Return-Path: <netdev+bounces-87997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DBE8A528F
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FD11C22A12
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF07B73530;
	Mon, 15 Apr 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="FSdc9g3O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C6745C2
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189720; cv=none; b=MdmTgv4DWTOxqg49JAtcKTfEZT3BLRGIA8ATZkQflnugio7ZFPwpodg+2zFAVvzu/Okgi4G5BO+yk/TkN6AlARDEB3+WXs3yg+jpjw7QPmc6wRJdBU+6ToHvelcRqydqRaZ+3wywoDn8b48fT2si4T3VipFr//gxb+sNvXswv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189720; c=relaxed/simple;
	bh=Bgac0RDuy+5OD6XxFGBnaKNJfRRdLHG5xNk0Y933sxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DklXzjmH8mS/LcOQJngH0L9+0oi+1+EIfH/kLu3kF5asCeBNSqsEKW66Xqxuh6ExsUh0vG1+I9ZLibw4hQNkrjvo2ETejf5pR80y9kkl2D3k80fF50AhsHQiBeA99jtkF8WhWq+Rm2HQTP+iCImD3zFQUbaaazpRtAVlwqjG+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=FSdc9g3O; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61ab31d63edso13237847b3.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713189715; x=1713794515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeVcetMQDPrHvTLw/jVBM/G2lxBJUfKvfXKAGGviwwI=;
        b=FSdc9g3OmZS/MIIQ97OhxAWpRcpCjvOtlC2Ju5t7Fbg5EfSvlZX12bXi7NYkLw+nnu
         FXRxf2AYQD8uvCpTsDJTuL3F5Pclsgym+yb+MYdBJ/nsl2AYs/dExbvMgf2fOKZ4UbMB
         cv050vIFHxQ9IuZ8aVRdIO6sKloYee3wQm2B8xkFcfVGgXL6SHjmFJXW70xkusSzxYdY
         B5hIbMDggEhnxvbmk2r4oVN1Ss0ohvF7PacC/nrkLjxMaSTHUsuo7P2nmd77/fV1JLKQ
         ZSkqKwrvmNKPv4rm3W0e8PFcx3F0dw1ganovbWYyS9KMGUbvjTdTL51m7AIvnH5TOKG2
         3Qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189715; x=1713794515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeVcetMQDPrHvTLw/jVBM/G2lxBJUfKvfXKAGGviwwI=;
        b=mHWLkuxa89aSEiQMNdBlgMch74ae8QJIzhtvLqXPo5TKcKoiChQKjDmd56FSXvz3oe
         ronvhzfiMu2qkSI6P99ik2vJzOotjZXhcbdKkh8DPZ7jFWJqrut3sKRtd1Zo/Xs96azY
         7xG5U7ENqMbV1a4AblIC6M3JrYBoSB93w71p+ujlBllZAvkCuMNAm4CTHvtNuR58qWQL
         lpETXEkAYpEjUmuEHBmOaDqu9sbvfSf6pLecMhBSaCJ4rKC30UJ7rFctqxBXoCcqXm02
         8VfaGalxOQwFlL4k62jUyzkUC2AIvOFCWMvRXO41/0yW4894xiN3hYrsPE3WmeCxQDYz
         YV4A==
X-Forwarded-Encrypted: i=1; AJvYcCU3UXnLXy+4mc1SWRr7l2cKuGfcuX4R9mdhO5TQIc4sdMIt2ptCxGwcZ59TymusLCuGaB5rG+vi7ENVESBUhi/bv9h3SKEE
X-Gm-Message-State: AOJu0Yy6fmko5wz1MpB3XyokDPMfj6ulUGJkHGKKgKxOnOViPK+OAMef
	rGfvTmYnhIDcy1yL54yTkBo34B+ok89RLM+feEaA1ieme21hF658nxT5246gA71Vfe7sZOPeFfB
	/PGTPE2Ib4qL3kQTWZuiQhcZJqjmrGMMG8mhd
X-Google-Smtp-Source: AGHT+IE6/cwNk+V83kNXUJDsEP9ZI0qmHhd9SwtL8WIu+kB5DsZw+JN9g+SmTIhSpZlF0wEyfNQoBdUKEyMQt9cmd9M=
X-Received: by 2002:a81:83c2:0:b0:61a:d26a:a621 with SMTP id
 t185-20020a8183c2000000b0061ad26aa621mr1571116ywf.10.1713189713294; Mon, 15
 Apr 2024 07:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326230319.190117-1-jhs@mojatatu.com> <CANn89iLhd4iD-pDVJHzKqWbf16u9KyNtgV41X3sd=iy15jDQtQ@mail.gmail.com>
 <CAM0EoMmQHsucU6n1O3XEd50zUB4TENkEH0+J-cZ=5Bbv9298mA@mail.gmail.com>
 <CANn89iKaMKeY7pR7=RH1NMBpYiYFmBRfAWmbZ61PdJ2VYoUJ9g@mail.gmail.com>
 <CAM0EoM=s_MvUa32kUyt=VfeiAwxOm2OUJ3H=i0ARO1xupM2_Xg@mail.gmail.com>
 <CAM0EoMk33ga5dh12ViZz8QeFwjwNQBvykM53VQo1B3BdfAZtaQ@mail.gmail.com>
 <CANn89iLmhaC8fuu4UpPdELOAapBzLv0+S50gr0Rs+J+=4+9j=g@mail.gmail.com> <CAM0EoMm+cqkY9tQC6+jpvLJrRxw43Gzffgw85Q3Fe2tBgA7k2Q@mail.gmail.com>
In-Reply-To: <CAM0EoMm+cqkY9tQC6+jpvLJrRxw43Gzffgw85Q3Fe2tBgA7k2Q@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 15 Apr 2024 10:01:42 -0400
Message-ID: <CAM0EoMmdp_ik6EA2q8vhr+gGh=OcxUkvBOsxPHFWjn1eDX_33Q@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 9:59=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Apr 15, 2024 at 5:20=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Apr 10, 2024 at 10:30=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Tue, Apr 2, 2024 at 1:35=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > > >
> > > > On Tue, Apr 2, 2024 at 12:47=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Wed, Mar 27, 2024 at 11:58=E2=80=AFPM Jamal Hadi Salim <jhs@mo=
jatatu.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 27, 2024 at 9:23=E2=80=AFAM Eric Dumazet <edumazet@=
google.com> wrote:
> > > > > > >
> > > > > > > On Wed, Mar 27, 2024 at 12:03=E2=80=AFAM Jamal Hadi Salim <jh=
s@mojatatu.com> wrote:
> > > > > > > >
> > > > > > > > When the mirred action is used on a classful egress qdisc a=
nd a packet is
> > > > > > > > mirrored or redirected to self we hit a qdisc lock deadlock=
.
> > > > > > > > See trace below.
> > > > > > > >
> > > > > > > > [..... other info removed for brevity....]
> > > > > > > > [   82.890906]
> > > > > > > > [   82.890906] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > > > [   82.890906] WARNING: possible recursive locking detected
> > > > > > > > [   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted=
: G        W
> > > > > > > > [   82.890906] --------------------------------------------
> > > > > > > > [   82.890906] ping/418 is trying to acquire lock:
> > > > > > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3},=
 at:
> > > > > > > > __dev_queue_xmit+0x1778/0x3550
> > > > > > > > [   82.890906]
> > > > > > > > [   82.890906] but task is already holding lock:
> > > > > > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3},=
 at:
> > > > > > > > __dev_queue_xmit+0x1778/0x3550
> > > > > > > > [   82.890906]
> > > > > > > > [   82.890906] other info that might help us debug this:
> > > > > > > > [   82.890906]  Possible unsafe locking scenario:
> > > > > > > > [   82.890906]
> > > > > > > > [   82.890906]        CPU0
> > > > > > > > [   82.890906]        ----
> > > > > > > > [   82.890906]   lock(&sch->q.lock);
> > > > > > > > [   82.890906]   lock(&sch->q.lock);
> > > > > > > > [   82.890906]
> > > > > > > > [   82.890906]  *** DEADLOCK ***
> > > > > > > > [   82.890906]
> > > > > > > > [..... other info removed for brevity....]
> > > > > > > >
> > > > > > > > Example setup (eth0->eth0) to recreate
> > > > > > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > > > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchal=
l \
> > > > > > > >      action mirred egress redirect dev eth0
> > > > > > > >
> > > > > > > > Another example(eth0->eth1->eth0) to recreate
> > > > > > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > > > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchal=
l \
> > > > > > > >      action mirred egress redirect dev eth1
> > > > > > > >
> > > > > > > > tc qdisc add dev eth1 root handle 1: htb default 30
> > > > > > > > tc filter add dev eth1 handle 1: protocol ip prio 2 matchal=
l \
> > > > > > > >      action mirred egress redirect dev eth0
> > > > > > > >
> > > > > > > > We fix this by adding a per-cpu, per-qdisc recursion counte=
r which is
> > > > > > > > incremented the first time a root qdisc is entered and on a=
 second attempt
> > > > > > > > enter the same root qdisc from the top, the packet is dropp=
ed to break the
> > > > > > > > loop.
> > > > > > > >
> > > > > > > > Reported-by: renmingshuai@huawei.com
> > > > > > > > Closes: https://lore.kernel.org/netdev/20240314111713.5979-=
1-renmingshuai@huawei.com/
> > > > > > > > Fixes: 3bcb846ca4cf ("net: get rid of spin_trylock() in net=
_tx_action()")
> > > > > > > > Fixes: e578d9c02587 ("net: sched: use counter to break recl=
assify loops")
> > > > > > > > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > > > > ---
> > > > > > > >  include/net/sch_generic.h |  2 ++
> > > > > > > >  net/core/dev.c            |  9 +++++++++
> > > > > > > >  net/sched/sch_api.c       | 12 ++++++++++++
> > > > > > > >  net/sched/sch_generic.c   |  2 ++
> > > > > > > >  4 files changed, 25 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/include/net/sch_generic.h b/include/net/sch_ge=
neric.h
> > > > > > > > index cefe0c4bdae3..f9f99df037ed 100644
> > > > > > > > --- a/include/net/sch_generic.h
> > > > > > > > +++ b/include/net/sch_generic.h
> > > > > > > > @@ -125,6 +125,8 @@ struct Qdisc {
> > > > > > > >         spinlock_t              busylock ____cacheline_alig=
ned_in_smp;
> > > > > > > >         spinlock_t              seqlock;
> > > > > > > >
> > > > > > > > +       u16 __percpu            *xmit_recursion;
> > > > > > > > +
> > > > > > > >         struct rcu_head         rcu;
> > > > > > > >         netdevice_tracker       dev_tracker;
> > > > > > > >         /* private data */
> > > > > > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > > > > > index 9a67003e49db..2b712388c06f 100644
> > > > > > > > --- a/net/core/dev.c
> > > > > > > > +++ b/net/core/dev.c
> > > > > > > > @@ -3789,6 +3789,13 @@ static inline int __dev_xmit_skb(str=
uct sk_buff *skb, struct Qdisc *q,
> > > > > > > >         if (unlikely(contended))
> > > > > > > >                 spin_lock(&q->busylock);
> > > > > > >
> > > > > > > This could hang here (busylock)
> > > > > >
> > > > > > Notice the goto free_skb_list has an spin_unlock(&q->busylock);=
  in
> > > > > > its code vicinity. Am I missing something?
> > > > >
> > > > > The hang would happen in above spin_lock(&q->busylock), before yo=
u can
> > > > > get a chance...
> > > > >
> > > > > If you want to test your patch, add this debugging feature, prete=
nding
> > > > > the spinlock is contended.
> > > > >
> > > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > > index 818699dea9d7040ee74532ccdebf01c4fd6887cc..b2fe3aa2716f0fe12=
8ef10f9d06c2431b3246933
> > > > > 100644
> > > > > --- a/net/core/dev.c
> > > > > +++ b/net/core/dev.c
> > > > > @@ -3816,7 +3816,7 @@ static inline int __dev_xmit_skb(struct sk_=
buff
> > > > > *skb, struct Qdisc *q,
> > > > >          * sent after the qdisc owner is scheduled again. To prev=
ent this
> > > > >          * scenario the task always serialize on the lock.
> > > > >          */
> > > > > -       contended =3D qdisc_is_running(q) || IS_ENABLED(CONFIG_PR=
EEMPT_RT);
> > > > > +       contended =3D true; // DEBUG for Jamal
> > > > >         if (unlikely(contended))
> > > > >                 spin_lock(&q->busylock);
> > > >
> > > > Will do.
> > >
> > > Finally got time to look again. Probably being too clever, but moving
> > > the check before the contended check resolves it as well. The only
> > > strange thing is now with the latest net-next seems to be spitting
> > > some false positive lockdep splat for the test of A->B->A (i am sure
> > > it's fixable).
> > >
> > > See attached. Didnt try the other idea, see if you like this one.
> >
> > A spinlock can only be held by one cpu at a time, so recording the cpu
> > number of the lock owner should be
> > enough to avoid a deadlock.
> >
> > So I really do not understand your push for a per-cpu variable with
> > extra cache line misses.
> >
>
> I was asking earlier - do per-cpu (qdisc struct) variables incur extra
> cache misses on top of the cache miss that is incurred when accessing
> the qdisc struct? I think you have been saying yes, but not being
> explicit ;->
>
> > I think the following would work just fine ? What do you think ?
> >
>
> Yep, good compromise ;-> Small missing thing - the initialization. See at=
tached.
> Do you want to send it or should we?

Sorry - shows Victor's name but this is your patch, so feel free if
you send to add your name as author.

cheers,
jamal

