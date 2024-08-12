Return-Path: <netdev+bounces-117819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E09B94F73E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A9E1C222AF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05CA194083;
	Mon, 12 Aug 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOzhq+OC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBDB192B67;
	Mon, 12 Aug 2024 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489628; cv=none; b=GQgH8Jm51jWPA0QccsTZcnesEjb+OILzHwc73XUnsivXvQXCOLOP3kyLuhvyaLvvEjrJM/0s3cR1asXF5lY6zIhJfW1bAu0y8SooEGL2pQ/XbVou1396a8pmCVUVqN9sHrgaT6UeJ7e/JRJDebU+9dx+hIdus2uiU79FTBVujiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489628; c=relaxed/simple;
	bh=zfODU3mDdGdpVPY0iCNi4MxdBz8LE3/Hr5mTb6CeEQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gbk9JC7+DPKx89lF2bl9WxxpemFPfp978EQsgElGpb62SCYLkKRqjp4cEp3hTOHz3fSwIDX3CxCIxeik1Y48ROrctQwTHmQc785zY/dFbjGJSUQm5/vqz8g0bacE4SFZUQk1xMxpsj4Yk9h8g+huGqJTilLlJP4oBhLkDV0iRcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOzhq+OC; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-264545214efso2524285fac.3;
        Mon, 12 Aug 2024 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723489626; x=1724094426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj9mzoTnQYXMxulrcjw7kaOxhiBLAe/Ye/1tmJvg1ng=;
        b=WOzhq+OCqlYQdxHdwimBMtSQtCE+6yvDznbD3F80cchMvo+x5WfwtId2x5FZz5g2C5
         YLBIYkzeC0Bhg/oaDX/d0MZPrjdVpgOYQVkNzA3ixWFEGPG3vVVR1B2xSvr18zn5fOIq
         NzSPOoJHXYhzcR639BJftQPvkJorPP1ygT6p2VFjpF+KSrfataeAmcg8fHSJWORYVpEY
         WjjfPsH0lEHN1xdtqdV1GjKhyM9m3k8htLcPjWrJPs1pEWh2uyURDXSKeoyzK1XEqs5S
         0MrSnjmIVMFVOeLWOgDQYsgLcV72waoZSMCddu7Mp4L4wkYmTdBEkRos86w11CMqN7b1
         yazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489626; x=1724094426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yj9mzoTnQYXMxulrcjw7kaOxhiBLAe/Ye/1tmJvg1ng=;
        b=ox7L/qhvVqt2p9lHAzYNgeW6jy1fzqqjUKW2zdtl7q7S5ou2z1+BE4LxfdZmfDLf1i
         Urn8GnuPVuc6V1I3TIkvFRBmrYy/o71MVdjXJTDNG7mFsgjpRjh3RGxeSMG9IDhIkea3
         0/vXgKElbS7h9076sLE/t60LmEQO7QGYP5stKII3m9/odqkEHx7+DyPEUCyb2KqgEMve
         xHdu/iDcfsjQ8rjvwRLqx/1MXpYxedQ2eqKz/UN3gWAHc/xu/603c2XPDjFx7Z/9fgk4
         XHgAf3GcmpfuacwwVkpHjAlLKJFzf7lwrhpAJ0Rsrl0pS4lG5QT50lacqAXethOVFqIY
         60Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXOeVs11X2Wg2OaV5b/Iz7ffaS4NzjKDxtnxKsroglhrQQtJPtU8dy8rBdYg4deAYwtrIhLdS09OK3o5dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvsanzvBjPLusZIUpjsR38HIrGh9Rk4KrHOiPRvYQqYBDSidiu
	8U+c1+aDgddnrfx+nnjZ2D9PLLQlvimsR+CX+3Ac9he4YT53YXBPg9v6+SZT
X-Google-Smtp-Source: AGHT+IFVmDzCrCmIlez6F2Q/gU3878rGaJhvGqvkvK7Fa7+LkgJ7Ybyn/DwfjYIdjmeSp3D9mALOvw==
X-Received: by 2002:a05:6871:3316:b0:263:3b45:b7dd with SMTP id 586e51a60fabf-26fcb61d7a7mr1261789fac.1.1723489625979;
        Mon, 12 Aug 2024 12:07:05 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a7facsm4334495b3a.59.2024.08.12.12.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 12:07:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: [PATCH net-next 2/3] net: ag71xx: use devm for of_mdiobus_register
Date: Mon, 12 Aug 2024 12:06:52 -0700
Message-ID: <20240812190700.14270-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812190700.14270-1-rosenp@gmail.com>
References: <20240812190700.14270-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows removing ag71xx_mdio_remove.

Removed local mii_bus variable and assign struct members directly.
Easier to reason about.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 39 ++++++++-------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index c22ebd3c1f46..1bc882fc1388 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -684,12 +684,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 {
 	struct device *dev = &ag->pdev->dev;
 	struct net_device *ndev = ag->ndev;
-	static struct mii_bus *mii_bus;
 	struct device_node *np, *mnp;
 	int err;
 
 	np = dev->of_node;
-	ag->mii_bus = NULL;
 
 	ag->clk_mdio = devm_clk_get_enabled(dev, "mdio");
 	if (IS_ERR(ag->clk_mdio)) {
@@ -703,7 +701,7 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 		return err;
 	}
 
-	mii_bus = devm_mdiobus_alloc(dev);
+	ag->mii_bus = devm_mdiobus_alloc(dev);
 	if (!mii_bus)
 		return -ENOMEM;
 
@@ -713,13 +711,13 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 		return PTR_ERR(ag->mdio_reset);
 	}
 
-	mii_bus->name = "ag71xx_mdio";
-	mii_bus->read = ag71xx_mdio_mii_read;
-	mii_bus->write = ag71xx_mdio_mii_write;
-	mii_bus->reset = ag71xx_mdio_reset;
-	mii_bus->priv = ag;
-	mii_bus->parent = dev;
-	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag->mac_idx);
+	ag->mii_bus->name = "ag71xx_mdio";
+	ag->mii_bus->read = ag71xx_mdio_mii_read;
+	ag->mii_bus->write = ag71xx_mdio_mii_write;
+	ag->mii_bus->reset = ag71xx_mdio_reset;
+	ag->mii_bus->priv = ag;
+	ag->mii_bus->parent = dev;
+	snprintf(ag->mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag->mac_idx);
 
 	if (!IS_ERR(ag->mdio_reset)) {
 		reset_control_assert(ag->mdio_reset);
@@ -729,22 +727,14 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	}
 
 	mnp = of_get_child_by_name(np, "mdio");
-	err = of_mdiobus_register(mii_bus, mnp);
+	err = devm_of_mdiobus_register(ag->mii_bus, mnp);
 	of_node_put(mnp);
 	if (err)
 		return err;
 
-	ag->mii_bus = mii_bus;
-
 	return 0;
 }
 
-static void ag71xx_mdio_remove(struct ag71xx *ag)
-{
-	if (ag->mii_bus)
-		mdiobus_unregister(ag->mii_bus);
-}
-
 static void ag71xx_hw_stop(struct ag71xx *ag)
 {
 	/* disable all interrupts and stop the rx/tx engine */
@@ -1930,14 +1920,14 @@ static int ag71xx_probe(struct platform_device *pdev)
 	err = ag71xx_phylink_setup(ag);
 	if (err) {
 		netif_err(ag, probe, ndev, "failed to setup phylink (%d)\n", err);
-		goto err_mdio_remove;
+		return err;
 	}
 
 	err = register_netdev(ndev);
 	if (err) {
 		netif_err(ag, probe, ndev, "unable to register net device\n");
 		platform_set_drvdata(pdev, NULL);
-		goto err_mdio_remove;
+		return err;
 	}
 
 	netif_info(ag, probe, ndev, "Atheros AG71xx at 0x%08lx, irq %d, mode:%s\n",
@@ -1945,23 +1935,16 @@ static int ag71xx_probe(struct platform_device *pdev)
 		   phy_modes(ag->phy_if_mode));
 
 	return 0;
-
-err_mdio_remove:
-	ag71xx_mdio_remove(ag);
-	return err;
 }
 
 static void ag71xx_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct ag71xx *ag;
 
 	if (!ndev)
 		return;
 
-	ag = netdev_priv(ndev);
 	unregister_netdev(ndev);
-	ag71xx_mdio_remove(ag);
 	platform_set_drvdata(pdev, NULL);
 }
 
-- 
2.46.0


