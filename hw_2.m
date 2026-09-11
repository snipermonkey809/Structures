clear; clc; close all;

E  = 100e6;
A  = 0.001;
EA = E*A;
L0 = 5;
a  = 4;
b  = 3;

delta_mm = (0:1:1000)';
delta    = delta_mm/1000;

cos_theta0 = a/L0;
P_lin = 2*(EA/L0)*cos_theta0^2 .* delta;

L      = sqrt((a+delta).^2 + b^2);
P_nl   = 2*(EA/L0).*(L-L0).*(a+delta)./L;

error_pct = (P_lin - P_nl)./P_nl * 100;
error_pct(1) = 0;

figure('Name','P vs delta','Color','w');
plot(delta_mm, P_lin, 'b-', 'LineWidth', 1.8); hold on;
plot(delta_mm, P_nl,  'r-', 'LineWidth', 1.8);
xlabel('\delta (mm)');
ylabel('P (N)');
title('Force P vs displacement \delta');
legend('Small displacement', 'Large displacement', ...
       'Location', 'northwest');
grid on;

figure('Name','Error vs delta','Color','w');
plot(delta_mm, error_pct, 'r-', 'LineWidth', 1.8);
xlabel('\delta (mm)');
ylabel('Error (%)');
title('Error of linear prediction');
grid on;

sample_idx = [1 51 101 201 501 1001];
fprintf('%8s %12s %12s %10s\n','delta(mm)','P_lin(N)','P_nl(N)','error(%)');
for k = sample_idx
    fprintf('%8d %12.2f %12.2f %10.3f\n', ...
        delta_mm(k), P_lin(k), P_nl(k), error_pct(k));
end