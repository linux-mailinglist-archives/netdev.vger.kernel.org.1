Return-Path: <netdev+bounces-189216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CD1AB12A6
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80258525356
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CA6293724;
	Fri,  9 May 2025 11:51:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00062918D9;
	Fri,  9 May 2025 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791510; cv=none; b=A/6bNIRkE5p+kWHSSWLmjTecSL/uWegOpWZ/nxOUn36DEla0s7ORD3fTNFGBXJrbdAYUohuz+5s+NpLRAJGRat5pi4yfrKCUwgAc95hAjIzRe7GNeRZV73SrAi6wNdz5fBn+QPGimVj/25qwfiXrKzM9y8nCMrdXW4403oQ3A5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791510; c=relaxed/simple;
	bh=8uQx4Xxlw13MVRH76cgZ+D3TL/9RtWBA0M1yU0nr2pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JhU49Ua41tpb/t9S1vO3WYnQfvlq/3JIUgzqyi2pRO9aMlfoGhBLtM7uYFy+MdgsVyP4USGeqfHT/NESzOble/7jf5TyBxqOAiP9/88bS2Mpl/QExd1GVfpZClTnJvOislhz9OORKKyB/3amk3eEnfbsiN4hKhyuCYY3mmZTaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-86-681dec498798
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
Subject: [RFC 16/19] netmem: use _Generic to cover const casting for page_to_netmem()
Date: Fri,  9 May 2025 20:51:23 +0900
Message-Id: <20250509115126.63190-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnoa7XG9kMgzNPGS3mrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgyPj1MLejhqFjR5djA+Iiti5GTQ0LAROLC0leMMHbjvC/sIDabgLrEjRs/mUFsEQFD
	ic+PjrN0MXJxMAssZJa4svgnWJGwQKjEt5eHwAaxCKhKdDTOB4vzCphJfPixmBViqLzE6g0H
	gAZxcHACxfs/qoOEhQRMJZZNWcAGMlNC4DebxNbpX6GOkJQ4uOIGywRG3gWMDKsYhTLzynIT
	M3NM9DIq8zIr9JLzczcxAiNgWe2f6B2Mny4EH2IU4GBU4uG1eC6bIcSaWFZcmXuIUYKDWUmE
	93mnTIYQb0piZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGxubN
	64MPyu7z26U67/UZjvWqx+0LhNLO1qZuZt8VNDfN4Wrqvunb4j0rNvntapzkwN0qKZc9YdGv
	a2q3JtSbCa/ifJAarPosSi/ryL6u7h/ie6o+hT5L4fX/+H/9RAWnoxKSn45bqqRN/N37dNP1
	7nv/SoSLt5v+6MyIetCn/NtsqfOa94fmtimxFGckGmoxFxUnAgDQFSMYfAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsXC5WfdrOv5RjbDYN85Q4s569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK+PTw9SCHo6KFV2ODYyP2LoYOTkkBEwkGud9YQex2QTUJW7c+MkM
	YosIGEp8fnScpYuRi4NZYCGzxJXFP8GKhAVCJb69PATWzCKgKtHROB8szitgJvHhx2JWiKHy
	Eqs3HAAaxMHBCRTv/6gOEhYSMJVYNmUB2wRGrgWMDKsYRTLzynITM3NM9YqzMyrzMiv0kvNz
	NzECw3lZ7Z+JOxi/XHY/xCjAwajEw2vxXDZDiDWxrLgy9xCjBAezkgjv806ZDCHelMTKqtSi
	/Pii0pzU4kOM0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGyJ1GAfLzGK3Xue+cv614
	2pLoX2VfeSpOvBIp+pTqz5Fmt9PhtlffwprIs15sM/fbKl7bs3/bs29zr5w66L79oNzpHeKd
	TocywlYwXbos5M3AmmNZEBVzdbO4nHScmFWr/Aqp5cXbN6fNCwsuEv2YYCX9hXPNh9I5nHYh
	257Imp74M//sofkXlFiKMxINtZiLihMBB5a/ZmMCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The current page_to_netmem() doesn't cover const casting resulting in
trying to cast const struct page * to const netmem_ref fails.

To cover the case, change page_to_netmem() to use macro and _Generic.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/netmem.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index c87a604e980b9..ce3765e675d19 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -133,10 +133,9 @@ static inline netmem_ref net_iov_to_netmem(struct netmem_desc *niov)
 	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
 }
 
-static inline netmem_ref page_to_netmem(struct page *page)
-{
-	return (__force netmem_ref)page;
-}
+#define page_to_netmem(p)	(_Generic((p),			\
+	const struct page *:	(__force const netmem_ref)(p),	\
+	struct page *:		(__force netmem_ref)(p)))
 
 static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
 		unsigned int order)
-- 
2.17.1


