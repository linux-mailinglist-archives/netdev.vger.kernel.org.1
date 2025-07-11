Return-Path: <netdev+bounces-205984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59834B01047
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D03C5C3CAF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B99020B22;
	Fri, 11 Jul 2025 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eURQWELE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C41FB663;
	Fri, 11 Jul 2025 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194198; cv=none; b=dEZqMm4+hkaJSnpwdYrIw3Sb8IqHWbc/mLqmbAiHbvAhxUFNyw9PcKgV4nJUHvZWC8OJ36ktQVjiW0Pxm4WhSV6VFnAszZMB25aZ4sNBafvxAXb3SjHbKCNssUUIqSLgAPZDcJ5l/fQat+7q63dANbsHJsnEX1Qd+uBG90nRuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194198; c=relaxed/simple;
	bh=uRG3zFxu77UEZXC6qq2/JvpSQZ/oV8mQvHKh7P35t8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxs2KHhp1cvgPqS1CPxB85h1EpEnSdSYC598udFU9r/Hhc9dpXyVGCAuYRuGsprtBgiGHe45XJCfr4VfdIxOHNOezroQklYyEu1jTVchyFrkE2/z7Mrrho0QBMagJ1wgLXXYNBl4epUhUeVkpa15UoVt3XfzyAiulQs4Y+TynZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eURQWELE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C9EC4CEE3;
	Fri, 11 Jul 2025 00:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752194197;
	bh=uRG3zFxu77UEZXC6qq2/JvpSQZ/oV8mQvHKh7P35t8k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eURQWELEMTJnkLOSxdp6MXjIxwgv0uBl134q1lkVL7NqxBZLDaZN0J4ZXGSHCgvIh
	 m+oa3km4B3YgjiPis60UU5ftefwUnabjrs9rZF2gnw8bzD51dgahFt0xpAE3cOghGd
	 VcQD2WJU0v3A6xjZM0FWIPsXdY5riq7lNJ5NaMF0MvUSwD15sV/fJBaL34kP+stLde
	 f+llROOJSKOk9yiUzZJTJdie558+LkVlUuyrZSET29/qV8QFRMjBi6xfWWm4bZfLp4
	 /LlP2HVqWiKITdT4j3g6NwBSQ8dS1PujZPV55zEYNhaLyURClp1/oFtZReCi9Az3tA
	 KtajtZrlZwvCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5A2EBCE0A44; Thu, 10 Jul 2025 17:36:37 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:36:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] Introduce simple hazard pointers
Message-ID: <7ae5149a-c8aa-46de-9b8e-66b6e695eaf6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250414060055.341516-1-boqun.feng@gmail.com>
 <20250414060055.341516-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414060055.341516-2-boqun.feng@gmail.com>

On Sun, Apr 13, 2025 at 11:00:48PM -0700, Boqun Feng wrote:
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
> 
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

That smp_cond_load_acquire() in synchronize_hazptr() will become
painful at some point, but when that situation arises, we will have the
information required to adjust as appropriate.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

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
> +
> +DECLARE_PER_CPU_SHARED_ALIGNED(void *, shazptr_slots);
> +
> +/* Represent a held hazard pointer slot */
> +struct shazptr_guard {
> +	void **slot;
> +	bool use_wildcard;
> +};
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
> 2.47.1
> 

