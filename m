Return-Path: <netdev+bounces-209900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D1AB11412
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4F55A7787
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 22:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A32472A8;
	Thu, 24 Jul 2025 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="VBQeiAWG"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3F246790;
	Thu, 24 Jul 2025 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396441; cv=none; b=O4MAimo0p3efG+pfIN+sq4ISV/GDzgaaJxZrkdlPmqZeoexUaa7bA6GXrU4AsWxl7l8/hDBZrABDSCEcDUMISiG/z0EO6i7JhOrh1FxCza+Xf7XmKow014d+gcrn6+XW3/K705yBiunPp0wnOjUHv1KEX9Utx6tRCMGP1Or+VCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396441; c=relaxed/simple;
	bh=cEAXnyHyU5m3CRnZvH3sSpLvnNpddGJiK1QZxdMvYfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iG9wXfkQUOFgLUHH/xKPH+AD8VJHPnet6EvdPzEDNpvK7y9NktqpZdEnsrobAw6ozua9F3egBg0lesv7cMB6fdtw2ByhtDLSEUqZHjafqwZghFUgZluxi72q8Ms/cfc71WsDO4CExVXZ4HB9+eCX9WHrgNILOGWcyKauh1a2Xew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=VBQeiAWG; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD94510391E87;
	Fri, 25 Jul 2025 00:33:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753396437; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=hM+v370wtickq5V8CQzPOHaBm83ZWdcg4XkbnFyIoGI=;
	b=VBQeiAWGFaEgDpAEadMAlG/AGpg4LOTVWxtyeX5ETxFrAkcyuF0J+0MQY/nL78s/ZXC2/d
	R7yYFhbM4hIN4hWjF0bgmeI6egxTChBipr/Z3iD4AF/3dpkHparIVz7nVBq6gV7Zey0oN/
	2aKLKvix+3ZIfKRXAMxKDj4r+k4FUi5GavcO8ZTrG+cb1Rv0y5pz/bk2CkHSga2hTer+k4
	p3e6i7Eh/kbQ0WsH3Rpzjztjbi626EUXzVAQa57DLrEv45rJzGXimaXpv2vKdxULrVhsrk
	04Hpfx7tb7s5I/abaM9pn870hdIiGinfl9Bepzsdp93OgOnMD6tAfy26i9Em6A==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next v16 05/12] net: mtip: Add buffers management functions to the L2 switch driver
Date: Fri, 25 Jul 2025 00:33:11 +0200
Message-Id: <20250724223318.3068984-6-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724223318.3068984-1-lukma@denx.de>
References: <20250724223318.3068984-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch provides buffers management funcions' content for MTIP
L2 switch.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v14:
- New patch - created by excluding some code from large (i.e. v13
  and earlier) MTIP driver

Changes for v15 - v16:
- None
---
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 3a37d7308712..a4668047ed11 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -870,11 +870,96 @@ static void mtip_get_drvinfo(struct net_device *dev,
 
 static void mtip_free_buffers(struct net_device *dev)
 {
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	int i;
+
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		page_pool_put_full_page(fep->page_pool,
+					fep->page[i], false);
+		fep->page[i] = NULL;
+	}
+
+	page_pool_destroy(fep->page_pool);
+	fep->page_pool = NULL;
+
+	for (i = 0; i < TX_RING_SIZE; i++)
+		kfree(fep->tx_bounce[i]);
+}
+
+static int mtip_create_page_pool(struct switch_enet_private *fep, int size)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = size,
+		.nid = dev_to_node(&fep->pdev->dev),
+		.dev = &fep->pdev->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.offset = 0,
+		.max_len = MTIP_SWITCH_RX_FRSIZE,
+	};
+	int ret = 0;
+
+	fep->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(fep->page_pool)) {
+		ret = PTR_ERR(fep->page_pool);
+		fep->page_pool = NULL;
+	}
+
+	return ret;
 }
 
 static int mtip_alloc_buffers(struct net_device *dev)
 {
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct cbd_t *bdp;
+	struct page *page;
+	int i, ret;
+
+	ret = mtip_create_page_pool(fep, RX_RING_SIZE);
+	if (ret < 0) {
+		dev_err(&fep->pdev->dev, "Failed to create page pool\n");
+		return ret;
+	}
+
+	bdp = fep->rx_bd_base;
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		page = page_pool_dev_alloc_pages(fep->page_pool);
+		if (!page) {
+			dev_err(&fep->pdev->dev,
+				"Failed to allocate page for rx buffer\n");
+			goto err;
+		}
+
+		bdp->cbd_bufaddr = page_pool_get_dma_addr(page);
+		fep->page[i] = page;
+
+		bdp->cbd_sc = BD_ENET_RX_EMPTY;
+		bdp++;
+	}
+
+	mtip_set_last_buf_to_wrap(bdp);
+
+	bdp = fep->tx_bd_base;
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		fep->tx_bounce[i] = kmalloc(MTIP_SWITCH_TX_FRSIZE, GFP_KERNEL);
+		if (!fep->tx_bounce[i])
+			goto err;
+
+		bdp->cbd_sc = 0;
+		bdp->cbd_bufaddr = 0;
+		bdp++;
+	}
+
+	mtip_set_last_buf_to_wrap(bdp);
+
 	return 0;
+
+ err:
+	mtip_free_buffers(dev);
+	return -ENOMEM;
 }
 
 static int mtip_rx_napi(struct napi_struct *napi, int budget)
-- 
2.39.5


