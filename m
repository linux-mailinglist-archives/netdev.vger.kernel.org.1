Return-Path: <netdev+bounces-128787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A177A97BB90
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 13:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D512F1C221AE
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F313180A6A;
	Wed, 18 Sep 2024 11:24:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83320176248;
	Wed, 18 Sep 2024 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658678; cv=none; b=iYxrNrcnOWzDZtzkNLdD418z7rwSPos3FTx/WAmifDxOrEywB+NJuPCtLu/PzDiReamHcF2uCUWbYDHJdmu7WD2WnqgeAlBMTQYnq6eGrgpd5K50SSCIRgr1qqszrgi58UHBuPhQqmlBOnabTZNzwLkrZMwx8oCLwr0VKeIAhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658678; c=relaxed/simple;
	bh=sWSy87kruE/s26kEJ5kE7ZMlwrrZIfE6Z5Y2lVAqzZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=is1bIpb9/BX/Hb/0SzEmM7g5A9Bb+VuxHpxwtHRe3Oez+Lt0xrm8Y8BIaANjHE23h2Ag2tojH36pBC1KygLeAiiV0nWThnOS08SEjud5OcsGRttkSNtbaMqFvVqUPnf8XfSzvL0Jxu+yTeak0QF7svjgR/1GMBCb80O4vQWIvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X7x9b4LBwz1S7ZV;
	Wed, 18 Sep 2024 19:23:47 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8EF881A0188;
	Wed, 18 Sep 2024 19:24:26 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Sep 2024 19:24:26 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric
 Dumazet <edumazet@google.com>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 1/2] page_pool: fix timing for checking and disabling napi_local
Date: Wed, 18 Sep 2024 19:18:24 +0800
Message-ID: <20240918111826.863596-2-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240918111826.863596-1-linyunsheng@huawei.com>
References: <20240918111826.863596-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

page_pool page may be freed from skb_defer_free_flush() to
softirq context, it may cause concurrent access problem for
pool->alloc cache due to the below time window, as below,
both CPU0 and CPU1 may access the pool->alloc cache
concurrently in page_pool_empty_alloc_cache_once() and
page_pool_recycle_in_cache():

          CPU 0                           CPU1
    page_pool_destroy()          skb_defer_free_flush()
           .                               .
           .                   page_pool_put_unrefed_page()
           .                               .
           .               allow_direct = page_pool_napi_local()
           .                               .
page_pool_disable_direct_recycling()       .
           .                               .
page_pool_empty_alloc_cache_once() page_pool_recycle_in_cache()

Use rcu mechanism to avoid the above concurrent access problem.

Note, the above was found during code reviewing on how to fix
the problem in [1].

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

Fixes: 8c48eea3adf3 ("page_pool: allow caching from safely localized NAPI")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/page_pool.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a813d30d2135..bec6e717cd22 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -818,8 +818,17 @@ static bool page_pool_napi_local(const struct page_pool *pool)
 void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 				  unsigned int dma_sync_size, bool allow_direct)
 {
-	if (!allow_direct)
+	bool allow_direct_orig = allow_direct;
+
+	/* page_pool_put_unrefed_netmem() is not supposed to be called with
+	 * allow_direct being true after page_pool_destroy() is called, so
+	 * the allow_direct being true case doesn't need synchronization.
+	 */
+	DEBUG_NET_WARN_ON_ONCE(allow_direct && pool->destroy_cnt);
+	if (!allow_direct_orig) {
+		rcu_read_lock();
 		allow_direct = page_pool_napi_local(pool);
+	}
 
 	netmem =
 		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
@@ -828,6 +837,9 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 		recycle_stat_inc(pool, ring_full);
 		page_pool_return_page(pool, netmem);
 	}
+
+	if (!allow_direct_orig)
+		rcu_read_unlock();
 }
 EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
 
@@ -861,6 +873,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 	bool allow_direct;
 	bool in_softirq;
 
+	rcu_read_lock();
 	allow_direct = page_pool_napi_local(pool);
 
 	for (i = 0; i < count; i++) {
@@ -876,8 +889,10 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			data[bulk_len++] = (__force void *)netmem;
 	}
 
-	if (!bulk_len)
+	if (!bulk_len) {
+		rcu_read_unlock();
 		return;
+	}
 
 	/* Bulk producer into ptr_ring page_pool cache */
 	in_softirq = page_pool_producer_lock(pool);
@@ -892,14 +907,18 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 	page_pool_producer_unlock(pool, in_softirq);
 
 	/* Hopefully all pages was return into ptr_ring */
-	if (likely(i == bulk_len))
+	if (likely(i == bulk_len)) {
+		rcu_read_unlock();
 		return;
+	}
 
 	/* ptr_ring cache full, free remaining pages outside producer lock
 	 * since put_page() with refcnt == 1 can be an expensive operation
 	 */
 	for (; i < bulk_len; i++)
 		page_pool_return_page(pool, (__force netmem_ref)data[i]);
+
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(page_pool_put_page_bulk);
 
@@ -1121,6 +1140,12 @@ void page_pool_destroy(struct page_pool *pool)
 		return;
 
 	page_pool_disable_direct_recycling(pool);
+
+	/* Wait for the freeing side see the disabling direct recycling setting
+	 * to avoid the concurrent access to the pool->alloc cache.
+	 */
+	synchronize_rcu();
+
 	page_pool_free_frag(pool);
 
 	if (!page_pool_release(pool))
-- 
2.33.0


