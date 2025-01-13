Return-Path: <netdev+bounces-157724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA76A0B604
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D30F160EF0
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFED314B96E;
	Mon, 13 Jan 2025 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qJT+F3VY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923622CF3D
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768838; cv=none; b=EDHo0HC3xbYAWK5aA3yWnRS9HEp/wKrVTlCp/HYhaE9cviqP+EXGx8ukzqXJlju0HpqoStXF4zlLt2crs+BtCoWHQ2N0AIoJ8IQSHO+VO/e+iNwzJpzn/FIzhIKk9uqKUG6mg1QiehDAxuOa1ZtDMfc2Z8FI74qB3mDOojFBBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768838; c=relaxed/simple;
	bh=LIcZopfwyA4AXBVXWD0maqcwldtqv/zxHs+YebFkNVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTIPrTeGl3tvI1WMAAqrNltzuLBSf9kmN0y0qgxakR1Q2SZtWjexvwerDIgbXOSCw4fI1kuXKrh8BfHBj5YOIjVzRwN1aILrFxWOKSpAAimEZ1xjHYPInJLt8nZCsL3JkxAApnNcYrEWZNvF18yC/3e5jyd8ky1kj/74zOZ/1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qJT+F3VY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso5210917a91.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 03:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736768836; x=1737373636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMB2okl7ovzHWnIfwYdVKq3qo4k1iOftg2QYXguQBbE=;
        b=qJT+F3VYsPT94HgHNdhiuRjjmNsUEy/3aOPSsns0hT8cdk5MUooYAfXtkOJgwcmAbd
         8pg6mtz5QoSVxxihv1kmr0sZ6GfA0+sEfEMUOxEWttfeM7uJ64mtyQGppaqfHVreSIgB
         w+tu6+z7vVNXohu4t0oW3NQS4ztNshD7TGTD1tQkawcsrlvMrWeFBhoSaViO+beCyC3w
         yrubjzpTOp12aKH1S4sU4Q5ctaXJ5S7waQoxnTo5DY1P2gb9yGhd9oMHgx22Alfw2ZJ7
         upWQdwweC8dSLxwDs4Q6PhruChPW5BnDPqWRVV+eRWgjJAvM9sDzJG/QiqH4EOIF3373
         G9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736768836; x=1737373636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMB2okl7ovzHWnIfwYdVKq3qo4k1iOftg2QYXguQBbE=;
        b=TZBpb81fCa87QEFhxFVVrpM0LzZIOEEoMwNB2Z7aO3m7fmB0HeDD/UefkWonuNOUUH
         08GPVuRhUmcziiAa4HFwY51mmYWiC5SaKhmRZiNb0JJIBmpK9JezYgYkZTccH4bgLIw4
         KvaabSrMsv481FDk2uUrpFVDWa0TP4RiL5Hc91kGVIMMFv5jGTIjLBC+jOspIbgH8NXm
         EqjV9bbE7dD5x920VX8GTJRv9ub94pn2nIsCPw+XUA45TwrKf93qxtLL0Q56Ynmgvjjo
         Tfdlmf7K16y0lUO2jDeA5HfqBsnrL4w+ckmyQjFpgWlJJ+E4HT9FFwVxqpO1Zlry8TVo
         uXrg==
X-Forwarded-Encrypted: i=1; AJvYcCWkFH2SNbJ7JDwSyXwzd19nc0ReE3pH577D62Xco4Hbv4uixqQE63qbaJnttYB/6csKJDKFhMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2fHsJ1vXAd8UJGRWU1n2I4Le5VbVWsdd8bu8wQLIJk/2Nu8mO
	HVy63Grul5fQ5C91FhsUYii3eXoAf/eYTuUWCIyoS9CK7ekODssvdqyVU41qqnbGHgrIi5TXwdr
	HXsVB19Lj5I08B0A5IqQtF8KtbULRyVW/nvCg
X-Gm-Gg: ASbGncu/STF7USaNJbv58xKCkzcU6NusGJFdYzPjq8v1Oib+OzatHkcE7ly+vq7fa/4
	mgWFb+liaYVQUbcC5ZIWFSzNCiFFh+aVyPipQ
X-Google-Smtp-Source: AGHT+IEwn8p934JN72Lo32xAA1zwXb8B2vtw4nZ/69N6Aa4Ne4GRGfckgNYFSfFrH6uUbLOT4pFN2c0vcS+mdP1xEwY=
X-Received: by 2002:a17:90b:2b8e:b0:2ee:96a5:721c with SMTP id
 98e67ed59e1d1-2f548eca2d0mr27436791a91.21.1736768836174; Mon, 13 Jan 2025
 03:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111145740.74755-1-jhs@mojatatu.com> <Z4RWFNIvS31kVhvA@pop-os.localdomain>
 <87zfjvqa6w.fsf@nvidia.com>
In-Reply-To: <87zfjvqa6w.fsf@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 13 Jan 2025 06:47:02 -0500
X-Gm-Features: AbW1kvZrPn4baFiGcACI1Aq0elZ7xiWUodPyeCClU1eSrZ-djhLRElevIDoNxUs
Message-ID: <CAM0EoMkvOOgT-SU1A7=29Tz1JrqpO7eDsoQAXQsYjCGds=1C-w@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] net: sched: fix ets qdisc OOB Indexing
To: Petr Machata <petrm@nvidia.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, petrm@mellanox.com, 
	security@kernel.org, g1042620637@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 5:29=E2=80=AFAM Petr Machata <petrm@nvidia.com> wro=
te:
>
>
> Cong Wang <xiyou.wangcong@gmail.com> writes:
>
> > On Sat, Jan 11, 2025 at 09:57:39AM -0500, Jamal Hadi Salim wrote:
> >> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> >> index f80bc05d4c5a..516038a44163 100644
> >> --- a/net/sched/sch_ets.c
> >> +++ b/net/sched/sch_ets.c
> >> @@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned long =
arg)
> >>  {
> >>      struct ets_sched *q =3D qdisc_priv(sch);
> >>
> >> +    if (arg =3D=3D 0 || arg > q->nbands)
> >> +            return NULL;
> >>      return &q->classes[arg - 1];
> >>  }
> >
> > I must miss something here. Some callers of this function don't handle
> > NULL at all, so are you sure it is safe to return NULL for all the
> > callers here??
> >
> > For one quick example:
> >
> > 322 static int ets_class_dump_stats(struct Qdisc *sch, unsigned long ar=
g,
> > 323                                 struct gnet_dump *d)
> > 324 {
> > 325         struct ets_class *cl =3D ets_class_from_arg(sch, arg);
> > 326         struct Qdisc *cl_q =3D cl->qdisc;
> >
> > 'cl' is not checked against NULL before dereferencing it.
> >
> > There are other cases too, please ensure _all_ of them handle NULL
> > correctly.
>
> Yeah, I looked through ets_class_from_arg() callers last week and I
> think that besides the one call that needs patching, which already
> handles NULL, in all other cases the arg passed to ets_class_from_arg()
> comes from class_find, and therefore shouldn't cause the NULL return.

Exactly.
Regardless - once the nodes are created we are guaranteed non-null.
See other qdiscs, not just ets.

cheers,
jamal

