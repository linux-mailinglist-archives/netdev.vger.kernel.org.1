Return-Path: <netdev+bounces-138259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7AE9ACB91
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B32B1F22794
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0581C2337;
	Wed, 23 Oct 2024 13:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2031B4F15;
	Wed, 23 Oct 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691347; cv=none; b=eaEE36p+JmnKjSqTXn265WsxmGoAyIYvwRhDisBuKtFw+58y3E491po19ZY+n0YkFRYRgJIzp4toH5hJKBNshQgDta7Bn8CS5OCqJXGe6kyJeNcz6HPiPWqNOKF1PQC/KOk2UpoQghq7R9Z0OkyuoxUMPvTRpIn1VxxbIa+kE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691347; c=relaxed/simple;
	bh=8jUiA3hI4RMlGGxOoGsp4bcFNlF3nKAWx3/88OJgw5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMykE9kH65H0j1QHzeP127rLEcS1FOLxm+0CUwDFohQ4Wgfym3Lk+TP5Xhfh+inq8Qh6YcsEeM07rE+7jUQJx66lPETjBasNDav1r4X+8k7ycCfmbvjL3YV7eWT9H9kONdrQzD5YqvHkezagx9itUzaBLyFvhmfA/iy2HCTo9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XYVk12JhBz20qjg;
	Wed, 23 Oct 2024 21:48:09 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 3358C14035F;
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
Subject: [PATCH net-next 3/7] net: hibmcge: Add unicast frame filter supported in this module
Date: Wed, 23 Oct 2024 21:42:09 +0800
Message-ID: <20241023134213.3359092-4-shaojijie@huawei.com>
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

MAC supports filtering unmatched unicast packets according to the
MAC address table. This patch adds the support for
unicast frame filtering.

To support automatic restoration of MAC entries
after reset, the driver saves a copy of MAC entries in the driver.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  13 ++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |  26 ++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  17 ++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   3 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 141 +++++++++++++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   3 +
 6 files changed, 197 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 411afc9b916b..491192a4fc74 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -84,6 +84,7 @@ struct hbg_dev_specs {
 	u32 vlan_layers;
 	u32 max_mtu;
 	u32 min_mtu;
+	u32 uc_mac_num;
 
 	u32 max_frame_len;
 	u32 rx_buf_size;
@@ -214,6 +215,17 @@ struct hbg_stats {
 	u64 tx_dma_err_cnt;
 };
 
+struct hbg_mac_table_entry {
+	u8 addr[ETH_ALEN];
+};
+
+struct hbg_mac_filter {
+	struct hbg_mac_table_entry *mac_table;
+	u32 table_max_len;
+	bool table_overflow;
+	bool enabled;
+};
+
 struct hbg_priv {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
@@ -226,6 +238,7 @@ struct hbg_priv {
 	struct hbg_ring rx_ring;
 	struct hbg_stats stats;
 	struct delayed_work service_task;
+	struct hbg_mac_filter filter;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index e65e1d498d2b..85d5cb3cd603 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -35,6 +35,7 @@ static int hbg_dbg_dev_spec(struct seq_file *s, void *unused)
 	seq_printf(s, "min mtu: %u, max mtu: %u\n",
 		   specs->min_mtu, specs->max_mtu);
 	seq_printf(s, "mdio frequency: %u\n", specs->mdio_frequency);
+	seq_printf(s, "uc mac max num: %u\n", specs->uc_mac_num);
 
 	return 0;
 }
@@ -109,12 +110,37 @@ static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
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
+	seq_printf(s, "filter enabled: %s\n",
+		   hbg_get_bool_str(filter->enabled));
+	seq_printf(s, "table overflow: %s\n",
+		   hbg_get_bool_str(filter->table_overflow));
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
 	{ "dev_spec", hbg_dbg_dev_spec },
 	{ "tx_ring", hbg_dbg_tx_ring },
 	{ "rx_ring", hbg_dbg_rx_ring },
 	{ "irq_info", hbg_dbg_irq_info },
 	{ "nic_state", hbg_dbg_nic_state },
+	{ "mac_talbe", hbg_dbg_mac_table },
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
index 30576483a938..0b7cfbd166ec 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -57,7 +57,7 @@ static int hbg_hw_txrx_clear(struct hbg_priv *priv)
 
 	/* After reset, regs need to be reconfigured */
 	hbg_hw_init(priv);
-	hbg_hw_set_uc_addr(priv, ether_addr_to_u64(priv->netdev->dev_addr));
+	hbg_hw_set_uc_addr(priv, ether_addr_to_u64(priv->netdev->dev_addr), 0);
 	hbg_change_mtu(priv, priv->netdev->mtu);
 
 	return 0;
@@ -75,19 +75,128 @@ static int hbg_net_stop(struct net_device *netdev)
 	return hbg_hw_txrx_clear(priv);
 }
 
+static void hbg_update_promisc_mode(struct net_device *netdev)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	priv->filter.enabled = !(priv->filter.table_overflow ||
+				 (netdev->flags & IFF_PROMISC));
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
+	if (!priv->filter.table_overflow) {
+		priv->filter.table_overflow = true;
+		hbg_update_promisc_mode(priv->netdev);
+		dev_info(&priv->pdev->dev, "mac table is overflow\n");
+	}
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
+
+	if (priv->filter.table_overflow) {
+		priv->filter.table_overflow = false;
+		hbg_update_promisc_mode(priv->netdev);
+		dev_info(&priv->pdev->dev, "mac table is not full\n");
+	}
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
+	hbg_update_promisc_mode(netdev);
+	__dev_uc_sync(netdev, hbg_uc_sync, hbg_uc_unsync);
+}
+
 static int hbg_net_set_mac_address(struct net_device *netdev, void *addr)
 {
 	struct hbg_priv *priv = netdev_priv(netdev);
 	u8 *mac_addr;
+	bool is_exists;
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
+	is_exists = !hbg_get_index_from_mac_table(priv, mac_addr, &index);
+	hbg_set_mac_to_mac_table(priv, 0, mac_addr);
+	if (is_exists)
+		hbg_set_mac_to_mac_table(priv, index, NULL);
 
+	dev_addr_set(netdev, mac_addr);
 	return 0;
 }
 
@@ -162,6 +271,7 @@ static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_change_mtu		= hbg_net_change_mtu,
 	.ndo_tx_timeout		= hbg_net_tx_timeout,
 	.ndo_get_stats64	= hbg_net_get_stats,
+	.ndo_set_rx_mode	= hbg_net_set_rx_mode,
 };
 
 static void hbg_service_task(struct work_struct *work)
@@ -190,6 +300,25 @@ static void hbg_delaywork_uninit(void *data)
 	cancel_delayed_work_sync(data);
 }
 
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
@@ -214,6 +343,10 @@ static int hbg_init(struct hbg_priv *priv)
 	if (ret)
 		return ret;
 
+	ret = hbg_mac_filter_init(priv);
+	if (ret)
+		return ret;
+
 	hbg_delaywork_init(priv);
 	return devm_add_action_or_reset(&priv->pdev->dev, hbg_delaywork_uninit,
 					&priv->service_task);
@@ -272,6 +405,8 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+
 	netdev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	netdev->max_mtu = priv->dev_specs.max_mtu;
 	netdev->min_mtu = priv->dev_specs.min_mtu;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index b1dbaa98c6b3..59bda7a8ce5f 100644
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
 #define HBG_REG_RX_OCTETS_TOTAL_OK_ADDR		(HBG_REG_SGMII_BASE + 0x0080)
 #define HBG_REG_RX_OCTETS_BAD_ADDR		(HBG_REG_SGMII_BASE + 0x0084)
 #define HBG_REG_RX_UC_PKTS_ADDR			(HBG_REG_SGMII_BASE + 0x0088)
-- 
2.33.0


