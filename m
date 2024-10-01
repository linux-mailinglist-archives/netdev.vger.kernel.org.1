Return-Path: <netdev+bounces-130998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6C998C59A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13EBC1F22E67
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4381CEEA2;
	Tue,  1 Oct 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP+K1dMx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331B51CEAD5;
	Tue,  1 Oct 2024 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808379; cv=none; b=Funb85vRN4lae2WXdix+/wuHcUZo/vz9mODfYgzZ7KJlUhN+BgHj6k+SBd/iu32FIqI8OeiUhDTEeiTfjV9Y05di5gJxqwi8xr0UJ2K2i4V19BfGaOu4KfRymsOigc9Ycz9OEnhiIC3JU3ATd+fPFRthyJpw7qFTCbVrb8wSUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808379; c=relaxed/simple;
	bh=EXhXd2czwyGbcYG1c8wXdvFk9fg01yOquF/Do5eADb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2uw/AZT8zaZNeA57gHuHCD22aumJE7sUX4gyd3L11akDpDccPhAxz8cbDM1L6YAEP0SktEBv+7rgvHTPL5OWu26KFg5F3j0hbumuWIsbLfgE/NoA482R8wCg4tyNqB697l6A2sXUni7/mFQExbFR1BtsRz81p2L92GlFDu/OpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP+K1dMx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20aff65aa37so47532565ad.1;
        Tue, 01 Oct 2024 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808377; x=1728413177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwUbJMNR0/QyvDYOplb8XoUvdN2UCOFTaKGE+xFOxaI=;
        b=BP+K1dMx3ixFiMVPcC5bkO8VDLSZcubQj6WGiC5WJ+2LWYSiNDyRvUVVOlL3vTH9ZV
         thiqeXXotNiJU8DN/TwBqRCobPbjCkUMsM1UInC+erVpBpYX7O/tekRHAHJOweOm7Qfm
         UC5/caEYJKM+L7I3lMwLuKN1Z7f0eSk9UwAS7IO5zMBT17AjEBM0s7783vnen5vHlnzo
         XSqJb22yivCR9VKAbGGyoKsavE7F5xFC/5r3gopqpTYWfzoYxOKtGLfFOj4KZlxXGZK5
         VP+j4ixnEDGhNp2lR/K2ZiUn9kM5Hqm7MsaM3pDumRuQh3gAzPWCMV2iDV73/R6aYRsl
         /+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808377; x=1728413177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwUbJMNR0/QyvDYOplb8XoUvdN2UCOFTaKGE+xFOxaI=;
        b=ZKgw/gKAEYJyAppqFS6TbWfIl0HnI+BzmJXXrTkccoq0gIk0As9m+HnuyomMvetyaQ
         /bPCXdjogsDaViDsqNhM4vPi328CDi1TIKyUrqo50v0IOitIEOEsjx3r3VATj83mHnwz
         9B3eefPk3w7Y2FOwlOUiqLHZkS+8sLu4s5LbDYFWzPmwxZcJlIhBpXA7vFT9h3uUMcB2
         RqWTKo3hp62F48p7K5H365qtV5H8eZxK2tunXFnyi2ImkyOdFf8wRwoRfV+pBGN9P+tf
         3Ax6cPvdaS54J8dAXXjOV8pfaxXrqGU+7ChIYVd8BQpnGtwkg0Zk2zdtLEeZE+2XtpSa
         FcAA==
X-Forwarded-Encrypted: i=1; AJvYcCVpO/9wPnUVVAfghwH+RyGamiq+wqeBZKpnHf0epFlhcKFO1TST4bCMjjKKKGjMVBH3naS7SUq8/RHgC/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1SwS3WiA4QwTA9ZLwaRDMluduNVkZmcFkKGeM7t/qPG+sVMi
	3roQTUbpUbi1BsYCJWsXj1aoVd2zvw3d8SSiInmuI44qq0Qbj9OmsxtlfopE
X-Google-Smtp-Source: AGHT+IHH2lu7AhQQAI3wILcCpgu8yQRH9ruAHyDNDaQryuq5nizoTWMUJtJ7tQTD1h/ywlEwyTELLQ==
X-Received: by 2002:a17:902:c404:b0:20b:5db2:4565 with SMTP id d9443c01a7336-20bc5aa3d49mr7139645ad.56.1727808377319;
        Tue, 01 Oct 2024 11:46:17 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357absm72278965ad.190.2024.10.01.11.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:46:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCHv2 net-next 06/10] net: lantiq_etop: use devm_err_probe
Date: Tue,  1 Oct 2024 11:46:03 -0700
Message-ID: <20241001184607.193461-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001184607.193461-1-rosenp@gmail.com>
References: <20241001184607.193461-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also remove pointless gotos that just return as a result of devm
conversions.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/lantiq_etop.c | 61 ++++++++++--------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 9ca8f01585f6..bc97b189785e 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -389,13 +389,11 @@ static int
 ltq_etop_mdio_init(struct net_device *dev)
 {
 	struct ltq_etop_priv *priv = netdev_priv(dev);
-	int err;
 
 	priv->mii_bus = devm_mdiobus_alloc(&dev->dev);
 	if (!priv->mii_bus) {
 		netdev_err(dev, "failed to allocate mii bus\n");
-		err = -ENOMEM;
-		goto err_out;
+		return -ENOMEM;
 	}
 
 	priv->mii_bus->priv = dev;
@@ -404,19 +402,13 @@ ltq_etop_mdio_init(struct net_device *dev)
 	priv->mii_bus->name = "ltq_mii";
 	snprintf(priv->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
 		 priv->pdev->name, priv->pdev->id);
-	if (devm_mdiobus_register(&dev->dev, priv->mii_bus)) {
-		err = -ENXIO;
-		goto err_out;
-	}
+	if (devm_mdiobus_register(&dev->dev, priv->mii_bus))
+		return -ENXIO;
 
-	if (ltq_etop_mdio_probe(dev)) {
-		err = -ENXIO;
-		goto err_out;
-	}
-	return 0;
+	if (ltq_etop_mdio_probe(dev))
+		return -ENXIO;
 
-err_out:
-	return err;
+	return 0;
 }
 
 static int
@@ -634,34 +626,28 @@ ltq_etop_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		dev_err(&pdev->dev, "failed to get etop resource\n");
-		err = -ENOENT;
-		goto err_out;
+		dev_err(&pdev->dev, "failed to get etop resource");
+		return -ENOENT;
 	}
 
 	res = devm_request_mem_region(&pdev->dev, res->start,
 				      resource_size(res), dev_name(&pdev->dev));
 	if (!res) {
-		dev_err(&pdev->dev, "failed to request etop resource\n");
-		err = -EBUSY;
-		goto err_out;
+		dev_err(&pdev->dev, "failed to request etop resource");
+		return -EBUSY;
 	}
 
 	ltq_etop_membase = devm_ioremap(&pdev->dev, res->start,
 					resource_size(res));
 	if (!ltq_etop_membase) {
-		dev_err(&pdev->dev, "failed to remap etop engine %d\n",
-			pdev->id);
-		err = -ENOMEM;
-		goto err_out;
+		dev_err(&pdev->dev, "failed to remap etop engine %d", pdev->id);
+		return -ENOMEM;
 	}
 
 	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(struct ltq_etop_priv),
 				      4, 4);
-	if (!dev) {
-		err = -ENOMEM;
-		goto err_out;
-	}
+	if (!dev)
+		return -ENOMEM;
 	dev->netdev_ops = &ltq_eth_netdev_ops;
 	dev->ethtool_ops = &ltq_etop_ethtool_ops;
 	priv = netdev_priv(dev);
@@ -673,16 +659,14 @@ ltq_etop_probe(struct platform_device *pdev)
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	err = device_property_read_u32(&pdev->dev, "lantiq,tx-burst-length", &priv->tx_burst_len);
-	if (err < 0) {
-		dev_err(&pdev->dev, "unable to read tx-burst-length property\n");
-		goto err_out;
-	}
+	if (err < 0)
+		return dev_err_probe(&pdev->dev, err,
+				     "unable to read tx-burst-length property");
 
 	err = device_property_read_u32(&pdev->dev, "lantiq,rx-burst-length", &priv->rx_burst_len);
-	if (err < 0) {
-		dev_err(&pdev->dev, "unable to read rx-burst-length property\n");
-		goto err_out;
-	}
+	if (err < 0)
+		return dev_err_probe(&pdev->dev, err,
+				     "unable to read rx-burst-length property");
 
 	for (i = 0; i < MAX_DMA_CHAN; i++) {
 		if (IS_TX(i))
@@ -696,13 +680,10 @@ ltq_etop_probe(struct platform_device *pdev)
 
 	err = devm_register_netdev(&pdev->dev, dev);
 	if (err)
-		goto err_out;
+		return err;
 
 	platform_set_drvdata(pdev, dev);
 	return 0;
-
-err_out:
-	return err;
 }
 
 static void ltq_etop_remove(struct platform_device *pdev)
-- 
2.46.2


