Return-Path: <netdev+bounces-172701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3194FA55C19
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EAF3A6046
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C9BDDAB;
	Fri,  7 Mar 2025 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IhjGqL6U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745989454
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308043; cv=none; b=u7WIF/ybCaEYDFGh735LiTvoPI/Wb/m0+6KRhW4oev97qmOTL3QI8c4R8rGzP0Dcgayin47/hIq7sWrvsWdMbZPqTBX84/9F+mjWwqoyu+kCkb3jXs6e5VX047BoKlwK7kQnzWI2+UN6Q7mmX4eoQKHjCc0eVfq23FwXN4yj8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308043; c=relaxed/simple;
	bh=4zuSsUUERQZ9XH2UW70V6n8vrmAslZnhgabwAuZZDgg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uzfwYmSA/ya7bIX86z10QZ8wML7Yd07IgcF0caY+rLe/ADrl6Lr0ADWGh/Ez1uu8jFfkpjk0WlFtkvW+hduZqTIO+m/JB3G+c09TEbMJw5kPc9fAIs+YaCSQA/6RbuGd9kZxwCljFGSKX0VHDwNAPZ2/CbCNjphKJT6I2oOGcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IhjGqL6U; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2feb47c6757so2196302a91.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 16:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741308041; x=1741912841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WzHFLEGlreZuEa57C28rn0nXYZoBE6nT+YTkqlDXLgs=;
        b=IhjGqL6UlPSfhrlf6fTaWhEksAbFzU6rIApgAQNN911sYJ5Tq8TRn69Eh4HzfFG6JQ
         fdz085QQNkoO/fIK7UlXjRIwi6qpMgtxLbTLFsFBrP9FA8qOOc6B/awJ2NKHLxgkyAQL
         iftlZjWG/d16GvMIaYJd90k30zfvLjhZc5SRn1XW/3OqZfe1mOy1ECtNTVf2evRtomlb
         R+kEg6dJXAGrpIaW6DuUeBDAU3Y3LPuHqG8Sd0uwI14YRnHNXhb+bTLauivnvGtBB//R
         1aloPM5oMxL4yAXuGgIAtJsZuVGUWUKSxuAjNuZ1LKRF/TEdsEwrWgt6nH9TTFlxEVr+
         B7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741308041; x=1741912841;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzHFLEGlreZuEa57C28rn0nXYZoBE6nT+YTkqlDXLgs=;
        b=YyGlXDoKBJt0f8ZdVhQNGF6HbNhrup4LUM5psd7tNLrM1jGvQ4uh6jjpe3RBBiTdD/
         4/UlkWA8Rs5FfgrvPlcRUl+zSEBZuVCHfuPNCr30CzR2kleqB/qUItfa1PpU9LQGYwdZ
         MxBgryDtO7s+c2gpqtYBWdiHmgiOFV6n9KhrAd27Xk90+z4eZZDRIMI/Kh7+LOgD+ITe
         THKuXKvNUvQdwBYnj6YYxdW/X+d7JAF45xCYoeYx6YL3EbPp4lFdKFqL0mE/7m+c3oDb
         wbIHmKaFCRh1QTAyjb2E5Oig+ayKhuYi3m+ZUFwAxt4GvpkJjyHPDaOCKDKj7R9P7Q63
         LRDg==
X-Gm-Message-State: AOJu0Yy/27452mezd+aR6+8g4JTFDDKoULTSWVIB89VzJP1TpeiTi3Ju
	8dVc681ntEg8X4hQfL64WEKhT0TGQf55iQKDxlzPPyjeFIxEDZ6VoL7s3Sy5gB9iFyaxLbqyktT
	3UsJ+6qvy5/5ZyyXq6rHhzqjc+b8XN4+FEZJOp1hqoep/aSz18B4Yi71aF1hgPqLYZJ/TEqW5Id
	zEPTmln9ElRj/zXfBlfjiqMDPUrdfwSHLd+PWFKGrKZuJkMHxBBWnq0h0sjbw=
X-Google-Smtp-Source: AGHT+IFjChsg8yoBFuWkq2ap+0QJibh5WB1FJmaACH3X+wlU6TnGAPchFEbPc7uluS9gcFVC8HQZXTstB8NO548Aog==
X-Received: from pjbsv15.prod.google.com ([2002:a17:90b:538f:b0:2fc:11a0:c549])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b11:b0:2fe:955d:cdb1 with SMTP id 98e67ed59e1d1-2ff7cef99b6mr1767094a91.23.1741308040737;
 Thu, 06 Mar 2025 16:40:40 -0800 (PST)
Date: Fri,  7 Mar 2025 00:39:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307003905.601175-1-hramamurthy@google.com>
Subject: [PATCH net-next] gve: convert to use netmem for DQO RDA mode
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	pkaligineedi@google.com, shailend@google.com, willemb@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, linux-kernel@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"

To add netmem support to the gve driver, add a union
to the struct gve_rx_slot_page_info. netmem_ref is used for
DQO queue format's raw DMA addressing(RDA) mode. The struct
page is retained for other usecases.

Then, switch to using relevant netmem helper functions for
page pool and skb frag management.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  8 ++++-
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 27 ++++++++-------
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 34 ++++++++++++++-----
 3 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 216d6e157bef..483c43bab3a9 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -105,7 +105,13 @@ struct gve_rx_desc_queue {
 
 /* The page info for a single slot in the RX data queue */
 struct gve_rx_slot_page_info {
-	struct page *page;
+	/* netmem is used for DQO RDA mode
+	 * page is used in all other modes
+	 */
+	union {
+		struct page *page;
+		netmem_ref netmem;
+	};
 	void *page_address;
 	u32 page_offset; /* offset to write to in page */
 	unsigned int buf_size;
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 403f0f335ba6..af84cb88f828 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -205,32 +205,33 @@ void gve_free_to_page_pool(struct gve_rx_ring *rx,
 			   struct gve_rx_buf_state_dqo *buf_state,
 			   bool allow_direct)
 {
-	struct page *page = buf_state->page_info.page;
+	netmem_ref netmem = buf_state->page_info.netmem;
 
-	if (!page)
+	if (!netmem)
 		return;
 
-	page_pool_put_full_page(page->pp, page, allow_direct);
-	buf_state->page_info.page = NULL;
+	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, allow_direct);
+	buf_state->page_info.netmem = 0;
 }
 
 static int gve_alloc_from_page_pool(struct gve_rx_ring *rx,
 				    struct gve_rx_buf_state_dqo *buf_state)
 {
 	struct gve_priv *priv = rx->gve;
-	struct page *page;
+	netmem_ref netmem;
 
 	buf_state->page_info.buf_size = priv->data_buffer_size_dqo;
-	page = page_pool_alloc(rx->dqo.page_pool,
-			       &buf_state->page_info.page_offset,
-			       &buf_state->page_info.buf_size, GFP_ATOMIC);
+	netmem = page_pool_alloc_netmem(rx->dqo.page_pool,
+					&buf_state->page_info.page_offset,
+					&buf_state->page_info.buf_size,
+					GFP_ATOMIC);
 
-	if (!page)
+	if (!netmem)
 		return -ENOMEM;
 
-	buf_state->page_info.page = page;
-	buf_state->page_info.page_address = page_address(page);
-	buf_state->addr = page_pool_get_dma_addr(page);
+	buf_state->page_info.netmem = netmem;
+	buf_state->page_info.page_address = netmem_address(netmem);
+	buf_state->addr = page_pool_get_dma_addr_netmem(netmem);
 
 	return 0;
 }
@@ -269,7 +270,7 @@ void gve_reuse_buffer(struct gve_rx_ring *rx,
 		      struct gve_rx_buf_state_dqo *buf_state)
 {
 	if (rx->dqo.page_pool) {
-		buf_state->page_info.page = NULL;
+		buf_state->page_info.netmem = 0;
 		gve_free_buf_state(rx, buf_state);
 	} else {
 		gve_dec_pagecnt_bias(&buf_state->page_info);
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index f0674a443567..856ade0c209f 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -476,6 +476,24 @@ static int gve_rx_copy_ondemand(struct gve_rx_ring *rx,
 	return 0;
 }
 
+static void gve_skb_add_rx_frag(struct gve_rx_ring *rx,
+				struct gve_rx_buf_state_dqo *buf_state,
+				int num_frags, u16 buf_len)
+{
+	if (rx->dqo.page_pool) {
+		skb_add_rx_frag_netmem(rx->ctx.skb_tail, num_frags,
+				       buf_state->page_info.netmem,
+				       buf_state->page_info.page_offset,
+				       buf_len,
+				       buf_state->page_info.buf_size);
+	} else {
+		skb_add_rx_frag(rx->ctx.skb_tail, num_frags,
+				buf_state->page_info.page,
+				buf_state->page_info.page_offset,
+				buf_len, buf_state->page_info.buf_size);
+	}
+}
+
 /* Chains multi skbs for single rx packet.
  * Returns 0 if buffer is appended, -1 otherwise.
  */
@@ -513,10 +531,7 @@ static int gve_rx_append_frags(struct napi_struct *napi,
 	if (gve_rx_should_trigger_copy_ondemand(rx))
 		return gve_rx_copy_ondemand(rx, buf_state, buf_len);
 
-	skb_add_rx_frag(rx->ctx.skb_tail, num_frags,
-			buf_state->page_info.page,
-			buf_state->page_info.page_offset,
-			buf_len, buf_state->page_info.buf_size);
+	gve_skb_add_rx_frag(rx, buf_state, num_frags, buf_len);
 	gve_reuse_buffer(rx, buf_state);
 	return 0;
 }
@@ -561,7 +576,12 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	/* Page might have not been used for awhile and was likely last written
 	 * by a different thread.
 	 */
-	prefetch(buf_state->page_info.page);
+	if (rx->dqo.page_pool) {
+		if (!netmem_is_net_iov(buf_state->page_info.netmem))
+			prefetch(netmem_to_page(buf_state->page_info.netmem));
+	} else {
+		prefetch(buf_state->page_info.page);
+	}
 
 	/* Copy the header into the skb in the case of header split */
 	if (hsplit) {
@@ -632,9 +652,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	if (rx->dqo.page_pool)
 		skb_mark_for_recycle(rx->ctx.skb_head);
 
-	skb_add_rx_frag(rx->ctx.skb_head, 0, buf_state->page_info.page,
-			buf_state->page_info.page_offset, buf_len,
-			buf_state->page_info.buf_size);
+	gve_skb_add_rx_frag(rx, buf_state, 0, buf_len);
 	gve_reuse_buffer(rx, buf_state);
 	return 0;
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


