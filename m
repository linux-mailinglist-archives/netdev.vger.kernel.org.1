Return-Path: <netdev+bounces-16104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D2774B67C
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF5C2818C1
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6A017726;
	Fri,  7 Jul 2023 18:39:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1241097B
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D62C433CC;
	Fri,  7 Jul 2023 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755184;
	bh=K/6WjbGLzAz6fxxlm8D2hh+6PXiKhDpzDvJqdlNHyRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmWrQRhLg3pAvgptGqF3h2ORa56MyFDwFdMeJZ4VU95HUHyB0pNUPVYaw7r/ytRUP
	 7Pw1g46UacQHcYUhkodbLlyw0riynB2j2KAQRJhhHuVe2zL9BPO8vnvzYzVCTsFvKk
	 ZnpYF2riO3/cCZACZVuXzCQecIeXDPS4nqCEXlWQ3Pg2LrQCOMrhu01RqhNrEOvo16
	 e+LIU+WQCAA0RrFxcLl0uAm6NeT+CFWsOMsnHCZiWeYtAJNiH+UchQBXfODk4CjdUS
	 3KjEaSoJRt92D7xbojLHEiHa2JAL0Q640AQYnbG/8RO2XJSIqIaI5rK/HatVJoaxu/
	 frUgR0oNMqrbw==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	edumazet@google.com,
	dsahern@gmail.com,
	michael.chan@broadcom.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 02/12] net: create a 1G-huge-page-backed allocator
Date: Fri,  7 Jul 2023 11:39:25 -0700
Message-ID: <20230707183935.997267-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707183935.997267-1-kuba@kernel.org>
References: <20230707183935.997267-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get 1G pages from CMA, driver will be able to sub-allocate from
those for individual queues. Each Rx queue (taking recycling into
account) needs 32MB - 128MB of memory. With 32 active queues even
with 2MB pages we'll end up using a lot of IOTLB entries.

There are some workarounds for 2MB pages like trying to sort
the buffers (i.e. making sure that the buffers used by the NIC
at any time belong to as few 2MB pages as possible). But 1G pages
seem so much simpler.

Grab 4 pages for now, the real thing will probably need some
Kconfigs and command line params. And a lot more uAPI in general.

Also IDK how to hook this properly into early init :(

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 arch/x86/kernel/setup.c |   6 +-
 include/net/dcalloc.h   |  10 ++
 net/core/dcalloc.c      | 225 ++++++++++++++++++++++++++++++++++++++++
 net/core/dcalloc.h      |   3 +
 4 files changed, 243 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index fd975a4a5200..cc6acd1fa67a 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -843,6 +843,8 @@ static void __init x86_report_nx(void)
 	}
 }
 
+int __init mep_cma_init(void);
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
@@ -1223,8 +1225,10 @@ void __init setup_arch(char **cmdline_p)
 	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
-	if (boot_cpu_has(X86_FEATURE_GBPAGES))
+	if (boot_cpu_has(X86_FEATURE_GBPAGES)) {
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+		mep_cma_init();
+	}
 
 	/*
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
diff --git a/include/net/dcalloc.h b/include/net/dcalloc.h
index a85c59d7f844..21c0fcaaa163 100644
--- a/include/net/dcalloc.h
+++ b/include/net/dcalloc.h
@@ -15,4 +15,14 @@ void *dma_cocoa_alloc(struct dma_cocoa *cocoa, unsigned long size,
 void dma_cocoa_free(struct dma_cocoa *cocoa, unsigned long size, void *addr,
 		    dma_addr_t dma);
 
+struct mem_provider;
+
+struct mem_provider *mep_create(struct device *dev);
+void mep_destroy(struct mem_provider *mep);
+
+struct page *mep_alloc(struct mem_provider *mep, unsigned int order,
+		       dma_addr_t *dma, gfp_t gfp);
+void mep_free(struct mem_provider *mep, struct page *page,
+	      unsigned int order, dma_addr_t dma);
+
 #endif
diff --git a/net/core/dcalloc.c b/net/core/dcalloc.c
index af9029018353..821b9dbfb655 100644
--- a/net/core/dcalloc.c
+++ b/net/core/dcalloc.c
@@ -388,3 +388,228 @@ void dma_cocoa_free(struct dma_cocoa *cocoa, unsigned long size, void *addr,
 	size = roundup_pow_of_two(size);
 	return dma_sal_free(&cocoa->sal, addr, size, dma);
 }
+
+/*****************************
+ ***   DMA MEP allocator   ***
+ *****************************/
+
+#include <linux/cma.h>
+
+static struct cma *mep_cma;
+static int mep_err;
+
+int __init mep_cma_init(void);
+int __init mep_cma_init(void)
+{
+	int order_per_bit;
+
+	order_per_bit = min(30 - PAGE_SHIFT, MAX_ORDER - 1);
+	order_per_bit = min(order_per_bit, HUGETLB_PAGE_ORDER);
+
+	mep_err = cma_declare_contiguous_nid(0,		/* base */
+					     SZ_4G,	/* size */
+					     0,		/* limit */
+					     SZ_1G,	/* alignment */
+					     order_per_bit,  /* order_per_bit */
+					     false,	/* fixed */
+					     "net_mep",	/* name */
+					     &mep_cma,	/* res_cma */
+					     NUMA_NO_NODE);  /* nid */
+	if (mep_err)
+		pr_warn("Net MEP init failed: %d\n", mep_err);
+	else
+		pr_info("Net MEP reserved 4G of memory\n");
+
+	return 0;
+}
+
+/** ----- MEP (slow / ctrl) allocator ----- */
+
+void mp_huge_split(struct page *page, unsigned int order)
+{
+	int i;
+
+	split_page(page, order);
+	/* The subsequent pages have a poisoned next, and since we only
+	 * OR in the PP_SIGNATURE this will mess up PP detection.
+	 */
+	for (i = 0; i < (1 << order); i++)
+		page[i].pp_magic &= 3UL;
+}
+
+struct mem_provider {
+	struct dma_slow_allocator sal;
+
+	struct work_struct work;
+};
+
+static int
+dma_mep_alloc_fall(struct dma_slow_allocator *sal, struct dma_slow_fall *fb,
+		   unsigned int size, gfp_t gfp)
+{
+	int order = get_order(size);
+
+	fb->addr = alloc_pages(gfp, order);
+	if (!fb->addr)
+		return -ENOMEM;
+
+	fb->dma = dma_map_page_attrs(sal->dev, fb->addr, 0, size,
+				     DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
+	if (dma_mapping_error(sal->dev, fb->dma)) {
+		put_page(fb->addr);
+		return -ENOMEM;
+	}
+
+	mp_huge_split(fb->addr, order);
+	return 0;
+}
+
+static void
+dma_mep_free_fall(struct dma_slow_allocator *sal, struct dma_slow_fall *fb)
+{
+	int order = get_order(fb->size);
+	struct page *page;
+	int i;
+
+	page = fb->addr;
+	dma_unmap_page_attrs(sal->dev, fb->dma, fb->size,
+			     DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
+	for (i = 0; i < (1 << order); i++)
+		put_page(page + i);
+}
+
+static void mep_release_work(struct work_struct *work)
+{
+	struct mem_provider *mep;
+
+	mep = container_of(work, struct mem_provider, work);
+
+	while (!list_empty(&mep->sal.huge)) {
+		struct dma_slow_buddy *bud;
+		struct dma_slow_huge *shu;
+
+		shu = list_first_entry(&mep->sal.huge, typeof(*shu), huge);
+
+		dma_unmap_page_attrs(mep->sal.dev, shu->dma, SZ_1G,
+				     DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
+		cma_release(mep_cma, shu->addr, SZ_1G / PAGE_SIZE);
+
+		bud = list_first_entry_or_null(&shu->buddy_list,
+					       typeof(*bud), list);
+		if (WARN_ON(!bud || bud->size != SZ_1G))
+			continue;
+		kfree(bud);
+
+		list_del(&shu->huge);
+		kfree(shu);
+	}
+	put_device(mep->sal.dev);
+	kfree(mep);
+}
+
+static void dma_mep_release(struct dma_slow_allocator *sal)
+{
+	struct mem_provider *mep;
+
+	mep = container_of(sal, struct mem_provider, sal);
+
+	INIT_WORK(&mep->work, mep_release_work);
+	schedule_work(&mep->work);
+}
+
+struct dma_slow_allocator_ops dma_mep_ops = {
+	.ptr_shf	= PAGE_SHIFT - order_base_2(sizeof(struct page)),
+
+	.alloc_fall	= dma_mep_alloc_fall,
+	.free_fall	= dma_mep_free_fall,
+
+	.release	= dma_mep_release,
+};
+
+struct mem_provider *mep_create(struct device *dev)
+{
+	struct mem_provider *mep;
+	int i;
+
+	mep = kzalloc(sizeof(*mep), GFP_KERNEL);
+	if (!mep)
+		return NULL;
+
+	dma_sal_init(&mep->sal, &dma_mep_ops, dev);
+	get_device(mep->sal.dev);
+
+	if (mep_err)
+		goto done;
+
+	/* Hardcoded for now */
+	for (i = 0; i < 2; i++) {
+		const unsigned int order = 30 - PAGE_SHIFT; /* 1G */
+		struct dma_slow_huge *shu;
+		struct page *page;
+
+		shu = kzalloc(sizeof(*shu), GFP_KERNEL);
+		if (!shu)
+			break;
+
+		page = cma_alloc(mep_cma, SZ_1G / PAGE_SIZE, order, false);
+		if (!page) {
+			pr_err("mep: CMA alloc failed\n");
+			goto err_free_shu;
+		}
+
+		shu->dma = dma_map_page_attrs(mep->sal.dev, page, 0,
+					      PAGE_SIZE << order,
+					      DMA_BIDIRECTIONAL,
+					      DMA_ATTR_SKIP_CPU_SYNC);
+		if (dma_mapping_error(mep->sal.dev, shu->dma)) {
+			pr_err("mep: DMA map failed\n");
+			goto err_free_page;
+		}
+
+		if (dma_slow_huge_init(shu, page, SZ_1G, shu->dma,
+				       GFP_KERNEL)) {
+			pr_err("mep: shu init failed\n");
+			goto err_unmap;
+		}
+
+		mp_huge_split(page, 30 - PAGE_SHIFT);
+
+		list_add(&shu->huge, &mep->sal.huge);
+		continue;
+
+err_unmap:
+		dma_unmap_page_attrs(mep->sal.dev, shu->dma, SZ_1G,
+				     DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
+err_free_page:
+		put_page(page);
+err_free_shu:
+		kfree(shu);
+		break;
+	}
+done:
+	if (list_empty(&mep->sal.huge))
+		pr_warn("mep: no huge pages acquired\n");
+
+	return mep;
+}
+EXPORT_SYMBOL_GPL(mep_create);
+
+void mep_destroy(struct mem_provider *mep)
+{
+	dma_slow_put(&mep->sal);
+}
+EXPORT_SYMBOL_GPL(mep_destroy);
+
+struct page *mep_alloc(struct mem_provider *mep, unsigned int order,
+		       dma_addr_t *dma, gfp_t gfp)
+{
+	return dma_sal_alloc(&mep->sal, PAGE_SIZE << order, dma, gfp);
+}
+EXPORT_SYMBOL_GPL(mep_alloc);
+
+void mep_free(struct mem_provider *mep, struct page *page,
+	      unsigned int order, dma_addr_t dma)
+{
+	dma_sal_free(&mep->sal, page, PAGE_SIZE << order, dma);
+}
+EXPORT_SYMBOL_GPL(mep_free);
diff --git a/net/core/dcalloc.h b/net/core/dcalloc.h
index c7e75ef0cb81..2664f933c8e1 100644
--- a/net/core/dcalloc.h
+++ b/net/core/dcalloc.h
@@ -90,4 +90,7 @@ static inline void dma_slow_put(struct dma_slow_allocator *sal)
 		sal->ops->release(sal);
 }
 
+/* misc */
+void mp_huge_split(struct page *page, unsigned int order);
+
 #endif
-- 
2.41.0


