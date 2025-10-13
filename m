Return-Path: <netdev+bounces-228664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2DEBD162F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 06:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CE73B7DC8
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 04:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E1A2BE7DD;
	Mon, 13 Oct 2025 04:41:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3C145B16;
	Mon, 13 Oct 2025 04:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760330511; cv=none; b=l4goo2vWNCpLOLHUTPBVrrCHhb87MJjS2yq3n1RlvFrO9AgHQeUXPN865//1wAIWXjdcfUh/5pJ2osOGMwfvmPalJ0pzd0+wEV56dxsDx3QVt2z6dzf6OpqiNpOMpZ9zoc/p3YX3fSc77r8XLY0ZXX7Tv28Embek9QoWZ0n2m68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760330511; c=relaxed/simple;
	bh=c79UIMu1a+/DPmtKafALUphndyR7diES9YMqJgRu7LA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=k+mh8wFTAQmNlhr+ogApPnt5SKVVW7jS6OnI8xBDGSDQR3AzCbVXgxbYzbTLVw1BMmpQYIpcz8kobTqSnyLp59QUcK0eqfXbePt7beTcYFqjVOlSMgX84asesOOEedR946HZE1lHtkOzZDaXIlEkojASELESgSPwwfmVIX/NlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-de-68ec83070b3d
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
Subject: [RESEND PATCH net-next v3] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
Date: Mon, 13 Oct 2025 13:41:33 +0900
Message-Id: <20251013044133.69472-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LhesuzUJe9+U2GQe86A4vVPyos5qzaxmgx
	53wLi8XTY4/YLfa0b2e2eNR/gs3iwrY+VovLu+awWRxbIGbx7fQbRotLhx+xOHB7bFl5k8lj
	56y77B4LNpV6bFrVyebxft9VNo/Pm+QC2KK4bFJSczLLUov07RK4Ms61P2Ip6LSoWPRtMWMD
	4za9LkZODgkBE4n3i94xwthfPl1nB7HZBNQlbtz4yQxiiwhYSTRsXAdkc3EwC9xnlHhy6Swb
	SEJYIEGib8pKMJtFQFXi1tfVYDavgKlE2/v77BBD5SVWbzgA1iwh8JNVYkVzGxtEQlLi4Iob
	LBMYuRcwMqxiFMrMK8tNzMwx0cuozMus0EvOz93ECAymZbV/oncwfroQfIhRgINRiYc3Y/fr
	DCHWxLLiytxDjBIczEoivObVbzKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnN
	Tk0tSC2CyTJxcEo1MFatnPX5+/LWYwmL849/3h7gsdLhJuPut2m9PFeEfbfdCpxsdvm5yKrz
	80XmbZXkvpXscvjilWPvFZfOkprRYaFxfsldoRPX3yrZXZ6zuKvMNYBb7r7Jv9AYx4nlJx+v
	uqy8J+vQ7zNsC5ReuKxZ8Fp04xVH+VZhtapne7bWPYm9unVZNo/Wh90zlViKMxINtZiLihMB
	E2t9RyICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGJMWRmVeSWpSXmKPExsXC5WfdrMve/CbD4PweZYvVPyos5qzaxmgx
	53wLi8XTY4/YLfa0b2e2eNR/gs3i8NyTrBYXtvWxWlzeNYfN4tgCMYtvp98wWlw6/IjFgcdj
	y8qbTB47Z91l91iwqdRj06pONo/3+66yeSx+8YHJ4/MmuQD2KC6blNSczLLUIn27BK6Mc+2P
	WAo6LSoWfVvM2MC4Ta+LkZNDQsBE4sun6+wgNpuAusSNGz+ZQWwRASuJho3rgGwuDmaB+4wS
	Ty6dZQNJCAskSPRNWQlmswioStz6uhrM5hUwlWh7f58dYqi8xOoNB5gnMHIsYGRYxSiSmVeW
	m5iZY6pXnJ1RmZdZoZecn7uJERgay2r/TNzB+OWy+yFGAQ5GJR7ejN2vM4RYE8uKK3MPMUpw
	MCuJ8JpXv8kQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRq
	YIzS6No+UTM5J3XRkXVKE68sqDkdcUj31KmCQBuHWq2wl66rfrs/6N4ad3E1qzM/3wlp/gmu
	1rsjPxwx425lVMic48gc+vtH9e/9h6TjPnRwrlFasP8Wbwp7b+inMHf+a2tTDna6th6aqOE7
	Jcn4YqjO1+bYGWIeWy2MLRKvs+gV3ubvCD0grMRSnJFoqMVcVJwIAARXzQAJAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

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
Changes from RFC v2:
	1. Add a Reviewed-by tag (Thanks to Mina)
	2. Rebase on main branch as of Sep 22

Changes from RFC:
	1. Optimize the implementation of netmem_to_nmdesc to use less
	   instructions (feedbacked by Pavel)
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


