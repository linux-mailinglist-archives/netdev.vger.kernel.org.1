Return-Path: <netdev+bounces-148718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A59E2FE4
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071C32834D2
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5333720B206;
	Tue,  3 Dec 2024 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDj5ow57"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD420ADDD;
	Tue,  3 Dec 2024 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268718; cv=none; b=KgwUrEXpoNAAXu4YDF4S9EtbBdz7YcMjy55LgH8SPIlAwxEsYywUSok+BiqfvkqcvHMi8kVtpDxgv6vrnVkrFOkAfyxlmvI47jk9svKRiNlw9yE1tRmAkUeAY86g8+9GUy5J+j6NX8+k0d4LkTeq6ssNMWLmqwDtswXa8ePZd+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268718; c=relaxed/simple;
	bh=PIvjBsWIWit53tR1d8qsymMuDcjl1qknBf5rZbJoPLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5QPO1JBGoEMcYc8owLKrtksRESkZgBCbEjS2aL5ecGVOS0hE5ZCQxFF1gz5p/KrnC38aA7WSeje3D2F7Pl0tYXtTW0PtKEmcth7E75kaAg9aSHRW0dmMisBbtKXAybKWVBzCvhiee9LGncCSAEXqsFrTGg6Jw3I4U0tRsM4a8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDj5ow57; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso230620a12.1;
        Tue, 03 Dec 2024 15:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733268716; x=1733873516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4JtiIyXxgPed2R4Wp0BJYFKVwfKIWK83kJwTLkwR84=;
        b=VDj5ow57gfqG1TZzGtecJz7FMCzj8v/gMPlNy1joEUBYB8xxJRjxoiObT/3/ePy+gd
         6Y7fXDPRjZAGM3X7sWKvoDj2vk+kADc43GoC9KeHUw8Vg6Yl5I8gw6xm+i1uUR3lSXJZ
         y1R/GDqlF4zpT3V7h5O4czXCobAImjjZ1qaWg2hlUHI0nT1rYNeV3erB5eGba3Hihxkp
         4mRPnG4zzKqLvR3esuuJ70d8+8giXhHttqk9rEaGz7UkKKpKtLFa2vnxoHiKb31Jobhm
         ovDuNb2c61TAud/v2c4E6EJVx/FeB7BJtKY3ZH4FyznnthbDE3RYd9rZxtekcQCZ22EX
         vZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733268716; x=1733873516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4JtiIyXxgPed2R4Wp0BJYFKVwfKIWK83kJwTLkwR84=;
        b=Q0lbQ2uen7Y5d8La84eRrIhc5djBTMoaOzxOzINHokWXxxzz773Pj+yZfJGVbCZbsF
         T0YhQ1OCK10Dij24Ktqt6vKpCgP5dgXM2Wi+nCq6dpc0aKEJxXwTzgd6QUxRt7uW8gTk
         INtRKzm7LMXgBapftgYU59OE+zBT+ednK03ouDG9WRn6s7/g9I3iTnI/kqQlfVoaIa2Y
         9PPnU4pXewxCgWXRnhoOyzISjZ18zLaqxrc+e9SAtBcJBupVJH9vlzJ0YUDowIqtPhzo
         HWEZKbInFllK5QWEhGh0+ni5+TzcQZJ6IDewnhoMhj4oztqMg6KpiE1eEjTFeuAXeUjm
         VWag==
X-Forwarded-Encrypted: i=1; AJvYcCXj9wvTOBcHnb7C0QsA+ty0NJVbQsa2ajvyZON/9PM+cwpM1Hy3JCCIkQvJkhjYc0GHwNhOKY8zSuKJh2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/qm4DL6QGECUOuTZvhBV2MgFYJUxH/WZsmcCM+pc5YVuK+Uh
	wBGPWNRV+psI8dvQO5QkqXR9/2ccKQjCO8NofDOAM09CGoU5XRPyTn9kDHqVc84=
X-Gm-Gg: ASbGncvB/lMZom0GhBK0gX7GjR+T5/Oko2CmHxp0ZTDhbHXcnyQCookexXm9JrvMSVV
	NOqtzJIHpqSQHbmLtNk+5qrusaFrBfrZi5ZyJbH0WLLJGOUFkNw1ujuL/yHq4WFMxYmRykCF0rz
	OV6MyO7x/WzfpZAkOKSSTiTWAjmqU1rtfzDsDFqrabXdLXQViWT2Dur/2VRKUlMgL/JVtbBFdoV
	BS2lp4J8GXuqqqhqPqzReEWBQ==
X-Google-Smtp-Source: AGHT+IG6NIznPUGkCPTwET6AvdBeODfzqNhbLWHDfJ+AcrshJGr0H4cEhJFJcZuKg5faSQ4gA+uVcQ==
X-Received: by 2002:a05:6a20:72a9:b0:1e0:c8c5:9b24 with SMTP id adf61e73a8af0-1e165aac298mr5963803637.16.1733268715940;
        Tue, 03 Dec 2024 15:31:55 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3a2dc1sm10169172a12.82.2024.12.03.15.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:31:55 -0800 (PST)
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
Subject: [PATCH net-next 2/2] net: altera: simplify request_and_map
Date: Tue,  3 Dec 2024 15:31:50 -0800
Message-ID: <20241203233150.184194-3-rosenp@gmail.com>
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

This function is effectively devm_platform_ioremap_resource_byname with
an additional parameter returning the resource. Might as well use modern
helpers.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 81 ++++++-------------
 1 file changed, 26 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 52d4cafec683..66add91e64e0 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1098,33 +1098,11 @@ static const struct phylink_mac_ops alt_tse_phylink_ops = {
 	.mac_select_pcs = alt_tse_select_pcs,
 };
 
-static int request_and_map(struct platform_device *pdev, const char *name,
-			   struct resource **res, void __iomem **ptr)
+static void __iomem *request_and_map(struct platform_device *pdev,
+				     const char *name, struct resource **res)
 {
-	struct device *device = &pdev->dev;
-	struct resource *region;
-
 	*res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
-	if (*res == NULL) {
-		dev_err(device, "resource %s not defined\n", name);
-		return -ENODEV;
-	}
-
-	region = devm_request_mem_region(device, (*res)->start,
-					 resource_size(*res), dev_name(device));
-	if (region == NULL) {
-		dev_err(device, "unable to request %s\n", name);
-		return -EBUSY;
-	}
-
-	*ptr = devm_ioremap(device, region->start,
-				    resource_size(region));
-	if (*ptr == NULL) {
-		dev_err(device, "ioremap of %s failed!", name);
-		return -ENOMEM;
-	}
-
-	return 0;
+	return devm_ioremap_resource(&pdev->dev, *res);
 }
 
 /* Probe Altera TSE MAC device
@@ -1163,9 +1141,9 @@ static int altera_tse_probe(struct platform_device *pdev)
 	if (priv->dmaops &&
 	    priv->dmaops->altera_dtype == ALTERA_DTYPE_SGDMA) {
 		/* Get the mapped address to the SGDMA descriptor memory */
-		ret = request_and_map(pdev, "s1", &dma_res, &descmap);
-		if (ret)
-			return ret;
+		descmap = request_and_map(pdev, "s1", &dma_res);
+		if (IS_ERR(descmap))
+			return PTR_ERR(descmap);
 
 		/* Start of that memory is for transmit descriptors */
 		priv->tx_dma_desc = descmap;
@@ -1193,23 +1171,20 @@ static int altera_tse_probe(struct platform_device *pdev)
 		}
 	} else if (priv->dmaops &&
 		   priv->dmaops->altera_dtype == ALTERA_DTYPE_MSGDMA) {
-		ret = request_and_map(pdev, "rx_resp", &dma_res,
-				      &priv->rx_dma_resp);
-		if (ret)
-			return ret;
+		priv->rx_dma_resp = request_and_map(pdev, "rx_resp", &dma_res);
+		if (IS_ERR(priv->rx_dma_resp))
+			return PTR_ERR(priv->rx_dma_resp);
 
-		ret = request_and_map(pdev, "tx_desc", &dma_res,
-				      &priv->tx_dma_desc);
-		if (ret)
-			return ret;
+		priv->tx_dma_desc = request_and_map(pdev, "tx_desc", &dma_res);
+		if (IS_ERR(priv->tx_dma_desc))
+			return PTR_ERR(priv->tx_dma_desc);
 
 		priv->txdescmem = resource_size(dma_res);
 		priv->txdescmem_busaddr = dma_res->start;
 
-		ret = request_and_map(pdev, "rx_desc", &dma_res,
-				      &priv->rx_dma_desc);
-		if (ret)
-			return ret;
+		priv->rx_dma_desc = request_and_map(pdev, "rx_desc", &dma_res);
+		if (IS_ERR(priv->rx_dma_desc))
+			return PTR_ERR(priv->rx_dma_desc);
 
 		priv->rxdescmem = resource_size(dma_res);
 		priv->rxdescmem_busaddr = dma_res->start;
@@ -1226,23 +1201,19 @@ static int altera_tse_probe(struct platform_device *pdev)
 		return -EIO;
 
 	/* MAC address space */
-	ret = request_and_map(pdev, "control_port", &control_port,
-			      (void __iomem **)&priv->mac_dev);
-	if (ret)
-		return ret;
+	priv->mac_dev = request_and_map(pdev, "control_port", &control_port);
+	if (IS_ERR(priv->mac_dev))
+		return PTR_ERR(priv->mac_dev);
 
 	/* xSGDMA Rx Dispatcher address space */
-	ret = request_and_map(pdev, "rx_csr", &dma_res,
-			      &priv->rx_dma_csr);
-	if (ret)
-		return ret;
-
+	priv->rx_dma_csr = request_and_map(pdev, "rx_csr", &dma_res);
+	if (IS_ERR(priv->rx_dma_csr))
+		return PTR_ERR(priv->rx_dma_csr);
 
 	/* xSGDMA Tx Dispatcher address space */
-	ret = request_and_map(pdev, "tx_csr", &dma_res,
-			      &priv->tx_dma_csr);
-	if (ret)
-		return ret;
+	priv->tx_dma_csr = request_and_map(pdev, "tx_csr", &dma_res);
+	if (IS_ERR(priv->tx_dma_csr))
+		return PTR_ERR(priv->tx_dma_csr);
 
 	memset(&pcs_regmap_cfg, 0, sizeof(pcs_regmap_cfg));
 	memset(&mrc, 0, sizeof(mrc));
@@ -1251,8 +1222,8 @@ static int altera_tse_probe(struct platform_device *pdev)
 	 * address space, but if it's not the case, we fallback to the mdiophy0
 	 * from the MAC's address space
 	 */
-	ret = request_and_map(pdev, "pcs", &pcs_res, &priv->pcs_base);
-	if (ret) {
+	priv->pcs_base = request_and_map(pdev, "pcs", &pcs_res);
+	if (IS_ERR(priv->pcs_base)) {
 		/* If we can't find a dedicated resource for the PCS, fallback
 		 * to the internal PCS, that has a different address stride
 		 */
-- 
2.47.0


