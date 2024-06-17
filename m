Return-Path: <netdev+bounces-104032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8E790AEFC
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9799B28EC95
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399DC199250;
	Mon, 17 Jun 2024 13:17:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F28199223;
	Mon, 17 Jun 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630262; cv=none; b=eQdpgMqAEQvIhB/aA1z0NK8SPPYlWcGc5ng/DLRodm8w+BsdGUr5qfCtLJn76jLeLDkYrxiHcXW3JJvf1WnZ8ZpuOpwHlOu+1xr0gKdlBX6BSaBhtRweLpQne8QZ8u8KpFmwSp897maCh9+SII/7uILimBOM7+m6oGAa/8GJ6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630262; c=relaxed/simple;
	bh=uAWqg1WOs7ll4fsC5gcc/k94p/PvzzCwbX83t1pWl8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVDi6vYPisZAbCHgiFMqbiBd1BERpsDjFbuvmiqN4T1KfwnfJlwnYmwArffDSp2KyOClsFmqDDFkv5i6NTpfpUrBDrgHhGLnM4mS9P2TWazUDuOQZ+Gef7kXdP5vfFi7DZ4QcQXeIPSKjhXjIrewAA67H047ee7V26V32TEz/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W2r141trrzxRsV;
	Mon, 17 Jun 2024 21:13:28 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F1621402CA;
	Mon, 17 Jun 2024 21:17:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Jun 2024 21:17:38 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v8 07/13] mm: page_frag: some minor refactoring before adding new API
Date: Mon, 17 Jun 2024 21:14:06 +0800
Message-ID: <20240617131413.25189-8-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240617131413.25189-1-linyunsheng@huawei.com>
References: <20240617131413.25189-1-linyunsheng@huawei.com>
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

Refactor common codes from __page_frag_alloc_va_align()
to __page_frag_cache_refill(), so that the new API can
make use of them.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 mm/page_frag_cache.c | 61 ++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index a3316dd50eff..4fd421d4f22c 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -29,10 +29,36 @@ static void *page_frag_cache_current_va(struct page_frag_cache *nc)
 static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 					     gfp_t gfp_mask)
 {
-	struct page *page = NULL;
+	struct encoded_va *encoded_va = nc->encoded_va;
 	gfp_t gfp = gfp_mask;
 	unsigned int order;
+	struct page *page;
+
+	if (unlikely(!encoded_va))
+		goto alloc;
+
+	page = virt_to_page(encoded_va);
+	if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
+		goto alloc;
+
+	if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
+		VM_BUG_ON(compound_order(page) !=
+			  encoded_page_order(encoded_va));
+		free_unref_page(page, encoded_page_order(encoded_va));
+		goto alloc;
+	}
+
+	/* OK, page count is 0, we can safely set it */
+	set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+
+	/* reset page count bias and remaining of new frag */
+	nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+	nc->remaining = page_frag_cache_page_size(encoded_va);
+
+	return page;
 
+alloc:
+	page = NULL;
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
@@ -89,40 +115,15 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int fragsz, gfp_t gfp_mask,
 				 unsigned int align_mask)
 {
-	struct encoded_va *encoded_va = nc->encoded_va;
-	struct page *page;
-	int remaining;
+	int remaining = nc->remaining & align_mask;
 	void *va;
 
-	if (unlikely(!encoded_va)) {
-refill:
-		if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
-			return NULL;
-
-		encoded_va = nc->encoded_va;
-	}
-
-	remaining = nc->remaining & align_mask;
 	remaining -= fragsz;
 	if (unlikely(remaining < 0)) {
-		page = virt_to_page(encoded_va);
-		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
-			goto refill;
-
-		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
-			VM_BUG_ON(compound_order(page) !=
-				  encoded_page_order(encoded_va));
-			free_unref_page(page, encoded_page_order(encoded_va));
-			goto refill;
-		}
-
-		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+		if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
+			return NULL;
 
-		/* reset page count bias and remaining of new frag */
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->remaining = remaining = page_frag_cache_page_size(encoded_va);
-		remaining -= fragsz;
+		remaining = nc->remaining - fragsz;
 		if (unlikely(remaining < 0)) {
 			/*
 			 * The caller is trying to allocate a fragment
-- 
2.33.0


