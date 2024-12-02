Return-Path: <netdev+bounces-148221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7469E0DCA
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118FC165804
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDBC1E0E04;
	Mon,  2 Dec 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ0JKaiE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB111E0480;
	Mon,  2 Dec 2024 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174629; cv=none; b=JGZUdrDMsGJ0fTYAI/C0wLEqQBUpnqWNdDdbPTv90nqfPyesHsIcoGPJEeLPy03AUpuZS4tYHFSLZ6QrKXvBn6C2H6bnMOn6noleuvllBkabOD//PFP4Jtdp1BtcnmbuNeyfJzops4L5uFc+XNzU3A15YmOdNMyuL1bG+EIc6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174629; c=relaxed/simple;
	bh=d5WVrbA2ZIXi7QcPy+mO8gXOberPzyE3RYUplpOiGoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rM3xge4mhgOnqZ27lIEiXoTvk/PnUD7udnQy2/I58SAtzRyLsJG2OZ3dBzlqvYbbGO8qODCxoJ3B7wiLczAJawoaW3FFj6qAWhDxd4l50M2gmkAIZt+ve4G4+nP7JunHBhfNWIcpoyrDYpA9i4+exI4e4FNI9c8dNulPT23MAQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ0JKaiE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2127d4140bbso44643445ad.1;
        Mon, 02 Dec 2024 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174627; x=1733779427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY9xPEHIS8lZ7d7wfdwH0uN/rXxhSahcYAQWeagLArI=;
        b=DZ0JKaiE7jOIAEF+dCg8zxJ5FpaKYzjvmyXd/g32sHe3DiE7i1JQS4V6Mn3hA/KvXS
         Ey9ACYv10BpOMeRPZUPnN4Wz6shJFbAbRW40/cRM9/lOlFagSZu3FH5xa6iuPfvR9d1k
         PX2n+dXL6nhMWDUpdnrQ7snoisz5T8QbOkBaAN8p7g5RaH/KCINm7pjLtA4mG0GGIole
         aPrbP7+rKWX2RR+eb53DSkvYKr03hXA6n/2NGOV3WdkmxwuND84kGDwKY73CdqMgVUHj
         Cba/0qbOg6aJkPhAXw9MSDKl4UsHd0IYOIgBapr8VWKbbqkCVN02dfCZgstQ3u+SPeFG
         58nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174627; x=1733779427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY9xPEHIS8lZ7d7wfdwH0uN/rXxhSahcYAQWeagLArI=;
        b=El8LmTck2IuSZcoqkOrC6CrBmpkJ6B1LEG7dr1YkxafEn9VDRHgZX2kROKQC/JA0Di
         Sj5NN25VVvxCahELhrBLV8Hzf81CSN+zOpVDlzkYjr3M3hsLPLqZEe8t2QgtUnhi/RsK
         ckBle44na0zXb8LLohoLKiujKj3xK82INWiTIVTM2ml6qc3PSdhJvFMZNGlyLCGn4ouL
         yH9kKvNiGY2od+YebYvb1qi1MuxLbipydE7c+bezaWnrFyNTAhm8Awjp6rkQFDYVttpX
         gHvO7+IlbqossBPKrl/u9sLjjWW6CX1QoiY7banGs2NHmIrZn2pRElQrBw9PUcNd0aac
         3irQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMoF1HBsYCr4/Hyh4mQlI6EAL7pJsYct1ihesqd7QNsC2Mw8Vdp4kp9PlF/tJsf0HBmHvEI4nbaOekyY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjOJm9eBid0ZE6gZevrSbW5o/Z22FBetn5YMmJ2gGOiK6dkp2H
	DZTLeqfpjwmsDQUJYXWo2DENdpmjVbkycPqAeegqcYhkvNyGCgtgNWPdHA13
X-Gm-Gg: ASbGncuOINOH7zsZYacueZRhKaOPveIXj/wFxZlxk8xpz8V09r5TYUB+Z0qCPJs/XXC
	+rcWRqLzXiYzJZzv41AesfTY5uxtLMtIZAeDZO5H7z2TtCioqDRH6wxTAE0QScXJ6xoK8DaYeJc
	We1wW8RpIlf5IisJYHW54w5xMiQ3RnWjrMsZ6YzoWvBqlTuhKkLfr1rwT6Tfhp2KykNT8I95Lm1
	FJ2vx3/+WcOnal/zxdALi6nCg==
X-Google-Smtp-Source: AGHT+IEAKapgf9LlQcMpkbNAnZyi9RJocZ6dBjrVz8dJI3b3jqCfUDB848BRGpo1rXM2KqWOKV/h2Q==
X-Received: by 2002:a17:902:f687:b0:215:5a53:edee with SMTP id d9443c01a7336-215bcfc52f9mr521305ad.9.1733174626933;
        Mon, 02 Dec 2024 13:23:46 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21598f3281fsm20729515ad.279.2024.12.02.13.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:23:46 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 10/11] net: gianfar: alloc queues with devm
Date: Mon,  2 Dec 2024 13:23:30 -0800
Message-ID: <20241202212331.7238-11-rosenp@gmail.com>
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


