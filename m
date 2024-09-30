Return-Path: <netdev+bounces-130650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2260298B01A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C40B20C8F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DDF1946A9;
	Mon, 30 Sep 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKf7WIcM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039A6188CB6;
	Mon, 30 Sep 2024 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736064; cv=none; b=kX4SZ/BPffLLJQFqRL9d5sgPksZ3n5OV11Diq06OmSNqbb2arYXx28A2sJHOs9sz3ZZAeUdT3mGPr6kNOoUT98eakSfsYwGlxbOf3qkOswqIuOb9AS4fEQWBZkkA1oK/0htyC0L6HOXajR6mhDeNP8nOf9qtomfwFi8mEUFsi2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736064; c=relaxed/simple;
	bh=iqj9a7iIpUjrYd15WVWnWZFhqqFG10G6AO3gHegYl1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4M4jYzPHpoAMFwD+1bOSwc83EXx54G+7kJQpecQ/WQ8MAQ7EK1rWNJaPcml3QnDjJnCjAObrY5up7ojtNvGxObZ7HrnY3TS26FuwAFwY6JDNipO9IXB/hFu8ftP1w1oUR6nq/3ZF//jcUxcBFpRlfbuN0GviWN1gc1gxnQqHrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKf7WIcM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71979bf5e7aso3574371b3a.1;
        Mon, 30 Sep 2024 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736062; x=1728340862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZaALxrETLenGQam95OTWhwOfcaIjjMmX+34RjWfT3c=;
        b=mKf7WIcMbNsk2+O2hgnejO4w429vA4ePoXX2ehVKprp2k3TMYxQUbz4dLmJYefrPVk
         gh64ULoD4beZBA8lRKFIBqo48WmWT2QB15NkaDOGieusOHidza6sCAZ3AqZxd0UtcbWD
         i+EHRe1wMWEejDKlyVku5U2YJtOnNSLjcORio1628YCD71QjjBMPAatjywFBUgUTyMtV
         RUkBYWd5Irm5dr4X8d4ryLQ7E5rEKwH2mLrh3J0kuMeO4UY7/Ql9BpPhOxSjNaBTCkaz
         h9Lc0awzVbzQBVy5MA44YsBUuo2I0sFkzZBp0PQ5pRW04BpinF6VlP6aGjyUCgLTrOJL
         PAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736062; x=1728340862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZaALxrETLenGQam95OTWhwOfcaIjjMmX+34RjWfT3c=;
        b=AadAr+X37C8t9bYTFligvJI5vGhF0hRyfsJPy4ylmQIB3rKEyZFvcF4rYaiCPXcDSD
         fNYhW2mAqS0/+/OXW6mgdaJ0VouzHQA0/ylloq4opVHCGv3h6CzuMxiUU7ql9jd6KXVW
         LEkBd0J4BG4f2i+ctK2WtbpHLimlMEh7jPSGJ+6J5aCjA0x+WzdsLKdmx6r6oUq8U+jv
         3ZNA0GRzg6IdPYMFPq0xwu1opbjQ8bFEg2Wkc0wF0dd3tItOFH+xYSzTyru2yYG9OBDG
         ld1v4Hgt7BUQANbqzwyLy6u/4N1I/6dHaiDg5P3YjwmJCirtI25ASleQViWaKLoHK4gs
         +P4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGjpYvVqQirn63/c8UEZWEETmbTMygf/AVtt4ci2V/iHi1rSZo6F1Y1ZClRbInhmA6c/UuhQvOLK12/YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/u2+ZolFhqeclpTpt8jBko38QeysH9h+JXod+PsCLCBOyWIc+
	1Jbp6cvE2utPuirmD5/MzMvNJ8T3lqVH8tpq/NIHoo/yqEW3px3IWhl+1bx1
X-Google-Smtp-Source: AGHT+IEGn2qHNDIanhj5+COEzeMEGR77sc32cVkcEfI0ojBcaBh8IwX8BmdUaI7dL5UCAg+adDSpmQ==
X-Received: by 2002:a05:6a00:1412:b0:719:8f90:5bae with SMTP id d2e1a72fcca58-71b260839admr20416723b3a.27.1727736062200;
        Mon, 30 Sep 2024 15:41:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515e40sm6786921b3a.117.2024.09.30.15.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:41:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCH net-next 2/8] net: smsc911x: use devm_alloc_etherdev
Date: Mon, 30 Sep 2024 15:40:50 -0700
Message-ID: <20240930224056.354349-3-rosenp@gmail.com>
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

Allows removal of various gotos and manual frees.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 3d4356df0070..3b3295b4e9e5 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2336,8 +2336,6 @@ static void smsc911x_drv_remove(struct platform_device *pdev)
 	(void)smsc911x_disable_resources(pdev);
 	smsc911x_free_resources(pdev);
 
-	free_netdev(dev);
-
 	pm_runtime_disable(&pdev->dev);
 }
 
@@ -2417,7 +2415,7 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 		goto out_0;
 	}
 
-	dev = alloc_etherdev(sizeof(struct smsc911x_data));
+	dev = devm_alloc_etherdev(&pdev->dev, sizeof(struct smsc911x_data));
 	if (!dev)
 		return -ENOMEM;
 
@@ -2426,10 +2424,8 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	pdata = netdev_priv(dev);
 	dev->irq = irq;
 	pdata->ioaddr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pdata->ioaddr)) {
-		retval = PTR_ERR(pdata->ioaddr);
-		goto out_ioremap_fail;
-	}
+	if (IS_ERR(pdata->ioaddr))
+		return PTR_ERR(pdata->ioaddr);
 
 	pdata->dev = dev;
 	pdata->msg_enable = ((1 << debug) - 1);
@@ -2438,7 +2434,7 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 
 	retval = smsc911x_request_resources(pdev);
 	if (retval)
-		goto out_ioremap_fail;
+		return retval;
 
 	retval = smsc911x_enable_resources(pdev);
 	if (retval)
@@ -2535,8 +2531,6 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	(void)smsc911x_disable_resources(pdev);
 out_enable_resources_fail:
 	smsc911x_free_resources(pdev);
-out_ioremap_fail:
-	free_netdev(dev);
 out_0:
 	return retval;
 }
-- 
2.46.2


