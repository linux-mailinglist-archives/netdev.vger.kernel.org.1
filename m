Return-Path: <netdev+bounces-124523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7089D969D8E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15491F23D49
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60BC1D0967;
	Tue,  3 Sep 2024 12:28:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDB31D0952;
	Tue,  3 Sep 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366485; cv=none; b=gHthvCJoYyoMThlcwwejgJ7N+x5RQ+elyNnRaiZ/tRA1RIIFS0qhvh8UOPjTNL2JiFsXrlah7kz5v/NGTvN4MJ5Oe4sk0Uz4ZaG6YlW6QEXK/xGyLwWzfeQBVKElF7zIo7pOFfbftst4n9zIiQ2OTM3bJLYDM08AfA0Lhvj6W8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366485; c=relaxed/simple;
	bh=IQEK2KkWZrhcbgTwyqBPhsr/hApnnXhwOWrHZS79ILc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pVOKAy43ee2zvR1WwEsH8crE1GGbRBoGfFj15jcwaRERsT4Ct13inXc7ICT8etO39fiRMdT6bi2BmGmGrJCJobJJBANuOdIAxAYnW9LS3+lrgs3SJLEJeWGVWix0Gy7b5hSH4qs50HY9/Ybflrp1hO5TiVRmAAUuLwgs+x6zIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WylJF5x1hz2CpMk;
	Tue,  3 Sep 2024 20:27:41 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F346C1A0188;
	Tue,  3 Sep 2024 20:28:00 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Sep 2024 20:28:00 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Eric Dumazet <edumazet@google.com>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC] page_pool: add debugging to catch concurrent access to pool->alloc
Date: Tue, 3 Sep 2024 20:22:07 +0800
Message-ID: <20240903122208.3379182-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Currently if there is a warning message almost infinity as
below when driver is unloaded, it seems there may be three
reasons as below:
1. Concurrent accese to the pool->alloc related data causing
   incorrect inflight stat.
2. The driver leaks some page.
3. The network stack holds the skb pointing to some page and
   does not seem to release it.

"page_pool_release_retry() stalled pool shutdown: id 949, 98
inflight 1449 sec"

Use the currently unused pool->ring.consumer_lock to catch the
case of concurrent access to pool->alloc.

The binary size is unchanged after this patch when the debug
feature is not enabled.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 net/Kconfig.debug    |  8 +++++
 net/core/page_pool.c | 70 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/net/Kconfig.debug b/net/Kconfig.debug
index 5e3fffe707dd..5575d63d7a36 100644
--- a/net/Kconfig.debug
+++ b/net/Kconfig.debug
@@ -18,6 +18,14 @@ config NET_NS_REFCNT_TRACKER
 	  Enable debugging feature to track netns references.
 	  This adds memory and cpu costs.
 
+config PAGE_POOL_DEBUG
+	bool "Enable page pool debugging"
+	depends on PAGE_POOL
+	default n
+	help
+	  Enable debugging feature in page pool to catch concurrent
+	  access for pool->alloc cache.
+
 config DEBUG_NET
 	bool "Add generic networking debug"
 	depends on DEBUG_KERNEL && NET
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2abe6e919224..8ef70d4252fb 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -31,6 +31,36 @@
 
 #define BIAS_MAX	(LONG_MAX >> 1)
 
+#ifdef CONFIG_PAGE_POOL_DEBUG
+#define __page_pool_debug_alloc_lock(pool, allow_direct, warn_on_destry)		\
+	do {										\
+		if (allow_direct) {							\
+			WARN_ON_ONCE(spin_is_locked(&(pool)->ring.consumer_lock));	\
+			spin_lock(&(pool)->ring.consumer_lock);				\
+			WARN_ON_ONCE(warn_on_destry && (pool)->destroy_cnt);		\
+		}									\
+	} while (0)
+
+#define __page_pool_debug_alloc_unlock(pool, allow_direct, warn_on_destry)		\
+	do {										\
+		if (allow_direct) {							\
+			WARN_ON_ONCE(warn_on_destry && (pool)->destroy_cnt);		\
+			spin_unlock(&(pool)->ring.consumer_lock);			\
+		}									\
+	} while (0)
+
+#define page_pool_debug_alloc_lock(pool, allow_direct)					\
+			__page_pool_debug_alloc_lock(pool, allow_direct, true)
+
+#define page_pool_debug_alloc_unlock(pool, allow_direct)				\
+			__page_pool_debug_alloc_unlock(pool, allow_direct, true)
+#else
+#define __page_pool_debug_alloc_lock(pool, allow_direct, warn_on_destry)
+#define __page_pool_debug_alloc_unlock(pool, allow_direct, warn_on_destry)
+#define page_pool_debug_alloc_lock(pool, allow_direct)
+#define page_pool_debug_alloc_unlock(pool, allow_direct)
+#endif
+
 #ifdef CONFIG_PAGE_POOL_STATS
 static DEFINE_PER_CPU(struct page_pool_recycle_stats, pp_system_recycle_stats);
 
@@ -563,7 +593,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 /* For using page_pool replace: alloc_pages() API calls, but provide
  * synchronization guarantee for allocation side.
  */
-netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
+static netmem_ref __page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
 {
 	netmem_ref netmem;
 
@@ -576,6 +606,17 @@ netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
 	netmem = __page_pool_alloc_pages_slow(pool, gfp);
 	return netmem;
 }
+
+netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
+{
+	netmem_ref netmem;
+
+	page_pool_debug_alloc_lock(pool, true);
+	netmem = __page_pool_alloc_netmem(pool, gfp);
+	page_pool_debug_alloc_unlock(pool, true);
+
+	return netmem;
+}
 EXPORT_SYMBOL(page_pool_alloc_netmem);
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
@@ -776,6 +817,8 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 	if (!allow_direct)
 		allow_direct = page_pool_napi_local(pool);
 
+	page_pool_debug_alloc_lock(pool, allow_direct);
+
 	netmem =
 		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
 	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
@@ -783,6 +826,8 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 		recycle_stat_inc(pool, ring_full);
 		page_pool_return_page(pool, netmem);
 	}
+
+	page_pool_debug_alloc_unlock(pool, allow_direct);
 }
 EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
 
@@ -817,6 +862,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 	bool in_softirq;
 
 	allow_direct = page_pool_napi_local(pool);
+	page_pool_debug_alloc_lock(pool, allow_direct);
 
 	for (i = 0; i < count; i++) {
 		netmem_ref netmem = page_to_netmem(virt_to_head_page(data[i]));
@@ -831,6 +877,8 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			data[bulk_len++] = (__force void *)netmem;
 	}
 
+	page_pool_debug_alloc_unlock(pool, allow_direct);
+
 	if (!bulk_len)
 		return;
 
@@ -878,10 +926,14 @@ static netmem_ref page_pool_drain_frag(struct page_pool *pool,
 
 static void page_pool_free_frag(struct page_pool *pool)
 {
-	long drain_count = BIAS_MAX - pool->frag_users;
-	netmem_ref netmem = pool->frag_page;
+	netmem_ref netmem;
+	long drain_count;
 
+	page_pool_debug_alloc_lock(pool, true);
+	drain_count = BIAS_MAX - pool->frag_users;
+	netmem = pool->frag_page;
 	pool->frag_page = 0;
+	page_pool_debug_alloc_unlock(pool, true);
 
 	if (!netmem || page_pool_unref_netmem(netmem, drain_count))
 		return;
@@ -899,6 +951,7 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	if (WARN_ON(size > max_size))
 		return 0;
 
+	page_pool_debug_alloc_lock(pool, true);
 	size = ALIGN(size, dma_get_cache_alignment());
 	*offset = pool->frag_offset;
 
@@ -911,9 +964,10 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	}
 
 	if (!netmem) {
-		netmem = page_pool_alloc_netmem(pool, gfp);
+		netmem = __page_pool_alloc_netmem(pool, gfp);
 		if (unlikely(!netmem)) {
 			pool->frag_page = 0;
+			page_pool_debug_alloc_unlock(pool, true);
 			return 0;
 		}
 
@@ -924,12 +978,14 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 		*offset = 0;
 		pool->frag_offset = size;
 		page_pool_fragment_netmem(netmem, BIAS_MAX);
+		page_pool_debug_alloc_unlock(pool, true);
 		return netmem;
 	}
 
 	pool->frag_users++;
 	pool->frag_offset = *offset + size;
 	alloc_stat_inc(pool, fast);
+	page_pool_debug_alloc_unlock(pool, true);
 	return netmem;
 }
 EXPORT_SYMBOL(page_pool_alloc_frag_netmem);
@@ -986,8 +1042,10 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 
 static void page_pool_scrub(struct page_pool *pool)
 {
+	__page_pool_debug_alloc_lock(pool, true, false);
 	page_pool_empty_alloc_cache_once(pool);
 	pool->destroy_cnt++;
+	__page_pool_debug_alloc_unlock(pool, true, false);
 
 	/* No more consumers should exist, but producers could still
 	 * be in-flight.
@@ -1089,6 +1147,8 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 {
 	netmem_ref netmem;
 
+	page_pool_debug_alloc_lock(pool, true);
+
 	trace_page_pool_update_nid(pool, new_nid);
 	pool->p.nid = new_nid;
 
@@ -1097,5 +1157,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 		netmem = pool->alloc.cache[--pool->alloc.count];
 		page_pool_return_page(pool, netmem);
 	}
+
+	page_pool_debug_alloc_unlock(pool, true);
 }
 EXPORT_SYMBOL(page_pool_update_nid);
-- 
2.33.0


