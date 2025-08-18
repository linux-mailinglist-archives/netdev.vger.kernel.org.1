Return-Path: <netdev+bounces-214474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEE3B29C6F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33EA3B7D63
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79D82FB97B;
	Mon, 18 Aug 2025 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIRzF1Ii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40528032D
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506406; cv=none; b=m5i10pgJeIGRA9fr2NDp4vpmPzuwiFemecFhapm2sWSfZGmNzVCC0dl0vYLlT7lSaKQEez3zuVNZuwylaViu9/qNI5OS0chb+qOlM03I+nMhTfhjwbiiAjnJm9T/J+QW+2TJCkd8wJ4KmDHFZybpancCE3k2qwAicU6fZTbkAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506406; c=relaxed/simple;
	bh=Jpnq+RAlgTp0JPwfqiYljv4KQLkNKX7ALRnLGwK4lOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZ9fnDAtUNSoEpvnhngt9X4Ibj29HWlBg1tDk4xHiq5nnaiTAjZxmJDajVoZA4kjv+ysKG3JEQ4ksL4NJBI9F9obyQk3lTivTd5z2E/3tp91MnNwgrknttcASEdjTle4KKtEFUQrhZs9AcYYj4WIqfudEoVe/nMWVKzsvla/23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IIRzF1Ii; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b10957f506so51965441cf.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755506403; x=1756111203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/katb7MKl0v0fnDTBBvI17yE2EFcHam2yfIVTSM1Bw=;
        b=IIRzF1IiWgJ1uvyOkQD6PVxx5j27U6vuQouRfmVy9u6HCxESo4RGHSIMN3DGK8cgB8
         3fxN+J80XMRVdCp6qDQC9RCyfjBkyfEZ95pjQalJo3prTQASUFO1cFJ6vGSy7y4nMmgG
         DbFsTSvPh1rQAvZnFPuoWX9xCfUnNmY/yttvWhjKpA+5OErAZnv9uAI76guL29ATKghL
         +iAh7yyvlWg3xbRHCw+lKrzBC8wBgiu89SqdGkcEDsSbhDwzQ14i0KucNRi/tuuq9EUf
         dT0MBe1cvbE0nh93n18/V98cXSG9VVBc+JfrH6DB5XHFdTfeH3x3vLTx601pg571QTj8
         xzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506403; x=1756111203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/katb7MKl0v0fnDTBBvI17yE2EFcHam2yfIVTSM1Bw=;
        b=E7DpZ2Yvxpc8THxWgvwlcVOBJuIK6jekbLzsQAPFfjIJP4gf3uC2FOxCTeNbvWz+Iq
         dTrtdVCw5Ulcfmq7e9CM/RTnEDEcTyEt0HYf1Mr6EHGkIpLVLWHITquRUCT7wqeebRQR
         jK/KxT7AGONJxGjP+dEjpWRAnHI1juqyGtK8XRC6mAu8XClbLTh0pOSYQeDh068D6N5D
         g8VYaguvPF41zJpZcbG+n4IIDVpLrrafZZ1TXt0EfejiFgCohySNVllMrmITar48Zfon
         LIGm/MD49NWw95PyWO4j2jcMA26Lqw8a5FoWOKgoqIBrpkWojEC7tsTk+DwvyiHkU4gm
         SMiA==
X-Forwarded-Encrypted: i=1; AJvYcCXCLnKdgl2kqOnAboN8ZhqVHNTfr8R/2YP9P9mFVQsPG7QECYufaNQc0ty4tmir4Jeei0tblgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze6Hw25vs3oW9Rq+e02BV9wxb4unnogJHfAltbLDsp8eP5wNbJ
	q8pAHAB58bByrsdxJzavyD4G7stv31FeNsAOyK5CpCIS5RSvmZraKnBj2NncOIVFSznGP2moY+q
	+UpP+munntzSBY25oArqT4B8VD9jMrvjmNHjqkgxa194QGPZwBtrNv2wd
X-Gm-Gg: ASbGncvz6n9bhJ7RjH8DyoEZVjSNi1v2vg4Ka8f5YBcdX9NgK2BTIDibWsPxYwXG0b5
	F4AB80TAJKy+wwpRG2Bm/anVa1voJN++CV5c1JePnsiNQ7KfiGeJsERVbyCjHK9HMB5E50W4ap2
	YpUNBk8J8rCXDt8Ny2KeFx5V6B6E1DkesV4/BK6dwWLb3bHYWzV7wM0JQhcUoKa62iC+eXjZPAB
	K/N1tTI2/kd/ec=
X-Google-Smtp-Source: AGHT+IGQfXC5NiM1KI7ga4bf5OnxuNQ/0wCHe4fBWtF4GJedz4sEm5vsmqJnxL4v15XS1p/AUGf8TbVrBPqqxCrO3js=
X-Received: by 2002:a05:622a:5e12:b0:4b0:769e:42e8 with SMTP id
 d75a77b69052e-4b11d36844dmr155959001cf.29.1755506403190; Mon, 18 Aug 2025
 01:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202508180406.dbf438fc-lkp@intel.com>
In-Reply-To: <202508180406.dbf438fc-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Aug 2025 01:39:52 -0700
X-Gm-Features: Ac12FXw3rrnKEVXgp_agvFqlK8t_12vQSKeweGOUOBwblNhV2qVMKNDV70oyT-c
Message-ID: <CANn89iJYsx=AWW3XczDjJnhkT7mgRbTcKJkPH0evt9C11s4g_w@mail.gmail.com>
Subject: Re: [linus:master] [tcp] 1d2fbaad7c: stress-ng.sigurg.ops_per_sec
 12.2% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 9:49=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
> Hello,
>
> kernel test robot noticed a 12.2% regression of stress-ng.sigurg.ops_per_=
sec on:
>
>
> commit: 1d2fbaad7cd8cc96899179f9898ad2787a15f0a0 ("tcp: stronger sk_rcvbu=
f checks")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [still regression on      linus/master d7ee5bdce7892643409dea7266c34977e6=
51b479]
> [still regression on linux-next/master 1357b2649c026b51353c84ddd32bc963e8=
999603]
> [still regression on        fix commit 972ca7a3bc9a136b15ba698713b056a490=
0e2634]
>
> testcase: stress-ng
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (S=
apphire Rapids) with 256G memory
> parameters:
>
>         nr_threads: 100%
>         testtime: 60s
>         test: sigurg
>         cpufreq_governor: performance
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202508180406.dbf438fc-lkp@intel.=
com
>
>

Yes, patch is about making sure we do not OOM in malicious cases.

Not sure what SIGURG and TCP have in common, I do not plan making
investigations.


> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250818/202508180406.dbf438fc-lk=
p@intel.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testc=
ase/testtime:
>   gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/l=
kp-spr-r02/sigurg/stress-ng/60s
>
> commit:
>   75dff0584c ("tcp: add const to tcp_try_rmem_schedule() and sk_rmem_sche=
dule() skb")
>   1d2fbaad7c ("tcp: stronger sk_rcvbuf checks")
>
> 75dff0584cce7920 1d2fbaad7cd8cc96899179f9898
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>      36434            +7.6%      39205        vmstat.system.cs
>    5683321           -13.3%    4926200 =C2=B1  2%  vmstat.system.in
>     530991 =C2=B1  2%      -9.3%     481619 =C2=B1  3%  meminfo.Mapped
>    1132865           -13.5%     979753        meminfo.SUnreclaim
>    1292406           -11.9%    1138096        meminfo.Slab
>       0.62 =C2=B1  2%      +0.1        0.70        mpstat.cpu.all.irq%
>      24.14            -8.3       15.83 =C2=B1  2%  mpstat.cpu.all.soft%
>      10.95            +2.3       13.22        mpstat.cpu.all.usr%
>     627541 =C2=B1  4%     -15.4%     530831 =C2=B1  5%  numa-meminfo.node=
0.SUnreclaim
>     721419 =C2=B1  3%     -14.0%     620592 =C2=B1  8%  numa-meminfo.node=
0.Slab
>     513808 =C2=B1  6%     -13.1%     446297 =C2=B1  4%  numa-meminfo.node=
1.SUnreclaim
>    6100681           -23.2%    4686698 =C2=B1  2%  numa-numastat.node0.lo=
cal_node
>    6205260           -22.6%    4802561 =C2=B1  2%  numa-numastat.node0.nu=
ma_hit
>    5548582           -18.0%    4547552        numa-numastat.node1.local_n=
ode
>    5676020           -17.8%    4663456        numa-numastat.node1.numa_hi=
t
>      22382 =C2=B1  2%     -37.0%      14107 =C2=B1  4%  perf-c2c.DRAM.loc=
al
>      28565 =C2=B1 14%     -28.5%      20433 =C2=B1 19%  perf-c2c.DRAM.rem=
ote
>      61612 =C2=B1  4%     -28.7%      43958 =C2=B1 10%  perf-c2c.HITM.loc=
al
>      18329 =C2=B1 14%     -27.0%      13378 =C2=B1 19%  perf-c2c.HITM.rem=
ote
>      79941           -28.3%      57336 =C2=B1  6%  perf-c2c.HITM.total
>     155304 =C2=B1  4%     -14.4%     132870 =C2=B1  5%  numa-vmstat.node0=
.nr_slab_unreclaimable
>    6217921           -22.8%    4801413 =C2=B1  2%  numa-vmstat.node0.numa=
_hit
>    6113343           -23.4%    4685551 =C2=B1  2%  numa-vmstat.node0.numa=
_local
>     127106 =C2=B1  6%     -12.0%     111885 =C2=B1  4%  numa-vmstat.node1=
.nr_slab_unreclaimable
>    5686635           -18.0%    4662431        numa-vmstat.node1.numa_hit
>    5559197           -18.2%    4546532        numa-vmstat.node1.numa_loca=
l
>   3.39e+08           -12.2%  2.977e+08        stress-ng.sigurg.ops
>    5652273           -12.2%    4963242        stress-ng.sigurg.ops_per_se=
c
>    1885719           +11.0%    2092671        stress-ng.time.involuntary_=
context_switches
>      16523           +11.2%      18365        stress-ng.time.percent_of_c=
pu_this_job_got
>       8500            +9.2%       9278        stress-ng.time.system_time
>       1438           +23.0%       1769        stress-ng.time.user_time
>     195971            -6.0%     184305        stress-ng.time.voluntary_co=
ntext_switches
>     487113 =C2=B1  7%      -5.8%     459038        proc-vmstat.nr_active_=
anon
>     134039            -9.5%     121269 =C2=B1  4%  proc-vmstat.nr_mapped
>     186858 =C2=B1 20%     -15.3%     158269 =C2=B1  2%  proc-vmstat.nr_sh=
mem
>     284955 =C2=B1  2%     -13.8%     245616        proc-vmstat.nr_slab_un=
reclaimable
>     487113 =C2=B1  7%      -5.8%     459038        proc-vmstat.nr_zone_ac=
tive_anon
>   11891822           -20.5%    9456122        proc-vmstat.numa_hit
>   11659806           -20.9%    9224357        proc-vmstat.numa_local
>   86214365           -22.0%   67254297        proc-vmstat.pgalloc_normal
>   85564410           -21.8%   66883184        proc-vmstat.pgfree
>    6156738           +13.9%    7012286        sched_debug.cfs_rq:/.avg_vr=
untime.avg
>    7693151           +10.1%    8468818        sched_debug.cfs_rq:/.avg_vr=
untime.max
>    4636464 =C2=B1  5%     +14.2%    5295369 =C2=B1  4%  sched_debug.cfs_r=
q:/.avg_vruntime.min
>     238.39 =C2=B1 92%    +228.2%     782.32 =C2=B1 46%  sched_debug.cfs_r=
q:/.load_avg.avg
>    6156739           +13.9%    7012287        sched_debug.cfs_rq:/.min_vr=
untime.avg
>    7693151           +10.1%    8468818        sched_debug.cfs_rq:/.min_vr=
untime.max
>    4636464 =C2=B1  5%     +14.2%    5295369 =C2=B1  4%  sched_debug.cfs_r=
q:/.min_vruntime.min
>       2580 =C2=B1  3%     -13.3%       2236 =C2=B1  8%  sched_debug.cfs_r=
q:/.runnable_avg.max
>     104496 =C2=B1 28%     -64.4%      37246 =C2=B1 38%  sched_debug.cpu.a=
vg_idle.min
>       1405 =C2=B1  3%     +12.7%       1583 =C2=B1  2%  sched_debug.cpu.n=
r_switches.stddev
>       0.68 =C2=B1  3%     -40.9%       0.40 =C2=B1  3%  perf-stat.i.MPKI
>  9.475e+10           +26.6%  1.199e+11        perf-stat.i.branch-instruct=
ions
>       0.13 =C2=B1  5%      -0.0        0.09 =C2=B1  2%  perf-stat.i.branc=
h-miss-rate%
>  1.178e+08 =C2=B1  3%     -14.9%  1.003e+08        perf-stat.i.branch-mis=
ses
>      40.25            -3.2       37.02        perf-stat.i.cache-miss-rate=
%
>  3.325e+08 =C2=B1  2%     -25.9%  2.465e+08 =C2=B1  3%  perf-stat.i.cache=
-misses
>  8.258e+08           -19.2%  6.672e+08        perf-stat.i.cache-reference=
s
>      37598            +8.1%      40642        perf-stat.i.context-switche=
s
>       1.31           -21.4%       1.03        perf-stat.i.cpi
>       2327           -15.3%       1970 =C2=B1  2%  perf-stat.i.cpu-migrat=
ions
>       1927 =C2=B1  2%     +33.7%       2577 =C2=B1  3%  perf-stat.i.cycle=
s-between-cache-misses
>  4.888e+11           +26.3%  6.174e+11        perf-stat.i.instructions
>       0.77           +26.9%       0.98        perf-stat.i.ipc
>       0.68 =C2=B1  3%     -41.3%       0.40 =C2=B1  3%  perf-stat.overall=
.MPKI
>       0.12 =C2=B1  4%      -0.0        0.08 =C2=B1  2%  perf-stat.overall=
.branch-miss-rate%
>      40.27            -3.3       36.95        perf-stat.overall.cache-mis=
s-rate%
>       1.31           -21.5%       1.03        perf-stat.overall.cpi
>       1928 =C2=B1  2%     +33.8%       2581 =C2=B1  3%  perf-stat.overall=
.cycles-between-cache-misses
>       0.76           +27.4%       0.97        perf-stat.overall.ipc
>  9.264e+10           +26.7%  1.173e+11        perf-stat.ps.branch-instruc=
tions
>  1.148e+08 =C2=B1  3%     -14.8%   97834009        perf-stat.ps.branch-mi=
sses
>  3.253e+08 =C2=B1  2%     -25.8%  2.413e+08 =C2=B1  3%  perf-stat.ps.cach=
e-misses
>  8.077e+08           -19.2%   6.53e+08        perf-stat.ps.cache-referenc=
es
>      36742            +8.2%      39741        perf-stat.ps.context-switch=
es
>       2273           -15.4%       1922 =C2=B1  2%  perf-stat.ps.cpu-migra=
tions
>  4.779e+11           +26.4%  6.041e+11        perf-stat.ps.instructions
>  2.914e+13           +27.4%  3.711e+13        perf-stat.total.instruction=
s
>       4.41 =C2=B1  4%     -17.7%       3.63 =C2=B1  6%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recv=
msg
>       6.74           -12.8%       5.87 =C2=B1  3%  perf-sched.sch_delay.a=
vg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
>       5.30           -19.6%       4.26 =C2=B1  4%  perf-sched.sch_delay.a=
vg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_al=
loc_skb.tcp_sendmsg_locked
>       5.22           -23.4%       4.00 =C2=B1  2%  perf-sched.sch_delay.a=
vg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_s=
kb.tcp_stream_alloc_skb
>       4.83 =C2=B1  4%     -15.7%       4.08 =C2=B1  2%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_re=
cvmsg
>       5.20 =C2=B1  2%     -17.9%       4.27        perf-sched.sch_delay.a=
vg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_se=
ndto
>       4.92 =C2=B1  2%     -16.5%       4.11 =C2=B1  2%  perf-sched.sch_de=
lay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.[unknown]
>       5.75 =C2=B1 18%     -88.1%       0.69 =C2=B1115%  perf-sched.sch_de=
lay.avg.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
>       5.00 =C2=B1  3%     -16.2%       4.19 =C2=B1  2%  perf-sched.sch_de=
lay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unkn=
own]
>       0.35 =C2=B1 15%     -37.1%       0.22 =C2=B1 12%  perf-sched.sch_de=
lay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.ker=
nel_clone
>       3.47           -16.7%       2.89 =C2=B1  3%  perf-sched.sch_delay.a=
vg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>       0.13 =C2=B1  7%     -14.8%       0.11 =C2=B1  8%  perf-sched.sch_de=
lay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      33.82 =C2=B1 55%     -45.0%      18.60 =C2=B1 16%  perf-sched.sch_de=
lay.max.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recv=
msg
>      36.83 =C2=B1 10%     -32.7%      24.80 =C2=B1 10%  perf-sched.sch_de=
lay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stre=
am_alloc_skb.tcp_sendmsg_locked
>      10.05 =C2=B1 49%     -58.0%       4.22 =C2=B1 33%  perf-sched.sch_de=
lay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nan=
osleep
>      55.68 =C2=B1  9%     -16.5%      46.49 =C2=B1 17%  perf-sched.sch_de=
lay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.[unknown]
>       6.12 =C2=B1 18%     -81.2%       1.15 =C2=B1116%  perf-sched.sch_de=
lay.max.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
>       7.91 =C2=B1 27%     -39.8%       4.77 =C2=B1 24%  perf-sched.sch_de=
lay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.ker=
nel_clone
>       1.73 =C2=B1104%     -99.1%       0.02 =C2=B1 44%  perf-sched.sch_de=
lay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       4.56 =C2=B1  2%     -15.3%       3.86 =C2=B1  2%  perf-sched.total_=
sch_delay.average.ms
>      26.64 =C2=B1  2%      -9.6%      24.08        perf-sched.total_wait_=
and_delay.average.ms
>      22.08 =C2=B1  2%      -8.5%      20.21 =C2=B1  2%  perf-sched.total_=
wait_time.average.ms
>      13.50           -12.5%      11.82 =C2=B1  3%  perf-sched.wait_and_de=
lay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sen=
dto
>      15.61          -100.0%       0.00        perf-sched.wait_and_delay.a=
vg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_al=
loc_skb.tcp_sendmsg_locked
>       9.72 =C2=B1  4%     -15.7%       8.20        perf-sched.wait_and_de=
lay.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_re=
cvmsg
>      15.17 =C2=B1  6%     -21.9%      11.85 =C2=B1  3%  perf-sched.wait_a=
nd_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__=
x64_sys_sendto
>      11.74 =C2=B1  2%     -12.5%      10.27 =C2=B1  2%  perf-sched.wait_a=
nd_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after=
_hwframe.[unknown]
>      10.39 =C2=B1  4%     -13.0%       9.04 =C2=B1  2%  perf-sched.wait_a=
nd_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.=
[unknown]
>       7.06           -15.7%       5.95 =C2=B1  3%  perf-sched.wait_and_de=
lay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>       2317           -49.6%       1169 =C2=B1  9%  perf-sched.wait_and_de=
lay.count.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_send=
to
>       1488 =C2=B1  5%    -100.0%       0.00        perf-sched.wait_and_de=
lay.count.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_strea=
m_alloc_skb.tcp_sendmsg_locked
>       1953 =C2=B1  8%    +347.2%       8733 =C2=B1  4%  perf-sched.wait_a=
nd_delay.count.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.soc=
k_recvmsg
>       2360 =C2=B1  5%    +251.5%       8296 =C2=B1  6%  perf-sched.wait_a=
nd_delay.count.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x=
64_sys_sendto
>      22781 =C2=B1  3%     +16.7%      26578 =C2=B1  3%  perf-sched.wait_a=
nd_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[=
unknown]
>      13753 =C2=B1  4%     -14.8%      11717 =C2=B1  3%  perf-sched.wait_a=
nd_delay.count.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendms=
g_locked
>       6038 =C2=B1  2%     -12.6%       5275 =C2=B1  7%  perf-sched.wait_a=
nd_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      71.60 =C2=B1  8%    -100.0%       0.00        perf-sched.wait_and_de=
lay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stre=
am_alloc_skb.tcp_sendmsg_locked
>      53.03 =C2=B1  7%    +140.7%     127.64 =C2=B1 45%  perf-sched.wait_a=
nd_delay.max.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.so=
ck_recvmsg
>     435.94 =C2=B1122%    +263.3%       1583 =C2=B1 27%  perf-sched.wait_a=
nd_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64=
_sys_call
>     987.24 =C2=B1 22%     +59.8%       1577 =C2=B1  6%  perf-sched.wait_a=
nd_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.=
[unknown]
>       4.49 =C2=B1  4%     -16.2%       3.76 =C2=B1  6%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recv=
msg
>       6.77           -12.1%       5.95 =C2=B1  4%  perf-sched.wait_time.a=
vg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
>       4.89 =C2=B1  4%     -15.7%       4.12        perf-sched.wait_time.a=
vg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
>       9.97 =C2=B1  9%     -24.0%       7.58 =C2=B1  5%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_s=
ys_sendto
>       6.82 =C2=B1  2%      -9.6%       6.17        perf-sched.wait_time.a=
vg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[=
unknown]
>       5.75 =C2=B1 18%     -87.3%       0.73 =C2=B1113%  perf-sched.wait_t=
ime.avg.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
>       2.01 =C2=B1 14%     +38.1%       2.78 =C2=B1  7%  perf-sched.wait_t=
ime.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
>       2.38 =C2=B1  7%     -12.0%       2.09 =C2=B1  8%  perf-sched.wait_t=
ime.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.ker=
nel_clone
>       5.50 =C2=B1  3%     +24.4%       6.84 =C2=B1  7%  perf-sched.wait_t=
ime.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       3.59           -14.7%       3.06 =C2=B1  3%  perf-sched.wait_time.a=
vg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>      26.85 =C2=B1  6%    +311.9%     110.60 =C2=B1 63%  perf-sched.wait_t=
ime.max.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_re=
cvmsg
>       6.12 =C2=B1 18%     -81.2%       1.15 =C2=B1116%  perf-sched.wait_t=
ime.max.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
>     985.54 =C2=B1 22%     +59.9%       1576 =C2=B1  6%  perf-sched.wait_t=
ime.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unkn=
own]
>       2411 =C2=B1 57%     -74.1%     623.65 =C2=B1 38%  perf-sched.wait_t=
ime.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_e=
poll_wait
>      17.94 =C2=B1 19%     -38.0%      11.12 =C2=B1 19%  perf-sched.wait_t=
ime.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.ker=
nel_clone
>     249.22 =C2=B1 28%     +48.9%     371.19 =C2=B1 16%  perf-sched.wait_t=
ime.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

