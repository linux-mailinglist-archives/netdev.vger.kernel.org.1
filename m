Return-Path: <netdev+bounces-186144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0ACA9D484
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6ED01717C6
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33AF224B0B;
	Fri, 25 Apr 2025 21:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191E32192F3;
	Fri, 25 Apr 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617904; cv=none; b=t4fAJT/II0ydeoxsOBuoTqQpXdtle746qfgXLPIMbmupZ0zqVr7Xp0Wup8C1NEzhkWS9o5bRM5mTTyZJMWpcp/ggHpFwYsZG67cocpOCsLrW2nj4+8dLQtEwdIoNRHq+Hwg0xN0CIp5ZJM4S6V8GQDT8LYP3OiiQfGOvzfB257k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617904; c=relaxed/simple;
	bh=UvWW5xM0ftXUKHpGxT90Ph/nnmgSYUp1c3rUqexg/eA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WS52CvaEbU1Vbj8nS0AtK0UsXe8IHGracW5xav4po8qKfnhqRRgBORSpz0GkgbFYiBhyOwYrVN7nyeXE0fIKR5FcJYA3BaqsUurTBAGv0QhlYDu+VIyEewXE+xCQi6XhIJqA1390yamOXvY7nzDnCvd8b1h89afRHzEfAwU2NI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u8QrR-0000000062h-39Vc;
	Fri, 25 Apr 2025 21:51:25 +0000
Date: Fri, 25 Apr 2025 22:51:18 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: ethernet: mtk_eth_soc: add support for MT7988
 internal 2.5G PHY
Message-ID: <ab77dc679ed7d9669e82d8efeab41df23b524b1f.1745617638.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The MediaTek MT7988 SoC comes with an single built-in Ethernet PHY
supporting 2500Base-T/1000Base-T/100Base-TX/10Base-T link partners in
addition to the built-in MT7531-like 1GE switch. The built-in PHY only
supports full duplex.

Add muxes allowing to select GMAC2->2.5G PHY path and add basic support
for XGMAC as the built-in 2.5G PHY is internally connected via XGMII.
The XGMAC features will also be used by 5GBase-R, 10GBase-R and USXGMII
SerDes modes which are going to be added once support for standalone PCS
drivers is in place.

In order to make use of the built-in 2.5G PHY the appropriate PHY driver
as well as (proprietary) PHY firmware has to be present as well.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
PHY driver: https://patchwork.kernel.org/project/netdevbpf/list/?series=935473&state=*
PHY firmware: https://gitlab.com/kernel-firmware/linux-firmware/-/commit/dcc4a0690ce0e3bcccd3625f79949e7b12c9db01

 drivers/net/ethernet/mediatek/mtk_eth_path.c |  41 +++++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.c  | 114 ++++++++++++++++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h  |  57 +++++++++-
 3 files changed, 196 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_path.c b/drivers/net/ethernet/mediatek/mtk_eth_path.c
index 6fbfb16438a5..e4636a0051e8 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_path.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_path.c
@@ -31,6 +31,8 @@ static const char *mtk_eth_path_name(u64 path)
 		return "gmac2_rgmii";
 	case MTK_ETH_PATH_GMAC2_SGMII:
 		return "gmac2_sgmii";
+	case MTK_ETH_PATH_GMAC2_2P5GPHY:
+		return "gmac2_2p5gphy";
 	case MTK_ETH_PATH_GMAC2_GEPHY:
 		return "gmac2_gephy";
 	case MTK_ETH_PATH_GDM1_ESW:
@@ -127,6 +129,27 @@ static int set_mux_u3_gmac2_to_qphy(struct mtk_eth *eth, u64 path)
 	return 0;
 }
 
+static int set_mux_gmac2_to_2p5gphy(struct mtk_eth *eth, u64 path)
+{
+	int ret;
+
+	if (path == MTK_ETH_PATH_GMAC2_2P5GPHY) {
+		ret = regmap_clear_bits(eth->ethsys, ETHSYS_SYSCFG0, SYSCFG0_SGMII_GMAC2_V2);
+		if (ret)
+			return ret;
+
+		/* Setup mux to 2p5g PHY */
+		ret = regmap_clear_bits(eth->infra, TOP_MISC_NETSYS_PCS_MUX, MUX_G2_USXGMII_SEL);
+		if (ret)
+			return ret;
+
+		dev_dbg(eth->dev, "path %s in %s updated\n",
+			mtk_eth_path_name(path), __func__);
+	}
+
+	return 0;
+}
+
 static int set_mux_gmac1_gmac2_to_sgmii_rgmii(struct mtk_eth *eth, u64 path)
 {
 	unsigned int val = 0;
@@ -209,6 +232,10 @@ static const struct mtk_eth_muxc mtk_eth_muxc[] = {
 		.name = "mux_u3_gmac2_to_qphy",
 		.cap_bit = MTK_ETH_MUX_U3_GMAC2_TO_QPHY,
 		.set_path = set_mux_u3_gmac2_to_qphy,
+	}, {
+		.name = "mux_gmac2_to_2p5gphy",
+		.cap_bit = MTK_ETH_MUX_GMAC2_TO_2P5GPHY,
+		.set_path = set_mux_gmac2_to_2p5gphy,
 	}, {
 		.name = "mux_gmac1_gmac2_to_sgmii_rgmii",
 		.cap_bit = MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII,
@@ -260,6 +287,20 @@ int mtk_gmac_sgmii_path_setup(struct mtk_eth *eth, int mac_id)
 	return mtk_eth_mux_setup(eth, path);
 }
 
+int mtk_gmac_2p5gphy_path_setup(struct mtk_eth *eth, int mac_id)
+{
+	u64 path = 0;
+
+	if (mac_id == MTK_GMAC2_ID)
+		path = MTK_ETH_PATH_GMAC2_2P5GPHY;
+
+	if (!path)
+		return -EINVAL;
+
+	/* Setup proper MUXes along the path */
+	return mtk_eth_mux_setup(eth, path);
+}
+
 int mtk_gmac_gephy_path_setup(struct mtk_eth *eth, int mac_id)
 {
 	u64 path = 0;
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 83068925c589..2c47c09a4fb3 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -503,7 +503,7 @@ static void mtk_gmac0_rgmii_adjust(struct mtk_eth *eth,
 static void mtk_setup_bridge_switch(struct mtk_eth *eth)
 {
 	/* Force Port1 XGMAC Link Up */
-	mtk_m32(eth, 0, MTK_XGMAC_FORCE_LINK(MTK_GMAC1_ID),
+	mtk_m32(eth, 0, MTK_XGMAC_FORCE_MODE(MTK_GMAC1_ID),
 		MTK_XGMAC_STS(MTK_GMAC1_ID));
 
 	/* Adjust GSW bridge IPG to 11 */
@@ -532,6 +532,25 @@ static struct phylink_pcs *mtk_mac_select_pcs(struct phylink_config *config,
 	return NULL;
 }
 
+static int mtk_mac_prepare(struct phylink_config *config, unsigned int mode,
+			   phy_interface_t iface)
+{
+	struct mtk_mac *mac = container_of(config, struct mtk_mac,
+					   phylink_config);
+	struct mtk_eth *eth = mac->hw;
+
+	if (mtk_interface_mode_is_xgmii(eth, iface) && mac->id != MTK_GMAC1_ID) {
+		mtk_m32(mac->hw, XMAC_MCR_TRX_DISABLE,
+			XMAC_MCR_TRX_DISABLE, MTK_XMAC_MCR(mac->id));
+
+		mtk_m32(mac->hw, MTK_XGMAC_FORCE_MODE(mac->id) |
+				 MTK_XGMAC_FORCE_LINK(mac->id),
+			MTK_XGMAC_FORCE_MODE(mac->id), MTK_XGMAC_STS(mac->id));
+	}
+
+	return 0;
+}
+
 static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 			   const struct phylink_link_state *state)
 {
@@ -573,6 +592,12 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 			}
 			break;
 		case PHY_INTERFACE_MODE_INTERNAL:
+			if (mac->id == MTK_GMAC2_ID &&
+			    MTK_HAS_CAPS(eth->soc->caps, MTK_2P5GPHY)) {
+				err = mtk_gmac_2p5gphy_path_setup(eth, mac->id);
+				if (err)
+					goto init_err;
+			}
 			break;
 		default:
 			goto err_phy;
@@ -644,12 +669,12 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 	}
 
 	/* Setup gmac */
-	if (mtk_is_netsys_v3_or_greater(eth) &&
-	    mac->interface == PHY_INTERFACE_MODE_INTERNAL) {
+	if (mtk_interface_mode_is_xgmii(eth, state->interface)) {
 		mtk_w32(mac->hw, MTK_GDMA_XGDM_SEL, MTK_GDMA_EG_CTRL(mac->id));
 		mtk_w32(mac->hw, MAC_MCR_FORCE_LINK_DOWN, MTK_MAC_MCR(mac->id));
 
-		mtk_setup_bridge_switch(eth);
+		if (mac->id == MTK_GMAC1_ID)
+			mtk_setup_bridge_switch(eth);
 	}
 
 	return;
@@ -696,10 +721,19 @@ static void mtk_mac_link_down(struct phylink_config *config, unsigned int mode,
 {
 	struct mtk_mac *mac = container_of(config, struct mtk_mac,
 					   phylink_config);
-	u32 mcr = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 
-	mcr &= ~(MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK);
-	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
+	if (!mtk_interface_mode_is_xgmii(mac->hw, interface)) {
+		/* GMAC modes */
+		mtk_m32(mac->hw,
+			MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK, 0,
+			MTK_MAC_MCR(mac->id));
+	} else if (mac->id != MTK_GMAC1_ID) {
+		/* XGMAC except for built-in switch */
+		mtk_m32(mac->hw, XMAC_MCR_TRX_DISABLE, XMAC_MCR_TRX_DISABLE,
+			MTK_XMAC_MCR(mac->id));
+		mtk_m32(mac->hw, MTK_XGMAC_FORCE_LINK(mac->id), 0,
+			MTK_XGMAC_STS(mac->id));
+	}
 }
 
 static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
@@ -771,13 +805,11 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
 	mtk_w32(eth, val, soc->reg_map->qdma.qtx_sch + ofs);
 }
 
-static void mtk_mac_link_up(struct phylink_config *config,
-			    struct phy_device *phy,
-			    unsigned int mode, phy_interface_t interface,
-			    int speed, int duplex, bool tx_pause, bool rx_pause)
+static void mtk_gdm_mac_link_up(struct mtk_mac *mac,
+				struct phy_device *phy,
+				unsigned int mode, phy_interface_t interface,
+				int speed, int duplex, bool tx_pause, bool rx_pause)
 {
-	struct mtk_mac *mac = container_of(config, struct mtk_mac,
-					   phylink_config);
 	u32 mcr;
 
 	mcr = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
@@ -811,6 +843,53 @@ static void mtk_mac_link_up(struct phylink_config *config,
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
+static void mtk_xgdm_mac_link_up(struct mtk_mac *mac,
+				 struct phy_device *phy,
+				 unsigned int mode, phy_interface_t interface,
+				 int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	u32 mcr;
+
+	if (mac->id == MTK_GMAC1_ID)
+		return;
+
+	/* Eliminate the interference(before link-up) caused by PHY noise */
+	mtk_m32(mac->hw, XMAC_LOGIC_RST, 0, MTK_XMAC_LOGIC_RST(mac->id));
+	mdelay(20);
+	mtk_m32(mac->hw, XMAC_GLB_CNTCLR, XMAC_GLB_CNTCLR, MTK_XMAC_CNT_CTRL(mac->id));
+
+	mtk_m32(mac->hw, MTK_XGMAC_FORCE_LINK(mac->id), MTK_XGMAC_FORCE_LINK(mac->id),
+		MTK_XGMAC_STS(mac->id));
+
+	mcr = mtk_r32(mac->hw, MTK_XMAC_MCR(mac->id));
+	mcr &= ~(XMAC_MCR_FORCE_TX_FC | XMAC_MCR_FORCE_RX_FC | XMAC_MCR_TRX_DISABLE);
+	/* Configure pause modes -
+	 * phylink will avoid these for half duplex
+	 */
+	if (tx_pause)
+		mcr |= XMAC_MCR_FORCE_TX_FC;
+	if (rx_pause)
+		mcr |= XMAC_MCR_FORCE_RX_FC;
+
+	mtk_w32(mac->hw, mcr, MTK_XMAC_MCR(mac->id));
+}
+
+static void mtk_mac_link_up(struct phylink_config *config,
+			    struct phy_device *phy,
+			    unsigned int mode, phy_interface_t interface,
+			    int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct mtk_mac *mac = container_of(config, struct mtk_mac,
+					   phylink_config);
+
+	if (mtk_interface_mode_is_xgmii(mac->hw, interface))
+		mtk_xgdm_mac_link_up(mac, phy, mode, interface, speed, duplex,
+				     tx_pause, rx_pause);
+	else
+		mtk_gdm_mac_link_up(mac, phy, mode, interface, speed, duplex,
+				    tx_pause, rx_pause);
+}
+
 static void mtk_mac_disable_tx_lpi(struct phylink_config *config)
 {
 	struct mtk_mac *mac = container_of(config, struct mtk_mac,
@@ -828,6 +907,9 @@ static int mtk_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 	struct mtk_eth *eth = mac->hw;
 	u32 val;
 
+	if (mtk_interface_mode_is_xgmii(eth, mac->interface))
+		return -EOPNOTSUPP;
+
 	/* Tx idle timer in ms */
 	timer = DIV_ROUND_UP(timer, 1000);
 
@@ -858,6 +940,7 @@ static int mtk_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 }
 
 static const struct phylink_mac_ops mtk_phylink_ops = {
+	.mac_prepare = mtk_mac_prepare,
 	.mac_select_pcs = mtk_mac_select_pcs,
 	.mac_config = mtk_mac_config,
 	.mac_finish = mtk_mac_finish,
@@ -4759,6 +4842,11 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 
 	mac->phylink = phylink;
 
+	if (MTK_HAS_CAPS(mac->hw->soc->caps, MTK_2P5GPHY) &&
+	    id == MTK_GMAC2_ID)
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  mac->phylink_config.supported_interfaces);
+
 	SET_NETDEV_DEV(eth->netdev[id], eth->dev);
 	eth->netdev[id]->watchdog_timeo = 5 * HZ;
 	eth->netdev[id]->netdev_ops = &mtk_netdev_ops;
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 88ef2e9c50fc..e3a8b24dd3d3 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -431,7 +431,8 @@
 
 /* XMAC status registers */
 #define MTK_XGMAC_STS(x)	(((x) == MTK_GMAC3_ID) ? 0x1001C : 0x1000C)
-#define MTK_XGMAC_FORCE_LINK(x)	(((x) == MTK_GMAC2_ID) ? BIT(31) : BIT(15))
+#define MTK_XGMAC_FORCE_MODE(x)	(((x) == MTK_GMAC2_ID) ? BIT(31) : BIT(15))
+#define MTK_XGMAC_FORCE_LINK(x)	(((x) == MTK_GMAC2_ID) ? BIT(27) : BIT(11))
 #define MTK_USXGMII_PCS_LINK	BIT(8)
 #define MTK_XGMAC_RX_FC		BIT(5)
 #define MTK_XGMAC_TX_FC		BIT(4)
@@ -524,6 +525,21 @@
 #define INTF_MODE_RGMII_1000    (TRGMII_MODE | TRGMII_CENTRAL_ALIGNED)
 #define INTF_MODE_RGMII_10_100  0
 
+/* XFI Mac control registers */
+#define MTK_XMAC_BASE(x)	(0x12000 + (((x) - 1) * 0x1000))
+#define MTK_XMAC_MCR(x)		(MTK_XMAC_BASE(x))
+#define XMAC_MCR_TRX_DISABLE	0xf
+#define XMAC_MCR_FORCE_TX_FC	BIT(5)
+#define XMAC_MCR_FORCE_RX_FC	BIT(4)
+
+/* XFI Mac logic reset registers */
+#define MTK_XMAC_LOGIC_RST(x)	(MTK_XMAC_BASE(x) + 0x10)
+#define XMAC_LOGIC_RST		BIT(0)
+
+/* XFI Mac count global control */
+#define MTK_XMAC_CNT_CTRL(x)	(MTK_XMAC_BASE(x) + 0x100)
+#define XMAC_GLB_CNTCLR		BIT(0)
+
 /* GPIO port control registers for GMAC 2*/
 #define GPIO_OD33_CTRL8		0x4c0
 #define GPIO_BIAS_CTRL		0xed0
@@ -587,6 +603,10 @@
 #define GEPHY_MAC_SEL          BIT(1)
 
 /* Top misc registers */
+#define TOP_MISC_NETSYS_PCS_MUX	0x84
+#define NETSYS_PCS_MUX_MASK	GENMASK(1, 0)
+#define MUX_G2_USXGMII_SEL	BIT(1)
+
 #define USB_PHY_SWITCH_REG	0x218
 #define QPHY_SEL_MASK		GENMASK(1, 0)
 #define SGMII_QPHY_SEL		0x2
@@ -951,6 +971,7 @@ enum mkt_eth_capabilities {
 	MTK_RGMII_BIT = 0,
 	MTK_TRGMII_BIT,
 	MTK_SGMII_BIT,
+	MTK_2P5GPHY_BIT,
 	MTK_ESW_BIT,
 	MTK_GEPHY_BIT,
 	MTK_MUX_BIT,
@@ -971,8 +992,10 @@ enum mkt_eth_capabilities {
 	MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT,
 	MTK_ETH_MUX_GMAC2_GMAC0_TO_GEPHY_BIT,
 	MTK_ETH_MUX_U3_GMAC2_TO_QPHY_BIT,
+	MTK_ETH_MUX_GMAC2_TO_2P5GPHY_BIT,
 	MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII_BIT,
 	MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII_BIT,
+	MTK_ETH_MUX_GMAC123_TO_GEPHY_SGMII_BIT,
 
 	/* PATH BITS */
 	MTK_ETH_PATH_GMAC1_RGMII_BIT,
@@ -980,6 +1003,7 @@ enum mkt_eth_capabilities {
 	MTK_ETH_PATH_GMAC1_SGMII_BIT,
 	MTK_ETH_PATH_GMAC2_RGMII_BIT,
 	MTK_ETH_PATH_GMAC2_SGMII_BIT,
+	MTK_ETH_PATH_GMAC2_2P5GPHY_BIT,
 	MTK_ETH_PATH_GMAC2_GEPHY_BIT,
 	MTK_ETH_PATH_GDM1_ESW_BIT,
 };
@@ -988,6 +1012,7 @@ enum mkt_eth_capabilities {
 #define MTK_RGMII		BIT_ULL(MTK_RGMII_BIT)
 #define MTK_TRGMII		BIT_ULL(MTK_TRGMII_BIT)
 #define MTK_SGMII		BIT_ULL(MTK_SGMII_BIT)
+#define MTK_2P5GPHY		BIT_ULL(MTK_2P5GPHY_BIT)
 #define MTK_ESW			BIT_ULL(MTK_ESW_BIT)
 #define MTK_GEPHY		BIT_ULL(MTK_GEPHY_BIT)
 #define MTK_MUX			BIT_ULL(MTK_MUX_BIT)
@@ -1010,6 +1035,8 @@ enum mkt_eth_capabilities {
 	BIT_ULL(MTK_ETH_MUX_GMAC2_GMAC0_TO_GEPHY_BIT)
 #define MTK_ETH_MUX_U3_GMAC2_TO_QPHY		\
 	BIT_ULL(MTK_ETH_MUX_U3_GMAC2_TO_QPHY_BIT)
+#define MTK_ETH_MUX_GMAC2_TO_2P5GPHY		\
+	BIT_ULL(MTK_ETH_MUX_GMAC2_TO_2P5GPHY_BIT)
 #define MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII	\
 	BIT_ULL(MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII_BIT)
 #define MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII	\
@@ -1021,6 +1048,7 @@ enum mkt_eth_capabilities {
 #define MTK_ETH_PATH_GMAC1_SGMII	BIT_ULL(MTK_ETH_PATH_GMAC1_SGMII_BIT)
 #define MTK_ETH_PATH_GMAC2_RGMII	BIT_ULL(MTK_ETH_PATH_GMAC2_RGMII_BIT)
 #define MTK_ETH_PATH_GMAC2_SGMII	BIT_ULL(MTK_ETH_PATH_GMAC2_SGMII_BIT)
+#define MTK_ETH_PATH_GMAC2_2P5GPHY	BIT_ULL(MTK_ETH_PATH_GMAC2_2P5GPHY_BIT)
 #define MTK_ETH_PATH_GMAC2_GEPHY	BIT_ULL(MTK_ETH_PATH_GMAC2_GEPHY_BIT)
 #define MTK_ETH_PATH_GDM1_ESW		BIT_ULL(MTK_ETH_PATH_GDM1_ESW_BIT)
 
@@ -1030,6 +1058,7 @@ enum mkt_eth_capabilities {
 #define MTK_GMAC2_RGMII		(MTK_ETH_PATH_GMAC2_RGMII | MTK_RGMII)
 #define MTK_GMAC2_SGMII		(MTK_ETH_PATH_GMAC2_SGMII | MTK_SGMII)
 #define MTK_GMAC2_GEPHY		(MTK_ETH_PATH_GMAC2_GEPHY | MTK_GEPHY)
+#define MTK_GMAC2_2P5GPHY	(MTK_ETH_PATH_GMAC2_2P5GPHY | MTK_2P5GPHY)
 #define MTK_GDM1_ESW		(MTK_ETH_PATH_GDM1_ESW | MTK_ESW)
 
 /* MUXes present on SoCs */
@@ -1049,6 +1078,10 @@ enum mkt_eth_capabilities {
 	(MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII | MTK_MUX | \
 	MTK_SHARED_SGMII)
 
+/* 2: GMAC2 -> 2P5GPHY */
+#define MTK_MUX_GMAC2_TO_2P5GPHY      \
+	(MTK_ETH_MUX_GMAC2_TO_2P5GPHY | MTK_MUX | MTK_INFRA)
+
 /* 0: GMACx -> GEPHY, 1: GMACx -> SGMII where x is 1 or 2 */
 #define MTK_MUX_GMAC12_TO_GEPHY_SGMII   \
 	(MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII | MTK_MUX)
@@ -1084,8 +1117,9 @@ enum mkt_eth_capabilities {
 		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
 		      MTK_RSTCTRL_PPE1 | MTK_SRAM)
 
-#define MT7988_CAPS  (MTK_36BIT_DMA | MTK_GDM1_ESW | MTK_QDMA | \
-		      MTK_RSTCTRL_PPE1 | MTK_RSTCTRL_PPE2 | MTK_SRAM)
+#define MT7988_CAPS  (MTK_36BIT_DMA | MTK_GDM1_ESW | MTK_GMAC2_2P5GPHY | \
+		      MTK_MUX_GMAC2_TO_2P5GPHY | MTK_QDMA | MTK_RSTCTRL_PPE1 | \
+		      MTK_RSTCTRL_PPE2 | MTK_SRAM)
 
 struct mtk_tx_dma_desc_info {
 	dma_addr_t	addr;
@@ -1437,6 +1471,22 @@ static inline u32 mtk_get_ib2_multicast_mask(struct mtk_eth *eth)
 	return MTK_FOE_IB2_MULTICAST;
 }
 
+static inline bool mtk_interface_mode_is_xgmii(struct mtk_eth *eth, phy_interface_t interface)
+{
+	if (!mtk_is_netsys_v3_or_greater(eth))
+		return false;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_INTERNAL:
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_5GBASER:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /* read the hardware status register */
 void mtk_stats_update_mac(struct mtk_mac *mac);
 
@@ -1445,6 +1495,7 @@ u32 mtk_r32(struct mtk_eth *eth, unsigned reg);
 u32 mtk_m32(struct mtk_eth *eth, u32 mask, u32 set, unsigned int reg);
 
 int mtk_gmac_sgmii_path_setup(struct mtk_eth *eth, int mac_id);
+int mtk_gmac_2p5gphy_path_setup(struct mtk_eth *eth, int mac_id);
 int mtk_gmac_gephy_path_setup(struct mtk_eth *eth, int mac_id);
 int mtk_gmac_rgmii_path_setup(struct mtk_eth *eth, int mac_id);
 
-- 
2.49.0


