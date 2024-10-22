Return-Path: <netdev+bounces-137709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D779A9710
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 05:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD261F22B66
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 03:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C14141987;
	Tue, 22 Oct 2024 03:28:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4285913DDB9;
	Tue, 22 Oct 2024 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567720; cv=none; b=JkBXknmgvgRt3i4qI6qfB5A8rEqndQypcOTOjw/5QFoJFzbiagi6ZSGN5s9GNuwGIFz3QFRS/WVWe7hiYXIrEmveaBj1Vhbrll5L7868k6PAihHZlZNnU0Ggx+5eYm41/OJm6hA3ipYWD636Z1H42p9yev4L4z+SJDzAdqkHLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567720; c=relaxed/simple;
	bh=FzKHvWSdH/zegyPx5g6zWcE3t9ZJBNWsqMZut4mO5Fw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWe3/8pWfEb31ighMaaDrLpBNG2tML2Hpq0AhxdI1np+GljX+h2ldPjI8aqj5UIj5sj3UdRiz3PIL4kbN6RDSIY9x5YZcuNjup8xVaaXhRGsrSRmpevoydq+m/xcMdhf3Lg9uRDjF1NzjZAlLXi5yyWjHdtkp8My1tUt2XRf1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XXczL59K0zpXCK;
	Tue, 22 Oct 2024 11:26:38 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F0D7C180106;
	Tue, 22 Oct 2024 11:28:35 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Oct 2024 11:28:35 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <fanghaiqing@huawei.com>,
	<liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric
 Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 2/3] page_pool: fix timing for checking and disabling napi_local
Date: Tue, 22 Oct 2024 11:22:12 +0800
Message-ID: <20241022032214.3915232-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241022032214.3915232-1-linyunsheng@huawei.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

page_pool page may be freed from skb_defer_free_flush() in
softirq context without binding to any specific napi, it
may cause use-after-free problem due to the below time window,
as below, CPU1 may still access napi->list_owner after CPU0
free the napi memory:

            CPU 0                           CPU1
      page_pool_destroy()          skb_defer_free_flush()
             .                               .
             .                napi = READ_ONCE(pool->p.napi);
             .                               .
page_pool_disable_direct_recycling()         .
   driver free napi memory                   .
             .                               .
             .       napi && READ_ONCE(napi->list_owner) == cpuid
             .                               .

Use rcu mechanism to avoid the above problem.

Note, the above was found during code reviewing on how to fix
the problem in [1].

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

Fixes: dd64b232deb8 ("page_pool: unlink from napi during destroy")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
As the IOMMU fix patch depends on synchronize_rcu() added in this
patch and the time window is so small that it doesn't seem to be
an urgent fix, so target the net-next as the IOMMU fix patch does.
---
 net/core/page_pool.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a813d30d2135..dd497f5c927d 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -795,6 +795,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 static bool page_pool_napi_local(const struct page_pool *pool)
 {
 	const struct napi_struct *napi;
+	bool napi_local;
 	u32 cpuid;
 
 	if (unlikely(!in_softirq()))
@@ -810,9 +811,15 @@ static bool page_pool_napi_local(const struct page_pool *pool)
 	if (READ_ONCE(pool->cpuid) == cpuid)
 		return true;
 
+	/* Synchronizated with page_pool_destory() to avoid use-after-free
+	 * for 'napi'.
+	 */
+	rcu_read_lock();
 	napi = READ_ONCE(pool->p.napi);
+	napi_local = napi && READ_ONCE(napi->list_owner) == cpuid;
+	rcu_read_unlock();
 
-	return napi && READ_ONCE(napi->list_owner) == cpuid;
+	return napi_local;
 }
 
 void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
@@ -1126,6 +1133,12 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_release(pool))
 		return;
 
+	/* Paired with rcu lock in page_pool_napi_local() to enable clearing
+	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
+	 * before returning to driver to free the napi instance.
+	 */
+	synchronize_rcu();
+
 	page_pool_detached(pool);
 	pool->defer_start = jiffies;
 	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
-- 
2.33.0


