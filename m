Return-Path: <netdev+bounces-132450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD2991C10
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD6828335F
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E41714C9;
	Sun,  6 Oct 2024 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh7ydFls"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CA116EC19;
	Sun,  6 Oct 2024 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181734; cv=none; b=Q8ggRwyhwh+DIkOV8n5RisepC9jsh42mD7okJ6NP46xnAOeeeSnAlS7uThYglH+OTuW1Itx8PWA9afyn7t4TbQmMqjibip9Abm+dyOAO+CT7426Os1kys/mibqJfmscU9+XtA/sO/+ZwVGymFK1DSwvIyMCqfIAZWElgxhnZHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181734; c=relaxed/simple;
	bh=A8gJS6fEP9QvIScx57iYcjbGzw0KGh8cHqIn3dIOJyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnOgoVfIPD68KxrJIrxkfZOsAwwQHvRJ7WOefADxF19oW8xIrbal0d3cTJIn9oXWNdLt3/XM3SfqymjxUH/Sbdq6F6a7q5D3DipfIt8eh9lD2Qzb+uzHku7Dwe5aoQ23ioUPa2S1xSRDBXXoqjMcUiYT1u0mG7m/Hv0oAqso/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh7ydFls; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e9f8d67df9so648927a12.1;
        Sat, 05 Oct 2024 19:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181732; x=1728786532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT1fHxwhP5+cPvxE4VxQE/C0xITWVI3wQQyc3orisuY=;
        b=Dh7ydFlssKJm6M7HdnBOD9UGwcgpYtzoseW5YrxUYpLcVcI7ovhTDExAEVHOKvMjU1
         3JFEamCgamASf9zu3ch7viPh0IfDM8iv2v13XTQvlND+Yy9Rf08cQ1fzn146sECidLa+
         FTx5vfiMYyMDc58f0H6L9RyQ9uJB5NCzdD3pRc4EHFVftrlqxrIum5M4tHWCp8XsGdHw
         PC797NVk4aV9DSGtphcgFTeAJvdJyFRh87yH6xT8efufsnIj2kB7PgbKdy1NIFqVgdv8
         PiKgYFwR9f+ngOsY2J6r1MTmCJJ9iEKVm41BuHJP9OidWGesq1eCkLGo6ogTZ7jxc6lD
         fg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181732; x=1728786532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT1fHxwhP5+cPvxE4VxQE/C0xITWVI3wQQyc3orisuY=;
        b=ETWgFIZI5FoZ8h0Mf3oXC6rrfLG94bZ5qWLGXhltIy3IisEWeqluZoAFiKOHzfX3P8
         5grIXw3li/z6RqnO0QvAKT1nmkAFcAdsHsoTgOi8BeoVwQYsoAJKcSiHN/1SRWSaxXda
         vzQ0m2lGZyU/id4Rq28CJOSlrIPBELFpsoT8Dg+i+H8VtvIk7/5Pa7+unSi7DoYF1EGT
         5TF2/Kya085eOjP6VyQ84fhgA4hKNiiZ0oNLIx80bjoukK1xPXVcWGR87ILlNND0FtVR
         SE5x7zQa0NyGnwsKTacPP4q8xoUcau7GKlU/GNP41vrKYEOILmItaNZe/HHt2Af+qxnx
         pbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwhYUe2PkJ/ISIFWtBZwW81N/MDKZuo9e+6yIQCsFJlQTDIW8cvmgb5am7cdk+6X+944BVHyL/FVnE8Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYZ39iSz5F5sY9Y+DftDat29ponFML5uo3IiO5Mim+9Ax8qxQ
	F6wfy5Ao5PO1s8zU+8sfdDbW3uzUtiZ1N7uEpX7CbQC+BP/J7P5200sSCQ==
X-Google-Smtp-Source: AGHT+IHs0PyY14tzlzORYLFdsbKSqyNOPGmGaa1vZ5h7M3v6v3NrUU/TFRe9hKhxDHE3rbaCWR2VtA==
X-Received: by 2002:a05:6a21:3414:b0:1d2:e888:3982 with SMTP id adf61e73a8af0-1d6dfa36971mr9474007637.19.1728181732301;
        Sat, 05 Oct 2024 19:28:52 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:28:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next 04/14] net: ibm: emac: rgmii: use devm for kzalloc
Date: Sat,  5 Oct 2024 19:28:34 -0700
Message-ID: <20241006022844.1041039-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006022844.1041039-1-rosenp@gmail.com>
References: <20241006022844.1041039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the probe function by removing gotos.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/rgmii.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index 52f080661f87..8c646a5e5c56 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -219,28 +219,25 @@ static int rgmii_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct rgmii_instance *dev;
 	struct resource regs;
-	int rc;
 
-	rc = -ENOMEM;
-	dev = kzalloc(sizeof(struct rgmii_instance), GFP_KERNEL);
-	if (dev == NULL)
-		goto err_gone;
+	dev = devm_kzalloc(&ofdev->dev, sizeof(struct rgmii_instance),
+			   GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 
 	mutex_init(&dev->lock);
 	dev->ofdev = ofdev;
 
-	rc = -ENXIO;
 	if (of_address_to_resource(np, 0, &regs)) {
 		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		goto err_free;
+		return -ENXIO;
 	}
 
-	rc = -ENOMEM;
 	dev->base = (struct rgmii_regs __iomem *)ioremap(regs.start,
 						 sizeof(struct rgmii_regs));
 	if (dev->base == NULL) {
 		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		goto err_free;
+		return -ENOMEM;
 	}
 
 	/* Check for RGMII flags */
@@ -266,11 +263,6 @@ static int rgmii_probe(struct platform_device *ofdev)
 	platform_set_drvdata(ofdev, dev);
 
 	return 0;
-
- err_free:
-	kfree(dev);
- err_gone:
-	return rc;
 }
 
 static void rgmii_remove(struct platform_device *ofdev)
@@ -280,7 +272,6 @@ static void rgmii_remove(struct platform_device *ofdev)
 	WARN_ON(dev->users != 0);
 
 	iounmap(dev->base);
-	kfree(dev);
 }
 
 static const struct of_device_id rgmii_match[] =
-- 
2.46.2


