Return-Path: <netdev+bounces-189218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721E7AB12A8
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53851C4260D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A759293B4C;
	Fri,  9 May 2025 11:51:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB602918F1;
	Fri,  9 May 2025 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791511; cv=none; b=MpTmkfpVHNY1b74axei+Yiyo0DvBn3Ldv2JGD/fkXJBtBEqSDr5edcaTNL+Jcvt0OwBgLeZllhGsx6gWkgLOigNblEqaNEzbrZBJjQ4q7jZXwiQsQxyATzTFrf/XHn1QzneQNIprdcfnqPCIj+IGX+0QSHtCHT996uNXrzT4vz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791511; c=relaxed/simple;
	bh=5HbkRADnH0AfURkYRtpP5zV79eZ3YdBexWxwI/8bZw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VqqfAUSSmeqVslFr1c3LD4Zr4+D0qbM5miz+YrRAz47NP0uife7O2BEmVsRO8qVhlGTiF1/E2Yj2Tu0IMc4xfXv6W3h1Nv+cnkaFFcAi/Urla8QLJGnld+HOpfavAstwNkuaQfk72kfxAOdJ5LwYVppXE9ltUxku5uayuLmoATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-98-681dec4a7ecf
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
Subject: [RFC 19/19] mm, netmem: remove the page pool members in struct page
Date: Fri,  9 May 2025 20:51:26 +0900
Message-Id: <20250509115126.63190-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnka7XG9kMg2PX+SzmrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgydh+7xl4wW6ni0dd+9gbG2dJdjJwcEgImEu2nD7LA2Fu2vgCz2QTUJW7c+MkMYosI
	GEp8fnQcKM7FwSywkFniyuKf7CAJYQEfidZrd4CKODhYBFQldjdEgIR5Bcwkth7ZxQoxU15i
	9YYDYCWcQPH+j+ogYSEBU4llUxawgYyUEPjPJtH/5zMjRL2kxMEVN1gmMPIuYGRYxSiUmVeW
	m5iZY6KXUZmXWaGXnJ+7iREYA8tq/0TvYPx0IfgQowAHoxIPr8Vz2Qwh1sSy4srcQ4wSHMxK
	IrzPO2UyhHhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTB6
	lPLrf9nrr5vIZdsyx10m80rK37Tfu2dtUZza3LfQ+UjHRsfkqom8E3bYXbiTIb0mt2HXzbOK
	bm2mPQk7rvP/7i09XP/yu3qej/zkK+LOzK93s9vuOW4Zmru5v4nvIC/3xvBWgzqNhiPcUp6H
	94bw8guu59dcV3xpe1fIjCcrA7dIr19fu1KJpTgj0VCLuag4EQBHz4cXfQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXC5WfdrOv1RjbD4OhNJos569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK2P3sWvsBbOVKh597WdvYJwt3cXIySEhYCKxZesLFhCbTUBd4saN
	n8wgtoiAocTnR8eB4lwczAILmSWuLP7JDpIQFvCRaL12B6iIg4NFQFVid0MESJhXwExi65Fd
	rBAz5SVWbzgAVsIJFO//qA4SFhIwlVg2ZQHbBEauBYwMqxhFMvPKchMzc0z1irMzKvMyK/SS
	83M3MQIDelntn4k7GL9cdj/EKMDBqMTDa/FcNkOINbGsuDL3EKMEB7OSCO/zTpkMId6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBkaWQ4KSvseWGcZPqJp5
	WuZr8on9agrFqTKPix26MrzU9+kvX9C8xmnFriwF0RcC+2JPZbBtK2LYN6NNsaAkQZI70Itp
	1Wa2xnudRZeW3r03+ZvyDIsnIeuyJiXFf+VS7Jq6dMnEfIPpinsYzU48ufT42MeopZ+PVYtc
	CA70eS3D0WxxX2u24E4lluKMREMt5qLiRACPzzROZAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Now that all the users of the page pool members in struct page have been
gone, the members can be removed from struct page.  However, the space
in struct page needs to be kept using a place holder with the same size,
until struct netmem_desc has its own instance, not overlayed onto struct
page, to avoid conficting with other members within struct page.

Remove the page pool members in struct page and replace with a place
holder.  The place holder should be removed once struct netmem_desc has
its own instance.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h  | 13 ++-----------
 include/net/netmem.h      | 35 +----------------------------------
 include/net/netmem_type.h | 22 ++++++++++++++++++++++
 3 files changed, 25 insertions(+), 45 deletions(-)
 create mode 100644 include/net/netmem_type.h

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e76bade9ebb12..69904a0855358 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -20,6 +20,7 @@
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
 #include <linux/types.h>
+#include <net/netmem_type.h> /* for page pool */
 
 #include <asm/mmu.h>
 
@@ -118,17 +119,7 @@ struct page {
 			 */
 			unsigned long private;
 		};
-		struct {	/* page_pool used by netstack */
-			/**
-			 * @pp_magic: magic value to avoid recycling non
-			 * page_pool allocated pages.
-			 */
-			unsigned long pp_magic;
-			struct page_pool *pp;
-			unsigned long _pp_mapping_pad;
-			unsigned long dma_addr;
-			atomic_long_t pp_ref_count;
-		};
+		struct __netmem_desc place_holder_1; /* for page pool */
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
 		};
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 00064e766b889..c414de6c6ab0d 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -10,6 +10,7 @@
 
 #include <linux/mm.h>
 #include <net/net_debug.h>
+#include <net/netmem_type.h>
 
 /* net_iov */
 
@@ -20,15 +21,6 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
  */
 #define NET_IOV 0x01UL
 
-struct netmem_desc {
-	unsigned long __unused_padding;
-	unsigned long pp_magic;
-	struct page_pool *pp;
-	struct net_iov_area *owner;
-	unsigned long dma_addr;
-	atomic_long_t pp_ref_count;
-};
-
 struct net_iov_area {
 	/* Array of net_iovs for this area. */
 	struct netmem_desc *niovs;
@@ -38,31 +30,6 @@ struct net_iov_area {
 	unsigned long base_virtual;
 };
 
-/* These fields in struct page are used by the page_pool and net stack:
- *
- *        struct {
- *                unsigned long pp_magic;
- *                struct page_pool *pp;
- *                unsigned long _pp_mapping_pad;
- *                unsigned long dma_addr;
- *                atomic_long_t pp_ref_count;
- *        };
- *
- * We mirror the page_pool fields here so the page_pool can access these fields
- * without worrying whether the underlying fields belong to a page or net_iov.
- *
- * The non-net stack fields of struct page are private to the mm stack and must
- * never be mirrored to net_iov.
- */
-#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
-	static_assert(offsetof(struct page, pg) == \
-		      offsetof(struct netmem_desc, iov))
-NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
-NET_IOV_ASSERT_OFFSET(pp, pp);
-NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
-NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
-#undef NET_IOV_ASSERT_OFFSET
-
 static inline struct net_iov_area *net_iov_owner(const struct netmem_desc *niov)
 {
 	return niov->owner;
diff --git a/include/net/netmem_type.h b/include/net/netmem_type.h
new file mode 100644
index 0000000000000..6a3ac8e908515
--- /dev/null
+++ b/include/net/netmem_type.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ *	Author:	Byungchul Park <max.byungchul.park@gmail.com>
+ */
+
+#ifndef _NET_NETMEM_TYPE_H
+#define _NET_NETMEM_TYPE_H
+
+#include <linux/stddef.h>
+
+struct netmem_desc {
+	unsigned long __unused_padding;
+	struct_group_tagged(__netmem_desc, actual_data,
+		unsigned long pp_magic;
+		struct page_pool *pp;
+		struct net_iov_area *owner;
+		unsigned long dma_addr;
+		atomic_long_t pp_ref_count;
+	);
+};
+
+#endif /* _NET_NETMEM_TYPE_H */
-- 
2.17.1


