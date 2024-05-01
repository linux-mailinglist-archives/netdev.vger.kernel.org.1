Return-Path: <netdev+bounces-92858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385808B9258
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1B21C21463
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B2F168B1E;
	Wed,  1 May 2024 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pA4gqVn0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A216C680
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605972; cv=none; b=m5cJQFYYZ5dm93CRs/LGqciGfRWtAp/4S8vfReqMmjQyvtveeKUZWnze0jtiWk2z9EMndaBbAUNEXcQ9hImsBI7MNsl0g9cnIgiPIRmXTWtE+ZrsRE3TUUVvtsiBAy0lPOyX1aMzDLnTgLcVgLfSHjr9zqJfXE9bimIxC7H97Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605972; c=relaxed/simple;
	bh=nqU7lgRnFZ/X0PNcsH7nolu4PE5U2oVnLJQWPNzmGVY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WRZMrQkDGlCiIdDK/i4G6xnq5nHEkXL3eta9d9ybEQrhCyiQnOUcQjp9NR9/hlQU8KIRSv7Q0jY+2hG0cOzPA6T9YTLfOy/NRX8hg0v/ZD53hO1jsNJAqLoKc5BfS08zMJJ/HAu8dKoWyDUmxX4JYCQenFmWWcW+WvZKNOSiFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pA4gqVn0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be8f9ca09so47039527b3.2
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605969; x=1715210769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X1h4LMrzCT+Amis4VKG8AAFYoLhhUQWunAXrHJrR4lI=;
        b=pA4gqVn062KW0VhIa1A77hLIsPK45W3JvA9ziDuubDIroob1wvbUKd8JloSTFL1jdd
         ISGcSJMCf4idrLeZa9n33vWCuRN/A4tqxL/zKVAa8M/FdD84GYBTQ6YMHvsWOotdPJ8a
         pi1aifNSlDrMDnHhdtF34izOYUwRekJXnpyZFMxtylZ/MsKlxSX1QFLq45OOppbNeHfd
         AreFnktFnbIwe1JNTIE47TiSQhB5zk/sBkBTMspLY5bQ3mU9BK3QpOc/efEQjx3VisyT
         vcLHk/l3bBae2WwCIMEwZ/aEmPW5rPQ3fsR+B9GG45iyGdJxbRfSzUAvXy/qZe+oh9F4
         PENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605969; x=1715210769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X1h4LMrzCT+Amis4VKG8AAFYoLhhUQWunAXrHJrR4lI=;
        b=n7TzJowJrWk+a455iTvWPzFhHALxuuy6ebxtyeKbUcGHC0kOGutQ/t562zVQqlPcCB
         eAZaeodwRVoEgvK7sybzwuZzWK1VPwRzhZbSuzeHFp/n+N942ClPboozU7uHOeN+Akbp
         LGY4hOQ37FgNlVpduHQIAB7fbQFV6sYBfoR7lszzmvtIysFPWj4x+T6f2ijmvWTCLGlJ
         icYWsTTOk5nk+YDt8vIi7AwB/CL+ztZWa4OCzqWNFcGnO/7BLcwTl/4Y6XcEsWKPxdIU
         jy0i4wVrSELRA9h8Eu4ipo6wqyibDk/UTw6mw/zyz/pCshH4K0ChBVt9nxK5OcgN5Lf3
         iJKg==
X-Gm-Message-State: AOJu0YzWhQfoXGoDuZwz4Yysb1cFX5Po2bk4MuU6wlUKv01UNM0oV4HN
	y1S+XEQmaFdeIYpVUA12VzPcrHlXV7+INi9vM4uS174mrEzSFy8KT4dY5p/GLoF8/XphwXqQdZs
	HXW6I+hr6hGVj8XZNBJx7tJc1z+XWEnrsRjaevHsPyBqbsILFpl0QVMfao6oJkPWidxZuILaJce
	pvRXOSxhc1BXBrIwAltDm4gHZb06uHP8+ZdenMwALyrp0=
X-Google-Smtp-Source: AGHT+IFu8YPuGVYTy4Ck3cIqMGzE7KGj/yMCF68OavkqIO0nyJpuqNJW7y9AFIwxQvMq4rx9fGrm9bduAQL1BQ==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:c01:b0:dc2:550b:a4f4 with SMTP
 id fs1-20020a0569020c0100b00dc2550ba4f4mr1328794ybb.1.1714605968916; Wed, 01
 May 2024 16:26:08 -0700 (PDT)
Date: Wed,  1 May 2024 23:25:46 +0000
In-Reply-To: <20240501232549.1327174-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501232549.1327174-8-shailend@google.com>
Subject: [PATCH net-next v2 07/10] gve: Reset Rx ring state in the ring-stop funcs
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com, 
	willemb@google.com, ziweixiao@google.com, 
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


