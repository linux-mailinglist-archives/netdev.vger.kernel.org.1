Return-Path: <netdev+bounces-101284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62048FE02F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7032FB23FA6
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 07:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEFF13AD04;
	Thu,  6 Jun 2024 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q2Pa3lV2"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683813A868;
	Thu,  6 Jun 2024 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660380; cv=none; b=reegTZBVIcvDsToa2hsMCdtEBAAQFsxReyrx36+DkH8frqNJPAJXTUP2L0/CfiEOugsEpAK8/WtX0W8EKvU9a4qF5LoLzEACO8gmwoxCFwfXN/HTGyHfMlZOxAHK/kccLqbyVgXNoMmW5Xhr0SLFieII42NI1Tu4j9DoOSir2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660380; c=relaxed/simple;
	bh=BwYxHHWvB1uZZP2ZgxoL/RFqtDAfYilZfWrjOdV4eOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTAXBDWf/DKMeGalwjoO5mQE+TaZDOqW2gGC5xxsSebpq1Q5izJD3HxxbSxCI3qnXOHrEIZ3ftJM/YHVbj+ygj7YnYcuITwodWbZZHGz7akYGGXQsbhl0qzP14d9Dq6iGNqFn56JlkTZFL5bk1auMMAad5kWl6Yzb8VZcbqML4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q2Pa3lV2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SuQyD+sLDXV8oCXL9Pl1e8PdK2YOMCbBfYFAwTy1UYU=; b=Q2Pa3lV2tiP162lvLviNt5iklu
	lu7XvOo8d2uTDhU62qpiYk08cT5huaHBCEWFXxAds9Ww+/nz/KhxzpRymhI71GDYq2ZWGZuaO/Rll
	PJwPk4okR3gXoYHsR3cKT7G/KldCoZNaUJzvRS2l30OoFO50wRcNMD+08anfLtrQHJZ4ohuEtHE2I
	fKtDNAcj3rs57+KmBDoikqE/MQXSMZnUXKSxPlyRO87qVvFOXeh8ii4p3mGWBET0UBtnjyYVEsAQ2
	0Df7hCQOixeqMa9oyS+K+ksBDf/Xmf8Qn0/kogH7GWsnZ5yC2VmM6eHeTsCi8fmb/OSWFlFqfL4b9
	Zx68klGQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF7vT-00000009sY5-3ZjH;
	Thu, 06 Jun 2024 07:52:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7CCF030047C; Thu,  6 Jun 2024 09:52:44 +0200 (CEST)
Date: Thu, 6 Jun 2024 09:52:44 +0200
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
Subject: Re: [PATCH v4 net-next 01/14] locking/local_lock: Add local nested
 BH locking infrastructure.
Message-ID: <20240606075244.GB8774@noisy.programming.kicks-ass.net>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
 <20240604154425.878636-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604154425.878636-2-bigeasy@linutronix.de>

On Tue, Jun 04, 2024 at 05:24:08PM +0200, Sebastian Andrzej Siewior wrote:
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

should we assert this? lockdep_assert(current->migration_disabled) or
somesuch should do, rite?

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

Otherwise I suppose sp.. not a fan of the whole nested thing, but I
don't really have an alternative proposal so yeah, whatever :-)

