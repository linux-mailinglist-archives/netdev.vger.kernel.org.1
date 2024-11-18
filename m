Return-Path: <netdev+bounces-146011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243639D1A9F
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 759AEB233D5
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061A71EB9FC;
	Mon, 18 Nov 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKS5fkjr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7587F1EABBE;
	Mon, 18 Nov 2024 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965245; cv=none; b=hkgM/WBvutIxMEHm5Oeyfg1GWXlQPr6XDwjTwGZNCnnUrcb8Dj3qVV2LAHghbGYkKMtfIUIetvDm6Z2RKJd5Jz35rkzRha3v/vTe3NLMHgPhnnnU+MEWSlTdA0j8ZulvHl1AN1IkYonD+U7rkyf4HVqgOEb/GavSKOQm8HhxThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965245; c=relaxed/simple;
	bh=d5WVrbA2ZIXi7QcPy+mO8gXOberPzyE3RYUplpOiGoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gr2Z1uhnKtP2roAPMuX7RWP5mWWKPr7uDOCDeLVugvyIpu+uIEO0idWkPPSLbw7NG3KnpI8onPvXrpPDfJGvk0h8vrNs1R6JeFWpXjJhh3ITITh/abaROvkI1YSdD4ghiAJyg99HGleWZ4+4u6U4KAGL9bqrxzNs5a8mlmK/h2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKS5fkjr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21210eaa803so17064245ad.2;
        Mon, 18 Nov 2024 13:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731965244; x=1732570044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY9xPEHIS8lZ7d7wfdwH0uN/rXxhSahcYAQWeagLArI=;
        b=QKS5fkjry5HcUFZVVeBibxxwAwNtIFbWI/hUcOCscIEBWZLKOhYrLXqBuPmN1EMGh6
         +VIziHV20aY4pJ+ITP5YGdUWlXEI1a1272UGvx2xG0fazv9leMzQq5lwCZN5E6L97MkE
         Sk6aQ37AaoFBr9CWkyXOjcGjDS37VZPE4Vh9VJ7ttTDimr+tAXtYOqDZiRZy/Fy8RhiM
         oVnTYX0FAW14ZscXglDhGxgsd889lqWeaYPZWKFuFjeKQz3uJDKLUa3sC690BoeRI60A
         F7LqFizC8fgxuOVvarM/8f8ZsnbU4BhBpPXKQNf9AEu59A+SGscit7TzTx3Dnk5lHS3b
         05jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731965244; x=1732570044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY9xPEHIS8lZ7d7wfdwH0uN/rXxhSahcYAQWeagLArI=;
        b=hxfAmCimTSqVvoBXj3oiUGpM3Qhu8gNxZBQjhHGLPHOjeKRxV5kXM9CxPemGnYS8ke
         qN4iILL47BnuJ67ZM1yKP3YJqRkqhh3he4K7wlETcv7CRLg84cOlHeRwBv+gKEFjoCBc
         rCiaFHXa7b/PdcT3P+M0pJndNYPsXhDYr1gK9FKtomPNu3WP0aSYAxFaOZnZheIEzbOB
         yX73ggrGQdZlvApDfQFftX9D5xJs91ofZPbmgD4kMMkj+7RXvsdxw0i4bcvw/uCnTDJ6
         mpUMdpQXoYo9PnWE1UokXmVMlEQ5SntD4NZUMP/ArhvXupldtdYoAW5lPMDf/aGQFWr1
         8P7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQnlG+3yBNQ1Plt7f+HL3PExaZvhVpjLV7i8tzWkQF76EmhrWtDBPrME2lhQHYyJAoEQfN01nEUpkxGbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1Hc38NwrulRxaeMopVF2MCJsGCRwDTtBeiwPr8NE4h13kioX
	lD4CHzgEtPsxHQ5HoDqthX0eNtpPMz8sFss7fqIWsn2Ilp5WFyh4a8+ClmWh
X-Google-Smtp-Source: AGHT+IHqAZDOHOSlbBJMfVyIc7Aov2eDoOfssAJpNRUf3h+YmYRYabS1kA57JHvwICDjIcT7uACvog==
X-Received: by 2002:a17:903:228f:b0:211:6b37:7e67 with SMTP id d9443c01a7336-211d0d5ff64mr191842835ad.9.1731965243828;
        Mon, 18 Nov 2024 13:27:23 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e4c48490sm50681455ad.38.2024.11.18.13.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 13:27:23 -0800 (PST)
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
Subject: [PATCHv2 net-next 5/6] net: gianfar: alloc queues with devm
Date: Mon, 18 Nov 2024 13:27:14 -0800
Message-ID: <20241118212715.10808-6-rosenp@gmail.com>
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

Remove the freeing functions as they no longer serve a purpose. devm
handles this automatically.

There seems to be a mistake here where free_tx_queue is called on
failure. Just let devm deal with it.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 38 +++++-------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 4799779c9cbe..f333ceb11e47 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -412,8 +412,8 @@ static int gfar_alloc_tx_queues(struct gfar_private *priv)
 	int i;
 
 	for (i = 0; i < priv->num_tx_queues; i++) {
-		priv->tx_queue[i] = kzalloc(sizeof(struct gfar_priv_tx_q),
-					    GFP_KERNEL);
+		priv->tx_queue[i] = devm_kzalloc(
+			priv->dev, sizeof(struct gfar_priv_tx_q), GFP_KERNEL);
 		if (!priv->tx_queue[i])
 			return -ENOMEM;
 
@@ -430,8 +430,8 @@ static int gfar_alloc_rx_queues(struct gfar_private *priv)
 	int i;
 
 	for (i = 0; i < priv->num_rx_queues; i++) {
-		priv->rx_queue[i] = kzalloc(sizeof(struct gfar_priv_rx_q),
-					    GFP_KERNEL);
+		priv->rx_queue[i] = devm_kzalloc(
+			priv->dev, sizeof(struct gfar_priv_rx_q), GFP_KERNEL);
 		if (!priv->rx_queue[i])
 			return -ENOMEM;
 
@@ -441,22 +441,6 @@ static int gfar_alloc_rx_queues(struct gfar_private *priv)
 	return 0;
 }
 
-static void gfar_free_tx_queues(struct gfar_private *priv)
-{
-	int i;
-
-	for (i = 0; i < priv->num_tx_queues; i++)
-		kfree(priv->tx_queue[i]);
-}
-
-static void gfar_free_rx_queues(struct gfar_private *priv)
-{
-	int i;
-
-	for (i = 0; i < priv->num_rx_queues; i++)
-		kfree(priv->rx_queue[i]);
-}
-
 static void unmap_group_regs(struct gfar_private *priv)
 {
 	int i;
@@ -687,16 +671,16 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 	err = gfar_alloc_tx_queues(priv);
 	if (err)
-		goto tx_alloc_failed;
+		return err;
 
 	err = gfar_alloc_rx_queues(priv);
 	if (err)
-		goto rx_alloc_failed;
+		return err;
 
 	err = of_property_read_string(np, "model", &model);
 	if (err) {
 		pr_err("Device model property missing, aborting\n");
-		goto rx_alloc_failed;
+		return err;
 	}
 
 	/* Init Rx queue filer rule set linked list */
@@ -805,10 +789,6 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 err_grp_init:
 	unmap_group_regs(priv);
-rx_alloc_failed:
-	gfar_free_rx_queues(priv);
-tx_alloc_failed:
-	gfar_free_tx_queues(priv);
 	return err;
 }
 
@@ -3348,8 +3328,6 @@ static int gfar_probe(struct platform_device *ofdev)
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 	unmap_group_regs(priv);
-	gfar_free_rx_queues(priv);
-	gfar_free_tx_queues(priv);
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
 	return err;
@@ -3367,8 +3345,6 @@ static void gfar_remove(struct platform_device *ofdev)
 		of_phy_deregister_fixed_link(np);
 
 	unmap_group_regs(priv);
-	gfar_free_rx_queues(priv);
-	gfar_free_tx_queues(priv);
 }
 
 #ifdef CONFIG_PM
-- 
2.47.0


