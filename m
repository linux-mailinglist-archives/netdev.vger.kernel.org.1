Return-Path: <netdev+bounces-232775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D99C08C0D
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 08:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14F923504FD
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 06:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68612DEA7D;
	Sat, 25 Oct 2025 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ffavJ6Nu"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4B6DDA9;
	Sat, 25 Oct 2025 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761373151; cv=none; b=JehbSaQ6RXv1BEPT4m+W7qnmyKEwz50w3pBp6YgEX4nWpodH7agBWJnYhITCv/nMenbN+TSqBusHskRPXnP2OzZkUGK3RbQpOcRwhP21e3CLgdnxKHRb9BojKB6e19jNt+W2zPVOHirJI/NkEC9VgwNxCjqEN04mX8W9wZfE9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761373151; c=relaxed/simple;
	bh=s0JB4Er/9OWU0poO+dBQ5448vIExojbrVjP+me6tqv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehWerjxcxteWJNbxze1ElRSgis/TExbgbjiH5cEozxkzEgJ5dSV+I9pxPyjdisl6TIM6fykYAXcFinKVRYlqYRivbIR4K1AqIwW0X4g/DIrf0YC+fpb2aiCVtiXh98kKeLdL3XwEzwsqTWYS8gZ51zJgjj6AO/HyUjv5gf4xcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ffavJ6Nu; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QRN3qv61eGwFKyrvzpriS162yyhwq5apNLjydtwF/Jc=;
	b=ffavJ6NuuRkAjwVMrzBHJ5HmI2Wyge5iytztWBm2Cu7PAi9lhaM6Y64noII1tivBzjIwUI5Kp
	VukmbTKz/Z4cvJ8GbzYeM8SSDw/FLu4WCzmlXFdy/ICuvNuyTxLAD0WNwPxf3mMjBWBY/BNN2Md
	MWWg4/fFCVKyIOJsKp4w6S0=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4ctqMr5QykzLlVc;
	Sat, 25 Oct 2025 14:18:32 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 16A141A0188;
	Sat, 25 Oct 2025 14:18:59 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Oct 2025 14:18:57 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <Markus.Elfring@web.de>, <pavan.chebbi@broadcom.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
	<luoyang82@h-partners.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>
Subject: [PATCH net-next v03 5/5] hinic3: Add netdev register interfaces
Date: Sat, 25 Oct 2025 14:18:36 +0800
Message-ID: <ac8e9b39a9d9515b68036bfcf985a4a21c5e5493.1761362580.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1761362580.git.zhuyikai1@h-partners.com>
References: <cover.1761362580.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add netdev notifier to accept netdev event.
Refine port event type to change link status.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |   9 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 180 +++++++++++++++++-
 .../huawei/hinic3/hinic3_netdev_ops.c         |  12 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  18 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   2 +
 6 files changed, 220 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
index 58bc561f95b3..9686c2600b46 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
@@ -17,6 +17,15 @@ enum hinic3_event_service_type {
 	HINIC3_EVENT_SRV_NIC  = 1
 };
 
+enum hinic3_comm_event_type {
+	HINIC3_COMM_EVENT_PCIE_LINK_DOWN = 0,
+	HINIC3_COMM_EVENT_HEART_LOST = 1,
+	HINIC3_COMM_EVENT_FAULT = 2,
+	HINIC3_COMM_EVENT_SRIOV_STATE_CHANGE = 3,
+	HINIC3_COMM_EVENT_CARD_REMOVE = 4,
+	HINIC3_COMM_EVENT_MGMT_WATCHDOG = 5,
+};
+
 enum hinic3_fault_err_level {
 	HINIC3_FAULT_LEVEL_SERIOUS_FLR = 3,
 };
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index cb9412986c26..d793dff88109 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -215,6 +215,8 @@ static void hinic3_auto_moderation_work(struct work_struct *work)
 	nic_dev = container_of(delay, struct hinic3_nic_dev, moderation_task);
 	period = (unsigned long)(jiffies - nic_dev->last_moder_jiffies);
 	netdev = nic_dev->netdev;
+	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags))
+		return;
 
 	queue_delayed_work(nic_dev->workq, &nic_dev->moderation_task,
 			   HINIC3_MODERATONE_DELAY);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 294ed9bc17b0..733d2780e56e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -29,6 +29,65 @@
 #define HINIC3_DEFAULT_TXRX_MSIX_COALESC_TIMER_CFG  25
 #define HINIC3_DEFAULT_TXRX_MSIX_RESEND_TIMER_CFG   7
 
+#define HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT  1
+#define HINIC3_VLAN_CLEAR_OFFLOAD \
+	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
+	 NETIF_F_SCTP_CRC | NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
+
+/* used for netdev notifier register/unregister */
+static DEFINE_MUTEX(hinic3_netdev_notifiers_mutex);
+static int hinic3_netdev_notifiers_ref_cnt;
+
+static u16 hinic3_get_vlan_depth(struct net_device *netdev)
+{
+	u16 vlan_depth = 0;
+
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+	while (is_vlan_dev(netdev)) {
+		netdev = vlan_dev_priv(netdev)->real_dev;
+		vlan_depth++;
+	}
+#endif
+	return vlan_depth;
+}
+
+static int hinic3_netdev_event(struct notifier_block *notifier,
+			       unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct hinic3_nic_dev *nic_dev = netdev_priv(ndev);
+	u16 vlan_depth;
+
+	if (!is_vlan_dev(ndev))
+		return NOTIFY_DONE;
+
+	netdev_hold(ndev, &nic_dev->tracker, GFP_ATOMIC);
+
+	switch (event) {
+	case NETDEV_REGISTER:
+		vlan_depth = hinic3_get_vlan_depth(ndev);
+		if (vlan_depth == HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT) {
+			ndev->vlan_features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
+		} else if (vlan_depth > HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT) {
+			ndev->hw_features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
+			ndev->features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
+		}
+
+		break;
+
+	default:
+		break;
+	}
+
+	netdev_put(ndev, &nic_dev->tracker);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block hinic3_netdev_notifier = {
+	.notifier_call = hinic3_netdev_event,
+};
+
 static void init_intr_coal_param(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -161,6 +220,14 @@ static int hinic3_init_nic_dev(struct net_device *netdev,
 	return 0;
 }
 
+static void hinic3_free_nic_dev(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	destroy_workqueue(nic_dev->workq);
+	kfree(nic_dev->vlan_bitmap);
+}
+
 static int hinic3_sw_init(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -238,6 +305,8 @@ static void hinic3_assign_netdev_ops(struct net_device *netdev)
 static void netdev_feature_init(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	netdev_features_t hw_features = 0;
+	netdev_features_t vlan_fts = 0;
 	netdev_features_t cso_fts = 0;
 	netdev_features_t tso_fts = 0;
 	netdev_features_t dft_fts;
@@ -250,7 +319,29 @@ static void netdev_feature_init(struct net_device *netdev)
 	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_TSO))
 		tso_fts |= NETIF_F_TSO | NETIF_F_TSO6;
 
-	netdev->features |= dft_fts | cso_fts | tso_fts;
+	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_RX_VLAN_STRIP |
+				HINIC3_NIC_F_TX_VLAN_INSERT))
+		vlan_fts |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
+
+	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_RX_VLAN_FILTER))
+		vlan_fts |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_VXLAN_OFFLOAD))
+		tso_fts |= NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL_CSUM;
+
+	/* LRO is disabled by default, only set hw features */
+	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_LRO))
+		hw_features |= NETIF_F_LRO;
+
+	netdev->features |= dft_fts | cso_fts | tso_fts | vlan_fts;
+	netdev->vlan_features |= dft_fts | cso_fts | tso_fts;
+		hw_features |= netdev->hw_features | netdev->features;
+	netdev->hw_features = hw_features;
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+
+	netdev->hw_enc_features |= dft_fts;
+	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_VXLAN_OFFLOAD))
+		netdev->hw_enc_features |= cso_fts | tso_fts | NETIF_F_TSO_ECN;
 }
 
 static int hinic3_set_default_hw_feature(struct net_device *netdev)
@@ -275,6 +366,36 @@ static int hinic3_set_default_hw_feature(struct net_device *netdev)
 	return 0;
 }
 
+static void hinic3_register_notifier(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	mutex_lock(&hinic3_netdev_notifiers_mutex);
+	hinic3_netdev_notifiers_ref_cnt++;
+	if (hinic3_netdev_notifiers_ref_cnt == 1) {
+		err = register_netdevice_notifier(&hinic3_netdev_notifier);
+		if (err) {
+			dev_dbg(nic_dev->hwdev->dev,
+				"Register netdevice notifier failed, err: %d\n",
+				err);
+			hinic3_netdev_notifiers_ref_cnt--;
+		}
+	}
+	mutex_unlock(&hinic3_netdev_notifiers_mutex);
+}
+
+static void hinic3_unregister_notifier(void)
+{
+	mutex_lock(&hinic3_netdev_notifiers_mutex);
+	if (hinic3_netdev_notifiers_ref_cnt == 1)
+		unregister_netdevice_notifier(&hinic3_netdev_notifier);
+
+	if (hinic3_netdev_notifiers_ref_cnt)
+		hinic3_netdev_notifiers_ref_cnt--;
+	mutex_unlock(&hinic3_netdev_notifiers_mutex);
+}
+
 static void hinic3_link_status_change(struct net_device *netdev,
 				      bool link_status_up)
 {
@@ -297,6 +418,42 @@ static void hinic3_link_status_change(struct net_device *netdev,
 	}
 }
 
+static void hinic3_port_module_event_handler(struct net_device *netdev,
+					     struct hinic3_event_info *event)
+{
+	const char *g_hinic3_module_link_err[LINK_ERR_NUM] = { "Unrecognized module" };
+	struct hinic3_port_module_event *module_event;
+	enum port_module_event_type type;
+	enum link_err_type err_type;
+
+	module_event = (struct hinic3_port_module_event *)event->event_data;
+	type = module_event->type;
+	err_type = module_event->err_type;
+
+	switch (type) {
+	case HINIC3_PORT_MODULE_CABLE_PLUGGED:
+	case HINIC3_PORT_MODULE_CABLE_UNPLUGGED:
+		netdev_info(netdev, "Port module event: Cable %s\n",
+			    type == HINIC3_PORT_MODULE_CABLE_PLUGGED ?
+			    "plugged" : "unplugged");
+		break;
+	case HINIC3_PORT_MODULE_LINK_ERR:
+		if (err_type >= LINK_ERR_NUM) {
+			netdev_info(netdev, "Link failed, Unknown error type: 0x%x\n",
+				    err_type);
+		} else {
+			netdev_info(netdev,
+				    "Link failed, error type: 0x%x: %s\n",
+				    err_type,
+				    g_hinic3_module_link_err[err_type]);
+		}
+		break;
+	default:
+		netdev_err(netdev, "Unknown port module type %d\n", type);
+		break;
+	}
+}
+
 static void hinic3_nic_event(struct auxiliary_device *adev,
 			     struct hinic3_event_info *event)
 {
@@ -310,8 +467,20 @@ static void hinic3_nic_event(struct auxiliary_device *adev,
 				   HINIC3_NIC_EVENT_LINK_UP):
 		hinic3_link_status_change(netdev, true);
 		break;
+	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_NIC,
+				   HINIC3_NIC_EVENT_PORT_MODULE_EVENT):
+		hinic3_port_module_event_handler(netdev, event);
+		break;
 	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_NIC,
 				   HINIC3_NIC_EVENT_LINK_DOWN):
+	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_COMM,
+				   HINIC3_COMM_EVENT_FAULT):
+	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_COMM,
+				   HINIC3_COMM_EVENT_PCIE_LINK_DOWN):
+	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_COMM,
+				   HINIC3_COMM_EVENT_HEART_LOST):
+	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_COMM,
+				   HINIC3_COMM_EVENT_MGMT_WATCHDOG):
 		hinic3_link_status_change(netdev, false);
 		break;
 	default:
@@ -359,7 +528,7 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 
 	err = hinic3_init_nic_io(nic_dev);
 	if (err)
-		goto err_free_netdev;
+		goto err_free_nic_dev;
 
 	err = hinic3_sw_init(netdev);
 	if (err)
@@ -372,6 +541,8 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 	if (err)
 		goto err_uninit_sw;
 
+	hinic3_register_notifier(netdev);
+
 	queue_delayed_work(nic_dev->workq, &nic_dev->periodic_work, HZ);
 	netif_carrier_off(netdev);
 
@@ -382,6 +553,7 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 	return 0;
 
 err_uninit_nic_feature:
+	hinic3_unregister_notifier();
 	hinic3_update_nic_feature(nic_dev, 0);
 	hinic3_set_nic_feature_to_hw(nic_dev);
 
@@ -390,7 +562,8 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 
 err_free_nic_io:
 	hinic3_free_nic_io(nic_dev);
-
+err_free_nic_dev:
+	hinic3_free_nic_dev(netdev);
 err_free_netdev:
 	free_netdev(netdev);
 
@@ -411,6 +584,7 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
 
 	netdev = nic_dev->netdev;
 	unregister_netdev(netdev);
+	hinic3_unregister_notifier();
 
 	disable_delayed_work_sync(&nic_dev->periodic_work);
 	cancel_work_sync(&nic_dev->rx_mode_work);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 99edea85658c..b3a47855965d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -435,6 +435,11 @@ static int hinic3_open(struct net_device *netdev)
 	struct hinic3_dyna_qp_params qp_params;
 	int err;
 
+	if (test_bit(HINIC3_INTF_UP, &nic_dev->flags)) {
+		netdev_dbg(netdev, "Netdev already open, do nothing\n");
+		return 0;
+	}
+
 	err = hinic3_init_nicio_res(nic_dev);
 	if (err) {
 		netdev_err(netdev, "Failed to init nicio resources\n");
@@ -462,6 +467,8 @@ static int hinic3_open(struct net_device *netdev)
 	if (err)
 		goto err_close_channel;
 
+	set_bit(HINIC3_INTF_UP, &nic_dev->flags);
+
 	return 0;
 
 err_close_channel:
@@ -482,6 +489,11 @@ static int hinic3_close(struct net_device *netdev)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	struct hinic3_dyna_qp_params qp_params;
 
+	if (!test_and_clear_bit(HINIC3_INTF_UP, &nic_dev->flags)) {
+		netdev_dbg(netdev, "Netdev already close, do nothing\n");
+		return 0;
+	}
+
 	hinic3_vport_down(netdev);
 	hinic3_close_channel(netdev);
 	hinic3_uninit_qps(nic_dev, &qp_params);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index 2c129de241eb..d7a299fb2d51 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -22,6 +22,7 @@ struct hinic3_nic_dev;
 enum hinic3_nic_event_type {
 	HINIC3_NIC_EVENT_LINK_DOWN = 0,
 	HINIC3_NIC_EVENT_LINK_UP   = 1,
+	HINIC3_NIC_EVENT_PORT_MODULE_EVENT = 2,
 };
 
 struct hinic3_sq_attr {
@@ -51,6 +52,23 @@ struct mag_cmd_set_port_enable {
 	u8                   rsvd1[3];
 };
 
+enum link_err_type {
+	LINK_ERR_MODULE_UNRECOGENIZED,
+	LINK_ERR_NUM,
+};
+
+enum port_module_event_type {
+	HINIC3_PORT_MODULE_CABLE_PLUGGED,
+	HINIC3_PORT_MODULE_CABLE_UNPLUGGED,
+	HINIC3_PORT_MODULE_LINK_ERR,
+	HINIC3_PORT_MODULE_MAX_EVENT,
+};
+
+struct hinic3_port_module_event {
+	enum port_module_event_type type;
+	enum link_err_type          err_type;
+};
+
 int hinic3_get_nic_feature_from_hw(struct hinic3_nic_dev *nic_dev);
 int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev);
 bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 985cbd91b7c8..1e8d41fc112c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -17,6 +17,7 @@
 #define HINIC3_MODERATONE_DELAY  HZ
 
 enum hinic3_flags {
+	HINIC3_INTF_UP,
 	HINIC3_MAC_FILTER_CHANGED,
 	HINIC3_RSS_ENABLE,
 	HINIC3_UPDATE_MAC_FILTER,
@@ -119,6 +120,7 @@ struct hinic3_intr_coal_info {
 struct hinic3_nic_dev {
 	struct pci_dev                  *pdev;
 	struct net_device               *netdev;
+	netdevice_tracker               tracker;
 	struct hinic3_hwdev             *hwdev;
 	struct hinic3_nic_io            *nic_io;
 
-- 
2.43.0


