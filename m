Return-Path: <netdev+bounces-157159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C41A0918E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B154169A0A
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7761620E31A;
	Fri, 10 Jan 2025 13:14:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427A20DD56;
	Fri, 10 Jan 2025 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514853; cv=none; b=YX9wrD+Ny8YPNj15DXqOCKTpIz2E0pNaKZxCTshtni+r2ZNtnx/2llen/J5wfyt0dNtW8PvIU6CEHlu7raz8FZQO2oav7Rxqio7qDi3C73jAn0Qsy7+sNA6vpP72hjt+e8AcozNudatlgic0+us3K1tcHpYVDLB04YE6afXysOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514853; c=relaxed/simple;
	bh=SE6agWJD0vY2chxfdQBW+/+kxBRBLrA9FT5tlI79wUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFLS60vg7zZdf+GYAi/XUehyGx5BdBbcA6M3N3gnKLB9DKcadGbxVnn3VgKpPVsUUn9ftOo+42LidKdQDc1G4K69h67pOr8rMVDBB9+KTG/RK5bqsFNPixuDEtUndeFVpNrQtrfWqN/TOC065NE0PPQvKoWg1gLpvhhSMjUBJKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YV29g2PPcz22ks5;
	Fri, 10 Jan 2025 21:11:51 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A840B1A0188;
	Fri, 10 Jan 2025 21:14:08 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Jan 2025 21:14:08 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v7 2/8] page_pool: fix timing for checking and disabling napi_local
Date: Fri, 10 Jan 2025 21:06:56 +0800
Message-ID: <20250110130703.3814407-3-linyunsheng@huawei.com>
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

As the following IOMMU fix patch depends on synchronize_rcu()
added in this patch and the time window is so small that it
doesn't seem to be an urgent fix, so target the net-next as
the IOMMU fix patch does.

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

Fixes: dd64b232deb8 ("page_pool: unlink from napi during destroy")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 net/core/page_pool.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9733206d6406..1aa7b93bdcc8 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -799,6 +799,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 static bool page_pool_napi_local(const struct page_pool *pool)
 {
 	const struct napi_struct *napi;
+	bool napi_local;
 	u32 cpuid;
 
 	if (unlikely(!in_softirq()))
@@ -814,9 +815,15 @@ static bool page_pool_napi_local(const struct page_pool *pool)
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
@@ -1165,6 +1172,12 @@ void page_pool_destroy(struct page_pool *pool)
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


