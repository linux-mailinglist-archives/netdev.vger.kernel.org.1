Return-Path: <netdev+bounces-138260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69F09ACB96
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830C72843AF
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADA61C75FA;
	Wed, 23 Oct 2024 13:49:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7010F1B652C;
	Wed, 23 Oct 2024 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691349; cv=none; b=OdPo2oSig7Y7/YaXAVncm6/+ZJv+LQmnn3wjQdEsaSdJhXhf71yD/M0F84q/8es63rmE7VimgUaCIosWeDnInwLeUqbdelsKHQebUgz14DaWZJj8/2nmnztT72EXRZeQkUBlNCANWINyVuEF8lHhsj3xvABvw/+aBv5OWm5yFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691349; c=relaxed/simple;
	bh=yE2s/lACwzD/14tqCV0WavLQ87XA/Tt78ANsxi0bV8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oysjq3vVEN9FZQkyweojKWuI9Ly9Nuh8kRlmQZnX54ABPselp1u4M/Rxpi5UNy7YtjDQAxGmYRn6ePy94DS6mIHpLlIiM7eQxJBn7zH5XpCO7kx/PXXQK7juOd6f4mLMYWVtFKUZxAolYpfRbw+WOIplSzaFToiUuZUiLT9YFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XYVjS3Thfz2FbBp;
	Wed, 23 Oct 2024 21:47:40 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id C5AE6180019;
	Wed, 23 Oct 2024 21:49:03 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 21:49:02 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 7/7] net: hibmcge: Add reset supported in this module
Date: Wed, 23 Oct 2024 21:42:13 +0800
Message-ID: <20241023134213.3359092-8-shaojijie@huawei.com>
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

Sometimes, if the port doesn't work, we can try to fix it by resetting it.

This patch supports reset triggered by ethtool or FLR of PCIe, For example:
 ethtool --reset eth0 dedicated
 echo 1 > /sys/bus/pci/devices/0000\:83\:00.1/reset

We hope that the reset can be performed only when the port is down,
and the port cannot be up during the reset.
Therefore, the entire reset process is protected by the rtnl lock.
But the ethtool command already holds the rtnl lock in the dev_ethtool().
Therefore, the reset operation is not directly performed in
ethtool_ops.reset() function. Instead, the reset operation
is triggered by a scheduled task.

After the reset is complete, the hardware registers are restored
to their default values. Therefore, some rebuild operations are
required to rewrite the user configuration to the registers.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hibmcge/Makefile   |   2 +-
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  22 +++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |  14 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  | 140 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.h  |  13 ++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  |  15 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  10 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  47 +++---
 8 files changed, 242 insertions(+), 21 deletions(-)
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
index 491192a4fc74..9eefa55fecef 100644
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
@@ -213,6 +223,13 @@ struct hbg_stats {
 
 	u64 tx_timeout_cnt;
 	u64 tx_dma_err_cnt;
+
+	u64 reset_fail_cnt;
+};
+
+/* saved for restore after rest */
+struct hbg_user_def {
+	struct ethtool_pauseparam pause_param;
 };
 
 struct hbg_mac_table_entry {
@@ -239,6 +256,11 @@ struct hbg_priv {
 	struct hbg_stats stats;
 	struct delayed_work service_task;
 	struct hbg_mac_filter filter;
+
+	struct hbg_user_def user_def;
+	enum hbg_reset_type reset_type;
 };
 
+void hbg_reset_task_schedule(struct hbg_priv *priv);
+
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index 85d5cb3cd603..72a8139c49a1 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -97,6 +97,8 @@ static int hbg_dbg_irq_info(struct seq_file *s, void *unused)
 	return 0;
 }
 
+static const char * const reset_type_str[] = {"None", "FLR", "Function"};
+
 static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
 {
 	struct net_device *netdev = dev_get_drvdata(s->private);
@@ -105,7 +107,19 @@ static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
 	seq_printf(s, "event handling state: %s\n",
 		   hbg_get_bool_str(test_bit(HBG_NIC_STATE_EVENT_HANDLING,
 					     &priv->state)));
+	seq_printf(s, "need reset state: %s\n",
+		   hbg_get_bool_str(test_bit(HBG_NIC_STATE_NEED_RESET,
+					     &priv->state)));
+	seq_printf(s, "resetting state: %s\n",
+		   hbg_get_bool_str(test_bit(HBG_NIC_STATE_RESETTING,
+					     &priv->state)));
+	seq_printf(s, "reset fail state: %s\n",
+		   hbg_get_bool_str(test_bit(HBG_NIC_STATE_RESET_FAIL,
+					     &priv->state)));
+	seq_printf(s, "last reset type: %s\n",
+		   reset_type_str[priv->reset_type]);
 
+	seq_printf(s, "reset fail cnt: %llu\n", priv->stats.reset_fail_cnt);
 	seq_printf(s, "tx timeout cnt: %llu\n", priv->stats.tx_timeout_cnt);
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
new file mode 100644
index 000000000000..25fa25234df6
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
@@ -0,0 +1,140 @@
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
+	priv->stats.reset_fail_cnt++;
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
+		priv->stats.reset_fail_cnt++;
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
index 2fef3d161c21..6c9a9298a2b2 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -4,6 +4,7 @@
 #include <linux/ethtool.h>
 #include <linux/phy.h>
 #include "hbg_common.h"
+#include "hbg_err.h"
 #include "hbg_ethtool.h"
 #include "hbg_hw.h"
 
@@ -360,6 +361,19 @@ static int hbg_ethtool_set_pauseparam(struct net_device *net_dev,
 	}
 
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
 
@@ -375,6 +389,7 @@ static const struct ethtool_ops hbg_ethtool_ops = {
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
index 6331cda91575..bd7e77e344d6 100644
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
@@ -201,15 +196,6 @@ static int hbg_net_set_mac_address(struct net_device *netdev, void *addr)
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
@@ -217,7 +203,7 @@ static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu)
 	if (netif_running(netdev))
 		return -EBUSY;
 
-	hbg_change_mtu(priv, new_mtu);
+	hbg_hw_set_mtu(priv, new_mtu);
 	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	dev_dbg(&priv->pdev->dev,
@@ -280,6 +266,9 @@ static void hbg_service_task(struct work_struct *work)
 	struct hbg_priv *priv = container_of(work, struct hbg_priv,
 					     service_task.work);
 
+	if (test_and_clear_bit(HBG_NIC_STATE_NEED_RESET, &priv->state))
+		hbg_reset(priv);
+
 	/* The type of statistics register is u32,
 	 * and the type of driver statistics is u64.
 	 * To prevent the statistics register from overflowing,
@@ -290,6 +279,18 @@ static void hbg_service_task(struct work_struct *work)
 			      msecs_to_jiffies(5 * 60 * MSEC_PER_SEC));
 }
 
+void hbg_reset_task_schedule(struct hbg_priv *priv)
+{
+	set_bit(HBG_NIC_STATE_NEED_RESET, &priv->state);
+
+	/* Generally, service_task is scheduled every 5 minutes.
+	 * Here, we want to schedule immediately,
+	 * so cancel the original task and reschedule it.
+	 */
+	cancel_delayed_work(&priv->service_task);
+	schedule_delayed_work(&priv->service_task, 0);
+}
+
 static void hbg_delaywork_init(struct hbg_priv *priv)
 {
 	INIT_DELAYED_WORK(&priv->service_task, hbg_service_task);
@@ -320,6 +321,14 @@ static int hbg_mac_filter_init(struct hbg_priv *priv)
 	return 0;
 }
 
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
@@ -348,6 +357,7 @@ static int hbg_init(struct hbg_priv *priv)
 	if (ret)
 		return ret;
 
+	hbg_init_user_def(priv);
 	hbg_delaywork_init(priv);
 	return devm_add_action_or_reset(&priv->pdev->dev, hbg_delaywork_uninit,
 					&priv->service_task);
@@ -414,7 +424,7 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->netdev_ops = &hbg_netdev_ops;
 	netdev->watchdog_timeo = 5 * HZ;
 
-	hbg_change_mtu(priv, ETH_DATA_LEN);
+	hbg_hw_set_mtu(priv, ETH_DATA_LEN);
 	hbg_net_set_mac_address(priv->netdev, &priv->dev_specs.mac_addr);
 	hbg_ethtool_set_ops(netdev);
 
@@ -443,6 +453,7 @@ static int __init hbg_module_init(void)
 	int ret;
 
 	hbg_debugfs_register();
+	hbg_set_pci_err_handler(&hbg_driver);
 	ret = pci_register_driver(&hbg_driver);
 	if (ret)
 		hbg_debugfs_unregister();
-- 
2.33.0


