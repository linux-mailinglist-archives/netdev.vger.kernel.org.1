Return-Path: <netdev+bounces-189202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610DAB128A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400313B98D3
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D9828FFE3;
	Fri,  9 May 2025 11:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993BE28FA98;
	Fri,  9 May 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791504; cv=none; b=OcjZuiPbfH9nvzjCMzxWy43knCyQmIKQkVb/CTCN/PVUWrtBx8eBI2BWFnXotbjzAh3vLVLroqrARr8ZDVCGi+md+TXv4g7m9dzjdkFpNVrVJF9XKW8Bw/YLs/H/QFW9/rJHnIZh0kf8xtdYFhhNXIwACqthDrGhDC7sFIIVZng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791504; c=relaxed/simple;
	bh=WTci3PN2uM1LSRFgheNdfLrJAz16t/cIFt6CBGIFCQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ko+dqCkS6GGvOQ+YijoQ73deEFg6WSO7X4OxSGVvBofYGU0BTXqadtg9ebolye5MyL5UGrZ/4KTFEVsdiqZDkvvbppl9U3duBSS8uNECDsmXW0pc4xGXMn+EyZ3q9m1sJmT+RFFLehZbmZM4H4Ks+Vef6aG4d6JX4JwoaLYRCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-2c-681dec49ee25
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: [RFC 01/19] netmem: rename struct net_iov to struct netmem_desc
Date: Fri,  9 May 2025 20:51:08 +0900
Message-Id: <20250509115126.63190-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnka7nG9kMgwmHOC3mrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgyJj74xFrQPoGx4tyD9AbGu+VdjJwcEgImEhc+LGCCsRd+ncQGYrMJqEvcuPGTGcQW
	ETCU+PzoOEsXIxcHs8BCZokri3+ygySEBTwkvp9rBmrg4GARUJVYtqIYJMwrYCpx/OciVoiZ
	8hKrNxxgBinhFDCT6P+oDhIWAipZNmUBG8hICYFmdokp5w8xQ9RLShxccYNlAiPvAkaGVYxC
	mXlluYmZOSZ6GZV5mRV6yfm5mxiBMbCs9k/0DsZPF4IPMQpwMCrx8Fo8l80QYk0sK67MPcQo
	wcGsJML7vFMmQ4g3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwen
	VAOj9bH/O1IW3lect3j1/1Xe5l4+jRZsNYY7580KOsi598b5Yz/CXHUkbKf89I7XPf/kMZfM
	1wulPjHxfDu29m1cMe+l0+vQdF8jXo9la1auqTqWcvdW0rXQqaG+LyySfHsS6u5cXyB45hFn
	SV1ofswb9mn3zR0s+BXF1viU5rVOtBN0WR/8Sm6BEktxRqKhFnNRcSIANm6nWH0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXC5WfdrOvxRjbDYPVCK4s569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK2Pig0+sBe0TGCvOPUhvYLxb3sXIySEhYCKx8OskNhCbTUBd4saN
	n8wgtoiAocTnR8dZuhi5OJgFFjJLXFn8kx0kISzgIfH9XDNQAwcHi4CqxLIVxSBhXgFTieM/
	F7FCzJSXWL3hADNICaeAmUT/R3WQsBBQybIpC9gmMHItYGRYxSiSmVeWm5iZY6pXnJ1RmZdZ
	oZecn7uJERjQy2r/TNzB+OWy+yFGAQ5GJR5ei+eyGUKsiWXFlbmHGCU4mJVEeJ93ymQI8aYk
	VlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MC5KF7gbe+fe1u62
	rTYdvstNFU1Ph4q9E5k5W/H4vTSldb32T4U2HuWeFNtnvnhh8OKYCSEfv3PP7uD0PfLKPXB6
	beBTFY5TcaKynTdPTJxwRsf+i57O80VHH7u4vC8sZ5TcK/i3kzMoOqaUraaa49j8E19XHsv7
	uk2Btbj454IXj2Y0TNx564oSS3FGoqEWc1FxIgCaEHMmZAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

To simplify struct page, the page pool members of struct page should be
moved to other, allowing these members to be removed from struct page.

Reuse struct net_iov for also system memory, that already mirrored the
page pool members.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/skbuff.h                  |  4 +--
 include/net/netmem.h                    | 20 ++++++------
 include/net/page_pool/memory_provider.h |  6 ++--
 io_uring/zcrx.c                         | 42 ++++++++++++-------------
 net/core/devmem.c                       | 14 ++++-----
 net/core/devmem.h                       | 24 +++++++-------
 net/core/page_pool.c                    |  6 ++--
 net/ipv4/tcp.c                          |  2 +-
 8 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b974a277975a8..bf67c47319a56 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3598,10 +3598,10 @@ static inline bool skb_frag_is_net_iov(const skb_frag_t *frag)
  * skb_frag_net_iov - retrieve the net_iov referred to by fragment
  * @frag: the fragment
  *
- * Return: the &struct net_iov associated with @frag. Returns NULL if this
+ * Return: the &struct netmem_desc associated with @frag. Returns NULL if this
  * frag has no associated net_iov.
  */
-static inline struct net_iov *skb_frag_net_iov(const skb_frag_t *frag)
+static inline struct netmem_desc *skb_frag_net_iov(const skb_frag_t *frag)
 {
 	if (!skb_frag_is_net_iov(frag))
 		return NULL;
diff --git a/include/net/netmem.h b/include/net/netmem.h
index c61d5b21e7b42..45c209d6cc689 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -20,7 +20,7 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
  */
 #define NET_IOV 0x01UL
 
-struct net_iov {
+struct netmem_desc {
 	unsigned long __unused_padding;
 	unsigned long pp_magic;
 	struct page_pool *pp;
@@ -31,7 +31,7 @@ struct net_iov {
 
 struct net_iov_area {
 	/* Array of net_iovs for this area. */
-	struct net_iov *niovs;
+	struct netmem_desc *niovs;
 	size_t num_niovs;
 
 	/* Offset into the dma-buf where this chunk starts.  */
@@ -56,19 +56,19 @@ struct net_iov_area {
  */
 #define NET_IOV_ASSERT_OFFSET(pg, iov)             \
 	static_assert(offsetof(struct page, pg) == \
-		      offsetof(struct net_iov, iov))
+		      offsetof(struct netmem_desc, iov))
 NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
 NET_IOV_ASSERT_OFFSET(pp, pp);
 NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
 NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
 #undef NET_IOV_ASSERT_OFFSET
 
-static inline struct net_iov_area *net_iov_owner(const struct net_iov *niov)
+static inline struct net_iov_area *net_iov_owner(const struct netmem_desc *niov)
 {
 	return niov->owner;
 }
 
-static inline unsigned int net_iov_idx(const struct net_iov *niov)
+static inline unsigned int net_iov_idx(const struct netmem_desc *niov)
 {
 	return niov - net_iov_owner(niov)->niovs;
 }
@@ -118,17 +118,17 @@ static inline struct page *netmem_to_page(netmem_ref netmem)
 	return __netmem_to_page(netmem);
 }
 
-static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
+static inline struct netmem_desc *netmem_to_net_iov(netmem_ref netmem)
 {
 	if (netmem_is_net_iov(netmem))
-		return (struct net_iov *)((__force unsigned long)netmem &
+		return (struct netmem_desc *)((__force unsigned long)netmem &
 					  ~NET_IOV);
 
 	DEBUG_NET_WARN_ON_ONCE(true);
 	return NULL;
 }
 
-static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
+static inline netmem_ref net_iov_to_netmem(struct netmem_desc *niov)
 {
 	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
 }
@@ -168,9 +168,9 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
 	return page_to_pfn(netmem_to_page(netmem));
 }
 
-static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
+static inline struct netmem_desc *__netmem_clear_lsb(netmem_ref netmem)
 {
-	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
+	return (struct netmem_desc *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
 /**
diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index ada4f968960ae..83aac2e9692c0 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -19,9 +19,9 @@ struct memory_provider_ops {
 	void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
 };
 
-bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
-void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
-void net_mp_niov_clear_page_pool(struct net_iov *niov);
+bool net_mp_niov_set_dma_addr(struct netmem_desc *niov, dma_addr_t addr);
+void net_mp_niov_set_page_pool(struct page_pool *pool, struct netmem_desc *niov);
+void net_mp_niov_clear_page_pool(struct netmem_desc *niov);
 
 int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
 		    struct pp_memory_provider_params *p);
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 0f46e0404c045..c0b66039d43df 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -34,7 +34,7 @@ static void __io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 	int i;
 
 	for (i = 0; i < nr_mapped; i++) {
-		struct net_iov *niov = &area->nia.niovs[i];
+		struct netmem_desc *niov = &area->nia.niovs[i];
 		dma_addr_t dma;
 
 		dma = page_pool_get_dma_addr_netmem(net_iov_to_netmem(niov));
@@ -55,7 +55,7 @@ static int io_zcrx_map_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
 	int i;
 
 	for (i = 0; i < area->nia.num_niovs; i++) {
-		struct net_iov *niov = &area->nia.niovs[i];
+		struct netmem_desc *niov = &area->nia.niovs[i];
 		dma_addr_t dma;
 
 		dma = dma_map_page_attrs(ifq->dev, area->pages[i], 0, PAGE_SIZE,
@@ -79,7 +79,7 @@ static int io_zcrx_map_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
 }
 
 static void io_zcrx_sync_for_device(const struct page_pool *pool,
-				    struct net_iov *niov)
+				    struct netmem_desc *niov)
 {
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
 	dma_addr_t dma_addr;
@@ -106,21 +106,21 @@ struct io_zcrx_args {
 
 static const struct memory_provider_ops io_uring_pp_zc_ops;
 
-static inline struct io_zcrx_area *io_zcrx_iov_to_area(const struct net_iov *niov)
+static inline struct io_zcrx_area *io_zcrx_iov_to_area(const struct netmem_desc *niov)
 {
 	struct net_iov_area *owner = net_iov_owner(niov);
 
 	return container_of(owner, struct io_zcrx_area, nia);
 }
 
-static inline atomic_t *io_get_user_counter(struct net_iov *niov)
+static inline atomic_t *io_get_user_counter(struct netmem_desc *niov)
 {
 	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
 
 	return &area->user_refs[net_iov_idx(niov)];
 }
 
-static bool io_zcrx_put_niov_uref(struct net_iov *niov)
+static bool io_zcrx_put_niov_uref(struct netmem_desc *niov)
 {
 	atomic_t *uref = io_get_user_counter(niov);
 
@@ -130,12 +130,12 @@ static bool io_zcrx_put_niov_uref(struct net_iov *niov)
 	return true;
 }
 
-static void io_zcrx_get_niov_uref(struct net_iov *niov)
+static void io_zcrx_get_niov_uref(struct netmem_desc *niov)
 {
 	atomic_inc(io_get_user_counter(niov));
 }
 
-static inline struct page *io_zcrx_iov_page(const struct net_iov *niov)
+static inline struct page *io_zcrx_iov_page(const struct netmem_desc *niov)
 {
 	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
 
@@ -242,7 +242,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		goto err;
 
 	for (i = 0; i < nr_iovs; i++) {
-		struct net_iov *niov = &area->nia.niovs[i];
+		struct netmem_desc *niov = &area->nia.niovs[i];
 
 		niov->owner = &area->nia;
 		area->freelist[i] = i;
@@ -435,7 +435,7 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 	io_zcrx_ifq_free(ifq);
 }
 
-static struct net_iov *__io_zcrx_get_free_niov(struct io_zcrx_area *area)
+static struct netmem_desc *__io_zcrx_get_free_niov(struct io_zcrx_area *area)
 {
 	unsigned niov_idx;
 
@@ -445,7 +445,7 @@ static struct net_iov *__io_zcrx_get_free_niov(struct io_zcrx_area *area)
 	return &area->nia.niovs[niov_idx];
 }
 
-static void io_zcrx_return_niov_freelist(struct net_iov *niov)
+static void io_zcrx_return_niov_freelist(struct netmem_desc *niov)
 {
 	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
 
@@ -454,7 +454,7 @@ static void io_zcrx_return_niov_freelist(struct net_iov *niov)
 	spin_unlock_bh(&area->freelist_lock);
 }
 
-static void io_zcrx_return_niov(struct net_iov *niov)
+static void io_zcrx_return_niov(struct netmem_desc *niov)
 {
 	netmem_ref netmem = net_iov_to_netmem(niov);
 
@@ -476,7 +476,7 @@ static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
 
 	/* Reclaim back all buffers given to the user space. */
 	for (i = 0; i < area->nia.num_niovs; i++) {
-		struct net_iov *niov = &area->nia.niovs[i];
+		struct netmem_desc *niov = &area->nia.niovs[i];
 		int nr;
 
 		if (!atomic_read(io_get_user_counter(niov)))
@@ -532,7 +532,7 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 	do {
 		struct io_uring_zcrx_rqe *rqe = io_zcrx_get_rqe(ifq, mask);
 		struct io_zcrx_area *area;
-		struct net_iov *niov;
+		struct netmem_desc *niov;
 		unsigned niov_idx, area_idx;
 
 		area_idx = rqe->off >> IORING_ZCRX_AREA_SHIFT;
@@ -573,7 +573,7 @@ static void io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *ifq)
 
 	spin_lock_bh(&area->freelist_lock);
 	while (area->free_count && pp->alloc.count < PP_ALLOC_CACHE_REFILL) {
-		struct net_iov *niov = __io_zcrx_get_free_niov(area);
+		struct netmem_desc *niov = __io_zcrx_get_free_niov(area);
 		netmem_ref netmem = net_iov_to_netmem(niov);
 
 		net_mp_niov_set_page_pool(pp, niov);
@@ -604,7 +604,7 @@ static netmem_ref io_pp_zc_alloc_netmems(struct page_pool *pp, gfp_t gfp)
 
 static bool io_pp_zc_release_netmem(struct page_pool *pp, netmem_ref netmem)
 {
-	struct net_iov *niov;
+	struct netmem_desc *niov;
 
 	if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
 		return false;
@@ -678,7 +678,7 @@ static const struct memory_provider_ops io_uring_pp_zc_ops = {
 	.uninstall		= io_pp_uninstall,
 };
 
-static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
+static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct netmem_desc *niov,
 			      struct io_zcrx_ifq *ifq, int off, int len)
 {
 	struct io_uring_zcrx_cqe *rcqe;
@@ -701,9 +701,9 @@ static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 	return true;
 }
 
-static struct net_iov *io_zcrx_alloc_fallback(struct io_zcrx_area *area)
+static struct netmem_desc *io_zcrx_alloc_fallback(struct io_zcrx_area *area)
 {
-	struct net_iov *niov = NULL;
+	struct netmem_desc *niov = NULL;
 
 	spin_lock_bh(&area->freelist_lock);
 	if (area->free_count)
@@ -726,7 +726,7 @@ static ssize_t io_zcrx_copy_chunk(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 	while (len) {
 		size_t copy_size = min_t(size_t, PAGE_SIZE, len);
 		const int dst_off = 0;
-		struct net_iov *niov;
+		struct netmem_desc *niov;
 		struct page *dst_page;
 		void *dst_addr;
 
@@ -784,7 +784,7 @@ static int io_zcrx_copy_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 static int io_zcrx_recv_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 			     const skb_frag_t *frag, int off, int len)
 {
-	struct net_iov *niov;
+	struct netmem_desc *niov;
 
 	if (unlikely(!skb_frag_is_net_iov(frag)))
 		return io_zcrx_copy_frag(req, ifq, frag, off, len);
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6e27a47d04935..5568478dd2ff6 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -28,7 +28,7 @@ static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
-bool net_is_devmem_iov(struct net_iov *niov)
+bool net_is_devmem_iov(struct netmem_desc *niov)
 {
 	return niov->pp->mp_ops == &dmabuf_devmem_ops;
 }
@@ -43,7 +43,7 @@ static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 	kfree(owner);
 }
 
-static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
+static dma_addr_t net_devmem_get_dma_addr(const struct netmem_desc *niov)
 {
 	struct dmabuf_genpool_chunk_owner *owner;
 
@@ -74,12 +74,12 @@ void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 	kfree(binding);
 }
 
-struct net_iov *
+struct netmem_desc *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 {
 	struct dmabuf_genpool_chunk_owner *owner;
 	unsigned long dma_addr;
-	struct net_iov *niov;
+	struct netmem_desc *niov;
 	ssize_t offset;
 	ssize_t index;
 
@@ -99,7 +99,7 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	return niov;
 }
 
-void net_devmem_free_dmabuf(struct net_iov *niov)
+void net_devmem_free_dmabuf(struct netmem_desc *niov)
 {
 	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
 	unsigned long dma_addr = net_devmem_get_dma_addr(niov);
@@ -233,7 +233,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 		dma_addr_t dma_addr = sg_dma_address(sg);
 		struct dmabuf_genpool_chunk_owner *owner;
 		size_t len = sg_dma_len(sg);
-		struct net_iov *niov;
+		struct netmem_desc *niov;
 
 		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
 				     dev_to_node(&dev->dev));
@@ -319,7 +319,7 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 {
 	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
-	struct net_iov *niov;
+	struct netmem_desc *niov;
 	netmem_ref netmem;
 
 	niov = net_devmem_alloc_dmabuf(binding);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 7fc158d527293..314ab0acdf716 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -70,7 +70,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct netlink_ext_ack *extack);
 
 static inline struct dmabuf_genpool_chunk_owner *
-net_devmem_iov_to_chunk_owner(const struct net_iov *niov)
+net_devmem_iov_to_chunk_owner(const struct netmem_desc *niov)
 {
 	struct net_iov_area *owner = net_iov_owner(niov);
 
@@ -78,17 +78,17 @@ net_devmem_iov_to_chunk_owner(const struct net_iov *niov)
 }
 
 static inline struct net_devmem_dmabuf_binding *
-net_devmem_iov_binding(const struct net_iov *niov)
+net_devmem_iov_binding(const struct netmem_desc *niov)
 {
 	return net_devmem_iov_to_chunk_owner(niov)->binding;
 }
 
-static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
+static inline u32 net_devmem_iov_binding_id(const struct netmem_desc *niov)
 {
 	return net_devmem_iov_binding(niov)->id;
 }
 
-static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
+static inline unsigned long net_iov_virtual_addr(const struct netmem_desc *niov)
 {
 	struct net_iov_area *owner = net_iov_owner(niov);
 
@@ -111,11 +111,11 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 	__net_devmem_dmabuf_binding_free(binding);
 }
 
-struct net_iov *
+struct netmem_desc *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
-void net_devmem_free_dmabuf(struct net_iov *ppiov);
+void net_devmem_free_dmabuf(struct netmem_desc *ppiov);
 
-bool net_is_devmem_iov(struct net_iov *niov);
+bool net_is_devmem_iov(struct netmem_desc *niov);
 
 #else
 struct net_devmem_dmabuf_binding;
@@ -146,27 +146,27 @@ net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	return -EOPNOTSUPP;
 }
 
-static inline struct net_iov *
+static inline struct netmem_desc *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 {
 	return NULL;
 }
 
-static inline void net_devmem_free_dmabuf(struct net_iov *ppiov)
+static inline void net_devmem_free_dmabuf(struct netmem_desc *ppiov)
 {
 }
 
-static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
+static inline unsigned long net_iov_virtual_addr(const struct netmem_desc *niov)
 {
 	return 0;
 }
 
-static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
+static inline u32 net_devmem_iov_binding_id(const struct netmem_desc *niov)
 {
 	return 0;
 }
 
-static inline bool net_is_devmem_iov(struct net_iov *niov)
+static inline bool net_is_devmem_iov(struct netmem_desc *niov)
 {
 	return false;
 }
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7745ad924ae2d..575fdab337414 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1198,7 +1198,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 }
 EXPORT_SYMBOL(page_pool_update_nid);
 
-bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr)
+bool net_mp_niov_set_dma_addr(struct netmem_desc *niov, dma_addr_t addr)
 {
 	return page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov), addr);
 }
@@ -1206,7 +1206,7 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr)
 /* Associate a niov with a page pool. Should follow with a matching
  * net_mp_niov_clear_page_pool()
  */
-void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov)
+void net_mp_niov_set_page_pool(struct page_pool *pool, struct netmem_desc *niov)
 {
 	netmem_ref netmem = net_iov_to_netmem(niov);
 
@@ -1219,7 +1219,7 @@ void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov)
 /* Disassociate a niov from a page pool. Should only be used in the
  * ->release_netmem() path.
  */
-void net_mp_niov_clear_page_pool(struct net_iov *niov)
+void net_mp_niov_clear_page_pool(struct netmem_desc *niov)
 {
 	netmem_ref netmem = net_iov_to_netmem(niov);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6edc441b37023..76199c832ef82 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2483,7 +2483,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 		 */
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-			struct net_iov *niov;
+			struct netmem_desc *niov;
 			u64 frag_offset;
 			int end;
 
-- 
2.17.1


