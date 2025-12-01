Return-Path: <netdev+bounces-242990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E80E9C97EAA
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 15:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A6FC342CF7
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 14:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA9E31A07B;
	Mon,  1 Dec 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mhHxQsKZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865893101A7
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600686; cv=none; b=e4F6Zj/vMIs5FJvm3p+iikxVVmsS6a7umaBoVHTZEt6pEIwsNRUjfXwS77BKz7RNgLPcksOerq6RDWtde3aZ54Ooc9aOnNXSAgMhlF5jyughST9QxRCwEgoLsFe86t81SJ9pBTkmYdrSYhdc8yGvpcFGWmmGgJPWukL3GXtFBys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600686; c=relaxed/simple;
	bh=5llHd/xsdNK+mxaLzj58boKxqoJqDBfBJk5Rmb8HQJE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pIuN+x3NSfUSotYR+OArr+vfFR6L78M54QGWeupmVx1SDUSVL/3jD07jom3mlMqZRrpEQrreUETL7rvwMzJrNe2NZ76HoMuMT9qyuyf36EJ8D6aca3PJFhmXT4s6fB1qmLMhhhQtwHa3nkB+v6i6to//NH+9qB/5l5tmZ6YqtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mhHxQsKZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2hE/ryqAJ/N06gaapnF4bpH3g38OsHzgIDzgJPBByBI=; b=mhHxQsKZaCI0rATUhSK3kuJSMM
	3FeW6ICt83OxoPfwJdRJq6Diyh4rCLZDAx32k+xad9T0Mk7XWIyGvHR7CmSv/j6s1NQNMzFpIVYAG
	Un6TzeGmEDS/gpb3PF8lD6GeqHYC2l74MAK83OOukqAGgK3SNV/xYTp6XeDMKqY7R3O1CpuY46nhn
	dlTAlrtrFnB+Du7DzB04Vkuv1zVAun8D8ivyZeMAackk6OeJ8swVkzKokn/bM6qVsV/xTdiYs/Qaf
	JwNw63el6L4QAXVn1xQvgqUMrWQTMZvMxJsVQTkMPIRnhOwSpQ/JjrdQBdBpHj1vLgCBD/fBpBQ9Z
	kqMllaWA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50946 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vQ5F7-000000000g6-3P0o;
	Mon, 01 Dec 2025 14:51:10 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vQ5F6-0000000GNvt-0nam;
	Mon, 01 Dec 2025 14:51:08 +0000
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
Subject: [PATCH RFC net-next 05/15] net: stmmac: rk: move speed GRF register
 offset to private data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vQ5F6-0000000GNvt-0nam@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 01 Dec 2025 14:51:08 +0000

Move the speed/clocking related GRF register offset into the driver
private data, convert rk_set_reg_speed() to use it and initialise this
member either from the corresponding member in struct rk_gmac_ops, or
the SoC specific initialisation function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 109 ++++++++++++------
 1 file changed, 76 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 369792b62c5e..e2c5bfbeadc5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -50,6 +50,8 @@ struct rk_gmac_ops {
 	u16 phy_intf_sel_mask;
 	u16 rmii_mode_mask;
 
+	u16 speed_grf_reg;
+
 	bool php_grf_required;
 	bool regs_valid;
 	u32 regs[];
@@ -99,6 +101,8 @@ struct rk_priv_data {
 	u16 phy_intf_sel_grf_reg;
 	u16 phy_intf_sel_mask;
 	u16 rmii_mode_mask;
+
+	u16 speed_grf_reg;
 };
 
 #define GMAC_CLK_DIV1_125M		0
@@ -128,8 +132,7 @@ static u32 rk_encode_wm16(u16 val, u16 mask)
 
 static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 			    const struct rk_reg_speed_data *rsd,
-			    unsigned int reg, phy_interface_t interface,
-			    int speed)
+			    phy_interface_t interface, int speed)
 {
 	unsigned int val;
 
@@ -165,7 +168,7 @@ static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 		return -EINVAL;
 	}
 
-	regmap_write(bsp_priv->grf, reg, val);
+	regmap_write(bsp_priv->grf, bsp_priv->speed_grf_reg, val);
 
 	return 0;
 
@@ -358,7 +361,7 @@ static int rk3128_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3128_reg_speed_data,
-				RK3128_GRF_MAC_CON1, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rk3128_ops = {
@@ -369,6 +372,8 @@ static const struct rk_gmac_ops rk3128_ops = {
 	.phy_intf_sel_grf_reg = RK3128_GRF_MAC_CON1,
 	.phy_intf_sel_mask = GENMASK_U16(8, 6),
 	.rmii_mode_mask = BIT_U16(14),
+
+	.speed_grf_reg = RK3128_GRF_MAC_CON1,
 };
 
 #define RK3228_GRF_MAC_CON0	0x0900
@@ -425,7 +430,7 @@ static int rk3228_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3228_reg_speed_data,
-				RK3228_GRF_MAC_CON1, interface, speed);
+				interface, speed);
 }
 
 static void rk3228_integrated_phy_powerup(struct rk_priv_data *priv)
@@ -447,6 +452,7 @@ static const struct rk_gmac_ops rk3228_ops = {
 	.phy_intf_sel_mask = GENMASK_U16(6, 4),
 	.rmii_mode_mask = BIT_U16(10),
 
+	.speed_grf_reg = RK3228_GRF_MAC_CON1,
 };
 
 #define RK3288_GRF_SOC_CON1	0x0248
@@ -494,7 +500,7 @@ static int rk3288_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3288_reg_speed_data,
-				RK3288_GRF_SOC_CON1, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rk3288_ops = {
@@ -505,6 +511,8 @@ static const struct rk_gmac_ops rk3288_ops = {
 	.phy_intf_sel_grf_reg = RK3288_GRF_SOC_CON1,
 	.phy_intf_sel_mask = GENMASK_U16(8, 6),
 	.rmii_mode_mask = BIT_U16(14),
+
+	.speed_grf_reg = RK3288_GRF_SOC_CON1,
 };
 
 #define RK3308_GRF_MAC_CON0		0x04a0
@@ -528,7 +536,7 @@ static int rk3308_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3308_reg_speed_data,
-				RK3308_GRF_MAC_CON0, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rk3308_ops = {
@@ -537,6 +545,8 @@ static const struct rk_gmac_ops rk3308_ops = {
 
 	.phy_intf_sel_grf_reg = RK3308_GRF_MAC_CON0,
 	.phy_intf_sel_mask = GENMASK_U16(4, 2),
+
+	.speed_grf_reg = RK3308_GRF_MAC_CON0,
 };
 
 #define RK3328_GRF_MAC_CON0	0x0900
@@ -567,10 +577,12 @@ static int rk3328_init(struct rk_priv_data *bsp_priv)
 	switch (bsp_priv->id) {
 	case 0: /* gmac2io */
 		bsp_priv->phy_intf_sel_grf_reg = RK3328_GRF_MAC_CON1;
+		bsp_priv->speed_grf_reg = RK3328_GRF_MAC_CON1;
 		return 0;
 
 	case 1: /* gmac2phy */
 		bsp_priv->phy_intf_sel_grf_reg = RK3328_GRF_MAC_CON2;
+		bsp_priv->speed_grf_reg = RK3328_GRF_MAC_CON2;
 		return 0;
 
 	default:
@@ -605,11 +617,7 @@ static const struct rk_reg_speed_data rk3328_reg_speed_data = {
 static int rk3328_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	unsigned int reg;
-
-	reg = bsp_priv->id ? RK3328_GRF_MAC_CON2 : RK3328_GRF_MAC_CON1;
-
-	return rk_set_reg_speed(bsp_priv, &rk3328_reg_speed_data, reg,
+	return rk_set_reg_speed(bsp_priv, &rk3328_reg_speed_data,
 				interface, speed);
 }
 
@@ -685,7 +693,7 @@ static int rk3366_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3366_reg_speed_data,
-				RK3366_GRF_SOC_CON6, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rk3366_ops = {
@@ -696,6 +704,8 @@ static const struct rk_gmac_ops rk3366_ops = {
 	.phy_intf_sel_grf_reg = RK3366_GRF_SOC_CON6,
 	.phy_intf_sel_mask = GENMASK_U16(11, 9),
 	.rmii_mode_mask = BIT_U16(6),
+
+	.speed_grf_reg = RK3366_GRF_SOC_CON6,
 };
 
 #define RK3368_GRF_SOC_CON15	0x043c
@@ -743,7 +753,7 @@ static int rk3368_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3368_reg_speed_data,
-				RK3368_GRF_SOC_CON15, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rk3368_ops = {
@@ -754,6 +764,8 @@ static const struct rk_gmac_ops rk3368_ops = {
 	.phy_intf_sel_grf_reg = RK3368_GRF_SOC_CON15,
 	.phy_intf_sel_mask = GENMASK_U16(11, 9),
 	.rmii_mode_mask = BIT_U16(6),
+
+	.speed_grf_reg = RK3368_GRF_SOC_CON15,
 };
 
 #define RK3399_GRF_SOC_CON5	0xc214
@@ -801,7 +813,7 @@ static int rk3399_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3399_reg_speed_data,
-				RK3399_GRF_SOC_CON5, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rk3399_ops = {
@@ -812,6 +824,8 @@ static const struct rk_gmac_ops rk3399_ops = {
 	.phy_intf_sel_grf_reg = RK3399_GRF_SOC_CON5,
 	.phy_intf_sel_mask = GENMASK_U16(11, 9),
 	.rmii_mode_mask = BIT_U16(6),
+
+	.speed_grf_reg = RK3399_GRF_SOC_CON5,
 };
 
 #define RK3506_GRF_SOC_CON8		0x0020
@@ -828,6 +842,22 @@ static const struct rk_gmac_ops rk3399_ops = {
 #define RK3506_GMAC_CLK_RMII_GATE	GRF_BIT(2)
 #define RK3506_GMAC_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
 
+static int rk3506_init(struct rk_priv_data *bsp_priv)
+{
+	switch (bsp_priv->id) {
+	case 0:
+		bsp_priv->speed_grf_reg = RK3506_GRF_SOC_CON8;
+		return 0;
+
+	case 1:
+		bsp_priv->speed_grf_reg = RK3506_GRF_SOC_CON11;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static void rk3506_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	unsigned int id = bsp_priv->id, offset;
@@ -844,11 +874,8 @@ static const struct rk_reg_speed_data rk3506_reg_speed_data = {
 static int rk3506_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	unsigned int id = bsp_priv->id, offset;
-
-	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
 	return rk_set_reg_speed(bsp_priv, &rk3506_reg_speed_data,
-				offset, interface, speed);
+				interface, speed);
 }
 
 static void rk3506_set_clock_selection(struct rk_priv_data *bsp_priv,
@@ -866,6 +893,7 @@ static void rk3506_set_clock_selection(struct rk_priv_data *bsp_priv,
 }
 
 static const struct rk_gmac_ops rk3506_ops = {
+	.init = rk3506_init,
 	.set_to_rmii = rk3506_set_to_rmii,
 	.set_speed = rk3506_set_speed,
 	.set_clock_selection = rk3506_set_clock_selection,
@@ -910,6 +938,22 @@ static const struct rk_gmac_ops rk3506_ops = {
 #define RK3528_GMAC1_CLK_RMII_GATE	GRF_BIT(9)
 #define RK3528_GMAC1_CLK_RMII_NOGATE	GRF_CLR_BIT(9)
 
+static int rk3528_init(struct rk_priv_data *bsp_priv)
+{
+	switch (bsp_priv->id) {
+	case 0:
+		bsp_priv->speed_grf_reg = RK3528_VO_GRF_GMAC_CON;
+		return 0;
+
+	case 1:
+		bsp_priv->speed_grf_reg = RK3528_VPU_GRF_GMAC_CON5;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static void rk3528_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
@@ -952,17 +996,13 @@ static int rk3528_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	const struct rk_reg_speed_data *rsd;
-	unsigned int reg;
 
-	if (bsp_priv->id == 1) {
+	if (bsp_priv->id == 1)
 		rsd = &rk3528_gmac1_reg_speed_data;
-		reg = RK3528_VPU_GRF_GMAC_CON5;
-	} else {
+	else
 		rsd = &rk3528_gmac0_reg_speed_data;
-		reg = RK3528_VO_GRF_GMAC_CON;
-	}
 
-	return rk_set_reg_speed(bsp_priv, rsd, reg, interface, speed);
+	return rk_set_reg_speed(bsp_priv, rsd, interface, speed);
 }
 
 static void rk3528_set_clock_selection(struct rk_priv_data *bsp_priv,
@@ -994,6 +1034,7 @@ static void rk3528_integrated_phy_powerdown(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_gmac_ops rk3528_ops = {
+	.init = rk3528_init,
 	.set_to_rgmii = rk3528_set_to_rgmii,
 	.set_to_rmii = rk3528_set_to_rmii,
 	.set_speed = rk3528_set_speed,
@@ -1114,10 +1155,12 @@ static int rk3576_init(struct rk_priv_data *bsp_priv)
 	switch (bsp_priv->id) {
 	case 0:
 		bsp_priv->phy_intf_sel_grf_reg = RK3576_GRF_GMAC_CON0;
+		bsp_priv->speed_grf_reg = RK3576_GRF_GMAC_CON0;
 		return 0;
 
 	case 1:
 		bsp_priv->phy_intf_sel_grf_reg = RK3576_GRF_GMAC_CON1;
+		bsp_priv->speed_grf_reg = RK3576_GRF_GMAC_CON1;
 		return 0;
 
 	default:
@@ -1163,12 +1206,7 @@ static const struct rk_reg_speed_data rk3578_reg_speed_data = {
 static int rk3576_set_gmac_speed(struct rk_priv_data *bsp_priv,
 				 phy_interface_t interface, int speed)
 {
-	unsigned int offset_con;
-
-	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
-					 RK3576_GRF_GMAC_CON0;
-
-	return rk_set_reg_speed(bsp_priv, &rk3578_reg_speed_data, offset_con,
+	return rk_set_reg_speed(bsp_priv, &rk3578_reg_speed_data,
 				interface, speed);
 }
 
@@ -1368,7 +1406,7 @@ static int rv1108_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rv1108_reg_speed_data,
-				RV1108_GRF_GMAC_CON0, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rv1108_ops = {
@@ -1377,6 +1415,8 @@ static const struct rk_gmac_ops rv1108_ops = {
 
 	.phy_intf_sel_grf_reg = RV1108_GRF_GMAC_CON0,
 	.phy_intf_sel_mask = GENMASK_U16(6, 4),
+
+	.speed_grf_reg = RV1108_GRF_GMAC_CON0,
 };
 
 #define RV1126_GRF_GMAC_CON0		0X0070
@@ -1656,6 +1696,9 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 	bsp_priv->phy_intf_sel_mask = ops->phy_intf_sel_mask;
 	bsp_priv->rmii_mode_mask = ops->rmii_mode_mask;
 
+	/* Set the default speed related parameters */
+	bsp_priv->speed_grf_reg = ops->speed_grf_reg;
+
 	if (ops->init) {
 		ret = ops->init(bsp_priv);
 		if (ret) {
-- 
2.47.3


