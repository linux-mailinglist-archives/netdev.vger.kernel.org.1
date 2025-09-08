Return-Path: <netdev+bounces-220828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0719B48F98
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247287A83DC
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C0A30B51F;
	Mon,  8 Sep 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zM7OQuiq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dtz20LEL"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED52E9ED4;
	Mon,  8 Sep 2025 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338227; cv=none; b=i3RbV6oqENItaOQcwTIZyoHMBTxIn8gDx7uSUiYc/+Q/vy4Hi682SyrjmNF8Pz63qS/xzjERXwj2ZVow7Tj1Guadpyg+sxCxNrudN8FG8wi5qpFJlPdlyq8hdY4UwigKgUd75MUrtnshjmCCTe+vJ/ZEcDI7mzU5TCxMxrnvl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338227; c=relaxed/simple;
	bh=CZTn/zUMVStp6lNcr/hrrgF5WR38lS/xc+w5UwVRfuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SGdi9bWuuTl/omon5v5Cy1caMR0ODDCIvYCuF7zwW772wsRNSs/hSzsF3fsHWQCAUzubMATPorfCX5VO+bMq+o3+t7osmPCf4kj78571Bcl/rr5gG/ozb0zwyvTpsw65lBDVUVgFv8N5Pg1bwfkAvhY0FgCVteg5z4S2OAeHzU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zM7OQuiq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dtz20LEL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757338218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDiE7+12FoK+K6JwIJkB7PeHaR+Gh06/ZX6DgEpac6w=;
	b=zM7OQuiqNxvMMTGw/6vBwwVNHKnbmv5P16z70f2WR6jeyO+BxReLS8Q6Q5FkSZQt2+44/y
	wTvcC0BiRhSz27hatHHqtOsMo3cLijAjDOBIZF2gQE3RWdZ3UWuMIo2ZaCkSRypyLX5p38
	eNyj5uNcqopdQwXIkA0TnoheW+q5NlLPqGGd/g1EDCkQwO6Cpfnl1vreqDY6lqB1h386Xm
	GQAMkyVhC5vcqDABRd0Ulqgd6Na5p5ZlfVq//fPp7qpJ7b0GABL43bMpyItmO7gmYO8h7H
	D+N9GlATlpMCAiADwsmNiYBHKi93EUsM+hnsTlQ+RkV5o7v0HtVMBeVMM2ojxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757338218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDiE7+12FoK+K6JwIJkB7PeHaR+Gh06/ZX6DgEpac6w=;
	b=Dtz20LELY1TpS5eB+tAKMoDZ95Z7fGNrV2eBJvSUJ8dB3p95jwZh6dxVqkgeqQGkZU8FyD
	tSzYyParAFAknIDw==
To: Mike Galbraith <efault@gmx.de>, Breno Leitao <leitao@debian.org>, Simon
 Horman <horms@kernel.org>, kuba@kernel.org, calvin@wbinvd.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, paulmck@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
In-Reply-To: <7fc8a1db60de959fd22ae898e86683f57fb07be2.camel@gmx.de>
References: <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
 <7fc8a1db60de959fd22ae898e86683f57fb07be2.camel@gmx.de>
Date: Mon, 08 Sep 2025 15:36:17 +0206
Message-ID: <84frcx842e.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-06, Mike Galbraith <efault@gmx.de> wrote:
>> The ->write_atomic() callback is intended to perform immediate
>> transmission. It is called with hardware interrupts disabled and is even
>> expected to work from NMI context. If you are not able to implement
>> these requirements, do not implement ->write_atomic(). Implementing some
>> sort of deferrment mechanism is inappropriate. Such a mechanism already
>> exists based on ->write_thread().
>
> Truly atomic packet blasting would be a case of happiness, but barring
> that, deferment is way better than the nothing that's available to both
> RT and !RT+wireless here/now.  With a .write_atomic that's really just
> .write_thread, both RT and !RT+wireless managed to successfully send a
> death rattle with the WIP nbcon patch.. a progression for each of them.

Just be aware that ->write_atomic() will be called from _any_ context
(including scheduler and NMI) and a console implementing this callback
must handle the message or the message is lost for that console.

I request that I am added CC to the next incarnation of this
series. Thanks!

John Ogness

