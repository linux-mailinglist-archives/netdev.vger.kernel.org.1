Return-Path: <netdev+bounces-172565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAEBA556AD
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CA0188C026
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B9227C873;
	Thu,  6 Mar 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9XT+Zua"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6427C854;
	Thu,  6 Mar 2025 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289268; cv=none; b=eUfA41LY1ApQ6cFyMJpZKvbOMhDkwLwtUEuw7g+P90egYzMq+f1WZoQ4IkTq/gSnIxVPfpAGQn9H0Sok39lRdG2TlBT7CShp3B23cP5yTSlaIwkib0J9/BhlMVmjNKudoUS1BY+NA77pIAbmA7LZM5YRtC92tKTwjr1/TZbytZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289268; c=relaxed/simple;
	bh=Zj0mTbSprW1K20L9vTB5FmrkKE8hUoyePdrerKHxmYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8F7PRq6M8xg98oWzG+ftVlmAT/hbYj2XYYYgGq+bsvQ2ZcW7Qc54KwuqMIV6sORo0SGaqOuDO66+XJPym20GBO6OeWpmpiEZsOEWFYpRF4mBggPq0vghTChjSnQQJfn7uOQRe4vfPBZhdZ97LePwQ0mB5BKcSIIKsf2EB7jMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9XT+Zua; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72a1011f3b9so425508a34.2;
        Thu, 06 Mar 2025 11:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289266; x=1741894066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgAj3WUGpPr6FmEt9R9RTKm4FaN9NGcDaNky1hr8/WE=;
        b=Y9XT+ZuakelyaQyIHL2er+h1TunFQXZh3OwU7jK0PMCH0T1e+FmYRmWf43mWvkcyI5
         Jgc3zvOotCcLC5paAJ7dwcy7kouzOpBDXI9kd10AVGts9DZAcI5nj91NnVhMd5kjR6Ew
         Krhwwn/U7LKz0TiY/9YMOtrF5NdvCfOvILKeCRYvOt8rRwZUoxx4awVaaQQIiW19b67C
         6PC0qQyBm1awyf1wR53ob8ty0OmYPTMCkPv3WI9Ty25kzBll8hadihZc7kejWL15ipmW
         dgXqbfKPJirE86npqFU9ah7VguDFMTyRNvi7WuPo/tQDpW0WY5DSE/M369ysnNOqcoN7
         uBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289266; x=1741894066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgAj3WUGpPr6FmEt9R9RTKm4FaN9NGcDaNky1hr8/WE=;
        b=iweNV/gYSi2X4BuS4dC3MgOrJXkdw+jhio0yfI2Wylcnn4UtRHlG8GF54pm9ntTPRm
         yKdek0duTMyKM8tQzCEsIjgdoStl3Pg0hiIHkS28enwiYU/WtO/RG6gnAqG9de+6h6se
         TSVymhNuU4t9cWJWFb5gejgFv5/aCfdVvVTKkj1ZpSVUckLVVNJ0YoIt7vdzZhT50Vca
         0OxR6imkCfMXrvjEmmKgqokJh6bbhwRkp66X21nWQCBVNVFGOHh6zFFkqs/zFm4Zsbf9
         NaWEK0HQCWdmaSSC85OEU+OoqfG4tNR1MjS+kyMmTczS952p7LXdTPZ9JjI17lTs9LJl
         LZuw==
X-Forwarded-Encrypted: i=1; AJvYcCVDrpq0H0wQtEloFqazeA6ON7LW6jBHZouQqgnOW7twHv+5+0Y99WI9LzricB0UlAvoUczjjAqB@vger.kernel.org, AJvYcCVkl0agUErDb12Xa56LZQiKMVVjEl328KCM8pDprovK9YFc5OupuKv42Ii53TWfNnscsdg92ie9izoQwPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBZGdb58pGePc1CeSQurZaGoaqwwekhs76t83ziKSpiTDBdB4
	f48xl3itEpyYW4GAQFfQXVx+kNnQOMJ+QlyrSe+WvJ/MuYU9lG5N
X-Gm-Gg: ASbGncvcWIaW2Ubo/M/ahVXCuadis+HqxUIzD1nyK5HjiVJF+5zbJGN45vMN7ClzUVw
	adl54mK2C5XDA9Ue1SCdYK4OQXs3bJI2FL9M6b57MlKlisWOmb0wdIv6b7DOx1cpzmp+siy41cb
	FLsv9GeoxY0Pny82tmDj2ZvHxXsUwWDFAQld7yP13ejM+DkZamC6QshHFAGTv2kXiO4pb+H1cmk
	TzKFK4El6jGOER7Efgt1IR60pFAD58h4BmBP1i1j+81u3rHj9ZTFrgak3wZVdS/oLb1aFbz9WFA
	LznIM6ioyGS51fyN3UlMrMbk/lKCTEsUjHkI9xubtBhmCHnh37DAZKoyXZwYaxORyMffdZvPPxH
	fbuMIadIM6GOR
X-Google-Smtp-Source: AGHT+IG5Od6NL8OcZyuMy8Ppw+OPc6VCptaNnyQ7oUxFjsnSaSj3FRGFNaxY7iYy3D9cMoypzjizlg==
X-Received: by 2002:a05:6830:6dc3:b0:727:3899:11e4 with SMTP id 46e09a7af769-72a37c64014mr286320a34.24.1741289266172;
        Thu, 06 Mar 2025 11:27:46 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:45 -0800 (PST)
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
Subject: [PATCH net-next 10/14] net: bcmgenet: introduce bcmgenet_[r|t]dma_disable
Date: Thu,  6 Mar 2025 11:26:38 -0800
Message-Id: <20250306192643.2383632-11-opendmb@gmail.com>
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

The bcmgenet_rdma_disable and bcmgenet_tdma_disable functions
are introduced to provide a common method for disabling each
dma and the code is simplified.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 123 +++++++++---------
 1 file changed, 62 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index ca936a7e7753..38943bbc35b1 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2727,6 +2727,52 @@ static void bcmgenet_fini_tx_napi(struct bcmgenet_priv *priv)
 	}
 }
 
+static int bcmgenet_tdma_disable(struct bcmgenet_priv *priv)
+{
+	int timeout = 0;
+	u32 reg, mask;
+
+	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
+	mask = (1 << (priv->hw_params->tx_queues + 1)) - 1;
+	mask = (mask << DMA_RING_BUF_EN_SHIFT) | DMA_EN;
+	reg &= ~mask;
+	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
+
+	/* Check DMA status register to confirm DMA is disabled */
+	while (timeout++ < DMA_TIMEOUT_VAL) {
+		reg = bcmgenet_tdma_readl(priv, DMA_STATUS);
+		if ((reg & mask) == mask)
+			return 0;
+
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int bcmgenet_rdma_disable(struct bcmgenet_priv *priv)
+{
+	int timeout = 0;
+	u32 reg, mask;
+
+	reg = bcmgenet_rdma_readl(priv, DMA_CTRL);
+	mask = (1 << (priv->hw_params->rx_queues + 1)) - 1;
+	mask = (mask << DMA_RING_BUF_EN_SHIFT) | DMA_EN;
+	reg &= ~mask;
+	bcmgenet_rdma_writel(priv, reg, DMA_CTRL);
+
+	/* Check DMA status register to confirm DMA is disabled */
+	while (timeout++ < DMA_TIMEOUT_VAL) {
+		reg = bcmgenet_rdma_readl(priv, DMA_STATUS);
+		if ((reg & mask) == mask)
+			return 0;
+
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
 /* Initialize Tx queues
  *
  * Queues 1-4 are priority-based, each one has 32 descriptors,
@@ -2848,26 +2894,9 @@ static int bcmgenet_init_rx_queues(struct net_device *dev)
 static int bcmgenet_dma_teardown(struct bcmgenet_priv *priv)
 {
 	int ret = 0;
-	int timeout = 0;
-	u32 reg;
-	u32 dma_ctrl;
-	int i;
 
 	/* Disable TDMA to stop add more frames in TX DMA */
-	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
-	reg &= ~DMA_EN;
-	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
-
-	/* Check TDMA status register to confirm TDMA is disabled */
-	while (timeout++ < DMA_TIMEOUT_VAL) {
-		reg = bcmgenet_tdma_readl(priv, DMA_STATUS);
-		if (reg & DMA_DISABLED)
-			break;
-
-		udelay(1);
-	}
-
-	if (timeout == DMA_TIMEOUT_VAL) {
+	if (-ETIMEDOUT == bcmgenet_tdma_disable(priv)) {
 		netdev_warn(priv->dev, "Timed out while disabling TX DMA\n");
 		ret = -ETIMEDOUT;
 	}
@@ -2876,39 +2905,11 @@ static int bcmgenet_dma_teardown(struct bcmgenet_priv *priv)
 	usleep_range(10000, 20000);
 
 	/* Disable RDMA */
-	reg = bcmgenet_rdma_readl(priv, DMA_CTRL);
-	reg &= ~DMA_EN;
-	bcmgenet_rdma_writel(priv, reg, DMA_CTRL);
-
-	timeout = 0;
-	/* Check RDMA status register to confirm RDMA is disabled */
-	while (timeout++ < DMA_TIMEOUT_VAL) {
-		reg = bcmgenet_rdma_readl(priv, DMA_STATUS);
-		if (reg & DMA_DISABLED)
-			break;
-
-		udelay(1);
-	}
-
-	if (timeout == DMA_TIMEOUT_VAL) {
+	if (-ETIMEDOUT == bcmgenet_rdma_disable(priv)) {
 		netdev_warn(priv->dev, "Timed out while disabling RX DMA\n");
 		ret = -ETIMEDOUT;
 	}
 
-	dma_ctrl = 0;
-	for (i = 0; i <= priv->hw_params->rx_queues; i++)
-		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
-	reg = bcmgenet_rdma_readl(priv, DMA_CTRL);
-	reg &= ~dma_ctrl;
-	bcmgenet_rdma_writel(priv, reg, DMA_CTRL);
-
-	dma_ctrl = 0;
-	for (i = 0; i <= priv->hw_params->tx_queues; i++)
-		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
-	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
-	reg &= ~dma_ctrl;
-	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
-
 	return ret;
 }
 
@@ -2938,27 +2939,27 @@ static void bcmgenet_fini_dma(struct bcmgenet_priv *priv)
 static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
 {
 	struct enet_cb *cb;
-	u32 reg, dma_ctrl;
 	unsigned int i;
 	int ret;
+	u32 reg;
 
 	netif_dbg(priv, hw, priv->dev, "%s\n", __func__);
 
-	/* Disable RX/TX DMA and flush TX queues */
-	dma_ctrl = 1 << (DESC_INDEX + DMA_RING_BUF_EN_SHIFT) | DMA_EN;
-	for (i = 0; i < priv->hw_params->tx_queues; i++)
-		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
-	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
-	reg &= ~dma_ctrl;
-	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
+	/* Disable TX DMA */
+	ret = bcmgenet_tdma_disable(priv);
+	if (ret) {
+		netdev_err(priv->dev, "failed to halt Tx DMA\n");
+		return ret;
+	}
 
-	dma_ctrl = 1 << (DESC_INDEX + DMA_RING_BUF_EN_SHIFT) | DMA_EN;
-	for (i = 0; i < priv->hw_params->rx_queues; i++)
-		dma_ctrl |= (1 << (i + DMA_RING_BUF_EN_SHIFT));
-	reg = bcmgenet_rdma_readl(priv, DMA_CTRL);
-	reg &= ~dma_ctrl;
-	bcmgenet_rdma_writel(priv, reg, DMA_CTRL);
+	/* Disable RX DMA */
+	ret = bcmgenet_rdma_disable(priv);
+	if (ret) {
+		netdev_err(priv->dev, "failed to halt Rx DMA\n");
+		return ret;
+	}
 
+	/* Flush TX queues */
 	bcmgenet_umac_writel(priv, 1, UMAC_TX_FLUSH);
 	udelay(10);
 	bcmgenet_umac_writel(priv, 0, UMAC_TX_FLUSH);
-- 
2.34.1


