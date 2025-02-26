Return-Path: <netdev+bounces-169942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D9A46905
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E23A188D56B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59F22A7F0;
	Wed, 26 Feb 2025 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktVDtqIg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDDE2253EB
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593411; cv=none; b=qsf58anNdWnTrlqvwMRo3rYBsE2bhOP2lLmTmkqeBlGnGFQuqX/KP4JKI1yyqg7TpNQ2MbvLacXx6FxEbBerWLHbqAjssOBolAG+CCetTp956wEwaVmpOjYPPt6k5vPuerNaBoHfNkIdP71khFAJOrZfc/cWYNmuEDFOoSFdqD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593411; c=relaxed/simple;
	bh=6szC99B9OCbmv8kx6C6LZMNoTvlv15TgsVnN3wD5kp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKiUPUhuhvG+/AaeSI6SUOo/fRKV/Hq2/T3ovLIDVcQdWRXM2R9/gloXLFLRMciyFfqbciDmuezHZnMpymi6Tb7nrdJwXVLOeJDJa/c+YHby7MUcIZtAdbZ5yP/3zRB9jmVwiVtx8lynSe5/IrTb1e4NBqbdpWAIZvxcR3VRtko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktVDtqIg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso11753634a12.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740593408; x=1741198208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBwwPI6uqr8jV8ttnUKpT6FSTlrAtxcnjkLen2qPLow=;
        b=ktVDtqIgOlsS67NuyoeNqGExVX5RGvdh/lDTwgKOLEJ3MJCNd8OwiBwoFnz3Uvu17V
         UhUd1Au11zaMV7NISLGJz+/am14HpKel2eCYg4awvSPBL3nul7bOieOo7Md+4V+GHd5D
         LHMIiRMYvquhZV+Wl/yYbzErHCCfLDapIxwPImmKyW+IrqAIqUJxf78BBcJUQVLwQQMW
         algitphw1B+JaCc2SDJySSM0SzHhcSIFVWT48CHP1rge/h1OA2XVQd0qVijvcu9kHZ6/
         dtNq6WKwZYnGD65q36bXV6VIG/Ud0eQwY/lo2rIUIQSN0xLlFJ//m1V9HMR8s5K8RzOP
         9EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593408; x=1741198208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBwwPI6uqr8jV8ttnUKpT6FSTlrAtxcnjkLen2qPLow=;
        b=It7xsErSQFmFRohMnk2ZzHNUg2MchbKKx+7ZFQ7WoPbWwaVB0UdtumXC6l645IF4HH
         RPizZYeGF30/uX5hgvEtzINVto+mVfnjGE0Hg0uLTNm2TkIIMGCn1nPGtnMNSKl9jHra
         hiFkyEys8U4IkwjYZbDfba3zdPLIdbqQx30nwlQ4uXNzGQa3Zl0zckeqEW8skLmuv53c
         s1NXVxXHppDBkQUmV9X1jKSvhxV/xO+Aw6H1kftFUFgR4L01RifDmcaM/qa8Sgg7jemT
         UUaGxNn8cT7hPC+tiOte7VUXVp5WTWko4dS3EEd22fCmlWO4jGe1DV91uC563j8kvHyL
         fg0w==
X-Forwarded-Encrypted: i=1; AJvYcCWRT6yC+X0EfJW56doio0lWpYx6grFuDYrkZnD8Z3m63t3y6tF/mKIEjlEAp+gu+xxGIUuwvWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGUaU23K8YFbq1qenSCKHcuZxKE3U2D/Fi77vNB1NT6ETcBBgW
	y/ulkZvw5ag4OuYBtcpwmMKY1go+HPL6M7jar55JJZ3W0rQqrr5IUvbKsLDCHvWHcNADQYQxi4M
	owkTFGzx688RL5fbf1dvhB9SAkxKlOqJFx2gO
X-Gm-Gg: ASbGnctZ+1sJ5v4iPc4FlMhw88LeDDcWBw/bqMNHIJY4vwC/y1JReE36VfpnCPBc1jy
	xtLcehu4gNnjfGak7QRdFA+lk0FbzOW0tg1S37oek8vUcwPbpLqN54E2+2343tyNxF56Vth1mup
	e6mJEDKT0=
X-Google-Smtp-Source: AGHT+IFaX6haRBqku9fndRM1Xq9MZo0wRLywEANjiPrs4zkgEsk8B1dtR4izjZ/6lEJnP1t0D6VXtO0IW1yMNoqcous=
X-Received: by 2002:a05:6402:430f:b0:5dc:929a:a726 with SMTP id
 4fb4d7f45d1cf-5e0b7236eebmr24021418a12.26.1740593407910; Wed, 26 Feb 2025
 10:10:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-4-kuniyu@amazon.com>
 <35e7f0a9-3c8d-479c-9a4c-012354f08c5d@kernel.org>
In-Reply-To: <35e7f0a9-3c8d-479c-9a4c-012354f08c5d@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 19:09:56 +0100
X-Gm-Features: AQ5f1Jpvr2aJX7Na9R2mrt3o4KA_A_UnBPP6kwB0UqpU-ORfXa_EmaezN3TGcXM
Message-ID: <CANn89iJ5c+Dq6WLb6DDxD=eEkueS_awg6CcFGcTBrpJPBNgrsw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 03/12] ipv4: fib: Allocate fib_info_hash[]
 during netns initialisation.
To: David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 6:48=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 2/25/25 11:22 AM, Kuniyuki Iwashima wrote:
> > diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
> > index 6730e2034cf8..dbf84c23ca09 100644
> > --- a/net/ipv4/fib_frontend.c
> > +++ b/net/ipv4/fib_frontend.c
> > @@ -1615,9 +1615,15 @@ static int __net_init fib_net_init(struct net *n=
et)
> >       error =3D ip_fib_net_init(net);
> >       if (error < 0)
> >               goto out;
> > +
> > +     error =3D fib4_semantics_init(net);
> > +     if (error)
> > +             goto out_semantics;
> > +
> >       error =3D nl_fib_lookup_init(net);
> >       if (error < 0)
> >               goto out_nlfl;
> > +
> >       error =3D fib_proc_init(net);
> >       if (error < 0)
> >               goto out_proc;
> > @@ -1627,6 +1633,8 @@ static int __net_init fib_net_init(struct net *ne=
t)
> >  out_proc:
> >       nl_fib_lookup_exit(net);
> >  out_nlfl:
> > +     fib4_semantics_init(net);
>
> _exit?

Yes, this was mentioned yesterday.

