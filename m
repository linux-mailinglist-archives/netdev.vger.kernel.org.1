Return-Path: <netdev+bounces-192171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0D2ABEC5D
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8334E2A48
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A3023AE95;
	Wed, 21 May 2025 06:46:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DBA23A99D
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809960; cv=none; b=SVcDgG13ro7Is8TWqnl/ZQOZNDUO7IAszoWN59W6nMgIRvLAbo7BhuputlGHRL7jRng3pQVfxKy8hFVEHbsXva9nmXHscjTxTR8lcadJ4dV5ibUUH+HeRLlBwGVGGcmAHoLLyQaCSnCgyPdQ1Ta+a0UDhusZLR3QW3W2xFkuuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809960; c=relaxed/simple;
	bh=D3Rsbm1lt0rGOlENAEsweM0DM+tYng8U2hth+BMA/yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkDFt0hSgqxyqi9+kK9BBw6Rhq3XGzl930JH2zCf7/vytQs2RNAlzNDNwRULS5oSa2C4DhWdvkZGZDqBm64a32vcJ4L4u+hIvEdmviQ6ImmUubVRSKe41dtJ5cu5uZ1UlHONgQNHWQ1rSn8PJHBTWkzJC3uBCSLF0KqumlNgsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1747809872tebb64a71
X-QQ-Originating-IP: 1xGX3tGbiQpoYO6B00OlYTRLk0q/6j3SuEmuGS5aU/A=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 May 2025 14:44:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11841717698249876863
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 4/9] net: txgbe: Implement PHYLINK for AML 25G/10G devices
Date: Wed, 21 May 2025 14:43:57 +0800
Message-ID: <987B973A5929CD48+20250521064402.22348-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250521064402.22348-1-jiawenwu@trustnetic.com>
References: <20250521064402.22348-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MIGBBOK2RQC4Dr04u81HMuqR1MN6yNAwkte6BhJrJBDr6IHIW17CGEdy
	N3Thf5oW0TjW5ub97fNlNciobGrSh9UzcA7vBhWcUVdhQ9KMOZOydG5YrXKO+3q1rh+OWa7
	H8by7e9TwcDt4z5lZDz10soGnh0P2T7n3GnU24Jo+kprR777hIvvxbVkwjOWZXVTuvq+dmI
	PylK96YVcx0wE9DjmTbeLsr527OtIYIhgUG1YiKvzpy89eGqNdmBdf7Pcjy/jNBw+VpvtPr
	XDin+B9gBJrVMtiaNstJ7QERZCCeZ32eAJo20k9mGjhTEaqu5s2TPW1tB4CnL7GZkGY4NkR
	vVyJ7q7tqLF45vziFx1RRqZojCYlVwW7NAknY5IMffQoWd3oHTenEKcNk6Rp+O1qaKlNx+h
	QpomtIn7b5SeFr0ubujIBD4YTazinsUPNVyh7c4Jtiwuu7ssK5INa7nYntVsA4PSVIQGJOG
	gb8/deIBUFV4rnNKJH0rbbg1CCAnWVq0/y3/7gBHgZJGFynRrWvtb8+H52Af5S27qCcxX2i
	rwZy338bJ+TKnbMkXxt6iiKmKmCFdBpeU+LSkPMDyIHw8bAY9WQcLNWI2MKJ6DRIk//HVSb
	LqTJrnW7LqJBbVLx9OoUknRLNbOYAFXx9YntSxRmn5IZXUN4zJ4VJX3bW67P/yzy7+FjneV
	xKIWZ/xvyg7C1qOYycIIhA1/aRk6dsN38hA7Up/Ou0DgqNBC1kicbWHkxUhjklKXNmpnb2G
	HwFcDQwlcXAkEQOx0Sr5eCqBg6hn8kTRioTWTiIj7MKnkf4+DdiX8kTBT8eHoVZXDYYexwH
	Ro+pZM45FSKBvtsKwXk0NH3qRx9e813FRyuRM1YsxwqdyL3KR95LYZ6YMf+q6COASSBue4x
	nXmJ6ILr+CQlxNcjCjYwX7PLW2u272mCoEAd41eyjNo2nX0uvxARANblxGaW+PVMmaTHjrZ
	JU0drqEzaA8lEEnlC2LCbRz/UkPM64BlaPbT+GwhQesyYK1U1jN5IG6+JZ5VoT3hXNBMzeJ
	p28vT68/C3IZD+Sp12h4gtalitRgCQ5VsqGWNWjktKK0jAVcqm
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

There is a new PHY attached to AML 25G/10G NIC, which is different from
SP 10G/1G NIC. But the PHY configuration is handed over to firmware, and
also I2C is controlled by firmware. So the different PHYLINK fixed-link
mode is added for these devices.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  12 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
 drivers/net/ethernet/wangxun/txgbe/Makefile   |   3 +-
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 154 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |   9 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  11 +-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  11 ++
 7 files changed, 195 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 7a3467b41524..c6744a363e97 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2252,10 +2252,8 @@ int wx_stop_adapter(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_stop_adapter);
 
-void wx_reset_misc(struct wx *wx)
+void wx_reset_mac(struct wx *wx)
 {
-	int i;
-
 	/* receive packets that size > 2048 */
 	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_JE, WX_MAC_RX_CFG_JE);
 
@@ -2267,6 +2265,14 @@ void wx_reset_misc(struct wx *wx)
 	      WX_MAC_RX_FLOW_CTRL_RFE, WX_MAC_RX_FLOW_CTRL_RFE);
 
 	wr32(wx, WX_MAC_PKT_FLT, WX_MAC_PKT_FLT_PR);
+}
+EXPORT_SYMBOL(wx_reset_mac);
+
+void wx_reset_misc(struct wx *wx)
+{
+	int i;
+
+	wx_reset_mac(wx);
 
 	wr32m(wx, WX_MIS_RST_ST,
 	      WX_MIS_RST_ST_RST_INIT, 0x1E00);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 91c1d6135045..26a56cba60b9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -42,6 +42,7 @@ void wx_configure(struct wx *wx);
 void wx_start_hw(struct wx *wx);
 int wx_disable_pcie_master(struct wx *wx);
 int wx_stop_adapter(struct wx *wx);
+void wx_reset_mac(struct wx *wx);
 void wx_reset_misc(struct wx *wx);
 int wx_get_pcie_msix_counts(struct wx *wx, u16 *msix_count, u16 max_msix_count);
 int wx_sw_init(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/Makefile b/drivers/net/ethernet/wangxun/txgbe/Makefile
index f74576fe7062..c757fa95e58e 100644
--- a/drivers/net/ethernet/wangxun/txgbe/Makefile
+++ b/drivers/net/ethernet/wangxun/txgbe/Makefile
@@ -11,4 +11,5 @@ txgbe-objs := txgbe_main.o \
               txgbe_phy.o \
               txgbe_irq.o \
               txgbe_fdir.o \
-              txgbe_ethtool.o
+              txgbe_ethtool.o \
+              txgbe_aml.o
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
new file mode 100644
index 000000000000..49eb93987a9d
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/phylink.h>
+#include <linux/iopoll.h>
+#include <linux/pci.h>
+#include <linux/phy.h>
+
+#include "../libwx/wx_type.h"
+#include "../libwx/wx_lib.h"
+#include "../libwx/wx_hw.h"
+#include "txgbe_type.h"
+#include "txgbe_aml.h"
+#include "txgbe_hw.h"
+
+static void txgbe_get_phy_link(struct wx *wx, int *speed)
+{
+	u32 status;
+
+	status = rd32(wx, TXGBE_CFG_PORT_ST);
+	if (!(status & TXGBE_CFG_PORT_ST_LINK_UP))
+		*speed = SPEED_UNKNOWN;
+	else if (status & TXGBE_CFG_PORT_ST_LINK_AML_25G)
+		*speed = SPEED_25000;
+	else if (status & TXGBE_CFG_PORT_ST_LINK_AML_10G)
+		*speed = SPEED_10000;
+	else
+		*speed = SPEED_UNKNOWN;
+}
+
+static void txgbe_get_link_state(struct phylink_config *config,
+				 struct phylink_link_state *state)
+{
+	struct wx *wx = phylink_to_wx(config);
+	int speed;
+
+	txgbe_get_phy_link(wx, &speed);
+	state->link = speed != SPEED_UNKNOWN;
+	state->speed = speed;
+	state->duplex = state->link ? DUPLEX_FULL : DUPLEX_UNKNOWN;
+}
+
+static void txgbe_reconfig_mac(struct wx *wx)
+{
+	u32 wdg, fc;
+
+	wdg = rd32(wx, WX_MAC_WDG_TIMEOUT);
+	fc = rd32(wx, WX_MAC_RX_FLOW_CTRL);
+
+	wr32(wx, WX_MIS_RST, TXGBE_MIS_RST_MAC_RST(wx->bus.func));
+	/* wait for MAC reset complete */
+	usleep_range(1000, 1500);
+
+	wr32m(wx, TXGBE_MAC_MISC_CTL, TXGBE_MAC_MISC_CTL_LINK_STS_MOD,
+	      TXGBE_MAC_MISC_CTL_LINK_BOTH);
+	wx_reset_mac(wx);
+
+	wr32(wx, WX_MAC_WDG_TIMEOUT, wdg);
+	wr32(wx, WX_MAC_RX_FLOW_CTRL, fc);
+}
+
+static void txgbe_mac_link_up_aml(struct phylink_config *config,
+				  struct phy_device *phy,
+				  unsigned int mode,
+				  phy_interface_t interface,
+				  int speed, int duplex,
+				  bool tx_pause, bool rx_pause)
+{
+	struct wx *wx = phylink_to_wx(config);
+	u32 txcfg;
+
+	wx_fc_enable(wx, tx_pause, rx_pause);
+
+	txgbe_reconfig_mac(wx);
+
+	txcfg = rd32(wx, TXGBE_AML_MAC_TX_CFG);
+	txcfg &= ~TXGBE_AML_MAC_TX_CFG_SPEED_MASK;
+
+	switch (speed) {
+	case SPEED_25000:
+		txcfg |= TXGBE_AML_MAC_TX_CFG_SPEED_25G;
+		break;
+	case SPEED_10000:
+		txcfg |= TXGBE_AML_MAC_TX_CFG_SPEED_10G;
+		break;
+	default:
+		break;
+	}
+
+	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, WX_MAC_RX_CFG_RE);
+	wr32(wx, TXGBE_AML_MAC_TX_CFG, txcfg | TXGBE_AML_MAC_TX_CFG_TE);
+
+	wx->speed = speed;
+}
+
+static void txgbe_mac_link_down_aml(struct phylink_config *config,
+				    unsigned int mode,
+				    phy_interface_t interface)
+{
+	struct wx *wx = phylink_to_wx(config);
+
+	wr32m(wx, TXGBE_AML_MAC_TX_CFG, TXGBE_AML_MAC_TX_CFG_TE, 0);
+	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
+
+	wx->speed = SPEED_UNKNOWN;
+}
+
+static void txgbe_mac_config_aml(struct phylink_config *config, unsigned int mode,
+				 const struct phylink_link_state *state)
+{
+}
+
+static const struct phylink_mac_ops txgbe_mac_ops_aml = {
+	.mac_config = txgbe_mac_config_aml,
+	.mac_link_down = txgbe_mac_link_down_aml,
+	.mac_link_up = txgbe_mac_link_up_aml,
+};
+
+int txgbe_phylink_init_aml(struct txgbe *txgbe)
+{
+	struct phylink_link_state state;
+	struct phylink_config *config;
+	struct wx *wx = txgbe->wx;
+	phy_interface_t phy_mode;
+	struct phylink *phylink;
+	int err;
+
+	config = &wx->phylink_config;
+	config->dev = &wx->netdev->dev;
+	config->type = PHYLINK_NETDEV;
+	config->mac_capabilities = MAC_25000FD | MAC_10000FD |
+				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
+	config->get_fixed_state = txgbe_get_link_state;
+
+	phy_mode = PHY_INTERFACE_MODE_25GBASER;
+	__set_bit(PHY_INTERFACE_MODE_25GBASER, config->supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_10GBASER, config->supported_interfaces);
+
+	phylink = phylink_create(config, NULL, phy_mode, &txgbe_mac_ops_aml);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
+
+	state.speed = SPEED_25000;
+	state.duplex = DUPLEX_FULL;
+	err = phylink_set_fixed_link(phylink, &state);
+	if (err) {
+		wx_err(wx, "Failed to set fixed link\n");
+		return err;
+	}
+
+	wx->phylink = phylink;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
new file mode 100644
index 000000000000..aa3b7848e03d
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _TXGBE_AML_H_
+#define _TXGBE_AML_H_
+
+int txgbe_phylink_init_aml(struct txgbe *txgbe);
+
+#endif /* _TXGBE_AML_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index ece378fa2620..03f1b9bc604d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -20,6 +20,7 @@
 #include "../libwx/wx_mbx.h"
 #include "../libwx/wx_hw.h"
 #include "txgbe_type.h"
+#include "txgbe_aml.h"
 #include "txgbe_phy.h"
 #include "txgbe_hw.h"
 
@@ -318,7 +319,10 @@ irqreturn_t txgbe_link_irq_handler(int irq, void *data)
 	status = rd32(wx, TXGBE_CFG_PORT_ST);
 	up = !!(status & TXGBE_CFG_PORT_ST_LINK_UP);
 
-	phylink_pcs_change(txgbe->pcs, up);
+	if (txgbe->pcs)
+		phylink_pcs_change(txgbe->pcs, up);
+	else
+		phylink_mac_change(wx->phylink, up);
 
 	return IRQ_HANDLED;
 }
@@ -575,8 +579,9 @@ int txgbe_init_phy(struct txgbe *txgbe)
 
 	switch (wx->mac.type) {
 	case wx_mac_aml40:
-	case wx_mac_aml:
 		return 0;
+	case wx_mac_aml:
+		return txgbe_phylink_init_aml(txgbe);
 	case wx_mac_sp:
 		if (wx->media_type == wx_media_copper)
 			return txgbe_ext_phy_init(txgbe);
@@ -648,7 +653,9 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 {
 	switch (txgbe->wx->mac.type) {
 	case wx_mac_aml40:
+		return;
 	case wx_mac_aml:
+		phylink_destroy(txgbe->wx->phylink);
 		return;
 	case wx_mac_sp:
 		if (txgbe->wx->media_type == wx_media_copper) {
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 3b4e4361462a..ca4da2696eed 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -50,6 +50,8 @@
 
 /**************** SP Registers ****************************/
 /* chip control Registers */
+#define TXGBE_MIS_RST                           0x1000C
+#define TXGBE_MIS_RST_MAC_RST(_i)               BIT(20 - (_i) * 3)
 #define TXGBE_MIS_PRB_CTL                       0x10010
 #define TXGBE_MIS_PRB_CTL_LAN_UP(_i)            BIT(1 - (_i))
 /* FMGR Registers */
@@ -62,6 +64,11 @@
 #define TXGBE_TS_CTL                            0x10300
 #define TXGBE_TS_CTL_EVAL_MD                    BIT(31)
 
+/* MAC Misc Registers */
+#define TXGBE_MAC_MISC_CTL                      0x11F00
+#define TXGBE_MAC_MISC_CTL_LINK_STS_MOD         BIT(0)
+#define TXGBE_MAC_MISC_CTL_LINK_PCS             FIELD_PREP(BIT(0), 0)
+#define TXGBE_MAC_MISC_CTL_LINK_BOTH            FIELD_PREP(BIT(0), 1)
 /* GPIO register bit */
 #define TXGBE_GPIOBIT_0                         BIT(0) /* I:tx fault */
 #define TXGBE_GPIOBIT_1                         BIT(1) /* O:tx disabled */
@@ -88,6 +95,8 @@
 /* Port cfg registers */
 #define TXGBE_CFG_PORT_ST                       0x14404
 #define TXGBE_CFG_PORT_ST_LINK_UP               BIT(0)
+#define TXGBE_CFG_PORT_ST_LINK_AML_25G          BIT(3)
+#define TXGBE_CFG_PORT_ST_LINK_AML_10G          BIT(4)
 #define TXGBE_CFG_VXLAN                         0x14410
 #define TXGBE_CFG_VXLAN_GPE                     0x14414
 #define TXGBE_CFG_GENEVE                        0x14418
@@ -151,9 +160,11 @@
 /*************************** Amber Lite Registers ****************************/
 #define TXGBE_PX_PF_BME                         0x4B8
 #define TXGBE_AML_MAC_TX_CFG                    0x11000
+#define TXGBE_AML_MAC_TX_CFG_TE                 BIT(0)
 #define TXGBE_AML_MAC_TX_CFG_SPEED_MASK         GENMASK(30, 27)
 #define TXGBE_AML_MAC_TX_CFG_SPEED_40G          FIELD_PREP(GENMASK(30, 27), 0)
 #define TXGBE_AML_MAC_TX_CFG_SPEED_25G          FIELD_PREP(GENMASK(30, 27), 2)
+#define TXGBE_AML_MAC_TX_CFG_SPEED_10G          FIELD_PREP(GENMASK(30, 27), 8)
 #define TXGBE_RDM_RSC_CTL                       0x1200C
 #define TXGBE_RDM_RSC_CTL_FREE_CTL              BIT(7)
 
-- 
2.48.1


