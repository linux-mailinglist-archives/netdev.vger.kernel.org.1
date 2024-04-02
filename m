Return-Path: <netdev+bounces-84127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7568B895ACA
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 19:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EED9B27525
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 17:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018AC15A4B4;
	Tue,  2 Apr 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="osejXlnR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4004815A4B3
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079338; cv=none; b=SGJBTrknJOUBovW0As6XGk1fKpSfosIqryRq7p05bk2O0iKP2Bh5qD0w6Nxi739bCeya4YCrDDGv7wA3+oAHT1iZCKogECty0Vt4SYA2eHKrDhmGMcAYE5RfFsQwqg16q+llIO96UhWriE8s5wmdToLYbtljB/GqVaIw4AIjRzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079338; c=relaxed/simple;
	bh=oK8MjyuNe6ZeoJ3MGK90LouWpavgSylqwcwMaIkQxYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuA2ekKP18mmrxJMagAXsGFWmfyytjBqt661xCe4cFWtmaBeiMYp83VCMJljTx7V/MijxGy7CpZ39c8AMRy0rgl66lrvP2b7zPAv1YKS+03XFHIYErC+97MNEh+pgwrsMT2TXlpefsSl7KtJNFsYi9rZ1DHTN+gUSWJz5gFJrWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=osejXlnR; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso5079948276.2
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712079335; x=1712684135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWde6IPtBKdKAhJje1cmSJIbcu8x901SsVx48dEY2dw=;
        b=osejXlnRcXsABeAToZaFx405GlmwEYtlam6e1/xNOrFhk+ptD57eAfLV9/pGeZyF3b
         Q+a9dX8CXH26t4q9jUbPAmshSkZXBPnQXUx27B7R+jaNODy3UZ0GX6Ode9dt4ByVSuH7
         F1t50JBBDcGpEJD2SEGxG08gizm6QURx2XYgfVl/w2Tax+UoZtsoyVcjDWWPrOW65bRZ
         EKLkG9ogds25cruixCPFol+ECVPNTRVgmGMoAb0U4C0SOzgGrV/6m4su893VgjEvwA9n
         coZyW23TZK/ODXlxNSmD5ezgTIcr/qCktP3sZfoANBA8Q8J+8o8RumdYn9xcOIhZgImw
         Oytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079335; x=1712684135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWde6IPtBKdKAhJje1cmSJIbcu8x901SsVx48dEY2dw=;
        b=Mm5TM7nKz66Ehdk1uKdm1l4S8/yKKThv1SkWUgF1oMQXXgLOSyYXtpa2jDSB5a2ky/
         qUjDan4NGBHaOujaASBKwgBOAYVCEj0KzkSFVZ3NMnRbptH8pxD9vZ+guvFGsBqupbnJ
         5PVh9DYAOWtNSjO3krEJlcaZwtwdfi3ujS+KRWlgDnLWwUCKPNhfC4zlsPm+vBbA1scN
         DQ75Ny8Xmyo1CJxZEsavQ/SmE4vvtQCqreRXnqBJoUGWWn4MoN+IOeGHWDwh0GMsvvUJ
         p+MM9BJXBCivf42/R7c8sglJ+hi8OymZ/k00h3S4yj07uB4qkmMM44pTAK3waY1pAP6F
         aLMw==
X-Forwarded-Encrypted: i=1; AJvYcCWPSLZ8bYZq0pvMQ6p4+ri/opZiFzTlkftJiUx1VtxCMirW8s3mUiwZhEdw9WNMD+g1sRFodq+XKB6XHvUF1LKFabHfpa4m
X-Gm-Message-State: AOJu0YwpbyllXycs3+d1zuG9NqPM79/oInUii+a1aQkchQ9YnnzfJbXS
	wjq0kbATgwtVA+dapQoJdE/tomsreK9xkKjH2V4BG9Eo79g4gSBwBM77uXb/dYO8CvK1ZohiMKn
	ziySnCZWr3zzzfYrCRCEjS7O2IHSyVuQlYaCH
X-Google-Smtp-Source: AGHT+IHS7kTRN36DYSWL+ijWgARRsbQhKfjvJWr45SwYdlGZo7f498jKew3ZGrBsJxCSoj/0gp782xgwdJfw1TZlX4s=
X-Received: by 2002:a05:6902:4e9:b0:dcf:bc86:1020 with SMTP id
 w9-20020a05690204e900b00dcfbc861020mr10630160ybs.53.1712079335077; Tue, 02
 Apr 2024 10:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326230319.190117-1-jhs@mojatatu.com> <CANn89iLhd4iD-pDVJHzKqWbf16u9KyNtgV41X3sd=iy15jDQtQ@mail.gmail.com>
 <CAM0EoMmQHsucU6n1O3XEd50zUB4TENkEH0+J-cZ=5Bbv9298mA@mail.gmail.com> <CANn89iKaMKeY7pR7=RH1NMBpYiYFmBRfAWmbZ61PdJ2VYoUJ9g@mail.gmail.com>
In-Reply-To: <CANn89iKaMKeY7pR7=RH1NMBpYiYFmBRfAWmbZ61PdJ2VYoUJ9g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 2 Apr 2024 13:35:23 -0400
Message-ID: <CAM0EoM=s_MvUa32kUyt=VfeiAwxOm2OUJ3H=i0ARO1xupM2_Xg@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:47=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Mar 27, 2024 at 11:58=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Wed, Mar 27, 2024 at 9:23=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 12:03=E2=80=AFAM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > > >
> > > > When the mirred action is used on a classful egress qdisc and a pac=
ket is
> > > > mirrored or redirected to self we hit a qdisc lock deadlock.
> > > > See trace below.
> > > >
> > > > [..... other info removed for brevity....]
> > > > [   82.890906]
> > > > [   82.890906] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > > [   82.890906] WARNING: possible recursive locking detected
> > > > [   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: G     =
   W
> > > > [   82.890906] --------------------------------------------
> > > > [   82.890906] ping/418 is trying to acquire lock:
> > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > > > __dev_queue_xmit+0x1778/0x3550
> > > > [   82.890906]
> > > > [   82.890906] but task is already holding lock:
> > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > > > __dev_queue_xmit+0x1778/0x3550
> > > > [   82.890906]
> > > > [   82.890906] other info that might help us debug this:
> > > > [   82.890906]  Possible unsafe locking scenario:
> > > > [   82.890906]
> > > > [   82.890906]        CPU0
> > > > [   82.890906]        ----
> > > > [   82.890906]   lock(&sch->q.lock);
> > > > [   82.890906]   lock(&sch->q.lock);
> > > > [   82.890906]
> > > > [   82.890906]  *** DEADLOCK ***
> > > > [   82.890906]
> > > > [..... other info removed for brevity....]
> > > >
> > > > Example setup (eth0->eth0) to recreate
> > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> > > >      action mirred egress redirect dev eth0
> > > >
> > > > Another example(eth0->eth1->eth0) to recreate
> > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> > > >      action mirred egress redirect dev eth1
> > > >
> > > > tc qdisc add dev eth1 root handle 1: htb default 30
> > > > tc filter add dev eth1 handle 1: protocol ip prio 2 matchall \
> > > >      action mirred egress redirect dev eth0
> > > >
> > > > We fix this by adding a per-cpu, per-qdisc recursion counter which =
is
> > > > incremented the first time a root qdisc is entered and on a second =
attempt
> > > > enter the same root qdisc from the top, the packet is dropped to br=
eak the
> > > > loop.
> > > >
> > > > Reported-by: renmingshuai@huawei.com
> > > > Closes: https://lore.kernel.org/netdev/20240314111713.5979-1-renmin=
gshuai@huawei.com/
> > > > Fixes: 3bcb846ca4cf ("net: get rid of spin_trylock() in net_tx_acti=
on()")
> > > > Fixes: e578d9c02587 ("net: sched: use counter to break reclassify l=
oops")
> > > > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > ---
> > > >  include/net/sch_generic.h |  2 ++
> > > >  net/core/dev.c            |  9 +++++++++
> > > >  net/sched/sch_api.c       | 12 ++++++++++++
> > > >  net/sched/sch_generic.c   |  2 ++
> > > >  4 files changed, 25 insertions(+)
> > > >
> > > > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > > > index cefe0c4bdae3..f9f99df037ed 100644
> > > > --- a/include/net/sch_generic.h
> > > > +++ b/include/net/sch_generic.h
> > > > @@ -125,6 +125,8 @@ struct Qdisc {
> > > >         spinlock_t              busylock ____cacheline_aligned_in_s=
mp;
> > > >         spinlock_t              seqlock;
> > > >
> > > > +       u16 __percpu            *xmit_recursion;
> > > > +
> > > >         struct rcu_head         rcu;
> > > >         netdevice_tracker       dev_tracker;
> > > >         /* private data */
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index 9a67003e49db..2b712388c06f 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -3789,6 +3789,13 @@ static inline int __dev_xmit_skb(struct sk_b=
uff *skb, struct Qdisc *q,
> > > >         if (unlikely(contended))
> > > >                 spin_lock(&q->busylock);
> > >
> > > This could hang here (busylock)
> >
> > Notice the goto free_skb_list has an spin_unlock(&q->busylock);  in
> > its code vicinity. Am I missing something?
>
> The hang would happen in above spin_lock(&q->busylock), before you can
> get a chance...
>
> If you want to test your patch, add this debugging feature, pretending
> the spinlock is contended.
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 818699dea9d7040ee74532ccdebf01c4fd6887cc..b2fe3aa2716f0fe128ef10f9d=
06c2431b3246933
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3816,7 +3816,7 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>          * sent after the qdisc owner is scheduled again. To prevent this
>          * scenario the task always serialize on the lock.
>          */
> -       contended =3D qdisc_is_running(q) || IS_ENABLED(CONFIG_PREEMPT_RT=
);
> +       contended =3D true; // DEBUG for Jamal
>         if (unlikely(contended))
>                 spin_lock(&q->busylock);

Will do.

> >
> > >
> > > >
> > > > +       if (__this_cpu_read(*q->xmit_recursion) > 0) {
> > > > +               __qdisc_drop(skb, &to_free);
> > > > +               rc =3D NET_XMIT_DROP;
> > > > +               goto free_skb_list;
> > > > +       }
> > >
> > >
> > > I do not think we want to add yet another cache line miss and
> > > complexity in tx fast path.
> > >
> >
> > I empathize. The cache miss is due to a per-cpu variable? Otherwise
> > that seems to be in the vicinity of the other fields being accessed in
> > __dev_xmit_skb()
> >
> > > I think that mirred should  use a separate queue to kick a transmit
> > > from the top level.
> > >
> > > (Like netif_rx() does)
> > >
> >
> > Eric, here's my concern: this would entail restructuring mirred
> > totally just to cater for one use case which is in itself _a bad
> > config_ for egress qdisc case only.
>
> Why can't the bad config be detected in the ctl path ?
>

We actually discussed this. It looks simple until you dig in. To catch
this issue we will need to store some state across ports. This can be
done with a graph construct in the control plane. Assume the following
cases matching header "foo" (all using htb or other classful qdiscs):

case 1:
flower match foo on eth0 redirect to egress of eth0

This is easy to do. Your graph can check if src is eth0 and dst is eth0.

Case 2:
flower match foo on eth0 redirect to eth1
flower match foo on eth1 redirect to eth0

Now your graph has to keep state across netdevs. You can catch this
issue as well (but your "checking" code is now growing).

case 3:
flower match foo on eth0 redirect to eth1
flower match bar on eth1 redirect to eth0

There is clearly no loop here because we have different headers, but
you will have to add code to check for such a case.

case 4:
flower match foo on eth0 redirect to eth1
u32 match foo on eth1 redirect to eth0

Now you have to add code that checks all other classifiers(worse would
be ebpf) for matching headers. Worse is you have to consider wild
card. I am also likely missing some other use cases.
Also, I am sure we'll very quickly hear from people who want very fast
insertion rates of filters which now are going to be massively slowed
down when using mirred.
So i am sure it can be done, just not worth the effort given how many
lines of code would need to be added to catch a corner case of bad
config.

>  Mirred is very heavily used in
> > many use cases and changing its behavior could likely introduce other
> > corner cases for some use cases which we would be chasing for a while.
> > Not to forget now we have to go via an extra transient queue.
> > If i understood what you are suggesting is to add an equivalent of
> > backlog queu for the tx side? I am assuming in a very similar nature
> > to backlog, meaning per cpu fired by softirq? or is it something
> > closer to qdisc->gso_skb
> > For either of those cases, the amount of infrastructure code there is
> > not a few lines of code. And then there's the desire to break the loop
> > etc.
> >
> > Some questions regarding your proposal - something I am not following
> > And i may have misunderstood what you are suggesting, but i am missing
> > what scenario mirred can directly call tcf_dev_queue_xmit() (see my
> > comment below)..
>
> I wish the act path would run without qdisc spinlock held, and use RCU in=
stead.
>

The main (only?) reason we need spinlock for qdiscs is for packet queues.

> Instead, we are adding cost in fast path only to detect bad configs.

Agreed but I dont know how we can totally avoid it. Would you be ok
with us using something that looks like qdisc->gso_skb and we check
such a list after releasing the qdisc lock in __dev_xmit_skb() to
invoke the redirect? The loop then can be caught inside mirred.

cheers,
jamal

