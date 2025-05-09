Return-Path: <netdev+bounces-189211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CC2AB1297
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEACC1C22879
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F22918E9;
	Fri,  9 May 2025 11:51:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD48290BA3;
	Fri,  9 May 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791507; cv=none; b=Dpxb6Eav5sTO3i8NQgP2Zpl57yqSrpKCnA/JAMp8wf78Qhfk8wU9AXEYvSg/acg4mEIOv63RL+NMb88Lj0ToKAW7BB9R+wcYerDnEFYm1X3dcOxZIFZqRQ/WYvJIrmgSl+ZYFCvZdI2zBKCYZnVkbUHjDIn+XM9RLM9gpObd1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791507; c=relaxed/simple;
	bh=M9cEjEFmrsQNR82PG/c3T/1k29MAQSnNtwed2DDOtHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JJ8BIJLQ6FhUzD4RwkOPLY7P+98jsHkf4x93DNW58usTSA+VVkFFF3ViQXFOrI4+/XCnaZ3IPckQG8lFNbl4BHjZ9DEwPehOwE2blPVpsQAJxPcvjd4b/G8GnWPTGLJGB034vanLI7upioZvIOE8e0guBTP0bSarVArhgdJOqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-6e-681dec49e29b
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
Subject: [RFC 12/19] netmem: introduce page_pool_recycle_direct_netmem()
Date: Fri,  9 May 2025 20:51:19 +0900
Message-Id: <20250509115126.63190-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnoa7nG9kMgxn79S3mrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgyrv46yl7wj73ixmLFBsaHbF2MnBwSAiYSuw58Z4exZ6/tZgSx2QTUJW7c+MkMYosI
	GEp8fnScpYuRi4NZYCGzxJXFP4EaODiEBTwkNvy3BqlhEVCVWHtpI1g9r4CZxL/OdcwQM+Ul
	Vm84wAxSzgkU7/+oDhIWEjCVWDZlARvISAmB/2wS36b9Z4Kol5Q4uOIGywRG3gWMDKsYhTLz
	ynITM3NM9DIq8zIr9JLzczcxAiNgWe2f6B2Mny4EH2IU4GBU4uG1eC6bIcSaWFZcmXuIUYKD
	WUmE93mnTIYQb0piZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkG
	xlqFd+duFOZr+GxKtC3OPjTV+kd7tvDtCzIxvysnZ0XwZjaqHy/YWyieErNh5bMHIhdNz6ZN
	7Hr3Z/avj/YzTS/+MX33QbbyiNvyJ6ka6sqJk5dMSGTk5mZ+yJB0suuYlrrG60MmTxW0nGRM
	zu9tk1u15/f6hYdK9608t37ujrSzjRMLpv3PKlFiKc5INNRiLipOBABInBU4fAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsXC5WfdrOv5RjbDYO5bZYs569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK+Pqr6PsBf/YK24sVmxgfMjWxcjJISFgIjF7bTcjiM0moC5x48ZP
	ZhBbRMBQ4vOj4yxdjFwczAILmSWuLP7J3sXIwSEs4CGx4b81SA2LgKrE2ksbwep5Bcwk/nWu
	Y4aYKS+xesMBZpByTqB4/0d1kLCQgKnEsikL2CYwci1gZFjFKJKZV5abmJljqlecnVGZl1mh
	l5yfu4kRGM7Lav9M3MH45bL7IUYBDkYlHl6L57IZQqyJZcWVuYcYJTiYlUR4n3fKZAjxpiRW
	VqUW5ccXleakFh9ilOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUw7r6+07+PoXHHRDXt
	I5HnVJb2iPUYaRs/d9tYEVJz/f6/cxfLe61+n+ywtaqZc7o49mqf3pbQ4IR/Bi8tv7/a4GHX
	2Gzbv27T5Pq/ma/CPV3Os89TOTkt7bi1V/g/811n1i+8mKh/b+Uvew4HpieLYwW9Z96ztz0y
	d/2hG2msWsdmZzCIbbWvVmIpzkg01GIuKk4EACkoVnBjAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

All the callers to page_pool_recycle_direct() need to be converted to
use netmem descriptor and API instead of struct page things.

As part of the work, introduce page_pool_recycle_direct_netmem()
allowing the callers to use netmem descriptor and API.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/page_pool/helpers.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 582a3d00cbe23..9b7a3a996bbea 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -395,6 +395,12 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
 	page_pool_put_full_page(pool, page, true);
 }
 
+static inline void page_pool_recycle_direct_netmem(struct page_pool *pool,
+						   netmem_ref netmem)
+{
+	page_pool_put_full_netmem(pool, netmem, true);
+}
+
 #define PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA	\
 		(sizeof(dma_addr_t) > sizeof(unsigned long))
 
-- 
2.17.1


