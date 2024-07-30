Return-Path: <netdev+bounces-113930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5184F94066C
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAA01F233EB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26F618EFD5;
	Tue, 30 Jul 2024 04:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dXhS27XT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6D161304;
	Tue, 30 Jul 2024 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312670; cv=none; b=EZHPqlZaBX5jQws3LqG/Iczddv7PY/uPywFOwUoDXWZcFn4lFiPClk7v45rkcmy9kfmzGvvUUzKy9zUjcm7bo7Rw8c8I5BrZijbzGA0yDKX25qQHMWIU5Lw6x4ZuaQUCd8sGZilqX0532o2VdlBXhEBOi3qe6MDrdkLie0x4nvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312670; c=relaxed/simple;
	bh=B9CTEj6yILfQ+EPyy9zCNNM6DOyW8bwJSjFQMnssD+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+n1KxXYJgsmvW0TpWItLKje3yoeWFC6Hf7s6YuvdSHrbjLak6BCeqZfatnAoVRm4mRYbdHpPeMD7S0UVTikuNI8OH9lvyWeT/CVqSbSGEd69705Dxncj4KL4sps3uOOP+sXCCWsRhl3PF5krKwlSmWHywtyuJUOkKdvMpJuGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dXhS27XT; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722312669; x=1753848669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B9CTEj6yILfQ+EPyy9zCNNM6DOyW8bwJSjFQMnssD+g=;
  b=dXhS27XTk3w7Ie/mQRvuSKbd5cQqcbUy0fQfebtFxX4/i+fLDaEYgEeZ
   vwWlzM+MRt4u1nVMwSv9SHb7TNC28+AtRe9T50isss2Qb0nsoU3WUOVWe
   C6B+dkavGU9gnVXwKBJOsWwPvnd9m8+nI04t6tzsbQVcLuWXbMdlSh8fw
   r0VwTdaxxp6SyayeA9uxr47y37hn1BvSoMlf3x6tV0IDSMDDVAFO5u43T
   m8ncqXQrqwUwc+33ZQGoQ41G8XHTuuSpTb1LeuoNuV0HHEaN9Jl8rgmUt
   h+YlWpfYCrg9aCFnK0SKWbzVDaPt8hslgl1utv0Vd/d9umIlDwkJNzJP/
   w==;
X-CSE-ConnectionGUID: mqMfXK64Rdu1Hu7kZRIsuQ==
X-CSE-MsgGUID: TtMlhYZgSUa4OHmzhGkn9A==
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="29844751"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 21:11:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 21:10:56 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 21:10:45 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v5 13/14] microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY
Date: Tue, 30 Jul 2024 09:39:05 +0530
Message-ID: <20240730040906.53779-14-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The LAN8650/1 is designed to conform to the OPEN Alliance 10BASE-T1x
MAC-PHY Serial Interface specification, Version 1.1. The IEEE Clause 4
MAC integration provides the low pin count standard SPI interface to any
microcontroller therefore providing Ethernet functionality without
requiring MAC integration within the microcontroller. The LAN8650/1
operates as an SPI client supporting SCLK clock rates up to a maximum of
25 MHz. This SPI interface supports the transfer of both data (Ethernet
frames) and control (register access).

By default, the chunk data payload is 64 bytes in size. The Ethernet
Media Access Controller (MAC) module implements a 10 Mbps half duplex
Ethernet MAC, compatible with the IEEE 802.3 standard. 10BASE-T1S
physical layer transceiver integrated is into the LAN8650/1. The PHY and
MAC are connected via an internal Media Independent Interface (MII).

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 MAINTAINERS                                   |   6 +
 drivers/net/ethernet/microchip/Kconfig        |   1 +
 drivers/net/ethernet/microchip/Makefile       |   1 +
 .../net/ethernet/microchip/lan865x/Kconfig    |  19 +
 .../net/ethernet/microchip/lan865x/Makefile   |   6 +
 .../net/ethernet/microchip/lan865x/lan865x.c  | 391 ++++++++++++++++++
 6 files changed, 424 insertions(+)
 create mode 100644 drivers/net/ethernet/microchip/lan865x/Kconfig
 create mode 100644 drivers/net/ethernet/microchip/lan865x/Makefile
 create mode 100644 drivers/net/ethernet/microchip/lan865x/lan865x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ee490b9e363c..907522277010 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14949,6 +14949,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
 
+MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
+M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/microchip/lan865x/lan865x.c
+
 MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
 M:	Arun Ramadoss <arun.ramadoss@microchip.com>
 R:	UNGLinuxDriver@microchip.com
diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 43ba71e82260..06ca79669053 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -56,6 +56,7 @@ config LAN743X
 	  To compile this driver as a module, choose M here. The module will be
 	  called lan743x.
 
+source "drivers/net/ethernet/microchip/lan865x/Kconfig"
 source "drivers/net/ethernet/microchip/lan966x/Kconfig"
 source "drivers/net/ethernet/microchip/sparx5/Kconfig"
 source "drivers/net/ethernet/microchip/vcap/Kconfig"
diff --git a/drivers/net/ethernet/microchip/Makefile b/drivers/net/ethernet/microchip/Makefile
index bbd349264e6f..15dfbb321057 100644
--- a/drivers/net/ethernet/microchip/Makefile
+++ b/drivers/net/ethernet/microchip/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_LAN743X) += lan743x.o
 
 lan743x-objs := lan743x_main.o lan743x_ethtool.o lan743x_ptp.o
 
+obj-$(CONFIG_LAN865X) += lan865x/
 obj-$(CONFIG_LAN966X_SWITCH) += lan966x/
 obj-$(CONFIG_SPARX5_SWITCH) += sparx5/
 obj-$(CONFIG_VCAP) += vcap/
diff --git a/drivers/net/ethernet/microchip/lan865x/Kconfig b/drivers/net/ethernet/microchip/lan865x/Kconfig
new file mode 100644
index 000000000000..f3d60d14e202
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan865x/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Microchip LAN865x Driver Support
+#
+
+if NET_VENDOR_MICROCHIP
+
+config LAN865X
+	tristate "LAN865x support"
+	depends on SPI
+	depends on OA_TC6
+	help
+	  Support for the Microchip LAN8650/1 Rev.B1 MACPHY Ethernet chip. It
+	  uses OPEN Alliance 10BASE-T1x Serial Interface specification.
+
+	  To compile this driver as a module, choose M here. The module will be
+	  called lan865x.
+
+endif # NET_VENDOR_MICROCHIP
diff --git a/drivers/net/ethernet/microchip/lan865x/Makefile b/drivers/net/ethernet/microchip/lan865x/Makefile
new file mode 100644
index 000000000000..9f5dd89c1eb8
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan865x/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the Microchip LAN865x Driver
+#
+
+obj-$(CONFIG_LAN865X) += lan865x.o
diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
new file mode 100644
index 000000000000..b25c927659f4
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Microchip's LAN865x 10BASE-T1S MAC-PHY driver
+ *
+ * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/phy.h>
+#include <linux/oa_tc6.h>
+
+#define DRV_NAME			"lan8650"
+
+/* MAC Network Control Register */
+#define LAN865X_REG_MAC_NET_CTL		0x00010000
+#define MAC_NET_CTL_TXEN		BIT(3) /* Transmit Enable */
+#define MAC_NET_CTL_RXEN		BIT(2) /* Receive Enable */
+
+/* MAC Network Configuration Reg */
+#define LAN865X_REG_MAC_NET_CFG		0x00010001
+#define MAC_NET_CFG_PROMISCUOUS_MODE	BIT(4)
+#define MAC_NET_CFG_MULTICAST_MODE	BIT(6)
+#define MAC_NET_CFG_UNICAST_MODE	BIT(7)
+
+/* MAC Hash Register Bottom */
+#define LAN865X_REG_MAC_L_HASH		0x00010020
+/* MAC Hash Register Top */
+#define LAN865X_REG_MAC_H_HASH		0x00010021
+/* MAC Specific Addr 1 Bottom Reg */
+#define LAN865X_REG_MAC_L_SADDR1	0x00010022
+/* MAC Specific Addr 1 Top Reg */
+#define LAN865X_REG_MAC_H_SADDR1	0x00010023
+
+struct lan865x_priv {
+	struct work_struct multicast_work;
+	struct net_device *netdev;
+	struct spi_device *spi;
+	struct oa_tc6 *tc6;
+};
+
+static int lan865x_set_hw_macaddr_low_bytes(struct oa_tc6 *tc6, const u8 *mac)
+{
+	u32 regval;
+
+	regval = (mac[3] << 24) | (mac[2] << 16) | (mac[1] << 8) | mac[0];
+
+	return oa_tc6_write_register(tc6, LAN865X_REG_MAC_L_SADDR1, regval);
+}
+
+static int lan865x_set_hw_macaddr(struct lan865x_priv *priv, const u8 *mac)
+{
+	int restore_ret;
+	u32 regval;
+	int ret;
+
+	/* Configure MAC address low bytes */
+	ret = lan865x_set_hw_macaddr_low_bytes(priv->tc6, mac);
+	if (ret)
+		return ret;
+
+	/* Prepare and configure MAC address high bytes */
+	regval = (mac[5] << 8) | mac[4];
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_SADDR1,
+				    regval);
+	if (!ret)
+		return 0;
+
+	/* Restore the old MAC address low bytes from netdev if the new MAC
+	 * address high bytes setting failed.
+	 */
+	restore_ret = lan865x_set_hw_macaddr_low_bytes(priv->tc6,
+						       priv->netdev->dev_addr);
+	if (restore_ret)
+		return restore_ret;
+
+	return ret;
+}
+
+static void
+lan865x_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->bus_info, dev_name(netdev->dev.parent),
+		sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops lan865x_ethtool_ops = {
+	.get_drvinfo        = lan865x_get_drvinfo,
+	.get_link_ksettings = phy_ethtool_get_link_ksettings,
+	.set_link_ksettings = phy_ethtool_set_link_ksettings,
+};
+
+static int lan865x_set_mac_address(struct net_device *netdev, void *addr)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	struct sockaddr *address = addr;
+	int ret;
+
+	ret = eth_prepare_mac_addr_change(netdev, addr);
+	if (ret < 0)
+		return ret;
+
+	if (ether_addr_equal(address->sa_data, netdev->dev_addr))
+		return 0;
+
+	ret = lan865x_set_hw_macaddr(priv, address->sa_data);
+	if (ret)
+		return ret;
+
+	eth_commit_mac_addr_change(netdev, address->sa_data);
+
+	return 0;
+}
+
+static u32 get_address_bit(u8 addr[ETH_ALEN], u32 bit)
+{
+	return ((addr[bit / 8]) >> (bit % 8)) & 1;
+}
+
+static u32 lan865x_hash(u8 addr[ETH_ALEN])
+{
+	u32 hash_index = 0;
+
+	for (int i = 0; i < 6; i++) {
+		u32 hash = 0;
+
+		for (int j = 0; j < 8; j++)
+			hash ^= get_address_bit(addr, (j * 6) + i);
+
+		hash_index |= (hash << i);
+	}
+
+	return hash_index;
+}
+
+static void lan865x_set_specific_multicast_addr(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	struct netdev_hw_addr *ha;
+	u32 hash_lo = 0;
+	u32 hash_hi = 0;
+
+	netdev_for_each_mc_addr(ha, netdev) {
+		u32 bit_num = lan865x_hash(ha->addr);
+
+		if (bit_num >= BIT(5))
+			hash_hi |= (1 << (bit_num - BIT(5)));
+		else
+			hash_lo |= (1 << bit_num);
+	}
+
+	/* Enabling specific multicast addresses */
+	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH, hash_hi)) {
+		netdev_err(netdev, "Failed to write reg_hashh");
+		return;
+	}
+
+	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH, hash_lo))
+		netdev_err(netdev, "Failed to write reg_hashl");
+}
+
+static void lan865x_multicast_work_handler(struct work_struct *work)
+{
+	struct lan865x_priv *priv = container_of(work, struct lan865x_priv,
+						 multicast_work);
+	u32 regval = 0;
+
+	if (priv->netdev->flags & IFF_PROMISC) {
+		/* Enabling promiscuous mode */
+		regval |= MAC_NET_CFG_PROMISCUOUS_MODE;
+		regval &= (~MAC_NET_CFG_MULTICAST_MODE);
+		regval &= (~MAC_NET_CFG_UNICAST_MODE);
+	} else if (priv->netdev->flags & IFF_ALLMULTI) {
+		/* Enabling all multicast mode */
+		regval &= (~MAC_NET_CFG_PROMISCUOUS_MODE);
+		regval |= MAC_NET_CFG_MULTICAST_MODE;
+		regval &= (~MAC_NET_CFG_UNICAST_MODE);
+	} else if (!netdev_mc_empty(priv->netdev)) {
+		lan865x_set_specific_multicast_addr(priv->netdev);
+		regval &= (~MAC_NET_CFG_PROMISCUOUS_MODE);
+		regval &= (~MAC_NET_CFG_MULTICAST_MODE);
+		regval |= MAC_NET_CFG_UNICAST_MODE;
+	} else {
+		/* enabling local mac address only */
+		if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH,
+					  0)) {
+			netdev_err(priv->netdev, "Failed to write reg_hashh");
+			return;
+		}
+		if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH,
+					  0)) {
+			netdev_err(priv->netdev, "Failed to write reg_hashl");
+			return;
+		}
+	}
+	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CFG, regval))
+		netdev_err(priv->netdev,
+			   "Failed to enable promiscuous/multicast/normal mode");
+}
+
+static void lan865x_set_multicast_list(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+
+	schedule_work(&priv->multicast_work);
+}
+
+static netdev_tx_t lan865x_send_packet(struct sk_buff *skb,
+				       struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+
+	return oa_tc6_start_xmit(priv->tc6, skb);
+}
+
+static int lan865x_hw_disable(struct lan865x_priv *priv)
+{
+	u32 regval;
+
+	if (oa_tc6_read_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, &regval))
+		return -ENODEV;
+
+	regval &= ~(MAC_NET_CTL_TXEN | MAC_NET_CTL_RXEN);
+
+	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, regval))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int lan865x_net_close(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	int ret;
+
+	netif_stop_queue(netdev);
+	phy_stop(netdev->phydev);
+	ret = lan865x_hw_disable(priv);
+	if (ret) {
+		netdev_err(netdev, "Failed to disable the hardware: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lan865x_hw_enable(struct lan865x_priv *priv)
+{
+	u32 regval;
+
+	if (oa_tc6_read_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, &regval))
+		return -ENODEV;
+
+	regval |= MAC_NET_CTL_TXEN | MAC_NET_CTL_RXEN;
+
+	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, regval))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int lan865x_net_open(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	int ret;
+
+	ret = lan865x_hw_enable(priv);
+	if (ret) {
+		netdev_err(netdev, "Failed to enable hardware: %d\n", ret);
+		return ret;
+	}
+
+	phy_start(netdev->phydev);
+
+	return 0;
+}
+
+static const struct net_device_ops lan865x_netdev_ops = {
+	.ndo_open		= lan865x_net_open,
+	.ndo_stop		= lan865x_net_close,
+	.ndo_start_xmit		= lan865x_send_packet,
+	.ndo_set_rx_mode	= lan865x_set_multicast_list,
+	.ndo_set_mac_address	= lan865x_set_mac_address,
+};
+
+static int lan865x_probe(struct spi_device *spi)
+{
+	struct net_device *netdev;
+	struct lan865x_priv *priv;
+	int ret;
+
+	netdev = alloc_etherdev(sizeof(struct lan865x_priv));
+	if (!netdev)
+		return -ENOMEM;
+
+	priv = netdev_priv(netdev);
+	priv->netdev = netdev;
+	priv->spi = spi;
+	spi_set_drvdata(spi, priv);
+	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
+
+	priv->tc6 = oa_tc6_init(spi, netdev);
+	if (!priv->tc6) {
+		ret = -ENODEV;
+		goto free_netdev;
+	}
+
+	/* As per the point s3 in the below errata, SPI receive Ethernet frame
+	 * transfer may halt when starting the next frame in the same data block
+	 * (chunk) as the end of a previous frame. The RFA field should be
+	 * configured to 01b or 10b for proper operation. In these modes, only
+	 * one receive Ethernet frame will be placed in a single data block.
+	 * When the RFA field is written to 01b, received frames will be forced
+	 * to only start in the first word of the data block payload (SWO=0). As
+	 * recommended, enable zero align receive frame feature for proper
+	 * operation.
+	 *
+	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/Errata/LAN8650-1-Errata-80001075.pdf
+	 */
+	ret = oa_tc6_zero_align_receive_frame_enable(priv->tc6);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to set ZARFE: %d\n", ret);
+		goto oa_tc6_exit;
+	}
+
+	/* Get the MAC address from the SPI device tree node */
+	if (device_get_ethdev_address(&spi->dev, netdev))
+		eth_hw_addr_random(netdev);
+
+	ret = lan865x_set_hw_macaddr(priv, netdev->dev_addr);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to configure MAC: %d\n", ret);
+		goto oa_tc6_exit;
+	}
+
+	netdev->if_port = IF_PORT_10BASET;
+	netdev->irq = spi->irq;
+	netdev->netdev_ops = &lan865x_netdev_ops;
+	netdev->ethtool_ops = &lan865x_ethtool_ops;
+
+	ret = register_netdev(netdev);
+	if (ret) {
+		dev_err(&spi->dev, "Register netdev failed (ret = %d)", ret);
+		goto oa_tc6_exit;
+	}
+
+	return 0;
+
+oa_tc6_exit:
+	oa_tc6_exit(priv->tc6);
+free_netdev:
+	free_netdev(priv->netdev);
+	return ret;
+}
+
+static void lan865x_remove(struct spi_device *spi)
+{
+	struct lan865x_priv *priv = spi_get_drvdata(spi);
+
+	cancel_work_sync(&priv->multicast_work);
+	unregister_netdev(priv->netdev);
+	oa_tc6_exit(priv->tc6);
+	free_netdev(priv->netdev);
+}
+
+static const struct spi_device_id spidev_spi_ids[] = {
+	{ .name = "lan8650" },
+	{},
+};
+
+static const struct of_device_id lan865x_dt_ids[] = {
+	{ .compatible = "microchip,lan8650" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
+
+static struct spi_driver lan865x_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = lan865x_dt_ids,
+	 },
+	.probe = lan865x_probe,
+	.remove = lan865x_remove,
+	.id_table = spidev_spi_ids,
+};
+module_spi_driver(lan865x_driver);
+
+MODULE_DESCRIPTION(DRV_NAME " 10Base-T1S MACPHY Ethernet Driver");
+MODULE_AUTHOR("Parthiban Veerasooran <parthiban.veerasooran@microchip.com>");
+MODULE_LICENSE("GPL");
-- 
2.34.1


