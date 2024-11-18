Return-Path: <netdev+bounces-145857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF569D12FD
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F799B2CB2E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0DC1B392C;
	Mon, 18 Nov 2024 14:20:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03819D890;
	Mon, 18 Nov 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939639; cv=none; b=CrA9wnaN38kaeXFrXsL5Xx8JDfgyWZl8/S70rRG85t/+MGI8tp/9P6iqiiQjEkG716VxUGJo+WmODcizbIDvje5Q/WSdiGyk9zQk6idu1vbnIpBa0YhzA/bCmIUgMhDuCmIqrWxfT2s/ej320bEXt7g+5bOUFuFehRShxplbhwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939639; c=relaxed/simple;
	bh=BoTLbHIoh8bNyLjBMsd/uaFL/edAStRognR0rMfFz20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThatL+70H0Ltu1HfPB0ayAscHRUQenyO4GHZOTZVpYeJ+xxS/OTmaJnGs4o2fiXqZJbZENdd60hhyUGM+lSULJh+BIUZ4bD+HAxj+XYgJPf9qj6HqiiPV0kV3lce49W+IWsb+AvVDCi4d0VSwWRZYk/KzX+qPHM3wgxl1Wfm99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XsV960hVhz10V6W;
	Mon, 18 Nov 2024 22:18:34 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F1585180064;
	Mon, 18 Nov 2024 22:20:33 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Nov 2024 22:20:33 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>, <hkelam@marvell.com>
Subject: [PATCH V4 net-next 4/7] net: hibmcge: Add register dump supported in this module
Date: Mon, 18 Nov 2024 22:13:36 +0800
Message-ID: <20241118141339.3224263-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241118141339.3224263-1-shaojijie@huawei.com>
References: <20241118141339.3224263-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

The dump register is an effective way to analyze problems.

To ensure code flexibility, each register contains the type,
offset, and value information. The ethtool does the pretty print
based on these information.

The driver can dynamically add or delete registers that need to be dumped
in the future because information such as type and offset is contained.
ethtool always can do pretty print.

With the ethtool of a specific version,
the following effects are achieved:
[root@localhost sjj]# ./ethtool -d enp131s0f1
[SPEC] VALID                    [0x0000]: 0x00000001
[SPEC] EVENT_REQ                [0x0004]: 0x00000000
[SPEC] MAC_ID                   [0x0008]: 0x00000002
[SPEC] PHY_ADDR                 [0x000c]: 0x00000002
[SPEC] MAC_ADDR_L               [0x0010]: 0x00000808
[SPEC] MAC_ADDR_H               [0x0014]: 0x08080802
[SPEC] UC_MAX_NUM               [0x0018]: 0x00000004
[SPEC] MAX_MTU                  [0x0028]: 0x00000fc2
[SPEC] MIN_MTU                  [0x002c]: 0x00000100
[SPEC] TX_FIFO_NUM              [0x0030]: 0x00000040
[SPEC] RX_FIFO_NUM              [0x0034]: 0x0000007f
[SPEC] VLAN_LAYERS              [0x0038]: 0x00000002
[MDIO] COMMAND_REG              [0x0000]: 0x0000185f
[MDIO] ADDR_REG                 [0x0004]: 0x00000000
[MDIO] WDATA_REG                [0x0008]: 0x0000a000
[MDIO] RDATA_REG                [0x000c]: 0x00000000
[MDIO] STA_REG                  [0x0010]: 0x00000000
[GMAC] DUPLEX_TYPE              [0x0008]: 0x00000001
[GMAC] FD_FC_TYPE               [0x000c]: 0x00008808
[GMAC] FC_TX_TIMER              [0x001c]: 0x000000ff
[GMAC] FD_FC_ADDR_LOW           [0x0020]: 0xc2000001
[GMAC] FD_FC_ADDR_HIGH          [0x0024]: 0x00000180
[GMAC] MAX_FRM_SIZE             [0x003c]: 0x000005f6
[GMAC] PORT_MODE                [0x0040]: 0x00000002
[GMAC] PORT_EN                  [0x0044]: 0x00000006
...

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v1 -> v2:
  - Not pass back ASCII text in dump register, suggested by Andrew.
v1: https://lore.kernel.org/all/20241023134213.3359092-5-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 140 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  34 +++++
 2 files changed, 174 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index c3370114aef3..e7f169d2abb7 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -3,12 +3,152 @@
 
 #include <linux/ethtool.h>
 #include <linux/phy.h>
+#include "hbg_common.h"
 #include "hbg_ethtool.h"
+#include "hbg_hw.h"
+
+enum hbg_reg_dump_type {
+	HBG_DUMP_REG_TYPE_SPEC = 0,
+	HBG_DUMP_REG_TYPE_MDIO,
+	HBG_DUMP_REG_TYPE_GMAC,
+	HBG_DUMP_REG_TYPE_PCU,
+};
+
+struct hbg_reg_info {
+	u32 type;
+	u32 offset;
+	u32 val;
+};
+
+#define HBG_DUMP_SPEC_I(offset) {HBG_DUMP_REG_TYPE_SPEC, offset, 0}
+#define HBG_DUMP_MDIO_I(offset) {HBG_DUMP_REG_TYPE_MDIO, offset, 0}
+#define HBG_DUMP_GMAC_I(offset) {HBG_DUMP_REG_TYPE_GMAC, offset, 0}
+#define HBG_DUMP_PCU_I(offset) {HBG_DUMP_REG_TYPE_PCU, offset, 0}
+
+static const struct hbg_reg_info hbg_dump_reg_infos[] = {
+	/* dev specs */
+	HBG_DUMP_SPEC_I(HBG_REG_SPEC_VALID_ADDR),
+	HBG_DUMP_SPEC_I(HBG_REG_EVENT_REQ_ADDR),
+	HBG_DUMP_SPEC_I(HBG_REG_MAC_ID_ADDR),
+	HBG_DUMP_SPEC_I(HBG_REG_PHY_ID_ADDR),
+	HBG_DUMP_SPEC_I(HBG_REG_MAC_ADDR_ADDR),
+	HBG_DUMP_SPEC_I(HBG_REG_MAC_ADDR_HIGH_ADDR),
+	HBG_DUMP_SPEC_I(HBG_REG_UC_MAC_NUM_ADDR),
+	HBG_DUMP_SPEC_I(HBG_REG_MDIO_FREQ_ADDR),
+	HBG_DUMP_SPEC_I(HBG_REG_MAX_MTU_ADDR),
+	HBG_DUMP_SPEC_I(HBG_REG_MIN_MTU_ADDR),
+	HBG_DUMP_SPEC_I(HBG_REG_TX_FIFO_NUM_ADDR),
+	HBG_DUMP_SPEC_I(HBG_REG_RX_FIFO_NUM_ADDR),
+	HBG_DUMP_SPEC_I(HBG_REG_VLAN_LAYERS_ADDR),
+
+	/* mdio */
+	HBG_DUMP_MDIO_I(HBG_REG_MDIO_COMMAND_ADDR),
+	HBG_DUMP_MDIO_I(HBG_REG_MDIO_ADDR_ADDR),
+	HBG_DUMP_MDIO_I(HBG_REG_MDIO_WDATA_ADDR),
+	HBG_DUMP_MDIO_I(HBG_REG_MDIO_RDATA_ADDR),
+	HBG_DUMP_MDIO_I(HBG_REG_MDIO_STA_ADDR),
+
+	/* gmac */
+	HBG_DUMP_GMAC_I(HBG_REG_DUPLEX_TYPE_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_FD_FC_TYPE_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_FC_TX_TIMER_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_FD_FC_ADDR_LOW_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_FD_FC_ADDR_HIGH_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_MAX_FRAME_SIZE_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_PORT_MODE_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_PORT_ENABLE_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_PAUSE_ENABLE_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_AN_NEG_STATE_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_TRANSMIT_CTRL_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_REC_FILT_CTRL_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_LINE_LOOP_BACK_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_CF_CRC_STRIP_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_MODE_CHANGE_EN_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_LOOP_REG_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_RECV_CTRL_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_VLAN_CODE_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_STATION_ADDR_LOW_0_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_STATION_ADDR_HIGH_0_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_STATION_ADDR_LOW_1_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_STATION_ADDR_HIGH_1_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_STATION_ADDR_LOW_2_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_STATION_ADDR_HIGH_2_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_STATION_ADDR_LOW_3_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_STATION_ADDR_HIGH_3_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_STATION_ADDR_LOW_4_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_STATION_ADDR_HIGH_4_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_STATION_ADDR_LOW_5_ADDR),
+	HBG_DUMP_GMAC_I(HBG_REG_STATION_ADDR_HIGH_5_ADDR),
+
+	/* pcu */
+	HBG_DUMP_PCU_I(HBG_REG_TX_FIFO_THRSLD_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_RX_FIFO_THRSLD_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_CFG_FIFO_THRSLD_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_CF_INTRPT_MSK_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_CF_INTRPT_STAT_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_CF_INTRPT_CLR_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_TX_BUS_ERR_ADDR_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_RX_BUS_ERR_ADDR_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_MAX_FRAME_LEN_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_DEBUG_ST_MCH_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_FIFO_CURR_STATUS_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_FIFO_HIST_STATUS_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_CF_CFF_DATA_NUM_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_CF_TX_PAUSE_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_RX_CFF_ADDR_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_RX_BUF_SIZE_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_BUS_CTRL_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_RX_CTRL_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_RX_PKT_MODE_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_DBG_ST0_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_DBG_ST1_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_DBG_ST2_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_BUS_RST_EN_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_CF_IND_TXINT_MSK_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_CF_IND_TXINT_STAT_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_CF_IND_TXINT_CLR_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_CF_IND_RXINT_MSK_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_CF_IND_RXINT_STAT_ADDR),
+	HBG_DUMP_PCU_I(HBG_REG_CF_IND_RXINT_CLR_ADDR),
+};
+
+static const u32 hbg_dump_type_base_array[] = {
+	[HBG_DUMP_REG_TYPE_SPEC] = 0,
+	[HBG_DUMP_REG_TYPE_MDIO] = HBG_REG_MDIO_BASE,
+	[HBG_DUMP_REG_TYPE_GMAC] = HBG_REG_SGMII_BASE,
+	[HBG_DUMP_REG_TYPE_PCU] = HBG_REG_SGMII_BASE,
+};
+
+static int hbg_ethtool_get_regs_len(struct net_device *netdev)
+{
+	return ARRAY_SIZE(hbg_dump_reg_infos) * sizeof(struct hbg_reg_info);
+}
+
+static void hbg_ethtool_get_regs(struct net_device *netdev,
+				 struct ethtool_regs *regs, void *data)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	struct hbg_reg_info *info;
+	u32 i, offset = 0;
+
+	regs->version = 0;
+	for (i = 0; i < ARRAY_SIZE(hbg_dump_reg_infos); i++) {
+		info = data + offset;
+
+		*info = hbg_dump_reg_infos[i];
+		info->val = hbg_reg_read(priv, info->offset);
+		info->offset -= hbg_dump_type_base_array[info->type];
+
+		offset += sizeof(*info);
+	}
+}
 
 static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+	.get_regs_len		= hbg_ethtool_get_regs_len,
+	.get_regs		= hbg_ethtool_get_regs,
 };
 
 void hbg_ethtool_set_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 8993f57ecea4..665666712c7c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -10,6 +10,7 @@
 #define HBG_REG_MAC_ID_ADDR			0x0008
 #define HBG_REG_PHY_ID_ADDR			0x000C
 #define HBG_REG_MAC_ADDR_ADDR			0x0010
+#define HBG_REG_MAC_ADDR_HIGH_ADDR		0x0014
 #define HBG_REG_UC_MAC_NUM_ADDR			0x0018
 #define HBG_REG_MDIO_FREQ_ADDR			0x0024
 #define HBG_REG_MAX_MTU_ADDR			0x0028
@@ -29,6 +30,7 @@
 #define HBG_REG_MDIO_COMMAND_OP_M		GENMASK(11, 10)
 #define HBG_REG_MDIO_COMMAND_PRTAD_M		GENMASK(9, 5)
 #define HBG_REG_MDIO_COMMAND_DEVAD_M		GENMASK(4, 0)
+#define HBG_REG_MDIO_ADDR_ADDR			(HBG_REG_MDIO_BASE + 0x0004)
 #define HBG_REG_MDIO_WDATA_ADDR			(HBG_REG_MDIO_BASE + 0x0008)
 #define HBG_REG_MDIO_WDATA_M			GENMASK(15, 0)
 #define HBG_REG_MDIO_RDATA_ADDR			(HBG_REG_MDIO_BASE + 0x000C)
@@ -37,6 +39,10 @@
 /* GMAC */
 #define HBG_REG_SGMII_BASE			0x10000
 #define HBG_REG_DUPLEX_TYPE_ADDR		(HBG_REG_SGMII_BASE + 0x0008)
+#define HBG_REG_FD_FC_TYPE_ADDR			(HBG_REG_SGMII_BASE + 0x000C)
+#define HBG_REG_FC_TX_TIMER_ADDR		(HBG_REG_SGMII_BASE + 0x001C)
+#define HBG_REG_FD_FC_ADDR_LOW_ADDR		(HBG_REG_SGMII_BASE + 0x0020)
+#define HBG_REG_FD_FC_ADDR_HIGH_ADDR		(HBG_REG_SGMII_BASE + 0x0024)
 #define HBG_REG_DUPLEX_B			BIT(0)
 #define HBG_REG_MAX_FRAME_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x003C)
 #define HBG_REG_PORT_MODE_ADDR			(HBG_REG_SGMII_BASE + 0x0040)
@@ -44,22 +50,40 @@
 #define HBG_REG_PORT_ENABLE_ADDR		(HBG_REG_SGMII_BASE + 0x0044)
 #define HBG_REG_PORT_ENABLE_RX_B		BIT(1)
 #define HBG_REG_PORT_ENABLE_TX_B		BIT(2)
+#define HBG_REG_PAUSE_ENABLE_ADDR		(HBG_REG_SGMII_BASE + 0x0048)
+#define HBG_REG_AN_NEG_STATE_ADDR		(HBG_REG_SGMII_BASE + 0x0058)
 #define HBG_REG_TRANSMIT_CTRL_ADDR		(HBG_REG_SGMII_BASE + 0x0060)
 #define HBG_REG_TRANSMIT_CTRL_PAD_EN_B		BIT(7)
 #define HBG_REG_TRANSMIT_CTRL_CRC_ADD_B		BIT(6)
 #define HBG_REG_TRANSMIT_CTRL_AN_EN_B		BIT(5)
 #define HBG_REG_REC_FILT_CTRL_ADDR		(HBG_REG_SGMII_BASE + 0x0064)
 #define HBG_REG_REC_FILT_CTRL_UC_MATCH_EN_B	BIT(0)
+#define HBG_REG_LINE_LOOP_BACK_ADDR		(HBG_REG_SGMII_BASE + 0x01A8)
 #define HBG_REG_CF_CRC_STRIP_ADDR		(HBG_REG_SGMII_BASE + 0x01B0)
 #define HBG_REG_CF_CRC_STRIP_B			BIT(0)
 #define HBG_REG_MODE_CHANGE_EN_ADDR		(HBG_REG_SGMII_BASE + 0x01B4)
 #define HBG_REG_MODE_CHANGE_EN_B		BIT(0)
+#define HBG_REG_LOOP_REG_ADDR			(HBG_REG_SGMII_BASE + 0x01DC)
 #define HBG_REG_RECV_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x01E0)
 #define HBG_REG_RECV_CTRL_STRIP_PAD_EN_B	BIT(3)
+#define HBG_REG_VLAN_CODE_ADDR			(HBG_REG_SGMII_BASE + 0x01E8)
+#define HBG_REG_STATION_ADDR_LOW_0_ADDR		(HBG_REG_SGMII_BASE + 0x0200)
+#define HBG_REG_STATION_ADDR_HIGH_0_ADDR	(HBG_REG_SGMII_BASE + 0x0204)
+#define HBG_REG_STATION_ADDR_LOW_1_ADDR		(HBG_REG_SGMII_BASE + 0x0208)
+#define HBG_REG_STATION_ADDR_HIGH_1_ADDR	(HBG_REG_SGMII_BASE + 0x020C)
 #define HBG_REG_STATION_ADDR_LOW_2_ADDR		(HBG_REG_SGMII_BASE + 0x0210)
 #define HBG_REG_STATION_ADDR_HIGH_2_ADDR	(HBG_REG_SGMII_BASE + 0x0214)
+#define HBG_REG_STATION_ADDR_LOW_3_ADDR		(HBG_REG_SGMII_BASE + 0x0218)
+#define HBG_REG_STATION_ADDR_HIGH_3_ADDR	(HBG_REG_SGMII_BASE + 0x021C)
+#define HBG_REG_STATION_ADDR_LOW_4_ADDR		(HBG_REG_SGMII_BASE + 0x0220)
+#define HBG_REG_STATION_ADDR_HIGH_4_ADDR	(HBG_REG_SGMII_BASE + 0x0224)
+#define HBG_REG_STATION_ADDR_LOW_5_ADDR		(HBG_REG_SGMII_BASE + 0x0228)
+#define HBG_REG_STATION_ADDR_HIGH_5_ADDR	(HBG_REG_SGMII_BASE + 0x022C)
 
 /* PCU */
+#define HBG_REG_TX_FIFO_THRSLD_ADDR		(HBG_REG_SGMII_BASE + 0x0420)
+#define HBG_REG_RX_FIFO_THRSLD_ADDR		(HBG_REG_SGMII_BASE + 0x0424)
+#define HBG_REG_CFG_FIFO_THRSLD_ADDR		(HBG_REG_SGMII_BASE + 0x0428)
 #define HBG_REG_CF_INTRPT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x042C)
 #define HBG_INT_MSK_WE_ERR_B			BIT(31)
 #define HBG_INT_MSK_RBREQ_ERR_B			BIT(30)
@@ -81,11 +105,17 @@
 #define HBG_INT_MSK_RX_B			BIT(0) /* just used in driver */
 #define HBG_REG_CF_INTRPT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0434)
 #define HBG_REG_CF_INTRPT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x0438)
+#define HBG_REG_TX_BUS_ERR_ADDR_ADDR		(HBG_REG_SGMII_BASE + 0x043C)
+#define HBG_REG_RX_BUS_ERR_ADDR_ADDR		(HBG_REG_SGMII_BASE + 0x0440)
 #define HBG_REG_MAX_FRAME_LEN_ADDR		(HBG_REG_SGMII_BASE + 0x0444)
 #define HBG_REG_MAX_FRAME_LEN_M			GENMASK(15, 0)
+#define HBG_REG_DEBUG_ST_MCH_ADDR		(HBG_REG_SGMII_BASE + 0x0450)
+#define HBG_REG_FIFO_CURR_STATUS_ADDR		(HBG_REG_SGMII_BASE + 0x0454)
+#define HBG_REG_FIFO_HIST_STATUS_ADDR		(HBG_REG_SGMII_BASE + 0x0458)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR		(HBG_REG_SGMII_BASE + 0x045C)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR_TX_M	GENMASK(8, 0)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR_RX_M	GENMASK(24, 16)
+#define HBG_REG_CF_TX_PAUSE_ADDR		(HBG_REG_SGMII_BASE + 0x0470)
 #define HBG_REG_TX_CFF_ADDR_0_ADDR		(HBG_REG_SGMII_BASE + 0x0488)
 #define HBG_REG_TX_CFF_ADDR_1_ADDR		(HBG_REG_SGMII_BASE + 0x048C)
 #define HBG_REG_TX_CFF_ADDR_2_ADDR		(HBG_REG_SGMII_BASE + 0x0490)
@@ -104,6 +134,10 @@
 #define HBG_REG_RX_CTRL_RXBUF_1ST_SKIP_SIZE2_M	GENMASK(3, 0)
 #define HBG_REG_RX_PKT_MODE_ADDR		(HBG_REG_SGMII_BASE + 0x04F4)
 #define HBG_REG_RX_PKT_MODE_PARSE_MODE_M	GENMASK(22, 21)
+#define HBG_REG_DBG_ST0_ADDR			(HBG_REG_SGMII_BASE + 0x05E4)
+#define HBG_REG_DBG_ST1_ADDR			(HBG_REG_SGMII_BASE + 0x05E8)
+#define HBG_REG_DBG_ST2_ADDR			(HBG_REG_SGMII_BASE + 0x05EC)
+#define HBG_REG_BUS_RST_EN_ADDR			(HBG_REG_SGMII_BASE + 0x0688)
 #define HBG_REG_CF_IND_TXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x0694)
 #define HBG_REG_IND_INTR_MASK_B			BIT(0)
 #define HBG_REG_CF_IND_TXINT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0698)
-- 
2.33.0


