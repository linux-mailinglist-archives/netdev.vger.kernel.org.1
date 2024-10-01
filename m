Return-Path: <netdev+bounces-130983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8AC98C555
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDB01F2563B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF431CCEC9;
	Tue,  1 Oct 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8VWbwiG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6B1CCB37;
	Tue,  1 Oct 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807362; cv=none; b=S+UFTmKG9vgdrNS91urUt/zehBJgSEAyzGMhh21X8LOIGpaW1g2kCRNREoVFqEu+XAeFSFG4Wil6E8hW/S3xfwYnYevfW96yzHsaCoHz/A5qBPTk0U9sToGPkWgGI05gF6d6U3Zx4XgMoo7MCsX1yeOLPLJrOWRIEoAzl2B6+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807362; c=relaxed/simple;
	bh=UO1AK6cSFv2YpB5vO4G4kuMpDK6Xz9tYWWRtpYMz804=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSPzjTHXrgz7idGzMaOPgE+V8Imsr+7QYneA6Tu/EQxhhSMcPOHuTQF86/UFMOdpfAeoMYW9i+RnKxjHvOuypLEsEpcnzV2LY3998gTSgY33c3XCwYgeX9BXeBQE9EZBWgGuAoRfhFrqqypCcn+RaBjOv7l+XZlKgTdHq7o0Z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8VWbwiG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-717934728adso4575636b3a.2;
        Tue, 01 Oct 2024 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727807360; x=1728412160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNW0qIQYuJi3K43w+QYrXz5749AOyaUHcAHp+VAUvX8=;
        b=J8VWbwiGgr66BcE/XzrokDlmiM31NanpjeOXLzismNGhs4s3pI6d3EC4mZphVi8GGX
         x88p/T+TEMJZscPA+bD6kmqp8P5hgnLRbgVijjJDHQkmlGMYozg13sHhcV0Gm/+hV4RY
         vsJ3gVM9zC5q3TDDaHEs9bD4jjM0YGoVn7vbYtq1yBsh0OqGjNRiXD/AjIxVsILPClY3
         rvi27nVD5Qqz2X33A6uAZnCkX5s+05zeQy7gROWohUa1xtzwS0FMO17WkYzeGCMVrk2Z
         c09iEW3EkeU2aMNxDvj0ELNH0aOCZLhX3wKllBrVUKzZACkQnvSi3RCB6M3MVwrpUnf3
         Whkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727807360; x=1728412160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNW0qIQYuJi3K43w+QYrXz5749AOyaUHcAHp+VAUvX8=;
        b=HlVmXIzIdczoPSFikppgj/MaKvKlXK6bKLFm8sKbwKSS2284cOqB4noFIfr3gTZPzM
         zwRLu1Ka5w3jCUVqeZZK1HO3ouHjfDLXpWxN+Ih+F/VVPLDT35O1UCTU5W2SJNbv9J9S
         NI8RlbUJKUwxCP6iqOOqoyMmXUl1zVUyZn8rB7KMywNiai+2pD1YE75plaDXeZ9uqPCz
         FKp0tJgscYTRMqBTDNGku3F0xVZ7d49CrlFh2T4p0HxG22TfwT+EsF2IKCO305YxU1MB
         UwshwKGhIRMyU3Xh9RbVGlpwcMt/7KkBv30k2sGi3YdAPv5RFnT/wkfPJBBJ/VQekxfG
         RXyg==
X-Forwarded-Encrypted: i=1; AJvYcCXEV4OtqKo6whYQfUCs5wibFyGc1rZDSPJtqUqrPRtB3c/qHQKo/SrBvQ824NrlVagpk9YbjLiexWT4fpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBccfZPnwrZNJyG1mxl9SowciBYP9zKp9JwkQ1wioDrzZwydZ5
	WYJsMAIz8cbBIA/2B05v+9Kuy9t6rXXdCU/K6ClHn40aisNUwhgEAbhmzYud
X-Google-Smtp-Source: AGHT+IHCRQkqAgnNFAUzucFB9h5q6M3RzDuijt5RBuntg5OAKKr9hdtc9yUC7qRFq5VrxAFERkSmRA==
X-Received: by 2002:a05:6a00:2d06:b0:717:d4e3:df21 with SMTP id d2e1a72fcca58-71dc5d8707emr902251b3a.23.1727807360449;
        Tue, 01 Oct 2024 11:29:20 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d56sm8649467b3a.170.2024.10.01.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:29:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCHv2 net-next 1/9] net: smsc911x: use devm_platform_ioremap_resource
Date: Tue,  1 Oct 2024 11:29:08 -0700
Message-ID: <20241001182916.122259-2-rosenp@gmail.com>
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

Allows removal of a bunch of code relating to grabbing resources.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 47 +++++-----------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 74f1ccc96459..3d4356df0070 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2319,7 +2319,6 @@ static void smsc911x_drv_remove(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct smsc911x_data *pdata;
-	struct resource *res;
 
 	dev = platform_get_drvdata(pdev);
 	BUG_ON(!dev);
@@ -2334,15 +2333,6 @@ static void smsc911x_drv_remove(struct platform_device *pdev)
 	mdiobus_unregister(pdata->mii_bus);
 	mdiobus_free(pdata->mii_bus);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "smsc911x-memory");
-	if (!res)
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	release_mem_region(res->start, resource_size(res));
-
-	iounmap(pdata->ioaddr);
-
 	(void)smsc911x_disable_resources(pdev);
 	smsc911x_free_resources(pdev);
 
@@ -2414,21 +2404,9 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	struct net_device *dev;
 	struct smsc911x_data *pdata;
 	struct smsc911x_platform_config *config = dev_get_platdata(&pdev->dev);
-	struct resource *res;
-	int res_size, irq;
+	int irq;
 	int retval;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "smsc911x-memory");
-	if (!res)
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		pr_warn("Could not allocate resource\n");
-		retval = -ENODEV;
-		goto out_0;
-	}
-	res_size = resource_size(res);
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq == -EPROBE_DEFER) {
 		retval = -EPROBE_DEFER;
@@ -2439,24 +2417,17 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 		goto out_0;
 	}
 
-	if (!request_mem_region(res->start, res_size, SMSC_CHIPNAME)) {
-		retval = -EBUSY;
-		goto out_0;
-	}
-
 	dev = alloc_etherdev(sizeof(struct smsc911x_data));
-	if (!dev) {
-		retval = -ENOMEM;
-		goto out_release_io_1;
-	}
+	if (!dev)
+		return -ENOMEM;
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	pdata = netdev_priv(dev);
 	dev->irq = irq;
-	pdata->ioaddr = ioremap(res->start, res_size);
-	if (!pdata->ioaddr) {
-		retval = -ENOMEM;
+	pdata->ioaddr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pdata->ioaddr)) {
+		retval = PTR_ERR(pdata->ioaddr);
 		goto out_ioremap_fail;
 	}
 
@@ -2467,7 +2438,7 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 
 	retval = smsc911x_request_resources(pdev);
 	if (retval)
-		goto out_request_resources_fail;
+		goto out_ioremap_fail;
 
 	retval = smsc911x_enable_resources(pdev);
 	if (retval)
@@ -2564,12 +2535,8 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	(void)smsc911x_disable_resources(pdev);
 out_enable_resources_fail:
 	smsc911x_free_resources(pdev);
-out_request_resources_fail:
-	iounmap(pdata->ioaddr);
 out_ioremap_fail:
 	free_netdev(dev);
-out_release_io_1:
-	release_mem_region(res->start, resource_size(res));
 out_0:
 	return retval;
 }
-- 
2.46.2


