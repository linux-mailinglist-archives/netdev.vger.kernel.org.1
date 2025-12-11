Return-Path: <netdev+bounces-244405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4194CB66FB
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 17:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABBF5300C354
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8009C2727F8;
	Thu, 11 Dec 2025 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w1+uL4+L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF52475CB
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765469767; cv=none; b=fT4niDWt4vYt9zrOoWNVMZ9rHCzsZLS1YhLI4j+p4EHjoCWvB2q55m5PK2Xz1G+eXmY/RDrdFoET4pa/P2s2nksvdEMTBDmOdI9eiew3cH4w7Ai6CT5/GKfc3DGdkGFN7Qp93BRbs6W74NbbtGHReZ+ScvZnvvJrUn54fKzmo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765469767; c=relaxed/simple;
	bh=nGI7OnF4D8CovfDAa2v92ATh7RgiZGd1i29E31H0+jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6ucAs/TNRcRJzoRXcCYLoS7NQhtIxgwVJoEcbngVXJMsotwGBpuYCVyhp13fuF2pnCLVhNT2Ram0+Npve+/D1nZGUXFi4EyTmbb7HE6YoesLOARe843D/T4YmiAwywf2rDwlH0k53+L8WE49eL8f2BndW7YPfLyguicIHypJBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w1+uL4+L; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4edf1be4434so2291751cf.1
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765469763; x=1766074563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzPG+S64XbXvnEid99xhQwVuSzwrWQQMioMQhjMX6qA=;
        b=w1+uL4+LVybVdPt3dsOmiQnyw0V1tt3wFCXlB5ajmPLlT6/1m3ILAWZP+c9Nte6jjA
         +Z3C2WeIdazgGjg46GHYPL608gvYm77U1zsAWgjajCvor1UfxRUhETFmQntHBmyiEmFq
         vBXEqyr+VgzIJ5m43BCrovAbJ+xCq+QM8iInzzL2HeaDO/Z7mk9nuT1XMLQ9/qq/Vzyr
         t+AHDnsD302PMRWM2UCmws1md/VFwIk5hLj4UogXBwgna/OgNEb7SYInw0MpP+TzHEQP
         HSoo3b9CmRw9f4HYNyY3b2N3CoXZgAU38p5N/SQ4k47s87Xq4UlPZ5I5R5prDFr4xY+4
         Oxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765469763; x=1766074563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzPG+S64XbXvnEid99xhQwVuSzwrWQQMioMQhjMX6qA=;
        b=SZcn7+Pssv6raBTSBJl52BNOA3doEWkaErY7FjBGlP2BZ5s81/PS7jUkPXUPhRowL8
         46A6OlxM8B4WcJgl9d6ZBTMmkDFq9yk4wWxkk/vcl9gLAaqA5QLfEAVZBjLIzKKuDree
         +S5XevHCEX+LhLiVo8lQ96RWgP7XF0x7Sio1n2w7gHZ9CQsCwLitwz8w7YY18Qbw8wpY
         aYi/gWxgwCrexWkCDichrYR5vtEInA4N9jjkQ+VUJ0Qpcsd2GbmJIdLjM/UvXpN+1+jz
         S3hV7Bov26oZ48NkO6EZfeUEXnC8llY/sSxdrQzue+1vBNLIkoaR2wpNA2xo+soWcw8Y
         XF4w==
X-Forwarded-Encrypted: i=1; AJvYcCX85qwbAlQocTjL0vkkW2TdWYDL83HGtGCnsEsvG1WaOI3DKbgekOeuwH3RzB/91nNDhzlLwog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUE+ywREH9zcl64YA70MhifPDKTscnBmE7ABRNgK+fODluuvM
	6UGJPtEbTZq844uNMOsOb7LB0+a/oTqXRYSdRC3ZK1shj50zHf4lxOhh/iAb0cSo0fBav3xh+8z
	7JozeXoUumHYBdSJrPbUhFdr9bpTi+APplfmSyP0N
X-Gm-Gg: AY/fxX7/Vby7f34jzb9RRMuGyWPff8FTcRz9CRUme11Wd+TI6k6AhnCF0eOE9C9Umna
	FTkSNMu9ePcvmAbH8TIoyB2+ULpqoRyx44t2vFhJ6U5XVpfiFLLmox6kPi9phBsRmkG4uIq4OR+
	eOMkgczCRiiiqdrXDmROdBFALRvrqG/06fDHVN+TCIjfVm/xfIxD5s2onJdbEHzicyyydvKCKEX
	rlmTjh8lIrBsk/cVR6u6cHX+zXj8MdZ4RfCQgKKzHE7DDJuH0hPLgDK7IsVZNKKJA8Hs60=
X-Google-Smtp-Source: AGHT+IHsxfy0PZ90m8M0BTCg6U2R6LFOZ7Uc0IEMAUlsVD8QzV7Ea0hhiMokyILw3BqnDZD1URHqdyLQeQAm6BZbyBY=
X-Received: by 2002:a05:622a:410f:b0:4e8:a9bf:9d2b with SMTP id
 d75a77b69052e-4f1b1b0a3e6mr85019241cf.84.1765469762776; Thu, 11 Dec 2025
 08:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202512112119.5b9829a-lkp@intel.com>
In-Reply-To: <202512112119.5b9829a-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Dec 2025 17:15:51 +0100
X-Gm-Features: AQt7F2q6k86w5G7rOM7i_Ow8MoasvV3CEHPcVZ2i9CLrD1koFdZmBwMqgpqa5bk
Message-ID: <CANn89iLG-WD9m4y--uJhgNGBoFb=Ved+X3JFTeH7e9_jUt6Jbw@mail.gmail.com>
Subject: Re: [linus:master] [net] 5628f3fe3b: sockperf.throughput.UDP.msg_per_sec
 20.1% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 3:31=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a 20.1% regression of sockperf.throughput.UDP.m=
sg_per_sec on:
>
>
> commit: 5628f3fe3b16114e8424bbfcf0594caef8958a06 ("net: add NUMA awarenes=
s to skb_attempt_defer_free()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [still regression on linus/master      cb015814f8b6eebcbb8e46e111d108892c=
5e6821]
> [still regression on linux-next/master c75caf76ed86bbc15a72808f48f8df1608=
a0886c]
>
> testcase: sockperf
> config: x86_64-rhel-9.4
> compiler: gcc-14
> test machine: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Fore=
st) with 128G memory

How many NUMA nodes are present ?

> parameters:
>
>         runtime: 600s
>         cluster: cs-localhost
>         msg_size: 1472b
>         cpufreq_governor: performance
>
>

Is it a test with a single sender and receiver ?

> In addition to that, the commit also has significant impact on the follow=
ing tests:
>
> +------------------+-----------------------------------------------------=
----------------------------+
> | testcase: change | netperf: netperf.Throughput_Mbps  6.0% regression   =
                            |
> | test machine     | 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sier=
ra Forest) with 128G memory |
> | test parameters  | cluster=3Dcs-localhost                              =
                              |
> |                  | cpufreq_governor=3Dperformance                      =
                              |
> |                  | ip=3Dipv4                                           =
                              |
> |                  | nr_threads=3D1                                      =
                              |
> |                  | runtime=3D300s                                      =
                              |
> |                  | test=3DUDP_STREAM                                   =
                              |
> +------------------+-----------------------------------------------------=
----------------------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202512112119.5b9829a-lkp@intel.c=
om
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251211/202512112119.5b9829a-lkp=
@intel.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> cluster/compiler/cpufreq_governor/kconfig/msg_size/rootfs/runtime/tbox_gr=
oup/testcase:
>   cs-localhost/gcc-14/performance/x86_64-rhel-9.4/1472b/debian-13-x86_64-=
20250902.cgz/600s/lkp-srf-2sp1/sockperf
>
> commit:
>   844c9db7f7 ("net: use llist for sd->defer_list")
>   5628f3fe3b ("net: add NUMA awareness to skb_attempt_defer_free()")
>
> 844c9db7f7f5fe1b 5628f3fe3b16114e8424bbfcf05
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>       0.10            +0.0        0.12        mpstat.cpu.all.soft%
>   16915992 =C4=85  6%     -16.0%   14216230 =C4=85  6%  turbostat.IRQ
>     207555            +4.0%     215887        vmstat.system.cs
>      28663 =C4=85  6%     -15.2%      24304 =C4=85  6%  vmstat.system.in
>   11048577            -1.6%   10873254        proc-vmstat.numa_hit
>   10782437            -1.6%   10607299        proc-vmstat.numa_local
>   75337098            -1.9%   73920567        proc-vmstat.pgalloc_normal
>   75257799            -1.9%   73843141        proc-vmstat.pgfree
>       2564            -2.0%       2514        sockperf.throughput.TCP.Ban=
dWidth_MBps
>    1826630            -2.0%    1790940        sockperf.throughput.TCP.msg=
_per_sec
>     941.44           -20.1%     751.96        sockperf.throughput.UDP.Ban=
dWidth_MBps
>     670636           -20.1%     535658        sockperf.throughput.UDP.msg=
_per_sec
>       6259 =C4=85  3%     +44.0%       9013 =C4=85 12%  sockperf.time.inv=
oluntary_context_switches
>      66.00            -3.0%      64.00        sockperf.time.percent_of_cp=
u_this_job_got
>  7.698e+08            +3.3%  7.955e+08        perf-stat.i.branch-instruct=
ions
>     208310            +4.0%     216675        perf-stat.i.context-switche=
s
>     298.79            +6.0%     316.62        perf-stat.i.cpu-migrations
>   3.92e+09            +4.1%  4.081e+09        perf-stat.i.instructions
>       0.79            +3.9%       0.83        perf-stat.i.ipc
>       0.68 =C4=85  3%      +7.5%       0.73        perf-stat.i.metric.K/s=
ec
>       0.11            -4.4%       0.10 =C4=85  2%  perf-stat.overall.MPKI
>       1.19            -3.7%       1.14        perf-stat.overall.cpi
>       0.84            +3.8%       0.87        perf-stat.overall.ipc
>  7.681e+08            +3.3%  7.937e+08        perf-stat.ps.branch-instruc=
tions
>     207867            +4.0%     216199        perf-stat.ps.context-switch=
es
>     298.39            +6.0%     316.29        perf-stat.ps.cpu-migrations
>  3.911e+09            +4.1%  4.072e+09        perf-stat.ps.instructions
>  2.419e+12            +4.1%  2.519e+12        perf-stat.total.instruction=
s
>       1.51 =C4=85  5%      -0.5        1.06 =C4=85 26%  perf-profile.call=
trace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_o=
utput.ip_send_skb
>       1.46 =C4=85  5%      -0.4        1.03 =C4=85 26%  perf-profile.call=
trace.cycles-pp.xmit_one.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_out=
put2.ip_output
>       1.26 =C4=85  7%      -0.4        0.88 =C4=85 28%  perf-profile.call=
trace.cycles-pp.loopback_xmit.xmit_one.dev_hard_start_xmit.__dev_queue_xmit=
.ip_finish_output2
>       6.40 =C4=85  4%      -0.3        6.06 =C4=85  2%  perf-profile.call=
trace.cycles-pp.udpv6_recvmsg.inet6_recvmsg.sock_recvmsg.__sys_recvfrom.__x=
64_sys_recvfrom
>       6.42 =C4=85  4%      -0.3        6.09 =C4=85  2%  perf-profile.call=
trace.cycles-pp.inet6_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfro=
m.do_syscall_64
>       1.06 =C4=85 17%      -0.3        0.75 =C4=85 31%  perf-profile.call=
trace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.=
ip_make_skb.udp_sendmsg
>       2.37 =C4=85  6%      -0.3        2.06 =C4=85  3%  perf-profile.call=
trace.cycles-pp.ip_make_skb.udp_sendmsg.udpv6_sendmsg.__sys_sendto.__x64_sy=
s_sendto
>       2.54 =C4=85  9%      -0.3        2.25 =C4=85  4%  perf-profile.call=
trace.cycles-pp.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp=
.udpv6_recvmsg.inet6_recvmsg
>       0.69 =C4=85  2%      -0.1        0.63 =C4=85  5%  perf-profile.call=
trace.cycles-pp.__wrgsbase_inactive
>       6.90 =C4=85  4%      +0.8        7.66 =C4=85  3%  perf-profile.call=
trace.cycles-pp.udp_send_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_s=
yscall_64
>       9.88 =C4=85  2%      +0.8       10.64 =C4=85  4%  perf-profile.call=
trace.cycles-pp.udp_sendmsg.udpv6_sendmsg.__sys_sendto.__x64_sys_sendto.do_=
syscall_64
>       9.94 =C4=85  2%      +0.8       10.72 =C4=85  4%  perf-profile.call=
trace.cycles-pp.udpv6_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.e=
ntry_SYSCALL_64_after_hwframe
>       6.77 =C4=85  4%      +0.8        7.58 =C4=85  3%  perf-profile.call=
trace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.__sys_sendto.__x64_sys=
_sendto
>       6.65 =C4=85  4%      +0.8        7.49 =C4=85  3%  perf-profile.call=
trace.cycles-pp.ip_output.ip_send_skb.udp_send_skb.udp_sendmsg.__sys_sendto
>       6.77 =C4=85  2%      +1.0        7.77 =C4=85  5%  perf-profile.call=
trace.cycles-pp.udp_send_skb.udp_sendmsg.udpv6_sendmsg.__sys_sendto.__x64_s=
ys_sendto
>       6.68 =C4=85  2%      +1.0        7.69 =C4=85  5%  perf-profile.call=
trace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.udpv6_sendmsg.__sys_se=
ndto
>       6.58 =C4=85  2%      +1.0        7.59 =C4=85  5%  perf-profile.call=
trace.cycles-pp.ip_output.ip_send_skb.udp_send_skb.udp_sendmsg.udpv6_sendms=
g
>      20.94            +1.3       22.20 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      20.92            +1.3       22.19 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_aft=
er_hwframe
>      13.07 =C4=85  2%      +1.9       14.99 =C4=85  4%  perf-profile.call=
trace.cycles-pp.ip_finish_output2.ip_output.ip_send_skb.udp_send_skb.udp_se=
ndmsg
>      12.72 =C4=85  2%      +2.0       14.69 =C4=85  4%  perf-profile.call=
trace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.ip_send_skb.ud=
p_send_skb
>      10.50 =C4=85  2%      +2.3       12.85 =C4=85  4%  perf-profile.call=
trace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_=
output.ip_send_skb
>      10.39 =C4=85  2%      +2.4       12.76 =C4=85  4%  perf-profile.call=
trace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_=
output2.ip_output
>      10.29 =C4=85  2%      +2.4       12.70 =C4=85  4%  perf-profile.call=
trace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue=
_xmit.ip_finish_output2
>       9.77 =C4=85  2%      +2.5       12.22 =C4=85  4%  perf-profile.call=
trace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_=
ip.__dev_queue_xmit
>       0.00            +4.1        4.08 =C4=85  5%  perf-profile.calltrace=
.cycles-pp.skb_defer_free_flush.net_rx_action.handle_softirqs.do_softirq.__=
local_bh_enable_ip
>       4.79 =C4=85  3%      -0.5        4.24 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.ip_make_skb
>       6.40 =C4=85  4%      -0.3        6.06 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.udpv6_recvmsg
>       6.43 =C4=85  4%      -0.3        6.09 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.inet6_recvmsg
>       1.51 =C4=85  5%      -0.3        1.22 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.dev_hard_start_xmit
>       1.46 =C4=85  5%      -0.3        1.18 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.xmit_one
>       0.95 =C4=85  6%      -0.2        0.77 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.sock_wfree
>       3.02 =C4=85  2%      -0.2        2.85 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__ip_append_data
>       1.26 =C4=85  7%      -0.2        1.11 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.loopback_xmit
>       0.20 =C4=85 11%      -0.1        0.10 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.__enqueue_entity
>       0.52 =C4=85  3%      -0.1        0.43 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.arch_exit_to_user_mode_prepare
>       0.22 =C4=85  7%      -0.1        0.12 =C4=85 21%  perf-profile.chil=
dren.cycles-pp.switch_fpu_return
>       0.22 =C4=85 12%      -0.1        0.13 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.ip_setup_cork
>       0.09 =C4=85 11%      -0.1        0.02 =C4=85 99%  perf-profile.chil=
dren.cycles-pp.tick_nohz_tick_stopped
>       0.75 =C4=85  2%      -0.1        0.69 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__wrgsbase_inactive
>       0.26 =C4=85 13%      -0.1        0.20 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.udp4_lib_lookup2
>       0.08 =C4=85 20%      -0.1        0.04 =C4=85 71%  perf-profile.chil=
dren.cycles-pp.__ip_finish_output
>       0.25 =C4=85 11%      -0.0        0.20 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.__netif_receive_skb_core
>       0.17 =C4=85 13%      -0.0        0.13 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.ipv4_mtu
>       0.21 =C4=85 11%      -0.0        0.16 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.__mkroute_output
>       0.09 =C4=85 15%      -0.0        0.05 =C4=85 52%  perf-profile.chil=
dren.cycles-pp.vruntime_eligible
>       0.10 =C4=85  9%      -0.0        0.07 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.update_min_vruntime
>       0.16 =C4=85 12%      +0.0        0.20 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.wakeup_preempt
>       0.01 =C4=85223%      +0.1        0.10 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.tick_nohz_get_next_hrtimer
>       9.94 =C4=85  2%      +0.8       10.72 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.udpv6_sendmsg
>       0.10 =C4=85 11%      +0.9        1.01 =C4=85  6%  perf-profile.chil=
dren.cycles-pp._find_next_bit
>      20.93            +1.3       22.20 =C4=85  3%  perf-profile.children.=
cycles-pp.__sys_sendto
>      20.94            +1.3       22.21 =C4=85  3%  perf-profile.children.=
cycles-pp.__x64_sys_sendto
>      19.98            +1.3       21.26 =C4=85  4%  perf-profile.children.=
cycles-pp.udp_sendmsg
>      13.68            +1.7       15.42 =C4=85  4%  perf-profile.children.=
cycles-pp.udp_send_skb
>      13.46 =C4=85  2%      +1.8       15.28 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.ip_send_skb
>      13.28 =C4=85  2%      +1.8       15.13 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.ip_output
>      13.13 =C4=85  2%      +1.9       15.04 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.ip_finish_output2
>      12.78 =C4=85  2%      +2.0       14.74 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__dev_queue_xmit
>      10.71 =C4=85  3%      +2.3       13.04 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__local_bh_enable_ip
>       9.84 =C4=85  3%      +2.4       12.28 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.net_rx_action
>      13.63            +2.5       16.11 =C4=85  3%  perf-profile.children.=
cycles-pp.do_softirq
>      14.05            +2.5       16.57 =C4=85  3%  perf-profile.children.=
cycles-pp.handle_softirqs
>       0.00            +4.1        4.09 =C4=85  5%  perf-profile.children.=
cycles-pp.skb_defer_free_flush
>       0.98 =C4=85 13%      -0.9        0.08 =C4=85 14%  perf-profile.self=
.cycles-pp.net_rx_action
>       0.94 =C4=85  7%      -0.2        0.76 =C4=85 12%  perf-profile.self=
.cycles-pp.sock_wfree
>       0.20 =C4=85 16%      -0.1        0.06 =C4=85 46%  perf-profile.self=
.cycles-pp.xmit_one
>       0.70 =C4=85 10%      -0.1        0.58 =C4=85  5%  perf-profile.self=
.cycles-pp.menu_select
>       0.20 =C4=85  6%      -0.1        0.11 =C4=85 20%  perf-profile.self=
.cycles-pp.switch_fpu_return
>       0.18 =C4=85  9%      -0.1        0.10 =C4=85 12%  perf-profile.self=
.cycles-pp.__enqueue_entity
>       0.70 =C4=85  9%      -0.1        0.62 =C4=85  5%  perf-profile.self=
.cycles-pp._raw_spin_lock_irqsave
>       0.43 =C4=85 10%      -0.1        0.36 =C4=85  7%  perf-profile.self=
.cycles-pp.__ip_append_data
>       0.30 =C4=85 11%      -0.1        0.22 =C4=85  8%  perf-profile.self=
.cycles-pp.dequeue_entity
>       0.35 =C4=85 10%      -0.1        0.28 =C4=85 11%  perf-profile.self=
.cycles-pp.sched_balance_newidle
>       0.13 =C4=85  5%      -0.1        0.06 =C4=85 48%  perf-profile.self=
.cycles-pp.__udp4_lib_rcv
>       0.41 =C4=85  8%      -0.1        0.35 =C4=85  9%  perf-profile.self=
.cycles-pp.cpuidle_idle_call
>       0.29 =C4=85 15%      -0.1        0.22 =C4=85  4%  perf-profile.self=
.cycles-pp.syscall_return_via_sysret
>       0.71            -0.1        0.65 =C4=85  4%  perf-profile.self.cycl=
es-pp.__wrgsbase_inactive
>       0.21 =C4=85 13%      -0.1        0.15 =C4=85 15%  perf-profile.self=
.cycles-pp.handle_softirqs
>       0.84 =C4=85  2%      -0.0        0.79 =C4=85  2%  perf-profile.self=
.cycles-pp.__switch_to
>       0.25 =C4=85 11%      -0.0        0.20 =C4=85 15%  perf-profile.self=
.cycles-pp.__netif_receive_skb_core
>       0.18 =C4=85 21%      -0.0        0.13 =C4=85 10%  perf-profile.self=
.cycles-pp.udp_send_skb
>       0.09 =C4=85 12%      -0.0        0.04 =C4=85 75%  perf-profile.self=
.cycles-pp.vruntime_eligible
>       0.16 =C4=85 14%      -0.0        0.12 =C4=85 10%  perf-profile.self=
.cycles-pp.ipv4_mtu
>       0.07 =C4=85 24%      -0.0        0.04 =C4=85 45%  perf-profile.self=
.cycles-pp.sock_recvmsg
>       0.24 =C4=85 11%      +0.1        0.29 =C4=85  3%  perf-profile.self=
.cycles-pp.udp_sendmsg
>       0.08 =C4=85 16%      +0.1        0.15 =C4=85  9%  perf-profile.self=
.cycles-pp.ttwu_do_activate
>       0.01 =C4=85223%      +0.1        0.10 =C4=85 15%  perf-profile.self=
.cycles-pp.tick_nohz_get_next_hrtimer
>       0.10 =C4=85 15%      +0.9        0.98 =C4=85  6%  perf-profile.self=
.cycles-pp._find_next_bit
>       0.00            +2.9        2.88 =C4=85  7%  perf-profile.self.cycl=
es-pp.skb_defer_free_flush
>
>
> *************************************************************************=
**************************
> lkp-srf-2sp1: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Fore=
st) with 128G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tb=
ox_group/test/testcase:
>   cs-localhost/gcc-14/performance/ipv4/x86_64-rhel-9.4/1/debian-13-x86_64=
-20250902.cgz/300s/lkp-srf-2sp1/UDP_STREAM/netperf
>
> commit:
>   844c9db7f7 ("net: use llist for sd->defer_list")
>   5628f3fe3b ("net: add NUMA awareness to skb_attempt_defer_free()")
>
> 844c9db7f7f5fe1b 5628f3fe3b16114e8424bbfcf05
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>   20600541 =C4=85  3%     +14.1%   23500650 =C4=85  2%  cpuidle..usage
>     214491 =C4=85  5%     +11.5%     239155 =C4=85  2%  meminfo.Shmem
>       0.11            +0.0        0.13 =C4=85  2%  mpstat.cpu.all.soft%
>     107642 =C4=85  4%     +17.1%     126046 =C4=85  3%  vmstat.system.cs
>       0.04 =C4=85  8%      +0.0        0.07        turbostat.C1%
>       0.46            +9.8%       0.50        turbostat.IPC
>       4284 =C4=85 13%     +28.8%       5519 =C4=85 10%  numa-meminfo.node=
0.PageTables
>       5684 =C4=85 10%     -21.7%       4451 =C4=85 11%  numa-meminfo.node=
1.PageTables
>     208697 =C4=85  5%     +11.0%     231719 =C4=85  2%  numa-meminfo.node=
1.Shmem
>       1073 =C4=85 13%     +28.9%       1383 =C4=85  9%  numa-vmstat.node0=
.nr_page_table_pages
>       1423 =C4=85 10%     -21.7%       1114 =C4=85 11%  numa-vmstat.node1=
.nr_page_table_pages
>      52145 =C4=85  5%     +11.0%      57900 =C4=85  2%  numa-vmstat.node1=
.nr_shmem
>      12387 =C4=85  4%     -12.9%      10792 =C4=85  4%  sched_debug.cfs_r=
q:/.avg_vruntime.avg
>      12387 =C4=85  4%     -12.9%      10792 =C4=85  4%  sched_debug.cfs_r=
q:/.min_vruntime.avg
>      64470 =C4=85  3%     +16.0%      74816 =C4=85  3%  sched_debug.cpu.n=
r_switches.avg
>       8.08 =C4=85  5%     -12.6%       7.07 =C4=85  3%  perf-sched.total_=
wait_and_delay.average.ms
>     197564 =C4=85  5%     +13.5%     224145 =C4=85  2%  perf-sched.total_=
wait_and_delay.count.ms
>       8.08 =C4=85  5%     -12.6%       7.06 =C4=85  3%  perf-sched.total_=
wait_time.average.ms
>       8.08 =C4=85  5%     -12.6%       7.07 =C4=85  3%  perf-sched.wait_a=
nd_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
>     197564 =C4=85  5%     +13.5%     224145 =C4=85  2%  perf-sched.wait_a=
nd_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
>       8.08 =C4=85  5%     -12.6%       7.06 =C4=85  3%  perf-sched.wait_t=
ime.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
>     224037            +3.1%     230892        proc-vmstat.nr_active_anon
>      53676 =C4=85  4%     +11.5%      59861 =C4=85  2%  proc-vmstat.nr_sh=
mem
>     224037            +3.1%     230892        proc-vmstat.nr_zone_active_=
anon
>  1.129e+08            -5.9%  1.063e+08        proc-vmstat.numa_hit
>  1.127e+08            -5.9%   1.06e+08        proc-vmstat.numa_local
>  8.928e+08            -6.0%  8.394e+08        proc-vmstat.pgalloc_normal
>  8.927e+08            -6.0%  8.393e+08        proc-vmstat.pgfree
>     194605            -6.0%     182934        netperf.ThroughputBoth_Mbps
>     194605            -6.0%     182934        netperf.ThroughputBoth_tota=
l_Mbps
>      97220            -6.0%      91387        netperf.ThroughputRecv_Mbps
>      97220            -6.0%      91387        netperf.ThroughputRecv_tota=
l_Mbps
>      97384            -6.0%      91547        netperf.Throughput_Mbps
>      97384            -6.0%      91547        netperf.Throughput_total_Mb=
ps
>      78.67            -6.8%      73.33        netperf.time.percent_of_cpu=
_this_job_got
>     232.75            -6.6%     217.32        netperf.time.system_time
>  1.114e+08            -6.0%  1.047e+08        netperf.workload
>  5.854e+08            +7.9%  6.313e+08        perf-stat.i.branch-instruct=
ions
>       0.60            -0.0        0.57        perf-stat.i.branch-miss-rat=
e%
>    3570607            +2.7%    3668021        perf-stat.i.branch-misses
>     108376 =C4=85  4%     +17.1%     126925 =C4=85  3%  perf-stat.i.conte=
xt-switches
>       2.29            -9.3%       2.08        perf-stat.i.cpi
>  3.086e+09            +8.7%  3.353e+09        perf-stat.i.instructions
>       0.44           +10.2%       0.49        perf-stat.i.ipc
>       0.61            -0.0        0.58        perf-stat.overall.branch-mi=
ss-rate%
>       2.24            -9.1%       2.04        perf-stat.overall.cpi
>       0.45           +10.0%       0.49        perf-stat.overall.ipc
>       8344           +15.6%       9643        perf-stat.overall.path-leng=
th
>  5.833e+08            +7.9%  6.292e+08        perf-stat.ps.branch-instruc=
tions
>    3558414            +2.8%    3656824        perf-stat.ps.branch-misses
>     108014 =C4=85  4%     +17.1%     126500 =C4=85  3%  perf-stat.ps.cont=
ext-switches
>  3.075e+09            +8.7%  3.341e+09        perf-stat.ps.instructions
>  9.295e+11            +8.6%   1.01e+12        perf-stat.total.instruction=
s
>      29.40            -1.8       27.59        perf-profile.calltrace.cycl=
es-pp.ip_make_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
>      28.64            -1.8       26.86        perf-profile.calltrace.cycl=
es-pp.__ip_append_data.ip_make_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendt=
o
>      25.28            -1.7       23.60        perf-profile.calltrace.cycl=
es-pp.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg.__sys_sen=
dto
>      25.91            -1.6       24.27        perf-profile.calltrace.cycl=
es-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.=
inet_recvmsg
>      33.24            -1.6       31.66        perf-profile.calltrace.cycl=
es-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv_=
omni.process_requests
>      33.22            -1.6       31.64        perf-profile.calltrace.cycl=
es-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe.recv_omni
>      31.95            -1.5       30.42        perf-profile.calltrace.cycl=
es-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SY=
SCALL_64_after_hwframe
>      33.73            -1.5       32.21        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.recv_omni.process_requests.spawn_child=
.accept_connection
>      31.86            -1.5       30.35        perf-profile.calltrace.cycl=
es-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscal=
l_64
>      33.68            -1.5       32.17        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv_omni.process_reques=
ts.spawn_child
>      31.84            -1.5       30.33        perf-profile.calltrace.cycl=
es-pp.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfr=
om
>      24.73            -1.5       23.26        perf-profile.calltrace.cycl=
es-pp._copy_from_iter.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_s=
endmsg
>      26.98            -1.5       25.52        perf-profile.calltrace.cycl=
es-pp.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_re=
cvfrom
>      26.96            -1.5       25.50        perf-profile.calltrace.cycl=
es-pp.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg.s=
ock_recvmsg
>      35.15            -1.4       33.74        perf-profile.calltrace.cycl=
es-pp.recv_omni.process_requests.spawn_child.accept_connection.accept_conne=
ctions
>       0.66 =C4=85  5%      -0.3        0.35 =C4=85 71%  perf-profile.call=
trace.cycles-pp.skb_attempt_defer_free.udp_recvmsg.inet_recvmsg.sock_recvms=
g.__sys_recvfrom
>       0.71 =C4=85  5%      +0.2        0.91 =C4=85  4%  perf-profile.call=
trace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_sm=
p_call_function_queue.do_idle.cpu_startup_entry
>       1.06 =C4=85  9%      +0.2        1.26 =C4=85  6%  perf-profile.call=
trace.cycles-pp.__schedule.schedule.schedule_timeout.__skb_wait_for_more_pa=
ckets.__skb_recv_udp
>       1.09 =C4=85  9%      +0.2        1.29 =C4=85  6%  perf-profile.call=
trace.cycles-pp.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb=
_recv_udp.udp_recvmsg
>       1.14 =C4=85  8%      +0.2        1.35 =C4=85  6%  perf-profile.call=
trace.cycles-pp.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp=
.udp_recvmsg.inet_recvmsg
>       1.28 =C4=85  7%      +0.3        1.56 =C4=85  7%  perf-profile.call=
trace.cycles-pp.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet=
_recvmsg.sock_recvmsg
>       0.98 =C4=85 13%      +0.4        1.36 =C4=85  8%  perf-profile.call=
trace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_que=
ue.do_idle.cpu_startup_entry.start_secondary
>       1.36 =C4=85  5%      +0.4        1.80 =C4=85  4%  perf-profile.call=
trace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__=
wake_up_sync_key.sock_def_readable
>       1.36 =C4=85  5%      +0.4        1.80 =C4=85  4%  perf-profile.call=
trace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_ke=
y.sock_def_readable.__udp_enqueue_schedule_skb
>       0.17 =C4=85141%      +0.5        0.64 =C4=85  7%  perf-profile.call=
trace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function=
.__wake_up_common.__wake_up_sync_key
>       4.74 =C4=85  3%      +0.5        5.22        perf-profile.calltrace=
.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_=
enable_ip
>       4.72 =C4=85  3%      +0.5        5.21        perf-profile.calltrace=
.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_sof=
tirq
>       1.38 =C4=85  8%      +0.5        1.88 =C4=85  6%  perf-profile.call=
trace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.sta=
rt_secondary.common_startup_64
>       0.00            +0.5        0.52 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.schedule=
_timeout
>       4.49 =C4=85  3%      +0.5        5.02        perf-profile.calltrace=
.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_=
action.handle_softirqs
>       3.89 =C4=85  3%      +0.5        4.42        perf-profile.calltrace=
.cycles-pp.ip_local_deliver_finish.ip_local_deliver.__netif_receive_skb_one=
_core.process_backlog.__napi_poll
>       1.73 =C4=85  6%      +0.5        2.27 =C4=85  4%  perf-profile.call=
trace.cycles-pp.__wake_up_common.__wake_up_sync_key.sock_def_readable.__udp=
_enqueue_schedule_skb.udp_queue_rcv_one_skb
>       3.88 =C4=85  3%      +0.5        4.41        perf-profile.calltrace=
.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver=
.__netif_receive_skb_one_core.process_backlog
>       3.90 =C4=85  3%      +0.5        4.44        perf-profile.calltrace=
.cycles-pp.ip_local_deliver.__netif_receive_skb_one_core.process_backlog.__=
napi_poll.net_rx_action
>       0.00            +0.5        0.54        perf-profile.calltrace.cycl=
es-pp.try_to_block_task.__schedule.schedule.schedule_timeout.__skb_wait_for=
_more_packets
>       3.82 =C4=85  3%      +0.5        4.36        perf-profile.calltrace=
.cycles-pp.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.i=
p_local_deliver.__netif_receive_skb_one_core
>       3.39 =C4=85  4%      +0.5        3.94 =C4=85  2%  perf-profile.call=
trace.cycles-pp.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip=
_protocol_deliver_rcu.ip_local_deliver_finish
>       3.40 =C4=85  4%      +0.6        3.95 =C4=85  2%  perf-profile.call=
trace.cycles-pp.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.=
ip_local_deliver_finish.ip_local_deliver
>       1.77 =C4=85  6%      +0.6        2.33 =C4=85  4%  perf-profile.call=
trace.cycles-pp.__wake_up_sync_key.sock_def_readable.__udp_enqueue_schedule=
_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb
>       0.00            +0.6        0.56        perf-profile.calltrace.cycl=
es-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_comm=
on.__wake_up_sync_key
>       3.15 =C4=85  4%      +0.6        3.74        perf-profile.calltrace=
.cycles-pp.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv=
_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
>       0.00            +0.6        0.62 =C4=85  3%  perf-profile.calltrace=
.cycles-pp._find_next_bit.skb_defer_free_flush.net_rx_action.handle_softirq=
s.do_softirq
>       2.16 =C4=85  5%      +0.6        2.80 =C4=85  3%  perf-profile.call=
trace.cycles-pp.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_=
one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv
>       0.00            +0.8        0.76 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.__free_frozen_pages.skb_release_data.napi_consume_skb.skb_defer_=
free_flush.net_rx_action
>       6.82 =C4=85  3%      +0.8        7.65 =C4=85  2%  perf-profile.call=
trace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_c=
all.do_idle
>       0.00            +1.2        1.24 =C4=85  4%  perf-profile.calltrace=
.cycles-pp.skb_release_data.napi_consume_skb.skb_defer_free_flush.net_rx_ac=
tion.handle_softirqs
>       0.00            +1.3        1.27 =C4=85  4%  perf-profile.calltrace=
.cycles-pp.napi_consume_skb.skb_defer_free_flush.net_rx_action.handle_softi=
rqs.do_softirq
>      15.03 =C4=85  2%      +1.4       16.40 =C4=85  2%  perf-profile.call=
trace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
>      15.04 =C4=85  2%      +1.4       16.42 =C4=85  2%  perf-profile.call=
trace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
>      15.05 =C4=85  2%      +1.4       16.42 =C4=85  2%  perf-profile.call=
trace.cycles-pp.start_secondary.common_startup_64
>      10.13            +2.3       12.44        perf-profile.calltrace.cycl=
es-pp.udp_send_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
>      10.02            +2.3       12.34        perf-profile.calltrace.cycl=
es-pp.ip_send_skb.udp_send_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto
>       9.73            +2.3       12.07        perf-profile.calltrace.cycl=
es-pp.ip_finish_output2.ip_output.ip_send_skb.udp_send_skb.udp_sendmsg
>       9.79            +2.3       12.13        perf-profile.calltrace.cycl=
es-pp.ip_output.ip_send_skb.udp_send_skb.udp_sendmsg.__sys_sendto
>       9.39 =C4=85  2%      +2.4       11.76        perf-profile.calltrace=
.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.ip_send_skb.udp_sen=
d_skb
>       8.41 =C4=85  2%      +2.5       10.88        perf-profile.calltrace=
.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_outpu=
t2.ip_output
>       8.36 =C4=85  2%      +2.5       10.82        perf-profile.calltrace=
.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit=
.ip_finish_output2
>       8.51 =C4=85  2%      +2.5       10.98        perf-profile.calltrace=
.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_outpu=
t.ip_send_skb
>       7.91 =C4=85  2%      +2.5       10.45        perf-profile.calltrace=
.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__=
dev_queue_xmit
>       0.00            +5.1        5.13 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.skb_defer_free_flush.net_rx_action.handle_softirqs.do_softirq.__=
local_bh_enable_ip
>      29.41            -1.8       27.59        perf-profile.children.cycle=
s-pp.ip_make_skb
>      28.64            -1.8       26.87        perf-profile.children.cycle=
s-pp.__ip_append_data
>      25.28            -1.7       23.61        perf-profile.children.cycle=
s-pp.ip_generic_getfrag
>      25.95            -1.6       24.31        perf-profile.children.cycle=
s-pp._copy_to_iter
>      33.23            -1.6       31.65        perf-profile.children.cycle=
s-pp.__sys_recvfrom
>      33.24            -1.6       31.66        perf-profile.children.cycle=
s-pp.__x64_sys_recvfrom
>      31.95            -1.5       30.42        perf-profile.children.cycle=
s-pp.sock_recvmsg
>      31.86            -1.5       30.35        perf-profile.children.cycle=
s-pp.inet_recvmsg
>      31.84            -1.5       30.34        perf-profile.children.cycle=
s-pp.udp_recvmsg
>      24.78            -1.5       23.29        perf-profile.children.cycle=
s-pp._copy_from_iter
>      26.98            -1.5       25.52        perf-profile.children.cycle=
s-pp.skb_copy_datagram_iter
>      26.96            -1.5       25.51        perf-profile.children.cycle=
s-pp.__skb_datagram_iter
>      35.15            -1.4       33.74        perf-profile.children.cycle=
s-pp.accept_connection
>      35.15            -1.4       33.74        perf-profile.children.cycle=
s-pp.accept_connections
>      35.15            -1.4       33.74        perf-profile.children.cycle=
s-pp.process_requests
>      35.15            -1.4       33.74        perf-profile.children.cycle=
s-pp.spawn_child
>      35.15            -1.4       33.74        perf-profile.children.cycle=
s-pp.recv_omni
>      76.98            -1.1       75.86        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>      76.90            -1.1       75.78        perf-profile.children.cycle=
s-pp.do_syscall_64
>       0.65 =C4=85  7%      -0.2        0.47 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__virt_addr_valid
>       0.66 =C4=85  5%      -0.1        0.51 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.skb_attempt_defer_free
>       0.94 =C4=85  6%      -0.1        0.81 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__check_object_size
>       0.78 =C4=85  6%      -0.1        0.66 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.check_heap_object
>       0.44 =C4=85  3%      -0.1        0.38 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.sched_clock
>       0.47 =C4=85  3%      -0.1        0.41 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.sched_clock_cpu
>       0.32 =C4=85  8%      -0.0        0.27 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.tick_nohz_next_event
>       0.20 =C4=85 13%      -0.0        0.16 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__get_next_timer_interrupt
>       0.06 =C4=85  7%      +0.0        0.09 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.udp4_csum_init
>       0.07 =C4=85 14%      +0.0        0.10 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.prepare_to_wait_exclusive
>       0.08 =C4=85 17%      +0.0        0.11 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.update_cfs_group
>       0.23 =C4=85  7%      +0.0        0.27 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.__rseq_handle_notify_resume
>       0.09 =C4=85 19%      +0.0        0.13 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.available_idle_cpu
>       0.37 =C4=85  6%      +0.0        0.41 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.enqueue_task_fair
>       0.30 =C4=85  8%      +0.0        0.34 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.enqueue_entity
>       0.39 =C4=85  7%      +0.0        0.44 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.enqueue_task
>       0.26 =C4=85  8%      +0.1        0.31 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.update_curr
>       0.32 =C4=85  6%      +0.1        0.38 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.exit_to_user_mode_loop
>       0.37 =C4=85  4%      +0.1        0.42 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.ttwu_do_activate
>       0.34 =C4=85  6%      +0.1        0.41 =C4=85  4%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock_irqsave
>       0.27 =C4=85  9%      +0.1        0.35 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.cpus_share_cache
>       0.47 =C4=85  6%      +0.1        0.56 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.dequeue_entities
>       0.42 =C4=85  5%      +0.1        0.51 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.dequeue_entity
>       0.48 =C4=85  6%      +0.1        0.57 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.dequeue_task_fair
>       0.48 =C4=85  5%      +0.1        0.57 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.try_to_block_task
>       0.43 =C4=85  4%      +0.1        0.53 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.call_function_single_prep_ipi
>       0.39 =C4=85  3%      +0.1        0.49 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.os_xsave
>       0.46 =C4=85  4%      +0.1        0.58 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__smp_call_single_queue
>       0.48 =C4=85  8%      +0.1        0.60 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.select_task_rq_fair
>       0.37 =C4=85  9%      +0.1        0.48 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.select_idle_sibling
>       0.43 =C4=85  8%      +0.1        0.58 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.select_task_rq
>       0.50 =C4=85  3%      +0.2        0.66 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.ttwu_queue_wakelist
>       1.58 =C4=85  6%      +0.2        1.77 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.schedule
>       0.73 =C4=85  5%      +0.2        0.92 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.sched_ttwu_pending
>       1.18 =C4=85  8%      +0.2        1.39 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.schedule_timeout
>       1.28 =C4=85  7%      +0.3        1.56 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__skb_wait_for_more_packets
>       2.25 =C4=85  7%      +0.4        2.60 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__schedule
>       1.04 =C4=85 12%      +0.4        1.43 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.__flush_smp_call_function_queue
>       1.38 =C4=85  5%      +0.4        1.81 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.autoremove_wake_function
>       1.42 =C4=85  5%      +0.4        1.86 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.try_to_wake_up
>       4.72 =C4=85  3%      +0.5        5.21        perf-profile.children.=
cycles-pp.process_backlog
>       4.74 =C4=85  3%      +0.5        5.22        perf-profile.children.=
cycles-pp.__napi_poll
>       1.76 =C4=85  6%      +0.5        2.28 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__wake_up_common
>       4.49 =C4=85  3%      +0.5        5.02        perf-profile.children.=
cycles-pp.__netif_receive_skb_one_core
>       3.89 =C4=85  3%      +0.5        4.42        perf-profile.children.=
cycles-pp.ip_local_deliver_finish
>       3.90 =C4=85  3%      +0.5        4.44        perf-profile.children.=
cycles-pp.ip_local_deliver
>       3.88 =C4=85  3%      +0.5        4.41        perf-profile.children.=
cycles-pp.ip_protocol_deliver_rcu
>       3.82 =C4=85  3%      +0.5        4.37        perf-profile.children.=
cycles-pp.__udp4_lib_rcv
>       3.40 =C4=85  4%      +0.5        3.95 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.udp_unicast_rcv_skb
>       1.79 =C4=85  6%      +0.6        2.34 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__wake_up_sync_key
>       3.39 =C4=85  4%      +0.6        3.94 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.udp_queue_rcv_one_skb
>       3.16 =C4=85  4%      +0.6        3.75        perf-profile.children.=
cycles-pp.__udp_enqueue_schedule_skb
>       0.14 =C4=85 17%      +0.6        0.77 =C4=85  6%  perf-profile.chil=
dren.cycles-pp._find_next_bit
>       2.17 =C4=85  5%      +0.6        2.82 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.sock_def_readable
>       7.10 =C4=85  3%      +0.8        7.90 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.intel_idle
>      15.05 =C4=85  2%      +1.4       16.42 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.start_secondary
>      12.18            +2.2       14.38        perf-profile.children.cycle=
s-pp.handle_softirqs
>      11.50            +2.3       13.75        perf-profile.children.cycle=
s-pp.do_softirq
>      10.13            +2.3       12.44        perf-profile.children.cycle=
s-pp.udp_send_skb
>      10.02            +2.3       12.34        perf-profile.children.cycle=
s-pp.ip_send_skb
>       9.73            +2.3       12.07        perf-profile.children.cycle=
s-pp.ip_finish_output2
>       9.79            +2.3       12.13        perf-profile.children.cycle=
s-pp.ip_output
>       9.40 =C4=85  2%      +2.4       11.76        perf-profile.children.=
cycles-pp.__dev_queue_xmit
>       8.60 =C4=85  2%      +2.5       11.07        perf-profile.children.=
cycles-pp.__local_bh_enable_ip
>       7.91 =C4=85  2%      +2.6       10.47        perf-profile.children.=
cycles-pp.net_rx_action
>       0.00            +5.1        5.14 =C4=85  2%  perf-profile.children.=
cycles-pp.skb_defer_free_flush
>      25.81            -1.7       24.15        perf-profile.self.cycles-pp=
._copy_to_iter
>       1.73 =C4=85  4%      -1.6        0.10 =C4=85 12%  perf-profile.self=
.cycles-pp.net_rx_action
>      24.62            -1.5       23.14        perf-profile.self.cycles-pp=
._copy_from_iter
>       0.64 =C4=85  7%      -0.2        0.47 =C4=85  7%  perf-profile.self=
.cycles-pp.__virt_addr_valid
>       0.66 =C4=85  5%      -0.1        0.51 =C4=85  7%  perf-profile.self=
.cycles-pp.skb_attempt_defer_free
>       0.23 =C4=85  8%      -0.0        0.19 =C4=85 11%  perf-profile.self=
.cycles-pp.skb_release_data
>       0.16 =C4=85 11%      -0.0        0.13 =C4=85 11%  perf-profile.self=
.cycles-pp.handle_softirqs
>       0.15 =C4=85  7%      -0.0        0.13 =C4=85  8%  perf-profile.self=
.cycles-pp.__sys_sendto
>       0.05 =C4=85  8%      +0.0        0.07 =C4=85  6%  perf-profile.self=
.cycles-pp.__flush_smp_call_function_queue
>       0.06 =C4=85  7%      +0.0        0.08 =C4=85 14%  perf-profile.self=
.cycles-pp.udp4_csum_init
>       0.08 =C4=85 17%      +0.0        0.11 =C4=85 10%  perf-profile.self=
.cycles-pp.update_cfs_group
>       0.09 =C4=85 17%      +0.0        0.13 =C4=85 14%  perf-profile.self=
.cycles-pp.available_idle_cpu
>       0.31 =C4=85  6%      +0.0        0.36 =C4=85  4%  perf-profile.self=
.cycles-pp._raw_spin_lock_irqsave
>       0.12 =C4=85 14%      +0.1        0.17 =C4=85 11%  perf-profile.self=
.cycles-pp.irqtime_account_irq
>       0.00            +0.1        0.06 =C4=85 19%  perf-profile.self.cycl=
es-pp.__skb_wait_for_more_packets
>       0.02 =C4=85 99%      +0.1        0.09 =C4=85 26%  perf-profile.self=
.cycles-pp.ttwu_queue_wakelist
>       0.27 =C4=85  9%      +0.1        0.35 =C4=85  4%  perf-profile.self=
.cycles-pp.cpus_share_cache
>       0.38 =C4=85  6%      +0.1        0.47 =C4=85 10%  perf-profile.self=
.cycles-pp.sock_def_readable
>       0.37 =C4=85 11%      +0.1        0.46 =C4=85  5%  perf-profile.self=
.cycles-pp.flush_smp_call_function_queue
>       0.37 =C4=85  9%      +0.1        0.47 =C4=85  3%  perf-profile.self=
.cycles-pp.__wake_up_common
>       0.43 =C4=85  4%      +0.1        0.53 =C4=85  6%  perf-profile.self=
.cycles-pp.call_function_single_prep_ipi
>       0.39 =C4=85  3%      +0.1        0.49 =C4=85  3%  perf-profile.self=
.cycles-pp.os_xsave
>       0.36 =C4=85  5%      +0.1        0.46 =C4=85  9%  perf-profile.self=
.cycles-pp.try_to_wake_up
>       0.58 =C4=85  6%      +0.1        0.71 =C4=85  3%  perf-profile.self=
.cycles-pp.__skb_datagram_iter
>       0.12 =C4=85 11%      +0.6        0.74 =C4=85  5%  perf-profile.self=
.cycles-pp._find_next_bit
>       7.10 =C4=85  3%      +0.8        7.90 =C4=85  2%  perf-profile.self=
.cycles-pp.intel_idle
>       0.00            +3.1        3.08 =C4=85  4%  perf-profile.self.cycl=
es-pp.skb_defer_free_flush
>
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

