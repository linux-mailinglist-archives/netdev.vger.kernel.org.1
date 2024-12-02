Return-Path: <netdev+bounces-148220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9519E0DC8
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1AD165800
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A701E0DFA;
	Mon,  2 Dec 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WntSXaYd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80A51E0DEB;
	Mon,  2 Dec 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174629; cv=none; b=njobbwLz28W9OA7RYxVQcOpLwGYk7ZlJnynwBJEcZKRzIxjmNqsJVg9kX4Q0B3shDxHzQH30/gHv8+DyKCWXcO4OMWB2MfmvV7zegLvJevAue6UlPLW+KOprDj32nnbnr0s0aI2H+pR5+dYsxliAegnHkt2Bh1xd+VkDFqYP0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174629; c=relaxed/simple;
	bh=o29Loz/wKRoCklR+Xw7+059RvxWhYbZTaNT9c2QM0ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5jv0EVTidwURtER8Zhzj7Xaqnv5gQJUVwTsQN4/oscDj3VGB24VwN7s5z/3xyhbg/l2zJQuE+iEKbHEmC0KQT570Sx6Xj0kC9ghvdGV+Kugz3eXt5J9gfbWRuuWDtXFLCJy6o08QJKNp6FukkkoINgJA1UHrs1hicrES9o7Zu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WntSXaYd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-211fb27cc6bso37984825ad.0;
        Mon, 02 Dec 2024 13:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174627; x=1733779427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZyjhkLJ98gZ41XXUPuf7JMsN/z0ZiIcAJfeyap8K3g=;
        b=WntSXaYd095CEr3/KChBUJ7j31N21lkbkKWhVkZS3sAt+gE7/1/MVJLxRCgEWmXrnt
         y/o3zOm3UE0mLYWmMpjA+rr4qMsCEB+NRG6wMLqhlri5BNfv2++1zYrfVmftClR5rVIt
         ZKAR77gRMO8wnVXRTxmDP4DrwQ8WoA5x1/rXmFfAMzHrfpStM22lDnkWdjbvL0y7RzMd
         kOTgqdRTojTqcP290r2/Ek0y+YxRSX46L2HcUjt39cVHE2HA8RqpIffm0uhNQHQoJBuF
         BrhQDuD1vzKTdJlR6Y4GQzW+BRDDzh9V1qLM5CFwi93I3T24Mdiqo/8kl3wmQ8qvekQL
         QjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174627; x=1733779427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZyjhkLJ98gZ41XXUPuf7JMsN/z0ZiIcAJfeyap8K3g=;
        b=evr0iND5o5xLteD0VDM7m6SPbIp4vO8Nrp4+SW9mxPuQzdWvmskwUGqO25WVptY2BO
         iWSkQYTNjdNRGkc7WHPIdIkjV5gZ5BnTgefESQjnKgWLkfWC3N5chG8Ex/0s7JLW9EQ5
         zrvwRIvwAC5pIWV4b/nvMyOjIQDVrJfonAr04gm0oYKHLjv1pRtN26Q3jFFNRJKX0zC0
         y7Tezm71mGk0nJEUzvdT1TdYWkwckyfE5/3wKK9As3EpF26HAIVk7VgoAkrX+nt987E2
         U2EqJrgm/LZQlS0j+HI7zqertkzKppZ/iMzbXwuxBs42JFTWGQqTcd7HTcq34tCXNZro
         w1Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWQgd5nCZ37yg0M8j5TtsOo73kCwOoTqz9wUPaSZ9yWFnZxRzj9bLXWQBpcBFp82gvCFRYW4bscBnLOnMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRBh/rpGCadpk2KmrXHO75HNyUgc50CjZdQ2VGY2OpfH+iU713
	2igblw5SaM5UCkuktOhl0YnK8txzKEdfPAlnStkqKDRB0iA09W1wkqtVoM6p
X-Gm-Gg: ASbGncsGaP8LlI75eNtJeHeIaJB+Ko2ZSAgQ00d++jdjBroNd0J8ABmNOBP/YiqY8mP
	/NhLRxeQ5AN5kVNlVgBvuHPQdt8IH3OgmghC4LjWFqG/m4BPCp8STusGKS6vGNmG4TtSeMVwd2+
	FPq3josLp9OhLzv6ybNwUqdjzhxXO+DM9bGkiNSMtI2BZgvzfn4ywmEh5SkdjDpGV0Gs1mvMMz7
	9IG0PeZKyjTX7BuXLMmpeDXyA==
X-Google-Smtp-Source: AGHT+IGz+LyrZDzvfCoKDhErZ+b/JaQjJiXvjgJkFwTA738KB46n0B3huiI/heNm8CMJy3bBB07lhg==
X-Received: by 2002:a17:902:da90:b0:20c:af5c:fc90 with SMTP id d9443c01a7336-215bd13df48mr302575ad.49.1733174625572;
        Mon, 02 Dec 2024 13:23:45 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21598f3281fsm20729515ad.279.2024.12.02.13.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:23:45 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 09/11] net: gianfar: remove free_gfar_dev
Date: Mon,  2 Dec 2024 13:23:29 -0800
Message-ID: <20241202212331.7238-10-rosenp@gmail.com>
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


