Return-Path: <netdev+bounces-86731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AF28A0152
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 22:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6284B27E5A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3F92A1BB;
	Wed, 10 Apr 2024 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Fk5dCehJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93186110
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712781046; cv=none; b=WIsEIG6NoIZqSzr2EKBtlUJg4gN3vQolSUd2mHCFfmnUp5E20K0iVqKdxthQUaciSBYFDZ8+L5j6hKXyAxsatbEzRL47yJ/Ic5FqrpQ3bGGyFxQm4b1Z0SGhFNOBLcZWksh8ysuMlrk2eNnR8VKy4nQLvqaxaUfiCM7gWJU1mUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712781046; c=relaxed/simple;
	bh=+1jFDn3XHfZ3P7+u5yAXGp7wkaqPlqSfnJHROmlLPyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKJYQ4w8kYos52bwG66ZIjT90k8pQtdsW34t3JvdkgDY1LRsI5jOZPxV1PfSTU9kBw0UQ/siWL0lSCnSrwY3jv2XMa8KXfw92TYlgzkHpqekEptF7JHCgNf/3x0C3NBDO3YVTVhXpKeM7eSD0CkUjz0cIaZW/Zpjiz+rO6MD8Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Fk5dCehJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so7342624276.2
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 13:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712781042; x=1713385842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIsyC5HM7UGR9IWJjizcqszaGhz6ppIlQDtIqsOsYM0=;
        b=Fk5dCehJiVX0FpqkowPkakq1b7hnMPAbMRHBgDYViOHiOTINbYcfYucMjd/Pble+oX
         7yC0w6GEg5n2AmO6PLdvINLJG0hNw2d0pvFn4xNOm+p+0FEBCfqOjToCPwRXK4t9eU7K
         T1fkIN46XpUmF7AlaxnUWKEl7qTDK8kMwCG6B+Yhp2hxrtVP+UEdv/k/tCqIejBp47Gn
         jQZ/vhcYJsXXz9W7U0BuuMxueEBZPUpJlBSz1BUUJpC/4EFb0ZTdS9HTAbZPmcKk04yq
         I+BFTj1J0Mijf3kHnwowRR8LTXAHiPGAMvdzVztGblO8ENTxld/pNrMtc5PuX3Dj0a82
         jk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712781042; x=1713385842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIsyC5HM7UGR9IWJjizcqszaGhz6ppIlQDtIqsOsYM0=;
        b=u15qWQIZ++prMDHDfR0tjL65DH5og4oT8Vy4Pki4skvmGRPT1ZVOIzmsMCVraCziR7
         YGZ97BudKk2NYO2Za2nBxSB78UuWjHbzqTiSWj1ntW1UHNJA1M1XR30VMS0JG7R4c3MC
         900Kns2SjvfvGXqI4yoTBGvLeJoj1A3M+vIHk8zZIlqlP76J+IAAlnj3n5G6YBGAYqqo
         0SxHiAh1i4UqB8+D6P+6gbsTXDJKxl97uzk3K7AyPUzJc07uBR+9XZ0+/V4Pmw/LUWPZ
         bABw2XV5kjldIo0smCLg/4vMWzUaDuigiAyLpClS2AcRKq9hqVw7bJGanTbMqYVAanNS
         5NbA==
X-Forwarded-Encrypted: i=1; AJvYcCVWRuj31kUsiVHzIG7G71kuZv40sYJ/+rWS7exryg5IPyapL1bq48f0XjLNXaInA55/SkeeFS46ph35HR2osZd2+LRftlrp
X-Gm-Message-State: AOJu0YxwRH8g1a3ujMy/E1rySgQhAbmPM3K3CBISH99+6vvwu6bWc3Sg
	uKlDrKXOaZfQeJ+A6nGVRoxv8jg6VmReXd8AW4VHknSTULSiUFkyp9bdR74RU6SpO2ooBTo8hXZ
	NxCB4yRUqksaVPHwsFT4kjgfOianjl9MJtzpt/tszahfhsVY=
X-Google-Smtp-Source: AGHT+IHEPPxYKe9iXfO+e/6jVkApDkzaLzSzN7anwyNSynR/xWdJwT3KnXlPTaeqPXNmpOYmFywISzvRgRR/sNm/23I=
X-Received: by 2002:a25:a527:0:b0:dc6:bbeb:d889 with SMTP id
 h36-20020a25a527000000b00dc6bbebd889mr3419745ybi.52.1712781042409; Wed, 10
 Apr 2024 13:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326230319.190117-1-jhs@mojatatu.com> <CANn89iLhd4iD-pDVJHzKqWbf16u9KyNtgV41X3sd=iy15jDQtQ@mail.gmail.com>
 <CAM0EoMmQHsucU6n1O3XEd50zUB4TENkEH0+J-cZ=5Bbv9298mA@mail.gmail.com>
 <CANn89iKaMKeY7pR7=RH1NMBpYiYFmBRfAWmbZ61PdJ2VYoUJ9g@mail.gmail.com> <CAM0EoM=s_MvUa32kUyt=VfeiAwxOm2OUJ3H=i0ARO1xupM2_Xg@mail.gmail.com>
In-Reply-To: <CAM0EoM=s_MvUa32kUyt=VfeiAwxOm2OUJ3H=i0ARO1xupM2_Xg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 10 Apr 2024 16:30:30 -0400
Message-ID: <CAM0EoMk33ga5dh12ViZz8QeFwjwNQBvykM53VQo1B3BdfAZtaQ@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: multipart/mixed; boundary="0000000000009c94880615c3e952"

--0000000000009c94880615c3e952
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 1:35=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Tue, Apr 2, 2024 at 12:47=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Mar 27, 2024 at 11:58=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 9:23=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Wed, Mar 27, 2024 at 12:03=E2=80=AFAM Jamal Hadi Salim <jhs@moja=
tatu.com> wrote:
> > > > >
> > > > > When the mirred action is used on a classful egress qdisc and a p=
acket is
> > > > > mirrored or redirected to self we hit a qdisc lock deadlock.
> > > > > See trace below.
> > > > >
> > > > > [..... other info removed for brevity....]
> > > > > [   82.890906]
> > > > > [   82.890906] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > > [   82.890906] WARNING: possible recursive locking detected
> > > > > [   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: G   =
     W
> > > > > [   82.890906] --------------------------------------------
> > > > > [   82.890906] ping/418 is trying to acquire lock:
> > > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > > > > __dev_queue_xmit+0x1778/0x3550
> > > > > [   82.890906]
> > > > > [   82.890906] but task is already holding lock:
> > > > > [   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
> > > > > __dev_queue_xmit+0x1778/0x3550
> > > > > [   82.890906]
> > > > > [   82.890906] other info that might help us debug this:
> > > > > [   82.890906]  Possible unsafe locking scenario:
> > > > > [   82.890906]
> > > > > [   82.890906]        CPU0
> > > > > [   82.890906]        ----
> > > > > [   82.890906]   lock(&sch->q.lock);
> > > > > [   82.890906]   lock(&sch->q.lock);
> > > > > [   82.890906]
> > > > > [   82.890906]  *** DEADLOCK ***
> > > > > [   82.890906]
> > > > > [..... other info removed for brevity....]
> > > > >
> > > > > Example setup (eth0->eth0) to recreate
> > > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> > > > >      action mirred egress redirect dev eth0
> > > > >
> > > > > Another example(eth0->eth1->eth0) to recreate
> > > > > tc qdisc add dev eth0 root handle 1: htb default 30
> > > > > tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
> > > > >      action mirred egress redirect dev eth1
> > > > >
> > > > > tc qdisc add dev eth1 root handle 1: htb default 30
> > > > > tc filter add dev eth1 handle 1: protocol ip prio 2 matchall \
> > > > >      action mirred egress redirect dev eth0
> > > > >
> > > > > We fix this by adding a per-cpu, per-qdisc recursion counter whic=
h is
> > > > > incremented the first time a root qdisc is entered and on a secon=
d attempt
> > > > > enter the same root qdisc from the top, the packet is dropped to =
break the
> > > > > loop.
> > > > >
> > > > > Reported-by: renmingshuai@huawei.com
> > > > > Closes: https://lore.kernel.org/netdev/20240314111713.5979-1-renm=
ingshuai@huawei.com/
> > > > > Fixes: 3bcb846ca4cf ("net: get rid of spin_trylock() in net_tx_ac=
tion()")
> > > > > Fixes: e578d9c02587 ("net: sched: use counter to break reclassify=
 loops")
> > > > > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > ---
> > > > >  include/net/sch_generic.h |  2 ++
> > > > >  net/core/dev.c            |  9 +++++++++
> > > > >  net/sched/sch_api.c       | 12 ++++++++++++
> > > > >  net/sched/sch_generic.c   |  2 ++
> > > > >  4 files changed, 25 insertions(+)
> > > > >
> > > > > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.=
h
> > > > > index cefe0c4bdae3..f9f99df037ed 100644
> > > > > --- a/include/net/sch_generic.h
> > > > > +++ b/include/net/sch_generic.h
> > > > > @@ -125,6 +125,8 @@ struct Qdisc {
> > > > >         spinlock_t              busylock ____cacheline_aligned_in=
_smp;
> > > > >         spinlock_t              seqlock;
> > > > >
> > > > > +       u16 __percpu            *xmit_recursion;
> > > > > +
> > > > >         struct rcu_head         rcu;
> > > > >         netdevice_tracker       dev_tracker;
> > > > >         /* private data */
> > > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > > index 9a67003e49db..2b712388c06f 100644
> > > > > --- a/net/core/dev.c
> > > > > +++ b/net/core/dev.c
> > > > > @@ -3789,6 +3789,13 @@ static inline int __dev_xmit_skb(struct sk=
_buff *skb, struct Qdisc *q,
> > > > >         if (unlikely(contended))
> > > > >                 spin_lock(&q->busylock);
> > > >
> > > > This could hang here (busylock)
> > >
> > > Notice the goto free_skb_list has an spin_unlock(&q->busylock);  in
> > > its code vicinity. Am I missing something?
> >
> > The hang would happen in above spin_lock(&q->busylock), before you can
> > get a chance...
> >
> > If you want to test your patch, add this debugging feature, pretending
> > the spinlock is contended.
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 818699dea9d7040ee74532ccdebf01c4fd6887cc..b2fe3aa2716f0fe128ef10f=
9d06c2431b3246933
> > 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3816,7 +3816,7 @@ static inline int __dev_xmit_skb(struct sk_buff
> > *skb, struct Qdisc *q,
> >          * sent after the qdisc owner is scheduled again. To prevent th=
is
> >          * scenario the task always serialize on the lock.
> >          */
> > -       contended =3D qdisc_is_running(q) || IS_ENABLED(CONFIG_PREEMPT_=
RT);
> > +       contended =3D true; // DEBUG for Jamal
> >         if (unlikely(contended))
> >                 spin_lock(&q->busylock);
>
> Will do.

Finally got time to look again. Probably being too clever, but moving
the check before the contended check resolves it as well. The only
strange thing is now with the latest net-next seems to be spitting
some false positive lockdep splat for the test of A->B->A (i am sure
it's fixable).

See attached. Didnt try the other idea, see if you like this one.

cheers,
jamal
> > >
> > > >
> > > > >
> > > > > +       if (__this_cpu_read(*q->xmit_recursion) > 0) {
> > > > > +               __qdisc_drop(skb, &to_free);
> > > > > +               rc =3D NET_XMIT_DROP;
> > > > > +               goto free_skb_list;
> > > > > +       }
> > > >
> > > >
> > > > I do not think we want to add yet another cache line miss and
> > > > complexity in tx fast path.
> > > >
> > >
> > > I empathize. The cache miss is due to a per-cpu variable? Otherwise
> > > that seems to be in the vicinity of the other fields being accessed i=
n
> > > __dev_xmit_skb()
> > >
> > > > I think that mirred should  use a separate queue to kick a transmit
> > > > from the top level.
> > > >
> > > > (Like netif_rx() does)
> > > >
> > >
> > > Eric, here's my concern: this would entail restructuring mirred
> > > totally just to cater for one use case which is in itself _a bad
> > > config_ for egress qdisc case only.
> >
> > Why can't the bad config be detected in the ctl path ?
> >
>
> We actually discussed this. It looks simple until you dig in. To catch
> this issue we will need to store some state across ports. This can be
> done with a graph construct in the control plane. Assume the following
> cases matching header "foo" (all using htb or other classful qdiscs):
>
> case 1:
> flower match foo on eth0 redirect to egress of eth0
>
> This is easy to do. Your graph can check if src is eth0 and dst is eth0.
>
> Case 2:
> flower match foo on eth0 redirect to eth1
> flower match foo on eth1 redirect to eth0
>
> Now your graph has to keep state across netdevs. You can catch this
> issue as well (but your "checking" code is now growing).
>
> case 3:
> flower match foo on eth0 redirect to eth1
> flower match bar on eth1 redirect to eth0
>
> There is clearly no loop here because we have different headers, but
> you will have to add code to check for such a case.
>
> case 4:
> flower match foo on eth0 redirect to eth1
> u32 match foo on eth1 redirect to eth0
>
> Now you have to add code that checks all other classifiers(worse would
> be ebpf) for matching headers. Worse is you have to consider wild
> card. I am also likely missing some other use cases.
> Also, I am sure we'll very quickly hear from people who want very fast
> insertion rates of filters which now are going to be massively slowed
> down when using mirred.
> So i am sure it can be done, just not worth the effort given how many
> lines of code would need to be added to catch a corner case of bad
> config.
>
> >  Mirred is very heavily used in
> > > many use cases and changing its behavior could likely introduce other
> > > corner cases for some use cases which we would be chasing for a while=
.
> > > Not to forget now we have to go via an extra transient queue.
> > > If i understood what you are suggesting is to add an equivalent of
> > > backlog queu for the tx side? I am assuming in a very similar nature
> > > to backlog, meaning per cpu fired by softirq? or is it something
> > > closer to qdisc->gso_skb
> > > For either of those cases, the amount of infrastructure code there is
> > > not a few lines of code. And then there's the desire to break the loo=
p
> > > etc.
> > >
> > > Some questions regarding your proposal - something I am not following
> > > And i may have misunderstood what you are suggesting, but i am missin=
g
> > > what scenario mirred can directly call tcf_dev_queue_xmit() (see my
> > > comment below)..
> >
> > I wish the act path would run without qdisc spinlock held, and use RCU =
instead.
> >
>
> The main (only?) reason we need spinlock for qdiscs is for packet queues.
>
> > Instead, we are adding cost in fast path only to detect bad configs.
>
> Agreed but I dont know how we can totally avoid it. Would you be ok
> with us using something that looks like qdisc->gso_skb and we check
> such a list after releasing the qdisc lock in __dev_xmit_skb() to
> invoke the redirect? The loop then can be caught inside mirred.
>
> cheers,
> jamal

--0000000000009c94880615c3e952
Content-Type: text/x-patch; charset="US-ASCII"; name="mirred-recursion-fix.patch"
Content-Disposition: attachment; filename="mirred-recursion-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_luu9ljn60>
X-Attachment-Id: f_luu9ljn60

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3NjaF9nZW5lcmljLmggYi9pbmNsdWRlL25ldC9zY2hf
Z2VuZXJpYy5oCmluZGV4IDc2ZGI2YmUxNjA4My4uZjg2MDU0NWYxN2Q1IDEwMDY0NAotLS0gYS9p
bmNsdWRlL25ldC9zY2hfZ2VuZXJpYy5oCisrKyBiL2luY2x1ZGUvbmV0L3NjaF9nZW5lcmljLmgK
QEAgLTEyNSw2ICsxMjUsOCBAQCBzdHJ1Y3QgUWRpc2MgewogCXNwaW5sb2NrX3QJCWJ1c3lsb2Nr
IF9fX19jYWNoZWxpbmVfYWxpZ25lZF9pbl9zbXA7CiAJc3BpbmxvY2tfdAkJc2VxbG9jazsKIAor
CXUxNiBfX3BlcmNwdSAgICAgICAgICAgICp4bWl0X3JlY3Vyc2lvbjsKKwogCXN0cnVjdCByY3Vf
aGVhZAkJcmN1OwogCW5ldGRldmljZV90cmFja2VyCWRldl90cmFja2VyOwogCS8qIHByaXZhdGUg
ZGF0YSAqLwpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvZGV2LmMgYi9uZXQvY29yZS9kZXYuYwppbmRl
eCA4NTRhM2EyOGE4ZDguLmQ2NmY2ODAxOGFjNyAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvZGV2LmMK
KysrIGIvbmV0L2NvcmUvZGV2LmMKQEAgLTM4MDgsNiArMzgwOCwxNCBAQCBzdGF0aWMgaW5saW5l
IGludCBfX2Rldl94bWl0X3NrYihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgUWRpc2MgKnEs
CiAJCXJldHVybiByYzsKIAl9CiAKKwlpZiAoX190aGlzX2NwdV9yZWFkKCpxLT54bWl0X3JlY3Vy
c2lvbikgPiAwKSB7CisJCV9fcWRpc2NfZHJvcChza2IsICZ0b19mcmVlKTsKKwkJa2ZyZWVfc2ti
X2xpc3RfcmVhc29uKHRvX2ZyZWUsCisJCQkJICAgICAgdGNmX2dldF9kcm9wX3JlYXNvbih0b19m
cmVlKSk7CisJCXJldHVybiBORVRfWE1JVF9EUk9QOworCX0KKwlfX3RoaXNfY3B1X2luYygqcS0+
eG1pdF9yZWN1cnNpb24pOworCiAJLyoKIAkgKiBIZXVyaXN0aWMgdG8gZm9yY2UgY29udGVuZGVk
IGVucXVldWVzIHRvIHNlcmlhbGl6ZSBvbiBhCiAJICogc2VwYXJhdGUgbG9jayBiZWZvcmUgdHJ5
aW5nIHRvIGdldCBxZGlzYyBtYWluIGxvY2suCkBAIC0zODYzLDYgKzM4NzEsNyBAQCBzdGF0aWMg
aW5saW5lIGludCBfX2Rldl94bWl0X3NrYihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgUWRp
c2MgKnEsCiAJCQkJICAgICAgdGNmX2dldF9kcm9wX3JlYXNvbih0b19mcmVlKSk7CiAJaWYgKHVu
bGlrZWx5KGNvbnRlbmRlZCkpCiAJCXNwaW5fdW5sb2NrKCZxLT5idXN5bG9jayk7CisJX190aGlz
X2NwdV9kZWMoKnEtPnhtaXRfcmVjdXJzaW9uKTsKIAlyZXR1cm4gcmM7CiB9CiAKZGlmZiAtLWdp
dCBhL25ldC9zY2hlZC9zY2hfYXBpLmMgYi9uZXQvc2NoZWQvc2NoX2FwaS5jCmluZGV4IDYwMjM5
Mzc4ZDQzZi4uNzYyMWRjN2QxZDQ1IDEwMDY0NAotLS0gYS9uZXQvc2NoZWQvc2NoX2FwaS5jCisr
KyBiL25ldC9zY2hlZC9zY2hfYXBpLmMKQEAgLTEyNjAsNiArMTI2MCw3IEBAIHN0YXRpYyBzdHJ1
Y3QgUWRpc2MgKnFkaXNjX2NyZWF0ZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAogCXN0cnVjdCBR
ZGlzYyAqc2NoOwogCXN0cnVjdCBRZGlzY19vcHMgKm9wczsKIAlzdHJ1Y3QgcWRpc2Nfc2l6ZV90
YWJsZSAqc3RhYjsKKwlpbnQgY3B1OwogCiAJb3BzID0gcWRpc2NfbG9va3VwX29wcyhraW5kKTsK
ICNpZmRlZiBDT05GSUdfTU9EVUxFUwpAQCAtMTM3NiwxMSArMTM3NywyMiBAQCBzdGF0aWMgc3Ry
dWN0IFFkaXNjICpxZGlzY19jcmVhdGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKIAkJfQogCX0K
IAorCXNjaC0+eG1pdF9yZWN1cnNpb24gPSBhbGxvY19wZXJjcHUodTE2KTsKKwlpZiAoIXNjaC0+
eG1pdF9yZWN1cnNpb24pIHsKKwkJZXJyID0gLUVOT01FTTsKKwkJZ290byBlcnJfb3V0NTsKKwl9
CisJZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkKKwkJKCpwZXJfY3B1X3B0cihzY2gtPnhtaXRf
cmVjdXJzaW9uLCBjcHUpKSA9IDA7CisKIAlxZGlzY19oYXNoX2FkZChzY2gsIGZhbHNlKTsKIAl0
cmFjZV9xZGlzY19jcmVhdGUob3BzLCBkZXYsIHBhcmVudCk7CiAKIAlyZXR1cm4gc2NoOwogCitl
cnJfb3V0NToKKwlpZiAodGNhW1RDQV9SQVRFXSkKKwkJZ2VuX2tpbGxfZXN0aW1hdG9yKCZzY2gt
PnJhdGVfZXN0KTsKIGVycl9vdXQ0OgogCS8qIEV2ZW4gaWYgb3BzLT5pbml0KCkgZmFpbGVkLCB3
ZSBjYWxsIG9wcy0+ZGVzdHJveSgpCiAJICogbGlrZSBxZGlzY19jcmVhdGVfZGZsdCgpLgpkaWZm
IC0tZ2l0IGEvbmV0L3NjaGVkL3NjaF9nZW5lcmljLmMgYi9uZXQvc2NoZWQvc2NoX2dlbmVyaWMu
YwppbmRleCBmZjUzMzY0OTM3NzcuLmFmYmJkMmU4ODVhNCAxMDA2NDQKLS0tIGEvbmV0L3NjaGVk
L3NjaF9nZW5lcmljLmMKKysrIGIvbmV0L3NjaGVkL3NjaF9nZW5lcmljLmMKQEAgLTEwNzAsNiAr
MTA3MCw4IEBAIHN0YXRpYyB2b2lkIF9fcWRpc2NfZGVzdHJveShzdHJ1Y3QgUWRpc2MgKnFkaXNj
KQogCW1vZHVsZV9wdXQob3BzLT5vd25lcik7CiAJbmV0ZGV2X3B1dChkZXYsICZxZGlzYy0+ZGV2
X3RyYWNrZXIpOwogCisJZnJlZV9wZXJjcHUocWRpc2MtPnhtaXRfcmVjdXJzaW9uKTsKKwogCXRy
YWNlX3FkaXNjX2Rlc3Ryb3kocWRpc2MpOwogCiAJY2FsbF9yY3UoJnFkaXNjLT5yY3UsIHFkaXNj
X2ZyZWVfY2IpOwo=
--0000000000009c94880615c3e952--

