Return-Path: <netdev+bounces-148717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F332E9E2FE3
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE0D166F8D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF0F20ADF4;
	Tue,  3 Dec 2024 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML0UIg5p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4720899B;
	Tue,  3 Dec 2024 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268717; cv=none; b=D+2aus65MzK/pbWQhEKNJzi0EXCkihVr/N0XK8C6wWN63yW199adve6klpb6kh8c1WyKejQ7TMw1Q2h0EcTz6/deMSUnKAgAydfdO5D3tJXCDcyCRvZ9uM0UlAtU8cO1KK1stHzSQLN7yOj7kxwQCf4StJ9lQlgN55qZIgu01Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268717; c=relaxed/simple;
	bh=WOfKELIdHSYED8JSXvwxUbnvS3q26rbLXDjAKsmxm0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KB83GvyBQlfRoi1pmFvB1wtb9hfv9kWaL4ZULQ6SVSaO/FWIS3EOmzEB1C2r0LOSq05+SFBT8UabzDhc+fZGdUH1oWfN85Klo6G4C7UZUF83N+OjzpN2fNl7n41ixr4QB16iWTwWBGpwqMeCCZcezQTb3UCa1+uKLsdlERDu9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ML0UIg5p; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea9739647bso4412494a12.0;
        Tue, 03 Dec 2024 15:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733268715; x=1733873515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPW72DaAKCjcqtNTefKHctDcKbOWx85fnl51Ad7FRIA=;
        b=ML0UIg5pVuqQaOi51MaBa/aG7lcX+t4i4wTgbs7+zM9oW+CyuKy2stxmoFeT+PXzhJ
         8lSiVa4BiLo7lU+DXfxHgTY+Ir8aRCyNuz5+aO0LqlFXwkXI+zcJrp6M3O9tyKmW0rwd
         xJNZPOj7kdLZSCXtVyQwsTP/W3v6mxl4ZFX7XHorTFVZkqbJMYy5tr8fqOfPIjZ5CSo6
         1DhSOFnXiIkdv/5fYrUGfq23k5qiKhhoPwIgZVC/R4ZDlSgqHI8R+qTdfU9hjdOkCRkj
         gRuMBgonRHOUNq1H2WEV1NhzmiDmDguTQBqd0NmnMGt7kAtazc96KnbUZh9cUE4Hlhhk
         jqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733268715; x=1733873515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPW72DaAKCjcqtNTefKHctDcKbOWx85fnl51Ad7FRIA=;
        b=v8VOI9hLQM05F6WUoOpDNohgPwX859Tr/SHCX6nbDgu/eW39NLO1B326Mof8pupMxw
         YgsFg1MTfmO+juZYCFU6Wz7CdQZ9l4LqnOxKNxLwgLBXa3h8IB2DIWW91UeyuFU609CY
         lAPIBvjWcssb3TdWRQqzX7isTRvh6tX6lXR/AdD63M/T/L/tnraWSn7Ir0LP/MarhlZO
         5svv8S4NwVuW12DQ6pdPCz6QUbHKSujJRMsJG0D0xcwqg/MTLwm9GBuS5E4tntV5DHJT
         0/Chh3onJqvq6YbVbSFfIu5muaSEy9uAgLFJ4DAd3h4HELJClPPQWdu2V0rAf5gUZQOR
         s9JA==
X-Forwarded-Encrypted: i=1; AJvYcCWTuFrie0VIzg+1gO2vU+JO+18Vkf4+EOezoNxg3nmiABffnr0bbaFS8VN3mZ7xcnGLtIRtgaP+VEt520k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGDLC7+n1BL69X5LMHo08O/nrsQbcY67qbw9AORz86l9YcgzwK
	eaYj8Hxnd7nFNar99NoAHkUsq/Tx7c39mbt+ztlP5ppnz8XU5CNHZSUTIGBPJpQ=
X-Gm-Gg: ASbGncvRn+ySKn9CQlWTPAIqtBWBaaetuyVUUM4J/zZZXAtbYX/3uvp5VDhmS904gAQ
	Q+12S8Mesi8KNIZ6v07BVTVB87EaLNfqhSntPBts3indpLm+lSw1AetRp6In2TZwdmAGEYCqutm
	BGtdu/NX9+6eC1uxApefXIa1DrD+Tehh/4DMsFsKidWdmKxghXJ46uL2+tBVALO1R+0445Ff0LG
	zRXovnhTLt0zHm57qhJlijBbQ==
X-Google-Smtp-Source: AGHT+IEOqTSK3PwwB/bEjH0eiNLN11BfUOJ5bd+mbYxYTypeWXtb5MxLadITI2AN8AzZ7+3nk2equg==
X-Received: by 2002:a05:6a20:4309:b0:1db:f732:d177 with SMTP id adf61e73a8af0-1e1653c825dmr5956930637.25.1733268714669;
        Tue, 03 Dec 2024 15:31:54 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3a2dc1sm10169172a12.82.2024.12.03.15.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:31:54 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Joyce Ooi <joyce.ooi@intel.com>,
	linux@armlinux.org.uk,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] net: altera: use devm for alloc_etherdev
Date: Tue,  3 Dec 2024 15:31:49 -0800
Message-ID: <20241203233150.184194-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203233150.184194-1-rosenp@gmail.com>
References: <20241203233150.184194-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a bunch of gotos as a result.

As this driver already uses devm, it makes sense to register
alloc_etherdev with devm before anything else.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 61 ++++++++-----------
 1 file changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 3f6204de9e6b..52d4cafec683 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1141,9 +1141,11 @@ static int altera_tse_probe(struct platform_device *pdev)
 	struct mii_bus *pcs_bus;
 	struct net_device *ndev;
 	void __iomem *descmap;
+	struct device *dev;
 	int ret = -ENODEV;
 
-	ndev = alloc_etherdev(sizeof(struct altera_tse_private));
+	dev = &pdev->dev;
+	ndev = devm_alloc_etherdev(dev, sizeof(struct altera_tse_private));
 	if (!ndev) {
 		dev_err(&pdev->dev, "Could not allocate network device\n");
 		return -ENODEV;
@@ -1163,7 +1165,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 		/* Get the mapped address to the SGDMA descriptor memory */
 		ret = request_and_map(pdev, "s1", &dma_res, &descmap);
 		if (ret)
-			goto err_free_netdev;
+			return ret;
 
 		/* Start of that memory is for transmit descriptors */
 		priv->tx_dma_desc = descmap;
@@ -1182,26 +1184,24 @@ static int altera_tse_probe(struct platform_device *pdev)
 		if (upper_32_bits(priv->rxdescmem_busaddr)) {
 			dev_dbg(priv->device,
 				"SGDMA bus addresses greater than 32-bits\n");
-			ret = -EINVAL;
-			goto err_free_netdev;
+			return -EINVAL;
 		}
 		if (upper_32_bits(priv->txdescmem_busaddr)) {
 			dev_dbg(priv->device,
 				"SGDMA bus addresses greater than 32-bits\n");
-			ret = -EINVAL;
-			goto err_free_netdev;
+			return -EINVAL;
 		}
 	} else if (priv->dmaops &&
 		   priv->dmaops->altera_dtype == ALTERA_DTYPE_MSGDMA) {
 		ret = request_and_map(pdev, "rx_resp", &dma_res,
 				      &priv->rx_dma_resp);
 		if (ret)
-			goto err_free_netdev;
+			return ret;
 
 		ret = request_and_map(pdev, "tx_desc", &dma_res,
 				      &priv->tx_dma_desc);
 		if (ret)
-			goto err_free_netdev;
+			return ret;
 
 		priv->txdescmem = resource_size(dma_res);
 		priv->txdescmem_busaddr = dma_res->start;
@@ -1209,44 +1209,40 @@ static int altera_tse_probe(struct platform_device *pdev)
 		ret = request_and_map(pdev, "rx_desc", &dma_res,
 				      &priv->rx_dma_desc);
 		if (ret)
-			goto err_free_netdev;
+			return ret;
 
 		priv->rxdescmem = resource_size(dma_res);
 		priv->rxdescmem_busaddr = dma_res->start;
 
-	} else {
-		ret = -ENODEV;
-		goto err_free_netdev;
-	}
+	} else
+		return -ENODEV;
 
 	if (!dma_set_mask(priv->device, DMA_BIT_MASK(priv->dmaops->dmamask))) {
 		dma_set_coherent_mask(priv->device,
 				      DMA_BIT_MASK(priv->dmaops->dmamask));
 	} else if (!dma_set_mask(priv->device, DMA_BIT_MASK(32))) {
 		dma_set_coherent_mask(priv->device, DMA_BIT_MASK(32));
-	} else {
-		ret = -EIO;
-		goto err_free_netdev;
-	}
+	} else
+		return -EIO;
 
 	/* MAC address space */
 	ret = request_and_map(pdev, "control_port", &control_port,
 			      (void __iomem **)&priv->mac_dev);
 	if (ret)
-		goto err_free_netdev;
+		return ret;
 
 	/* xSGDMA Rx Dispatcher address space */
 	ret = request_and_map(pdev, "rx_csr", &dma_res,
 			      &priv->rx_dma_csr);
 	if (ret)
-		goto err_free_netdev;
+		return ret;
 
 
 	/* xSGDMA Tx Dispatcher address space */
 	ret = request_and_map(pdev, "tx_csr", &dma_res,
 			      &priv->tx_dma_csr);
 	if (ret)
-		goto err_free_netdev;
+		return ret;
 
 	memset(&pcs_regmap_cfg, 0, sizeof(pcs_regmap_cfg));
 	memset(&mrc, 0, sizeof(mrc));
@@ -1274,10 +1270,9 @@ static int altera_tse_probe(struct platform_device *pdev)
 	/* Create a regmap for the PCS so that it can be used by the PCS driver */
 	pcs_regmap = devm_regmap_init_mmio(&pdev->dev, priv->pcs_base,
 					   &pcs_regmap_cfg);
-	if (IS_ERR(pcs_regmap)) {
-		ret = PTR_ERR(pcs_regmap);
-		goto err_free_netdev;
-	}
+	if (IS_ERR(pcs_regmap))
+		return PTR_ERR(pcs_regmap);
+
 	mrc.regmap = pcs_regmap;
 	mrc.parent = &pdev->dev;
 	mrc.valid_addr = 0x0;
@@ -1287,31 +1282,27 @@ static int altera_tse_probe(struct platform_device *pdev)
 	priv->rx_irq = platform_get_irq_byname(pdev, "rx_irq");
 	if (priv->rx_irq == -ENXIO) {
 		dev_err(&pdev->dev, "cannot obtain Rx IRQ\n");
-		ret = -ENXIO;
-		goto err_free_netdev;
+		return -ENXIO;
 	}
 
 	/* Tx IRQ */
 	priv->tx_irq = platform_get_irq_byname(pdev, "tx_irq");
 	if (priv->tx_irq == -ENXIO) {
 		dev_err(&pdev->dev, "cannot obtain Tx IRQ\n");
-		ret = -ENXIO;
-		goto err_free_netdev;
+		return -ENXIO;
 	}
 
 	/* get FIFO depths from device tree */
 	if (of_property_read_u32(pdev->dev.of_node, "rx-fifo-depth",
 				 &priv->rx_fifo_depth)) {
 		dev_err(&pdev->dev, "cannot obtain rx-fifo-depth\n");
-		ret = -ENXIO;
-		goto err_free_netdev;
+		return -ENXIO;
 	}
 
 	if (of_property_read_u32(pdev->dev.of_node, "tx-fifo-depth",
 				 &priv->tx_fifo_depth)) {
 		dev_err(&pdev->dev, "cannot obtain tx-fifo-depth\n");
-		ret = -ENXIO;
-		goto err_free_netdev;
+		return -ENXIO;
 	}
 
 	/* get hash filter settings for this instance */
@@ -1354,7 +1345,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 	ret = altera_tse_phy_get_addr_mdio_create(ndev);
 
 	if (ret)
-		goto err_free_netdev;
+		return ret;
 
 	/* initialize netdev */
 	ndev->mem_start = control_port->start;
@@ -1450,8 +1441,6 @@ static int altera_tse_probe(struct platform_device *pdev)
 err_register_netdev:
 	netif_napi_del(&priv->napi);
 	altera_tse_mdio_destroy(ndev);
-err_free_netdev:
-	free_netdev(ndev);
 	return ret;
 }
 
@@ -1467,8 +1456,6 @@ static void altera_tse_remove(struct platform_device *pdev)
 	unregister_netdev(ndev);
 	phylink_destroy(priv->phylink);
 	lynx_pcs_destroy(priv->pcs);
-
-	free_netdev(ndev);
 }
 
 static const struct altera_dmaops altera_dtype_sgdma = {
-- 
2.47.0


