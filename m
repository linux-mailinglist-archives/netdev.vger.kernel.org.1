Return-Path: <netdev+bounces-131070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BB898C787
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CF71C23B0E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08F71CF5F7;
	Tue,  1 Oct 2024 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkeTw59N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545CF1CF2B7;
	Tue,  1 Oct 2024 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817734; cv=none; b=FfblASJ2mzCNj4ou9NNuxc+Pqb5Na567+a1NtybeC4IouiczFyVsCDZBnON0Gh1hm8kOmLFC6C7v1JKjXyUyxInF4X5Oir1ENEP315Hlk06VkRNtJg5YR7d7IPk7rfrBWCfkHokeq8zPwc5tdHAhKeyyB4J02bYxn626dQE4nkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817734; c=relaxed/simple;
	bh=DZYFjktoIihobhlGbWl9pbIqwhs7oZ9mIFgmBRiZeZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYrkMR08I7PDOMfkAAeEjybQVpypo4xgthMOlUILfAI5PmqUlWa57QYqMMQij2WxnL5SfsSInLsTaboVSLi9jKXDWudl008AjlyEci9GEYL4B98e+buwVFHQSaii6QkkxnM2+7gWZU2vzmXDvkP6RpOKeiLNvYaLB92TXMB6qCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkeTw59N; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b1335e4e4so54565045ad.0;
        Tue, 01 Oct 2024 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727817732; x=1728422532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HhAsvUSxcaPvt/idfj9E3lnChQ0pfTApWXnOCNYoO4=;
        b=MkeTw59NWov90ACw7s2E1BjAemSu6YimLVyA/zcrcNJ267pErctxe8zXuHY+oLxCFT
         RBlTnvhoMrEIvwHPKDWpYZTnGKKX4ZSnuuQzHiTIIT6e8V7mjDUSYjQH0TiM/v/LkPjy
         1jdk6eRMe/zP6RvP7Sl7oqYTbY/eMu0GJNyVYoJ71sN/B8lCp4YAKEjsMJVriNblNaOh
         ImuGbkHZ6UuxQpzGrBG8Wz047K3KqlpDWLg68XOi+Jsz4qhSPfSfdHTWdyRX9UigWCX4
         Ilp08/+R9BfVVjDQzqaPxJpkmtvkUvtEHYsnGuw4ymfZtsxojbVNwoa7RmLb3cTw3kB6
         X2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817732; x=1728422532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HhAsvUSxcaPvt/idfj9E3lnChQ0pfTApWXnOCNYoO4=;
        b=aHmrhSR8dDAOXrH08WybVjSpmAcnrol5xvzMBVQHPUEkgHVqUsPY++zuTJz4PRB7iQ
         VG9KLKoRa6BQvEnnNO22aMevpJX5XUI/gwCyJki+1X2L8Kyy6HoEN8OP+XFE6LXJpnzf
         72BcieD6hcfw2fjSIXsingm0lj2OH4VFTK3y1qaCiZW65nlqVkRfvGGV9kltzlY8h6y6
         lXiNmV9IX4CYVTnmWNj1WUx6NTT2kMRN/C8rdf5NC7caTA40oXLdhhOHAOVpyTlTHQbD
         eOZwOWnUt7Sj0HICxZtOM34NRDPlpQEOUCPRV5+nkQukkI0EgpVmoOQpAPSzQe/5b6HI
         c4eg==
X-Forwarded-Encrypted: i=1; AJvYcCUNRw2zzCHY9XpzBtBezKhwJMEkzvyU5Kd6R4oxSkfVCK9fPV6cPbmr8Nqj6kO3xi+Nn5JuidcFYoKpghY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5FMe/1yUBFVjGXK2/ZRMtuvyHbWr0D4AGOe2QvAZsO3dSpumX
	OhkDFmVCHWru+8I2YCuaDDqUGGbUtUlk2iGTjGlHJWHKytgf8LA4TqRgYgGy
X-Google-Smtp-Source: AGHT+IGGl9SQ8ZXgyHHQ/BcdNGdw6gW7afgVBUCZEAPuizlVnCQtyJJfdxwK8rFM1uLtzR7uleHEIw==
X-Received: by 2002:a17:90a:f40d:b0:2e0:a931:cb11 with SMTP id 98e67ed59e1d1-2e18454bfafmr1321298a91.4.1727817732527;
        Tue, 01 Oct 2024 14:22:12 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8a731asm47144a91.34.2024.10.01.14.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:22:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	claudiu.manoil@nxp.com
Subject: [PATCH net-next 5/6] net: gianfar: use devm for request_irq
Date: Tue,  1 Oct 2024 14:22:03 -0700
Message-ID: <20241001212204.308758-6-rosenp@gmail.com>
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

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 67 +++++++-----------------
 1 file changed, 18 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 07936dccc389..78fdab3c6f77 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2769,13 +2769,6 @@ static void gfar_netpoll(struct net_device *dev)
 }
 #endif
 
-static void free_grp_irqs(struct gfar_priv_grp *grp)
-{
-	free_irq(gfar_irq(grp, TX)->irq, grp);
-	free_irq(gfar_irq(grp, RX)->irq, grp);
-	free_irq(gfar_irq(grp, ER)->irq, grp);
-}
-
 static int register_grp_irqs(struct gfar_priv_grp *grp)
 {
 	struct gfar_private *priv = grp->priv;
@@ -2789,80 +2782,58 @@ static int register_grp_irqs(struct gfar_priv_grp *grp)
 		/* Install our interrupt handlers for Error,
 		 * Transmit, and Receive
 		 */
-		err = request_irq(gfar_irq(grp, ER)->irq, gfar_error, 0,
-				  gfar_irq(grp, ER)->name, grp);
+		err = devm_request_irq(priv->dev, gfar_irq(grp, ER)->irq,
+				       gfar_error, 0, gfar_irq(grp, ER)->name,
+				       grp);
 		if (err < 0) {
 			netif_err(priv, intr, dev, "Can't get IRQ %d\n",
 				  gfar_irq(grp, ER)->irq);
 
-			goto err_irq_fail;
+			return err;
 		}
 		enable_irq_wake(gfar_irq(grp, ER)->irq);
 
-		err = request_irq(gfar_irq(grp, TX)->irq, gfar_transmit, 0,
-				  gfar_irq(grp, TX)->name, grp);
+		err = devm_request_irq(priv->dev, gfar_irq(grp, TX)->irq,
+				       gfar_transmit, 0,
+				       gfar_irq(grp, TX)->name, grp);
 		if (err < 0) {
 			netif_err(priv, intr, dev, "Can't get IRQ %d\n",
 				  gfar_irq(grp, TX)->irq);
-			goto tx_irq_fail;
+			return err;
 		}
-		err = request_irq(gfar_irq(grp, RX)->irq, gfar_receive, 0,
-				  gfar_irq(grp, RX)->name, grp);
+		err = devm_request_irq(priv->dev, gfar_irq(grp, RX)->irq,
+				       gfar_receive, 0, gfar_irq(grp, RX)->name,
+				       grp);
 		if (err < 0) {
 			netif_err(priv, intr, dev, "Can't get IRQ %d\n",
 				  gfar_irq(grp, RX)->irq);
-			goto rx_irq_fail;
+			return err;
 		}
 		enable_irq_wake(gfar_irq(grp, RX)->irq);
 
 	} else {
-		err = request_irq(gfar_irq(grp, TX)->irq, gfar_interrupt, 0,
-				  gfar_irq(grp, TX)->name, grp);
+		err = devm_request_irq(priv->dev, gfar_irq(grp, TX)->irq,
+				       gfar_interrupt, 0,
+				       gfar_irq(grp, TX)->name, grp);
 		if (err < 0) {
 			netif_err(priv, intr, dev, "Can't get IRQ %d\n",
 				  gfar_irq(grp, TX)->irq);
-			goto err_irq_fail;
+			return err;
 		}
 		enable_irq_wake(gfar_irq(grp, TX)->irq);
 	}
 
 	return 0;
-
-rx_irq_fail:
-	free_irq(gfar_irq(grp, TX)->irq, grp);
-tx_irq_fail:
-	free_irq(gfar_irq(grp, ER)->irq, grp);
-err_irq_fail:
-	return err;
-
-}
-
-static void gfar_free_irq(struct gfar_private *priv)
-{
-	int i;
-
-	/* Free the IRQs */
-	if (priv->device_flags & FSL_GIANFAR_DEV_HAS_MULTI_INTR) {
-		for (i = 0; i < priv->num_grps; i++)
-			free_grp_irqs(&priv->gfargrp[i]);
-	} else {
-		for (i = 0; i < priv->num_grps; i++)
-			free_irq(gfar_irq(&priv->gfargrp[i], TX)->irq,
-				 &priv->gfargrp[i]);
-	}
 }
 
 static int gfar_request_irq(struct gfar_private *priv)
 {
-	int err, i, j;
+	int err, i;
 
 	for (i = 0; i < priv->num_grps; i++) {
 		err = register_grp_irqs(&priv->gfargrp[i]);
-		if (err) {
-			for (j = 0; j < i; j++)
-				free_grp_irqs(&priv->gfargrp[j]);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
@@ -2902,8 +2873,6 @@ static int gfar_close(struct net_device *dev)
 	/* Disconnect from the PHY */
 	phy_disconnect(dev->phydev);
 
-	gfar_free_irq(priv);
-
 	return 0;
 }
 
-- 
2.46.2


