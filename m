Return-Path: <netdev+bounces-82685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1803688F252
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 23:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE1329E906
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 22:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5E3154C0F;
	Wed, 27 Mar 2024 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QqhpbnV0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F41154C1D
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580285; cv=none; b=eAy+Arzm+0j+Ev0oJc70GAqJFT9SLvggj8W7CKPXx/FohNm4pA3FpB7vRSI9DlDOicX0ZLe/vCPeXWhNNLVERi4pRH3b6J3ddu0haxbPvqTQqPYY0lf16Rho2eqg8g0u3SjviS+ODi4o547TpiINv2Jyl4SbVvAtLnSkM+jMb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580285; c=relaxed/simple;
	bh=rzqHDCMAIurGe+zYBXPD+qXou3xIRL/Yt4ZidjR+21I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/5CiE9eqUEcb3Q7XsjO1roKjOmZyvobme+8npss1GY8DUdS7fNAtfTCbaUT0xZfi1IRA7OKdikmOwVbgyHiUGaQGU/rSqWgPTm25TfLeDjjHr5rFZ1+x8QY+igCnP7nZ6S7f4OtFNc9/YvzdPLQoctDKrGnosISHY9zTgRHkj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QqhpbnV0; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso271959276.2
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 15:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1711580281; x=1712185081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L06hZQbd1t4F+V9/19kSM3T7Uq+hBtu2GFKmKAXV6bA=;
        b=QqhpbnV0XKsPf4VrCfcZUTMG+HbFFWdMYX18a96qWKvrXWuShs1/T3qgwuuXzGq5eS
         5aV1vsmFk5Jv9hh1lvJKrfhUU2l8juX/q7DS0L4VzQKVbwfs6T5mljLscEzRb2y5/z5H
         Ai9iCPB2DrXBnaa98Et+NMPMs1r1QQdjQctcwfmO1zw4vDEShGKKLA6Rsf7m4H+ynepN
         i7s3XZ7BSKftKeaSPqhn0567KbIVsevwwxXAupTsAT6b7eUo30XmrFT2h+C3bvyHD27f
         fSZrXr1WCVqtE/RgoulgXfi2MpnNkkhQap+8t9ZAjGGhtEfkUUC0xKY5KnZTbMOSa68U
         qcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711580281; x=1712185081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L06hZQbd1t4F+V9/19kSM3T7Uq+hBtu2GFKmKAXV6bA=;
        b=LbIo8bWAZB7mBcyofxLB7SNestjm4pGU7QH1XSO+CV5OtgQVREX5RfLUvDJ5dwtD6P
         6PxxDTpquEb+actVaOioU5fxEWPAdePFLNBCxlLDKkvfZeMMV9GxlFLzBvDWhwzF/Ir0
         EG0cxn/+5e2Doz4kuzxnkp29F3PsLu4ebXbSp1XhZsu3MC4k+4YImj1EU+/+GmvXr0rH
         lr6J3oJuoQNeGOo8ecQH795QjnZt5NWnAjU6/b5TRRixZoOft7qEPlA4YFNAvXqPFlpc
         JzrNQk+xr9kTsRU/UA6IWUWkR3ygdG0wFd73RDBY95WYQmKzTYhESADBQWfpX5hPzOCe
         6dNw==
X-Forwarded-Encrypted: i=1; AJvYcCU8nHIop+5cVbnj6DG9JUDy1YUCqVG1F2nj3ITL5UPkmD0R6uDTPXOnNm8WO25ARpvEcWz7aTHeyqm32KfhD1vr8qpBBMbc
X-Gm-Message-State: AOJu0YzgS2wJjN8BosBh6n5LzhqgQ0W7PaAhiRp0SwcnKXLuBO6Ht7Yy
	L9POOYTrb+1UaPsmwGKveb9fQtlgYdkcKfRAfsjKmbogMa+bD39XbqbTmSlESP0SpthlbkfacIc
	WbiUVGLkzsAr9ZTd5qpkhg85zcDQQgPr3VSa+
X-Google-Smtp-Source: AGHT+IHxRiQ+qAXxum31FGovUZfdkQFp33etXXoFe6R+oq8JKBGieEv7bCtKr/1ws0KoM3qVoQ6cGIukIJNZKHD/e0k=
X-Received: by 2002:a25:cd07:0:b0:dc2:1dd0:1d1b with SMTP id
 d7-20020a25cd07000000b00dc21dd01d1bmr1323483ybf.19.1711580280625; Wed, 27 Mar
 2024 15:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326230319.190117-1-jhs@mojatatu.com> <CANn89iLhd4iD-pDVJHzKqWbf16u9KyNtgV41X3sd=iy15jDQtQ@mail.gmail.com>
In-Reply-To: <CANn89iLhd4iD-pDVJHzKqWbf16u9KyNtgV41X3sd=iy15jDQtQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 27 Mar 2024 18:57:49 -0400
Message-ID: <CAM0EoMmQHsucU6n1O3XEd50zUB4TENkEH0+J-cZ=5Bbv9298mA@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 9:23=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Mar 27, 2024 at 12:03=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > When the mirred action is used on a classful egress qdisc and a packet =
is
> > mirrored or redirected to self we hit a qdisc lock deadlock.
> > See trace below.
> >
> > [..... other info removed for brevity....]
> > [   82.890906]
> > [   82.890906] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > [   82.890906] WARNING: possible recursive locking detected
> > [   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: G        W
> > [   82.890906] --------------------------------------------
> > [   82.890906] ping/418 is trying to acquire lock:
> > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > __dev_queue_xmit+0x1778/0x3550
> > [   82.890906]
> > [   82.890906] but task is already holding lock:
> > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > __dev_queue_xmit+0x1778/0x3550
> > [   82.890906]
> > [   82.890906] other info that might help us debug this:
> > [   82.890906]  Possible unsafe locking scenario:
> > [   82.890906]
> > [   82.890906]        CPU0
> > [   82.890906]        ----
> > [   82.890906]   lock(&sch->q.lock);
> > [   82.890906]   lock(&sch->q.lock);
> > [   82.890906]
> > [   82.890906]  *** DEADLOCK ***
> > [   82.890906]
> > [..... other info removed for brevity....]
> >
> > Example setup (eth0->eth0) to recreate
> > tc qdisc add dev eth0 root handle 1: htb default 30
> > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> >      action mirred egress redirect dev eth0
> >
> > Another example(eth0->eth1->eth0) to recreate
> > tc qdisc add dev eth0 root handle 1: htb default 30
> > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> >      action mirred egress redirect dev eth1
> >
> > tc qdisc add dev eth1 root handle 1: htb default 30
> > tc filter add dev eth1 handle 1: protocol ip prio 2 matchall \
> >      action mirred egress redirect dev eth0
> >
> > We fix this by adding a per-cpu, per-qdisc recursion counter which is
> > incremented the first time a root qdisc is entered and on a second atte=
mpt
> > enter the same root qdisc from the top, the packet is dropped to break =
the
> > loop.
> >
> > Reported-by: renmingshuai@huawei.com
> > Closes: https://lore.kernel.org/netdev/20240314111713.5979-1-renmingshu=
ai@huawei.com/
> > Fixes: 3bcb846ca4cf ("net: get rid of spin_trylock() in net_tx_action()=
")
> > Fixes: e578d9c02587 ("net: sched: use counter to break reclassify loops=
")
> > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  include/net/sch_generic.h |  2 ++
> >  net/core/dev.c            |  9 +++++++++
> >  net/sched/sch_api.c       | 12 ++++++++++++
> >  net/sched/sch_generic.c   |  2 ++
> >  4 files changed, 25 insertions(+)
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index cefe0c4bdae3..f9f99df037ed 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -125,6 +125,8 @@ struct Qdisc {
> >         spinlock_t              busylock ____cacheline_aligned_in_smp;
> >         spinlock_t              seqlock;
> >
> > +       u16 __percpu            *xmit_recursion;
> > +
> >         struct rcu_head         rcu;
> >         netdevice_tracker       dev_tracker;
> >         /* private data */
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 9a67003e49db..2b712388c06f 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3789,6 +3789,13 @@ static inline int __dev_xmit_skb(struct sk_buff =
*skb, struct Qdisc *q,
> >         if (unlikely(contended))
> >                 spin_lock(&q->busylock);
>
> This could hang here (busylock)

Notice the goto free_skb_list has an spin_unlock(&q->busylock);  in
its code vicinity. Am I missing something?

>
> >
> > +       if (__this_cpu_read(*q->xmit_recursion) > 0) {
> > +               __qdisc_drop(skb, &to_free);
> > +               rc =3D NET_XMIT_DROP;
> > +               goto free_skb_list;
> > +       }
>
>
> I do not think we want to add yet another cache line miss and
> complexity in tx fast path.
>

I empathize. The cache miss is due to a per-cpu variable? Otherwise
that seems to be in the vicinity of the other fields being accessed in
__dev_xmit_skb()

> I think that mirred should  use a separate queue to kick a transmit
> from the top level.
>
> (Like netif_rx() does)
>

Eric, here's my concern: this would entail restructuring mirred
totally just to cater for one use case which is in itself _a bad
config_ for egress qdisc case only. Mirred is very heavily used in
many use cases and changing its behavior could likely introduce other
corner cases for some use cases which we would be chasing for a while.
Not to forget now we have to go via an extra transient queue.
If i understood what you are suggesting is to add an equivalent of
backlog queu for the tx side? I am assuming in a very similar nature
to backlog, meaning per cpu fired by softirq? or is it something
closer to qdisc->gso_skb
For either of those cases, the amount of infrastructure code there is
not a few lines of code. And then there's the desire to break the loop
etc.

Some questions regarding your proposal - something I am not following
And i may have misunderstood what you are suggesting, but i am missing
what scenario mirred can directly call tcf_dev_queue_xmit() (see my
comment below)..

> Using a softnet.xmit_qdisc_recursion (not a qdisc-per-cpu thing),
> would allow mirred to bypass this additional queue
> in most cases.
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index cb37817d6382c29117afd8ce54db6dba94f8c930..62ba5ef554860496ee928f7ed=
6b7c3ea46b8ee1d
> 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3217,7 +3217,8 @@ struct softnet_data {
>  #endif
>         /* written and read only by owning cpu: */
>         struct {
> -               u16 recursion;
> +               u8 recursion;
> +               u8 qdisc_recursion;
>                 u8  more;
>  #ifdef CONFIG_NET_EGRESS
>                 u8  skip_txqueue;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9a67003e49db87f3f92b6c6296b3e7a5ca9d9171..7ac59835edef657e9558d4d4f=
c0a76b171aace93
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4298,7 +4298,9 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
> net_device *sb_dev)
>
>         trace_net_dev_queue(skb);
>         if (q->enqueue) {
> +               __this_cpu_inc(softnet_data.xmit.qdisc_recursion);

This increments the count by 1..

>                 rc =3D __dev_xmit_skb(skb, q, dev, txq);
> +               __this_cpu_dec(softnet_data.xmit.qdisc_recursion);
>                 goto out;
>         }
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 5b38143659249e66718348e0ec4ed3c7bc21c13d..0f5f02e6744397d33ae2a7267=
0ba7131aaa6942e
> 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -237,8 +237,13 @@ tcf_mirred_forward(bool at_ingress, bool
> want_ingress, struct sk_buff *skb)
>  {
>         int err;
>
> -       if (!want_ingress)
> -               err =3D tcf_dev_queue_xmit(skb, dev_queue_xmit);
> +       if (!want_ingress) {
> +               if (__this_cpu_read(softnet_data.xmit.qdisc_recursion)) {

Where does the defered
So this will always be 1 assuming the defer queue will have to be
something like a workqueue

> +                       // Queue to top level, or drop
> +               } else {

and we'll never enter this..

> +                       err =3D tcf_dev_queue_xmit(skb, dev_queue_xmit);
> +               }
> +       }
>         else if (!at_ingress)
>                 err =3D netif_rx(skb);
>         else

cheers,
jamal

