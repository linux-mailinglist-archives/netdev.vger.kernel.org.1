Return-Path: <netdev+bounces-187158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDE0AA558E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F8D9A720D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 20:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4133C296FD2;
	Wed, 30 Apr 2025 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTdClufq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78255298CB2
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746045215; cv=none; b=N/qLfsnCDpdbWTkiOCwMeyaQF7ojDORrQZo2KQph4SMCa8+/4OB/xMSzemQkdzFO2G8SjYVdP4lasFpi1m9Pvr91Ojti8O1she3x5/EB1AfvdFZRFJBpbB3GBM4pnXCWQiHpz5QVjZrkz+5DTqrTPbr7JCGTWOjeeF1KAr8Yjoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746045215; c=relaxed/simple;
	bh=4SIYk9/JNkn1HsNKyrm1AEz+RQscX+Lfkoh1zhUoPew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfXb12cREmUyvMrRRWKpJNoqrt1qPS0A8EIFsm9UqsdQ7vPMkN94nsb/Dbc3OailG4qNzmOYRnsjoN38J9rrWKiOmPkNSB9iFUjIf56IdZ8uvNP4JEAoq9cs+P5149WBwgmGKwQlHme9VC0+K8YyJit3MrNdldJfL4Boy/DjHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTdClufq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2263428c8baso4515ad.1
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746045212; x=1746650012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcCy/KINzcIPmyNbZq3HCq/O9U+fA/Gu6z5IxeN6cus=;
        b=pTdClufq2Cr1ENE9w2ODRnIma3y0YZmYXVRXIiu3uBMhWL2Xp7eW7IkYpjKLLyZiQK
         PAUesg05y6yIN8LekB7ZcBxY6d65c6ZCgAQsYe8h1caFhBfWGDFXnJQW5vfJ2hfwP9ly
         NrsxpsCqwnkPeBm5PSUBkg1rS94pApMzXppqOMA7ZY7qUYBYSPuYu0bn1f0BJ1e617C3
         OMCBTwWLAbut70Y7HsxL0GDidgoubY2lt3Yv6UG/55AzVJ7McjVCH28gBcZg0511xKhi
         aZyh8IRMyeYvUA3PhWNXqv6aDLUuSxrFY2bWrGuCtBAp6W4GKl1MjnyL9ogsDOhw9SlA
         lIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746045212; x=1746650012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcCy/KINzcIPmyNbZq3HCq/O9U+fA/Gu6z5IxeN6cus=;
        b=EahF7X4IMfuzTPy8tugck+nKx9UXIyFaR4qPoTH6mJUqoAhzwtZe3/T8aV7G4OBoA/
         BORdCVIuVB88ftXU7hDK5/GwoMxXZF7/AquVQmgROUYJehbEuw1Mhas3+YTs8eclxF11
         YDdgcy+rd4voUdIOm0u0e865bBX63vSvtMc5gzQ8wgTsa5Vz0FclhXq7umD+jMDN8ZzG
         2olAjSiL0Pph4DMaIGWIgvN35A/jMfneD76BxXAZfElm2nqZu/rRMIlRfA2G81zP8Viw
         IPqpXgL3tyaGpf40X9T0sCJP9oS+PpJvQ2fvBGiVzeWNgdCvbQXcIn0gVIsJwsc7w4oS
         eC3g==
X-Forwarded-Encrypted: i=1; AJvYcCXO0pN/JdJfP5GTRK+otjox/9cNfQil2/g0GqLwqyjX+VxLVDN6Sh6lCTPpUmQKJt+Cm4JsZos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCgXVYtQctQamDFAeQVJctjuT6c42sJrIwFaY67HkhrtpZaMJ
	aorUEAgxYNXVNQ4POpWDK6i3vz+ipSEN9+tvJNKx9AHbesFcEVc+jk+1qnuwLFgfQHHFrDpHw2w
	cIBLSEXP7CUHB3YMFBvZAqt/e4+kySFFA5PWd
X-Gm-Gg: ASbGncuBLkXozk40kBa5lC8wN9YDTRmgD9e8eqM4SII/MlmSFro9r4pmW3YwJH7jLiY
	YqMp9ow7UHsEFkdCdXmrIaIwosqWUOkvsbO4VDTnB0qvkOglr2UDUACJo/JILA9CHFK6Y2hoN19
	jleSehZElRVNnhdtAPL3vsoNoukSI3KYYI93hZFFjUWIdlJ8vXTcBCjRk=
X-Google-Smtp-Source: AGHT+IFnreYD6mIRLHOM3vY53ytsEznQqEksrXxjHjDhJAZJSVAyl7Mrh7HbxKZNKROFM+ASAmJmYSjsWf3VEQ3Ija0=
X-Received: by 2002:a17:902:c402:b0:21f:4986:c7d5 with SMTP id
 d9443c01a7336-22e03d08e31mr804315ad.8.1746045212205; Wed, 30 Apr 2025
 13:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424200222.2602990-1-skhawaja@google.com> <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
 <db35fe8a-05c3-4227-9b2b-eeca8b7cb75a@uwaterloo.ca> <CAAywjhRM8wd67DwUttU76+6KrKUki-w9hgkbVskhVG+nJ4JNig@mail.gmail.com>
 <a8a7ed7f-af44-4f15-9e30-651a2b9b86ba@uwaterloo.ca>
In-Reply-To: <a8a7ed7f-af44-4f15-9e30-651a2b9b86ba@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 30 Apr 2025 13:33:20 -0700
X-Gm-Features: ATxdqUHd-vSVkOV5JwqJ1S7CuXuoIeLaE0CQ9rYArTa6IST6Y4UNp8u2r5nYNSw
Message-ID: <CAAywjhRnV9t_64DA1XLuDx89u2oMSEep0RCYO84YRKn5PxsUkA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 12:57=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo=
.ca> wrote:
>
> On 2025-04-30 12:58, Samiullah Khawaja wrote:
> > On Wed, Apr 30, 2025 at 8:23=E2=80=AFAM Martin Karsten <mkarsten@uwater=
loo.ca> wrote:
> >>
> >> On 2025-04-28 09:50, Martin Karsten wrote:
> >>> On 2025-04-24 16:02, Samiullah Khawaja wrote:
> >>
> >> [snip]
> >>
> >>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NA=
PI
> >>>> threaded |
> >>>> |---|---|---|---|---|
> >>>> | 12 Kpkt/s + 0us delay | | | | |
> >>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> >>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> >>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> >>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> >>>> | 32 Kpkt/s + 30us delay | | | | |
> >>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> >>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> >>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> >>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> >>>> | 125 Kpkt/s + 6us delay | | | | |
> >>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> >>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> >>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> >>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> >>>> | 12 Kpkt/s + 78us delay | | | | |
> >>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> >>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> >>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> >>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> >>>> | 25 Kpkt/s + 38us delay | | | | |
> >>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> >>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> >>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> >>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> >>>>
> >>>>    ## Observations
> >>>>
> >>>> - Here without application processing all the approaches give the sa=
me
> >>>>     latency within 1usecs range and NAPI threaded gives minimum late=
ncy.
> >>>> - With application processing the latency increases by 3-4usecs when
> >>>>     doing inline polling.
> >>>> - Using a dedicated core to drive napi polling keeps the latency sam=
e
> >>>>     even with application processing. This is observed both in users=
pace
> >>>>     and threaded napi (in kernel).
> >>>> - Using napi threaded polling in kernel gives lower latency by
> >>>>     1-1.5usecs as compared to userspace driven polling in separate c=
ore.
> >>>> - With application processing userspace will get the packet from rec=
v
> >>>>     ring and spend some time doing application processing and then d=
o napi
> >>>>     polling. While application processing is happening a dedicated c=
ore
> >>>>     doing napi polling can pull the packet of the NAPI RX queue and
> >>>>     populate the AF_XDP recv ring. This means that when the applicat=
ion
> >>>>     thread is done with application processing it has new packets re=
ady to
> >>>>     recv and process in recv ring.
> >>>> - Napi threaded busy polling in the kernel with a dedicated core giv=
es
> >>>>     the consistent P5-P99 latency.
> >>> I've experimented with this some more. I can confirm latency savings =
of
> >>> about 1 usec arising from busy-looping a NAPI thread on a dedicated c=
ore
> >>> when compared to in-thread busy-polling. A few more comments:
> > Thanks for the experiments and reproducing this. I really appreciate it=
.
> >>>
> >>> 1) I note that the experiment results above show that 'interrupts' is
> >>> almost as fast as 'NAPI threaded' in the base case. I cannot confirm
> >>> these results, because I currently only have (very) old hardware
> >>> available for testing. However, these results worry me in terms of
> >>> necessity of the threaded busy-polling mechanism - also see Item 4) b=
elow.
> >>
> >> I want to add one more thought, just to spell this out explicitly:
> >> Assuming the latency benefits result from better cache utilization of
> >> two shorter processing loops (NAPI and application) using a dedicated
> >> core each, it would make sense to see softirq processing on the NAPI
> >> core being almost as fast. While there might be small penalty for the
> >> initial hardware interrupt, the following softirq processing does not
> > The interrupt experiment in the last row demonstrates the penalty you
> > mentioned. While this effect might be acceptable for some use cases,
> > it could be problematic in scenarios sensitive to jitter (P99
> > latency).
>
> Just to be clear andexplicit: The difference is 200 nsecs for P99 (13200
> vs 13000), i.e, 100 nsecs per core burned on either side. As I mentioned
> before, I don't think the 100%-load experiments (those with nonzero
> delay setting) are representative of any real-world scenario.
oh.. you are only considering the first row. Yes, with zero delay it
would (mostly) be equal. I agree with you that there is very little
difference in that particular scenario.
>
> Thanks,
> Martin
>
> >> differ much from what a NAPI spin-loop does? The experiments seem to
> >> corroborate this, because latency results for 'interrupts' and 'NAPI
> >> threaded' are extremely close.
> >>
> >> In this case, it would be essential that interrupt handling happens on=
 a
> >> dedicated empty core, so it can react to hardware interrupts right awa=
y
> >> and its local cache isn't dirtied by other code than softirq processin=
g.
> >> While this also means dedicating a entire core to NAPI processing, at
> >> least the core wouldn't have to spin all the time, hopefully reducing
> >> power consumption and heat generation.
> >>
> >> Thanks,
> >> Martin
> >>> 2) The experiments reported here are symmetric in that they use the s=
ame
> >>> polling variant at both the client and the server. When mixing things=
 up
> >>> by combining different polling variants, it becomes clear that the
> >>> latency savings are split between both ends. The total savings of 1 u=
sec
> >>> are thus a combination of 0.5 usec are either end. So the ultimate
> >>> trade-off is 0.5 usec latency gain for burning 1 core.
> >>>
> >>> 3) I believe the savings arise from running two tight loops (separate
> >>> NAPI and application) instead of one longer loop. The shorter loops
> >>> likely result in better cache utilization on their respective dedicat=
ed
> >>> cores (and L1 caches). However I am not sure right how to explicitly
> >>> confirm this.
> >>>
> >>> 4) I still believe that the additional experiments with setting both
> >>> delay and period are meaningless. They create corner cases where rate=
 *
> >>> delay is about 1. Nobody would run a latency-critical system at 100%
> >>> load. I also note that the experiment program xsk_rr fails when tryin=
g
> >>> to increase the load beyond saturation (client fails with 'xsk_rr:
> >>> oustanding array full').
> >>>
> >>> 5) I worry that a mechanism like this might be misinterpreted as some
> >>> kind of magic wand for improving performance and might end up being u=
sed
> >>> in practice and cause substantial overhead without much gain. If
> >>> accepted, I would hope that this will be documented very clearly and
> >>> have appropriate warnings attached. Given that the patch cover letter=
 is
> >>> often used as a basis for documentation, I believe this should be
> >>> spelled out in the cover letter.
> >>>
> >>> With the above in mind, someone else will need to judge whether (at
> >>> most) 0.5 usec for burning a core is a worthy enough trade-off to
> >>> justify inclusion of this mechanism. Maybe someone else can take a
> >>> closer look at the 'interrupts' variant on modern hardware.
> >>>
> >>> Thanks,
> >>> Martin
> >>
>

