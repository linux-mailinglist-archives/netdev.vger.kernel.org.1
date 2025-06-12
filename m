Return-Path: <netdev+bounces-197050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0F2AD76AD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7793D7B60FB
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED6929A327;
	Thu, 12 Jun 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g1Czl30N"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106B27145C
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742895; cv=none; b=kNCKLCgQQhxlrI3kC02wYrFDMDuNAVonorsLO62aR2F9/L1UKdmtyPFpYREnSoIe/YKsv5mVAtTJGFJmeD2NifxuHn7ukp0nBNhtmBGY2NIUMs7Kz3X3mZ5BExUl/fg9OK8ltQvQDwZkE2QLjkhTT9dJ2OXdE9syO9F1WF+tvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742895; c=relaxed/simple;
	bh=apS+GNSK/Ja3NKhZIXXMoZaW5scYcXmoyAOOUxZ0HXE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qQOefZbHOgAxlo/7ZN0rnMbuHJ6a4GVhCVHDYcKIyRumqUhSXx5IZDP3Z1Dkf+pALlW0/8fAl7NkVvgtZweUXlvYRLlgObrhfvLuxzfr0H/gEk4Bj62Q/Dd2IN1CG4+m+I5LwAVfEzht9ZBNOaRb46dNCz9wiRlhwqAjiovzonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=g1Czl30N; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CC0g4GmOm4bxRpRpsR1/d4pivwR+6mfH3HXLbDWPYKs=; b=g1Czl30NgvMFN5zDQt40YI9mc1
	XJjZ9affoElNN3rsWEzBWh44jQYU2YKixkIkaWjOezoAyybQknJPDyqQanmIdp46r5BmZF+MkjtHP
	cM42u4ZUGa9VBpmLYEVoEyApsGjgXS5F57Plu9wFQBZaEa6bG8y0ho0B3YEeAkny/EBmvTnjD121G
	GVaViSmAH3G3Ek6argen99VTPVXMyMWF8A3S60+bV1L248jCh9+wh1pGBbfdmH5xP7f2zPDtDMOX6
	k5haVlVe0sH+kqQj4/jy8KNU5K7qnqLA5gD7bPN8RIViBibUwiZogxKsnxGtH8tH1C+0Sr0N9EEvO
	JOyIV1Jw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60394 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPk3S-00083a-2s;
	Thu, 12 Jun 2025 16:41:26 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPk2o-004CFH-Q4; Thu, 12 Jun 2025 16:40:46 +0100
In-Reply-To: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/9] net: stmmac: rk: simplify set_*_speed()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uPk2o-004CFH-Q4@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Jun 2025 16:40:46 +0100

Rather than having lots of regmap_write()s to the same register but
with different values depending on the speed, reorganise the
functions to use a local variable for the value, and then have one
regmap_write() call to write it to the register. This reduces the
amount of code and is a step towards further reducing the code size.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 303 ++++++++++--------
 1 file changed, 161 insertions(+), 142 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 8006424ab027..7a1a9f54748d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -264,35 +264,37 @@ static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 static void rk3128_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con1;
 
-	if (speed == 10)
-		regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
-			     RK3128_GMAC_CLK_2_5M);
-	else if (speed == 100)
-		regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
-			     RK3128_GMAC_CLK_25M);
-	else if (speed == 1000)
-		regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
-			     RK3128_GMAC_CLK_125M);
-	else
+	if (speed == 10) {
+		con1 = RK3128_GMAC_CLK_2_5M;
+	} else if (speed == 100) {
+		con1 = RK3128_GMAC_CLK_25M;
+	} else if (speed == 1000) {
+		con1 = RK3128_GMAC_CLK_125M;
+	} else {
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
+		return;
+	}
+
+	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1, con1);
 }
 
 static void rk3128_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con1;
 
 	if (speed == 10) {
-		regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
-			     RK3128_GMAC_RMII_CLK_2_5M |
-			     RK3128_GMAC_SPEED_10M);
+		con1 = RK3128_GMAC_RMII_CLK_2_5M | RK3128_GMAC_SPEED_10M;
 	} else if (speed == 100) {
-		regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
-			     RK3128_GMAC_RMII_CLK_25M |
-			     RK3128_GMAC_SPEED_100M);
+		con1 = RK3128_GMAC_RMII_CLK_25M | RK3128_GMAC_SPEED_100M;
 	} else {
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+		return;
 	}
+
+	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1, con1);
 }
 
 static const struct rk_gmac_ops rk3128_ops = {
@@ -361,34 +363,37 @@ static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 static void rk3228_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con1;
 
-	if (speed == 10)
-		regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
-			     RK3228_GMAC_CLK_2_5M);
-	else if (speed == 100)
-		regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
-			     RK3228_GMAC_CLK_25M);
-	else if (speed == 1000)
-		regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
-			     RK3228_GMAC_CLK_125M);
-	else
+	if (speed == 10) {
+		con1 = RK3228_GMAC_CLK_2_5M;
+	} else if (speed == 100) {
+		con1 = RK3228_GMAC_CLK_25M;
+	} else if (speed == 1000) {
+		con1 = RK3228_GMAC_CLK_125M;
+	} else {
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
+		return;
+	}
+
+	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1, con1);
 }
 
 static void rk3228_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con1;
 
-	if (speed == 10)
-		regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
-			     RK3228_GMAC_RMII_CLK_2_5M |
-			     RK3228_GMAC_SPEED_10M);
-	else if (speed == 100)
-		regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
-			     RK3228_GMAC_RMII_CLK_25M |
-			     RK3228_GMAC_SPEED_100M);
-	else
+	if (speed == 10) {
+		con1 = RK3228_GMAC_RMII_CLK_2_5M | RK3228_GMAC_SPEED_10M;
+	} else if (speed == 100) {
+		con1 = RK3228_GMAC_RMII_CLK_25M | RK3228_GMAC_SPEED_100M;
+	} else {
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+		return;
+	}
+
+	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1, con1);
 }
 
 static void rk3228_integrated_phy_powerup(struct rk_priv_data *priv)
@@ -457,35 +462,37 @@ static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 static void rk3288_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con1;
 
-	if (speed == 10)
-		regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
-			     RK3288_GMAC_CLK_2_5M);
-	else if (speed == 100)
-		regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
-			     RK3288_GMAC_CLK_25M);
-	else if (speed == 1000)
-		regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
-			     RK3288_GMAC_CLK_125M);
-	else
+	if (speed == 10) {
+		con1 = RK3288_GMAC_CLK_2_5M;
+	} else if (speed == 100) {
+		con1 = RK3288_GMAC_CLK_25M;
+	} else if (speed == 1000) {
+		con1 = RK3288_GMAC_CLK_125M;
+	} else {
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
+		return;
+	}
+
+	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1, con1);
 }
 
 static void rk3288_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con1;
 
 	if (speed == 10) {
-		regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
-			     RK3288_GMAC_RMII_CLK_2_5M |
-			     RK3288_GMAC_SPEED_10M);
+		con1 = RK3288_GMAC_RMII_CLK_2_5M | RK3288_GMAC_SPEED_10M;
 	} else if (speed == 100) {
-		regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
-			     RK3288_GMAC_RMII_CLK_25M |
-			     RK3288_GMAC_SPEED_100M);
+		con1 = RK3288_GMAC_RMII_CLK_25M | RK3288_GMAC_SPEED_100M;
 	} else {
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+		return;
 	}
+
+	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1, con1);
 }
 
 static const struct rk_gmac_ops rk3288_ops = {
@@ -514,16 +521,18 @@ static void rk3308_set_to_rmii(struct rk_priv_data *bsp_priv)
 static void rk3308_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con0;
 
 	if (speed == 10) {
-		regmap_write(bsp_priv->grf, RK3308_GRF_MAC_CON0,
-			     RK3308_GMAC_SPEED_10M);
+		con0 = RK3308_GMAC_SPEED_10M;
 	} else if (speed == 100) {
-		regmap_write(bsp_priv->grf, RK3308_GRF_MAC_CON0,
-			     RK3308_GMAC_SPEED_100M);
+		con0 = RK3308_GMAC_SPEED_100M;
 	} else {
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+		return;
 	}
+
+	regmap_write(bsp_priv->grf, RK3308_GRF_MAC_CON0, con0);
 }
 
 static const struct rk_gmac_ops rk3308_ops = {
@@ -593,38 +602,40 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 static void rk3328_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con1;
 
-	if (speed == 10)
-		regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
-			     RK3328_GMAC_CLK_2_5M);
-	else if (speed == 100)
-		regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
-			     RK3328_GMAC_CLK_25M);
-	else if (speed == 1000)
-		regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
-			     RK3328_GMAC_CLK_125M);
-	else
+	if (speed == 10) {
+		con1 = RK3328_GMAC_CLK_2_5M;
+	} else if (speed == 100) {
+		con1 = RK3328_GMAC_CLK_25M;
+	} else if (speed == 1000) {
+		con1 = RK3328_GMAC_CLK_125M;
+	} else {
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
+		return;
+	}
+
+	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1, con1);
 }
 
 static void rk3328_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int reg;
+	unsigned int reg, con;
 
 	reg = bsp_priv->integrated_phy ? RK3328_GRF_MAC_CON2 :
 		  RK3328_GRF_MAC_CON1;
 
-	if (speed == 10)
-		regmap_write(bsp_priv->grf, reg,
-			     RK3328_GMAC_RMII_CLK_2_5M |
-			     RK3328_GMAC_SPEED_10M);
-	else if (speed == 100)
-		regmap_write(bsp_priv->grf, reg,
-			     RK3328_GMAC_RMII_CLK_25M |
-			     RK3328_GMAC_SPEED_100M);
-	else
+	if (speed == 10) {
+		con = RK3328_GMAC_RMII_CLK_2_5M | RK3328_GMAC_SPEED_10M;
+	} else if (speed == 100) {
+		con = RK3328_GMAC_RMII_CLK_25M | RK3328_GMAC_SPEED_100M;
+	} else {
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+		return;
+	}
+
+	regmap_write(bsp_priv->grf, reg, con);
 }
 
 static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
@@ -693,35 +704,37 @@ static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 static void rk3366_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con6;
 
-	if (speed == 10)
-		regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
-			     RK3366_GMAC_CLK_2_5M);
-	else if (speed == 100)
-		regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
-			     RK3366_GMAC_CLK_25M);
-	else if (speed == 1000)
-		regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
-			     RK3366_GMAC_CLK_125M);
-	else
+	if (speed == 10) {
+		con6 = RK3366_GMAC_CLK_2_5M;
+	} else if (speed == 100) {
+		con6 = RK3366_GMAC_CLK_25M;
+	} else if (speed == 1000) {
+		con6 = RK3366_GMAC_CLK_125M;
+	} else {
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
+		return;
+	}
+
+	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6, con6);
 }
 
 static void rk3366_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con6;
 
 	if (speed == 10) {
-		regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
-			     RK3366_GMAC_RMII_CLK_2_5M |
-			     RK3366_GMAC_SPEED_10M);
+		con6 = RK3366_GMAC_RMII_CLK_2_5M | RK3366_GMAC_SPEED_10M;
 	} else if (speed == 100) {
-		regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
-			     RK3366_GMAC_RMII_CLK_25M |
-			     RK3366_GMAC_SPEED_100M);
+		con6 = RK3366_GMAC_RMII_CLK_25M | RK3366_GMAC_SPEED_100M;
 	} else {
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+		return;
 	}
+
+	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6, con6);
 }
 
 static const struct rk_gmac_ops rk3366_ops = {
@@ -780,35 +793,37 @@ static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 static void rk3368_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con15;
 
-	if (speed == 10)
-		regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
-			     RK3368_GMAC_CLK_2_5M);
-	else if (speed == 100)
-		regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
-			     RK3368_GMAC_CLK_25M);
-	else if (speed == 1000)
-		regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
-			     RK3368_GMAC_CLK_125M);
-	else
+	if (speed == 10) {
+		con15 = RK3368_GMAC_CLK_2_5M;
+	} else if (speed == 100) {
+		con15 = RK3368_GMAC_CLK_25M;
+	} else if (speed == 1000) {
+		con15 = RK3368_GMAC_CLK_125M;
+	} else {
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
+		return;
+	}
+
+	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15, con15);
 }
 
 static void rk3368_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con15;
 
 	if (speed == 10) {
-		regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
-			     RK3368_GMAC_RMII_CLK_2_5M |
-			     RK3368_GMAC_SPEED_10M);
+		con15 = RK3368_GMAC_RMII_CLK_2_5M | RK3368_GMAC_SPEED_10M;
 	} else if (speed == 100) {
-		regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
-			     RK3368_GMAC_RMII_CLK_25M |
-			     RK3368_GMAC_SPEED_100M);
+		con15 = RK3368_GMAC_RMII_CLK_25M | RK3368_GMAC_SPEED_100M;
 	} else {
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+		return;
 	}
+
+	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15, con15);
 }
 
 static const struct rk_gmac_ops rk3368_ops = {
@@ -867,35 +882,37 @@ static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 static void rk3399_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con5;
 
-	if (speed == 10)
-		regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
-			     RK3399_GMAC_CLK_2_5M);
-	else if (speed == 100)
-		regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
-			     RK3399_GMAC_CLK_25M);
-	else if (speed == 1000)
-		regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
-			     RK3399_GMAC_CLK_125M);
-	else
+	if (speed == 10) {
+		con5 = RK3399_GMAC_CLK_2_5M;
+	} else if (speed == 100) {
+		con5 = RK3399_GMAC_CLK_25M;
+	} else if (speed == 1000) {
+		con5 = RK3399_GMAC_CLK_125M;
+	} else {
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
+		return;
+	}
+
+	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5, con5);
 }
 
 static void rk3399_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con5;
 
 	if (speed == 10) {
-		regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
-			     RK3399_GMAC_RMII_CLK_2_5M |
-			     RK3399_GMAC_SPEED_10M);
+		con5 = RK3399_GMAC_RMII_CLK_2_5M | RK3399_GMAC_SPEED_10M;
 	} else if (speed == 100) {
-		regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
-			     RK3399_GMAC_RMII_CLK_25M |
-			     RK3399_GMAC_SPEED_100M);
+		con5 = RK3399_GMAC_RMII_CLK_25M | RK3399_GMAC_SPEED_100M;
 	} else {
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+		return;
 	}
+
+	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5, con5);
 }
 
 static const struct rk_gmac_ops rk3399_ops = {
@@ -968,18 +985,20 @@ static void rk3528_set_to_rmii(struct rk_priv_data *bsp_priv)
 static void rk3528_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con5;
 
-	if (speed == 10)
-		regmap_write(bsp_priv->grf, RK3528_VPU_GRF_GMAC_CON5,
-			     RK3528_GMAC1_CLK_RGMII_DIV50);
-	else if (speed == 100)
-		regmap_write(bsp_priv->grf, RK3528_VPU_GRF_GMAC_CON5,
-			     RK3528_GMAC1_CLK_RGMII_DIV5);
-	else if (speed == 1000)
-		regmap_write(bsp_priv->grf, RK3528_VPU_GRF_GMAC_CON5,
-			     RK3528_GMAC1_CLK_RGMII_DIV1);
-	else
+	if (speed == 10) {
+		con5 = RK3528_GMAC1_CLK_RGMII_DIV50;
+	} else if (speed == 100) {
+		con5 = RK3528_GMAC1_CLK_RGMII_DIV5;
+	} else if (speed == 1000) {
+		con5 = RK3528_GMAC1_CLK_RGMII_DIV1;
+	} else {
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
+		return;
+	}
+
+	regmap_write(bsp_priv->grf, RK3528_VPU_GRF_GMAC_CON5, con5);
 }
 
 static void rk3528_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
@@ -987,13 +1006,13 @@ static void rk3528_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int reg, val;
 
-	if (speed == 10)
+	if (speed == 10) {
 		val = bsp_priv->id == 1 ? RK3528_GMAC1_CLK_RMII_DIV20 :
 					  RK3528_GMAC0_CLK_RMII_DIV20;
-	else if (speed == 100)
+	} else if (speed == 100) {
 		val = bsp_priv->id == 1 ? RK3528_GMAC1_CLK_RMII_DIV2 :
 					  RK3528_GMAC0_CLK_RMII_DIV2;
-	else {
+	} else {
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
 		return;
 	}
@@ -1430,18 +1449,18 @@ static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
 static void rv1108_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con0;
 
 	if (speed == 10) {
-		regmap_write(bsp_priv->grf, RV1108_GRF_GMAC_CON0,
-			     RV1108_GMAC_RMII_CLK_2_5M |
-			     RV1108_GMAC_SPEED_10M);
+		con0 = RV1108_GMAC_RMII_CLK_2_5M | RV1108_GMAC_SPEED_10M;
 	} else if (speed == 100) {
-		regmap_write(bsp_priv->grf, RV1108_GRF_GMAC_CON0,
-			     RV1108_GMAC_RMII_CLK_25M |
-			     RV1108_GMAC_SPEED_100M);
+		con0 = RV1108_GMAC_RMII_CLK_25M | RV1108_GMAC_SPEED_100M;
 	} else {
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+		return;
 	}
+
+	regmap_write(bsp_priv->grf, RV1108_GRF_GMAC_CON0, con0);
 }
 
 static const struct rk_gmac_ops rv1108_ops = {
-- 
2.30.2


