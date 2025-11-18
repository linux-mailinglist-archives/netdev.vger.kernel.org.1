Return-Path: <netdev+bounces-239423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B2DC68218
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70E3034F2F1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48266306494;
	Tue, 18 Nov 2025 08:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CAC305E2D
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453144; cv=none; b=uJkSpqxjtvo3vAZ+HlJU19hTTqnuTHsYVLCpQW+7CAgiOujK7DvFdOpv8v6wEa5/tpTWfQYKc+veOMu8eYZADAdgUnrahfnfGCVkc+gViuuuKo2+stmPxzoaPs1g6B+2TZ23KCVJ/G3lZNp8jrNLfusnbBKScDqu4YRzhjRG/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453144; c=relaxed/simple;
	bh=U8IE+RX0LBN7+f6QIGosXwWMBXk4ByYcN7c2fOcgyj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OSeUskI6lFY/yrrKVzZbohtUVMph/zXJQDkwlGmZ5ovSPgf26ji1X14eTlxytJy1nWBMV4m6b7Ah4peuiTpCSu04OQpMUPjjHtND79Z/Lo+G50ZMDUDvPpLsQGhh7Bd8OwJg3d32FdQLS7eoGy1HYPNBuJ+At7ensFKppEu20zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz8t1763453003te95adee7
X-QQ-Originating-IP: r1lVkxdjaw3ZxdAAuBUInz9NsNp4Cy+SX1oU+jFbnhc=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.152.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Nov 2025 16:03:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4272100048886765520
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 3/5] net: txgbe: improve functions of AML 40G devices
Date: Tue, 18 Nov 2025 16:02:57 +0800
Message-Id: <20251118080259.24676-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251118080259.24676-1-jiawenwu@trustnetic.com>
References: <20251118080259.24676-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NAL10RuyI0V8dFCPpyyRKd5TQQCX/QrC4X53aS+Dsnc7cCpP0zxyKbkR
	/rVXC95M+/l5eMPagIfi2xDDOLTf+NMxvMCGsXIrNzK+a17dley+gX5Pv7uo9bvXezRXKKc
	xRDXh3EnL8fWHc5zi6HhbGfZ2DW+n54HLgtqfFb2KG0OgjrI/T10oeqXO/lMEOuF1xaa4Fi
	1wRreRX0GkuQP18qNJ5sXnFCUCcpAvg66Pus8XdB1KHObCUCYJsHAqDfDlfCLRM/wJ1kero
	ut5amD8ylG55vYIFuoULudQtjKicxr+VCuQXSOO7pAPcQuRVOtLQ2HxFQucLcwUyyZ9+MqM
	+k7dsHHZfWaPf1l791LVfw9XinAw0tuv0zpEBJD06n+RuH84R3666X5LyrTE9qDI/y5qvvg
	y+msrEBjWGhxk/lUBbwKJNZNSKDW1bTINm4FMuqNnjvB4DCbo31+hsB+F6oS+MencjIn9Pp
	3F6SLS/HbbUZw8UqQx+gyDP3lM5x/6xPOEtpiX0zOyf6RLG1Skgu2mTXrHyGKyEI6KDkH4y
	BpyRCllYEZLZVOupnj9tJlb0ScuISspw7CmvaemL25peg6auP4mSpx4YTRlCxZnV5wOIFmH
	zFCOr9dYtSDmerjEJf1tEjZkK2xOGk5wun+utDvQf/e7q551HcAscDOhylU/sUTI5U+3rfs
	J7JEGC6rtASIcH+tdyTU4nrZa03zNTi2+me70GjOqH33mtnbGczsb1EbGaeotqdsr/MKKIo
	9RDyv+FvHsYd8NqJHTfqox9a4XF+j0LQQMTQ/oeX6r+FAtIE6DWIpNvuAaoZr57cGj2It9T
	1o/bcVTJ4FhQMLBQSYICQtpd1VFfuKe1Kzx4qTQb3uOEf6wGk0IY2mhm3vaiY7n0yQkJN9d
	k+xv6Dij2Hoj8Ac8s0IIivXs2T220yn2xFlRHTkUkuJfb2aZ4UB/Id46iQlPh72cbNxVtWR
	6EcEXwm23R5ypRSjAaHt3+uAeRBgjBQPqt8M5kMNjwFWk+wBEhtqBwjDgzbqaaeg2roqQ6E
	FocjWfT4lrfIV1JCVolT0MJqQ+xR/jGMdDXjZ8FsXwFUHKaOArKE9Rf3dXfj1VMZp7BNoeS
	9J4TnQt2r97qqyCEQtsjvI=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Support to identify QSFP modules for AML 40G devices. The definition of
GPIO pins follows the design of the QSFP modules, and TXGBE_GPIOBIT_4 is
used for module present.

Meanwhile, implement phylink in XLGMII mode by default, and get the link
state from MAC link.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  12 --
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 136 ++++++++++++++++--
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   3 -
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  10 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  11 +-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   2 -
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  11 ++
 7 files changed, 137 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 9aa3964187e1..f362e51c73ee 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -240,9 +240,6 @@ int wx_nway_reset(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_aml40)
-		return -EOPNOTSUPP;
-
 	return phylink_ethtool_nway_reset(wx->phylink);
 }
 EXPORT_SYMBOL(wx_nway_reset);
@@ -261,9 +258,6 @@ int wx_set_link_ksettings(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_aml40)
-		return -EOPNOTSUPP;
-
 	return phylink_ethtool_ksettings_set(wx->phylink, cmd);
 }
 EXPORT_SYMBOL(wx_set_link_ksettings);
@@ -273,9 +267,6 @@ void wx_get_pauseparam(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_aml40)
-		return;
-
 	phylink_ethtool_get_pauseparam(wx->phylink, pause);
 }
 EXPORT_SYMBOL(wx_get_pauseparam);
@@ -285,9 +276,6 @@ int wx_set_pauseparam(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_aml40)
-		return -EOPNOTSUPP;
-
 	return phylink_ethtool_set_pauseparam(wx->phylink, pause);
 }
 EXPORT_SYMBOL(wx_set_pauseparam);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 432880ccc640..5725e9557669 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -17,10 +17,15 @@
 
 void txgbe_gpio_init_aml(struct wx *wx)
 {
-	u32 status;
+	u32 status, mod_rst;
+
+	if (wx->mac.type == wx_mac_aml40)
+		mod_rst = TXGBE_GPIOBIT_4;
+	else
+		mod_rst = TXGBE_GPIOBIT_2;
 
-	wr32(wx, WX_GPIO_INTTYPE_LEVEL, TXGBE_GPIOBIT_2);
-	wr32(wx, WX_GPIO_INTEN, TXGBE_GPIOBIT_2);
+	wr32(wx, WX_GPIO_INTTYPE_LEVEL, mod_rst);
+	wr32(wx, WX_GPIO_INTEN, mod_rst);
 
 	status = rd32(wx, WX_GPIO_INTSTATUS);
 	for (int i = 0; i < 6; i++) {
@@ -33,13 +38,18 @@ irqreturn_t txgbe_gpio_irq_handler_aml(int irq, void *data)
 {
 	struct txgbe *txgbe = data;
 	struct wx *wx = txgbe->wx;
-	u32 status;
+	u32 status, mod_rst;
+
+	if (wx->mac.type == wx_mac_aml40)
+		mod_rst = TXGBE_GPIOBIT_4;
+	else
+		mod_rst = TXGBE_GPIOBIT_2;
 
 	wr32(wx, WX_GPIO_INTMASK, 0xFF);
 	status = rd32(wx, WX_GPIO_INTSTATUS);
-	if (status & TXGBE_GPIOBIT_2) {
+	if (status & mod_rst) {
 		set_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
-		wr32(wx, WX_GPIO_EOI, TXGBE_GPIOBIT_2);
+		wr32(wx, WX_GPIO_EOI, mod_rst);
 		wx_service_event_schedule(wx);
 	}
 
@@ -51,7 +61,7 @@ int txgbe_test_hostif(struct wx *wx)
 {
 	struct txgbe_hic_ephy_getlink buffer;
 
-	if (wx->mac.type != wx_mac_aml)
+	if (wx->mac.type == wx_mac_sp)
 		return 0;
 
 	buffer.hdr.cmd = FW_PHY_GET_LINK_CMD;
@@ -86,6 +96,9 @@ static int txgbe_set_phy_link_hostif(struct wx *wx, int speed, int autoneg, int
 	buffer.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
 
 	switch (speed) {
+	case SPEED_40000:
+		buffer.speed = TXGBE_LINK_SPEED_40GB_FULL;
+		break;
 	case SPEED_25000:
 		buffer.speed = TXGBE_LINK_SPEED_25GB_FULL;
 		break;
@@ -110,7 +123,9 @@ static void txgbe_get_link_capabilities(struct wx *wx, int *speed,
 {
 	struct txgbe *txgbe = wx->priv;
 
-	if (test_bit(PHY_INTERFACE_MODE_25GBASER, txgbe->link_interfaces))
+	if (test_bit(PHY_INTERFACE_MODE_XLGMII, txgbe->link_interfaces))
+		*speed = SPEED_40000;
+	else if (test_bit(PHY_INTERFACE_MODE_25GBASER, txgbe->link_interfaces))
 		*speed = SPEED_25000;
 	else if (test_bit(PHY_INTERFACE_MODE_10GBASER, txgbe->link_interfaces))
 		*speed = SPEED_10000;
@@ -128,6 +143,8 @@ static void txgbe_get_mac_link(struct wx *wx, int *speed)
 	status = rd32(wx, TXGBE_CFG_PORT_ST);
 	if (!(status & TXGBE_CFG_PORT_ST_LINK_UP))
 		*speed = SPEED_UNKNOWN;
+	else if (status & TXGBE_CFG_PORT_ST_LINK_AML_40G)
+		*speed = SPEED_40000;
 	else if (status & TXGBE_CFG_PORT_ST_LINK_AML_25G)
 		*speed = SPEED_25000;
 	else if (status & TXGBE_CFG_PORT_ST_LINK_AML_10G)
@@ -218,15 +235,86 @@ static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 	return 0;
 }
 
+static int txgbe_qsfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) = { 0, };
+	DECLARE_PHY_INTERFACE_MASK(interfaces);
+	struct txgbe *txgbe = wx->priv;
+
+	if (id->transceiver_type & TXGBE_SFF_ETHERNET_40G_CR4) {
+		txgbe->link_port = PORT_DA;
+		phylink_set(modes, Autoneg);
+		phylink_set(modes, 40000baseCR4_Full);
+		phylink_set(modes, 10000baseCR_Full);
+		__set_bit(PHY_INTERFACE_MODE_XLGMII, interfaces);
+		__set_bit(PHY_INTERFACE_MODE_10GBASER, interfaces);
+	}
+	if (id->transceiver_type & TXGBE_SFF_ETHERNET_40G_SR4) {
+		txgbe->link_port = PORT_FIBRE;
+		phylink_set(modes, 40000baseSR4_Full);
+		__set_bit(PHY_INTERFACE_MODE_XLGMII, interfaces);
+	}
+	if (id->transceiver_type & TXGBE_SFF_ETHERNET_40G_LR4) {
+		txgbe->link_port = PORT_FIBRE;
+		phylink_set(modes, 40000baseLR4_Full);
+		__set_bit(PHY_INTERFACE_MODE_XLGMII, interfaces);
+	}
+	if (id->transceiver_type & TXGBE_SFF_ETHERNET_40G_ACTIVE) {
+		txgbe->link_port = PORT_DA;
+		phylink_set(modes, Autoneg);
+		phylink_set(modes, 40000baseCR4_Full);
+		__set_bit(PHY_INTERFACE_MODE_XLGMII, interfaces);
+	}
+	if (id->transceiver_type & TXGBE_SFF_ETHERNET_RSRVD) {
+		if (id->sff_opt1 & TXGBE_SFF_ETHERNET_100G_CR4) {
+			txgbe->link_port = PORT_DA;
+			phylink_set(modes, Autoneg);
+			phylink_set(modes, 40000baseCR4_Full);
+			phylink_set(modes, 25000baseCR_Full);
+			phylink_set(modes, 10000baseCR_Full);
+			__set_bit(PHY_INTERFACE_MODE_XLGMII, interfaces);
+			__set_bit(PHY_INTERFACE_MODE_25GBASER, interfaces);
+			__set_bit(PHY_INTERFACE_MODE_10GBASER, interfaces);
+		}
+	}
+
+	if (phy_interface_empty(interfaces)) {
+		wx_err(wx, "unsupported QSFP module\n");
+		return -EINVAL;
+	}
+
+	phylink_set(modes, Pause);
+	phylink_set(modes, Asym_Pause);
+	phylink_set(modes, FIBRE);
+
+	if (!linkmode_equal(txgbe->link_support, modes)) {
+		linkmode_copy(txgbe->link_support, modes);
+		phy_interface_and(txgbe->link_interfaces,
+				  wx->phylink_config.supported_interfaces,
+				  interfaces);
+		linkmode_copy(txgbe->advertising, modes);
+
+		set_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags);
+	}
+
+	return 0;
+}
+
 int txgbe_identify_module(struct wx *wx)
 {
 	struct txgbe_hic_get_module_info buffer;
 	struct txgbe_sff_id *id;
 	int err = 0;
+	u32 mod_abs;
 	u32 gpio;
 
+	if (wx->mac.type == wx_mac_aml40)
+		mod_abs = TXGBE_GPIOBIT_4;
+	else
+		mod_abs = TXGBE_GPIOBIT_2;
+
 	gpio = rd32(wx, WX_GPIO_EXT);
-	if (gpio & TXGBE_GPIOBIT_2)
+	if (gpio & mod_abs)
 		return -ENODEV;
 
 	err = txgbe_identify_module_hostif(wx, &buffer);
@@ -236,12 +324,18 @@ int txgbe_identify_module(struct wx *wx)
 	}
 
 	id = &buffer.id;
-	if (id->identifier != TXGBE_SFF_IDENTIFIER_SFP) {
-		wx_err(wx, "Invalid SFP module\n");
+	if (id->identifier != TXGBE_SFF_IDENTIFIER_SFP &&
+	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP &&
+	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP_PLUS &&
+	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP28) {
+		wx_err(wx, "Invalid module\n");
 		return -ENODEV;
 	}
 
-	return txgbe_sfp_to_linkmodes(wx, id);
+	if (id->transceiver_type == 0xFF)
+		return txgbe_sfp_to_linkmodes(wx, id);
+
+	return txgbe_qsfp_to_linkmodes(wx, id);
 }
 
 void txgbe_setup_link(struct wx *wx)
@@ -304,6 +398,9 @@ static void txgbe_mac_link_up_aml(struct phylink_config *config,
 	txcfg &= ~TXGBE_AML_MAC_TX_CFG_SPEED_MASK;
 
 	switch (speed) {
+	case SPEED_40000:
+		txcfg |= TXGBE_AML_MAC_TX_CFG_SPEED_40G;
+		break;
 	case SPEED_25000:
 		txcfg |= TXGBE_AML_MAC_TX_CFG_SPEED_25G;
 		break;
@@ -368,7 +465,18 @@ int txgbe_phylink_init_aml(struct txgbe *txgbe)
 				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
 	config->get_fixed_state = txgbe_get_link_state;
 
-	phy_mode = PHY_INTERFACE_MODE_25GBASER;
+	if (wx->mac.type == wx_mac_aml40) {
+		config->mac_capabilities |= MAC_40000FD;
+		phy_mode = PHY_INTERFACE_MODE_XLGMII;
+		__set_bit(PHY_INTERFACE_MODE_XLGMII, config->supported_interfaces);
+		state.speed = SPEED_40000;
+		state.duplex = DUPLEX_FULL;
+	} else {
+		phy_mode = PHY_INTERFACE_MODE_25GBASER;
+		state.speed = SPEED_25000;
+		state.duplex = DUPLEX_FULL;
+	}
+
 	__set_bit(PHY_INTERFACE_MODE_25GBASER, config->supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_10GBASER, config->supported_interfaces);
 
@@ -376,8 +484,6 @@ int txgbe_phylink_init_aml(struct txgbe *txgbe)
 	if (IS_ERR(phylink))
 		return PTR_ERR(phylink);
 
-	state.speed = SPEED_25000;
-	state.duplex = DUPLEX_FULL;
 	err = phylink_set_fixed_link(phylink, &state);
 	if (err) {
 		wx_err(wx, "Failed to set fixed link\n");
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index d7f905359458..f553ec5f8238 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -19,9 +19,6 @@ int txgbe_get_link_ksettings(struct net_device *netdev,
 	struct txgbe *txgbe = wx->priv;
 	int err;
 
-	if (wx->mac.type == wx_mac_aml40)
-		return -EOPNOTSUPP;
-
 	err = wx_get_link_ksettings(netdev, cmd);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 3885283681ec..aa14958d439a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -23,7 +23,7 @@ void txgbe_irq_enable(struct wx *wx, bool queues)
 {
 	u32 misc_ien = TXGBE_PX_MISC_IEN_MASK;
 
-	if (wx->mac.type == wx_mac_aml) {
+	if (wx->mac.type != wx_mac_sp) {
 		misc_ien |= TXGBE_PX_MISC_GPIO;
 		txgbe_gpio_init_aml(wx);
 	}
@@ -201,10 +201,7 @@ static void txgbe_del_irq_domain(struct txgbe *txgbe)
 
 void txgbe_free_misc_irq(struct txgbe *txgbe)
 {
-	if (txgbe->wx->mac.type == wx_mac_aml40)
-		return;
-
-	if (txgbe->wx->mac.type == wx_mac_aml)
+	if (txgbe->wx->mac.type != wx_mac_sp)
 		free_irq(txgbe->gpio_irq, txgbe);
 
 	free_irq(txgbe->link_irq, txgbe);
@@ -219,9 +216,6 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	struct wx *wx = txgbe->wx;
 	int hwirq, err;
 
-	if (wx->mac.type == wx_mac_aml40)
-		goto skip_sp_irq;
-
 	txgbe->misc.nirqs = TXGBE_IRQ_MAX;
 	txgbe->misc.domain = irq_domain_create_simple(NULL, txgbe->misc.nirqs, 0,
 						      &txgbe_misc_irq_domain_ops, txgbe);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 91d1b4e68126..0de051450a82 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -144,7 +144,6 @@ static void txgbe_init_service(struct wx *wx)
 static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
-	u32 reg;
 
 	wx_control_hw(wx, true);
 	wx_configure_vectors(wx);
@@ -155,12 +154,8 @@ static void txgbe_up_complete(struct wx *wx)
 
 	switch (wx->mac.type) {
 	case wx_mac_aml40:
-		reg = rd32(wx, TXGBE_AML_MAC_TX_CFG);
-		reg &= ~TXGBE_AML_MAC_TX_CFG_SPEED_MASK;
-		reg |= TXGBE_AML_MAC_TX_CFG_SPEED_40G;
-		wr32(wx, WX_MAC_TX_CFG, reg);
-		txgbe_enable_sec_tx_path(wx);
-		netif_carrier_on(wx->netdev);
+		txgbe_setup_link(wx);
+		phylink_start(wx->phylink);
 		break;
 	case wx_mac_aml:
 		/* Enable TX laser */
@@ -276,7 +271,7 @@ void txgbe_down(struct wx *wx)
 
 	switch (wx->mac.type) {
 	case wx_mac_aml40:
-		netif_carrier_off(wx->netdev);
+		phylink_stop(wx->phylink);
 		break;
 	case wx_mac_aml:
 		phylink_stop(wx->phylink);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 03f1b9bc604d..8ea7aa07ae4e 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -579,7 +579,6 @@ int txgbe_init_phy(struct txgbe *txgbe)
 
 	switch (wx->mac.type) {
 	case wx_mac_aml40:
-		return 0;
 	case wx_mac_aml:
 		return txgbe_phylink_init_aml(txgbe);
 	case wx_mac_sp:
@@ -653,7 +652,6 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 {
 	switch (txgbe->wx->mac.type) {
 	case wx_mac_aml40:
-		return;
 	case wx_mac_aml:
 		phylink_destroy(txgbe->wx->phylink);
 		return;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index c115ed659544..e72edb9ef084 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -98,6 +98,7 @@
 /* Port cfg registers */
 #define TXGBE_CFG_PORT_ST                       0x14404
 #define TXGBE_CFG_PORT_ST_LINK_UP               BIT(0)
+#define TXGBE_CFG_PORT_ST_LINK_AML_40G          BIT(2)
 #define TXGBE_CFG_PORT_ST_LINK_AML_25G          BIT(3)
 #define TXGBE_CFG_PORT_ST_LINK_AML_10G          BIT(4)
 #define TXGBE_CFG_VXLAN                         0x14410
@@ -317,8 +318,12 @@ void txgbe_do_reset(struct net_device *netdev);
 #define TXGBE_LINK_SPEED_UNKNOWN        0
 #define TXGBE_LINK_SPEED_10GB_FULL      4
 #define TXGBE_LINK_SPEED_25GB_FULL      0x10
+#define TXGBE_LINK_SPEED_40GB_FULL      0x20
 
 #define TXGBE_SFF_IDENTIFIER_SFP        0x3
+#define TXGBE_SFF_IDENTIFIER_QSFP       0xC
+#define TXGBE_SFF_IDENTIFIER_QSFP_PLUS  0xD
+#define TXGBE_SFF_IDENTIFIER_QSFP28     0x11
 #define TXGBE_SFF_DA_PASSIVE_CABLE      0x4
 #define TXGBE_SFF_DA_ACTIVE_CABLE       0x8
 #define TXGBE_SFF_DA_SPEC_ACTIVE_LIMIT  0x4
@@ -331,6 +336,12 @@ void txgbe_do_reset(struct net_device *netdev);
 #define TXGBE_SFF_25GBASECR_91FEC       0xB
 #define TXGBE_SFF_25GBASECR_74FEC       0xC
 #define TXGBE_SFF_25GBASECR_NOFEC       0xD
+#define TXGBE_SFF_ETHERNET_RSRVD        BIT(7)
+#define TXGBE_SFF_ETHERNET_40G_CR4      BIT(3)
+#define TXGBE_SFF_ETHERNET_40G_SR4      BIT(2)
+#define TXGBE_SFF_ETHERNET_40G_LR4      BIT(1)
+#define TXGBE_SFF_ETHERNET_40G_ACTIVE   BIT(0)
+#define TXGBE_SFF_ETHERNET_100G_CR4     0xB
 
 #define TXGBE_PHY_FEC_RS                BIT(0)
 #define TXGBE_PHY_FEC_BASER             BIT(1)
-- 
2.48.1


