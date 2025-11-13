Return-Path: <netdev+bounces-238474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBB1C596C6
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED0574FC847
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52052F8BF7;
	Thu, 13 Nov 2025 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fWAKNzjS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AEE265621
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056025; cv=none; b=LO6chJV2Uj8DPCu5fgH3LxIjVMIYgkw+rdH2Yn8KDiZ/fWJHWW8+Gtei65jv2qpWwgSi0+hovmi6mFT0RoobL8FH+q7XrMT3LZCXPrIRf637grEJ9tkekj2j+1+SG4i2W20OW7yfhfHa6tAj1f/P1kPN+XLXctSxXeXscwccU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056025; c=relaxed/simple;
	bh=Deo/cCoMymU86TfRpZ8acbfNY0gfZqYx7qrW7RiDOgg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tuKLG1iaHiaU7W+DQpx+gm10vpKw4IVYICc1Syb4SjvulJhnUQSCjRZgF1yZZxdWaOO5xDA4vjPpZZ1K0oQtFF1mpdqs7yLu4W3pubMpuJPUhax01YbV7evgGDba3C8ALzqhPxAVEsW5nji83DQp1gdyQhc16CSAk8fs5vHk+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fWAKNzjS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VoZcSse6v2oqb36n7b6znlM7NzMZX9n4I5tTB7KsEck=; b=fWAKNzjSCernVzquo2UB4ly6W+
	6ENt4joh7HMM1eIT9HrnqmJXKGaNjU/pHGQIru/Wc+LPpzBb+f1FCotFmSAZB8RG/3867Xr2wWECc
	Lu2/AXFWWuvUPYUZmcJkkmlyEb8HUe29q+WhQ48Mj68KNx0JlIoEQtNz5X8iShBbn9wdQWfcxf6Aq
	NMiTPw3vHMv/vphG0Tjzcz9CnwVWW00/6B1V6q+NA3fRj3Fxm2Wy76jBJ+y2v6+uGxuSQHy3EEaC8
	JcWQqvVbzQTmLwejEAvV0JmucZTgw9dooTAWwPGkm9P6mrh8dC4vty5C64Q4n3poEDW6jv68ImyxR
	q+YPrYsg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46244 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJbPI-000000005oQ-0DFx;
	Thu, 13 Nov 2025 17:46:52 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJbPG-0000000EBqb-2cF2;
	Thu, 13 Nov 2025 17:46:50 +0000
In-Reply-To: <aRYZaKTIvfYoV3wE@shell.armlinux.org.uk>
References: <aRYZaKTIvfYoV3wE@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 4/4] net: stmmac: rk: use PHY_INTF_SEL_x in functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJbPG-0000000EBqb-2cF2@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Nov 2025 17:46:50 +0000

Rather than defining one xxx_GMAC_PHY_INTF_SEL_xxx() for each mode,
define xxx_GMAC_PHY_INTF_SEL() which takes the phy_intf_sel value.
Pass the appropriate value into these new macros in the set_to_xxx()
methods.

No change to produced code on aarch64.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 91 +++++++++----------
 1 file changed, 43 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 49076ee00877..6e75da577af5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -234,14 +234,14 @@ static void rk_gmac_integrated_fephy_powerdown(struct rk_priv_data *priv,
 #define PX30_GRF_GMAC_CON1		0x0904
 
 /* PX30_GRF_GMAC_CON1 */
-#define PX30_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RMII)
+#define PX30_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
 #define PX30_GMAC_SPEED_10M		GRF_CLR_BIT(2)
 #define PX30_GMAC_SPEED_100M		GRF_BIT(2)
 
 static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
-		     PX30_GMAC_PHY_INTF_SEL_RMII);
+		     PX30_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
 }
 
 static int px30_set_speed(struct rk_priv_data *bsp_priv,
@@ -290,8 +290,7 @@ static const struct rk_gmac_ops px30_ops = {
 #define RK3128_GMAC_CLK_TX_DL_CFG(val) GRF_FIELD(6, 0, val)
 
 /* RK3128_GRF_MAC_CON1 */
-#define RK3128_GMAC_PHY_INTF_SEL_RGMII GRF_FIELD(8, 6, PHY_INTF_SEL_RGMII)
-#define RK3128_GMAC_PHY_INTF_SEL_RMII  GRF_FIELD(8, 6, PHY_INTF_SEL_RMII)
+#define RK3128_GMAC_PHY_INTF_SEL(val)  GRF_FIELD(8, 6, val)
 #define RK3128_GMAC_FLOW_CTRL          GRF_BIT(9)
 #define RK3128_GMAC_FLOW_CTRL_CLR      GRF_CLR_BIT(9)
 #define RK3128_GMAC_SPEED_10M          GRF_CLR_BIT(10)
@@ -308,7 +307,7 @@ static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
 	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
-		     RK3128_GMAC_PHY_INTF_SEL_RGMII |
+		     RK3128_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
 		     RK3128_GMAC_RMII_MODE_CLR);
 	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON0,
 		     DELAY_ENABLE(RK3128, tx_delay, rx_delay) |
@@ -319,7 +318,8 @@ static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
-		     RK3128_GMAC_PHY_INTF_SEL_RMII | RK3128_GMAC_RMII_MODE);
+		     RK3128_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
+		     RK3128_GMAC_RMII_MODE);
 }
 
 static const struct rk_reg_speed_data rk3128_reg_speed_data = {
@@ -353,8 +353,7 @@ static const struct rk_gmac_ops rk3128_ops = {
 #define RK3228_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 /* RK3228_GRF_MAC_CON1 */
-#define RK3228_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RGMII)
-#define RK3228_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RMII)
+#define RK3228_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
 #define RK3228_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3228_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RK3228_GMAC_SPEED_10M		GRF_CLR_BIT(2)
@@ -378,7 +377,7 @@ static void rk3228_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
-		     RK3228_GMAC_PHY_INTF_SEL_RGMII |
+		     RK3228_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
 		     RK3228_GMAC_RMII_MODE_CLR |
 		     DELAY_ENABLE(RK3228, tx_delay, rx_delay));
 
@@ -390,7 +389,7 @@ static void rk3228_set_to_rgmii(struct rk_priv_data *bsp_priv,
 static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
-		     RK3228_GMAC_PHY_INTF_SEL_RMII |
+		     RK3228_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
 		     RK3228_GMAC_RMII_MODE);
 
 	/* set MAC to RMII mode */
@@ -432,8 +431,7 @@ static const struct rk_gmac_ops rk3228_ops = {
 #define RK3288_GRF_SOC_CON3	0x0250
 
 /*RK3288_GRF_SOC_CON1*/
-#define RK3288_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(8, 6, PHY_INTF_SEL_RGMII)
-#define RK3288_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(8, 6, PHY_INTF_SEL_RMII)
+#define RK3288_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(8, 6, val)
 #define RK3288_GMAC_FLOW_CTRL		GRF_BIT(9)
 #define RK3288_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(9)
 #define RK3288_GMAC_SPEED_10M		GRF_CLR_BIT(10)
@@ -458,7 +456,7 @@ static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
 	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
-		     RK3288_GMAC_PHY_INTF_SEL_RGMII |
+		     RK3288_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
 		     RK3288_GMAC_RMII_MODE_CLR);
 	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON3,
 		     DELAY_ENABLE(RK3288, tx_delay, rx_delay) |
@@ -469,7 +467,8 @@ static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
 static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
-		     RK3288_GMAC_PHY_INTF_SEL_RMII | RK3288_GMAC_RMII_MODE);
+		     RK3288_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
+		     RK3288_GMAC_RMII_MODE);
 }
 
 static const struct rk_reg_speed_data rk3288_reg_speed_data = {
@@ -496,7 +495,7 @@ static const struct rk_gmac_ops rk3288_ops = {
 #define RK3308_GRF_MAC_CON0		0x04a0
 
 /* RK3308_GRF_MAC_CON0 */
-#define RK3308_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(4, 2, PHY_INTF_SEL_RMII)
+#define RK3308_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(4, 2, val)
 #define RK3308_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3308_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RK3308_GMAC_SPEED_10M		GRF_CLR_BIT(0)
@@ -505,7 +504,7 @@ static const struct rk_gmac_ops rk3288_ops = {
 static void rk3308_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	regmap_write(bsp_priv->grf, RK3308_GRF_MAC_CON0,
-		     RK3308_GMAC_PHY_INTF_SEL_RMII);
+		     RK3308_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
 }
 
 static const struct rk_reg_speed_data rk3308_reg_speed_data = {
@@ -535,8 +534,7 @@ static const struct rk_gmac_ops rk3308_ops = {
 #define RK3328_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 /* RK3328_GRF_MAC_CON1 */
-#define RK3328_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RGMII)
-#define RK3328_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RMII)
+#define RK3328_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
 #define RK3328_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3328_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RK3328_GMAC_SPEED_10M		GRF_CLR_BIT(2)
@@ -558,7 +556,7 @@ static void rk3328_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
 	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
-		     RK3328_GMAC_PHY_INTF_SEL_RGMII |
+		     RK3328_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
 		     RK3328_GMAC_RMII_MODE_CLR |
 		     RK3328_GMAC_RXCLK_DLY_ENABLE |
 		     RK3328_GMAC_TXCLK_DLY_ENABLE);
@@ -576,7 +574,7 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 		  RK3328_GRF_MAC_CON1;
 
 	regmap_write(bsp_priv->grf, reg,
-		     RK3328_GMAC_PHY_INTF_SEL_RMII |
+		     RK3328_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
 		     RK3328_GMAC_RMII_MODE);
 }
 
@@ -622,8 +620,7 @@ static const struct rk_gmac_ops rk3328_ops = {
 #define RK3366_GRF_SOC_CON7	0x041c
 
 /* RK3366_GRF_SOC_CON6 */
-#define RK3366_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(11, 9, PHY_INTF_SEL_RGMII)
-#define RK3366_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(11, 9, PHY_INTF_SEL_RMII)
+#define RK3366_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(11, 9, val)
 #define RK3366_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3366_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
 #define RK3366_GMAC_SPEED_10M		GRF_CLR_BIT(7)
@@ -648,7 +645,7 @@ static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
 	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
-		     RK3366_GMAC_PHY_INTF_SEL_RGMII |
+		     RK3366_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
 		     RK3366_GMAC_RMII_MODE_CLR);
 	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON7,
 		     DELAY_ENABLE(RK3366, tx_delay, rx_delay) |
@@ -659,7 +656,8 @@ static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
 static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
-		     RK3366_GMAC_PHY_INTF_SEL_RMII | RK3366_GMAC_RMII_MODE);
+		     RK3366_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
+		     RK3366_GMAC_RMII_MODE);
 }
 
 static const struct rk_reg_speed_data rk3366_reg_speed_data = {
@@ -687,8 +685,7 @@ static const struct rk_gmac_ops rk3366_ops = {
 #define RK3368_GRF_SOC_CON16	0x0440
 
 /* RK3368_GRF_SOC_CON15 */
-#define RK3368_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(11, 9, PHY_INTF_SEL_RGMII)
-#define RK3368_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(11, 9, PHY_INTF_SEL_RMII)
+#define RK3368_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(11, 9, val)
 #define RK3368_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3368_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
 #define RK3368_GMAC_SPEED_10M		GRF_CLR_BIT(7)
@@ -713,7 +710,7 @@ static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
 	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
-		     RK3368_GMAC_PHY_INTF_SEL_RGMII |
+		     RK3368_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
 		     RK3368_GMAC_RMII_MODE_CLR);
 	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON16,
 		     DELAY_ENABLE(RK3368, tx_delay, rx_delay) |
@@ -724,7 +721,8 @@ static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
 static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
-		     RK3368_GMAC_PHY_INTF_SEL_RMII | RK3368_GMAC_RMII_MODE);
+		     RK3368_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
+		     RK3368_GMAC_RMII_MODE);
 }
 
 static const struct rk_reg_speed_data rk3368_reg_speed_data = {
@@ -752,8 +750,7 @@ static const struct rk_gmac_ops rk3368_ops = {
 #define RK3399_GRF_SOC_CON6	0xc218
 
 /* RK3399_GRF_SOC_CON5 */
-#define RK3399_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(11, 9, PHY_INTF_SEL_RGMII)
-#define RK3399_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(11, 9, PHY_INTF_SEL_RMII)
+#define RK3399_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(11, 9, val)
 #define RK3399_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3399_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
 #define RK3399_GMAC_SPEED_10M		GRF_CLR_BIT(7)
@@ -778,7 +775,7 @@ static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
 	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
-		     RK3399_GMAC_PHY_INTF_SEL_RGMII |
+		     RK3399_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
 		     RK3399_GMAC_RMII_MODE_CLR);
 	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON6,
 		     DELAY_ENABLE(RK3399, tx_delay, rx_delay) |
@@ -789,7 +786,8 @@ static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
 static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
-		     RK3399_GMAC_PHY_INTF_SEL_RMII | RK3399_GMAC_RMII_MODE);
+		     RK3399_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
+		     RK3399_GMAC_RMII_MODE);
 }
 
 static const struct rk_reg_speed_data rk3399_reg_speed_data = {
@@ -1015,8 +1013,7 @@ static const struct rk_gmac_ops rk3528_ops = {
 #define RK3568_GRF_GMAC1_CON1		0x038c
 
 /* RK3568_GRF_GMAC0_CON1 && RK3568_GRF_GMAC1_CON1 */
-#define RK3568_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RGMII)
-#define RK3568_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RMII)
+#define RK3568_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
 #define RK3568_GMAC_FLOW_CTRL			GRF_BIT(3)
 #define RK3568_GMAC_FLOW_CTRL_CLR		GRF_CLR_BIT(3)
 #define RK3568_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(1)
@@ -1043,7 +1040,7 @@ static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3568_GMAC_CLK_TX_DL_CFG(tx_delay));
 
 	regmap_write(bsp_priv->grf, con1,
-		     RK3568_GMAC_PHY_INTF_SEL_RGMII |
+		     RK3568_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
 		     RK3568_GMAC_RXCLK_DLY_ENABLE |
 		     RK3568_GMAC_TXCLK_DLY_ENABLE);
 }
@@ -1054,7 +1051,8 @@ static void rk3568_set_to_rmii(struct rk_priv_data *bsp_priv)
 
 	con1 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON1 :
 				     RK3568_GRF_GMAC0_CON1;
-	regmap_write(bsp_priv->grf, con1, RK3568_GMAC_PHY_INTF_SEL_RMII);
+	regmap_write(bsp_priv->grf, con1,
+		     RK3568_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
 }
 
 static const struct rk_gmac_ops rk3568_ops = {
@@ -1208,10 +1206,8 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GRF_GMAC_CON0			0X0008
 #define RK3588_GRF_CLK_CON1			0X0070
 
-#define RK3588_GMAC_PHY_INTF_SEL_RGMII(id)	\
-	(GRF_FIELD(5, 3, PHY_INTF_SEL_RGMII) << ((id) * 6))
-#define RK3588_GMAC_PHY_INTF_SEL_RMII(id)	\
-	(GRF_FIELD(5, 3, PHY_INTF_SEL_RMII) << ((id) * 6))
+#define RK3588_GMAC_PHY_INTF_SEL(id, val)	\
+	(GRF_FIELD(5, 3, val) << ((id) * 6))
 
 #define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
 #define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
@@ -1241,7 +1237,7 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 					 RK3588_GRF_GMAC_CON8;
 
 	regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
-		     RK3588_GMAC_PHY_INTF_SEL_RGMII(id));
+		     RK3588_GMAC_PHY_INTF_SEL(id, PHY_INTF_SEL_RGMII));
 
 	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1,
 		     RK3588_GMAC_CLK_RGMII_MODE(id));
@@ -1258,7 +1254,7 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
-		     RK3588_GMAC_PHY_INTF_SEL_RMII(bsp_priv->id));
+		     RK3588_GMAC_PHY_INTF_SEL(bsp_priv->id, PHY_INTF_SEL_RMII));
 
 	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1,
 		     RK3588_GMAC_CLK_RMII_MODE(bsp_priv->id));
@@ -1328,7 +1324,7 @@ static const struct rk_gmac_ops rk3588_ops = {
 #define RV1108_GRF_GMAC_CON0		0X0900
 
 /* RV1108_GRF_GMAC_CON0 */
-#define RV1108_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RMII)
+#define RV1108_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
 #define RV1108_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RV1108_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RV1108_GMAC_SPEED_10M		GRF_CLR_BIT(2)
@@ -1339,7 +1335,7 @@ static const struct rk_gmac_ops rk3588_ops = {
 static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	regmap_write(bsp_priv->grf, RV1108_GRF_GMAC_CON0,
-		     RV1108_GMAC_PHY_INTF_SEL_RMII);
+		     RV1108_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
 }
 
 static const struct rk_reg_speed_data rv1108_reg_speed_data = {
@@ -1364,8 +1360,7 @@ static const struct rk_gmac_ops rv1108_ops = {
 #define RV1126_GRF_GMAC_CON2		0X0078
 
 /* RV1126_GRF_GMAC_CON0 */
-#define RV1126_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RGMII)
-#define RV1126_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, PHY_INTF_SEL_RMII)
+#define RV1126_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
 #define RV1126_GMAC_FLOW_CTRL			GRF_BIT(7)
 #define RV1126_GMAC_FLOW_CTRL_CLR		GRF_CLR_BIT(7)
 #define RV1126_GMAC_M0_RXCLK_DLY_ENABLE		GRF_BIT(1)
@@ -1388,7 +1383,7 @@ static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
 	regmap_write(bsp_priv->grf, RV1126_GRF_GMAC_CON0,
-		     RV1126_GMAC_PHY_INTF_SEL_RGMII |
+		     RV1126_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
 		     RV1126_GMAC_M0_RXCLK_DLY_ENABLE |
 		     RV1126_GMAC_M0_TXCLK_DLY_ENABLE |
 		     RV1126_GMAC_M1_RXCLK_DLY_ENABLE |
@@ -1406,7 +1401,7 @@ static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
 static void rv1126_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	regmap_write(bsp_priv->grf, RV1126_GRF_GMAC_CON0,
-		     RV1126_GMAC_PHY_INTF_SEL_RMII);
+		     RV1126_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
 }
 
 static const struct rk_gmac_ops rv1126_ops = {
-- 
2.47.3


