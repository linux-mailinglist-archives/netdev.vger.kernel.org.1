Return-Path: <netdev+bounces-104028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DCD90AEEF
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29961F25899
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CBA197A6D;
	Mon, 17 Jun 2024 13:17:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFA1E4B2;
	Mon, 17 Jun 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630247; cv=none; b=iJ0KPyXPRV44hCam7yvOS+Chx7MQ0zsbAA/aYSfeAqpIDb/8baftAQLjTTuVE93lroPJVW6kv6lWLxna/V40iOCmdjPDK1ibvbdYozbJZgRg64s6Rud5BvZ5XazNvtKgVgODm8ypBAQKhq9/LmPn3sH6b7ucTJfD6O9VariPs7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630247; c=relaxed/simple;
	bh=ou6EHE2gCwCQQFcZJDhBB8bgQmQDNkRLMpKKSoQno18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2irFbkmh2ucRTVACji3mhAXAITk8QHLEy0y4OGKzt/FubGps3ub9dp7m9W5ri/D7XPBYLslSRmaLBlT+DC6UW8Fkk3gJnWM+gkQKMgB3qXksO6sLdop/XiesGCraXeZrOZ4JygP5m2vXnC3JtV/Cr+PGDVgiD6MDCXoXRE4aMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W2r0k5Q6YzwSvs;
	Mon, 17 Jun 2024 21:13:10 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5175114011B;
	Mon, 17 Jun 2024 21:17:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Jun 2024 21:17:23 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v8 03/13] mm: page_frag: use initial zero offset for page_frag_alloc_align()
Date: Mon, 17 Jun 2024 21:14:02 +0800
Message-ID: <20240617131413.25189-4-linyunsheng@huawei.com>
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

We are above to use page_frag_alloc_*() API to not just
allocate memory for skb->data, but also use them to do
the memory allocation for skb frag too. Currently the
implementation of page_frag in mm subsystem is running
the offset as a countdown rather than count-up value,
there may have several advantages to that as mentioned
in [1], but it may have some disadvantages, for example,
it may disable skb frag coaleasing and more correct cache
prefetching

We have a trade-off to make in order to have a unified
implementation and API for page_frag, so use a initial zero
offset in this patch, and the following patch will try to
make some optimization to aovid the disadvantages as much
as possible.

As offsets is added due to alignment requirement before
actually checking if the cache is enough, which might make
it exploitable if caller passes a align value bigger than
32K mistakenly. As we are allowing order 3 page allocation
to fail easily under low memory condition, align value bigger
than PAGE_SIZE is not really allowed, so add a 'align >
PAGE_SIZE' checking in page_frag_alloc_va_align() to catch
that.

1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com/

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h |  2 +-
 include/linux/skbuff.h          |  4 ++--
 mm/page_frag_cache.c            | 26 +++++++++++---------------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 3a44bfc99750..b9411f0db25a 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -32,7 +32,7 @@ static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 					  unsigned int fragsz, gfp_t gfp_mask,
 					  unsigned int align)
 {
-	WARN_ON_ONCE(!is_power_of_2(align));
+	WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
 	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
 }
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 28af9c728636..7387d3d3b5af 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3314,7 +3314,7 @@ static inline void *netdev_alloc_frag(unsigned int fragsz)
 static inline void *netdev_alloc_frag_align(unsigned int fragsz,
 					    unsigned int align)
 {
-	WARN_ON_ONCE(!is_power_of_2(align));
+	WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
 	return __netdev_alloc_frag_align(fragsz, -align);
 }
 
@@ -3385,7 +3385,7 @@ static inline void *napi_alloc_frag(unsigned int fragsz)
 static inline void *napi_alloc_frag_align(unsigned int fragsz,
 					  unsigned int align)
 {
-	WARN_ON_ONCE(!is_power_of_2(align));
+	WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
 	return __napi_alloc_frag_align(fragsz, -align);
 }
 
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 88f567ef0e29..da244851b8a4 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -72,10 +72,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		if (!page)
 			return NULL;
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
@@ -84,11 +80,16 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		/* reset page count bias and offset to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->offset = size;
+		nc->offset = 0;
 	}
 
-	offset = nc->offset - fragsz;
-	if (unlikely(offset < 0)) {
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	/* if size can vary use size else just use PAGE_SIZE */
+	size = nc->size;
+#endif
+
+	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
+	if (unlikely(offset + fragsz > size)) {
 		page = virt_to_page(nc->va);
 
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
@@ -99,17 +100,13 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
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
+		offset = 0;
+		if (unlikely(fragsz > PAGE_SIZE)) {
 			/*
 			 * The caller is trying to allocate a fragment
 			 * with fragsz > PAGE_SIZE but the cache isn't big
@@ -124,8 +121,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 	}
 
 	nc->pagecnt_bias--;
-	offset &= align_mask;
-	nc->offset = offset;
+	nc->offset = offset + fragsz;
 
 	return nc->va + offset;
 }
-- 
2.33.0


