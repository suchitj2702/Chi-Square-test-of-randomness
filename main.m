close all;
clear all;

%% Making the sequence
% length of each sequence
n = 10;

% number of sequencies
n_seq = 10000;

% standard deviation of the normal distribution
stddev_seq = 10;

% mean of the normal distribution
mean_seq = 50;

% creating the sequences
sequences = ones(n_seq, n);
for i = 1:n_seq
    sequences(i, :) = stddev_seq.*(randn(1, n)) + mean_seq;
end

% standard deviation of the normal distribution for choosing indices
stddev_index = 2;

% mean of the normal distribution for choosing indices
mean_index = 5;

% random sequences of indices
index = round(stddev_index.*(randn(1, n_seq)) + mean_index);

% making the final sequence 
finalseq = ones(1, length(n_seq));
for i = 1:n_seq
    if index(i) > n
        ind = n;
    elseif index(i) <= 0
        ind = 1;
    else
        ind = index(i);
    end
    finalseq(i) = sequences(i, ind);
end

%% Chi Square test on the sequence taking normal distribution as a null hypothesis

% critical values for p < 0.05(degree of freedom as index) taken from a
% chi square table available online
critical_val = [3.84 5.99 7.81 9.49 11.07 12.59 14.07 15.51 16.92 18.31];

% getting the bin information along with the degree of freedom
[h, p, stats] = chi2gof(finalseq);
fprintf('Degrees of freedom(df) =\n')
disp(stats.df);
fprintf('Bin Edges = \n');
disp(stats.edges);
fprintf('Observed frequency =\n');
disp(stats.O);
fprintf('Expected frequency = \n');
disp(stats.E);

% calculating the chi square value of the hypothesis
chi2value = sum(((stats.O - stats.E).^2)./stats.E);
fprintf('Chi square value = %f\n', chi2value);
fprintf('Critical value for %d degrees of freedom = %f\n', stats.df, critical_val(stats.df))

% checking our chi2value against the critical value for the degree of
% freedom
if chi2value < critical_val(stats.df)
    fprintf('The hypothesis is accepted(belongs to a normal distribution)\n');
else
    fprintf('The hypothesis is rejected\n');
end