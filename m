Return-Path: <netdev+bounces-134824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B7D99B44B
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49D31F25719
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE432202F6C;
	Sat, 12 Oct 2024 11:29:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EE0201101;
	Sat, 12 Oct 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732593; cv=none; b=fD0FHuXORp0kFtamP7umM9cbpD6dURLqlEmZgEIuZ/w3r9IjUp7vEu1XAtWUIDqnUuBoZLew32/AWvS9wGPj/G6vEvlcE8wEbnK3R116h9vGwL5wbszC+tci5UIkvX0M1WiDB3hREKnPvVaJ7Q0YXSZS9olSxlk63sTPx3CSul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732593; c=relaxed/simple;
	bh=F8NaFy8Gqe3Y7KuxbrOesyWY58h7LgGRc3j4/fenDHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8kFHbVTPhRbWbH3/KBel1w/zn13xN5z9CTfS7NJC1NeFf2T+dcvGgWrdjLfIrLXDXDPNYRE1oEwV3Rb7tPHP8oaHkte+ZhoC+4EzCtFZAHkUXn++EdgHKOdPqzI/+fpO1bZasnEcmZ0Bq/xeibIvWA8Yn6NSjyK7rU+0sLn/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XQh883ZRrz2DdSc;
	Sat, 12 Oct 2024 19:28:40 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A03CF1402CC;
	Sat, 12 Oct 2024 19:29:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Oct 2024 19:29:49 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	Alexander Duyck <alexanderduyck@fb.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v21 08/14] mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
Date: Sat, 12 Oct 2024 19:23:14 +0800
Message-ID: <20241012112320.2503906-9-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241012112320.2503906-1-linyunsheng@huawei.com>
References: <20241012112320.2503906-1-linyunsheng@huawei.com>
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

It seems there is about 24Bytes binary size increase for
__page_frag_cache_refill() after refactoring in arm64 system
with 64K PAGE_SIZE. By doing the gdb disassembling, It seems
we can have more than 100Bytes decrease for the binary size
by using __alloc_pages() to replace alloc_pages_node(), as
there seems to be some unnecessary checking for nid being
NUMA_NO_NODE, especially when page_frag is part of the mm
system.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 mm/page_frag_cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index a852523bc8ca..f55d34cf7d43 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -56,11 +56,11 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
-	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
-				PAGE_FRAG_CACHE_MAX_ORDER);
+	page = __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
+			     numa_mem_id(), NULL);
 #endif
 	if (unlikely(!page)) {
-		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
+		page = __alloc_pages(gfp, 0, numa_mem_id(), NULL);
 		order = 0;
 	}
 
-- 
2.33.0


