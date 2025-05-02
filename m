Return-Path: <netdev+bounces-187560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86698AA7D7B
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 01:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECE49A809C
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 23:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1BC2701D5;
	Fri,  2 May 2025 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Sy1N4J4S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1EF26FD97
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229897; cv=none; b=BOCFjmnV8mJCsADQUgO/jBIJncTMEsFr7wACGatjeKA5KAPr0JIZogGEvIKz7frI3KhANxuLCurHX2X/C2JC5O2XJu4E/sXAxBr77F90VKleH0cFAcHRG0NoSbgRSTip7o9GJ1EttBBCAQfaERMHQo1IhLvJsgXKckHc1s+hW/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229897; c=relaxed/simple;
	bh=s4U5taoAVN1JBSFqEJomjE//nCSmAuRgNbrJtv6jbsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHUEyMoxDjSl/LtkVmcpZUY6FHa/9ln6OBX6/eZIxVj7g5WSf7RwV5rFu6zL13AKEqQ8fKil6MEFDMEz+Jgf1P3oWy967aBjl36mFIUgMIkkg65jPVFgkHVeDR/JwYvx0AgyH5J/Et9piEuLbTtXfjp/kgoUIGkPGAUcAIKOZko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Sy1N4J4S; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KeIpJOiGJuvWVqZmb16XpiHQ40tlq39BVMDQyeYcBZs=; t=1746229895; x=1747093895; 
	b=Sy1N4J4Sd1NKTcHouZ70QDKX4V1rlnGsDOvuW5X6SScgGFZV1bE8V8kl/K+5Y7YPXYhATZkix4k
	i4hfAXvgkKaTRnr2r4+HC22v1gB70ACEkFzfEc4VluKova1RsBUOrn3D4mRy5U1J5GSmi2nQeWshn
	+Eq/meOmedGvVRpfpzxBZW1SGbwnzmlOpkuzVK2ULxqIEKSBz2V9HMjVHDiORSc5kgKn25SuG7qBu
	FgHltsG5fgnPGh5CMRa9G1eBGnjHU0j5u+LXfKmcJzYw4qokqVDOl946mrRbddSBUIQu5VPe7RyA+
	sjVXKs4yH24xkFLe2hVt32OC32QQ5ZDOilXQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:64199 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uAzxG-0007if-4i; Fri, 02 May 2025 16:38:08 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v8 04/15] net: homa: create homa_pool.h and homa_pool.c
Date: Fri,  2 May 2025 16:37:17 -0700
Message-ID: <20250502233729.64220-5-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250502233729.64220-1-ouster@cs.stanford.edu>
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: d727352c3771831d004f0ee273319f52

These files implement Homa's mechanism for managing application-level
buffer space for incoming messages This mechanism is needed to allow
Homa to copy data out to user space in parallel with receiving packets;
it was discussed in a talk at NetDev 0x17.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v8:
* Refactor homa_pool APIs (move allocation/deallocation into homa_pool.c,
  move locking responsibility out)

Changes for v7:
* Use u64 and __u64 properly
* Eliminate extraneous use of RCU
* Refactor pool->cores to use percpu variable
* Use smp_processor_id instead of raw_smp_processor_id
---
 net/homa/homa_pool.c | 470 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_pool.h | 149 ++++++++++++++
 net/homa/sync.txt    |  77 +++++++
 3 files changed, 696 insertions(+)
 create mode 100644 net/homa/homa_pool.c
 create mode 100644 net/homa/homa_pool.h
 create mode 100644 net/homa/sync.txt

diff --git a/net/homa/homa_pool.c b/net/homa/homa_pool.c
new file mode 100644
index 000000000000..d2dfcc6f38bb
--- /dev/null
+++ b/net/homa/homa_pool.c
@@ -0,0 +1,470 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+#include "homa_impl.h"
+#include "homa_pool.h"
+
+/* This file contains functions that manage user-space buffer pools. */
+
+/* Pools must always have at least this many bpages (no particular
+ * reasoning behind this value).
+ */
+#define MIN_POOL_SIZE 2
+
+/* Used when determining how many bpages to consider for allocation. */
+#define MIN_EXTRA 4
+
+/**
+ * set_bpages_needed() - Set the bpages_needed field of @pool based
+ * on the length of the first RPC that's waiting for buffer space.
+ * The caller must own the lock for @pool->hsk.
+ * @pool: Pool to update.
+ */
+static void set_bpages_needed(struct homa_pool *pool)
+{
+	struct homa_rpc *rpc = list_first_entry(&pool->hsk->waiting_for_bufs,
+			struct homa_rpc, buf_links);
+	pool->bpages_needed = (rpc->msgin.length + HOMA_BPAGE_SIZE - 1)
+			>> HOMA_BPAGE_SHIFT;
+}
+
+/**
+ * homa_pool_new() - Allocate and initialize a new homa_pool (it will have
+ * no region associated with it until homa_pool_set_region is invoked).
+ * @hsk:          Socket the pool will be associated with.
+ * Return: A pointer to the new pool or a negative errno.
+ */
+struct homa_pool *homa_pool_new(struct homa_sock *hsk)
+{
+	struct homa_pool *pool;
+
+	pool = kzalloc(sizeof(*pool), GFP_ATOMIC);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+	pool->hsk = hsk;
+	return pool;
+}
+
+/**
+ * homa_pool_set_region() - Associate a region of memory with a pool.
+ * @pool:         Pool the region will be associated with. Must not currently
+ *                have a region associated with it.
+ * @region:       First byte of the memory region for the pool, allocated
+ *                by the application; must be page-aligned.
+ * @region_size:  Total number of bytes available at @buf_region.
+ * Return: Either zero (for success) or a negative errno for failure.
+ */
+int homa_pool_set_region(struct homa_pool *pool, void __user *region,
+		   u64 region_size)
+{
+	int i, result;
+
+	if (pool->region)
+		return -EINVAL;
+
+	if (((uintptr_t)region) & ~PAGE_MASK)
+		return -EINVAL;
+	pool->region = (char __user *)region;
+	pool->num_bpages = region_size >> HOMA_BPAGE_SHIFT;
+	pool->descriptors = NULL;
+	pool->cores = NULL;
+	if (pool->num_bpages < MIN_POOL_SIZE) {
+		result = -EINVAL;
+		goto error;
+	}
+	pool->descriptors = kmalloc_array(pool->num_bpages,
+					  sizeof(struct homa_bpage),
+					  GFP_ATOMIC | __GFP_ZERO);
+	if (!pool->descriptors) {
+		result = -ENOMEM;
+		goto error;
+	}
+	for (i = 0; i < pool->num_bpages; i++) {
+		struct homa_bpage *bp = &pool->descriptors[i];
+
+		spin_lock_init(&bp->lock);
+		bp->owner = -1;
+	}
+	atomic_set(&pool->free_bpages, pool->num_bpages);
+	pool->bpages_needed = INT_MAX;
+
+	/* Allocate and initialize core-specific data. */
+	pool->cores = alloc_percpu_gfp(struct homa_pool_core,
+				       GFP_ATOMIC | __GFP_ZERO);
+	if (!pool->cores) {
+		result = -ENOMEM;
+		goto error;
+	}
+	pool->num_cores = nr_cpu_ids;
+	pool->check_waiting_invoked = 0;
+
+	return 0;
+
+error:
+	kfree(pool->descriptors);
+	free_percpu(pool->cores);
+	pool->region = NULL;
+	return result;
+}
+
+/**
+ * homa_pool_destroy() - Destructor for homa_pool. After this method
+ * returns, the object should not be used (it will be freed here).
+ * @pool: Pool to destroy.
+ */
+void homa_pool_destroy(struct homa_pool *pool)
+{
+	if (pool->region) {
+		kfree(pool->descriptors);
+		free_percpu(pool->cores);
+		pool->region = NULL;
+	}
+	kfree(pool);
+}
+
+/**
+ * homa_pool_get_rcvbuf() - Return information needed to handle getsockopt
+ * for HOMA_SO_RCVBUF.
+ * @pool:         Pool for which information is needed.
+ * @args:         Store info here.
+ */
+void homa_pool_get_rcvbuf(struct homa_pool *pool,
+			  struct homa_rcvbuf_args *args)
+{
+	args->start = (uintptr_t)pool->region;
+	args->length = pool->num_bpages << HOMA_BPAGE_SHIFT;
+}
+
+/**
+ * homa_bpage_available() - Check whether a bpage is available for use.
+ * @bpage:      Bpage to check
+ * @now:        Current time (sched_clock() units)
+ * Return:      True if the bpage is free or if it can be stolen, otherwise
+ *              false.
+ */
+bool homa_bpage_available(struct homa_bpage *bpage, u64 now)
+{
+	int ref_count = atomic_read(&bpage->refs);
+
+	return ref_count == 0 || (ref_count == 1 && bpage->owner >= 0 &&
+			bpage->expiration <= now);
+}
+
+/**
+ * homa_pool_get_pages() - Allocate one or more full pages from the pool.
+ * @pool:         Pool from which to allocate pages
+ * @num_pages:    Number of pages needed
+ * @pages:        The indices of the allocated pages are stored here; caller
+ *                must ensure this array is big enough. Reference counts have
+ *                been set to 1 on all of these pages (or 2 if set_owner
+ *                was specified).
+ * @set_owner:    If nonzero, the current core is marked as owner of all
+ *                of the allocated pages (and the expiration time is also
+ *                set). Otherwise the pages are left unowned.
+ * Return: 0 for success, -1 if there wasn't enough free space in the pool.
+ */
+int homa_pool_get_pages(struct homa_pool *pool, int num_pages, u32 *pages,
+			int set_owner)
+{
+	int core_num = smp_processor_id();
+	struct homa_pool_core *core;
+	u64 now = sched_clock();
+	int alloced = 0;
+	int limit = 0;
+
+	core = this_cpu_ptr(pool->cores);
+	if (atomic_sub_return(num_pages, &pool->free_bpages) < 0) {
+		atomic_add(num_pages, &pool->free_bpages);
+		return -1;
+	}
+
+	/* Once we get to this point we know we will be able to find
+	 * enough free pages; now we just have to find them.
+	 */
+	while (alloced != num_pages) {
+		struct homa_bpage *bpage;
+		int cur;
+
+		/* If we don't need to use all of the bpages in the pool,
+		 * then try to use only the ones with low indexes. This
+		 * will reduce the cache footprint for the pool by reusing
+		 * a few bpages over and over. Specifically this code will
+		 * not consider any candidate page whose index is >= limit.
+		 * Limit is chosen to make sure there are a reasonable
+		 * number of free pages in the range, so we won't have to
+		 * check a huge number of pages.
+		 */
+		if (limit == 0) {
+			int extra;
+
+			limit = pool->num_bpages
+					- atomic_read(&pool->free_bpages);
+			extra = limit >> 2;
+			limit += (extra < MIN_EXTRA) ? MIN_EXTRA : extra;
+			if (limit > pool->num_bpages)
+				limit = pool->num_bpages;
+		}
+
+		cur = core->next_candidate;
+		core->next_candidate++;
+		if (cur >= limit) {
+			core->next_candidate = 0;
+
+			/* Must recompute the limit for each new loop through
+			 * the bpage array: we may need to consider a larger
+			 * range of pages because of concurrent allocations.
+			 */
+			limit = 0;
+			continue;
+		}
+		bpage = &pool->descriptors[cur];
+
+		/* Figure out whether this candidate is free (or can be
+		 * stolen). Do a quick check without locking the page, and
+		 * if the page looks promising, then lock it and check again
+		 * (must check again in case someone else snuck in and
+		 * grabbed the page).
+		 */
+		if (!homa_bpage_available(bpage, now))
+			continue;
+		if (!spin_trylock_bh(&bpage->lock))
+			continue;
+		if (!homa_bpage_available(bpage, now)) {
+			spin_unlock_bh(&bpage->lock);
+			continue;
+		}
+		if (bpage->owner >= 0)
+			atomic_inc(&pool->free_bpages);
+		if (set_owner) {
+			atomic_set(&bpage->refs, 2);
+			bpage->owner = core_num;
+			bpage->expiration = now + 1000 *
+					pool->hsk->homa->bpage_lease_usecs;
+		} else {
+			atomic_set(&bpage->refs, 1);
+			bpage->owner = -1;
+		}
+		spin_unlock_bh(&bpage->lock);
+		pages[alloced] = cur;
+		alloced++;
+	}
+	return 0;
+}
+
+/**
+ * homa_pool_allocate() - Allocate buffer space for an RPC.
+ * @rpc:  RPC that needs space allocated for its incoming message (space must
+ *        not already have been allocated). The fields @msgin->num_buffers
+ *        and @msgin->buffers are filled in. Must be locked by caller.
+ * Return: The return value is normally 0, which means either buffer space
+ * was allocated or the @rpc was queued on @hsk->waiting. If a fatal error
+ * occurred, such as no buffer pool present, then a negative errno is
+ * returned.
+ */
+int homa_pool_allocate(struct homa_rpc *rpc)
+	__must_hold(&rpc->bucket->lock)
+{
+	struct homa_pool *pool = rpc->hsk->buffer_pool;
+	int full_pages, partial, i, core_id;
+	u32 pages[HOMA_MAX_BPAGES];
+	struct homa_pool_core *core;
+	struct homa_bpage *bpage;
+	struct homa_rpc *other;
+
+	if (!pool->region)
+		return -ENOMEM;
+
+	/* First allocate any full bpages that are needed. */
+	full_pages = rpc->msgin.length >> HOMA_BPAGE_SHIFT;
+	if (unlikely(full_pages)) {
+		if (homa_pool_get_pages(pool, full_pages, pages, 0) != 0)
+			goto out_of_space;
+		for (i = 0; i < full_pages; i++)
+			rpc->msgin.bpage_offsets[i] = pages[i] <<
+					HOMA_BPAGE_SHIFT;
+	}
+	rpc->msgin.num_bpages = full_pages;
+
+	/* The last chunk may be less than a full bpage; for this we use
+	 * the bpage that we own (and reuse it for multiple messages).
+	 */
+	partial = rpc->msgin.length & (HOMA_BPAGE_SIZE - 1);
+	if (unlikely(partial == 0))
+		goto success;
+	core_id = smp_processor_id();
+	core = this_cpu_ptr(pool->cores);
+	bpage = &pool->descriptors[core->page_hint];
+	if (!spin_trylock_bh(&bpage->lock))
+		spin_lock_bh(&bpage->lock);
+	if (bpage->owner != core_id) {
+		spin_unlock_bh(&bpage->lock);
+		goto new_page;
+	}
+	if ((core->allocated + partial) > HOMA_BPAGE_SIZE) {
+		if (atomic_read(&bpage->refs) == 1) {
+			/* Bpage is totally free, so we can reuse it. */
+			core->allocated = 0;
+		} else {
+			bpage->owner = -1;
+
+			/* We know the reference count can't reach zero here
+			 * because of check above, so we won't have to decrement
+			 * pool->free_bpages.
+			 */
+			atomic_dec_return(&bpage->refs);
+			spin_unlock_bh(&bpage->lock);
+			goto new_page;
+		}
+	}
+	bpage->expiration = sched_clock() +
+			1000 * pool->hsk->homa->bpage_lease_usecs;
+	atomic_inc(&bpage->refs);
+	spin_unlock_bh(&bpage->lock);
+	goto allocate_partial;
+
+	/* Can't use the current page; get another one. */
+new_page:
+	if (homa_pool_get_pages(pool, 1, pages, 1) != 0) {
+		homa_pool_release_buffers(pool, rpc->msgin.num_bpages,
+					  rpc->msgin.bpage_offsets);
+		rpc->msgin.num_bpages = 0;
+		goto out_of_space;
+	}
+	core->page_hint = pages[0];
+	core->allocated = 0;
+
+allocate_partial:
+	rpc->msgin.bpage_offsets[rpc->msgin.num_bpages] = core->allocated
+			+ (core->page_hint << HOMA_BPAGE_SHIFT);
+	rpc->msgin.num_bpages++;
+	core->allocated += partial;
+
+success:
+	return 0;
+
+	/* We get here if there wasn't enough buffer space for this
+	 * message; add the RPC to hsk->waiting_for_bufs.
+	 */
+out_of_space:
+	homa_sock_lock(pool->hsk);
+	list_for_each_entry(other, &pool->hsk->waiting_for_bufs, buf_links) {
+		if (other->msgin.length > rpc->msgin.length) {
+			list_add_tail(&rpc->buf_links, &other->buf_links);
+			goto queued;
+		}
+	}
+	list_add_tail(&rpc->buf_links, &pool->hsk->waiting_for_bufs);
+
+queued:
+	set_bpages_needed(pool);
+	homa_sock_unlock(pool->hsk);
+	return 0;
+}
+
+/**
+ * homa_pool_get_buffer() - Given an RPC, figure out where to store incoming
+ * message data.
+ * @rpc:        RPC for which incoming message data is being processed; its
+ *              msgin must be properly initialized and buffer space must have
+ *              been allocated for the message.
+ * @offset:     Offset within @rpc's incoming message.
+ * @available:  Will be filled in with the number of bytes of space available
+ *              at the returned address (could be zero if offset is
+ *              (erroneously) past the end of the message).
+ * Return:      The application's virtual address for buffer space corresponding
+ *              to @offset in the incoming message for @rpc.
+ */
+void __user *homa_pool_get_buffer(struct homa_rpc *rpc, int offset,
+				  int *available)
+{
+	int bpage_index, bpage_offset;
+
+	bpage_index = offset >> HOMA_BPAGE_SHIFT;
+	if (offset >= rpc->msgin.length) {
+		WARN_ONCE(true, "%s got offset %d >= message length %d\n",
+			  __func__, offset, rpc->msgin.length);
+		*available = 0;
+		return NULL;
+	}
+	bpage_offset = offset & (HOMA_BPAGE_SIZE - 1);
+	*available = (bpage_index < (rpc->msgin.num_bpages - 1))
+			? HOMA_BPAGE_SIZE - bpage_offset
+			: rpc->msgin.length - offset;
+	return rpc->hsk->buffer_pool->region +
+			rpc->msgin.bpage_offsets[bpage_index] + bpage_offset;
+}
+
+/**
+ * homa_pool_release_buffers() - Release buffer space so that it can be
+ * reused.
+ * @pool:         Pool that the buffer space belongs to. Doesn't need to
+ *                be locked.
+ * @num_buffers:  How many buffers to release.
+ * @buffers:      Points to @num_buffers values, each of which is an offset
+ *                from the start of the pool to the buffer to be released.
+ * Return:        0 for success, otherwise a negative errno.
+ */
+int homa_pool_release_buffers(struct homa_pool *pool, int num_buffers,
+			      u32 *buffers)
+{
+	int result = 0;
+	int i;
+
+	if (!pool->region)
+		return result;
+	for (i = 0; i < num_buffers; i++) {
+		u32 bpage_index = buffers[i] >> HOMA_BPAGE_SHIFT;
+		struct homa_bpage *bpage = &pool->descriptors[bpage_index];
+
+		if (bpage_index < pool->num_bpages) {
+			if (atomic_dec_return(&bpage->refs) == 0)
+				atomic_inc(&pool->free_bpages);
+		} else {
+			result = -EINVAL;
+		}
+	}
+	return result;
+}
+
+/**
+ * homa_pool_check_waiting() - Checks to see if there are enough free
+ * bpages to wake up any RPCs that were blocked. Whenever
+ * homa_pool_release_buffers is invoked, this function must be invoked later,
+ * at a point when the caller holds no locks (homa_pool_release_buffers may
+ * be invoked with locks held, so it can't safely invoke this function).
+ * This is regrettably tricky, but I can't think of a better solution.
+ * @pool:         Information about the buffer pool.
+ */
+void homa_pool_check_waiting(struct homa_pool *pool)
+{
+	if (!pool->region)
+		return;
+	while (atomic_read(&pool->free_bpages) >= pool->bpages_needed) {
+		struct homa_rpc *rpc;
+
+		homa_sock_lock(pool->hsk);
+		if (list_empty(&pool->hsk->waiting_for_bufs)) {
+			pool->bpages_needed = INT_MAX;
+			homa_sock_unlock(pool->hsk);
+			break;
+		}
+		rpc = list_first_entry(&pool->hsk->waiting_for_bufs,
+				       struct homa_rpc, buf_links);
+		if (!homa_rpc_try_lock(rpc)) {
+			/* Can't just spin on the RPC lock because we're
+			 * holding the socket lock (see sync.txt). Instead,
+			 * release the socket lock and try the entire
+			 * operation again.
+			 */
+			homa_sock_unlock(pool->hsk);
+			continue;
+		}
+		list_del_init(&rpc->buf_links);
+		if (list_empty(&pool->hsk->waiting_for_bufs))
+			pool->bpages_needed = INT_MAX;
+		else
+			set_bpages_needed(pool);
+		homa_sock_unlock(pool->hsk);
+		homa_pool_allocate(rpc);
+		homa_rpc_unlock(rpc);
+	}
+}
diff --git a/net/homa/homa_pool.h b/net/homa/homa_pool.h
new file mode 100644
index 000000000000..d52d61afa557
--- /dev/null
+++ b/net/homa/homa_pool.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file contains definitions used to manage user-space buffer pools.
+ */
+
+#ifndef _HOMA_POOL_H
+#define _HOMA_POOL_H
+
+#include <linux/percpu.h>
+
+#include "homa_rpc.h"
+
+/**
+ * struct homa_bpage - Contains information about a single page in
+ * a buffer pool.
+ */
+struct homa_bpage {
+	union {
+		/**
+		 * @cache_line: Ensures that each homa_bpage object
+		 * is exactly one cache line long.
+		 */
+		char cache_line[L1_CACHE_BYTES];
+		struct {
+			/** @lock: to synchronize shared access. */
+			spinlock_t lock;
+
+			/**
+			 * @refs: Counts number of distinct uses of this
+			 * bpage (1 tick for each message that is using
+			 * this page, plus an additional tick if the @owner
+			 * field is set).
+			 */
+			atomic_t refs;
+
+			/**
+			 * @owner: kernel core that currently owns this page
+			 * (< 0 if none).
+			 */
+			int owner;
+
+			/**
+			 * @expiration: time (in sched_clock() units) after
+			 * which it's OK to steal this page from its current
+			 * owner (if @refs is 1).
+			 */
+			u64 expiration;
+		};
+	};
+};
+
+/**
+ * struct homa_pool_core - Holds core-specific data for a homa_pool (a bpage
+ * out of which that core is allocating small chunks).
+ */
+struct homa_pool_core {
+	/**
+	 * @page_hint: Index of bpage in pool->descriptors,
+	 * which may be owned by this core. If so, we'll use it
+	 * for allocating partial pages.
+	 */
+	int page_hint;
+
+	/**
+	 * @allocated: if the page given by @page_hint is
+	 * owned by this core, this variable gives the number of
+	 * (initial) bytes that have already been allocated
+	 * from the page.
+	 */
+	int allocated;
+
+	/**
+	 * @next_candidate: when searching for free bpages,
+	 * check this index next.
+	 */
+	int next_candidate;
+};
+
+/**
+ * struct homa_pool - Describes a pool of buffer space for incoming
+ * messages for a particular socket; managed by homa_pool.c. The pool is
+ * divided up into "bpages", which are a multiple of the hardware page size.
+ * A bpage may be owned by a particular core so that it can more efficiently
+ * allocate space for small messages.
+ */
+struct homa_pool {
+	/**
+	 * @hsk: the socket that this pool belongs to.
+	 */
+	struct homa_sock *hsk;
+
+	/**
+	 * @region: beginning of the pool's region (in the app's virtual
+	 * memory). Divided into bpages. 0 means the pool hasn't yet been
+	 * initialized.
+	 */
+	char __user *region;
+
+	/** @num_bpages: total number of bpages in the pool. */
+	int num_bpages;
+
+	/** @descriptors: kmalloced area containing one entry for each bpage. */
+	struct homa_bpage *descriptors;
+
+	/**
+	 * @free_bpages: the number of pages still available for allocation
+	 * by homa_pool_get pages. This equals the number of pages with zero
+	 * reference counts, minus the number of pages that have been claimed
+	 * by homa_get_pool_pages but not yet allocated.
+	 */
+	atomic_t free_bpages;
+
+	/**
+	 * @bpages_needed: the number of free bpages required to satisfy the
+	 * needs of the first RPC on @hsk->waiting_for_bufs, or INT_MAX if
+	 * that queue is empty.
+	 */
+	int bpages_needed;
+
+	/** @cores: core-specific info; dynamically allocated. */
+	struct homa_pool_core __percpu *cores;
+
+	/** @num_cores: number of elements in @cores. */
+	int num_cores;
+
+	/**
+	 * @check_waiting_invoked: incremented during unit tests when
+	 * homa_pool_check_waiting is invoked.
+	 */
+	int check_waiting_invoked;
+};
+
+bool     homa_bpage_available(struct homa_bpage *bpage, u64 now);
+int      homa_pool_allocate(struct homa_rpc *rpc);
+void     homa_pool_check_waiting(struct homa_pool *pool);
+void     homa_pool_destroy(struct homa_pool *pool);
+void __user *homa_pool_get_buffer(struct homa_rpc *rpc, int offset,
+				  int *available);
+int      homa_pool_get_pages(struct homa_pool *pool, int num_pages,
+			     u32 *pages, int leave_locked);
+void     homa_pool_get_rcvbuf(struct homa_pool *pool,
+			      struct homa_rcvbuf_args *args);
+struct   homa_pool *homa_pool_new(struct homa_sock *hsk);
+int      homa_pool_release_buffers(struct homa_pool *pool,
+				   int num_buffers, u32 *buffers);
+int      homa_pool_set_region(struct homa_pool *pool, void __user *region,
+			      u64 region_size);
+
+#endif /* _HOMA_POOL_H */
diff --git a/net/homa/sync.txt b/net/homa/sync.txt
new file mode 100644
index 000000000000..eb3c6ffb19ee
--- /dev/null
+++ b/net/homa/sync.txt
@@ -0,0 +1,77 @@
+This file describes the synchronization strategy used for Homa.
+
+* In the Linux TCP/IP stack, the primary locking mechanism is a lock
+  per socket. However, per-socket locks aren't adequate for Homa, because
+  sockets are "larger" in Homa. In TCP, a socket corresponds to a single
+  connection between the source and destination; an application can have
+  hundreds or thousands of sockets open at once, so per-socket locks leave
+  lots of opportunities for concurrency. With Homa, a single socket can be
+  used for communicating with any number of peers, so there will typically
+  be no more than one socket per thread. As a result, a single Homa socket
+  must support many concurrent RPCs efficiently, and a per-socket lock would
+  create a bottleneck (Homa tried this approach initially).
+
+* Thus, the primary lock used in Homa is a per-RPC spinlock. This allows operations
+  on different RPCs to proceed concurrently. RPC locks are actually stored in
+  the hash table buckets used to look them up. This is important because it
+  makes looking up RPCs and locking them atomic. Without this approach it
+  is possible that an RPC could get deleted after it was looked up but before
+  it was locked.
+
+* Certain operations are not permitted while holding spinlocks, such as memory
+  allocation and copying data to/from user space (spinlocks disable
+  interrupts, so the holder must not block). RPC locks are spinlocks,
+  and that results in awkward code in several places to move prohibited
+  operations outside the locked regions. In particular, there is extra
+  complexity to make sure that RPCs are not garbage-collected while these
+  operations are occurring without a lock.
+
+* There are several other locks in Homa besides RPC locks. When multiple
+  locks are held, they must always be acquired in a consistent order, in
+  order to prevent deadlock. For each lock, here are the other locks that
+  may be acquired while holding the given lock.
+  * RPC: socket, grant, throttle, peer->ack_lock
+  * Socket: port_map.write_lock
+  Any lock not listed above must be a "leaf" lock: no other lock will be
+  acquired while holding the lock.
+
+* Homa's approach means that socket shutdown and deletion can potentially
+  occur while operations are underway that hold RPC locks but not the socket
+  lock. This creates several potential problems:
+  * A socket might be deleted and its memory reclaimed while an RPC still
+    has access to it. Homa assumes that Linux will prevent socket deletion
+    while the kernel call is executing. In situations outside kernel call
+    handling, Homa uses rcu_read_lock and/or socket references to prevent
+    socket deletion.
+  * A socket might be shut down while there are active operations on
+    RPCs. For example, a new RPC creation might be underway when a socket
+    is shut down, which could add the new RPC after all of its RPCs
+    have supposedly been deleted. Handling this requires careful ordering
+    of operations during shutdown, plus the rest of Homa must be careful
+    never to add new RPCs to a socket that has been shut down.
+
+* There are a few places where Homa needs to process RPCs on lists
+  associated with a socket, such as the timer. Such code must first lock
+  the socket (to synchronize access to the link pointers) then lock
+  individual RPCs on the list. However, this violates the rules for locking
+  order. It isn't safe to unlock the socket before locking the RPC, because
+  the RPC could be deleted and its memory recycled between the unlock of the
+  socket lock and the lock of the RPC; this could result in corruption. Homa
+  uses a few different ways to handle this situation:
+  * Use homa_protect_rpcs to prevent RPC reaping for a socket. RPCs can still
+    be deleted, but their memory won't go away until homa_unprotect_rpcs is
+    invoked. This allows the socket lock to be released before acquiring
+    the RPC lock; after acquiring the RPC lock check to see if it has been
+    deleted; if so, skip it.  Note: the Linux RCU mechanism could have been
+    used to achieve the same effect, but it results in *very* long delays
+    before final reclamation (tens of ms), even without contention, which
+    means that a large number of dead RPCs could accumulate.
+  * Use spin_trylock_bh to acquire the RPC lock, while still holding the
+    socket lock. If this fails, then release the socket lock, then retry
+    both the socket lock and the RPC lock.
+
+* There are also a few places where Homa is doing something related to an
+  RPC (such as copying message data to user space) and needs the RPC to stay
+  around, but it isn't holding the RPC lock. In this situations, Homa sets
+  a bit in rpc->flags and homa_rpc_reap will not reap RPCs with any of these
+  flags set.
\ No newline at end of file
-- 
2.43.0


