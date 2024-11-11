Return-Path: <netdev+bounces-143774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A299C4170
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 16:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135FBB22C48
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A01AA781;
	Mon, 11 Nov 2024 15:03:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E1374D1;
	Mon, 11 Nov 2024 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337384; cv=none; b=nqte5rb8G2ksWIRwqDb7zlpaRzXtTwkGo3IybfyM3gdOM7/pbJkNSxmX01PuEzBYynJ0wQexOXNOP/79Ng67B+cu9+BqCVSClBoNfVBkoFhQkp/bs2xVdzQymlC12ENnySOEwRhhrTrdzMmWfnaR7mP9XE92LcZPtQRaoaBVDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337384; c=relaxed/simple;
	bh=Lq9/GtDIdJfUFxrTDnIlHjOrNIb/+S4E1kf4JgAHY6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWQhERC/ax2I7DP6yDkO2kNtExulm7VYwie2ohZ6o/DFDYVFWSfy/GsYOLMfBZzZJIeZyKcKfaie7PdOFGvXzn8zYARwWxZn+F82bOD7yPLakG5LEUjfEsQ5iMAaIB1T4xKwgn5k+Ih75k8v5kA/EqXhBR5tKrev81Bl4+43YlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XnCTh4DlGz1ynk6;
	Mon, 11 Nov 2024 23:03:04 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6280F1402D0;
	Mon, 11 Nov 2024 23:02:53 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Nov 2024 23:02:52 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V3 net-next 6/7] net: hibmcge: Add reset supported in this module
Date: Mon, 11 Nov 2024 22:55:57 +0800
Message-ID: <20241111145558.1965325-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241111145558.1965325-1-shaojijie@huawei.com>
References: <20241111145558.1965325-1-shaojijie@huawei.com>
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

Sometimes, if the port doesn't work, we can try to fix it by resetting it.

This patch supports reset triggered by ethtool or FLR of PCIe, For example:
 ethtool --reset eth0 dedicated
 echo 1 > /sys/bus/pci/devices/0000\:83\:00.1/reset

We hope that the reset can be performed only when the port is down,
and the port cannot be up during the reset.
Therefore, the entire reset process is protected by the rtnl lock.
But the ethtool command already holds the rtnl lock in the dev_ethtool().
So, the reset operation is not directly performed in
ethtool_ops.reset() function. Instead, the reset operation
is triggered by a scheduled task.

After the reset is complete, the hardware registers are restored
to their default values. Therefore, some rebuild operations are
required to rewrite the user configuration to the registers.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hibmcge/Makefile   |   2 +-
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  20 +++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |  23 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  | 138 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.h  |  13 ++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  |  15 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  10 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  63 +++++---
 8 files changed, 262 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/Makefile b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
index 1a0ec2fb8c24..7ea15f9ef849 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/Makefile
+++ b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
@@ -6,4 +6,4 @@
 obj-$(CONFIG_HIBMCGE) += hibmcge.o
 
 hibmcge-objs = hbg_main.o hbg_hw.o hbg_mdio.o hbg_irq.o hbg_txrx.o hbg_ethtool.o \
-		hbg_debugfs.o
+		hbg_debugfs.o hbg_err.o
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index e071f77754fe..490a12d32e8c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -4,6 +4,7 @@
 #ifndef __HBG_COMMON_H
 #define __HBG_COMMON_H
 
+#include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include "hbg_reg.h"
@@ -33,6 +34,15 @@ enum hbg_tx_state {
 
 enum hbg_nic_state {
 	HBG_NIC_STATE_EVENT_HANDLING = 0,
+	HBG_NIC_STATE_NEED_RESET,
+	HBG_NIC_STATE_RESETTING,
+	HBG_NIC_STATE_RESET_FAIL,
+};
+
+enum hbg_reset_type {
+	HBG_RESET_TYPE_NONE = 0,
+	HBG_RESET_TYPE_FLR,
+	HBG_RESET_TYPE_FUNCTION,
 };
 
 struct hbg_buffer {
@@ -128,6 +138,11 @@ struct hbg_mac_filter {
 	bool enabled;
 };
 
+/* saved for restore after rest */
+struct hbg_user_def {
+	struct ethtool_pauseparam pause_param;
+};
+
 struct hbg_priv {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
@@ -139,6 +154,11 @@ struct hbg_priv {
 	struct hbg_ring tx_ring;
 	struct hbg_ring rx_ring;
 	struct hbg_mac_filter filter;
+	struct delayed_work service_task;
+	struct hbg_user_def user_def;
+	enum hbg_reset_type reset_type;
 };
 
+void hbg_reset_task_schedule(struct hbg_priv *priv);
+
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index 2f9d30a51f62..1284d1d431c3 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -19,6 +19,7 @@ struct hbg_dbg_info {
 };
 
 #define hbg_get_bool_str(state) ((state) ? "true" : "false")
+#define hbg_get_state_str(p, s) hbg_get_bool_str(test_bit(s, &(p)->state))
 
 static void hbg_dbg_ring(struct hbg_priv *priv, struct hbg_ring *ring,
 			 struct seq_file *s)
@@ -101,11 +102,33 @@ static int hbg_dbg_mac_table(struct seq_file *s, void *unused)
 	return 0;
 }
 
+static const char * const reset_type_str[] = {"None", "FLR", "Function"};
+
+static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
+{
+	struct net_device *netdev = dev_get_drvdata(s->private);
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	seq_printf(s, "event handling state: %s\n",
+		   hbg_get_state_str(priv, HBG_NIC_STATE_EVENT_HANDLING));
+	seq_printf(s, "need reset state: %s\n",
+		   hbg_get_state_str(priv, HBG_NIC_STATE_NEED_RESET));
+	seq_printf(s, "resetting state: %s\n",
+		   hbg_get_state_str(priv, HBG_NIC_STATE_RESETTING));
+	seq_printf(s, "reset fail state: %s\n",
+		   hbg_get_state_str(priv, HBG_NIC_STATE_RESET_FAIL));
+	seq_printf(s, "last reset type: %s\n",
+		   reset_type_str[priv->reset_type]);
+
+	return 0;
+}
+
 static const struct hbg_dbg_info hbg_dbg_infos[] = {
 	{ "tx_ring", hbg_dbg_tx_ring },
 	{ "rx_ring", hbg_dbg_rx_ring },
 	{ "irq_info", hbg_dbg_irq_info },
 	{ "mac_talbe", hbg_dbg_mac_table },
+	{ "nic_state", hbg_dbg_nic_state },
 };
 
 static void hbg_debugfs_uninit(void *data)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
new file mode 100644
index 000000000000..fd12a396baf0
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/phy.h>
+#include <linux/rtnetlink.h>
+#include "hbg_common.h"
+#include "hbg_err.h"
+#include "hbg_hw.h"
+
+static void hbg_restore_mac_table(struct hbg_priv *priv)
+{
+	struct hbg_mac_filter *filter = &priv->filter;
+	u64 addr;
+	u32 i;
+
+	for (i = 0; i < filter->table_max_len; i++)
+		if (!is_zero_ether_addr(filter->mac_table[i].addr)) {
+			addr = ether_addr_to_u64(filter->mac_table[i].addr);
+			hbg_hw_set_uc_addr(priv, addr, i);
+		}
+
+	hbg_hw_set_mac_filter_enable(priv, priv->filter.enabled);
+}
+
+static void hbg_restore_user_def_settings(struct hbg_priv *priv)
+{
+	struct ethtool_pauseparam *pause_param = &priv->user_def.pause_param;
+
+	hbg_restore_mac_table(priv);
+
+	hbg_hw_set_mtu(priv, priv->netdev->mtu);
+	hbg_hw_set_pause_enable(priv, !!pause_param->tx_pause,
+				!!pause_param->rx_pause);
+}
+
+int hbg_rebuild(struct hbg_priv *priv)
+{
+	int ret;
+
+	ret = hbg_hw_init(priv);
+	if (ret)
+		return ret;
+
+	hbg_restore_user_def_settings(priv);
+	return 0;
+}
+
+static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
+{
+	int ret = -EBUSY;
+
+	rtnl_lock();
+
+	set_bit(HBG_NIC_STATE_RESETTING, &priv->state);
+
+	if (netif_running(priv->netdev)) {
+		dev_warn(&priv->pdev->dev,
+			 "failed to reset because port is up\n");
+		goto unlock;
+	}
+
+	priv->reset_type = type;
+	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_RESET);
+	if (!ret)
+		return 0;
+
+	set_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
+
+unlock:
+	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
+	rtnl_unlock();
+	return ret;
+}
+
+static int hbg_reset_done(struct hbg_priv *priv, enum hbg_reset_type type)
+{
+	int ret;
+
+	if (!test_bit(HBG_NIC_STATE_RESETTING, &priv->state) ||
+	    type != priv->reset_type)
+		return 0;
+
+	ASSERT_RTNL();
+
+	ret = hbg_rebuild(priv);
+	if (ret) {
+		set_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
+		dev_err(&priv->pdev->dev, "failed to rebuild after reset\n");
+		goto unlock;
+	}
+
+	clear_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
+	dev_info(&priv->pdev->dev, "reset done\n");
+
+unlock:
+	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
+	rtnl_unlock();
+	return ret;
+}
+
+int hbg_reset(struct hbg_priv *priv)
+{
+	int ret;
+
+	ret = hbg_reset_prepare(priv, HBG_RESET_TYPE_FUNCTION);
+	if (ret)
+		return ret;
+
+	return hbg_reset_done(priv, HBG_RESET_TYPE_FUNCTION);
+}
+
+static void hbg_pci_err_reset_prepare(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	hbg_reset_prepare(priv, HBG_RESET_TYPE_FLR);
+}
+
+static void hbg_pci_err_reset_done(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	hbg_reset_done(priv, HBG_RESET_TYPE_FLR);
+}
+
+static const struct pci_error_handlers hbg_pci_err_handler = {
+	.reset_prepare = hbg_pci_err_reset_prepare,
+	.reset_done = hbg_pci_err_reset_done,
+};
+
+void hbg_set_pci_err_handler(struct pci_driver *pdrv)
+{
+	pdrv->err_handler = &hbg_pci_err_handler;
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h
new file mode 100644
index 000000000000..d7828e446308
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef __HBG_ERR_H
+#define __HBG_ERR_H
+
+#include <linux/pci.h>
+
+void hbg_set_pci_err_handler(struct pci_driver *pdrv);
+int hbg_reset(struct hbg_priv *priv);
+int hbg_rebuild(struct hbg_priv *priv);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index edad07826b94..14df8fb5cd91 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -4,6 +4,7 @@
 #include <linux/ethtool.h>
 #include <linux/phy.h>
 #include "hbg_common.h"
+#include "hbg_err.h"
 #include "hbg_ethtool.h"
 #include "hbg_hw.h"
 
@@ -160,6 +161,19 @@ static int hbg_ethtool_set_pauseparam(struct net_device *net_dev,
 		return -EOPNOTSUPP;
 
 	hbg_hw_set_pause_enable(priv, !!param->tx_pause, !!param->rx_pause);
+	priv->user_def.pause_param = *param;
+	return 0;
+}
+
+static int hbg_ethtool_reset(struct net_device *netdev, u32 *flags)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	if (*flags != ETH_RESET_DEDICATED)
+		return -EOPNOTSUPP;
+
+	hbg_reset_task_schedule(priv);
+	*flags = 0;
 	return 0;
 }
 
@@ -171,6 +185,7 @@ static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_regs		= hbg_ethtool_get_regs,
 	.get_pauseparam         = hbg_ethtool_get_pauseparam,
 	.set_pauseparam         = hbg_ethtool_set_pauseparam,
+	.reset			= hbg_ethtool_reset,
 };
 
 void hbg_ethtool_set_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 0cbe9f7229b3..e7798f213645 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -3,6 +3,7 @@
 
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/if_vlan.h>
 #include <linux/iopoll.h>
 #include <linux/minmax.h>
 #include "hbg_common.h"
@@ -167,8 +168,13 @@ static void hbg_hw_set_mac_max_frame_len(struct hbg_priv *priv,
 
 void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu)
 {
-	hbg_hw_set_pcu_max_frame_len(priv, mtu);
-	hbg_hw_set_mac_max_frame_len(priv, mtu);
+	u32 frame_len;
+
+	frame_len = mtu + VLAN_HLEN * priv->dev_specs.vlan_layers +
+		    ETH_HLEN + ETH_FCS_LEN;
+
+	hbg_hw_set_pcu_max_frame_len(priv, frame_len);
+	hbg_hw_set_mac_max_frame_len(priv, frame_len);
 }
 
 void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index a45a63856e61..5e5e5caab74c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -6,6 +6,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include "hbg_common.h"
+#include "hbg_err.h"
 #include "hbg_ethtool.h"
 #include "hbg_hw.h"
 #include "hbg_irq.h"
@@ -13,8 +14,6 @@
 #include "hbg_txrx.h"
 #include "hbg_debugfs.h"
 
-static void hbg_change_mtu(struct hbg_priv *priv, int new_mtu);
-
 static void hbg_all_irq_enable(struct hbg_priv *priv, bool enabled)
 {
 	struct hbg_irq_info *info;
@@ -56,11 +55,7 @@ static int hbg_hw_txrx_clear(struct hbg_priv *priv)
 		return ret;
 
 	/* After reset, regs need to be reconfigured */
-	hbg_hw_init(priv);
-	hbg_hw_set_uc_addr(priv, ether_addr_to_u64(priv->netdev->dev_addr), 0);
-	hbg_change_mtu(priv, priv->netdev->mtu);
-
-	return 0;
+	return hbg_rebuild(priv);
 }
 
 static int hbg_net_stop(struct net_device *netdev)
@@ -209,15 +204,6 @@ static int hbg_net_set_mac_address(struct net_device *netdev, void *addr)
 	return 0;
 }
 
-static void hbg_change_mtu(struct hbg_priv *priv, int new_mtu)
-{
-	u32 frame_len;
-
-	frame_len = new_mtu + VLAN_HLEN * priv->dev_specs.vlan_layers +
-		    ETH_HLEN + ETH_FCS_LEN;
-	hbg_hw_set_mtu(priv, frame_len);
-}
-
 static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct hbg_priv *priv = netdev_priv(netdev);
@@ -225,7 +211,7 @@ static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu)
 	if (netif_running(netdev))
 		return -EBUSY;
 
-	hbg_change_mtu(priv, new_mtu);
+	hbg_hw_set_mtu(priv, new_mtu);
 	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	dev_dbg(&priv->pdev->dev,
@@ -283,6 +269,41 @@ static int hbg_mac_filter_init(struct hbg_priv *priv)
 	return 0;
 }
 
+void hbg_reset_task_schedule(struct hbg_priv *priv)
+{
+	set_bit(HBG_NIC_STATE_NEED_RESET, &priv->state);
+
+	schedule_delayed_work(&priv->service_task, 0);
+}
+
+static void hbg_service_task(struct work_struct *work)
+{
+	struct hbg_priv *priv = container_of(work, struct hbg_priv,
+					     service_task.work);
+
+	if (test_and_clear_bit(HBG_NIC_STATE_NEED_RESET, &priv->state))
+		hbg_reset(priv);
+}
+
+static void hbg_delaywork_init(struct hbg_priv *priv)
+{
+	INIT_DELAYED_WORK(&priv->service_task, hbg_service_task);
+	schedule_delayed_work(&priv->service_task, 0);
+}
+
+static void hbg_delaywork_uninit(void *data)
+{
+	cancel_delayed_work_sync(data);
+}
+
+static void hbg_init_user_def(struct hbg_priv *priv)
+{
+	struct ethtool_pauseparam *pause_param = &priv->user_def.pause_param;
+
+	hbg_hw_get_pause_enable(priv, &pause_param->tx_pause,
+				&pause_param->rx_pause);
+}
+
 static int hbg_init(struct hbg_priv *priv)
 {
 	int ret;
@@ -308,7 +329,10 @@ static int hbg_init(struct hbg_priv *priv)
 		return ret;
 
 	hbg_debugfs_init(priv);
-	return 0;
+	hbg_init_user_def(priv);
+	hbg_delaywork_init(priv);
+	return devm_add_action_or_reset(&priv->pdev->dev, hbg_delaywork_uninit,
+					&priv->service_task);
 }
 
 static int hbg_pci_init(struct pci_dev *pdev)
@@ -372,7 +396,7 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->netdev_ops = &hbg_netdev_ops;
 	netdev->watchdog_timeo = 5 * HZ;
 
-	hbg_change_mtu(priv, ETH_DATA_LEN);
+	hbg_hw_set_mtu(priv, ETH_DATA_LEN);
 	hbg_net_set_mac_address(priv->netdev, &priv->dev_specs.mac_addr);
 	hbg_ethtool_set_ops(netdev);
 
@@ -401,6 +425,7 @@ static int __init hbg_module_init(void)
 	int ret;
 
 	hbg_debugfs_register();
+	hbg_set_pci_err_handler(&hbg_driver);
 	ret = pci_register_driver(&hbg_driver);
 	if (ret)
 		hbg_debugfs_unregister();
-- 
2.33.0


