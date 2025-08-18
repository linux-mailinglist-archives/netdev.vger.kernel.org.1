Return-Path: <netdev+bounces-214783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AACB2B32D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 23:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057483BF7D3
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 21:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A8323505E;
	Mon, 18 Aug 2025 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2yqPDn7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1825D20B7F4
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755551114; cv=none; b=R9cHBEPlTb7qsTdy4WCnDrRAjUvknIRnPWx6oRl02Rns4njZdHahC+0pBuI9gDAZ11hoaT05bqG3epM6Llq37O3S7koTmmKcRN+LnTuod+IYLC0iYu0WZj8h1F/ZsMepaeLhEDSOMuBmaam+UYxIh7k4zYLm1+d/leO6woSMrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755551114; c=relaxed/simple;
	bh=vs33q/xMLjGp5f/8wOcGTqry10cy1yx1Vec5ZubeWiE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EdadQ1ck3e5V5mdAkbb54Ft4XGrOY+ztjxcucVRu99ICUvotACR4hLxk84zLCXaCB8KOXBxViquXsrtfwNYoI0ew5hp/RRuR1w2YqrJfRgrBtDi3vVAsKFoTTkaMF3ZR3rUBv+h3jEaOPSzi4FLaTYnWllVzNob/Jaq1L8QQFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2yqPDn7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eb6d2baso10407842b3a.3
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755551112; x=1756155912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cqttlk/hbJyxL50WlgnQ4IHuWmhf7bPxr6NxrThxPlI=;
        b=i2yqPDn7ucS2GuKvnXOt9MOEpKbo1DF7Ey074p4QmI+j2eRsq8GkaQCdoH0yKJq88R
         Vvy3FBvlRRldiGltY/dRrn0m4MDuOLueVEayl/tj9XhClTJXWDNrBQuQCryvhgZn9kPJ
         htGYmaJGM5d1p0S1nKH1Ks7cat/PFKxc0vK69tBj/fFsUdQQWWvVeoGftootDzFRc5a2
         E6XwBhAOAbUHw4RdQPJcSq/wMKQAdl7NX16N+D/TYa8yrrGmOQ8/X3Eh/BNYtjqovrOK
         X5H3djINkUhklY8SP9h/AxiSa2V1IuvdGjqmymm3oGMnnQGVunVyJQrZgLjzkw6Be8wX
         2IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755551112; x=1756155912;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cqttlk/hbJyxL50WlgnQ4IHuWmhf7bPxr6NxrThxPlI=;
        b=tHWavsBqz+OD0vXUx5ZJcWGQNW5vODjo+nDDBUMrIQuMeey/4oYmnMbI/+YNgebp9C
         OlrpBA4lm1aEw+XeQXQQ4j+hfB6CnyJbe+eKeo0k1QSpNb1NKD3ckpz0fN0hYwRONPOc
         3l3jDboOnugkUoIv7Az82yMcgycQTF7LtBHKVNFxlMrGetZVNmfoDlDY0MT6bLM62jS8
         py69gAOkhVf6twaWYNVbZl9saUDvQC8eIpULa247dz3H5WQCzBqA8Na/J1s7FAML4P+H
         2fVi6bjW8HDG1aYZBSikgRKXCr3T2s4cpiIHVMkygCej7JqPxasScUXpAFEV1ZGgcVWJ
         /ITA==
X-Gm-Message-State: AOJu0Yxj9ZtWmK1Qej3nNM174lTffY4Tb27Os2sjK+z+ctW7Vw6xwsGO
	cPjSMMK+SdVzhZFGDYaHSgXl8wlIrnBfKcaulDMFtogaOPrEoZYtBn8xcDjqUHm4Zqvdt16wkq3
	LEGgVWDahOoNKvm/4ZcGvq1PLpgCkoeJO7vR/7PfTZUcRgtZOVhoeumWuOpy8eKDP38Wc4zeIeL
	h1NT5YwaMqlLu5GF5XfxA8MwPpyk1Lz7MRwcydx7S6T2DGd/pHwu39+JPfnjPSHfM=
X-Google-Smtp-Source: AGHT+IHj+SISdeINEA8J4Jb4DADUwlz+KRawELTru597TLDhi2fzxgvYCQ9Kylo2E41s3lu1cj3YXOvo9fh/pZ8HHw==
X-Received: from pfod1.prod.google.com ([2002:aa7:8681:0:b0:76b:da8d:7393])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4320:b0:238:351a:6437 with SMTP id adf61e73a8af0-2430d4d3d9emr7675637.43.1755551112265;
 Mon, 18 Aug 2025 14:05:12 -0700 (PDT)
Date: Mon, 18 Aug 2025 21:05:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818210507.3781705-1-hramamurthy@google.com>
Subject: [PATCH net-next v2] gve: support unreadable netmem
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, pkaligineedi@google.com, joshwash@google.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>, Ziwei Xiao <ziweixiao@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Mina Almasry <almasrymina@google.com>

Declare PP_FLAG_ALLOW_UNREADABLE_NETMEM to turn on unreadable netmem
support in GVE.

We also drop any net_iov packets where header split is not enabled.
We're unable to process packets where the header landed in unreadable
netmem.

Use page_pool_dma_sync_netmem_for_cpu in lieu of
dma_sync_single_range_for_cpu to correctly handle unreadable netmem
that should not be dma-sync'd.

Disable rx_copybreak optimization if payload is unreadable netmem as
that needs access to the payload.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 Changes in v2:
 * Change to handle error paths using existing 'goto error' in gve_rx_dqo
   (Simon Horman)
---
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |  5 +++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 35 ++++++++++++++++---
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 8f5021e59e0a..0e2b703c673a 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -260,6 +260,11 @@ struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
 		.offset = xdp ? XDP_PACKET_HEADROOM : 0,
 	};
 
+	if (priv->header_split_enabled) {
+		pp.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+		pp.queue_idx = rx->q_num;
+	}
+
 	return page_pool_create(&pp);
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7380c2b7a2d8..55393b784317 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -718,6 +718,24 @@ static int gve_rx_xsk_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	return 0;
 }
 
+static void gve_dma_sync(struct gve_priv *priv, struct gve_rx_ring *rx,
+			 struct gve_rx_buf_state_dqo *buf_state, u16 buf_len)
+{
+	struct gve_rx_slot_page_info *page_info = &buf_state->page_info;
+
+	if (rx->dqo.page_pool) {
+		page_pool_dma_sync_netmem_for_cpu(rx->dqo.page_pool,
+						  page_info->netmem,
+						  page_info->page_offset,
+						  buf_len);
+	} else {
+		dma_sync_single_range_for_cpu(&priv->pdev->dev, buf_state->addr,
+					      page_info->page_offset +
+					      page_info->pad,
+					      buf_len, DMA_FROM_DEVICE);
+	}
+}
+
 /* Returns 0 if descriptor is completed successfully.
  * Returns -EINVAL if descriptor is invalid.
  * Returns -ENOMEM if data cannot be copied to skb.
@@ -793,13 +811,18 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		rx->rx_hsplit_unsplit_pkt += unsplit;
 		rx->rx_hsplit_bytes += hdr_len;
 		u64_stats_update_end(&rx->statss);
+	} else if (!rx->ctx.skb_head && rx->dqo.page_pool &&
+		   netmem_is_net_iov(buf_state->page_info.netmem)) {
+		/* when header split is disabled, the header went to the packet
+		 * buffer. If the packet buffer is a net_iov, those can't be
+		 * easily mapped into the kernel space to access the header
+		 * required to process the packet.
+		 */
+		goto error;
 	}
 
 	/* Sync the portion of dma buffer for CPU to read. */
-	dma_sync_single_range_for_cpu(&priv->pdev->dev, buf_state->addr,
-				      buf_state->page_info.page_offset +
-				      buf_state->page_info.pad,
-				      buf_len, DMA_FROM_DEVICE);
+	gve_dma_sync(priv, rx, buf_state, buf_len);
 
 	/* Append to current skb if one exists. */
 	if (rx->ctx.skb_head) {
@@ -837,7 +860,9 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		u64_stats_update_end(&rx->statss);
 	}
 
-	if (eop && buf_len <= priv->rx_copybreak) {
+	if (eop && buf_len <= priv->rx_copybreak &&
+	    !(rx->dqo.page_pool &&
+	      netmem_is_net_iov(buf_state->page_info.netmem))) {
 		rx->ctx.skb_head = gve_rx_copy(priv->dev, napi,
 					       &buf_state->page_info, buf_len);
 		if (unlikely(!rx->ctx.skb_head))
-- 
2.51.0.rc0.155.g4a0f42376b-goog


