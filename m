Return-Path: <netdev+bounces-210426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C37B133A7
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 06:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258147A6EC2
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 04:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2EC1F5842;
	Mon, 28 Jul 2025 04:21:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D231C36;
	Mon, 28 Jul 2025 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753676477; cv=none; b=XjnLGCCrCPgLZ2QXxX0dPILAI6cj+sc9KThTyvjqR1sS6lqp5B9bWKb9LD+/JdCw0ZzjPhCUKeR8tQ5RblY+uA31/WZfOUXrhKJlquPvXcgnD9v2PJgmoXjCJsN1swrGLtLQ7Vzoq8b/JZFN3fQAo7Ht0k09G6Qn0lvAgJcGntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753676477; c=relaxed/simple;
	bh=w86KR5FHkwPycOHZuKnays9MGzpZ9OSrzPKVwgR4qus=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RAPsSb9gFfv130tfHbWHOWIcKX4UP/Rj2vyTHjcWwnALhT4SGpLtB81VGb8Gnpu17WkMqxG/NXhgRY0rJ8Ihgli4y8lLpkcb69IEI3TnpoAi3abODOti/BG0R0INFpxg+SzhINBbH7Y5h6vcXnvb5zQtOy5xM9CrQbxUEOsKKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-3e-6886faacf898
From: Byungchul Park <byungchul@sk.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	almasrymina@google.com,
	hawk@kernel.org,
	toke@redhat.com,
	asml.silence@gmail.com
Subject: [RFC net-next] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
Date: Mon, 28 Jul 2025 13:20:50 +0900
Message-Id: <20250728042050.24228-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LhesuzUHfNr7YMg8n3NSxW/6iwmLNqG6PF
	nPMtLBZPjz1it9jTvp3Z4lH/CTaLC9v6WC0u75rDZnFsgZjFt9NvGC0uHX7E4sDtsWXlTSaP
	nbPusnss2FTqsWlVJ5vH+31X2Tw+b5ILYIvisklJzcksSy3St0vgymjYeo2tYIJWxdqV91ga
	GDcqdzFycEgImEisnZjTxcgJZj6edIAVxGYTUJe4ceMnM4gtImAl0bBxHZDNxcEscIRRYsez
	t2AJYYEQicaDT1lAbBYBVYmdm7+ygczkFTCV+Pk5BGKmvMTqDQfAeiUE3rJKfLi8gxkiISlx
	cMUNlgmM3AsYGVYxCmXmleUmZuaY6GVU5mVW6CXn525iBAbSsto/0TsYP10IPsQowMGoxMP7
	wrwtQ4g1say4MvcQowQHs5IIb8FSoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6Ykl
	qdmpqQWpRTBZJg5OqQbGebxmdmWPqxWPZ8YyWE0tfbowPKJAOmvWW+/Jp6cs4tRft2S2bktT
	WU/mrIi9VQt2yF37YJTNaR0i5KSuvjwyZ62LbvID3RvPT7BE2Sv0qXAmfNF04bf7lbzI11Nn
	v/+bzSW/arfZTcs/H/LsdueJ9r0b1ap+JixX+D/zmdIL/svrZsQq6O5TYinOSDTUYi4qTgQA
	/9nyhCACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNJMWRmVeSWpSXmKPExsXC5WfdrLvmV1uGwdGPcharf1RYzFm1jdFi
	zvkWFounxx6xW+xp385s8aj/BJvFhW19rBaXd81hszi2QMzi2+k3jBaXDj9iceD22LLyJpPH
	zll32T0WbCr12LSqk83j/b6rbB6fN8kFsEVx2aSk5mSWpRbp2yVwZTRsvcZWMEGrYu3KeywN
	jBuVuxg5OSQETCQeTzrACmKzCahL3LjxkxnEFhGwkmjYuA7I5uJgFjjCKLHj2VuwhLBAiETj
	wacsIDaLgKrEzs1f2boYOTh4BUwlfn4OgZgpL7F6wwHmCYwcCxgZVjGKZOaV5SZm5pjqFWdn
	VOZlVugl5+duYgQGwbLaPxN3MH657H6IUYCDUYmH94V5W4YQa2JZcWXuIUYJDmYlEd6CpUAh
	3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGRv2P8Sqa9tzJ
	8bsy5jhPvcz+v/XqJTuB+Zzs2xo7PJVkLiQvsSw+n/jOaWaF6NU3L5aI2PTtmt766kNZUMi7
	xJwCvqU2O6ddqzZliF0e2rR27fE0til2Ra1PX0g197xc0pzsFqRvqjZjfYk7U+GlLVOC/z3r
	eKPzlvWStv2OOa+mmL07/eBVuBJLcUaioRZzUXEiAKmXYzj+AQAA
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

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/netmem.h   | 33 ++++++++++++++++-----------------
 net/core/netmem_priv.h | 16 ++++++++--------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index f7dacc9e75fd..33ae444a9745 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -265,24 +265,23 @@ static inline struct netmem_desc *__netmem_to_nmdesc(netmem_ref netmem)
 	return (__force struct netmem_desc *)netmem;
 }
 
-/* __netmem_clear_lsb - convert netmem_ref to struct net_iov * for access to
- * common fields.
- * @netmem: netmem reference to extract as net_iov.
+/* netmem_to_nmdesc - convert netmem_ref to struct netmem_desc * for
+ * access to common fields.
+ * @netmem: netmem reference to get netmem_desc.
  *
- * All the sub types of netmem_ref (page, net_iov) have the same pp, pp_magic,
- * dma_addr, and pp_ref_count fields at the same offsets. Thus, we can access
- * these fields without a type check to make sure that the underlying mem is
- * net_iov or page.
+ * All the sub types of netmem_ref (netmem_desc, net_iov) have the same
+ * pp, pp_magic, dma_addr, and pp_ref_count fields via netmem_desc.
  *
- * The resulting value of this function can only be used to access the fields
- * that are NET_IOV_ASSERT_OFFSET'd. Accessing any other fields will result in
- * undefined behavior.
- *
- * Return: the netmem_ref cast to net_iov* regardless of its underlying type.
+ * Return: the pointer to struct netmem_desc * regardless of its
+ * underlying type.
  */
-static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
+static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
 {
-	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
+	if (netmem_is_net_iov(netmem))
+		return &((struct net_iov *)((__force unsigned long)netmem &
+					    ~NET_IOV))->desc;
+
+	return __netmem_to_nmdesc(netmem);
 }
 
 /* XXX: How to extract netmem_desc from page must be changed, once
@@ -320,12 +319,12 @@ static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
 
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
@@ -390,7 +389,7 @@ static inline bool netmem_is_pfmemalloc(netmem_ref netmem)
 
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

base-commit: fa582ca7e187a15e772e6a72fe035f649b387a60
-- 
2.17.1


