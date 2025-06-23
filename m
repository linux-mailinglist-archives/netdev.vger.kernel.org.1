Return-Path: <netdev+bounces-200126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B5BAE3431
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDF218903BE
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 04:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF71DFDAB;
	Mon, 23 Jun 2025 04:07:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1081DC07D;
	Mon, 23 Jun 2025 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651665; cv=none; b=hA6zk53l9b6Fc1zf9RbbiJeWL3p6quk/6fteb7ZuQR1t9bODJLqdzWKTMx4cRL1Id+6pn4Ppq6klXBRLg1mnvaTRffcLmJ4hR/hSq/tZfMNYwxEjD0Hzp2YqrU41IWTj+majEY+kPSU9dvHZGKsUymNbP24W+ctOtrF9nneT1VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651665; c=relaxed/simple;
	bh=iVkcZaM8d2A8qjubmI/tQfCMe+Hzvky4EzwRNrtdGqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g88DaKc+9siFe5kN17L3Atx9ktwK9v2vnJOvvJ00eXmON/KWDAhsQ0CwyjqIo+4YplgmIY6NEetwvH2J3Ps5usNQh++3QpBhowYBp0IwyE63mfQGS5//vsA0n6DKzXdvyQNtu0YFfbg9knnoNPgJJwvXnt9cGXFFQmYoHs0BhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bQZJ83HGvz2TSm6;
	Mon, 23 Jun 2025 12:06:00 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D9775140276;
	Mon, 23 Jun 2025 12:07:34 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 12:07:34 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v4 net-next 2/7] net: hns3: use hns3_get_ae_dev() helper to reduce the unnecessary middle layer conversion
Date: Mon, 23 Jun 2025 12:00:38 +0800
Message-ID: <20250623040043.857782-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250623040043.857782-1-shaojijie@huawei.com>
References: <20250623040043.857782-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)

There are too many indirection layers in the HNS3 driver code.
This issue was previously discussed with the maintainer,
who suggested adding a helper function to fix the issue.
In fact, the hns3_get_ae_dev() helper is already defined
and can fix this issue.

This patch uses hns3_get_ae_dev() helper to reduce the unnecessary
middle layer conversion. Apply it to the whole HNS3 driver.
The former discusstion can be checked from the link.

Link: https://patchwork.kernel.org/project/netdevbpf/patch/20230310081404.947-1-lanhao@huawei.com/
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
ChangeLog:
v1 -> v2:
  - Change commit message and title, suggested by Michal Swiatkowski.
  v1: https://lore.kernel.org/all/20250612021317.1487943-1-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  8 ++---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 12 +++----
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 36 +++++++++----------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 4e5d8bc39a1b..4f6ed7c7ee68 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -684,7 +684,7 @@ static int hns3_dbg_rx_queue_info(struct hnae3_handle *h,
 				  char *buf, int len)
 {
 	char data_str[ARRAY_SIZE(rx_queue_info_items)][HNS3_DBG_DATA_STR_LEN];
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
 	char *result[ARRAY_SIZE(rx_queue_info_items)];
 	struct hns3_nic_priv *priv = h->priv;
 	char content[HNS3_DBG_INFO_LEN];
@@ -789,7 +789,7 @@ static int hns3_dbg_tx_queue_info(struct hnae3_handle *h,
 				  char *buf, int len)
 {
 	char data_str[ARRAY_SIZE(tx_queue_info_items)][HNS3_DBG_DATA_STR_LEN];
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
 	char *result[ARRAY_SIZE(tx_queue_info_items)];
 	struct hns3_nic_priv *priv = h->priv;
 	char content[HNS3_DBG_INFO_LEN];
@@ -1034,7 +1034,7 @@ static int hns3_dbg_tx_bd_info(struct hns3_dbg_data *d, char *buf, int len)
 static void
 hns3_dbg_dev_caps(struct hnae3_handle *h, char *buf, int len, int *pos)
 {
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
 	unsigned long *caps = ae_dev->caps;
 	u32 i, state;
 
@@ -1364,7 +1364,7 @@ hns3_dbg_common_file_init(struct hnae3_handle *handle, u32 cmd)
 
 int hns3_dbg_init(struct hnae3_handle *handle)
 {
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 	const char *name = pci_name(handle->pdev);
 	int ret;
 	u32 i;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 5c8c62ea6ac0..6babc636145b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -547,9 +547,9 @@ void hns3_set_vector_coalesce_rx_ql(struct hns3_enet_tqp_vector *tqp_vector,
 static void hns3_vector_coalesce_init(struct hns3_enet_tqp_vector *tqp_vector,
 				      struct hns3_nic_priv *priv)
 {
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(priv->ae_handle->pdev);
 	struct hns3_enet_coalesce *tx_coal = &tqp_vector->tx_group.coal;
 	struct hns3_enet_coalesce *rx_coal = &tqp_vector->rx_group.coal;
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(priv->ae_handle);
 	struct hns3_enet_coalesce *ptx_coal = &priv->tx_coal;
 	struct hns3_enet_coalesce *prx_coal = &priv->rx_coal;
 
@@ -1304,7 +1304,7 @@ static int hns3_get_l4_protocol(struct sk_buff *skb, u8 *ol4_proto,
 static bool hns3_tunnel_csum_bug(struct sk_buff *skb)
 {
 	struct hns3_nic_priv *priv = netdev_priv(skb->dev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(priv->ae_handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(priv->ae_handle);
 	union l4_hdr_info l4;
 
 	/* device version above V3(include V3), the hardware can
@@ -1504,7 +1504,7 @@ static int hns3_handle_vtags(struct hns3_enet_ring *tx_ring,
 	 * VLAN enabled, only one VLAN header is allowed in skb, otherwise it
 	 * will cause RAS error.
 	 */
-	ae_dev = pci_get_drvdata(handle->pdev);
+	ae_dev = hns3_get_ae_dev(handle);
 	if (unlikely(skb_vlan_tagged_multi(skb) &&
 		     ae_dev->dev_version <= HNAE3_DEVICE_VERSION_V2 &&
 		     handle->port_base_vlan_state ==
@@ -4747,7 +4747,7 @@ static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
 
 static void hns3_nic_init_coal_cfg(struct hns3_nic_priv *priv)
 {
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(priv->ae_handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(priv->ae_handle);
 	struct hns3_enet_coalesce *tx_coal = &priv->tx_coal;
 	struct hns3_enet_coalesce *rx_coal = &priv->rx_coal;
 
@@ -5226,7 +5226,7 @@ static void hns3_info_show(struct hns3_nic_priv *priv)
 static void hns3_set_cq_period_mode(struct hns3_nic_priv *priv,
 				    enum dim_cq_period_mode mode, bool is_tx)
 {
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(priv->ae_handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(priv->ae_handle);
 	struct hnae3_handle *handle = priv->ae_handle;
 	int i;
 
@@ -5264,7 +5264,7 @@ void hns3_cq_period_mode_init(struct hns3_nic_priv *priv,
 
 static void hns3_state_init(struct hnae3_handle *handle)
 {
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 	struct net_device *netdev = handle->kinfo.netdev;
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 3513293abda9..b75766a94536 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -86,7 +86,7 @@ static int hns3_get_sset_count(struct net_device *netdev, int stringset);
 static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop, bool en)
 {
 	struct hnae3_handle *h = hns3_get_handle(ndev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
 	int ret;
 
 	if (!h->ae_algo->ops->set_loopback ||
@@ -171,7 +171,7 @@ static void hns3_lp_setup_skb(struct sk_buff *skb)
 	 * the purpose of mac or serdes selftest.
 	 */
 	handle = hns3_get_handle(ndev);
-	ae_dev = pci_get_drvdata(handle->pdev);
+	ae_dev = hns3_get_ae_dev(handle);
 	if (ae_dev->dev_version < HNAE3_DEVICE_VERSION_V2)
 		ethh->h_dest[5] += HNS3_NIC_LB_DST_MAC_ADDR;
 	eth_zero_addr(ethh->h_source);
@@ -692,7 +692,7 @@ static void hns3_get_pauseparam(struct net_device *netdev,
 				struct ethtool_pauseparam *param)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
 
 	if (!test_bit(HNAE3_DEV_SUPPORT_PAUSE_B, ae_dev->caps))
 		return;
@@ -706,7 +706,7 @@ static int hns3_set_pauseparam(struct net_device *netdev,
 			       struct ethtool_pauseparam *param)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
 
 	if (!test_bit(HNAE3_DEV_SUPPORT_PAUSE_B, ae_dev->caps))
 		return -EOPNOTSUPP;
@@ -751,7 +751,7 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 				   struct ethtool_link_ksettings *cmd)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
 	const struct hnae3_ae_ops *ops;
 	u8 module_type;
 	u8 media_type;
@@ -861,7 +861,7 @@ static int hns3_set_link_ksettings(struct net_device *netdev,
 				   const struct ethtool_link_ksettings *cmd)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 	int ret;
 
@@ -932,7 +932,7 @@ static u32 hns3_get_rss_key_size(struct net_device *netdev)
 static u32 hns3_get_rss_indir_size(struct net_device *netdev)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
 
 	return ae_dev->dev_specs.rss_ind_tbl_size;
 }
@@ -954,7 +954,7 @@ static int hns3_set_rss(struct net_device *netdev,
 			struct netlink_ext_ack *extack)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
 
 	if (!h->ae_algo->ops->set_rss)
 		return -EOPNOTSUPP;
@@ -1030,7 +1030,7 @@ static int hns3_set_reset(struct net_device *netdev, u32 *flags)
 {
 	enum hnae3_reset_type rst_type = HNAE3_NONE_RESET;
 	struct hnae3_handle *h = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
 	const struct hnae3_ae_ops *ops = h->ae_algo->ops;
 	const struct hns3_reset_type_map *rst_type_map;
 	enum ethtool_reset_flags rst_flags;
@@ -1195,7 +1195,7 @@ static int hns3_set_tx_push(struct net_device *netdev, u32 tx_push)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
 	u32 old_state = test_bit(HNS3_NIC_STATE_TX_PUSH_ENABLE, &priv->state);
 
 	if (!test_bit(HNAE3_DEV_SUPPORT_TX_PUSH_B, ae_dev->caps) && tx_push)
@@ -1390,7 +1390,7 @@ static int hns3_check_gl_coalesce_para(struct net_device *netdev,
 				       struct ethtool_coalesce *cmd)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 	u32 rx_gl, tx_gl;
 
 	if (cmd->rx_coalesce_usecs > ae_dev->dev_specs.max_int_gl) {
@@ -1462,7 +1462,7 @@ static int hns3_check_ql_coalesce_param(struct net_device *netdev,
 					struct ethtool_coalesce *cmd)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 
 	if ((cmd->tx_max_coalesced_frames || cmd->rx_max_coalesced_frames) &&
 	    !ae_dev->dev_specs.int_ql_max) {
@@ -1486,7 +1486,7 @@ hns3_check_cqe_coalesce_param(struct net_device *netdev,
 			      struct kernel_ethtool_coalesce *kernel_coal)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 
 	if ((kernel_coal->use_cqe_mode_tx || kernel_coal->use_cqe_mode_rx) &&
 	    !hnae3_ae_dev_cq_supported(ae_dev)) {
@@ -1662,7 +1662,7 @@ static void hns3_get_fec_stats(struct net_device *netdev,
 			       struct ethtool_fec_stats *fec_stats)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 
 	if (!hnae3_ae_dev_fec_stats_supported(ae_dev) || !ops->get_fec_stats)
@@ -1713,7 +1713,7 @@ static int hns3_get_fecparam(struct net_device *netdev,
 			     struct ethtool_fecparam *fec)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 	u8 fec_ability;
 	u8 fec_mode;
@@ -1738,7 +1738,7 @@ static int hns3_set_fecparam(struct net_device *netdev,
 			     struct ethtool_fecparam *fec)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 	u32 fec_mode;
 
@@ -1760,7 +1760,7 @@ static int hns3_get_module_info(struct net_device *netdev,
 #define HNS3_SFF_8636_V1_3 0x03
 
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 	struct hns3_sfp_type sfp_type;
 	int ret;
@@ -1810,7 +1810,7 @@ static int hns3_get_module_eeprom(struct net_device *netdev,
 				  struct ethtool_eeprom *ee, u8 *data)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 
 	if (ae_dev->dev_version < HNAE3_DEVICE_VERSION_V2 ||
-- 
2.33.0


