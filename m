Return-Path: <netdev+bounces-89404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429988AA38A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE911F246AB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6932E1A0AFA;
	Thu, 18 Apr 2024 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mmBksB5z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21B1BED97
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469951; cv=none; b=K01hItmmwfnVBwF6snY1agNAgoKB3clldXMPdqcEUcGIWnoZW42AMmNDj7ZWltbqSxUfTGmrbGCdavi9WxocfMv2OgSjAxHJqMRxS0nnkp5di6Ad2swpOdVTWxATAZTUn9e1XjaMahxSck4NipNCuiZLqxFfE8FqGddrypGeKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469951; c=relaxed/simple;
	bh=EACbfvY/4424J5g7tN1NGHoJKDeUycyOIa1G0728pbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J3rHfosWdoZUdyl7pbAWuYTZePmmMn5qk7vwn/F4pXe1QgpfOFnq/xdiB3dHW4vHkwojTRnXFdpNX9VDh7mp/SwIPRQ3l8xf0F4uFni2qiV6LaxmGl+IlmqT/KKWrtrrIpPLWdKrPPjOLX5X7yAUKF48qWpDZJO2SLbtSM0Tv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mmBksB5z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de45dba157dso2475400276.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713469949; x=1714074749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXApQ/BYRhq5FbSARBQKlWaEk3VaY98fqoz2ny5u76A=;
        b=mmBksB5zE8b0uZgL/64nMVJugbe90KTDIhgaYFu/CJiqOPQcTJSlQYBo7ttwRKYGiY
         uLzh5Apf0GELLXyDGUNjFV+kGIz2+LIgis872FTAC264OT4BnfSjUHEhd6uPkksr3/Eb
         UJbaZLatP6WFqLBjP08kDbL+rDfC8A+0Lhp5nE3gjVK968yn4Ks6kLAd18BjAa1Cdl3Q
         uJmI9sA10OwXN/YdQNV7K/vVjMI68dZTYb82iSkTJdZsO0eAlBb/mn2oIxJYcbnmWjdx
         3bDjQlMWElUUy3bwlTSCJ/YRWC1rAAV5MwwJeh8j+e6WGkFMiQDc/8xRRbCLNjgYDlXr
         xVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469949; x=1714074749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXApQ/BYRhq5FbSARBQKlWaEk3VaY98fqoz2ny5u76A=;
        b=HxhcOUxKvGd7KWAFDelJDRZ9IhOmapeKd/ogf+v9eeCCSSfd9MAnGsseq2erNgUMCh
         8nuoOq3gEGT+qxbByyHGJMdTVp/nim6NoUGr4GkPVnI0kxI/6Af04zNAr689CBKOD05j
         kzJ0ghLoV9/jqeyiLMhuXgkrmrT4DY7JxtlvHYfy7uB72CeppGvspmY31rspFV+pQaRH
         17REEC9C+2WkrGOZhYe1HrqnZMUjtuSCKnoZ0a+5vekIZVvzS1Ab3p++lIFEjpRURE4u
         kicYxCGuUj5zIemtB9O2XS3sVEwQiWXsG5MB3Bwuavf+Nevkum9dx7mYlko9N15nz6wp
         goCg==
X-Gm-Message-State: AOJu0Yz0NBPrlayonrS3CZ3aDJ255t51O7arep+aUZeAvMMHnLp+Qk3i
	hQ4MmAAStbWnC5ENHf6Rv0AvrvAmhOn0Y43BfDhIan89+0sr/2U8nnNupttS3oIVU029Gbxz59B
	P6s6HQQc5L75LUsS/THHpTi6IsrsqlWmUq905WUWHtiPddh3LC7PsrKoISQhYFx8QDlfZKxj6mP
	7a9NHhrj7G9cH5zHhKXPXtHfgAjVM/ES95GVM2WGj8i10=
X-Google-Smtp-Source: AGHT+IFvefHzkZrPL3Hdz4Rwx4k6mgBm0n4x4/iUO5+yRxJETIw9mOV0L5SL3+TDsiP6w8Iq5w5Tfpy1TfQxbw==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:100c:b0:dbe:387d:a8ef with SMTP
 id w12-20020a056902100c00b00dbe387da8efmr337872ybt.1.1713469948593; Thu, 18
 Apr 2024 12:52:28 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:51:57 +0000
In-Reply-To: <20240418195159.3461151-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418195159.3461151-8-shailend@google.com>
Subject: [RFC PATCH net-next 7/9] gve: Reset Rx ring state in the ring-stop funcs
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

This does not fix any existing bug. In anticipation of the ndo queue api
hooks that alloc/free/start/stop a single Rx queue, the already existing
per-queue stop functions are being made more robust. Specifically for
this use case: rx_queue_n.stop() + rx_queue_n.start()

Note that this is not the use case being used in devmem tcp (the first
place these new ndo hooks would be used). There the usecase is:
new_queue.alloc() + old_queue.stop() + new_queue.start() + old_queue.free()

Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx.c     |  48 +++++++--
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 102 +++++++++++++++----
 2 files changed, 120 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index fde7503940f7..1d235caab4c5 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -54,6 +54,41 @@ static void gve_rx_unfill_pages(struct gve_priv *priv,
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
@@ -63,6 +98,7 @@ void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx)
 
 	gve_remove_napi(priv, ntfy_idx);
 	gve_rx_remove_from_block(priv, idx);
+	gve_rx_reset_ring_gqi(priv, idx);
 }
 
 static void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
@@ -226,15 +262,6 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
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
@@ -313,9 +340,8 @@ static int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
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
index 15108407b54f..dc2c6bd92e82 100644
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
@@ -275,10 +352,10 @@ static void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
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
@@ -303,7 +380,6 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 {
 	struct device *hdev = &priv->pdev->dev;
 	size_t size;
-	int i;
 
 	const u32 buffer_queue_slots = cfg->ring_size;
 	const u32 completion_queue_slots = cfg->ring_size;
@@ -313,11 +389,6 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
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
@@ -330,19 +401,9 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 
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
@@ -370,6 +431,9 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 	if (!rx->q_resources)
 		goto err;
 
+	gve_rx_init_ring_state_dqo(rx, buffer_queue_slots,
+				   completion_queue_slots);
+
 	return 0;
 
 err:
-- 
2.44.0.769.g3c40516874-goog


