Return-Path: <netdev+bounces-201716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A9BAEAC08
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8A93A2053
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 00:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C6718E3F;
	Fri, 27 Jun 2025 00:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hg1w+kZp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9D9460
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750985779; cv=none; b=sd1HYUI9nKuVRyRvr92klWhjU5AAmRdolYnnmtNeBjxEFQp38hvNLOuyN8NQxJ2M0VtLGgFlhmG0ml/oEEDLZUu1ADVxDLyiZzZkAVK3isQwdE50pn+N1ucsDPCOMUdex6OToJdDWQJMCzPDzBxOlsR/IPD+fttJ7XsKHIDTYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750985779; c=relaxed/simple;
	bh=PVsqYZgkwP6lL7T/eugI/a8cIUYBHvFTaBQYVi1zQAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZECgUqdug3ZztcYfF4UlNGArGp/jooW3+QtR7PsDe9qW2NHWmtvG8rzGv1lfTvTbsA6jk2cZu+rGMbCgNcLiSCf8TMq942rdNow7DRyYtOWft6ktYf71pDs7d1zAY3c6pTly2ryJBPbktgvJFlTIFbx11Zv8aATTK8WxTPaiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hg1w+kZp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-315b0050bb5so949082a91.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 17:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750985776; x=1751590576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucTELEpU9GyP1sLuRRZyznD4pvZD45/dvISDzev1QcA=;
        b=hg1w+kZpYcgqGR27HIrlGSBjWqRaVeuc+PmhyUlSlA0DKsjRunPC+Z5elu2tYM8HK8
         5b30YxdXukD6XIVy8cZIGfvbHVvcqGLBmCfZ7YUmBS44YgdaWWkwB/QugDaTRHspOgZn
         pUfe6bIknkeV22/4tgavPIivZAuHp6sgUM35T5CcCrk6fAXibAD6tqrwkpsVXJQzAPc8
         ccJWjYA8FX+A4hdzkn/SAyId01p7Zjav8uspNpsVLsVAznI5BVxYvzsHE0tNNAXIUCxM
         z4vZpCJLIUVgcLnskximvS4HCFvHvnjrTU+mLlEsfKkY2FC8RaZZLPm2dlhe3v1F/+fp
         TBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750985776; x=1751590576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucTELEpU9GyP1sLuRRZyznD4pvZD45/dvISDzev1QcA=;
        b=f2ELwQWOjYVkL0aJVmilIgbDp0pvUPBNg+mpNbJBLC24CEoJI0k/pYuZajGKq77eYj
         NAwXP/tgRAEFuyYJTAvJvOduJOK45FB+cyDftsdk3uX9bm3a6E8cPRWGo/nRN3zfQ3EQ
         B+M2sJNTdDiBoEivIXl1L5QCTHs4gi4OOMKsy1Jfo6mHH9dfx6s/6KUHg40suRdiAl9G
         QWpSgiuk0HC85xyRrAWxIQG8wSJNlCL7q1UWETjSnwPe0ttdmSItOLCmGlsaPddFb+Ua
         sMVJW6vrp2TfIzYieMQvw/jhjuhcb5fDgG4r2KbQm2UJ1jT7rSL2LrJnKkBx3gg7E/aC
         XmjA==
X-Forwarded-Encrypted: i=1; AJvYcCX4uj9uXyvYQmO+V8Jl7SBl0HU1lQTViHDbWrHtgu05HDOtl7V6JpaoCwynuyMtNI/qslV9klQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/SeAVYYuPgGRR9wqIrdLr1nd8tjNMHgbgdCwkZBKKSyavwRo
	lN16dgZTeLJSiGLGGXsjkDtRum8I7ZJMNWIdwJ9t54Y2W0a/GvKyleER0LLVpham5tKFE69bHgV
	nXpCvLpIOz/bIfmR4hBJEzw53snZ+GviBeOw1+tvN
X-Gm-Gg: ASbGncsX14i2yliooXeCGdGLBmmUiEup4rETaAdtZZHhAWG7XizQwx34J35WruHgRR7
	L9ktwyvTcS9zAj2eFLSLh5PA5i3kuDsBWWB8+pGgrQ2YVN0hBToqfKUDNKDKzj0WEJZS44EwKr0
	pYxTMka8T0/pmF1gGCjXxnhvsb+onOs4uDk4crPFDjZoGTTSI2FhbK/JeW4t10wpMbSqDx9+nG3
	8G2
X-Google-Smtp-Source: AGHT+IEuLvRPtd+/U0By9A40ceT8NmU7WCnxQb4bYYP4IQ3pn2lse2003GsKqPZfFJAEJj8/GB3bx5h2ueY/l9P4tcs=
X-Received: by 2002:a17:90b:5348:b0:313:d6d9:8891 with SMTP id
 98e67ed59e1d1-318c910e1a6mr1466404a91.3.1750985776191; Thu, 26 Jun 2025
 17:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-2-kuni1840@gmail.com>
 <CANn89iLjgDG5EB2nPWsS7GVmf360-Q_7OSZ3qRZb_SToOar8wQ@mail.gmail.com>
In-Reply-To: <CANn89iLjgDG5EB2nPWsS7GVmf360-Q_7OSZ3qRZb_SToOar8wQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Jun 2025 17:56:04 -0700
X-Gm-Features: Ac12FXzI8Vd93JSyu1q2bmjpyI1CRPEuZQeq1MVk2zoKcYWUe3tGUCJmWIvDPR8
Message-ID: <CAAVpQUA8j8OZJ8bvQkjVpX6HkAQW88wxvHnAMG_rrPzLqm+UGw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 01/15] ipv6: ndisc: Remove __in6_dev_get() in pndisc_{constructor,destructor}().
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 7:26=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail=
.com> wrote:
> >
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > ipv6_dev_mc_{inc,dec}() has the same check.
> >
> > Let's remove __in6_dev_get() from pndisc_constructor() and
> > pndisc_destructor().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/ipv6/ndisc.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> > index ecb5c4b8518f..beb1814a1ac2 100644
> > --- a/net/ipv6/ndisc.c
> > +++ b/net/ipv6/ndisc.c
> > @@ -377,11 +377,12 @@ static int ndisc_constructor(struct neighbour *ne=
igh)
> >  static int pndisc_constructor(struct pneigh_entry *n)
> >  {
> >         struct in6_addr *addr =3D (struct in6_addr *)&n->key;
> > -       struct in6_addr maddr;
> >         struct net_device *dev =3D n->dev;
> > +       struct in6_addr maddr;
> >
> > -       if (!dev || !__in6_dev_get(dev))
> > +       if (!dev)
> >                 return -EINVAL;
> > +
> >         addrconf_addr_solict_mult(addr, &maddr);
> >         ipv6_dev_mc_inc(dev, &maddr);
>
> return ipv6_dev_mc_inc(dev, &maddr); ?
>
> >         return 0;
> > @@ -390,11 +391,12 @@ static int pndisc_constructor(struct pneigh_entry=
 *n)
> >  static void pndisc_destructor(struct pneigh_entry *n)
> >  {
> >         struct in6_addr *addr =3D (struct in6_addr *)&n->key;
> > -       struct in6_addr maddr;
> >         struct net_device *dev =3D n->dev;
> > +       struct in6_addr maddr;
> >
> > -       if (!dev || !__in6_dev_get(dev))
> > +       if (!dev)
> >                 return;
> > +
> >         addrconf_addr_solict_mult(addr, &maddr);
> >         ipv6_dev_mc_dec(dev, &maddr);
>
> return ipv6_dev_mc_dec(dev, &maddr);

Somehow I separated this change for the following neigh conversion
series but will squash it to this patch.

Thanks!

>
> >  }
> > --
>
> If not needed (because of a future patch ?), this should be mentioned
> in the changelog.
>
> > 2.49.0
> >

