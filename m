Return-Path: <netdev+bounces-87812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328EB8A4B5A
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECA528227B
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA22C848;
	Mon, 15 Apr 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFVO3yAi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6191D3F9C6
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713172845; cv=none; b=O4cJNwrUF5xFku+1JBs6xZ30hmlbsf+1tsD2I+LehdIJMHsMwuG8wL4NAtyciVkaWpQpk7SHAoST7Pm4ToStIlWirRRyunW7p26mjd3iFGo+R++FVcm2xk05bNklFW9G+eAlO9xBn2VG4E/FZTHXIVqePXiDaCOeQulao4Vvopo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713172845; c=relaxed/simple;
	bh=l8OTsp0Dy62b96+30MweQBT8JvBVGhCzlYsMtV2YkdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9OTA/QK1fHb5g5EJyGALWWvPkqawJxXuCo3R0cV+tgSckYTt61XnpaZ6n7Sr7e0LtkpBv1ZOLW5lSIIn6J5WwvOcJamcLGdCs+MqlTgnaw13HyfFPph00fuG0X4FVz4TeR5Db0hofvhSU1hTF+nrhY1ugDxsEQV6v6dvZlnkG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFVO3yAi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so9523a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 02:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713172842; x=1713777642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsUyZEXiWh1rFVKwNLikC9i3Ma74BNE1a98CIdVv/xA=;
        b=EFVO3yAik7a/c3FRHkau5MlNcxQQ92D4Ab9Ymqs4XmJRxiZgfvm+HRs/ybwikEN4gQ
         GaDzqFsfto7hdZ0ICaDJ/Adb+Qjr0DQXjUtJEeZ6519xe/BcXv4q381wq+jONbAEHjxO
         yR2qIRAh3gRDvNIjOib/orkZXt4Bqd9wFZR2tOflxkIYZg0c8jPpPi6e/2hOgLRJkyKf
         YzwU4gsgpuff3BgHNXNbTldV0eNCxtBPWcB5v80ytHhRBwUKCJwcINiRoSxmyERma0/8
         D1f5w9A/KMwQsj9DHrPgkHBhBhGmKr5dOuOIS7EO/hwzcrtinkY3jmswHHUa68Miri7T
         zMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713172842; x=1713777642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsUyZEXiWh1rFVKwNLikC9i3Ma74BNE1a98CIdVv/xA=;
        b=cQQkkYIBhA+CHPNlgieCwbcJuIBK6oHGPhOPczztatOGVSf/tqyUdQqaDw4yihhAEZ
         89uN3btmBIou41YJbbSltgSJcjT9LeahiLBwryTQQmpuYJJQFopktm3DmIjHizAT5HmO
         BDs1hgU8b7d8ZpX5ttReMOys1abJ2hgiGqhYCH+o4W/mUSca/xuODpYgp4kPM8G+BAWy
         UCwcYPvSOhhlvwQbRRnNmfZsIlLgOVay1M8S+LlIK/GrDLxqrP/0izI9sqKkMEIm+0h6
         HNYYe1EoywqiHAilKWPoioM5LUPDytUI841bd6c4iWkhRTlDaROhas1Aq7PbnFBFYMMG
         65xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxLyPJoxXef+T5zHMSrG11urESetHko3PvWWw9djmm/m03VB+aXrRBdlh3BwE0LV0boyFgJrVP1BztH79fp+LRgSOcyisa
X-Gm-Message-State: AOJu0Yyo4ZVPX4k3hPeH5mvjQRdZCS4PsJRwfO30egzQlJv/MTRV3OSX
	p7D88ICkO/SzZTDoTJ+jSXv4nY1v+ttBCTmKsEQO/Xa6k2a/k+8ctTDpWEIl0RvqPBW1pYPfwi2
	ueuUMWczJ9OltVBv+X8rZUX4BGAXuUgXKbbVX
X-Google-Smtp-Source: AGHT+IGBUBjzbsUUYDdvQPBSjCNEb9tGUDKVIu3+5kuCmTd40QThjmJiEjE1fw0fzsckH0NnQJO3L+xG69f6gz3hRT4=
X-Received: by 2002:a05:6402:5243:b0:570:2cb5:af32 with SMTP id
 t3-20020a056402524300b005702cb5af32mr88917edd.5.1713172841435; Mon, 15 Apr
 2024 02:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326230319.190117-1-jhs@mojatatu.com> <CANn89iLhd4iD-pDVJHzKqWbf16u9KyNtgV41X3sd=iy15jDQtQ@mail.gmail.com>
 <CAM0EoMmQHsucU6n1O3XEd50zUB4TENkEH0+J-cZ=5Bbv9298mA@mail.gmail.com>
 <CANn89iKaMKeY7pR7=RH1NMBpYiYFmBRfAWmbZ61PdJ2VYoUJ9g@mail.gmail.com>
 <CAM0EoM=s_MvUa32kUyt=VfeiAwxOm2OUJ3H=i0ARO1xupM2_Xg@mail.gmail.com> <CAM0EoMk33ga5dh12ViZz8QeFwjwNQBvykM53VQo1B3BdfAZtaQ@mail.gmail.com>
In-Reply-To: <CAM0EoMk33ga5dh12ViZz8QeFwjwNQBvykM53VQo1B3BdfAZtaQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Apr 2024 11:20:27 +0200
Message-ID: <CANn89iLmhaC8fuu4UpPdELOAapBzLv0+S50gr0Rs+J+=4+9j=g@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 10:30=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Tue, Apr 2, 2024 at 1:35=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> > On Tue, Apr 2, 2024 at 12:47=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 11:58=E2=80=AFPM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > > >
> > > > On Wed, Mar 27, 2024 at 9:23=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Wed, Mar 27, 2024 at 12:03=E2=80=AFAM Jamal Hadi Salim <jhs@mo=
jatatu.com> wrote:
> > > > > >
> > > > > > When the mirred action is used on a classful egress qdisc and a=
 packet is
> > > > > > mirrored or redirected to self we hit a qdisc lock deadlock.
> > > > > > See trace below.
> > > > > >
> > > > > > [..... other info removed for brevity....]
> > > > > > [   82.890906]
> > > > > > [   82.890906] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > > > [   82.890906] WARNING: possible recursive locking detected
> > > > > > [   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: G =
       W
> > > > > > [   82.890906] --------------------------------------------
> > > > > > [   82.890906] ping/418 is trying to acquire lock:
> > > > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > > > > > __dev_queue_xmit+0x1778/0x3550
> > > > > > [   82.890906]
> > > > > > [   82.890906] but task is already holding lock:
> > > > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > > > > > __dev_queue_xmit+0x1778/0x3550
> > > > > > [   82.890906]
> > > > > > [   82.890906] other info that might help us debug this:
> > > > > > [   82.890906]  Possible unsafe locking scenario:
> > > > > > [   82.890906]
> > > > > > [   82.890906]        CPU0
> > > > > > [   82.890906]        ----
> > > > > > [   82.890906]   lock(&sch->q.lock);
> > > > > > [   82.890906]   lock(&sch->q.lock);
> > > > > > [   82.890906]
> > > > > > [   82.890906]  *** DEADLOCK ***
> > > > > > [   82.890906]
> > > > > > [..... other info removed for brevity....]
> > > > > >
> > > > > > Example setup (eth0->eth0) to recreate
> > > > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> > > > > >      action mirred egress redirect dev eth0
> > > > > >
> > > > > > Another example(eth0->eth1->eth0) to recreate
> > > > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> > > > > >      action mirred egress redirect dev eth1
> > > > > >
> > > > > > tc qdisc add dev eth1 root handle 1: htb default 30
> > > > > > tc filter add dev eth1 handle 1: protocol ip prio 2 matchall \
> > > > > >      action mirred egress redirect dev eth0
> > > > > >
> > > > > > We fix this by adding a per-cpu, per-qdisc recursion counter wh=
ich is
> > > > > > incremented the first time a root qdisc is entered and on a sec=
ond attempt
> > > > > > enter the same root qdisc from the top, the packet is dropped t=
o break the
> > > > > > loop.
> > > > > >
> > > > > > Reported-by: renmingshuai@huawei.com
> > > > > > Closes: https://lore.kernel.org/netdev/20240314111713.5979-1-re=
nmingshuai@huawei.com/
> > > > > > Fixes: 3bcb846ca4cf ("net: get rid of spin_trylock() in net_tx_=
action()")
> > > > > > Fixes: e578d9c02587 ("net: sched: use counter to break reclassi=
fy loops")
> > > > > > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > > ---
> > > > > >  include/net/sch_generic.h |  2 ++
> > > > > >  net/core/dev.c            |  9 +++++++++
> > > > > >  net/sched/sch_api.c       | 12 ++++++++++++
> > > > > >  net/sched/sch_generic.c   |  2 ++
> > > > > >  4 files changed, 25 insertions(+)
> > > > > >
> > > > > > diff --git a/include/net/sch_generic.h b/include/net/sch_generi=
c.h
> > > > > > index cefe0c4bdae3..f9f99df037ed 100644
> > > > > > --- a/include/net/sch_generic.h
> > > > > > +++ b/include/net/sch_generic.h
> > > > > > @@ -125,6 +125,8 @@ struct Qdisc {
> > > > > >         spinlock_t              busylock ____cacheline_aligned_=
in_smp;
> > > > > >         spinlock_t              seqlock;
> > > > > >
> > > > > > +       u16 __percpu            *xmit_recursion;
> > > > > > +
> > > > > >         struct rcu_head         rcu;
> > > > > >         netdevice_tracker       dev_tracker;
> > > > > >         /* private data */
> > > > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > > > index 9a67003e49db..2b712388c06f 100644
> > > > > > --- a/net/core/dev.c
> > > > > > +++ b/net/core/dev.c
> > > > > > @@ -3789,6 +3789,13 @@ static inline int __dev_xmit_skb(struct =
sk_buff *skb, struct Qdisc *q,
> > > > > >         if (unlikely(contended))
> > > > > >                 spin_lock(&q->busylock);
> > > > >
> > > > > This could hang here (busylock)
> > > >
> > > > Notice the goto free_skb_list has an spin_unlock(&q->busylock);  in
> > > > its code vicinity. Am I missing something?
> > >
> > > The hang would happen in above spin_lock(&q->busylock), before you ca=
n
> > > get a chance...
> > >
> > > If you want to test your patch, add this debugging feature, pretendin=
g
> > > the spinlock is contended.
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 818699dea9d7040ee74532ccdebf01c4fd6887cc..b2fe3aa2716f0fe128ef1=
0f9d06c2431b3246933
> > > 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -3816,7 +3816,7 @@ static inline int __dev_xmit_skb(struct sk_buff
> > > *skb, struct Qdisc *q,
> > >          * sent after the qdisc owner is scheduled again. To prevent =
this
> > >          * scenario the task always serialize on the lock.
> > >          */
> > > -       contended =3D qdisc_is_running(q) || IS_ENABLED(CONFIG_PREEMP=
T_RT);
> > > +       contended =3D true; // DEBUG for Jamal
> > >         if (unlikely(contended))
> > >                 spin_lock(&q->busylock);
> >
> > Will do.
>
> Finally got time to look again. Probably being too clever, but moving
> the check before the contended check resolves it as well. The only
> strange thing is now with the latest net-next seems to be spitting
> some false positive lockdep splat for the test of A->B->A (i am sure
> it's fixable).
>
> See attached. Didnt try the other idea, see if you like this one.

A spinlock can only be held by one cpu at a time, so recording the cpu
number of the lock owner should be
enough to avoid a deadlock.

So I really do not understand your push for a per-cpu variable with
extra cache line misses.

I think the following would work just fine ? What do you think ?

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 76db6be1608315102495dd6372fc30e6c9d41a99..dcd92ed7f69fae00deaca2c88fe=
d248a559108ea
100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -117,6 +117,7 @@ struct Qdisc {
        struct qdisc_skb_head   q;
        struct gnet_stats_basic_sync bstats;
        struct gnet_stats_queue qstats;
+       int                     owner;
        unsigned long           state;
        unsigned long           state2; /* must be written under qdisc
spinlock */
        struct Qdisc            *next_sched;
diff --git a/net/core/dev.c b/net/core/dev.c
index 854a3a28a8d85b335a9158378ae0cca6dfbf8b36..d77cac53df4b4af478548dd17e7=
a3a7cfe4bd792
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3808,6 +3808,11 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
                return rc;
        }

+       if (unlikely(READ_ONCE(q->owner) =3D=3D smp_processor_id())) {
+               /* add a specific drop_reason later in net-next */
+               kfree_skb_reason(skb, SKB_DROP_REASON_TC_RECLASSIFY_LOOP);
+               return NET_XMIT_DROP;
+       }
        /*
         * Heuristic to force contended enqueues to serialize on a
         * separate lock before trying to get qdisc main lock.
@@ -3847,7 +3852,9 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
                qdisc_run_end(q);
                rc =3D NET_XMIT_SUCCESS;
        } else {
+               WRITE_ONCE(q->owner, smp_processor_id());
                rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
+               WRITE_ONCE(q->owner, -1);
                if (qdisc_run_begin(q)) {
                        if (unlikely(contended)) {
                                spin_unlock(&q->busylock);

