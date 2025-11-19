Return-Path: <netdev+bounces-239968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C90C6E9B1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 445593A1083
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE8D35F8D4;
	Wed, 19 Nov 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gfTOKdAF"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602335F8C1;
	Wed, 19 Nov 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556264; cv=none; b=r55K0F9wgmqfSpKuLdWEA0LKScIi8U8X1GgILzc0fDewgw9fK6+16JonsyASkyVmRSetGWoI6JyS8z5beptXKZ1mPAQoPefLgkn74akQe9DhRnn/HDIrjLZbbHAzr37J48eY1sxjQhDCCGrwmDGvnGrVIU8A5UPHVNo1ZcG/vcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556264; c=relaxed/simple;
	bh=h4GHaccWqxCegFHLSWVNzQ3SeCZPuJrjnZn5eftcTXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ei/K8y74xO+xpiPmkmTGNUbQvAjlgaqwdmdHZY3vQx72F0+QiN5oCr7Ibis+bwlBk9yml+B2wRVaCwmpk1qJrjcgeKkc9+jHwaaqiKqbTPoj0YxOIspg9uc03t1uxMF/ToComR9PyaMlCFDp2zDgFE5ZHS+F1ZKBqgaO5tgteTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gfTOKdAF; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QLgAYi+bkoyYJz97IbUgd1HG2TEXgw9fBz1b1oCAi28=;
	b=gfTOKdAFrkewhPD4IzGH2GgXD5gq2GftoGAXm9dfHCHv4DRrSuQJnigtal1ZqOdhsMz7CMLdw
	lKOGNNryhYjQy1QFnTekkbmGtpzonCJzQiiDS2By9p/FKZFmdsrGktSgrxbxUeUf9g506q0qGHV
	rbiDWNwECTanFlwcQIvIpqE=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dBLjB74T5zpSwn;
	Wed, 19 Nov 2025 20:42:22 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A56A180495;
	Wed, 19 Nov 2025 20:44:18 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Nov 2025 20:44:16 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
	<luoyang82@h-partners.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>
Subject: [PATCH net-next v07 9/9] hinic3: Add HW event handler
Date: Wed, 19 Nov 2025 20:43:42 +0800
Message-ID: <960cf26830046e9b25fd4bc28636880efe89b1a7.1763555878.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1763555878.git.zhuyikai1@h-partners.com>
References: <cover.1763555878.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add HINIC3_INIT_UP flags to trace netdev open status.
Add port module event handler.
Add link status event type(FAULT, PCIE link down, heart lost, mgmt
watchdog).

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  9 ++++
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  3 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 50 +++++++++++++++++++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 12 +++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 18 +++++++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  1 +
 6 files changed, 92 insertions(+), 1 deletion(-)

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
index 604e09812977..8a47320ffd3f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -19,7 +19,8 @@ static void hinic3_net_dim(struct hinic3_nic_dev *nic_dev,
 	struct hinic3_rxq *rxq = irq_cfg->rxq;
 	struct dim_sample sample = {};
 
-	if (!nic_dev->adaptive_rx_coal)
+	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags) ||
+	    !nic_dev->adaptive_rx_coal)
 		return;
 
 	dim_update_sample(irq_cfg->total_events, rxq->rxq_stats.packets,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 463609585f46..c556c853859d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -416,6 +416,44 @@ static void hinic3_link_status_change(struct net_device *netdev,
 	}
 }
 
+static void hinic3_port_module_event_handler(struct net_device *netdev,
+					     struct hinic3_event_info *event)
+{
+	const char *g_hinic3_module_link_err[LINK_ERR_NUM] = {
+		"Unrecognized module"
+	};
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
@@ -429,8 +467,20 @@ static void hinic3_nic_event(struct auxiliary_device *adev,
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
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 52bc30cc8a0b..439f1cecc2b4 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -430,6 +430,11 @@ static int hinic3_open(struct net_device *netdev)
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
@@ -457,6 +462,8 @@ static int hinic3_open(struct net_device *netdev)
 	if (err)
 		goto err_close_channel;
 
+	set_bit(HINIC3_INTF_UP, &nic_dev->flags);
+
 	return 0;
 
 err_close_channel:
@@ -477,6 +484,11 @@ static int hinic3_close(struct net_device *netdev)
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
index f83913e74cb5..c32eaa886e17 100644
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
index 899f60588d25..ff0ce5804d53 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -16,6 +16,7 @@
 	(VLAN_N_VID / HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev))
 
 enum hinic3_flags {
+	HINIC3_INTF_UP,
 	HINIC3_MAC_FILTER_CHANGED,
 	HINIC3_RSS_ENABLE,
 	HINIC3_UPDATE_MAC_FILTER,
-- 
2.43.0


