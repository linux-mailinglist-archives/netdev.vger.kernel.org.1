Return-Path: <netdev+bounces-235047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED29C2B891
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C373BA38A
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C133043C7;
	Mon,  3 Nov 2025 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="snBIplvI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030152D73A8
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170649; cv=none; b=jJXPl9tmMUT6fGnrim10DrZe+DETdQwdc+2efMQZjIZuSKqJBHMRxBg4MlPS350Y2oC9Bipw24xQ2BljjkXR1IBTt1LlWrHnU4xgZ61oc1kPFR5s1tJhipCaK24rlKY/1N+HjEjI/n917vzz6K8q9t42ydnkIXSJYQVVGp9jqII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170649; c=relaxed/simple;
	bh=Hd4l0VcI22ZDHpW/lGTd0d6Q6+uj9VyMOCcRBl8dPVM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GbjJMdrENrn4+YRS7aI3Qrz6pN180FiY6bU41X2TZuanIoUODqMC6cH/9WGrcT6oRjoESTExwDyl+gzW4VdN41JmwmL5h3UXqDi4Z8XS3Vf9POnWRhBXIQn+7m3JzK08BuSob5AZI8HcgIJkXaLkXfsyfKQ+W+VMSIIaBZ38H44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=snBIplvI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7xL9GiU2IaWHrasIEnSZbT6M9oFMnSwoQNmb4+tGE3o=; b=snBIplvIVkUf0YsCAdoyLlUA1B
	yStvnWgOqPNvyDMqHuZSX+/yBhxmjEcdRsu1HmY9y4uuAhYQFIA177MBLRKW4tYCifHBuysqtbPml
	wTyP7lojvuRjnAEgiqjI+gevOsqOYVIR5L0/gSeQlwHbpGiPtSEC+ZLmWMz4GtwG/okWmuCbDfqm+
	ShPnM6OjvMHTDXBfD6w/PqdanezCQtbCTas2DtL6GUrHeOKvHQuJyg12+WU41+f/DsA519xjtFiZ6
	AW281jpFmqZH7YQu7VDq4qxniPl22GcTmQibymg127KQUVtJM3n47vw47ot7oC7B5ox5tO2I1XhKg
	ZnlEI/rQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41448 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vFt4u-000000000hA-2yld;
	Mon, 03 Nov 2025 11:50:29 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vFt4s-0000000Chp4-0kwf;
	Mon, 03 Nov 2025 11:50:26 +0000
In-Reply-To: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	s32@nxp.com,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next 07/11] net: stmmac: imx: use FIELD_PREP()/FIELD_GET()
 for PHY_INTF_SEL_x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vFt4s-0000000Chp4-0kwf@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 03 Nov 2025 11:50:26 +0000

Use FIELD_PREP()/FIELD_GET() in the functions to construct the PHY
interface selection bitfield or to extract its value.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 44 +++++++++----------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 4fbee59e7337..f1cfccd4269c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -24,24 +24,12 @@
 
 #define GPR_ENET_QOS_INTF_MODE_MASK	GENMASK(21, 16)
 #define GPR_ENET_QOS_INTF_SEL_MASK	GENMASK(20, 16)
-#define GPR_ENET_QOS_INTF_SEL_MII	FIELD_PREP(GPR_ENET_QOS_INTF_SEL_MASK, \
-						   PHY_INTF_SEL_GMII_MII)
-#define GPR_ENET_QOS_INTF_SEL_RMII	FIELD_PREP(GPR_ENET_QOS_INTF_SEL_MASK, \
-						   PHY_INTF_SEL_RMII)
-#define GPR_ENET_QOS_INTF_SEL_RGMII	FIELD_PREP(GPR_ENET_QOS_INTF_SEL_MASK, \
-						   PHY_INTF_SEL_RGMII)
 #define GPR_ENET_QOS_CLK_GEN_EN		(0x1 << 19)
 #define GPR_ENET_QOS_CLK_TX_CLK_SEL	(0x1 << 20)
 #define GPR_ENET_QOS_RGMII_EN		(0x1 << 21)
 
 #define MX93_GPR_ENET_QOS_INTF_MODE_MASK	GENMASK(3, 0)
 #define MX93_GPR_ENET_QOS_INTF_SEL_MASK		GENMASK(3, 1)
-#define MX93_GPR_ENET_QOS_INTF_SEL_MII		FIELD_PREP(MX93_GPR_ENET_QOS_INTF_SEL_MASK, \
-							   PHY_INTF_SEL_GMII_MII)
-#define MX93_GPR_ENET_QOS_INTF_SEL_RMII		FIELD_PREP(MX93_GPR_ENET_QOS_INTF_SEL_MASK, \
-							   PHY_INTF_SEL_RMII)
-#define MX93_GPR_ENET_QOS_INTF_SEL_RGMII	FIELD_PREP(MX93_GPR_ENET_QOS_INTF_SEL_MASK, \
-							   PHY_INTF_SEL_RGMII)
 #define MX93_GPR_ENET_QOS_CLK_GEN_EN		(0x1 << 0)
 #define MX93_GPR_ENET_QOS_CLK_SEL_MASK		BIT_MASK(0)
 #define MX93_GPR_CLK_SEL_OFFSET			(4)
@@ -77,22 +65,24 @@ struct imx_priv_data {
 static int imx8mp_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct imx_priv_data *dwmac = plat_dat->bsp_priv;
+	u8 phy_intf_sel;
 	int val;
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		val = GPR_ENET_QOS_INTF_SEL_MII;
+		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
+		val = 0;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-		val = GPR_ENET_QOS_INTF_SEL_RMII;
-		val |= (dwmac->rmii_refclk_ext ? 0 : GPR_ENET_QOS_CLK_TX_CLK_SEL);
+		phy_intf_sel = PHY_INTF_SEL_RMII;
+		val = dwmac->rmii_refclk_ext ? 0 : GPR_ENET_QOS_CLK_TX_CLK_SEL;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		val = GPR_ENET_QOS_INTF_SEL_RGMII |
-		      GPR_ENET_QOS_RGMII_EN;
+		phy_intf_sel = PHY_INTF_SEL_RGMII;
+		val = GPR_ENET_QOS_RGMII_EN;
 		break;
 	default:
 		pr_debug("imx dwmac doesn't support %s interface\n",
@@ -100,7 +90,9 @@ static int imx8mp_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 		return -EINVAL;
 	}
 
-	val |= GPR_ENET_QOS_CLK_GEN_EN;
+	val |= FIELD_PREP(GPR_ENET_QOS_INTF_SEL_MASK, phy_intf_sel) |
+	       GPR_ENET_QOS_CLK_GEN_EN;
+
 	return regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
 				  GPR_ENET_QOS_INTF_MODE_MASK, val);
 };
@@ -117,11 +109,12 @@ imx8dxl_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 static int imx93_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct imx_priv_data *dwmac = plat_dat->bsp_priv;
+	u8 phy_intf_sel;
 	int val, ret;
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		val = MX93_GPR_ENET_QOS_INTF_SEL_MII;
+		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		if (dwmac->rmii_refclk_ext) {
@@ -132,13 +125,13 @@ static int imx93_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 			if (ret)
 				return ret;
 		}
-		val = MX93_GPR_ENET_QOS_INTF_SEL_RMII;
+		phy_intf_sel = PHY_INTF_SEL_RMII;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		val = MX93_GPR_ENET_QOS_INTF_SEL_RGMII;
+		phy_intf_sel = PHY_INTF_SEL_RGMII;
 		break;
 	default:
 		dev_dbg(dwmac->dev, "imx dwmac doesn't support %s interface\n",
@@ -146,7 +139,9 @@ static int imx93_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 		return -EINVAL;
 	}
 
-	val |= MX93_GPR_ENET_QOS_CLK_GEN_EN;
+	val = FIELD_PREP(MX93_GPR_ENET_QOS_INTF_SEL_MASK, phy_intf_sel) |
+	      MX93_GPR_ENET_QOS_CLK_GEN_EN;
+
 	return regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
 				  MX93_GPR_ENET_QOS_INTF_MODE_MASK, val);
 };
@@ -248,8 +243,8 @@ static void imx93_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 	if (regmap_read(dwmac->intf_regmap, dwmac->intf_reg_off, &iface))
 		return;
 
-	iface &= MX93_GPR_ENET_QOS_INTF_SEL_MASK;
-	if (iface != MX93_GPR_ENET_QOS_INTF_SEL_RGMII)
+	if (FIELD_GET(MX93_GPR_ENET_QOS_INTF_SEL_MASK, iface) !=
+	    PHY_INTF_SEL_RGMII)
 		return;
 
 	old_ctrl = readl(dwmac->base_addr + MAC_CTRL_REG);
@@ -262,6 +257,7 @@ static void imx93_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 	readl(dwmac->base_addr + MAC_CTRL_REG);
 
 	usleep_range(10, 20);
+	iface &= MX93_GPR_ENET_QOS_INTF_SEL_MASK;
 	iface |= MX93_GPR_ENET_QOS_CLK_GEN_EN;
 	regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
 			   MX93_GPR_ENET_QOS_INTF_MODE_MASK, iface);
-- 
2.47.3


