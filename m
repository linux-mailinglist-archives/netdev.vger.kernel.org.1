Return-Path: <netdev+bounces-144885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 988FC9C89D7
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580E5B2F112
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8191FA84A;
	Thu, 14 Nov 2024 12:22:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF21F9AA2;
	Thu, 14 Nov 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586972; cv=none; b=gsmkql1IGo1aB+yRHgOfp7U4bB4C/CZdmbP8u8NnGhaekEhUOFsObX2CZNsmxN0REOqujr7AbLlSLfruIyc+AS9KwMr3IUl1thuBP4K8nxxm57oXisc9RE3Cc7fdv2wU2LQJw7NAtgilxpyofp9TdF9usGYRNklw8uD1MLOfoVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586972; c=relaxed/simple;
	bh=RGKlZlIHnfdjJPRFHRHDvZ1TNo210Ov+wGfIldbdT2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qH4cYcaPTlptXy95i8Atj9UDSLcqtR0a8hvBapJ/UftkhjLN8oRnCP7TSRVAv7DfRwe0RIAl6xBXtzfvfZKuE1ULP1/J3Kd2MU5hKkEWIBXlG9nyxYnT+1SkOAeFEO1jx/LEHZcIBv7Lr+soSPKFIH7Soy2n4kSwk6/z7hpuASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XpzlD3TxJz1jyy5;
	Thu, 14 Nov 2024 20:20:56 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A675E140391;
	Thu, 14 Nov 2024 20:22:47 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 20:22:47 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v1 04/10] mm: page_frag: introduce page_frag_alloc_abort() related API
Date: Thu, 14 Nov 2024 20:15:59 +0800
Message-ID: <20241114121606.3434517-5-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241114121606.3434517-1-linyunsheng@huawei.com>
References: <20241114121606.3434517-1-linyunsheng@huawei.com>
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

For some case as tun_build_skb() without the needing of
using complicated prepare & commit API, add the abort API to
abort the operation of page_frag_alloc_*() related API for
error handling knowing that no one else is taking extra
reference to the just allocated fragment, and add abort_ref
API to only abort the reference counting of the allocated
fragment if it is already referenced by someone else.

CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linux-MM <linux-mm@kvack.org>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 Documentation/mm/page_frags.rst |  7 +++++--
 include/linux/page_frag_cache.h | 20 ++++++++++++++++++++
 mm/page_frag_cache.c            | 21 +++++++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
index 34e654c2956e..339e641beb53 100644
--- a/Documentation/mm/page_frags.rst
+++ b/Documentation/mm/page_frags.rst
@@ -114,9 +114,10 @@ fragsz if there is an alignment requirement for the size of the fragment.
 .. kernel-doc:: include/linux/page_frag_cache.h
    :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
 		 __page_frag_alloc_align page_frag_alloc_align page_frag_alloc
+		 page_frag_alloc_abort
 
 .. kernel-doc:: mm/page_frag_cache.c
-   :identifiers: page_frag_cache_drain page_frag_free
+   :identifiers: page_frag_cache_drain page_frag_free page_frag_alloc_abort_ref
 
 Coding examples
 ===============
@@ -143,8 +144,10 @@ Allocation & freeing API
         goto do_error;
 
     err = do_something(va, size);
-    if (err)
+    if (err) {
+        page_frag_alloc_abort(nc, va, size);
         goto do_error;
+    }
 
     ...
 
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index a2b1127e8ac8..c3347c97522c 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -141,5 +141,25 @@ static inline void *page_frag_alloc(struct page_frag_cache *nc,
 }
 
 void page_frag_free(void *addr);
+void page_frag_alloc_abort_ref(struct page_frag_cache *nc, void *va,
+			       unsigned int fragsz);
+
+/**
+ * page_frag_alloc_abort - Abort the page fragment allocation.
+ * @nc: page_frag cache to which the page fragment is aborted back
+ * @va: virtual address of page fragment to be aborted
+ * @fragsz: size of the page fragment to be aborted
+ *
+ * It is expected to be called from the same context as the allocation API.
+ * Mostly used for error handling cases to abort the fragment allocation knowing
+ * that no one else is taking extra reference to the just aborted fragment, so
+ * that the aborted fragment can be reused.
+ */
+static inline void page_frag_alloc_abort(struct page_frag_cache *nc, void *va,
+					 unsigned int fragsz)
+{
+	page_frag_alloc_abort_ref(nc, va, fragsz);
+	nc->offset -= fragsz;
+}
 
 #endif
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index d014130fb893..8c3cfdbe8c2b 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -201,3 +201,24 @@ void page_frag_free(void *addr)
 		free_unref_page(page, compound_order(page));
 }
 EXPORT_SYMBOL(page_frag_free);
+
+/**
+ * page_frag_alloc_abort_ref - Abort the reference of allocated fragment.
+ * @nc: page_frag cache to which the page fragment is aborted back
+ * @va: virtual address of page fragment to be aborted
+ * @fragsz: size of the page fragment to be aborted
+ *
+ * It is expected to be called from the same context as the allocation API.
+ * Mostly used for error handling cases to abort the reference of allocated
+ * fragment if the fragment has been referenced for other usages, to avoid the
+ * atomic operation of page_frag_free() API.
+ */
+void page_frag_alloc_abort_ref(struct page_frag_cache *nc, void *va,
+			       unsigned int fragsz)
+{
+	VM_BUG_ON(va + fragsz !=
+		  encoded_page_decode_virt(nc->encoded_page) + nc->offset);
+
+	nc->pagecnt_bias++;
+}
+EXPORT_SYMBOL(page_frag_alloc_abort_ref);
-- 
2.33.0


