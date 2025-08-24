Return-Path: <netdev+bounces-216339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1022FB33318
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 00:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF32205E73
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 22:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE5F2DFF04;
	Sun, 24 Aug 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tDtCEYTx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X9r24EEH"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D42580F2;
	Sun, 24 Aug 2025 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756073308; cv=none; b=L9Wy3QVJnmVQD7gr+huhW1ed+h0exKF2TPjv/hJq90RuxQhMLDtZ101ed5dBordpmDn+pQcNQ66lrD8kBKOQcyedjmZpB4McWpqBttQCmb367uVpgWJLKVw7tlCpQkxqj3MfuV5zJpFN+rErqE870woE8D5THJvEuIWEGP9IkBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756073308; c=relaxed/simple;
	bh=Cqi1KjttiDdhWqKLMTl19w8vHID7id3z9wMy5PMIhaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UNF06n6uiClGFxwoqvgOmg4N2gHdsaOm3Ujd7PxXl3kzVOD3m2GaHjSf3y8pdkrLJZVuEsSlDdpiZtf8Qv3MeMQKvGPvr42ZmaD42h+fDhDsPsTJLlhOTwkuS3d8x6tnincl2wQ8jf5B/+bzgM82D6njsxRnJl+Y91dkX8JocoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tDtCEYTx; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=X9r24EEH; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c97NL4qn4z9tcN;
	Mon, 25 Aug 2025 00:08:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756073298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XaTXer8NQKVAFFJmOvJcASY6ItCMeUQ4gw1of3TcEi0=;
	b=tDtCEYTx0ObxfZzcswGBBnRrWsHs2RjCfvrR1AmZwVDiTquc9Dw+I64eY8ld5bvjlLs31k
	BDVetHnNAETtYVTGmetkRvH+3WzGH0gReQd3mkydXWdqot2d401lzSZiHMQHFAgQLV3lD/
	Vw7foJhmt0VF92f7LcSSsIaqsnLgYXsCQlaR2erdqIy6VCAFRE8o/gHZVOab3jXqti+1Pe
	WEycOMpEIE/7+bqU2iQrCcC2/GXlRkhuwlW26j6wk4T+EOLk4q/4A71esQnS4RDBqqfUop
	xIK4Ra1pUdFxTLX1kq0CQV8XklgXiZw+WywEI/3uD9AZRIqTZ9P5g3auNk4tRw==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756073296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XaTXer8NQKVAFFJmOvJcASY6ItCMeUQ4gw1of3TcEi0=;
	b=X9r24EEHGXWEkK6wbbYkzc4E1rTGQg0oRAtqHLlmJmnE8QsJO0g27ZRBLPmXht5+9cJnCE
	Cc+XrV4KPBcuM3ybL5RthHvpYDtx1RM2Qjy+0Zolrp7w8LMNhYNO3hnWdS7zRxTYSuqxjE
	RbWbE63waQbtzWrsW73pKVJtYOjtSdPNAP5lmbxuwqLu2x4j495lWxNx9tPFZ2YZIXw/3P
	tpkIs7kJzg3aGC+PHySLa8W75LRrCd/B0OZWVQgSlrNoim57IYPc1MwW8DaIVzudZ9XqZQ
	nYpF37otoXEK/Mk/IjMYsRta9AVNFYyFB4WvGpdRzjvBfNwONqKKMHgD3HyWrA==
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
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v19 3/7] net: mtip: Add buffers management functions to the L2 switch driver
Date: Mon, 25 Aug 2025 00:07:32 +0200
Message-Id: <20250824220736.1760482-4-lukasz.majewski@mailbox.org>
In-Reply-To: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
References: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ksg1j4uogupyrtkhayrgucqi1xji9fm4
X-MBO-RS-ID: 1d8c858c0d90626d114

This patch provides buffers management funcions' content for MTIP
L2 switch.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
---
Changes for v14:
- New patch - created by excluding some code from large (i.e. v13
  and earlier) MTIP driver

Changes for v15 - v19:
- None
---
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 604c0ab350d6..61380f09e2f1 100644
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


