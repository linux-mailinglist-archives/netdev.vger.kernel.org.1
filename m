Return-Path: <netdev+bounces-193319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED10AC389A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA2F3AE7B4
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 04:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59B81B424D;
	Mon, 26 May 2025 04:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Bdw8yCNo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB181A8F84
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 04:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748233730; cv=none; b=BqwGE5R+LQSoHe7PCizSqTBvpwIXJG59d0LI5Ob0D8Zw5kwlzUUOINKZ7oVR6cmqNrgz+eQqnxMG2S4jXeScRJhMY/B1KrQlQ4ZQmb5KHyLUlxlHkcmkVRyfytCgotkStWGJv6uXNll/SWMQhjHiH3bY9behyrQvJU67CVeCEAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748233730; c=relaxed/simple;
	bh=N0hYVe2rFrGoBvJUHRgup8mA8+Gptjy+ZliNmvYFJKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdWFZZaUoYxsgLQO4KPV32cwJ6NzoWEvSiP6fG7EpQifSgWOX9lbSxhBV0mLzk+VRFYjPzBtL2Rjb+Keto+qKoNyEO4ze0AOSCDATakXiOKFkrIxJy/xvLRV5UKRCvt3xahjH3Hi4WaeGXYgPMXEz8Z5LJKKDFlhN0NMe5syEiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Bdw8yCNo; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VVRW8BgyjQh7ui5ZNUpQHGeSfXO02rHoYVeMGCX/xcw=; t=1748233728; x=1749097728; 
	b=Bdw8yCNoR1RY1vrTTiWnwWRAnpvY3rVZDwBk8+2+DVr4fFwPK8a9TpcMF17Yv99/c61kwXHKt08
	wg7o08z/HNUyY+xebKfSKuj/xFuYdzNTa2lvaJeIpOovJCmAuz4CMovvh0Crm+IwBZxcHrEDPVx0e
	pePQJJd3E1hIUU6vviUGaf+PKMSNbYh6nCBdoRIic6soN8b5GllRG7ldAcmg005LQvMlqc6fq03EY
	fMOOKmujoxvAOPKPBakJvKN929DuRRUbLqEe9cQkyXX3zIoNzsABUqIl9YlQenEn7Hofk7TaAt6bn
	RYVdnTQznG1yBWhs8JIIOgSk3eWfx1fV0sTA==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:54961 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uJPSA-0006Qy-8H; Sun, 25 May 2025 21:28:47 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v9 04/15] net: homa: create homa_pool.h and homa_pool.c
Date: Sun, 25 May 2025 21:28:06 -0700
Message-ID: <20250526042819.2526-5-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250526042819.2526-1-ouster@cs.stanford.edu>
References: <20250526042819.2526-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 05851fdffb26bf5e8e47d3fe7e8ad3e0

These files implement Homa's mechanism for managing application-level
buffer space for incoming messages This mechanism is needed to allow
Homa to copy data out to user space in parallel with receiving packets;
it was discussed in a talk at NetDev 0x17.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Eliminate use of _Static_assert
* Use new homa_clock abstraction layer.
* Allow memory to be allocated without GFP_ATOMIC
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)
* Remove sync.txt, move its contents into comments (mostly in homa_impl.h)

Changes for v8:
* Refactor homa_pool APIs (move allocation/deallocation into homa_pool.c,
  move locking responsibility out)

Changes for v7:
* Use u64 and __u64 properly
* Eliminate extraneous use of RCU
* Refactor pool->cores to use percpu variable
* Use smp_processor_id instead of raw_smp_processor_id
---
 net/homa/homa_pool.c | 483 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_pool.h | 136 ++++++++++++
 2 files changed, 619 insertions(+)
 create mode 100644 net/homa/homa_pool.c
 create mode 100644 net/homa/homa_pool.h

diff --git a/net/homa/homa_pool.c b/net/homa/homa_pool.c
new file mode 100644
index 000000000000..c8fd219e1796
--- /dev/null
+++ b/net/homa/homa_pool.c
@@ -0,0 +1,483 @@
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
+						struct homa_rpc, buf_links);
+
+	pool->bpages_needed = (rpc->msgin.length + HOMA_BPAGE_SIZE - 1) >>
+			      HOMA_BPAGE_SHIFT;
+}
+
+/**
+ * homa_pool_alloc() - Allocate and initialize a new homa_pool (it will have
+ * no region associated with it until homa_pool_set_region is invoked).
+ * @hsk:          Socket the pool will be associated with.
+ * Return: A pointer to the new pool or a negative errno.
+ */
+struct homa_pool *homa_pool_alloc(struct homa_sock *hsk)
+{
+	struct homa_pool *pool;
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+	pool->hsk = hsk;
+	return pool;
+}
+
+/**
+ * homa_pool_set_region() - Associate a region of memory with a pool.
+ * @hsk:          Socket whose pool the region will be associated with.
+ *                Must not be locked, and the pool must not currently
+ *                have a region associated with it.
+ * @region:       First byte of the memory region for the pool, allocated
+ *                by the application; must be page-aligned.
+ * @region_size:  Total number of bytes available at @buf_region.
+ * Return: Either zero (for success) or a negative errno for failure.
+ */
+int homa_pool_set_region(struct homa_sock *hsk, void __user *region,
+			 u64 region_size)
+{
+	struct homa_pool_core __percpu *cores;
+	struct homa_bpage *descriptors;
+	int i, result, num_bpages;
+	struct homa_pool *pool;
+
+	if (((uintptr_t)region) & ~PAGE_MASK)
+		return -EINVAL;
+
+	/* Allocate memory before locking the socket, so we can allocate
+	 * without GFP_ATOMIC.
+	 */
+	num_bpages = region_size >> HOMA_BPAGE_SHIFT;
+	if (num_bpages < MIN_POOL_SIZE)
+		return -EINVAL;
+	descriptors = kmalloc_array(num_bpages, sizeof(struct homa_bpage),
+				    __GFP_ZERO);
+	if (!descriptors)
+		return -ENOMEM;
+	cores = alloc_percpu_gfp(struct homa_pool_core, __GFP_ZERO);
+	if (!cores) {
+		result = -ENOMEM;
+		goto error;
+	}
+
+	homa_sock_lock(hsk);
+	pool = hsk->buffer_pool;
+	if (pool->region) {
+		result = -EINVAL;
+		homa_sock_unlock(hsk);
+		goto error;
+	}
+
+	pool->region = (char __user *)region;
+	pool->num_bpages = num_bpages;
+	pool->descriptors = descriptors;
+	atomic_set(&pool->free_bpages, pool->num_bpages);
+	pool->bpages_needed = INT_MAX;
+	pool->cores = cores;
+	pool->check_waiting_invoked = 0;
+
+	for (i = 0; i < pool->num_bpages; i++) {
+		struct homa_bpage *bp = &pool->descriptors[i];
+
+		spin_lock_init(&bp->lock);
+		bp->owner = -1;
+	}
+
+	homa_sock_unlock(hsk);
+	return 0;
+
+error:
+	kfree(descriptors);
+	free_percpu(cores);
+	return result;
+}
+
+/**
+ * homa_pool_free() - Destructor for homa_pool. After this method
+ * returns, the object should not be used (it will be freed here).
+ * @pool: Pool to destroy.
+ */
+void homa_pool_free(struct homa_pool *pool)
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
+ * @now:        Current time (homa_clock() units)
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
+	u64 now = homa_clock();
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
+			limit = pool->num_bpages -
+				atomic_read(&pool->free_bpages);
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
+			/* Rather than wait for a locked page to become free,
+			 * just go on to the next page. If the page is locked,
+			 * it probably won't turn out to be available anyway.
+			 */
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
+			bpage->expiration = now +
+					    pool->hsk->homa->bpage_lease_cycles;
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
+ * homa_pool_alloc_msg() - Allocate buffer space for an incoming message.
+ * @rpc:  RPC that needs space allocated for its incoming message (space must
+ *        not already have been allocated). The fields @msgin->num_buffers
+ *        and @msgin->buffers are filled in. Must be locked by caller.
+ * Return: The return value is normally 0, which means either buffer space
+ * was allocated or the @rpc was queued on @hsk->waiting. If a fatal error
+ * occurred, such as no buffer pool present, then a negative errno is
+ * returned.
+ */
+int homa_pool_alloc_msg(struct homa_rpc *rpc)
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
+	spin_lock_bh(&bpage->lock);
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
+	bpage->expiration = homa_clock() +
+			    pool->hsk->homa->bpage_lease_cycles;
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
+	 * message; add the RPC to hsk->waiting_for_bufs. The list is sorted
+	 * by RPC length in order to implement SRPT.
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
+			 * holding the socket lock and the lock order is
+			 * rpc-then-socket (see "Homa Locking Strategy" in
+			 * homa_impl.h). Instead, release the socket lock
+			 * and try the entire operation again.
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
+		homa_pool_alloc_msg(rpc);
+		homa_rpc_unlock(rpc);
+	}
+}
diff --git a/net/homa/homa_pool.h b/net/homa/homa_pool.h
new file mode 100644
index 000000000000..708183e259db
--- /dev/null
+++ b/net/homa/homa_pool.h
@@ -0,0 +1,136 @@
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
+	/** @lock: to synchronize shared access. */
+	spinlock_t lock;
+
+	/**
+	 * @refs: Counts number of distinct uses of this
+	 * bpage (1 tick for each message that is using
+	 * this page, plus an additional tick if the @owner
+	 * field is set).
+	 */
+	atomic_t refs;
+
+	/**
+	 * @owner: kernel core that currently owns this page
+	 * (< 0 if none).
+	 */
+	int owner;
+
+	/**
+	 * @expiration: homa_clock() time after which it's OK to steal this
+	 * page from its current owner (if @refs is 1).
+	 */
+	u64 expiration;
+} ____cacheline_aligned_in_smp;
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
+	/**
+	 * @check_waiting_invoked: incremented during unit tests when
+	 * homa_pool_check_waiting is invoked.
+	 */
+	int check_waiting_invoked;
+};
+
+bool     homa_bpage_available(struct homa_bpage *bpage, u64 now);
+struct   homa_pool *homa_pool_alloc(struct homa_sock *hsk);
+int      homa_pool_alloc_msg(struct homa_rpc *rpc);
+void     homa_pool_check_waiting(struct homa_pool *pool);
+void     homa_pool_free(struct homa_pool *pool);
+void __user *homa_pool_get_buffer(struct homa_rpc *rpc, int offset,
+				  int *available);
+int      homa_pool_get_pages(struct homa_pool *pool, int num_pages,
+			     u32 *pages, int leave_locked);
+void     homa_pool_get_rcvbuf(struct homa_pool *pool,
+			      struct homa_rcvbuf_args *args);
+int      homa_pool_release_buffers(struct homa_pool *pool,
+				   int num_buffers, u32 *buffers);
+int      homa_pool_set_region(struct homa_sock *hsk, void __user *region,
+			      u64 region_size);
+
+#endif /* _HOMA_POOL_H */
-- 
2.43.0


