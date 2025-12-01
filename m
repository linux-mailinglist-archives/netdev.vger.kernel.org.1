Return-Path: <netdev+bounces-242992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B451C97EB6
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 15:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 351AE342F2E
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4737631A7E1;
	Mon,  1 Dec 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hu1ChD4S"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B5314B88
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600705; cv=none; b=JcAeozhroRppO+aKbtU+GrGcAFc++ZwXLZOjAWE+NDt4yvH505RTowFLZ9zR7JR1D8l+57AviTPfutyEvg+D8IXVPYmlsdwv++Cwx10oTEtwhJ20tW2HzZ5MWw3mpVBr3YVFJ5BkfMEyHTLHvzMQxDSQrvA5e2QTpT0vX/ABi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600705; c=relaxed/simple;
	bh=ZHgFuiKYjvF575lTeTSk29nDZWFqImHYnP8oL0DrYnE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=X292s7e94Uvd9VGk1aGopU2OFeq5QqAP4XS9IO0CNoUEfe6k69VZLiKmod8/ub4uExdjMH32oUAlIVa8V4tAAUSQkOi3x56lliAtXdAd3JNzUfvnzmHycw4smP0fjuIveoF6LmxykVyBwTzYu8hW1J0IYMK4OlvaO0VLw74w7LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hu1ChD4S; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qCyMrIwNIyOdbUbfZfgTtvVRVPXWkgng6fMj7jPQeq4=; b=hu1ChD4SmvwCBcmcEypJbxb/f7
	UE7llai0TkCwA1EZqwD/cXEstfizATTzDP8WKL3Zwj46S+Q4p6GRjxJ9KxmoB3LO0HsVrjRqpzEbi
	tIKq80InSw5mYXMLsK8q9SFCWmVJQ0giVPOw+TwTJKx4YenCrqMYUKu38hz+FDhEiVJm0pBoZcS4f
	nTcW23GhSXpaoM7JQYnsTgsTisBJhWgIp428v89JWK4ZDgmK3hn6+/Mv+/RaTUOb5TfbT/k/vrhdA
	dVlb/Lvrh3OvB4PjsdlZN3xLZsOcsckpKFDDFq9gQMS2u0payf/YgfcNtzHxXHDWimzh8U166QVPu
	TgoIuYzg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50460 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vQ5FH-000000000gi-3Cb6;
	Mon, 01 Dec 2025 14:51:20 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vQ5FG-0000000GNw5-2Apg;
	Mon, 01 Dec 2025 14:51:18 +0000
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
Subject: [PATCH RFC net-next 07/15] net: stmmac: rk: use rk_encode_wm16() for
 RGMII clocks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vQ5FG-0000000GNw5-2Apg@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 01 Dec 2025 14:51:18 +0000

As all of the RGMII clock selection bitfields (gmii_clk_sel) use the
same encoding, parameterise this by providing the bitfield mask in
the BSP private data.

One additional change is for RK3328 - as only gmac2io supports RGMII,
only initialise the mask for this instance.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 94 +++++++------------
 1 file changed, 32 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 2061ced12d6c..d11a58d7f24b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -27,9 +27,6 @@
 struct rk_priv_data;
 
 struct rk_reg_speed_data {
-	unsigned int rgmii_10;
-	unsigned int rgmii_100;
-	unsigned int rgmii_1000;
 	unsigned int rmii_10;
 	unsigned int rmii_100;
 };
@@ -51,6 +48,7 @@ struct rk_gmac_ops {
 	u16 rmii_mode_mask;
 
 	u16 speed_grf_reg;
+	u16 gmii_clk_sel_mask;
 
 	bool speed_reg_php_grf;
 	bool php_grf_required;
@@ -104,12 +102,24 @@ struct rk_priv_data {
 	u16 rmii_mode_mask;
 
 	u16 speed_grf_reg;
+	u16 gmii_clk_sel_mask;
 };
 
 #define GMAC_CLK_DIV1_125M		0
 #define GMAC_CLK_DIV50_2_5M		2
 #define GMAC_CLK_DIV5_25M		3
 
+static int rk_gmac_rgmii_clk_div(int speed)
+{
+	if (speed == SPEED_10)
+		return GMAC_CLK_DIV50_2_5M;
+	if (speed == SPEED_100)
+		return GMAC_CLK_DIV5_25M;
+	if (speed == SPEED_1000)
+		return GMAC_CLK_DIV1_125M;
+	return -EINVAL;
+}
+
 static int rk_get_phy_intf_sel(phy_interface_t interface)
 {
 	int ret = stmmac_get_phy_intf_sel(interface);
@@ -137,20 +147,14 @@ static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 {
 	struct regmap *regmap;
 	unsigned int val;
+	int ret;
 
 	if (phy_interface_mode_is_rgmii(interface)) {
-		if (speed == SPEED_10) {
-			val = rsd->rgmii_10;
-		} else if (speed == SPEED_100) {
-			val = rsd->rgmii_100;
-		} else if (speed == SPEED_1000) {
-			val = rsd->rgmii_1000;
-		} else {
-			/* Phylink will not allow inappropriate speeds for
-			 * interface modes, so this should never happen.
-			 */
-			return -EINVAL;
-		}
+		ret = rk_gmac_rgmii_clk_div(speed);
+		if (ret < 0)
+			return ret;
+
+		val = rk_encode_wm16(ret, bsp_priv->gmii_clk_sel_mask);
 	} else if (interface == PHY_INTERFACE_MODE_RMII) {
 		if (speed == SPEED_10) {
 			val = rsd->rmii_10;
@@ -341,7 +345,6 @@ static const struct rk_gmac_ops px30_ops = {
 #define RK3128_GMAC_SPEED_100M         GRF_BIT(10)
 #define RK3128_GMAC_RMII_CLK_25M       GRF_BIT(11)
 #define RK3128_GMAC_RMII_CLK_2_5M      GRF_CLR_BIT(11)
-#define RK3128_GMAC_CLK(val)           GRF_FIELD_CONST(13, 12, val)
 
 static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
@@ -357,9 +360,6 @@ static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3128_reg_speed_data = {
-	.rgmii_10 = RK3128_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3128_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3128_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3128_GMAC_RMII_CLK_2_5M | RK3128_GMAC_SPEED_10M,
 	.rmii_100 = RK3128_GMAC_RMII_CLK_25M | RK3128_GMAC_SPEED_100M,
 };
@@ -381,6 +381,7 @@ static const struct rk_gmac_ops rk3128_ops = {
 	.rmii_mode_mask = BIT_U16(14),
 
 	.speed_grf_reg = RK3128_GRF_MAC_CON1,
+	.gmii_clk_sel_mask = GENMASK_U16(13, 12),
 };
 
 #define RK3228_GRF_MAC_CON0	0x0900
@@ -399,7 +400,6 @@ static const struct rk_gmac_ops rk3128_ops = {
 #define RK3228_GMAC_SPEED_100M		GRF_BIT(2)
 #define RK3228_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3228_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
-#define RK3228_GMAC_CLK(val)		GRF_FIELD_CONST(9, 8, val)
 #define RK3228_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
 #define RK3228_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(0)
 #define RK3228_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(1)
@@ -426,9 +426,6 @@ static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3228_reg_speed_data = {
-	.rgmii_10 = RK3228_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3228_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3228_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3228_GMAC_RMII_CLK_2_5M | RK3228_GMAC_SPEED_10M,
 	.rmii_100 = RK3228_GMAC_RMII_CLK_25M | RK3228_GMAC_SPEED_100M,
 };
@@ -460,6 +457,7 @@ static const struct rk_gmac_ops rk3228_ops = {
 	.rmii_mode_mask = BIT_U16(10),
 
 	.speed_grf_reg = RK3228_GRF_MAC_CON1,
+	.gmii_clk_sel_mask = GENMASK_U16(9, 8),
 };
 
 #define RK3288_GRF_SOC_CON1	0x0248
@@ -472,7 +470,6 @@ static const struct rk_gmac_ops rk3228_ops = {
 #define RK3288_GMAC_SPEED_100M		GRF_BIT(10)
 #define RK3288_GMAC_RMII_CLK_25M	GRF_BIT(11)
 #define RK3288_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(11)
-#define RK3288_GMAC_CLK(val)		GRF_FIELD_CONST(13, 12, val)
 
 /*RK3288_GRF_SOC_CON3*/
 #define RK3288_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(14)
@@ -496,9 +493,6 @@ static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3288_reg_speed_data = {
-	.rgmii_10 = RK3288_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3288_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3288_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3288_GMAC_RMII_CLK_2_5M | RK3288_GMAC_SPEED_10M,
 	.rmii_100 = RK3288_GMAC_RMII_CLK_25M | RK3288_GMAC_SPEED_100M,
 };
@@ -520,6 +514,7 @@ static const struct rk_gmac_ops rk3288_ops = {
 	.rmii_mode_mask = BIT_U16(14),
 
 	.speed_grf_reg = RK3288_GRF_SOC_CON1,
+	.gmii_clk_sel_mask = GENMASK_U16(13, 12),
 };
 
 #define RK3308_GRF_MAC_CON0		0x04a0
@@ -572,7 +567,6 @@ static const struct rk_gmac_ops rk3308_ops = {
 #define RK3328_GMAC_SPEED_100M		GRF_BIT(2)
 #define RK3328_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3328_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
-#define RK3328_GMAC_CLK(val)		GRF_FIELD_CONST(12, 11, val)
 #define RK3328_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
 #define RK3328_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(1)
 
@@ -585,6 +579,7 @@ static int rk3328_init(struct rk_priv_data *bsp_priv)
 	case 0: /* gmac2io */
 		bsp_priv->phy_intf_sel_grf_reg = RK3328_GRF_MAC_CON1;
 		bsp_priv->speed_grf_reg = RK3328_GRF_MAC_CON1;
+		bsp_priv->gmii_clk_sel_mask = GENMASK_U16(12, 11);
 		return 0;
 
 	case 1: /* gmac2phy */
@@ -614,9 +609,6 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3328_reg_speed_data = {
-	.rgmii_10 = RK3328_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3328_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3328_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3328_GMAC_RMII_CLK_2_5M | RK3328_GMAC_SPEED_10M,
 	.rmii_100 = RK3328_GMAC_RMII_CLK_25M | RK3328_GMAC_SPEED_100M,
 };
@@ -665,7 +657,6 @@ static const struct rk_gmac_ops rk3328_ops = {
 #define RK3366_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3366_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3366_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3366_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
 
 /* RK3366_GRF_SOC_CON7 */
 #define RK3366_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -689,9 +680,6 @@ static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3366_reg_speed_data = {
-	.rgmii_10 = RK3366_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3366_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3366_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3366_GMAC_RMII_CLK_2_5M | RK3366_GMAC_SPEED_10M,
 	.rmii_100 = RK3366_GMAC_RMII_CLK_25M | RK3366_GMAC_SPEED_100M,
 };
@@ -713,6 +701,7 @@ static const struct rk_gmac_ops rk3366_ops = {
 	.rmii_mode_mask = BIT_U16(6),
 
 	.speed_grf_reg = RK3366_GRF_SOC_CON6,
+	.gmii_clk_sel_mask = GENMASK_U16(5, 4),
 };
 
 #define RK3368_GRF_SOC_CON15	0x043c
@@ -725,7 +714,6 @@ static const struct rk_gmac_ops rk3366_ops = {
 #define RK3368_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3368_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3368_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3368_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
 
 /* RK3368_GRF_SOC_CON16 */
 #define RK3368_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -749,9 +737,6 @@ static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3368_reg_speed_data = {
-	.rgmii_10 = RK3368_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3368_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3368_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3368_GMAC_RMII_CLK_2_5M | RK3368_GMAC_SPEED_10M,
 	.rmii_100 = RK3368_GMAC_RMII_CLK_25M | RK3368_GMAC_SPEED_100M,
 };
@@ -773,6 +758,7 @@ static const struct rk_gmac_ops rk3368_ops = {
 	.rmii_mode_mask = BIT_U16(6),
 
 	.speed_grf_reg = RK3368_GRF_SOC_CON15,
+	.gmii_clk_sel_mask = GENMASK_U16(5, 4),
 };
 
 #define RK3399_GRF_SOC_CON5	0xc214
@@ -785,7 +771,6 @@ static const struct rk_gmac_ops rk3368_ops = {
 #define RK3399_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3399_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3399_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3399_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
 
 /* RK3399_GRF_SOC_CON6 */
 #define RK3399_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -809,9 +794,6 @@ static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3399_reg_speed_data = {
-	.rgmii_10 = RK3399_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3399_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3399_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3399_GMAC_RMII_CLK_2_5M | RK3399_GMAC_SPEED_10M,
 	.rmii_100 = RK3399_GMAC_RMII_CLK_25M | RK3399_GMAC_SPEED_100M,
 };
@@ -833,6 +815,7 @@ static const struct rk_gmac_ops rk3399_ops = {
 	.rmii_mode_mask = BIT_U16(6),
 
 	.speed_grf_reg = RK3399_GRF_SOC_CON5,
+	.gmii_clk_sel_mask = GENMASK_U16(5, 4),
 };
 
 #define RK3506_GRF_SOC_CON8		0x0020
@@ -938,8 +921,6 @@ static const struct rk_gmac_ops rk3506_ops = {
 #define RK3528_GMAC1_CLK_RMII_DIV2	GRF_BIT(10)
 #define RK3528_GMAC1_CLK_RMII_DIV20	GRF_CLR_BIT(10)
 
-#define RK3528_GMAC1_CLK_RGMII(val)	GRF_FIELD_CONST(11, 10, val)
-
 #define RK3528_GMAC0_CLK_RMII_GATE	GRF_BIT(2)
 #define RK3528_GMAC0_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
 #define RK3528_GMAC1_CLK_RMII_GATE	GRF_BIT(9)
@@ -954,6 +935,7 @@ static int rk3528_init(struct rk_priv_data *bsp_priv)
 
 	case 1:
 		bsp_priv->speed_grf_reg = RK3528_VPU_GRF_GMAC_CON5;
+		bsp_priv->gmii_clk_sel_mask = GENMASK_U16(11, 10);
 		return 0;
 
 	default:
@@ -992,9 +974,6 @@ static const struct rk_reg_speed_data rk3528_gmac0_reg_speed_data = {
 };
 
 static const struct rk_reg_speed_data rk3528_gmac1_reg_speed_data = {
-	.rgmii_10 = RK3528_GMAC1_CLK_RGMII(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3528_GMAC1_CLK_RGMII(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3528_GMAC1_CLK_RGMII(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3528_GMAC1_CLK_RMII_DIV20,
 	.rmii_100 = RK3528_GMAC1_CLK_RMII_DIV2,
 };
@@ -1152,8 +1131,6 @@ static const struct rk_gmac_ops rk3568_ops = {
 #define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
 #define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
 
-#define RK3576_GMAC_CLK_RGMII(val)		GRF_FIELD_CONST(6, 5, val)
-
 #define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
 #define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
 
@@ -1203,9 +1180,6 @@ static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3578_reg_speed_data = {
-	.rgmii_10 = RK3576_GMAC_CLK_RGMII(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3576_GMAC_CLK_RGMII(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3576_GMAC_CLK_RGMII(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3576_GMAC_CLK_RMII_DIV20,
 	.rmii_100 = RK3576_GMAC_CLK_RMII_DIV2,
 };
@@ -1242,6 +1216,8 @@ static const struct rk_gmac_ops rk3576_ops = {
 
 	.rmii_mode_mask = BIT_U16(3),
 
+	.gmii_clk_sel_mask = GENMASK_U16(6, 5),
+
 	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
@@ -1277,9 +1253,6 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GMA_CLK_RMII_DIV2(id)		GRF_BIT(5 * (id) + 2)
 #define RK3588_GMA_CLK_RMII_DIV20(id)		GRF_CLR_BIT(5 * (id) + 2)
 
-#define RK3588_GMAC_CLK_RGMII(id, val)		\
-	(GRF_FIELD_CONST(3, 2, val) << ((id) * 5))
-
 #define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
 #define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
 
@@ -1288,10 +1261,12 @@ static int rk3588_init(struct rk_priv_data *bsp_priv)
 	switch (bsp_priv->id) {
 	case 0:
 		bsp_priv->phy_intf_sel_mask = GENMASK_U16(5, 3);
+		bsp_priv->gmii_clk_sel_mask = GENMASK_U16(3, 2);
 		return 0;
 
 	case 1:
 		bsp_priv->phy_intf_sel_mask = GENMASK_U16(11, 9);
+		bsp_priv->gmii_clk_sel_mask = GENMASK_U16(8, 7);
 		return 0;
 
 	default:
@@ -1326,17 +1301,11 @@ static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3588_gmac0_speed_data = {
-	.rgmii_10 = RK3588_GMAC_CLK_RGMII(0, GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3588_GMAC_CLK_RGMII(0, GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3588_GMAC_CLK_RGMII(0, GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3588_GMA_CLK_RMII_DIV20(0),
 	.rmii_100 = RK3588_GMA_CLK_RMII_DIV2(0),
 };
 
 static const struct rk_reg_speed_data rk3588_gmac1_speed_data = {
-	.rgmii_10 = RK3588_GMAC_CLK_RGMII(1, GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3588_GMAC_CLK_RGMII(1, GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3588_GMAC_CLK_RGMII(1, GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3588_GMA_CLK_RMII_DIV20(1),
 	.rmii_100 = RK3588_GMA_CLK_RMII_DIV2(1),
 };
@@ -1702,6 +1671,7 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 
 	/* Set the default speed related parameters */
 	bsp_priv->speed_grf_reg = ops->speed_grf_reg;
+	bsp_priv->gmii_clk_sel_mask = ops->gmii_clk_sel_mask;
 
 	if (ops->init) {
 		ret = ops->init(bsp_priv);
-- 
2.47.3


