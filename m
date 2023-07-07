Return-Path: <netdev+bounces-16101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6571174B66E
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868981C2103D
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537C7171CB;
	Fri,  7 Jul 2023 18:39:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8310952
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D704C433C9;
	Fri,  7 Jul 2023 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755183;
	bh=JhnNxV3xLZg2lEqAzbRF2RmDGouOVFVS1lFMBF2icmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kfQwHlfRy92F5W1sQUgNIpzPJYAWI4Yf14kLc9TSQdf7ifJJkOmfLzm+/GXH0mdF5
	 jKRKiMZb70LxafKLXPdUiJYKq1ZGXaSqprih1c461Krf/KWH7lTbJmQhacJcesMq58
	 ++vqhFr8EGK4xEZTs3ubrLo/FZ8x3lcdXZrcQsW0XzjZuTtVcifG+XMXSMM1+cdHhY
	 5gbtrvS5swWZH08KKMMowG6eka1k31PmFtpNIy9E6sJU4YCAwImDJTI49NopQPEuzH
	 78trm8XnMAdgai9sidwG3rj16xL0FUrEO0XJsbcrYNrArGUe8z/Lpp6RhdayX7sYio
	 x7oJsGSoSoe8A==
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
Subject: [RFC 01/12] net: hack together some page sharing
Date: Fri,  7 Jul 2023 11:39:24 -0700
Message-ID: <20230707183935.997267-2-kuba@kernel.org>
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

Implement a simple buddy allocator with a fallback. It will be
used to split huge pages into smaller pools. And fallback to
alloc_pages() if huge pages are exhausted.

This code will be used exclusively on slow paths and is generally
"not great" but it doesn't seem to immediately crash which is
good enough for now?

This patch contains a basic "coherent allocator" which splits 2M
coherently mapped pages into smaller chunks. Certian drivers
appear to allocate a few MB in single coherent pages which is not
great for IOTLB pressure (simple iperf test on bnxt with Rx backed
by huge pages goes from 170k IOTLB misses to 60k when using this).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/dcalloc.h |  18 ++
 net/core/Makefile     |   2 +-
 net/core/dcalloc.c    | 390 ++++++++++++++++++++++++++++++++++++++++++
 net/core/dcalloc.h    |  93 ++++++++++
 4 files changed, 502 insertions(+), 1 deletion(-)
 create mode 100644 include/net/dcalloc.h
 create mode 100644 net/core/dcalloc.c
 create mode 100644 net/core/dcalloc.h

diff --git a/include/net/dcalloc.h b/include/net/dcalloc.h
new file mode 100644
index 000000000000..a85c59d7f844
--- /dev/null
+++ b/include/net/dcalloc.h
@@ -0,0 +1,18 @@
+#ifndef __NET_DCALLOC_H
+#define __NET_DCALLOC_H
+
+#include <linux/types.h>
+
+struct device;
+
+struct dma_cocoa;
+
+struct dma_cocoa *dma_cocoa_create(struct device *dev, gfp_t gfp);
+void dma_cocoa_destroy(struct dma_cocoa *cocoa);
+
+void *dma_cocoa_alloc(struct dma_cocoa *cocoa, unsigned long size,
+		      dma_addr_t *dma, gfp_t gfp);
+void dma_cocoa_free(struct dma_cocoa *cocoa, unsigned long size, void *addr,
+		    dma_addr_t dma);
+
+#endif
diff --git a/net/core/Makefile b/net/core/Makefile
index 731db2eaa610..3a98ad5d2b49 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -13,7 +13,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
 			fib_notifier.o xdp.o flow_offload.o gro.o \
-			netdev-genl.o netdev-genl-gen.o gso.o
+			netdev-genl.o netdev-genl-gen.o gso.o dcalloc.o
 
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
diff --git a/net/core/dcalloc.c b/net/core/dcalloc.c
new file mode 100644
index 000000000000..af9029018353
--- /dev/null
+++ b/net/core/dcalloc.c
@@ -0,0 +1,390 @@
+#include "dcalloc.h"
+
+#include <linux/dma-mapping.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+
+static bool dma_sal_in_use(struct dma_slow_allocator *sal)
+{
+	return refcount_read(&sal->user_cnt);
+}
+
+int dma_slow_huge_init(struct dma_slow_huge *shu, void *addr,
+		       unsigned int size, dma_addr_t dma, gfp_t gfp)
+{
+	struct dma_slow_buddy *bud;
+
+	bud = kzalloc(sizeof(*bud), gfp);
+	if (!bud)
+		return -ENOMEM;
+
+	shu->addr = addr;
+	shu->size = size;
+	shu->dma = dma;
+
+	INIT_LIST_HEAD(&shu->buddy_list);
+
+	bud->size = size;
+	bud->free = true;
+	list_add(&bud->list, &shu->buddy_list);
+
+	return 0;
+}
+
+static struct dma_slow_buddy *
+dma_slow_bud_split(struct dma_slow_buddy *bud, gfp_t gfp)
+{
+	struct dma_slow_buddy *right;
+
+	right = kzalloc(sizeof(*bud), gfp);
+	if (!right)
+		return NULL;
+
+	bud->size /= 2;
+
+	right->offset = bud->offset + bud->size;
+	right->size = bud->size;
+	right->free = true;
+
+	list_add(&right->list, &bud->list);
+
+	return bud;
+}
+
+static bool dma_slow_bud_coalesce(struct dma_slow_huge *shu)
+{
+	struct dma_slow_buddy *bud, *left = NULL, *right = NULL;
+
+	list_for_each_entry(bud, &shu->buddy_list, list) {
+		if (left && bud &&
+		    left->free && bud->free &&
+		    left->size == bud->size &&
+		    (left->offset & bud->offset) == left->offset) {
+			right = bud;
+			break;
+		}
+		left = bud;
+	}
+
+	if (!right)
+		return false;
+
+	left->size *= 2;
+	list_del(&right->list);
+	kfree(right);
+	return true;
+}
+
+static void *
+__dma_sal_alloc_buddy(struct dma_slow_allocator *sal, struct dma_slow_huge *shu,
+		      unsigned int size, dma_addr_t *dma, gfp_t gfp)
+{
+	struct dma_slow_buddy *small_fit = NULL;
+	struct dma_slow_buddy *bud;
+
+	if (shu->size < size)
+		return NULL;
+
+	list_for_each_entry(bud, &shu->buddy_list, list) {
+		if (!bud->free || bud->size < size)
+			continue;
+
+		if (!small_fit || small_fit->size > bud->size)
+			small_fit = bud;
+		if (bud->size == size)
+			break;
+	}
+	if (!small_fit)
+		return NULL;
+	bud = small_fit;
+
+	while (bud->size >= size * 2) {
+		bud = dma_slow_bud_split(bud, gfp);
+		if (!bud)
+			return NULL;
+	}
+
+	bud->free = false;
+	*dma = shu->dma + bud->offset;
+	return shu->addr + (bud->offset >> sal->ops->ptr_shf);
+}
+
+static void *
+dma_sal_alloc_buddy(struct dma_slow_allocator *sal, unsigned int size,
+		    dma_addr_t *dma, gfp_t gfp)
+{
+	struct dma_slow_huge *shu;
+	void *addr;
+
+	list_for_each_entry(shu, &sal->huge, huge) {
+		addr = __dma_sal_alloc_buddy(sal, shu, size, dma, gfp);
+		if (addr)
+			return addr;
+	}
+
+	if (!sal->ops->alloc_huge)
+		return NULL;
+
+	shu = kzalloc(sizeof(*shu), gfp);
+	if (!shu)
+		return NULL;
+	if (sal->ops->alloc_huge(sal, shu, size, gfp)) {
+		kfree(shu);
+		return NULL;
+	}
+	list_add(&shu->huge, &sal->huge);
+
+	return __dma_sal_alloc_buddy(sal, shu, size, dma, gfp);
+}
+
+static bool
+__dma_sal_free_buddy(struct dma_slow_allocator *sal, struct dma_slow_huge *shu,
+		     void *addr, unsigned int size, dma_addr_t dma)
+{
+	struct dma_slow_buddy *bud;
+	dma_addr_t exp_dma;
+	void *exp_addr;
+
+	list_for_each_entry(bud, &shu->buddy_list, list) {
+		exp_dma = shu->dma + bud->offset;
+		exp_addr = shu->addr + (bud->offset >> sal->ops->ptr_shf);
+
+		if (exp_addr != addr)
+			continue;
+
+		if (exp_dma != dma || bud->size != size)
+			pr_warn("mep param mismatch: %u %u, %lu %lu\n",
+				bud->size, size, (ulong)exp_dma, (ulong)dma);
+		if (bud->free)
+			pr_warn("double free: %d %lu\n", size, (ulong)dma);
+		bud->free = true;
+		return true;
+	}
+
+	return false;
+}
+
+static void
+dma_slow_maybe_free_huge(struct dma_slow_allocator *sal,
+			 struct dma_slow_huge *shu)
+{
+	struct dma_slow_buddy *bud;
+
+	bud = list_first_entry(&shu->buddy_list, typeof(*bud), list);
+	if (!bud->free || bud->size != shu->size)
+		return;
+
+	if (!sal->ops->alloc_huge)
+		return;
+
+	kfree(bud);
+
+	sal->ops->free_huge(sal, shu);
+	list_del(&shu->huge);
+	kfree(shu);
+}
+
+static bool
+dma_sal_free_buddy(struct dma_slow_allocator *sal, void *addr,
+		   unsigned int order, dma_addr_t dma)
+{
+	struct dma_slow_huge *shu;
+	bool freed = false;
+
+	list_for_each_entry(shu, &sal->huge, huge) {
+		freed = __dma_sal_free_buddy(sal, shu, addr, order, dma);
+		if (freed)
+			break;
+	}
+	if (freed) {
+		while (dma_slow_bud_coalesce(shu))
+			/* I know, it's not efficient.
+			 * But all of SAL is on the config path.
+			 */;
+		dma_slow_maybe_free_huge(sal, shu);
+	}
+	return freed;
+}
+
+static void *
+dma_sal_alloc_fb(struct dma_slow_allocator *sal, unsigned int size,
+		 dma_addr_t *dma, gfp_t gfp)
+{
+	struct dma_slow_fall *fb;
+
+	fb = kzalloc(sizeof(*fb), gfp);
+	if (!fb)
+		return NULL;
+	fb->size = size;
+
+	if (sal->ops->alloc_fall(sal, fb, size, gfp)) {
+		kfree(fb);
+		return NULL;
+	}
+	list_add(&fb->fb, &sal->fallback);
+
+	*dma = fb->dma;
+	return fb->addr;
+}
+
+static bool dma_sal_free_fb(struct dma_slow_allocator *sal, void *addr,
+			    unsigned int size, dma_addr_t dma)
+{
+	struct dma_slow_fall *fb, *pos;
+
+	fb = NULL;
+	list_for_each_entry(pos, &sal->fallback, fb)
+		if (pos->addr == addr) {
+			fb = pos;
+			break;
+		}
+
+	if (!fb) {
+		pr_warn("free: address %px not found\n", addr);
+		return false;
+	}
+
+	if (fb->size != size || fb->dma != dma)
+		pr_warn("free: param mismatch: %u %u, %lu %lu\n",
+			fb->size, size, (ulong)fb->dma, (ulong)dma);
+
+	list_del(&fb->fb);
+	sal->ops->free_fall(sal, fb);
+	kfree(fb);
+	return true;
+}
+
+void *dma_sal_alloc(struct dma_slow_allocator *sal, unsigned int size,
+		    dma_addr_t *dma, gfp_t gfp)
+{
+	void *ret;
+
+	ret = dma_sal_alloc_buddy(sal, size, dma, gfp);
+	if (!ret)
+		ret = dma_sal_alloc_fb(sal, size, dma, gfp);
+	if (!ret)
+		return NULL;
+
+	dma_slow_get(sal);
+	return ret;
+}
+
+void dma_sal_free(struct dma_slow_allocator *sal, void *addr,
+		  unsigned int size, dma_addr_t dma)
+{
+	if (!dma_sal_free_buddy(sal, addr, size, dma) &&
+	    !dma_sal_free_fb(sal, addr, size, dma))
+		return;
+
+	dma_slow_put(sal);
+}
+
+void dma_sal_init(struct dma_slow_allocator *sal,
+		  const struct dma_slow_allocator_ops *ops,
+		  struct device *dev)
+{
+	sal->ops = ops;
+	sal->dev = dev;
+
+	INIT_LIST_HEAD(&sal->huge);
+	INIT_LIST_HEAD(&sal->fallback);
+
+	refcount_set(&sal->user_cnt, 1);
+}
+
+/*****************************
+ ***  DMA COCOA allocator  ***
+ *****************************/
+static int
+dma_cocoa_alloc_huge(struct dma_slow_allocator *sal, struct dma_slow_huge *shu,
+		     unsigned int size, gfp_t gfp)
+{
+	if (size >= SZ_2M)
+		return -ENOMEM;
+
+	shu->addr = dma_alloc_coherent(sal->dev, SZ_2M, &shu->dma, gfp);
+	if (!shu->addr)
+		return -ENOMEM;
+
+	if (dma_slow_huge_init(shu, shu->addr, SZ_2M, shu->dma, gfp))
+		goto err_free_dma;
+
+	return 0;
+
+err_free_dma:
+	dma_free_coherent(sal->dev, SZ_2M, shu->addr, shu->dma);
+	return -ENOMEM;
+}
+
+static void
+dma_cocoa_free_huge(struct dma_slow_allocator *sal, struct dma_slow_huge *shu)
+{
+	dma_free_coherent(sal->dev, SZ_2M, shu->addr, shu->dma);
+}
+
+static int
+dma_cocoa_alloc_fall(struct dma_slow_allocator *sal, struct dma_slow_fall *fb,
+		     unsigned int size, gfp_t gfp)
+{
+	fb->addr = dma_alloc_coherent(sal->dev, size, &fb->dma, gfp);
+	if (!fb->addr)
+		return -ENOMEM;
+	return 0;
+}
+
+static void
+dma_cocoa_free_fall(struct dma_slow_allocator *sal, struct dma_slow_fall *fb)
+{
+	dma_free_coherent(sal->dev, fb->size, fb->addr, fb->dma);
+}
+
+struct dma_slow_allocator_ops dma_cocoa_ops = {
+	.alloc_huge	= dma_cocoa_alloc_huge,
+	.free_huge	= dma_cocoa_free_huge,
+	.alloc_fall	= dma_cocoa_alloc_fall,
+	.free_fall	= dma_cocoa_free_fall,
+};
+
+struct dma_cocoa {
+	struct dma_slow_allocator sal;
+};
+
+struct dma_cocoa *dma_cocoa_create(struct device *dev, gfp_t gfp)
+{
+	struct dma_cocoa *cocoa;
+
+	cocoa = kzalloc(sizeof(*cocoa), gfp);
+	if (!cocoa)
+		return NULL;
+
+	dma_sal_init(&cocoa->sal, &dma_cocoa_ops, dev);
+
+	return cocoa;
+}
+
+void dma_cocoa_destroy(struct dma_cocoa *cocoa)
+{
+	dma_slow_put(&cocoa->sal);
+	WARN_ON(dma_sal_in_use(&cocoa->sal));
+	kfree(cocoa);
+}
+
+void *dma_cocoa_alloc(struct dma_cocoa *cocoa, unsigned long size,
+		      dma_addr_t *dma, gfp_t gfp)
+{
+	void *addr;
+
+	size = roundup_pow_of_two(size);
+	addr = dma_sal_alloc(&cocoa->sal, size, dma, gfp);
+	if (!addr)
+		return NULL;
+	memset(addr, 0, size);
+	return addr;
+}
+
+void dma_cocoa_free(struct dma_cocoa *cocoa, unsigned long size, void *addr,
+		    dma_addr_t dma)
+{
+	size = roundup_pow_of_two(size);
+	return dma_sal_free(&cocoa->sal, addr, size, dma);
+}
diff --git a/net/core/dcalloc.h b/net/core/dcalloc.h
new file mode 100644
index 000000000000..c7e75ef0cb81
--- /dev/null
+++ b/net/core/dcalloc.h
@@ -0,0 +1,93 @@
+#ifndef __DCALLOC_H
+#define __DCALLOC_H
+
+#include <linux/dma-mapping.h>
+#include <net/dcalloc.h>
+
+struct device;
+
+/* struct dma_slow_huge - AKA @shu, large block which will get chopped up */
+struct dma_slow_huge {
+	void *addr;
+	unsigned int size;
+	dma_addr_t dma;
+
+	struct list_head huge;
+	struct list_head buddy_list;	/* struct dma_slow_buddy */
+};
+
+/* Single allocation piece */
+struct dma_slow_buddy {
+	unsigned int offset;
+	unsigned int size;
+
+	bool free;
+
+	struct list_head list;
+};
+
+/* struct dma_slow_fall - AKA @fb, fallback when huge can't be allocated */
+struct dma_slow_fall {
+	void *addr;
+	unsigned int size;
+	dma_addr_t dma;
+
+	struct list_head fb;
+};
+
+/* struct dma_slow_allocator - AKA @sal, per device allocator */
+struct dma_slow_allocator {
+	const struct dma_slow_allocator_ops *ops;
+	struct device *dev;
+
+	unsigned int ptr_shf;
+	refcount_t user_cnt;
+
+	struct list_head huge;		/* struct dma_slow_huge */
+	struct list_head fallback;	/* struct dma_slow_fall */
+};
+
+struct dma_slow_allocator_ops {
+	u8	ptr_shf;
+
+	int (*alloc_huge)(struct dma_slow_allocator *sal,
+			  struct dma_slow_huge *shu,
+			  unsigned int size, gfp_t gfp);
+	void (*free_huge)(struct dma_slow_allocator *sal,
+			  struct dma_slow_huge *fb);
+	int (*alloc_fall)(struct dma_slow_allocator *sal,
+			  struct dma_slow_fall *fb,
+			  unsigned int size, gfp_t gfp);
+	void (*free_fall)(struct dma_slow_allocator *sal,
+			  struct dma_slow_fall *fb);
+
+	void (*release)(struct dma_slow_allocator *sal);
+};
+
+int dma_slow_huge_init(struct dma_slow_huge *shu, void *addr,
+		       unsigned int size, dma_addr_t dma, gfp_t gfp);
+
+void dma_sal_init(struct dma_slow_allocator *sal,
+		  const struct dma_slow_allocator_ops *ops,
+		  struct device *dev);
+
+void *dma_sal_alloc(struct dma_slow_allocator *sal, unsigned int size,
+		    dma_addr_t *dma, gfp_t gfp);
+void dma_sal_free(struct dma_slow_allocator *sal, void *addr,
+		  unsigned int size, dma_addr_t dma);
+
+static inline void dma_slow_get(struct dma_slow_allocator *sal)
+{
+	refcount_inc(&sal->user_cnt);
+}
+
+static inline void dma_slow_put(struct dma_slow_allocator *sal)
+{
+	if (!refcount_dec_and_test(&sal->user_cnt))
+		return;
+
+	if (sal->ops->release)
+		sal->ops->release(sal);
+}
+
+#endif
-- 
2.41.0


