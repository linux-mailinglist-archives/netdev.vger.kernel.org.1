Return-Path: <netdev+bounces-87995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F938A5278
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E348528257D
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED5573191;
	Mon, 15 Apr 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZBSIDLKU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329333080
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189565; cv=none; b=oPPzZzDVuL3TX4IPt0x/6Sm3xUhq/cy9BS3k8uLsqOVMKYT2wn6U7dnx2F9gQk6p7FkQBeJub2XfenR7cxdlfn8l+Kog9coSXODDjJCQUitP9x/eWK/aryjLrPnEcdPlSr3k3rn/jeECuALOCyen6ZQG3DwxbhQsSHzILKx1ZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189565; c=relaxed/simple;
	bh=ZmNngN+3CftMBayEeayrqAurmRR0aM9ZwP3l+YxmDDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGgdc+r52TZFeGZTHCmgqfznymIJHCpdjQbbY7yBRpUdUYBc3JFloP5jh+meK/h244CA+sJN3T37FNrNr3DWo3LnhoI641GqDf+8W/Eh+coQAV7F6uz75r99ZC+W9vGuo4Gm8NoOLyxnOnJVGpQYTFzepmbNRKsgTFAwv+J5BoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ZBSIDLKU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6164d7a02d2so36649907b3.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713189562; x=1713794362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CwvqOXueQ3YrD7scDQxifONCa9tiar4MMUnbnRihG3c=;
        b=ZBSIDLKUG8jrORCvkI6iHSrxxHcVJshV9AdZD780Wz/UvaOgRtIqY6fuAPzVUEa5X0
         lHf4lgAT9NY/5zUrRl5gBeKUbGRuqJ7tHOPD7g9Zq5S3VQs9DBl0mVxd1QEg+DkyQ7Lo
         NBer5ItkmMUSSNTQIGvObI5+bWwKQRiVaoA7KGJNaqQKs76p7lBkfQjhPD+6euaRFrOy
         XE3MFrzijPCvB881mjGyYYD14VzIp13CfxhV0pBQlmHV0Jv2OJlx8nPXV6XLTtvpofI8
         3BA3ikfkxke91UZP7KmEWxFeX5K96eg3P7XC8tWqBewReALgSKhV9Uogjt8IhQuFk3mM
         llyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189562; x=1713794362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwvqOXueQ3YrD7scDQxifONCa9tiar4MMUnbnRihG3c=;
        b=ZJoCEhK9zVG5SuxGPLqBFhJixgV1NbvsbUWLhlSLjDMu5Q8bq9GiMhFTGDVU2komKJ
         thIfq7XmQi5n3T+5aG56f4D84Olb8a5VfaE1XEvnudDuFRAQOGy0aPi+tquwxvSlz0nK
         iWIaQNAP+fJISMX0/+hv6chhJTLjakCkuCTORMYwkKvVepm6TntWQ2RICcDEbbLgyhAj
         lgSKnvN5S6RLRujspQ1s90IJXjbS88IhEDlh20rQW5491X8VldWlBLYI158MOCrA7yUP
         FwFBHc309rAAs/lfrWwkDQuhFnBNL96YoxJqGCXjs00d+R2rVG8kh1MmesieHHJ04paI
         NNqw==
X-Forwarded-Encrypted: i=1; AJvYcCVhrkpxGi4XAR2B/pSTSy0HFMLx8ewkPZOP7BtySFD7MQ/lRKps4CvRHpI2cqslElON/WqhtHynVkr1AQNunX4WpTsNJ6cw
X-Gm-Message-State: AOJu0YxUTDbOHAJQazm5ViIiyZK3KByXBjxjofhmoj8KoZJi937FzIkq
	S3M5Y4wLJHpZ7RRzmVHOZoQ4LXQHSNu7xPysMcSpviZUQdu/bnEi2rSTuanKwpGwS/UMWaunwVE
	vi8ZO677ScDnqyLXubmTVCONTIy4DY1MIjxN2
X-Google-Smtp-Source: AGHT+IHYRr1hqlPoAsXV3ztsA7QIJh5ixXNXPgKibmGfF+GwI65Udt2EpvPl6UAk3iXGOQjjBZwGyi7nynrm9iG/DYs=
X-Received: by 2002:a81:52ca:0:b0:615:b6f:ad35 with SMTP id
 g193-20020a8152ca000000b006150b6fad35mr8804226ywb.33.1713189562339; Mon, 15
 Apr 2024 06:59:22 -0700 (PDT)
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
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 15 Apr 2024 09:59:10 -0400
Message-ID: <CAM0EoMm+cqkY9tQC6+jpvLJrRxw43Gzffgw85Q3Fe2tBgA7k2Q@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: multipart/mixed; boundary="0000000000004c3a7106162307a9"

--0000000000004c3a7106162307a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 5:20=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
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

I was asking earlier - do per-cpu (qdisc struct) variables incur extra
cache misses on top of the cache miss that is incurred when accessing
the qdisc struct? I think you have been saying yes, but not being
explicit ;->

> I think the following would work just fine ? What do you think ?
>

Yep, good compromise ;-> Small missing thing - the initialization. See atta=
ched.
Do you want to send it or should we? We are going to add the reason
and test cases later.

cheers,
jamal

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

--0000000000004c3a7106162307a9
Content-Type: text/x-patch; charset="US-ASCII"; name="mirred-loop-fix.patch"
Content-Disposition: attachment; filename="mirred-loop-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lv10rgme0>
X-Attachment-Id: f_lv10rgme0

Y29tbWl0IDVlODE5MDQ5YzI3MGY0NzcxYmI5OTBkYjEzZDc1ZjhlYzg4ZjYyMjcKQXV0aG9yOiBW
aWN0b3IgTm9ndWVpcmEgPHZpY3RvckBtb2phdGF0dS5jb20+CkRhdGU6ICAgTW9uIEFwciAxNSAx
MjoxMDo0MCAyMDI0ICswMDAwCgogICAgTWlycmVkIG5lc3RlZCBsb29wIGZpeAoKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbmV0L3NjaF9nZW5lcmljLmggYi9pbmNsdWRlL25ldC9zY2hfZ2VuZXJpYy5o
CmluZGV4IDc2ZGI2YmUxNjA4My4uZjU2MWRmYjc5NzQzIDEwMDY0NAotLS0gYS9pbmNsdWRlL25l
dC9zY2hfZ2VuZXJpYy5oCisrKyBiL2luY2x1ZGUvbmV0L3NjaF9nZW5lcmljLmgKQEAgLTExNyw2
ICsxMTcsNyBAQCBzdHJ1Y3QgUWRpc2MgewogCXN0cnVjdCBxZGlzY19za2JfaGVhZAlxOwogCXN0
cnVjdCBnbmV0X3N0YXRzX2Jhc2ljX3N5bmMgYnN0YXRzOwogCXN0cnVjdCBnbmV0X3N0YXRzX3F1
ZXVlCXFzdGF0czsKKwlpbnQgICAgICAgICAgICAgICAgICAgICBvd25lcjsKIAl1bnNpZ25lZCBs
b25nCQlzdGF0ZTsKIAl1bnNpZ25lZCBsb25nCQlzdGF0ZTI7IC8qIG11c3QgYmUgd3JpdHRlbiB1
bmRlciBxZGlzYyBzcGlubG9jayAqLwogCXN0cnVjdCBRZGlzYyAgICAgICAgICAgICpuZXh0X3Nj
aGVkOwpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvZGV2LmMgYi9uZXQvY29yZS9kZXYuYwppbmRleCA4
NTRhM2EyOGE4ZDguLmY2YzZlNDk0ZjBhOSAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvZGV2LmMKKysr
IGIvbmV0L2NvcmUvZGV2LmMKQEAgLTM4MDgsNiArMzgwOCwxMCBAQCBzdGF0aWMgaW5saW5lIGlu
dCBfX2Rldl94bWl0X3NrYihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgUWRpc2MgKnEsCiAJ
CXJldHVybiByYzsKIAl9CiAKKwlpZiAodW5saWtlbHkoUkVBRF9PTkNFKHEtPm93bmVyKSA9PSBz
bXBfcHJvY2Vzc29yX2lkKCkpKSB7CisJCWtmcmVlX3NrYl9yZWFzb24oc2tiLCBTS0JfRFJPUF9S
RUFTT05fVENfUkVDTEFTU0lGWV9MT09QKTsKKwkJcmV0dXJuIE5FVF9YTUlUX0RST1A7CisJfQog
CS8qCiAJICogSGV1cmlzdGljIHRvIGZvcmNlIGNvbnRlbmRlZCBlbnF1ZXVlcyB0byBzZXJpYWxp
emUgb24gYQogCSAqIHNlcGFyYXRlIGxvY2sgYmVmb3JlIHRyeWluZyB0byBnZXQgcWRpc2MgbWFp
biBsb2NrLgpAQCAtMzg0Nyw3ICszODUxLDkgQEAgc3RhdGljIGlubGluZSBpbnQgX19kZXZfeG1p
dF9za2Ioc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IFFkaXNjICpxLAogCQlxZGlzY19ydW5f
ZW5kKHEpOwogCQlyYyA9IE5FVF9YTUlUX1NVQ0NFU1M7CiAJfSBlbHNlIHsKKwkJV1JJVEVfT05D
RShxLT5vd25lciwgc21wX3Byb2Nlc3Nvcl9pZCgpKTsKIAkJcmMgPSBkZXZfcWRpc2NfZW5xdWV1
ZShza2IsIHEsICZ0b19mcmVlLCB0eHEpOworCQlXUklURV9PTkNFKHEtPm93bmVyLCAtMSk7CiAJ
CWlmIChxZGlzY19ydW5fYmVnaW4ocSkpIHsKIAkJCWlmICh1bmxpa2VseShjb250ZW5kZWQpKSB7
CiAJCQkJc3Bpbl91bmxvY2soJnEtPmJ1c3lsb2NrKTsKZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9z
Y2hfYXBpLmMgYi9uZXQvc2NoZWQvc2NoX2FwaS5jCmluZGV4IDYwMjM5Mzc4ZDQzZi4uMTVjNzE1
YzE2MjQ3IDEwMDY0NAotLS0gYS9uZXQvc2NoZWQvc2NoX2FwaS5jCisrKyBiL25ldC9zY2hlZC9z
Y2hfYXBpLmMKQEAgLTEzNzYsNiArMTM3Niw3IEBAIHN0YXRpYyBzdHJ1Y3QgUWRpc2MgKnFkaXNj
X2NyZWF0ZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAogCQl9CiAJfQogCisJc2NoLT5vd25lciA9
IC0xOwogCXFkaXNjX2hhc2hfYWRkKHNjaCwgZmFsc2UpOwogCXRyYWNlX3FkaXNjX2NyZWF0ZShv
cHMsIGRldiwgcGFyZW50KTsKIAo=
--0000000000004c3a7106162307a9--

