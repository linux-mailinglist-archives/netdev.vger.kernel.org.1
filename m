Return-Path: <netdev+bounces-127095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CBC97412C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FF11C24EB0
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E341A3BBC;
	Tue, 10 Sep 2024 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eefr4pTu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA71A38C1
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990810; cv=none; b=KIZKXLb0tLh17e6vm1ZSPWRzIk0f4Jr4lVMLAyEk6zM4/bhxOdxxK6Fettg8dYTfmbFBooK+kyztAa8kUYuaHjH+wlQVdaIv4+4r1rMAVM6StJFiAl9+HOAdVVSVZ000LA02fCx0VMqVbiSnbXkMQ76Guwn3Uu3fe6lLvTTX9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990810; c=relaxed/simple;
	bh=2gaop2R+uHm567bx/c0CNhPQutyBtWnefkgY6C10rB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jW/LrgmP9D/oY2Z1pmdntubykeodvV4l28JwvB5pg/gNEGsMu2vIPHGx5LSRgZC6ALN30UbQNLJWp4WPH1DQ70c9mToX4sccU4lFfpAUE+XMqCyEn+PgdK1G0ZZJEvMZbWATxiQe9jIAb1pV9DDikETVNs/XXrWUydvbCzplq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eefr4pTu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-206b912491eso855045ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725990807; x=1726595607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ky5m5cjnT2yD3/Y55busipw4ONKL8tstus3eR6RjlgM=;
        b=eefr4pTuKM73cZ8MVy6s8pGtRWPNpgAPN1B+3wpo1DNHeg0CwGQHFdT/JYpLJfsVKw
         uwQOzChyL0HB67TNKcexEAuyr1n5zNJk46hirx22Tr/mVXF0nJDj/sEq2+V3RIOQxOR/
         eMPEKDL9bLy6C28BSGLqBbrH418fU7iwSgyqYIi55clPY1lAL9xgxbNV6ZvnIb2tG9wK
         nAdj6roV35J8JdYZmX1G+Z5pxQJsY2IHsoLqZpht87qM3T0AeCdp7woaleJbjZ7SjktV
         qA6OtWmt2USf9PI6QuimH7+qQ1hJnEeh5DLwLDm3SDMcrcEXmsAWYnfQXMI7XwhQewwV
         n6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990807; x=1726595607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ky5m5cjnT2yD3/Y55busipw4ONKL8tstus3eR6RjlgM=;
        b=LG9R38odxmTmadXj6eTuBGlWc4fju1Mdhwtjbc8MTB+sK6CaQD6uiyFheXBmbKKNBd
         UyGUIbwml5kH14MFhxy874iRITeYk0PNJ4nTvvnXtm2NOeoMJs+B2riOjnLHmqYdmQue
         BuRq5pT2ncC1X0IVUZ7YNKaSAlCfJjGj2AqJ6+2Y1MmBbqH3YqSh1c8na5e1/L5W4oIr
         QhibqO176QzO34x5pRDmafZixeenpmJtmy6VdqE1JYpbG5/8O1rzMjiiLXpx0AFMOvSb
         notUjN8IfvqplES5K3DM3Vsa9L3bzQHSDldHkbWmDWkJuUydCzxeG9+wHWoT/Gc+TiNX
         BpcQ==
X-Gm-Message-State: AOJu0YwJmCpUYjR7CFZiSE9z/AV5+eAY23CwOHwV36ZKhUNEf52JhOEQ
	oKPUQotgeaoLvI4jSerodoRujYK4Ookth+9HqI4SiEaQcaHY8An1Wu/HLY7cN6hEnHlazplFOQ4
	+ipt0jgtE6YDI4yl02a8WRIZNWrbZ6QonIjre5Yn1e+Q+FWdgWCc82tAI37dR4TGQcwrQBI2uoE
	3gUtLAcB4Vv4Wre+DoQADAGHYPUcNmqdX5OvRExRCzFDamuNxXVHTEStTNWncH34Za
X-Google-Smtp-Source: AGHT+IEHcMjX2CkGAQofQSB4MQaPr9PM0tAUgSp15alIivRg1RYql4CFoXLRuI/IpiVDVBSbynHPajdWL/D9zqMWSFU=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:76a6:f58f:c4bd:5bea])
 (user=pkaligineedi job=sendgmr) by 2002:a17:903:80e:b0:1f9:e5e4:494b with
 SMTP id d9443c01a7336-2074c5e04dcmr51955ad.2.1725990804809; Tue, 10 Sep 2024
 10:53:24 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:53:15 -0700
In-Reply-To: <20240910175315.1334256-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910175315.1334256-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910175315.1334256-3-pkaligineedi@google.com>
Subject: [PATCH net-next 2/2] gve: adopt page pool for DQ RDA mode
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, ziweixiao@google.com, 
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
 drivers/net/ethernet/google/Kconfig           |   1 +
 drivers/net/ethernet/google/gve/gve.h         |  15 +-
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 166 +++++++++++++-----
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  88 +++++-----
 4 files changed, 180 insertions(+), 90 deletions(-)

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
index 387fd26ebc43..5012ed6fbdb4 100644
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
 
@@ -1173,9 +1179,16 @@ struct gve_rx_buf_state_dqo *gve_dequeue_buf_state(struct gve_rx_ring *rx,
 void gve_enqueue_buf_state(struct gve_rx_ring *rx, struct gve_index_list *list,
 			   struct gve_rx_buf_state_dqo *buf_state);
 struct gve_rx_buf_state_dqo *gve_get_recycled_buf_state(struct gve_rx_ring *rx);
-int gve_alloc_page_dqo(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state);
 void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
 			 struct gve_rx_buf_state_dqo *buf_state);
+void gve_free_to_page_pool(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state);
+int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state);
+void gve_free_qpl_page_dqo(struct gve_rx_buf_state_dqo *buf_state);
+void gve_reuse_buffer(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state);
+void gve_free_buffer(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state);
+int gve_alloc_buffer(struct gve_rx_ring *rx, struct gve_rx_desc_dqo *desc);
+struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv, struct gve_rx_ring *rx);
+
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
 int gve_reset(struct gve_priv *priv, bool attempt_teardown);
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index a8ea23b407ed..c26461cb7cf4 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -12,15 +12,6 @@ int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
 	return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
 }
 
-void gve_free_page_dqo(struct gve_priv *priv, struct gve_rx_buf_state_dqo *bs, bool free_page)
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
@@ -125,55 +116,27 @@ struct gve_rx_buf_state_dqo *gve_get_recycled_buf_state(struct gve_rx_ring *rx)
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
 
-int gve_alloc_page_dqo(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
+int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
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
@@ -183,6 +146,15 @@ int gve_alloc_page_dqo(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_
 	return 0;
 }
 
+void gve_free_qpl_page_dqo(struct gve_rx_buf_state_dqo *buf_state)
+{
+	if (!buf_state->page_info.page)
+		return;
+
+	page_ref_sub(buf_state->page_info.page, buf_state->page_info.pagecnt_bias - 1);
+	buf_state->page_info.page = NULL;
+}
+
 void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
 			 struct gve_rx_buf_state_dqo *buf_state)
 {
@@ -224,3 +196,103 @@ void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
 	gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
 	rx->dqo.used_buf_states_cnt++;
 }
+
+void gve_free_to_page_pool(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
+{
+	struct page *page = buf_state->page_info.page;
+
+	if (!page)
+		return;
+
+	page_pool_put_page(page->pp, page, buf_state->page_info.buf_size, true);
+	buf_state->page_info.page = NULL;
+}
+
+static int gve_alloc_from_page_pool(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
+{
+	struct gve_priv *priv = rx->gve;
+	struct page *page;
+
+	buf_state->page_info.buf_size = priv->data_buffer_size_dqo;
+	page = page_pool_alloc(rx->dqo.page_pool, &buf_state->page_info.page_offset,
+			       &buf_state->page_info.buf_size, GFP_ATOMIC);
+
+	if (!page) {
+		priv->page_alloc_fail++;
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
+struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv, struct gve_rx_ring *rx)
+{
+	struct page_pool_params pp = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order = 0,
+		.pool_size = GVE_PAGE_POOL_SIZE_MULTIPLIER * priv->rx_desc_cnt,
+		.dev = &priv->pdev->dev,
+		.netdev = priv->dev,
+		.max_len = PAGE_SIZE,
+		.dma_dir = DMA_FROM_DEVICE,
+	};
+
+	return page_pool_create(&pp);
+}
+
+void gve_free_buffer(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
+{
+	if (rx->dqo.page_pool) {
+		gve_free_to_page_pool(rx, buf_state);
+		gve_free_buf_state(rx, buf_state);
+	} else {
+		gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
+	}
+}
+
+void gve_reuse_buffer(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
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
+	desc->buf_addr = cpu_to_le64(buf_state->addr + buf_state->page_info.page_offset);
+
+	return 0;
+
+free_buf_state:
+	gve_free_buf_state(rx, buf_state);
+	return -ENOMEM;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index b343be2fb118..250c0302664c 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -95,8 +95,10 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
 		for (i = 0; i < rx->dqo.num_buf_states; i++) {
 			struct gve_rx_buf_state_dqo *bs = &rx->dqo.buf_states[i];
 
-			if (bs->page_info.page)
-				gve_free_page_dqo(priv, bs, !rx->dqo.qpl);
+			if (rx->dqo.page_pool)
+				gve_free_to_page_pool(rx, bs);
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
+			gve_free_to_page_pool(rx, bs);
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
@@ -508,13 +514,9 @@ static int gve_rx_append_frags(struct napi_struct *napi,
 	skb_add_rx_frag(rx->ctx.skb_tail, num_frags,
 			buf_state->page_info.page,
 			buf_state->page_info.page_offset,
-			buf_len, priv->data_buffer_size_dqo);
-	gve_dec_pagecnt_bias(&buf_state->page_info);
+			buf_len, buf_state->page_info.buf_size);
 
-	/* Advances buffer page-offset if page is partially used.
-	 * Marks buffer as used if page is full.
-	 */
-	gve_try_recycle_buf(priv, rx, buf_state);
+	gve_reuse_buffer(rx, buf_state);
 	return 0;
 }
 
@@ -548,8 +550,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	if (unlikely(compl_desc->rx_error)) {
-		gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states,
-				      buf_state);
+		gve_free_buffer(rx, buf_state);
 		return -EINVAL;
 	}
 
@@ -573,6 +574,9 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 			if (unlikely(!rx->ctx.skb_head))
 				goto error;
 			rx->ctx.skb_tail = rx->ctx.skb_head;
+
+			if (rx->dqo.page_pool)
+				skb_mark_for_recycle(rx->ctx.skb_head);
 		} else {
 			unsplit = 1;
 		}
@@ -609,8 +613,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		rx->rx_copybreak_pkt++;
 		u64_stats_update_end(&rx->statss);
 
-		gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states,
-				      buf_state);
+		gve_free_buffer(rx, buf_state);
 		return 0;
 	}
 
@@ -625,16 +628,17 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
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
2.46.0.598.g6f2099f65c-goog


