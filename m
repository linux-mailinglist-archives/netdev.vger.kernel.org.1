Return-Path: <netdev+bounces-146012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A919D1AA1
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510A42826E4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133F1EE006;
	Mon, 18 Nov 2024 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbEgTBmf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D901EC017;
	Mon, 18 Nov 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965249; cv=none; b=eASmW2H1GA5kLSzFFViluieZXxERlGO9N9S25+4eN2XqaZHFlehzNOsH5f3oYdO8mdlu0hhdNS04Ywuux1OAze2DIT6AThS+4EwXwzynmXYfDDvZCLRGZL4MgKycF04fA/7veNi6pTBK2At1gNUNE6wvwNdMDpKn3i9+/GWhhKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965249; c=relaxed/simple;
	bh=//y4HhrPotue02nBUtPgcflgl/boQHqvOPQ9RixjeGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIoZaXtqj+sns+AC9sOa7oIz+30OUGZtsoT5lFSvQD9nuNp6C6gzcBFIS41u5DatNdQIJGHVOblKWr1EJ8YTWecbgFUh2q5+kz/SScCjo5xrpDI9utc3an+OGpvvM5O0XFE4NjU81CUFvTwMjTI1cs+J9Iw+84SVBrHGPvXt3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbEgTBmf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2110a622d76so1412545ad.3;
        Mon, 18 Nov 2024 13:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731965245; x=1732570045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Y8CkbhLK5PllQroqtL9wsJUlt2pSyGEhrKOQZgaXUg=;
        b=mbEgTBmfw9UU6gStMA9Age3C73ZINucD8S036Vr4M3FO3HAHFnwBY9+/DAZuvKrzZL
         NngvW8lbsuUGQGN1/jm2tO6dUoBR1Vq/9sH0M81xWuWuhDk4wanoj9TWeJ4I6MLNX6Qr
         7nEeoqHjS66tezEsEqwmGjcQYS7faOv3uBlmIE/aFR5sADaDNp8mQANdmjw6aWE5eZ9D
         CnQcRQJnclpecpQtzeP3/gO0lUbhEYL6ZfX5za+7/ucq5ovqUe+xWFG5zlpgQKhqgOze
         b9rJ2ITVZGYuzdVOBagGk/lRlfuTi8S+xgbRg3nY1vX+a4DJLBFnpJ4/7Qs3m9pQTa8v
         mOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731965245; x=1732570045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Y8CkbhLK5PllQroqtL9wsJUlt2pSyGEhrKOQZgaXUg=;
        b=wrphUFF67hdDLJ2hTsVpmAF1vGdQPBJU/1xuPoMD8tQqxLGohsWuueIjaTjKZxUBHN
         0XdMXvvXfEZZ5aZufHLogbSr9U0tVCo/JFpPvOjDuob+56tkjepvbgQEqHX3kZJZrEKZ
         8Kt8xOekP5RA2i4WBrcTdv/rZv0zY2ce+n52BhVvx5nGmzFM2lgyPbHObn0PdEc+eM/F
         lbyrDQ3cwUkJnvszQMQKsPIDdWG0Sc2pVf30ccXK/OsJeL44NcFvvK5rFZD6615k9S7V
         IH6YobZ9mwJWqG8Wi/XYlCRiXF21ZsE+eCXb+hSQZ/3nZIodlND3TgRCdkhtv4y5iqyh
         jrFw==
X-Forwarded-Encrypted: i=1; AJvYcCXgWnJhSLswNwjpK+ewSqylEPemcGUw1UEvrz2ndCCddc21sdSc57UNTC6JbwmSyjcLjOrf1qkvu3kwBrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytUsFixBqDNax6AZ+SYrSv29dzPw++qJMZuC62aBHs/QRj6yGz
	m8EqqpivtZ4g/dtWGII3txma4RTHkEl1ZbsU52zRDGSx17CBJrOBlDdGPvDF
X-Google-Smtp-Source: AGHT+IFSoR4L26mtGCz279nXOPwjTGPqxRzsJhJYaw9htne1+z6wXZfw1wlPcAYNGm+sDrTaFIgx4A==
X-Received: by 2002:a17:902:f601:b0:211:ef94:7a92 with SMTP id d9443c01a7336-211ef947babmr111063075ad.55.1731965245050;
        Mon, 18 Nov 2024 13:27:25 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e4c48490sm50681455ad.38.2024.11.18.13.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 13:27:24 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	maxime.chevallier@bootlin.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next 6/6] net: gianfar: iomap with devm
Date: Mon, 18 Nov 2024 13:27:15 -0800
Message-ID: <20241118212715.10808-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212715.10808-1-rosenp@gmail.com>
References: <20241118212715.10808-1-rosenp@gmail.com>
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


