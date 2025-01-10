Return-Path: <netdev+bounces-157164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7434EA0919E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EBD16B0D9
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48582210F5E;
	Fri, 10 Jan 2025 13:14:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B5210199;
	Fri, 10 Jan 2025 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514863; cv=none; b=p4cnjUunQxjRVscNJWCh2gjw+oUKRRMY4oyehjZ4k4C+m65J3yS4bTAGkPoUBEV4d6NIZ8P5DZbwhtAJ2BGDzeJM7cPR1XkefnUxF3lJdNButLpQ7eMlplfduQA8WQya34ub/YjxDD7q4qPyB/o2kXndDnTfIOHeQ6wYpFBLa5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514863; c=relaxed/simple;
	bh=PaqOn+Oja4g9X4NhGAyOafyWkejK07nZ3Pm2NkEzi7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJ/ZpQrZElE3C7HnIR/aRfBMC5M1Gs3JnXU3QHq99woE0gUm+/xcglmN7VkJZw7nJRP9vVQqyNYcVgjUHXPsfegolbGY8mdhMMm2ZU/r3r+EbJCRmD3i8ZQ0FHTgTnRj++1GwSQJr3Ju6JUgqIkzv+bJaicVdzBnAejloQKPCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YV28w1LGwzbjs3;
	Fri, 10 Jan 2025 21:11:12 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6375F1800D1;
	Fri, 10 Jan 2025 21:14:18 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Jan 2025 21:14:18 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v7 6/8] page_pool: use list instead of ptr_ring for ring cache
Date: Fri, 10 Jan 2025 21:07:00 +0800
Message-ID: <20250110130703.3814407-7-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250110130703.3814407-1-linyunsheng@huawei.com>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

As 'struct page_pool_item' is added to fix the DMA API
misuse problem, which adds some performance and memory
overhead.

Utilize the 'state' of 'struct page_pool_item' for a
pointer to a next item as only lower 2 bits of 'state'
are used, in order to avoid some performance and memory
overhead of adding 'struct page_pool_item'. As there is
only one producer due to the NAPI context protection,
multiple consumers can be allowed using the similar
lockless operation like llist in llist.h.

Testing shows there is about 10ns~20ns improvement for
performance of 'time_bench_page_pool02_ptr_ring' test
case

CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: IOMMU <iommu@lists.linux.dev>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/page_pool/types.h |  16 ++--
 net/core/page_pool.c          | 133 ++++++++++++++++++----------------
 2 files changed, 82 insertions(+), 67 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 844a7f5ba87a..f4903aa3c7c2 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -4,7 +4,6 @@
 #define _NET_PAGE_POOL_TYPES_H
 
 #include <linux/dma-direction.h>
-#include <linux/ptr_ring.h>
 #include <linux/types.h>
 #include <net/netmem.h>
 
@@ -147,7 +146,10 @@ struct page_pool_stats {
 #endif
 
 struct page_pool_item {
-	unsigned long state;
+	/* An 'encoded_next' is a pointer to next item, lower 2 bits is used to
+	 * indicate the state of current item.
+	 */
+	unsigned long encoded_next;
 
 	union {
 		netmem_ref pp_netmem;
@@ -155,6 +157,11 @@ struct page_pool_item {
 	};
 };
 
+struct pp_ring_cache {
+	struct page_pool_item *list;
+	atomic_t count;
+};
+
 /* The size of item_block is always PAGE_SIZE, so that the address of item_block
  * for a specific item can be calculated using 'item & PAGE_MASK'
  */
@@ -241,12 +248,9 @@ struct page_pool {
 	 * wise, because free's can happen on remote CPUs, with no
 	 * association with allocation resource.
 	 *
-	 * Use ptr_ring, as it separates consumer and producer
-	 * efficiently, it a way that doesn't bounce cache-lines.
-	 *
 	 * TODO: Implement bulk return pages into this structure.
 	 */
-	struct ptr_ring ring;
+	struct pp_ring_cache ring ____cacheline_aligned_in_smp;
 
 	void *mp_priv;
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 232ab56f7fac..5b0b841352f2 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -161,29 +161,6 @@ EXPORT_SYMBOL(page_pool_ethtool_stats_get);
 #define recycle_stat_add(pool, __stat, val)
 #endif
 
-static bool page_pool_producer_lock(struct page_pool *pool)
-	__acquires(&pool->ring.producer_lock)
-{
-	bool in_softirq = in_softirq();
-
-	if (in_softirq)
-		spin_lock(&pool->ring.producer_lock);
-	else
-		spin_lock_bh(&pool->ring.producer_lock);
-
-	return in_softirq;
-}
-
-static void page_pool_producer_unlock(struct page_pool *pool,
-				      bool in_softirq)
-	__releases(&pool->ring.producer_lock)
-{
-	if (in_softirq)
-		spin_unlock(&pool->ring.producer_lock);
-	else
-		spin_unlock_bh(&pool->ring.producer_lock);
-}
-
 static void page_pool_struct_check(void)
 {
 	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_users);
@@ -266,14 +243,6 @@ static int page_pool_init(struct page_pool *pool,
 	}
 #endif
 
-	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
-#ifdef CONFIG_PAGE_POOL_STATS
-		if (!pool->system)
-			free_percpu(pool->recycle_stats);
-#endif
-		return -ENOMEM;
-	}
-
 	spin_lock_init(&pool->item_lock);
 	atomic_set(&pool->pages_state_release_cnt, 0);
 
@@ -299,7 +268,7 @@ static int page_pool_init(struct page_pool *pool,
 		if (err) {
 			pr_warn("%s() mem-provider init failed %d\n", __func__,
 				err);
-			goto free_ptr_ring;
+			goto free_stats;
 		}
 
 		static_branch_inc(&page_pool_mem_providers);
@@ -307,8 +276,7 @@ static int page_pool_init(struct page_pool *pool,
 
 	return 0;
 
-free_ptr_ring:
-	ptr_ring_cleanup(&pool->ring, NULL);
+free_stats:
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!pool->system)
 		free_percpu(pool->recycle_stats);
@@ -318,8 +286,6 @@ static int page_pool_init(struct page_pool *pool,
 
 static void page_pool_uninit(struct page_pool *pool)
 {
-	ptr_ring_cleanup(&pool->ring, NULL);
-
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!pool->system)
 		free_percpu(pool->recycle_stats);
@@ -328,6 +294,8 @@ static void page_pool_uninit(struct page_pool *pool)
 
 #define PAGE_POOL_ITEM_USED			0
 #define PAGE_POOL_ITEM_MAPPED			1
+#define PAGE_POOL_ITEM_STATE_MASK		(BIT(PAGE_POOL_ITEM_USED) |\
+						 BIT(PAGE_POOL_ITEM_MAPPED))
 
 #define ITEMS_PER_PAGE	((PAGE_SIZE -						\
 			  offsetof(struct page_pool_item_block, items)) /	\
@@ -335,18 +303,18 @@ static void page_pool_uninit(struct page_pool *pool)
 
 #define page_pool_item_init_state(item)					\
 ({									\
-	(item)->state = 0;						\
+	(item)->encoded_next &= ~PAGE_POOL_ITEM_STATE_MASK;		\
 })
 
 #if defined(CONFIG_DEBUG_NET)
 #define page_pool_item_set_used(item)					\
-	__set_bit(PAGE_POOL_ITEM_USED, &(item)->state)
+	__set_bit(PAGE_POOL_ITEM_USED, &(item)->encoded_next)
 
 #define page_pool_item_clear_used(item)					\
-	__clear_bit(PAGE_POOL_ITEM_USED, &(item)->state)
+	__clear_bit(PAGE_POOL_ITEM_USED, &(item)->encoded_next)
 
 #define page_pool_item_is_used(item)					\
-	test_bit(PAGE_POOL_ITEM_USED, &(item)->state)
+	test_bit(PAGE_POOL_ITEM_USED, &(item)->encoded_next)
 #else
 #define page_pool_item_set_used(item)
 #define page_pool_item_clear_used(item)
@@ -354,16 +322,69 @@ static void page_pool_uninit(struct page_pool *pool)
 #endif
 
 #define page_pool_item_set_mapped(item)					\
-	__set_bit(PAGE_POOL_ITEM_MAPPED, &(item)->state)
+	__set_bit(PAGE_POOL_ITEM_MAPPED, &(item)->encoded_next)
 
 /* Only clear_mapped and is_mapped need to be atomic as they can be
  * called concurrently.
  */
 #define page_pool_item_clear_mapped(item)				\
-	clear_bit(PAGE_POOL_ITEM_MAPPED, &(item)->state)
+	clear_bit(PAGE_POOL_ITEM_MAPPED, &(item)->encoded_next)
 
 #define page_pool_item_is_mapped(item)					\
-	test_bit(PAGE_POOL_ITEM_MAPPED, &(item)->state)
+	test_bit(PAGE_POOL_ITEM_MAPPED, &(item)->encoded_next)
+
+#define page_pool_item_set_next(item, next)				\
+({									\
+	struct page_pool_item *__item = item;				\
+									\
+	__item->encoded_next &= PAGE_POOL_ITEM_STATE_MASK;		\
+	__item->encoded_next |= (unsigned long)(next);			\
+})
+
+#define page_pool_item_get_next(item)					\
+({									\
+	struct page_pool_item *__next;					\
+									\
+	__next = (struct page_pool_item *)				\
+		((item)->encoded_next & ~PAGE_POOL_ITEM_STATE_MASK);	\
+	__next;								\
+})
+
+static bool __page_pool_recycle_in_ring(struct page_pool *pool,
+					netmem_ref netmem)
+{
+	struct page_pool_item *item, *list;
+
+	if (unlikely(atomic_read(&pool->ring.count) > pool->p.pool_size))
+		return false;
+
+	item = netmem_get_pp_item(netmem);
+	list = READ_ONCE(pool->ring.list);
+
+	do {
+		page_pool_item_set_next(item, list);
+	} while (!try_cmpxchg(&pool->ring.list, &list, item));
+
+	atomic_inc(&pool->ring.count);
+	return true;
+}
+
+static netmem_ref page_pool_consume_ring(struct page_pool *pool)
+{
+	struct page_pool_item *next, *list;
+
+	list = READ_ONCE(pool->ring.list);
+
+	do {
+		if (unlikely(!list))
+			return (__force netmem_ref)0;
+
+		next = page_pool_item_get_next(list);
+	} while (!try_cmpxchg(&pool->ring.list, &list, next));
+
+	atomic_dec(&pool->ring.count);
+	return list->pp_netmem;
+}
 
 static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 							 netmem_ref netmem,
@@ -660,12 +681,11 @@ static void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem,
 
 static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 {
-	struct ptr_ring *r = &pool->ring;
 	netmem_ref netmem;
 	int pref_nid; /* preferred NUMA node */
 
 	/* Quicker fallback, avoid locks when ring is empty */
-	if (__ptr_ring_empty(r)) {
+	if (unlikely(!READ_ONCE(pool->ring.list))) {
 		alloc_stat_inc(pool, empty);
 		return 0;
 	}
@@ -682,7 +702,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 
 	/* Refill alloc array, but only if NUMA match */
 	do {
-		netmem = (__force netmem_ref)__ptr_ring_consume(r);
+		netmem = page_pool_consume_ring(pool);
 		if (unlikely(!netmem))
 			break;
 
@@ -1032,19 +1052,14 @@ static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem,
 				      unsigned int dma_sync_size)
 {
-	int ret;
-	/* BH protection not needed if current is softirq */
-	if (in_softirq())
-		ret = ptr_ring_produce(&pool->ring, (__force void *)netmem);
-	else
-		ret = ptr_ring_produce_bh(&pool->ring, (__force void *)netmem);
+	bool ret = __page_pool_recycle_in_ring(pool, netmem);
 
-	if (likely(!ret)) {
+	if (likely(ret)) {
 		page_pool_dma_sync_for_device_rcu(pool, netmem, dma_sync_size);
 		recycle_stat_inc(pool, ring);
 	}
 
-	return !ret;
+	return ret;
 }
 
 /* Only allow direct recycling in special circumstances, into the
@@ -1183,15 +1198,12 @@ static void page_pool_recycle_ring_bulk(struct page_pool *pool,
 					netmem_ref *bulk,
 					u32 bulk_len)
 {
-	bool in_softirq;
 	u32 i;
 
-	/* Bulk produce into ptr_ring page_pool cache */
-	in_softirq = page_pool_producer_lock(pool);
-
 	rcu_read_lock();
 	for (i = 0; i < bulk_len; i++) {
-		if (__ptr_ring_produce(&pool->ring, (__force void *)bulk[i])) {
+		if (!__page_pool_recycle_in_ring(pool,
+						 (__force netmem_ref)bulk[i])) {
 			/* ring full */
 			recycle_stat_inc(pool, ring_full);
 			break;
@@ -1200,7 +1212,6 @@ static void page_pool_recycle_ring_bulk(struct page_pool *pool,
 					      -1);
 	}
 	rcu_read_unlock();
-	page_pool_producer_unlock(pool, in_softirq);
 	recycle_stat_add(pool, ring, i);
 
 	/* Hopefully all pages were returned into ptr_ring */
@@ -1370,7 +1381,7 @@ static void page_pool_empty_ring(struct page_pool *pool)
 	netmem_ref netmem;
 
 	/* Empty recycle ring */
-	while ((netmem = (__force netmem_ref)ptr_ring_consume_bh(&pool->ring))) {
+	while ((netmem = page_pool_consume_ring(pool))) {
 		/* Verify the refcnt invariant of cached pages */
 		if (!(netmem_ref_count(netmem) == 1))
 			pr_crit("%s() page_pool refcnt %d violation\n",
-- 
2.33.0


