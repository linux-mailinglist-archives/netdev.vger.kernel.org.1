Return-Path: <netdev+bounces-55322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F10080A634
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72DC1F2141F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807E32033D;
	Fri,  8 Dec 2023 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCjhuI4V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A006B3848;
	Fri,  8 Dec 2023 06:52:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c19467a63so24583635e9.3;
        Fri, 08 Dec 2023 06:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047135; x=1702651935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5/O/H6nUdwu1//MonWtOM4w7F6u3pPBln032X6Yzks=;
        b=cCjhuI4V7g3BKattb0Qk7pUDvdvXOUbdqVoi3KEzIO8aYKFHk3HrmPIkmpQnZt5KPz
         7X1nPZZP0oeUZpUzL+lbLAW2cNmmqmjE3/UfE9Ixyvu7zS/Vi6j3p0vG9CaB2CnzduWm
         irqQ1UwjmPIBEfuqh4h0mt1rYuYKWC7abhq4pBK2zu2g7M9CrAnJY2QJfN84NDpV1H+C
         hzFyz7RacH6scZAvhSIla7649KCUp84GhVC3PTOotfKN72F+oOTeNY/WMUjGUQojKeXo
         aFqwzQjGN3cA76EwCXZuFirb7H3GbpXrVnKlo4Ow33TSInBMMzraFt1EJ4Q5Vv4y5B7I
         R/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047135; x=1702651935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5/O/H6nUdwu1//MonWtOM4w7F6u3pPBln032X6Yzks=;
        b=A3ymuCLvmFKpcniWP13ZM8fd0VCzhGsfTIPMm8G5LMhFTo6hY7DoF6vuHsvro9UgoI
         cODRXC4CES8MmCy+9c/VGAwi7HzjQgx20wI1JDYmjuW2+cgRbvFyHgV9eUgwZ270l88J
         Usruz0ktP4yrirfaDDFZIvAmQo7M3E8+Ue0WxiqSsL7KHROsjYtvZ6Xqm79ELKH2NUu+
         GItHV60Gt0q6pGGJ2m4VP6MdwGhWLBHHU53N6kd5PdL/9/pGWTxNFDSSK+P+ydujuCkG
         G7OIGc/LWxJ1kIwj06r1dA6C0YM0wmYsd3SnnXninbvJMtGWeVjubdf7iFzUVySYjj4W
         4qHw==
X-Gm-Message-State: AOJu0YyXtRsxSiBTCBhimdXPPPcmrY0qOkDBxB9Q0b6hR0jajW/UQyb5
	P4IX4C1PFe5aRH6dQW0BpgM/fVpAoy8=
X-Google-Smtp-Source: AGHT+IHVaHwU+tLLPUOaGgsgNxEGh6ogpNiaXnDzv0nvMD3D1QPq0vsU6EY6ItnQ3vls8tTbGj0Vfw==
X-Received: by 2002:a05:600c:204b:b0:40b:5e59:e9f3 with SMTP id p11-20020a05600c204b00b0040b5e59e9f3mr40459wmg.146.1702047134544;
        Fri, 08 Dec 2023 06:52:14 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:14 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v4 07/13] net: phy: at803x: move specific at8031 config_init to dedicated function
Date: Fri,  8 Dec 2023 15:51:54 +0100
Message-Id: <20231208145200.25162-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208145200.25162-1-ansuelsmth@gmail.com>
References: <20231208145200.25162-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move specific at8031 config_init to dedicated function to make
at803x_config_init more generic and tidy things up.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 45 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 6cb41af31818..e2bf5a16ba3c 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -951,27 +951,8 @@ static int at803x_hibernation_mode_config(struct phy_device *phydev)
 
 static int at803x_config_init(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	int ret;
 
-	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-		/* Some bootloaders leave the fiber page selected.
-		 * Switch to the appropriate page (fiber or copper), as otherwise we
-		 * read the PHY capabilities from the wrong page.
-		 */
-		phy_lock_mdio_bus(phydev);
-		ret = at803x_write_page(phydev,
-					priv->is_fiber ? AT803X_PAGE_FIBER :
-							 AT803X_PAGE_COPPER);
-		phy_unlock_mdio_bus(phydev);
-		if (ret)
-			return ret;
-
-		ret = at8031_pll_config(phydev);
-		if (ret < 0)
-			return ret;
-	}
-
 	/* The RX and TX delay default is:
 	 *   after HW reset: RX delay enabled and TX delay disabled
 	 *   after SW reset: RX delay enabled, while TX delay retains the
@@ -1604,6 +1585,30 @@ static int at8031_probe(struct phy_device *phydev)
 			      AT803X_WOL_EN, 0);
 }
 
+static int at8031_config_init(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	int ret;
+
+	/* Some bootloaders leave the fiber page selected.
+	 * Switch to the appropriate page (fiber or copper), as otherwise we
+	 * read the PHY capabilities from the wrong page.
+	 */
+	phy_lock_mdio_bus(phydev);
+	ret = at803x_write_page(phydev,
+				priv->is_fiber ? AT803X_PAGE_FIBER :
+						 AT803X_PAGE_COPPER);
+	phy_unlock_mdio_bus(phydev);
+	if (ret)
+		return ret;
+
+	ret = at8031_pll_config(phydev);
+	if (ret < 0)
+		return ret;
+
+	return at803x_config_init(phydev);
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2113,7 +2118,7 @@ static struct phy_driver at803x_driver[] = {
 	.name			= "Qualcomm Atheros AR8031/AR8033",
 	.flags			= PHY_POLL_CABLE_TEST,
 	.probe			= at8031_probe,
-	.config_init		= at803x_config_init,
+	.config_init		= at8031_config_init,
 	.config_aneg		= at803x_config_aneg,
 	.soft_reset		= genphy_soft_reset,
 	.set_wol		= at803x_set_wol,
-- 
2.40.1


