Return-Path: <netdev+bounces-190978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED35AB98F4
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1843A9CBA
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B423371E;
	Fri, 16 May 2025 09:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A80230BF2
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388059; cv=none; b=LYRG1frFv1evYA1Dt5puE1ZBIKf/p8nKRPXPQKXZIkC3iQoIaJ/+Q/P3CvrRbn3qskJ60ktyI4/MJW6a4Fec3mOsx3P07Jf7Kr7xP56FACRn2SldWmw6uTE2iswHnMvs+BFGhuIe7/s6Bfjffc57+V8kM1IogDQl3phNNHiLLrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388059; c=relaxed/simple;
	bh=VBVY5s8GdpbfRqfu6nUB5e8KNDBwWzZ/s4qtdvpJ5SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkh2yLQT3o4YCXvRXoABqu4LVpj41lPHghPvA6Gh/IpwtJUlxqqMf+7zbLKwiZXR3ydmzawNc1vAYzPUCbA+i4y4FNwLxYQDlGyElbCFbux88mxay29VD3frED8ZuBZaPzqk1FG27jHojiCoTj5bRNnO61ZN2uQEh1iA52vDs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1747387968t2e39c35c
X-QQ-Originating-IP: Darc1JgGAcbIV/uBgcIu4pOd16yunzpu51nPl5MD97k=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 17:32:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13929437064546343469
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 4/9] net: txgbe: Implement PHYLINK for AML 25G/10G devices
Date: Fri, 16 May 2025 17:32:15 +0800
Message-ID: <A8546B4037DAA0AE+20250516093220.6044-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516093220.6044-1-jiawenwu@trustnetic.com>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mxdgibywz0jUTZ5p0QG/xjdwIt+0dAnfuXgeopIS7iDJ9ZLTUGnHHxO4
	T3xbW9hJluzzKfUWOblMCDpQKSt8myMl+2XXoUE/d079T9h0wUVV5MLjdogz/peVr+ZtDYf
	36ZAqRDAxs5uCKnu62W6qsyJuh326P39L+kcfT1R5uHiS6jMzy2pWnmA/78iGHollPotW2N
	3kqA3eYx9aPHwqLgvlNosO7tjbpLLuMg272Rt7063aZSWkiGltON6ByXga6dpfQm32qIUVB
	0S9rlBWaNzXoM5IocHe4Rkfxng/5T0w2k7cmk6rpoSzBi6yjGlGH7CiSFL8dYLOYWsJGJLx
	sUkh58NQdDxkKKtY9jDPBfGAW91xqxhT/5QVqSS6c7P5ceUoRFU97zluSyJa3F+1FEVrdN/
	5TiLaAbUIBwyHlALZ00Qdv143de8R0QCvuaHdb2lkjN43aQl7xLDRiH9uxSmy65ZqvKir4i
	TDtZfRW7XicPWZmuVSkK0JZ9aa1GsPD83yW4nXJf25lfioguwFytg93FGWVRA9A0LbMupwy
	izbcAdGS2WQ+zLjdsATdfz9jQuZGFF8qNzQboWLNVXUUxy8uuthuo5oFKM3duP7S2eNsBN5
	ohn9y5jzoikeBwurmu111O/dnuplPZu9BdD3oGJ5hKIp5I5aAHQBFzMM33A5lZ8Lg58ZQ11
	g8JNl6Zfu3Tr8MJWA6ni8yD+79nzYlwuNIIjjUBxxY/sv5akklcG9xS941u3s87TmqsCV4M
	O6JZxOAdYIhRLX1dObNtLsfznqBwyfOB286Tm0yAv4i8lyj9gCc3ZVFzEuCsi23vZQuACO8
	u/06xuXSJM1KC6hkXOauDAKxpqenvtiLl0NoRiiN87ehMJ3s+4wo2dehASRNC4pus8oYRyE
	qcVfow09VrqL3w/vKmm6tIRcwuwbl/BG3xcooHWvNd6ymWdQrVlzduZOqts/jG0hQX4bxfQ
	8i95rTu9jafa+kCul41wnGlLDFpU1NGiMvArN8oB+DQ0OPNX0gHB7mbgtWG5wkFUNfgG6O6
	DhnVwTZZCTcw4M+fpBE+aZ5AsuSv6SxKYEtYz/kBo5WGRelJkzbXFsjbPWUEug1Io+j2PMt
	r/SPeVDgi3qAr/3Nrdnx1w=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Support PHYLINK framework for AML 25G/10G devices. Since the read and
write of I2C and PHY are controlled by firmware, set fixed-link mode for
these devices.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
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


