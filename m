Return-Path: <netdev+bounces-212534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC121B2120F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C5D3AD43B
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA3F1A9FB8;
	Mon, 11 Aug 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ody4PjOc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0694C17993
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929713; cv=none; b=BURiLXUHGBCZJlNZ3HOFNV04IWiJrEZoiQvXMhb5InKl7WZunyqQhnpd1h0hrb4bPdYEtZwXttLCCtiX4eMubaQqQgr0LmJAlFAQcUMSzlg+FxYpYrlItSUzNG3WkPaITbk09cwgOD+SJx/x6ISzmWT9XcAx9EhcR+Et6uGr34o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929713; c=relaxed/simple;
	bh=2w6gBTOfjR2f672HZActNWhtvkejKHJZMo6hy17TMIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sD+y6kLjMGpD4do9PQsZU8JZxWAkoMGZzJ4+YCNaaepGvrcScCqx0l9U/iXbdnatIoTW65xkBbp90F3DkstsuLSKhcZyMw3Clbe5rGpunYXioMrzgGhzYNPxyhMid2EI0za04N5EsLXNzDWOJ7Q5+MVNw/ZeqRIuhsugz3f4Kag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ody4PjOc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so23083275e9.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754929710; x=1755534510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AD731Sw+meBwq/XvdLu2tOAp1241NSCxpOJb+qs4wAg=;
        b=Ody4PjOcEp5F6wi9QnMzzynWe0AfaIGuoFQ7zpHiktLDf0s3qtM156ao6Ns6YTNSkQ
         3AaYZeVOl+En1Q8dIVFndfTtt6ctKpvP9DDhEMRSaTpRpTi2jJNq3kvdtm36M0XM4cwl
         XKzmqImVN+0QQyAzZHGotB8s0ci5rppUZpeE9tN2Hbi1sb9xjNZnuy5xdE8dE5f62FJP
         zofpG8U4kezuGTWt5o80gpUrTCf3BumUBV9Flvln38XKP9B36IPpp48O+NJPVwS1IV13
         muUIPQ0I39n+Fzjg25mZSkbE3c/QXkS/bZPXjPfclANOud2LIGyNHl7pTgRg5v/a4VWN
         idDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754929710; x=1755534510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AD731Sw+meBwq/XvdLu2tOAp1241NSCxpOJb+qs4wAg=;
        b=fHNYiQOiLEms9cGoaR51jg8wjbjGgIuVmzM0hoRMDIRbEnKFK3AJvMWSS/oRisqcVM
         VX8+qpNLtz0Urb7J7Xtp5/gL+AQr91qlUexxazkIQYK1JyXFnYi+E76WDAU8/Vi9K+mI
         dRHyMhkOL5c7+tYDGj0EJv4ji4rVM0zZToW8LCFdYuZralHsGcUpb1aoIHqHe9RZn/fq
         oqFlPse0EeSQcz0ddfUJwt7ujeKdnw4epl4D4AItIHfXyJkU9NlpLHWQhoe3qF2xwAkq
         KES7tfnrcGVr+5m7PizSr77lt2eABuF3Zc8evoavK4yq7mIcWAJ/uhrlxzplY3UnbC9T
         mlcA==
X-Gm-Message-State: AOJu0Ywsv1/4FMRDS4edft4WvNIzYcVK5oEpEv35PzzaCczMPaYL18oK
	I6rBUv5aA5SANUR61tG02jVxll4Zdlj5ns3khrEpcYhNM/uWWNo/qwP6FDp3og==
X-Gm-Gg: ASbGncuF1GhLVycQwCMyua/1KpQEbDFZnSqNtr8IGH9xKlRu9ylfKrm0OlBfHMfRk2R
	yTBJR6SntH/p2PAhnbqtAbb6LFBsJs3rqACWE/DHKNxwr+VtGnOzZ0IDmCVzXNp/x2L8QODidGZ
	XW2Eek1/DrMjir8X1aeCSVW8z6nXKIZPmQVBKNwqGVU38D368JcLdylCrIlGh6pF6R5PiE+7uLx
	dXhfRHBvEB7r5HIDGZrsQD/Tj17b0wijHfkU+30C68qWFGhPu28FYSO9nqTIieHtZzjNqidhW7G
	Msi9vE7sdeUjYNr39QLuqIob2+6gg/GAgQAiqa3hz4vLhaMCFb3QGTtWpkzs53WtWjvYtCnlr05
	DC/DQqQ==
X-Google-Smtp-Source: AGHT+IE6SoAeBFsUlTtUlFQORg0K63cyIJAIGDiRdvDfFtXh2qRybZTtSF/2JrE9aOH9Hgf4QmcGKA==
X-Received: by 2002:a05:600c:4f91:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-45a10bf510dmr3386985e9.19.1754929709752;
        Mon, 11 Aug 2025 09:28:29 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:628b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58554f2sm260267515e9.12.2025.08.11.09.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:28:28 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Byungchul Park <byungchul@sk.com>,
	asml.silence@gmail.com
Subject: [RFC net-next v1 2/6] net: replace __netmem_clear_lsb() with netmem_to_nmdesc()
Date: Mon, 11 Aug 2025 17:29:39 +0100
Message-ID: <a8643abedd208138d3d550db71631d5a2e4168d1.1754929026.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754929026.git.asml.silence@gmail.com>
References: <cover.1754929026.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Byungchul Park <byungchul@sk.com>

Now that we have struct netmem_desc, it'd better access the pp fields
via struct netmem_desc rather than struct net_iov.

Introduce netmem_to_nmdesc() for safely converting netmem_ref to
netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.

While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
used instead.

Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
[pavel: rebased, cleaned up, added comments]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netmem.h   | 37 +++++++++++++++++++------------------
 net/core/netmem_priv.h | 16 ++++++++--------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 8b639e45cfe2..d08797e40a7c 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -282,24 +282,25 @@ static inline struct netmem_desc *__netmem_to_nmdesc(netmem_ref netmem)
 	return (__force struct netmem_desc *)netmem;
 }
 
-/* __netmem_clear_lsb - convert netmem_ref to struct net_iov * for access to
- * common fields.
- * @netmem: netmem reference to extract as net_iov.
+/* netmem_to_nmdesc - convert netmem_ref to struct netmem_desc.
+ * @netmem: netmem reference to get netmem_desc.
  *
- * All the sub types of netmem_ref (page, net_iov) have the same pp, pp_magic,
- * dma_addr, and pp_ref_count fields at the same offsets. Thus, we can access
- * these fields without a type check to make sure that the underlying mem is
- * net_iov or page.
- *
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
+	void *p = (void *)((__force unsigned long)netmem & ~NET_IOV);
+
+	/* Note: can be replaced with netmem_to_net_iov(), but open coded
+	 * NET_IOV masking gives better code generation.
+	 */
+	if (netmem_is_net_iov(netmem)) {
+		struct net_iov *niov = p;
+
+		return &niov->desc;
+	}
+	return __pp_page_to_nmdesc((struct page *)p);
 }
 
 /**
@@ -320,12 +321,12 @@ static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
 
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
@@ -390,7 +391,7 @@ static inline bool netmem_is_pfmemalloc(netmem_ref netmem)
 
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
-- 
2.49.0


