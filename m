Return-Path: <netdev+bounces-148222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3559E0DF8
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736E5B3AB64
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2001E1023;
	Mon,  2 Dec 2024 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A89o9x61"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004E1E0DF9;
	Mon,  2 Dec 2024 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174630; cv=none; b=qeuVtlIVT1OIxixzBPtQ/8tFQ46uR2dT1/j9C06DC+cN3hRoDtCn0/9FR/cTgA1as98fFaLu+OgjQHQKtQPwr6helHmGDzaL/gLbrjPXXyF70djrlZneIJjq5rftBWlRAHyNk8Ulj9h4U7RlwIQ49f8tLOYlPzt4t++K6ccdLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174630; c=relaxed/simple;
	bh=//y4HhrPotue02nBUtPgcflgl/boQHqvOPQ9RixjeGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv8JZkBafIpaX3T5t0eF1kj5ovxL4f3Dg4myVKBKytww8l2U+5zf63E4a75wufS+Q2jaBSw1HU4a2jircYa8xGCdqU7f4FCoKuL8B+Ql+1fWT/vuhw5k8TME6qdbVWT9vsHFWnvViMkWGp4Bz8j4RA8nIr7A1JLAhfbma3IGbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A89o9x61; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21145812538so38297785ad.0;
        Mon, 02 Dec 2024 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174628; x=1733779428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Y8CkbhLK5PllQroqtL9wsJUlt2pSyGEhrKOQZgaXUg=;
        b=A89o9x611FodRN7IDuFEQAtgJD79aBndDtYupmPK9UN8S+/LAKxY6v7bexDdP6k/iR
         q00NB/hDYijXTvsJa8FXS/PionCRaDpuyLre/si16Zgz90v7GnKiiNQocwaTOfYcRLLf
         fIq9XrRprshfMI+rLgOl3NdHa+jJa8zNisBAOmBmCgnyqlNMRKkYvubWkpusHeSdrOdO
         U2515VWcVsQMpUyvE4MeqBwiA6JeWkZ4fi3lEzGsJMXFxzOA62u+PDrNVwA+oy8yOyUB
         cWTPnWAovYbugir10Sna7EEzJc15jo3uK610MHnOOFfUwYKr23vCjc3Yoe9LOVIxHhaT
         Et3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174628; x=1733779428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Y8CkbhLK5PllQroqtL9wsJUlt2pSyGEhrKOQZgaXUg=;
        b=cHr8CZbyvF8n7N6MM0D40JNC7WBIwH1+MpNRgqEaDibUCvHe3jIVm4eoLQI8F/fXKk
         jNN7vHCybL0+ohS0EaQ289cNiTD/r+64UYCmCCtxef+LlRKHq0DQRuBqXZSWcDP54te6
         l6v4NaHDQt8GFqipo9v9ZTO9Vojx+QgufdLdIgaZB8e/JCTEbLz+MzBNS+utuvwFoogQ
         14DaGDdePWJcot45/NP4FHhQnmUpOXlYoFN4UK6pf7+8Ml8fx5vQrpGr9tBLmfrc5Wvv
         ZI5qDon2sIhYL/LUZv0PvEp4YeE4gHhc4GU3XwZ6uBVHKNE+H2uXaGXDjhhJUOJuR455
         fD2A==
X-Forwarded-Encrypted: i=1; AJvYcCXlHTBhX/prNP9OdUNm1X2J90k+W1Gf7lWnJHEVpCeSubE9WGJsN7fu/m1FemCZ+xm6gX25E4TWPYFstjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/HS44UOoSbfYsQAlCakZaVfj9eniTBCx8v1HMQHoCTCfwKII+
	/K/g1nRsCcZuJlGuePYAHY/s/c8u0qPIGCmLSUuf01Kc/AihgyjR26FfrPmR
X-Gm-Gg: ASbGnctvCX0T1pFu9Q/EfUy5HLHFPOowzYiFly/JY0V+CyrmYCWt5Z3ddut6xOUYRxc
	KjW/opuhPsCJCkD1Eewa216+jGBu6PsO9qdXRF4dLUxLgJ+YcoyQnaa5vIa7ZWUmPQ3Dq9mkzm0
	EccM2ZT3rqgYNvXIkBHI7KkG+YsRzJ51vJ3a0PFeaQRskTFxbiqzpFnXN4VYKzqL4jLol265kSu
	1edUPIzlrKCvH3YxQDfaBLJAw==
X-Google-Smtp-Source: AGHT+IFIan+i6PUAZhU/fBWXEd1C1hzWZPqVCUaEHLsb7o3ZsFobpXVRU4VdgRDlO7dqbXAOFR55GQ==
X-Received: by 2002:a17:902:e743:b0:215:4f98:da0d with SMTP id d9443c01a7336-215bd0d8968mr719445ad.15.1733174628186;
        Mon, 02 Dec 2024 13:23:48 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21598f3281fsm20729515ad.279.2024.12.02.13.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:23:47 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 11/11] net: gianfar: iomap with devm
Date: Mon,  2 Dec 2024 13:23:31 -0800
Message-ID: <20241202212331.7238-12-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202212331.7238-1-rosenp@gmail.com>
References: <20241202212331.7238-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unmap_group_regs as it no longer served a purpose. devm can
handle this automatically.

Remove gotos as they are no longer needed.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 26 +++++-------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index f333ceb11e47..d610adc485f7 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -441,15 +441,6 @@ static int gfar_alloc_rx_queues(struct gfar_private *priv)
 	return 0;
 }
 
-static void unmap_group_regs(struct gfar_private *priv)
-{
-	int i;
-
-	for (i = 0; i < MAXGROUPS; i++)
-		if (priv->gfargrp[i].regs)
-			iounmap(priv->gfargrp[i].regs);
-}
-
 static void disable_napi(struct gfar_private *priv)
 {
 	int i;
@@ -483,7 +474,7 @@ static int gfar_parse_group(struct device_node *np,
 			return -ENOMEM;
 	}
 
-	grp->regs = of_iomap(np, 0);
+	grp->regs = devm_of_iomap(priv->dev, np, 0, NULL);
 	if (!grp->regs)
 		return -ENOMEM;
 
@@ -700,13 +691,13 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 			err = gfar_parse_group(child, priv, model);
 			if (err) {
 				of_node_put(child);
-				goto err_grp_init;
+				return err;
 			}
 		}
 	} else { /* SQ_SG_MODE */
 		err = gfar_parse_group(np, priv, model);
 		if (err)
-			goto err_grp_init;
+			return err;
 	}
 
 	if (of_property_read_bool(np, "bd-stash")) {
@@ -729,7 +720,7 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 	err = of_get_ethdev_address(np, dev);
 	if (err == -EPROBE_DEFER)
-		goto err_grp_init;
+		return err;
 	if (err) {
 		eth_hw_addr_random(dev);
 		dev_info(&ofdev->dev, "Using random MAC address: %pM\n", dev->dev_addr);
@@ -777,7 +768,7 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	if (!priv->phy_node && of_phy_is_fixed_link(np)) {
 		err = of_phy_register_fixed_link(np);
 		if (err)
-			goto err_grp_init;
+			return err;
 
 		priv->phy_node = of_node_get(np);
 	}
@@ -786,10 +777,6 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	priv->tbi_node = of_parse_phandle(np, "tbi-handle", 0);
 
 	return 0;
-
-err_grp_init:
-	unmap_group_regs(priv);
-	return err;
 }
 
 static u32 cluster_entry_per_class(struct gfar_private *priv, u32 rqfar,
@@ -3327,7 +3314,6 @@ static int gfar_probe(struct platform_device *ofdev)
 register_fail:
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
-	unmap_group_regs(priv);
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
 	return err;
@@ -3343,8 +3329,6 @@ static void gfar_remove(struct platform_device *ofdev)
 
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
-
-	unmap_group_regs(priv);
 }
 
 #ifdef CONFIG_PM
-- 
2.47.0


