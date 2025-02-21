Return-Path: <netdev+bounces-168525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FADA3F3B9
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA50C19C1C04
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C420E026;
	Fri, 21 Feb 2025 12:03:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CDD20DD63;
	Fri, 21 Feb 2025 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139407; cv=none; b=Ta7V52L++wxzY5XwiuKY0yytgQxlmAxjhT8vNgacT8CI8+EQowkpezuUmVGgZ2nZFeF1ur4l0cRdbqjj5vvMbuyr1zzZBcdb8KOIRBIOcl/i/S/9jO6IVpr9OEo8jCS2wHZlcHnP30pkIaQifV/7RgxM71tpZn8EtpUswZaGljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139407; c=relaxed/simple;
	bh=oiODJzFkCb9kIrwveAa4+CBwKVcqJoTcDD6uWRtTghY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RA+A4vfInzxW3ijK/UiI1MGiPb8KWs0wT9Nvs71kni9wz8dE8zEk7L68L/W3qUsRV2H748NwQIDUUw99v15Lv4vHhsR76rg67Ikw1DsC2b2PZzy19i9rj5VnPzKZLtmyUMErL6CR2FZprziKh6Y4sXbPu26n1NkUZBhhapHGHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Yzpbf2C4ZzHr7j;
	Fri, 21 Feb 2025 20:00:14 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F2F7318010B;
	Fri, 21 Feb 2025 20:03:16 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 20:03:16 +0800
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
Subject: [PATCH v3 net-next 4/6] net: hibmcge: Add support for mac link exception handling feature
Date: Fri, 21 Feb 2025 19:55:24 +0800
Message-ID: <20250221115526.1082660-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250221115526.1082660-1-shaojijie@huawei.com>
References: <20250221115526.1082660-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk100013.china.huawei.com (7.202.194.61)

If the rate changed frequently, the PHY link ok,
but the MAC link maybe fails.
As a result, the network port is unavailable.

According to the documents of the chip,
core_reset needs to do to fix the fault.

In hw_adjus_link(), the core_reset is added to try to
ensure that MAC link status is normal.
In addition, MAC link failure detection is added.
If the MAC link fails after core_reset, driver invokes
the phy_stop() and phy_start() to re-link.

Due to phydev->lock, re-link cannot be triggered
in adjust_link(). Therefore, this operation
is invoked in a scheduled task.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v1 -> v2:
  - Replace phy_reset() with phy_stop() and phy_start(), suggested by Andrew.
  v1: https://lore.kernel.org/all/20250213035529.2402283-1-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  5 +++++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |  2 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 20 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  9 +++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 20 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |  2 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  1 +
 7 files changed, 59 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 4e4d33d2832a..8b943912184b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -37,6 +37,7 @@ enum hbg_nic_state {
 	HBG_NIC_STATE_RESETTING,
 	HBG_NIC_STATE_RESET_FAIL,
 	HBG_NIC_STATE_NEED_RESET, /* trigger a reset in scheduled task */
+	HBG_NIC_STATE_NP_LINK_FAIL,
 };
 
 enum hbg_reset_type {
@@ -82,6 +83,7 @@ enum hbg_hw_event_type {
 	HBG_HW_EVENT_NONE = 0,
 	HBG_HW_EVENT_INIT, /* driver is loading */
 	HBG_HW_EVENT_RESET,
+	HBG_HW_EVENT_CORE_RESET,
 };
 
 struct hbg_dev_specs {
@@ -252,6 +254,8 @@ struct hbg_stats {
 
 	u64 tx_timeout_cnt;
 	u64 tx_dma_err_cnt;
+
+	u64 np_link_fail_cnt;
 };
 
 struct hbg_priv {
@@ -272,5 +276,6 @@ struct hbg_priv {
 };
 
 void hbg_err_reset_task_schedule(struct hbg_priv *priv);
+void hbg_np_link_fail_task_schedule(struct hbg_priv *priv);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index 55ce90b4319a..5e0ba4d5b08d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -117,6 +117,8 @@ static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
 		   reset_type_str[priv->reset_type]);
 	seq_printf(s, "need reset state: %s\n",
 		   state_str_true_false(priv, HBG_NIC_STATE_NEED_RESET));
+	seq_printf(s, "np_link fail state: %s\n",
+		   state_str_true_false(priv, HBG_NIC_STATE_NP_LINK_FAIL));
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index e7798f213645..41047fc38c04 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -213,10 +213,30 @@ void hbg_hw_fill_buffer(struct hbg_priv *priv, u32 buffer_dma_addr)
 
 void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
 {
+	struct hbg_stats *stats = &priv->stats;
+
+	hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
+
 	hbg_reg_write_field(priv, HBG_REG_PORT_MODE_ADDR,
 			    HBG_REG_PORT_MODE_M, speed);
 	hbg_reg_write_field(priv, HBG_REG_DUPLEX_TYPE_ADDR,
 			    HBG_REG_DUPLEX_B, duplex);
+
+	hbg_hw_event_notify(priv, HBG_HW_EVENT_CORE_RESET);
+
+	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
+
+	if (hbg_reg_read_field(priv, HBG_REG_AN_NEG_STATE_ADDR,
+			       HBG_REG_AN_NEG_STATE_NP_LINK_OK_B)) {
+		/* mac link ok */
+		stats->np_link_fail_cnt = 0;
+		return;
+	}
+
+	/* mac link fail */
+	stats->np_link_fail_cnt++;
+	hbg_np_link_fail_task_schedule(priv);
+
 }
 
 /* only support uc filter */
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 40f62db33fed..3b7955f57b4d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -286,6 +286,9 @@ static void hbg_service_task(struct work_struct *work)
 	if (test_and_clear_bit(HBG_NIC_STATE_NEED_RESET, &priv->state))
 		hbg_err_reset(priv);
 
+	if (test_and_clear_bit(HBG_NIC_STATE_NP_LINK_FAIL, &priv->state))
+		hbg_fix_np_link_fail(priv);
+
 	/* The type of statistics register is u32,
 	 * To prevent the statistics register from overflowing,
 	 * the driver dumps the statistics every 30 seconds.
@@ -301,6 +304,12 @@ void hbg_err_reset_task_schedule(struct hbg_priv *priv)
 	schedule_delayed_work(&priv->service_task, 0);
 }
 
+void hbg_np_link_fail_task_schedule(struct hbg_priv *priv)
+{
+	set_bit(HBG_NIC_STATE_NP_LINK_FAIL, &priv->state);
+	schedule_delayed_work(&priv->service_task, 0);
+}
+
 static void hbg_cancel_delayed_work_sync(void *data)
 {
 	cancel_delayed_work_sync(data);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index db6bc4cfb971..9d93aacf12dc 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -17,6 +17,8 @@
 #define HBG_MDIO_OP_TIMEOUT_US		(1 * 1000 * 1000)
 #define HBG_MDIO_OP_INTERVAL_US		(5 * 1000)
 
+#define HBG_NP_LINK_FAIL_RETRY_TIMES	5
+
 static void hbg_mdio_set_command(struct hbg_mac *mac, u32 cmd)
 {
 	hbg_reg_write(HBG_MAC_GET_PRIV(mac), HBG_REG_MDIO_COMMAND_ADDR, cmd);
@@ -127,6 +129,24 @@ static void hbg_flowctrl_cfg(struct hbg_priv *priv)
 	hbg_hw_set_pause_enable(priv, tx_pause, rx_pause);
 }
 
+void hbg_fix_np_link_fail(struct hbg_priv *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+
+	if (!(priv->stats.np_link_fail_cnt % HBG_NP_LINK_FAIL_RETRY_TIMES)) {
+		dev_err(dev, "failed to fix the MAC link status\n");
+		return;
+	}
+
+	dev_err(dev, "failed to link between MAC and PHY, try to fix...\n");
+
+	/* Replace phy_reset() with phy_stop() and phy_start(),
+	 * as suggested by Andrew.
+	 */
+	hbg_phy_stop(priv);
+	hbg_phy_start(priv);
+}
+
 static void hbg_phy_adjust_link(struct net_device *netdev)
 {
 	struct hbg_priv *priv = netdev_priv(netdev);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
index febd02a309c7..f3771c1bbd34 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
@@ -9,4 +9,6 @@
 int hbg_mdio_init(struct hbg_priv *priv);
 void hbg_phy_start(struct hbg_priv *priv);
 void hbg_phy_stop(struct hbg_priv *priv);
+void hbg_fix_np_link_fail(struct hbg_priv *priv);
+
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index c45450ab608c..23c55a24b284 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -54,6 +54,7 @@
 #define HBG_REG_PAUSE_ENABLE_RX_B		BIT(0)
 #define HBG_REG_PAUSE_ENABLE_TX_B		BIT(1)
 #define HBG_REG_AN_NEG_STATE_ADDR		(HBG_REG_SGMII_BASE + 0x0058)
+#define HBG_REG_AN_NEG_STATE_NP_LINK_OK_B	BIT(15)
 #define HBG_REG_TRANSMIT_CTRL_ADDR		(HBG_REG_SGMII_BASE + 0x0060)
 #define HBG_REG_TRANSMIT_CTRL_PAD_EN_B		BIT(7)
 #define HBG_REG_TRANSMIT_CTRL_CRC_ADD_B		BIT(6)
-- 
2.33.0


