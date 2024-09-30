%% HW02
close all; clear; clc;

%% The system
wn_list = [1, 1.5, 2, 3, 5, 7, 10];
zeta_list = [0.1, 0.3, 0.5, 0.7, 0.9, 1.0];

%% Input signal
dt = 0.01;
tend = 10;
t = 0:dt:tend;

freq = 1;
u = t ...
    - (t - 1) .* (t >= 1) ...
    - (t - 2) .* (t >= 2) ...
    + (t - 3) .* (t >= 3);  % The input signal

%% Simulation
fig = figure(Name = "Sweep Zeta");
wn = 5;
hold on;
for zeta = zeta_list
    numerator = [0, 0, wn^2];
    denominator = [1, 2 * zeta * wn, wn^2];
    sys = tf(numerator, denominator);
    [y, t_out, x] = lsim(sys, u, t);
    plot(t_out, y, 'LineWidth', 2);
end
hold off;
grid on;
xlabel("Time (sec)");
ylabel("Amplitude");
lgd = legend("$\zeta=0.1$", "$\zeta=0.3$", "$\zeta=0.5$", "$\zeta=0.7$", "$\zeta=0.9$", "$\zeta=1.0$");
set(lgd, 'interpreter', 'latex');
set(fig, "position", [100, 50, 1000, 550]);

fig = figure(Name = "Sweep wn");
zeta = 0.5;
hold on;
for wn = wn_list
    numerator = [0, 0, wn^2];
    denominator = [1, 2 * zeta * wn, wn^2];
    sys = tf(numerator, denominator);
    [y, t_out, x] = lsim(sys, u, t);
    plot(t_out, y, 'LineWidth', 2);
end
hold off;
grid on;
xlabel("Time (sec)");
ylabel("Amplitude");
lgd = legend("$\omega_{\rm n}=1$", "$\omega_{\rm n}=1.5$", "$\omega_{\rm n}=2$", "$\omega_{\rm n}=3$", "$\omega_{\rm n}=5$", "$\omega_{\rm n}=7$", "$\omega_{\rm n}=10$");
set(lgd, 'interpreter', 'latex');
set(fig, "position", [100, 50, 1000, 550]);
