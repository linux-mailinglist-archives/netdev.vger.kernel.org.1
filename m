Return-Path: <netdev+bounces-163669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195F4A2B42E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBEF168BBD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 21:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D5D1F4178;
	Thu,  6 Feb 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB1xB1Vj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B61F63E8
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877387; cv=none; b=f/q+bYrkpNbfE8V7Yf8RrWRUFx3SGFVyYZB05gagomnDtgt6FEwqXC84B6cRI3BaKzRdKsu79TdwK7M6xgWhszNV8vxCvFQIt5Uo4Jt9FyxHMpZXIwey3tQiDKA+X6JkoJET0bwu08FzYwLPCnEWcvPnkuNk9YEZoJmbvla2z0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877387; c=relaxed/simple;
	bh=A6TTiu3mBQ8WrU99XKbFU9nfwT1ncucUhelx3jmdnOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDv8GnTdx2Bmwp4PomVekGREenEbqkTBmavNxJhzDFcG7D3K6orGtfgXcpWmUTdsnMk0xPkul5VI2vLiFlJ1kZNsHAlhSB0gSmMa5yhGSYpmvxnn1YesJJpZ6FCIaD16H7YUcgMyr/3sA3JKRWYMu+AFf0k936GBjEelObevUmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PB1xB1Vj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738877382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gke+kpGI22E8kWaQlFj2yXZXAZ9KiJB37Zh0LKiikgs=;
	b=PB1xB1Vju0QS85iTJmsI47JLsgbHOKuoZZGGBzZ92YlpQzuXQMeQSphzKi1eZ0Z0WEY9hD
	nZSQLgFfoM7reEDiYlDPDm2kXJ0mZO2iKb+8I/5n7WnPY1Wevq4H8gBl28xNU+0FC+ot+w
	4zVvngvvQeQW5HTf9f+veWCCxXenejU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-njuxJtXbPQmPbyC1gXO4Xg-1; Thu,
 06 Feb 2025 16:29:37 -0500
X-MC-Unique: njuxJtXbPQmPbyC1gXO4Xg-1
X-Mimecast-MFC-AGG-ID: njuxJtXbPQmPbyC1gXO4Xg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9ABE01956094;
	Thu,  6 Feb 2025 21:29:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.200])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2906130001AB;
	Thu,  6 Feb 2025 21:29:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: [PATCH net] Revert "net: skb: introduce and use a single page frag cache"
Date: Thu,  6 Feb 2025 22:28:48 +0100
Message-ID: <e649212fde9f0fdee23909ca0d14158d32bb7425.1738877290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This reverts commit dbae2b062824 ("net: skb: introduce and use a single
page frag cache"). The intended goal of such change was to counter a
performance regression introduced by commit 3226b158e67c ("net: avoid
32 x truesize under-estimation for tiny skbs").

Unfortunately, the blamed commit introduces another regression for the
virtio_net driver. Such a driver calls napi_alloc_skb() with a tiny
size, so that the whole head frag could fit a 512-byte block.

The single page frag cache uses a 1K fragment for such allocation, and
the additional overhead, under small UDP packets flood, makes the page
allocator a bottleneck.

Thanks to commit bf9f1baa279f ("net: add dedicated kmem_cache for
typical/small skb->head"), this revert does not re-introduce the
original regression. Actually, in the relevant test on top of this
revert, I measure a small but noticeable positive delta, just above
noise level.

The revert itself required some additional mangling due to the
introduction of the SKB_HEAD_ALIGN() helper and local lock infra in the
affected code.

Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: dbae2b062824 ("net: skb: introduce and use a single page frag cache")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
@Eric: IIRC, once upon time, you reported a similar regression, which
was root-caused to the SLOB allocator. Please let me know if you prefer
your Reported-by tag here.
---
 include/linux/netdevice.h |   1 -
 net/core/dev.c            |  17 +++++++
 net/core/skbuff.c         | 103 ++------------------------------------
 3 files changed, 22 insertions(+), 99 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 03bb584c62cf..8c91cdf06afd 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4109,7 +4109,6 @@ void netif_receive_skb_list(struct list_head *head);
 gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb);
 void napi_gro_flush(struct napi_struct *napi, bool flush_old);
 struct sk_buff *napi_get_frags(struct napi_struct *napi);
-void napi_get_frags_check(struct napi_struct *napi);
 gro_result_t napi_gro_frags(struct napi_struct *napi);
 
 static inline void napi_free_frags(struct napi_struct *napi)
diff --git a/net/core/dev.c b/net/core/dev.c
index b91658e8aedb..55e356a68db6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6920,6 +6920,23 @@ netif_napi_dev_list_add(struct net_device *dev, struct napi_struct *napi)
 	list_add_rcu(&napi->dev_list, higher); /* adds after higher */
 }
 
+/* Double check that napi_get_frags() allocates skbs with
+ * skb->head being backed by slab, not a page fragment.
+ * This is to make sure bug fixed in 3226b158e67c
+ * ("net: avoid 32 x truesize under-estimation for tiny skbs")
+ * does not accidentally come back.
+ */
+static void napi_get_frags_check(struct napi_struct *napi)
+{
+	struct sk_buff *skb;
+
+	local_bh_disable();
+	skb = napi_get_frags(napi);
+	WARN_ON_ONCE(skb && skb->head_frag);
+	napi_free_frags(napi);
+	local_bh_enable();
+}
+
 void netif_napi_add_weight_locked(struct net_device *dev,
 				  struct napi_struct *napi,
 				  int (*poll)(struct napi_struct *, int),
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..6a99c453397f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -220,67 +220,9 @@ static void skb_under_panic(struct sk_buff *skb, unsigned int sz, void *addr)
 #define NAPI_SKB_CACHE_BULK	16
 #define NAPI_SKB_CACHE_HALF	(NAPI_SKB_CACHE_SIZE / 2)
 
-#if PAGE_SIZE == SZ_4K
-
-#define NAPI_HAS_SMALL_PAGE_FRAG	1
-#define NAPI_SMALL_PAGE_PFMEMALLOC(nc)	((nc).pfmemalloc)
-
-/* specialized page frag allocator using a single order 0 page
- * and slicing it into 1K sized fragment. Constrained to systems
- * with a very limited amount of 1K fragments fitting a single
- * page - to avoid excessive truesize underestimation
- */
-
-struct page_frag_1k {
-	void *va;
-	u16 offset;
-	bool pfmemalloc;
-};
-
-static void *page_frag_alloc_1k(struct page_frag_1k *nc, gfp_t gfp)
-{
-	struct page *page;
-	int offset;
-
-	offset = nc->offset - SZ_1K;
-	if (likely(offset >= 0))
-		goto use_frag;
-
-	page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
-	if (!page)
-		return NULL;
-
-	nc->va = page_address(page);
-	nc->pfmemalloc = page_is_pfmemalloc(page);
-	offset = PAGE_SIZE - SZ_1K;
-	page_ref_add(page, offset / SZ_1K);
-
-use_frag:
-	nc->offset = offset;
-	return nc->va + offset;
-}
-#else
-
-/* the small page is actually unused in this build; add dummy helpers
- * to please the compiler and avoid later preprocessor's conditionals
- */
-#define NAPI_HAS_SMALL_PAGE_FRAG	0
-#define NAPI_SMALL_PAGE_PFMEMALLOC(nc)	false
-
-struct page_frag_1k {
-};
-
-static void *page_frag_alloc_1k(struct page_frag_1k *nc, gfp_t gfp_mask)
-{
-	return NULL;
-}
-
-#endif
-
 struct napi_alloc_cache {
 	local_lock_t bh_lock;
 	struct page_frag_cache page;
-	struct page_frag_1k page_small;
 	unsigned int skb_count;
 	void *skb_cache[NAPI_SKB_CACHE_SIZE];
 };
@@ -290,23 +232,6 @@ static DEFINE_PER_CPU(struct napi_alloc_cache, napi_alloc_cache) = {
 	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
 };
 
-/* Double check that napi_get_frags() allocates skbs with
- * skb->head being backed by slab, not a page fragment.
- * This is to make sure bug fixed in 3226b158e67c
- * ("net: avoid 32 x truesize under-estimation for tiny skbs")
- * does not accidentally come back.
- */
-void napi_get_frags_check(struct napi_struct *napi)
-{
-	struct sk_buff *skb;
-
-	local_bh_disable();
-	skb = napi_get_frags(napi);
-	WARN_ON_ONCE(!NAPI_HAS_SMALL_PAGE_FRAG && skb && skb->head_frag);
-	napi_free_frags(napi);
-	local_bh_enable();
-}
-
 void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 {
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
@@ -813,10 +738,8 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 
 	/* If requested length is either too small or too big,
 	 * we use kmalloc() for skb->head allocation.
-	 * When the small frag allocator is available, prefer it over kmalloc
-	 * for small fragments
 	 */
-	if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(1024)) ||
+	if (len <= SKB_WITH_OVERHEAD(1024) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALLOC_NAPI,
@@ -826,32 +749,16 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 		goto skb_success;
 	}
 
+	len = SKB_HEAD_ALIGN(len);
+
 	if (sk_memalloc_socks())
 		gfp_mask |= __GFP_MEMALLOC;
 
 	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
 	nc = this_cpu_ptr(&napi_alloc_cache);
-	if (NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(1024)) {
-		/* we are artificially inflating the allocation size, but
-		 * that is not as bad as it may look like, as:
-		 * - 'len' less than GRO_MAX_HEAD makes little sense
-		 * - On most systems, larger 'len' values lead to fragment
-		 *   size above 512 bytes
-		 * - kmalloc would use the kmalloc-1k slab for such values
-		 * - Builds with smaller GRO_MAX_HEAD will very likely do
-		 *   little networking, as that implies no WiFi and no
-		 *   tunnels support, and 32 bits arches.
-		 */
-		len = SZ_1K;
 
-		data = page_frag_alloc_1k(&nc->page_small, gfp_mask);
-		pfmemalloc = NAPI_SMALL_PAGE_PFMEMALLOC(nc->page_small);
-	} else {
-		len = SKB_HEAD_ALIGN(len);
-
-		data = page_frag_alloc(&nc->page, len, gfp_mask);
-		pfmemalloc = page_frag_cache_is_pfmemalloc(&nc->page);
-	}
+	data = page_frag_alloc(&nc->page, len, gfp_mask);
+	pfmemalloc = page_frag_cache_is_pfmemalloc(&nc->page);
 	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 
 	if (unlikely(!data))
-- 
2.48.1


