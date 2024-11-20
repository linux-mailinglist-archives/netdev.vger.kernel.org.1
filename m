Return-Path: <netdev+bounces-146458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE599D388A
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE4BB25CAC
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5C71A00E7;
	Wed, 20 Nov 2024 10:41:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561A19D894;
	Wed, 20 Nov 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099307; cv=none; b=goP4WICaBOYQlB2WarGtTizU2epJthzgpMt8/u6ARoBFtc083oU8B14GhqJDhi7L/JR8mWlHVgzglEamhnErzXKqRb4RxkNLX6cXNqZoDXSUT4/WD3NgsraRAE+PNK8y0aoMxqljZivZj/IDyoEWi71LFofwoAEm82WvTVTRAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099307; c=relaxed/simple;
	bh=JlcPB+XQ7+ySKj6oA8bzNNE/FXbCzv6GW2zRxNfkS8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5k6eU7zxn5jCUDt9gTboGgULgWwEvM/I7zc3xMVKPBEJVky/664fjQyfIcm3ynvVWwKztInRvYlLc3eBJmX6I70uUCFwh9eT2scq90XtobN0YBhoGwxOflIQ8C8QuYPpnXUmBnWkSkv/ctJKNLMsz4Ru3jpIG7bMYrHpRuc5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XtdCX4yVkz2GZlH;
	Wed, 20 Nov 2024 18:39:36 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id AA9911A0188;
	Wed, 20 Nov 2024 18:41:35 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Nov 2024 18:41:35 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v4 1/3] page_pool: fix timing for checking and disabling napi_local
Date: Wed, 20 Nov 2024 18:34:53 +0800
Message-ID: <20241120103456.396577-2-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241120103456.396577-1-linyunsheng@huawei.com>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
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
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 net/core/page_pool.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f89cf93f6eb4..b3dae671eb26 100644
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


