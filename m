Return-Path: <netdev+bounces-84113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0440895A37
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 18:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 866EBB292F3
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B0159912;
	Tue,  2 Apr 2024 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hNP9bvC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57D159913
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076477; cv=none; b=lJ/3APBVaBU2CgZubHP1Y66SkJgXd8HFOapt0J6Cx6sjtp4sdDu5Jk2uPRvd8UpdD1dF/Wg9tFSFV5XPgSieHVh+wmUo+r6sNlLSclCG6fr3vUIg++EmCyeSceLzxzwnSr8mq9R8BTaJfLZ3kCZLhYGtfcxlRSZeeDH14CtFu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076477; c=relaxed/simple;
	bh=9dD5gyxbjgbv8W74i2HvlUVvwUGYhEwyMO+cu+/Luw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsS7Rrx2QiQGJetp0TxOCBlSlORuJNNfNupDhF5hkPuU+dyUVATiqmCf8L39W/P0l+EtCAI7spiGUZFIKBOs6z6RP5cYOckgkNhYrXzo4Xh+rjycvF0hs4d3L3OIY9fSxeIh04dn5J4xLcjC2imP4ZdN3KLZcMxTFQaZPP7D1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hNP9bvC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so125a12.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712076474; x=1712681274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgvyxt1pOdmwSKOj/z40UkLqWrUIewEo0riNXRWhfEc=;
        b=3hNP9bvCKuc0IqAP1oIYQS7WiuCmxDSeb+TVP/7t/wjp2e1IrAyp2WuXnk+wV1DY2j
         TFAll4wz4Hz/jnpaO43IOyAv6nd5JU7N0lJNefRF/n52+zhO4D5JactBhf+y+Zswh/a4
         aNfbA8Ch+IR1dctJi4/Xc8viqSgXnYdzWFeouuB3kOeCSfFe1lnCmjpS1CQt4P1Cz/iC
         /C2XXbIcccnW0eolrbcJnwRhvBK2hB80lQv8wnpvitanAwOkLd3KFhg5m3bkN8y2vY2s
         cGw4/sT6QJIQf0v5WbcyjIzfaHXU9BmOsetn4V/27cGg8bKIlGNPaG86f3aeRZnkb51n
         +khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076474; x=1712681274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgvyxt1pOdmwSKOj/z40UkLqWrUIewEo0riNXRWhfEc=;
        b=w9ayaxqLrVf3AL62dW+F3VBt48u44hZ5d18Vy6P6l3YT+rtiCh5cUBnxIDJ5Gt5Hdc
         gU/QO+bAo7TAJIc0tBSQmMQjrjywSAYajVhB+haC+ydjhQn/9NVfLqDv77GZIowdALNg
         hiiTbKFYH8t0pN3FbQfH+7W2lZz4xCXkZZ9cTGt1d8t93bdP8aTj3PHYCyGoQcXwGiH6
         Z9VgGG6FBIDImlvbk/m/SHCZ6PK6cKEbIcrQtum7QrEVnRKiifbKzib+vF3apTiaLKt6
         UK0a+oRwo/AYtSFKNIEBeHgQ32o+g5O2vCP+d5zCsw4i1eO4z0ueCDxP0PSr+u6xQEoI
         hsFg==
X-Forwarded-Encrypted: i=1; AJvYcCVyO/A9vdS/5DGrNL1FyqIAL9uXlkBwMskLfMguxME0o/GBwcMaKzxozmFj/2creERwa2zxulC3T4jkGglllNPW+0ncgZTO
X-Gm-Message-State: AOJu0Yw+nJTB3C+ZYA52SXT/p1pqw6bRRFaje7bBw2diZD/s8CGAsKdH
	HRC+79m2hV8Vjf/FJZOEyZhqzSU7VGXtXd2wb4coSPx8HRD2lYPwFkjAnuqQFrNFldMfnoePmc+
	auZNjONuKjUakepCpqBgAg9MOs+I4veCOWvDO
X-Google-Smtp-Source: AGHT+IHJmBmfgJRsdIXtW6c19AJtRX8UHYOU3Cu+FqYxRm+lg/4cEgqRLa7J5dVjefPDdAAznU+/KLTlPYZqmHCwc0I=
X-Received: by 2002:aa7:dc17:0:b0:56c:303b:f4d4 with SMTP id
 b23-20020aa7dc17000000b0056c303bf4d4mr660967edu.1.1712076473528; Tue, 02 Apr
 2024 09:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326230319.190117-1-jhs@mojatatu.com> <CANn89iLhd4iD-pDVJHzKqWbf16u9KyNtgV41X3sd=iy15jDQtQ@mail.gmail.com>
 <CAM0EoMmQHsucU6n1O3XEd50zUB4TENkEH0+J-cZ=5Bbv9298mA@mail.gmail.com>
In-Reply-To: <CAM0EoMmQHsucU6n1O3XEd50zUB4TENkEH0+J-cZ=5Bbv9298mA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Apr 2024 18:47:42 +0200
Message-ID: <CANn89iKaMKeY7pR7=RH1NMBpYiYFmBRfAWmbZ61PdJ2VYoUJ9g@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 11:58=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Wed, Mar 27, 2024 at 9:23=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Mar 27, 2024 at 12:03=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > When the mirred action is used on a classful egress qdisc and a packe=
t is
> > > mirrored or redirected to self we hit a qdisc lock deadlock.
> > > See trace below.
> > >
> > > [..... other info removed for brevity....]
> > > [   82.890906]
> > > [   82.890906] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > [   82.890906] WARNING: possible recursive locking detected
> > > [   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: G       =
 W
> > > [   82.890906] --------------------------------------------
> > > [   82.890906] ping/418 is trying to acquire lock:
> > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > > __dev_queue_xmit+0x1778/0x3550
> > > [   82.890906]
> > > [   82.890906] but task is already holding lock:
> > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > > __dev_queue_xmit+0x1778/0x3550
> > > [   82.890906]
> > > [   82.890906] other info that might help us debug this:
> > > [   82.890906]  Possible unsafe locking scenario:
> > > [   82.890906]
> > > [   82.890906]        CPU0
> > > [   82.890906]        ----
> > > [   82.890906]   lock(&sch->q.lock);
> > > [   82.890906]   lock(&sch->q.lock);
> > > [   82.890906]
> > > [   82.890906]  *** DEADLOCK ***
> > > [   82.890906]
> > > [..... other info removed for brevity....]
> > >
> > > Example setup (eth0->eth0) to recreate
> > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> > >      action mirred egress redirect dev eth0
> > >
> > > Another example(eth0->eth1->eth0) to recreate
> > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> > >      action mirred egress redirect dev eth1
> > >
> > > tc qdisc add dev eth1 root handle 1: htb default 30
> > > tc filter add dev eth1 handle 1: protocol ip prio 2 matchall \
> > >      action mirred egress redirect dev eth0
> > >
> > > We fix this by adding a per-cpu, per-qdisc recursion counter which is
> > > incremented the first time a root qdisc is entered and on a second at=
tempt
> > > enter the same root qdisc from the top, the packet is dropped to brea=
k the
> > > loop.
> > >
> > > Reported-by: renmingshuai@huawei.com
> > > Closes: https://lore.kernel.org/netdev/20240314111713.5979-1-renmings=
huai@huawei.com/
> > > Fixes: 3bcb846ca4cf ("net: get rid of spin_trylock() in net_tx_action=
()")
> > > Fixes: e578d9c02587 ("net: sched: use counter to break reclassify loo=
ps")
> > > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > >  include/net/sch_generic.h |  2 ++
> > >  net/core/dev.c            |  9 +++++++++
> > >  net/sched/sch_api.c       | 12 ++++++++++++
> > >  net/sched/sch_generic.c   |  2 ++
> > >  4 files changed, 25 insertions(+)
> > >
> > > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > > index cefe0c4bdae3..f9f99df037ed 100644
> > > --- a/include/net/sch_generic.h
> > > +++ b/include/net/sch_generic.h
> > > @@ -125,6 +125,8 @@ struct Qdisc {
> > >         spinlock_t              busylock ____cacheline_aligned_in_smp=
;
> > >         spinlock_t              seqlock;
> > >
> > > +       u16 __percpu            *xmit_recursion;
> > > +
> > >         struct rcu_head         rcu;
> > >         netdevice_tracker       dev_tracker;
> > >         /* private data */
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 9a67003e49db..2b712388c06f 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -3789,6 +3789,13 @@ static inline int __dev_xmit_skb(struct sk_buf=
f *skb, struct Qdisc *q,
> > >         if (unlikely(contended))
> > >                 spin_lock(&q->busylock);
> >
> > This could hang here (busylock)
>
> Notice the goto free_skb_list has an spin_unlock(&q->busylock);  in
> its code vicinity. Am I missing something?

The hang would happen in above spin_lock(&q->busylock), before you can
get a chance...

If you want to test your patch, add this debugging feature, pretending
the spinlock is contended.

diff --git a/net/core/dev.c b/net/core/dev.c
index 818699dea9d7040ee74532ccdebf01c4fd6887cc..b2fe3aa2716f0fe128ef10f9d06=
c2431b3246933
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3816,7 +3816,7 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
         * sent after the qdisc owner is scheduled again. To prevent this
         * scenario the task always serialize on the lock.
         */
-       contended =3D qdisc_is_running(q) || IS_ENABLED(CONFIG_PREEMPT_RT);
+       contended =3D true; // DEBUG for Jamal
        if (unlikely(contended))
                spin_lock(&q->busylock);



>
> >
> > >
> > > +       if (__this_cpu_read(*q->xmit_recursion) > 0) {
> > > +               __qdisc_drop(skb, &to_free);
> > > +               rc =3D NET_XMIT_DROP;
> > > +               goto free_skb_list;
> > > +       }
> >
> >
> > I do not think we want to add yet another cache line miss and
> > complexity in tx fast path.
> >
>
> I empathize. The cache miss is due to a per-cpu variable? Otherwise
> that seems to be in the vicinity of the other fields being accessed in
> __dev_xmit_skb()
>
> > I think that mirred should  use a separate queue to kick a transmit
> > from the top level.
> >
> > (Like netif_rx() does)
> >
>
> Eric, here's my concern: this would entail restructuring mirred
> totally just to cater for one use case which is in itself _a bad
> config_ for egress qdisc case only.

Why can't the bad config be detected in the ctl path ?

 Mirred is very heavily used in
> many use cases and changing its behavior could likely introduce other
> corner cases for some use cases which we would be chasing for a while.
> Not to forget now we have to go via an extra transient queue.
> If i understood what you are suggesting is to add an equivalent of
> backlog queu for the tx side? I am assuming in a very similar nature
> to backlog, meaning per cpu fired by softirq? or is it something
> closer to qdisc->gso_skb
> For either of those cases, the amount of infrastructure code there is
> not a few lines of code. And then there's the desire to break the loop
> etc.
>
> Some questions regarding your proposal - something I am not following
> And i may have misunderstood what you are suggesting, but i am missing
> what scenario mirred can directly call tcf_dev_queue_xmit() (see my
> comment below)..

I wish the act path would run without qdisc spinlock held, and use RCU inst=
ead.

Instead, we are adding cost in fast path only to detect bad configs.

