Return-Path: <netdev+bounces-197054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF87AD76ED
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067513B3F56
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187BC29ACF6;
	Thu, 12 Jun 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iIL9Q6re"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802C29ACF0
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742917; cv=none; b=ucvjLY1w1RkjT2zSxJ/KwlzQCbHabhS9O8i2OscLgjCgcLgd8lt4K6dS/2k0cB4T2dZoG14Rv1is7kKqFevWuFNNPiAPl0RGH2h1F5mSqA9xcS5tc+hmubZo3JlHVYvmJJB3SW+J31/MUoTVvRqwHtmg8fwfkJQZ0QW+Szo5Zy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742917; c=relaxed/simple;
	bh=BK6HUD+SWx9c2pmZP4/Bfg6d3DQ5WXJqbbMIbpvcSy4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=s3+fh7vQBrj3Mkb4cYuXVQqMOcOKoSTS75kzbg6INLTuEm06EuLQ3MaZ5nSryEQ68X3L13RVU8BdH0dNy3OUuBQgZl/iyhiugQqWDiOzTNisbbQwooct9G0HJCiHqPtUfpzuhRYZ96owKU5hn6d8SskdOisNSplrJYBX8cfUkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iIL9Q6re; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PjZtqLOyKsP8cLYiDM1Mfroe54thvExaAc0UYHcaWnA=; b=iIL9Q6reMvYCBCsjhNUMiIsCSd
	ZXL0e9a98pRVAvzDUJ5SLxGCTANU7Tu8OrE39HfsxB29saEsPP6gMgawOJeMiFQHrCqj3gLzDvRRO
	6OaJ5Fw0MClKR/7lpI3Nf9+hZywO8OHa3Gj9rIlwAP3oyfCs57vAProQAC81+XDSuX0ur/zWFgvvR
	R6agveakaeaUFoc5cNhGs+NPZqWamagCQPs7Qzyyf3W4nd7Y3Y5xKCgxjhxW4RPJcQ0ARZhy9iJSD
	IANy/29T3eMNhXftfYV3x7hYNI7TF1thcEsFHMVDeJ95HHOaDvoQ9tt8j64ev+sk4m2nQDRmw2jYm
	iApuiN1w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58308 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPk3n-00084c-14;
	Thu, 12 Jun 2025 16:41:47 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPk39-004CFf-7a; Thu, 12 Jun 2025 16:41:07 +0100
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
Subject: [PATCH net-next 6/9] net: stmmac: rk: combine .set_*_speed() methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uPk39-004CFf-7a@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Jun 2025 16:41:07 +0100

As a result of the previous patches, many of the .set_rgmii_speed()
and .set_rmii_speed() implementations are identical apart from the
interface mode. Add a new .set_speed() function which takes the
interface mode in addition to the speed, and use it to combine the
separate implementations, calling the common rk_set_reg_speed()
function.

Also convert rk_set_clk_mac_speed() to be called by this new method
pointer, rather than having these implementations called from both
.set_*_speed() methods.

Remove all the error messages from the .set_speed() methods, as these
return an error code which is propagated up to stmmac_mac_link_up()
which will print the error.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 274 +++++-------------
 1 file changed, 79 insertions(+), 195 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index eeef11b60566..8ad6b3b0e282 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -39,6 +39,8 @@ struct rk_gmac_ops {
 	void (*set_to_rmii)(struct rk_priv_data *bsp_priv);
 	void (*set_rgmii_speed)(struct rk_priv_data *bsp_priv, int speed);
 	void (*set_rmii_speed)(struct rk_priv_data *bsp_priv, int speed);
+	int (*set_speed)(struct rk_priv_data *bsp_priv,
+			 phy_interface_t interface, int speed);
 	void (*set_clock_selection)(struct rk_priv_data *bsp_priv, bool input,
 				    bool enable);
 	void (*integrated_phy_powerup)(struct rk_priv_data *bsp_priv);
@@ -137,39 +139,17 @@ static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 
 }
 
-static int rk_set_reg_speed_rgmii(struct rk_priv_data *bsp_priv,
-				  const struct rk_reg_speed_data *rsd,
-				  unsigned int reg, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, rsd, reg, PHY_INTERFACE_MODE_RGMII,
-				speed);
-}
-
-static int rk_set_reg_speed_rmii(struct rk_priv_data *bsp_priv,
-				 const struct rk_reg_speed_data *rsd,
-				 unsigned int reg, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, rsd, reg, PHY_INTERFACE_MODE_RMII,
-				speed);
-}
-
-static void rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv,
+				phy_interface_t interface, int speed)
 {
 	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
-	struct device *dev = &bsp_priv->pdev->dev;
 	long rate;
-	int ret;
 
 	rate = rgmii_clock(speed);
-	if (rate < 0) {
-		dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
-		return;
-	}
+	if (rate < 0)
+		return rate;
 
-	ret = clk_set_rate(clk_mac_speed, rate);
-	if (ret)
-		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
-			__func__, rate, ret);
+	return clk_set_rate(clk_mac_speed, rate);
 }
 
 #define HIWORD_UPDATE(val, mask, shift) \
@@ -358,29 +338,17 @@ static const struct rk_reg_speed_data rk3128_reg_speed_data = {
 	.rmii_100 = RK3128_GMAC_RMII_CLK_25M | RK3128_GMAC_SPEED_100M,
 };
 
-static void rk3128_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rk3128_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface, int speed)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3128_reg_speed_data,
-				   RK3128_GRF_MAC_CON1, speed))
-		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-}
-
-static void rk3128_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
-{
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rmii(bsp_priv, &rk3128_reg_speed_data,
-				  RK3128_GRF_MAC_CON1, speed))
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+	return rk_set_reg_speed(bsp_priv, &rk3128_reg_speed_data,
+				RK3128_GRF_MAC_CON1, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3128_ops = {
 	.set_to_rgmii = rk3128_set_to_rgmii,
 	.set_to_rmii = rk3128_set_to_rmii,
-	.set_rgmii_speed = rk3128_set_rgmii_speed,
-	.set_rmii_speed = rk3128_set_rmii_speed,
+	.set_speed = rk3128_set_speed,
 };
 
 #define RK3228_GRF_MAC_CON0	0x0900
@@ -447,22 +415,11 @@ static const struct rk_reg_speed_data rk3228_reg_speed_data = {
 	.rmii_100 = RK3228_GMAC_RMII_CLK_25M | RK3228_GMAC_SPEED_100M,
 };
 
-static void rk3228_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rk3228_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface, int speed)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3228_reg_speed_data,
-				   RK3228_GRF_MAC_CON1, speed))
-		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-}
-
-static void rk3228_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
-{
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rmii(bsp_priv, &rk3228_reg_speed_data,
-				  RK3228_GRF_MAC_CON1, speed))
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+	return rk_set_reg_speed(bsp_priv, &rk3228_reg_speed_data,
+				RK3228_GRF_MAC_CON1, interface, speed);
 }
 
 static void rk3228_integrated_phy_powerup(struct rk_priv_data *priv)
@@ -476,8 +433,7 @@ static void rk3228_integrated_phy_powerup(struct rk_priv_data *priv)
 static const struct rk_gmac_ops rk3228_ops = {
 	.set_to_rgmii = rk3228_set_to_rgmii,
 	.set_to_rmii = rk3228_set_to_rmii,
-	.set_rgmii_speed = rk3228_set_rgmii_speed,
-	.set_rmii_speed = rk3228_set_rmii_speed,
+	.set_speed = rk3228_set_speed,
 	.integrated_phy_powerup = rk3228_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
 };
@@ -536,29 +492,17 @@ static const struct rk_reg_speed_data rk3288_reg_speed_data = {
 	.rmii_100 = RK3288_GMAC_RMII_CLK_25M | RK3288_GMAC_SPEED_100M,
 };
 
-static void rk3288_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rk3288_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface, int speed)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3288_reg_speed_data,
-				   RK3288_GRF_SOC_CON1, speed))
-		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-}
-
-static void rk3288_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
-{
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rmii(bsp_priv, &rk3288_reg_speed_data,
-				  RK3288_GRF_SOC_CON1, speed))
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+	return rk_set_reg_speed(bsp_priv, &rk3288_reg_speed_data,
+				RK3288_GRF_SOC_CON1, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3288_ops = {
 	.set_to_rgmii = rk3288_set_to_rgmii,
 	.set_to_rmii = rk3288_set_to_rmii,
-	.set_rgmii_speed = rk3288_set_rgmii_speed,
-	.set_rmii_speed = rk3288_set_rmii_speed,
+	.set_speed = rk3288_set_speed,
 };
 
 #define RK3308_GRF_MAC_CON0		0x04a0
@@ -582,18 +526,16 @@ static const struct rk_reg_speed_data rk3308_reg_speed_data = {
 	.rmii_100 = RK3308_GMAC_SPEED_100M,
 };
 
-static void rk3308_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rk3308_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface, int speed)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rmii(bsp_priv, &rk3308_reg_speed_data,
-				  RK3308_GRF_MAC_CON0, speed))
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+	return rk_set_reg_speed(bsp_priv, &rk3308_reg_speed_data,
+				RK3308_GRF_MAC_CON0, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3308_ops = {
 	.set_to_rmii = rk3308_set_to_rmii,
-	.set_rmii_speed = rk3308_set_rmii_speed,
+	.set_speed = rk3308_set_speed,
 };
 
 #define RK3328_GRF_MAC_CON0	0x0900
@@ -663,25 +605,18 @@ static const struct rk_reg_speed_data rk3328_reg_speed_data = {
 	.rmii_100 = RK3328_GMAC_RMII_CLK_25M | RK3328_GMAC_SPEED_100M,
 };
 
-static void rk3328_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
-{
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3328_reg_speed_data,
-				   RK3328_GRF_MAC_CON1, speed))
-		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-}
-
-static void rk3328_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rk3328_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface, int speed)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int reg;
 
-	reg = bsp_priv->integrated_phy ? RK3328_GRF_MAC_CON2 :
-		  RK3328_GRF_MAC_CON1;
+	if (interface == PHY_INTERFACE_MODE_RMII && bsp_priv->integrated_phy)
+		reg = RK3328_GRF_MAC_CON2;
+	else
+		reg = RK3328_GRF_MAC_CON1;
 
-	if (rk_set_reg_speed_rmii(bsp_priv, &rk3328_reg_speed_data, reg, speed))
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+	return rk_set_reg_speed(bsp_priv, &rk3328_reg_speed_data, reg,
+				interface, speed);
 }
 
 static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
@@ -695,8 +630,7 @@ static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
 static const struct rk_gmac_ops rk3328_ops = {
 	.set_to_rgmii = rk3328_set_to_rgmii,
 	.set_to_rmii = rk3328_set_to_rmii,
-	.set_rgmii_speed = rk3328_set_rgmii_speed,
-	.set_rmii_speed = rk3328_set_rmii_speed,
+	.set_speed = rk3328_set_speed,
 	.integrated_phy_powerup = rk3328_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
 };
@@ -755,29 +689,17 @@ static const struct rk_reg_speed_data rk3366_reg_speed_data = {
 	.rmii_100 = RK3366_GMAC_RMII_CLK_25M | RK3366_GMAC_SPEED_100M,
 };
 
-static void rk3366_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rk3366_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface, int speed)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3366_reg_speed_data,
-				   RK3366_GRF_SOC_CON6, speed))
-		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-}
-
-static void rk3366_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
-{
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rmii(bsp_priv, &rk3366_reg_speed_data,
-				  RK3366_GRF_SOC_CON6, speed))
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+	return rk_set_reg_speed(bsp_priv, &rk3366_reg_speed_data,
+				RK3366_GRF_SOC_CON6, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3366_ops = {
 	.set_to_rgmii = rk3366_set_to_rgmii,
 	.set_to_rmii = rk3366_set_to_rmii,
-	.set_rgmii_speed = rk3366_set_rgmii_speed,
-	.set_rmii_speed = rk3366_set_rmii_speed,
+	.set_speed = rk3366_set_speed,
 };
 
 #define RK3368_GRF_SOC_CON15	0x043c
@@ -834,29 +756,17 @@ static const struct rk_reg_speed_data rk3368_reg_speed_data = {
 	.rmii_100 = RK3368_GMAC_RMII_CLK_25M | RK3368_GMAC_SPEED_100M,
 };
 
-static void rk3368_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rk3368_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface, int speed)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3368_reg_speed_data,
-				   RK3368_GRF_SOC_CON15, speed))
-		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-}
-
-static void rk3368_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
-{
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rmii(bsp_priv, &rk3368_reg_speed_data,
-				  RK3368_GRF_SOC_CON15, speed))
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+	return rk_set_reg_speed(bsp_priv, &rk3368_reg_speed_data,
+				RK3368_GRF_SOC_CON15, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3368_ops = {
 	.set_to_rgmii = rk3368_set_to_rgmii,
 	.set_to_rmii = rk3368_set_to_rmii,
-	.set_rgmii_speed = rk3368_set_rgmii_speed,
-	.set_rmii_speed = rk3368_set_rmii_speed,
+	.set_speed = rk3368_set_speed,
 };
 
 #define RK3399_GRF_SOC_CON5	0xc214
@@ -913,29 +823,17 @@ static const struct rk_reg_speed_data rk3399_reg_speed_data = {
 	.rmii_100 = RK3399_GMAC_RMII_CLK_25M | RK3399_GMAC_SPEED_100M,
 };
 
-static void rk3399_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rk3399_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface, int speed)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3399_reg_speed_data,
-				   RK3399_GRF_SOC_CON5, speed))
-		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-}
-
-static void rk3399_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
-{
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rmii(bsp_priv, &rk3399_reg_speed_data,
-				  RK3399_GRF_SOC_CON5, speed))
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+	return rk_set_reg_speed(bsp_priv, &rk3399_reg_speed_data,
+				RK3399_GRF_SOC_CON5, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3399_ops = {
 	.set_to_rgmii = rk3399_set_to_rgmii,
 	.set_to_rmii = rk3399_set_to_rmii,
-	.set_rgmii_speed = rk3399_set_rgmii_speed,
-	.set_rmii_speed = rk3399_set_rmii_speed,
+	.set_speed = rk3399_set_speed,
 };
 
 #define RK3528_VO_GRF_GMAC_CON		0x0018
@@ -1011,18 +909,9 @@ static const struct rk_reg_speed_data rk3528_gmac1_reg_speed_data = {
 	.rmii_100 = RK3528_GMAC1_CLK_RMII_DIV2,
 };
 
-static void rk3528_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rk3528_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface,int speed)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3528_gmac1_reg_speed_data,
-				   RK3528_VPU_GRF_GMAC_CON5, speed))
-		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-}
-
-static void rk3528_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
-{
-	struct device *dev = &bsp_priv->pdev->dev;
 	const struct rk_reg_speed_data *rsd;
 	unsigned int reg;
 
@@ -1034,8 +923,7 @@ static void rk3528_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 		reg = RK3528_VO_GRF_GMAC_CON;
 	}
 
-	if (rk_set_reg_speed_rmii(bsp_priv, rsd, reg, speed))
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+	return rk_set_reg_speed(bsp_priv, rsd, reg, interface, speed);
 }
 
 static void rk3528_set_clock_selection(struct rk_priv_data *bsp_priv,
@@ -1069,8 +957,7 @@ static void rk3528_integrated_phy_powerdown(struct rk_priv_data *bsp_priv)
 static const struct rk_gmac_ops rk3528_ops = {
 	.set_to_rgmii = rk3528_set_to_rgmii,
 	.set_to_rmii = rk3528_set_to_rmii,
-	.set_rgmii_speed = rk3528_set_rgmii_speed,
-	.set_rmii_speed = rk3528_set_rmii_speed,
+	.set_speed = rk3528_set_speed,
 	.set_clock_selection = rk3528_set_clock_selection,
 	.integrated_phy_powerup = rk3528_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk3528_integrated_phy_powerdown,
@@ -1135,8 +1022,7 @@ static void rk3568_set_to_rmii(struct rk_priv_data *bsp_priv)
 static const struct rk_gmac_ops rk3568_ops = {
 	.set_to_rgmii = rk3568_set_to_rgmii,
 	.set_to_rmii = rk3568_set_to_rmii,
-	.set_rgmii_speed = rk_set_clk_mac_speed,
-	.set_rmii_speed = rk_set_clk_mac_speed,
+	.set_speed = rk_set_clk_mac_speed,
 	.regs_valid = true,
 	.regs = {
 		0xfe2a0000, /* gmac0 */
@@ -1228,17 +1114,16 @@ static const struct rk_reg_speed_data rk3578_reg_speed_data = {
 	.rmii_100 = RK3576_GMAC_CLK_RMII_DIV2,
 };
 
-static void rk3576_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rk3576_set_gmac_speed(struct rk_priv_data *bsp_priv,
+				 phy_interface_t interface, int speed)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int offset_con;
 
 	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
 					 RK3576_GRF_GMAC_CON0;
 
-	if (rk_set_reg_speed(bsp_priv, &rk3578_reg_speed_data, offset_con,
-			     bsp_priv->phy_iface, speed))
-		dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
+	return rk_set_reg_speed(bsp_priv, &rk3578_reg_speed_data, offset_con,
+				interface, speed);
 }
 
 static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
@@ -1260,8 +1145,7 @@ static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input
 static const struct rk_gmac_ops rk3576_ops = {
 	.set_to_rgmii = rk3576_set_to_rgmii,
 	.set_to_rmii = rk3576_set_to_rmii,
-	.set_rgmii_speed = rk3576_set_gmac_speed,
-	.set_rmii_speed = rk3576_set_gmac_speed,
+	.set_speed = rk3576_set_gmac_speed,
 	.set_clock_selection = rk3576_set_clock_selection,
 	.php_grf_required = true,
 	.regs_valid = true,
@@ -1345,26 +1229,26 @@ static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3588_GMAC_CLK_RMII_MODE(bsp_priv->id));
 }
 
-static void rk3588_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rk3588_set_gmac_speed(struct rk_priv_data *bsp_priv,
+				 phy_interface_t interface, int speed)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int val = 0, id = bsp_priv->id;
 
 	switch (speed) {
 	case 10:
-		if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII)
+		if (interface == PHY_INTERFACE_MODE_RMII)
 			val = RK3588_GMA_CLK_RMII_DIV20(id);
 		else
 			val = RK3588_GMAC_CLK_RGMII_DIV50(id);
 		break;
 	case 100:
-		if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII)
+		if (interface == PHY_INTERFACE_MODE_RMII)
 			val = RK3588_GMA_CLK_RMII_DIV2(id);
 		else
 			val = RK3588_GMAC_CLK_RGMII_DIV5(id);
 		break;
 	case 1000:
-		if (bsp_priv->phy_iface != PHY_INTERFACE_MODE_RMII)
+		if (interface != PHY_INTERFACE_MODE_RMII)
 			val = RK3588_GMAC_CLK_RGMII_DIV1(id);
 		else
 			goto err;
@@ -1375,9 +1259,9 @@ static void rk3588_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
 
 	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1, val);
 
-	return;
+	return 0;
 err:
-	dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
+	return -EINVAL;
 }
 
 static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
@@ -1395,8 +1279,7 @@ static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input
 static const struct rk_gmac_ops rk3588_ops = {
 	.set_to_rgmii = rk3588_set_to_rgmii,
 	.set_to_rmii = rk3588_set_to_rmii,
-	.set_rgmii_speed = rk3588_set_gmac_speed,
-	.set_rmii_speed = rk3588_set_gmac_speed,
+	.set_speed = rk3588_set_gmac_speed,
 	.set_clock_selection = rk3588_set_clock_selection,
 	.php_grf_required = true,
 	.regs_valid = true,
@@ -1430,18 +1313,16 @@ static const struct rk_reg_speed_data rv1108_reg_speed_data = {
 	.rmii_100 = RV1108_GMAC_RMII_CLK_25M | RV1108_GMAC_SPEED_100M,
 };
 
-static void rv1108_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
+static int rv1108_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface, int speed)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (rk_set_reg_speed_rmii(bsp_priv, &rv1108_reg_speed_data,
-				  RV1108_GRF_GMAC_CON0, speed))
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+	return rk_set_reg_speed(bsp_priv, &rv1108_reg_speed_data,
+				RV1108_GRF_GMAC_CON0, interface, speed);
 }
 
 static const struct rk_gmac_ops rv1108_ops = {
 	.set_to_rmii = rv1108_set_to_rmii,
-	.set_rmii_speed = rv1108_set_rmii_speed,
+	.set_speed = rv1108_set_speed,
 };
 
 #define RV1126_GRF_GMAC_CON0		0X0070
@@ -1499,8 +1380,7 @@ static void rv1126_set_to_rmii(struct rk_priv_data *bsp_priv)
 static const struct rk_gmac_ops rv1126_ops = {
 	.set_to_rgmii = rv1126_set_to_rgmii,
 	.set_to_rmii = rv1126_set_to_rmii,
-	.set_rgmii_speed = rk_set_clk_mac_speed,
-	.set_rmii_speed = rk_set_clk_mac_speed,
+	.set_speed = rk_set_clk_mac_speed,
 };
 
 static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
@@ -1833,6 +1713,10 @@ static int rk_set_clk_tx_rate(void *bsp_priv_, struct clk *clk_tx_i,
 	struct rk_priv_data *bsp_priv = bsp_priv_;
 	struct device *dev = &bsp_priv->pdev->dev;
 
+	if (bsp_priv->ops->set_speed)
+		return bsp_priv->ops->set_speed(bsp_priv, bsp_priv->phy_iface,
+						speed);
+
 	switch (bsp_priv->phy_iface) {
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
-- 
2.30.2


