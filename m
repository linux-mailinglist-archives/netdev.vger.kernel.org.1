Return-Path: <netdev+bounces-135752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E358099F132
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D48BB21AE5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF851B393A;
	Tue, 15 Oct 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vXQLXjYj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D6147C91
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006217; cv=none; b=hbIQF5ju8YQyY6DUGOh4+KYjCzVK0S/44auEGlWxWi4gggXLWh+wTDMknCkxlIJiuQ4vun9AUh6LtmgDyCXIJwMXDL9cN9BwlLuHPpgWCfAY/qEFviz21n+o7tL4RZsuiGFIHKKKeaB0jjhoFzGRTAUgnnd77zyLda7AYnW/haA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006217; c=relaxed/simple;
	bh=rGiF0YKgu94NQ2iifk/O5X3Kw8ra0+IINoy+Jt2Bdmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKv/po+v3v2ixMKozZb+HndLWc2J/JA0GY13qi2w10KpybvHuTO58SwG0omQmz1O8BXfMmBVu7f2jCNhmD+P7ykiz2ndWHWz8jB9zaVXwOiwQSRRsBxqoKkNDNZbNHuzCBq8qi+TQLU4e/5MKSHTuYbnpdZPBaSBkC2BHllkrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=vXQLXjYj; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso4587733a12.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1729006213; x=1729611013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf94J/nxYXUjLRpqEi4kfktdPL1NaXWd5oQQWe7jUZM=;
        b=vXQLXjYj5PsTcMyJp4uUNYCL34ROvyjBx/+nPwTxbXuLULukRhEYshIazaqynE0oyk
         h3tknFBBk/y7L3UvR3na+jBaAmN/Z76HU2UbakxSbASw2zqIrdugw2zUu/AcZqHs/l1v
         HbGOdsOnky6Zm61fJ6rsHGaC4DDPFyVfJ/2hXMffUyrhGP5KyYttu2nr9BQNasw2mXCf
         DnZE2liBsVlDH9pMOAcQoN7OIqNvD9/B7TKnJ/3qW/Ih6kV91Ad2QqrGR8Sm2ocprxQq
         vCU44RiU9iZUTQPVyNkEAbHOur8KgzTVWXrsNCrajb9Cit4+22xWb81OLvLQeN2VJvRG
         QLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006213; x=1729611013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vf94J/nxYXUjLRpqEi4kfktdPL1NaXWd5oQQWe7jUZM=;
        b=AhKwgH+E+PD//USp7R6DLTmn0jAMUBBloXEMO1kgXqYA3u2kyS6TxbKEmfjeecDIHA
         RImpoT0U+O0agsjyPM+4tPobEq5m229kYZ4RgQc6gWZhBK2lnsV6XHXM0cl4+7dBA+Oo
         2taqjVedz6crsYSlO3tJSdqth7G8yUmtq0b//6znxYjQfAnXNWYDtu/91N24+iNcEEVy
         /3G3ne4eVTYRCP+3AK89uo5s+tdoAhV8syEvkYgr0tjM56lCTXGddz+XhOwDfONE5xnP
         GY9vOjvjqWTY61jTvwm+UuEanZW6ycmH+NIPiFzzMylCAtj7/zDXNwzTh7LXBIZjPKwn
         YqYQ==
X-Gm-Message-State: AOJu0YwPWB96+MVDF/3lOr5zyXh5omRNZY5ysTWmO9UmErVtuyY9oUbE
	t49GOIDGw9vR8i8APZkVHa7KPQkFbu6+5QYy+SqumRX+9v5t106FkT7w7VDnv0Ev/WriDbeB2Tw
	Infiui7lIVYL0RJb6+QM7fLpb7CFdzwzDRguK
X-Google-Smtp-Source: AGHT+IETiQeKLBuaRw4qy8mT39wjybH6gdrxRz47o9d3d70Hs7Nri34vKDjKhSm810Z5Ju70PY2U0XWtmyS3gbDtS0k=
X-Received: by 2002:a05:6a21:1584:b0:1d8:b11e:19b9 with SMTP id
 adf61e73a8af0-1d905f69289mr870263637.47.1729006212596; Tue, 15 Oct 2024
 08:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com> <20241015102940.26157-2-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241015102940.26157-2-chia-yu.chang@nokia-bell-labs.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 15 Oct 2024 11:30:01 -0400
Message-ID: <CAM0EoMk4Uddc+T-akmMweF9mPC25Amq4+XnAn9fiVEUhmQ_Qbg@mail.gmail.com>
Subject: Re: [PATCH net-next 01/44] sched: Add dualpi2 qdisc
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, 
	Olivier Tilmans <olivier.tilmans@nokia.com>, Henrik Steen <henrist@henrist.net>, 
	Bob Briscoe <research@bobbriscoe.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:31=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
>
> DualPI2 provides L4S-type low latency & loss to traffic that uses a
> scalable congestion controller (e.g. TCP-Prague, DCTCP) without
> degrading the performance of 'classic' traffic (e.g. Reno,
> Cubic etc.). It is intended to be the reference implementation of the
> IETF's DualQ Coupled AQM.
>
> The qdisc provides two queues called low latency and classic. It
> classifies packets based on the ECN field in the IP headers. By
> default it directs non-ECN and ECT(0) into the classic queue and
> ECT(1) and CE into the low latency queue, as per the IETF spec.
>
> Each queue runs its own AQM:
> * The classic AQM is called PI2, which is similar to the PIE AQM but
>   more responsive and simpler. Classic traffic requires a decent
>   target queue (default 15ms for Internet deployment) to fully
>   utilize the link and to avoid high drop rates.
> * The low latency AQM is, by default, a very shallow ECN marking
>   threshold (1ms) similar to that used for DCTCP.
>
> The DualQ isolates the low queuing delay of the Low Latency queue
> from the larger delay of the 'Classic' queue. However, from a
> bandwidth perspective, flows in either queue will share out the link
> capacity as if there was just a single queue. This bandwidth pooling
> effect is achieved by coupling together the drop and ECN-marking
> probabilities of the two AQMs.
>
> The PI2 AQM has two main parameters in addition to its target delay.
> All the defaults are suitable for any Internet setting, but it can
> be reconfigured for a Data Centre setting. The integral gain factor
> alpha is used to slowly correct any persistent standing queue error
> from the target delay, while the proportional gain factor beta is
> used to quickly compensate for queue changes (growth or shrinkage).
> Either alpha and beta are given as a parameter, or they can be
> calculated by tc from alternative typical and maximum RTT parameters.
>
> Internally, the output of a linear Proportional Integral (PI)
> controller is used for both queues. This output is squared to
> calculate the drop or ECN-marking probability of the classic queue.
> This counterbalances the square-root rate equation of Reno/Cubic,
> which is the trick that balances flow rates across the queues. For
> the ECN-marking probability of the low latency queue, the output of
> the base AQM is multiplied by a coupling factor. This determines the
> balance between the flow rates in each queue. The default setting
> makes the flow rates roughly equal, which should be generally
> applicable.
>
> If DUALPI2 AQM has detected overload (due to excessive non-responsive
> traffic in either queue), it will switch to signaling congestion
> solely using drop, irrespective of the ECN field. Alternatively, it
> can be configured to limit the drop probability and let the queue
> grow and eventually overflow (like tail-drop).
>
> Additional details can be found in the draft:
>   https://datatracker.ietf.org/doc/html/rfc9332
>
> Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> Co-developed-by: Olga Albisser <olga@albisser.org>
> Signed-off-by: Olga Albisser <olga@albisser.org>
> Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Co-developed-by: Henrik Steen <henrist@henrist.net>
> Signed-off-by: Henrik Steen <henrist@henrist.net>
> Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>


Most important thing in submissions (if you want reviews) is to make
sure you cc the stakeholders - not everybody keeps track of every
message on the list. Read the upstream howto doc...

> ---
>  include/linux/netdevice.h      |    1 +
>  include/uapi/linux/pkt_sched.h |   34 ++
>  net/sched/Kconfig              |   20 +
>  net/sched/Makefile             |    1 +
>  net/sched/sch_dualpi2.c        | 1046 ++++++++++++++++++++++++++++++++
>  5 files changed, 1102 insertions(+)
>  create mode 100644 net/sched/sch_dualpi2.c
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 8feaca12655e..bdd7d6262112 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -30,6 +30,7 @@
>  #include <asm/byteorder.h>
>  #include <asm/local.h>
>
> +#include <linux/netdev_features.h>
>  #include <linux/percpu.h>
>  #include <linux/rculist.h>
>  #include <linux/workqueue.h>
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sche=
d.h
> index 25a9a47001cd..f2418eabdcb1 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -1210,4 +1210,38 @@ enum {
>
>  #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
>
> +/* DUALPI2 */
> +enum {
> +       TCA_DUALPI2_UNSPEC,
> +       TCA_DUALPI2_LIMIT,              /* Packets */
> +       TCA_DUALPI2_TARGET,             /* us */
> +       TCA_DUALPI2_TUPDATE,            /* us */
> +       TCA_DUALPI2_ALPHA,              /* Hz scaled up by 256 */
> +       TCA_DUALPI2_BETA,               /* HZ scaled up by 256 */
> +       TCA_DUALPI2_STEP_THRESH,        /* Packets or us */
> +       TCA_DUALPI2_STEP_PACKETS,       /* Whether STEP_THRESH is in pack=
ets */
> +       TCA_DUALPI2_COUPLING,           /* Coupling factor between queues=
 */
> +       TCA_DUALPI2_DROP_OVERLOAD,      /* Whether to drop on overload */
> +       TCA_DUALPI2_DROP_EARLY,         /* Whether to drop on enqueue */
> +       TCA_DUALPI2_C_PROTECTION,       /* Percentage */
> +       TCA_DUALPI2_ECN_MASK,           /* L4S queue classification mask =
*/
> +       TCA_DUALPI2_SPLIT_GSO,          /* Split GSO packets at enqueue *=
/
> +       TCA_DUALPI2_PAD,
> +       __TCA_DUALPI2_MAX
> +};
> +
> +#define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
> +
> +struct tc_dualpi2_xstats {
> +       __u32 prob;             /* current probability */
> +       __u32 delay_c;          /* current delay in C queue */
> +       __u32 delay_l;          /* current delay in L queue */
> +       __s32 credit;           /* current c_protection credit */
> +       __u32 packets_in_c;     /* number of packets enqueued in C queue =
*/
> +       __u32 packets_in_l;     /* number of packets enqueued in L queue =
*/
> +       __u32 maxq;             /* maximum queue size */
> +       __u32 ecn_mark;         /* packets marked with ecn*/
> +       __u32 step_marks;       /* ECN marks due to the step AQM */
> +};
> +
>  #endif
> diff --git a/net/sched/Kconfig b/net/sched/Kconfig
> index 8180d0c12fce..c1421e219040 100644
> --- a/net/sched/Kconfig
> +++ b/net/sched/Kconfig
> @@ -403,6 +403,26 @@ config NET_SCH_ETS
>
>           If unsure, say N.
>
> +config NET_SCH_DUALPI2
> +       tristate "Dual Queue Proportional Integral Controller Improved wi=
th a Square (DUALPI2) scheduler"
> +       help
> +         Say Y here if you want to use the DualPI2 AQM.
> +         This is a combination of the DUALQ Coupled-AQM with a PI2 base-=
AQM.
> +         The PI2 AQM is in turn both an extension and a simplification o=
f the
> +         PIE AQM. PI2 makes quite some PIE heuristics unnecessary, while=
 being
> +         able to control scalable congestion controls like DCTCP and
> +         TCP-Prague. With PI2, both Reno/Cubic can be used in parallel w=
ith
> +         DCTCP, maintaining window fairness. DUALQ provides latency sepa=
ration
> +         between low latency DCTCP flows and Reno/Cubic flows that need =
a
> +         bigger queue.
> +         For more information, please see
> +         https://datatracker.ietf.org/doc/html/rfc9332
> +
> +         To compile this code as a module, choose M here: the module
> +         will be called sch_dualpi2.
> +
> +         If unsure, say N.
> +
>  menuconfig NET_SCH_DEFAULT
>         bool "Allow override default queue discipline"
>         help
> diff --git a/net/sched/Makefile b/net/sched/Makefile
> index 82c3f78ca486..1abb06554057 100644
> --- a/net/sched/Makefile
> +++ b/net/sched/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_NET_SCH_FQ_PIE)  +=3D sch_fq_pie.o
>  obj-$(CONFIG_NET_SCH_CBS)      +=3D sch_cbs.o
>  obj-$(CONFIG_NET_SCH_ETF)      +=3D sch_etf.o
>  obj-$(CONFIG_NET_SCH_TAPRIO)   +=3D sch_taprio.o
> +obj-$(CONFIG_NET_SCH_DUALPI2)  +=3D sch_dualpi2.o
>
>  obj-$(CONFIG_NET_CLS_U32)      +=3D cls_u32.o
>  obj-$(CONFIG_NET_CLS_ROUTE4)   +=3D cls_route.o
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> new file mode 100644
> index 000000000000..18e8934faa4e
> --- /dev/null
> +++ b/net/sched/sch_dualpi2.c
> @@ -0,0 +1,1046 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 Nokia
> + *
> + * Author: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> + * Author: Olga Albisser <olga@albisser.org>
> + * Author: Henrik Steen <henrist@henrist.net>
> + * Author: Olivier Tilmans <olivier.tilmans@nokia-bell-labs.com>
> + * Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> + *
> + * DualPI Improved with a Square (dualpi2):
> + * - Supports congestion controls that comply with the Prague requiremen=
ts
> + *   in RFC9331 (e.g. TCP-Prague)
> + * - Supports coupled dual-queue with PI2 as defined in RFC9332
> + * - Supports ECN L4S-identifier (IP.ECN=3D=3D0b*1)
> + *
> + * note: DCTCP is not Prague compliant, so DCTCP & DualPI2 can only be
> + *   used in DC context; BBRv3 (overwrites bbr) stopped Prague support,
> + *   you should use TCP-Prague instead for low latency apps
> + *
> + * References:
> + * - RFC9332: https://datatracker.ietf.org/doc/html/rfc9332
> + * - De Schepper, Koen, et al. "PI 2: A linearized AQM for both classic =
and
> + *   scalable TCP."  in proc. ACM CoNEXT'16, 2016.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/hrtimer.h>
> +#include <linux/if_vlan.h>
> +#include <linux/kernel.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/skbuff.h>
> +#include <linux/types.h>
> +
> +#include <net/gso.h>
> +#include <net/inet_ecn.h>
> +#include <net/pkt_cls.h>
> +#include <net/pkt_sched.h>
> +
> +/* 32b enable to support flows with windows up to ~8.6 * 1e9 packets
> + * i.e., twice the maximal snd_cwnd.
> + * MAX_PROB must be consistent with the RNG in dualpi2_roll().
> + */
> +#define MAX_PROB U32_MAX
> +/* alpha/beta values exchanged over netlink are in units of 256ns */
> +#define ALPHA_BETA_SHIFT 8
> +/* Scaled values of alpha/beta must fit in 32b to avoid overflow in late=
r
> + * computations. Consequently (see and dualpi2_scale_alpha_beta()), thei=
r
> + * netlink-provided values can use at most 31b, i.e. be at most (2^23)-1
> + * (~4MHz) as those are given in 1/256th. This enable to tune alpha/beta=
 to
> + * control flows whose maximal RTTs can be in usec up to few secs.
> + */
> +#define ALPHA_BETA_MAX ((1U << 31) - 1)
> +/* Internal alpha/beta are in units of 64ns.
> + * This enables to use all alpha/beta values in the allowed range withou=
t loss
> + * of precision due to rounding when scaling them internally, e.g.,
> + * scale_alpha_beta(1) will not round down to 0.
> + */
> +#define ALPHA_BETA_GRANULARITY 6
> +#define ALPHA_BETA_SCALING (ALPHA_BETA_SHIFT - ALPHA_BETA_GRANULARITY)
> +/* We express the weights (wc, wl) in %, i.e., wc + wl =3D 100 */
> +#define MAX_WC 100
> +
> +struct dualpi2_sched_data {
> +       struct Qdisc *l_queue;  /* The L4S LL queue */
> +       struct Qdisc *sch;      /* The classic queue (owner of this struc=
t) */
> +
> +       /* Registered tc filters */
> +       struct {
> +               struct tcf_proto __rcu *filters;
> +               struct tcf_block *block;
> +       } tcf;
> +
> +       struct { /* PI2 parameters */
> +               u64     target; /* Target delay in nanoseconds */
> +               u32     tupdate;/* Timer frequency in nanoseconds */
> +               u32     prob;   /* Base PI probability */
> +               u32     alpha;  /* Gain factor for the integral rate resp=
onse */
> +               u32     beta;   /* Gain factor for the proportional respo=
nse */
> +               struct hrtimer timer; /* prob update timer */
> +       } pi2;
> +
> +       struct { /* Step AQM (L4S queue only) parameters */
> +               u32 thresh;     /* Step threshold */
> +               bool in_packets;/* Whether the step is in packets or time=
 */
> +       } step;
> +
> +       struct { /* Classic queue starvation protection */
> +               s32     credit; /* Credit (sign indicates which queue) */
> +               s32     init;   /* Reset value of the credit */
> +               u8      wc;     /* C queue weight (between 0 and MAX_WC) =
*/
> +               u8      wl;     /* L queue weight (MAX_WC - wc) */
> +       } c_protection;
> +
> +       /* General dualQ parameters */
> +       u8      coupling_factor;/* Coupling factor (k) between both queue=
s */
> +       u8      ecn_mask;       /* Mask to match L4S packets */
> +       bool    drop_early;     /* Drop at enqueue instead of dequeue if =
true */
> +       bool    drop_overload;  /* Drop (1) on overload, or overflow (0) =
*/
> +       bool    split_gso;      /* Split aggregated skb (1) or leave as i=
s */
> +
> +       /* Statistics */
> +       u64     c_head_ts;      /* Enqueue timestamp of the classic Q's h=
ead */
> +       u64     l_head_ts;      /* Enqueue timestamp of the L Q's head */
> +       u64     last_qdelay;    /* Q delay val at the last probability up=
date */
> +       u32     packets_in_c;   /* Number of packets enqueued in C queue =
*/
> +       u32     packets_in_l;   /* Number of packets enqueued in L queue =
*/
> +       u32     maxq;           /* maximum queue size */
> +       u32     ecn_mark;       /* packets marked with ECN */
> +       u32     step_marks;     /* ECN marks due to the step AQM */
> +
> +       struct { /* Deferred drop statistics */
> +               u32 cnt;        /* Packets dropped */
> +               u32 len;        /* Bytes dropped */
> +       } deferred_drops;
> +};
> +
> +struct dualpi2_skb_cb {
> +       u64 ts;                 /* Timestamp at enqueue */
> +       u8 apply_step:1,        /* Can we apply the step threshold */
> +          classified:2,        /* Packet classification results */
> +          ect:2;               /* Packet ECT codepoint */
> +};
> +
> +enum dualpi2_classification_results {
> +       DUALPI2_C_CLASSIC       =3D 0,    /* C queue */
> +       DUALPI2_C_L4S           =3D 1,    /* L queue (scalable marking/cl=
assic drops) */
> +       DUALPI2_C_LLLL          =3D 2,    /* L queue (no drops/marks) */
> +       __DUALPI2_C_MAX                 /* Keep last*/
> +};
> +
> +static struct dualpi2_skb_cb *dualpi2_skb_cb(struct sk_buff *skb)
> +{
> +       qdisc_cb_private_validate(skb, sizeof(struct dualpi2_skb_cb));
> +       return (struct dualpi2_skb_cb *)qdisc_skb_cb(skb)->data;
> +}
> +
> +static u64 skb_sojourn_time(struct sk_buff *skb, u64 reference)
> +{
> +       return reference - dualpi2_skb_cb(skb)->ts;
> +}
>

better to use dualpi2 instead of skb prefix?

> +static u64 head_enqueue_time(struct Qdisc *q)
> +{
> +       struct sk_buff *skb =3D qdisc_peek_head(q);
> +
> +       return skb ? dualpi2_skb_cb(skb)->ts : 0;
> +}
> +
> +static u32 dualpi2_scale_alpha_beta(u32 param)
> +{
> +       u64 tmp =3D ((u64)param * MAX_PROB >> ALPHA_BETA_SCALING);
> +
> +       do_div(tmp, NSEC_PER_SEC);
> +       return tmp;
> +}
> +
> +static u32 dualpi2_unscale_alpha_beta(u32 param)
> +{
> +       u64 tmp =3D ((u64)param * NSEC_PER_SEC << ALPHA_BETA_SCALING);
> +
> +       do_div(tmp, MAX_PROB);
> +       return tmp;
> +}
> +
> +static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
> +{
> +       return ktime_add_ns(ktime_get_ns(), q->pi2.tupdate);
> +}
> +
> +static bool skb_is_l4s(struct sk_buff *skb)
> +{
> +       return dualpi2_skb_cb(skb)->classified =3D=3D DUALPI2_C_L4S;
> +}
> +
> +static bool skb_in_l_queue(struct sk_buff *skb)
> +{
> +       return dualpi2_skb_cb(skb)->classified !=3D DUALPI2_C_CLASSIC;
> +}
> +
> +static bool dualpi2_mark(struct dualpi2_sched_data *q, struct sk_buff *s=
kb)
> +{
> +       if (INET_ECN_set_ce(skb)) {
> +               q->ecn_mark++;
> +               return true;
> +       }
> +       return false;
> +}
> +
> +static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
> +{
> +       q->c_protection.credit =3D q->c_protection.init;
> +}
> +
> +/* This computes the initial credit value and WRR weight for the L queue=
 (wl)
> + * from the weight of the C queue (wc).
> + * If wl > wc, the scheduler will start with the L queue when reset.
> + */
> +static void dualpi2_calculate_c_protection(struct Qdisc *sch,
> +                                          struct dualpi2_sched_data *q, =
u32 wc)
> +{
> +       q->c_protection.wc =3D wc;
> +       q->c_protection.wl =3D MAX_WC - wc;
> +       q->c_protection.init =3D (s32)psched_mtu(qdisc_dev(sch)) *
> +               ((int)q->c_protection.wc - (int)q->c_protection.wl);
> +       dualpi2_reset_c_protection(q);
> +}
> +
> +static bool dualpi2_roll(u32 prob)
> +{
> +       return get_random_u32() <=3D prob;
> +}
> +
> +/* Packets in the C queue are subject to a marking probability pC, which=
 is the
> + * square of the internal PI2 probability (i.e., have an overall lower m=
ark/drop
> + * probability). If the qdisc is overloaded, ignore ECT values and only =
drop.
> + *
> + * Note that this marking scheme is also applied to L4S packets during o=
verload.
> + * Return true if packet dropping is required in C queue
> + */
> +static bool dualpi2_classic_marking(struct dualpi2_sched_data *q,
> +                                   struct sk_buff *skb, u32 prob,
> +                                   bool overload)
> +{
> +       if (dualpi2_roll(prob) && dualpi2_roll(prob)) {
> +               if (overload || dualpi2_skb_cb(skb)->ect =3D=3D INET_ECN_=
NOT_ECT)
> +                       return true;
> +               dualpi2_mark(q, skb);
> +       }
> +       return false;
> +}
> +
> +/* Packets in the L queue are subject to a marking probability pL given =
by the
> + * internal PI2 probability scaled by the coupling factor.
> + *
> + * On overload (i.e., @local_l_prob is >=3D 100%):
> + * - if the qdisc is configured to trade losses to preserve latency (i.e=
.,
> + *   @q->drop_overload), apply classic drops first before marking.
> + * - otherwise, preserve the "no loss" property of ECN at the cost of qu=
eueing
> + *   delay, eventually resulting in taildrop behavior once sch->limit is
> + *   reached.
> + * Return true if packet dropping is required in L queue
> + */
> +static bool dualpi2_scalable_marking(struct dualpi2_sched_data *q,
> +                                    struct sk_buff *skb,
> +                                    u64 local_l_prob, u32 prob,
> +                                    bool overload)
> +{
> +       if (overload) {
> +               /* Apply classic drop */
> +               if (!q->drop_overload ||
> +                   !(dualpi2_roll(prob) && dualpi2_roll(prob)))
> +                       goto mark;
> +               return true;
> +       }
> +
> +       /* We can safely cut the upper 32b as overload=3D=3Dfalse */
> +       if (dualpi2_roll(local_l_prob)) {
> +               /* Non-ECT packets could have classified as L4S by filter=
s. */
> +               if (dualpi2_skb_cb(skb)->ect =3D=3D INET_ECN_NOT_ECT)
> +                       return true;
> +mark:
> +               dualpi2_mark(q, skb);
> +       }
> +       return false;
> +}
> +
> +/* Decide whether a given packet must be dropped (or marked if ECT), acc=
ording
> + * to the PI2 probability.
> + *
> + * Never mark/drop if we have a standing queue of less than 2 MTUs.
> + */
> +static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
> +                     struct sk_buff *skb)
> +{
> +       u64 local_l_prob;
> +       u32 prob;
> +       bool overload;
> +
> +       if (sch->qstats.backlog < 2 * psched_mtu(qdisc_dev(sch)))
> +               return false;
> +
> +       prob =3D READ_ONCE(q->pi2.prob);
> +       local_l_prob =3D (u64)prob * q->coupling_factor;
> +       overload =3D local_l_prob > MAX_PROB;
> +
> +       switch (dualpi2_skb_cb(skb)->classified) {
> +       case DUALPI2_C_CLASSIC:
> +               return dualpi2_classic_marking(q, skb, prob, overload);
> +       case DUALPI2_C_L4S:
> +               return dualpi2_scalable_marking(q, skb, local_l_prob, pro=
b,
> +                                               overload);
> +       default: /* DUALPI2_C_LLLL */
> +               return false;
> +       }
> +}
> +
> +static void dualpi2_read_ect(struct sk_buff *skb)
> +{
> +       struct dualpi2_skb_cb *cb =3D dualpi2_skb_cb(skb);
> +       int wlen =3D skb_network_offset(skb);
> +
> +       switch (skb_protocol(skb, true)) {
> +       case htons(ETH_P_IP):
> +               wlen +=3D sizeof(struct iphdr);
> +               if (!pskb_may_pull(skb, wlen) ||
> +                   skb_try_make_writable(skb, wlen))
> +                       goto not_ecn;
> +
> +               cb->ect =3D ipv4_get_dsfield(ip_hdr(skb)) & INET_ECN_MASK=
;
> +               break;
> +       case htons(ETH_P_IPV6):
> +               wlen +=3D sizeof(struct ipv6hdr);
> +               if (!pskb_may_pull(skb, wlen) ||
> +                   skb_try_make_writable(skb, wlen))
> +                       goto not_ecn;
> +
> +               cb->ect =3D ipv6_get_dsfield(ipv6_hdr(skb)) & INET_ECN_MA=
SK;
> +               break;
> +       default:
> +               goto not_ecn;
> +       }
> +       return;
> +
> +not_ecn:
> +       /* Non pullable/writable packets can only be dropped hence are
> +        * classified as not ECT.
> +        */
> +       cb->ect =3D INET_ECN_NOT_ECT;
> +}
> +
> +static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
> +                               struct sk_buff *skb)
> +{
> +       struct dualpi2_skb_cb *cb =3D dualpi2_skb_cb(skb);
> +       struct tcf_result res;
> +       struct tcf_proto *fl;
> +       int result;
> +
> +       dualpi2_read_ect(skb);
> +       if (cb->ect & q->ecn_mask) {
> +               cb->classified =3D DUALPI2_C_L4S;
> +               return NET_XMIT_SUCCESS;
> +       }
> +
> +       if (TC_H_MAJ(skb->priority) =3D=3D q->sch->handle &&
> +           TC_H_MIN(skb->priority) < __DUALPI2_C_MAX) {
> +               cb->classified =3D TC_H_MIN(skb->priority);
> +               return NET_XMIT_SUCCESS;
> +       }
> +
> +       fl =3D rcu_dereference_bh(q->tcf.filters);
> +       if (!fl) {
> +               cb->classified =3D DUALPI2_C_CLASSIC;
> +               return NET_XMIT_SUCCESS;
> +       }
> +
> +       result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       if (result >=3D 0) {
> +#ifdef CONFIG_NET_CLS_ACT
> +               switch (result) {
> +               case TC_ACT_STOLEN:
> +               case TC_ACT_QUEUED:
> +               case TC_ACT_TRAP:
> +                       return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
> +               case TC_ACT_SHOT:
> +                       return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> +               }
> +#endif
> +               cb->classified =3D TC_H_MIN(res.classid) < __DUALPI2_C_MA=
X ?
> +                       TC_H_MIN(res.classid) : DUALPI2_C_CLASSIC;
> +       }
> +       return NET_XMIT_SUCCESS;
> +}
> +
> +static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
> +                              struct sk_buff **to_free)
> +{
> +       struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> +       struct dualpi2_skb_cb *cb;
> +
> +       if (unlikely(qdisc_qlen(sch) >=3D sch->limit)) {
> +               qdisc_qstats_overlimit(sch);
> +               if (skb_in_l_queue(skb))
> +                       qdisc_qstats_overlimit(q->l_queue);
> +               return qdisc_drop(skb, sch, to_free);
> +       }
> +
> +       if (q->drop_early && must_drop(sch, q, skb)) {
> +               qdisc_drop(skb, sch, to_free);
> +               return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> +       }
> +
> +       cb =3D dualpi2_skb_cb(skb);
> +       cb->ts =3D ktime_get_ns();
> +
> +       if (qdisc_qlen(sch) > q->maxq)
> +               q->maxq =3D qdisc_qlen(sch);
> +
> +       if (skb_in_l_queue(skb)) {
> +               /* Only apply the step if a queue is building up */
> +               dualpi2_skb_cb(skb)->apply_step =3D
> +                       skb_is_l4s(skb) && qdisc_qlen(q->l_queue) > 1;
> +               /* Keep the overall qdisc stats consistent */
> +               ++sch->q.qlen;
> +               qdisc_qstats_backlog_inc(sch, skb);
> +               ++q->packets_in_l;
> +               if (!q->l_head_ts)
> +                       q->l_head_ts =3D cb->ts;
> +               return qdisc_enqueue_tail(skb, q->l_queue);
> +       }
> +       ++q->packets_in_c;
> +       if (!q->c_head_ts)
> +               q->c_head_ts =3D cb->ts;
> +       return qdisc_enqueue_tail(skb, sch);
> +}
> +
> +/* Optionally, dualpi2 will split GSO skbs into independent skbs and enq=
ueue
> + * each of those individually. This yields the following benefits, at th=
e
> + * expense of CPU usage:
> + * - Finer-grained AQM actions as the sub-packets of a burst no longer s=
hare the
> + *   same fate (e.g., the random mark/drop probability is applied indivi=
dually)
> + * - Improved precision of the starvation protection/WRR scheduler at de=
queue,
> + *   as the size of the dequeued packets will be smaller.
> + */
> +static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> +                                struct sk_buff **to_free)
> +{
> +       struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> +       int err;
> +
> +       err =3D dualpi2_skb_classify(q, skb);
> +       if (err !=3D NET_XMIT_SUCCESS) {
> +               if (err & __NET_XMIT_BYPASS)
> +                       qdisc_qstats_drop(sch);
> +               __qdisc_drop(skb, to_free);
> +               return err;
> +       }
> +
> +       if (q->split_gso && skb_is_gso(skb)) {
> +               netdev_features_t features;
> +               struct sk_buff *nskb, *next;
> +               int cnt, byte_len, orig_len;
> +               int err;
> +
> +               features =3D netif_skb_features(skb);
> +               nskb =3D skb_gso_segment(skb, features & ~NETIF_F_GSO_MAS=
K);
> +               if (IS_ERR_OR_NULL(nskb))
> +                       return qdisc_drop(skb, sch, to_free);
> +
> +               cnt =3D 1;
> +               byte_len =3D 0;
> +               orig_len =3D qdisc_pkt_len(skb);
> +               while (nskb) {
> +                       next =3D nskb->next;
> +                       skb_mark_not_on_list(nskb);
> +                       qdisc_skb_cb(nskb)->pkt_len =3D nskb->len;
> +                       dualpi2_skb_cb(nskb)->classified =3D
> +                               dualpi2_skb_cb(skb)->classified;
> +                       dualpi2_skb_cb(nskb)->ect =3D dualpi2_skb_cb(skb)=
->ect;
> +                       err =3D dualpi2_enqueue_skb(nskb, sch, to_free);
> +                       if (err =3D=3D NET_XMIT_SUCCESS) {
> +                               /* Compute the backlog adjustement that n=
eeds
> +                                * to be propagated in the qdisc tree to =
reflect
> +                                * all new skbs successfully enqueued.
> +                                */
> +                               ++cnt;
> +                               byte_len +=3D nskb->len;
> +                       }
> +                       nskb =3D next;
> +               }
> +               if (err =3D=3D NET_XMIT_SUCCESS) {
> +                       /* The caller will add the original skb stats to =
its
> +                        * backlog, compensate this.
> +                        */
> +                       --cnt;
> +                       byte_len -=3D orig_len;
> +               }
> +               qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
> +               consume_skb(skb);
> +               return err;
> +       }
> +       return dualpi2_enqueue_skb(skb, sch, to_free);
> +}
> +
> +/* Select the queue from which the next packet can be dequeued, ensuring=
 that
> + * neither queue can starve the other with a WRR scheduler.
> + *
> + * The sign of the WRR credit determines the next queue, while the size =
of
> + * the dequeued packet determines the magnitude of the WRR credit change=
. If
> + * either queue is empty, the WRR credit is kept unchanged.
> + *
> + * As the dequeued packet can be dropped later, the caller has to perfor=
m the
> + * qdisc_bstats_update() calls.
> + */
> +static struct sk_buff *dequeue_packet(struct Qdisc *sch,
> +                                     struct dualpi2_sched_data *q,
> +                                     int *credit_change,
> +                                     u64 now)
> +{
> +       struct sk_buff *skb =3D NULL;
> +       int c_len;
> +
> +       *credit_change =3D 0;
> +       c_len =3D qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
> +       if (qdisc_qlen(q->l_queue) && (!c_len || q->c_protection.credit <=
=3D 0)) {
> +               skb =3D __qdisc_dequeue_head(&q->l_queue->q);
> +               WRITE_ONCE(q->l_head_ts, head_enqueue_time(q->l_queue));
> +               if (c_len)
> +                       *credit_change =3D q->c_protection.wc;
> +               qdisc_qstats_backlog_dec(q->l_queue, skb);
> +               /* Keep the global queue size consistent */
> +               --sch->q.qlen;
> +       } else if (c_len) {
> +               skb =3D __qdisc_dequeue_head(&sch->q);
> +               WRITE_ONCE(q->c_head_ts, head_enqueue_time(sch));
> +               if (qdisc_qlen(q->l_queue))
> +                       *credit_change =3D ~((s32)q->c_protection.wl) + 1=
;
> +       } else {
> +               dualpi2_reset_c_protection(q);
> +               return NULL;
> +       }
> +       *credit_change *=3D qdisc_pkt_len(skb);
> +       qdisc_qstats_backlog_dec(sch, skb);
> +       return skb;
> +}
> +
> +static int do_step_aqm(struct dualpi2_sched_data *q, struct sk_buff *skb=
,
> +                      u64 now)
> +{
> +       u64 qdelay =3D 0;
> +
> +       if (q->step.in_packets)
> +               qdelay =3D qdisc_qlen(q->l_queue);
> +       else
> +               qdelay =3D skb_sojourn_time(skb, now);
> +
> +       if (dualpi2_skb_cb(skb)->apply_step && qdelay > q->step.thresh) {
> +               if (!dualpi2_skb_cb(skb)->ect)
> +                       /* Drop this non-ECT packet */
> +                       return 1;
> +               if (dualpi2_mark(q, skb))
> +                       ++q->step_marks;
> +       }
> +       qdisc_bstats_update(q->l_queue, skb);
> +       return 0;
> +}
> +
> +static void drop_and_retry(struct dualpi2_sched_data *q, struct sk_buff =
*skb, struct Qdisc *sch)
> +{
> +       ++q->deferred_drops.cnt;
> +       q->deferred_drops.len +=3D qdisc_pkt_len(skb);
> +       consume_skb(skb);
> +       qdisc_qstats_drop(sch);
> +}
> +
> +static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
> +{
> +       struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> +       struct sk_buff *skb;
> +       int credit_change;
> +       u64 now;
> +
> +       now =3D ktime_get_ns();
> +
> +       while ((skb =3D dequeue_packet(sch, q, &credit_change, now))) {
> +               if (!q->drop_early && must_drop(sch, q, skb)) {
> +                       drop_and_retry(q, skb, sch);
> +                       continue;
> +               }
> +
> +               if (skb_in_l_queue(skb) && do_step_aqm(q, skb, now)) {
> +                       qdisc_qstats_drop(q->l_queue);
> +                       drop_and_retry(q, skb, sch);
> +                       continue;
> +               }
> +
> +               q->c_protection.credit +=3D credit_change;
> +               qdisc_bstats_update(sch, skb);
> +               break;
> +       }
> +
> +       /* We cannot call qdisc_tree_reduce_backlog() if our qlen is 0,
> +        * or HTB crashes.
> +        */
> +       if (q->deferred_drops.cnt && qdisc_qlen(sch)) {
> +               qdisc_tree_reduce_backlog(sch, q->deferred_drops.cnt,
> +                                         q->deferred_drops.len);
> +               q->deferred_drops.cnt =3D 0;
> +               q->deferred_drops.len =3D 0;
> +       }
> +       return skb;
> +}
> +
> +static s64 __scale_delta(u64 diff)
> +{
> +       do_div(diff, 1 << ALPHA_BETA_GRANULARITY);
> +       return diff;
> +}
> +
> +static void get_queue_delays(struct dualpi2_sched_data *q, u64 *qdelay_c=
,
> +                            u64 *qdelay_l)
> +{
> +       u64 now, qc, ql;
> +
> +       now =3D ktime_get_ns();
> +       qc =3D READ_ONCE(q->c_head_ts);
> +       ql =3D READ_ONCE(q->l_head_ts);
> +
> +       *qdelay_c =3D qc ? now - qc : 0;
> +       *qdelay_l =3D ql ? now - ql : 0;
> +}
> +
> +static u32 calculate_probability(struct Qdisc *sch)
> +{
> +       struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> +       u32 new_prob;
> +       u64 qdelay_c;
> +       u64 qdelay_l;
> +       u64 qdelay;
> +       s64 delta;
> +
> +       get_queue_delays(q, &qdelay_c, &qdelay_l);
> +       qdelay =3D max(qdelay_l, qdelay_c);
> +       /* Alpha and beta take at most 32b, i.e, the delay difference wou=
ld
> +        * overflow for queuing delay differences > ~4.2sec.
> +        */
> +       delta =3D ((s64)qdelay - q->pi2.target) * q->pi2.alpha;
> +       delta +=3D ((s64)qdelay - q->last_qdelay) * q->pi2.beta;
> +       if (delta > 0) {
> +               new_prob =3D __scale_delta(delta) + q->pi2.prob;
> +               if (new_prob < q->pi2.prob)
> +                       new_prob =3D MAX_PROB;
> +       } else {
> +               new_prob =3D q->pi2.prob - __scale_delta(~delta + 1);
> +               if (new_prob > q->pi2.prob)
> +                       new_prob =3D 0;
> +       }
> +       q->last_qdelay =3D qdelay;
> +       /* If we do not drop on overload, ensure we cap the L4S probabili=
ty to
> +        * 100% to keep window fairness when overflowing.
> +        */
> +       if (!q->drop_overload)
> +               return min_t(u32, new_prob, MAX_PROB / q->coupling_factor=
);
> +       return new_prob;
> +}
> +
> +static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
> +{
> +       struct dualpi2_sched_data *q =3D from_timer(q, timer, pi2.timer);
> +
> +       WRITE_ONCE(q->pi2.prob, calculate_probability(q->sch));
> +
> +       hrtimer_set_expires(&q->pi2.timer, next_pi2_timeout(q));
> +       return HRTIMER_RESTART;
> +}
> +
> +static const struct nla_policy dualpi2_policy[TCA_DUALPI2_MAX + 1] =3D {
> +       [TCA_DUALPI2_LIMIT] =3D {.type =3D NLA_U32},
> +       [TCA_DUALPI2_TARGET] =3D {.type =3D NLA_U32},
> +       [TCA_DUALPI2_TUPDATE] =3D {.type =3D NLA_U32},
> +       [TCA_DUALPI2_ALPHA] =3D {.type =3D NLA_U32},
> +       [TCA_DUALPI2_BETA] =3D {.type =3D NLA_U32},
> +       [TCA_DUALPI2_STEP_THRESH] =3D {.type =3D NLA_U32},
> +       [TCA_DUALPI2_STEP_PACKETS] =3D {.type =3D NLA_U8},
> +       [TCA_DUALPI2_COUPLING] =3D {.type =3D NLA_U8},
> +       [TCA_DUALPI2_DROP_OVERLOAD] =3D {.type =3D NLA_U8},
> +       [TCA_DUALPI2_DROP_EARLY] =3D {.type =3D NLA_U8},
> +       [TCA_DUALPI2_C_PROTECTION] =3D {.type =3D NLA_U8},
> +       [TCA_DUALPI2_ECN_MASK] =3D {.type =3D NLA_U8},
> +       [TCA_DUALPI2_SPLIT_GSO] =3D {.type =3D NLA_U8},
> +};
>
> +static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
> +                         struct netlink_ext_ack *extack)
> +{
> +       struct nlattr *tb[TCA_DUALPI2_MAX + 1];
> +       struct dualpi2_sched_data *q;
> +       int old_backlog;
> +       int old_qlen;
> +       int err;
> +
> +       if (!opt)
> +               return -EINVAL;
> +       err =3D nla_parse_nested_deprecated(tb, TCA_DUALPI2_MAX, opt,
> +                                         dualpi2_policy, extack);

Given this is a new qdisc - use normal nla_parse_nested()

> +       if (err < 0)
> +               return err;
> +
> +       q =3D qdisc_priv(sch);
> +       sch_tree_lock(sch);
> +
> +       if (tb[TCA_DUALPI2_LIMIT]) {
> +               u32 limit =3D nla_get_u32(tb[TCA_DUALPI2_LIMIT]);
> +
> +               if (!limit) {
> +                       NL_SET_ERR_MSG_ATTR(extack, tb[TCA_DUALPI2_LIMIT]=
,
> +                                           "limit must be greater than 0=
.");
> +                       sch_tree_unlock(sch);
> +                       return -EINVAL;
> +               }
> +               sch->limit =3D limit;
> +       }
> +
> +       if (tb[TCA_DUALPI2_TARGET])
> +               q->pi2.target =3D (u64)nla_get_u32(tb[TCA_DUALPI2_TARGET]=
) *
> +                       NSEC_PER_USEC;
> +
> +       if (tb[TCA_DUALPI2_TUPDATE]) {
> +               u64 tupdate =3D nla_get_u32(tb[TCA_DUALPI2_TUPDATE]);
> +
> +               if (!tupdate) {
> +                       NL_SET_ERR_MSG_ATTR(extack, tb[TCA_DUALPI2_TUPDAT=
E],
> +                                           "tupdate cannot be 0us.");
> +                       sch_tree_unlock(sch);
> +                       return -EINVAL;
> +               }
> +               q->pi2.tupdate =3D tupdate * NSEC_PER_USEC;
> +       }
> +
> +       if (tb[TCA_DUALPI2_ALPHA]) {
> +               u32 alpha =3D nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
> +
> +               if (alpha > ALPHA_BETA_MAX) {
> +                       NL_SET_ERR_MSG_ATTR(extack, tb[TCA_DUALPI2_ALPHA]=
,
> +                                           "alpha is too large.");
> +                       sch_tree_unlock(sch);
> +                       return -EINVAL;
> +               }
> +               q->pi2.alpha =3D dualpi2_scale_alpha_beta(alpha);
> +       }

You should consider using netlink policies for these checks (for
example, you can check for min/max without replicating code as above).
Applies in quiet a few places (and not just for max/min validation)

cheers,
jamal

> +
> +       if (tb[TCA_DUALPI2_BETA]) {
> +               u32 beta =3D nla_get_u32(tb[TCA_DUALPI2_BETA]);
> +
> +               if (beta > ALPHA_BETA_MAX) {
> +                       NL_SET_ERR_MSG_ATTR(extack, tb[TCA_DUALPI2_BETA],
> +                                           "beta is too large.");
> +                       sch_tree_unlock(sch);
> +                       return -EINVAL;
> +               }
> +               q->pi2.beta =3D dualpi2_scale_alpha_beta(beta);
> +       }
> +
> +       if (tb[TCA_DUALPI2_STEP_THRESH])
> +               q->step.thresh =3D nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH=
]) *
> +                       NSEC_PER_USEC;
> +
> +       if (tb[TCA_DUALPI2_COUPLING]) {
> +               u8 coupling =3D nla_get_u8(tb[TCA_DUALPI2_COUPLING]);
> +
> +               if (!coupling) {
> +                       NL_SET_ERR_MSG_ATTR(extack, tb[TCA_DUALPI2_COUPLI=
NG],
> +                                           "Must use a non-zero coupling=
.");
> +                       sch_tree_unlock(sch);
> +                       return -EINVAL;
> +               }
> +               q->coupling_factor =3D coupling;
> +       }
> +
> +       if (tb[TCA_DUALPI2_STEP_PACKETS])
> +               q->step.in_packets =3D !!nla_get_u8(tb[TCA_DUALPI2_STEP_P=
ACKETS]);
> +
> +       if (tb[TCA_DUALPI2_DROP_OVERLOAD])
> +               q->drop_overload =3D !!nla_get_u8(tb[TCA_DUALPI2_DROP_OVE=
RLOAD]);
> +
> +       if (tb[TCA_DUALPI2_DROP_EARLY])
> +               q->drop_early =3D !!nla_get_u8(tb[TCA_DUALPI2_DROP_EARLY]=
);
> +
> +       if (tb[TCA_DUALPI2_C_PROTECTION]) {
> +               u8 wc =3D nla_get_u8(tb[TCA_DUALPI2_C_PROTECTION]);
> +
> +               if (wc > MAX_WC) {
> +                       NL_SET_ERR_MSG_ATTR(extack,
> +                                           tb[TCA_DUALPI2_C_PROTECTION],
> +                                           "c_protection must be <=3D 10=
0.");
> +                       sch_tree_unlock(sch);
> +                       return -EINVAL;
> +               }
> +               dualpi2_calculate_c_protection(sch, q, wc);
> +       }
> +
> +       if (tb[TCA_DUALPI2_ECN_MASK])
> +               q->ecn_mask =3D nla_get_u8(tb[TCA_DUALPI2_ECN_MASK]);
> +
> +       if (tb[TCA_DUALPI2_SPLIT_GSO])
> +               q->split_gso =3D !!nla_get_u8(tb[TCA_DUALPI2_SPLIT_GSO]);
> +
> +       old_qlen =3D qdisc_qlen(sch);
> +       old_backlog =3D sch->qstats.backlog;
> +       while (qdisc_qlen(sch) > sch->limit) {
> +               struct sk_buff *skb =3D __qdisc_dequeue_head(&sch->q);
> +
> +               qdisc_qstats_backlog_dec(sch, skb);
> +               rtnl_qdisc_drop(skb, sch);
> +       }
> +       qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
> +                                 old_backlog - sch->qstats.backlog);
> +
> +       sch_tree_unlock(sch);
> +       return 0;
> +}
> +
> +/* Default alpha/beta values give a 10dB stability margin with max_rtt=
=3D100ms. */
> +static void dualpi2_reset_default(struct dualpi2_sched_data *q)
> +{
> +       q->sch->limit =3D 10000;                          /* Max 125ms at=
 1Gbps */
> +
> +       q->pi2.target =3D 15 * NSEC_PER_MSEC;
> +       q->pi2.tupdate =3D 16 * NSEC_PER_MSEC;
> +       q->pi2.alpha =3D dualpi2_scale_alpha_beta(41);    /* ~0.16 Hz * 2=
56 */
> +       q->pi2.beta =3D dualpi2_scale_alpha_beta(819);    /* ~3.20 Hz * 2=
56 */
> +
> +       q->step.thresh =3D 1 * NSEC_PER_MSEC;
> +       q->step.in_packets =3D false;
> +
> +       dualpi2_calculate_c_protection(q->sch, q, 10);  /* wc=3D10%, wl=
=3D90% */
> +
> +       q->ecn_mask =3D INET_ECN_ECT_1;
> +       q->coupling_factor =3D 2;         /* window fairness for equal RT=
Ts */
> +       q->drop_overload =3D true;        /* Preserve latency by dropping=
 */
> +       q->drop_early =3D false;          /* PI2 drops on dequeue */
> +       q->split_gso =3D true;
> +}
> +
> +static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
> +                       struct netlink_ext_ack *extack)
> +{
> +       struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> +       int err;
> +
> +       q->l_queue =3D qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops=
,
> +                                      TC_H_MAKE(sch->handle, 1), extack)=
;
> +       if (!q->l_queue)
> +               return -ENOMEM;
> +
> +       err =3D tcf_block_get(&q->tcf.block, &q->tcf.filters, sch, extack=
);
> +       if (err)
> +               return err;
> +
> +       q->sch =3D sch;
> +       dualpi2_reset_default(q);
> +       hrtimer_init(&q->pi2.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PIN=
NED);
> +       q->pi2.timer.function =3D dualpi2_timer;
> +
> +       if (opt) {
> +               err =3D dualpi2_change(sch, opt, extack);
> +
> +               if (err)
> +                       return err;
> +       }
> +
> +       hrtimer_start(&q->pi2.timer, next_pi2_timeout(q),
> +                     HRTIMER_MODE_ABS_PINNED);
> +       return 0;
> +}
> +
> +static u32 convert_ns_to_usec(u64 ns)
> +{
> +       do_div(ns, NSEC_PER_USEC);
> +       return ns;
> +}
> +
> +static int dualpi2_dump(struct Qdisc *sch, struct sk_buff *skb)
> +{
> +       struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> +       struct nlattr *opts;
> +
> +       opts =3D nla_nest_start_noflag(skb, TCA_OPTIONS);
> +       if (!opts)
> +               goto nla_put_failure;
> +
> +       if (nla_put_u32(skb, TCA_DUALPI2_LIMIT, sch->limit) ||
> +           nla_put_u32(skb, TCA_DUALPI2_TARGET,
> +                       convert_ns_to_usec(q->pi2.target)) ||
> +           nla_put_u32(skb, TCA_DUALPI2_TUPDATE,
> +                       convert_ns_to_usec(q->pi2.tupdate)) ||
> +           nla_put_u32(skb, TCA_DUALPI2_ALPHA,
> +                       dualpi2_unscale_alpha_beta(q->pi2.alpha)) ||
> +           nla_put_u32(skb, TCA_DUALPI2_BETA,
> +                       dualpi2_unscale_alpha_beta(q->pi2.beta)) ||
> +           nla_put_u32(skb, TCA_DUALPI2_STEP_THRESH, q->step.in_packets =
?
> +                       q->step.thresh : convert_ns_to_usec(q->step.thres=
h)) ||
> +           nla_put_u8(skb, TCA_DUALPI2_COUPLING, q->coupling_factor) ||
> +           nla_put_u8(skb, TCA_DUALPI2_DROP_OVERLOAD, q->drop_overload) =
||
> +           nla_put_u8(skb, TCA_DUALPI2_STEP_PACKETS, q->step.in_packets)=
 ||
> +           nla_put_u8(skb, TCA_DUALPI2_DROP_EARLY, q->drop_early) ||
> +           nla_put_u8(skb, TCA_DUALPI2_C_PROTECTION, q->c_protection.wc)=
 ||
> +           nla_put_u8(skb, TCA_DUALPI2_ECN_MASK, q->ecn_mask) ||
> +           nla_put_u8(skb, TCA_DUALPI2_SPLIT_GSO, q->split_gso))
> +               goto nla_put_failure;
> +
> +       return nla_nest_end(skb, opts);
> +
> +nla_put_failure:
> +       nla_nest_cancel(skb, opts);
> +       return -1;
> +}
> +
> +static int dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
> +{
> +       struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> +       struct tc_dualpi2_xstats st =3D {
> +               .prob           =3D READ_ONCE(q->pi2.prob),
> +               .packets_in_c   =3D q->packets_in_c,
> +               .packets_in_l   =3D q->packets_in_l,
> +               .maxq           =3D q->maxq,
> +               .ecn_mark       =3D q->ecn_mark,
> +               .credit         =3D q->c_protection.credit,
> +               .step_marks     =3D q->step_marks,
> +       };
> +       u64 qc, ql;
> +
> +       get_queue_delays(q, &qc, &ql);
> +       st.delay_l =3D convert_ns_to_usec(ql);
> +       st.delay_c =3D convert_ns_to_usec(qc);
> +       return gnet_stats_copy_app(d, &st, sizeof(st));
> +}
> +
> +static void dualpi2_reset(struct Qdisc *sch)
> +{
> +       struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> +
> +       qdisc_reset_queue(sch);
> +       qdisc_reset_queue(q->l_queue);
> +       q->c_head_ts =3D 0;
> +       q->l_head_ts =3D 0;
> +       q->pi2.prob =3D 0;
> +       q->packets_in_c =3D 0;
> +       q->packets_in_l =3D 0;
> +       q->maxq =3D 0;
> +       q->ecn_mark =3D 0;
> +       q->step_marks =3D 0;
> +       dualpi2_reset_c_protection(q);
> +}
> +
> +static void dualpi2_destroy(struct Qdisc *sch)
> +{
> +       struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> +
> +       q->pi2.tupdate =3D 0;
> +       hrtimer_cancel(&q->pi2.timer);
> +       if (q->l_queue)
> +               qdisc_put(q->l_queue);
> +       tcf_block_put(q->tcf.block);
> +}
> +
> +static struct Qdisc *dualpi2_leaf(struct Qdisc *sch, unsigned long arg)
> +{
> +       return NULL;
> +}
> +
> +static unsigned long dualpi2_find(struct Qdisc *sch, u32 classid)
> +{
> +       return 0;
> +}
> +
> +static unsigned long dualpi2_bind(struct Qdisc *sch, unsigned long paren=
t,
> +                                 u32 classid)
> +{
> +       return 0;
> +}
> +
> +static void dualpi2_unbind(struct Qdisc *q, unsigned long cl)
> +{
> +}
> +
> +static struct tcf_block *dualpi2_tcf_block(struct Qdisc *sch, unsigned l=
ong cl,
> +                                          struct netlink_ext_ack *extack=
)
> +{
> +       struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> +
> +       if (cl)
> +               return NULL;
> +       return q->tcf.block;
> +}
> +
> +static void dualpi2_walk(struct Qdisc *sch, struct qdisc_walker *arg)
> +{
> +       unsigned int i;
> +
> +       if (arg->stop)
> +               return;
> +
> +       /* We statically define only 2 queues */
> +       for (i =3D 0; i < 2; i++) {
> +               if (arg->count < arg->skip) {
> +                       arg->count++;
> +                       continue;
> +               }
> +               if (arg->fn(sch, i + 1, arg) < 0) {
> +                       arg->stop =3D 1;
> +                       break;
> +               }
> +               arg->count++;
> +       }
> +}
> +
> +/* Minimal class support to handler tc filters */
> +static const struct Qdisc_class_ops dualpi2_class_ops =3D {
> +       .leaf           =3D dualpi2_leaf,
> +       .find           =3D dualpi2_find,
> +       .tcf_block      =3D dualpi2_tcf_block,
> +       .bind_tcf       =3D dualpi2_bind,
> +       .unbind_tcf     =3D dualpi2_unbind,
> +       .walk           =3D dualpi2_walk,
> +};
> +
> +static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly =3D {
> +       .id             =3D "dualpi2",
> +       .cl_ops         =3D &dualpi2_class_ops,
> +       .priv_size      =3D sizeof(struct dualpi2_sched_data),
> +       .enqueue        =3D dualpi2_qdisc_enqueue,
> +       .dequeue        =3D dualpi2_qdisc_dequeue,
> +       .peek           =3D qdisc_peek_dequeued,
> +       .init           =3D dualpi2_init,
> +       .destroy        =3D dualpi2_destroy,
> +       .reset          =3D dualpi2_reset,
> +       .change         =3D dualpi2_change,
> +       .dump           =3D dualpi2_dump,
> +       .dump_stats     =3D dualpi2_dump_stats,
> +       .owner          =3D THIS_MODULE,
> +};
> +
> +static int __init dualpi2_module_init(void)
> +{
> +       return register_qdisc(&dualpi2_qdisc_ops);
> +}
> +
> +static void __exit dualpi2_module_exit(void)
> +{
> +       unregister_qdisc(&dualpi2_qdisc_ops);
> +}
> +
> +module_init(dualpi2_module_init);
> +module_exit(dualpi2_module_exit);
> +
> +MODULE_DESCRIPTION("Dual Queue with Proportional Integral controller Imp=
roved with a Square (dualpi2) scheduler");
> +MODULE_AUTHOR("Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>")=
;
> +MODULE_AUTHOR("Olga Albisser <olga@albisser.org>");
> +MODULE_AUTHOR("Henrik Steen <henrist@henrist.net>");
> +MODULE_AUTHOR("Olivier Tilmans <olivier.tilmans@nokia.com>");
> +MODULE_AUTHOR("Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>");
> +
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0");
> --
> 2.34.1
>
>

