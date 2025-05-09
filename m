Return-Path: <netdev+bounces-189207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A1AB1293
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B38EA02217
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336A3291178;
	Fri,  9 May 2025 11:51:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992F428F930;
	Fri,  9 May 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791505; cv=none; b=ematUwLqL1XLLl5OjUXv24TTf2O5a6ygiuMEltAxHBfhPB46UJg0IHQSRpigHrNwKqvqIDgn1q9pZnEI358W7kUowZYooy5LZVt/HG1hL582VOAIZY2KN35pdFAanKVbRGEDrQOgwz1KOPA/OgSwUeIj5qGuRHCQpQwx82Wbfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791505; c=relaxed/simple;
	bh=MaWnivG0bkyZnL3UV4hhAq5uTzeVjyZQ1dynQ9IhHto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tQLkh3SXarXC9+J9pWS7TqVkzVV9DAt4MsaV4FA07xiiPieX1bSewccx8xMd6j7VIYuZ7mf89bmiOzuxE5pQ6nvLvrL1stwnC9NGZ/tudLwJDZVUm0BkSzfQVT1g3kv6xpi/C6lwXQNbLqQ0JBzGHPdQEgiYFq2KhlUWnySqHBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-32-681dec49c7b9
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
Subject: [RFC 02/19] netmem: introduce netmem alloc/put API to wrap page alloc/put API
Date: Fri,  9 May 2025 20:51:09 +0900
Message-Id: <20250509115126.63190-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnka7nG9kMg5W/uSzmrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgylnxqZC2YxFUxa9cP1gbGbRxdjJwcEgImEpc7+lm7GDnA7L8rA0DCbALqEjdu/GQG
	sUUEDCU+PzrO0sXIxcEssJBZ4srin+wgCWGBMIkty6YygtgsAqoS/aeesoHYvAKmEkeunGaD
	mC8vsXrDAWaQ+ZwCZhL9H9VBwkJAJcumLGADmSkh0MwucXvbOkaIekmJgytusExg5F3AyLCK
	USgzryw3MTPHRC+jMi+zQi85P3cTIzAGltX+id7B+OlC8CFGAQ5GJR5ei+eyGUKsiWXFlbmH
	GCU4mJVEeJ93ymQI8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi
	4JRqYFSP/Ly26jtTRF/ejLwtfvH2m93tRR7a3PsS9fdVUOauFxdLbTlvBq7zeD7hWbZ5+Yzq
	2om+9p+vnQzKEg9LT8hzXS6nEujSdMZAyPWVNM+a/+9t7P/LnZecrP1xU/WGlCg+448mV3c9
	vbJbWG3z3hq3y8mPv4W6rZ6jVpp2wsdLUr28Zw+bqBJLcUaioRZzUXEiAOuMkL99AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXC5WfdrOv5RjbD4MgNRos569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK2PJp0bWgklcFbN2/WBtYNzG0cXIwSEhYCLxd2VAFyMnB5uAusSN
	Gz+ZQWwRAUOJz4+Os3QxcnEwCyxklriy+Cc7SEJYIExiy7KpjCA2i4CqRP+pp2wgNq+AqcSR
	K6fBbAkBeYnVGw4wg8znFDCT6P+oDhIWAipZNmUB2wRGrgWMDKsYRTLzynITM3NM9YqzMyrz
	Miv0kvNzNzECA3pZ7Z+JOxi/XHY/xCjAwajEw2vxXDZDiDWxrLgy9xCjBAezkgjv806ZDCHe
	lMTKqtSi/Pii0pzU4kOM0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGubUxFo9ePvLO
	K3HPCbuaWNCZpntlugdbiJwqw88jJvw+VRvNtGX2Si3yMNkqWHhhz+x30apTOb8+27tnM7fS
	BTOnulbWqy6+vpZ1wosuhMcny3rH82u4sJ9jspu27kPEV9ktdfUKQfPbz0a/7ZjQInzq4Yue
	kumvFeQXfMy/PfdKpbyawRclluKMREMt5qLiRADMbW5KZAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool code
should use netmem descriptor and API instead.

As part of the work, introduce netmem alloc/put API allowing the code to
use them rather than struct page things.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/netmem.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 45c209d6cc689..c87a604e980b9 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -138,6 +138,24 @@ static inline netmem_ref page_to_netmem(struct page *page)
 	return (__force netmem_ref)page;
 }
 
+static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
+		unsigned int order)
+{
+	return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
+}
+
+static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
+		unsigned long nr_netmems, netmem_ref *netmem_array)
+{
+	return alloc_pages_bulk_node(gfp, nid, nr_netmems,
+			(struct page **)netmem_array);
+}
+
+static inline void put_netmem(netmem_ref netmem)
+{
+	put_page(netmem_to_page(netmem));
+}
+
 /**
  * virt_to_netmem - convert virtual memory pointer to a netmem reference
  * @data: host memory pointer to convert
-- 
2.17.1


