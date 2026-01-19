Return-Path: <netdev+bounces-251269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF34CD3B784
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFAE33006631
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6192E3387;
	Mon, 19 Jan 2026 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="lq8kv+Tb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gajNBoG2"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0673728B7DB;
	Mon, 19 Jan 2026 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851896; cv=none; b=pKpfdnNQLWFrHQrBwMWbjTL1QZ7r/McGbq8QwvYjkL6X8k9WZPwhgT1lmHRRKWVzirTiulbSaTTOJ2vvUq664vuwdacNzuso+nPMWc5j/n5JrEWuA7WBJYRfAqzbFS9y1yi4dqqFOGf4LeXjoTX7wkcumpmuxlU/Sa8cN21E/kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851896; c=relaxed/simple;
	bh=bDFDEVaTCBBAYbGrOAKDIkCm0xGtvcaeQwUDe9QhOXA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FIEWtxOJmYMZV9NufSEWfvgb1zehaL9gi2ZO/QpwptrZZ50ApJNN9j6IweAD3vIQu3IsNtI1axO7+ZTTJgs/PgZg9rfhR9ylqQ98B9YVJd/G0ZChsTnra6Zlm6l+2Z8I/o/ScGWgcC5Tg8A18pFaPToBcPqa9S2hh574NxYbTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=lq8kv+Tb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gajNBoG2; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 27FD91D002EB;
	Mon, 19 Jan 2026 14:44:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 19 Jan 2026 14:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768851892; x=1768938292; bh=LoVesKvEDZ
	v1Cg5uKpzhYtUwqzCfdIo4UCFjeKjmD1A=; b=lq8kv+TbQsU5zKfbNXe4EWlvP8
	rbetP0mVzYEasv/PNbF5IR7RD7qoJtpRRCvmD1pEhNkq6+glcJYQjbGrY2gea4d5
	ZWCtgjYJPVYYpUmsb7vq+LSkuvMUTpE4TsSiicuOva9bX+kc48daWYCVNMfVfPm9
	XtvBFMGy4eHZ3aSH8mjypUM7f2J9hNgcyU9nY3V7p/+r1AsL5p067JkaYUxc8pa5
	/4ccq8Y8IMSARYPWrMq05zA07tZQPMfRYzjEN47nYuICpWvThn9HBqIo9JjaRfgO
	Vg9nWB+SRMcWwQDXDQC5BdrgWjdNP0+uWX92zkTMcS0w+UYPOff4oRxQfsmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768851892; x=1768938292; bh=LoVesKvEDZv1Cg5uKpzhYtUwqzCfdIo4UCF
	jeKjmD1A=; b=gajNBoG2fkUp5vFZUoOvwaukQOqNzOhjkyPRlthYWwYIwU3dTq/
	FRcDjt0u6ShrLY9hRrRwlUHgXPtpsZII/DDB38D1Kx8lDT0VEIsd8yNkMmUdNkkG
	PKPhjH3GRNmyDv1AuSSjmuFNfros198YaBC+sbxAThMtdZcpS55DyV/Z9HoGn+Hl
	IM9cqrwZvaXHU90RHKraxl+c0qj7cimZv8Eo1arg4MJQVuRx1wqfxQ8ZHeRPgR1T
	cJPdTvqVKiwc9B7Nyu0IPAlRAczb70ukfKvaZmDLaiD+Eycni8StyYk+eHJScPDj
	z3nYvdUx4dGEW7oG7T/aQbrieCrHdFMovVA==
X-ME-Sender: <xms:tIluaeUIN8Mxwi3ueBMYLYlHMke1xjEhyD_onm3ACXuWtNdDLXluBg>
    <xme:tIluaUmlcc6UfVCocX7-vYQI4t3sKufm-ssLX1YxN0mNcxzh3eCdDgiIbpb1zJzui
    htI0MA8xCw7p9PMHJ1wJ-a7Sk3P3rCmm-Q3M2agJcMgw4JJ3aiX9rg>
X-ME-Received: <xmr:tIluaZCEbdbCL5dyTEhPcxHpPqrYEF9kq1PWYljltz5IDcS_EiHWix10PAQcG4pD7Nt4chvtTKcu03Qj-G_5dzT-7jVio3Q1kRiV6dMd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeekgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefpihgtohhlrghs
    ucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrh
    hnpefgvedvhfefueejgefggfefhfelffeiieduvdehffduheduffekkefhgeffhfefveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtoh
    esfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepvghrihgtrdguuhhmrgiivghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuh
    gsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tIluaTjPMqcv6LNRcltvYXRW53MrPhZH64La8yYApxxb_vgnR0W6Gg>
    <xmx:tIluaWzbMfEfkRn20g8vGCVxKglQ6ruawC9ZKGhOHq3c6bw8eaxYLQ>
    <xmx:tIluaU1VoZ_BwonYWvm0SBK2Fq8mibYSQWfjI2QTcn3P4sRvkiJtgA>
    <xmx:tIluab9UbtpBOWej-gZFIWz-TTvi1c9KzgnXkZBNdyU0TjQ1OIjtiw>
    <xmx:tIluaYXed53nvSQVDaweCLKS_yD9JuX4wo3konXT1zqCRLyvXi6ZjMiU>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 14:44:52 -0500 (EST)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id E79FC14FCE51;
	Mon, 19 Jan 2026 14:44:51 -0500 (EST)
Date: Mon, 19 Jan 2026 14:44:51 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: David Laight <david.laight.linux@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Eric Dumazet <edumazet@google.com>, 
    linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
    Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
In-Reply-To: <20260119190341.39c3d04c@pumpkin>
Message-ID: <05853n16-s64r-6976-q763-p9262p5o176n@syhkavp.arg>
References: <20260118152448.2560414-1-edumazet@google.com> <20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org> <20260118225802.5e658c2a@pumpkin> <681985ss-q84n-r802-90pq-0837pr1463p5@syhkavp.arg> <20260119190341.39c3d04c@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 19 Jan 2026, David Laight wrote:

> On Mon, 19 Jan 2026 10:47:51 -0500 (EST)
> Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > On Sun, 18 Jan 2026, David Laight wrote:
> > 
> > > On 32bit you probably don't want to inline __arch_xprod_64(), but you do
> > > want to pass (bias ? m : 0) and may want separate functions for the
> > > 'no overflow' case (if it is common enough to worry about).  
> > 
> > You do want to inline it. Performance quickly degrades otherwise.
> 
> If it isn't inlined you want a real C function in div.c (or similar),
> not the compiler generating a separate body in the object file of each
> file that uses it.

Yes you absolutely do in this very particular case. This relies on a 
long sequence of code that collapses to only a few assembly instructions 
due to constant propagation. But most of the time gcc is not smart 
enough to realize that (strangely enough it used to be fine more than 10 
years ago). The corresponding function is not only slower but actually 
creates bigger code from the argument passing handling overhead.

> > And __arch_xprod_64() exists only for 32bit btw.
> 
> I wonder how much of a mess gcc makes of that code.
> I added asm functions for u64 mul_add(u32 a, u32 b, u32 c) calculating
> a * b + c without explicit zero extending any of the 32 bit values.
> Without that gcc runs out of registers and starts spilling to stack
> instead of just generating 'mul; add; adc $0'.

Here this is different. Let me copy the definition:

* Prototype: uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
* Semantic:  retval = ((bias ? m : 0) + m * n) >> 64
* 
* The product is a 128-bit value, scaled down to 64 bits.
* Hoping for compile-time optimization of  conditional code.
* Architectures may provide their own optimized assembly implementation.

ARM32 provides its own definition. Last time I checked, RV32 already 
produced optimal code from the default C implementation.

> But 64bit systems without a 64x64=>128 multiply (ie without u128
> support) also need the 'multiply in 32bit chunks' code.

Again this is only for 32-bit systems. 64-bit systems use none of that.


Nicolas

