Return-Path: <netdev+bounces-205930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09EBB00D57
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735757A3C99
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00632FF46D;
	Thu, 10 Jul 2025 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkgTu2O2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DF2FEE32
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180044; cv=none; b=fWWqJkJcK5ZBjiJdoI1uK+mlERr18SLg+vEnKC/J0NfB7KSwkpS9DBAnOYqZ+LYpT8EGNtN6fyLEb0ItdhIP8bFB9AHrTlPlj3eR7RpqX/COWKvbFGvESwgEk9gRJAQ0MrZqgGgtGFKZlWDKzIlZ25RF3bgK5C4QLKiWEAK4TlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180044; c=relaxed/simple;
	bh=QiQcjwnugEr4scAsaddEGg9VWx9+kWaUrS7Rv6RmOH0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXvXuJYFvOkG5jT5mMFuCqBVFlvoTsWzhoNomr+50y+gHfqLy4fiyhlhpLxMgdP3WRYKJyBBJ8dto9c4XXJvHO/aeNm0/TGmnMDnQ8VjUN3pHejeUCfFZ0L6LYF6zUcGKZK4awXaWbGJmyuDGbG2LK/8vhmLmGzp8FlJhlueK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkgTu2O2; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so1228543a12.2
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180042; x=1752784842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/swJcXFTLHY6CJOlRMl4sc3jwx3DFJUcDEDPPCXhstc=;
        b=IkgTu2O2AW8UJ8ceOqmRnOIScNnDr40p6w3a29uwIYomWhcP7Ud98e+rykx24aZkGB
         LV1baNarmGUcyoGsU0/5ZYMWfDG5hmxTdurAZtGegz+9EoTeLSvSnqMf2Vp+C5KUDtIO
         JwDfu+V1K9x2lDnuKQLSpJYmZg44jgTwYkFd+fzEOCKJ/CDYwBzDucVWbhn2sDEjkHcd
         ocnL9KC9nM095crzTM5rNc7FK3vtZwzFqqpO6you4DVIo7Zzc/l/dGMC7jxXDr1iEkOz
         kO1//fOoNva8QuYoEidsefs/4Qt5P29tuJ39ESv1EvXobW6ZxDktiFLiZFni+mN/JRmc
         z0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180042; x=1752784842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/swJcXFTLHY6CJOlRMl4sc3jwx3DFJUcDEDPPCXhstc=;
        b=qFuoLH7HaxGao+NWK+7HBz5W0WmQUY+DmD87d8VxsLwWnm7NAVbZ354JZ8v5ky3GX4
         AsqtZBiHrTesuYJ6cCU10xkkzmnV89sqI/kvAtqoM3u4fduouscYZ8XLbtAolpLAC8Qp
         E7UicJRe1ECsIds3H+IGCHax3Be8wRhG8YBX7s6hzVJebQEx+BLswtlYqK+yWG/QjS0/
         UfDLEhmgcVRC3Qes7tg+X6uBK3f+E421OfwjPwg3ntFzLvyc8sDUHmueJ0RWl5HBBPB/
         sOyXkom1bAwrGqe4YrbR7FVyBlJMb/k0bEZwnBfVIEfj4iKQdmSwTGERn1gPJiy7CFh5
         nyxg==
X-Gm-Message-State: AOJu0YwgXph/M7OSb6q77CWBH0s1iK6SYRjRoZHmLJPZvRROKDrmqsYp
	55zM5TW0biTkgjfil3WAGjp2c7kzfUUiuSaRCdiGUisziaJVzan3D7kMHLU1Yhh6
X-Gm-Gg: ASbGncs2xNqFzeZdcMqKir+EqbtrbQPwk+VXVMoltuHzPAxzojPiaP2JDiL0FDwkJz0
	WSr+jP64sTZgNqahEqzc5w+lfeNu8FTb38ohiEDtyDauo/M5NJRwuYppAIwUu9PhorH/62DgDJJ
	USYY4Ik9/iEgkJOTkmUDWmr8grcVsAs6oeK1LVxFIZnxVMgjlOC5zE+nPBJn1ov1zOqT/iU/YRt
	zvjMkaCui4JefcfqIJ4QY+UtMIKrE59Ck22gGiEuJAJ5rGCl8+4YUl96Gmh17XtAVJjwE/irYt7
	Vrp8nYzlaXHAmwIddmA7FyW+nPEQ0vXPi7jr8u54DLw=
X-Google-Smtp-Source: AGHT+IFFyih9eu5JnZ8rSQxVu+1wb0KHiBoxnf9H2MijGkZSGq2/mlDfU0F/w6GhGgqG7J0QfUJ9lA==
X-Received: by 2002:a17:90a:3945:b0:315:af43:12ee with SMTP id 98e67ed59e1d1-31c4cce5478mr929721a91.16.1752180042392;
        Thu, 10 Jul 2025 13:40:42 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm3547861a91.46.2025.07.10.13.40.41
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:40:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 11/11] net: gianfar: iomap with devm
Date: Thu, 10 Jul 2025 13:40:32 -0700
Message-ID: <20250710204032.650152-12-rosenp@gmail.com>
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

Remove unmap_group_regs as it no longer served a purpose. devm can
handle this automatically.

Remove gotos as they are no longer needed.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 26 +++++-------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index bc1d7c4bd1a7..1932c6d8bc66 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -442,15 +442,6 @@ static int gfar_alloc_rx_queues(struct gfar_private *priv)
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
@@ -484,7 +475,7 @@ static int gfar_parse_group(struct device_node *np,
 			return -ENOMEM;
 	}
 
-	grp->regs = of_iomap(np, 0);
+	grp->regs = devm_of_iomap(priv->dev, np, 0, NULL);
 	if (!grp->regs)
 		return -ENOMEM;
 
@@ -691,13 +682,13 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
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
@@ -720,7 +711,7 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 	err = of_get_ethdev_address(np, dev);
 	if (err == -EPROBE_DEFER)
-		goto err_grp_init;
+		return err;
 	if (err) {
 		eth_hw_addr_random(dev);
 		dev_info(&ofdev->dev, "Using random MAC address: %pM\n", dev->dev_addr);
@@ -768,7 +759,7 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	if (!priv->phy_node && of_phy_is_fixed_link(np)) {
 		err = of_phy_register_fixed_link(np);
 		if (err)
-			goto err_grp_init;
+			return err;
 
 		priv->phy_node = of_node_get(np);
 	}
@@ -777,10 +768,6 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	priv->tbi_node = of_parse_phandle(np, "tbi-handle", 0);
 
 	return 0;
-
-err_grp_init:
-	unmap_group_regs(priv);
-	return err;
 }
 
 static u32 cluster_entry_per_class(struct gfar_private *priv, u32 rqfar,
@@ -3287,7 +3274,6 @@ static int gfar_probe(struct platform_device *ofdev)
 register_fail:
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
-	unmap_group_regs(priv);
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
 	return err;
@@ -3303,8 +3289,6 @@ static void gfar_remove(struct platform_device *ofdev)
 
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
-
-	unmap_group_regs(priv);
 }
 
 #ifdef CONFIG_PM
-- 
2.50.0


