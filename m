Return-Path: <netdev+bounces-131691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C82998F445
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1C01F21A4F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4651A265D;
	Thu,  3 Oct 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eILUGNzc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97D1A7076
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973071; cv=none; b=EsnWkTOCgTWdLrAci7f5zWpXS/dfFwXEAFTYCoYFyr7FaFPSEW24yUmqae4SIR+o4TcpBZgxXz1bd/IRT/DEaVE0b3r2pkaWxQOK8YSupvNhxaSOi5OovI4hPYS3n/YZDLK+N2rP9D5YZbNbDJwY5EAZUj0HNYWcz8YXGfDy+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973071; c=relaxed/simple;
	bh=a3sM6giAH4BkPDNHG2rr/J8GVckgvt/hhaY60Dz/tEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zl8dairCXqlEgv8FXShdM1RvR3kloLptAoxX4d4YP26736W1AJN1FOTvdE8eIhQAQhIeasGYCBTI/iYrBxrHcxeyMr13j305IzO6+Ae7zhD1RuzK90Co2cKHpEwlgZFhZll7djob0QW2PELfCXyb0vuc04R9MdGxXyO8EYh+7e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eILUGNzc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d9e31e66eeso19930807b3.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 09:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727973068; x=1728577868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bTf98rb29IGL6ZCbR8KZYUks2P9r1Y9cRU0jNEs2oBw=;
        b=eILUGNzc200l9NZvTe0k88Jm8CKPgIgpV1MxhqFGae2Ti/fqNKwi9Vc6mv47fNrrWd
         isifV5ni54pzbDgWGfcdyfmNxFwYaXQ/b42M950JuQQYcl/v2pWuMaZYWXoKckK+bbT4
         udTtbil3PSBIYDmyGjA9WYhTv6g/xOHN7UCpSMZYqOr009XO5DaDYo+dOdiqR57V3kOW
         XjHw10GXdTuhyb3uVUzK5HmMDVPCNU1KvrH/4KifTquaJ03OYGEVkUa1t18JctMtJkPb
         OzBPIEnPRcdRDeAHzU6eADeIMWx2kuZ0qPe2fGkqucV0wBAC6nf1pwHxZx/k58KKN7Xk
         cwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727973068; x=1728577868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTf98rb29IGL6ZCbR8KZYUks2P9r1Y9cRU0jNEs2oBw=;
        b=v/MwZL2VR6WS2p4Qi4/Wv/c6E9R4nCcbr9hmqDztQlYwgU8HbSodxGFJgEanTscRZH
         JjPabXl+p65DZClAlwRvrGgkAyhEljBQNdrAY7CtcsV//gzjAnIjemWjVeu/+3Vc6M7M
         6XgnCBSJ/r+NBNELVVZ4VoZijIQizR6yNNTQgsWR1W3ffwb8lk3r8w6bk0poUUI5t4Ht
         SW6zedcphLTtiXrbNH5kmgM7jgRaAATl6aqbPMcKUs/YqMMiXiCPBw18Zo1juBaoA/fL
         tr7LTS4WFCiO3lZV8sf+6hRMGEIqjGVczY1I1z5mK9i0zSz8b8/R2WW/UTFSKB0r/1Qt
         HKJQ==
X-Gm-Message-State: AOJu0YzoCLPdhFKLvtoJjBp3yqNCl48o25yKL3oeh9aoBTqc1a4LoaZg
	ad2EX2qvzRUXTvs2qFJAYug5AV7tsAOD8eRBnNuNSKt0EZozevUGm6Luh1Z7442L3lUV3yhUUNs
	XCl+H63q8NG9ii4LH9Zl6+r+9uG3LZa7oeCDtkxSFfcXeKtWapxzuwnMJN4TXpKkSdyVl4xrKHo
	l5urG78S4iSYcKK+5xieGgL7E3KWWTSBxADKlFZSA4HnEn1SThrckUV3rZkWqLkcxa
X-Google-Smtp-Source: AGHT+IHLEV8OTznfDB7R/mCWG/uHFtua9tXX6DaTN5NkjwUJJn7CiHW3NtA8TNpzbKiE2ZHsMjuZrAL039Tkb+jimt4=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:db19:ea7:7d31:e0ea])
 (user=pkaligineedi job=sendgmr) by 2002:a05:690c:4c13:b0:62f:1f63:ae4f with
 SMTP id 00721157ae682-6e2a2adca3dmr1858947b3.1.1727973067736; Thu, 03 Oct
 2024 09:31:07 -0700 (PDT)
Date: Thu,  3 Oct 2024 09:30:42 -0700
In-Reply-To: <20241003163042.194168-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003163042.194168-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241003163042.194168-3-pkaligineedi@google.com>
Subject: [PATCH net-next v2 2/2] gve: adopt page pool for DQ RDA mode
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	shannon.nelson@amd.com, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Harshitha Ramamurthy <hramamurthy@google.com>

For DQ queue format in raw DMA addressing(RDA) mode,
implement page pool recycling of buffers by leveraging
a few helper functions. Also add a stat per ring to track
page pool allocation failures.

DQ QPL mode will continue to use the exisiting recycling
logic. This is because in QPL mode, the pages come from a
constant set of pages that the driver pre-allocates and
registers with the device.

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---

Changes in v2:
-Set allow_direct parameter to true in napi context and false
in others (Shannon Nelson)
-Set the napi pointer in page pool params (Jakub Kicinski)
-Track page pool alloc failures per ring (Jakub Kicinski)
-Don't exceed 80 char limit (Jakub Kicinski)

---
 drivers/net/ethernet/google/Kconfig           |   1 +
 drivers/net/ethernet/google/gve/gve.h         |  23 ++-
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 184 +++++++++++++-----
 drivers/net/ethernet/google/gve/gve_ethtool.c |  14 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  89 +++++----
 5 files changed, 211 insertions(+), 100 deletions(-)

diff --git a/drivers/net/ethernet/google/Kconfig b/drivers/net/ethernet/google/Kconfig
index 8641a00f8e63..564862a57124 100644
--- a/drivers/net/ethernet/google/Kconfig
+++ b/drivers/net/ethernet/google/Kconfig
@@ -18,6 +18,7 @@ if NET_VENDOR_GOOGLE
 config GVE
 	tristate "Google Virtual NIC (gVNIC) support"
 	depends on (PCI_MSI && (X86 || CPU_LITTLE_ENDIAN))
+	select PAGE_POOL
 	help
 	  This driver supports Google Virtual NIC (gVNIC)"
 
diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index bd684c7d996a..bd6fc3a541cd 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -13,6 +13,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/u64_stats_sync.h>
+#include <net/page_pool/helpers.h>
 #include <net/xdp.h>
 
 #include "gve_desc.h"
@@ -60,6 +61,8 @@
 
 #define GVE_DEFAULT_RX_BUFFER_OFFSET 2048
 
+#define GVE_PAGE_POOL_SIZE_MULTIPLIER 4
+
 #define GVE_FLOW_RULES_CACHE_SIZE \
 	(GVE_ADMINQ_BUFFER_SIZE / sizeof(struct gve_adminq_queried_flow_rule))
 #define GVE_FLOW_RULE_IDS_CACHE_SIZE \
@@ -102,6 +105,7 @@ struct gve_rx_slot_page_info {
 	struct page *page;
 	void *page_address;
 	u32 page_offset; /* offset to write to in page */
+	unsigned int buf_size;
 	int pagecnt_bias; /* expected pagecnt if only the driver has a ref */
 	u16 pad; /* adjustment for rx padding */
 	u8 can_flip; /* tracks if the networking stack is using the page */
@@ -273,6 +277,8 @@ struct gve_rx_ring {
 
 			/* Address info of the buffers for header-split */
 			struct gve_header_buf hdr_bufs;
+
+			struct page_pool *page_pool;
 		} dqo;
 	};
 
@@ -294,6 +300,7 @@ struct gve_rx_ring {
 	u64 rx_frag_flip_cnt; /* free-running count of rx segments where page_flip was used */
 	u64 rx_frag_copy_cnt; /* free-running count of rx segments copied */
 	u64 rx_frag_alloc_cnt; /* free-running count of rx page allocations */
+	u64 rx_pp_alloc_fail; /* free-running cnt of rx page pool alloc fails*/
 	u64 xdp_tx_errors;
 	u64 xdp_redirect_errors;
 	u64 xdp_alloc_fails;
@@ -1176,10 +1183,22 @@ struct gve_rx_buf_state_dqo *gve_dequeue_buf_state(struct gve_rx_ring *rx,
 void gve_enqueue_buf_state(struct gve_rx_ring *rx, struct gve_index_list *list,
 			   struct gve_rx_buf_state_dqo *buf_state);
 struct gve_rx_buf_state_dqo *gve_get_recycled_buf_state(struct gve_rx_ring *rx);
-int gve_alloc_page_dqo(struct gve_rx_ring *rx,
-		       struct gve_rx_buf_state_dqo *buf_state);
 void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
 			 struct gve_rx_buf_state_dqo *buf_state);
+void gve_free_to_page_pool(struct gve_rx_ring *rx,
+			   struct gve_rx_buf_state_dqo *buf_state,
+			   bool allow_direct);
+int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
+			   struct gve_rx_buf_state_dqo *buf_state);
+void gve_free_qpl_page_dqo(struct gve_rx_buf_state_dqo *buf_state);
+void gve_reuse_buffer(struct gve_rx_ring *rx,
+		      struct gve_rx_buf_state_dqo *buf_state);
+void gve_free_buffer(struct gve_rx_ring *rx,
+		     struct gve_rx_buf_state_dqo *buf_state);
+int gve_alloc_buffer(struct gve_rx_ring *rx, struct gve_rx_desc_dqo *desc);
+struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
+					  struct gve_rx_ring *rx);
+
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
 int gve_reset(struct gve_priv *priv, bool attempt_teardown);
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 8e50f0e4bb2e..69ffd89e6995 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -12,16 +12,6 @@ int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
 	return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
 }
 
-void gve_free_page_dqo(struct gve_priv *priv, struct gve_rx_buf_state_dqo *bs,
-		       bool free_page)
-{
-	page_ref_sub(bs->page_info.page, bs->page_info.pagecnt_bias - 1);
-	if (free_page)
-		gve_free_page(&priv->pdev->dev, bs->page_info.page, bs->addr,
-			      DMA_FROM_DEVICE);
-	bs->page_info.page = NULL;
-}
-
 struct gve_rx_buf_state_dqo *gve_alloc_buf_state(struct gve_rx_ring *rx)
 {
 	struct gve_rx_buf_state_dqo *buf_state;
@@ -128,56 +118,28 @@ struct gve_rx_buf_state_dqo *gve_get_recycled_buf_state(struct gve_rx_ring *rx)
 		gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
 	}
 
-	/* For QPL, we cannot allocate any new buffers and must
-	 * wait for the existing ones to be available.
-	 */
-	if (rx->dqo.qpl)
-		return NULL;
-
-	/* If there are no free buf states discard an entry from
-	 * `used_buf_states` so it can be used.
-	 */
-	if (unlikely(rx->dqo.free_buf_states == -1)) {
-		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
-		if (gve_buf_ref_cnt(buf_state) == 0)
-			return buf_state;
-
-		gve_free_page_dqo(rx->gve, buf_state, true);
-		gve_free_buf_state(rx, buf_state);
-	}
-
 	return NULL;
 }
 
-int gve_alloc_page_dqo(struct gve_rx_ring *rx,
-		       struct gve_rx_buf_state_dqo *buf_state)
+int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
+			   struct gve_rx_buf_state_dqo *buf_state)
 {
 	struct gve_priv *priv = rx->gve;
 	u32 idx;
 
-	if (!rx->dqo.qpl) {
-		int err;
-
-		err = gve_alloc_page(priv, &priv->pdev->dev,
-				     &buf_state->page_info.page,
-				     &buf_state->addr,
-				     DMA_FROM_DEVICE, GFP_ATOMIC);
-		if (err)
-			return err;
-	} else {
-		idx = rx->dqo.next_qpl_page_idx;
-		if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
-			net_err_ratelimited("%s: Out of QPL pages\n",
-					    priv->dev->name);
-			return -ENOMEM;
-		}
-		buf_state->page_info.page = rx->dqo.qpl->pages[idx];
-		buf_state->addr = rx->dqo.qpl->page_buses[idx];
-		rx->dqo.next_qpl_page_idx++;
+	idx = rx->dqo.next_qpl_page_idx;
+	if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
+		net_err_ratelimited("%s: Out of QPL pages\n",
+				    priv->dev->name);
+		return -ENOMEM;
 	}
+	buf_state->page_info.page = rx->dqo.qpl->pages[idx];
+	buf_state->addr = rx->dqo.qpl->page_buses[idx];
+	rx->dqo.next_qpl_page_idx++;
 	buf_state->page_info.page_offset = 0;
 	buf_state->page_info.page_address =
 		page_address(buf_state->page_info.page);
+	buf_state->page_info.buf_size = priv->data_buffer_size_dqo;
 	buf_state->last_single_ref_offset = 0;
 
 	/* The page already has 1 ref. */
@@ -187,6 +149,16 @@ int gve_alloc_page_dqo(struct gve_rx_ring *rx,
 	return 0;
 }
 
+void gve_free_qpl_page_dqo(struct gve_rx_buf_state_dqo *buf_state)
+{
+	if (!buf_state->page_info.page)
+		return;
+
+	page_ref_sub(buf_state->page_info.page,
+		     buf_state->page_info.pagecnt_bias - 1);
+	buf_state->page_info.page = NULL;
+}
+
 void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
 			 struct gve_rx_buf_state_dqo *buf_state)
 {
@@ -228,3 +200,117 @@ void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
 	gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
 	rx->dqo.used_buf_states_cnt++;
 }
+
+void gve_free_to_page_pool(struct gve_rx_ring *rx,
+			   struct gve_rx_buf_state_dqo *buf_state,
+			   bool allow_direct)
+{
+	struct page *page = buf_state->page_info.page;
+
+	if (!page)
+		return;
+
+	page_pool_put_page(page->pp, page, buf_state->page_info.buf_size,
+			   allow_direct);
+	buf_state->page_info.page = NULL;
+}
+
+static int gve_alloc_from_page_pool(struct gve_rx_ring *rx,
+				    struct gve_rx_buf_state_dqo *buf_state)
+{
+	struct gve_priv *priv = rx->gve;
+	struct page *page;
+
+	buf_state->page_info.buf_size = priv->data_buffer_size_dqo;
+	page = page_pool_alloc(rx->dqo.page_pool,
+			       &buf_state->page_info.page_offset,
+			       &buf_state->page_info.buf_size, GFP_ATOMIC);
+
+	if (!page) {
+		u64_stats_update_begin(&rx->statss);
+		rx->rx_pp_alloc_fail++;
+		u64_stats_update_end(&rx->statss);
+		return -ENOMEM;
+	}
+
+	buf_state->page_info.page = page;
+	buf_state->page_info.page_address = page_address(page);
+	buf_state->addr = page_pool_get_dma_addr(page);
+
+	return 0;
+}
+
+struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
+					  struct gve_rx_ring *rx)
+{
+	u32 ntfy_id = gve_rx_idx_to_ntfy(priv, rx->q_num);
+	struct page_pool_params pp = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order = 0,
+		.pool_size = GVE_PAGE_POOL_SIZE_MULTIPLIER * priv->rx_desc_cnt,
+		.dev = &priv->pdev->dev,
+		.netdev = priv->dev,
+		.napi = &priv->ntfy_blocks[ntfy_id].napi,
+		.max_len = PAGE_SIZE,
+		.dma_dir = DMA_FROM_DEVICE,
+	};
+
+	return page_pool_create(&pp);
+}
+
+void gve_free_buffer(struct gve_rx_ring *rx,
+		     struct gve_rx_buf_state_dqo *buf_state)
+{
+	if (rx->dqo.page_pool) {
+		gve_free_to_page_pool(rx, buf_state, true);
+		gve_free_buf_state(rx, buf_state);
+	} else {
+		gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states,
+				      buf_state);
+	}
+}
+
+void gve_reuse_buffer(struct gve_rx_ring *rx,
+		      struct gve_rx_buf_state_dqo *buf_state)
+{
+	if (rx->dqo.page_pool) {
+		buf_state->page_info.page = NULL;
+		gve_free_buf_state(rx, buf_state);
+	} else {
+		gve_dec_pagecnt_bias(&buf_state->page_info);
+		gve_try_recycle_buf(rx->gve, rx, buf_state);
+	}
+}
+
+int gve_alloc_buffer(struct gve_rx_ring *rx, struct gve_rx_desc_dqo *desc)
+{
+	struct gve_rx_buf_state_dqo *buf_state;
+
+	if (rx->dqo.page_pool) {
+		buf_state = gve_alloc_buf_state(rx);
+		if (WARN_ON_ONCE(!buf_state))
+			return -ENOMEM;
+
+		if (gve_alloc_from_page_pool(rx, buf_state))
+			goto free_buf_state;
+	} else {
+		buf_state = gve_get_recycled_buf_state(rx);
+		if (unlikely(!buf_state)) {
+			buf_state = gve_alloc_buf_state(rx);
+			if (unlikely(!buf_state))
+				return -ENOMEM;
+
+			if (unlikely(gve_alloc_qpl_page_dqo(rx, buf_state)))
+				goto free_buf_state;
+		}
+	}
+	desc->buf_id = cpu_to_le16(buf_state - rx->dqo.buf_states);
+	desc->buf_addr = cpu_to_le64(buf_state->addr +
+				     buf_state->page_info.page_offset);
+
+	return 0;
+
+free_buf_state:
+	gve_free_buf_state(rx, buf_state);
+	return -ENOMEM;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index bdfc6e77b2af..21e3ace48baa 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -52,12 +52,13 @@ static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
 	"rx_posted_desc[%u]", "rx_completed_desc[%u]", "rx_consumed_desc[%u]",
 	"rx_bytes[%u]", "rx_hsplit_bytes[%u]", "rx_cont_packet_cnt[%u]",
 	"rx_frag_flip_cnt[%u]", "rx_frag_copy_cnt[%u]", "rx_frag_alloc_cnt[%u]",
-	"rx_dropped_pkt[%u]", "rx_copybreak_pkt[%u]", "rx_copied_pkt[%u]",
-	"rx_queue_drop_cnt[%u]", "rx_no_buffers_posted[%u]",
-	"rx_drops_packet_over_mru[%u]", "rx_drops_invalid_checksum[%u]",
-	"rx_xdp_aborted[%u]", "rx_xdp_drop[%u]", "rx_xdp_pass[%u]",
-	"rx_xdp_tx[%u]", "rx_xdp_redirect[%u]",
-	"rx_xdp_tx_errors[%u]", "rx_xdp_redirect_errors[%u]", "rx_xdp_alloc_fails[%u]",
+	"rx_pp_alloc_fail[%u]", "rx_dropped_pkt[%u]", "rx_copybreak_pkt[%u]",
+	"rx_copied_pkt[%u]", "rx_queue_drop_cnt[%u]",
+	"rx_no_buffers_posted[%u]", "rx_drops_packet_over_mru[%u]",
+	"rx_drops_invalid_checksum[%u]", "rx_xdp_aborted[%u]",
+	"rx_xdp_drop[%u]", "rx_xdp_pass[%u]", "rx_xdp_tx[%u]",
+	"rx_xdp_redirect[%u]", "rx_xdp_tx_errors[%u]",
+	"rx_xdp_redirect_errors[%u]", "rx_xdp_alloc_fails[%u]",
 };
 
 static const char gve_gstrings_tx_stats[][ETH_GSTRING_LEN] = {
@@ -319,6 +320,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			data[i++] = rx->rx_frag_flip_cnt;
 			data[i++] = rx->rx_frag_copy_cnt;
 			data[i++] = rx->rx_frag_alloc_cnt;
+			data[i++] = rx->rx_pp_alloc_fail;
 			/* rx dropped packets */
 			data[i++] = tmp_rx_skb_alloc_fail +
 				tmp_rx_buf_alloc_fail +
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index b343be2fb118..8ac0047f1ada 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -95,8 +95,10 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
 		for (i = 0; i < rx->dqo.num_buf_states; i++) {
 			struct gve_rx_buf_state_dqo *bs = &rx->dqo.buf_states[i];
 
-			if (bs->page_info.page)
-				gve_free_page_dqo(priv, bs, !rx->dqo.qpl);
+			if (rx->dqo.page_pool)
+				gve_free_to_page_pool(rx, bs, false);
+			else
+				gve_free_qpl_page_dqo(bs);
 		}
 	}
 
@@ -138,9 +140,11 @@ void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 
 	for (i = 0; i < rx->dqo.num_buf_states; i++) {
 		struct gve_rx_buf_state_dqo *bs = &rx->dqo.buf_states[i];
-		/* Only free page for RDA. QPL pages are freed in gve_main. */
-		if (bs->page_info.page)
-			gve_free_page_dqo(priv, bs, !rx->dqo.qpl);
+
+		if (rx->dqo.page_pool)
+			gve_free_to_page_pool(rx, bs, false);
+		else
+			gve_free_qpl_page_dqo(bs);
 	}
 
 	if (rx->dqo.qpl) {
@@ -167,6 +171,11 @@ void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 	kvfree(rx->dqo.buf_states);
 	rx->dqo.buf_states = NULL;
 
+	if (rx->dqo.page_pool) {
+		page_pool_destroy(rx->dqo.page_pool);
+		rx->dqo.page_pool = NULL;
+	}
+
 	gve_rx_free_hdr_bufs(priv, rx);
 
 	netif_dbg(priv, drv, priv->dev, "freed rx ring %d\n", idx);
@@ -199,6 +208,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 			  int idx)
 {
 	struct device *hdev = &priv->pdev->dev;
+	struct page_pool *pool;
 	int qpl_page_cnt;
 	size_t size;
 	u32 qpl_id;
@@ -212,8 +222,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 	rx->gve = priv;
 	rx->q_num = idx;
 
-	rx->dqo.num_buf_states = cfg->raw_addressing ?
-		min_t(s16, S16_MAX, buffer_queue_slots * 4) :
+	rx->dqo.num_buf_states = cfg->raw_addressing ? buffer_queue_slots :
 		gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
 	rx->dqo.buf_states = kvcalloc(rx->dqo.num_buf_states,
 				      sizeof(rx->dqo.buf_states[0]),
@@ -241,7 +250,13 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 	if (!rx->dqo.bufq.desc_ring)
 		goto err;
 
-	if (!cfg->raw_addressing) {
+	if (cfg->raw_addressing) {
+		pool = gve_rx_create_page_pool(priv, rx);
+		if (IS_ERR(pool))
+			goto err;
+
+		rx->dqo.page_pool = pool;
+	} else {
 		qpl_id = gve_get_rx_qpl_id(cfg->qcfg_tx, rx->q_num);
 		qpl_page_cnt = gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
 
@@ -338,26 +353,14 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 	num_avail_slots = min_t(u32, num_avail_slots, complq->num_free_slots);
 	while (num_posted < num_avail_slots) {
 		struct gve_rx_desc_dqo *desc = &bufq->desc_ring[bufq->tail];
-		struct gve_rx_buf_state_dqo *buf_state;
-
-		buf_state = gve_get_recycled_buf_state(rx);
-		if (unlikely(!buf_state)) {
-			buf_state = gve_alloc_buf_state(rx);
-			if (unlikely(!buf_state))
-				break;
-
-			if (unlikely(gve_alloc_page_dqo(rx, buf_state))) {
-				u64_stats_update_begin(&rx->statss);
-				rx->rx_buf_alloc_fail++;
-				u64_stats_update_end(&rx->statss);
-				gve_free_buf_state(rx, buf_state);
-				break;
-			}
+
+		if (unlikely(gve_alloc_buffer(rx, desc))) {
+			u64_stats_update_begin(&rx->statss);
+			rx->rx_buf_alloc_fail++;
+			u64_stats_update_end(&rx->statss);
+			break;
 		}
 
-		desc->buf_id = cpu_to_le16(buf_state - rx->dqo.buf_states);
-		desc->buf_addr = cpu_to_le64(buf_state->addr +
-					     buf_state->page_info.page_offset);
 		if (rx->dqo.hdr_bufs.data)
 			desc->header_buf_addr =
 				cpu_to_le64(rx->dqo.hdr_bufs.addr +
@@ -488,6 +491,9 @@ static int gve_rx_append_frags(struct napi_struct *napi,
 		if (!skb)
 			return -1;
 
+		if (rx->dqo.page_pool)
+			skb_mark_for_recycle(skb);
+
 		if (rx->ctx.skb_tail == rx->ctx.skb_head)
 			skb_shinfo(rx->ctx.skb_head)->frag_list = skb;
 		else
@@ -498,7 +504,7 @@ static int gve_rx_append_frags(struct napi_struct *napi,
 	if (rx->ctx.skb_tail != rx->ctx.skb_head) {
 		rx->ctx.skb_head->len += buf_len;
 		rx->ctx.skb_head->data_len += buf_len;
-		rx->ctx.skb_head->truesize += priv->data_buffer_size_dqo;
+		rx->ctx.skb_head->truesize += buf_state->page_info.buf_size;
 	}
 
 	/* Trigger ondemand page allocation if we are running low on buffers */
@@ -508,13 +514,8 @@ static int gve_rx_append_frags(struct napi_struct *napi,
 	skb_add_rx_frag(rx->ctx.skb_tail, num_frags,
 			buf_state->page_info.page,
 			buf_state->page_info.page_offset,
-			buf_len, priv->data_buffer_size_dqo);
-	gve_dec_pagecnt_bias(&buf_state->page_info);
-
-	/* Advances buffer page-offset if page is partially used.
-	 * Marks buffer as used if page is full.
-	 */
-	gve_try_recycle_buf(priv, rx, buf_state);
+			buf_len, buf_state->page_info.buf_size);
+	gve_reuse_buffer(rx, buf_state);
 	return 0;
 }
 
@@ -548,8 +549,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	if (unlikely(compl_desc->rx_error)) {
-		gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states,
-				      buf_state);
+		gve_free_buffer(rx, buf_state);
 		return -EINVAL;
 	}
 
@@ -573,6 +573,9 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 			if (unlikely(!rx->ctx.skb_head))
 				goto error;
 			rx->ctx.skb_tail = rx->ctx.skb_head;
+
+			if (rx->dqo.page_pool)
+				skb_mark_for_recycle(rx->ctx.skb_head);
 		} else {
 			unsplit = 1;
 		}
@@ -609,8 +612,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		rx->rx_copybreak_pkt++;
 		u64_stats_update_end(&rx->statss);
 
-		gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states,
-				      buf_state);
+		gve_free_buffer(rx, buf_state);
 		return 0;
 	}
 
@@ -625,16 +627,17 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		return 0;
 	}
 
+	if (rx->dqo.page_pool)
+		skb_mark_for_recycle(rx->ctx.skb_head);
+
 	skb_add_rx_frag(rx->ctx.skb_head, 0, buf_state->page_info.page,
 			buf_state->page_info.page_offset, buf_len,
-			priv->data_buffer_size_dqo);
-	gve_dec_pagecnt_bias(&buf_state->page_info);
-
-	gve_try_recycle_buf(priv, rx, buf_state);
+			buf_state->page_info.buf_size);
+	gve_reuse_buffer(rx, buf_state);
 	return 0;
 
 error:
-	gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
+	gve_free_buffer(rx, buf_state);
 	return -ENOMEM;
 }
 
-- 
2.46.1.824.gd892dcdcdd-goog


