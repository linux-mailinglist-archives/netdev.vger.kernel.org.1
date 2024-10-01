Return-Path: <netdev+bounces-130985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7285798C55C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3070A287489
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A82E1CDFA7;
	Tue,  1 Oct 2024 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTY3+AlJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7481CCEE8;
	Tue,  1 Oct 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807365; cv=none; b=pxlGmT2chUX63x+t8vNOCd/3p8e8gvQ8bw9PHI3stORJ2qeecvqVB5gVQ+6CbOUw7Nlkfp4jVniAH0rsuw+gAg+/NDw8ijf1/JO/Wd5Z01U4LY05otovk1T7dDzLoguId1Bb84d+ygPGihXAKTN0cbeNsgTRCmKKYvtWDgvuJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807365; c=relaxed/simple;
	bh=x994x0rBBXuswtZWWrjpOvS/r+5K72UXBv+BHNYF1+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0zSR8WqWmP1zeKTl4djkCeY88s5bCuqFivPFqq6VUyVnnq3EAcusDH2x1k54bBfxSELAIBpU767OhSy8Fsf5TkjMKiAn7UIBLOGJBTz71KBMBUVsARoV0kprHq7HH7Sf9JM3QLMJXjuNWmrfDCBXMr2vl17Yr8tslvnBUUBepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTY3+AlJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso76068a12.1;
        Tue, 01 Oct 2024 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727807363; x=1728412163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/rvMPtWP8DD5zfR08yofPW0Dn4PaREoOaJcNdoxwJU=;
        b=HTY3+AlJJ7Zn+K6o+IcsMclbTGv5P2Y5ZO7ro1v7l13iApw8Ak9jgt6yhc22jG3B6n
         GPpOqP7CfL3igEwCjJORcQujykeKSVPxZD0V3kvDJRi9LlKAMxV+rTslQg5zXoaZsjI3
         LtqbeC/brFeUXzHnC1GTYMH+ydU67Okln9XUXRegusywFrHSl9CtzCcyCT7YkY2s7Jw1
         CPEeJ6pQ9t7HZMnq2U3U4UQ10jCULzvDYMcYmFgNFMNFAU4gkgd6qz/N4u4VB38PZ5GG
         ctRPQGZmVdU/yB1p9p10PbFdi4VLKzcuudZUF4gmXnX5awJpn8B4yK1nEnVkQKTdXG2x
         1fmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727807363; x=1728412163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/rvMPtWP8DD5zfR08yofPW0Dn4PaREoOaJcNdoxwJU=;
        b=BAdHwrd2p7S32o3x1zYLyuoXXufxHv4TW3TXBpTmjIEbK0o2jXQIBtGnwXvDrkietQ
         Muifbmvp4sIWSwgs1lq5POv0ZhuuTa8LAqaDLS7cIQHCPAd9TLpCck9qOWmS8Kq3SNc8
         JZ5NlwXpBKsBXuHGdKUt+7ooTAS3FUtPaafHHripSpFcpZim2luHl+S4YV0yeUldqU0R
         cPKWyj3B7HBTMHK1Z/bve3kZILINMXf7tr6ohjl9ksg3psXSZXIoG57qGBJFrnXBZ/Sy
         y/NUA6xGWJH3tC5+bdjQMmzXptNSzfLLpJxOVYFYmQw/wVx+sh2dILNc2UaBpdSUe3x2
         jQng==
X-Forwarded-Encrypted: i=1; AJvYcCX0pJWDtANbHo23gX1uw7jum/CzAg6kvtmuQDmRBNnRfgy1QHBPr/uj8MOUfnztVlvpdlU/CXxp33W8jsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzYsnFvRCgaZ22LVI8EyY/FD9rrjopnUvXMYS/pIc5CsA2S2F
	WZhmzioeyIzXg/4FkDZnyk4WRaT0nvuasnT0o5NS6IsDHK6NLGUZcbU6rzUL
X-Google-Smtp-Source: AGHT+IG8Q0jX9Ja5aSm0+Tcy74vu0jwOLkDjgzb5XuLV0jrA6wYPbvhYbsJqQHFfhUm88V/JTlBtbQ==
X-Received: by 2002:a05:6a20:d494:b0:1d2:eaea:39d7 with SMTP id adf61e73a8af0-1d62e24393emr829625637.9.1727807362927;
        Tue, 01 Oct 2024 11:29:22 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d56sm8649467b3a.170.2024.10.01.11.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:29:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCHv2 net-next 3/9] net: smsc911x: use devm for regulators
Date: Tue,  1 Oct 2024 11:29:10 -0700
Message-ID: <20241001182916.122259-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001182916.122259-1-rosenp@gmail.com>
References: <20241001182916.122259-1-rosenp@gmail.com>
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


