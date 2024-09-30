Return-Path: <netdev+bounces-130600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B1D98AE43
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8906E2823A7
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B3B1A3BC9;
	Mon, 30 Sep 2024 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8uaKi5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9F1A38EB;
	Mon, 30 Sep 2024 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727886; cv=none; b=qa95vliD2qxIzIzGobcM3lRg8fXnHCLCEBs6fcPVP5gLc7KC2kXVxMXQVF3PFvu0zBo7G4KwU0bxE1U4gYKVN7gg4WiXIrZV1qZ/veFRJQBvOkTD59fq8VhiiR36mJvyFi9tdmp4q/BiANZjMpW9rZ6+pK8YSMXKH8T7cCAzA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727886; c=relaxed/simple;
	bh=BLFruLzi5nr59Es+Q9KpNATJiUxLeOIsnBBJdVewCzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZmQ1ba7dbIQGv4NnRerysW2y77bCQVcdE+hvAVPIzkDqkXSNpznE1O9Kc71YCcXqDNyj7wW+t8BY9zewSNTs1llAGJu4KONl2HuWV3cd/l2luRPuPuaXcBBxxjnnAcltE2/jKnXaxg+HWQ18v/vQWCeFseU1i7Lp4MbqzYdLgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8uaKi5j; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7db12af2f31so4003161a12.1;
        Mon, 30 Sep 2024 13:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727884; x=1728332684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHj/lIlzFIU4shuEI1PXkmQf3BW7sLfbfdA5obcdX1E=;
        b=m8uaKi5jKFKBn0hSrLNuASfFvUsdx75HMj//IBKAgmhxPz7pD3LLLo+O6GPpO/3lOX
         oJzEXQymTSd5c/EfLUEhTdFLeRZ7692s0jNyZ0w28tbmMgXyAc/5i88KbxJjQfZyl0c+
         JnTcSWYuyPZuwAeWiGf2wenCyvdcJCssDevFe9Vmv1j/Qb3Nj7RTaNaKjiISvnYVDicd
         R5hA2uFZnvSqLg54Pc6lN5LTZ8Misj9RNkxO5Ws+++Nm0H9VLjqgbq2bGh8/VkErmaD8
         /IZTfh5hjOODKCjqEhb1tm+/43kd8Pgz6xDgXYZPa6k/lVpIkFRvlcQL67XxetcdIMqT
         g8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727884; x=1728332684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHj/lIlzFIU4shuEI1PXkmQf3BW7sLfbfdA5obcdX1E=;
        b=lqioYdb0aXDamzKZLk+5zSRvyuf6eiJv795K5htiVlrTM81dQiZAKeb6fPO/oJjnfe
         QyXK3maRcJW+cSulKcFQfHDGORENFVZ/qiDXK4yurP6Y1IYCFn8t4aYOC3KJisNzB7/v
         NNEQaAQkGKT4nkOa8TWPmGc9/vZD0qIvrGlrkwB3wpyF209f1red8iUDi6PP0zos15id
         XeAQnTBbS9cj3gbj6E6vLCUqEBKIeowBk/DvjSIlVtfo62ylHDUPJJPBOA9BO+b5PK/X
         s7IfItPwnj8IWN9/yFwndeAbMnfTvi1+oOuiZxFZu9kdOygDvMyLIOG+G0Ixx3fUc+ne
         hT7g==
X-Forwarded-Encrypted: i=1; AJvYcCWHa6y7cx8r9wyP9uL2Jh9fmvyYMpYBzszbb+7EXCs2i99VSrJ2+wFp34ke1ZKSrH2Qzx0cdeP09BuV3bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywre1LiULm1ok0cNeS0hMWk+X+FVRdWY03v2A2Jtp9VY9WyhOXI
	LzMjhesxM1CbvZBbPLrUiiqgcuqzCbedmwgncvttdY7s0SJQ4wCJTnMJWd+C
X-Google-Smtp-Source: AGHT+IHDuqwXABi7sp8QkV124jMxZI5GcRbPKzqCADzQEe2/hjSMGRC6xZmu8PfxNuUPVMPorSIxCQ==
X-Received: by 2002:a05:6a21:78e:b0:1d2:eaea:3b4c with SMTP id adf61e73a8af0-1d4fa6c3676mr22894942637.25.1727727884342;
        Mon, 30 Sep 2024 13:24:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265160a5sm6670623b3a.103.2024.09.30.13.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:44 -0700 (PDT)
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
Subject: [PATCH net-next 6/9] net: lantiq_etop: use devm_err_probe
Date: Mon, 30 Sep 2024 13:24:31 -0700
Message-ID: <20240930202434.296960-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202434.296960-1-rosenp@gmail.com>
References: <20240930202434.296960-1-rosenp@gmail.com>
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


