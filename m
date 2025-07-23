Return-Path: <netdev+bounces-209542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD5BB0FCE9
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 00:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F3C7A736A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAEF273D99;
	Wed, 23 Jul 2025 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBrjVNcP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5919A273D91
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309715; cv=none; b=ZCB5es/mbnwsrNmUNw7jpAJqw78c4DCIcgyaInBDKCEdm1lBTUYPLUMznEWTJ6fp7yPcKrl24LVylGX63fswmSFMOcIHMUWLq2vU/MCWQ9MfQevv89JYXLy+YngIE14RntU/hkiW+NPUiNknw8Mll0k+UgxeRTOw8jfmj8vy8IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309715; c=relaxed/simple;
	bh=VvUDt6FWFoyoDIDged2fZ1ZVOvIafQIneLMPsAZxYGs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tPTLipAqr9Wi5B8xDlD4Zed+8MSibH4QaP/OfAHzpQqvindNwmce2Y/sQk5beU+Al+oFggDv8/wKG/kTJe06wqTB/Kt3Ejck1VKCz1F41OBBNbrmJCYGQREIj9M+kYjEowl/A3U6TMPmaZaDMtHhbs+G1uZmiZOhCjyew/FAY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBrjVNcP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so264969a12.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753309712; x=1753914512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=maxoCoCzZYBwjX5BKP0pvsUFSndKViTHC8/D3FpCBB0=;
        b=LBrjVNcPtjzrPzpYwZtLwa3EPmZhQmWWQnPzuLq52zGauBkbW9ShWruo6wy214sxWf
         bxCb5qavvd9CC7PWSZido5cPPxMIiLGn/tnZICfj6B/xpcMT3wLsV8jEkXflpjAEKRsJ
         gULignJwl9x+nx6qKaoorm/K0WkU97+Te5LPHjjU8qX1P2/MYrA6/OvasgJWYL8/DTP4
         Epj6X5uRa9xdnh9eQ2FmH9JkOe2HEPtZ6y5ESg5JEeTW/QbNIRE3Vt1RgzhmS7YpcKd/
         DJCavZ+NltENwZHjAgDKbIYXxPpOX/snSdnK8sQ5/VVxICNVHSxm2lvojzscto8ZK/xy
         nEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309712; x=1753914512;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maxoCoCzZYBwjX5BKP0pvsUFSndKViTHC8/D3FpCBB0=;
        b=Aq4V0Jve4X5mFVproN+VzVz9VdKxvscklJr5Ikh9S1RbgXTxl+ojEY0/0+8/1DSdvi
         SPJsAZmF11YDyQU4gFvKDKfNq/7COkVVQLmD7jDFJ098kPIAyXZ/g6Zeg0erWe3kQC9g
         LZxIuIEBKKi62Yf/DtUbta2JuJjN8s7FHC8UVC4h+jJVge/yc3dyJgew7KznLhG2/2cU
         JlUZunn3hw+DWQngaEbcJASHpw0T0RBDv7CG+3aEyHAOikrmiIl2ld74JrUi1bJh49t7
         3Ec2XJ9S/g7iq6FmI/rWNkz+opzVZ2sujKcnJLm7lwkdzuKhXhAgPIoZr3/coVAmGFCn
         dECg==
X-Gm-Message-State: AOJu0YxVKvE2MYoD2D+khwkYawNdeE2Oroz6kYVHhxRqBGn8CcMsu2gE
	Gmq0C3E1QigLzjHG6kJN6pCVtjVmeA8MjCc3sMzMv4tKfYNU3r7BHW/RWG9FvyYJaRmDh7pMCOw
	ue53aJoNHEQxMWVJZsxsLLQQAZVryIhKc2Lp0vXWZCv+WdWmE4N6J0Z5Z1crXmdvPopFPh0mfy/
	/8MfPO3s33cSwVHRLv6ySndafZWh2PhSalXbWIzFShnVd1xlM6OREdJAj9TX0XaT8=
X-Google-Smtp-Source: AGHT+IFxGNtqJ26mBeUuULBu7HleUmr3O2AVx8P8w6Q3+FKJVsiAhBbN7BqUKAMBmasnh+F58Ye1cOC9ZU84HvXLrg==
X-Received: from pjwx11.prod.google.com ([2002:a17:90a:c2cb:b0:312:e266:f849])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e183:b0:313:15fe:4c13 with SMTP id 98e67ed59e1d1-31e507ce7f7mr7052868a91.27.1753309712524;
 Wed, 23 Jul 2025 15:28:32 -0700 (PDT)
Date: Wed, 23 Jul 2025 22:28:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723222829.3528565-1-hramamurthy@google.com>
Subject: [PATCH net-next] gve: support unreadable netmem
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, pkaligineedi@google.com, joshwash@google.com, 
	linux-kernel@vger.kernel.org, Mina Almasry <almasrymina@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>
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
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |  5 +++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 36 ++++++++++++++++---
 2 files changed, 36 insertions(+), 5 deletions(-)

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
index 7380c2b7a2d8..8c75a4d1e3e7 100644
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
@@ -793,13 +811,19 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
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
+		gve_free_buffer(rx, buf_state);
+		return -EFAULT;
 	}
 
 	/* Sync the portion of dma buffer for CPU to read. */
-	dma_sync_single_range_for_cpu(&priv->pdev->dev, buf_state->addr,
-				      buf_state->page_info.page_offset +
-				      buf_state->page_info.pad,
-				      buf_len, DMA_FROM_DEVICE);
+	gve_dma_sync(priv, rx, buf_state, buf_len);
 
 	/* Append to current skb if one exists. */
 	if (rx->ctx.skb_head) {
@@ -837,7 +861,9 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
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
2.50.0.727.gbf7dc18ff4-goog


