Return-Path: <netdev+bounces-226586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDB1BA25E2
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 06:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D36494E0281
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AD6269D18;
	Fri, 26 Sep 2025 04:09:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE991534EC;
	Fri, 26 Sep 2025 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859788; cv=none; b=qz2GAKhs/qZIIoMH9d2xkZ2Xz7aQ1BFLh2GpS8x/srs1dHzqq5X3h6Mw6p3lxwqtmdNSfW+XPMp7p++lQO2G8VK2rFyR7QrKdg025Erf2GsvCGmBs2dQR81+Kbxs27YyUNVKgM6UQmqQ6ZUSh5tMzTNe2V512HSmdTEv9gCrwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859788; c=relaxed/simple;
	bh=KUA2IGS6uDePpaDgjKtY+mufgYMIZvorHbb4OY2Ul+s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OgOd1tt8MQQwrqN7qpYYjcwszybAxxpquOSDMScpdwR4deSzOdYPnq/xCuyGnBksN3KM9JlcGv0PdmoHHBwlu8qCuR3MgbBSbqpcZRZyhveeOx9KJgTatTawrFQ70bSmX6cAyzEjgfnROzu3gwQGROjC3bzUscg4nwyn9BDDZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-4b-68d60e79f221
From: Byungchul Park <byungchul@sk.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	almasrymina@google.com,
	hawk@kernel.org,
	toke@redhat.com,
	asml.silence@gmail.com
Subject: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
Date: Fri, 26 Sep 2025 12:54:23 +0900
Message-Id: <20250926035423.51210-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LhesuzULeS71qGwd7Huharf1RYzFm1jdFi
	zvkWFounxx6xW+xp385s8aj/BJvFhW19rBaXd81hszi2QMzi2+k3jBaXDj9iceD22LLyJpPH
	zll32T0WbCr12LSqk83j/b6rbB6fN8kFsEVx2aSk5mSWpRbp2yVwZVw9+4yxoNWq4srEk+wN
	jP0GXYycHBICJhKtk66zwtiXZk1jAbHZBNQlbtz4yQxiiwhYSTRsXAdkc3EwC9xnlHhy6Swb
	SEJYIFJi86MTYA0sAqoSW+7dARvEK2AqsfDYLiaIofISqzccAGuWEPjLKvHq6052iISkxMEV
	N1gmMHIvYGRYxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREYTMtq/0TvYPx0IfgQowAHoxIP7wOv
	qxlCrIllxZW5hxglOJiVRHh377uSIcSbklhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJ
	anZqakFqEUyWiYNTqoHRqmtvpYQq094zPSWOyxi4l/mud3rWYZCrxxb7YeaJ72ZCH7doHBIp
	a3b7nnbrgIb03x51zfkG3Ss8NPYtsXEyvHyq1S6y8uPMRKULXFtbhD+7Lb6iayVYq/f52SrD
	9Akpk21Nb8Tm9OpkxD1JjNwUFH950lej2s/aNZOLNPfmLVRIaLcX51diKc5INNRiLipOBADu
	DwbSIgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGJMWRmVeSWpSXmKPExsXC5WfdrFvJdy3D4MZsBYvVPyos5qzaxmgx
	53wLi8XTY4/YLfa0b2e2eNR/gs3i8NyTrBYXtvWxWlzeNYfN4tgCMYtvp98wWlw6/IjFgcdj
	y8qbTB47Z91l91iwqdRj06pONo/3+66yeSx+8YHJ4/MmuQD2KC6blNSczLLUIn27BK6Mq2ef
	MRa0WlVcmXiSvYGx36CLkZNDQsBE4tKsaSwgNpuAusSNGz+ZQWwRASuJho3rgGwuDmaB+4wS
	Ty6dZQNJCAtESmx+dAKsgUVAVWLLvTusIDavgKnEwmO7mCCGykus3nCAeQIjxwJGhlWMIpl5
	ZbmJmTmmesXZGZV5mRV6yfm5mxiBobGs9s/EHYxfLrsfYhTgYFTi4X3gdTVDiDWxrLgy9xCj
	BAezkgjv7n1XMoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4
	pRoYbyZv+5HxX2TOhBt8Nn8tXkhprmbhYRCQY/GrvqSYKjC1RsZl8tHJ9yfYWBZMCt01i8XP
	cbvBsrLJTQsu+E8VfTq1JvWVa9Iyn+opEtumlIlwWfUbvPqTnPH+kahchvXcWyqmEx16fH/8
	fmlzbOX29DPHPEPZFA4cnVj/c/VXhZSATwbrTFNnK7EUZyQaajEXFScCAK5kY18JAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Changes from RFC v2:
	1. Add a Reviewed-by tag (Thanks to Mina)
	2. Rebase on main branch as of Sep 22

Changes from RFC:
	1. Optimize the implementation of netmem_to_nmdesc to use less
	   instructions (feedbacked by Pavel)

--->8---
From 01d23fc4b20c369a2ecf29dc92319d55a4e63aa2 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Tue, 29 Jul 2025 19:34:12 +0900
Subject: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()

Now that we have struct netmem_desc, it'd better access the pp fields
via struct netmem_desc rather than struct net_iov.

Introduce netmem_to_nmdesc() for safely converting netmem_ref to
netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.

While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
used instead.

Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h   | 66 +++++++++++++++++++++---------------------
 net/core/netmem_priv.h | 16 +++++-----
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index f7dacc9e75fd..651e2c62d1dd 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -247,6 +247,23 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
 	return page_to_pfn(netmem_to_page(netmem));
 }
 
+/* XXX: How to extract netmem_desc from page must be changed, once
+ * netmem_desc no longer overlays on page and will be allocated through
+ * slab.
+ */
+#define __pp_page_to_nmdesc(p)	(_Generic((p),				\
+	const struct page * :	(const struct netmem_desc *)(p),	\
+	struct page * :		(struct netmem_desc *)(p)))
+
+/* CAUTION: Check if the page is a pp page before calling this helper or
+ * know it's a pp page.
+ */
+#define pp_page_to_nmdesc(p)						\
+({									\
+	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
+	__pp_page_to_nmdesc(p);						\
+})
+
 /**
  * __netmem_to_nmdesc - unsafely get pointer to the &netmem_desc backing
  * @netmem
@@ -265,42 +282,25 @@ static inline struct netmem_desc *__netmem_to_nmdesc(netmem_ref netmem)
 	return (__force struct netmem_desc *)netmem;
 }
 
-/* __netmem_clear_lsb - convert netmem_ref to struct net_iov * for access to
- * common fields.
- * @netmem: netmem reference to extract as net_iov.
- *
- * All the sub types of netmem_ref (page, net_iov) have the same pp, pp_magic,
- * dma_addr, and pp_ref_count fields at the same offsets. Thus, we can access
- * these fields without a type check to make sure that the underlying mem is
- * net_iov or page.
+/* netmem_to_nmdesc - convert netmem_ref to struct netmem_desc * for
+ * access to common fields.
+ * @netmem: netmem reference to get netmem_desc.
  *
- * The resulting value of this function can only be used to access the fields
- * that are NET_IOV_ASSERT_OFFSET'd. Accessing any other fields will result in
- * undefined behavior.
+ * All the sub types of netmem_ref (netmem_desc, net_iov) have the same
+ * pp, pp_magic, dma_addr, and pp_ref_count fields via netmem_desc.
  *
- * Return: the netmem_ref cast to net_iov* regardless of its underlying type.
+ * Return: the pointer to struct netmem_desc * regardless of its
+ * underlying type.
  */
-static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
+static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
 {
-	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
-}
+	void *p = (void *)((__force unsigned long)netmem & ~NET_IOV);
 
-/* XXX: How to extract netmem_desc from page must be changed, once
- * netmem_desc no longer overlays on page and will be allocated through
- * slab.
- */
-#define __pp_page_to_nmdesc(p)	(_Generic((p),				\
-	const struct page * :	(const struct netmem_desc *)(p),	\
-	struct page * :		(struct netmem_desc *)(p)))
+	if (netmem_is_net_iov(netmem))
+		return &((struct net_iov *)p)->desc;
 
-/* CAUTION: Check if the page is a pp page before calling this helper or
- * know it's a pp page.
- */
-#define pp_page_to_nmdesc(p)						\
-({									\
-	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
-	__pp_page_to_nmdesc(p);						\
-})
+	return __pp_page_to_nmdesc((struct page *)p);
+}
 
 /**
  * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
@@ -320,12 +320,12 @@ static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
 
 static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
 {
-	return __netmem_clear_lsb(netmem)->pp;
+	return netmem_to_nmdesc(netmem)->pp;
 }
 
 static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netmem)
 {
-	return &__netmem_clear_lsb(netmem)->pp_ref_count;
+	return &netmem_to_nmdesc(netmem)->pp_ref_count;
 }
 
 static inline bool netmem_is_pref_nid(netmem_ref netmem, int pref_nid)
@@ -390,7 +390,7 @@ static inline bool netmem_is_pfmemalloc(netmem_ref netmem)
 
 static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 {
-	return __netmem_clear_lsb(netmem)->dma_addr;
+	return netmem_to_nmdesc(netmem)->dma_addr;
 }
 
 void get_netmem(netmem_ref netmem);
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index cd95394399b4..23175cb2bd86 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -5,19 +5,19 @@
 
 static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
 {
-	return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
+	return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
 }
 
 static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
 {
-	__netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
+	netmem_to_nmdesc(netmem)->pp_magic |= pp_magic;
 }
 
 static inline void netmem_clear_pp_magic(netmem_ref netmem)
 {
-	WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
+	WARN_ON_ONCE(netmem_to_nmdesc(netmem)->pp_magic & PP_DMA_INDEX_MASK);
 
-	__netmem_clear_lsb(netmem)->pp_magic = 0;
+	netmem_to_nmdesc(netmem)->pp_magic = 0;
 }
 
 static inline bool netmem_is_pp(netmem_ref netmem)
@@ -27,13 +27,13 @@ static inline bool netmem_is_pp(netmem_ref netmem)
 
 static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
 {
-	__netmem_clear_lsb(netmem)->pp = pool;
+	netmem_to_nmdesc(netmem)->pp = pool;
 }
 
 static inline void netmem_set_dma_addr(netmem_ref netmem,
 				       unsigned long dma_addr)
 {
-	__netmem_clear_lsb(netmem)->dma_addr = dma_addr;
+	netmem_to_nmdesc(netmem)->dma_addr = dma_addr;
 }
 
 static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
@@ -43,7 +43,7 @@ static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
 	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
 		return 0;
 
-	magic = __netmem_clear_lsb(netmem)->pp_magic;
+	magic = netmem_to_nmdesc(netmem)->pp_magic;
 
 	return (magic & PP_DMA_INDEX_MASK) >> PP_DMA_INDEX_SHIFT;
 }
@@ -57,6 +57,6 @@ static inline void netmem_set_dma_index(netmem_ref netmem,
 		return;
 
 	magic = netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
-	__netmem_clear_lsb(netmem)->pp_magic = magic;
+	netmem_to_nmdesc(netmem)->pp_magic = magic;
 }
 #endif

base-commit: 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
-- 
2.17.1


