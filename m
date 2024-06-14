Return-Path: <netdev+bounces-103580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3F7908B36
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434EA1F23F8D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6A7195808;
	Fri, 14 Jun 2024 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phq6nZwL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A1811FE
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366613; cv=none; b=s0Qcs3o5YTJ7LvRon32NboDfA2tgMjtUzLSnyc9PI0Lkk+YSEQhRWfJ5J0Dh9ZfjX/qpd8OeTTqs2twAuU1gylqAegQ2d4GhUh/e01f0InhGpyxsDIWHEk/PFnuOh4p8xLDikNGaZu0cfXL7784PiXUDHlVom8zI4UZ6vtlumts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366613; c=relaxed/simple;
	bh=DQPGBUTjt/uHl1Hv3TXbvTOF0/fynX3OlySL1AUY53I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZzE3QzslVzFIygLMrPSV9OVldkrwb68GEtAmDjduO6KWI1bJ4xwxTCfAPpxgn6JQIE7dSDPx2FvMfoKx2S4pjNXb0AO0UyISqcQygcNN35y1rVMv/p5olWViROUq4q/nEW1LOm/S1WIXX07DXHvmIrasBxlfJEyTvHby4Rgqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phq6nZwL; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c9b74043b1so984232b6e.1
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 05:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718366611; x=1718971411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DQPGBUTjt/uHl1Hv3TXbvTOF0/fynX3OlySL1AUY53I=;
        b=Phq6nZwLgPolWBpxlgAHBbxl4R/CrXkqAcPr4AD9LX35d0HJkpn7gVYsoc6/eYqkIN
         OKO9IcojLy24u/u6opziDvaEmWZIeOayChll9J3lQ3LOjWd6HSAS7u31GZ+pTeYwggme
         XM0jiPl5RZZrDh/sSDsXTRl4buWqcZ9SWmSkR2tdH1bT/8ANJ5ql+HW6tW6qH8pL4LKe
         SMnpSaqnBhDURvnslWWpTdfnRNko72T+yf2COsfDl6s9jJFMs8uKq3pBd2dapQImPEFg
         ALaqMDJiHzff7FQJmtj519AuBzMATy3rE2jMcRvylYTVzCTrrQh8kNhoVa0X8yvaQBin
         Lvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718366611; x=1718971411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQPGBUTjt/uHl1Hv3TXbvTOF0/fynX3OlySL1AUY53I=;
        b=Xsx6Xo93u9E4NcpHYdlgY6Y3VCbhWAhtKBRWi9XcbCJJvHuyrDXAapqSBWqe/hKsUY
         yElEr5CC3sYTrgtjcQT/EdHAojjB4IHNLT8hvna1HF7wXIjBD0UlZKPj0cMcAPuoMwgr
         kLAcMj6jp0YPrjULCuO92dwT790hJOxm5wjoAI29zObDaQMvhIGnb7hVYjZJ0KZOos97
         BtPU3By9zY5yEegO/ocCVPrSPcD747F/mQ1O04xU/YbbLhLd4TSmxTPijXIBPGWAX9co
         mS8w/BpuyCuddvHYo48mUgIKQkEsMJYyJnPZwv/wU8Bh+mHRkif8kiUgnXIei27/GcYe
         mAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOJBYzyG/AsVkcOTCEM7BU896WMlVwBFsFjfjlMUPUmPRgkH5AYPoPkVZuMxkQOtVCtO1iLDt3kLynqbvwUj5GNrx82YMk
X-Gm-Message-State: AOJu0YyaI33PZAOBwjDK7DSH+nRZPIUj0m6Hl0ELHbuq/0jbumEarZ1c
	kBmWGdTkn80CmOMM7X9GAV4wj7klWSWmAotEcka6mtHdW9W5vt5E8NgthuzY13wSLwqzyQ4u6ka
	cqs3c4bGgSMPFEYM46iMwg3CMTPI=
X-Google-Smtp-Source: AGHT+IEce6IPckyCTKcKRFpieIb75jc8usn+Q31egvqn9SOSDESIamDvR4fDIsKn+8zbgumsRTCx5GAujG3rk7LUJr4=
X-Received: by 2002:a05:6808:1528:b0:3d2:250e:470e with SMTP id
 5614622812f47-3d24e8f989amr2654844b6e.18.1718366610660; Fri, 14 Jun 2024
 05:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611045830.67640-1-lulie@linux.alibaba.com>
 <c4ae602bd44e6b6ad739e1e17c444ca75587435e.camel@redhat.com>
 <CANn89iK88gJG2PsEnXWmN=kPydVqbNGZeLQ69p+Ho+60FWzaSw@mail.gmail.com> <8fe6208c-c408-4a14-acbc-84a1130b3ddf@linux.alibaba.com>
In-Reply-To: <8fe6208c-c408-4a14-acbc-84a1130b3ddf@linux.alibaba.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 14 Jun 2024 14:02:53 +0200
Message-ID: <CAF=yD-Jxq2nZ2X0C3cRLUnszddwdGMS+nhCPs2uWjGqc=Amd7g@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Add tracepoint for rxtstamp coalescing
To: Philo Lu <lulie@linux.alibaba.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Mike Maloney <maloney@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com, 
	Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"

> >> On Tue, 2024-06-11 at 12:58 +0800, Philo Lu wrote:
> >>> During tcp coalescence, rx timestamps of the former skb ("to" in
> >>> tcp_try_coalesce), will be lost. This may lead to inaccurate
> >>> timestamping results if skbs come out of order.
> >>>
> >>> Here is an example.
> >>> Assume a message consists of 3 skbs, namely A, B, and C. And these skbs
> >>> are processed by tcp in the following order:
> >>> A -(1us)-> C -(1ms)-> B
> >>
> >> IMHO the above order makes the changelog confusing
> >>
> >>> If C is coalesced to B, the final rx timestamps of the message will be
> >>> those of C. That is, the timestamps show that we received the message
> >>> when C came (including hardware and software). However, we actually
> >>> received it 1ms later (when B came).
> >>>
> >>> With the added tracepoint, we can recognize such cases and report them
> >>> if we want.
> >>
> >> We really need very good reasons to add new tracepoints to TCP. I'm
> >> unsure if the above example match such requirement. The reported
> >> timestamp actually matches the first byte in the aggregate segment,
> >> inferring anything more is IMHO stretching too far the API semantic.
> >>
> >
> > Note the current behavior was a conscious choice, see
> > commit 98aaa913b4ed2503244 ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE
> > to TCP recvmsg")
> > for the rationale.
> >
>
> IIUC, the behavior of returning the timestamp of the skb with highest
> sequence number works well without disorder. But once disorder occurs,
> tcp coalescence can cause this issue.
>
> > Perhaps another application would need to add a new timestamp to report
> > both the oldest and newest timestamps.
>
> I prefer this way, we do need both oldest and newest timestamps of a
> message to find if any packet is unexpected delayed after sending.
> But given there can be both hardware and software timestamps, we may
> need more fields in sk_buff to carry these new timestamps.

Unfortunately returning multiple timestamps in tcp_recv_timestamp
requires a new extended struct scm_timestamping, and likely an extra
field to store both after coalescing.

FWIW, I maintain a patch that also changes semantics, by returning not
the timestamp associated with the last byte in the message (which is
the current defined behavior), but the first byte that makes the
socket readable. Usually just the first byte, unless SO_RCVLOWAT is
set.

It is definitely easier to define a flag like SOF_TIMESTAMPING_POLLIN
that changes behavior of the one timestamp returned, than to return
two timestamps.


> >
> > Or add a socket flag to prevent coalescing for applications needing
> > precise timestamps.
> >
> > Willem might know better about this.
> >
> > I agree the tracepoint seems not needed. What about solving the issue instead ?
> Thanks.

A tracepoint is also not needed as a bpftrace program with kfunc on
tcp_try_coalesce should be able to access this information already
without kernel modifications. Or if it has to be at this line, a
program with kprobe at offset, but that requires manual register
reading.

