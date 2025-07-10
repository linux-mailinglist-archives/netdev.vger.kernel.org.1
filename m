Return-Path: <netdev+bounces-205921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45675B00D4D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F320E48014C
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FD32FE364;
	Thu, 10 Jul 2025 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmT/3JsX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DEE28B7C2
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180037; cv=none; b=gFvtTKbv8BA2Plge6hRoPQyGztF1F2AtmFVsTxJ51k3Bbf7a+McDuoLxPPpr2FzQVCHY8hzmjYZBkxc/n41nmXvLid9nLIhN4ajB8p5xZ3IY0ooFXXsMR74mIg9VXu4yyi95X+FEjbh/upBtQJaCorUtlDG0aqKnQpu32lPFZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180037; c=relaxed/simple;
	bh=vBvWjyUsI7H4O43b1+ShcPMZOdKBMQwCoV5q/cWiwHM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZWqxviR4cP8A42/VNSbu4NInelbrO0MxbI5YSZqfPCJ2ZNPjBM70Uby8z2rMVVeScShnXLC3hn3NoxmWYpcDFMjWtgUjJEEfsxKsxaGtnax8hVTCVswi87y7A2LLtEWGK/sM8dbDApyAM89dgC4E8At0CP8IfiX6gc7mnhVQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmT/3JsX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23602481460so14719915ad.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180035; x=1752784835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DW11MDZ5YazetA3XzohFvUArwaGazXQv/75d1OLzYIU=;
        b=JmT/3JsXnHCz9rJfCliVIwyHh/k5yo8FPdcH2wY1mspvEHuro0hyG6uozvF5+Yprws
         Ix3ZycBiSADT5LdfsdAUM3dbK3FZtDSeECM4Scx/EKdZGlVdiQCqOKHLhjgwQ7MtQ7Xk
         POVPAOwO+JZ2Nfn7IEL0Twn7ZKXQu+1j9lxylQ0MRDxUAkp8Cns/2gCYaYg2+h16NC2D
         WM2rhAWYPHZDkr20HdBoLbIRkIRlx4FiIh1cdLF/yPPZYyF1RBtYH69qlohp4WojkyKo
         gprmRThliMIQFhO3l18xyrFHkItxVtzDKeW84euMDjknkIuG1tApyhMPzApyO2x52lx/
         BaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180035; x=1752784835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DW11MDZ5YazetA3XzohFvUArwaGazXQv/75d1OLzYIU=;
        b=pjfSHCMY66StMb3IlFcRLUbSo/VyHFpq+IWWXkrlkwyg3WZqhjMJ8w5wHf7YAXx9++
         2n8eiTo2jT2Fp5CuBBfdmMp5L86mj9G5PK8ogzZhd9tcb6bQwTY4Rlj8Bwq/fqCEAgr6
         MK0TOosT1+wpPst+Pid07Lv1MWRDbLqUbwHm2LNsrNLbz7UKmiRfzLtxI/JmU4yzl33I
         228Kap/XLwbWPSPua+Bhpht9UzzT70HpnZe78A1Y62Xd8SESc37+cidsP8k5ab/GwkaI
         Qapse4Sl/JJqlXPL526HUdjag4DAE1S5LumE4NPyZCgnRoLDubjXPcGDOJbZrMGMGwdV
         KPHg==
X-Gm-Message-State: AOJu0YzYQ3pDRojU6Li3p8KLyiC5BK72mKlpnU+CahxecVztKZIiklHJ
	0Fp6uq6+bsKJ9UYGpYlbJFUK86mi+iSdF9qHd7eHVFgoIVheanOuq3cpjIbcM+AC
X-Gm-Gg: ASbGncshoDRw/B0ABP55P9TD5NfUEfzb6Bqql6g/b5nwrjUTO8/Sg6tn5oEyXxThZHX
	1YwnNzUKkXrVHy+VgbGbhPK9Kcid7OoYjlZX/MnV3velEiUVS2EpHy6KAUcUVqu/rx0a45Pnkx8
	LxD/B7usb+0kaLCvyfB8aOjjmCRFgI4tcDFQup82d216VhGDREanJpsVWGk8f0T/BhogvjrHXdZ
	x9ZNuaxdlkXQAJ3Cm5dBTkB33wynA+MkZGVBrAn6nG58Zaguchkq1kpOLCG0rOiP8nUNCZLSlD+
	WjrW/U60TYT8uq/+reSRrNKmChpZS7/vMaXPLB2Cl9KoYJsHn7dwroS2KuevB/p63YWn9mp7fKb
	zhBc=
X-Google-Smtp-Source: AGHT+IGKRdhe0kA9F1d6JNbzUzfVHYWkLFfoHT4MpaYgpvEhXzdrQx1snFGv3WAGfaroDej+9N2ZPA==
X-Received: by 2002:a17:903:1ae3:b0:22c:3609:97ed with SMTP id d9443c01a7336-23dede890e9mr7292265ad.30.1752180035037;
        Thu, 10 Jul 2025 13:40:35 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm3547861a91.46.2025.07.10.13.40.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:40:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 02/11] net: fsl_pq_mdio: use devm for mdiobus_alloc_size
Date: Thu, 10 Jul 2025 13:40:23 -0700
Message-ID: <20250710204032.650152-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710204032.650152-1-rosenp@gmail.com>
References: <20250710204032.650152-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using devm avoids having to manually free. In the case of this driver,
it's simple enough that it's ideal for devm.

There also seems to be a mistake here. Using kfree instead of
mdiobus_free.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 108e760c7a5f..d7f9d99fe782 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -423,7 +423,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	new_bus = mdiobus_alloc_size(sizeof(*priv));
+	new_bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
 	if (!new_bus)
 		return -ENOMEM;
 
@@ -437,17 +437,15 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	err = of_address_to_resource(np, 0, &res);
 	if (err < 0) {
 		dev_err(dev, "could not obtain address information\n");
-		goto error;
+		return err;
 	}
 
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%pOFn@%llx", np,
 		 (unsigned long long)res.start);
 
 	priv->map = of_iomap(np, 0);
-	if (!priv->map) {
-		err = -ENOMEM;
-		goto error;
-	}
+	if (!priv->map)
+		return -ENOMEM;
 
 	/*
 	 * Some device tree nodes represent only the MII registers, and
@@ -502,8 +500,6 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	if (priv->map)
 		iounmap(priv->map);
 
-	kfree(new_bus);
-
 	return err;
 }
 
@@ -517,7 +513,6 @@ static void fsl_pq_mdio_remove(struct platform_device *pdev)
 	mdiobus_unregister(bus);
 
 	iounmap(priv->map);
-	mdiobus_free(bus);
 }
 
 static struct platform_driver fsl_pq_mdio_driver = {
-- 
2.50.0


