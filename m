Return-Path: <netdev+bounces-118063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94324950708
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6100B22C84
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E92B19D098;
	Tue, 13 Aug 2024 14:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713271DFF8;
	Tue, 13 Aug 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557763; cv=none; b=XagT8VfOnd3SFbJ7AAzAhMgxnIK3aYpr5WaCc9aU6Bui1r1cIFdsKtra4qw72L8Vyuhfzi2chpEnypbcAeA0S7SkZHvsYS3jXROHDBL8aRGZM1BMOBr1VBNEYEP9EVJTP3S+YYErrIFKXc1maNWTfS7XPXi7En9zUr9OwIvfxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557763; c=relaxed/simple;
	bh=ovTeCG11jzaqF/J+RBLpusdamo+cHPfsv9sr2km7TqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlDOGgVED6QrQD5PDgDYXVoY2BC7K2hDzTrbIJ/t7IsphqOCBK3d7gcUYmD07UEwKdwgglbV4gTN4zKzlMUOPw2TctPNYaGiv95HXEOIaGyI7jqCfDAl+AtzdZxecOhOyTgEdDTpmZKJLbKdldw8jpeOAbUFbHOxl6E5nrxElIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WjtJD1hK9zQpjN;
	Tue, 13 Aug 2024 21:58:04 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id A4A1E1400FD;
	Tue, 13 Aug 2024 22:02:37 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 22:02:36 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <andrew@lunn.ch>,
	<jdamato@fastly.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH V2 net-next 03/11] net: hibmcge: Add mdio and hardware configuration supported in this module
Date: Tue, 13 Aug 2024 21:56:32 +0800
Message-ID: <20240813135640.1694993-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240813135640.1694993-1-shaojijie@huawei.com>
References: <20240813135640.1694993-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)

this driver using phy through genphy device. Implements the C22
read and write PHY registers interfaces.

Some hardware interfaces related to the PHY are also implemented
in this patch.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  19 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 107 ++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   2 +
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   5 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 253 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |  13 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  38 +++
 .../hisilicon/hibmcge/hbg_reg_union.h         | 112 ++++++++
 8 files changed, 547 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index d1f05484f246..f796287c0868 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -6,6 +6,13 @@
 
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include "hbg_reg.h"
+
+#define HBG_STATUS_DISABLE		0x0
+#define HBG_STATUS_ENABLE		0x1
+#define HBG_DEFAULT_MTU_SIZE		1500
+#define HBG_RX_SKIP1			0x00
+#define HBG_RX_SKIP2			0x01
 
 enum hbg_nic_state {
 	HBG_NIC_STATE_INITED = 0,
@@ -32,6 +39,17 @@ struct hbg_dev_specs {
 	u32 rx_buf_size;
 };
 
+struct hbg_mac {
+	struct mii_bus *mdio_bus;
+	struct phy_device *phydev;
+	u8 phy_addr;
+
+	u32 speed;
+	u32 duplex;
+	u32 autoneg;
+	u32 link_status;
+};
+
 struct hbg_priv {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
@@ -39,6 +57,7 @@ struct hbg_priv {
 	struct regmap *regmap;
 	struct hbg_dev_specs dev_specs;
 	unsigned long state;
+	struct hbg_mac mac;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 978f680ad089..e1294c60cd2d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -68,3 +68,110 @@ int hbg_hw_dev_specs_init(struct hbg_priv *priv)
 
 	return 0;
 }
+
+int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
+{
+	if (speed != HBG_PORT_MODE_SGMII_10M &&
+	    speed != HBG_PORT_MODE_SGMII_100M &&
+	    speed != HBG_PORT_MODE_SGMII_1000M)
+		return -EOPNOTSUPP;
+
+	if (duplex != DUPLEX_FULL && duplex != DUPLEX_HALF)
+		return -EOPNOTSUPP;
+
+	hbg_reg_write_field(priv, HBG_REG_PORT_MODE_ADDR,
+			    HBG_REG_PORT_MODE_M, speed);
+	hbg_reg_write_field(priv, HBG_REG_DUPLEX_TYPE_ADDR,
+			    HBG_REG_DUPLEX_B, duplex);
+
+	priv->mac.speed = speed;
+	priv->mac.duplex = duplex;
+
+	return 0;
+}
+
+static void hbg_hw_init_transmit_control(struct hbg_priv *priv)
+{
+	struct hbg_transmit_control control = {
+		.bits = 0,
+		.pad_enalbe = HBG_STATUS_ENABLE,
+		.crc_add = HBG_STATUS_ENABLE,
+		.an_enable = HBG_STATUS_ENABLE,
+	};
+
+	hbg_reg_write(priv, HBG_REG_TRANSMIT_CONTROL_ADDR, control.bits);
+}
+
+static void hbg_hw_init_rx_ctrl(struct hbg_priv *priv)
+{
+	struct hbg_rx_ctrl ctrl = {
+		.bits = 0,
+		.rx_get_addr_mode = HBG_STATUS_ENABLE,
+		.time_inf_en = HBG_STATUS_DISABLE,
+		.rx_align_num = NET_IP_ALIGN,
+		.rxbuf_1st_skip_size = HBG_RX_SKIP1,
+		.rxbuf_1st_skip_size2 = HBG_RX_SKIP2,
+		.port_num = priv->dev_specs.mac_id,
+	};
+
+	hbg_reg_write(priv, HBG_REG_RX_CTRL_ADDR, ctrl.bits);
+}
+
+static void hbg_hw_init_rx_pkt_mode(struct hbg_priv *priv)
+{
+	struct hbg_rx_pkt_mode mode = {
+		.bits = 0,
+		.parse_mode = 0x1, /* parse from L2 layer */
+	};
+
+	hbg_reg_write(priv, HBG_REG_RX_PKT_MODE_ADDR, mode.bits);
+}
+
+static void hbg_hw_init_recv_ctrl(struct hbg_priv *priv)
+{
+	struct hbg_recv_control ctrl = {
+		.bits = 0,
+		.strip_pad_en = HBG_STATUS_ENABLE,
+	};
+
+	hbg_reg_write(priv, HBG_REG_RECV_CONTROL_ADDR, ctrl.bits);
+}
+
+static void hbg_hw_init_rx_control(struct hbg_priv *priv)
+{
+	hbg_reg_write_field(priv, HBG_REG_RX_BUF_SIZE_ADDR,
+			    HBG_REG_RX_BUF_SIZE_M, priv->dev_specs.rx_buf_size);
+	hbg_hw_init_rx_ctrl(priv);
+	hbg_hw_init_rx_pkt_mode(priv);
+	hbg_hw_init_recv_ctrl(priv);
+	hbg_reg_write_field(priv, HBG_REG_CF_CRC_STRIP_ADDR,
+			    HBG_REG_CF_CRC_STRIP_B, HBG_STATUS_DISABLE);
+}
+
+int hbg_hw_init(struct hbg_priv *priv)
+{
+/* little endian or big endian.
+ * ctrl means packet description, data means skb packet data
+ */
+#define HBG_ENDIAN_CTRL_LE_DATA_BE	0x0
+
+	int ret;
+
+	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_INIT);
+	if (ret)
+		return ret;
+
+	ret = hbg_hw_dev_specs_init(priv);
+	if (ret)
+		return ret;
+
+	hbg_reg_write_field(priv, HBG_REG_BUS_CTRL_ADDR,
+			    HBG_REG_BUS_CTRL_ENDIAN_M,
+			    HBG_ENDIAN_CTRL_LE_DATA_BE);
+	hbg_reg_write_field(priv, HBG_REG_MODE_CHANGE_EN_ADDR,
+			    HBG_REG_MODE_CHANGE_EN_B, HBG_STATUS_ENABLE);
+
+	hbg_hw_init_rx_control(priv);
+	hbg_hw_init_transmit_control(priv);
+	return 0;
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index e977132915e1..c5a2dd49399b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -28,5 +28,7 @@
 
 int hbg_hw_event_notify(struct hbg_priv *priv, enum hbg_hw_event_type event_type);
 int hbg_hw_dev_specs_init(struct hbg_priv *priv);
+int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex);
+int hbg_hw_init(struct hbg_priv *pri);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 5ab3f1df3d21..cba301e49b8e 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include "hbg_common.h"
 #include "hbg_hw.h"
+#include "hbg_mdio.h"
 
 static const struct regmap_config hbg_regmap_config = {
 	.reg_bits	= 32,
@@ -26,11 +27,11 @@ static int hbg_init(struct hbg_priv *priv)
 		return dev_err_probe(dev, PTR_ERR(regmap), "failed to init regmap\n");
 
 	priv->regmap = regmap;
-	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_INIT);
+	ret = hbg_hw_init(priv);
 	if (ret)
 		return ret;
 
-	return hbg_hw_dev_specs_init(priv);
+	return hbg_mdio_init(priv);
 }
 
 static int hbg_pci_init(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
new file mode 100644
index 000000000000..00c03865c0ba
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/phy.h>
+#include "hbg_common.h"
+#include "hbg_hw.h"
+#include "hbg_mdio.h"
+#include "hbg_reg.h"
+
+#define HBG_MAC_GET_PRIV(mac) ((struct hbg_priv *)(mac)->mdio_bus->priv)
+#define HBG_MII_BUS_GET_MAC(bus) (&((struct hbg_priv *)(bus)->priv)->mac)
+
+#define HBG_MDIO_C22_MODE		0x1
+#define HBG_MDIO_C22_REG_WRITE		0x1
+#define HBG_MDIO_C22_REG_READ		0x2
+
+static void hbg_mdio_set_command(struct hbg_mac *mac,
+				 struct hbg_mdio_command *command)
+{
+	hbg_reg_write(HBG_MAC_GET_PRIV(mac), HBG_REG_MDIO_COMMAND_ADDR,
+		      command->bits);
+}
+
+static void hbg_mdio_get_command(struct hbg_mac *mac,
+				 struct hbg_mdio_command *command)
+{
+	command->bits = hbg_reg_read(HBG_MAC_GET_PRIV(mac),
+				     HBG_REG_MDIO_COMMAND_ADDR);
+}
+
+static void hbg_mdio_set_wdata_reg(struct hbg_mac *mac, u16 wdata_value)
+{
+	hbg_reg_write_field(HBG_MAC_GET_PRIV(mac), HBG_REG_MDIO_WDATA_ADDR,
+			    HBG_REG_MDIO_WDATA_M, wdata_value);
+}
+
+static u32 hbg_mdio_get_rdata_reg(struct hbg_mac *mac)
+{
+	return hbg_reg_read_field(HBG_MAC_GET_PRIV(mac),
+				  HBG_REG_MDIO_RDATA_ADDR,
+				  HBG_REG_MDIO_WDATA_M);
+}
+
+static int hbg_mdio_wait_ready(struct hbg_mac *mac)
+{
+#define HBG_MDIO_OP_TIMEOUT_US		(1 * 1000 * 1000)
+#define HBG_MDIO_OP_INTERVAL_US		(5 * 1000)
+
+	struct hbg_priv *priv = HBG_MAC_GET_PRIV(mac);
+	struct hbg_mdio_command command;
+
+	return readl_poll_timeout(priv->io_base + HBG_REG_MDIO_COMMAND_ADDR,
+				  command.bits, !command.mdio_start,
+				  HBG_MDIO_OP_INTERVAL_US,
+				  HBG_MDIO_OP_TIMEOUT_US);
+}
+
+static int hbg_mdio_check_op_status(struct hbg_mac *mac)
+{
+	if (hbg_reg_read(HBG_MAC_GET_PRIV(mac), HBG_REG_MDIO_STA_ADDR))
+		return -EBUSY;
+
+	return 0;
+}
+
+static int hbg_mdio_check_send_result(struct hbg_mac *mac)
+{
+	int ret;
+
+	ret = hbg_mdio_wait_ready(mac);
+	if (ret)
+		return ret;
+
+	return hbg_mdio_check_op_status(mac);
+}
+
+static int hbg_mdio_cmd_send(struct hbg_mac *mac, u32 prt_addr, u32 dev_addr,
+			     u32 type, u32 op_code)
+{
+	struct hbg_mdio_command mdio_cmd;
+
+	hbg_mdio_get_command(mac, &mdio_cmd);
+	mdio_cmd.mdio_st = type;
+	/* if auto scan enabled, this value need fix to 0 */
+	mdio_cmd.mdio_start = 0x1;
+	mdio_cmd.mdio_op = op_code;
+	mdio_cmd.mdio_prtad = prt_addr;
+	mdio_cmd.mdio_devad = dev_addr;
+	hbg_mdio_set_command(mac, &mdio_cmd);
+
+	/* wait operation complete and check the result */
+	return hbg_mdio_check_send_result(mac);
+}
+
+static int hbg_mdio_read22(struct mii_bus *bus, int phy_addr, int regnum)
+{
+	struct hbg_mac *mac = HBG_MII_BUS_GET_MAC(bus);
+	int ret;
+
+	ret = hbg_mdio_check_op_status(mac);
+	if (ret)
+		return ret;
+
+	ret = hbg_mdio_cmd_send(mac, phy_addr, regnum, HBG_MDIO_C22_MODE,
+				HBG_MDIO_C22_REG_READ);
+	if (ret)
+		return ret;
+
+	return hbg_mdio_get_rdata_reg(mac);
+}
+
+static int hbg_mdio_write22(struct mii_bus *bus, int phy_addr, int regnum,
+			    u16 val)
+{
+	struct hbg_mac *mac = HBG_MII_BUS_GET_MAC(bus);
+	int ret;
+
+	ret = hbg_mdio_check_op_status(mac);
+	if (ret)
+		return ret;
+
+	hbg_mdio_set_wdata_reg(mac, val);
+	return hbg_mdio_cmd_send(mac, phy_addr, regnum, HBG_MDIO_C22_MODE,
+				 HBG_MDIO_C22_REG_WRITE);
+}
+
+static int hbg_mdio_init_hw(struct hbg_priv *priv)
+{
+	u32 freq = priv->dev_specs.mdio_frequency;
+	struct hbg_mac *mac = &priv->mac;
+	struct hbg_mdio_command cmd;
+
+	cmd.bits = 0;
+	cmd.mdio_auto_scan = HBG_STATUS_DISABLE;
+	cmd.mdio_st = HBG_MDIO_C22_MODE;
+
+	/* freq use two bits, which are stored in clk_sel and clk_sel_exp */
+	cmd.mdio_clk_sel = freq & 0x1;
+	cmd.mdio_clk_sel_exp = (((u32)freq) >> 1) & 0x1;
+
+	hbg_mdio_set_command(mac, &cmd);
+	return 0;
+}
+
+static void hbg_phy_adjust_link(struct net_device *netdev)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	struct phy_device *phydev = priv->mac.phydev;
+	u32 speed;
+
+	if (phydev->link != priv->mac.link_status) {
+		if (phydev->link) {
+			switch (phydev->speed) {
+			case SPEED_10:
+				speed = HBG_PORT_MODE_SGMII_10M;
+				break;
+			case SPEED_100:
+				speed = HBG_PORT_MODE_SGMII_100M;
+				break;
+			case SPEED_1000:
+				speed = HBG_PORT_MODE_SGMII_1000M;
+				break;
+			default:
+				return;
+			}
+
+			priv->mac.autoneg = phydev->autoneg;
+			hbg_hw_adjust_link(priv, speed, phydev->duplex);
+		}
+
+		priv->mac.link_status = phydev->link;
+		phy_print_status(phydev);
+	}
+}
+
+static void hbg_phy_disconnect(void *data)
+{
+	phy_disconnect((struct phy_device *)data);
+}
+
+static int hbg_phy_connect(struct hbg_priv *priv)
+{
+	struct phy_device *phydev = priv->mac.phydev;
+	struct device *dev = &priv->pdev->dev;
+	struct hbg_mac *mac = &priv->mac;
+	int ret;
+
+	ret = phy_connect_direct(priv->netdev, mac->phydev, hbg_phy_adjust_link,
+				 PHY_INTERFACE_MODE_SGMII);
+	if (ret)
+		return dev_err_probe(dev, -ENOMEM, "failed to connect phy\n");
+
+	ret = devm_add_action_or_reset(dev, hbg_phy_disconnect, mac->phydev);
+	if (ret)
+		return ret;
+
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
+	phy_attached_info(phydev);
+
+	return 0;
+}
+
+void hbg_phy_start(struct hbg_priv *priv)
+{
+	if (!priv->mac.phydev)
+		return;
+
+	phy_start(priv->mac.phydev);
+}
+
+void hbg_phy_stop(struct hbg_priv *priv)
+{
+	if (!priv->mac.phydev)
+		return;
+
+	phy_stop(priv->mac.phydev);
+}
+
+int hbg_mdio_init(struct hbg_priv *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct hbg_mac *mac = &priv->mac;
+	struct phy_device *phydev;
+	struct mii_bus *mdio_bus;
+	int ret;
+
+	mac->phy_addr = priv->dev_specs.phy_addr;
+	mdio_bus = devm_mdiobus_alloc(dev);
+	if (!mdio_bus)
+		return dev_err_probe(dev, -ENOMEM, "failed to alloc MDIO bus\n");
+
+	mdio_bus->parent = dev;
+	mdio_bus->priv = priv;
+	mdio_bus->phy_mask = ~(1 << mac->phy_addr);
+	mdio_bus->name = "hibmcge mii bus";
+	mac->mdio_bus = mdio_bus;
+
+	mdio_bus->read = hbg_mdio_read22;
+	mdio_bus->write = hbg_mdio_write22;
+	snprintf(mdio_bus->id, MII_BUS_ID_SIZE, "%s-%s", "mii", dev_name(dev));
+
+	ret = devm_mdiobus_register(dev, mdio_bus);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register MDIO bus\n");
+
+	phydev = mdiobus_get_phy(mdio_bus, mac->phy_addr);
+	if (!phydev)
+		return dev_err_probe(dev, -EIO, "failed to get phy device\n");
+
+	mac->phydev = phydev;
+	hbg_mdio_init_hw(priv);
+	return hbg_phy_connect(priv);
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
new file mode 100644
index 000000000000..bca38c7fe14b
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_MDIO_H
+#define __HBG_MDIO_H
+
+#include "hbg_common.h"
+
+int hbg_mdio_init(struct hbg_priv *priv);
+u32 hbg_get_link_status(struct hbg_priv *priv);
+void hbg_phy_start(struct hbg_priv *priv);
+void hbg_phy_stop(struct hbg_priv *priv);
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 77153f1132fd..a9885d705cc7 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -4,6 +4,8 @@
 #ifndef __HBG_REG_H
 #define __HBG_REG_H
 
+#include "hbg_reg_union.h"
+
 /* DEV SPEC */
 #define HBG_REG_SPEC_VALID_ADDR			0x0000
 #define HBG_REG_EVENT_REQ_ADDR			0x0004
@@ -17,4 +19,40 @@
 #define HBG_REG_RX_FIFO_NUM_ADDR		0x0034
 #define HBG_REG_VLAN_LAYERS_ADDR		0x0038
 
+/* MDIO */
+#define HBG_REG_MDIO_BASE			0x8000
+#define HBG_REG_MDIO_COMMAND_ADDR		(HBG_REG_MDIO_BASE + 0x0000)
+#define HBG_REG_MDIO_WDATA_ADDR			(HBG_REG_MDIO_BASE + 0x0008)
+#define HBG_REG_MDIO_WDATA_M			GENMASK(15, 0)
+#define HBG_REG_MDIO_RDATA_ADDR			(HBG_REG_MDIO_BASE + 0x000C)
+#define HBG_REG_MDIO_STA_ADDR			(HBG_REG_MDIO_BASE + 0x0010)
+
+/* GMAC */
+#define HBG_REG_SGMII_BASE			0x10000
+#define HBG_REG_DUPLEX_TYPE_ADDR		(HBG_REG_SGMII_BASE + 0x0008)
+#define HBG_REG_DUPLEX_B			BIT(0)
+#define HBG_REG_PORT_MODE_ADDR			(HBG_REG_SGMII_BASE + 0x0040)
+#define HBG_REG_PORT_MODE_M			GENMASK(3, 0)
+#define HBG_REG_TRANSMIT_CONTROL_ADDR		(HBG_REG_SGMII_BASE + 0x0060)
+#define HBG_REG_CF_CRC_STRIP_ADDR		(HBG_REG_SGMII_BASE + 0x01B0)
+#define HBG_REG_CF_CRC_STRIP_B			BIT(1)
+#define HBG_REG_MODE_CHANGE_EN_ADDR		(HBG_REG_SGMII_BASE + 0x01B4)
+#define HBG_REG_MODE_CHANGE_EN_B		BIT(0)
+#define HBG_REG_RECV_CONTROL_ADDR		(HBG_REG_SGMII_BASE + 0x01E0)
+
+/* PCU */
+#define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
+#define HBG_REG_RX_BUF_SIZE_M			GENMASK(15, 0)
+#define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
+#define HBG_REG_BUS_CTRL_ENDIAN_M		GENMASK(2, 1)
+#define HBG_REG_RX_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04F0)
+#define HBG_REG_RX_PKT_MODE_ADDR		(HBG_REG_SGMII_BASE + 0x04F4)
+
+enum hbg_port_mode {
+	/* 0x0 ~ 0x5 are reserved */
+	HBG_PORT_MODE_SGMII_10M = 0x6,
+	HBG_PORT_MODE_SGMII_100M = 0x7,
+	HBG_PORT_MODE_SGMII_1000M = 0x8,
+};
+
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h
new file mode 100644
index 000000000000..fc6cad15438d
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_REG_UNION_H
+#define __HBG_REG_UNION_H
+
+struct hbg_rx_ctrl {
+	union {
+		struct {
+			u32 rxbuf_1st_skip_size2 : 4;
+			u32 cache_line_l : 3;
+			u32 rx_cfg_req_en : 1;
+			u32 cache_line_h : 2;
+			u32 addr_mode : 2;
+			u32 rx_get_addr_mode : 1;
+			u32 port_num : 4;
+			u32 rx_align_num : 2;
+			u32 pool_num : 4;
+			u32 time_inf_en : 1;
+			u32 rxbuf_no_1st_skip_size : 4;
+			u32 rxbuf_1st_skip_size : 4;
+		};
+		u32 bits;
+	};
+};
+
+struct hbg_rx_pkt_mode {
+	union {
+		struct {
+			u32 gen_id : 8;
+			u32 rsv_0 : 4;
+			u32 match_offset : 9;
+			u32 parse_mode : 2;
+			u32 skip_len : 7;
+			u32 rsv_1 : 1;
+			u32 instr_head_mode : 1;
+		};
+		u32 bits;
+	};
+};
+
+struct hbg_transmit_control {
+	union {
+		struct {
+			u32 rsv_0 : 5;
+			u32 an_enable : 1;
+			u32 crc_add : 1;
+			u32 pad_enalbe : 1;
+			u32 rsv_1 : 24;
+		};
+		u32 bits;
+	};
+};
+
+struct hbg_mdio_command {
+	union {
+		struct {
+			u32 mdio_devad : 5;
+			u32 mdio_prtad :5;
+			u32 mdio_op : 2;
+			u32 mdio_st : 2;
+			u32 mdio_start : 1;
+			u32 mdio_clk_sel : 1;
+			u32 mdio_auto_scan : 1;
+			u32 mdio_clk_sel_exp : 1;
+			u32 rev : 14;
+		};
+		u32 bits;
+	};
+};
+
+struct hbg_an_state {
+	union {
+		struct {
+			u32 reserved_0 : 5;
+			/* SerDes autoneg */
+			u32 half_duplex : 1;
+			/* SerDes autoneg */
+			u32 full_duplex : 1;
+			/* SerDes autoneg */
+			u32 support_pause_frame : 2;
+			u32 reserved_1 : 1;
+			/* SerDes autoneg, b10: 1000M; b01: 100M; b00: 10M */
+			u32 speed : 2;
+			/* SGMII autoneg, 0: half duplex; 1: full duplex */
+			u32 duplex : 1;
+			u32 rf2 : 1;
+			u32 reserved_2 : 1;
+			u32 link_ok : 1;
+			u32 reserved_3 : 4;
+			u32 rx_sync_ok : 1;
+			u32 an_done : 1;
+			u32 reserved_4 : 10;
+		};
+		u32 bits;
+	};
+};
+
+struct hbg_recv_control {
+	union {
+		struct {
+			u32 reserved_0 : 3;
+			u32 strip_pad_en : 1;
+			/* short frame transparent transmission enable */
+			u32 runt_pkt_en : 1;
+			u32 reserved_1 : 27;
+		};
+		u32 bits;
+	};
+};
+
+#endif
-- 
2.33.0


