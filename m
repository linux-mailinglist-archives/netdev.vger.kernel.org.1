Return-Path: <netdev+bounces-117029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5523394C669
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 23:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51411F21A7F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 21:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8B015820F;
	Thu,  8 Aug 2024 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Qgw/wre"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422602A1DF
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723153524; cv=none; b=cSJwvcnYaiiiKQKA7Ps4O7btaa3XrmfWm7Ma2fP4d3PlJFHdeuApSAh2T2cnrQaZyXxKkaCB70DwDY2oa96iB14PVZpKF+LgTR0NzlTWqFWTlYye3uibQQVoo+9ZOjm/yaeIrfCq6w8lr6rJrs+dMSDCdcmaUjr1zIw6oUslsR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723153524; c=relaxed/simple;
	bh=69cziFFAZjQ/eDktjxM5mM+/jpzNLZpyXq1ik0zmeys=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VT7nHvOJnWOe8FDv+yidlZw/bAWoftqs4GIeMxAYukdXANqdrQbTG6Dr5lJFJ1r0Go5cAOSmq1RVhDQ7RHO8IQu83FQlrU8CzvAbdiPdjF7aMZsLKYWDByVMtd+QQMwYlaBTs4m5/Z5iHIIMQMFWEQl5EuUlVajoH0XEuzoSaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Qgw/wre; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-699c81a261eso31190437b3.2
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723153522; x=1723758322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xcPPvcPRwxXVxdlXqs3yv30ISGaFacQoI1PGRx6DtEw=;
        b=0Qgw/wreMFnRyx9nlyyHMlNGJqYJMEMRPxiW03+qFkUw6U8USqgy+mfqM6BT1z0F82
         KvXFMYSq/aFYBF3ecRWmKHgA5zoCZDRsV+j9NFL2dlgcpZoRusKWed9vRxunQWTWEx6a
         jzSfza2ZJT0OZiZDQKiKa8hKa1CZbDRmRNoT61sKLxsrEPW9NP0EfU86J4fPI6ikUmqJ
         Utlbq+VaTNd0+KOwQVVeqnrQXnt9KrX4jh7SYcK0zZDLKWmLVa7GGD6mclqT08nLFWMI
         Fwxj5iTXV4CKEStjFv7uxLqYUJuzbf/dvhbAle9aOzfiRiOalfu00tHWjjmoBPG6EQwl
         uXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723153522; x=1723758322;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcPPvcPRwxXVxdlXqs3yv30ISGaFacQoI1PGRx6DtEw=;
        b=JxTbVLi/+tWPCeEJR2fzVKhj6syZMbTTaoE/pbOVyGTqdqR0JRtsAle3r5n/WZLpcF
         Q96rNPDhbB2NWA+LJcnzCRHtN866KbDfD5gzU8wnmHGf6SN0Ezr/ExMJasgp0uxlsvUW
         mgMLHAoU4DBFbPhCS4OsHDkLQLpL4iUZsu2wrRLdjcOsSpkvrSAMHSyFKhFD2EoLJyrR
         rbfTMHKLnf7/I9+6I+AwVQ0nlaqMOngditKuD6ywSsQcqqQCtXDsF9u0pQqrORHpdwzG
         CtdqDQJV4zK1YiVCh/HeG+wDfv8yO5eRWzcuIgAgt3wFVjrp0C2CeAowtu9cz8DNSNcs
         BVqg==
X-Gm-Message-State: AOJu0YybNevERUFlwcNIa54IcjWxcJk6vvOTOtj8mRQONuUVeKrh2gMw
	eQK+fSm9h696WW4qzk7yIs2KSHlIvTjANeT5/t58ztw0zY+awX6LtSfxin18MmFbglwN1s00yuO
	4fdOQCQI4oQurgRvMgdG5KPC7ruUwK9pff4ywfDy5Wilb6t6RYwdG3foRn7Uxe/LgK/lOlec1XS
	BdW84XCTBwSpmYyiWLfTAqg2QRB3jETfoHQfjAN5p001HZwkSZ47COaZwNPZ0=
X-Google-Smtp-Source: AGHT+IHjq3IWl8119yLZ1MLHMgj3sC96WrT2g2xXdZ8R7JZd3eIR92qX4u49H3OhyifuuXgN+Z/IrbZtAjSh76ix7A==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:840b:0:b0:e05:ec8f:b497 with SMTP
 id 3f1490d57ef6-e0e9db1383bmr18971276.4.1723153521565; Thu, 08 Aug 2024
 14:45:21 -0700 (PDT)
Date: Thu,  8 Aug 2024 21:45:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240808214520.2648194-1-almasrymina@google.com>
Subject: [PATCH net-next v2] page_pool: unexport set dma_addr helper
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

This helper doesn't need to be exported. Move it to page_pool_priv.h

Moving the implementation to the .c file allows us to hide netmem
implementation details in internal header files rather than the public
file.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2: https://patchwork.kernel.org/project/netdevbpf/patch/20240805212536.2172174-6-almasrymina@google.com/
- Move get back to the public header. (Jakub)
- Move set to the internal header page_pool_priv.h (Jakub)

---
 include/net/page_pool/helpers.h | 23 -----------------------
 net/core/page_pool.c            | 17 +++++++++++++++++
 net/core/page_pool_priv.h       |  6 ++++++
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 2b43a893c619d..375656baa2d45 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -423,24 +423,6 @@ static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 	return page_pool_get_dma_addr_netmem(page_to_netmem((struct page *)page));
 }
 
-static inline bool page_pool_set_dma_addr_netmem(netmem_ref netmem,
-						 dma_addr_t addr)
-{
-	struct page *page = netmem_to_page(netmem);
-
-	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
-		page->dma_addr = addr >> PAGE_SHIFT;
-
-		/* We assume page alignment to shave off bottom bits,
-		 * if this "compression" doesn't work we need to drop.
-		 */
-		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
-	}
-
-	page->dma_addr = addr;
-	return false;
-}
-
 /**
  * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
  * @pool: &page_pool the @page belongs to
@@ -463,11 +445,6 @@ static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
 				      page_pool_get_dma_dir(pool));
 }
 
-static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
-{
-	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
-}
-
 static inline bool page_pool_put(struct page_pool *pool)
 {
 	return refcount_dec_and_test(&pool->user_cnt);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2abe6e919224d..d689a20780f40 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1099,3 +1099,20 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
+
+bool page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr)
+{
+	struct page *page = netmem_to_page(netmem);
+
+	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
+		page->dma_addr = addr >> PAGE_SHIFT;
+
+		/* We assume page alignment to shave off bottom bits,
+		 * if this "compression" doesn't work we need to drop.
+		 */
+		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
+	}
+
+	page->dma_addr = addr;
+	return false;
+}
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 90665d40f1eb7..4fbc69ace7d21 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -8,5 +8,11 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict);
 int page_pool_list(struct page_pool *pool);
 void page_pool_detached(struct page_pool *pool);
 void page_pool_unlist(struct page_pool *pool);
+bool page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr);
+
+static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
+{
+	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
+}
 
 #endif
-- 
2.46.0.76.ge559c4bf1a-goog


