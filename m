Return-Path: <netdev+bounces-131068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C784098C783
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5F028327F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6991CF296;
	Tue,  1 Oct 2024 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoD9Tsru"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7E01CEE92;
	Tue,  1 Oct 2024 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817732; cv=none; b=eMg6qDP7zEKKIBnkTUgFsPsblRKQrqMkMzKBKStwYJMUEN7ULJHsrMfTDofqaOJ8DtZlKMxtvxpVXklkieGCW3LeWCTFymnd4oV2VrEAeqy8R08Cb3CV4COF8vb6PuIsxS+eT6G7b4vfpPotIXYKlPoDJGaypjxmvDHBofeFaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817732; c=relaxed/simple;
	bh=4bvbj6hyND3H9ZiJGPMA/wt3pdXVll77E089pRZgFIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coxNfjhYJ5IneQddFThZdZCNSCp+yAdxENWFOdtVHbgfEf0BT8wtkUaGUQRoL3Y5S23NoARrbyHZgORQMnJLNlJa+24IAKF48NqR0Ie/HtlxL0DRe4kURKEWfNESsbq37LQHcKWg/0JZSvcsOX0f2K3Sw308WVBOrYp4HKz8gtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoD9Tsru; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e09d9f2021so4031763a91.0;
        Tue, 01 Oct 2024 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727817730; x=1728422530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lztIAy9xf7LQ0hu6hXNHnpiCKulbigvMb5PRXJdlzo=;
        b=LoD9TsruAY54wptLwSMFQOIvGWrZrKYlbLpiQQh5vhrYjvXHXwY7MeY9zwpzpu5sJP
         2zTRSFik7H28Ok6l9XO1Xio7nxU1q4OToZGf/kTFeBfJsZfAMFtlWf0bcZFPu8VNNA6O
         10lWBkXYatgfiLK8GlcVY24hJoJKk6utSKry/JCQRGucb3ot/vVwRIfvvHZhCXr7bX7E
         uIoIMUalbx0l1tG98EG7ktAuBSe5hVLrNi/oQZxE0cu5Il709916gMG/oPOIQKzK81vo
         aTOoantOgbDMnyaXcuHdtWzOjatviws0CB4N9Z5FmFRZ32a/N9AUoJ1IWGo48NF/VbNN
         Uzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817730; x=1728422530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lztIAy9xf7LQ0hu6hXNHnpiCKulbigvMb5PRXJdlzo=;
        b=XYIYtCYM6ORJyaktoLXg2T5selWqqYRsuX+FBgxH+QCrszY4mghvIYgWyENmoq5vUl
         5fG2J1RXGaFekw0wV3DLpoyhJH0KwAzoPa3q07c9Q9EIsYck02HlEBMxcqgsOTNPNThz
         1DWuZQ25PIoXjLN7zPWB8gHFYWqTb0rwrZO1H0bf8pbHHrkvIDZ6uHlo/au0+WC4xooG
         GRWqsibmr4zDdUGIR4oO1pRl4OriBIYClZNTlND0biDJMyPFJogqjs2S4WWLsWDeba6Z
         YTrkaT+GRFxCRAfgTONXYhbSA8otx8K/H25peu3W5dZ+vXmAP1+yIQ+l3ob6B/T8IUU2
         TNVw==
X-Forwarded-Encrypted: i=1; AJvYcCXmyUp0h0pAGosO9OFvMWEjt7zhtEjPOsMaR7FB8vvrpHbjEt1wctN7PFlXk/HvLXdrzjKYuNcnjvj84T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyekW3Odva/teOkSSirqNP8B5U2LnsM4ieK3ZEy8lH3rrIBRAfT
	7IwN8zRBrTRzMK11hZDL02t1vNVlDkb8egxb9Ow9Ypu5S8o3eEW062dzEhJJ
X-Google-Smtp-Source: AGHT+IHHVe8QgwY+tXSw3a/mEp9ukaVxz27NO6vBfDPMrusy/XW3XUexpl+ih3SfeBhgHVjHk2sTmw==
X-Received: by 2002:a17:90b:3a85:b0:2c9:df1c:4a58 with SMTP id 98e67ed59e1d1-2e1846a6a16mr1309626a91.23.1727817730075;
        Tue, 01 Oct 2024 14:22:10 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8a731asm47144a91.34.2024.10.01.14.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:22:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	claudiu.manoil@nxp.com
Subject: [PATCH net-next 3/6] net: gianfar: allocate queues with devm
Date: Tue,  1 Oct 2024 14:22:01 -0700
Message-ID: <20241001212204.308758-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001212204.308758-1-rosenp@gmail.com>
References: <20241001212204.308758-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be a mistake here where free_tx_queue is called on
failure. Just let devm deal with it.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 38 +++++-------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 9f0824f0b2d1..66818d63cced 100644
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
@@ -685,16 +669,16 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
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
@@ -803,10 +787,6 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 err_grp_init:
 	unmap_group_regs(priv);
-rx_alloc_failed:
-	gfar_free_rx_queues(priv);
-tx_alloc_failed:
-	gfar_free_tx_queues(priv);
 	return err;
 }
 
@@ -3345,8 +3325,6 @@ static int gfar_probe(struct platform_device *ofdev)
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 	unmap_group_regs(priv);
-	gfar_free_rx_queues(priv);
-	gfar_free_tx_queues(priv);
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
 	return err;
@@ -3366,8 +3344,6 @@ static void gfar_remove(struct platform_device *ofdev)
 		of_phy_deregister_fixed_link(np);
 
 	unmap_group_regs(priv);
-	gfar_free_rx_queues(priv);
-	gfar_free_tx_queues(priv);
 }
 
 #ifdef CONFIG_PM
-- 
2.46.2


