Return-Path: <netdev+bounces-125814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948896EC47
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F171C236D7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5C015666B;
	Fri,  6 Sep 2024 07:42:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6615575D;
	Fri,  6 Sep 2024 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608570; cv=none; b=MmlpK9KW4zdgGBH5BK0Y6XgEul6M3LUw5mzlnCrWKuTqfqfUTv/xQUBCVy6Kxx/5v5xmAWLqpalFKSjK0TsPwL8M8T/MfkiZrkq2prgz+jg1kO8rtNja/8lrVVdS+dj14NetlFseAGsrxU2bvzRV2P1TQAY4/zuAZw/VUJj9nLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608570; c=relaxed/simple;
	bh=aYBnWkTc7X6Jd9TrW+P5jkI06C6U0YrKVYyRHt2hWkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCKpMX7P0Ku4AQeq8WrSz5RK/5M7VpHGJj9QKAN9dDzXivBXhVbNhoitrmF2ifdzQ1S3MLFWYVzYIQ3JOzu+VT9hNE0HR3m/U8ofKJ+31spBlPJmrrs9vdCjB70+sEhfF0v9Lm01FAanS2zj6bDD8YoMFCnuRl+P/JotJ9Jj50c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X0SqK11wLzyR1R;
	Fri,  6 Sep 2024 15:42:05 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 41B8818006C;
	Fri,  6 Sep 2024 15:42:45 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 15:42:45 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	Alexander Duyck <alexanderduyck@fb.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v18 03/14] mm: page_frag: use initial zero offset for page_frag_alloc_align()
Date: Fri, 6 Sep 2024 15:36:35 +0800
Message-ID: <20240906073646.2930809-4-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240906073646.2930809-1-linyunsheng@huawei.com>
References: <20240906073646.2930809-1-linyunsheng@huawei.com>
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

We are about to use page_frag_alloc_*() API to not just
allocate memory for skb->data, but also use them to do
the memory allocation for skb frag too. Currently the
implementation of page_frag in mm subsystem is running
the offset as a countdown rather than count-up value,
there may have several advantages to that as mentioned
in [1], but it may have some disadvantages, for example,
it may disable skb frag coalescing and more correct cache
prefetching

We have a trade-off to make in order to have a unified
implementation and API for page_frag, so use a initial zero
offset in this patch, and the following patch will try to
make some optimization to avoid the disadvantages as much
as possible.

1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com/

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 mm/page_frag_cache.c | 46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 609a485cd02a..4c8e04379cb3 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -63,9 +63,13 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			      unsigned int fragsz, gfp_t gfp_mask,
 			      unsigned int align_mask)
 {
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	unsigned int size = nc->size;
+#else
 	unsigned int size = PAGE_SIZE;
+#endif
+	unsigned int offset;
 	struct page *page;
-	int offset;
 
 	if (unlikely(!nc->va)) {
 refill:
@@ -85,11 +89,24 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		/* reset page count bias and offset to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->offset = size;
+		nc->offset = 0;
 	}
 
-	offset = nc->offset - fragsz;
-	if (unlikely(offset < 0)) {
+	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
+	if (unlikely(offset + fragsz > size)) {
+		if (unlikely(fragsz > PAGE_SIZE)) {
+			/*
+			 * The caller is trying to allocate a fragment
+			 * with fragsz > PAGE_SIZE but the cache isn't big
+			 * enough to satisfy the request, this may
+			 * happen in low memory conditions.
+			 * We don't release the cache page because
+			 * it could make memory pressure worse
+			 * so we simply return NULL here.
+			 */
+			return NULL;
+		}
+
 		page = virt_to_page(nc->va);
 
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
@@ -100,33 +117,16 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			goto refill;
 		}
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
 		/* OK, page count is 0, we can safely set it */
 		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		offset = size - fragsz;
-		if (unlikely(offset < 0)) {
-			/*
-			 * The caller is trying to allocate a fragment
-			 * with fragsz > PAGE_SIZE but the cache isn't big
-			 * enough to satisfy the request, this may
-			 * happen in low memory conditions.
-			 * We don't release the cache page because
-			 * it could make memory pressure worse
-			 * so we simply return NULL here.
-			 */
-			return NULL;
-		}
+		offset = 0;
 	}
 
 	nc->pagecnt_bias--;
-	offset &= align_mask;
-	nc->offset = offset;
+	nc->offset = offset + fragsz;
 
 	return nc->va + offset;
 }
-- 
2.33.0


