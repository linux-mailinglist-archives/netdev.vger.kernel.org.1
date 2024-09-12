Return-Path: <netdev+bounces-127805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E6A976994
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657161F2125B
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5447A1A4E7C;
	Thu, 12 Sep 2024 12:51:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53E1A0BFA;
	Thu, 12 Sep 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145474; cv=none; b=jF0D8ehRLpwQ/SjANLkW/d6s7J5N38YJtYZjC5K3RvyFpKrbveLRaGyDaAoAxv1v38VM42V0avhSTwug9J6auTIFOKcAw9AyKKOprytqigfW9XSIug21zDUz//eJakAVXrpCTV6XOWYvjK6iUJmjlPAOMBKXA57UkmjkGBsjsp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145474; c=relaxed/simple;
	bh=9yebMu2vCpQ+wu5Z5l9WP4ME7I74Jq6QtRrLnf1mRBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYJRCGmculWwR40KYkhZCyREq/t5PNkAYAqTFpk/o516P+MPsZMwWj7xHPdxBbYQZbniFw9ZHBtJcI2CRJOrtpUUwCYOBugyUCep77wkUvr4niqXeuLm+C3WJ2Ls0S40luyTuAHlkOXiY/4UhzX1iv8IQcfOW1AJydLtnBTJxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X4HP213Ymz20nrY;
	Thu, 12 Sep 2024 20:51:02 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EC651A016C;
	Thu, 12 Sep 2024 20:51:09 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Sep 2024 20:51:09 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC 1/2] page_pool: fix timing for checking and disabling napi_local
Date: Thu, 12 Sep 2024 20:45:12 +0800
Message-ID: <20240912124514.2329991-2-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240912124514.2329991-1-linyunsheng@huawei.com>
References: <20240912124514.2329991-1-linyunsheng@huawei.com>
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

Note, the above was found during code reviewing how to fix the
problem in [1].

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/page_pool.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a813d30d2135..18645907cec2 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -818,6 +818,8 @@ static bool page_pool_napi_local(const struct page_pool *pool)
 void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 				  unsigned int dma_sync_size, bool allow_direct)
 {
+	rcu_read_lock();
+
 	if (!allow_direct)
 		allow_direct = page_pool_napi_local(pool);
 
@@ -828,6 +830,8 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 		recycle_stat_inc(pool, ring_full);
 		page_pool_return_page(pool, netmem);
 	}
+
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
 
@@ -861,6 +865,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 	bool allow_direct;
 	bool in_softirq;
 
+	rcu_read_lock();
 	allow_direct = page_pool_napi_local(pool);
 
 	for (i = 0; i < count; i++) {
@@ -876,8 +881,10 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			data[bulk_len++] = (__force void *)netmem;
 	}
 
-	if (!bulk_len)
+	if (!bulk_len) {
+		rcu_read_unlock();
 		return;
+	}
 
 	/* Bulk producer into ptr_ring page_pool cache */
 	in_softirq = page_pool_producer_lock(pool);
@@ -892,14 +899,18 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
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
 
@@ -1121,6 +1132,12 @@ void page_pool_destroy(struct page_pool *pool)
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


