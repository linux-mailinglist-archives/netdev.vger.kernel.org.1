Return-Path: <netdev+bounces-229501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B98BDCE09
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6F319C0416
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B1631618D;
	Wed, 15 Oct 2025 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SN4BlHFJ"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE031328A;
	Wed, 15 Oct 2025 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512564; cv=none; b=BwJfudnsuwKRt1K/yQviysNtViG6WedkuND0FJoil5H9AdsscjkWUGvM7U1mfxjguTO6k89yps7zeexfijEkCKxsCJyBdHoXEVKpRvnnIKx/UzIIbXs3/kUYV/0AlmA7OUHmk3GP5XP6eyNN6GsfIGeSXG+pJYDhW04U0+KHY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512564; c=relaxed/simple;
	bh=D3YdoAnSeALFbCYiK+blWK7S+sApcclWyExZMJH2Wrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZp7x/VF3u5e4Xs7o8cAKzFEPKnSg5WjmkeBtl+Li8xVDylTmDbOFfdyBXfgJuL81VMRm82K0ZCyzZeBijXypS8gSH6bpajUEjVINAOdNRCIh6464j+D5cwq1tRQFrLmWzvpmtWoWtxvcWQOhYYt4fcpHrItlcdTErcYw2HMLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SN4BlHFJ; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EAY6p+snXEjB+p2AP6MO4Nu4V6HaAuvFXZrZx8DYwo0=;
	b=SN4BlHFJWN8shdBDtq2yoSfclVj3dlojCQt7+Acc3Ab9+OUeHPWzG1SRAtaOFbm0dqkJqX0iZ
	xcZ1BuFlx3NP2fVnmJG99ggmGY7aC+GnU2VmPFIz65c4II/NZ/jd5cTXne2DUHADTSqZYN3BQhT
	dOUJxiCW9LI6P9YiM8qf1jU=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4cmj6M2txKz1K9D7;
	Wed, 15 Oct 2025 15:15:39 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id E6BE21A016C;
	Wed, 15 Oct 2025 15:15:58 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 15:15:57 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v01 5/9] hinic3: Add netdev register interfaces
Date: Wed, 15 Oct 2025 15:15:31 +0800
Message-ID: <85a6aab1f40d6078279c07e28e08b879bdee207c.1760502478.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1760502478.git.zhuyikai1@h-partners.com>
References: <cover.1760502478.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add netdev notifier to accept netdev event.
Refine port event type to change link status.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |   9 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 181 +++++++++++++++++-
 .../huawei/hinic3/hinic3_netdev_ops.c         |  12 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  18 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   1 +
 6 files changed, 220 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
index 3bed3215bbbc..84b56af74aec 100644
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
index ac79b8bf9b56..6898aa34b4e1 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -212,6 +212,8 @@ static void hinic3_auto_moderation_work(struct work_struct *work)
 	nic_dev = container_of(delay, struct hinic3_nic_dev, moderation_task);
 	period = (unsigned long)(jiffies - nic_dev->last_moder_jiffies);
 	netdev = nic_dev->netdev;
+	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags))
+		return;
 
 	queue_delayed_work(nic_dev->workq, &nic_dev->moderation_task,
 			   HINIC3_MODERATONE_DELAY);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 6b8cca66f0e9..b9b6cb825357 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -29,6 +29,66 @@
 #define HINIC3_DEFAULT_TXRX_MSIX_COALESC_TIMER_CFG  25
 #define HINIC3_DEFAULT_TXRX_MSIX_RESEND_TIMER_CFG   7
 
+#define HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT  1
+#define HINIC3_VLAN_CLEAR_OFFLOAD \
+	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
+	 NETIF_F_SCTP_CRC | NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
+
+static int hinic3_netdev_event(struct notifier_block *notifier,
+			       unsigned long event, void *ptr);
+
+/* used for netdev notifier register/unregister */
+static DEFINE_MUTEX(hinic3_netdev_notifiers_mutex);
+static int hinic3_netdev_notifiers_ref_cnt;
+static struct notifier_block hinic3_netdev_notifier = {
+	.notifier_call = hinic3_netdev_event,
+};
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
+	u16 vlan_depth;
+
+	if (!is_vlan_dev(ndev))
+		return NOTIFY_DONE;
+
+	dev_hold(ndev);
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
+	};
+
+	dev_put(ndev);
+
+	return NOTIFY_DONE;
+}
+
 static void init_intr_coal_param(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -161,6 +221,14 @@ static int hinic3_init_nic_dev(struct net_device *netdev,
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
@@ -238,6 +306,8 @@ static void hinic3_assign_netdev_ops(struct net_device *netdev)
 static void netdev_feature_init(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	netdev_features_t hw_features = 0;
+	netdev_features_t vlan_fts = 0;
 	netdev_features_t cso_fts = 0;
 	netdev_features_t tso_fts = 0;
 	netdev_features_t dft_fts;
@@ -250,7 +320,29 @@ static void netdev_feature_init(struct net_device *netdev)
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
@@ -275,6 +367,36 @@ static int hinic3_set_default_hw_feature(struct net_device *netdev)
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
@@ -297,6 +419,42 @@ static void hinic3_link_status_change(struct net_device *netdev,
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
@@ -310,8 +468,20 @@ static void hinic3_nic_event(struct auxiliary_device *adev,
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
@@ -359,7 +529,7 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 
 	err = hinic3_init_nic_io(nic_dev);
 	if (err)
-		goto err_free_netdev;
+		goto err_free_nic_dev;
 
 	err = hinic3_sw_init(netdev);
 	if (err)
@@ -372,6 +542,8 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 	if (err)
 		goto err_uninit_sw;
 
+	hinic3_register_notifier(netdev);
+
 	queue_delayed_work(nic_dev->workq, &nic_dev->periodic_work, HZ);
 	netif_carrier_off(netdev);
 
@@ -382,6 +554,7 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 	return 0;
 
 err_uninit_nic_feature:
+	hinic3_unregister_notifier();
 	hinic3_update_nic_feature(nic_dev, 0);
 	hinic3_set_nic_feature_to_hw(nic_dev);
 
@@ -390,7 +563,8 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 
 err_free_nic_io:
 	hinic3_free_nic_io(nic_dev);
-
+err_free_nic_dev:
+	hinic3_free_nic_dev(netdev);
 err_free_netdev:
 	free_netdev(netdev);
 
@@ -411,6 +585,7 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
 
 	netdev = nic_dev->netdev;
 	unregister_netdev(netdev);
+	hinic3_unregister_notifier();
 
 	cancel_delayed_work_sync(&nic_dev->periodic_work);
 	cancel_work_sync(&nic_dev->rx_mode_work);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index e749bc09c493..f2a6cdab3d37 100644
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
index 508e3f047d19..d3ea31faf333 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -17,6 +17,7 @@
 #define HINIC3_MODERATONE_DELAY  HZ
 
 enum hinic3_flags {
+	HINIC3_INTF_UP,
 	HINIC3_MAC_FILTER_CHANGED,
 	HINIC3_RSS_ENABLE,
 	HINIC3_UPDATE_MAC_FILTER,
-- 
2.43.0


