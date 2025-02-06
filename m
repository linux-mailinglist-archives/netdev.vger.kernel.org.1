Return-Path: <netdev+bounces-163543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E76A2AA8B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8624E16852E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE601C6FF2;
	Thu,  6 Feb 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="uLBRl21k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E7E1624FA
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850410; cv=none; b=RdYIiDHmNwfCPnXBsDpOZh+ibLZrqV8/xofDq1rOoh0XtZXrjdzZafgwJsIGlIgzd2iH7Wp1NJTQCbNurWa4zqpw3ES0KtSgBmDodE54O1cAA7up1KmAWKBXc50OuSmvLwonrY4kmpKQTotfA1BvmsnbAr1B41+oiZBPERIV5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850410; c=relaxed/simple;
	bh=4QybecFrBrTt9fq1P8wqQMPTmke6UVsmvGsnjW/L4Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSnNmJ9OCchegwvbWnyodUEPGW+jCW5DMtCxZ6ikR5shpqtpcJj2gWFDQ0oJnW5dbIRs0BWq8O+fJSAdA92p1j3z6Z0QpKmBzBVfTsnAVWehgPy1jG6zn546SLX8VhIRgfcEjrImeA9tlKz57Cf7JEChco6SzEd3PaeiJRyJ+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=uLBRl21k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2164b662090so19111915ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738850407; x=1739455207; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Apk9nWsh1FP+cMEr/XDJCmLz2Reui4ngiroq9+Buf2E=;
        b=uLBRl21k1SYYWIMWGkgoRum8IDGt5hbDoPZX3Pugo3LoX41fjGF+pMPBo1u/dGNCok
         xZRdb+SWszMa5wFHH4Tix//yxeVTMGaU9z7eFTjZ9WLoyBudfKq7MIT2B4DEWGjVBgkP
         Yfbkt5ljYP2j/I+7qY+T9eQJMJlTuaPjpYLos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738850407; x=1739455207;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Apk9nWsh1FP+cMEr/XDJCmLz2Reui4ngiroq9+Buf2E=;
        b=fCfAeHi/KcxzCzdxyXWwSN1LRw3sQ2AYUwme6GOidIP2qySlPDyy2pCU/74H3k+40L
         AFaCRcmZ1luXzgCuo2BPGooUMkZCUOplTk7GKjyaHyIFxNmSOeJzifLNPyQapL6SipQL
         ve9WpH03rRUdpl1XUIrsdAb6tAf2LwnvXkHvbKg3inp5AT+Y3/2Jz5+OmY4s+xSZAEu2
         hgY8wCxcXp5Z1H53mDTi/L4Uicjaq39JJ2gJSLzoli7RgN4XDkuu/MG6r8efi9xLPUyU
         yehopZEnbx7Y9gB7pZc6aEayY6lI2VdQiZtNxFkHFy0m2lBObouB5o0PnA/WFgHvI3sN
         sZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNSxvz07uEaK7a5sKh0h5nuFSxGVrtvKrQOawggHtYQmUEvXIOZj/VfsDpkaFnSYnZOJm7TzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvqjKwmPbOAABCheb/KUgBM/IVQUzy5TGnf57VVJvuxpjtFrBl
	ZKKZw8Y3whp8NV5VQ3X2nFB0u+DkpWnZQTOrnY02FDLK3yPJoMKjEPRsmbUvUgU1TaePQBm5dK0
	9
X-Gm-Gg: ASbGncuw864wqwDJyVap6eqHJzLBwFEXfFkQ5uya8FUYC2rSlknkZvrKqKiJVLlom0s
	xWe3aiQfrCbocXvGluesgzy9ljPRF7u7ZEyugAdKRUBQFkBP+KOLRrCwcTNQ+7fHtJg/5UIQdy9
	z8pW0fSXUiehik1DHkLrCVSvFL/btSYlMoXT4/OXuXXwugI3B2ukQv74RnTcyEGwRy3Xvu2wUGe
	bcLfp8W0cD8XwazlZ3Kh58LFi1YnqK/FSZCg0iaFi5RP8h1tkqRCz3Z7IyKTI7y4HkanWsqSxav
	90ANj6l0o8B6cbugMpcwvnLr2DhAOFwaCxqTmQzNBthG9gIzUZpG2WX9jQ==
X-Google-Smtp-Source: AGHT+IHzDF+DY/AcLC/60/7HzpwTBDrCJyoCbvcGlpcKqNDf2T/Y0DoITyEC+zy/qWyrV+CoTFX1Tg==
X-Received: by 2002:a05:6a20:d498:b0:1e1:ca27:89f0 with SMTP id adf61e73a8af0-1ede88d5aa2mr13850904637.37.1738850407175;
        Thu, 06 Feb 2025 06:00:07 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aeb9358sm1168036a12.16.2025.02.06.06.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 06:00:06 -0800 (PST)
Date: Thu, 6 Feb 2025 06:00:04 -0800
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
Message-ID: <Z6TAZK4TrTbhm1SB@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
 <CAAywjhQM4BLXX55Kh0XQ_NqYv8sJVWBfPfSZMb7724_3DrsjjA@mail.gmail.com>
 <Z6Pg6Ye5ZbzMlBeP@LQ3V64L9R2>
 <b2c7d2dc-595f-4cae-ab00-61b89243fc9e@uwaterloo.ca>
 <CAAywjhS69zRTBM7ZLNR08kL+anYuffppzU5ZuNORxKGQgo7_TA@mail.gmail.com>
 <6eeb6128-cf12-4997-a820-54c56eb93656@uwaterloo.ca>
 <CAAywjhRmtf36KHo9iV91KS4C+40d3Yks0rHBmKETvV_XUvCAxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhRmtf36KHo9iV91KS4C+40d3Yks0rHBmKETvV_XUvCAxA@mail.gmail.com>

On Wed, Feb 05, 2025 at 10:43:43PM -0800, Samiullah Khawaja wrote:
> On Wed, Feb 5, 2025 at 8:50 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
> >
> > On 2025-02-05 23:43, Samiullah Khawaja wrote:
> > > On Wed, Feb 5, 2025 at 5:15 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
> > >>
> > >> On 2025-02-05 17:06, Joe Damato wrote:
> > >>> On Wed, Feb 05, 2025 at 12:35:00PM -0800, Samiullah Khawaja wrote:
> > >>>> On Tue, Feb 4, 2025 at 5:32 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
> > >>>>>
> > >>>>> On 2025-02-04 19:10, Samiullah Khawaja wrote:
> > >>
> > >> [snip]
> > >>
> > >>>>> Note that I don't dismiss the approach out of hand. I just think it's
> > >>>>> important to properly understand the purported performance improvements.
> > >>>> I think the performance improvements are apparent with the data I
> > >>>> provided, I purposefully used more sockets to show the real
> > >>>> differences in tail latency with this revision.
> > >>>
> > >>> Respectfully, I don't agree that the improvements are "apparent." I
> > >>> think my comments and Martin's comments both suggest that the cover
> > >>> letter does not make the improvements apparent.
> > >>>
> > >>>> Also one thing that you are probably missing here is that the change
> > >>>> here also has an API aspect, that is it allows a user to drive napi
> > >>>> independent of the user API or protocol being used.
> > >>>
> > >>> I'm not missing that part; I'll let Martin speak for himself but I
> > >>> suspect he also follows that part.
> > >>
> > >> Yes, the API aspect is quite interesting. In fact, Joe has given you
> > >> pointers how to split this patch into multiple incremental steps, the
> > >> first of which should be uncontroversial.
> > >>
> > >> I also just read your subsequent response to Joe. He has captured the
> > >> relevant concerns very well and I don't understand why you refuse to
> > >> document your complete experiment setup for transparency and
> > >> reproducibility. This shouldn't be hard.
> > > I think I have provided all the setup details and pointers to
> > > components. I appreciate that you want to reproduce the results and If
> > > you really really want to set it up then start by setting up onload on
> > > your platform. I cannot provide a generic installer script for onload
> > > that _claims_ to set it up on an arbitrary platform (with arbitrary
> > > NIC and environment). If it works on your platform (on top of AF_XDP)
> > > then from that point you can certainly build neper and run it using
> > > the command I shared.
> >
> > This is not what I have asked. Installing onload and neper is a given.
> > At least, I need the irq routing and potential thread affinity settings
> > at the server. Providing a full experiment script would be appreciated,
> > but at least the server configuration needs to be specified.
> - There is only 1 rx/tx queue and IRQs are deferred as mentioned in
> the cover letter. I have listed the following command for you to
> configure your netdev with 1 queue pair.
> ```
> sudo ethtool -L eth0 rx 1 tx 1
> ```
> - There is no special interrupt routing, there is only 1 queue pair
> and IDPF shares the same IRQ for both queues. The results remain the
> same whatever core I pin this IRQ to, I tested with core 2, 3 and 23
> (random) on my machine. This is mostly irrelevant since interrupts are
> deferred in both tests. I don't know how your NIC uses IRQs and
> whether the tx and rx are combined, so you might have to figure that
> part out. Sorry about that.

Again, you can assume we are using the same GCP instance you used.

If pinning the IRQ to other cores has no impact on the results, why
not include data that shows that in your cover letter?

> - I moved my napi polling thread to core 2 and as you can see in the
> command I shared I run neper on core 3-10. I enable threaded napi at
> device level for ease of use as I have only 1 queue pair and they both
> share a single NAPI on idpf. Probably different for your platform. I
> use following command,
> ```
>   echo 2 | sudo tee /sys/class/net/eth0/threaded
>   NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
>   sudo chrt -o  -p 0 $NAPI_T
>   sudo taskset -pc 2 $NAPI_T
> ```

I must have missed it in the original cover letter because I didn't
know that you had moved NAPI polling to core 2.

So: 
  - your base case is testing share one CPU core, where IRQ/softirq
    interference is likely to occur when network load is high

  - your test case is testing a 2 CPU setup, where one core does
    NAPI processing with BH disabled so that IRQ/sofitrq cannot
    interfere

Is that accurate? It may not be, and if not please let me know.

I never heard back on my response to the cover letter so I have no
idea if my understanding of how this works, what is being tested,
and the machine's configuration is accurate.

I think this points to more detail required in the cover letter
given how none of this seems particularly obvious to either Martin
or I.

