Return-Path: <netdev+bounces-92643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0E18B82F1
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD4A3B23900
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280401C2325;
	Tue, 30 Apr 2024 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbJzfE3h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C51C2314
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518888; cv=none; b=e0k+MZXBJSfWaIDub+6//dROYOD/gpYhGbZGHhsycRNWsUS9GeBYsEMIfsuaGu7+ufcTinHn+8Pf+MbdtUgQIWT/zUdtUFEjxI28n2c727hYXsOFwBudw8FU7FX3lyQVWGgCpO1OJl+B02iAwJbqdIC3B/dA66RCMTVx3Xd3f0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518888; c=relaxed/simple;
	bh=nqU7lgRnFZ/X0PNcsH7nolu4PE5U2oVnLJQWPNzmGVY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TJY4jUe3YffwoC1BEdLOiAKLqLVwB5LkUGjqG6HzXURlGr7aJG0phDqi5Xtd7DPuwnFhb8FPu8PWa61UCduA7R/IrLJNWcBtGGdZ6YJFbCdskMLZTNocdbls/sREVKrQoznrglm3bGFPRjEOiqEfzf8zaK5OHAAsHvqexYRBxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbJzfE3h; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be75e21fdso31895557b3.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714518885; x=1715123685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X1h4LMrzCT+Amis4VKG8AAFYoLhhUQWunAXrHJrR4lI=;
        b=nbJzfE3hoWnblFI+vePyEpt2GekhRZkqOZnPeD2BDbqHokYTv+XmSbAI7EJkjQ0J89
         m5pMQDbUK9UnIdr0yauWsrgo0PsGhzhGB+4pXmCDdLy9OfLPfxxPRMpd0pW6CuQBbtJK
         VOpoCRHNTBMsj2s8djIIEnEI8GH8jGDt1p1i29QR/vGGpubRDJYJY6hRYldClaBz81GL
         r9VtPTumkIixr3UJCLNXsup5IQLAlOUykKSse8yAMKLQmBku7EugLIyJeZc4Ev+dhgwz
         MXKfAmrlXFHT7BhSWpgadU4ALSTCkmMrLlE91J2JSiy7Ylo97ci9XzU3IMbpRxH41vZg
         UvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714518885; x=1715123685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X1h4LMrzCT+Amis4VKG8AAFYoLhhUQWunAXrHJrR4lI=;
        b=PEjaN9k7gYLhgzeuUFqC7yqq0HasLo9qqDVNxu37NI4ARem/VV+nt7RbRr6hpQG1Fu
         nOZQM7UCBTG/doMZzDG8njXYq7qRHzLOfXTcDB6m11+jzdosHe28LEyZKLRxiRRdN/64
         G5g2mn6W2CRdGH4AiX3foDh/zrBGMUquWJ3BM+ueNtQ38AMeePb0cENsrV6knhFSJ1Hc
         gZCdJl7sI9/NeYTFAESv+OMVU1Zv/3ykvguJoh5Jsi8h38QJ89mJ4qXytgcArN5GvgKZ
         gWpqJRt5GzZ4nnbZtZIykykWvQyWnqJhVIxqrLFC0SjqSKREEOJoB/klHSd2f6dD76JJ
         lgLw==
X-Gm-Message-State: AOJu0YzCe636df7eANWA3Yr21L5Jz6YPL1QHU/xFzVTwWvYxPePjMBf2
	49eh1oGBw+uPl0hboqkld0LXfeX3EdFLvvWAIMri8NcNcRjYZobD+Y11ep2lZbPP+xki4Q+D5vJ
	bbHME8T04Gk2AuxGqg1JG8n5Tl0TEOrXQyd3+fY/Oi1zEamfaWFD6O4F86OaDPRhMUsyGMhc06g
	8SHK8+HrrtzV2Zt7O750qUqEWLd3bXvJ8lYFYnygr+dtE=
X-Google-Smtp-Source: AGHT+IFxTLJVhZ0ppLimVy7QqvU8zr+LhLmWPZm7IYSCzpK+j/DFd+pSfMRH8nyzcedsOQUjpq2hPG8UkPAbdw==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a0d:d2c5:0:b0:61d:3304:c25e with SMTP id
 u188-20020a0dd2c5000000b0061d3304c25emr270225ywd.7.1714518885252; Tue, 30 Apr
 2024 16:14:45 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:14:16 +0000
In-Reply-To: <20240430231420.699177-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430231420.699177-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430231420.699177-8-shailend@google.com>
Subject: [PATCH net-next 07/10] gve: Reset Rx ring state in the ring-stop funcs
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

This does not fix any existing bug. In anticipation of the ndo queue api
hooks that alloc/free/start/stop a single Rx queue, the already existing
per-queue stop functions are being made more robust. Specifically for
this use case: rx_queue_n.stop() + rx_queue_n.start()

Note that this is not the use case being used in devmem tcp (the first
place these new ndo hooks would be used). There the usecase is:
new_queue.alloc() + old_queue.stop() + new_queue.start() + old_queue.free()

Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx.c     |  48 +++++++--
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 102 +++++++++++++++----
 2 files changed, 120 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 0a3f88170411..79c1d8f63621 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -53,6 +53,41 @@ static void gve_rx_unfill_pages(struct gve_priv *priv,
 	rx->data.page_info = NULL;
 }
 
+static void gve_rx_ctx_clear(struct gve_rx_ctx *ctx)
+{
+	ctx->skb_head = NULL;
+	ctx->skb_tail = NULL;
+	ctx->total_size = 0;
+	ctx->frag_cnt = 0;
+	ctx->drop_pkt = false;
+}
+
+static void gve_rx_init_ring_state_gqi(struct gve_rx_ring *rx)
+{
+	rx->desc.seqno = 1;
+	rx->cnt = 0;
+	gve_rx_ctx_clear(&rx->ctx);
+}
+
+static void gve_rx_reset_ring_gqi(struct gve_priv *priv, int idx)
+{
+	struct gve_rx_ring *rx = &priv->rx[idx];
+	const u32 slots = priv->rx_desc_cnt;
+	size_t size;
+
+	/* Reset desc ring */
+	if (rx->desc.desc_ring) {
+		size = slots * sizeof(rx->desc.desc_ring[0]);
+		memset(rx->desc.desc_ring, 0, size);
+	}
+
+	/* Reset q_resources */
+	if (rx->q_resources)
+		memset(rx->q_resources, 0, sizeof(*rx->q_resources));
+
+	gve_rx_init_ring_state_gqi(rx);
+}
+
 void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx)
 {
 	int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
@@ -62,6 +97,7 @@ void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx)
 
 	gve_remove_napi(priv, ntfy_idx);
 	gve_rx_remove_from_block(priv, idx);
+	gve_rx_reset_ring_gqi(priv, idx);
 }
 
 static void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
@@ -222,15 +258,6 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 	return err;
 }
 
-static void gve_rx_ctx_clear(struct gve_rx_ctx *ctx)
-{
-	ctx->skb_head = NULL;
-	ctx->skb_tail = NULL;
-	ctx->total_size = 0;
-	ctx->frag_cnt = 0;
-	ctx->drop_pkt = false;
-}
-
 void gve_rx_start_ring_gqi(struct gve_priv *priv, int idx)
 {
 	int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
@@ -309,9 +336,8 @@ static int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 		err = -ENOMEM;
 		goto abort_with_q_resources;
 	}
-	rx->cnt = 0;
 	rx->db_threshold = slots / 2;
-	rx->desc.seqno = 1;
+	gve_rx_init_ring_state_gqi(rx);
 
 	rx->packet_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 	gve_rx_ctx_clear(&rx->ctx);
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 53fd2d87233f..7c2980c212f4 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -211,6 +211,82 @@ static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
 	}
 }
 
+static void gve_rx_init_ring_state_dqo(struct gve_rx_ring *rx,
+				       const u32 buffer_queue_slots,
+				       const u32 completion_queue_slots)
+{
+	int i;
+
+	/* Set buffer queue state */
+	rx->dqo.bufq.mask = buffer_queue_slots - 1;
+	rx->dqo.bufq.head = 0;
+	rx->dqo.bufq.tail = 0;
+
+	/* Set completion queue state */
+	rx->dqo.complq.num_free_slots = completion_queue_slots;
+	rx->dqo.complq.mask = completion_queue_slots - 1;
+	rx->dqo.complq.cur_gen_bit = 0;
+	rx->dqo.complq.head = 0;
+
+	/* Set RX SKB context */
+	rx->ctx.skb_head = NULL;
+	rx->ctx.skb_tail = NULL;
+
+	/* Set up linked list of buffer IDs */
+	if (rx->dqo.buf_states) {
+		for (i = 0; i < rx->dqo.num_buf_states - 1; i++)
+			rx->dqo.buf_states[i].next = i + 1;
+		rx->dqo.buf_states[rx->dqo.num_buf_states - 1].next = -1;
+	}
+
+	rx->dqo.free_buf_states = 0;
+	rx->dqo.recycled_buf_states.head = -1;
+	rx->dqo.recycled_buf_states.tail = -1;
+	rx->dqo.used_buf_states.head = -1;
+	rx->dqo.used_buf_states.tail = -1;
+}
+
+static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
+{
+	struct gve_rx_ring *rx = &priv->rx[idx];
+	size_t size;
+	int i;
+
+	const u32 buffer_queue_slots = priv->rx_desc_cnt;
+	const u32 completion_queue_slots = priv->rx_desc_cnt;
+
+	/* Reset buffer queue */
+	if (rx->dqo.bufq.desc_ring) {
+		size = sizeof(rx->dqo.bufq.desc_ring[0]) *
+			buffer_queue_slots;
+		memset(rx->dqo.bufq.desc_ring, 0, size);
+	}
+
+	/* Reset completion queue */
+	if (rx->dqo.complq.desc_ring) {
+		size = sizeof(rx->dqo.complq.desc_ring[0]) *
+			completion_queue_slots;
+		memset(rx->dqo.complq.desc_ring, 0, size);
+	}
+
+	/* Reset q_resources */
+	if (rx->q_resources)
+		memset(rx->q_resources, 0, sizeof(*rx->q_resources));
+
+	/* Reset buf states */
+	if (rx->dqo.buf_states) {
+		for (i = 0; i < rx->dqo.num_buf_states; i++) {
+			struct gve_rx_buf_state_dqo *bs = &rx->dqo.buf_states[i];
+
+			if (bs->page_info.page)
+				gve_free_page_dqo(priv, bs, !rx->dqo.qpl);
+		}
+	}
+
+	gve_rx_init_ring_state_dqo(rx, buffer_queue_slots,
+				   completion_queue_slots);
+}
+
 void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
 {
 	int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
@@ -220,6 +296,7 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
 
 	gve_remove_napi(priv, ntfy_idx);
 	gve_rx_remove_from_block(priv, idx);
+	gve_rx_reset_ring_dqo(priv, idx);
 }
 
 static void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
@@ -273,10 +350,10 @@ static void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 	netif_dbg(priv, drv, priv->dev, "freed rx ring %d\n", idx);
 }
 
-static int gve_rx_alloc_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
+static int gve_rx_alloc_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx,
+				 const u32 buf_count)
 {
 	struct device *hdev = &priv->pdev->dev;
-	int buf_count = rx->dqo.bufq.mask + 1;
 
 	rx->dqo.hdr_bufs.data = dma_alloc_coherent(hdev, priv->header_buf_size * buf_count,
 						   &rx->dqo.hdr_bufs.addr, GFP_KERNEL);
@@ -301,7 +378,6 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 {
 	struct device *hdev = &priv->pdev->dev;
 	size_t size;
-	int i;
 
 	const u32 buffer_queue_slots = cfg->ring_size;
 	const u32 completion_queue_slots = cfg->ring_size;
@@ -311,11 +387,6 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 	memset(rx, 0, sizeof(*rx));
 	rx->gve = priv;
 	rx->q_num = idx;
-	rx->dqo.bufq.mask = buffer_queue_slots - 1;
-	rx->dqo.complq.num_free_slots = completion_queue_slots;
-	rx->dqo.complq.mask = completion_queue_slots - 1;
-	rx->ctx.skb_head = NULL;
-	rx->ctx.skb_tail = NULL;
 
 	rx->dqo.num_buf_states = cfg->raw_addressing ?
 		min_t(s16, S16_MAX, buffer_queue_slots * 4) :
@@ -328,19 +399,9 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 
 	/* Allocate header buffers for header-split */
 	if (cfg->enable_header_split)
-		if (gve_rx_alloc_hdr_bufs(priv, rx))
+		if (gve_rx_alloc_hdr_bufs(priv, rx, buffer_queue_slots))
 			goto err;
 
-	/* Set up linked list of buffer IDs */
-	for (i = 0; i < rx->dqo.num_buf_states - 1; i++)
-		rx->dqo.buf_states[i].next = i + 1;
-
-	rx->dqo.buf_states[rx->dqo.num_buf_states - 1].next = -1;
-	rx->dqo.recycled_buf_states.head = -1;
-	rx->dqo.recycled_buf_states.tail = -1;
-	rx->dqo.used_buf_states.head = -1;
-	rx->dqo.used_buf_states.tail = -1;
-
 	/* Allocate RX completion queue */
 	size = sizeof(rx->dqo.complq.desc_ring[0]) *
 		completion_queue_slots;
@@ -368,6 +429,9 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 	if (!rx->q_resources)
 		goto err;
 
+	gve_rx_init_ring_state_dqo(rx, buffer_queue_slots,
+				   completion_queue_slots);
+
 	return 0;
 
 err:
-- 
2.45.0.rc0.197.gbae5840b3b-goog


