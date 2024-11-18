Return-Path: <netdev+bounces-146010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D915A9D1A9D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9359B1F22964
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC87A1EABD2;
	Mon, 18 Nov 2024 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isZ/E6eY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D881E9095;
	Mon, 18 Nov 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965244; cv=none; b=meeXKWmAbkb1SqdBO+KV/hoWqzmkKOf6y2h4WySnQTqqRLQUaG22rzTFerTuUtfzJUnEcsJN5cOB4auN8KMtt830FJrfpYaQ02zquXLhG4AKU8x8pgII+h1gzsUPA1M1R4MjdIXBjqWZl+wdJAAHT30oz4Jv9YZpJk7EwicHub0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965244; c=relaxed/simple;
	bh=o29Loz/wKRoCklR+Xw7+059RvxWhYbZTaNT9c2QM0ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rd+DLwbf5Rq91+W617s2E7tKx1j8oF6lXIPwhYnI3YEDmTocPI3YQRVpPebCf6aocj0uM5MltoVoNatBJLqlmb0iJKN1WMXy5/5CAbQM9h4Vyw0EhjOA+6/qMh3mI9tV6TWm/SVMKfCpG7OgwkxcuouAqv6kE/PnxTlHU2TzCr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isZ/E6eY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c714cd9c8so21044065ad.0;
        Mon, 18 Nov 2024 13:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731965242; x=1732570042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZyjhkLJ98gZ41XXUPuf7JMsN/z0ZiIcAJfeyap8K3g=;
        b=isZ/E6eYH43PZPMXGR9FCAY8xs4xPiMe5uGPMqMOru1XjweiAWLEIfyUkkDTSy64CC
         JYl2GPcCof1JfMfMjyaXco4dpAZB01Rae3quueBSWeyM6moPnVKIbBvIIsI3OF3zHFT6
         ybHaCYgcbVspUvy5jBvtBOLKlQtiazoHbUCaW4ayXJ4NasvNIjCVv+TblCc6Ewelig3W
         MkCiu7cHvCA2DcWKbW1RStj2JkqvhpXAZqKGFR+pxY0UbghKddHO/4q3zeDDDQPW+PTQ
         Rd8w4GLA65jM7q2Sr2JbO50sP+dLWjm3INX17ORdhNsUW4rkirU6p+/ZDGMvsD51i8Jx
         Y/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731965242; x=1732570042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZyjhkLJ98gZ41XXUPuf7JMsN/z0ZiIcAJfeyap8K3g=;
        b=AydGPGhWKanDvpoKwvGzRGjLo5O6qGsd8xJvqVd68eoQa3wpc7wXt0/wLnbqZ/KRon
         saH4iWpfqSc6OTdkMJohYPM2MjFiQ3OnhIoQeJB4uOApXrxLypaHi47cTFescjOrYjYD
         jshV/MsPAWbf+Op/e99Qar5ycFzlX+qSf/85rBEufjMs5g1z1jgXgu/nWuPlqsV0CcD7
         ecjyQjuqMeAkvK7DEiWirlcj/My6iF3zmcCRVz39dUNZXedycohUOX7KqOTGuKYYR/yY
         3cOU5bbxyoGnpoQT0SPV/AW1gMusNTyPqlqGUeTMOgwDXxhpFKDgTFFJlFfvgM3JqxGq
         veaA==
X-Forwarded-Encrypted: i=1; AJvYcCXiOCr1adjcDneWHjh+sjVVTyz8+jTnFlI+9vssFocofQ9SzHxL3kHGIYw5pb8sOnIZTERUPWxbUQ4LxPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7+lKL6OOu20zhRmUSZgkM8plGa5061aFvZS9NUho7jVp8UyQ+
	hhtnUg2mb3i979o+u8gxy7usoulnvhoeNTVm4zsTkK15FkI4x6sItwtV0ZVG
X-Google-Smtp-Source: AGHT+IG0Kur2muv6q1tSYo8C5H1hQUWXttelk3lUBeD6pMxvx1wwyTAZ008wpbQvavQpui6swAiwnQ==
X-Received: by 2002:a17:903:32cf:b0:20c:774b:5aeb with SMTP id d9443c01a7336-211d0d6003bmr199577555ad.3.1731965242594;
        Mon, 18 Nov 2024 13:27:22 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e4c48490sm50681455ad.38.2024.11.18.13.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 13:27:22 -0800 (PST)
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
Subject: [PATCHv2 net-next 4/6] net: gianfar: remove free_gfar_dev
Date: Mon, 18 Nov 2024 13:27:13 -0800
Message-ID: <20241118212715.10808-5-rosenp@gmail.com>
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

Use devm for kzalloc. Allows to remove free_gfar_dev as devm handles
freeing it now.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 4b023beaa0b1..4799779c9cbe 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -466,17 +466,6 @@ static void unmap_group_regs(struct gfar_private *priv)
 			iounmap(priv->gfargrp[i].regs);
 }
 
-static void free_gfar_dev(struct gfar_private *priv)
-{
-	int i, j;
-
-	for (i = 0; i < priv->num_grps; i++)
-		for (j = 0; j < GFAR_NUM_IRQS; j++) {
-			kfree(priv->gfargrp[i].irqinfo[j]);
-			priv->gfargrp[i].irqinfo[j] = NULL;
-		}
-}
-
 static void disable_napi(struct gfar_private *priv)
 {
 	int i;
@@ -504,8 +493,8 @@ static int gfar_parse_group(struct device_node *np,
 	int i;
 
 	for (i = 0; i < GFAR_NUM_IRQS; i++) {
-		grp->irqinfo[i] = kzalloc(sizeof(struct gfar_irqinfo),
-					  GFP_KERNEL);
+		grp->irqinfo[i] = devm_kzalloc(
+			priv->dev, sizeof(struct gfar_irqinfo), GFP_KERNEL);
 		if (!grp->irqinfo[i])
 			return -ENOMEM;
 	}
@@ -820,7 +809,6 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	gfar_free_rx_queues(priv);
 tx_alloc_failed:
 	gfar_free_tx_queues(priv);
-	free_gfar_dev(priv);
 	return err;
 }
 
@@ -3364,7 +3352,6 @@ static int gfar_probe(struct platform_device *ofdev)
 	gfar_free_tx_queues(priv);
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
-	free_gfar_dev(priv);
 	return err;
 }
 
@@ -3382,7 +3369,6 @@ static void gfar_remove(struct platform_device *ofdev)
 	unmap_group_regs(priv);
 	gfar_free_rx_queues(priv);
 	gfar_free_tx_queues(priv);
-	free_gfar_dev(priv);
 }
 
 #ifdef CONFIG_PM
-- 
2.47.0


