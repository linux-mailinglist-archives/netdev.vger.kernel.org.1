Return-Path: <netdev+bounces-173175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2E9A57B49
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 15:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95E5188FC9F
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBD21D0E2B;
	Sat,  8 Mar 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCSk7czq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A517C77
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445730; cv=none; b=VEWTwB+w4yqNwgNQNx90Fccms1gluVFSwx7d5w1Nshu9eOqt1hQEspXX6t324TkmmsEFlHrFsBiZiZ1MjT/sfU8rXdZ+NA7J7vd+7slqbKkjzukBss2k4f2yPyqSGMgAe2c+akFNtH8DgiznAkfUpNyUJo+C8JdnsTjcUqdBIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445730; c=relaxed/simple;
	bh=Un3T9/J5UK6NxoqvPEyrf+ynuBTEZeer0X2ynP6Dzq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CMF5d8QXrNbjfYOHopcZf78KYWhlfw/Q8pNCrkuKGKJ38IKwwGYPfDqX8YeSbfvoJ98FsjC3FPga0fIBl7Jaf7nk6L5p7pDWlCMY2hFqw6cYrWUkqAr0cEuwc6FnzCILiMvda86n2LobJ9vUICvuRp4tqv9sCHuaJYPTeXxPtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCSk7czq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741445727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PCmvY6Sc5FZMvxBsN2EioQfAKoU5EAMLDPRS1zRsOEo=;
	b=RCSk7czqyQELHFuYQaW3lRK60cx+O97M8srN9OUDJ2G/RXxJ/bItwD6IEeDZ+XlJW7Q9Ky
	Ct1EalLSgCczlXceyb3zH6GWxaA4ZllnQX1qZ/3W5y8jRPLexWos/6snJ081qp+U7LsCWL
	IlrNOrViUnm02EPnd6KiJrANceyg0lk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-aV-enDkKOxupo2buh9fsxw-1; Sat, 08 Mar 2025 09:55:15 -0500
X-MC-Unique: aV-enDkKOxupo2buh9fsxw-1
X-Mimecast-MFC-AGG-ID: aV-enDkKOxupo2buh9fsxw_1741445714
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30bff47a93cso3489671fa.1
        for <netdev@vger.kernel.org>; Sat, 08 Mar 2025 06:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741445714; x=1742050514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCmvY6Sc5FZMvxBsN2EioQfAKoU5EAMLDPRS1zRsOEo=;
        b=ZnHAbn/0TgyaPVsoCZelvZ8iWqGLwhfuZaLmffFs2ZLV6FEWSnV5mTUGtgeznx2iD5
         heFILpqce9rXsVfXhbS7MAwSuEjU555L/iNt7Ih0eAv7p7Tg9no8KF9CKfa5Sb7so9ss
         f8fug1XBGeuKUDPieP7OpAzVqQiOe9pwJkHe92cura9VgIdWVLDKzgQRRSaxS9y2z9Fs
         vk4wQRfns5NYLw53SYDsi+YD5cbtSU5AUZ4NZDEuz06NLUn+oPu8sE4Xhb2Xo/0xSBsw
         TjjIuPVCfo7wq04SnEfXIu/B6X8v1OU0My9AP424ATHnP+dezuVLaFHGhyhoYlyPqPL4
         7bDg==
X-Forwarded-Encrypted: i=1; AJvYcCXPeeXqBSvWCwv7jrNvuyP8dbLavAoD6VRMlS012uySfe0//ClRhB8jIZhUrfl3iyEHdXqV5TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQAAe03hOz8yJJwOTaovl98UJeUDNJzjb3MqV4eU18f9fU6DM0
	zcGLGu9QY+riYsZj6/3hfVDIudawi9COB5/JOBdlkOEIbuiOj8YSoTzFD+tpo5HBvvg7I8pxN1+
	OYJlIZ1OLiwY+bzecxRbXcsisD+D3NTtHWOHbyE/YDw92Z6HH8w04cw==
X-Gm-Gg: ASbGnctQXwuIIeEktgQsST1BCJd4DCuJCkS8JcX7sgEKKqgDdQGRsuxdmNJ0jtNjl5f
	tc5PhawLgUw4LF/awQWiEXY3Y+VcuYb3l3MLmYZ0dFzQ/l22OWqTgAxfTPbNF8+J2mD8zhcQiH/
	MzYU9QlEQnAeX0WCWlTj4AM7oAJApXT3LutG+HJi32zad9baKsisTnkR/VL5ebilmqwD/tg8IWy
	EVQV/zTkd49prVYWLf22NL6hg/PP9tON9WlDRjmKxyHyhyZujgilH/ghDi/2dAXt76ZIfB1dc1V
	/I2gEHFNfoLZowvW3F9iWsyRFksDc9XCcn4gAnpK
X-Received: by 2002:a05:651c:b2c:b0:300:2a29:d47c with SMTP id 38308e7fff4ca-30bf4606942mr23205791fa.24.1741445713663;
        Sat, 08 Mar 2025 06:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzsQqPg4H08FfVDKNDsbH7bqFv3QPDqrk1h8mLbZyAiDMoS62GYE8j8MXgzI5KJvsKlizyWQ==
X-Received: by 2002:a05:651c:b2c:b0:300:2a29:d47c with SMTP id 38308e7fff4ca-30bf4606942mr23205701fa.24.1741445713135;
        Sat, 08 Mar 2025 06:55:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bf794bff6sm5296511fa.23.2025.03.08.06.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 06:55:11 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4F9CB18FA09F; Sat, 08 Mar 2025 15:55:10 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Yunsheng Lin <linyunsheng@huawei.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Mina Almasry <almasrymina@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap them when destroying the pool
Date: Sat,  8 Mar 2025 15:54:58 +0100
Message-ID: <20250308145500.14046-1-toke@redhat.com>
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
structure itself, in the field previously called '_pp_mapping_pad' in
the page_pool struct inside struct page. This field overlaps with the
page->mapping pointer, which may turn out to be problematic, so an
alternative is probably needed. Sticking the ID into some of the upper
bits of page->pp_magic may work as an alternative, but that requires
further investigation. Using the 'mapping' field works well enough as
a demonstration for this RFC, though.

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
This is an alternative to Yunsheng's series. Yunsheng requested I send
this as an RFC to better be able to discuss the different approaches; see
some initial discussion in[1], also regarding where to store the ID as
alluded to above.

-Toke

[1] https://lore.kernel.org/r/40b33879-509a-4c4a-873b-b5d3573b6e14@gmail.com

 include/linux/mm_types.h      |  2 +-
 include/net/page_pool/types.h |  2 ++
 net/core/netmem_priv.h        | 17 +++++++++++++
 net/core/page_pool.c          | 46 +++++++++++++++++++++++++++++------
 4 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0234f14f2aa6..d2c7a7b04bea 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -121,7 +121,7 @@ struct page {
 			 */
 			unsigned long pp_magic;
 			struct page_pool *pp;
-			unsigned long _pp_mapping_pad;
+			unsigned long pp_dma_index;
 			unsigned long dma_addr;
 			atomic_long_t pp_ref_count;
 		};
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 36eb57d73abc..13597a77aa36 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -221,6 +221,8 @@ struct page_pool {
 	void *mp_priv;
 	const struct memory_provider_ops *mp_ops;
 
+	struct xarray dma_mapped;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 7eadb8393e00..59679406a7b7 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -28,4 +28,21 @@ static inline void netmem_set_dma_addr(netmem_ref netmem,
 {
 	__netmem_clear_lsb(netmem)->dma_addr = dma_addr;
 }
+
+static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
+{
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return 0;
+
+	return netmem_to_page(netmem)->pp_dma_index;
+}
+
+static inline void netmem_set_dma_index(netmem_ref netmem,
+					unsigned long id)
+{
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return;
+
+	netmem_to_page(netmem)->pp_dma_index = id;
+}
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index acef1fcd8ddc..d5530f29bf62 100644
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
+			       XA_LIMIT(1, UINT_MAX), gfp);
+	else
+		err = xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
+				  XA_LIMIT(1, UINT_MAX), gfp);
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


