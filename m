Return-Path: <netdev+bounces-172561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DDEA556A4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A243B4450
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09E82702C9;
	Thu,  6 Mar 2025 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGAlAAYU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AE278171;
	Thu,  6 Mar 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289259; cv=none; b=KMHBbZ0I56UWWqc2Su3FlzAd25utGexvrmZwyZBMvu0gL6jJj/CP6CN3kWZik2oAhA/oQiuzmt8mFkHNtJW2j4CrN6gkqzjTGGCdThRhsVkDvLUw6f3piOxyldVyOidGcFajPV4PLSKXue36PiWBnqoXpZQ4iXtnRUJKdXRe8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289259; c=relaxed/simple;
	bh=qBxrRbfa1jMDGB4iPLVEPAtBZ1DWZEQJvNicAcw5R5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/A40WoJ0ViUyGUgN0lcL9KUB98CPDsuMQO56yUYPEboQvyGMjmq5FAvRvTHBjIHnPCxqQ5s+E3mVKmFS/kaLd9GLp4WYKR7mSBz05KPMG2h0l1rrQjxdEPM7HeUVD3Gqrg5NPWMC8RR3PbWQZkduiNhkMDzwiOudw+K9YQcCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGAlAAYU; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f3edbef7d2so361372b6e.2;
        Thu, 06 Mar 2025 11:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289256; x=1741894056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+W4olOQhzQClIpRPGbOJDgouRi53lzaBdLg61HYuAU=;
        b=LGAlAAYUl5Ai+Vm8NybOq1tcCr3fxP9zem5vZDJls5N/9BH4ijHMwoBH9S1h0Or/29
         qf5O3NPD20VS+da0x6sU52LZKdZRAzSQLb6siPK4QmOF5wWsTyx01nF+Q+S8yqTHRAYO
         GxX3d6FixORftPEUDPhcz6PBfhvlhR8/M6uK5Soa1bUH0LNIvsfGrpdWEnIwD8363pas
         yhj1De61RcludzTe75zwzsKo8okj/HNcwQAM1e/NpRSdZ9i4hUi4pTouvQE3lwf3V3sq
         rHcALREnuMEAL445IE2c9sMHHCj3kQJSped6jRDBRdA+Juww5IdOV3WeDfzLqdIiUVlK
         AitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289256; x=1741894056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+W4olOQhzQClIpRPGbOJDgouRi53lzaBdLg61HYuAU=;
        b=sIbCR/++vUpmP83X/5GTDlQLlXIFPWVF6VyMwTSeSACl3EtLh05/2BVGprteaBzRP8
         IgOwGNJ/dj4ZOAdYO6mQFoJN/pJ9zUepQ1+4YFr8+mLdbjm6Zm3OT6io+V+b4wqlpQdd
         /tKRwA8UCSwjtWWAD/HpBBrnvCDqqbOxgQb8JqAH2UNP4C6waVwPackUVPFSIZzBBl6y
         E059gfHg1tk97esuRcb8levzulTxoKr+vqxfIxAPHhU/uU7U2TjSYXOHd86lJQkz0cNT
         IJEH1KS/9TpmUFZqyZP8hAUZRjOsudW6vi/NbvQMPU5OJs8mGEq9egqkWlk1tPU0yPmV
         yoxw==
X-Forwarded-Encrypted: i=1; AJvYcCUBUiJH8NiPBDBD14rtDh1EU3H5F2kmRt1C3tdEVUYP4gAil7be22NCpSbAIKSISy+Z6K+lzfMeMYxNv2A=@vger.kernel.org, AJvYcCXh/4ZpoBnbFG9VSRbSZDV6gBtnsjsuYNnQ2J/K4chP+YZZ2pq7sGSovW/Ct/NFzC7vN5jDsAMl@vger.kernel.org
X-Gm-Message-State: AOJu0YyjOKOEtzak0aRSqR+gzUShBujvAwLv5S3xqFhY0GRpBpTJkFzi
	oP+sVZHE+qewXRgRg9D4TgR60FdgtE3hv+KDKE0/eVgPaIksTuRg
X-Gm-Gg: ASbGncuiHCAeTgg2U5UlJhSYO4RchheNCLi6awFV3lGtfjLog4kQbH5cs0zJPsllh5T
	jApI6CutYDcYf7GdDiot5HfRUfzoc4KSYFGhvnC+uIg9KSQxYT75P7ypgpxqjuFN8OK8SZKytK5
	Sk63K2TmWRT7ru1N3SYPAGSGzDAaW0zN4sSpXFtBiCQhdIZABzv96U2aErl8udEsvx4n3IuPtGW
	B1eoQrX+G1mf6Sjxnv1RNuvzSLym4UCUipo3jBKTxsmPnFctckW58B1qvCrg5DtCSHyLEibF5Zj
	J/zcYUk3az274zFXl28RSVlprwhKK2TeoNIkIaYJ0i7IcrsxP+Ohm8ukA1TGgxxpgqDba6Sh5Tf
	Gj9uNbfMU7cnN
X-Google-Smtp-Source: AGHT+IE8f0m7E2atODzAgr4dH6irh+ChuNSp+rYwZjTe40DEfIoy2pbxWkYzTr5hW8TSXvrnvw87PQ==
X-Received: by 2002:a05:6808:10c6:b0:3f4:91d:2022 with SMTP id 5614622812f47-3f697b4e2a0mr562247b6e.13.1741289256009;
        Thu, 06 Mar 2025 11:27:36 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:34 -0800 (PST)
From: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 06/14] net: bcmgenet: move DESC_INDEX flow to ring 0
Date: Thu,  6 Mar 2025 11:26:34 -0800
Message-Id: <20250306192643.2383632-7-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306192643.2383632-1-opendmb@gmail.com>
References: <20250306192643.2383632-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default transmit and receive packet handling is moved from
the DESC_INDEX (i.e. 16) descriptor rings to the Ring 0 queues.
This saves a fair amount of special case code by unifying the
handling.

A default dummy filter is enabled in the Hardware Filter Block
to route default receive packets to Ring 0.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 369 +++++-------------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  12 +-
 .../ethernet/broadcom/genet/bcmgenet_wol.c    |   4 +-
 3 files changed, 110 insertions(+), 275 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 9aeb1133ffa1..356d100b729d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -41,15 +41,13 @@
 
 #include "bcmgenet.h"
 
-/* Maximum number of hardware queues, downsized if needed */
-#define GENET_MAX_MQ_CNT	4
-
 /* Default highest priority queue for multi queue support */
-#define GENET_Q0_PRIORITY	0
+#define GENET_Q1_PRIORITY	0
+#define GENET_Q0_PRIORITY	1
 
-#define GENET_Q16_RX_BD_CNT	\
+#define GENET_Q0_RX_BD_CNT	\
 	(TOTAL_DESC - priv->hw_params->rx_queues * priv->hw_params->rx_bds_per_q)
-#define GENET_Q16_TX_BD_CNT	\
+#define GENET_Q0_TX_BD_CNT	\
 	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_q)
 
 #define RX_BUF_LENGTH		2048
@@ -607,7 +605,7 @@ static void bcmgenet_hfb_create_rxnfc_filter(struct bcmgenet_priv *priv,
 	u16 mask_16;
 	size_t size;
 
-	f = fs->location;
+	f = fs->location + 1;
 	if (fs->flow_type & FLOW_MAC_EXT) {
 		bcmgenet_hfb_insert_data(priv, f, 0,
 					 &fs->h_ext.h_dest, &fs->m_ext.h_dest,
@@ -689,19 +687,14 @@ static void bcmgenet_hfb_create_rxnfc_filter(struct bcmgenet_priv *priv,
 	}
 
 	bcmgenet_hfb_set_filter_length(priv, f, 2 * f_length);
-	if (!fs->ring_cookie || fs->ring_cookie == RX_CLS_FLOW_WAKE) {
-		/* Ring 0 flows can be handled by the default Descriptor Ring
-		 * We'll map them to ring 0, but don't enable the filter
-		 */
+	if (fs->ring_cookie == RX_CLS_FLOW_WAKE)
 		bcmgenet_hfb_set_filter_rx_queue_mapping(priv, f, 0);
-		rule->state = BCMGENET_RXNFC_STATE_DISABLED;
-	} else {
+	else
 		/* Other Rx rings are direct mapped here */
 		bcmgenet_hfb_set_filter_rx_queue_mapping(priv, f,
 							 fs->ring_cookie);
-		bcmgenet_hfb_enable_filter(priv, f);
-		rule->state = BCMGENET_RXNFC_STATE_ENABLED;
-	}
+	bcmgenet_hfb_enable_filter(priv, f);
+	rule->state = BCMGENET_RXNFC_STATE_ENABLED;
 }
 
 /* bcmgenet_hfb_clear
@@ -735,6 +728,10 @@ static void bcmgenet_hfb_clear(struct bcmgenet_priv *priv)
 
 	for (i = 0; i < priv->hw_params->hfb_filter_cnt; i++)
 		bcmgenet_hfb_clear_filter(priv, i);
+
+	/* Enable filter 0 to send default flow to ring 0 */
+	bcmgenet_hfb_set_filter_length(priv, 0, 4);
+	bcmgenet_hfb_enable_filter(priv, 0);
 }
 
 static void bcmgenet_hfb_init(struct bcmgenet_priv *priv)
@@ -836,20 +833,16 @@ static int bcmgenet_get_coalesce(struct net_device *dev,
 	unsigned int i;
 
 	ec->tx_max_coalesced_frames =
-		bcmgenet_tdma_ring_readl(priv, DESC_INDEX,
-					 DMA_MBUF_DONE_THRESH);
+		bcmgenet_tdma_ring_readl(priv, 0, DMA_MBUF_DONE_THRESH);
 	ec->rx_max_coalesced_frames =
-		bcmgenet_rdma_ring_readl(priv, DESC_INDEX,
-					 DMA_MBUF_DONE_THRESH);
+		bcmgenet_rdma_ring_readl(priv, 0, DMA_MBUF_DONE_THRESH);
 	ec->rx_coalesce_usecs =
-		bcmgenet_rdma_readl(priv, DMA_RING16_TIMEOUT) * 8192 / 1000;
+		bcmgenet_rdma_readl(priv, DMA_RING0_TIMEOUT) * 8192 / 1000;
 
-	for (i = 0; i < priv->hw_params->rx_queues; i++) {
+	for (i = 0; i <= priv->hw_params->rx_queues; i++) {
 		ring = &priv->rx_rings[i];
 		ec->use_adaptive_rx_coalesce |= ring->dim.use_dim;
 	}
-	ring = &priv->rx_rings[DESC_INDEX];
-	ec->use_adaptive_rx_coalesce |= ring->dim.use_dim;
 
 	return 0;
 }
@@ -919,17 +912,13 @@ static int bcmgenet_set_coalesce(struct net_device *dev,
 	/* Program all TX queues with the same values, as there is no
 	 * ethtool knob to do coalescing on a per-queue basis
 	 */
-	for (i = 0; i < priv->hw_params->tx_queues; i++)
+	for (i = 0; i <= priv->hw_params->tx_queues; i++)
 		bcmgenet_tdma_ring_writel(priv, i,
 					  ec->tx_max_coalesced_frames,
 					  DMA_MBUF_DONE_THRESH);
-	bcmgenet_tdma_ring_writel(priv, DESC_INDEX,
-				  ec->tx_max_coalesced_frames,
-				  DMA_MBUF_DONE_THRESH);
 
-	for (i = 0; i < priv->hw_params->rx_queues; i++)
+	for (i = 0; i <= priv->hw_params->rx_queues; i++)
 		bcmgenet_set_ring_rx_coalesce(&priv->rx_rings[i], ec);
-	bcmgenet_set_ring_rx_coalesce(&priv->rx_rings[DESC_INDEX], ec);
 
 	return 0;
 }
@@ -1137,7 +1126,7 @@ static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
 	STAT_GENET_Q(1),
 	STAT_GENET_Q(2),
 	STAT_GENET_Q(3),
-	STAT_GENET_Q(16),
+	STAT_GENET_Q(4),
 };
 
 #define BCMGENET_STATS_LEN	ARRAY_SIZE(bcmgenet_gstrings_stats)
@@ -1489,10 +1478,10 @@ static int bcmgenet_insert_flow(struct net_device *dev,
 		loc_rule = &priv->rxnfc_rules[cmd->fs.location];
 	}
 	if (loc_rule->state == BCMGENET_RXNFC_STATE_ENABLED)
-		bcmgenet_hfb_disable_filter(priv, cmd->fs.location);
+		bcmgenet_hfb_disable_filter(priv, cmd->fs.location + 1);
 	if (loc_rule->state != BCMGENET_RXNFC_STATE_UNUSED) {
 		list_del(&loc_rule->list);
-		bcmgenet_hfb_clear_filter(priv, cmd->fs.location);
+		bcmgenet_hfb_clear_filter(priv, cmd->fs.location + 1);
 	}
 	loc_rule->state = BCMGENET_RXNFC_STATE_UNUSED;
 	memcpy(&loc_rule->fs, &cmd->fs,
@@ -1522,10 +1511,10 @@ static int bcmgenet_delete_flow(struct net_device *dev,
 	}
 
 	if (rule->state == BCMGENET_RXNFC_STATE_ENABLED)
-		bcmgenet_hfb_disable_filter(priv, cmd->fs.location);
+		bcmgenet_hfb_disable_filter(priv, cmd->fs.location + 1);
 	if (rule->state != BCMGENET_RXNFC_STATE_UNUSED) {
 		list_del(&rule->list);
-		bcmgenet_hfb_clear_filter(priv, cmd->fs.location);
+		bcmgenet_hfb_clear_filter(priv, cmd->fs.location + 1);
 	}
 	rule->state = BCMGENET_RXNFC_STATE_UNUSED;
 	memset(&rule->fs, 0, sizeof(struct ethtool_rx_flow_spec));
@@ -1776,18 +1765,6 @@ static struct enet_cb *bcmgenet_put_txcb(struct bcmgenet_priv *priv,
 	return tx_cb_ptr;
 }
 
-static inline void bcmgenet_rx_ring16_int_disable(struct bcmgenet_rx_ring *ring)
-{
-	bcmgenet_intrl2_0_writel(ring->priv, UMAC_IRQ_RXDMA_DONE,
-				 INTRL2_CPU_MASK_SET);
-}
-
-static inline void bcmgenet_rx_ring16_int_enable(struct bcmgenet_rx_ring *ring)
-{
-	bcmgenet_intrl2_0_writel(ring->priv, UMAC_IRQ_RXDMA_DONE,
-				 INTRL2_CPU_MASK_CLEAR);
-}
-
 static inline void bcmgenet_rx_ring_int_disable(struct bcmgenet_rx_ring *ring)
 {
 	bcmgenet_intrl2_1_writel(ring->priv,
@@ -1802,18 +1779,6 @@ static inline void bcmgenet_rx_ring_int_enable(struct bcmgenet_rx_ring *ring)
 				 INTRL2_CPU_MASK_CLEAR);
 }
 
-static inline void bcmgenet_tx_ring16_int_disable(struct bcmgenet_tx_ring *ring)
-{
-	bcmgenet_intrl2_0_writel(ring->priv, UMAC_IRQ_TXDMA_DONE,
-				 INTRL2_CPU_MASK_SET);
-}
-
-static inline void bcmgenet_tx_ring16_int_enable(struct bcmgenet_tx_ring *ring)
-{
-	bcmgenet_intrl2_0_writel(ring->priv, UMAC_IRQ_TXDMA_DONE,
-				 INTRL2_CPU_MASK_CLEAR);
-}
-
 static inline void bcmgenet_tx_ring_int_enable(struct bcmgenet_tx_ring *ring)
 {
 	bcmgenet_intrl2_1_writel(ring->priv, 1 << ring->index,
@@ -1894,12 +1859,7 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
 	struct sk_buff *skb;
 
 	/* Clear status before servicing to reduce spurious interrupts */
-	if (ring->index == DESC_INDEX)
-		bcmgenet_intrl2_0_writel(priv, UMAC_IRQ_TXDMA_DONE,
-					 INTRL2_CPU_CLEAR);
-	else
-		bcmgenet_intrl2_1_writel(priv, (1 << ring->index),
-					 INTRL2_CPU_CLEAR);
+	bcmgenet_intrl2_1_writel(priv, (1 << ring->index), INTRL2_CPU_CLEAR);
 
 	/* Compute how many buffers are transmitted since last xmit call */
 	c_index = bcmgenet_tdma_ring_readl(priv, ring->index, TDMA_CONS_INDEX)
@@ -1933,7 +1893,7 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
 	ring->packets += pkts_compl;
 	ring->bytes += bytes_compl;
 
-	netdev_tx_completed_queue(netdev_get_tx_queue(dev, ring->queue),
+	netdev_tx_completed_queue(netdev_get_tx_queue(dev, ring->index),
 				  pkts_compl, bytes_compl);
 
 	return txbds_processed;
@@ -1961,14 +1921,14 @@ static int bcmgenet_tx_poll(struct napi_struct *napi, int budget)
 	spin_lock(&ring->lock);
 	work_done = __bcmgenet_tx_reclaim(ring->priv->dev, ring);
 	if (ring->free_bds > (MAX_SKB_FRAGS + 1)) {
-		txq = netdev_get_tx_queue(ring->priv->dev, ring->queue);
+		txq = netdev_get_tx_queue(ring->priv->dev, ring->index);
 		netif_tx_wake_queue(txq);
 	}
 	spin_unlock(&ring->lock);
 
 	if (work_done == 0) {
 		napi_complete(napi);
-		ring->int_enable(ring);
+		bcmgenet_tx_ring_int_enable(ring);
 
 		return 0;
 	}
@@ -1979,14 +1939,11 @@ static int bcmgenet_tx_poll(struct napi_struct *napi, int budget)
 static void bcmgenet_tx_reclaim_all(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	int i;
-
-	if (netif_is_multiqueue(dev)) {
-		for (i = 0; i < priv->hw_params->tx_queues; i++)
-			bcmgenet_tx_reclaim(dev, &priv->tx_rings[i]);
-	}
+	int i = 0;
 
-	bcmgenet_tx_reclaim(dev, &priv->tx_rings[DESC_INDEX]);
+	do {
+		bcmgenet_tx_reclaim(dev, &priv->tx_rings[i++]);
+	} while (i <= priv->hw_params->tx_queues && netif_is_multiqueue(dev));
 }
 
 /* Reallocate the SKB to put enough headroom in front of it and insert
@@ -2074,19 +2031,14 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	index = skb_get_queue_mapping(skb);
 	/* Mapping strategy:
-	 * queue_mapping = 0, unclassified, packet xmited through ring16
-	 * queue_mapping = 1, goes to ring 0. (highest priority queue
-	 * queue_mapping = 2, goes to ring 1.
-	 * queue_mapping = 3, goes to ring 2.
-	 * queue_mapping = 4, goes to ring 3.
+	 * queue_mapping = 0, unclassified, packet xmited through ring 0
+	 * queue_mapping = 1, goes to ring 1. (highest priority queue)
+	 * queue_mapping = 2, goes to ring 2.
+	 * queue_mapping = 3, goes to ring 3.
+	 * queue_mapping = 4, goes to ring 4.
 	 */
-	if (index == 0)
-		index = DESC_INDEX;
-	else
-		index -= 1;
-
 	ring = &priv->tx_rings[index];
-	txq = netdev_get_tx_queue(dev, ring->queue);
+	txq = netdev_get_tx_queue(dev, index);
 
 	nr_frags = skb_shinfo(skb)->nr_frags;
 
@@ -2259,15 +2211,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	unsigned int discards;
 
 	/* Clear status before servicing to reduce spurious interrupts */
-	if (ring->index == DESC_INDEX) {
-		bcmgenet_intrl2_0_writel(priv, UMAC_IRQ_RXDMA_DONE,
-					 INTRL2_CPU_CLEAR);
-	} else {
-		mask = 1 << (UMAC_IRQ1_RX_INTR_SHIFT + ring->index);
-		bcmgenet_intrl2_1_writel(priv,
-					 mask,
-					 INTRL2_CPU_CLEAR);
-	}
+	mask = 1 << (UMAC_IRQ1_RX_INTR_SHIFT + ring->index);
+	bcmgenet_intrl2_1_writel(priv, mask, INTRL2_CPU_CLEAR);
 
 	p_index = bcmgenet_rdma_ring_readl(priv, ring->index, RDMA_PROD_INDEX);
 
@@ -2416,7 +2361,7 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
 
 	if (work_done < budget) {
 		napi_complete_done(napi, work_done);
-		ring->int_enable(ring);
+		bcmgenet_rx_ring_int_enable(ring);
 	}
 
 	if (ring->dim.use_dim) {
@@ -2656,15 +2601,6 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 	spin_lock_init(&ring->lock);
 	ring->priv = priv;
 	ring->index = index;
-	if (index == DESC_INDEX) {
-		ring->queue = 0;
-		ring->int_enable = bcmgenet_tx_ring16_int_enable;
-		ring->int_disable = bcmgenet_tx_ring16_int_disable;
-	} else {
-		ring->queue = index + 1;
-		ring->int_enable = bcmgenet_tx_ring_int_enable;
-		ring->int_disable = bcmgenet_tx_ring_int_disable;
-	}
 	ring->cbs = priv->tx_cbs + start_ptr;
 	ring->size = size;
 	ring->clean_ptr = start_ptr;
@@ -2675,8 +2611,8 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 	ring->end_ptr = end_ptr - 1;
 	ring->prod_index = 0;
 
-	/* Set flow period for ring != 16 */
-	if (index != DESC_INDEX)
+	/* Set flow period for ring != 0 */
+	if (index)
 		flow_period_val = ENET_MAX_MTU_SIZE << 16;
 
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_PROD_INDEX);
@@ -2714,13 +2650,6 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
 
 	ring->priv = priv;
 	ring->index = index;
-	if (index == DESC_INDEX) {
-		ring->int_enable = bcmgenet_rx_ring16_int_enable;
-		ring->int_disable = bcmgenet_rx_ring16_int_disable;
-	} else {
-		ring->int_enable = bcmgenet_rx_ring_int_enable;
-		ring->int_disable = bcmgenet_rx_ring_int_disable;
-	}
 	ring->cbs = priv->rx_cbs + start_ptr;
 	ring->size = size;
 	ring->c_index = 0;
@@ -2766,15 +2695,11 @@ static void bcmgenet_enable_tx_napi(struct bcmgenet_priv *priv)
 	unsigned int i;
 	struct bcmgenet_tx_ring *ring;
 
-	for (i = 0; i < priv->hw_params->tx_queues; ++i) {
+	for (i = 0; i <= priv->hw_params->tx_queues; ++i) {
 		ring = &priv->tx_rings[i];
 		napi_enable(&ring->napi);
-		ring->int_enable(ring);
+		bcmgenet_tx_ring_int_enable(ring);
 	}
-
-	ring = &priv->tx_rings[DESC_INDEX];
-	napi_enable(&ring->napi);
-	ring->int_enable(ring);
 }
 
 static void bcmgenet_disable_tx_napi(struct bcmgenet_priv *priv)
@@ -2782,13 +2707,10 @@ static void bcmgenet_disable_tx_napi(struct bcmgenet_priv *priv)
 	unsigned int i;
 	struct bcmgenet_tx_ring *ring;
 
-	for (i = 0; i < priv->hw_params->tx_queues; ++i) {
+	for (i = 0; i <= priv->hw_params->tx_queues; ++i) {
 		ring = &priv->tx_rings[i];
 		napi_disable(&ring->napi);
 	}
-
-	ring = &priv->tx_rings[DESC_INDEX];
-	napi_disable(&ring->napi);
 }
 
 static void bcmgenet_fini_tx_napi(struct bcmgenet_priv *priv)
@@ -2796,33 +2718,31 @@ static void bcmgenet_fini_tx_napi(struct bcmgenet_priv *priv)
 	unsigned int i;
 	struct bcmgenet_tx_ring *ring;
 
-	for (i = 0; i < priv->hw_params->tx_queues; ++i) {
+	for (i = 0; i <= priv->hw_params->tx_queues; ++i) {
 		ring = &priv->tx_rings[i];
 		netif_napi_del(&ring->napi);
 	}
-
-	ring = &priv->tx_rings[DESC_INDEX];
-	netif_napi_del(&ring->napi);
 }
 
 /* Initialize Tx queues
  *
- * Queues 0-3 are priority-based, each one has 32 descriptors,
- * with queue 0 being the highest priority queue.
+ * Queues 1-4 are priority-based, each one has 32 descriptors,
+ * with queue 1 being the highest priority queue.
  *
- * Queue 16 is the default Tx queue with
- * GENET_Q16_TX_BD_CNT = 256 - 4 * 32 = 128 descriptors.
+ * Queue 0 is the default Tx queue with
+ * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 = 128 descriptors.
  *
  * The transmit control block pool is then partitioned as follows:
- * - Tx queue 0 uses tx_cbs[0..31]
- * - Tx queue 1 uses tx_cbs[32..63]
- * - Tx queue 2 uses tx_cbs[64..95]
- * - Tx queue 3 uses tx_cbs[96..127]
- * - Tx queue 16 uses tx_cbs[128..255]
+ * - Tx queue 0 uses tx_cbs[0..127]
+ * - Tx queue 1 uses tx_cbs[128..159]
+ * - Tx queue 2 uses tx_cbs[160..191]
+ * - Tx queue 3 uses tx_cbs[192..223]
+ * - Tx queue 4 uses tx_cbs[224..255]
  */
 static void bcmgenet_init_tx_queues(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
+	unsigned int start = 0, end = GENET_Q0_TX_BD_CNT;
 	u32 i, dma_enable;
 	u32 dma_ctrl, ring_cfg;
 	u32 dma_priority[3] = {0, 0, 0};
@@ -2839,27 +2759,17 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
 	bcmgenet_tdma_writel(priv, DMA_ARBITER_SP, DMA_ARB_CTRL);
 
 	/* Initialize Tx priority queues */
-	for (i = 0; i < priv->hw_params->tx_queues; i++) {
-		bcmgenet_init_tx_ring(priv, i, priv->hw_params->tx_bds_per_q,
-				      i * priv->hw_params->tx_bds_per_q,
-				      (i + 1) * priv->hw_params->tx_bds_per_q);
+	for (i = 0; i <= priv->hw_params->tx_queues; i++) {
+		bcmgenet_init_tx_ring(priv, i, end - start, start, end);
+		start = end;
+		end += priv->hw_params->tx_bds_per_q;
 		ring_cfg |= (1 << i);
 		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
 		dma_priority[DMA_PRIO_REG_INDEX(i)] |=
-			((GENET_Q0_PRIORITY + i) << DMA_PRIO_REG_SHIFT(i));
+			(i ? GENET_Q1_PRIORITY : GENET_Q0_PRIORITY)
+			<< DMA_PRIO_REG_SHIFT(i);
 	}
 
-	/* Initialize Tx default queue 16 */
-	bcmgenet_init_tx_ring(priv, DESC_INDEX, GENET_Q16_TX_BD_CNT,
-			      priv->hw_params->tx_queues *
-			      priv->hw_params->tx_bds_per_q,
-			      TOTAL_DESC);
-	ring_cfg |= (1 << DESC_INDEX);
-	dma_ctrl |= (1 << (DESC_INDEX + DMA_RING_BUF_EN_SHIFT));
-	dma_priority[DMA_PRIO_REG_INDEX(DESC_INDEX)] |=
-		((GENET_Q0_PRIORITY + priv->hw_params->tx_queues) <<
-		 DMA_PRIO_REG_SHIFT(DESC_INDEX));
-
 	/* Set Tx queue priorities */
 	bcmgenet_tdma_writel(priv, dma_priority[0], DMA_PRIORITY_0);
 	bcmgenet_tdma_writel(priv, dma_priority[1], DMA_PRIORITY_1);
@@ -2879,15 +2789,11 @@ static void bcmgenet_enable_rx_napi(struct bcmgenet_priv *priv)
 	unsigned int i;
 	struct bcmgenet_rx_ring *ring;
 
-	for (i = 0; i < priv->hw_params->rx_queues; ++i) {
+	for (i = 0; i <= priv->hw_params->rx_queues; ++i) {
 		ring = &priv->rx_rings[i];
 		napi_enable(&ring->napi);
-		ring->int_enable(ring);
+		bcmgenet_rx_ring_int_enable(ring);
 	}
-
-	ring = &priv->rx_rings[DESC_INDEX];
-	napi_enable(&ring->napi);
-	ring->int_enable(ring);
 }
 
 static void bcmgenet_disable_rx_napi(struct bcmgenet_priv *priv)
@@ -2895,15 +2801,11 @@ static void bcmgenet_disable_rx_napi(struct bcmgenet_priv *priv)
 	unsigned int i;
 	struct bcmgenet_rx_ring *ring;
 
-	for (i = 0; i < priv->hw_params->rx_queues; ++i) {
+	for (i = 0; i <= priv->hw_params->rx_queues; ++i) {
 		ring = &priv->rx_rings[i];
 		napi_disable(&ring->napi);
 		cancel_work_sync(&ring->dim.dim.work);
 	}
-
-	ring = &priv->rx_rings[DESC_INDEX];
-	napi_disable(&ring->napi);
-	cancel_work_sync(&ring->dim.dim.work);
 }
 
 static void bcmgenet_fini_rx_napi(struct bcmgenet_priv *priv)
@@ -2911,13 +2813,10 @@ static void bcmgenet_fini_rx_napi(struct bcmgenet_priv *priv)
 	unsigned int i;
 	struct bcmgenet_rx_ring *ring;
 
-	for (i = 0; i < priv->hw_params->rx_queues; ++i) {
+	for (i = 0; i <= priv->hw_params->rx_queues; ++i) {
 		ring = &priv->rx_rings[i];
 		netif_napi_del(&ring->napi);
 	}
-
-	ring = &priv->rx_rings[DESC_INDEX];
-	netif_napi_del(&ring->napi);
 }
 
 /* Initialize Rx queues
@@ -2925,15 +2824,13 @@ static void bcmgenet_fini_rx_napi(struct bcmgenet_priv *priv)
  * Queues 0-15 are priority queues. Hardware Filtering Block (HFB) can be
  * used to direct traffic to these queues.
  *
- * Queue 16 is the default Rx queue with GENET_Q16_RX_BD_CNT descriptors.
+ * Queue 0 is also the default Rx queue with GENET_Q0_RX_BD_CNT descriptors.
  */
 static int bcmgenet_init_rx_queues(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	u32 i;
-	u32 dma_enable;
-	u32 dma_ctrl;
-	u32 ring_cfg;
+	unsigned int start = 0, end = GENET_Q0_RX_BD_CNT;
+	u32 i, dma_enable, dma_ctrl = 0, ring_cfg = 0;
 	int ret;
 
 	dma_ctrl = bcmgenet_rdma_readl(priv, DMA_CTRL);
@@ -2945,34 +2842,21 @@ static int bcmgenet_init_rx_queues(struct net_device *dev)
 	ring_cfg = 0;
 
 	/* Initialize Rx priority queues */
-	for (i = 0; i < priv->hw_params->rx_queues; i++) {
-		ret = bcmgenet_init_rx_ring(priv, i,
-					    priv->hw_params->rx_bds_per_q,
-					    i * priv->hw_params->rx_bds_per_q,
-					    (i + 1) *
-					    priv->hw_params->rx_bds_per_q);
+	for (i = 0; i <= priv->hw_params->rx_queues; i++) {
+		ret = bcmgenet_init_rx_ring(priv, i, end - start, start, end);
 		if (ret)
 			return ret;
 
+		start = end;
+		end += priv->hw_params->rx_bds_per_q;
 		ring_cfg |= (1 << i);
 		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
 	}
 
-	/* Initialize Rx default queue 16 */
-	ret = bcmgenet_init_rx_ring(priv, DESC_INDEX, GENET_Q16_RX_BD_CNT,
-				    priv->hw_params->rx_queues *
-				    priv->hw_params->rx_bds_per_q,
-				    TOTAL_DESC);
-	if (ret)
-		return ret;
-
-	ring_cfg |= (1 << DESC_INDEX);
-	dma_ctrl |= (1 << (DESC_INDEX + DMA_RING_BUF_EN_SHIFT));
-
-	/* Enable rings */
+	/* Configure Rx queues as descriptor rings */
 	bcmgenet_rdma_writel(priv, ring_cfg, DMA_RING_CFG);
 
-	/* Configure ring as descriptor ring and re-enable DMA if enabled */
+	/* Enable Rx rings */
 	if (dma_enable)
 		dma_ctrl |= DMA_EN;
 	bcmgenet_rdma_writel(priv, dma_ctrl, DMA_CTRL);
@@ -3031,14 +2915,14 @@ static int bcmgenet_dma_teardown(struct bcmgenet_priv *priv)
 	}
 
 	dma_ctrl = 0;
-	for (i = 0; i < priv->hw_params->rx_queues; i++)
+	for (i = 0; i <= priv->hw_params->rx_queues; i++)
 		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
 	reg = bcmgenet_rdma_readl(priv, DMA_CTRL);
 	reg &= ~dma_ctrl;
 	bcmgenet_rdma_writel(priv, reg, DMA_CTRL);
 
 	dma_ctrl = 0;
-	for (i = 0; i < priv->hw_params->tx_queues; i++)
+	for (i = 0; i <= priv->hw_params->tx_queues; i++)
 		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
 	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
 	reg &= ~dma_ctrl;
@@ -3059,14 +2943,11 @@ static void bcmgenet_fini_dma(struct bcmgenet_priv *priv)
 		dev_kfree_skb(bcmgenet_free_tx_cb(&priv->pdev->dev,
 						  priv->tx_cbs + i));
 
-	for (i = 0; i < priv->hw_params->tx_queues; i++) {
-		txq = netdev_get_tx_queue(priv->dev, priv->tx_rings[i].queue);
+	for (i = 0; i <= priv->hw_params->tx_queues; i++) {
+		txq = netdev_get_tx_queue(priv->dev, i);
 		netdev_tx_reset_queue(txq);
 	}
 
-	txq = netdev_get_tx_queue(priv->dev, priv->tx_rings[DESC_INDEX].queue);
-	netdev_tx_reset_queue(txq);
-
 	bcmgenet_free_rx_buffers(priv);
 	kfree(priv->rx_cbs);
 	kfree(priv->tx_cbs);
@@ -3159,7 +3040,7 @@ static void bcmgenet_irq_task(struct work_struct *work)
 
 }
 
-/* bcmgenet_isr1: handle Rx and Tx priority queues */
+/* bcmgenet_isr1: handle Rx and Tx queues */
 static irqreturn_t bcmgenet_isr1(int irq, void *dev_id)
 {
 	struct bcmgenet_priv *priv = dev_id;
@@ -3178,7 +3059,7 @@ static irqreturn_t bcmgenet_isr1(int irq, void *dev_id)
 		  "%s: IRQ=0x%x\n", __func__, status);
 
 	/* Check Rx priority queue interrupts */
-	for (index = 0; index < priv->hw_params->rx_queues; index++) {
+	for (index = 0; index <= priv->hw_params->rx_queues; index++) {
 		if (!(status & BIT(UMAC_IRQ1_RX_INTR_SHIFT + index)))
 			continue;
 
@@ -3186,20 +3067,20 @@ static irqreturn_t bcmgenet_isr1(int irq, void *dev_id)
 		rx_ring->dim.event_ctr++;
 
 		if (likely(napi_schedule_prep(&rx_ring->napi))) {
-			rx_ring->int_disable(rx_ring);
+			bcmgenet_rx_ring_int_disable(rx_ring);
 			__napi_schedule_irqoff(&rx_ring->napi);
 		}
 	}
 
 	/* Check Tx priority queue interrupts */
-	for (index = 0; index < priv->hw_params->tx_queues; index++) {
+	for (index = 0; index <= priv->hw_params->tx_queues; index++) {
 		if (!(status & BIT(index)))
 			continue;
 
 		tx_ring = &priv->tx_rings[index];
 
 		if (likely(napi_schedule_prep(&tx_ring->napi))) {
-			tx_ring->int_disable(tx_ring);
+			bcmgenet_tx_ring_int_disable(tx_ring);
 			__napi_schedule_irqoff(&tx_ring->napi);
 		}
 	}
@@ -3207,12 +3088,10 @@ static irqreturn_t bcmgenet_isr1(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/* bcmgenet_isr0: handle Rx and Tx default queues + other stuff */
+/* bcmgenet_isr0: handle other stuff */
 static irqreturn_t bcmgenet_isr0(int irq, void *dev_id)
 {
 	struct bcmgenet_priv *priv = dev_id;
-	struct bcmgenet_rx_ring *rx_ring;
-	struct bcmgenet_tx_ring *tx_ring;
 	unsigned int status;
 	unsigned long flags;
 
@@ -3226,25 +3105,6 @@ static irqreturn_t bcmgenet_isr0(int irq, void *dev_id)
 	netif_dbg(priv, intr, priv->dev,
 		  "IRQ=0x%x\n", status);
 
-	if (status & UMAC_IRQ_RXDMA_DONE) {
-		rx_ring = &priv->rx_rings[DESC_INDEX];
-		rx_ring->dim.event_ctr++;
-
-		if (likely(napi_schedule_prep(&rx_ring->napi))) {
-			rx_ring->int_disable(rx_ring);
-			__napi_schedule_irqoff(&rx_ring->napi);
-		}
-	}
-
-	if (status & UMAC_IRQ_TXDMA_DONE) {
-		tx_ring = &priv->tx_rings[DESC_INDEX];
-
-		if (likely(napi_schedule_prep(&tx_ring->napi))) {
-			tx_ring->int_disable(tx_ring);
-			__napi_schedule_irqoff(&tx_ring->napi);
-		}
-	}
-
 	if (bcmgenet_has_mdio_intr(priv) &&
 		status & (UMAC_IRQ_MDIO_DONE | UMAC_IRQ_MDIO_ERROR)) {
 		wake_up(&priv->wq);
@@ -3310,15 +3170,15 @@ static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv, bool flush_rx)
 	u32 dma_ctrl;
 
 	/* disable DMA */
-	dma_ctrl = 1 << (DESC_INDEX + DMA_RING_BUF_EN_SHIFT) | DMA_EN;
-	for (i = 0; i < priv->hw_params->tx_queues; i++)
+	dma_ctrl = DMA_EN;
+	for (i = 0; i <= priv->hw_params->tx_queues; i++)
 		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
 	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
 	reg &= ~dma_ctrl;
 	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
 
-	dma_ctrl = 1 << (DESC_INDEX + DMA_RING_BUF_EN_SHIFT) | DMA_EN;
-	for (i = 0; i < priv->hw_params->rx_queues; i++)
+	dma_ctrl = DMA_EN;
+	for (i = 0; i <= priv->hw_params->rx_queues; i++)
 		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
 	reg = bcmgenet_rdma_readl(priv, DMA_CTRL);
 	reg &= ~dma_ctrl;
@@ -3401,6 +3261,9 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_set_hw_addr(priv, dev->dev_addr);
 
+	/* HFB init */
+	bcmgenet_hfb_init(priv);
+
 	/* Disable RX/TX DMA and flush TX and RX queues */
 	dma_ctrl = bcmgenet_dma_disable(priv, true);
 
@@ -3411,12 +3274,8 @@ static int bcmgenet_open(struct net_device *dev)
 		goto err_clk_disable;
 	}
 
-	/* Always enable ring 16 - descriptor ring */
 	bcmgenet_enable_dma(priv, dma_ctrl);
 
-	/* HFB init */
-	bcmgenet_hfb_init(priv);
-
 	ret = request_irq(priv->irq0, bcmgenet_isr0, IRQF_SHARED,
 			  dev->name, priv);
 	if (ret < 0) {
@@ -3523,16 +3382,11 @@ static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
 	if (!netif_msg_tx_err(priv))
 		return;
 
-	txq = netdev_get_tx_queue(priv->dev, ring->queue);
+	txq = netdev_get_tx_queue(priv->dev, ring->index);
 
 	spin_lock(&ring->lock);
-	if (ring->index == DESC_INDEX) {
-		intsts = ~bcmgenet_intrl2_0_readl(priv, INTRL2_CPU_MASK_STATUS);
-		intmsk = UMAC_IRQ_TXDMA_DONE | UMAC_IRQ_TXDMA_MBDONE;
-	} else {
-		intsts = ~bcmgenet_intrl2_1_readl(priv, INTRL2_CPU_MASK_STATUS);
-		intmsk = 1 << ring->index;
-	}
+	intsts = ~bcmgenet_intrl2_1_readl(priv, INTRL2_CPU_MASK_STATUS);
+	intmsk = 1 << ring->index;
 	c_index = bcmgenet_tdma_ring_readl(priv, ring->index, TDMA_CONS_INDEX);
 	p_index = bcmgenet_tdma_ring_readl(priv, ring->index, TDMA_PROD_INDEX);
 	txq_stopped = netif_tx_queue_stopped(txq);
@@ -3546,7 +3400,7 @@ static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
 		  "(sw)c_index: %d (hw)c_index: %d\n"
 		  "(sw)clean_p: %d (sw)write_p: %d\n"
 		  "(sw)cb_ptr: %d (sw)end_ptr: %d\n",
-		  ring->index, ring->queue,
+		  ring->index, ring->index,
 		  txq_stopped ? "stopped" : "active",
 		  intsts & intmsk ? "enabled" : "disabled",
 		  free_bds, ring->size,
@@ -3559,25 +3413,20 @@ static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
 static void bcmgenet_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	u32 int0_enable = 0;
 	u32 int1_enable = 0;
 	unsigned int q;
 
 	netif_dbg(priv, tx_err, dev, "bcmgenet_timeout\n");
 
-	for (q = 0; q < priv->hw_params->tx_queues; q++)
+	for (q = 0; q <= priv->hw_params->tx_queues; q++)
 		bcmgenet_dump_tx_queue(&priv->tx_rings[q]);
-	bcmgenet_dump_tx_queue(&priv->tx_rings[DESC_INDEX]);
 
 	bcmgenet_tx_reclaim_all(dev);
 
-	for (q = 0; q < priv->hw_params->tx_queues; q++)
+	for (q = 0; q <= priv->hw_params->tx_queues; q++)
 		int1_enable |= (1 << q);
 
-	int0_enable = UMAC_IRQ_TXDMA_DONE;
-
 	/* Re-enable TX interrupts if disabled */
-	bcmgenet_intrl2_0_writel(priv, int0_enable, INTRL2_CPU_MASK_CLEAR);
 	bcmgenet_intrl2_1_writel(priv, int1_enable, INTRL2_CPU_MASK_CLEAR);
 
 	netif_trans_update(dev);
@@ -3681,16 +3530,13 @@ static struct net_device_stats *bcmgenet_get_stats(struct net_device *dev)
 	struct bcmgenet_rx_ring *rx_ring;
 	unsigned int q;
 
-	for (q = 0; q < priv->hw_params->tx_queues; q++) {
+	for (q = 0; q <= priv->hw_params->tx_queues; q++) {
 		tx_ring = &priv->tx_rings[q];
 		tx_bytes += tx_ring->bytes;
 		tx_packets += tx_ring->packets;
 	}
-	tx_ring = &priv->tx_rings[DESC_INDEX];
-	tx_bytes += tx_ring->bytes;
-	tx_packets += tx_ring->packets;
 
-	for (q = 0; q < priv->hw_params->rx_queues; q++) {
+	for (q = 0; q <= priv->hw_params->rx_queues; q++) {
 		rx_ring = &priv->rx_rings[q];
 
 		rx_bytes += rx_ring->bytes;
@@ -3698,11 +3544,6 @@ static struct net_device_stats *bcmgenet_get_stats(struct net_device *dev)
 		rx_errors += rx_ring->errors;
 		rx_dropped += rx_ring->dropped;
 	}
-	rx_ring = &priv->rx_rings[DESC_INDEX];
-	rx_bytes += rx_ring->bytes;
-	rx_packets += rx_ring->packets;
-	rx_errors += rx_ring->errors;
-	rx_dropped += rx_ring->dropped;
 
 	dev->stats.tx_bytes = tx_bytes;
 	dev->stats.tx_packets = tx_packets;
@@ -4141,16 +3982,13 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	if (err)
 		goto err_clk_disable;
 
-	/* setup number of real queues  + 1 (GENET_V1 has 0 hardware queues
-	 * just the ring 16 descriptor based TX
-	 */
+	/* setup number of real queues + 1 */
 	netif_set_real_num_tx_queues(priv->dev, priv->hw_params->tx_queues + 1);
 	netif_set_real_num_rx_queues(priv->dev, priv->hw_params->rx_queues + 1);
 
 	/* Set default coalescing parameters */
-	for (i = 0; i < priv->hw_params->rx_queues; i++)
+	for (i = 0; i <= priv->hw_params->rx_queues; i++)
 		priv->rx_rings[i].rx_max_coalesced_frames = 1;
-	priv->rx_rings[DESC_INDEX].rx_max_coalesced_frames = 1;
 
 	/* libphy will determine the link state */
 	netif_carrier_off(dev);
@@ -4273,7 +4111,6 @@ static int bcmgenet_resume(struct device *d)
 		goto out_clk_disable;
 	}
 
-	/* Always enable ring 16 - descriptor ring */
 	bcmgenet_enable_dma(priv, dma_ctrl);
 
 	if (!device_may_wakeup(d))
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index a7f121503ffb..926523d019db 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -18,6 +18,9 @@
 
 #include "../unimac.h"
 
+/* Maximum number of hardware queues, downsized if needed */
+#define GENET_MAX_MQ_CNT	4
+
 /* total number of Buffer Descriptors, same for Rx/Tx */
 #define TOTAL_DESC				256
 
@@ -513,7 +516,6 @@ struct bcmgenet_tx_ring {
 	unsigned long	packets;
 	unsigned long	bytes;
 	unsigned int	index;		/* ring index */
-	unsigned int	queue;		/* queue index */
 	struct enet_cb	*cbs;		/* tx ring buffer control block*/
 	unsigned int	size;		/* size of each tx ring */
 	unsigned int    clean_ptr;      /* Tx ring clean pointer */
@@ -523,8 +525,6 @@ struct bcmgenet_tx_ring {
 	unsigned int	prod_index;	/* Tx ring producer index SW copy */
 	unsigned int	cb_ptr;		/* Tx ring initial CB ptr */
 	unsigned int	end_ptr;	/* Tx ring end CB ptr */
-	void (*int_enable)(struct bcmgenet_tx_ring *);
-	void (*int_disable)(struct bcmgenet_tx_ring *);
 	struct bcmgenet_priv *priv;
 };
 
@@ -553,8 +553,6 @@ struct bcmgenet_rx_ring {
 	struct bcmgenet_net_dim dim;
 	u32		rx_max_coalesced_frames;
 	u32		rx_coalesce_usecs;
-	void (*int_enable)(struct bcmgenet_rx_ring *);
-	void (*int_disable)(struct bcmgenet_rx_ring *);
 	struct bcmgenet_priv *priv;
 };
 
@@ -583,7 +581,7 @@ struct bcmgenet_priv {
 	struct enet_cb *tx_cbs;
 	unsigned int num_tx_bds;
 
-	struct bcmgenet_tx_ring tx_rings[DESC_INDEX + 1];
+	struct bcmgenet_tx_ring tx_rings[GENET_MAX_MQ_CNT + 1];
 
 	/* receive variables */
 	void __iomem *rx_bds;
@@ -593,7 +591,7 @@ struct bcmgenet_priv {
 	struct bcmgenet_rxnfc_rule rxnfc_rules[MAX_NUM_OF_FS_RULES];
 	struct list_head rxnfc_list;
 
-	struct bcmgenet_rx_ring rx_rings[DESC_INDEX + 1];
+	struct bcmgenet_rx_ring rx_rings[GENET_MAX_MQ_CNT + 1];
 
 	/* other misc variables */
 	const struct bcmgenet_hw_params *hw_params;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 3b082114f2e5..f37665ce40cb 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET (Gigabit Ethernet) Wake-on-LAN support
  *
- * Copyright (c) 2014-2024 Broadcom
+ * Copyright (c) 2014-2025 Broadcom
  */
 
 #define pr_fmt(fmt)				"bcmgenet_wol: " fmt
@@ -180,7 +180,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	if (priv->wolopts & WAKE_FILTER) {
 		list_for_each_entry(rule, &priv->rxnfc_list, list)
 			if (rule->fs.ring_cookie == RX_CLS_FLOW_WAKE)
-				hfb_enable |= (1 << rule->fs.location);
+				hfb_enable |= (1 << (rule->fs.location + 1));
 		reg = (hfb_ctrl_reg & ~RBUF_HFB_EN) | RBUF_ACPI_EN;
 		bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
 	}
-- 
2.34.1


