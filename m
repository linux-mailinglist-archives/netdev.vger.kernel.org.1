Return-Path: <netdev+bounces-130649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50A98B018
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401512837D5
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFAF1891A9;
	Mon, 30 Sep 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5XY+G+U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB763187849;
	Mon, 30 Sep 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736063; cv=none; b=fgyziDJNwcIPulKeASVZtuVmde8J6XZbtxxTsqUNs5/pL8dzrjGgq1zsQ4mmEs9oPp9lAfipKyAsWptc5Lv9o1wbs99qH+o9GrJGlrCfO6ZrNfhHMGwTEEFzqGhyL7MMd8xv8OSOvjtnB5gEk04NKNbe8bgKHIDhTSgBaKViUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736063; c=relaxed/simple;
	bh=UO1AK6cSFv2YpB5vO4G4kuMpDK6Xz9tYWWRtpYMz804=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrqZfybeH6SlsGrgb71elOmi8d6UXDfBPapDT8v447H5V2rC+NdwEzMwHMg4XCZZb6AThdnGpLeKX3N62ctjiwkh0kuEULsscn9nPvz7IW9psmKwTnxawi+yrFFJCEGuoJb1/xvjSt95UVrJ7drOZY80sXD4ZUrobppQCfzpXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5XY+G+U; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71b070ff24dso4331753b3a.2;
        Mon, 30 Sep 2024 15:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736061; x=1728340861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNW0qIQYuJi3K43w+QYrXz5749AOyaUHcAHp+VAUvX8=;
        b=f5XY+G+UrF+6Znk9Xn96ol+8A+YAMrH3xCB1iB/1W8p/1xhfNpcCs+DWlYkVJSMUvR
         w18Sm8fCn06hwB7vF6YKqdk8hL3iKN4MMfZdslHe18xypi2HhCf6ztrdNH65/OeB4mhy
         p7ZA90EDYcWKnJnG+sywZMiKO7cTFkTaK/kSQKJM2Pz6ElSBjr1V9pd2U8tknl2hWUyq
         FGarN/Z1h+TdB2mxjJSq00dIEA/bk6TXGWWPKkYYOv4IpYcF+m0NnLzo9COcjrEAI1Ve
         Ph413njpbSMfWnJwTy1F5Wed3yYsLr7uBhPQIzxvkDC18e7VD5q4UPqy4CUTotZRiLXU
         DEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736061; x=1728340861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNW0qIQYuJi3K43w+QYrXz5749AOyaUHcAHp+VAUvX8=;
        b=s5FBS3D2Dl435yYU3jG9nZEZ/j53VOPO3urWBvyYN2Ru+oQBFznXFIcdIIt8ACE2Zz
         gibnLKTGkPbMVYyLFhTDmB+FcrVebqprFXC6lWw+lyuNuCKkBPZpAFrKV7RYunB0GtHi
         0LDhVn5wRpIpwGKKeQBgCcfQTDO1dlNdDQ4jv2xL50xqo0jFyd3rIeLcwr+Tl/GvCTcV
         VYo2lLrz6BI2POPdzypHbBhYif3D5Z3+Z41oQeW+O4O7UHEtVzkBORaATHZ59bSjB8Bm
         rbHjRRvL/SayZ4cB1FRHDkten9aY3KDU0L+1xOjVY0cviTcbetiR+RWvLHa1uFtxt8oC
         eoow==
X-Forwarded-Encrypted: i=1; AJvYcCXP16S8QAniBcO4u1dSyVtowJuAvKBOQZO554PhZemJ/Hv5zroM7Esit4+NyuuB2oB9vydP5vIUNDOZNYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDd7tIT6xB6QUSIN9UrYjxvdPzYKg5d7nwjsuTA0VOfRYAGHBd
	l8lt7tYlDQaIQ6PYRVdhcS7wbRHuTRRZbPBP72WQcyxBeUZFyDc9mDVGCKnO
X-Google-Smtp-Source: AGHT+IE8NZqlTieUcOjHj0al9kkTMlY+9HufH4pcT3RRtcgr2pW2tuxuXbEkrFDyqsGmiJbDT08WNQ==
X-Received: by 2002:a05:6a00:3e1b:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-71b25f75357mr21460538b3a.13.1727736060783;
        Mon, 30 Sep 2024 15:41:00 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515e40sm6786921b3a.117.2024.09.30.15.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:41:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCH net-next 1/8] net: smsc911x: use devm_platform_ioremap_resource
Date: Mon, 30 Sep 2024 15:40:49 -0700
Message-ID: <20240930224056.354349-2-rosenp@gmail.com>
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


