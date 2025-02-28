Return-Path: <netdev+bounces-170682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032A9A498B8
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D2F7A9D65
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3ED26D5B0;
	Fri, 28 Feb 2025 12:01:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC03926BD95;
	Fri, 28 Feb 2025 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744114; cv=none; b=n5fYDn0gFwrFNBE2rBfsdCnpHhb8nBQ0FnM4tHdZFRIm0oVMkYYyUxFM4CUU75hbR6Uwd2Z8EBFLA7gkyBYVQqyqi0e76TwDfH0mhr8BNMNwlEQLqGS02BSS+yavF6cFINaKHIefbpZKU0j1X9UMcuLMcPUfnVNt3eoLQODvMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744114; c=relaxed/simple;
	bh=vfMX4wkeW19UVViYd513ez4HGpdIsX1wHjQKZdeOcC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYG6S2aoeWDQ0EKFSyRUws8VWfetdheFqcxyeMdjLiolhRRiE/U086ffE8ilGw1ToIBIPEcArPrvvmcsVkfE/8iNes344r/74EQT2rEpxAdnZk/DLnWYctS5e00nNixHRbZQ0bnj6FtBfHpWN4D/gfFZTto2LA3BdT5TCctKeCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z46CP5FrFz2Cplr;
	Fri, 28 Feb 2025 19:57:37 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 14A9B1400CB;
	Fri, 28 Feb 2025 20:01:44 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 20:01:43 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
	<shaojijie@huawei.com>
Subject: [PATCH v4 net-next 3/6] net: hibmcge: Add support for abnormal irq handling feature
Date: Fri, 28 Feb 2025 19:54:08 +0800
Message-ID: <20250228115411.1750803-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250228115411.1750803-1-shaojijie@huawei.com>
References: <20250228115411.1750803-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)

the hardware error was reported by interrupt,
and need be fixed by doing function reset,
but the whole reset flow takes a long time,
should not do it in irq handler,
so do it in scheduled task.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  5 ++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |  5 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  | 58 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.h  |  1 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  |  1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 55 +++++++++++-------
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  9 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  1 +
 8 files changed, 112 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 920514a8e29a..4e4d33d2832a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -36,6 +36,7 @@ enum hbg_nic_state {
 	HBG_NIC_STATE_EVENT_HANDLING = 0,
 	HBG_NIC_STATE_RESETTING,
 	HBG_NIC_STATE_RESET_FAIL,
+	HBG_NIC_STATE_NEED_RESET, /* trigger a reset in scheduled task */
 };
 
 enum hbg_reset_type {
@@ -104,6 +105,7 @@ struct hbg_irq_info {
 	u32 mask;
 	bool re_enable;
 	bool need_print;
+	bool need_reset;
 	u64 count;
 
 	void (*irq_handle)(struct hbg_priv *priv, struct hbg_irq_info *info);
@@ -220,6 +222,7 @@ struct hbg_stats {
 	u64 rx_fail_comma_cnt;
 
 	u64 rx_dma_err_cnt;
+	u64 rx_fifo_less_empty_thrsld_cnt;
 
 	u64 tx_octets_total_ok_cnt;
 	u64 tx_uc_pkt_cnt;
@@ -268,4 +271,6 @@ struct hbg_priv {
 	struct delayed_work service_task;
 };
 
+void hbg_err_reset_task_schedule(struct hbg_priv *priv);
+
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index 8473c43d171a..55ce90b4319a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -67,10 +67,11 @@ static int hbg_dbg_irq_info(struct seq_file *s, void *unused)
 	for (i = 0; i < priv->vectors.info_array_len; i++) {
 		info = &priv->vectors.info_array[i];
 		seq_printf(s,
-			   "%-20s: enabled: %-5s, logged: %-5s, count: %llu\n",
+			   "%-20s: enabled: %-5s, reset: %-5s, logged: %-5s, count: %llu\n",
 			   info->name,
 			   str_true_false(hbg_hw_irq_is_enabled(priv,
 								info->mask)),
+			   str_true_false(info->need_reset),
 			   str_true_false(info->need_print),
 			   info->count);
 	}
@@ -114,6 +115,8 @@ static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
 		   state_str_true_false(priv, HBG_NIC_STATE_RESET_FAIL));
 	seq_printf(s, "last reset type: %s\n",
 		   reset_type_str[priv->reset_type]);
+	seq_printf(s, "need reset state: %s\n",
+		   state_str_true_false(priv, HBG_NIC_STATE_NEED_RESET));
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
index 4d1f4a33391a..4e8cb66f601c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
@@ -105,6 +105,62 @@ int hbg_reset(struct hbg_priv *priv)
 	return hbg_reset_done(priv, HBG_RESET_TYPE_FUNCTION);
 }
 
+void hbg_err_reset(struct hbg_priv *priv)
+{
+	bool running;
+
+	rtnl_lock();
+	running = netif_running(priv->netdev);
+	if (running)
+		dev_close(priv->netdev);
+
+	hbg_reset(priv);
+
+	/* in hbg_pci_err_detected(), we will detach first,
+	 * so we need to attach before open
+	 */
+	if (!netif_device_present(priv->netdev))
+		netif_device_attach(priv->netdev);
+
+	if (running)
+		dev_open(priv->netdev, NULL);
+	rtnl_unlock();
+}
+
+static pci_ers_result_t hbg_pci_err_detected(struct pci_dev *pdev,
+					     pci_channel_state_t state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+
+	netif_device_detach(netdev);
+
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	pci_disable_device(pdev);
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t hbg_pci_err_slot_reset(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	if (pci_enable_device(pdev)) {
+		dev_err(&pdev->dev,
+			"failed to re-enable PCI device after reset\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	pci_set_master(pdev);
+	pci_restore_state(pdev);
+	pci_save_state(pdev);
+
+	hbg_err_reset(priv);
+	netif_device_attach(netdev);
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
 static void hbg_pci_err_reset_prepare(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -124,6 +180,8 @@ static void hbg_pci_err_reset_done(struct pci_dev *pdev)
 }
 
 static const struct pci_error_handlers hbg_pci_err_handler = {
+	.error_detected = hbg_pci_err_detected,
+	.slot_reset = hbg_pci_err_slot_reset,
 	.reset_prepare = hbg_pci_err_reset_prepare,
 	.reset_done = hbg_pci_err_reset_done,
 };
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h
index d7828e446308..fb9fbe7004e8 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h
@@ -9,5 +9,6 @@
 void hbg_set_pci_err_handler(struct pci_driver *pdrv);
 int hbg_reset(struct hbg_priv *priv);
 int hbg_rebuild(struct hbg_priv *priv);
+void hbg_err_reset(struct hbg_priv *priv);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index f5be8d0ef611..8f1107b85fbb 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -69,6 +69,7 @@ static const struct hbg_ethtool_stats hbg_ethtool_stats_info[] = {
 			HBG_REG_RX_LENGTHFIELD_ERR_CNT_ADDR),
 	HBG_STATS_REG_I(rx_fail_comma_cnt, HBG_REG_RX_FAIL_COMMA_CNT_ADDR),
 	HBG_STATS_I(rx_dma_err_cnt),
+	HBG_STATS_I(rx_fifo_less_empty_thrsld_cnt),
 
 	HBG_STATS_REG_I(tx_uc_pkt_cnt, HBG_REG_TX_UC_PKTS_ADDR),
 	HBG_STATS_REG_I(tx_vlan_pkt_cnt, HBG_REG_TX_TAGGED_ADDR),
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
index 25dd25f096fe..e79e9ab3e530 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -11,6 +11,9 @@ static void hbg_irq_handle_err(struct hbg_priv *priv,
 	if (irq_info->need_print)
 		dev_err(&priv->pdev->dev,
 			"receive error interrupt: %s\n", irq_info->name);
+
+	if (irq_info->need_reset)
+		hbg_err_reset_task_schedule(priv);
 }
 
 static void hbg_irq_handle_tx(struct hbg_priv *priv,
@@ -25,30 +28,38 @@ static void hbg_irq_handle_rx(struct hbg_priv *priv,
 	napi_schedule(&priv->rx_ring.napi);
 }
 
-#define HBG_TXRX_IRQ_I(name, handle) \
-	{#name, HBG_INT_MSK_##name##_B, false, false, 0, handle}
-#define HBG_ERR_IRQ_I(name, need_print) \
-	{#name, HBG_INT_MSK_##name##_B, true, need_print, 0, hbg_irq_handle_err}
+static void hbg_irq_handle_rx_buf_val(struct hbg_priv *priv,
+				      struct hbg_irq_info *irq_info)
+{
+	priv->stats.rx_fifo_less_empty_thrsld_cnt++;
+}
+
+#define HBG_IRQ_I(name, handle) \
+	{#name, HBG_INT_MSK_##name##_B, false, false, false, 0, handle}
+#define HBG_ERR_IRQ_I(name, need_print, ndde_reset) \
+	{#name, HBG_INT_MSK_##name##_B, true, need_print, \
+	ndde_reset, 0, hbg_irq_handle_err}
 
 static struct hbg_irq_info hbg_irqs[] = {
-	HBG_TXRX_IRQ_I(RX, hbg_irq_handle_rx),
-	HBG_TXRX_IRQ_I(TX, hbg_irq_handle_tx),
-	HBG_ERR_IRQ_I(MAC_MII_FIFO_ERR, true),
-	HBG_ERR_IRQ_I(MAC_PCS_RX_FIFO_ERR, true),
-	HBG_ERR_IRQ_I(MAC_PCS_TX_FIFO_ERR, true),
-	HBG_ERR_IRQ_I(MAC_APP_RX_FIFO_ERR, true),
-	HBG_ERR_IRQ_I(MAC_APP_TX_FIFO_ERR, true),
-	HBG_ERR_IRQ_I(SRAM_PARITY_ERR, true),
-	HBG_ERR_IRQ_I(TX_AHB_ERR, true),
-	HBG_ERR_IRQ_I(RX_BUF_AVL, false),
-	HBG_ERR_IRQ_I(REL_BUF_ERR, true),
-	HBG_ERR_IRQ_I(TXCFG_AVL, false),
-	HBG_ERR_IRQ_I(TX_DROP, false),
-	HBG_ERR_IRQ_I(RX_DROP, false),
-	HBG_ERR_IRQ_I(RX_AHB_ERR, true),
-	HBG_ERR_IRQ_I(MAC_FIFO_ERR, false),
-	HBG_ERR_IRQ_I(RBREQ_ERR, false),
-	HBG_ERR_IRQ_I(WE_ERR, false),
+	HBG_IRQ_I(RX, hbg_irq_handle_rx),
+	HBG_IRQ_I(TX, hbg_irq_handle_tx),
+	HBG_ERR_IRQ_I(TX_PKT_CPL, true, true),
+	HBG_ERR_IRQ_I(MAC_MII_FIFO_ERR, true, true),
+	HBG_ERR_IRQ_I(MAC_PCS_RX_FIFO_ERR, true, true),
+	HBG_ERR_IRQ_I(MAC_PCS_TX_FIFO_ERR, true, true),
+	HBG_ERR_IRQ_I(MAC_APP_RX_FIFO_ERR, true, true),
+	HBG_ERR_IRQ_I(MAC_APP_TX_FIFO_ERR, true, true),
+	HBG_ERR_IRQ_I(SRAM_PARITY_ERR, true, false),
+	HBG_ERR_IRQ_I(TX_AHB_ERR, true, true),
+	HBG_IRQ_I(RX_BUF_AVL, hbg_irq_handle_rx_buf_val),
+	HBG_ERR_IRQ_I(REL_BUF_ERR, true, false),
+	HBG_ERR_IRQ_I(TXCFG_AVL, false, false),
+	HBG_ERR_IRQ_I(TX_DROP, false, false),
+	HBG_ERR_IRQ_I(RX_DROP, false, false),
+	HBG_ERR_IRQ_I(RX_AHB_ERR, true, false),
+	HBG_ERR_IRQ_I(MAC_FIFO_ERR, true, true),
+	HBG_ERR_IRQ_I(RBREQ_ERR, true, true),
+	HBG_ERR_IRQ_I(WE_ERR, true, true),
 };
 
 static irqreturn_t hbg_irq_handle(int irq_num, void *p)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 688f408de84c..40f62db33fed 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -283,6 +283,9 @@ static void hbg_service_task(struct work_struct *work)
 	struct hbg_priv *priv = container_of(work, struct hbg_priv,
 					     service_task.work);
 
+	if (test_and_clear_bit(HBG_NIC_STATE_NEED_RESET, &priv->state))
+		hbg_err_reset(priv);
+
 	/* The type of statistics register is u32,
 	 * To prevent the statistics register from overflowing,
 	 * the driver dumps the statistics every 30 seconds.
@@ -292,6 +295,12 @@ static void hbg_service_task(struct work_struct *work)
 			      msecs_to_jiffies(30 * MSEC_PER_SEC));
 }
 
+void hbg_err_reset_task_schedule(struct hbg_priv *priv)
+{
+	set_bit(HBG_NIC_STATE_NEED_RESET, &priv->state);
+	schedule_delayed_work(&priv->service_task, 0);
+}
+
 static void hbg_cancel_delayed_work_sync(void *data)
 {
 	cancel_delayed_work_sync(data);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 106d0e0408ba..c45450ab608c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -148,6 +148,7 @@
 #define HBG_INT_MSK_MAC_PCS_TX_FIFO_ERR_B	BIT(17)
 #define HBG_INT_MSK_MAC_PCS_RX_FIFO_ERR_B	BIT(16)
 #define HBG_INT_MSK_MAC_MII_FIFO_ERR_B		BIT(15)
+#define HBG_INT_MSK_TX_PKT_CPL_B		BIT(14)
 #define HBG_INT_MSK_TX_B			BIT(1) /* just used in driver */
 #define HBG_INT_MSK_RX_B			BIT(0) /* just used in driver */
 #define HBG_REG_CF_INTRPT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0434)
-- 
2.33.0


