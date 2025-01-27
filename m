Return-Path: <netdev+bounces-161047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBDFA1CFAD
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 04:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C929A1886B78
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 03:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED0E1FC7CD;
	Mon, 27 Jan 2025 03:05:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B05B7E792;
	Mon, 27 Jan 2025 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737947100; cv=none; b=UnfyoDROFkKB2sWuTUTQhjUA/aP5QVBOOwlijuOaNadQRsnDClMLrtabolg0+bqGAu0pCToFBhG2zGqOwin+nuVJcSix2438/NK2qGxm0ecibnYnDw6F52GssbWsbpGvk5HL6Px9SvJJ6syKTGWR/d6W925NsnqhQuY8vlTmfNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737947100; c=relaxed/simple;
	bh=HofMslkLzU27lEYsgNYZYxtDL4pv/CesiUGNib6YiCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbVapJxo6SLaxbDjC0QHLzF1CF9+z2iNmhZlVAf2zBuMQDuBA8Zrn01hueIZQlui4vcLcVLSrqiLHnxJiZRXHLN0ZxQcFvtW40xH9yhfktfYPKQlEsVU9hZQd29gpWQFR6bFZBdHLU/eBBNK13tFgXlOSCN0Rj1PUamFtdSnKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YhCqg4rYMz11TB5;
	Mon, 27 Jan 2025 11:01:35 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A6F78180101;
	Mon, 27 Jan 2025 11:04:50 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Jan 2025 11:04:50 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC v8 2/5] page_pool: fix timing for checking and disabling napi_local
Date: Mon, 27 Jan 2025 10:57:31 +0800
Message-ID: <20250127025734.3406167-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250127025734.3406167-1-linyunsheng@huawei.com>
References: <20250127025734.3406167-1-linyunsheng@huawei.com>
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

As the following IOMMU fix patch depends on rcu synchronization
added in this patch and the time window is so small that it
doesn't seem to be an urgent fix, so target the net-next as
the IOMMU fix patch does.

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

Fixes: dd64b232deb8 ("page_pool: unlink from napi during destroy")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 net/core/page_pool.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f89cf93f6eb4..713502e8e8c9 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -810,6 +810,11 @@ static bool page_pool_napi_local(const struct page_pool *pool)
 	if (READ_ONCE(pool->cpuid) == cpuid)
 		return true;
 
+	/* The in_softirq() checking above should ensure RCU-bh read-side
+	 * critical section, which is paired with the rcu sync in
+	 * page_pool_destroy().
+	 */
+	DEBUG_NET_WARN_ON_ONCE(!rcu_read_lock_bh_held());
 	napi = READ_ONCE(pool->p.napi);
 
 	return napi && READ_ONCE(napi->list_owner) == cpuid;
@@ -1126,6 +1131,12 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_release(pool))
 		return;
 
+	/* Paired with RCU-bh read-side critical section to enable clearing
+	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
+	 * before returning to driver to free the napi instance.
+	 */
+	synchronize_net();
+
 	page_pool_detached(pool);
 	pool->defer_start = jiffies;
 	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
-- 
2.33.0


