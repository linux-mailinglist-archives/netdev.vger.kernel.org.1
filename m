Return-Path: <netdev+bounces-157759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058B0A0B94D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B433A15BE
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347A8233138;
	Mon, 13 Jan 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJkyLbWd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B71CAA80;
	Mon, 13 Jan 2025 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778059; cv=none; b=EDSR16AeXe9pEr1q0odcibcsXE474Bnss0MdDcabc6Gjfn75Hyp1eBevmLkgK83oMwC+GjfNyeBCePwOr9ZdhmlZiEuwC4c85gudnl3I4499R+y/pIXRkXIbM9ufRZ/APYQzz4pfOz4msOntm0E+5gX6GK8j/jgVRasy8Or1ik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778059; c=relaxed/simple;
	bh=1PVh8C2yjnUHnMVEp1XjPPO2t1Qz//HqdwDj2GiJ0PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JgXDtnBlbWbMgOUaI1+7fSLUdmelCmMNuhdf+GdSdMcZQmmo3fV61W2cAOsdV/krQf+9NMETotUDBzRsykDNxlcpo4/W9gEj2LbpSXCvr5uAI2F8gsYKNku7qgU5K7Ig806mtLdsWvmFRRZZhgcFbxXt2P8p07Nxt6Dx8nBLM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJkyLbWd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163bd70069so78103685ad.0;
        Mon, 13 Jan 2025 06:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736778056; x=1737382856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccKpY1leYRtGPw2tEgtgVTc2GSp/SOKDOJPp9BmSe4Y=;
        b=aJkyLbWdeiaXipoA1CURQJ0xadX9/+3nL8d9MvUIABM+ZMq7RoHZhCKblUCPkimfNr
         xjrVcTxR8ozGZYVzjfcjbje2J0yjknf2etjiUGG+9dgbxXHZDeBBu5ZPtMh+4meBmR5H
         F68ZwzEuq5vKipSQuhoBeQd0eAkm787AWv3kzRLowLTzlWHW8lEOttC0lpfTannZXZbA
         E/lX0Sd6Rj6QUq85RRvrS16u7TreriFINbHpuAVtTA5i1QMhFYGebhmo9R4XZKFexzfx
         DZCayTpBXsFkgSdCiZIH4W+1DgDZKqqOOdCJZhdhqdA4j+dx+JTnrZfoLlqawj5XcX2d
         wohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736778056; x=1737382856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccKpY1leYRtGPw2tEgtgVTc2GSp/SOKDOJPp9BmSe4Y=;
        b=aKBxNRD/aaqfGZF9Rn/a0UPKvbP30KEtHDQebdHDLjmO7KOEO68aFWry/xJs3/ULvP
         Ko22oYcS6jyOyilnn3A5qyUL2mAhbclDmDXs++EMQlXkEp/fJwPJIAq7/Vx2ji+9JGBE
         d7Owf1wVAZ3pQNpkD1c7hS09JVMWadCfXF4stS7J72J8RsMfl69a3Pc15dP7+pPNFMQk
         lGvmHIRpdulW1//AUsLBp3mR/LCuNJ3gDxz2sTOR7MCUwObbyxRTqtAYmTKROyXO3TeJ
         g1Qi/OoC46WJpQRwKTjDiOFAbEE6Ok27Em0MHRTbeqiuVBeI9yJ2jlBJaFfRXakqPGaa
         rQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQSEwkhY12yunj3z5NHgn548Z+Z5+AtMEUzS2Gy3DA6myuHLFiGmTunmBb4pAhLh5G26YResxL2cEMJyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8FY6NZiuKxfQM+ye/vQsGuuAQZltZwPXOjCXW1BG0Fxl03uxC
	mEPp7q3MeQGvRtyGy5mng7QU/JAOv9+xeXODIlHTMl9AgkauR0SbAPQzUw==
X-Gm-Gg: ASbGncslrk5OYNaCv8yjzFEMsQrtn855bqHxj4MV/9Y6GzcMowpk+K7KVB4WtTjNQpp
	DhdFe6/INg7jc3kWvs8hfrAiIXPorLXzj3wyz1dDHIlpCuxX//Fp4/zCrI+q627htXC44olv8RT
	13BebtfevtbSSrT0qDPCoWS+4naa4yubWoAoBYjTtdWDrd4ULpGSif6oA5Nq9gUMVMl0RusYZC1
	S+KzBrfE1gnSYkRHnIzB/4MC1eKdaJW6ZHNyxsxsU5/jPEvNtzXoRAp2OyBu/OJAsNiTw==
X-Google-Smtp-Source: AGHT+IGKv3lMSzF+D1LHruGGkM9/Rgx0EUTXEe4+mf7NCbt27F7Ct+oQGMUGSmcsLeFCk+WT+xqn0A==
X-Received: by 2002:a05:6a21:4a41:b0:1e3:e836:8ad8 with SMTP id adf61e73a8af0-1e88d0ef9f6mr36157231637.38.1736778056233;
        Mon, 13 Jan 2025 06:20:56 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d4067f0d1sm6089222b3a.136.2025.01.13.06.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:20:55 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 1/3] net: stmmac: Switch to zero-copy in non-XDP RX path
Date: Mon, 13 Jan 2025 22:20:29 +0800
Message-Id: <7e7c594913b003b3eb7a836042fe00515421218e.1736777576.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736777576.git.0x1207@gmail.com>
References: <cover.1736777576.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid memcpy in non-XDP RX path by marking all allocated SKBs to
be recycled in the upper network stack.

This patch brings ~11.5% driver performance improvement in a TCP RX
throughput test with iPerf tool on a single isolated Cortex-A65 CPU
core, from 2.18 Gbits/sec increased to 2.43 Gbits/sec.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 26 ++++++++++++-------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index e8dbce20129c..f05cae103d83 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -126,6 +126,7 @@ struct stmmac_rx_queue {
 	unsigned int cur_rx;
 	unsigned int dirty_rx;
 	unsigned int buf_alloc_num;
+	unsigned int napi_skb_frag_size;
 	dma_addr_t dma_rx_phy;
 	u32 rx_tail_addr;
 	unsigned int state_saved;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 58b013528dea..6ec7bc61df9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1330,7 +1330,7 @@ static unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
 	if (stmmac_xdp_is_enabled(priv))
 		return XDP_PACKET_HEADROOM;
 
-	return 0;
+	return NET_SKB_PAD;
 }
 
 static int stmmac_set_bfsize(int mtu, int bufsize)
@@ -2029,17 +2029,21 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	struct stmmac_channel *ch = &priv->channel[queue];
 	bool xdp_prog = stmmac_xdp_is_enabled(priv);
 	struct page_pool_params pp_params = { 0 };
-	unsigned int num_pages;
+	unsigned int dma_buf_sz_pad, num_pages;
 	unsigned int napi_id;
 	int ret;
 
+	dma_buf_sz_pad = stmmac_rx_offset(priv) + dma_conf->dma_buf_sz +
+			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	num_pages = DIV_ROUND_UP(dma_buf_sz_pad, PAGE_SIZE);
+
 	rx_q->queue_index = queue;
 	rx_q->priv_data = priv;
+	rx_q->napi_skb_frag_size = num_pages * PAGE_SIZE;
 
 	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 	pp_params.pool_size = dma_conf->dma_rx_size;
-	num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
-	pp_params.order = ilog2(num_pages);
+	pp_params.order = order_base_2(num_pages);
 	pp_params.nid = dev_to_node(priv->device);
 	pp_params.dev = priv->device;
 	pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
@@ -5574,22 +5578,26 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		}
 
 		if (!skb) {
+			unsigned int head_pad_len;
+
 			/* XDP program may expand or reduce tail */
 			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
 
-			skb = napi_alloc_skb(&ch->rx_napi, buf1_len);
+			skb = napi_build_skb(page_address(buf->page),
+					     rx_q->napi_skb_frag_size);
 			if (!skb) {
+				page_pool_recycle_direct(rx_q->page_pool,
+							 buf->page);
 				rx_dropped++;
 				count++;
 				goto drain_data;
 			}
 
 			/* XDP program may adjust header */
-			skb_copy_to_linear_data(skb, ctx.xdp.data, buf1_len);
+			head_pad_len = ctx.xdp.data - ctx.xdp.data_hard_start;
+			skb_reserve(skb, head_pad_len);
 			skb_put(skb, buf1_len);
-
-			/* Data payload copied into SKB, page ready for recycle */
-			page_pool_recycle_direct(rx_q->page_pool, buf->page);
+			skb_mark_for_recycle(skb);
 			buf->page = NULL;
 		} else if (buf1_len) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,
-- 
2.34.1


