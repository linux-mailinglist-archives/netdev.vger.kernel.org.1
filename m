Return-Path: <netdev+bounces-130651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2131298B01C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B94F1C226EA
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E7B1A0BDA;
	Mon, 30 Sep 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCSimmsE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A419192B77;
	Mon, 30 Sep 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736066; cv=none; b=WmpTRPr/ZBpzsIwDx7VQUc4yB5+veqF1aUAO4L9u7GGN4mZIl5O9KgAAlxUmFh5cBwUY3zZkRWdOlDuIMkeRxaVGNuyQX3msWICVGkYjuvvt4S8gFcLXOrwBs27pZ3F+3qQqUcTLt7zE6ojbTOTtKyOF2+PlVaZDxntdSqV+vQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736066; c=relaxed/simple;
	bh=x994x0rBBXuswtZWWrjpOvS/r+5K72UXBv+BHNYF1+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U50Znn1mJN+Y6JRKdQKJJwNnoGQ5pby+FROrm105ulqWe+SDBmaFv9ScPVrNTY1nJZNJeAZKPZbdKT5yS1OMutp6+899VwF+1fUINLGRxtu7SNJmN+mgzH98UbVjEv3JwLFobeWTWpGuj00hrq8i/UebRa29W+OBY+mi4gQ1PbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCSimmsE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7178df70f28so3831624b3a.2;
        Mon, 30 Sep 2024 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736063; x=1728340863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/rvMPtWP8DD5zfR08yofPW0Dn4PaREoOaJcNdoxwJU=;
        b=dCSimmsEhp7pJr4aAvOYxkx/dtGV/BSGqQnLJrzsBILGgoMqqQPvCtXDbuEYmRg/Ai
         a+ykGLn/+P3DuZzIEDK0L0+6unFGO+R+JB0ovwBOnxllnrhmfFc5EkUetM8SS0VN6jT9
         to/KxidKRvo8DVkmP7+C2YIX/boYcH+sblu0yqBTcMDSP5fdWYssQMQkQhCaDwhR6V8E
         fjOpGX65dMz4WLMpLTZlNlwwTbt1jACsITP/MBAQRfeZ0Eo60up4ow/3V7ZvxM7ZtQeE
         pchzTWVau7vwmDD6MQvwKSED5oRV4shPWZHk9rf+5oeuQ5sXNeXlZbCh5DO84/Sew+VL
         iRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736063; x=1728340863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/rvMPtWP8DD5zfR08yofPW0Dn4PaREoOaJcNdoxwJU=;
        b=dmOXrN+BMpd4g7lXd/PTeYqDulZgNwa9bQw2/9dXgCNbLVQYWOd+4xK2Vs2YsmbDWS
         kWgQDjIzRLRAKQbLhbNaIxtcWC6uJAWddFFmCCqf8Oz/y97abuZdsxZSb3Cv1bXmf1Cr
         ltKxb6kYnpyv3rv0ptzqzaalQu1fH9PYy4oXshJ459QdIgARfx2YkzzA1XjsA1lND9Ug
         LZK/PEf2bAkaDrqgj0mSX1kTs53lasre9KpEhmgYlJ+VZJcyj9X6ben1r/E8dQXgkLhP
         gbtzZHDWRXOXobatmEfi/zhWn9Bs0YrQc1GMDVUzzl2CNyBwlUXGCtxt7NACDU2mfh4y
         C2kg==
X-Forwarded-Encrypted: i=1; AJvYcCUgwONzMnMyOBpr7CQ5SlACHf7fehoezC71KdvEwbEELANCsUW0B3lkS9XTmdBvBN+WGPfHv56Ldj9oPMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGj8f9RqsBEvWvpLUS1zzh2otEsNtmrZdJazGbG/0GoTanrTu
	/BxwM3Oys8TvaromsS4+Qxovmlijrz3Wj/GThrXgvnyNnn6n1lTlCyEeXlRb
X-Google-Smtp-Source: AGHT+IFm65tgB2Nwcn9iqP1ktq2K+3nuEjU6r3DPFHfqdhdqeDCCLFZl75U9ht87CpRJkaTCsvLA+Q==
X-Received: by 2002:a05:6a00:2e87:b0:717:9154:b5b6 with SMTP id d2e1a72fcca58-71b25f3dae9mr21221595b3a.7.1727736063567;
        Mon, 30 Sep 2024 15:41:03 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515e40sm6786921b3a.117.2024.09.30.15.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:41:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCH net-next 3/8] net: smsc911x: use devm for regulators
Date: Mon, 30 Sep 2024 15:40:51 -0700
Message-ID: <20240930224056.354349-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930224056.354349-1-rosenp@gmail.com>
References: <20240930224056.354349-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows to get rid of freeing functions.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 106 +++------------------------
 1 file changed, 12 insertions(+), 94 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 3b3295b4e9e5..68687df4eb3b 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -132,14 +132,8 @@ struct smsc911x_data {
 	/* register access functions */
 	const struct smsc911x_ops *ops;
 
-	/* regulators */
-	struct regulator_bulk_data supplies[SMSC911X_NUM_SUPPLIES];
-
 	/* Reset GPIO */
 	struct gpio_desc *reset_gpiod;
-
-	/* clock */
-	struct clk *clk;
 };
 
 /* Easy access to information */
@@ -369,41 +363,10 @@ smsc911x_rx_readfifo_shift(struct smsc911x_data *pdata, unsigned int *buf,
  */
 static int smsc911x_enable_resources(struct platform_device *pdev)
 {
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct smsc911x_data *pdata = netdev_priv(ndev);
-	int ret = 0;
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(pdata->supplies),
-			pdata->supplies);
-	if (ret)
-		netdev_err(ndev, "failed to enable regulators %d\n",
-				ret);
+	static const char *const supplies[] = { "vdd33a", "vddvario" };
 
-	if (!IS_ERR(pdata->clk)) {
-		ret = clk_prepare_enable(pdata->clk);
-		if (ret < 0)
-			netdev_err(ndev, "failed to enable clock %d\n", ret);
-	}
-
-	return ret;
-}
-
-/*
- * disable resources, currently just regulators.
- */
-static int smsc911x_disable_resources(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct smsc911x_data *pdata = netdev_priv(ndev);
-	int ret = 0;
-
-	ret = regulator_bulk_disable(ARRAY_SIZE(pdata->supplies),
-			pdata->supplies);
-
-	if (!IS_ERR(pdata->clk))
-		clk_disable_unprepare(pdata->clk);
-
-	return ret;
+	return devm_regulator_bulk_get_enable(&pdev->dev, ARRAY_SIZE(supplies),
+					      supplies);
 }
 
 /*
@@ -417,24 +380,7 @@ static int smsc911x_request_resources(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct smsc911x_data *pdata = netdev_priv(ndev);
-	int ret = 0;
-
-	/* Request regulators */
-	pdata->supplies[0].supply = "vdd33a";
-	pdata->supplies[1].supply = "vddvario";
-	ret = regulator_bulk_get(&pdev->dev,
-			ARRAY_SIZE(pdata->supplies),
-			pdata->supplies);
-	if (ret) {
-		/*
-		 * Retry on deferrals, else just report the error
-		 * and try to continue.
-		 */
-		if (ret == -EPROBE_DEFER)
-			return ret;
-		netdev_err(ndev, "couldn't get regulators %d\n",
-				ret);
-	}
+	struct clk *clk;
 
 	/* Request optional RESET GPIO */
 	pdata->reset_gpiod = devm_gpiod_get_optional(&pdev->dev,
@@ -442,32 +388,12 @@ static int smsc911x_request_resources(struct platform_device *pdev)
 						     GPIOD_OUT_LOW);
 
 	/* Request clock */
-	pdata->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pdata->clk))
-		dev_dbg(&pdev->dev, "couldn't get clock %li\n",
-			PTR_ERR(pdata->clk));
-
-	return ret;
-}
-
-/*
- * Free resources, currently just regulators.
- *
- */
-static void smsc911x_free_resources(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct smsc911x_data *pdata = netdev_priv(ndev);
+	clk = devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+				     "couldn't get clock");
 
-	/* Free regulators */
-	regulator_bulk_free(ARRAY_SIZE(pdata->supplies),
-			pdata->supplies);
-
-	/* Free clock */
-	if (!IS_ERR(pdata->clk)) {
-		clk_put(pdata->clk);
-		pdata->clk = NULL;
-	}
+	return 0;
 }
 
 /* waits for MAC not busy, with timeout.  Only called by smsc911x_mac_read
@@ -2333,9 +2259,6 @@ static void smsc911x_drv_remove(struct platform_device *pdev)
 	mdiobus_unregister(pdata->mii_bus);
 	mdiobus_free(pdata->mii_bus);
 
-	(void)smsc911x_disable_resources(pdev);
-	smsc911x_free_resources(pdev);
-
 	pm_runtime_disable(&pdev->dev);
 }
 
@@ -2438,12 +2361,11 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 
 	retval = smsc911x_enable_resources(pdev);
 	if (retval)
-		goto out_enable_resources_fail;
+		return retval;
 
 	if (pdata->ioaddr == NULL) {
 		SMSC_WARN(pdata, probe, "Error smsc911x base address invalid");
-		retval = -ENOMEM;
-		goto out_disable_resources;
+		return -ENOMEM;
 	}
 
 	retval = smsc911x_probe_config(&pdata->config, &pdev->dev);
@@ -2455,7 +2377,7 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 
 	if (retval) {
 		SMSC_WARN(pdata, probe, "Error smsc911x config not found");
-		goto out_disable_resources;
+		return retval;
 	}
 
 	/* assume standard, non-shifted, access to HW registers */
@@ -2527,10 +2449,6 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 out_init_fail:
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-out_disable_resources:
-	(void)smsc911x_disable_resources(pdev);
-out_enable_resources_fail:
-	smsc911x_free_resources(pdev);
 out_0:
 	return retval;
 }
-- 
2.46.2


