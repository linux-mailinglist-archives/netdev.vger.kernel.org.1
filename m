Return-Path: <netdev+bounces-242994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30536C97EC8
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 15:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F033343257
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC131A7E1;
	Mon,  1 Dec 2025 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PqZfowaP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7D31A7F4
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600738; cv=none; b=Gb7/BcVMDDqwKDaHrHkCAWc6+Z46E+cyJtVUEDHTv7DdMlmImffL5q7nBX0DNxZnvLrlad36h8BidyVzJRy48uIks2+nbki3inrR9tQSV7CYvsjoYnUtrz7VZsj06f6a/hdQP1cK6++RFew/XfiloS8dF+K4o5NXbL6hRKB0718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600738; c=relaxed/simple;
	bh=aKZxJ02mIrZDdi+/m142jrDrxjwlQ6Wmr2bkMg26O5M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=oMCbatG4NQUckYqzOtHcL6F3cqGFXrdswxJ65lCXt9tqVAEU+TSIpN0haFD+liQPjO/4j6YoF+ugfwdCJpV9B7w2UyfEI82OF6GVqSjvLWXP//hsyb4h1Q9b+FyojakUIHf2h9FmHHKnGgdpcZwG2gIh9yEHCODwcmFyaWKwk7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PqZfowaP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hN5LfiaXy1wS8FdTenG4/KweLcBLPklg3ZhrE3ISNGk=; b=PqZfowaPE+XUOsFloaio0is979
	ey2SbBCv79tEQRxlus/HHu72NXnBJRVzwhr51f0LOuEaIQLrsod28CMrCB4+sCN93njPgYIObGyQp
	Wy1r8i9mW8uEZBVOX7ZVt8ylPubMAW6VVTipMZq49vVX39y9TTTUSI8QSgc757CftisriFA4Dxmf0
	LOi/1iILyTIIfRyYcx2KWUAPJksG78na3LQLHET/E9Plcg1wGtufph34FkEMmGFvmNvhSQ8D2Y0D4
	VbtywUnJH4Y9j15swr4zUm7iceVW9TdK4xR8rIHTDGORekwyqyXnNttA1VRaZ1MbNJ0oCwUAtE7RQ
	xo2y5URg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60510 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vQ5FS-000000000hJ-1Xhv;
	Mon, 01 Dec 2025 14:51:30 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vQ5FQ-0000000GNwH-37za;
	Mon, 01 Dec 2025 14:51:28 +0000
In-Reply-To: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 09/15] net: stmmac: rk: use rk_encode_wm16() for
 RMII clock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vQ5FQ-0000000GNwH-37za@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 01 Dec 2025 14:51:28 +0000

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 187 ++++--------------
 1 file changed, 34 insertions(+), 153 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 5f586782d595..a77ce36e0da6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -26,11 +26,6 @@
 
 struct rk_priv_data;
 
-struct rk_reg_speed_data {
-	unsigned int rmii_10;
-	unsigned int rmii_100;
-};
-
 struct rk_gmac_ops {
 	int (*init)(struct rk_priv_data *bsp_priv);
 	void (*set_to_rgmii)(struct rk_priv_data *bsp_priv,
@@ -49,6 +44,7 @@ struct rk_gmac_ops {
 
 	u16 speed_grf_reg;
 	u16 gmii_clk_sel_mask;
+	u16 rmii_clk_sel_mask;
 	u16 mac_speed_mask;
 
 	bool speed_reg_php_grf;
@@ -104,6 +100,7 @@ struct rk_priv_data {
 
 	u16 speed_grf_reg;
 	u16 gmii_clk_sel_mask;
+	u16 rmii_clk_sel_mask;
 	u16 mac_speed_mask;
 };
 
@@ -144,7 +141,6 @@ static u32 rk_encode_wm16(u16 val, u16 mask)
 }
 
 static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
-			    const struct rk_reg_speed_data *rsd,
 			    phy_interface_t interface, int speed)
 {
 	struct regmap *regmap;
@@ -159,17 +155,9 @@ static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 		val = rk_encode_wm16(ret, bsp_priv->gmii_clk_sel_mask);
 	} else if (interface == PHY_INTERFACE_MODE_RMII) {
 		val = rk_encode_wm16(speed == SPEED_100,
-				     bsp_priv->mac_speed_mask);
-		if (speed == SPEED_10) {
-			val |= rsd->rmii_10;
-		} else if (speed == SPEED_100) {
-			val |= rsd->rmii_100;
-		} else {
-			/* Phylink will not allow inappropriate speeds for
-			 * interface modes, so this should never happen.
-			 */
-			return -EINVAL;
-		}
+				     bsp_priv->mac_speed_mask) |
+		      rk_encode_wm16(speed == SPEED_100,
+				     bsp_priv->rmii_clk_sel_mask);
 	} else {
 		/* This should never happen, as .get_interfaces() limits
 		 * the interface modes that are supported to RGMII and/or
@@ -345,8 +333,6 @@ static const struct rk_gmac_ops px30_ops = {
 /* RK3128_GRF_MAC_CON1 */
 #define RK3128_GMAC_FLOW_CTRL          GRF_BIT(9)
 #define RK3128_GMAC_FLOW_CTRL_CLR      GRF_CLR_BIT(9)
-#define RK3128_GMAC_RMII_CLK_25M       GRF_BIT(11)
-#define RK3128_GMAC_RMII_CLK_2_5M      GRF_CLR_BIT(11)
 
 static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
@@ -361,16 +347,10 @@ static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3128_reg_speed_data = {
-	.rmii_10 = RK3128_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3128_GMAC_RMII_CLK_25M,
-};
-
 static int rk3128_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3128_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3128_ops = {
@@ -384,6 +364,7 @@ static const struct rk_gmac_ops rk3128_ops = {
 
 	.speed_grf_reg = RK3128_GRF_MAC_CON1,
 	.gmii_clk_sel_mask = GENMASK_U16(13, 12),
+	.rmii_clk_sel_mask = BIT_U16(11),
 	.mac_speed_mask = BIT_U16(10),
 };
 
@@ -399,8 +380,6 @@ static const struct rk_gmac_ops rk3128_ops = {
 /* RK3228_GRF_MAC_CON1 */
 #define RK3228_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3228_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RK3228_GMAC_RMII_CLK_25M	GRF_BIT(7)
-#define RK3228_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 #define RK3228_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
 #define RK3228_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(0)
 #define RK3228_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(1)
@@ -426,16 +405,10 @@ static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1, GRF_BIT(11));
 }
 
-static const struct rk_reg_speed_data rk3228_reg_speed_data = {
-	.rmii_10 = RK3228_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3228_GMAC_RMII_CLK_25M,
-};
-
 static int rk3228_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3228_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static void rk3228_integrated_phy_powerup(struct rk_priv_data *priv)
@@ -459,6 +432,7 @@ static const struct rk_gmac_ops rk3228_ops = {
 
 	.speed_grf_reg = RK3228_GRF_MAC_CON1,
 	.gmii_clk_sel_mask = GENMASK_U16(9, 8),
+	.rmii_clk_sel_mask = BIT_U16(7),
 	.mac_speed_mask = BIT_U16(2),
 };
 
@@ -468,8 +442,6 @@ static const struct rk_gmac_ops rk3228_ops = {
 /*RK3288_GRF_SOC_CON1*/
 #define RK3288_GMAC_FLOW_CTRL		GRF_BIT(9)
 #define RK3288_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(9)
-#define RK3288_GMAC_RMII_CLK_25M	GRF_BIT(11)
-#define RK3288_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(11)
 
 /*RK3288_GRF_SOC_CON3*/
 #define RK3288_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(14)
@@ -492,16 +464,10 @@ static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3288_reg_speed_data = {
-	.rmii_10 = RK3288_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3288_GMAC_RMII_CLK_25M,
-};
-
 static int rk3288_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3288_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3288_ops = {
@@ -515,6 +481,7 @@ static const struct rk_gmac_ops rk3288_ops = {
 
 	.speed_grf_reg = RK3288_GRF_SOC_CON1,
 	.gmii_clk_sel_mask = GENMASK_U16(13, 12),
+	.rmii_clk_sel_mask = BIT_U16(11),
 	.mac_speed_mask = BIT_U16(10),
 };
 
@@ -561,8 +528,6 @@ static const struct rk_gmac_ops rk3308_ops = {
 /* RK3328_GRF_MAC_CON1 */
 #define RK3328_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3328_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RK3328_GMAC_RMII_CLK_25M	GRF_BIT(7)
-#define RK3328_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 #define RK3328_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
 #define RK3328_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(1)
 
@@ -604,16 +569,10 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3328_reg_speed_data = {
-	.rmii_10 = RK3328_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3328_GMAC_RMII_CLK_25M,
-};
-
 static int rk3328_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3328_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
@@ -635,6 +594,7 @@ static const struct rk_gmac_ops rk3328_ops = {
 	.phy_intf_sel_mask = GENMASK_U16(6, 4),
 	.rmii_mode_mask = BIT_U16(9),
 
+	.rmii_clk_sel_mask = BIT_U16(7),
 	.mac_speed_mask = BIT_U16(2),
 
 	.regs_valid = true,
@@ -651,8 +611,6 @@ static const struct rk_gmac_ops rk3328_ops = {
 /* RK3366_GRF_SOC_CON6 */
 #define RK3366_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3366_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
-#define RK3366_GMAC_RMII_CLK_25M	GRF_BIT(3)
-#define RK3366_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 
 /* RK3366_GRF_SOC_CON7 */
 #define RK3366_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -675,16 +633,10 @@ static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3366_reg_speed_data = {
-	.rmii_10 = RK3366_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3366_GMAC_RMII_CLK_25M,
-};
-
 static int rk3366_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3366_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3366_ops = {
@@ -698,6 +650,7 @@ static const struct rk_gmac_ops rk3366_ops = {
 
 	.speed_grf_reg = RK3366_GRF_SOC_CON6,
 	.gmii_clk_sel_mask = GENMASK_U16(5, 4),
+	.rmii_clk_sel_mask = BIT_U16(3),
 	.mac_speed_mask = BIT_U16(7),
 };
 
@@ -707,8 +660,6 @@ static const struct rk_gmac_ops rk3366_ops = {
 /* RK3368_GRF_SOC_CON15 */
 #define RK3368_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3368_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
-#define RK3368_GMAC_RMII_CLK_25M	GRF_BIT(3)
-#define RK3368_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 
 /* RK3368_GRF_SOC_CON16 */
 #define RK3368_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -731,16 +682,10 @@ static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3368_reg_speed_data = {
-	.rmii_10 = RK3368_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3368_GMAC_RMII_CLK_25M,
-};
-
 static int rk3368_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3368_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3368_ops = {
@@ -754,6 +699,7 @@ static const struct rk_gmac_ops rk3368_ops = {
 
 	.speed_grf_reg = RK3368_GRF_SOC_CON15,
 	.gmii_clk_sel_mask = GENMASK_U16(5, 4),
+	.rmii_clk_sel_mask = BIT_U16(3),
 	.mac_speed_mask = BIT_U16(7),
 };
 
@@ -763,8 +709,6 @@ static const struct rk_gmac_ops rk3368_ops = {
 /* RK3399_GRF_SOC_CON5 */
 #define RK3399_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3399_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
-#define RK3399_GMAC_RMII_CLK_25M	GRF_BIT(3)
-#define RK3399_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 
 /* RK3399_GRF_SOC_CON6 */
 #define RK3399_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -787,16 +731,10 @@ static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3399_reg_speed_data = {
-	.rmii_10 = RK3399_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3399_GMAC_RMII_CLK_25M,
-};
-
 static int rk3399_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3399_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3399_ops = {
@@ -810,6 +748,7 @@ static const struct rk_gmac_ops rk3399_ops = {
 
 	.speed_grf_reg = RK3399_GRF_SOC_CON5,
 	.gmii_clk_sel_mask = GENMASK_U16(5, 4),
+	.rmii_clk_sel_mask = BIT_U16(3),
 	.mac_speed_mask = BIT_U16(7),
 };
 
@@ -818,9 +757,6 @@ static const struct rk_gmac_ops rk3399_ops = {
 
 #define RK3506_GMAC_RMII_MODE		GRF_BIT(1)
 
-#define RK3506_GMAC_CLK_RMII_DIV2	GRF_BIT(3)
-#define RK3506_GMAC_CLK_RMII_DIV20	GRF_CLR_BIT(3)
-
 #define RK3506_GMAC_CLK_SELECT_CRU	GRF_CLR_BIT(5)
 #define RK3506_GMAC_CLK_SELECT_IO	GRF_BIT(5)
 
@@ -851,16 +787,10 @@ static void rk3506_set_to_rmii(struct rk_priv_data *bsp_priv)
 	regmap_write(bsp_priv->grf, offset, RK3506_GMAC_RMII_MODE);
 }
 
-static const struct rk_reg_speed_data rk3506_reg_speed_data = {
-	.rmii_10 = RK3506_GMAC_CLK_RMII_DIV20,
-	.rmii_100 = RK3506_GMAC_CLK_RMII_DIV2,
-};
-
 static int rk3506_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3506_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static void rk3506_set_clock_selection(struct rk_priv_data *bsp_priv,
@@ -882,6 +812,9 @@ static const struct rk_gmac_ops rk3506_ops = {
 	.set_to_rmii = rk3506_set_to_rmii,
 	.set_speed = rk3506_set_speed,
 	.set_clock_selection = rk3506_set_clock_selection,
+
+	.rmii_clk_sel_mask = BIT_U16(3),
+
 	.regs_valid = true,
 	.regs = {
 		0xff4c8000, /* gmac0 */
@@ -911,11 +844,6 @@ static const struct rk_gmac_ops rk3506_ops = {
 #define RK3528_GMAC1_CLK_SELECT_CRU	GRF_CLR_BIT(12)
 #define RK3528_GMAC1_CLK_SELECT_IO	GRF_BIT(12)
 
-#define RK3528_GMAC0_CLK_RMII_DIV2	GRF_BIT(3)
-#define RK3528_GMAC0_CLK_RMII_DIV20	GRF_CLR_BIT(3)
-#define RK3528_GMAC1_CLK_RMII_DIV2	GRF_BIT(10)
-#define RK3528_GMAC1_CLK_RMII_DIV20	GRF_CLR_BIT(10)
-
 #define RK3528_GMAC0_CLK_RMII_GATE	GRF_BIT(2)
 #define RK3528_GMAC0_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
 #define RK3528_GMAC1_CLK_RMII_GATE	GRF_BIT(9)
@@ -926,11 +854,13 @@ static int rk3528_init(struct rk_priv_data *bsp_priv)
 	switch (bsp_priv->id) {
 	case 0:
 		bsp_priv->speed_grf_reg = RK3528_VO_GRF_GMAC_CON;
+		bsp_priv->rmii_clk_sel_mask = BIT_U16(3);
 		return 0;
 
 	case 1:
 		bsp_priv->speed_grf_reg = RK3528_VPU_GRF_GMAC_CON5;
 		bsp_priv->gmii_clk_sel_mask = GENMASK_U16(11, 10);
+		bsp_priv->rmii_clk_sel_mask = BIT_U16(10);
 		return 0;
 
 	default:
@@ -963,27 +893,10 @@ static void rk3528_set_to_rmii(struct rk_priv_data *bsp_priv)
 			     RK3528_GMAC0_CLK_RMII_DIV2);
 }
 
-static const struct rk_reg_speed_data rk3528_gmac0_reg_speed_data = {
-	.rmii_10 = RK3528_GMAC0_CLK_RMII_DIV20,
-	.rmii_100 = RK3528_GMAC0_CLK_RMII_DIV2,
-};
-
-static const struct rk_reg_speed_data rk3528_gmac1_reg_speed_data = {
-	.rmii_10 = RK3528_GMAC1_CLK_RMII_DIV20,
-	.rmii_100 = RK3528_GMAC1_CLK_RMII_DIV2,
-};
-
 static int rk3528_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	const struct rk_reg_speed_data *rsd;
-
-	if (bsp_priv->id == 1)
-		rsd = &rk3528_gmac1_reg_speed_data;
-	else
-		rsd = &rk3528_gmac0_reg_speed_data;
-
-	return rk_set_reg_speed(bsp_priv, rsd, interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static void rk3528_set_clock_selection(struct rk_priv_data *bsp_priv,
@@ -1123,9 +1036,6 @@ static const struct rk_gmac_ops rk3568_ops = {
 #define RK3576_GMAC_CLK_SELECT_IO		GRF_BIT(7)
 #define RK3576_GMAC_CLK_SELECT_CRU		GRF_CLR_BIT(7)
 
-#define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
-#define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
-
 #define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
 #define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
 
@@ -1174,16 +1084,10 @@ static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3578_reg_speed_data = {
-	.rmii_10 = RK3576_GMAC_CLK_RMII_DIV20,
-	.rmii_100 = RK3576_GMAC_CLK_RMII_DIV2,
-};
-
 static int rk3576_set_gmac_speed(struct rk_priv_data *bsp_priv,
 				 phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3578_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
@@ -1212,6 +1116,7 @@ static const struct rk_gmac_ops rk3576_ops = {
 	.rmii_mode_mask = BIT_U16(3),
 
 	.gmii_clk_sel_mask = GENMASK_U16(6, 5),
+	.rmii_clk_sel_mask = BIT_U16(5),
 
 	.php_grf_required = true,
 	.regs_valid = true,
@@ -1245,9 +1150,6 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GMAC_CLK_SELECT_CRU(id)		GRF_BIT(5 * (id) + 4)
 #define RK3588_GMAC_CLK_SELECT_IO(id)		GRF_CLR_BIT(5 * (id) + 4)
 
-#define RK3588_GMA_CLK_RMII_DIV2(id)		GRF_BIT(5 * (id) + 2)
-#define RK3588_GMA_CLK_RMII_DIV20(id)		GRF_CLR_BIT(5 * (id) + 2)
-
 #define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
 #define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
 
@@ -1257,11 +1159,13 @@ static int rk3588_init(struct rk_priv_data *bsp_priv)
 	case 0:
 		bsp_priv->phy_intf_sel_mask = GENMASK_U16(5, 3);
 		bsp_priv->gmii_clk_sel_mask = GENMASK_U16(3, 2);
+		bsp_priv->rmii_clk_sel_mask = BIT_U16(2);
 		return 0;
 
 	case 1:
 		bsp_priv->phy_intf_sel_mask = GENMASK_U16(11, 9);
 		bsp_priv->gmii_clk_sel_mask = GENMASK_U16(8, 7);
+		bsp_priv->rmii_clk_sel_mask = BIT_U16(7);
 		return 0;
 
 	default:
@@ -1295,27 +1199,10 @@ static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3588_GMAC_CLK_RMII_MODE(bsp_priv->id));
 }
 
-static const struct rk_reg_speed_data rk3588_gmac0_speed_data = {
-	.rmii_10 = RK3588_GMA_CLK_RMII_DIV20(0),
-	.rmii_100 = RK3588_GMA_CLK_RMII_DIV2(0),
-};
-
-static const struct rk_reg_speed_data rk3588_gmac1_speed_data = {
-	.rmii_10 = RK3588_GMA_CLK_RMII_DIV20(1),
-	.rmii_100 = RK3588_GMA_CLK_RMII_DIV2(1),
-};
-
 static int rk3588_set_gmac_speed(struct rk_priv_data *bsp_priv,
 				 phy_interface_t interface, int speed)
 {
-	const struct rk_reg_speed_data *rsd;
-
-	if (bsp_priv->id == 0)
-		rsd = &rk3588_gmac0_speed_data;
-	else
-		rsd = &rk3588_gmac1_speed_data;
-
-	return rk_set_reg_speed(bsp_priv, rsd, interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
@@ -1356,23 +1243,15 @@ static const struct rk_gmac_ops rk3588_ops = {
 /* RV1108_GRF_GMAC_CON0 */
 #define RV1108_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RV1108_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RV1108_GMAC_RMII_CLK_25M	GRF_BIT(7)
-#define RV1108_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 
 static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rv1108_reg_speed_data = {
-	.rmii_10 = RV1108_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RV1108_GMAC_RMII_CLK_25M,
-};
-
 static int rv1108_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rv1108_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rv1108_ops = {
@@ -1383,6 +1262,7 @@ static const struct rk_gmac_ops rv1108_ops = {
 	.phy_intf_sel_mask = GENMASK_U16(6, 4),
 
 	.speed_grf_reg = RV1108_GRF_GMAC_CON0,
+	.rmii_clk_sel_mask = BIT_U16(7),
 	.mac_speed_mask = BIT_U16(2),
 };
 
@@ -1666,6 +1546,7 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 	/* Set the default speed related parameters */
 	bsp_priv->speed_grf_reg = ops->speed_grf_reg;
 	bsp_priv->gmii_clk_sel_mask = ops->gmii_clk_sel_mask;
+	bsp_priv->rmii_clk_sel_mask = ops->rmii_clk_sel_mask;
 	bsp_priv->mac_speed_mask = ops->mac_speed_mask;
 
 	if (ops->init) {
-- 
2.47.3


