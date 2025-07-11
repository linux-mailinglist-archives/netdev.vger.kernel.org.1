Return-Path: <netdev+bounces-205991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34C6B01078
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911995C49A5
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFBA18B0F;
	Fri, 11 Jul 2025 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6J5vTmo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD944101E6;
	Fri, 11 Jul 2025 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195361; cv=none; b=Vw11dRwcgBOYVeZs31tW/Eb6DswdjjkbBivlDPix6OMrkJ+C2b+1gBv3VoPWGdcHSkS5cSU6qy98kYs88zIam/l1f2W94uS4XsONiubvfgMdKNL/DY/HU3DJm0KEkuK5WSIgfzH6TVdyeDilXXPZLv6J4EmtChj0YncP7TqaYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195361; c=relaxed/simple;
	bh=L6XVSioQ3coexjmwwz3yN2TK9ucokH1H6RlaBe8WxTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgiHYmzP6JCE0cZxIMlgcHP3CXcr2Jx9xIERJMsOCeYw2L1cM18Z0Jw/yz0xGRmKt5wOxDJgBzad5UHTGR0wQlS5DpPs1TYnu59lYBXbK99dZfvddhsaTreMWJm2BlmqxMWIKqk/NdxN0Jhtpe6Knp4PmBHQkG1rsrq/ya7Cd3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6J5vTmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F3CC4CEF4;
	Fri, 11 Jul 2025 00:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752195361;
	bh=L6XVSioQ3coexjmwwz3yN2TK9ucokH1H6RlaBe8WxTY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=K6J5vTmoabhqKudYAALKKXSE0A9u4JJulAuHKamwC9U1+IAlzyKkndms0el2HMspc
	 6qeTc4DZrm5W7eyYyJ21gC1pG94ivYIxu8C+rQtIMBy2dksCn2pqtYx3vMivhiraWU
	 a3ltfQ7Qz5uQ5gVspfTBugzt3Rx1QObBR0CRMdLm8PPizSXmYzC1pe5MmxrH6Nk2Ec
	 kyBkf4sSVwCzQEsvffZ8DiAgBXxiEeeUVIRPYEziPpgm36Fg2rnvEQvqF1Dj6CKya6
	 ZH/c9W+S1Di3/7HTCAl1o7AHNuro/KQgNFQduyu5qAw/eBR/jR0+JJ7n9IAocgOz83
	 CSSxOGFFeatkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C94DACE0A44; Thu, 10 Jul 2025 17:56:00 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:56:00 -0700
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
Subject: Re: [RFC PATCH 4/8] shazptr: Avoid synchronize_shaptr() busy waiting
Message-ID: <a6172f7c-fd1d-4961-91c7-8c682e2289c6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250414060055.341516-1-boqun.feng@gmail.com>
 <20250414060055.341516-5-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414060055.341516-5-boqun.feng@gmail.com>

On Sun, Apr 13, 2025 at 11:00:51PM -0700, Boqun Feng wrote:
> For a general purpose hazard pointers implemenation, always busy waiting
> is not an option. It may benefit some special workload, but overall it
> hurts the system performance when more and more users begin to call
> synchronize_shazptr(). Therefore avoid busy waiting for hazard pointer
> slots changes by using a scan kthread, and each synchronize_shazptr()
> queues themselves if a quick scan shows they are blocked by some slots.
> 
> A simple optimization is done inside the scan: each
> synchronize_shazptr() tracks which CPUs (or CPU groups if nr_cpu_ids >
> BITS_PER_LONG) are blocking it and the scan function updates this
> information for each synchronize_shazptr() (via shazptr_wait)
> individually. In this way, synchronize_shazptr() doesn't need to wait
> until a scan result showing all slots are not blocking (as long as the
> scan has observed each slot has changed into non-block state once).
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

OK, so this patch addresses the aforementioned pain.  ;-)

One question below, might be worth a comment beyond the second paragraph
of the commit log.  Nevertheless:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/locking/shazptr.c | 277 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 276 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/shazptr.c b/kernel/locking/shazptr.c
> index 991fd1a05cfd..a8559cb559f8 100644
> --- a/kernel/locking/shazptr.c
> +++ b/kernel/locking/shazptr.c
> @@ -7,18 +7,243 @@
>   * Author: Boqun Feng <boqun.feng@gmail.com>
>   */
>  
> +#define pr_fmt(fmt) "shazptr: " fmt
> +
>  #include <linux/atomic.h>
>  #include <linux/cpumask.h>
> +#include <linux/completion.h>
> +#include <linux/kthread.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
>  #include <linux/shazptr.h>
> +#include <linux/slab.h>
> +#include <linux/sort.h>
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(void *, shazptr_slots);
>  EXPORT_PER_CPU_SYMBOL_GPL(shazptr_slots);
>  
> -void synchronize_shazptr(void *ptr)
> +/* Wait structure for synchronize_shazptr(). */
> +struct shazptr_wait {
> +	struct list_head list;
> +	/* Which groups of CPUs are blocking. */
> +	unsigned long blocking_grp_mask;
> +	void *ptr;
> +	struct completion done;
> +};
> +
> +/* Snapshot for hazptr slot. */
> +struct shazptr_snapshot {
> +	unsigned long ptr;
> +	unsigned long grp_mask;

The point of ->grp_mask is to avoid being fooled by CPUs that assert the
wildcard after having been found not to be holding a hazard pointer on
the current object?  And to avoid being delayed by CPUs that picked up
a pointer, were preempted/interrupted for a long time, then do a doomed
store into their hazard pointer?  Or is there something else subtle
that I am missing that somehow allows a given object to reappear in a
hazard pointer?

> +};
> +
> +static inline int
> +shazptr_snapshot_cmp(const void *a, const void *b)
> +{
> +	const struct shazptr_snapshot *snap_a = (struct shazptr_snapshot *)a;
> +	const struct shazptr_snapshot *snap_b = (struct shazptr_snapshot *)b;
> +
> +	if (snap_a->ptr > snap_b->ptr)
> +		return 1;
> +	else if (snap_a->ptr < snap_b->ptr)
> +		return -1;
> +	else
> +		return 0;
> +}
> +
> +/* *In-place* merge @n together based on ->ptr and accumulate the >grp_mask. */
> +static int shazptr_snapshot_merge(struct shazptr_snapshot *snaps, int n)
> +{
> +	int new, i;
> +
> +	/* Sort first. */
> +	sort(snaps, n, sizeof(*snaps), shazptr_snapshot_cmp, NULL);
> +
> +	new = 0;
> +
> +	/* Skip NULLs. */
> +	for (i = 0; i < n; i++) {
> +		if (snaps[i].ptr)
> +			break;
> +	}
> +
> +	while (i < n) {
> +		/* Start with a new address. */
> +		snaps[new] = snaps[i];
> +
> +		for (; i < n; i++) {
> +			/* Merge if the next one has the same address. */
> +			if (snaps[new].ptr == snaps[i].ptr) {
> +				snaps[new].grp_mask |= snaps[i].grp_mask;
> +			} else
> +				break;
> +		}
> +
> +		/*
> +		 * Either the end has been reached or need to start with a new
> +		 * record.
> +		 */
> +		new++;
> +	}
> +
> +	return new;
> +}
> +
> +/*
> + * Calculate which group is still blocking @ptr, this assumes the @snaps is
> + * already merged.
> + */
> +static unsigned long
> +shazptr_snapshot_blocking_grp_mask(struct shazptr_snapshot *snaps,
> +				   int n, void *ptr)
> +{
> +	unsigned long mask = 0;
> +
> +	if (!n)
> +		return mask;
> +	else if (snaps[n-1].ptr == (unsigned long)SHAZPTR_WILDCARD) {
> +		/*
> +		 * Take SHAZPTR_WILDCARD slots, which is ULONG_MAX, into
> +		 * consideration if any.
> +		 */
> +		mask = snaps[n-1].grp_mask;
> +	}
> +
> +	/* TODO: binary search if n is big. */
> +	for (int i = 0; i < n; i++) {
> +		if (snaps[i].ptr == (unsigned long)ptr) {
> +			mask |= snaps[i].grp_mask;
> +			break;
> +		}
> +	}
> +
> +	return mask;
> +}
> +
> +/* Scan structure for synchronize_shazptr(). */
> +struct shazptr_scan {
> +	/* The scan kthread */
> +	struct task_struct *thread;
> +
> +	/* Wait queue for the scan kthread */
> +	struct swait_queue_head wq;
> +
> +	/* Whether the scan kthread has been scheduled to scan */
> +	bool scheduled;
> +
> +	/* The lock protecting ->queued and ->scheduled */
> +	struct mutex lock;
> +
> +	/* List of queued synchronize_shazptr() request. */
> +	struct list_head queued;
> +
> +	int cpu_grp_size;
> +
> +	/* List of scanning synchronize_shazptr() request. */
> +	struct list_head scanning;
> +
> +	/* Buffer used for hazptr slot scan, nr_cpu_ids slots*/
> +	struct shazptr_snapshot* snaps;
> +};
> +
> +static struct shazptr_scan shazptr_scan;
> +
> +static void shazptr_do_scan(struct shazptr_scan *scan)
> +{
> +	int cpu;
> +	int snaps_len;
> +	struct shazptr_wait *curr, *next;
> +
> +	scoped_guard(mutex, &scan->lock) {
> +		/* Move from ->queued to ->scanning. */
> +		list_splice_tail_init(&scan->queued, &scan->scanning);
> +	}
> +
> +	memset(scan->snaps, nr_cpu_ids, sizeof(struct shazptr_snapshot));
> +
> +	for_each_possible_cpu(cpu) {
> +		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
> +		void *val;
> +
> +		/* Pair with smp_store_release() in shazptr_clear(). */
> +		val = smp_load_acquire(slot);
> +
> +		scan->snaps[cpu].ptr = (unsigned long)val;
> +		scan->snaps[cpu].grp_mask = 1UL << (cpu / scan->cpu_grp_size);
> +	}
> +
> +	snaps_len = shazptr_snapshot_merge(scan->snaps, nr_cpu_ids);
> +
> +	/* Only one thread can access ->scanning, so can be lockless. */
> +	list_for_each_entry_safe(curr, next, &scan->scanning, list) {
> +		/* Accumulate the shazptr slot scan result. */
> +		curr->blocking_grp_mask &=
> +			shazptr_snapshot_blocking_grp_mask(scan->snaps,
> +							   snaps_len,
> +							   curr->ptr);
> +
> +		if (curr->blocking_grp_mask == 0) {
> +			/* All shots are observed as not blocking once. */
> +			list_del(&curr->list);
> +			complete(&curr->done);
> +		}
> +	}
> +}
> +
> +static int __noreturn shazptr_scan_kthread(void *unused)
> +{
> +	for (;;) {
> +		swait_event_idle_exclusive(shazptr_scan.wq,
> +					   READ_ONCE(shazptr_scan.scheduled));
> +
> +		shazptr_do_scan(&shazptr_scan);
> +
> +		scoped_guard(mutex, &shazptr_scan.lock) {
> +			if (list_empty(&shazptr_scan.queued) &&
> +			    list_empty(&shazptr_scan.scanning))
> +				shazptr_scan.scheduled = false;
> +		}
> +	}
> +}
> +
> +static int __init shazptr_scan_init(void)
> +{
> +	struct shazptr_scan *scan = &shazptr_scan;
> +	struct task_struct *t;
> +
> +	init_swait_queue_head(&scan->wq);
> +	mutex_init(&scan->lock);
> +	INIT_LIST_HEAD(&scan->queued);
> +	INIT_LIST_HEAD(&scan->scanning);
> +	scan->scheduled = false;
> +
> +	/* Group CPUs into at most BITS_PER_LONG groups. */
> +	scan->cpu_grp_size = DIV_ROUND_UP(nr_cpu_ids, BITS_PER_LONG);
> +
> +	scan->snaps = kcalloc(nr_cpu_ids, sizeof(scan->snaps[0]), GFP_KERNEL);
> +
> +	if (scan->snaps) {
> +		t = kthread_run(shazptr_scan_kthread, NULL, "shazptr_scan");
> +		if (!IS_ERR(t)) {
> +			smp_store_release(&scan->thread, t);
> +			/* Kthread creation succeeds */
> +			return 0;
> +		} else {
> +			kfree(scan->snaps);
> +		}
> +	}
> +
> +	pr_info("Failed to create the scan thread, only busy waits\n");
> +	return 0;
> +}
> +core_initcall(shazptr_scan_init);
> +
> +static void synchronize_shazptr_busywait(void *ptr)
>  {
>  	int cpu;
>  
>  	smp_mb(); /* Synchronize with the smp_mb() in shazptr_acquire(). */
> +
>  	for_each_possible_cpu(cpu) {
>  		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
>  		/* Pair with smp_store_release() in shazptr_clear(). */
> @@ -26,4 +251,54 @@ void synchronize_shazptr(void *ptr)
>  				      VAL != ptr && VAL != SHAZPTR_WILDCARD);
>  	}
>  }
> +
> +static void synchronize_shazptr_normal(void *ptr)
> +{
> +	int cpu;
> +	unsigned long blocking_grp_mask = 0;
> +
> +	smp_mb(); /* Synchronize with the smp_mb() in shazptr_acquire(). */
> +
> +	for_each_possible_cpu(cpu) {
> +		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
> +		void *val;
> +
> +		/* Pair with smp_store_release() in shazptr_clear(). */
> +		val = smp_load_acquire(slot);
> +
> +		if (val == ptr || val == SHAZPTR_WILDCARD)
> +			blocking_grp_mask |= 1UL << (cpu / shazptr_scan.cpu_grp_size);
> +	}
> +
> +	/* Found blocking slots, prepare to wait. */
> +	if (blocking_grp_mask) {
> +		struct shazptr_scan *scan = &shazptr_scan;
> +		struct shazptr_wait wait = {
> +			.blocking_grp_mask = blocking_grp_mask,
> +		};
> +
> +		INIT_LIST_HEAD(&wait.list);
> +		init_completion(&wait.done);
> +
> +		scoped_guard(mutex, &scan->lock) {
> +			list_add_tail(&wait.list, &scan->queued);
> +
> +			if (!scan->scheduled) {
> +				WRITE_ONCE(scan->scheduled, true);
> +				swake_up_one(&shazptr_scan.wq);
> +			}
> +		}
> +
> +		wait_for_completion(&wait.done);
> +	}
> +}
> +
> +void synchronize_shazptr(void *ptr)
> +{
> +	/* Busy waiting if the scan kthread has not been created. */
> +	if (!smp_load_acquire(&shazptr_scan.thread))
> +		synchronize_shazptr_busywait(ptr);
> +	else
> +		synchronize_shazptr_normal(ptr);
> +}
>  EXPORT_SYMBOL_GPL(synchronize_shazptr);
> -- 
> 2.47.1
> 

