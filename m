Return-Path: <netdev+bounces-101835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C89003E8
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2821F23B82
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E4C199E82;
	Fri,  7 Jun 2024 12:41:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F135199234;
	Fri,  7 Jun 2024 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764097; cv=none; b=Oae3BrwfwYpIxBZE8NDHR3H0KH2FowlH4WXtRiEb2zIjMmlwKYNezhESXDJRyh7fM7UTzHnWFaeKrcC6ditPS5vxA6ZfNmsVLnHPf0S4X1gVBIGmYYJM/fJ7Ah9U5ZPlg14lvcnnq6XfiAzVPs96kbEolfTpWM6lSFEniCpauUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764097; c=relaxed/simple;
	bh=hfFbLymvSxwLpMPm3GiJI09uSNMTMhoFhZmhtM3OeWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ik4QzVNHwg7rstRAwBgeDC7GK30P0jpnqmywBlAPm/wk4COydMweWZQvrNnATUd2k8eh73yXbGRMPllHvsq3VYpuz7ZQrzJNhqjhX6OAdsEQrm5P2rOqMDgNpJM/4OsxPnCxjYpjTamMNG14JR88I3tFsiaocz3ueazi8OWZcIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwghG1fDHzwSJh;
	Fri,  7 Jun 2024 20:37:34 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 950F718007A;
	Fri,  7 Jun 2024 20:41:33 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Jun 2024 20:41:33 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v7 09/15] mm: page_frag: some minor refactoring before adding new API
Date: Fri, 7 Jun 2024 20:38:12 +0800
Message-ID: <20240607123819.40694-10-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240607123819.40694-1-linyunsheng@huawei.com>
References: <20240607123819.40694-1-linyunsheng@huawei.com>
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

Refactor common codes from __page_frag_alloc_va_align()
to __page_frag_cache_refill(), so that the new API can
make use of them.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 mm/page_frag_cache.c | 61 ++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 756ef68cce21..b5ad6e9d316d 100644
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
 	/* Ensure free_unref_page() can be used to free the page fragment */
 	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_ALLOC_COSTLY_ORDER);
@@ -92,40 +118,15 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
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


