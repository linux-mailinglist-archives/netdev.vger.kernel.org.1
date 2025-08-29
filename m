Return-Path: <netdev+bounces-218349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF996B3C184
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 19:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE771C807ED
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C933375B1;
	Fri, 29 Aug 2025 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="NMadx0Wy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8632C309
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487329; cv=none; b=iIijaPaUtzpgf8erwaWd3hqAavSuZEe63MObQFYFoPm99janxzx3svrqff6KgPZybAA/LUPqbYOY4CRtfqAkjOUlg3J5DKZr7JJFS/4FRLd31pawZLxLsJ+MSxUcbZR2e2pxvDyVw/+fthlQLqULvU7LeeZojTFOtldIrztjlkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487329; c=relaxed/simple;
	bh=TQZ9cTTwtePIr8tAFzYnxEslxa8lkzvS2mn+zrChWtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wrhd0NOGsyBrcI3b6+38StZWi+LbYy/mMbVTy9e4L4STeXzjVOLwVczOxQYVzflsjpYpjHpHoAoLZBg0O8TcWUiTRhDdm9b7mLBRlgkXdffbGy80qhe6RcEAwpagUNMgkHfjzB2ddgRnnc/7MJcrnpoHcdyWcxH+eWR1HNKFpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=NMadx0Wy; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TQZ9cTTwtePIr8tAFzYnxEslxa8lkzvS2mn+zrChWtc=; t=1756487328; x=1757351328; 
	b=NMadx0Wynp/mbQ+HqU5GsHzrJgBJbJjzsLsAFR/iZyOBm7+Dbicg3mSYHE5vdsmQRiQUXyuN8zW
	rpPSZ77hxXsZ1eZBmyffLW4K1i3GiI/ACq0BK6Ro8oTAnGO1QnMKH4zH1TMF5x+8T9+0wvKiJ4ZDf
	3sCSErq0dVKTxedulL6iwLoDsBcxFWdcVNAYAOLDqwwWhrcRaGThdixJ87Cv25I5of/Brq3/th4wD
	C4Lq4JgtiFUy9kyLBsdO4xN0iH+px3gITioH9ts6rq7evOS29kyT1XbqR7qdevLJsLFKC41Hbs3RG
	USv5YQHAHWJ5MGD8BArV6xP47FdKRHox+e1w==;
Received: from mail-oo1-f45.google.com ([209.85.161.45]:43027)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1us2ai-00020I-PI
	for netdev@vger.kernel.org; Fri, 29 Aug 2025 10:08:46 -0700
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61bc52fd7a4so2214677eaf.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 10:08:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YwWMDBLS3KjRmQ1WGvq6IZ15gU8H2+Tml3tqyh7lPizKoBzWo42
	Odq0h00MeVUkrvuqfnsDQ/lKapfNKfLBlkk1ZIYH5HAvjyG4iTJGoKC7AIzQ+LF44N8TjRg9h9S
	wnhs0QwCuZNXPXB9qqc+RW5hj7sQf95E=
X-Google-Smtp-Source: AGHT+IFSLTA15YATUclhetCfX/mUmpihkNsx2o/l2btVP/RsW6ZZWtN1ITYVLA/MeTS2blU1ZfKFw7S8OFPSRO9qf2Y=
X-Received: by 2002:a05:6808:6c8b:b0:437:f136:2501 with SMTP id
 5614622812f47-437f1362950mr1020931b6e.21.1756487324185; Fri, 29 Aug 2025
 10:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-4-ouster@cs.stanford.edu>
 <ce4f62a8-1114-47b9-af08-51656e08c2b5@redhat.com> <CAGXJAmzwk87WCjxrxQbTn3bM8nemKcnzHzOeFTBJiKWABRf+Nw@mail.gmail.com>
 <6d99c24c-a327-471b-964f-cfe02aef7ce2@redhat.com> <CAGXJAmzpibzh+4FvM4mcvkXeT8f0AhMK00eqie7J8NEU9Z9xWg@mail.gmail.com>
 <fd3b25a3-018b-4732-af42-289b3c7c4817@redhat.com>
In-Reply-To: <fd3b25a3-018b-4732-af42-289b3c7c4817@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 29 Aug 2025 10:08:07 -0700
X-Gmail-Original-Message-ID: <CAGXJAmz=DweQnvpWhgACnCUcxhq1-Yp9m5KznSL1RNCX-p_-EQ@mail.gmail.com>
X-Gm-Features: Ac12FXwB0jMkZz3wuZqTX_KKy92RC2qQoVchThF7Yy2eiD8Ab5u1G7XOfGx3c4c
Message-ID: <CAGXJAmz=DweQnvpWhgACnCUcxhq1-Yp9m5KznSL1RNCX-p_-EQ@mail.gmail.com>
Subject: Re: [PATCH net-next v15 03/15] net: homa: create shared Homa header files
To: Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 143d975f4418483bad6282b216f6b212

On Fri, Aug 29, 2025 at 12:53=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 8/29/25 5:03 AM, John Ousterhout wrote:
> > On Wed, Aug 27, 2025 at 12:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >
> >> The TSC raw value depends on the current CPU.
> >
> > This is incorrect. There were problems in the first multi-core Intel
> > chips in the early 2000s, but they were fixed before I began using TSC
> > in 2010. The TSC counter is synchronized across cores and increments
> > at a constant rate independent of core frequency and power state.
>
> Please read:
>
> https://elixir.bootlin.com/linux/v6.17-rc3/source/arch/x86/include/asm/ts=
c.h#L14

This does not contradict my assertion, but maybe we are talking about
different things.

First, the statement "the results can be non-monotonic if compared on
different CPUs" in the link you sent doesn't really make sense as
written. There is no way to execute RDTSC instructions at exactly the
same moment on two CPUs and compare the results. Maybe the comment is
referring to a situation like this:
* Execute RDTSC on core A.
* Increment a shared variable on core A.
* Read the variable's value on core B.
* Execute RDTSC on core B.

In this situation, it is possible that the time returned by RDTSC on
core B could precede that observed on core A, while the value of the
variable read by core B reflects the increment. Perhaps this is what
you meant by your statement "The TSC raw value depends on the current
CPU"? I interpreted your words to mean that each CPU has its own
independent TSC counter, which was the case in the early 2000's but is
not the case today.

There are two different issues here:
* Is the TSC clock itself consistent across CPUs? Yes it is. It does
not depend on which CPU reads it.
* When are TSC values read relative to the execution of nearby
instructions? This is also well-defined: with RDTSC, the time is read
as soon as the instruction is decoded. Of course, this may be before
some previous instructions have been retired, so the time could appear
to have been read out-of-order. This means you shouldn't use RDTSC
values to deduce the order of operations on different cores.

> > I have measured Homa performance using ktime_get_ns, and
> > this adds about .04 core to Homa's total core utilization when driving
> > a 25 Gbps link at 80% utilization bidirectional.
>
> What is that 0.04? A percent? of total CPU time? of CPU time used by
> Homa? absolute time?

It's .04 core. In other words Homa uses 40ms more execution time every
second with ktime_get_ns than it did with get_cycles, when running
this particular workload.

> If that is percent of total CPU time for a single core, such value is
> inconsistent with my benchmarking where a couple of timestamp() reads
> per aggregate packet are well below noise level.

Homa is doing a lot more than a couple of timestamp() reads per
aggregate packet. The version of Homa that I measured (my default
version, even for benchmarking) is heavily instrumented; you will see
the instrumentation in a later patch series. So far, I've been able to
afford the instrumentation without significant performance penalty,
and I'd like to keep it that way if possible.

-John-

