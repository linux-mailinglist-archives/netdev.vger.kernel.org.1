Return-Path: <netdev+bounces-131054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F59698C725
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1161C2386E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F51D016E;
	Tue,  1 Oct 2024 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+QEYX8h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC291D0145;
	Tue,  1 Oct 2024 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816343; cv=none; b=MKQSVTg7aHTGmtd8meMomJilvOxgGMcSKHTh/sMkCVsXjn/KHZt+ABd1Vwj+Bbj9EEDrPWH4DfGNBhESatSEWWBdPGPzUL7vIIP6dikZSLW+CXRzvfuYLUH2WEjNeMogJe6fjXpp6MeXemfrqCeRysJXOM+EjfTBOowtpTNqyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816343; c=relaxed/simple;
	bh=FHY66iZ1UrcrbeXKE99B9ikoT6GAi0J+noOtDA2DGFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFCFIu6yMs+BIl869K2SyIcy0ycWhN+6WQEpoGsb8+Tzyj1Pblk8LlIjk6Bg6pMHIq8fZXFPFNyF0Oet3fEQO+vrc3kdjpgQKv47YPb1qKBVOlXhAMhxWSVIO32kIUuGLX6YIlbGa5DXPzssck8MOFJMCqnNIIbvk6phGmvHSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+QEYX8h; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71788bfe60eso4458832b3a.1;
        Tue, 01 Oct 2024 13:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816341; x=1728421141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCLbZsayLlcNqhgpjNVIbKiCMjSAjR3dphSfWdGQgSs=;
        b=m+QEYX8hOAmeVGqfu2gN8Xsx9xAVJewp7hMh7WZ9aKp4GtY4LIKigcJjm0c/7J4/1v
         JNR05Z8DFn9tdUxydmxFS3bezBAD0+flQE3W7OY+d7c+aQEyLNGA6RLoQBuDGzTHJUid
         tS7l0szKh/qXro3Dk9xdjpJmitNL8TbZrFAdNxDt7U5tn6iAmhgDqA7IDqYP+nB9Nmq/
         r1xfWpI4J8bsPz+mjeNUNqSIbiGQC13UFUB+1ZvtM9uHqWDA2Db2093kKhf8eaD0I6Fw
         IATSVMjutm7EiZylzgo0Ra5NFIeWC61vCDaOKuiKUsoqN4B/4Lr46y2KAJNRvR4Ta7Q6
         qN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816341; x=1728421141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCLbZsayLlcNqhgpjNVIbKiCMjSAjR3dphSfWdGQgSs=;
        b=CCA91bPb0GjKe2k/FGGZZJRXC9zziQ5xlonPQI2Qo2hs4YGOL1wtgr3A4Dp3dV3W9K
         XFJlzJvSyXbo2SodmWFJRsfrmVl1EP7WgZL029iaEc9w29+eZVPlD8wRfi4uDIQCQBQt
         RkJ9fbtIOITAd4VEb1a4FcRko0G70Mw+o0Mx7ioUt85ST04n2HYQsIAeIAXEcF3MRJEP
         Vq7RHxfxN25uPE/hQoMeM3z0Pm5xAyxLMIQbocwQmmldiLHu2KCRkvPofz9IGNZik3at
         WZcDvnV8LyP/ZL9uNJ9w2RH7wbW9Fj3Vzhlg0elMKhEPEM+LJV9nZJr8yGITPqossOWA
         RcYg==
X-Forwarded-Encrypted: i=1; AJvYcCXVZpHDLyTv9cZAW2TPhp7XRkmUuI0wl1pU8A2o2O7XOqIkHlfffI3FXDgYAmUvUpyP7Y3thmCDpQjuC9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUQbkF4W+KUmdskC9dxIjwUHMJVLtWSLcEKNbhN7GDckGZ9fQ
	3BZj7xo5LoU/wOGZFcckOeC0/kEJFTAEvxhB6v+cY+QKuWPtsA18P1bANOTE
X-Google-Smtp-Source: AGHT+IH2e2iz/6iGzx2q06St1nGx7MBiueTm87p85AqIrG7BHenR97sY1ssoMmd3g42AqZS8mTeW7Q==
X-Received: by 2002:a05:6a20:4499:b0:1d5:377c:224c with SMTP id adf61e73a8af0-1d5e2d9e14emr1378603637.37.1727816341077;
        Tue, 01 Oct 2024 13:59:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:59:00 -0700 (PDT)
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
Subject: [PATCHv2 net-next 10/18] net: ibm: emac: rgmii: devm_platform_get_resource
Date: Tue,  1 Oct 2024 13:58:36 -0700
Message-ID: <20241001205844.306821-11-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the probe function by a bit and allows removing the _remove
function such that devm now handles all cleanup.

printk gets converted to dev_err as np is now gone.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/rgmii.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index 8c646a5e5c56..25a13a00a614 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -216,9 +216,7 @@ void *rgmii_dump_regs(struct platform_device *ofdev, void *buf)
 
 static int rgmii_probe(struct platform_device *ofdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
 	struct rgmii_instance *dev;
-	struct resource regs;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct rgmii_instance),
 			   GFP_KERNEL);
@@ -228,16 +226,10 @@ static int rgmii_probe(struct platform_device *ofdev)
 	mutex_init(&dev->lock);
 	dev->ofdev = ofdev;
 
-	if (of_address_to_resource(np, 0, &regs)) {
-		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		return -ENXIO;
-	}
-
-	dev->base = (struct rgmii_regs __iomem *)ioremap(regs.start,
-						 sizeof(struct rgmii_regs));
-	if (dev->base == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		return -ENOMEM;
+	dev->base = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->base)) {
+		dev_err(&ofdev->dev, "can't map device registers");
+		return PTR_ERR(dev->base);
 	}
 
 	/* Check for RGMII flags */
@@ -265,15 +257,6 @@ static int rgmii_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static void rgmii_remove(struct platform_device *ofdev)
-{
-	struct rgmii_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-}
-
 static const struct of_device_id rgmii_match[] =
 {
 	{
@@ -291,7 +274,6 @@ static struct platform_driver rgmii_driver = {
 		.of_match_table = rgmii_match,
 	},
 	.probe = rgmii_probe,
-	.remove_new = rgmii_remove,
 };
 
 module_platform_driver(rgmii_driver);
-- 
2.46.2


