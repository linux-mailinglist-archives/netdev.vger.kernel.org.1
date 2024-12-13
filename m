Return-Path: <netdev+bounces-151752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ABE9F0C5A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE0D285520
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3438E1E00AC;
	Fri, 13 Dec 2024 12:34:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1471DFDA4;
	Fri, 13 Dec 2024 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093277; cv=none; b=HcAphSMCJ58q23tSook63W8pWOtwThJE44o8AhRYlgcXGACPzs7pdu6+wPDurzeeg0WhER1FV3BbhanqjTz7iLE7NbEQn/v/IpY0UfAGwx3rxl9kpUM1aOlhtX4gje9y2Xd+PLtQag5Rq8Bz/6xDbIJh2RwA3L9K7/N/IkK2l/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093277; c=relaxed/simple;
	bh=eAX1NIfkek3PEkHM4LoPkClTbiiakDE8VsCvC6nSH6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+JC0nl/uF7s1SDelVmBqyKYwv5WZLN0o6KORbwMSAvXmE29Keib5jfyfNeeoqZ4GNHc/WMnbKMVNJo5v+wlHrRZzLXMfBBml9bft2MG6lWqQe8DuPg4DH4D1Cb14c9F/ItSIZphEI+dgNJhMTVw7ybBkpNWVCFWmmt5PH3F8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y8pbt5j5Kz1V6DP;
	Fri, 13 Dec 2024 20:31:22 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 21FB0180101;
	Fri, 13 Dec 2024 20:34:31 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Dec 2024 20:34:30 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <somnath.kotur@broadcom.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFCv5 2/8] page_pool: fix timing for checking and disabling napi_local
Date: Fri, 13 Dec 2024 20:27:33 +0800
Message-ID: <20241213122739.4050137-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241213122739.4050137-1-linyunsheng@huawei.com>
References: <20241213122739.4050137-1-linyunsheng@huawei.com>
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

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

Fixes: dd64b232deb8 ("page_pool: unlink from napi during destroy")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
As the disscussion with jakub seem unfinished yet, so keep it here
for this RFC, it can be split out when necessary.
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


