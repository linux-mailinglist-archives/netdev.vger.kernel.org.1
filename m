Return-Path: <netdev+bounces-158896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9021CA13AFB
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCECD18889E4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E5E1F3D21;
	Thu, 16 Jan 2025 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="swQjLWLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD23C1DE8B2
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034543; cv=none; b=YozNfFSb5DQOaT4eszveepkq1b1MhY0wwBrwPzFkxCZZNvA/rTMM4FbydzxU2Vvm82mBLuUIQydEZo8nLaVJBEY4I4FdwrfYy0nbepcl9FsI/fov+n2JhEeZ72IB2v69LFl9nPJ330UbzYb19Ej5BFPYUtLNn+DZJ5hCDf/Hfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034543; c=relaxed/simple;
	bh=H0Wx16kX1xBWVQqag2gm+lC3y1axrX+j36QxnIUccG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S52aYrCGF4AibqhXEwE47DkR2Q8ZEcZZp22oSml1/XGGzGP2B6+wjIqKCw6QWN75m/IPgwdmvZdSnByxcrHT01OkJGo6J0h+26gGDP9t6CPuBBVmF4lxUlxRIFqNn6W/BIRKmNPPoNO0ErkuBmNhBGr+KA9WFzrUeGFguwThXwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=swQjLWLC; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so1641774a91.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1737034541; x=1737639341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRx0D+aa1xBQPrJytprdfTEKtFZVxZXTPu2tNnI295I=;
        b=swQjLWLCbo8kQ6/qhoCL2VkD0FndKqB3KmCE2WNu1GWE7vpl2lKsEaaWh7/BqdYgDp
         sRLMiLFZTYhD1r0peuoTYJngan/KwXf1lF5YFeIRWfiiCkk0R8ZQDwTdcBtysXZ/PRwA
         0ejObAs+Fej4qI50LXD1ENtuIYICXocAklo7lI+1g9RupRspL1A7gJchZ/4AfqeNVKTG
         Shr2amCNJhsvOFuNoNlgpSWwCkD7pR6xdoEhf2M29F70sR3rDnfRJUvdmCnL4WTtF5f2
         FwS/29A5EBjRZUqUu1ovVAgTPji8CjsY39IENNzWYL5a6c3fnSbBoFWCyUGnsB6of17X
         WZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737034541; x=1737639341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRx0D+aa1xBQPrJytprdfTEKtFZVxZXTPu2tNnI295I=;
        b=nlYH4DNA+/1TBsqk/37L4hdM0iDdT+vZ5aP31UmQPzgiM1MRynREcKlWlS1+25Palm
         a20WG3wJHOzJ7j7zzP9EusEoquh+hxt5ifp8EQCyReXrBRW2thVoo1WHqq0UAK4e+LMs
         Pt1+iSyKh6dPZ6J/RESbdcZZMgGO8Jyx6jFejLkZMyDUqsg5AYIk/Soi3aLMjtoODw46
         eqDpWHE4E9mTpS367rTmPSl9HrPA0onaB4mqUdZU/JecFnw5j56vxdL77SCZo2n1E+lS
         7ztS3xP5992eb5ahA3tAdylXLOUtj6eHHdMO+EGKHAWhnYfmmajtSCIGVvxDvM+cRDvi
         8gpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPVB6sACUsS5FPd8A777iqJ7wPgn5576uS8qDE+IQPgJahgTkChKiUyoXGpqaUA8A1Xra1dVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqZUiJEk7C7oe/R5msrVdjgeNwDufqeys+6Wr/JZrgh6e74fd
	a0TsS20Thzo8K071+hQNfoJpxaewh6B923UcPIAowN4KxSb3hvGUzNVMSl3xLhFJs2ZKUmZofaH
	gFAT1I6Wb7s/4ZXk+R/qyWMYq6wYTinNb7//s
X-Gm-Gg: ASbGncszCTuCM/L4QkOvVQLPluq1/Bsd/C3yi1OhxIkbHYB9edL4H9TotFRXnfX/PKa
	G8Lur0pCscBkq/ju9g4KHFFs2Y2+YlA0UPZd2
X-Google-Smtp-Source: AGHT+IFJ8sgsIXg5i3/WJiq5YyccC7RdeepecDPeulE9L2gypwVdQcLgRPMjz6LyiifWYV01ZsX4Qe8xKcwPsJqScb8=
X-Received: by 2002:a17:90b:2d44:b0:2f4:432d:250d with SMTP id
 98e67ed59e1d1-2f548eceda2mr43653374a91.21.1737034541148; Thu, 16 Jan 2025
 05:35:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111145740.74755-1-jhs@mojatatu.com> <Z4RWFNIvS31kVhvA@pop-os.localdomain>
 <87zfjvqa6w.fsf@nvidia.com> <CAM0EoMkvOOgT-SU1A7=29Tz1JrqpO7eDsoQAXQsYjCGds=1C-w@mail.gmail.com>
 <Z4iM3qHZ6R9Ae1uk@pop-os.localdomain> <66ba9652-5f9e-4a15-9eec-58ad78cbd745@redhat.com>
In-Reply-To: <66ba9652-5f9e-4a15-9eec-58ad78cbd745@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 16 Jan 2025 08:35:30 -0500
X-Gm-Features: AbW1kvapSveiWjQvXEx-haU_zKcmtqc9RpHx8Oxcu_p2I5e9nuFIYOkpVKuuLcQ
Message-ID: <CAM0EoMkReTgA+OnjXp3rm=DYdYE96DUYwGNjLoCyUK+yP9hehQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] net: sched: fix ets qdisc OOB Indexing
To: Paolo Abeni <pabeni@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	petrm@mellanox.com, security@kernel.org, g1042620637@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 3:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On 1/16/25 5:36 AM, Cong Wang wrote:
> > On Mon, Jan 13, 2025 at 06:47:02AM -0500, Jamal Hadi Salim wrote:
> >> On Mon, Jan 13, 2025 at 5:29=E2=80=AFAM Petr Machata <petrm@nvidia.com=
> wrote:
> >>>
> >>>
> >>> Cong Wang <xiyou.wangcong@gmail.com> writes:
> >>>
> >>>> On Sat, Jan 11, 2025 at 09:57:39AM -0500, Jamal Hadi Salim wrote:
> >>>>> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> >>>>> index f80bc05d4c5a..516038a44163 100644
> >>>>> --- a/net/sched/sch_ets.c
> >>>>> +++ b/net/sched/sch_ets.c
> >>>>> @@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned lo=
ng arg)
> >>>>>  {
> >>>>>      struct ets_sched *q =3D qdisc_priv(sch);
> >>>>>
> >>>>> +    if (arg =3D=3D 0 || arg > q->nbands)
> >>>>> +            return NULL;
> >>>>>      return &q->classes[arg - 1];
> >>>>>  }
> >>>>
> >>>> I must miss something here. Some callers of this function don't hand=
le
> >>>> NULL at all, so are you sure it is safe to return NULL for all the
> >>>> callers here??
> >>>>
> >>>> For one quick example:
> >>>>
> >>>> 322 static int ets_class_dump_stats(struct Qdisc *sch, unsigned long=
 arg,
> >>>> 323                                 struct gnet_dump *d)
> >>>> 324 {
> >>>> 325         struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> >>>> 326         struct Qdisc *cl_q =3D cl->qdisc;
> >>>>
> >>>> 'cl' is not checked against NULL before dereferencing it.
> >>>>
> >>>> There are other cases too, please ensure _all_ of them handle NULL
> >>>> correctly.
> >>>
> >>> Yeah, I looked through ets_class_from_arg() callers last week and I
> >>> think that besides the one call that needs patching, which already
> >>> handles NULL, in all other cases the arg passed to ets_class_from_arg=
()
> >>> comes from class_find, and therefore shouldn't cause the NULL return.
> >>
> >> Exactly.
> >> Regardless - once the nodes are created we are guaranteed non-null.
> >> See other qdiscs, not just ets.
> >
> > The anti-pattern part is that we usually pass the pointer instead of
> > classid with these 'arg', hence it is unsigned long. In fact, for
> > ->change(), classid is passed as the 2nd parameter, not the 5th.
> > The pointer should come from the return value of ->find().
> >
> > Something like the untested patch below.
> >
> > Thanks.
> >
> > ---->
> >
> > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > index f80bc05d4c5a..3b7253e8756f 100644
> > --- a/net/sched/sch_ets.c
> > +++ b/net/sched/sch_ets.c
> > @@ -86,12 +86,9 @@ static int ets_quantum_parse(struct Qdisc *sch, cons=
t struct nlattr *attr,
> >       return 0;
> >  }
> >
> > -static struct ets_class *
> > -ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
> > +static struct ets_class *ets_class_from_arg(unsigned long arg)
> >  {
> > -     struct ets_sched *q =3D qdisc_priv(sch);
> > -
> > -     return &q->classes[arg - 1];
> > +     return (struct ets_class *) arg;
> >  }
> >
> >  static u32 ets_class_id(struct Qdisc *sch, const struct ets_class *cl)
> > @@ -198,7 +195,7 @@ static int ets_class_change(struct Qdisc *sch, u32 =
classid, u32 parentid,
> >                           struct nlattr **tca, unsigned long *arg,
> >                           struct netlink_ext_ack *extack)
> >  {
> > -     struct ets_class *cl =3D ets_class_from_arg(sch, *arg);
> > +     struct ets_class *cl =3D ets_class_from_arg(*arg);
> >       struct ets_sched *q =3D qdisc_priv(sch);
> >       struct nlattr *opt =3D tca[TCA_OPTIONS];
> >       struct nlattr *tb[TCA_ETS_MAX + 1];
> > @@ -248,7 +245,7 @@ static int ets_class_graft(struct Qdisc *sch, unsig=
ned long arg,
> >                          struct Qdisc *new, struct Qdisc **old,
> >                          struct netlink_ext_ack *extack)
> >  {
> > -     struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> > +     struct ets_class *cl =3D ets_class_from_arg(arg);
> >
> >       if (!new) {
> >               new =3D qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_op=
s,
> > @@ -266,7 +263,7 @@ static int ets_class_graft(struct Qdisc *sch, unsig=
ned long arg,
> >
> >  static struct Qdisc *ets_class_leaf(struct Qdisc *sch, unsigned long a=
rg)
> >  {
> > -     struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> > +     struct ets_class *cl =3D ets_class_from_arg(arg);
> >
> >       return cl->qdisc;
> >  }
> > @@ -278,12 +275,12 @@ static unsigned long ets_class_find(struct Qdisc =
*sch, u32 classid)
> >
> >       if (band - 1 >=3D q->nbands)
> >               return 0;
> > -     return band;
> > +     return (unsigned long)&q->classes[band - 1];
> >  }
> >
> >  static void ets_class_qlen_notify(struct Qdisc *sch, unsigned long arg=
)
> >  {
> > -     struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> > +     struct ets_class *cl =3D ets_class_from_arg(arg);
> >       struct ets_sched *q =3D qdisc_priv(sch);
> >
> >       /* We get notified about zero-length child Qdiscs as well if they=
 are
> > @@ -297,7 +294,7 @@ static void ets_class_qlen_notify(struct Qdisc *sch=
, unsigned long arg)
> >  static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
> >                         struct sk_buff *skb, struct tcmsg *tcm)
> >  {
> > -     struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> > +     struct ets_class *cl =3D ets_class_from_arg(arg);
> >       struct ets_sched *q =3D qdisc_priv(sch);
> >       struct nlattr *nest;
> >
> > @@ -322,7 +319,7 @@ static int ets_class_dump(struct Qdisc *sch, unsign=
ed long arg,
> >  static int ets_class_dump_stats(struct Qdisc *sch, unsigned long arg,
> >                               struct gnet_dump *d)
> >  {
> > -     struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> > +     struct ets_class *cl =3D ets_class_from_arg(arg);
> >       struct Qdisc *cl_q =3D cl->qdisc;
> >
> >       if (gnet_stats_copy_basic(d, NULL, &cl_q->bstats, true) < 0 ||
>
> The blamed commit is quite old, and the fix will be propagated on
> several stable trees. Jamal's option is IMHO more suitable to such goal,
> being less invasive and with possibly less conflict.
>
> Would you be fine with Jamal's fix and following-up with the above on
> net-next?
>

Agreed.
The pattern is followed by all qdiscs, not just ets. So if we are
fixing patterns it should be a separate patch.

cheers,
jamal
> Thanks,
>
> Paolo
>

