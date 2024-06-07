Return-Path: <netdev+bounces-101746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDCB8FFE72
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32C11F29EE8
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F15115B159;
	Fri,  7 Jun 2024 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jqGTdLWv"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA615B146;
	Fri,  7 Jun 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750345; cv=none; b=kW6fHYkawzUvnz5qNJFqq63MH65CwunaWYLe3D6xUP/IAIKzO33VAmsQhwrLiKVxrBd/JJR/tsDSL42KF4MetRMSRsZioz56XhfXKiOcOa82uXroWSZqcsW3NAJY52ObNAoJ8WMfw+hR1yx2DSvFFpmL5uknacJjBZgIVrw6H2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750345; c=relaxed/simple;
	bh=iTPRRQOvPok8xlSPKpxY2JTbNwsVV55WTe+YB0l3dDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swoK1ToVhksZVJ6aFNokHgna4Bk7HARM8yRIUamTKCF0S7/COg+dY5zUxC65ZLUsP3Yegnsbj2xgCv7JO5Pc4/aor9i8n9+Aztga3kRi5ShHXe32kmPYXjaQfWDcqycAXTMjn3xJRvJtO04DRtpqAxmrR4vDLh+3CEIIecQKLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jqGTdLWv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y4XbcYSuremmP3gL9yQrQsDM5EscIQsQEPM6XKHwLrg=; b=jqGTdLWvUQGPXrm0pKxeSKzcyl
	eev6H2NqhHTBavxvYyn7QBy0CQaDDMPxwvwL53ylukBrj6cDy6XIA6NqY4qlWNgfO7B0XzfGJe+79
	m/bbO+2Jf2tka1LnwIFXjCUfvYEtQlAWBWsVAD+Yuql3sSwbcyBoHv4cs1MT5DeZqemJJ3gDOxWyA
	97s1FkCtQOufs1JdVKW/vqesZQUNhrBFhh+b+wGuDbgEZBfdYa0mjooX+m7R1NLNDBK2FivmbAtTJ
	atKXZrfZXFk3jAy2CGzuAGMu3TuMr2xnQ22PW5XDmCRvaAdadlBsg4BQBJprvGRxBvndeebt+g9eF
	MaMYUNOw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFVKc-00000004f8o-1UyP;
	Fri, 07 Jun 2024 08:52:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7D04C30047C; Fri,  7 Jun 2024 10:52:16 +0200 (CEST)
Date: Fri, 7 Jun 2024 10:52:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 net-next 02/15] locking/local_lock: Add local nested
 BH locking infrastructure.
Message-ID: <20240607085216.GM8774@noisy.programming.kicks-ass.net>
References: <20240607070427.1379327-1-bigeasy@linutronix.de>
 <20240607070427.1379327-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607070427.1379327-3-bigeasy@linutronix.de>

On Fri, Jun 07, 2024 at 08:53:05AM +0200, Sebastian Andrzej Siewior wrote:
> Add local_lock_nested_bh() locking. It is based on local_lock_t and the
> naming follows the preempt_disable_nested() example.
> 
> For !PREEMPT_RT + !LOCKDEP it is a per-CPU annotation for locking
> assumptions based on local_bh_disable(). The macro is optimized away
> during compilation.
> For !PREEMPT_RT + LOCKDEP the local_lock_nested_bh() is reduced to
> the usual lock-acquire plus lockdep_assert_in_softirq() - ensuring that
> BH is disabled.
> 
> For PREEMPT_RT local_lock_nested_bh() acquires the specified per-CPU
> lock. It does not disable CPU migration because it relies on
> local_bh_disable() disabling CPU migration.
> With LOCKDEP it performans the usual lockdep checks as with !PREEMPT_RT.
> Due to include hell the softirq check has been moved spinlock.c.
> 
> The intention is to use this locking in places where locking of a per-CPU
> variable relies on BH being disabled. Instead of treating disabled
> bottom halves as a big per-CPU lock, PREEMPT_RT can use this to reduce
> the locking scope to what actually needs protecting.
> A side effect is that it also documents the protection scope of the
> per-CPU variables.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I'm assuming this (and the previous) patch will make their way through
the network tree, seeing how it's users and everything else is network
stuff.

