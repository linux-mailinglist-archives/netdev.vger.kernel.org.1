Return-Path: <netdev+bounces-205929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C0DB00D54
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6459D5C4C46
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4DC2FF461;
	Thu, 10 Jul 2025 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9NqLgNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9142FEE27
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180044; cv=none; b=K3qlxwXAI4TVpx9Wyls4vZIz3Q4+oslEfgnfMfuBcwFNWpugI7mHuRyPOVKU92j6vbdmH8S3cTKLESgejgl6RJ0lZzLhbjAPnQQSHoIOB69ZdV4rWkB7LDOQ8WgrB1bj61P9GSjP89k/Xb/j1lAPUpIrnZpJ7WN9dGrpQjN3110=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180044; c=relaxed/simple;
	bh=UlGNpyOVoWm9JjRf+RW1wnRzkNw9egOKjcCnfZjBvMY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asLOjxMhgzRRxo9IbnnbdvSTTKm9XP8NQQY+07HGnaCOwhGnA7RXgdz0oLAA2AFtlcm4SbA0hW/WpTZFBbWKQmWtOsNVdSxZWKaXgRgoUnZKVXBYy+PUZigoVSLgsMDgdoreODw0UqMhx+FhApt06sQ7EjkLCWmhMla8EfU+VXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9NqLgNi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so1271445a91.2
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180041; x=1752784841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWhtL69PTW7oxxMOtkLSmE0zga+L5Lr2/IzcqoRgayA=;
        b=J9NqLgNiSq5uVYBf+XxyESt4ZDv43F+9jGT0f+YphYmSl1lD4a7mGcg5lMJswp6c3o
         tpf2BKRbwCNa8INeyayNmzFmlE5QcsrEVTVkA7YWo8+5SzFvbyrhkklepaJ3a5y4h3sz
         Ez3zme+YXQZo8ub6TkaR2yA1BadpIy1YDivzK3u78yE1XytvYVrHOhtgjJF19gN631vI
         nIXH0E/WNgXf3kzykYxbu0eeTyU29Hh2Z1N47aK/41Mlcf5OojenwwKdihEV/i4UPysL
         upoae1krsRv9SY7/o0SU2w14SNtr3mlIx4SbVm+LD/IW4AfrXIz+sV2uYurfXU1Dk8Iw
         MF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180041; x=1752784841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWhtL69PTW7oxxMOtkLSmE0zga+L5Lr2/IzcqoRgayA=;
        b=fmMhGP4AL7ozUeGz2UxspMrgIelkMt469UFOks8kFPeF4gj6V/oCG3ryncyiS/cHX0
         VO6ND303L+aoX++uYXvDnh03DNj4ofz8m11+WTOswvGD/Pj5aCP1w5C8vNS6t7iApTlP
         9YNpiSRxPmexrj1FrzqH5dD/QL43435L1C/BmXTEJqN/b/BFYCCRajMOTX8Ne0ZHed4b
         yvEVIJ6jN1oRRxxC64cYkUJ4TPJujvhipwjzoX0zZfi9J6xO8+tIeNEhSo8+n4pYYi/g
         DSENqXcv3koqndoNiYKnSG40vXhZV+195zyUQ9fiUFrt1BEqr+orLD+4cwwLFRBqM52M
         96qw==
X-Gm-Message-State: AOJu0YyMsKR1OIK96D9TT48z/nVRpgzmh9rUl8dQmDHTqSbcvNa5MbP2
	/VVBnKmOMwFOqB1rqdBMNbM0LjoKPyOUHH2RXzncA08zQ78m9iSg6CxtfkNpcsk8
X-Gm-Gg: ASbGncvq44+fVjAf8km1iRHTgkWj5d0gQLX1NeauX3LAohzzbz7BQjuKaYxody5H1kB
	e1uAXsfpc5eH52yKTARh6qD5AzTgufMW814180CL+JT3rpLuO07L75/9avlY74ptzhyT5wvNjY0
	gpavQ7TI/eDAyPSdiB07hhnGXuWPOPceg/CrzQYea1kyiwSOBWq+iavHpmx2RKpvng3tY3/DnsC
	nIpVKVD9z8vjnRgCd9Bwb0NLvTsMBFKsbe9EN9W2zXWbpynkt5b0P/VOOovXINZjynvmqe6cezw
	6uXYAsscRx8260HWFxwiscdrEl+O6ssDVbC9Vxhb5DzXhRSROeCj7ZMz0Qk4VJVkv6T7whG1QxJ
	A7x4=
X-Google-Smtp-Source: AGHT+IGcmPmZCCNdKvuyP3jWtzo4rV8Gd6cFSmDGZTYheN+t7QZkVoX7zhZ4Rc/nfrxUxb8UqOY/sA==
X-Received: by 2002:a17:90b:4a8f:b0:312:e6f1:c05d with SMTP id 98e67ed59e1d1-31c4ca75914mr1186976a91.2.1752180041602;
        Thu, 10 Jul 2025 13:40:41 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm3547861a91.46.2025.07.10.13.40.40
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:40:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 10/11] net: gianfar: alloc queues with devm
Date: Thu, 10 Jul 2025 13:40:31 -0700
Message-ID: <20250710204032.650152-11-rosenp@gmail.com>
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
index a93244415274..bc1d7c4bd1a7 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -413,8 +413,8 @@ static int gfar_alloc_tx_queues(struct gfar_private *priv)
 	int i;
 
 	for (i = 0; i < priv->num_tx_queues; i++) {
-		priv->tx_queue[i] = kzalloc(sizeof(struct gfar_priv_tx_q),
-					    GFP_KERNEL);
+		priv->tx_queue[i] = devm_kzalloc(
+			priv->dev, sizeof(struct gfar_priv_tx_q), GFP_KERNEL);
 		if (!priv->tx_queue[i])
 			return -ENOMEM;
 
@@ -431,8 +431,8 @@ static int gfar_alloc_rx_queues(struct gfar_private *priv)
 	int i;
 
 	for (i = 0; i < priv->num_rx_queues; i++) {
-		priv->rx_queue[i] = kzalloc(sizeof(struct gfar_priv_rx_q),
-					    GFP_KERNEL);
+		priv->rx_queue[i] = devm_kzalloc(
+			priv->dev, sizeof(struct gfar_priv_rx_q), GFP_KERNEL);
 		if (!priv->rx_queue[i])
 			return -ENOMEM;
 
@@ -442,22 +442,6 @@ static int gfar_alloc_rx_queues(struct gfar_private *priv)
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
@@ -678,16 +662,16 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
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
@@ -796,10 +780,6 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 err_grp_init:
 	unmap_group_regs(priv);
-rx_alloc_failed:
-	gfar_free_rx_queues(priv);
-tx_alloc_failed:
-	gfar_free_tx_queues(priv);
 	return err;
 }
 
@@ -3308,8 +3288,6 @@ static int gfar_probe(struct platform_device *ofdev)
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 	unmap_group_regs(priv);
-	gfar_free_rx_queues(priv);
-	gfar_free_tx_queues(priv);
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
 	return err;
@@ -3327,8 +3305,6 @@ static void gfar_remove(struct platform_device *ofdev)
 		of_phy_deregister_fixed_link(np);
 
 	unmap_group_regs(priv);
-	gfar_free_rx_queues(priv);
-	gfar_free_tx_queues(priv);
 }
 
 #ifdef CONFIG_PM
-- 
2.50.0


