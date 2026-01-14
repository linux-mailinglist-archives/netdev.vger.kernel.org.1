Return-Path: <netdev+bounces-249753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF7D1D2A8
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 090013016CDF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00637F8AE;
	Wed, 14 Jan 2026 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GQapL+7R"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5637F73A;
	Wed, 14 Jan 2026 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379936; cv=none; b=FPkxzUX4XrhugwRC0NpD5fVNuBI4KCtA0pCjcrIYz180BH7he5uwltG4Osc2jsWXimlIf13A6TaLkp1OUuqMOYwWl/SRH6y1yyZIZr9SLTC2sJW9pE3pT/tmrtwwHcSk7OA267U+ExknigSgSQ5L0PbL3SJ5Lh25ULXPXuLfUQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379936; c=relaxed/simple;
	bh=1aE9GAo1cPov/b3GJPMhF7HPXQls7HqMrcBQd8wELPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dO2uQQcIUYsK4/UDYz2Plf7ArtAXoVGwL11za6OZyRzV/PF8mbIrYtdlOLzi/IFvdpZ5KHFt2fbF7QgsQTDoCYG9iDw+YVaRN9gwyBfg1OXVERTy08n/R6cOMTgqjFJb7Xut1vQKFrMMIMBgj5iyXK4mUTiNoWtzEVv/mVctIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GQapL+7R; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FI3qNgzKm1o6JrsRgZyEVUJwCzAbKB+8VPU4BhgawdI=;
	b=GQapL+7RsrmzZkQY2EH+x0NmCFfWUBov++IgcN/oxbPwCHI1Q0yP8J0hZH5VIQGkM6PvBlX4e
	TLIYJnwFzRX0GlNw2DfCdb1tH22IXtGLcRYtM61whuB2PnDZddwK4fnDnFyAObSDnEXUfNW1gaA
	SPJNSyILhQBFcsLQfCPvzEI=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4drfZM46rhzKm5f;
	Wed, 14 Jan 2026 16:35:23 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id C792840536;
	Wed, 14 Jan 2026 16:38:43 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 14 Jan 2026 16:38:42 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net-next v11 4/9] hinic3: Add .ndo_set_features and .ndo_fix_features
Date: Wed, 14 Jan 2026 16:38:23 +0800
Message-ID: <682734a08fde421413048bf70057dafe3cbe8497.1768375903.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1768375903.git.zhuyikai1@h-partners.com>
References: <cover.1768375903.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Implement following callback function:
.ndo_set_features
.ndo_fix_features

The .ndo_set_features function includes five features: rx_csum,
tso, lro, rx_cvlan and vlan_filter.
Add these new features in netdev_feature_init.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  33 +++-
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  40 +++++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 161 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 130 ++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |   5 +
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   2 +
 6 files changed, 370 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 2bd306f09cd5..6071d2023a5d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -227,6 +227,8 @@ static void hinic3_assign_netdev_ops(struct net_device *netdev)
 static void netdev_feature_init(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	netdev_features_t hw_features = 0;
+	netdev_features_t vlan_fts = 0;
 	netdev_features_t cso_fts = 0;
 	netdev_features_t tso_fts = 0;
 	netdev_features_t dft_fts;
@@ -239,7 +241,29 @@ static void netdev_feature_init(struct net_device *netdev)
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
+	hw_features |= netdev->hw_features | netdev->features;
+	netdev->hw_features = hw_features;
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+
+	netdev->hw_enc_features |= dft_fts;
+	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_VXLAN_OFFLOAD))
+		netdev->hw_enc_features |= cso_fts | tso_fts | NETIF_F_TSO_ECN;
 }
 
 static int hinic3_set_default_hw_feature(struct net_device *netdev)
@@ -254,6 +278,13 @@ static int hinic3_set_default_hw_feature(struct net_device *netdev)
 		return err;
 	}
 
+	err = hinic3_set_hw_features(netdev);
+	if (err) {
+		hinic3_update_nic_feature(nic_dev, 0);
+		hinic3_set_nic_feature_to_hw(nic_dev);
+		return err;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index 3a6d3ee534d0..69405715e734 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -56,6 +56,22 @@ struct l2nic_cmd_update_mac {
 	u8                   new_mac[ETH_ALEN];
 };
 
+struct l2nic_cmd_vlan_offload {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u8                   vlan_offload;
+	u8                   rsvd1[5];
+};
+
+/* set vlan filter */
+struct l2nic_cmd_set_vlan_filter {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u8                   rsvd[2];
+	/* bit0:vlan filter en; bit1:broadcast_filter_en */
+	u32                  vlan_filter_ctrl;
+};
+
 struct l2nic_cmd_set_ci_attr {
 	struct mgmt_msg_head msg_head;
 	u16                  func_idx;
@@ -102,6 +118,26 @@ struct l2nic_cmd_set_dcb_state {
 	u8                   rsvd[7];
 };
 
+struct l2nic_cmd_lro_config {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u8                   opcode;
+	u8                   rsvd1;
+	u8                   lro_ipv4_en;
+	u8                   lro_ipv6_en;
+	/* unit is 1K */
+	u8                   lro_max_pkt_len;
+	u8                   resv2[13];
+};
+
+struct l2nic_cmd_lro_timer {
+	struct mgmt_msg_head msg_head;
+	/* 1: set timer value, 0: get timer value */
+	u8                   opcode;
+	u8                   rsvd[3];
+	u32                  timer;
+};
+
 #define L2NIC_RSS_TYPE_VALID_MASK         BIT(23)
 #define L2NIC_RSS_TYPE_TCP_IPV6_EXT_MASK  BIT(24)
 #define L2NIC_RSS_TYPE_IPV6_EXT_MASK      BIT(25)
@@ -162,11 +198,15 @@ enum l2nic_cmd {
 	L2NIC_CMD_SET_VPORT_ENABLE    = 6,
 	L2NIC_CMD_SET_SQ_CI_ATTR      = 8,
 	L2NIC_CMD_CLEAR_QP_RESOURCE   = 11,
+	L2NIC_CMD_CFG_RX_LRO          = 13,
+	L2NIC_CMD_CFG_LRO_TIMER       = 14,
 	L2NIC_CMD_FEATURE_NEGO        = 15,
 	L2NIC_CMD_GET_MAC             = 20,
 	L2NIC_CMD_SET_MAC             = 21,
 	L2NIC_CMD_DEL_MAC             = 22,
 	L2NIC_CMD_UPDATE_MAC          = 23,
+	L2NIC_CMD_SET_VLAN_FILTER_EN  = 26,
+	L2NIC_CMD_SET_RX_VLAN_OFFLOAD = 27,
 	L2NIC_CMD_CFG_RSS             = 60,
 	L2NIC_CMD_CFG_RSS_HASH_KEY    = 63,
 	L2NIC_CMD_CFG_RSS_HASH_ENGINE = 64,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 39091f472372..2e1ca9571e7c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -12,6 +12,9 @@
 #include "hinic3_rx.h"
 #include "hinic3_tx.h"
 
+#define HINIC3_LRO_DEFAULT_COAL_PKT_SIZE  32
+#define HINIC3_LRO_DEFAULT_TIME_LIMIT     16
+
 /* try to modify the number of irq to the target number,
  * and return the actual number of irq.
  */
@@ -476,6 +479,162 @@ static int hinic3_close(struct net_device *netdev)
 	return 0;
 }
 
+#define SET_FEATURES_OP_STR(op)  ((op) ? "Enable" : "Disable")
+
+static int hinic3_set_feature_rx_csum(struct net_device *netdev,
+				      netdev_features_t wanted_features,
+				      netdev_features_t features,
+				      netdev_features_t *failed_features)
+{
+	netdev_features_t changed = wanted_features ^ features;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+
+	if (changed & NETIF_F_RXCSUM)
+		dev_dbg(hwdev->dev, "%s rx csum success\n",
+			SET_FEATURES_OP_STR(wanted_features & NETIF_F_RXCSUM));
+
+	return 0;
+}
+
+static int hinic3_set_feature_tso(struct net_device *netdev,
+				  netdev_features_t wanted_features,
+				  netdev_features_t features,
+				  netdev_features_t *failed_features)
+{
+	netdev_features_t changed = wanted_features ^ features;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+
+	if (changed & NETIF_F_TSO)
+		dev_dbg(hwdev->dev, "%s tso success\n",
+			SET_FEATURES_OP_STR(wanted_features & NETIF_F_TSO));
+
+	return 0;
+}
+
+static int hinic3_set_feature_lro(struct net_device *netdev,
+				  netdev_features_t wanted_features,
+				  netdev_features_t features,
+				  netdev_features_t *failed_features)
+{
+	netdev_features_t changed = wanted_features ^ features;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	bool en = !!(wanted_features & NETIF_F_LRO);
+	int err;
+
+	if (!(changed & NETIF_F_LRO))
+		return 0;
+
+	err = hinic3_set_rx_lro_state(hwdev, en,
+				      HINIC3_LRO_DEFAULT_TIME_LIMIT,
+				      HINIC3_LRO_DEFAULT_COAL_PKT_SIZE);
+	if (err) {
+		dev_err(hwdev->dev, "%s lro failed\n", SET_FEATURES_OP_STR(en));
+		*failed_features |= NETIF_F_LRO;
+	}
+
+	return err;
+}
+
+static int hinic3_set_feature_rx_cvlan(struct net_device *netdev,
+				       netdev_features_t wanted_features,
+				       netdev_features_t features,
+				       netdev_features_t *failed_features)
+{
+	bool en = !!(wanted_features & NETIF_F_HW_VLAN_CTAG_RX);
+	netdev_features_t changed = wanted_features ^ features;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	int err;
+
+	if (!(changed & NETIF_F_HW_VLAN_CTAG_RX))
+		return 0;
+
+	err = hinic3_set_rx_vlan_offload(hwdev, en);
+	if (err) {
+		dev_err(hwdev->dev, "%s rx vlan offload failed\n",
+			SET_FEATURES_OP_STR(en));
+		*failed_features |= NETIF_F_HW_VLAN_CTAG_RX;
+	}
+
+	return err;
+}
+
+static int hinic3_set_feature_vlan_filter(struct net_device *netdev,
+					  netdev_features_t wanted_features,
+					  netdev_features_t features,
+					  netdev_features_t *failed_features)
+{
+	bool en = !!(wanted_features & NETIF_F_HW_VLAN_CTAG_FILTER);
+	netdev_features_t changed = wanted_features ^ features;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	int err;
+
+	if (!(changed & NETIF_F_HW_VLAN_CTAG_FILTER))
+		return 0;
+
+	err = hinic3_set_vlan_filter(hwdev, en);
+	if (err) {
+		dev_err(hwdev->dev, "%s rx vlan filter failed\n",
+			SET_FEATURES_OP_STR(en));
+		*failed_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	}
+
+	return err;
+}
+
+static int hinic3_set_features(struct net_device *netdev,
+			       netdev_features_t curr,
+			       netdev_features_t wanted)
+{
+	netdev_features_t failed = 0;
+	int err;
+
+	err = hinic3_set_feature_rx_csum(netdev, wanted, curr, &failed) |
+	      hinic3_set_feature_tso(netdev, wanted, curr, &failed) |
+	      hinic3_set_feature_lro(netdev, wanted, curr, &failed) |
+	      hinic3_set_feature_rx_cvlan(netdev, wanted, curr, &failed) |
+	      hinic3_set_feature_vlan_filter(netdev, wanted, curr, &failed);
+	if (err) {
+		netdev->features = wanted ^ failed;
+		return err;
+	}
+
+	return 0;
+}
+
+static int hinic3_ndo_set_features(struct net_device *netdev,
+				   netdev_features_t features)
+{
+	return hinic3_set_features(netdev, netdev->features, features);
+}
+
+static netdev_features_t hinic3_fix_features(struct net_device *netdev,
+					     netdev_features_t features)
+{
+	netdev_features_t features_tmp = features;
+
+	/* If Rx checksum is disabled, then LRO should also be disabled */
+	if (!(features_tmp & NETIF_F_RXCSUM))
+		features_tmp &= ~NETIF_F_LRO;
+
+	return features_tmp;
+}
+
+int hinic3_set_hw_features(struct net_device *netdev)
+{
+	netdev_features_t wanted, curr;
+
+	wanted = netdev->features;
+	/* fake current features so all wanted are enabled */
+	curr = ~wanted;
+
+	return hinic3_set_features(netdev, curr, wanted);
+}
+
 static int hinic3_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	int err;
@@ -595,6 +754,8 @@ static void hinic3_get_stats64(struct net_device *netdev,
 static const struct net_device_ops hinic3_netdev_ops = {
 	.ndo_open             = hinic3_open,
 	.ndo_stop             = hinic3_close,
+	.ndo_set_features     = hinic3_ndo_set_features,
+	.ndo_fix_features     = hinic3_fix_features,
 	.ndo_change_mtu       = hinic3_change_mtu,
 	.ndo_set_mac_address  = hinic3_set_mac_addr,
 	.ndo_tx_timeout       = hinic3_tx_timeout,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 7fec13bbe60e..79494ac8f395 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -57,6 +57,136 @@ bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
 	return (nic_dev->nic_io->feature_cap & feature_bits) == feature_bits;
 }
 
+static int hinic3_set_rx_lro(struct hinic3_hwdev *hwdev, u8 ipv4_en, u8 ipv6_en,
+			     u8 lro_max_pkt_len)
+{
+	struct l2nic_cmd_lro_config lro_cfg = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	lro_cfg.func_id = hinic3_global_func_id(hwdev);
+	lro_cfg.opcode = MGMT_MSG_CMD_OP_SET;
+	lro_cfg.lro_ipv4_en = ipv4_en;
+	lro_cfg.lro_ipv6_en = ipv6_en;
+	lro_cfg.lro_max_pkt_len = lro_max_pkt_len;
+
+	mgmt_msg_params_init_default(&msg_params, &lro_cfg,
+				     sizeof(lro_cfg));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_CFG_RX_LRO,
+				       &msg_params);
+
+	if (err || lro_cfg.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set lro offload, err: %d, status: 0x%x\n",
+			err, lro_cfg.msg_head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_rx_lro_timer(struct hinic3_hwdev *hwdev, u32 timer_value)
+{
+	struct l2nic_cmd_lro_timer lro_timer = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	lro_timer.opcode = MGMT_MSG_CMD_OP_SET;
+	lro_timer.timer = timer_value;
+
+	mgmt_msg_params_init_default(&msg_params, &lro_timer,
+				     sizeof(lro_timer));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_CFG_LRO_TIMER,
+				       &msg_params);
+
+	if (err || lro_timer.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set lro timer, err: %d, status: 0x%x\n",
+			err, lro_timer.msg_head.status);
+
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, u8 lro_en,
+			    u32 lro_timer, u8 lro_max_pkt_len)
+{
+	u8 ipv4_en, ipv6_en;
+	int err;
+
+	ipv4_en = lro_en ? 1 : 0;
+	ipv6_en = lro_en ? 1 : 0;
+
+	dev_dbg(hwdev->dev, "Set LRO max coalesce packet size to %uK\n",
+		lro_max_pkt_len);
+
+	err = hinic3_set_rx_lro(hwdev, ipv4_en, ipv6_en, lro_max_pkt_len);
+	if (err)
+		return err;
+
+	/* we don't set LRO timer for VF */
+	if (HINIC3_IS_VF(hwdev))
+		return 0;
+
+	dev_dbg(hwdev->dev, "Set LRO timer to %u\n", lro_timer);
+
+	return hinic3_set_rx_lro_timer(hwdev, lro_timer);
+}
+
+int hinic3_set_rx_vlan_offload(struct hinic3_hwdev *hwdev, u8 en)
+{
+	struct l2nic_cmd_vlan_offload vlan_cfg = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	vlan_cfg.func_id = hinic3_global_func_id(hwdev);
+	vlan_cfg.vlan_offload = en;
+
+	mgmt_msg_params_init_default(&msg_params, &vlan_cfg,
+				     sizeof(vlan_cfg));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_SET_RX_VLAN_OFFLOAD,
+				       &msg_params);
+
+	if (err || vlan_cfg.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set rx vlan offload, err: %d, status: 0x%x\n",
+			err, vlan_cfg.msg_head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_set_vlan_filter(struct hinic3_hwdev *hwdev, u32 vlan_filter_ctrl)
+{
+	struct l2nic_cmd_set_vlan_filter vlan_filter = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	vlan_filter.func_id = hinic3_global_func_id(hwdev);
+	vlan_filter.vlan_filter_ctrl = vlan_filter_ctrl;
+
+	mgmt_msg_params_init_default(&msg_params, &vlan_filter,
+				     sizeof(vlan_filter));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_SET_VLAN_FILTER_EN,
+				       &msg_params);
+
+	if (err || vlan_filter.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set vlan filter, err: %d, status: 0x%x\n",
+			err, vlan_filter.msg_head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature_cap)
 {
 	nic_dev->nic_io->feature_cap = feature_cap;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index d4326937db48..a17cd56bce71 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -57,6 +57,11 @@ bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
 			 enum hinic3_nic_feature_cap feature_bits);
 void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature_cap);
 
+int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, u8 lro_en,
+			    u32 lro_timer, u8 lro_max_pkt_len);
+int hinic3_set_rx_vlan_offload(struct hinic3_hwdev *hwdev, u8 en);
+int hinic3_set_vlan_filter(struct hinic3_hwdev *hwdev, u32 vlan_filter_ctrl);
+
 int hinic3_init_function_table(struct hinic3_nic_dev *nic_dev);
 int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index b8c9c325a45a..a8e92e070d9e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -7,6 +7,7 @@
 #include <linux/netdevice.h>
 
 #include "hinic3_hw_cfg.h"
+#include "hinic3_hwdev.h"
 #include "hinic3_mgmt_interface.h"
 
 enum hinic3_flags {
@@ -98,6 +99,7 @@ struct hinic3_nic_dev {
 };
 
 void hinic3_set_netdev_ops(struct net_device *netdev);
+int hinic3_set_hw_features(struct net_device *netdev);
 int hinic3_qps_irq_init(struct net_device *netdev);
 void hinic3_qps_irq_uninit(struct net_device *netdev);
 
-- 
2.43.0


