Return-Path: <netdev+bounces-135309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3714199D819
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8C71F23392
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4E1D0490;
	Mon, 14 Oct 2024 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ENGJoP6A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E651D0E18
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937284; cv=none; b=cHaNMPZaJTLOqjBahvaHiwwU3iMP9ApHy7YVx0Q9jagwNjocbTInKFUkGUtoEwATxHobvHuXEYeaE71jjKEblMLR6M9GlXD/DzdldeL4Aukw5n7+f2OLs85XgOCzP53Us3LlXjYzvuxW1SyyO4WI7KNdnjESxShc+6K00CB1wj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937284; c=relaxed/simple;
	bh=jfP1xCD+hUkAq2i7mstIViUlB7XOBw7NEsZLzMxwaqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OUdm70HqdeDq9Rcly+HmTocoAQF5/LA7yHH/nLA1HW5zwwFj724D+zDUK54VV56Y//k2vDhb4ivixQSuTgeFubumk3AV65t0wP10e6D1tyWeOiDlGdc68swQ1zWn/Wh1Clpcqb3KaO5SCgjXIi+Slyx6c3XZFAuc7rixOGpQ1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ENGJoP6A; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fea2adb6so5543100276.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728937281; x=1729542081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHjlFC8/CWaVQIqCn5gdE6v+p5o6pf/NYDeA3ppx5z0=;
        b=ENGJoP6AMflkJUJC39ygGzA9us4nj5yQK8BPFgclrb7yvJQRuo/oWaZE0h/qt9CIQ5
         tG/GZGBatDyyTAwtgzvz0IybfXRx5p6atlojKi/a7en9RnAJZtVxmgPgNONjJuPskW7R
         HX3fnRtBO6pThP69YGbl0DeihYerXr9+87fSWWFZio84oYcpezSiLBahMwzktkHQ8DlY
         3iKfAnsW0YZj3Mus7zNxONnHrTsUeY4dntlm3OXa89T6NF9tTOC8mUovQePuhZyep0MF
         sAkf7iegeZnQtRvdb6a7tXc1Do1QUkKm69M1gsVzPACjyREntemJiA0TKDaxnMPsPlhX
         mwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937281; x=1729542081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHjlFC8/CWaVQIqCn5gdE6v+p5o6pf/NYDeA3ppx5z0=;
        b=TTKIgPi5OdLTU/F4rTHL4XhRf0LKdsjI1xbI9Evz2ViXQaJBqgO6VcM4U/g8RfhvDy
         Bu/HFSDgyKkvMnhdWPi++2l6QHLV4iLFqwpjGWJx3PZx2BMS76r/+gWBYNlXLa2P3DWJ
         eMF6uBk4CQNncpttajTu/M95cimnPPZ3BTrwWJrIlKQ5r4Zm8QR3O31oo4Vf1xFT017f
         6rdjbR98vVO/OvFs3ixSKz1eDGta+h3IMhpk5eA46B1UDUGIwM3tgsKxH53G7Wxygbcd
         +XZVShqgfqUZ8YK8ea8bpF2S4cflGXVEc04GAmUCmq7Q6V7aAPBJkXU45uru22aTe3VW
         Kh3w==
X-Gm-Message-State: AOJu0Yz2W4GHQ0j5bmsEetHp4WXRSbW6YpyE1jj5G3Y601E2kflMuEI/
	jK3R4a+OPJbwTNsDjvS3ydTmRFgi/6oxgu7QyKeFbzqYjpzwESQ/u6YzSPAuZc6sNmRkJZ2NAmY
	QeH5Q9ZiFUGCzW+8aNnBANYC/VxCrDWVaYg1dxEaMsJLZRJYIeQ8q0shEnYj5GUTDfrDurw1bCa
	nAeMmo7GRV0hgCRjn89mWXpQ/gcHwDCqUazSgwO3mA57NgAX8VDnMF804MaEP7s1hJ
X-Google-Smtp-Source: AGHT+IF7ZbTL983ECJ8KBnz56PYX0Fw7TZG1jfUDMmqC2R5Q+CjOij6DPUsfz99pGQpvbShlJDWC9mTEM8QHUzvH5Hk=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:1ab8:7f2d:7123:f4fc])
 (user=pkaligineedi job=sendgmr) by 2002:a25:5f50:0:b0:e28:f2a5:f1d with SMTP
 id 3f1490d57ef6-e2919d9e584mr50706276.4.1728937280582; Mon, 14 Oct 2024
 13:21:20 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:21:07 -0700
In-Reply-To: <20241014202108.1051963-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014202108.1051963-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014202108.1051963-3-pkaligineedi@google.com>
Subject: [PATCH net-next v3 2/3] gve: adopt page pool for DQ RDA mode
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	shannon.nelson@amd.com, jacob.e.keller@intel.com, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Harshitha Ramamurthy <hramamurthy@google.com>

For DQ queue format in raw DMA addressing(RDA) mode,
implement page pool recycling of buffers by leveraging
a few helper functions.

DQ QPL mode will continue to use the exisiting recycling
logic. This is because in QPL mode, the pages come from a
constant set of pages that the driver pre-allocates and
registers with the device.

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---

Changes in v3:
-Removed ethtool stat tracking page pool alloc failures (Jakub Kicinski)

Changes in v2:
-Set allow_direct parameter to true in napi context and false
in others (Shannon Nelson)
-Set the napi pointer in page pool params (Jakub Kicinski)
-Track page pool alloc failures per ring (Jakub Kicinski)
-Don't exceed 80 char limit (Jakub Kicinski)

---
 drivers/net/ethernet/google/Kconfig           |   1 +
 drivers/net/ethernet/google/gve/gve.h         |  22 ++-
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 180 +++++++++++++-----
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  89 ++++-----
 4 files changed, 198 insertions(+), 94 deletions(-)

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
index bd684c7d996a..dd92949bb214 100644
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
 
@@ -1176,10 +1182,22 @@ struct gve_rx_buf_state_dqo *gve_dequeue_buf_state(struct gve_rx_ring *rx,
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
index 8e50f0e4bb2e..05bf1f80a79c 100644
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
@@ -228,3 +200,113 @@ void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
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
+	if (!page)
+		return -ENOMEM;
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
2.47.0.rc1.288.g06298d1525-goog


