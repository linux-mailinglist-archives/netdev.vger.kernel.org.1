Return-Path: <netdev+bounces-94579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6758BFED8
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8341F26948
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DE284DF8;
	Wed,  8 May 2024 13:36:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1843684A39;
	Wed,  8 May 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175409; cv=none; b=lcZk/haQoe4aL3AxBAMaIvHGAmh600WP6MnkKNqAR9kE6m/5/LGHCMh7TiAnqsYOYL8VrXSr9jByp1aEK9SCnR8x+FXufG4UDaEIbi5JtP9D/fH9dO4c/YRAgqRV3W8yQqOxwJ8DQgnT7+GPOS6BtU48r8UAhnjc7qcLFuB8akY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175409; c=relaxed/simple;
	bh=rRe906GCuGt9qvp80MgInsHgTGQB3I7xJLZHB55hI0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h54Djp1rHNi7CrohVtdpBpRNd6Xnf15OND1M+KnZ9kcKwYMY/GPCH79wPg3GLjUG+NtS9o+0B9qeehbdxNO9SOC1rkNmrYcLNH+rNOx/BneX7nFqOBB8FE80s88dC9HpMNKTJCZ/eujuB7N5Qug+qhbO9bvqEOhLt0lFzKTzbBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VZGLX6l8gz1RCbm;
	Wed,  8 May 2024 21:33:24 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id DE26814011A;
	Wed,  8 May 2024 21:36:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 21:36:44 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, David Howells <dhowells@redhat.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
Subject: [PATCH net-next v3 04/13] mm: move the page fragment allocator from page_alloc into its own file
Date: Wed, 8 May 2024 21:33:59 +0800
Message-ID: <20240508133408.54708-5-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240508133408.54708-1-linyunsheng@huawei.com>
References: <20240508133408.54708-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

Inspired by [1], move the page fragment allocator from page_alloc
into its own c file and header file, as we are about to make more
change for it to replace another page_frag implementation in
sock.c

1. https://lore.kernel.org/all/20230411160902.4134381-3-dhowells@redhat.com/

CC: David Howells <dhowells@redhat.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/gfp.h             |  22 -----
 include/linux/mm_types.h        |  18 ----
 include/linux/page_frag_cache.h |  47 ++++++++++
 include/linux/skbuff.h          |   1 +
 mm/Makefile                     |   1 +
 mm/page_alloc.c                 | 139 ------------------------------
 mm/page_frag_cache.c            | 147 ++++++++++++++++++++++++++++++++
 mm/page_frag_test.c             |   1 +
 8 files changed, 197 insertions(+), 179 deletions(-)
 create mode 100644 include/linux/page_frag_cache.h
 create mode 100644 mm/page_frag_cache.c

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index c775ea3c6015..5afeab2b906f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -310,28 +310,6 @@ __meminit void *alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask) __al
 extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
 
-struct page_frag_cache;
-void page_frag_cache_drain(struct page_frag_cache *nc);
-extern void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
-			      gfp_t gfp_mask, unsigned int align_mask);
-
-static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
-					  unsigned int fragsz, gfp_t gfp_mask,
-					  unsigned int align)
-{
-	WARN_ON_ONCE(!is_power_of_2(align));
-	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
-}
-
-static inline void *page_frag_alloc(struct page_frag_cache *nc,
-			     unsigned int fragsz, gfp_t gfp_mask)
-{
-	return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
-}
-
-extern void page_frag_free(void *addr);
-
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5240bd7bca33..78a92b4475a7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -504,9 +504,6 @@ static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
  */
 #define STRUCT_PAGE_MAX_SHIFT	(order_base_2(sizeof(struct page)))
 
-#define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
-#define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
-
 /*
  * page_private can be used on tail pages.  However, PagePrivate is only
  * checked by the VM on the head page.  So page_private on the tail pages
@@ -525,21 +522,6 @@ static inline void *folio_get_private(struct folio *folio)
 	return folio->private;
 }
 
-struct page_frag_cache {
-	void * va;
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	__u16 offset;
-	__u16 size;
-#else
-	__u32 offset;
-#endif
-	/* we maintain a pagecount bias, so that we dont dirty cache line
-	 * containing page->_refcount every time we allocate a fragment.
-	 */
-	unsigned int		pagecnt_bias;
-	bool pfmemalloc;
-};
-
 typedef unsigned long vm_flags_t;
 
 /*
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
new file mode 100644
index 000000000000..635b67ceb939
--- /dev/null
+++ b/include/linux/page_frag_cache.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_PAGE_FRAG_CACHE_H
+#define _LINUX_PAGE_FRAG_CACHE_H
+
+#include <linux/gfp.h>
+
+#define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
+#define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
+
+struct page_frag_cache {
+	void *va;
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	__u16 offset;
+	__u16 size;
+#else
+	__u32 offset;
+#endif
+	/* we maintain a pagecount bias, so that we dont dirty cache line
+	 * containing page->_refcount every time we allocate a fragment.
+	 */
+	unsigned int		pagecnt_bias;
+	bool pfmemalloc;
+};
+
+void page_frag_cache_drain(struct page_frag_cache *nc);
+void __page_frag_cache_drain(struct page *page, unsigned int count);
+void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
+			      gfp_t gfp_mask, unsigned int align_mask);
+
+static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
+					  unsigned int fragsz, gfp_t gfp_mask,
+					  unsigned int align)
+{
+	WARN_ON_ONCE(!is_power_of_2(align));
+	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
+}
+
+static inline void *page_frag_alloc(struct page_frag_cache *nc,
+				    unsigned int fragsz, gfp_t gfp_mask)
+{
+	return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
+}
+
+void page_frag_free(void *addr);
+
+#endif
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 36b133f04d30..ce077d14eab6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -31,6 +31,7 @@
 #include <linux/in6.h>
 #include <linux/if_packet.h>
 #include <linux/llist.h>
+#include <linux/page_frag_cache.h>
 #include <net/flow.h>
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 #include <linux/netfilter/nf_conntrack_common.h>
diff --git a/mm/Makefile b/mm/Makefile
index 5a14e6992f44..8b62f5de48a7 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -59,6 +59,7 @@ page-alloc-$(CONFIG_SHUFFLE_PAGE_ALLOCATOR) += shuffle.o
 memory-hotplug-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 
 obj-y += page-alloc.o
+obj-y += page_frag_cache.o
 obj-y += init-mm.o
 obj-y += memblock.o
 obj-y += $(memory-hotplug-y)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7adb29f8f364..2308360d78eb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4675,145 +4675,6 @@ void free_pages(unsigned long addr, unsigned int order)
 
 EXPORT_SYMBOL(free_pages);
 
-/*
- * Page Fragment:
- *  An arbitrary-length arbitrary-offset area of memory which resides
- *  within a 0 or higher order page.  Multiple fragments within that page
- *  are individually refcounted, in the page's reference counter.
- *
- * The page_frag functions below provide a simple allocation framework for
- * page fragments.  This is used by the network stack and network device
- * drivers to provide a backing region of memory for use as either an
- * sk_buff->head, or to be used in the "frags" portion of skb_shared_info.
- */
-static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
-					     gfp_t gfp_mask)
-{
-	struct page *page = NULL;
-	gfp_t gfp = gfp_mask;
-
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	/* Ensure free_unref_page() can be used to free the page fragment */
-	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_ALLOC_COSTLY_ORDER);
-
-	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
-		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
-	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
-				PAGE_FRAG_CACHE_MAX_ORDER);
-	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
-#endif
-	if (unlikely(!page))
-		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
-
-	nc->va = page ? page_address(page) : NULL;
-
-	return page;
-}
-
-void page_frag_cache_drain(struct page_frag_cache *nc)
-{
-	if (!nc->va)
-		return;
-
-	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
-	nc->va = NULL;
-}
-EXPORT_SYMBOL(page_frag_cache_drain);
-
-void __page_frag_cache_drain(struct page *page, unsigned int count)
-{
-	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
-
-	if (page_ref_sub_and_test(page, count))
-		free_unref_page(page, compound_order(page));
-}
-EXPORT_SYMBOL(__page_frag_cache_drain);
-
-void *__page_frag_alloc_align(struct page_frag_cache *nc,
-			      unsigned int fragsz, gfp_t gfp_mask,
-			      unsigned int align_mask)
-{
-	unsigned int size = PAGE_SIZE;
-	struct page *page;
-	int offset;
-
-	if (unlikely(!nc->va)) {
-refill:
-		page = __page_frag_cache_refill(nc, gfp_mask);
-		if (!page)
-			return NULL;
-
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
-		/* Even if we own the page, we do not use atomic_set().
-		 * This would break get_page_unless_zero() users.
-		 */
-		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
-
-		/* reset page count bias and offset to start of new frag */
-		nc->pfmemalloc = page_is_pfmemalloc(page);
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->offset = size;
-	}
-
-	offset = nc->offset - fragsz;
-	if (unlikely(offset < 0)) {
-		page = virt_to_page(nc->va);
-
-		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
-			goto refill;
-
-		if (unlikely(nc->pfmemalloc)) {
-			free_unref_page(page, compound_order(page));
-			goto refill;
-		}
-
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
-		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
-
-		/* reset page count bias and offset to start of new frag */
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
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
-	}
-
-	nc->pagecnt_bias--;
-	offset &= align_mask;
-	nc->offset = offset;
-
-	return nc->va + offset;
-}
-EXPORT_SYMBOL(__page_frag_alloc_align);
-
-/*
- * Frees a page fragment allocated out of either a compound or order 0 page.
- */
-void page_frag_free(void *addr)
-{
-	struct page *page = virt_to_head_page(addr);
-
-	if (unlikely(put_page_testzero(page)))
-		free_unref_page(page, compound_order(page));
-}
-EXPORT_SYMBOL(page_frag_free);
-
 static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		size_t size)
 {
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
new file mode 100644
index 000000000000..64993b5d1243
--- /dev/null
+++ b/mm/page_frag_cache.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Page fragment allocator
+ *
+ * Page Fragment:
+ *  An arbitrary-length arbitrary-offset area of memory which resides within a
+ *  0 or higher order page.  Multiple fragments within that page are
+ *  individually refcounted, in the page's reference counter.
+ *
+ * The page_frag functions provide a simple allocation framework for page
+ * fragments.  This is used by the network stack and network device drivers to
+ * provide a backing region of memory for use as either an sk_buff->head, or to
+ * be used in the "frags" portion of skb_shared_info.
+ */
+
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/page_frag_cache.h>
+#include "internal.h"
+
+static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
+					     gfp_t gfp_mask)
+{
+	struct page *page = NULL;
+	gfp_t gfp = gfp_mask;
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	/* Ensure free_unref_page() can be used to free the page fragment */
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_ALLOC_COSTLY_ORDER);
+
+	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
+		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
+	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
+				PAGE_FRAG_CACHE_MAX_ORDER);
+	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
+#endif
+	if (unlikely(!page))
+		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
+
+	nc->va = page ? page_address(page) : NULL;
+
+	return page;
+}
+
+void page_frag_cache_drain(struct page_frag_cache *nc)
+{
+	if (!nc->va)
+		return;
+
+	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
+	nc->va = NULL;
+}
+EXPORT_SYMBOL(page_frag_cache_drain);
+
+void __page_frag_cache_drain(struct page *page, unsigned int count)
+{
+	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
+
+	if (page_ref_sub_and_test(page, count))
+		free_unref_page(page, compound_order(page));
+}
+EXPORT_SYMBOL(__page_frag_cache_drain);
+
+void *__page_frag_alloc_align(struct page_frag_cache *nc,
+			      unsigned int fragsz, gfp_t gfp_mask,
+			      unsigned int align_mask)
+{
+	unsigned int size = PAGE_SIZE;
+	struct page *page;
+	int offset;
+
+	if (unlikely(!nc->va)) {
+refill:
+		page = __page_frag_cache_refill(nc, gfp_mask);
+		if (!page)
+			return NULL;
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+		/* if size can vary use size else just use PAGE_SIZE */
+		size = nc->size;
+#endif
+		/* Even if we own the page, we do not use atomic_set().
+		 * This would break get_page_unless_zero() users.
+		 */
+		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
+
+		/* reset page count bias and offset to start of new frag */
+		nc->pfmemalloc = page_is_pfmemalloc(page);
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+		nc->offset = size;
+	}
+
+	offset = nc->offset - fragsz;
+	if (unlikely(offset < 0)) {
+		page = virt_to_page(nc->va);
+
+		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
+			goto refill;
+
+		if (unlikely(nc->pfmemalloc)) {
+			free_unref_page(page, compound_order(page));
+			goto refill;
+		}
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+		/* if size can vary use size else just use PAGE_SIZE */
+		size = nc->size;
+#endif
+		/* OK, page count is 0, we can safely set it */
+		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+
+		/* reset page count bias and offset to start of new frag */
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+		offset = size - fragsz;
+		if (unlikely(offset < 0)) {
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
+	}
+
+	nc->pagecnt_bias--;
+	offset &= align_mask;
+	nc->offset = offset;
+
+	return nc->va + offset;
+}
+EXPORT_SYMBOL(__page_frag_alloc_align);
+
+/*
+ * Frees a page fragment allocated out of either a compound or order 0 page.
+ */
+void page_frag_free(void *addr)
+{
+	struct page *page = virt_to_head_page(addr);
+
+	if (unlikely(put_page_testzero(page)))
+		free_unref_page(page, compound_order(page));
+}
+EXPORT_SYMBOL(page_frag_free);
diff --git a/mm/page_frag_test.c b/mm/page_frag_test.c
index dc6e75656e42..f1c861709551 100644
--- a/mm/page_frag_test.c
+++ b/mm/page_frag_test.c
@@ -16,6 +16,7 @@
 #include <linux/log2.h>
 #include <linux/completion.h>
 #include <linux/kthread.h>
+#include <linux/page_frag_cache.h>
 
 #define OBJPOOL_NR_OBJECT_MAX	BIT(24)
 
-- 
2.33.0


