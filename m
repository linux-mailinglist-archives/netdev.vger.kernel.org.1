Return-Path: <netdev+bounces-160402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286C0A198A2
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB56188D8E3
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A82215777;
	Wed, 22 Jan 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="xRBeXi1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC271215166
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571230; cv=none; b=sAI0ibV5Yq5OrgkE9EHHMCjHVifHnfZ6XX6tzAfoIToEeVzT7mPmdCIJtpikzVxUjaJhP2/Uq2fG88UbXC8DGTqdVSpMtYEIyT2SOlP9jNBWcySclqbgqoXY6tByGN0UbrL61XfcfodbyUA9S8McEdQmQLwO099l68uHxxJAN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571230; c=relaxed/simple;
	bh=qzwyfkWHaIDEwnsqRZyPF2yxBUjt8m2Vz2wT88VCHps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpworDcYhuK9VKHRPj8/JYwTfxF0TV9z78FrFpsHOcj1fPfsoCXS7eJoZKCMqEXtg9nuM+eo18MvX5xAanjCfhZpHAY8M9tMHtbvE1uAHP6HxnK7YUsn0tb0jeS0YiZQJS1wzZYPXpNVjzURYKvH7drxUuRdfGEnDh4Z04rpZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=xRBeXi1Y; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so214653a91.2
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1737571228; x=1738176028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1jra0AvNRAJo1epsyC8U5EtbRwp75qm0nhwitN+0q0=;
        b=xRBeXi1YTBZKDpgvIkE+nFHQp7Xvsohy0IF8GYvsTtC2CD/UXorWDPL1wx8MVX6679
         6qoEhjDmTdj8ydCyeFlkdCYViH0GsCwEph6TbBkK7MdYkCB/Vw4nwp30+TxfqEb4eVjQ
         o2gZ8m21CsxRMrXYM7MgPtravuURbq+Zihx7sDzHCNfXjjpwdkjHAvIAWr8q1pIoW+9G
         4KxW9SgYwG3jH7t/NQnkCV3KZNipw6TNJgHxchWaibKw49RPX3Z50osA95aPmJAiXF9x
         xxIFC8rf+epYxHodS1bm6FTgJWtC5iAGhgA2eocz66hrzDCNBZ8E8ToDwXkYKULOhQAZ
         CymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737571228; x=1738176028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1jra0AvNRAJo1epsyC8U5EtbRwp75qm0nhwitN+0q0=;
        b=fC4yJ451W5iMQu0JB4zj3rJYvYUdpgITB5N5e4BeHDtQV+N4mjiiQZG9nZxQOI9au9
         3peBPZ7KhOFnmBotNyqtt+qcrD11kZxzZCe/m54XuCtIGJlyTJtWZIf7923VFkC5L7hJ
         hPrhQ7R0sDyHZpP+t46r3ehlqNtDO/WhNiKNhyLWBgL4CnkhjF1YVgQQ30Kclo50ZCJk
         4LKeq6B6HJIyo4GZAgAI5jAu4tcZwaObxOi2D+5O1s+AX96JfrfvON5sAuJh3NTz5r8x
         IJQLVLbpVsJvpjCppZkg0+alQ0YFibPiHAshElSMkQ6J0fMMXWt0pcEEECU8Vu/1oPU9
         CeEA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4HaS9OJoAsA/Q3pIQgFrGH20jJRn1PMC5U+4FXAnnSVDdGT8bNgbmTAoS24zXGDLZEQWiHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA89MtJDLtBkfuiP3NDi6lOy9E9s5GvYFhO1Ln3RwaBFn3bq3u
	Z73fwvfGQoGxdBUWiDUZl6akNn2yu744x6hd8y9kqJEuclGlKW4RxoHT4rwfuPF62xKx6HoBcq+
	AU/kmDBcdBiSfveUs1szti45M9Aq8vBaZRbeU
X-Gm-Gg: ASbGncs16ucqsPI3/hHagcgXMo04T137kxoi8lms6C8kHzUXhsAvning98CJJbKkHTL
	e9uumlEW8CcHEk9MtjzQEShlDvRVBX8qRQm/5z2OdC1SFzitllw==
X-Google-Smtp-Source: AGHT+IELf7WZ7T+NpLudeM+1LFYtQDz+wqwvYulFDI2ibRfMn4noaOP007n345t2ouekyWh1loHSxxDsA4dAAl7qA/U=
X-Received: by 2002:a05:6a00:460e:b0:726:54f1:d133 with SMTP id
 d2e1a72fcca58-72dafa44498mr32767071b3a.12.1737571226645; Wed, 22 Jan 2025
 10:40:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111145740.74755-1-jhs@mojatatu.com> <Z4RWFNIvS31kVhvA@pop-os.localdomain>
 <87zfjvqa6w.fsf@nvidia.com> <CAM0EoMkvOOgT-SU1A7=29Tz1JrqpO7eDsoQAXQsYjCGds=1C-w@mail.gmail.com>
 <Z4iM3qHZ6R9Ae1uk@pop-os.localdomain> <66ba9652-5f9e-4a15-9eec-58ad78cbd745@redhat.com>
 <CAM0EoMkReTgA+OnjXp3rm=DYdYE96DUYwGNjLoCyUK+yP9hehQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkReTgA+OnjXp3rm=DYdYE96DUYwGNjLoCyUK+yP9hehQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 22 Jan 2025 13:40:15 -0500
X-Gm-Features: AbW1kvZKDnu_eBLKmL7BTqPRYAVVhDxFXsF-bhE2E6VbKdUlH5etToBKB9RFtDM
Message-ID: <CAM0EoMkPHKW8WPG4t2V-6wpCcnnuV5y1fs0OmVAaBYcPnbMmkQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] net: sched: fix ets qdisc OOB Indexing
To: Paolo Abeni <pabeni@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	petrm@mellanox.com, security@kernel.org, g1042620637@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 8:35=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Jan 16, 2025 at 3:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > Hi,
> >
> > On 1/16/25 5:36 AM, Cong Wang wrote:
> > > On Mon, Jan 13, 2025 at 06:47:02AM -0500, Jamal Hadi Salim wrote:
> > >> On Mon, Jan 13, 2025 at 5:29=E2=80=AFAM Petr Machata <petrm@nvidia.c=
om> wrote:
> > >>>
> > >>>
> > >>> Cong Wang <xiyou.wangcong@gmail.com> writes:
> > >>>
> > >>>> On Sat, Jan 11, 2025 at 09:57:39AM -0500, Jamal Hadi Salim wrote:
> > >>>>> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > >>>>> index f80bc05d4c5a..516038a44163 100644
> > >>>>> --- a/net/sched/sch_ets.c
> > >>>>> +++ b/net/sched/sch_ets.c
> > >>>>> @@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned =
long arg)
> > >>>>>  {
> > >>>>>      struct ets_sched *q =3D qdisc_priv(sch);
> > >>>>>
> > >>>>> +    if (arg =3D=3D 0 || arg > q->nbands)
> > >>>>> +            return NULL;
> > >>>>>      return &q->classes[arg - 1];
> > >>>>>  }
> > >>>>
> > >>>> I must miss something here. Some callers of this function don't ha=
ndle
> > >>>> NULL at all, so are you sure it is safe to return NULL for all the
> > >>>> callers here??
> > >>>>
> > >>>> For one quick example:
> > >>>>
> > >>>> 322 static int ets_class_dump_stats(struct Qdisc *sch, unsigned lo=
ng arg,
> > >>>> 323                                 struct gnet_dump *d)
> > >>>> 324 {
> > >>>> 325         struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> > >>>> 326         struct Qdisc *cl_q =3D cl->qdisc;
> > >>>>
> > >>>> 'cl' is not checked against NULL before dereferencing it.
> > >>>>
> > >>>> There are other cases too, please ensure _all_ of them handle NULL
> > >>>> correctly.
> > >>>
> > >>> Yeah, I looked through ets_class_from_arg() callers last week and I
> > >>> think that besides the one call that needs patching, which already
> > >>> handles NULL, in all other cases the arg passed to ets_class_from_a=
rg()
> > >>> comes from class_find, and therefore shouldn't cause the NULL retur=
n.
> > >>
> > >> Exactly.
> > >> Regardless - once the nodes are created we are guaranteed non-null.
> > >> See other qdiscs, not just ets.
> > >
> > > The anti-pattern part is that we usually pass the pointer instead of
> > > classid with these 'arg', hence it is unsigned long. In fact, for
> > > ->change(), classid is passed as the 2nd parameter, not the 5th.
> > > The pointer should come from the return value of ->find().
> > >
> > > Something like the untested patch below.
> > >
> > > Thanks.
> > >
> > > ---->
> > >
> > > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > > index f80bc05d4c5a..3b7253e8756f 100644
> > > --- a/net/sched/sch_ets.c
> > > +++ b/net/sched/sch_ets.c
> > > @@ -86,12 +86,9 @@ static int ets_quantum_parse(struct Qdisc *sch, co=
nst struct nlattr *attr,
> > >       return 0;
> > >  }
> > >
> > > -static struct ets_class *
> > > -ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
> > > +static struct ets_class *ets_class_from_arg(unsigned long arg)
> > >  {
> > > -     struct ets_sched *q =3D qdisc_priv(sch);
> > > -
> > > -     return &q->classes[arg - 1];
> > > +     return (struct ets_class *) arg;
> > >  }
> > >
> > >  static u32 ets_class_id(struct Qdisc *sch, const struct ets_class *c=
l)
> > > @@ -198,7 +195,7 @@ static int ets_class_change(struct Qdisc *sch, u3=
2 classid, u32 parentid,
> > >                           struct nlattr **tca, unsigned long *arg,
> > >                           struct netlink_ext_ack *extack)
> > >  {
> > > -     struct ets_class *cl =3D ets_class_from_arg(sch, *arg);
> > > +     struct ets_class *cl =3D ets_class_from_arg(*arg);
> > >       struct ets_sched *q =3D qdisc_priv(sch);
> > >       struct nlattr *opt =3D tca[TCA_OPTIONS];
> > >       struct nlattr *tb[TCA_ETS_MAX + 1];
> > > @@ -248,7 +245,7 @@ static int ets_class_graft(struct Qdisc *sch, uns=
igned long arg,
> > >                          struct Qdisc *new, struct Qdisc **old,
> > >                          struct netlink_ext_ack *extack)
> > >  {
> > > -     struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> > > +     struct ets_class *cl =3D ets_class_from_arg(arg);
> > >
> > >       if (!new) {
> > >               new =3D qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_=
ops,
> > > @@ -266,7 +263,7 @@ static int ets_class_graft(struct Qdisc *sch, uns=
igned long arg,
> > >
> > >  static struct Qdisc *ets_class_leaf(struct Qdisc *sch, unsigned long=
 arg)
> > >  {
> > > -     struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> > > +     struct ets_class *cl =3D ets_class_from_arg(arg);
> > >
> > >       return cl->qdisc;
> > >  }
> > > @@ -278,12 +275,12 @@ static unsigned long ets_class_find(struct Qdis=
c *sch, u32 classid)
> > >
> > >       if (band - 1 >=3D q->nbands)
> > >               return 0;
> > > -     return band;
> > > +     return (unsigned long)&q->classes[band - 1];
> > >  }
> > >
> > >  static void ets_class_qlen_notify(struct Qdisc *sch, unsigned long a=
rg)
> > >  {
> > > -     struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> > > +     struct ets_class *cl =3D ets_class_from_arg(arg);
> > >       struct ets_sched *q =3D qdisc_priv(sch);
> > >
> > >       /* We get notified about zero-length child Qdiscs as well if th=
ey are
> > > @@ -297,7 +294,7 @@ static void ets_class_qlen_notify(struct Qdisc *s=
ch, unsigned long arg)
> > >  static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
> > >                         struct sk_buff *skb, struct tcmsg *tcm)
> > >  {
> > > -     struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> > > +     struct ets_class *cl =3D ets_class_from_arg(arg);
> > >       struct ets_sched *q =3D qdisc_priv(sch);
> > >       struct nlattr *nest;
> > >
> > > @@ -322,7 +319,7 @@ static int ets_class_dump(struct Qdisc *sch, unsi=
gned long arg,
> > >  static int ets_class_dump_stats(struct Qdisc *sch, unsigned long arg=
,
> > >                               struct gnet_dump *d)
> > >  {
> > > -     struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> > > +     struct ets_class *cl =3D ets_class_from_arg(arg);
> > >       struct Qdisc *cl_q =3D cl->qdisc;
> > >
> > >       if (gnet_stats_copy_basic(d, NULL, &cl_q->bstats, true) < 0 ||
> >
> > The blamed commit is quite old, and the fix will be propagated on
> > several stable trees. Jamal's option is IMHO more suitable to such goal=
,
> > being less invasive and with possibly less conflict.
> >
> > Would you be fine with Jamal's fix and following-up with the above on
> > net-next?
> >
>
> Agreed.
> The pattern is followed by all qdiscs, not just ets. So if we are
> fixing patterns it should be a separate patch.
>

Can we please apply this?

cheers,
jamal

