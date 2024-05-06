Return-Path: <netdev+bounces-93745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679938BD08C
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23581280C08
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9FB1534FD;
	Mon,  6 May 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mjTrL+M/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aBdofRxm"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88C1534E5;
	Mon,  6 May 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006644; cv=none; b=B13DlyEluEz3h8JU0rPCmscsLzHqmjYdeqPAenvnFUwrgdcU+G36FnUW2OW/EoPWmr19xcZLalc/SheHz+81aE4VcpKoh22FJhq4DUPswsPE1DcgaAZvT37zCEH8k5ELOXEdPuoySiMjgEsPCL6AycJsEzbdHnHvrC/eB1eD21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006644; c=relaxed/simple;
	bh=OuM/H3qINfOzCQkL3sukKEitkVGJMlavmaV4oYhb4Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efr74gPUVb++xzvVsaHh7UeM+GijtSxPlyeGCInei5ZnxtXetoQJP6oLglHR+JP0Tj81oqxbHM8IJYw15aEpsxP6TMXJo/87vNDrC4PVE19Ac5dAiJ7xSFTKT9MVmseWzIJBxEt6qfrz2iTQWE9f2aP5+C697h2Ik2HMgi3gizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mjTrL+M/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aBdofRxm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 6 May 2024 16:43:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715006640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+17KTu0vecr45/CU20r0ymLx4clM9yLKI0xnA9xyBk=;
	b=mjTrL+M/wnHLmGDQbZ1LTzkD8cdNhzejF0byOGvZ/i4eRbIoSYjirIa2LPwRruBZrfDl4q
	ntO59K2bs8ns0OAGlXFx/p5nex+0/UMF837kBom8+FwPIUBebc5eorG64CuYYBzvgsaFpj
	bfjqJqxtVIVkliVhzHvACRSRRIVtp0qn/USE6uVnrVcxpdRUMKoOQAotBB3lNFqg7DKEJX
	M6t9tCAsEbP3Ia/9ttCtYikK36v9lckkVatk1BfIEtkIbmOngYtgaUAyAL0RnQa67ZjuZs
	piTqecxDmgGtmj+jRkvNkSIH76hOQbgs7l2aw0SVC05+l2nn4s8UXKWy270fcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715006640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+17KTu0vecr45/CU20r0ymLx4clM9yLKI0xnA9xyBk=;
	b=aBdofRxm1GkXMlZ8sMIK1OQLxffD8rYQylS1m5koFr7U/90pC91vExaa4zQAlzcFQLryqr
	vpqcwtg/sOvXIWAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 net-next 00/15] locking: Introduce nested-BH locking.
Message-ID: <20240506144358.Dqd57lTp@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <0d2eca9e80ae644583248a9e4a4bdee94999a8f8.camel@redhat.com>
 <20240506093828.OLP2KzcG@linutronix.de>
 <7d46b465dd986bdf07330a7ed8d466674dec4859.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d46b465dd986bdf07330a7ed8d466674dec4859.camel@redhat.com>

On 2024-05-06 16:12:00 [+0200], Paolo Abeni wrote:
> 
> I think sometimes the stack could call local_bh_enable() after a while
> WRT the paired spin lock release, to enforce some serialization - alike
> what inet_twsk_purge() is doing - but I can't point to any specific
> line on top of my head.

I *think* the inet_twsk_purge() is special because the timer is pinned
and that bh_disable call ensures that the timer does not fire.

> A possible side-effect you should/could observe in the final tree is
> more pressure on the process scheduler, as something alike:
> 
> local_bh_disable()
> 
> <spinlock lock unlock>
> 
> <again spinlock lock unlock>
> 
> local_bh_enable()
> 
> could results in more invocation of the scheduler, right? 

Yes, to some degree.
On PREEMPT_RT "spinlock lock" does not disable preemption so the section
remains preemptible. A task with elevated priority (SCHED_RR/FIFO/DL)
remains on the CPU unless preempted by task with higher priority.
Regardless of the locks.

A SCHED_OTHER task can be preempted by another SCHED_OTHER task even
with an acquired spinlock_t. This can be bad performance wise if this
other SCHED_OTHER task preempts the lock owner and blocks on the same
lock. To cope with this we had something called PREEMPT_LAZY (now
PREEMPT_AUTO) in the RT-queue to avoid preemption within SCHED_OTHER
tasks as long as a spinlock_t (or other lock that spins on !RT) is
acquired.
By removing the lock from local_bh_disable() we lose that "please don't
preempt me" feature from your scenario above across the BH disabled
section for SCHED_OTHER tasks. Nothing changes for tasks with elevated
priority.

> Cheers,
> 
> Paolo

Sebastian

