Return-Path: <netdev+bounces-201025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E02BAE7E50
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2563BBC86
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BD227FD46;
	Wed, 25 Jun 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kN3JT+Ek"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AAF285CB1;
	Wed, 25 Jun 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845652; cv=none; b=Cm19TCJ9vfXh2P1sh7Wc7AU4X/5USwaOMeG0Yo5ZFqiuke4GnWKbnEU4Z/RxIPdKvV44osMWJNfAZfLKS9tFuofVZw28VdOvjRMhPrEXWniNnQ+/7fHRc+guqMOyjw43Qq3yc4CFY+suKFje8RWh8RImRv0rrfLkjE/6bBeFuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845652; c=relaxed/simple;
	bh=Ewr/9YSg+4KSWKdVpkuiGc4fRNUXEVUrfoJAoNPfx1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r84plxBBaDX/UdUvYgRPdXkENwDX92jD7rwJyPSvcrkW+32DIA0ezcK9sFep0SvRqXzFrJGXhZAkPMo58FbjODcsDu3ePk2XjU/fORDX8SsIcqUxGFujNRPDKMjgAtkA4Pb+zfPn6ff2Zcknaa+89ck7o/ffYQRiTEhOuh+0wqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kN3JT+Ek; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iqhhoiKp4vSBiJdf55jnDE3zxzap5f0PWAr4X6NeSW4=; b=kN3JT+Ek7JZ7sSUs+XXPMi9sBD
	XEBe7jG/uPr4klTRLICC44HoiZ2EMITCuP0ILfLUOy3esgmPcCegIRBf6C86LKA9GFiFAaaCxqJtR
	sK/n+7fhQzdXcbRjtNVulDf1apwo0mXSV1oND8/zAWUlwMLC7ftnkG0tn6qVHM8cUEVnVvuhD7MDI
	jQWhqSOc5SWQdaANlDGsLMZcSQL5G30jyioSVU70fD4Y7IOBKKp0MhgP1H6cNWoET7EcLcbcblPFM
	KdbHdGa3YLzPnIWDE+ww6wWC6fY7CThAajmwjtz+Wqyn5mZWA9WZBjdeoyV+bUmBdMRm4LiCUeEEs
	hRoonpxg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMvh-000000093BE-2l5l;
	Wed, 25 Jun 2025 10:00:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B5F22307E4E; Wed, 25 Jun 2025 12:00:32 +0200 (CEST)
Date: Wed, 25 Jun 2025 12:00:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Breno Leitao <leitao@debian.org>,
	aeh@meta.com, netdev@vger.kernel.org, edumazet@google.com,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH 1/8] Introduce simple hazard pointers
Message-ID: <20250625100032.GA1613376@noisy.programming.kicks-ass.net>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625031101.12555-2-boqun.feng@gmail.com>

On Tue, Jun 24, 2025 at 08:10:54PM -0700, Boqun Feng wrote:
> As its name suggests, simple hazard pointers (shazptr) is a
> simplification of hazard pointers [1]: it has only one hazard pointer
> slot per-CPU and is targeted for simple use cases where the read-side
> already has preemption disabled. It's a trade-off between full features
> of a normal hazard pointer implementation (multiple slots, dynamic slot
> allocation, etc.) and the simple use scenario.
> 
> Since there's only one slot per-CPU, so shazptr read-side critical
> section nesting is a problem that needs to be resolved, because at very
> least, interrupts and NMI can introduce nested shazptr read-side
> critical sections. A SHAZPTR_WILDCARD is introduced to resolve this:
> SHAZPTR_WILDCARD is a special address value that blocks *all* shazptr
> waiters. In an interrupt-causing shazptr read-side critical section
> nesting case (i.e. an interrupt happens while the per-CPU hazard pointer
> slot being used and tries to acquire a hazard pointer itself), the inner
> critical section will switch the value of the hazard pointer slot into
> SHAZPTR_WILDCARD, and let the outer critical section eventually zero the
> slot. The SHAZPTR_WILDCARD still provide the correct protection because
> it blocks all the waiters.

Don't we typically name such a thing a tombstone?

> It's true that once the wildcard mechanism is activated, shazptr
> mechanism may be downgrade to something similar to RCU (and probably
> with a worse implementation), which generally has longer wait time and
> larger memory footprint compared to a typical hazard pointer
> implementation. However, that can only happen with a lot of users using
> hazard pointers, and then it's reasonable to introduce the
> fully-featured hazard pointer implementation [2] and switch users to it.
> 
> Note that shazptr_protect() may be added later, the current potential
> usage doesn't require it, and a shazptr_acquire(), which installs the
> protected value to hazard pointer slot and proves the smp_mb(), is
> enough for now.
> 
> [1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
>      lock-free objects," in IEEE Transactions on Parallel and
>      Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
> 
> Link: https://lore.kernel.org/lkml/20240917143402.930114-1-boqun.feng@gmail.com/ [2]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  include/linux/shazptr.h  | 73 ++++++++++++++++++++++++++++++++++++++++
>  kernel/locking/Makefile  |  2 +-
>  kernel/locking/shazptr.c | 29 ++++++++++++++++
>  3 files changed, 103 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/shazptr.h
>  create mode 100644 kernel/locking/shazptr.c
> 
> diff --git a/include/linux/shazptr.h b/include/linux/shazptr.h
> new file mode 100644
> index 000000000000..287cd04b4be9
> --- /dev/null
> +++ b/include/linux/shazptr.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Simple hazard pointers
> + *
> + * Copyright (c) 2025, Microsoft Corporation.
> + *
> + * Author: Boqun Feng <boqun.feng@gmail.com>
> + *
> + * A simple variant of hazard pointers, the users must ensure the preemption
> + * is already disabled when calling a shazptr_acquire() to protect an address.
> + * If one shazptr_acquire() is called after another shazptr_acquire() has been
> + * called without the corresponding shazptr_clear() has been called, the later
> + * shazptr_acquire() must be cleared first.
> + *
> + * The most suitable usage is when only one address need to be protected in a
> + * preemption disabled critical section.

It might be useful to have some example code included here to illustrate
how this is supposed to be used etc.

> + */
> +
> +#ifndef _LINUX_SHAZPTR_H
> +#define _LINUX_SHAZPTR_H
> +
> +#include <linux/cleanup.h>
> +#include <linux/percpu.h>
> +
> +/* Make ULONG_MAX the wildcard value */
> +#define SHAZPTR_WILDCARD ((void *)(ULONG_MAX))

Right, I typically write that like: ((void *)-1L) or ((void *)~0UL)

> +
> +DECLARE_PER_CPU_SHARED_ALIGNED(void *, shazptr_slots);
> +
> +/* Represent a held hazard pointer slot */
> +struct shazptr_guard {
> +	void **slot;
> +	bool use_wildcard;
> +};

Natural alignment ensures the LSB of that pointer is 0, which is enough
space to stick that bool in, no?

> +
> +/*
> + * Acquire a hazptr slot and begin the hazard pointer critical section.
> + *
> + * Must be called with preemption disabled, and preemption must remain disabled
> + * until shazptr_clear().
> + */
> +static inline struct shazptr_guard shazptr_acquire(void *ptr)
> +{
> +	struct shazptr_guard guard = {
> +		/* Preemption is disabled. */
> +		.slot = this_cpu_ptr(&shazptr_slots),

What you're trying to say with that comment is that: this_cpu_ptr(),
will complain if preemption is not already disabled, and as such this
verifies the assumption?

You can also add:

	lockdep_assert_preemption_disabled();

at the start of this function and then all these comments can go in the
bin, no?

> +		.use_wildcard = false,
> +	};
> +
> +	if (likely(!READ_ONCE(*guard.slot))) {
> +		WRITE_ONCE(*guard.slot, ptr);
> +	} else {
> +		guard.use_wildcard = true;
> +		WRITE_ONCE(*guard.slot, SHAZPTR_WILDCARD);
> +	}
> +
> +	smp_mb(); /* Synchronize with smp_mb() at synchronize_shazptr(). */
> +
> +	return guard;
> +}
> +
> +static inline void shazptr_clear(struct shazptr_guard guard)
> +{
> +	/* Only clear the slot when the outermost guard is released */
> +	if (likely(!guard.use_wildcard))
> +		smp_store_release(guard.slot, NULL); /* Pair with ACQUIRE at synchronize_shazptr() */
> +}
> +
> +void synchronize_shazptr(void *ptr);
> +
> +DEFINE_CLASS(shazptr, struct shazptr_guard, shazptr_clear(_T),
> +	     shazptr_acquire(ptr), void *ptr);
> +#endif
> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> index a114949eeed5..1517076c98ec 100644
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -3,7 +3,7 @@
>  # and is generally not a function of system call inputs.
>  KCOV_INSTRUMENT		:= n
>  
> -obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
> +obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o shazptr.o
>  
>  # Avoid recursion lockdep -> sanitizer -> ... -> lockdep & improve performance.
>  KASAN_SANITIZE_lockdep.o := n
> diff --git a/kernel/locking/shazptr.c b/kernel/locking/shazptr.c
> new file mode 100644
> index 000000000000..991fd1a05cfd
> --- /dev/null
> +++ b/kernel/locking/shazptr.c
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Simple hazard pointers
> + *
> + * Copyright (c) 2025, Microsoft Corporation.
> + *
> + * Author: Boqun Feng <boqun.feng@gmail.com>
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/cpumask.h>
> +#include <linux/shazptr.h>
> +
> +DEFINE_PER_CPU_SHARED_ALIGNED(void *, shazptr_slots);
> +EXPORT_PER_CPU_SYMBOL_GPL(shazptr_slots);
> +
> +void synchronize_shazptr(void *ptr)
> +{
> +	int cpu;

	lockdep_assert_preemption_enabled();

> +
> +	smp_mb(); /* Synchronize with the smp_mb() in shazptr_acquire(). */
> +	for_each_possible_cpu(cpu) {
> +		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
> +		/* Pair with smp_store_release() in shazptr_clear(). */
> +		smp_cond_load_acquire(slot,
> +				      VAL != ptr && VAL != SHAZPTR_WILDCARD);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(synchronize_shazptr);
> -- 
> 2.39.5 (Apple Git-154)
> 

