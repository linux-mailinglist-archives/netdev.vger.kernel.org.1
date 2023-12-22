Return-Path: <netdev+bounces-59875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F6C81C810
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 11:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A70C287150
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951041173C;
	Fri, 22 Dec 2023 10:23:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1E12B65
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp84t1703240527tm0hb4u6
Received: from wxdbg.localdomain.com ( [125.119.246.92])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Dec 2023 18:22:06 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: /15IGBtyjqODP/1szwLzWpxODfxjRfMSwtB6TbfHly8sId0L931RYCyp4r9Hn
	QLaK0LrdFZ1M8/N/7U6+pKoAWpWw4stpW+tAXzvpsOtAGfOolcAiIvZW7KNKhB43EJYvYTL
	zSUeZ3elYie7Dq9UT7VmDIdae817mbzO9l/Pq92QKxO+cfgkQMfIIL1lXly30RiUymUvQQF
	9zu3XTAeM2M07Esw1YDNI/zHO8ziL9qmKDX8ppvJVNcdXJdGlQntgJV4jsPVxlRegEZrJl1
	9KQu1vLZs1GTD9BlU0kpCGcvtQbTL3wUw95mUcng/HBZgichkithJ8ZzKuQIcjHu7C9JOMk
	KZpoVKTIwOGz9hwXZ+d5LqSFtEQtKL2h4ck5XtvUTKs0me3y2JfaP7yNePHbHnd90QHf7Ez
	GHb06TqHqOk=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10760202948367290
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 4/8] net: wangxun: add flow control support
Date: Fri, 22 Dec 2023 18:16:35 +0800
Message-Id: <20231222101639.1499997-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231222101639.1499997-1-jiawenwu@trustnetic.com>
References: <20231222101639.1499997-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

Add support to set pause params with ethtool -A and get pause
params with ethtool -a, for ethernet driver txgbe and ngbe.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  18 ++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 172 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  48 +++++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   2 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   2 +
 9 files changed, 251 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index ba37ba6f03e4..e010303174df 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -211,3 +211,21 @@ int wx_set_link_ksettings(struct net_device *netdev,
 	return phylink_ethtool_ksettings_set(wx->phylink, cmd);
 }
 EXPORT_SYMBOL(wx_set_link_ksettings);
+
+void wx_get_pauseparam(struct net_device *netdev,
+		       struct ethtool_pauseparam *pause)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	phylink_ethtool_get_pauseparam(wx->phylink, pause);
+}
+EXPORT_SYMBOL(wx_get_pauseparam);
+
+int wx_set_pauseparam(struct net_device *netdev,
+		      struct ethtool_pauseparam *pause)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	return phylink_ethtool_set_pauseparam(wx->phylink, pause);
+}
+EXPORT_SYMBOL(wx_set_pauseparam);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index f15cc445ae0f..7d3d85f212eb 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -18,4 +18,8 @@ int wx_get_link_ksettings(struct net_device *netdev,
 			  struct ethtool_link_ksettings *cmd);
 int wx_set_link_ksettings(struct net_device *netdev,
 			  const struct ethtool_link_ksettings *cmd);
+void wx_get_pauseparam(struct net_device *netdev,
+		       struct ethtool_pauseparam *pause);
+int wx_set_pauseparam(struct net_device *netdev,
+		      struct ethtool_pauseparam *pause);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 533e912af089..d11f7d8db194 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1158,6 +1158,81 @@ static void wx_set_rxpba(struct wx *wx)
 	wr32(wx, WX_TDM_PB_THRE(0), txpbthresh);
 }
 
+#define WX_ETH_FRAMING 20
+
+/**
+ * wx_hpbthresh - calculate high water mark for flow control
+ *
+ * @wx: board private structure to calculate for
+ **/
+static int wx_hpbthresh(struct wx *wx)
+{
+	struct net_device *dev = wx->netdev;
+	int link, tc, kb, marker;
+	u32 dv_id, rx_pba;
+
+	/* Calculate max LAN frame size */
+	link = dev->mtu + ETH_HLEN + ETH_FCS_LEN + WX_ETH_FRAMING;
+	tc = link;
+
+	/* Calculate delay value for device */
+	dv_id = WX_DV(link, tc);
+
+	/* Delay value is calculated in bit times convert to KB */
+	kb = WX_BT2KB(dv_id);
+	rx_pba = rd32(wx, WX_RDB_PB_SZ(0)) >> WX_RDB_PB_SZ_SHIFT;
+
+	marker = rx_pba - kb;
+
+	/* It is possible that the packet buffer is not large enough
+	 * to provide required headroom. In this case throw an error
+	 * to user and a do the best we can.
+	 */
+	if (marker < 0) {
+		dev_warn(&wx->pdev->dev,
+			 "Packet Buffer can not provide enough headroom to support flow control. Decrease MTU or number of traffic classes\n");
+		marker = tc + 1;
+	}
+
+	return marker;
+}
+
+/**
+ * wx_lpbthresh - calculate low water mark for flow control
+ *
+ * @wx: board private structure to calculate for
+ **/
+static int wx_lpbthresh(struct wx *wx)
+{
+	struct net_device *dev = wx->netdev;
+	u32 dv_id;
+	int tc;
+
+	/* Calculate max LAN frame size */
+	tc = dev->mtu + ETH_HLEN + ETH_FCS_LEN;
+
+	/* Calculate delay value for device */
+	dv_id = WX_LOW_DV(tc);
+
+	/* Delay value is calculated in bit times convert to KB */
+	return WX_BT2KB(dv_id);
+}
+
+/**
+ * wx_pbthresh_setup - calculate and setup high low water marks
+ *
+ * @wx: board private structure to calculate for
+ **/
+static void wx_pbthresh_setup(struct wx *wx)
+{
+	wx->fc.high_water = wx_hpbthresh(wx);
+	wx->fc.low_water = wx_lpbthresh(wx);
+
+	/* Low water marks must not be larger than high water marks */
+	if (wx->fc.low_water > wx->fc.high_water)
+		wx->fc.low_water = 0;
+}
+
 static void wx_configure_port(struct wx *wx)
 {
 	u32 value, i;
@@ -1584,6 +1659,7 @@ static void wx_configure_isb(struct wx *wx)
 void wx_configure(struct wx *wx)
 {
 	wx_set_rxpba(wx);
+	wx_pbthresh_setup(wx);
 	wx_configure_port(wx);
 
 	wx_set_rx_mode(wx->netdev);
@@ -2003,6 +2079,102 @@ int wx_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
 }
 EXPORT_SYMBOL(wx_vlan_rx_kill_vid);
 
+static void wx_enable_rx_drop(struct wx *wx, struct wx_ring *ring)
+{
+	u16 reg_idx = ring->reg_idx;
+	u32 srrctl;
+
+	srrctl = rd32(wx, WX_PX_RR_CFG(reg_idx));
+	srrctl |= WX_PX_RR_CFG_DROP_EN;
+
+	wr32(wx, WX_PX_RR_CFG(reg_idx), srrctl);
+}
+
+static void wx_disable_rx_drop(struct wx *wx, struct wx_ring *ring)
+{
+	u16 reg_idx = ring->reg_idx;
+	u32 srrctl;
+
+	srrctl = rd32(wx, WX_PX_RR_CFG(reg_idx));
+	srrctl &= ~WX_PX_RR_CFG_DROP_EN;
+
+	wr32(wx, WX_PX_RR_CFG(reg_idx), srrctl);
+}
+
+int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause)
+{
+	u16 pause_time = WX_DEFAULT_FCPAUSE;
+	u32 mflcn_reg, fccfg_reg, reg;
+	u32 fcrtl, fcrth;
+	int i;
+
+	/* Low water mark of zero causes XOFF floods */
+	if (tx_pause && wx->fc.high_water) {
+		if (!wx->fc.low_water || wx->fc.low_water >= wx->fc.high_water) {
+			wx_err(wx, "Invalid water mark configuration\n");
+			return -EINVAL;
+		}
+	}
+
+	/* Disable any previous flow control settings */
+	mflcn_reg = rd32(wx, WX_MAC_RX_FLOW_CTRL);
+	mflcn_reg &= ~WX_MAC_RX_FLOW_CTRL_RFE;
+
+	fccfg_reg = rd32(wx, WX_RDB_RFCC);
+	fccfg_reg &= ~WX_RDB_RFCC_RFCE_802_3X;
+
+	if (rx_pause)
+		mflcn_reg |= WX_MAC_RX_FLOW_CTRL_RFE;
+	if (tx_pause)
+		fccfg_reg |= WX_RDB_RFCC_RFCE_802_3X;
+
+	/* Set 802.3x based flow control settings. */
+	wr32(wx, WX_MAC_RX_FLOW_CTRL, mflcn_reg);
+	wr32(wx, WX_RDB_RFCC, fccfg_reg);
+
+	/* Set up and enable Rx high/low water mark thresholds, enable XON. */
+	if (tx_pause && wx->fc.high_water) {
+		fcrtl = (wx->fc.low_water << 10) | WX_RDB_RFCL_XONE;
+		wr32(wx, WX_RDB_RFCL, fcrtl);
+		fcrth = (wx->fc.high_water << 10) | WX_RDB_RFCH_XOFFE;
+	} else {
+		wr32(wx, WX_RDB_RFCL, 0);
+		/* In order to prevent Tx hangs when the internal Tx
+		 * switch is enabled we must set the high water mark
+		 * to the Rx packet buffer size - 24KB.  This allows
+		 * the Tx switch to function even under heavy Rx
+		 * workloads.
+		 */
+		fcrth = rd32(wx, WX_RDB_PB_SZ(0)) - 24576;
+	}
+
+	wr32(wx, WX_RDB_RFCH, fcrth);
+
+	/* Configure pause time */
+	reg = pause_time * 0x00010001;
+	wr32(wx, WX_RDB_RFCV, reg);
+
+	/* Configure flow control refresh threshold value */
+	wr32(wx, WX_RDB_RFCRT, pause_time / 2);
+
+	/*  We should set the drop enable bit if:
+	 *  Number of Rx queues > 1 and flow control is disabled
+	 *
+	 *  This allows us to avoid head of line blocking for security
+	 *  and performance reasons.
+	 */
+	if (wx->num_rx_queues > 1 && !tx_pause) {
+		for (i = 0; i < wx->num_rx_queues; i++)
+			wx_enable_rx_drop(wx, wx->rx_ring[i]);
+	} else {
+		for (i = 0; i < wx->num_rx_queues; i++)
+			wx_disable_rx_drop(wx, wx->rx_ring[i]);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_fc_enable);
+
 /**
  * wx_update_stats - Update the board statistics counters.
  * @wx: board private structure
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 12c20a7c364d..9e219fa717a2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -41,6 +41,7 @@ int wx_get_pcie_msix_counts(struct wx *wx, u16 *msix_count, u16 max_msix_count);
 int wx_sw_init(struct wx *wx);
 int wx_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid);
 int wx_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid);
+int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause);
 void wx_update_stats(struct wx *wx);
 void wx_clear_hw_cntrs(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 5b064c434053..561f752defec 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -131,6 +131,15 @@
 #define WX_RDB_PFCMACDAH             0x19214
 #define WX_RDB_LXOFFTXC              0x19218
 #define WX_RDB_LXONTXC               0x1921C
+/* Flow Control Registers */
+#define WX_RDB_RFCV                  0x19200
+#define WX_RDB_RFCL                  0x19220
+#define WX_RDB_RFCL_XONE             BIT(31)
+#define WX_RDB_RFCH                  0x19260
+#define WX_RDB_RFCH_XOFFE            BIT(31)
+#define WX_RDB_RFCRT                 0x192A0
+#define WX_RDB_RFCC                  0x192A4
+#define WX_RDB_RFCC_RFCE_802_3X      BIT(3)
 /* ring assignment */
 #define WX_RDB_PL_CFG(_i)            (0x19300 + ((_i) * 4))
 #define WX_RDB_PL_CFG_L4HDR          BIT(1)
@@ -331,6 +340,7 @@ enum WX_MSCA_CMD_value {
 #define WX_PX_MPRC(_i)               (0x01020 + ((_i) * 0x40))
 /* PX_RR_CFG bit definitions */
 #define WX_PX_RR_CFG_VLAN            BIT(31)
+#define WX_PX_RR_CFG_DROP_EN         BIT(30)
 #define WX_PX_RR_CFG_SPLIT_MODE      BIT(26)
 #define WX_PX_RR_CFG_RR_THER_SHIFT   16
 #define WX_PX_RR_CFG_RR_HDR_SZ       GENMASK(15, 12)
@@ -368,6 +378,38 @@ enum WX_MSCA_CMD_value {
 #define WX_MAC_STATE_MODIFIED        0x2
 #define WX_MAC_STATE_IN_USE          0x4
 
+/* BitTimes (BT) conversion */
+#define WX_BT2KB(BT)         (((BT) + (8 * 1024 - 1)) / (8 * 1024))
+#define WX_B2BT(BT)          ((BT) * 8)
+
+/* Calculate Delay to respond to PFC */
+#define WX_PFC_D     672
+/* Calculate Cable Delay */
+#define WX_CABLE_DC  5556 /* Delay Copper */
+/* Calculate Delay incurred from higher layer */
+#define WX_HD        6144
+
+/* Calculate Interface Delay */
+#define WX_PHY_D     12800
+#define WX_MAC_D     4096
+#define WX_XAUI_D    (2 * 1024)
+#define WX_ID        (WX_MAC_D + WX_XAUI_D + WX_PHY_D)
+/* Calculate PCI Bus delay for low thresholds */
+#define WX_PCI_DELAY 10000
+
+/* Calculate delay value in bit times */
+#define WX_DV(_max_frame_link, _max_frame_tc) \
+	((36 * (WX_B2BT(_max_frame_link) + WX_PFC_D + \
+		(2 * WX_CABLE_DC) + (2 * WX_ID) + WX_HD) / 25 + 1) + \
+	 2 * WX_B2BT(_max_frame_tc))
+
+/* Calculate low threshold delay values */
+#define WX_LOW_DV(_max_frame_tc) \
+	(2 * (2 * WX_B2BT(_max_frame_tc) + (36 * WX_PCI_DELAY / 25) + 1))
+
+/* flow control */
+#define WX_DEFAULT_FCPAUSE           0xFFFF
+
 #define WX_MAX_RXD                   8192
 #define WX_MAX_TXD                   8192
 
@@ -880,6 +922,11 @@ enum wx_isb_idx {
 	WX_ISB_MAX
 };
 
+struct wx_fc_info {
+	u32 high_water; /* Flow Ctrl High-water */
+	u32 low_water; /* Flow Ctrl Low-water */
+};
+
 /* Statistics counters collected by the MAC */
 struct wx_hw_stats {
 	u64 gprc;
@@ -920,6 +967,7 @@ struct wx {
 	enum sp_media_type media_type;
 	struct wx_eeprom_info eeprom;
 	struct wx_addr_filter_info addr_ctrl;
+	struct wx_fc_info fc;
 	struct wx_mac_addr *mac_table;
 	u16 device_id;
 	u16 vendor_id;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 0f87898a55b2..9a89f9576180 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -54,6 +54,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.get_ethtool_stats	= wx_get_ethtool_stats,
 	.get_eth_mac_stats	= wx_get_mac_stats,
 	.get_pause_stats	= wx_get_pause_stats,
+	.get_pauseparam		= wx_get_pauseparam,
+	.set_pauseparam		= wx_set_pauseparam,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index cc75856f231a..ec54b18c5fe7 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -75,6 +75,8 @@ static void ngbe_mac_link_up(struct phylink_config *config,
 	struct wx *wx = phylink_to_wx(config);
 	u32 lan_speed, reg;
 
+	wx_fc_enable(wx, tx_pause, rx_pause);
+
 	switch (speed) {
 	case SPEED_10:
 		lan_speed = 0;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 60f351a3b89d..cdaa19528248 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -21,6 +21,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_ethtool_stats	= wx_get_ethtool_stats,
 	.get_eth_mac_stats	= wx_get_mac_stats,
 	.get_pause_stats	= wx_get_pause_stats,
+	.get_pauseparam		= wx_get_pauseparam,
+	.set_pauseparam		= wx_set_pauseparam,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 3c0524d19866..b1b5cdc04a92 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -190,6 +190,8 @@ static void txgbe_mac_link_up(struct phylink_config *config,
 	struct wx *wx = phylink_to_wx(config);
 	u32 txcfg, wdg;
 
+	wx_fc_enable(wx, tx_pause, rx_pause);
+
 	txcfg = rd32(wx, WX_MAC_TX_CFG);
 	txcfg &= ~WX_MAC_TX_CFG_SPEED_MASK;
 
-- 
2.27.0


