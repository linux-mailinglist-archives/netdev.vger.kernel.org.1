Return-Path: <netdev+bounces-122331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFA5960BD2
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54ED81C23129
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F47B1C3F0B;
	Tue, 27 Aug 2024 13:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050D1BDABE;
	Tue, 27 Aug 2024 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764943; cv=none; b=Dpru4r4DaVKu1v50qTZ5QmGCdMUdsFmrzzN/i5HLSo10LfopREmzjb0ve9lG2+5uV1g2zPdAFg92s7E812ary9VoVVTEFZWZZjN7Lt2zvrwxs1RaLMxfQB/FJSBIo+FSGcwHtP0gzG020l02w+PXX6M6JeOmF2RQaiyDG0wp3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764943; c=relaxed/simple;
	bh=kuRYVGQKJmK1aEUxpvHv1MLWQHrPIW5z4fqxeDE0iR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWK8sL9GdYowFTuT1JPp/35lCVzk+5qfFY6TlgqPF8FX/v2b78SmlFsOnP4kaCBrEPxyHpVKQ8kgyBqE2Ljc7Y3AI4Rc38WcwqMCd/8SkkNzmYOUcGnxIq7yrwsYKMfjHkwnsNKibi/zLlij7gx4WEYNLIQJIj3xAGG1zg7vofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WtSmg05Q2z1HHMX;
	Tue, 27 Aug 2024 21:18:59 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id BF3E218002B;
	Tue, 27 Aug 2024 21:22:17 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 21:22:16 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <shaojijie@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <andrew@lunn.ch>, <jdamato@fastly.com>,
	<horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V5 net-next 03/11] net: hibmcge: Add mdio and hardware configuration supported in this module
Date: Tue, 27 Aug 2024 21:14:47 +0800
Message-ID: <20240827131455.2919051-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240827131455.2919051-1-shaojijie@huawei.com>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)

this driver using phy through genphy device. Implements the C22
read and write PHY registers interfaces.

Some hardware interfaces related to the PHY are also implemented
in this patch.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  19 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  82 +++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |  17 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   9 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 245 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |  12 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  55 ++++
 7 files changed, 436 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 6fbc24803942..e047539a407a 100644
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
 	HBG_NIC_STATE_EVENT_HANDLING = 0,
@@ -31,12 +38,24 @@ struct hbg_dev_specs {
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
 	u8 __iomem *io_base;
 	struct hbg_dev_specs dev_specs;
 	unsigned long state;
+	struct hbg_mac mac;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 677f81022411..61769bad284c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -70,13 +70,93 @@ static int hbg_hw_dev_specs_init(struct hbg_priv *priv)
 	return 0;
 }
 
+void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
+{
+	hbg_reg_write_field(priv, HBG_REG_PORT_MODE_ADDR,
+			    HBG_REG_PORT_MODE_M, speed);
+	hbg_reg_write_field(priv, HBG_REG_DUPLEX_TYPE_ADDR,
+			    HBG_REG_DUPLEX_B, duplex);
+}
+
+static void hbg_hw_init_transmit_control(struct hbg_priv *priv)
+{
+	u32 control = 0;
+
+	control |= FIELD_PREP(HBG_REG_TRANSMIT_CONTROL_AN_EN_B, HBG_STATUS_ENABLE);
+	control |= FIELD_PREP(HBG_REG_TRANSMIT_CONTROL_CRC_ADD_B, HBG_STATUS_ENABLE);
+	control |= FIELD_PREP(HBG_REG_TRANSMIT_CONTROL_PAD_EN_B, HBG_STATUS_ENABLE);
+
+	hbg_reg_write(priv, HBG_REG_TRANSMIT_CONTROL_ADDR, control);
+}
+
+static void hbg_hw_init_rx_ctrl(struct hbg_priv *priv)
+{
+	u32 ctrl = 0;
+
+	ctrl |= FIELD_PREP(HBG_REG_RX_CTRL_RX_GET_ADDR_MODE_B, HBG_STATUS_ENABLE);
+	ctrl |= FIELD_PREP(HBG_REG_RX_CTRL_TIME_INF_EN_B, HBG_STATUS_DISABLE);
+	ctrl |= FIELD_PREP(HBG_REG_RX_CTRL_RXBUF_1ST_SKIP_SIZE_M, HBG_RX_SKIP1);
+	ctrl |= FIELD_PREP(HBG_REG_RX_CTRL_RXBUF_1ST_SKIP_SIZE2_M, HBG_RX_SKIP2);
+	ctrl |= FIELD_PREP(HBG_REG_RX_CTRL_RX_ALIGN_NUM_M, NET_IP_ALIGN);
+	ctrl |= FIELD_PREP(HBG_REG_RX_CTRL_PORT_NUM, priv->dev_specs.mac_id);
+
+	hbg_reg_write(priv, HBG_REG_RX_CTRL_ADDR, ctrl);
+}
+
+static void hbg_hw_init_rx_pkt_mode(struct hbg_priv *priv)
+{
+	u32 mode = 0;
+
+	/* parse from L2 layer */
+	mode |= FIELD_PREP(HBG_REG_RX_PKT_MODE_PARSE_MODE_M, 0x1);
+
+	hbg_reg_write(priv, HBG_REG_RX_PKT_MODE_ADDR, mode);
+}
+
+static void hbg_hw_init_recv_ctrl(struct hbg_priv *priv)
+{
+	u32 ctrl = 0;
+
+	ctrl |= FIELD_PREP(HBG_REG_RECV_CONTROL_STRIP_PAD_EN_B, HBG_STATUS_ENABLE);
+
+	hbg_reg_write(priv, HBG_REG_RECV_CONTROL_ADDR, ctrl);
+}
+
+static void hbg_hw_init_rx_control(struct hbg_priv *priv)
+{
+	hbg_hw_init_rx_ctrl(priv);
+	hbg_hw_init_rx_pkt_mode(priv);
+	hbg_hw_init_recv_ctrl(priv);
+	hbg_reg_write_field(priv, HBG_REG_RX_BUF_SIZE_ADDR,
+			    HBG_REG_RX_BUF_SIZE_M, priv->dev_specs.rx_buf_size);
+	hbg_reg_write_field(priv, HBG_REG_CF_CRC_STRIP_ADDR,
+			    HBG_REG_CF_CRC_STRIP_B, HBG_STATUS_DISABLE);
+}
+
 int hbg_hw_init(struct hbg_priv *priv)
 {
+/* little endian or big endian.
+ * ctrl means packet description, data means skb packet data
+ */
+#define HBG_ENDIAN_CTRL_LE_DATA_BE	0x0
+
 	int ret;
 
 	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_INIT);
 	if (ret)
 		return ret;
 
-	return hbg_hw_dev_specs_init(priv);
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
 }
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index 7460701412a1..88fa378db757 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -27,6 +27,21 @@ static inline void hbg_reg_write64(struct hbg_priv *priv, u32 addr, u64 value)
 	lo_hi_writeq(value, priv->io_base + addr);
 }
 
-int hbg_hw_init(struct hbg_priv *priv);
+#define hbg_reg_read_field(priv, addr, mask) \
+		FIELD_GET(mask, hbg_reg_read(priv, addr))
+
+#define hbg_field_modify(reg_value, mask, value) ({	\
+		(reg_value) &= ~(mask);			\
+		(reg_value) |= FIELD_PREP(mask, value); })
+
+#define hbg_reg_write_field(priv, addr, mask, val) ({		\
+		typeof(priv) _priv = (priv);			\
+		typeof(addr) _addr = (addr);			\
+		u32 _value = hbg_reg_read(_priv, _addr);	\
+		hbg_field_modify(_value, mask, val);		\
+		hbg_reg_write(_priv, _addr, _value); })
+
+int hbg_hw_init(struct hbg_priv *pri);
+void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index a5c12c4b7d89..132711554c1e 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -6,10 +6,17 @@
 #include <linux/pci.h>
 #include "hbg_common.h"
 #include "hbg_hw.h"
+#include "hbg_mdio.h"
 
 static int hbg_init(struct hbg_priv *priv)
 {
-	return hbg_hw_init(priv);
+	int ret;
+
+	ret = hbg_hw_init(priv);
+	if (ret)
+		return ret;
+
+	return hbg_mdio_init(priv);
 }
 
 static int hbg_pci_init(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
new file mode 100644
index 000000000000..ec0d536b5b2a
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -0,0 +1,245 @@
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
+static void hbg_mdio_set_command(struct hbg_mac *mac, u32 cmd)
+{
+	hbg_reg_write(HBG_MAC_GET_PRIV(mac), HBG_REG_MDIO_COMMAND_ADDR, cmd);
+}
+
+static void hbg_mdio_get_command(struct hbg_mac *mac, u32 *cmd)
+{
+	*cmd = hbg_reg_read(HBG_MAC_GET_PRIV(mac), HBG_REG_MDIO_COMMAND_ADDR);
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
+static int hbg_mdio_check_op_status(struct hbg_mac *mac)
+{
+	struct hbg_priv *priv = HBG_MAC_GET_PRIV(mac);
+
+	return hbg_reg_read(priv, HBG_REG_MDIO_STA_ADDR) ? -EBUSY : 0;
+}
+
+static int hbg_mdio_wait_ready(struct hbg_mac *mac)
+{
+#define HBG_MDIO_OP_TIMEOUT_US		(1 * 1000 * 1000)
+#define HBG_MDIO_OP_INTERVAL_US		(5 * 1000)
+
+	struct hbg_priv *priv = HBG_MAC_GET_PRIV(mac);
+	u32 cmd;
+
+	return readl_poll_timeout(priv->io_base + HBG_REG_MDIO_COMMAND_ADDR, cmd,
+				  !FIELD_GET(HBG_REG_MDIO_COMMAND_START_B, cmd),
+				  HBG_MDIO_OP_INTERVAL_US,
+				  HBG_MDIO_OP_TIMEOUT_US);
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
+	u32 cmd = 0;
+
+	hbg_mdio_get_command(mac, &cmd);
+	hbg_field_modify(cmd, HBG_REG_MDIO_COMMAND_ST_M, type);
+	hbg_field_modify(cmd, HBG_REG_MDIO_COMMAND_OP_M, op_code);
+	hbg_field_modify(cmd, HBG_REG_MDIO_COMMAND_PRTAD_M, prt_addr);
+	hbg_field_modify(cmd, HBG_REG_MDIO_COMMAND_DEVAD_M, dev_addr);
+
+	/* if auto scan enabled, this value need fix to 0 */
+	hbg_field_modify(cmd, HBG_REG_MDIO_COMMAND_START_B, 0x1);
+
+	hbg_mdio_set_command(mac, cmd);
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
+	u32 cmd = 0;
+
+	cmd |= FIELD_PREP(HBG_REG_MDIO_COMMAND_ST_M, HBG_MDIO_C22_MODE);
+	cmd |= FIELD_PREP(HBG_REG_MDIO_COMMAND_AUTO_SCAN_B, HBG_STATUS_DISABLE);
+
+	/* freq use two bits, which are stored in clk_sel and clk_sel_exp */
+	cmd |= FIELD_PREP(HBG_REG_MDIO_COMMAND_CLK_SEL_B, freq & 0x1);
+	cmd |= FIELD_PREP(HBG_REG_MDIO_COMMAND_CLK_SEL_EXP_B, (freq >> 1) & 0x1);
+
+	hbg_mdio_set_command(mac, cmd);
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
+			priv->mac.speed = speed;
+			priv->mac.duplex = phydev->duplex;
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
+		return dev_err_probe(dev, ret, "failed to connect phy\n");
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
+	phy_start(priv->mac.phydev);
+}
+
+void hbg_phy_stop(struct hbg_priv *priv)
+{
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
+		return dev_err_probe(dev, -ENODEV, "failed to get phy device\n");
+
+	mac->phydev = phydev;
+	hbg_mdio_init_hw(priv);
+	return hbg_phy_connect(priv);
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
new file mode 100644
index 000000000000..febd02a309c7
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_MDIO_H
+#define __HBG_MDIO_H
+
+#include "hbg_common.h"
+
+int hbg_mdio_init(struct hbg_priv *priv);
+void hbg_phy_start(struct hbg_priv *priv);
+void hbg_phy_stop(struct hbg_priv *priv);
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 77153f1132fd..81e6d6e9a429 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -17,4 +17,59 @@
 #define HBG_REG_RX_FIFO_NUM_ADDR		0x0034
 #define HBG_REG_VLAN_LAYERS_ADDR		0x0038
 
+/* MDIO */
+#define HBG_REG_MDIO_BASE			0x8000
+#define HBG_REG_MDIO_COMMAND_ADDR		(HBG_REG_MDIO_BASE + 0x0000)
+#define HBG_REG_MDIO_COMMAND_CLK_SEL_EXP_B	BIT(17)
+#define HBG_REG_MDIO_COMMAND_AUTO_SCAN_B	BIT(16)
+#define HBG_REG_MDIO_COMMAND_CLK_SEL_B		BIT(15)
+#define HBG_REG_MDIO_COMMAND_START_B		BIT(14)
+#define HBG_REG_MDIO_COMMAND_ST_M		GENMASK(13, 12)
+#define HBG_REG_MDIO_COMMAND_OP_M		GENMASK(11, 10)
+#define HBG_REG_MDIO_COMMAND_PRTAD_M		GENMASK(9, 5)
+#define HBG_REG_MDIO_COMMAND_DEVAD_M		GENMASK(4, 0)
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
+#define HBG_REG_TRANSMIT_CONTROL_PAD_EN_B	BIT(7)
+#define HBG_REG_TRANSMIT_CONTROL_CRC_ADD_B	BIT(6)
+#define HBG_REG_TRANSMIT_CONTROL_AN_EN_B	BIT(5)
+#define HBG_REG_CF_CRC_STRIP_ADDR		(HBG_REG_SGMII_BASE + 0x01B0)
+#define HBG_REG_CF_CRC_STRIP_B			BIT(0)
+#define HBG_REG_MODE_CHANGE_EN_ADDR		(HBG_REG_SGMII_BASE + 0x01B4)
+#define HBG_REG_MODE_CHANGE_EN_B		BIT(0)
+#define HBG_REG_RECV_CONTROL_ADDR		(HBG_REG_SGMII_BASE + 0x01E0)
+#define HBG_REG_RECV_CONTROL_STRIP_PAD_EN_B	BIT(3)
+
+/* PCU */
+#define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
+#define HBG_REG_RX_BUF_SIZE_M			GENMASK(15, 0)
+#define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
+#define HBG_REG_BUS_CTRL_ENDIAN_M		GENMASK(2, 1)
+#define HBG_REG_RX_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04F0)
+#define HBG_REG_RX_CTRL_RXBUF_1ST_SKIP_SIZE_M	GENMASK(31, 28)
+#define HBG_REG_RX_CTRL_TIME_INF_EN_B		BIT(23)
+#define HBG_REG_RX_CTRL_RX_ALIGN_NUM_M		GENMASK(18, 17)
+#define HBG_REG_RX_CTRL_PORT_NUM		GENMASK(16, 13)
+#define HBG_REG_RX_CTRL_RX_GET_ADDR_MODE_B	BIT(12)
+#define HBG_REG_RX_CTRL_RXBUF_1ST_SKIP_SIZE2_M	GENMASK(3, 0)
+#define HBG_REG_RX_PKT_MODE_ADDR		(HBG_REG_SGMII_BASE + 0x04F4)
+#define HBG_REG_RX_PKT_MODE_PARSE_MODE_M	GENMASK(22, 21)
+
+enum hbg_port_mode {
+	/* 0x0 ~ 0x5 are reserved */
+	HBG_PORT_MODE_SGMII_10M = 0x6,
+	HBG_PORT_MODE_SGMII_100M = 0x7,
+	HBG_PORT_MODE_SGMII_1000M = 0x8,
+};
+
 #endif
-- 
2.33.0


