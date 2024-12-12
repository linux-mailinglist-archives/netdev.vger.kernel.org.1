Return-Path: <netdev+bounces-151393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667F29EE8D7
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D9F16676B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECCE215793;
	Thu, 12 Dec 2024 14:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693E55897;
	Thu, 12 Dec 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013830; cv=none; b=nezuWXHSrHVqCX2CJHAZUmivyUcIH3ecgg99GKRBHFHK9L35UyQ/ZOx4qLshgt661c6sLwRrObkaGvxU4KVloHTeLjUF8F6TGeT70Htobn4LQqw02xzy+XAYNO9Bp/KTglN42UVvAxOxs9v6Okd0QtC0v0XXCEwCGhVIS5sIW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013830; c=relaxed/simple;
	bh=kzE6nhrqQ2tRTx/9yZvYAZInzY0QGh6wpzIxfI+8J7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8CVQpBYXq4VQpKmroQafS2pwpDAWeE881yxN0cetOkglgshKCbSS+utrwWYkF2XF4YqiB1JJ03P1x8jf6lJFoa2MCdVNbFttwN4/cjlYkKwiVY8YR7gxUvV/vJxJAXk6BVpAi2LNkgK6s9C/ol+TwtQXg1t/T6W6gS9MyfBzIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y8FHN1W15z1JDsJ;
	Thu, 12 Dec 2024 22:30:08 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 932821A016C;
	Thu, 12 Dec 2024 22:30:24 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Dec 2024 22:30:23 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>, <hkelam@marvell.com>
Subject: [PATCH V7 net-next 3/7] net: hibmcge: Add unicast frame filter supported in this module
Date: Thu, 12 Dec 2024 22:23:30 +0800
Message-ID: <20241212142334.1024136-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241212142334.1024136-1-shaojijie@huawei.com>
References: <20241212142334.1024136-1-shaojijie@huawei.com>
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

MAC supports filtering unmatched unicast packets according to
the MAC address table. This patch adds the support for
unicast frame filtering.

To support automatic restoration of MAC entries
after reset, the driver saves a copy of MAC entries in the driver.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
---
ChangeLog:
v6 -> v7:
  - Delete table_overflow to simplify the code, suggested by Jakub.
  v6: https://lore.kernel.org/all/20241210134855.2864577-1-shaojijie@huawei.com/
v1 -> v2:
  - Add somme comments for filtering, suggested by Andrew.
  v1: https://lore.kernel.org/all/20241023134213.3359092-4-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  12 ++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |  22 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  17 ++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   3 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 136 +++++++++++++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   3 +
 6 files changed, 187 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 96daf058d387..9bb3abe88377 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -84,6 +84,7 @@ struct hbg_dev_specs {
 	u32 vlan_layers;
 	u32 max_mtu;
 	u32 min_mtu;
+	u32 uc_mac_num;
 
 	u32 max_frame_len;
 	u32 rx_buf_size;
@@ -116,6 +117,16 @@ struct hbg_mac {
 	u32 link_status;
 };
 
+struct hbg_mac_table_entry {
+	u8 addr[ETH_ALEN];
+};
+
+struct hbg_mac_filter {
+	struct hbg_mac_table_entry *mac_table;
+	u32 table_max_len;
+	bool enabled;
+};
+
 struct hbg_priv {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
@@ -126,6 +137,7 @@ struct hbg_priv {
 	struct hbg_vector vectors;
 	struct hbg_ring tx_ring;
 	struct hbg_ring rx_ring;
+	struct hbg_mac_filter filter;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index a7e833d2a454..52e779654918 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -77,10 +77,32 @@ static int hbg_dbg_irq_info(struct seq_file *s, void *unused)
 	return 0;
 }
 
+static int hbg_dbg_mac_table(struct seq_file *s, void *unused)
+{
+	struct net_device *netdev = dev_get_drvdata(s->private);
+	struct hbg_priv *priv = netdev_priv(netdev);
+	struct hbg_mac_filter *filter;
+	u32 i;
+
+	filter = &priv->filter;
+	seq_printf(s, "mac addr max count: %u\n", filter->table_max_len);
+	seq_printf(s, "filter enabled: %s\n", str_true_false(filter->enabled));
+
+	for (i = 0; i < filter->table_max_len; i++) {
+		if (is_zero_ether_addr(filter->mac_table[i].addr))
+			continue;
+
+		seq_printf(s, "[%u] %pM\n", i, filter->mac_table[i].addr);
+	}
+
+	return 0;
+}
+
 static const struct hbg_dbg_info hbg_dbg_infos[] = {
 	{ "tx_ring", hbg_dbg_tx_ring },
 	{ "rx_ring", hbg_dbg_rx_ring },
 	{ "irq_info", hbg_dbg_irq_info },
+	{ "mac_table", hbg_dbg_mac_table },
 };
 
 static void hbg_debugfs_uninit(void *data)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 05295c2ad439..29d66a0ea0a6 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -67,6 +67,8 @@ static int hbg_hw_dev_specs_init(struct hbg_priv *priv)
 	specs->vlan_layers = hbg_reg_read(priv, HBG_REG_VLAN_LAYERS_ADDR);
 	specs->rx_fifo_num = hbg_reg_read(priv, HBG_REG_RX_FIFO_NUM_ADDR);
 	specs->tx_fifo_num = hbg_reg_read(priv, HBG_REG_TX_FIFO_NUM_ADDR);
+	specs->uc_mac_num = hbg_reg_read(priv, HBG_REG_UC_MAC_NUM_ADDR);
+
 	mac_addr = hbg_reg_read64(priv, HBG_REG_MAC_ADDR_ADDR);
 	u64_to_ether_addr(mac_addr, (u8 *)specs->mac_addr.sa_data);
 
@@ -135,9 +137,13 @@ void hbg_hw_irq_enable(struct hbg_priv *priv, u32 mask, bool enable)
 	hbg_reg_write(priv, HBG_REG_CF_INTRPT_MSK_ADDR, value);
 }
 
-void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr)
+void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr, u32 index)
 {
-	hbg_reg_write64(priv, HBG_REG_STATION_ADDR_LOW_2_ADDR, mac_addr);
+	u32 addr;
+
+	/* mac addr is u64, so the addr offset is 0x8 */
+	addr = HBG_REG_STATION_ADDR_LOW_2_ADDR + (index * 0x8);
+	hbg_reg_write64(priv, addr, mac_addr);
 }
 
 static void hbg_hw_set_pcu_max_frame_len(struct hbg_priv *priv,
@@ -207,6 +213,13 @@ void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
 			    HBG_REG_DUPLEX_B, duplex);
 }
 
+/* only support uc filter */
+void hbg_hw_set_mac_filter_enable(struct hbg_priv *priv, u32 enable)
+{
+	hbg_reg_write_field(priv, HBG_REG_REC_FILT_CTRL_ADDR,
+			    HBG_REG_REC_FILT_CTRL_UC_MATCH_EN_B, enable);
+}
+
 static void hbg_hw_init_transmit_ctrl(struct hbg_priv *priv)
 {
 	u32 ctrl = 0;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index 14fb39241c93..6eb4b7d2cba8 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -51,9 +51,10 @@ bool hbg_hw_irq_is_enabled(struct hbg_priv *priv, u32 mask);
 void hbg_hw_irq_enable(struct hbg_priv *priv, u32 mask, bool enable);
 void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu);
 void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable);
-void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr);
+void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr, u32 index);
 u32 hbg_hw_get_fifo_used_num(struct hbg_priv *priv, enum hbg_dir dir);
 void hbg_hw_set_tx_desc(struct hbg_priv *priv, struct hbg_tx_desc *tx_desc);
 void hbg_hw_fill_buffer(struct hbg_priv *priv, u32 buffer_dma_addr);
+void hbg_hw_set_mac_filter_enable(struct hbg_priv *priv, u32 enable);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 7a03fdfa32a7..4841fed2a13b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -57,7 +57,7 @@ static int hbg_hw_txrx_clear(struct hbg_priv *priv)
 
 	/* After reset, regs need to be reconfigured */
 	hbg_hw_init(priv);
-	hbg_hw_set_uc_addr(priv, ether_addr_to_u64(priv->netdev->dev_addr));
+	hbg_hw_set_uc_addr(priv, ether_addr_to_u64(priv->netdev->dev_addr), 0);
 	hbg_change_mtu(priv, priv->netdev->mtu);
 
 	return 0;
@@ -75,19 +75,123 @@ static int hbg_net_stop(struct net_device *netdev)
 	return hbg_hw_txrx_clear(priv);
 }
 
+static void hbg_update_promisc_mode(struct net_device *netdev, bool overflow)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	/* Only when not table_overflow, and netdev->flags not set IFF_PROMISC,
+	 * The MAC filter will be enabled.
+	 * Otherwise the filter will be disabled.
+	 */
+	priv->filter.enabled = !(overflow || (netdev->flags & IFF_PROMISC));
+	hbg_hw_set_mac_filter_enable(priv, priv->filter.enabled);
+}
+
+static void hbg_set_mac_to_mac_table(struct hbg_priv *priv,
+				     u32 index, const u8 *addr)
+{
+	if (addr) {
+		ether_addr_copy(priv->filter.mac_table[index].addr, addr);
+		hbg_hw_set_uc_addr(priv, ether_addr_to_u64(addr), index);
+	} else {
+		eth_zero_addr(priv->filter.mac_table[index].addr);
+		hbg_hw_set_uc_addr(priv, 0, index);
+	}
+}
+
+static int hbg_get_index_from_mac_table(struct hbg_priv *priv,
+					const u8 *addr, u32 *index)
+{
+	u32 i;
+
+	for (i = 0; i < priv->filter.table_max_len; i++)
+		if (ether_addr_equal(priv->filter.mac_table[i].addr, addr)) {
+			*index = i;
+			return 0;
+		}
+
+	return -EINVAL;
+}
+
+static int hbg_add_mac_to_filter(struct hbg_priv *priv, const u8 *addr)
+{
+	u32 index;
+
+	/* already exists */
+	if (!hbg_get_index_from_mac_table(priv, addr, &index))
+		return 0;
+
+	for (index = 0; index < priv->filter.table_max_len; index++)
+		if (is_zero_ether_addr(priv->filter.mac_table[index].addr)) {
+			hbg_set_mac_to_mac_table(priv, index, addr);
+			return 0;
+		}
+
+	return -ENOSPC;
+}
+
+static void hbg_del_mac_from_filter(struct hbg_priv *priv, const u8 *addr)
+{
+	u32 index;
+
+	/* not exists */
+	if (hbg_get_index_from_mac_table(priv, addr, &index))
+		return;
+
+	hbg_set_mac_to_mac_table(priv, index, NULL);
+}
+
+static int hbg_uc_sync(struct net_device *netdev, const unsigned char *addr)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	return hbg_add_mac_to_filter(priv, addr);
+}
+
+static int hbg_uc_unsync(struct net_device *netdev, const unsigned char *addr)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	if (ether_addr_equal(netdev->dev_addr, (u8 *)addr))
+		return 0;
+
+	hbg_del_mac_from_filter(priv, addr);
+	return 0;
+}
+
+static void hbg_net_set_rx_mode(struct net_device *netdev)
+{
+	int ret;
+
+	ret = __dev_uc_sync(netdev, hbg_uc_sync, hbg_uc_unsync);
+
+	/* If ret != 0, overflow has occurred */
+	hbg_update_promisc_mode(netdev, !!ret);
+}
+
 static int hbg_net_set_mac_address(struct net_device *netdev, void *addr)
 {
 	struct hbg_priv *priv = netdev_priv(netdev);
 	u8 *mac_addr;
+	bool exists;
+	u32 index;
 
 	mac_addr = ((struct sockaddr *)addr)->sa_data;
 
 	if (!is_valid_ether_addr(mac_addr))
 		return -EADDRNOTAVAIL;
 
-	hbg_hw_set_uc_addr(priv, ether_addr_to_u64(mac_addr));
-	dev_addr_set(netdev, mac_addr);
+	/* The index of host mac is always 0.
+	 * If new mac address already exists,
+	 * delete the existing mac address and
+	 * add it to the position with index 0.
+	 */
+	exists = !hbg_get_index_from_mac_table(priv, mac_addr, &index);
+	hbg_set_mac_to_mac_table(priv, 0, mac_addr);
+	if (exists)
+		hbg_set_mac_to_mac_table(priv, index, NULL);
 
+	dev_addr_set(netdev, mac_addr);
 	return 0;
 }
 
@@ -143,8 +247,28 @@ static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_set_mac_address	= hbg_net_set_mac_address,
 	.ndo_change_mtu		= hbg_net_change_mtu,
 	.ndo_tx_timeout		= hbg_net_tx_timeout,
+	.ndo_set_rx_mode	= hbg_net_set_rx_mode,
 };
 
+static int hbg_mac_filter_init(struct hbg_priv *priv)
+{
+	struct hbg_dev_specs *dev_specs = &priv->dev_specs;
+	struct hbg_mac_filter *filter = &priv->filter;
+	struct hbg_mac_table_entry *tmp_table;
+
+	tmp_table = devm_kcalloc(&priv->pdev->dev, dev_specs->uc_mac_num,
+				 sizeof(*tmp_table), GFP_KERNEL);
+	if (!tmp_table)
+		return -ENOMEM;
+
+	filter->mac_table = tmp_table;
+	filter->table_max_len = dev_specs->uc_mac_num;
+	filter->enabled = true;
+
+	hbg_hw_set_mac_filter_enable(priv, filter->enabled);
+	return 0;
+}
+
 static int hbg_init(struct hbg_priv *priv)
 {
 	int ret;
@@ -165,6 +289,10 @@ static int hbg_init(struct hbg_priv *priv)
 	if (ret)
 		return ret;
 
+	ret = hbg_mac_filter_init(priv);
+	if (ret)
+		return ret;
+
 	hbg_debugfs_init(priv);
 	return 0;
 }
@@ -222,6 +350,8 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+
 	netdev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	netdev->max_mtu = priv->dev_specs.max_mtu;
 	netdev->min_mtu = priv->dev_specs.min_mtu;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 57d81c6d7633..8993f57ecea4 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -10,6 +10,7 @@
 #define HBG_REG_MAC_ID_ADDR			0x0008
 #define HBG_REG_PHY_ID_ADDR			0x000C
 #define HBG_REG_MAC_ADDR_ADDR			0x0010
+#define HBG_REG_UC_MAC_NUM_ADDR			0x0018
 #define HBG_REG_MDIO_FREQ_ADDR			0x0024
 #define HBG_REG_MAX_MTU_ADDR			0x0028
 #define HBG_REG_MIN_MTU_ADDR			0x002C
@@ -47,6 +48,8 @@
 #define HBG_REG_TRANSMIT_CTRL_PAD_EN_B		BIT(7)
 #define HBG_REG_TRANSMIT_CTRL_CRC_ADD_B		BIT(6)
 #define HBG_REG_TRANSMIT_CTRL_AN_EN_B		BIT(5)
+#define HBG_REG_REC_FILT_CTRL_ADDR		(HBG_REG_SGMII_BASE + 0x0064)
+#define HBG_REG_REC_FILT_CTRL_UC_MATCH_EN_B	BIT(0)
 #define HBG_REG_CF_CRC_STRIP_ADDR		(HBG_REG_SGMII_BASE + 0x01B0)
 #define HBG_REG_CF_CRC_STRIP_B			BIT(0)
 #define HBG_REG_MODE_CHANGE_EN_ADDR		(HBG_REG_SGMII_BASE + 0x01B4)
-- 
2.33.0


