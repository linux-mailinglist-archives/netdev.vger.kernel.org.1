Return-Path: <netdev+bounces-87815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181CA8A4B75
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383091C2109A
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB863FE55;
	Mon, 15 Apr 2024 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQxYtHwC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60733FB99
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173405; cv=none; b=qDkoFFFIJa2sGnNmfDduZPOso2lHvdth7kNDD7+t/XPk7zTl0U+YpVmKSYjQrkV6ZeM7dUFnFhomI/VRiAh7Yd6SnTcrm0Ph6llH7nVQ2zdwlOTka2IWCC2M5kSkXJh0aLuCnYzhhHyLZz5QA342wxM46/3FObDLjXtTiA2/j3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173405; c=relaxed/simple;
	bh=jgTcNN+S3ycEmYHulRrTUWpfdKBOBWs4500TU2VTpiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amzP0+Q9zb5A1mkeO6CqiPZFqnD5NXv/msNy5LNJwmJGepVgQ6xI0gTlGqUw431zC80YSbFKtxD/wkUNfdGkR7i+eMTayT/0o0NBh4EAzXvzbn3DrUdeeQE+O5JEELRmOsk3tWtTVN9fwxviOUlY/l7AA9I/852PiejNUL2zLVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQxYtHwC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5700ed3017fso11540a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 02:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713173402; x=1713778202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNj6qSBxPtBl3RQXTzkrjLin4rllOTR1hjVXVlg3sZw=;
        b=bQxYtHwCebJtCosuAZHc9WPx4eGgJB09vVe1VUFXqjVLOd56QbkHoQNwKgXYWnWDGs
         yioqOzt0r7qkC1AcRfYF474TQHO30196YRD4sgmtolNYTtuSIF9tnQbr/YJ2cklS8Pyo
         gVcAUOEudEisZSBooadKYXdhjd7AGSMN48Ib1TAA0eckXJHrAt+jWotq2XUpsmCD3p6w
         JN2+sjd3LkJY+5b7F43O9b/vbfma/3/8INx3CzGTTo1ZZe8zSxGNukJO3CwjUm0qD54Q
         95QR6jpirJwXnCYwjWyNAu4QAJ9I6B/LExlREgCLcZgPUMrAD1meHcZznx5SOzBIOdrS
         q3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713173402; x=1713778202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNj6qSBxPtBl3RQXTzkrjLin4rllOTR1hjVXVlg3sZw=;
        b=QJA5THHZJSd1IyzrWsUh5zTeI7mvs+R0qz3rS6HtXtCj5jFqXsewLO/WkJz7z2bpqF
         VGmEp69o+BIeU+rX4D7u7R0DFtqFxj+M/UN7LGbSCLpZfIpha7ebbwQ1yBzjsdymuNcS
         twWL+Sjm1jHZ4FMv+XhaWM2AFuNTMRfSQtK15/JvsHxrhqHnL4AInMbJ2O3X6DvAs36F
         RSbBMbhgvDv75GhNJuS5nY0jEjR0Dg5S2NbHSQbDgFPEdtVercIyggSdCZlscu6TRkkk
         G+ldSq95OP/Jx+BsFREnRWK4Ci+WmMdPCCdhZO3cOZQ9AF+ObqJDN47+/cXc9gjAchwJ
         1asA==
X-Forwarded-Encrypted: i=1; AJvYcCXX4/11f5YOeeW1QxLiInzAiHDyLqAlG/G2VAJqcRhGWiWKgt5uz9btoUETZ63GF8N02D19Yr/PBZeiNDphrLo+jpZ6p1HW
X-Gm-Message-State: AOJu0Yx9Lp/DssZu/s8vzjUoJnBy8TmSf70DBCHAUV2lvLhH5FyaQXsI
	lpL/cbHLVka5WE4DzvvR9b+dr+s0BbtbF28R2mrez8ovcgtvHBUiG72E2RtfsFdWCvjgXUp35AS
	g8UnPUtbCWFHdFQ6HS02RQC1+2IuN6c1w4ZNy
X-Google-Smtp-Source: AGHT+IEezWUstpDtD8pP5gt5VdI+5txYFkHnZRciUxmqYUkyxi07xFi2DPXcDJdge/Qyohpa3kBzXXQWwdvOnkUhrLw=
X-Received: by 2002:a05:6402:2062:b0:570:99f:6c2e with SMTP id
 bd2-20020a056402206200b00570099f6c2emr216195edb.1.1713173401872; Mon, 15 Apr
 2024 02:30:01 -0700 (PDT)
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
 <CAM0EoMk33ga5dh12ViZz8QeFwjwNQBvykM53VQo1B3BdfAZtaQ@mail.gmail.com> <CANn89iLmhaC8fuu4UpPdELOAapBzLv0+S50gr0Rs+J+=4+9j=g@mail.gmail.com>
In-Reply-To: <CANn89iLmhaC8fuu4UpPdELOAapBzLv0+S50gr0Rs+J+=4+9j=g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Apr 2024 11:29:50 +0200
Message-ID: <CANn89i+J=+2n4qsaHMNdPBUo36mvdzs1mV2GeK_ZNj=ruGvUSw@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:20=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Apr 10, 2024 at 10:30=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Tue, Apr 2, 2024 at 1:35=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> > >
> > > On Tue, Apr 2, 2024 at 12:47=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Wed, Mar 27, 2024 at 11:58=E2=80=AFPM Jamal Hadi Salim <jhs@moja=
tatu.com> wrote:
> > > > >
> > > > > On Wed, Mar 27, 2024 at 9:23=E2=80=AFAM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 27, 2024 at 12:03=E2=80=AFAM Jamal Hadi Salim <jhs@=
mojatatu.com> wrote:
> > > > > > >
> > > > > > > When the mirred action is used on a classful egress qdisc and=
 a packet is
> > > > > > > mirrored or redirected to self we hit a qdisc lock deadlock.
> > > > > > > See trace below.
> > > > > > >
> > > > > > > [..... other info removed for brevity....]
> > > > > > > [   82.890906]
> > > > > > > [   82.890906] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > > > > [   82.890906] WARNING: possible recursive locking detected
> > > > > > > [   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: =
G        W
> > > > > > > [   82.890906] --------------------------------------------
> > > > > > > [   82.890906] ping/418 is trying to acquire lock:
> > > > > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, a=
t:
> > > > > > > __dev_queue_xmit+0x1778/0x3550
> > > > > > > [   82.890906]
> > > > > > > [   82.890906] but task is already holding lock:
> > > > > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, a=
t:
> > > > > > > __dev_queue_xmit+0x1778/0x3550
> > > > > > > [   82.890906]
> > > > > > > [   82.890906] other info that might help us debug this:
> > > > > > > [   82.890906]  Possible unsafe locking scenario:
> > > > > > > [   82.890906]
> > > > > > > [   82.890906]        CPU0
> > > > > > > [   82.890906]        ----
> > > > > > > [   82.890906]   lock(&sch->q.lock);
> > > > > > > [   82.890906]   lock(&sch->q.lock);
> > > > > > > [   82.890906]
> > > > > > > [   82.890906]  *** DEADLOCK ***
> > > > > > > [   82.890906]
> > > > > > > [..... other info removed for brevity....]
> > > > > > >
> > > > > > > Example setup (eth0->eth0) to recreate
> > > > > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall =
\
> > > > > > >      action mirred egress redirect dev eth0
> > > > > > >
> > > > > > > Another example(eth0->eth1->eth0) to recreate
> > > > > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall =
\
> > > > > > >      action mirred egress redirect dev eth1
> > > > > > >
> > > > > > > tc qdisc add dev eth1 root handle 1: htb default 30
> > > > > > > tc filter add dev eth1 handle 1: protocol ip prio 2 matchall =
\
> > > > > > >      action mirred egress redirect dev eth0
> > > > > > >
> > > > > > > We fix this by adding a per-cpu, per-qdisc recursion counter =
which is
> > > > > > > incremented the first time a root qdisc is entered and on a s=
econd attempt
> > > > > > > enter the same root qdisc from the top, the packet is dropped=
 to break the
> > > > > > > loop.
> > > > > > >
> > > > > > > Reported-by: renmingshuai@huawei.com
> > > > > > > Closes: https://lore.kernel.org/netdev/20240314111713.5979-1-=
renmingshuai@huawei.com/
> > > > > > > Fixes: 3bcb846ca4cf ("net: get rid of spin_trylock() in net_t=
x_action()")
> > > > > > > Fixes: e578d9c02587 ("net: sched: use counter to break reclas=
sify loops")
> > > > > > > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > > > ---
> > > > > > >  include/net/sch_generic.h |  2 ++
> > > > > > >  net/core/dev.c            |  9 +++++++++
> > > > > > >  net/sched/sch_api.c       | 12 ++++++++++++
> > > > > > >  net/sched/sch_generic.c   |  2 ++
> > > > > > >  4 files changed, 25 insertions(+)
> > > > > > >
> > > > > > > diff --git a/include/net/sch_generic.h b/include/net/sch_gene=
ric.h
> > > > > > > index cefe0c4bdae3..f9f99df037ed 100644
> > > > > > > --- a/include/net/sch_generic.h
> > > > > > > +++ b/include/net/sch_generic.h
> > > > > > > @@ -125,6 +125,8 @@ struct Qdisc {
> > > > > > >         spinlock_t              busylock ____cacheline_aligne=
d_in_smp;
> > > > > > >         spinlock_t              seqlock;
> > > > > > >
> > > > > > > +       u16 __percpu            *xmit_recursion;
> > > > > > > +
> > > > > > >         struct rcu_head         rcu;
> > > > > > >         netdevice_tracker       dev_tracker;
> > > > > > >         /* private data */
> > > > > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > > > > index 9a67003e49db..2b712388c06f 100644
> > > > > > > --- a/net/core/dev.c
> > > > > > > +++ b/net/core/dev.c
> > > > > > > @@ -3789,6 +3789,13 @@ static inline int __dev_xmit_skb(struc=
t sk_buff *skb, struct Qdisc *q,
> > > > > > >         if (unlikely(contended))
> > > > > > >                 spin_lock(&q->busylock);
> > > > > >
> > > > > > This could hang here (busylock)
> > > > >
> > > > > Notice the goto free_skb_list has an spin_unlock(&q->busylock);  =
in
> > > > > its code vicinity. Am I missing something?
> > > >
> > > > The hang would happen in above spin_lock(&q->busylock), before you =
can
> > > > get a chance...
> > > >
> > > > If you want to test your patch, add this debugging feature, pretend=
ing
> > > > the spinlock is contended.
> > > >
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index 818699dea9d7040ee74532ccdebf01c4fd6887cc..b2fe3aa2716f0fe128e=
f10f9d06c2431b3246933
> > > > 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -3816,7 +3816,7 @@ static inline int __dev_xmit_skb(struct sk_bu=
ff
> > > > *skb, struct Qdisc *q,
> > > >          * sent after the qdisc owner is scheduled again. To preven=
t this
> > > >          * scenario the task always serialize on the lock.
> > > >          */
> > > > -       contended =3D qdisc_is_running(q) || IS_ENABLED(CONFIG_PREE=
MPT_RT);
> > > > +       contended =3D true; // DEBUG for Jamal
> > > >         if (unlikely(contended))
> > > >                 spin_lock(&q->busylock);
> > >
> > > Will do.
> >
> > Finally got time to look again. Probably being too clever, but moving
> > the check before the contended check resolves it as well. The only
> > strange thing is now with the latest net-next seems to be spitting
> > some false positive lockdep splat for the test of A->B->A (i am sure
> > it's fixable).
> >
> > See attached. Didnt try the other idea, see if you like this one.
>
> A spinlock can only be held by one cpu at a time, so recording the cpu
> number of the lock owner should be
> enough to avoid a deadlock.
>
> So I really do not understand your push for a per-cpu variable with
> extra cache line misses.
>
> I think the following would work just fine ? What do you think ?
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 76db6be1608315102495dd6372fc30e6c9d41a99..dcd92ed7f69fae00deaca2c88=
fed248a559108ea
> 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -117,6 +117,7 @@ struct Qdisc {
>         struct qdisc_skb_head   q;
>         struct gnet_stats_basic_sync bstats;
>         struct gnet_stats_queue qstats;
> +       int                     owner;
>         unsigned long           state;
>         unsigned long           state2; /* must be written under qdisc
> spinlock */
>         struct Qdisc            *next_sched;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 854a3a28a8d85b335a9158378ae0cca6dfbf8b36..d77cac53df4b4af478548dd17=
e7a3a7cfe4bd792
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3808,6 +3808,11 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>                 return rc;
>         }
>
> +       if (unlikely(READ_ONCE(q->owner) =3D=3D smp_processor_id())) {
> +               /* add a specific drop_reason later in net-next */
> +               kfree_skb_reason(skb, SKB_DROP_REASON_TC_RECLASSIFY_LOOP)=
;
> +               return NET_XMIT_DROP;
> +       }

Or even better this expensive check could be moved into tcf_mirred_forward(=
) ?

This would be done later in net-next, because this looks a bit more
complex than this simple solution.


>         /*
>          * Heuristic to force contended enqueues to serialize on a
>          * separate lock before trying to get qdisc main lock.
> @@ -3847,7 +3852,9 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>                 qdisc_run_end(q);
>                 rc =3D NET_XMIT_SUCCESS;
>         } else {
> +               WRITE_ONCE(q->owner, smp_processor_id());
>                 rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
> +               WRITE_ONCE(q->owner, -1);
>                 if (qdisc_run_begin(q)) {
>                         if (unlikely(contended)) {
>                                 spin_unlock(&q->busylock);

