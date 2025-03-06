Return-Path: <netdev+bounces-172564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3DCA556AB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1FA3B402B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8A627C84A;
	Thu,  6 Mar 2025 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5sDdk+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83D327C15B;
	Thu,  6 Mar 2025 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289266; cv=none; b=brrtra8jTpWxHjcffpfPd3ziE1g5yqXMl4mNbeCEpY3vd0LE1dzgRGnw1rjpb8KmD4l/yfnSNomGaaC0XudtirTnPz4X6ZdphUhHG+E+oesKCCGzDhdsU3dMLcUWBDvt6twJ3pN8MjGvoKLXyXxMdcoz/tvQijYqD6yjzEqlV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289266; c=relaxed/simple;
	bh=cDQBUZ4vsh0uEqo//EJmBSnxR24vO41IdLmkwkJ3UEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITXdchb1+PDd3ifqlMM2Z+5TbokzndGI7f1wX0RX9T9M2bXVbdWR3WwMOwpPnzjkp3eZYuAn0bSiu2js1loPg6bdctXV/u4g8wiuwGfBTBZ/34yN7wC5fJRe8GbnpEn6AF1pZ0LqDyDgqZ+q5xzf2v8A5bEISAzSqYORMZkumcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5sDdk+e; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72a145521d6so693753a34.3;
        Thu, 06 Mar 2025 11:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289264; x=1741894064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK0HGLfFBpaEaEqoY3z8srPfy6JhsjSNgjSfTR05B2A=;
        b=k5sDdk+ergmxYUnke1MpWqUgnfjFkEaqbow9s1GxBfU8KDLZP61AbzKVe6kF74Bv/Z
         e+1f1HBT/mExdvPqaT2DRAoDVrJjCEznV9snOHcenxjuprmPACUH8e4PNntR6Pvvs3Vx
         P8mRtvvUlj39zUhvD7OfuydGWM0mcoeFWv0IITWaN/DjiWoOIc9QWLjW8zGyilqmtuKv
         tUYI2Wxe9/qbSiSuUYdeRu4P3BJqIwCa/vlkptPF6NISXK6cpGckAV8mz+FoAdj8mwOr
         Ct2xr2I8Pmhfd13OpkIxadK/qrZDDfSonBRVUBo2N+RbXJeGHhEQbW0+h26U1UhK3h4S
         UBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289264; x=1741894064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YK0HGLfFBpaEaEqoY3z8srPfy6JhsjSNgjSfTR05B2A=;
        b=LhhrcZ6uwgRKvYsTgomZPzXRsaQV4i4fCQHXYdWSOrc9DXz0ssPVyq4fT3u/VlkKAy
         DZTU4LPCtkeI8PQ5D4hmIl9uq5JKzCrGC6RPx8ax99Ls/Ujjz3OW09ZAU5o+dKpYWlpv
         prHKSnEFFgTftn1mysPcFdT7WXerZ2DWPfx74T0IExFyZpwIwwCyDT60TFLnIk4NVlp+
         MgYI55zD4lRLbZgLQH73+/0rXHr6bQ2YxlDzW3l3wtQcvDU+NKNdlGJtCu26NEIQ394K
         6QVgE2c55b+mXwN9Gk6qL4c1Wibce7DtAEodmibwqHFpiOWwm43niB+hYhghc04qAytt
         cFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQav9P7YtaiVBTtZRtQTZYl+FhzePHhIbBTpXo3dosI7mH21iuvPTqgS2GVxoE1lXq2PtIg+Lb@vger.kernel.org, AJvYcCW3KXBXMindJ3LkEfRlIJs7r+8i3sjegmVSRapqhx4Ac8pd0UT2nq8qqUQyLbjOV7CbW93sMK5yZnxGHSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRSqInyiqqdcKQ2xLIIK5E7V9qIr4t/C65Iq5Wc47M6zTgW9GA
	Bk6dQssoyZvPWjfy9/a0OGeXg4eEzUx2M9JJJVk+P2dhg5WG+TdErOHGVg==
X-Gm-Gg: ASbGncsQlmgw8Dn6WLZlRinqji9Uc/dlLvAoAAFlQMh3n7ZvUAu069hsyUJgvPr0MSo
	IYwBWD5bjuASiuNLIW4Wwv2cDp7Id7ktsWQ5M1+uk0O3BpE+PqWymlwbrmDGEOkLMp0Ak++KNND
	2EW++1xLq6h6pB4uYLpjJX/MVx2FOCCaQiNEZB3EcBqfCbWOQ+ihStLhja57i2LuIolv1OL2TkF
	LudUDzTByG3jvGjr2DOBuGVRAqGy+fIcAnOHci0E9uIn6yJ3MNtnYkM8stptMJIJkWfHLOwz+Hl
	UQJvWO13NDbrZGje0rD3dKFp0b7UCEQS1TpjVi4xDdM07wylKnCv+tAPDOvSfq9wewR1YQ7rrSC
	1qoQucPviFE0E
X-Google-Smtp-Source: AGHT+IHj+nGMSb1hday2p6jieEvSWrklRXCokM4eW0XYruxL28Iw1APbNwm4atQxfoHuRG2uKpLnHA==
X-Received: by 2002:a05:6830:6f42:b0:72a:1648:445b with SMTP id 46e09a7af769-72a37b3deabmr271693a34.1.1741289263655;
        Thu, 06 Mar 2025 11:27:43 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:42 -0800 (PST)
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
Subject: [PATCH net-next 09/14] net: bcmgenet: consolidate dma initialization
Date: Thu,  6 Mar 2025 11:26:37 -0800
Message-Id: <20250306192643.2383632-10-opendmb@gmail.com>
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

The functions bcmgenet_dma_disable and bcmgenet_enable_dma are
only used as part of dma initialization. Their functionality is
moved inside bcmgenet_init_dma and the functions are removed.

Since the dma is always disabled inside of bcmgenet_init_dma,
the initialization functions bcmgenet_init_rx_queues and
bcmgenet_init_tx_queues no longer need to attempt to manage its
state.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 150 +++++++-----------
 1 file changed, 54 insertions(+), 96 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 56fe4526c479..ca936a7e7753 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2746,17 +2746,7 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	unsigned int start = 0, end = GENET_Q0_TX_BD_CNT;
-	u32 i, dma_enable;
-	u32 dma_ctrl, ring_cfg;
-	u32 dma_priority[3] = {0, 0, 0};
-
-	dma_ctrl = bcmgenet_tdma_readl(priv, DMA_CTRL);
-	dma_enable = dma_ctrl & DMA_EN;
-	dma_ctrl &= ~DMA_EN;
-	bcmgenet_tdma_writel(priv, dma_ctrl, DMA_CTRL);
-
-	dma_ctrl = 0;
-	ring_cfg = 0;
+	u32 i, ring_mask, dma_priority[3] = {0, 0, 0};
 
 	/* Enable strict priority arbiter mode */
 	bcmgenet_tdma_writel(priv, DMA_ARBITER_SP, DMA_ARB_CTRL);
@@ -2766,8 +2756,6 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
 		bcmgenet_init_tx_ring(priv, i, end - start, start, end);
 		start = end;
 		end += priv->hw_params->tx_bds_per_q;
-		ring_cfg |= (1 << i);
-		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
 		dma_priority[DMA_PRIO_REG_INDEX(i)] |=
 			(i ? GENET_Q1_PRIORITY : GENET_Q0_PRIORITY)
 			<< DMA_PRIO_REG_SHIFT(i);
@@ -2778,13 +2766,13 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
 	bcmgenet_tdma_writel(priv, dma_priority[1], DMA_PRIORITY_1);
 	bcmgenet_tdma_writel(priv, dma_priority[2], DMA_PRIORITY_2);
 
-	/* Enable Tx queues */
-	bcmgenet_tdma_writel(priv, ring_cfg, DMA_RING_CFG);
+	/* Configure Tx queues as descriptor rings */
+	ring_mask = (1 << (priv->hw_params->tx_queues + 1)) - 1;
+	bcmgenet_tdma_writel(priv, ring_mask, DMA_RING_CFG);
 
-	/* Enable Tx DMA */
-	if (dma_enable)
-		dma_ctrl |= DMA_EN;
-	bcmgenet_tdma_writel(priv, dma_ctrl, DMA_CTRL);
+	/* Enable Tx rings */
+	ring_mask <<= DMA_RING_BUF_EN_SHIFT;
+	bcmgenet_tdma_writel(priv, ring_mask, DMA_CTRL);
 }
 
 static void bcmgenet_enable_rx_napi(struct bcmgenet_priv *priv)
@@ -2833,17 +2821,9 @@ static int bcmgenet_init_rx_queues(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	unsigned int start = 0, end = GENET_Q0_RX_BD_CNT;
-	u32 i, dma_enable, dma_ctrl = 0, ring_cfg = 0;
+	u32 i, ring_mask;
 	int ret;
 
-	dma_ctrl = bcmgenet_rdma_readl(priv, DMA_CTRL);
-	dma_enable = dma_ctrl & DMA_EN;
-	dma_ctrl &= ~DMA_EN;
-	bcmgenet_rdma_writel(priv, dma_ctrl, DMA_CTRL);
-
-	dma_ctrl = 0;
-	ring_cfg = 0;
-
 	/* Initialize Rx priority queues */
 	for (i = 0; i <= priv->hw_params->rx_queues; i++) {
 		ret = bcmgenet_init_rx_ring(priv, i, end - start, start, end);
@@ -2852,17 +2832,15 @@ static int bcmgenet_init_rx_queues(struct net_device *dev)
 
 		start = end;
 		end += priv->hw_params->rx_bds_per_q;
-		ring_cfg |= (1 << i);
-		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
 	}
 
 	/* Configure Rx queues as descriptor rings */
-	bcmgenet_rdma_writel(priv, ring_cfg, DMA_RING_CFG);
+	ring_mask = (1 << (priv->hw_params->rx_queues + 1)) - 1;
+	bcmgenet_rdma_writel(priv, ring_mask, DMA_RING_CFG);
 
 	/* Enable Rx rings */
-	if (dma_enable)
-		dma_ctrl |= DMA_EN;
-	bcmgenet_rdma_writel(priv, dma_ctrl, DMA_CTRL);
+	ring_mask <<= DMA_RING_BUF_EN_SHIFT;
+	bcmgenet_rdma_writel(priv, ring_mask, DMA_CTRL);
 
 	return 0;
 }
@@ -2957,14 +2935,42 @@ static void bcmgenet_fini_dma(struct bcmgenet_priv *priv)
 }
 
 /* init_edma: Initialize DMA control register */
-static int bcmgenet_init_dma(struct bcmgenet_priv *priv)
+static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
 {
-	int ret;
-	unsigned int i;
 	struct enet_cb *cb;
+	u32 reg, dma_ctrl;
+	unsigned int i;
+	int ret;
 
 	netif_dbg(priv, hw, priv->dev, "%s\n", __func__);
 
+	/* Disable RX/TX DMA and flush TX queues */
+	dma_ctrl = 1 << (DESC_INDEX + DMA_RING_BUF_EN_SHIFT) | DMA_EN;
+	for (i = 0; i < priv->hw_params->tx_queues; i++)
+		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
+	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
+	reg &= ~dma_ctrl;
+	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
+
+	dma_ctrl = 1 << (DESC_INDEX + DMA_RING_BUF_EN_SHIFT) | DMA_EN;
+	for (i = 0; i < priv->hw_params->rx_queues; i++)
+		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
+	reg = bcmgenet_rdma_readl(priv, DMA_CTRL);
+	reg &= ~dma_ctrl;
+	bcmgenet_rdma_writel(priv, reg, DMA_CTRL);
+
+	bcmgenet_umac_writel(priv, 1, UMAC_TX_FLUSH);
+	udelay(10);
+	bcmgenet_umac_writel(priv, 0, UMAC_TX_FLUSH);
+
+	if (flush_rx) {
+		reg = bcmgenet_rbuf_ctrl_get(priv);
+		bcmgenet_rbuf_ctrl_set(priv, reg | BIT(0));
+		udelay(10);
+		bcmgenet_rbuf_ctrl_set(priv, reg);
+		udelay(10);
+	}
+
 	/* Initialize common Rx ring structures */
 	priv->rx_bds = priv->base + priv->hw_params->rdma_offset;
 	priv->num_rx_bds = TOTAL_DESC;
@@ -3014,6 +3020,15 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv)
 	/* Initialize Tx queues */
 	bcmgenet_init_tx_queues(priv->dev);
 
+	/* Enable RX/TX DMA */
+	reg = bcmgenet_rdma_readl(priv, DMA_CTRL);
+	reg |= DMA_EN;
+	bcmgenet_rdma_writel(priv, reg, DMA_CTRL);
+
+	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
+	reg |= DMA_EN;
+	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
+
 	return 0;
 }
 
@@ -3165,53 +3180,6 @@ static void bcmgenet_get_hw_addr(struct bcmgenet_priv *priv,
 	put_unaligned_be16(addr_tmp, &addr[4]);
 }
 
-static void bcmgenet_dma_disable(struct bcmgenet_priv *priv, bool flush_rx)
-{
-	unsigned int i;
-	u32 reg;
-	u32 dma_ctrl;
-
-	/* disable DMA */
-	dma_ctrl = DMA_EN;
-	for (i = 0; i <= priv->hw_params->tx_queues; i++)
-		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
-	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
-	reg &= ~dma_ctrl;
-	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
-
-	dma_ctrl = DMA_EN;
-	for (i = 0; i <= priv->hw_params->rx_queues; i++)
-		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
-	reg = bcmgenet_rdma_readl(priv, DMA_CTRL);
-	reg &= ~dma_ctrl;
-	bcmgenet_rdma_writel(priv, reg, DMA_CTRL);
-
-	bcmgenet_umac_writel(priv, 1, UMAC_TX_FLUSH);
-	udelay(10);
-	bcmgenet_umac_writel(priv, 0, UMAC_TX_FLUSH);
-
-	if (flush_rx) {
-		reg = bcmgenet_rbuf_ctrl_get(priv);
-		bcmgenet_rbuf_ctrl_set(priv, reg | BIT(0));
-		udelay(10);
-		bcmgenet_rbuf_ctrl_set(priv, reg);
-		udelay(10);
-	}
-}
-
-static void bcmgenet_enable_dma(struct bcmgenet_priv *priv)
-{
-	u32 reg;
-
-	reg = bcmgenet_rdma_readl(priv, DMA_CTRL);
-	reg |= DMA_EN;
-	bcmgenet_rdma_writel(priv, reg, DMA_CTRL);
-
-	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
-	reg |= DMA_EN;
-	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
-}
-
 static void bcmgenet_netif_start(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
@@ -3263,18 +3231,13 @@ static int bcmgenet_open(struct net_device *dev)
 	/* HFB init */
 	bcmgenet_hfb_init(priv);
 
-	/* Disable RX/TX DMA and flush TX and RX queues */
-	bcmgenet_dma_disable(priv, true);
-
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
-	ret = bcmgenet_init_dma(priv);
+	ret = bcmgenet_init_dma(priv, true);
 	if (ret) {
 		netdev_err(dev, "failed to initialize DMA\n");
 		goto err_clk_disable;
 	}
 
-	bcmgenet_enable_dma(priv);
-
 	ret = request_irq(priv->irq0, bcmgenet_isr0, IRQF_SHARED,
 			  dev->name, priv);
 	if (ret < 0) {
@@ -4099,18 +4062,13 @@ static int bcmgenet_resume(struct device *d)
 		if (rule->state != BCMGENET_RXNFC_STATE_UNUSED)
 			bcmgenet_hfb_create_rxnfc_filter(priv, rule);
 
-	/* Disable RX/TX DMA and flush TX queues */
-	bcmgenet_dma_disable(priv, false);
-
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
-	ret = bcmgenet_init_dma(priv);
+	ret = bcmgenet_init_dma(priv, false);
 	if (ret) {
 		netdev_err(dev, "failed to initialize DMA\n");
 		goto out_clk_disable;
 	}
 
-	bcmgenet_enable_dma(priv);
-
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
 
-- 
2.34.1


