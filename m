Return-Path: <netdev+bounces-238471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0037C594A6
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B763B8AFE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9082E7F14;
	Thu, 13 Nov 2025 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r0s+nd/7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C52877FA
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056005; cv=none; b=imqaxgsOH7hEYnwfvNCsDhZdV/k4LZVOJ5wvO9vnXv3J2E+jD6zDohMtksaO9qdxuVgB4hmjxy6HNa+uTidOULD3jE922+ynwO277awOxqmTgc/STnvh/PUXTPRVXiOKRA6S1Xn3Ky4TrbMIyIeTs76j8ZvbpxEJqRK7cH8uRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056005; c=relaxed/simple;
	bh=cUe93mGZK0vVbUgA6HRFrlTlfcwXDklNwsc4nIG1Kgw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uMNQOawxRqTPzmkzr6oHt5cwUBJqCgYA7rBj/+dOnmJyI1ADb4mA39M0KMU1pRwn6Sh9iN3ruAmjoWM3Pe/eBdDungZ9vdAOzFOQewSoL/UkSeNW8H1X2ea/aE60S1KvsgI6r3bZgIZHvTwTtYD5aMl+MSAJeGfhZlViV90BCQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=r0s+nd/7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2XuI9JXuGMQe+qBDDwJRIMLDDaz6Ki24k1VsQCKN82Y=; b=r0s+nd/7X+KzRASyRyVdM1bmBL
	G7VSdwMUMsN+DzqUtR6XR6pyBPyr1zp6Dp9zDHXLEbyK5Dgg6rWWHW95kvEzL9IRT2xu8dS8Me8as
	aD3ieFEXMntaw2P5hjcEE7GpWlbSVM+MhGM+r+HrMGK58vRkpr4xT/8oALYHjDzF/ryc87nzYHIcu
	N0klpWYAanSN1W6GK+XcXcDIPgL9n3p02+LhjCR793SQpqzzRpeQOuN/esYOvCw/nC+dJs7LGLR20
	N3GkBJ+S/pHMVhqV//jHomaQScq6NGYskuqq2BzeuEpZAjT8sP/xRzIbqM+CAoNx/PhzM+Op7gEj6
	u7NnyxFQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40654 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJbP2-000000005nT-0CAJ;
	Thu, 13 Nov 2025 17:46:36 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJbP1-0000000EBqJ-1AjR;
	Thu, 13 Nov 2025 17:46:35 +0000
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
Subject: [PATCH net-next 1/4] net: stmmac: rk: replace HIWORD_UPDATE() with
 GRF_FIELD()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJbP1-0000000EBqJ-1AjR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Nov 2025 17:46:35 +0000

Provide GRF_FIELD() which takes the high/low bit numbers of the field
and field value, generates the mask and passes it to FIELD_PREP_WM16.
Replace all HIWORD_UPDATE() instances with this.

No change to produced code on aarch64.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 64 +++++++++----------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index a5c7e03ebc63..794a7ed71451 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -149,11 +149,11 @@ static int rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv,
 	return clk_set_rate(clk_mac_speed, rate);
 }
 
-#define HIWORD_UPDATE(val, mask, shift) \
-		(FIELD_PREP_WM16((mask) << (shift), (val)))
+#define GRF_FIELD(hi, lo, val)		\
+	FIELD_PREP_WM16(GENMASK_U16(hi, lo), val)
 
-#define GRF_BIT(nr)	(BIT(nr) | BIT(nr+16))
-#define GRF_CLR_BIT(nr)	(BIT(nr+16))
+#define GRF_BIT(nr)			(BIT(nr) | BIT(nr+16))
+#define GRF_CLR_BIT(nr)			(BIT(nr+16))
 
 #define DELAY_ENABLE(soc, tx, rx) \
 	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
@@ -168,8 +168,8 @@ static int rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv,
 #define RK_MACPHY_DISABLE		GRF_CLR_BIT(0)
 #define RK_MACPHY_CFG_CLK_50M		GRF_BIT(14)
 #define RK_GMAC2PHY_RMII_MODE		(GRF_BIT(6) | GRF_CLR_BIT(7))
-#define RK_GRF_CON2_MACPHY_ID		HIWORD_UPDATE(0x1234, 0xffff, 0)
-#define RK_GRF_CON3_MACPHY_ID		HIWORD_UPDATE(0x35, 0x3f, 0)
+#define RK_GRF_CON2_MACPHY_ID		GRF_FIELD(15, 0, 0x1234)
+#define RK_GRF_CON3_MACPHY_ID		GRF_FIELD(5, 0, 0x35)
 
 static void rk_gmac_integrated_ephy_powerup(struct rk_priv_data *priv)
 {
@@ -285,8 +285,8 @@ static const struct rk_gmac_ops px30_ops = {
 #define RK3128_GMAC_TXCLK_DLY_DISABLE  GRF_CLR_BIT(14)
 #define RK3128_GMAC_RXCLK_DLY_ENABLE   GRF_BIT(15)
 #define RK3128_GMAC_RXCLK_DLY_DISABLE  GRF_CLR_BIT(15)
-#define RK3128_GMAC_CLK_RX_DL_CFG(val) HIWORD_UPDATE(val, 0x7F, 7)
-#define RK3128_GMAC_CLK_TX_DL_CFG(val) HIWORD_UPDATE(val, 0x7F, 0)
+#define RK3128_GMAC_CLK_RX_DL_CFG(val) GRF_FIELD(13, 7, val)
+#define RK3128_GMAC_CLK_TX_DL_CFG(val) GRF_FIELD(6, 0, val)
 
 /* RK3128_GRF_MAC_CON1 */
 #define RK3128_GMAC_PHY_INTF_SEL_RGMII	\
@@ -350,8 +350,8 @@ static const struct rk_gmac_ops rk3128_ops = {
 #define RK3228_GRF_CON_MUX	0x50
 
 /* RK3228_GRF_MAC_CON0 */
-#define RK3228_GMAC_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 7)
-#define RK3228_GMAC_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 0)
+#define RK3228_GMAC_CLK_RX_DL_CFG(val)	GRF_FIELD(13, 7, val)
+#define RK3228_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 /* RK3228_GRF_MAC_CON1 */
 #define RK3228_GMAC_PHY_INTF_SEL_RGMII	\
@@ -456,8 +456,8 @@ static const struct rk_gmac_ops rk3228_ops = {
 #define RK3288_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(14)
 #define RK3288_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(15)
 #define RK3288_GMAC_RXCLK_DLY_DISABLE	GRF_CLR_BIT(15)
-#define RK3288_GMAC_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 7)
-#define RK3288_GMAC_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 0)
+#define RK3288_GMAC_CLK_RX_DL_CFG(val)	GRF_FIELD(13, 7, val)
+#define RK3288_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
@@ -537,8 +537,8 @@ static const struct rk_gmac_ops rk3308_ops = {
 #define RK3328_GRF_MACPHY_CON1	0xb04
 
 /* RK3328_GRF_MAC_CON0 */
-#define RK3328_GMAC_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 7)
-#define RK3328_GMAC_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 0)
+#define RK3328_GMAC_CLK_RX_DL_CFG(val)	GRF_FIELD(13, 7, val)
+#define RK3328_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 /* RK3328_GRF_MAC_CON1 */
 #define RK3328_GMAC_PHY_INTF_SEL_RGMII	\
@@ -651,8 +651,8 @@ static const struct rk_gmac_ops rk3328_ops = {
 #define RK3366_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(7)
 #define RK3366_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(15)
 #define RK3366_GMAC_RXCLK_DLY_DISABLE	GRF_CLR_BIT(15)
-#define RK3366_GMAC_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 8)
-#define RK3366_GMAC_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 0)
+#define RK3366_GMAC_CLK_RX_DL_CFG(val)	GRF_FIELD(14, 8, val)
+#define RK3366_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
@@ -718,8 +718,8 @@ static const struct rk_gmac_ops rk3366_ops = {
 #define RK3368_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(7)
 #define RK3368_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(15)
 #define RK3368_GMAC_RXCLK_DLY_DISABLE	GRF_CLR_BIT(15)
-#define RK3368_GMAC_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 8)
-#define RK3368_GMAC_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 0)
+#define RK3368_GMAC_CLK_RX_DL_CFG(val)	GRF_FIELD(14, 8, val)
+#define RK3368_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
@@ -785,8 +785,8 @@ static const struct rk_gmac_ops rk3368_ops = {
 #define RK3399_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(7)
 #define RK3399_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(15)
 #define RK3399_GMAC_RXCLK_DLY_DISABLE	GRF_CLR_BIT(15)
-#define RK3399_GMAC_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 8)
-#define RK3399_GMAC_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 0)
+#define RK3399_GMAC_CLK_RX_DL_CFG(val)	GRF_FIELD(14, 8, val)
+#define RK3399_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
@@ -901,8 +901,8 @@ static const struct rk_gmac_ops rk3506_ops = {
 #define RK3528_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(14)
 #define RK3528_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(14)
 
-#define RK3528_GMAC_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0xFF, 8)
-#define RK3528_GMAC_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0xFF, 0)
+#define RK3528_GMAC_CLK_RX_DL_CFG(val)	GRF_FIELD(15, 8, val)
+#define RK3528_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(7, 0, val)
 
 #define RK3528_GMAC0_PHY_INTF_SEL_RMII	GRF_BIT(1)
 #define RK3528_GMAC1_PHY_INTF_SEL_RGMII	GRF_CLR_BIT(8)
@@ -1041,8 +1041,8 @@ static const struct rk_gmac_ops rk3528_ops = {
 #define RK3568_GMAC_TXCLK_DLY_DISABLE		GRF_CLR_BIT(0)
 
 /* RK3568_GRF_GMAC0_CON0 && RK3568_GRF_GMAC1_CON0 */
-#define RK3568_GMAC_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 8)
-#define RK3568_GMAC_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 0)
+#define RK3568_GMAC_CLK_RX_DL_CFG(val)	GRF_FIELD(14, 8, val)
+#define RK3568_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
@@ -1096,8 +1096,8 @@ static const struct rk_gmac_ops rk3568_ops = {
 #define RK3576_GMAC_TXCLK_DLY_ENABLE		GRF_BIT(7)
 #define RK3576_GMAC_TXCLK_DLY_DISABLE		GRF_CLR_BIT(7)
 
-#define RK3576_GMAC_CLK_RX_DL_CFG(val)		HIWORD_UPDATE(val, 0x7F, 8)
-#define RK3576_GMAC_CLK_TX_DL_CFG(val)		HIWORD_UPDATE(val, 0x7F, 0)
+#define RK3576_GMAC_CLK_RX_DL_CFG(val)		GRF_FIELD(14, 8, val)
+#define RK3576_GMAC_CLK_TX_DL_CFG(val)		GRF_FIELD(6, 0, val)
 
 /* SDGMAC_GRF */
 #define RK3576_GRF_GMAC_CON0			0X0020
@@ -1220,8 +1220,8 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GMAC_TXCLK_DLY_ENABLE(id)	GRF_BIT(2 * (id) + 2)
 #define RK3588_GMAC_TXCLK_DLY_DISABLE(id)	GRF_CLR_BIT(2 * (id) + 2)
 
-#define RK3588_GMAC_CLK_RX_DL_CFG(val)		HIWORD_UPDATE(val, 0xFF, 8)
-#define RK3588_GMAC_CLK_TX_DL_CFG(val)		HIWORD_UPDATE(val, 0xFF, 0)
+#define RK3588_GMAC_CLK_RX_DL_CFG(val)		GRF_FIELD(15, 8, val)
+#define RK3588_GMAC_CLK_TX_DL_CFG(val)		GRF_FIELD(7, 0, val)
 
 /* php_grf */
 #define RK3588_GRF_GMAC_CON0			0X0008
@@ -1400,11 +1400,11 @@ static const struct rk_gmac_ops rv1108_ops = {
 #define RV1126_GMAC_M1_TXCLK_DLY_DISABLE	GRF_CLR_BIT(2)
 
 /* RV1126_GRF_GMAC_CON1 */
-#define RV1126_GMAC_M0_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 8)
-#define RV1126_GMAC_M0_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 0)
+#define RV1126_GMAC_M0_CLK_RX_DL_CFG(val)	GRF_FIELD(14, 8, val)
+#define RV1126_GMAC_M0_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 /* RV1126_GRF_GMAC_CON2 */
-#define RV1126_GMAC_M1_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 8)
-#define RV1126_GMAC_M1_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 0)
+#define RV1126_GMAC_M1_CLK_RX_DL_CFG(val)	GRF_FIELD(14, 8, val)
+#define RV1126_GMAC_M1_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
-- 
2.47.3


