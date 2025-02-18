Return-Path: <netdev+bounces-167249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B29A39681
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E617A441C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9231422C35B;
	Tue, 18 Feb 2025 09:07:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC222AE74;
	Tue, 18 Feb 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869670; cv=none; b=AFiQDlZb658myZFkPmEe3EJlTeYJqjeNOv6knVPryP7vW7CmLXxmrLyFhAzY0IsJOXaxY2RxCkHKpxDM/Ta1PzWydelOG2jcxzRh6u57VQ/8vVjXaKITGSZbm8ylOl7607xq3q9UrWTcL/8v9lG4A5nO+AuM2n5Y8H2ib0HoRw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869670; c=relaxed/simple;
	bh=79PknZh6ltyYQm3IYH5diTFGNkITqu1KzDL/A/ZtQWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAxMEmZd/6H2RraG96GQYWYakwhA9MPk1SQLEPr9WsgZSueLgyrrMADxzZ1eZFN4wnj7wRTBJX4RcpTlk5uA7/amkjFxf61+DtxmFKX9ygATFgEjrowYXMXOurs2CBmCLP3/ZMr833t5dmcHZBOiQVc2Z0MyxS3IQi4unEZvGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Yxtwc6zlkzpkBV;
	Tue, 18 Feb 2025 17:08:16 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 56BF61A0188;
	Tue, 18 Feb 2025 17:07:46 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Feb 2025 17:07:45 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net-next 3/6] net: hibmcge: Add abnormal irq handling feature in this module
Date: Tue, 18 Feb 2025 16:58:26 +0800
Message-ID: <20250218085829.3172126-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250218085829.3172126-1-shaojijie@huawei.com>
References: <20250218085829.3172126-1-shaojijie@huawei.com>
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
index 23d32a04f0b8..9e163ed15bc7 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -290,6 +290,9 @@ static void hbg_service_task(struct work_struct *work)
 	struct hbg_priv *priv = container_of(work, struct hbg_priv,
 					     service_task.work);
 
+	if (test_and_clear_bit(HBG_NIC_STATE_NEED_RESET, &priv->state))
+		hbg_err_reset(priv);
+
 	/* The type of statistics register is u32,
 	 * To prevent the statistics register from overflowing,
 	 * the driver dumps the statistics every 30 seconds.
@@ -299,6 +302,12 @@ static void hbg_service_task(struct work_struct *work)
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


