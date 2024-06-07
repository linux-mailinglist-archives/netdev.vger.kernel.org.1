Return-Path: <netdev+bounces-101877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42C69005B5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C92C2923B5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C201953B8;
	Fri,  7 Jun 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q8IQAxHn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QF//ukp2"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A505188CAD;
	Fri,  7 Jun 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768527; cv=none; b=pdu+TzwjRVwQmUhyRyCW43Q5V5I4clScrQhLJ110f2yC1TvtFtqHzxcxAF5IV/0dlZ+H+kUS5xtQSQ6D3/P0bP171mGR+HAXZ2A0HJ/OWiOkkVa6G0TdScU8xEqj2O6cpFIxQsELXYjE+hEkru5EmWISAl+C+aPPidzyxkutQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768527; c=relaxed/simple;
	bh=a5RPpDEDYqykL90Q0KRHEPbEGICF5nDt6M3cCtmcnaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FhGBtiyQi25B93jDz2KC+69XjAVwxcamjlBCQ2TEkeV13S1vRT0dl0J7/WZfh0ntH3hoA5kkznUQHS0sphpoquxeUHYlZJFBDHSdKXXa3FrYVsEAXvs8TuJWzPEUE0Vdi0mqETEb3d3ZEUqL8BX8rjREnZxjD9eU9K++U4KGZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q8IQAxHn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QF//ukp2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717768522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5RPpDEDYqykL90Q0KRHEPbEGICF5nDt6M3cCtmcnaY=;
	b=Q8IQAxHn7DMqFrh0hvQfeKRZaMUqSN1If8x3sORFSXrge9/hTeMEEDB/gI/IV8bYdcltAG
	6W2N95y3Tko6x0c6XPEIhNMtrByEfQciuTzFMY/xlNO2gZF7jTGAFo/Bc3k+VtTqhJ1vd5
	MqwD+caiQlMtRMmTZxHum2xFGZWRcBJb0Vjia3urjQ3vvZc3tKa+F9+W2Qhssi2KVsjFS4
	eDIk6cRd6nCgjlJncdupvjNGHKCOzb5BsVtjj+f3QBrBdSFkzm3hc2WtsXp8iR23B5vO85
	JxNu4YCuOq597GLcTHwpOC1wOUGQPrzyGP2pTLDZdRJHWPU/DRt3gfsoUT1vzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717768522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5RPpDEDYqykL90Q0KRHEPbEGICF5nDt6M3cCtmcnaY=;
	b=QF//ukp2I1yuRI/6E1AHBKDFFwrGftMYR11tF9Ny3Qf9B2Or5wH53GZw4ptWBjBSWUNVNC
	tEOgSjZ4Zk0f+LAw==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v5 net-next 02/15] locking/local_lock: Add local nested
 BH locking infrastructure.
In-Reply-To: <20240607070427.1379327-3-bigeasy@linutronix.de>
References: <20240607070427.1379327-1-bigeasy@linutronix.de>
 <20240607070427.1379327-3-bigeasy@linutronix.de>
Date: Fri, 07 Jun 2024 15:55:22 +0200
Message-ID: <875xuk26yd.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 07 2024 at 08:53, Sebastian Andrzej Siewior wrote:
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

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

