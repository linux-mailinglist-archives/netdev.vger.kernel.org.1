Return-Path: <netdev+bounces-243411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8EBC9F468
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 15:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC583A5EE2
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6A42FB62A;
	Wed,  3 Dec 2025 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qdNUg1yC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B4226CFE
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764771811; cv=none; b=FRL//sQqsE6ReEA56i7/vdtXZubgDvDcGF4MMOjVQoSg7kCh7RZG5GR297+uzhJo/QjhGRiM6/u8nt3Pga/0YWfRN/44N5jezSDV4/GO2d7a6nlL7Ontu3JLNSNNkgRTpf69BRi+9bWt/gB7aX/ATrC1AAv183PGpajxi2uKtY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764771811; c=relaxed/simple;
	bh=SqQ7gL6+iQAXqHpFjwjzI0tlqPyV6DtImcU6SWYKhC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsezhsXj2Gvhn3/3Zsa36RCYwNWze1pc0fyVxXrnSatLLIjhRYChTlKCdbde6O2DNDBcvFFzp/xcbRaDfSADc03nCJ4uXcc39vOtfu46cNMI8EekkPqKTXokwYPr4whXqH44ebqd5JgkTRQqIep9u8XsLJIf18bsBFNhgUWdEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qdNUg1yC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso7819099b3a.2
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 06:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764771809; x=1765376609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HeQEoCjuAQ7jItRf9nQvnwSP0XvjQjVOvUue26JfYQ=;
        b=qdNUg1yCmaygyTYh6ZeA241L0+KYPVge+GZoxoUUrFhPW+QvKucg2WlNCRHy7kSbsp
         WHCbDXiznZyynPnWlgHs+ZJ02j/zrzp2eL22bAmJ88vxH2Psf2ARU/HF+Z58M3LO00Xq
         zf2U1O+Anu8PodOTrDnwsQZZd+dtr8tVzVDU++o6b1p2/o7bO0ndZvEu+GU4Vh4I22+2
         GausuwAFHIjOznhWxG3Mgi1wLOZ5i9awRmyWqIP7D13T1STqCq45bs+MhrrBXSoajPCM
         Q7Sj9liK18jBSJ/PlODEsnBwLFU866XRw0nmHRergDNH3TMtduulrNAFQE9C5WQ1mXAn
         FcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764771809; x=1765376609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6HeQEoCjuAQ7jItRf9nQvnwSP0XvjQjVOvUue26JfYQ=;
        b=cdImZVooBCeG4x+Vk4GYv8KIhyIHvQ4DxMI+aTyWJar+wLwdkfe3a5HA5nq4YwB+X6
         zURloGpfkQNuEXfBaVKJYr013mQYl4IKkDx7n28IrtrDMJmUjTdCOjifVRXghWbSV/WP
         VNzEa6DPrK+Q+27CiFDijnrs+eXbKosblsyvgclilDT/fE4wncYM09WF9JuLNzbAwdF4
         Q2QeFYqfKE4pWoNxVR6sizE3YsWk+WPkE4TLGCR5iQtjJbBawwmSwjAc1sHLR9XVvAds
         Bt33m7xhDfSf7Hi0wKfMmP5yo2Zg4SsBUq96BFC9H/khlah3qXKylXyP7G2QWKuoo6Zi
         ow3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXg1OzPcSo7PiTn7HTy0+DY/NwqsgAMNuKPbdDTHxjxhcs4nShWGJQyaTx+zGZdUw2RGdkgziQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvzeIJDvNH6SagCVBbwwHYvp+kLKXHWOYFf86HXXuhR+8qH2S0
	1bxU0Yqa5lXllwnKBnS/KDvPtu07uq/+fFX2vkLxXGXXTJNgLeaUj/7wsfCzu0DYO4Kc5+D99F/
	AMNDaXdzqWMITjuufFxD/EEY6q1sro/ZEdzsrZ7CbJxNmsC5gjgx+xQ==
X-Gm-Gg: ASbGncsHF+KyEKjOJYIQHSrZjf+xalZuoYl3sgjpEcTkn790GKUZDNh+/pTo2alOiw3
	ewc4nEqxCKFzWeaXfumAG4mKJ9csKWJhA9WQJkE5F70JFJT8E1Xv5VoJ8nz2AxR0PAxRNGV0IqI
	KqDawbVEh8iQWNVLRl8mE2+/zoYXHMO+wFFu98Us8AyAhz3mx1Ao7MYb2BYPYydMnkz8jCRH1yz
	KtguRXpQ8twoQ608qEHvIwvwBNkHk22J0caDj0bVr84Kf8u4bPzPCKTJ838ZUtKmJUceXsKSfh1
	LVU=
X-Google-Smtp-Source: AGHT+IG2swXIqpbbJlHz2BG4nFcxsTpyYyADhPnGdPvYEQjhpj7aMe7r9YFgBidfm1iSLqpzrK4ziH6DDHuSCH1cAmo=
X-Received: by 2002:a05:6a00:1142:b0:7a2:1b8a:ca22 with SMTP id
 d2e1a72fcca58-7e00f322872mr2653829b3a.25.1764771808692; Wed, 03 Dec 2025
 06:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128151919.576920-1-jhs@mojatatu.com> <aSna9hYKaG7xvYSn@dcaratti.users.ipa.redhat.com>
 <CAM0EoMmtqe_09jpG8-HzTVKNs2gfi_qNNCDq4Y4CayRVuDF4Jg@mail.gmail.com> <aS630uTBI26gLBTZ@dcaratti.users.ipa.redhat.com>
In-Reply-To: <aS630uTBI26gLBTZ@dcaratti.users.ipa.redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 3 Dec 2025 09:23:17 -0500
X-Gm-Features: AWmQ_bn4jKrZuo_ODJVaHq-0zPpM8Ft7OUFDcr2_k_TVawOVYTk1mT9eYbuv_Vw
Message-ID: <CAM0EoMnEU1gLNn4XNbq=rG14iVh_XqU32P3y_8K8+fvRbmWrvA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: ets: Always remove class from active list
 before deleting in ets_qdisc_change
To: Davide Caratti <dcaratti@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, horms@kernel.org, zdi-disclosures@trendmicro.com, 
	w@1wt.eu, security@kernel.org, tglx@linutronix.de, victor@mojatatu.com, 
	Petr Machata <petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I totally forgot to add Petr in the original post, he's on Cc now..

On Tue, Dec 2, 2025 at 4:56=E2=80=AFAM Davide Caratti <dcaratti@redhat.com>=
 wrote:
>
> On Fri, Nov 28, 2025 at 03:52:53PM -0500, Jamal Hadi Salim wrote:
> > Hi Davide,
> >
> > On Fri, Nov 28, 2025 at 12:25=E2=80=AFPM Davide Caratti <dcaratti@redha=
t.com> wrote:
>
> hello Jamal, thanks for your patience!
>
> [...]
>
> > > > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > > > index 82635dd2cfa5..ae46643e596d 100644
> > > > --- a/net/sched/sch_ets.c
> > > > +++ b/net/sched/sch_ets.c
> > > > @@ -652,7 +652,7 @@ static int ets_qdisc_change(struct Qdisc *sch, =
struct nlattr *opt,
> > > >       sch_tree_lock(sch);
> > > >
> > > >       for (i =3D nbands; i < oldbands; i++) {
> > > > -             if (i >=3D q->nstrict && q->classes[i].qdisc->q.qlen)
> > > > +             if (cl_is_active(&q->classes[i]))
> > > >                       list_del_init(&q->classes[i].alist);
> > > >               qdisc_purge_queue(q->classes[i].qdisc);
> > > >       }
> > >
> > > (nit)
> > >
> > > the reported problem is NULL dereference of q->classes[i].qdisc, then
> > > probably the 'Fixes' tag is an hash precedent to de6d25924c2a ("net/s=
ched: sch_ets: don't
> > > peek at classes beyond 'nbands'"). My understanding is: the test on '=
q->classes[i].qdisc'
> > > is no more NULL-safe after 103406b38c60 ("net/sched: Always pass noti=
fications when
> > > child class becomes empty"). So we might help our friends  planning b=
ackports with something like:
> > >
> > > Fixes: de6d25924c2a ("net/sched: sch_ets: don't peek at classes beyon=
d 'nbands'")
> > > Fixes: c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes f=
rom the round-robin list")
> > >
> > > WDYT?
> >
> > I may be misreading your thought process, seems you are thinking the
> > null ptr deref is in change()?
> > The null ptr deref (and the uaf if you add a delay) is in dequeue
> > (ets_qdisc_dequeue()) i.e not in change.
>
> I understand this - it happens to DRR classes that are beyond 'nbands'
> after the call to ets_qdisc_change(). Since those queues can have some pa=
ckets
> stored, in ets_qdisc_dequeue() you might have observed:
>
> 480                 cl =3D list_first_entry(&q->active, struct ets_class,=
 alist);
> 481                 skb =3D cl->qdisc->ops->peek(cl->qdisc);
>
> with a "problematic" value in cl->qdisc. That's why I suggest to add
>
> [1] Fixes: de6d25924c2a ("net/sched: sch_ets: don't peek at classes beyon=
d 'nbands'")
>

Ok, so that was the initial attempt to fix this issue?

> in the metadata.
>
> > If that makes sense, what would be a more appropriate Fixes?
>
> the line you are changing in the patch above was added with:
>
> c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from the rou=
nd-robin list")
>
> and the commit message said:
>

> << we can remove 'q->classes[i].alist' only if DRR class 'i' was part of =
the active
>    list. In the ETS scheduler DRR classes belong to that list only if the=
 queue length
>    is greater than zero >>
>
> this assumption on the queue length is no more valid, maybe it has never =
been valid :),
> hence my suggestion to add also
>
> [2] Fixes: c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes f=
rom the round-robin list")
>

ok, so this seems to be a followup attempt to the first one.
I have a question: Shouldnt we be listing all the commits in Fixes if
subsequent patches are fixing a previous one? Example, this one has a
Fixes: de6d25924c2a - which is the previous one? IOW, would it not be
fine to only mention c062f2a0b04d and not de6d25924c2a?

> > BTW, is that q->classes[i].qdisc =3D NULL even needed after this?
> > It was not clear whether it guards against something else that was not
> > obvious from inspection.
>
> That NULL assignment is done in ets_qdisc_change() since the beginning: f=
or classes
> beyond 'nbands' we had
>
>         for (i =3D q->nbands; i < oldbands; i++) {
>                 qdisc_put(q->classes[i].qdisc);
>                 memset(&q->classes[i], 0, sizeof(q->classes[i]));
>
> in the very first implementation of sch_ets that memset() was wrongly ove=
rwriting 'alist'.

Ok. makes sense - i see it in the original patch from Petr.

> The NULL assignment is not strictly necessary, but any value of 'q->class=
es[i].qdisc'
> is either a UAF or a NULL dereference when 'i' is greater or equal to 'q-=
>nbands'.

I agree - before this one liner fix. I do think it is not necessary
any longer, but wont touch it for now in case there are other
dependencies

> I see that ETS sometimes assigns the noop qdisc there: maybe we can assig=
n that to
> 'q->classes[i].qdisc' when 'i' is greater or equal to 'q->nbands', instea=
d of NULL ?

I wouldnt go that far. What i can tell you is removing it didnt matter
in both what i and Victor tested.

> so the value of 'q->classes[i].qdisc' is a valid pointer all the times?

Well, I don't think the nstrict classes should have gone into that
alist to begin with (looking at the trick test that  made you issue
the first commit - that is what the test was achieving) and since that
doesnt happen anymore we dont need to worry about it.

> In case it makes some
> sense, that would be a follow-up patch targeting net-next that I can test=
 and send. Any
> feedback appreciated!
>

We'll see if it is worth it. Some more testing is needed.

cheers,
jamal


> thanks,
> --
> davide
>
>

