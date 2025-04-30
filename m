Return-Path: <netdev+bounces-187132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B11AA524D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A529830D8
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0666264F96;
	Wed, 30 Apr 2025 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tc5nYqWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2927A29D0E
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746032319; cv=none; b=C1UGdf5uAYBAl3aJwAsERglgb1sRifS4Gu4dIy9HKSwV9yDq7dcT2lGvdqfwnhJXLWTbMPiIRL23RZexV1cQ1noDk5Nqd+KueKV3L9N6PQfMiea+PB0iPx5CIa3MjfM8NDLPFhPzAtMYxDuW5M6jwkjdxOuXHOTxTAVqUl+Fq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746032319; c=relaxed/simple;
	bh=MVzV0b03ifPMAQ1TmUhGpIYIbToVjVggup774KrQO34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEPfcNf3sjPDB8tYnpVkV3IaLmAkLgSrRhBNYGqqiD/k7PlHkoZzNXzm/7oP/tJJvRVrrrKfdSxEzBWdWQrY0N8mIb4c8qy2qWO/xOtwWDSlFhSmLOSAZjiFx314BweW2RtDZ6vCCMCwevMmx4Rof6aKRZzIT1i9KYZR/GlTDg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tc5nYqWY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2240aad70f2so20505ad.0
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 09:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746032317; x=1746637117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfchzJA/myuq6yLs9cewuhb35n7v6x7R/JKXR7PgTYI=;
        b=Tc5nYqWY/E04+ibRs2alcY4MsgXfiPkG8SIWTWVw/ecQ92+MSHxxXX2Dey4zHpyCJ4
         Pm0yh9Oc7Gh3Sa48WsEflQui/fdYTly3iaXkZLFTbjLrfsoOJ/3Cdme9xQVGR3R8Tu/E
         v4RG68mSh+qduwZzQUqIlGFfh9+NkLy67ELsh9MH1sMHT0FDpmQRiwN5jk2ZQ3HxPidV
         /YYfSJJ0zz2ugcCGEpJEX4kTr6LOfN0ZqrHTWpjquUyda1nmfjXVvmv+QQCnX7xJBQAA
         Dn/WjQbs+vVKsarvMM7EOp8RJTTDSa1B53UT4ZCNRte9bYmTrzwGxmxHUouXWdl8hzT9
         M6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746032317; x=1746637117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfchzJA/myuq6yLs9cewuhb35n7v6x7R/JKXR7PgTYI=;
        b=IqGlU4B0QS9L+QOu8TvJtpQ2A/9hDW7UMY7o7blYVDe/u90IJsKMF8choP8CHIgAY5
         Gsv+SZL2xnqPW4uyZtDDOW7obaUco086HFzYb3zitsRh1fL6zr/INmA7h3h+lG9jd6w2
         iutIimcBntsm1XkorexU/h1Zlo2/XZhn2lFl/+1zIcp2yGOClsRxwHex1HxtImOWRZVM
         fuS2IqrSA0uXMFvIG0IIfCsNnpzxbOS5UyCrmxImb4MyWJXspFz0YvzzFgRKxIdnbBZW
         gxGBndyCIeVwVNFtV4C/3SQKZSgYNkJBLUsv5kq1G2Rmghi3WC8z213OVGdAyW0YyluC
         Eu9g==
X-Forwarded-Encrypted: i=1; AJvYcCWTpQ21BSyJHlhQobCXOxrkdB88u90CpihHaAcgMhTFOSB4oqKP9cUlciLKNmtU4xTlXiq/gHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPp3ZmNxeyXJUTT8VifgoljuxTm/p70bKJSCYDfb5bLdoNjMW
	2H1A6IuR/G1j/MciXoEMMLdJghniE43jXGIDTxE65sI3ooTe5utpdLOg6ExOpiZThgvvZjpb5jV
	Uqi0FaZRjbGv0UlrNBrESUDhZyMDnvbOuYeKI5WgNiWxYf1rTsE9TB/0=
X-Gm-Gg: ASbGncvt4vT9tUY5GARhM6g71R6+zVbX/0uhDaSu5kSp8gKHR2gkUB+pRhcBlZMdRVJ
	nSOM4Dab1Zm4is3CWVa3mLDpWdztt4T+ujZhn2OLYxjshUFcXeAgj7SuRrZiAD0Jc3WvNHYXJQm
	F+QgLHQWznvJq1CI57U2s1+YYJmbXt3LCKXM9enII/cI/NC9jV+Z1EhGlmz3oQi+83bQ==
X-Google-Smtp-Source: AGHT+IEVViSpziJMseHnj0B3GL7cVDNyLuOt4tmw9cGc1bfsfvD7CvavwPJG7JGB4Tr0Cbtev5FxEU2b3wS6UCC8D2Q=
X-Received: by 2002:a17:903:2f8e:b0:21f:2ded:bfa0 with SMTP id
 d9443c01a7336-22df548f145mr3153565ad.25.1746032316939; Wed, 30 Apr 2025
 09:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424200222.2602990-1-skhawaja@google.com> <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
 <db35fe8a-05c3-4227-9b2b-eeca8b7cb75a@uwaterloo.ca>
In-Reply-To: <db35fe8a-05c3-4227-9b2b-eeca8b7cb75a@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 30 Apr 2025 09:58:25 -0700
X-Gm-Features: ATxdqUGeBnklRp3cE4m4aX9xT8yRCSCLgZ9s5PYoIfDsl0wNEEFsj--i1vBNjQ0
Message-ID: <CAAywjhRM8wd67DwUttU76+6KrKUki-w9hgkbVskhVG+nJ4JNig@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 8:23=E2=80=AFAM Martin Karsten <mkarsten@uwaterloo.=
ca> wrote:
>
> On 2025-04-28 09:50, Martin Karsten wrote:
> > On 2025-04-24 16:02, Samiullah Khawaja wrote:
>
> [snip]
>
> >> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI
> >> threaded |
> >> |---|---|---|---|---|
> >> | 12 Kpkt/s + 0us delay | | | | |
> >> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> >> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> >> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> >> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> >> | 32 Kpkt/s + 30us delay | | | | |
> >> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> >> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> >> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> >> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> >> | 125 Kpkt/s + 6us delay | | | | |
> >> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> >> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> >> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> >> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> >> | 12 Kpkt/s + 78us delay | | | | |
> >> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> >> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> >> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> >> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> >> | 25 Kpkt/s + 38us delay | | | | |
> >> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> >> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> >> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> >> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> >>
> >>   ## Observations
> >>
> >> - Here without application processing all the approaches give the same
> >>    latency within 1usecs range and NAPI threaded gives minimum latency=
.
> >> - With application processing the latency increases by 3-4usecs when
> >>    doing inline polling.
> >> - Using a dedicated core to drive napi polling keeps the latency same
> >>    even with application processing. This is observed both in userspac=
e
> >>    and threaded napi (in kernel).
> >> - Using napi threaded polling in kernel gives lower latency by
> >>    1-1.5usecs as compared to userspace driven polling in separate core=
.
> >> - With application processing userspace will get the packet from recv
> >>    ring and spend some time doing application processing and then do n=
api
> >>    polling. While application processing is happening a dedicated core
> >>    doing napi polling can pull the packet of the NAPI RX queue and
> >>    populate the AF_XDP recv ring. This means that when the application
> >>    thread is done with application processing it has new packets ready=
 to
> >>    recv and process in recv ring.
> >> - Napi threaded busy polling in the kernel with a dedicated core gives
> >>    the consistent P5-P99 latency.
> > I've experimented with this some more. I can confirm latency savings of
> > about 1 usec arising from busy-looping a NAPI thread on a dedicated cor=
e
> > when compared to in-thread busy-polling. A few more comments:
Thanks for the experiments and reproducing this. I really appreciate it.
> >
> > 1) I note that the experiment results above show that 'interrupts' is
> > almost as fast as 'NAPI threaded' in the base case. I cannot confirm
> > these results, because I currently only have (very) old hardware
> > available for testing. However, these results worry me in terms of
> > necessity of the threaded busy-polling mechanism - also see Item 4) bel=
ow.
>
> I want to add one more thought, just to spell this out explicitly:
> Assuming the latency benefits result from better cache utilization of
> two shorter processing loops (NAPI and application) using a dedicated
> core each, it would make sense to see softirq processing on the NAPI
> core being almost as fast. While there might be small penalty for the
> initial hardware interrupt, the following softirq processing does not
The interrupt experiment in the last row demonstrates the penalty you
mentioned. While this effect might be acceptable for some use cases,
it could be problematic in scenarios sensitive to jitter (P99
latency).
> differ much from what a NAPI spin-loop does? The experiments seem to
> corroborate this, because latency results for 'interrupts' and 'NAPI
> threaded' are extremely close.
>
> In this case, it would be essential that interrupt handling happens on a
> dedicated empty core, so it can react to hardware interrupts right away
> and its local cache isn't dirtied by other code than softirq processing.
> While this also means dedicating a entire core to NAPI processing, at
> least the core wouldn't have to spin all the time, hopefully reducing
> power consumption and heat generation.
>
> Thanks,
> Martin
> > 2) The experiments reported here are symmetric in that they use the sam=
e
> > polling variant at both the client and the server. When mixing things u=
p
> > by combining different polling variants, it becomes clear that the
> > latency savings are split between both ends. The total savings of 1 use=
c
> > are thus a combination of 0.5 usec are either end. So the ultimate
> > trade-off is 0.5 usec latency gain for burning 1 core.
> >
> > 3) I believe the savings arise from running two tight loops (separate
> > NAPI and application) instead of one longer loop. The shorter loops
> > likely result in better cache utilization on their respective dedicated
> > cores (and L1 caches). However I am not sure right how to explicitly
> > confirm this.
> >
> > 4) I still believe that the additional experiments with setting both
> > delay and period are meaningless. They create corner cases where rate *
> > delay is about 1. Nobody would run a latency-critical system at 100%
> > load. I also note that the experiment program xsk_rr fails when trying
> > to increase the load beyond saturation (client fails with 'xsk_rr:
> > oustanding array full').
> >
> > 5) I worry that a mechanism like this might be misinterpreted as some
> > kind of magic wand for improving performance and might end up being use=
d
> > in practice and cause substantial overhead without much gain. If
> > accepted, I would hope that this will be documented very clearly and
> > have appropriate warnings attached. Given that the patch cover letter i=
s
> > often used as a basis for documentation, I believe this should be
> > spelled out in the cover letter.
> >
> > With the above in mind, someone else will need to judge whether (at
> > most) 0.5 usec for burning a core is a worthy enough trade-off to
> > justify inclusion of this mechanism. Maybe someone else can take a
> > closer look at the 'interrupts' variant on modern hardware.
> >
> > Thanks,
> > Martin
>

