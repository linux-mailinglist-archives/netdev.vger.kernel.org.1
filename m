Return-Path: <netdev+bounces-138257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59699ACB8E
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827102843D1
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4CF1BD01E;
	Wed, 23 Oct 2024 13:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D61ABEA2;
	Wed, 23 Oct 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691347; cv=none; b=ZPAW2nHZ84BH4AxV6z2h34gWHnadbXBYTndCDCqmobe59Zb/ebXVlL9nfv8xZEkf5NN8uadyscqE5exsiadeiu3CEJ6shbFiMATTMlTuZLjNpNeWCl1dQV/BG+UBMNKcIeBxF6jl3qBc5RUC/22j/7OZ1qgZYVIo2f3EPS3e5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691347; c=relaxed/simple;
	bh=W3S/mEQ7wNbzHx7mYYvHKkAG8EaOqz9brbXsm1goMg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4kYcvhs0EgzQK3cBYYaLiDzafs26jgfVxdNr/pNX7y7wZWYRypJR7pdA2fhDKbgf+zGLXbAze0K1tB/N6taHJ0nGK2XTaHRn6OsxzYOxFcK90kmn8wyfj7ZAekWWVtNyCYQoze6rRtH+z5e+rrk2fiKtlVFqWAnkDTtzsNuyPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XYVh73QzTzdkJc;
	Wed, 23 Oct 2024 21:46:31 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id D205214010D;
	Wed, 23 Oct 2024 21:49:01 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 21:49:00 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 4/7] net: hibmcge: Add register dump supported in this module
Date: Wed, 23 Oct 2024 21:42:10 +0800
Message-ID: <20241023134213.3359092-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241023134213.3359092-1-shaojijie@huawei.com>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)

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
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 163 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  34 ++++
 2 files changed, 197 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index 59f8c84d43fa..a630c7d8ef5c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -133,6 +133,126 @@ static const struct hbg_ethtool_stats hbg_ethtool_stats_map[] = {
 	HBG_STATS_I(tx_dma_err_cnt),
 };
 
+#define HBG_REG_NAEM_MAX_LEN	24
+#define HBG_REG_TYPE_MAX_LEN	8
+
+struct hbg_reg_offset_name_map {
+	u32 reg_offset;
+	char name[HBG_REG_NAEM_MAX_LEN];
+};
+
+struct hbg_reg_type_info {
+	char name[HBG_REG_TYPE_MAX_LEN];
+	u32 offset_base;
+	const struct hbg_reg_offset_name_map *reg_maps;
+	u32 reg_num;
+};
+
+struct hbg_reg_info {
+	char name[HBG_REG_NAEM_MAX_LEN + HBG_REG_TYPE_MAX_LEN];
+	u32 offset;
+	u32 val;
+};
+
+const struct hbg_reg_offset_name_map hbg_dev_spec_reg_map[] = {
+	{HBG_REG_SPEC_VALID_ADDR, "VALID"},
+	{HBG_REG_EVENT_REQ_ADDR, "EVENT_REQ"},
+	{HBG_REG_MAC_ID_ADDR, "MAC_ID"},
+	{HBG_REG_PHY_ID_ADDR, "PHY_ADDR"},
+	{HBG_REG_MAC_ADDR_ADDR, "MAC_ADDR_L"},
+	{HBG_REG_MAC_ADDR_HIGH_ADDR, "MAC_ADDR_H"},
+	{HBG_REG_UC_MAC_NUM_ADDR, "UC_MAX_NUM"},
+	{HBG_REG_MAX_MTU_ADDR, "MAX_MTU"},
+	{HBG_REG_MIN_MTU_ADDR, "MIN_MTU"},
+	{HBG_REG_TX_FIFO_NUM_ADDR, "TX_FIFO_NUM"},
+	{HBG_REG_RX_FIFO_NUM_ADDR, "RX_FIFO_NUM"},
+	{HBG_REG_VLAN_LAYERS_ADDR, "VLAN_LAYERS"},
+};
+
+const struct hbg_reg_offset_name_map hbg_mdio_reg_map[] = {
+	{HBG_REG_MDIO_COMMAND_ADDR, "COMMAND_REG"},
+	{HBG_REG_MDIO_ADDR_ADDR, "ADDR_REG"},
+	{HBG_REG_MDIO_WDATA_ADDR, "WDATA_REG"},
+	{HBG_REG_MDIO_RDATA_ADDR, "RDATA_REG"},
+	{HBG_REG_MDIO_STA_ADDR, "STA_REG"},
+};
+
+const struct hbg_reg_offset_name_map hbg_gmac_reg_map[] = {
+	{HBG_REG_DUPLEX_TYPE_ADDR, "DUPLEX_TYPE"},
+	{HBG_REG_FD_FC_TYPE_ADDR, "FD_FC_TYPE"},
+	{HBG_REG_FC_TX_TIMER_ADDR, "FC_TX_TIMER"},
+	{HBG_REG_FD_FC_ADDR_LOW_ADDR, "FD_FC_ADDR_LOW"},
+	{HBG_REG_FD_FC_ADDR_HIGH_ADDR, "FD_FC_ADDR_HIGH"},
+	{HBG_REG_MAX_FRAME_SIZE_ADDR, "MAX_FRM_SIZE"},
+	{HBG_REG_PORT_MODE_ADDR, "PORT_MODE"},
+	{HBG_REG_PORT_ENABLE_ADDR, "PORT_EN"},
+	{HBG_REG_PAUSE_ENABLE_ADDR, "PAUSE_EN"},
+	{HBG_REG_AN_NEG_STATE_ADDR, "AN_NEG_STATE"},
+	{HBG_REG_LINE_LOOP_BACK_ADDR, "LINE_LOOP_BACK"},
+	{HBG_REG_CF_CRC_STRIP_ADDR, "CF_CRC_STRIP"},
+	{HBG_REG_MODE_CHANGE_EN_ADDR, "MODE_CHANGE_EN"},
+	{HBG_REG_LOOP_REG_ADDR, "LOOP_REG"},
+	{HBG_REG_RECV_CTRL_ADDR, "RECV_CONTROL"},
+	{HBG_REG_VLAN_CODE_ADDR, "VLAN_CODE"},
+	{HBG_REG_STATION_ADDR_LOW_0_ADDR, "STATION_ADDR_LOW_0"},
+	{HBG_REG_STATION_ADDR_HIGH_0_ADDR, "STATION_ADDR_HIGH_0"},
+	{HBG_REG_STATION_ADDR_LOW_1_ADDR, "STATION_ADDR_LOW_1"},
+	{HBG_REG_STATION_ADDR_HIGH_1_ADDR, "STATION_ADDR_HIGH_1"},
+	{HBG_REG_STATION_ADDR_LOW_2_ADDR, "STATION_ADDR_LOW_2"},
+	{HBG_REG_STATION_ADDR_HIGH_2_ADDR, "STATION_ADDR_HIGH_2"},
+	{HBG_REG_STATION_ADDR_LOW_3_ADDR, "STATION_ADDR_LOW_3"},
+	{HBG_REG_STATION_ADDR_HIGH_3_ADDR, "STATION_ADDR_HIGH_3"},
+	{HBG_REG_STATION_ADDR_LOW_4_ADDR, "STATION_ADDR_LOW_4"},
+	{HBG_REG_STATION_ADDR_HIGH_4_ADDR, "STATION_ADDR_HIGH_4"},
+	{HBG_REG_STATION_ADDR_LOW_5_ADDR, "STATION_ADDR_LOW_5"},
+	{HBG_REG_STATION_ADDR_HIGH_5_ADDR, "STATION_ADDR_HIGH_5"},
+};
+
+const struct hbg_reg_offset_name_map hbg_pcu_reg_map[] = {
+	{HBG_REG_TX_FIFO_THRSLD_ADDR, "CF_TX_FIFO_THRSLD"},
+	{HBG_REG_RX_FIFO_THRSLD_ADDR, "CF_RX_FIFO_THRSLD"},
+	{HBG_REG_CFG_FIFO_THRSLD_ADDR, "CF_CFG_FIFO_THRSLD"},
+	{HBG_REG_CF_INTRPT_MSK_ADDR, "CF_INTRPT_MSK"},
+	{HBG_REG_CF_INTRPT_STAT_ADDR, "CF_INTRPT_STAT"},
+	{HBG_REG_CF_INTRPT_CLR_ADDR, "CF_INTRPT_CLR"},
+	{HBG_REG_TX_BUS_ERR_ADDR_ADDR, "TX_BUS_ERR_ADDR"},
+	{HBG_REG_RX_BUS_ERR_ADDR_ADDR, "RX_BUS_ERR_ADDR"},
+	{HBG_REG_MAX_FRAME_LEN_ADDR, "MAX_FRAME_LEN"},
+	{HBG_REG_DEBUG_ST_MCH_ADDR, "DEBUG_ST_MCH"},
+	{HBG_REG_FIFO_CURR_STATUS_ADDR, "FIFO_CURR_STATUS"},
+	{HBG_REG_FIFO_HIST_STATUS_ADDR, "FIFO_HIS_STATUS"},
+	{HBG_REG_CF_CFF_DATA_NUM_ADDR, "CF_CFF_DATA_NUM"},
+	{HBG_REG_CF_TX_PAUSE_ADDR, "CF_TX_PAUSE"},
+	{HBG_REG_TX_CFF_ADDR_0_ADDR, "TX_CFF_ADDR_0"},
+	{HBG_REG_TX_CFF_ADDR_1_ADDR, "TX_CFF_ADDR_1"},
+	{HBG_REG_TX_CFF_ADDR_2_ADDR, "TX_CFF_ADDR_2"},
+	{HBG_REG_TX_CFF_ADDR_3_ADDR, "TX_CFF_ADDR_3"},
+	{HBG_REG_RX_CFF_ADDR_ADDR, "RX_CFF_ADDR"},
+	{HBG_REG_RX_BUF_SIZE_ADDR, "RX_BUF_SIZE"},
+	{HBG_REG_BUS_CTRL_ADDR, "BUS_CTRL"},
+	{HBG_REG_RX_CTRL_ADDR, "RX_CTRL"},
+	{HBG_REG_RX_PKT_MODE_ADDR, "RX_PKT_MODE"},
+	{HBG_REG_DBG_ST0_ADDR, "DBG_ST0"},
+	{HBG_REG_DBG_ST1_ADDR, "DBG_ST1"},
+	{HBG_REG_DBG_ST2_ADDR, "DBG_ST2"},
+	{HBG_REG_BUS_RST_EN_ADDR, "BUS_RST_EN"},
+	{HBG_REG_CF_IND_TXINT_MSK_ADDR, "CF_IND_TXINT_MSK"},
+	{HBG_REG_CF_IND_TXINT_STAT_ADDR, "CF_IND_TXINT_STAT"},
+	{HBG_REG_CF_IND_TXINT_CLR_ADDR, "CF_IND_TXINT_CLR"},
+	{HBG_REG_CF_IND_RXINT_MSK_ADDR, "CF_IND_RXINT_MSK"},
+	{HBG_REG_CF_IND_RXINT_STAT_ADDR, "CF_IND_RXINT_STAT"},
+	{HBG_REG_CF_IND_RXINT_CLR_ADDR, "CF_IND_RXINT_CLR"},
+};
+
+#define HBG_REG_TYPE_INFO_I(name, base, map) {name, base, map, ARRAY_SIZE(map)}
+
+const struct hbg_reg_type_info hbg_type_infos[] = {
+	HBG_REG_TYPE_INFO_I("SPEC", 0, hbg_dev_spec_reg_map),
+	HBG_REG_TYPE_INFO_I("MDIO", HBG_REG_MDIO_BASE, hbg_mdio_reg_map),
+	HBG_REG_TYPE_INFO_I("GMAC", HBG_REG_SGMII_BASE, hbg_gmac_reg_map),
+	HBG_REG_TYPE_INFO_I("PCU", HBG_REG_SGMII_BASE, hbg_pcu_reg_map),
+};
+
 static int hbg_ethtool_get_sset_count(struct net_device *netdev, int stringset)
 {
 	if (stringset != ETH_SS_STATS)
@@ -180,6 +300,47 @@ static void hbg_ethtool_get_stats(struct net_device *netdev,
 					 hbg_ethtool_stats_map[i].offset);
 }
 
+static int hbg_ethtool_get_regs_len(struct net_device *netdev)
+{
+	u32 len = 0;
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(hbg_type_infos); i++)
+		len += hbg_type_infos[i].reg_num * sizeof(struct hbg_reg_info);
+
+	return len;
+}
+
+static u32 hbg_get_reg_info(struct hbg_priv *priv,
+			    const struct hbg_reg_type_info *type_info,
+			    const struct hbg_reg_offset_name_map *reg_map,
+			    struct hbg_reg_info *info)
+{
+	info->val = hbg_reg_read(priv, reg_map->reg_offset);
+	info->offset = reg_map->reg_offset - type_info->offset_base;
+	snprintf(info->name, sizeof(info->name),
+		 "[%s] %s", type_info->name, reg_map->name);
+
+	return sizeof(*info);
+}
+
+static void hbg_ethtool_get_regs(struct net_device *netdev,
+				 struct ethtool_regs *regs, void *data)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	const struct hbg_reg_type_info *info;
+	u32 i, j, offset = 0;
+
+	regs->version = 0;
+	for (i = 0; i < ARRAY_SIZE(hbg_type_infos); i++) {
+		info = &hbg_type_infos[i];
+		for (j = 0; j < info->reg_num; j++)
+			offset += hbg_get_reg_info(priv, info,
+						   &info->reg_maps[j],
+						   data + offset);
+	}
+}
+
 static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
@@ -187,6 +348,8 @@ static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_sset_count		= hbg_ethtool_get_sset_count,
 	.get_strings		= hbg_ethtool_get_strings,
 	.get_ethtool_stats	= hbg_ethtool_get_stats,
+	.get_regs_len		= hbg_ethtool_get_regs_len,
+	.get_regs		= hbg_ethtool_get_regs,
 };
 
 void hbg_ethtool_set_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 59bda7a8ce5f..bbfefe9c1e61 100644
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
@@ -44,6 +50,8 @@
 #define HBG_REG_PORT_ENABLE_ADDR		(HBG_REG_SGMII_BASE + 0x0044)
 #define HBG_REG_PORT_ENABLE_RX_B		BIT(1)
 #define HBG_REG_PORT_ENABLE_TX_B		BIT(2)
+#define HBG_REG_PAUSE_ENABLE_ADDR		(HBG_REG_SGMII_BASE + 0x0048)
+#define HBG_REG_AN_NEG_STATE_ADDR		(HBG_REG_SGMII_BASE + 0x0058)
 #define HBG_REG_TRANSMIT_CTRL_ADDR		(HBG_REG_SGMII_BASE + 0x0060)
 #define HBG_REG_TRANSMIT_CTRL_PAD_EN_B		BIT(7)
 #define HBG_REG_TRANSMIT_CTRL_CRC_ADD_B		BIT(6)
@@ -92,19 +100,35 @@
 #define HBG_REG_TX_TAGGED_ADDR			(HBG_REG_SGMII_BASE + 0x0154)
 #define HBG_REG_TX_CRC_ERROR_ADDR		(HBG_REG_SGMII_BASE + 0x0158)
 #define HBG_REG_TX_PAUSE_FRAMES_ADDR		(HBG_REG_SGMII_BASE + 0x015C)
+#define HBG_REG_LINE_LOOP_BACK_ADDR		(HBG_REG_SGMII_BASE + 0x01A8)
 #define HBG_REG_CF_CRC_STRIP_ADDR		(HBG_REG_SGMII_BASE + 0x01B0)
 #define HBG_REG_CF_CRC_STRIP_B			BIT(0)
 #define HBG_REG_MODE_CHANGE_EN_ADDR		(HBG_REG_SGMII_BASE + 0x01B4)
 #define HBG_REG_MODE_CHANGE_EN_B		BIT(0)
+#define HBG_REG_LOOP_REG_ADDR			(HBG_REG_SGMII_BASE + 0x01DC)
 #define HBG_REG_RECV_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x01E0)
+#define HBG_REG_VLAN_CODE_ADDR			(HBG_REG_SGMII_BASE + 0x01E8)
 #define HBG_REG_RECV_CTRL_STRIP_PAD_EN_B	BIT(3)
 #define HBG_REG_RX_OVERRUN_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x01EC)
 #define HBG_REG_RX_LENGTHFIELD_ERR_CNT_ADDR	(HBG_REG_SGMII_BASE + 0x01F4)
 #define HBG_REG_RX_FAIL_COMMA_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x01F8)
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
@@ -126,10 +150,15 @@
 #define HBG_INT_MSK_RX_B			BIT(0) /* just used in driver */
 #define HBG_REG_CF_INTRPT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0434)
 #define HBG_REG_CF_INTRPT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x0438)
+#define HBG_REG_TX_BUS_ERR_ADDR_ADDR		(HBG_REG_SGMII_BASE + 0x043C)
+#define HBG_REG_RX_BUS_ERR_ADDR_ADDR		(HBG_REG_SGMII_BASE + 0x0440)
 #define HBG_REG_MAX_FRAME_LEN_ADDR		(HBG_REG_SGMII_BASE + 0x0444)
 #define HBG_REG_TX_DROP_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0448)
 #define HBG_REG_RX_OVER_FLOW_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x044C)
 #define HBG_REG_MAX_FRAME_LEN_M			GENMASK(15, 0)
+#define HBG_REG_DEBUG_ST_MCH_ADDR		(HBG_REG_SGMII_BASE + 0x0450)
+#define HBG_REG_FIFO_CURR_STATUS_ADDR		(HBG_REG_SGMII_BASE + 0x0454)
+#define HBG_REG_FIFO_HIST_STATUS_ADDR		(HBG_REG_SGMII_BASE + 0x0458)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR		(HBG_REG_SGMII_BASE + 0x045C)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR_TX_M	GENMASK(8, 0)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR_RX_M	GENMASK(24, 16)
@@ -137,6 +166,7 @@
 #define HBG_REG_RX_TRANS_PKG_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0464)
 #define HBG_REG_TX_TRANS_PKG_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0468)
 #define HBG_REG_RX_ADDR_OVERFLOW_ADDR		(HBG_REG_SGMII_BASE + 0x046C)
+#define HBG_REG_CF_TX_PAUSE_ADDR		(HBG_REG_SGMII_BASE + 0x0470)
 #define HBG_REG_TX_CFF_ADDR_0_ADDR		(HBG_REG_SGMII_BASE + 0x0488)
 #define HBG_REG_TX_CFF_ADDR_1_ADDR		(HBG_REG_SGMII_BASE + 0x048C)
 #define HBG_REG_TX_CFF_ADDR_2_ADDR		(HBG_REG_SGMII_BASE + 0x0490)
@@ -158,6 +188,10 @@
 #define HBG_REG_RX_BUFRQ_ERR_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x058C)
 #define HBG_REG_TX_BUFRL_ERR_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0590)
 #define HBG_REG_RX_WE_ERR_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0594)
+#define HBG_REG_DBG_ST0_ADDR			(HBG_REG_SGMII_BASE + 0x05E4)
+#define HBG_REG_DBG_ST1_ADDR			(HBG_REG_SGMII_BASE + 0x05E8)
+#define HBG_REG_DBG_ST2_ADDR			(HBG_REG_SGMII_BASE + 0x05EC)
+#define HBG_REG_BUS_RST_EN_ADDR			(HBG_REG_SGMII_BASE + 0x0688)
 #define HBG_REG_CF_IND_TXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x0694)
 #define HBG_REG_IND_INTR_MASK_B			BIT(0)
 #define HBG_REG_CF_IND_TXINT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0698)
-- 
2.33.0


