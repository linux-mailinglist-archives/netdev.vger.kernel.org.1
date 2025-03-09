Return-Path: <netdev+bounces-173273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7825A58421
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 13:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62A416B4CA
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06EB1ADC97;
	Sun,  9 Mar 2025 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUKnIcdA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090540849
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741524617; cv=none; b=g8chCdgTnokq0SQKhBX/eah1MzCf05+7F/AqOIMSv4lJpkzrWDRWXqERFt22gNH3rolCgvSUecgjcXCYcVXICPqaNRPLK0pixu0YfszE6Wr1qbFGsfe3L+ON7UUvCDXDNp/71lEoNq0u9o95ekbFmRCy3o7U6r6qXa9WDTLJ1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741524617; c=relaxed/simple;
	bh=S1LgzSohiDKJxJDAtHUUOrlMvwumJ1UsEkm5xGf9TaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GS7DfOBQJyaC4nX0Oba8PE7rl3tyotDM2a2Gh80+vLUYfaXb4gQfUNM2iq/LhSZzSehN3AYKlqe9cHLg03luvUNAQNazr+A6EANVuqIX+S66wkLK73/JfGCtYmrsljAMg1otkue9ASiqsGI7YgGnTL6V+Oj4nmBNiW2IOTOmO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUKnIcdA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741524613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zY0n1mTsfg2sZHOCrorEXerzqFHGZByck2FJCEmzyfg=;
	b=JUKnIcdAX04M7lPo9JOtfKpLEfhDR+TcgzR69Baw2vuTeD875Hn/fNooGNcvKuLtbCtQeq
	5BUCabNA2fSaZkbxyOEHGMsE+nwpzGEoP11aIpqGVGbuUpQ+3JoC6iXN0UNdZMTQ8KOzB3
	MOOdM5vtulR7kW5v9ifi1YlEDjWO0qA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-jjGXWurxOXO1Yo2KnkUDmw-1; Sun, 09 Mar 2025 08:50:12 -0400
X-MC-Unique: jjGXWurxOXO1Yo2KnkUDmw-1
X-Mimecast-MFC-AGG-ID: jjGXWurxOXO1Yo2KnkUDmw_1741524611
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-30c0c56a73aso1719661fa.1
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 05:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741524611; x=1742129411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zY0n1mTsfg2sZHOCrorEXerzqFHGZByck2FJCEmzyfg=;
        b=iQTh7tCOBlRn0rHUo71XYgPMyHYfQL+eQz+QepeJHYyhasyl/GtEwebZCyChCM/Yso
         fnvumGQBlEd76Oc2iJuq9pYXs2NNSTuwaxG/yQnGS1EgmZPGqLAQQjGpIxoixEi7CfKd
         7TTT6wB2mDRmUjs7dwQZ1hKdw1vRV1Q6LCLX/m4jqH4pCzbYE+h1NDaupKJRBinXU5tj
         xrmi5mAJduCPZE26Kih1AYbBufICmU6MbDNVaqD/eSb+FZEMn/Xrx/Tna+zfBTMOmr1p
         ryBRnMTgXp9o8fJseuQpvFbQk3b56b6t3WBempXv4LeEs3pT5uBDbt/tsiiuZKeZyb0b
         jZTg==
X-Forwarded-Encrypted: i=1; AJvYcCUNsWNJ0X35oRKaWs2acfosDqQ3XkWrbqk0fO2SuydwJ6YeHCaMZd5d69VreDvELEeUUcYW+us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa27xlMJv4VL2Es923ExVZSxZFFTEvWHP0dcAV5RapHGdpGNsI
	3ozFDpPiIjEEKC07uYESx6iig2Ugj1EgZwxFrcX38c2WCyOqccwpXITYwIYF+vf3ZO3846ydfWB
	AXVJvlczCG6D4kvx5xRmlriOTQGbS6Tqv2734+g7+OXKAb4UE2Y6QDQ==
X-Gm-Gg: ASbGncuKnJ7yIbZruORoJwr+A0V579CqtEEi1a18IGrQcYrQ/efsssjpauwIp1avHpo
	ZoeyZPSiAbbeebg+xWSrN+g2BKkw6LZguE3Xc1qAscdixMJzAkp9ow+OFIHk/D5vk91NlyT3dqs
	ysIRm4lgw8dkRfwybbzFPoo9TJMrWiri1LGJW2+cvh2LwkChMr0gEkReii+uR96S+vllCc6ZGUJ
	WU3m8un5wR97sRx920dU2ATCGzZZ5DUwAQJLttNlFp/p/3LlIsk96MYGXD7TYAscV0D0ZAvpFnC
	6BzlzNJ3fdiV
X-Received: by 2002:a05:6512:3dab:b0:545:ea9:1a1d with SMTP id 2adb3069b0e04-54990e2c0femr2738959e87.1.1741524610662;
        Sun, 09 Mar 2025 05:50:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyrUvBveDFCHFXQ28XqNGPRJsR1btM2RLgidtLkHfCkg2GXey9OMd8zjOyVd4eptehm/8QMQ==
X-Received: by 2002:a05:6512:3dab:b0:545:ea9:1a1d with SMTP id 2adb3069b0e04-54990e2c0femr2738941e87.1.1741524610134;
        Sun, 09 Mar 2025 05:50:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae46167sm1082018e87.32.2025.03.09.05.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 05:50:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6E5A518FA191; Sun, 09 Mar 2025 13:50:07 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Yunsheng Lin <linyunsheng@huawei.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Mina Almasry <almasrymina@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH net-next v2] page_pool: Track DMA-mapped pages and unmap them when destroying the pool
Date: Sun,  9 Mar 2025 13:47:17 +0100
Message-ID: <20250309124719.21285-1-toke@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When enabling DMA mapping in page_pool, pages are kept DMA mapped until
they are released from the pool, to avoid the overhead of re-mapping the
pages every time they are used. This causes problems when a device is
torn down, because the page pool can't unmap the pages until they are
returned to the pool. This causes resource leaks and/or crashes when
there are pages still outstanding while the device is torn down, because
page_pool will attempt an unmap of a non-existent DMA device on the
subsequent page return.

To fix this, implement a simple tracking of outstanding dma-mapped pages
in page pool using an xarray. This was first suggested by Mina[0], and
turns out to be fairly straight forward: We simply store pointers to
pages directly in the xarray with xa_alloc() when they are first DMA
mapped, and remove them from the array on unmap. Then, when a page pool
is torn down, it can simply walk the xarray and unmap all pages still
present there before returning, which also allows us to get rid of the
get/put_device() calls in page_pool. Using xa_cmpxchg(), no additional
synchronisation is needed, as a page will only ever be unmapped once.

To avoid having to walk the entire xarray on unmap to find the page
reference, we stash the ID assigned by xa_alloc() into the page
structure itself, using the upper bits of the pp_magic field. This
requires a couple of defines to avoid conflicting with the
POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
so should not affect run-time performance.

Since all the tracking is performed on DMA map/unmap, no additional code
is needed in the fast path, meaning the performance overhead of this
tracking is negligible. The extra memory needed to track the pages is
neatly encapsulated inside xarray, which uses the 'struct xa_node'
structure to track items. This structure is 576 bytes long, with slots
for 64 items, meaning that a full node occurs only 9 bytes of overhead
per slot it tracks (in practice, it probably won't be this efficient,
but in any case it should be an acceptable overhead).

[0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/

Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
Reported-by: Yonglong Liu <liuyonglong@huawei.com>
Suggested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v2:
  - Stash the id in the pp_magic field of struct page instead of
    overwriting the mapping field. This version is compile-tested only.

 include/net/page_pool/types.h | 31 +++++++++++++++++++++++
 mm/page_alloc.c               |  3 ++-
 net/core/netmem_priv.h        | 35 +++++++++++++++++++++++++-
 net/core/page_pool.c          | 46 +++++++++++++++++++++++++++++------
 4 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 36eb57d73abc..d879a505ca4d 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -6,6 +6,7 @@
 #include <linux/dma-direction.h>
 #include <linux/ptr_ring.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 #include <net/netmem.h>
 
 #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
@@ -54,6 +55,34 @@ struct pp_alloc_cache {
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
 };
 
+/*
+ * DMA mapping IDs
+ *
+ * When DMA-mapping a page, we allocate an ID (from an xarray) and stash this in
+ * the upper bits of page->pp_magic. The number of bits available here is
+ * constrained by the size of an unsigned long, and the definition of
+ * PP_SIGNATURE.
+ */
+#define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA))
+#define _PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 1)
+
+#if POISON_POINTER_DELTA > 0
+/* PP_SIGNATURE includes POISON_POINTER_DELTA, so limit the size of the DMA
+ * index to not overlap with that if set
+ */
+#define PP_DMA_INDEX_BITS MIN(_PP_DMA_INDEX_BITS, \
+			      __ffs(POISON_POINTER_DELTA) - PP_DMA_INDEX_SHIFT)
+#else
+#define PP_DMA_INDEX_BITS _PP_DMA_INDEX_BITS
+#endif
+
+#define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
+				  PP_DMA_INDEX_SHIFT)
+#define PP_DMA_INDEX_LIMIT XA_LIMIT(1, BIT(PP_DMA_INDEX_BITS) - 1)
+
+/* For check in page_alloc.c */
+#define PP_MAGIC_MASK (~(PP_DMA_INDEX_MASK | 0x3))
+
 /**
  * struct page_pool_params - page pool parameters
  * @fast:	params accessed frequently on hotpath
@@ -221,6 +250,8 @@ struct page_pool {
 	void *mp_priv;
 	const struct memory_provider_ops *mp_ops;
 
+	struct xarray dma_mapped;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 579789600a3c..96776e7b2301 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <net/page_pool/types.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -873,7 +874,7 @@ static inline bool page_expected_state(struct page *page,
 			page->memcg_data |
 #endif
 #ifdef CONFIG_PAGE_POOL
-			((page->pp_magic & ~0x3UL) == PP_SIGNATURE) |
+			((page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE) |
 #endif
 			(page->flags & check_flags)))
 		return false;
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 7eadb8393e00..59face70f40d 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -3,10 +3,19 @@
 #ifndef __NETMEM_PRIV_H
 #define __NETMEM_PRIV_H
 
-static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
+static inline unsigned long _netmem_get_pp_magic(netmem_ref netmem)
 {
 	return __netmem_clear_lsb(netmem)->pp_magic;
 }
+static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
+{
+	return _netmem_get_pp_magic(netmem) & ~PP_DMA_INDEX_MASK;
+}
+
+static inline void netmem_set_pp_magic(netmem_ref netmem, unsigned long pp_magic)
+{
+	__netmem_clear_lsb(netmem)->pp_magic = pp_magic;
+}
 
 static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
 {
@@ -28,4 +37,28 @@ static inline void netmem_set_dma_addr(netmem_ref netmem,
 {
 	__netmem_clear_lsb(netmem)->dma_addr = dma_addr;
 }
+
+static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
+{
+	unsigned long magic;
+
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return 0;
+
+	magic = _netmem_get_pp_magic(netmem);
+
+	return (magic & PP_DMA_INDEX_MASK) >> PP_DMA_INDEX_SHIFT;
+}
+
+static inline void netmem_set_dma_index(netmem_ref netmem,
+					unsigned long id)
+{
+	unsigned long magic;
+
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return;
+
+	magic = netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
+	netmem_set_pp_magic(netmem, magic);
+}
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index acef1fcd8ddc..dceef9b82198 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -226,6 +226,8 @@ static int page_pool_init(struct page_pool *pool,
 			return -EINVAL;
 
 		pool->dma_map = true;
+
+		xa_init_flags(&pool->dma_mapped, XA_FLAGS_ALLOC1);
 	}
 
 	if (pool->slow.flags & PP_FLAG_DMA_SYNC_DEV) {
@@ -275,9 +277,6 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
-	if (pool->dma_map)
-		get_device(pool->p.dev);
-
 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
 		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
 		 * configuration doesn't change while we're initializing
@@ -325,7 +324,7 @@ static void page_pool_uninit(struct page_pool *pool)
 	ptr_ring_cleanup(&pool->ring, NULL);
 
 	if (pool->dma_map)
-		put_device(pool->p.dev);
+		xa_destroy(&pool->dma_mapped);
 
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!pool->system)
@@ -470,9 +469,11 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 
-static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
+static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)
 {
 	dma_addr_t dma;
+	int err;
+	u32 id;
 
 	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
 	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
@@ -486,9 +487,19 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 	if (dma_mapping_error(pool->p.dev, dma))
 		return false;
 
+	if (in_softirq())
+		err = xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
+			       PP_DMA_INDEX_LIMIT, gfp);
+	else
+		err = xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
+				  PP_DMA_INDEX_LIMIT, gfp);
+	if (err)
+		goto unmap_failed;
+
 	if (page_pool_set_dma_addr_netmem(netmem, dma))
 		goto unmap_failed;
 
+	netmem_set_dma_index(netmem, id);
 	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
 
 	return true;
@@ -511,7 +522,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 	if (unlikely(!page))
 		return NULL;
 
-	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page)))) {
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page), gfp))) {
 		put_page(page);
 		return NULL;
 	}
@@ -557,7 +568,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		netmem = pool->alloc.cache[i];
-		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem))) {
+		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem, gfp))) {
 			put_page(netmem_to_page(netmem));
 			continue;
 		}
@@ -659,6 +670,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 							 netmem_ref netmem)
 {
+	struct page *old, *page = netmem_to_page(netmem);
+	unsigned long id;
 	dma_addr_t dma;
 
 	if (!pool->dma_map)
@@ -667,6 +680,17 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 		 */
 		return;
 
+	id = netmem_get_dma_index(netmem);
+	if (!id)
+		return;
+
+	if (in_softirq())
+		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
+	else
+		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
+	if (old != page)
+		return;
+
 	dma = page_pool_get_dma_addr_netmem(netmem);
 
 	/* When page is unmapped, it cannot be returned to our pool */
@@ -674,6 +698,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	page_pool_set_dma_addr_netmem(netmem, 0);
+	netmem_set_dma_index(netmem, 0);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
@@ -1083,8 +1108,13 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 
 static void page_pool_scrub(struct page_pool *pool)
 {
+	unsigned long id;
+	void *ptr;
+
 	page_pool_empty_alloc_cache_once(pool);
-	pool->destroy_cnt++;
+	if (!pool->destroy_cnt++)
+		xa_for_each(&pool->dma_mapped, id, ptr)
+			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
 
 	/* No more consumers should exist, but producers could still
 	 * be in-flight.
-- 
2.48.1


