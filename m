Return-Path: <netdev+bounces-156460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A08A067D7
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44A91679D5
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F123D204C3A;
	Wed,  8 Jan 2025 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="QhBDBWqH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF30204C27
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374032; cv=none; b=g1RE40jHmKVOJd3PbNV6JwqRqQenjCKlVNy86OMyatiPzq1zW9giXUP9kkLubK7nqladlbbWBfbNdeVHtCChDHCOQANJoNUNT5P9dDPumF/fJn2dO1a1p//5R452N1Za9VWRlO7z/guiLoYhTrQJdszlXfENMD0DOrewmUQ3kL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374032; c=relaxed/simple;
	bh=vsqLuE6DqLf3J0UFpwIwwTXWmo6/0dTiQbeWm5ynXEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7t9PkGyCKcoOjq7DZPgxOqTq2RboBZqL1olpBT2Eet2wSGuk5xOjWhqZy44iUXXSOG256DOpB9JRqvnTLIfU6aHJjM9Kijt7SAqc7knsZo2EfOkpzLugyawRncqhWolEwFkVYUeSHc5qz4YswwfhHDlHz/PNP7uYg4sWYa/thw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=QhBDBWqH; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so2181317a91.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 14:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1736374031; x=1736978831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPy7NZ/HefVEBZMyFVm1hd+CR3G+7zsYSwKOvIz2FyU=;
        b=QhBDBWqHDuOUmG7rpzDXAfsO2VmcGH5Fj/7fxy6t2jRdlukb2MYpckPfenXqvQBeM0
         mC03ibrBcaj5T3LPZ8uO2VcfuhJij63fGCEik9OAeWf5G9EF5Mpk3edZJXK2B346tPaK
         mT67/6MhtetuwSZGjAh+ydHzWm/CxGyVfAdcdyJnpYAODQTy1491ckOO0fm0/xcN/Es9
         JEOdXLN/NKACs/z61Lv0FPKnjIxqSugI6uQfSgj602TvqKaYTpAhyu6RuzVWW1zZ5IYc
         B+qnIg+VkbD4ODmjnb8zhGhpuZGq6YSE/U5ut0Rq87xLrUB2LGd3VzEMCSV8zMBw5Mvu
         Qjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736374031; x=1736978831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPy7NZ/HefVEBZMyFVm1hd+CR3G+7zsYSwKOvIz2FyU=;
        b=PqCXDw1gbwAxKyTTRGImpbucFVhl6LPbvRgHufKis3lcyFAl5yl9yLhiXcO/8YP0Y9
         xnuwDPa2mR6K9haUuK4rUcgHV2czOlUeQC+VJ/ybiVYl50K5gX4R+qf1MABwRxclPyYK
         o56bgKVRg5JYr1EHagJet0N3pjXmBRBszpDAtPsGWnyqMirsUlkUegO5KtMHq68KAfvf
         6odJD6jDiDAMwMZ1Ug0SkXjHFRZVYnQAaMhXp3loChfI01ALrVEQbv7mSDuZc54xkqTo
         KakcnVyPci5dkTRD55PQfJg9xtdCRhcyLHPkrrFGSXY0fYC/sKu0XBLSzzsEI0dbftEv
         cbmg==
X-Forwarded-Encrypted: i=1; AJvYcCXbc/yQNsTZHy4qitn88WhD6SBxga68jXIpyLsun5PfIS/MAFIcZ4NmyNEPRuKjl5vlYZ+s3uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSIvsI+DpHipPll5EXtg3A6uStGlIhDh0L+/fxqly8+0iB+iqj
	azPS0Dhp0WIjQSxQLFQykuGb6/kapiOJmK2UBIRo2bEf/sa59zao5QS+FrmyVMg=
X-Gm-Gg: ASbGncs0QtEAJxP7qW5HGIFl1w8LqEyuzDsZxmYN/q3GtKrSV+RjWEiCsgFq67pMgLA
	xY4aAfIIxKzqwMWwVT3qKaYWsJ97fBjXP7HhiCx3E+XCAPWFkHhDqRp+51GxZTHZbjasOevMggn
	RWvg7HGtR05EyvOp6F0t0OZWyEUCtOCTqj79C4ybtSpmirvzx2Vernlukn7ct5DcCZpstJpj7TD
	u7KGRBP4EnA8SOeoRX7f7NnZBL7MLAF3C27Wneipw==
X-Google-Smtp-Source: AGHT+IHxqz8Tw10oJ/rDnvBmMsvo/Ohi5UrLMOF52SlyZc5UiSa2yJQpU6BJRG4JR8KRWKdh/1Ii6Q==
X-Received: by 2002:a05:6a00:2a0b:b0:725:e386:3c5b with SMTP id d2e1a72fcca58-72d30327553mr1702779b3a.5.1736374030659;
        Wed, 08 Jan 2025 14:07:10 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad815796sm36896848b3a.28.2025.01.08.14.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:07:10 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v10 06/22] net: page_pool: create hooks for custom memory providers
Date: Wed,  8 Jan 2025 14:06:27 -0800
Message-ID: <20250108220644.3528845-7-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108220644.3528845-1-dw@davidwei.uk>
References: <20250108220644.3528845-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

A spin off from the original page pool memory providers patch by Jakub,
which allows extending page pools with custom allocators. One of such
providers is devmem TCP, and the other is io_uring zerocopy added in
following patches.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h | 20 ++++++++++++++++++++
 include/net/page_pool/types.h           |  4 ++++
 net/core/devmem.c                       | 15 ++++++++++++++-
 net/core/page_pool.c                    | 23 +++++++++++++++--------
 4 files changed, 53 insertions(+), 9 deletions(-)
 create mode 100644 include/net/page_pool/memory_provider.h

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
new file mode 100644
index 000000000000..79412a8714fa
--- /dev/null
+++ b/include/net/page_pool/memory_provider.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * page_pool/memory_provider.h
+ *	Author:	Pavel Begunkov <asml.silence@gmail.com>
+ *	Author:	David Wei <dw@davidwei.uk>
+ */
+#ifndef _NET_PAGE_POOL_MEMORY_PROVIDER_H
+#define _NET_PAGE_POOL_MEMORY_PROVIDER_H
+
+#include <net/netmem.h>
+#include <net/page_pool/types.h>
+
+struct memory_provider_ops {
+	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
+	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
+	int (*init)(struct page_pool *pool);
+	void (*destroy)(struct page_pool *pool);
+};
+
+#endif
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index ed4cd114180a..88f65c3e2ad9 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -152,8 +152,11 @@ struct page_pool_stats {
  */
 #define PAGE_POOL_FRAG_GROUP_ALIGN	(4 * sizeof(long))
 
+struct memory_provider_ops;
+
 struct pp_memory_provider_params {
 	void *mp_priv;
+	const struct memory_provider_ops *mp_ops;
 };
 
 struct page_pool {
@@ -216,6 +219,7 @@ struct page_pool {
 	struct ptr_ring ring;
 
 	void *mp_priv;
+	const struct memory_provider_ops *mp_ops;
 
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
diff --git a/net/core/devmem.c b/net/core/devmem.c
index c250db6993d3..48833c1dcbd4 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -15,6 +15,7 @@
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
+#include <net/page_pool/memory_provider.h>
 #include <trace/events/page_pool.h>
 
 #include "devmem.h"
@@ -26,6 +27,8 @@
 /* Protected by rtnl_lock() */
 static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
+static const struct memory_provider_ops dmabuf_devmem_ops;
+
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 					       struct gen_pool_chunk *chunk,
 					       void *not_used)
@@ -117,6 +120,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		WARN_ON(rxq->mp_params.mp_priv != binding);
 
 		rxq->mp_params.mp_priv = NULL;
+		rxq->mp_params.mp_ops = NULL;
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
@@ -142,7 +146,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	}
 
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
-	if (rxq->mp_params.mp_priv) {
+	if (rxq->mp_params.mp_ops) {
 		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
 		return -EEXIST;
 	}
@@ -160,6 +164,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 		return err;
 
 	rxq->mp_params.mp_priv = binding;
+	rxq->mp_params.mp_ops = &dmabuf_devmem_ops;
 
 	err = netdev_rx_queue_restart(dev, rxq_idx);
 	if (err)
@@ -169,6 +174,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 
 err_xa_erase:
 	rxq->mp_params.mp_priv = NULL;
+	rxq->mp_params.mp_ops = NULL;
 	xa_erase(&binding->bound_rxqs, xa_idx);
 
 	return err;
@@ -388,3 +394,10 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
 	/* We don't want the page pool put_page()ing our net_iovs. */
 	return false;
 }
+
+static const struct memory_provider_ops dmabuf_devmem_ops = {
+	.init			= mp_dmabuf_devmem_init,
+	.destroy		= mp_dmabuf_devmem_destroy,
+	.alloc_netmems		= mp_dmabuf_devmem_alloc_netmems,
+	.release_netmem		= mp_dmabuf_devmem_release_page,
+};
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index fc3a04823087..0c5da8c056ec 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -13,6 +13,7 @@
 
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
+#include <net/page_pool/memory_provider.h>
 #include <net/xdp.h>
 
 #include <linux/dma-direction.h>
@@ -285,13 +286,19 @@ static int page_pool_init(struct page_pool *pool,
 		rxq = __netif_get_rx_queue(pool->slow.netdev,
 					   pool->slow.queue_idx);
 		pool->mp_priv = rxq->mp_params.mp_priv;
+		pool->mp_ops = rxq->mp_params.mp_ops;
 	}
 
-	if (pool->mp_priv) {
+	if (pool->mp_ops) {
 		if (!pool->dma_map || !pool->dma_sync)
 			return -EOPNOTSUPP;
 
-		err = mp_dmabuf_devmem_init(pool);
+		if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops))) {
+			err = -EFAULT;
+			goto free_ptr_ring;
+		}
+
+		err = pool->mp_ops->init(pool);
 		if (err) {
 			pr_warn("%s() mem-provider init failed %d\n", __func__,
 				err);
@@ -588,8 +595,8 @@ netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 		return netmem;
 
 	/* Slow-path: cache empty, do real allocation */
-	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
-		netmem = mp_dmabuf_devmem_alloc_netmems(pool, gfp);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		netmem = pool->mp_ops->alloc_netmems(pool, gfp);
 	else
 		netmem = __page_pool_alloc_pages_slow(pool, gfp);
 	return netmem;
@@ -696,8 +703,8 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	bool put;
 
 	put = true;
-	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
-		put = mp_dmabuf_devmem_release_page(pool, netmem);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		put = pool->mp_ops->release_netmem(pool, netmem);
 	else
 		__page_pool_release_page_dma(pool, netmem);
 
@@ -1065,8 +1072,8 @@ static void __page_pool_destroy(struct page_pool *pool)
 	page_pool_unlist(pool);
 	page_pool_uninit(pool);
 
-	if (pool->mp_priv) {
-		mp_dmabuf_devmem_destroy(pool);
+	if (pool->mp_ops) {
+		pool->mp_ops->destroy(pool);
 		static_branch_dec(&page_pool_mem_providers);
 	}
 
-- 
2.43.5


