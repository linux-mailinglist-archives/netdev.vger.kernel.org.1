Return-Path: <netdev+bounces-118139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56603950B1D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 19:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E561C24833
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69201A38D7;
	Tue, 13 Aug 2024 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXzG7fkd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F81A38CF;
	Tue, 13 Aug 2024 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568750; cv=none; b=PfKrNgQu3SU+bEKB2DR03EgrFLF0oOfjIvbPomCmNujRJZ9v+8puRMySJ2Aun7e3X5+rhWeESmIoL+aY8sNmm8uZsp6+ZJzF3HHfwGMe1C98J+LMPq4GxQW+3WWvKtIiiKkRBu+x1DWYmLIJT3rRaPoG6pVTt7ZNfssrDCNN//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568750; c=relaxed/simple;
	bh=MV7R+YHOXi/XcXGkohMCd1CQNmhYlhc4ACiUh5bMITI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6o5JX1hskEZMyQI8Vij1UW9lCZRU9C+NyJmzWUI2nG4QcGxZi4YJCrGlqjlU5ExGo3ZfZiCw7zX8P3aeVLuw40hG+OGdyV8WzKX4PDprpOUfSDpY5xoicz/jb/O8IevFNLAbCnR2RKXHynvOHdGUT8tLzofq7cnz0KgtkYMG8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXzG7fkd; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1137aafb8fso1759012276.1;
        Tue, 13 Aug 2024 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723568748; x=1724173548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JMjZUt3IuyFMwoZfgrbYg424GOy4cvItQgw2J2lg7s=;
        b=eXzG7fkdp7XOxY5eBoSz1NdjWvlVgY6ChbS219ASyT0dNd2IedlXF5iD2miFYFF5/L
         h7wZsJEMzvd4alQJtUxPyWSj7s0yeo99xvVcTEjSVlcrs6qjySO8IMM25GNm2Sv22aiV
         Zb6LWpCWRBgGgXa3WHYqCJ92hDPxbfw5OGBin8W1vHY+nBbaQ+UyXjMxrHY13G/2+Lif
         /l+umvxfE1kAGTvZx86IrzjMErewHtB8BbpwjPTSjcjDqEH1+zSU+shQnFkdyrOUGmu9
         7BeD3DvsssAbW2tG8FFu8XEqR7oggZnhXhg6yg3ENNV1uFHQPoT2SMRdDiYhTpCBfEtl
         iz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568748; x=1724173548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JMjZUt3IuyFMwoZfgrbYg424GOy4cvItQgw2J2lg7s=;
        b=omvD5THDO3BZWArUrC1jnez0nL/i1PRl5EFbqvjtf0Si1oW9ap70cl3Okdfv2XJAJP
         84eE2uO50r3iUZeBODnCID4de7dRYxP9Vg79bTw7LHylc0EmfpO3h/fWXUvSe18X3acT
         /KxTXmbz+kTIKsYU9gt0Kz+WgMcNC36Z96Hjq5U+J4M8RL198ux9ZIMViAV2BrduLadS
         Hs/WguWG5bMdKYV1dozbt1Dy4ACpP4LbXbcmcS3oipAv8fUDBTYFZHNkosoYFbyMWKI7
         SX9lYSA5kAvbkqR/DnnYMHy761opurWpCwWmQm4MHSQE/bOlrdIzgtwZGMSD8r+kJZIc
         YR7g==
X-Forwarded-Encrypted: i=1; AJvYcCX2iJZruRuVbmOsKp0oCsjcltXRtXO1Q7ZahteGa2j+oizPvNbCMWBojenJ57xlh83n9j+HJSrh6EPYulY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9l/IF6WL2QdhP5goBm9feHDETFtqyqf3OUz7Ph/UXOoiffUqs
	j1btcmXB6TmpMrHVrQJbYucJLRPMqrrhLZjBSTSv+jQtTt/dUX6aC0+J70j5
X-Google-Smtp-Source: AGHT+IE857ZQNVM5Az50U2+fcTIxGCe7unJr02UBjY5k+PZt+fgbvFARTkowtKSRPy7bGkE+t99C2g==
X-Received: by 2002:a17:902:ccd2:b0:201:d659:4c29 with SMTP id d9443c01a7336-201d6594e80mr1475875ad.21.1723568720796;
        Tue, 13 Aug 2024 10:05:20 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a947fsm15946425ad.140.2024.08.13.10.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:05:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: [PATCH net-next v2 2/3] net: ag71xx: use devm for of_mdiobus_register
Date: Tue, 13 Aug 2024 10:04:58 -0700
Message-ID: <20240813170516.7301-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813170516.7301-1-rosenp@gmail.com>
References: <20240813170516.7301-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows removing ag71xx_mdio_remove.

Removed ag.mii_bus variable. Local one can be used with devm. Easier to
reason about as mii_bus is only used here now. Also shrinks the struct
slightly.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index e46d10a5c28c..3c16f6c5e75c 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -380,7 +380,6 @@ struct ag71xx {
 	int mac_idx;
 
 	struct reset_control *mdio_reset;
-	struct mii_bus *mii_bus;
 	struct clk *clk_mdio;
 	struct clk *clk_eth;
 };
@@ -689,7 +688,6 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	int err;
 
 	np = dev->of_node;
-	ag->mii_bus = NULL;
 
 	ag->clk_mdio = devm_clk_get_enabled(dev, "mdio");
 	if (IS_ERR(ag->clk_mdio)) {
@@ -723,22 +721,14 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	}
 
 	mnp = of_get_child_by_name(np, "mdio");
-	err = of_mdiobus_register(mii_bus, mnp);
+	err = devm_of_mdiobus_register(dev, mii_bus, mnp);
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
@@ -1924,14 +1914,14 @@ static int ag71xx_probe(struct platform_device *pdev)
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
@@ -1939,23 +1929,16 @@ static int ag71xx_probe(struct platform_device *pdev)
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


