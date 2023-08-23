Return-Path: <netdev+bounces-29886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D03785067
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631011C20CAF
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 06:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED276FBF;
	Wed, 23 Aug 2023 06:10:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D67620F16
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:10:50 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54175CF1
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 23:10:48 -0700 (PDT)
X-QQ-mid: bizesmtp73t1692770856twrqippu
Received: from wxdbg.localdomain.com ( [60.177.96.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Aug 2023 14:07:35 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: bhet8yMU7vnQalcTub9pSGX8vh1/KYHCFLby6OxMTwYUqa3SKYsd2hCi07UdC
	hq+MlJXBk7CehDoRP8zgm9WhNPDHKGzv2kBelBZM2N77CJP7OA0/sdlPIFl3ryyzPCcoj2u
	d5fyCWJBpXfxURT7haLCG++UCOA8/ODW7MtlLKYL2KKIOD1nQmj/izLTVLZ7jAPr9ICHi04
	zAeURZTo45X861BULcC6G4Fb1xqYY+DsJnFmnrKOpMb6Gj7tUmR6+NhO4rJTTvk2kxch52U
	kgfz+Nck5G/UV1GL+YoLCUwldYdSBUKsuAP93wjofgPmRFSWIJ0vdV4f5jGiVvBsgA8p7ow
	Pd8mIhbJmzupBoMMlsCLz6qHpxf6ydxh8wgM+qZDYzFAnQdiEzytq07HVDAYEfvi0pyO4hj
	f2WGRNUJH4M=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5930406382509453443
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com,
	rmk+kernel@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 6/8] net: txgbe: support switching mode to 1000BASE-X and SGMII
Date: Wed, 23 Aug 2023 14:19:33 +0800
Message-Id: <20230823061935.415804-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230823061935.415804-1-jiawenwu@trustnetic.com>
References: <20230823061935.415804-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Disable data path before PCS VR reset while switching PCS mode, to prevent
the blocking of data path. Enable AN interrupt for CL37 auto-negotiation.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  2 ++
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c | 28 +++++++++++++++++
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h |  2 ++
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 30 ++++++++++++++++++-
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 1de88a33a698..50b92cfb46a0 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -205,6 +205,8 @@
 #define WX_TSC_CTL                   0x1D000
 #define WX_TSC_CTL_TX_DIS            BIT(1)
 #define WX_TSC_CTL_TSEC_DIS          BIT(0)
+#define WX_TSC_ST                    0x1D004
+#define WX_TSC_ST_SECTX_RDY          BIT(0)
 #define WX_TSC_BUF_AE                0x1D00C
 #define WX_TSC_BUF_AE_THR            GENMASK(9, 0)
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
index 6e130d1f7a7b..90168aab11ae 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -13,6 +13,34 @@
 #include "txgbe_type.h"
 #include "txgbe_hw.h"
 
+/**
+ *  txgbe_disable_sec_tx_path - Stops the transmit data path
+ *  @wx: pointer to hardware structure
+ *
+ *  Stops the transmit data path and waits for the HW to internally empty
+ *  the tx security block
+ **/
+int txgbe_disable_sec_tx_path(struct wx *wx)
+{
+	int val;
+
+	wr32m(wx, WX_TSC_CTL, WX_TSC_CTL_TX_DIS, WX_TSC_CTL_TX_DIS);
+	return read_poll_timeout(rd32, val, val & WX_TSC_ST_SECTX_RDY,
+				 1000, 20000, false, wx, WX_TSC_ST);
+}
+
+/**
+ *  txgbe_enable_sec_tx_path - Enables the transmit data path
+ *  @wx: pointer to hardware structure
+ *
+ *  Enables the transmit data path.
+ **/
+void txgbe_enable_sec_tx_path(struct wx *wx)
+{
+	wr32m(wx, WX_TSC_CTL, WX_TSC_CTL_TX_DIS, 0);
+	WX_WRITE_FLUSH(wx);
+}
+
 /**
  *  txgbe_init_thermal_sensor_thresh - Inits thermal sensor thresholds
  *  @wx: pointer to hardware structure
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h
index e82f65dff8a6..abc729eb187a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h
@@ -4,6 +4,8 @@
 #ifndef _TXGBE_HW_H_
 #define _TXGBE_HW_H_
 
+int txgbe_disable_sec_tx_path(struct wx *wx);
+void txgbe_enable_sec_tx_path(struct wx *wx);
 int txgbe_read_pba_string(struct wx *wx, u8 *pba_num, u32 pba_num_size);
 int txgbe_validate_eeprom_checksum(struct wx *wx, u16 *checksum_val);
 int txgbe_reset_hw(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 819d1db34643..d2124547394d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -18,6 +18,7 @@
 #include "../libwx/wx_hw.h"
 #include "txgbe_type.h"
 #include "txgbe_phy.h"
+#include "txgbe_hw.h"
 
 static int txgbe_swnodes_register(struct txgbe *txgbe)
 {
@@ -210,8 +211,32 @@ static void txgbe_mac_link_up(struct phylink_config *config,
 	wr32(wx, WX_MAC_WDG_TIMEOUT, wdg);
 }
 
+static int txgbe_mac_prepare(struct phylink_config *config, unsigned int mode,
+			     phy_interface_t interface)
+{
+	struct wx *wx = netdev_priv(to_net_dev(config->dev));
+
+	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
+	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
+
+	return txgbe_disable_sec_tx_path(wx);
+}
+
+static int txgbe_mac_finish(struct phylink_config *config, unsigned int mode,
+			    phy_interface_t interface)
+{
+	struct wx *wx = netdev_priv(to_net_dev(config->dev));
+
+	txgbe_enable_sec_tx_path(wx);
+	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, WX_MAC_RX_CFG_RE);
+
+	return 0;
+}
+
 static const struct phylink_mac_ops txgbe_mac_ops = {
 	.mac_select_pcs = txgbe_phylink_mac_select,
+	.mac_prepare = txgbe_mac_prepare,
+	.mac_finish = txgbe_mac_finish,
 	.mac_config = txgbe_mac_config,
 	.mac_link_down = txgbe_mac_link_down,
 	.mac_link_up = txgbe_mac_link_up,
@@ -234,6 +259,8 @@ static int txgbe_phylink_init(struct txgbe *txgbe)
 	config->mac_capabilities = MAC_10000FD | MAC_1000FD | MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
 	phy_mode = PHY_INTERFACE_MODE_10GBASER;
 	__set_bit(PHY_INTERFACE_MODE_10GBASER, config->supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, config->supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII, config->supported_interfaces);
 	fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_PHYLINK]);
 	phylink = phylink_create(config, fwnode, phy_mode, &txgbe_mac_ops);
 	if (IS_ERR(phylink))
@@ -431,7 +458,8 @@ static void txgbe_irq_handler(struct irq_desc *desc)
 
 	chained_irq_exit(chip, desc);
 
-	if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN)) {
+	if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN |
+		    TXGBE_PX_MISC_ETH_AN)) {
 		u32 reg = rd32(wx, TXGBE_CFG_PORT_ST);
 
 		phylink_mac_change(txgbe->phylink, !!(reg & TXGBE_CFG_PORT_ST_LINK_UP));
-- 
2.27.0


