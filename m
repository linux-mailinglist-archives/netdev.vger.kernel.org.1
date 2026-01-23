Return-Path: <netdev+bounces-252584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG6KBJzOcmlgpgAAu9opvQ
	(envelope-from <netdev+bounces-252584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:27:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AD96F122
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F4783014C26
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456BF37AA92;
	Fri, 23 Jan 2026 01:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-25.us.a.mail.aliyun.com (out198-25.us.a.mail.aliyun.com [47.90.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B383378831;
	Fri, 23 Jan 2026 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131182; cv=none; b=UbFuridlV8k7jzyk/25gqs4AwFsDWEAA8r+szGP27PifdkIomp3FunvAI70tfy7YdM8RIJ5pybROJoQIDRktm6mqmWGoNiBiIS2flpecrFs2BjtStIPw41Ns/d+B82F+I9ZUTNEJfZ/9ceS4l3t52QwY8DqX72UOptnPhE7j/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131182; c=relaxed/simple;
	bh=fRCNnZNfPIDl1Jfq61e3PXaCFWy8rN4OEiTpGSCVvyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0xDlVIcLfQr+NXqaZCXWlpUaI03Bjw3hfm4g/qA/MGJIB5uF9+oWfBVTeJsmd4fQv0ABMuqYZB5Akij8otGVBbeJ2EkWiKg6JUd2VwRl2IFpZ5A2R/bPZlEsyZDcDmYq5DemCRXswXKPWO2MOSoxARzMxJszHQDTz3zavC83zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSYWO1_1769131136 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 09:18:57 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	hawk@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 net-next 15/15] net/nebula-matrix: add net dev start/stop operation
Date: Fri, 23 Jan 2026 09:17:52 +0800
Message-ID: <20260123011804.31263-16-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252584-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nebula-matrix.com:mid,nebula-matrix.com:email,illusion.wang:url,pci:email]
X-Rspamd-Queue-Id: 39AD96F122
X-Rspamd-Action: no action

start net dev:
 1 alloc netdev with multi-queue support, config private data
and associatess with the adapter.
 2 alloc tx/rx rings, set up network resource managements(vlan,rate
limiting)
 3 build the netdev structure, map queues to msix interrupts, init
hw stats.
 4 start net vsi and register net irq.
 5 register netdev

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  26 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 450 +++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 595 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.h  |   6 +
 .../nbl/nbl_include/nbl_def_common.h          |   1 +
 .../nbl/nbl_include/nbl_def_service.h         |   1 -
 .../nbl/nbl_include/nbl_include.h             |  43 ++
 7 files changed, 1121 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index e39319cee159..72227da4458b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -43,6 +43,18 @@
 #define NBL_NETDEV_TO_ADAPTER(netdev) \
 	(NBL_NETDEV_PRIV_TO_ADAPTER(  \
 		(struct nbl_netdev_priv *)netdev_priv(netdev)))
+
+#define NBL_NETDEV_TO_SERV_MGT(netdev) \
+	(NBL_ADAP_TO_SERV_MGT(NBL_NETDEV_PRIV_TO_ADAPTER(\
+		(struct nbl_netdev_priv *)netdev_priv(netdev))))
+
+#define NBL_NETDEV_TO_DEV_MGT(netdev) \
+	(NBL_ADAP_TO_DEV_MGT(NBL_NETDEV_TO_ADAPTER(netdev)))
+
+#define NBL_NETDEV_TO_COMMON(netdev) \
+	(NBL_ADAP_TO_COMMON(NBL_NETDEV_PRIV_TO_ADAPTER(\
+		(struct nbl_netdev_priv *)netdev_priv(netdev))))
+
 #define NBL_CAP_TEST_BIT(val, loc) (((val) >> (loc)) & 0x1)
 
 #define NBL_CAP_IS_CTRL(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_CTRL_BIT)
@@ -59,6 +71,19 @@ enum {
 	NBL_CAP_IS_OCP_BIT,
 };
 
+enum nbl_adapter_state {
+	NBL_DOWN,
+	NBL_RESETTING,
+	NBL_RESET_REQUESTED,
+	NBL_INITING,
+	NBL_INIT_FAILED,
+	NBL_RUNNING,
+	NBL_TESTING,
+	NBL_USER,
+	NBL_FATAL_ERR,
+	NBL_STATE_NBITS
+};
+
 struct nbl_interface {
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
 	struct nbl_resource_ops_tbl *resource_ops_tbl;
@@ -84,6 +109,7 @@ struct nbl_adapter {
 	struct nbl_common_info common;
 	struct nbl_product_base_ops *product_base_ops;
 	struct nbl_init_param init_param;
+	DECLARE_BITMAP(state, NBL_STATE_NBITS);
 };
 
 struct nbl_netdev_priv {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index cdc1baa5988d..6a615594013d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -13,6 +13,18 @@
 static struct nbl_dev_ops dev_ops;
 static int nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt);
 
+static void nbl_dev_set_netdev_priv(struct net_device *netdev,
+				    struct nbl_dev_vsi *vsi)
+{
+	struct nbl_netdev_priv *net_priv = netdev_priv(netdev);
+
+	net_priv->tx_queue_num = vsi->queue_num;
+	net_priv->rx_queue_num = vsi->queue_num;
+	net_priv->queue_size = vsi->queue_size;
+	net_priv->netdev = netdev;
+	net_priv->data_vsi = vsi->vsi_id;
+}
+
 /* ----------  Interrupt config  ---------- */
 static irqreturn_t nbl_dev_clean_mailbox(int __always_unused irq, void *data)
 {
@@ -41,6 +53,59 @@ static void nbl_dev_register_net_irq(struct nbl_dev_mgt *dev_mgt, u16 queue_num)
 	msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en = 1;
 }
 
+static int nbl_dev_request_net_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_msix_info_param param = { 0 };
+	int msix_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
+	int ret = 0;
+
+	param.msix_entries =
+		kcalloc(msix_num, sizeof(*param.msix_entries), GFP_KERNEL);
+	if (!param.msix_entries)
+		return -ENOMEM;
+
+	param.msix_num = msix_num;
+	memcpy(param.msix_entries,
+	       msix_info->msix_entries +
+		       msix_info->serv_info[NBL_MSIX_NET_TYPE].base_vector_id,
+	       sizeof(param.msix_entries[0]) * msix_num);
+
+	ret = serv_ops->request_net_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					&param);
+
+	kfree(param.msix_entries);
+	return ret;
+}
+
+static void nbl_dev_free_net_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_msix_info_param param = { 0 };
+	int msix_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
+
+	param.msix_entries =
+		kcalloc(msix_num, sizeof(*param.msix_entries), GFP_KERNEL);
+	if (!param.msix_entries)
+		return;
+
+	param.msix_num = msix_num;
+	memcpy(param.msix_entries,
+	       msix_info->msix_entries +
+		       msix_info->serv_info[NBL_MSIX_NET_TYPE].base_vector_id,
+	       sizeof(param.msix_entries[0]) * msix_num);
+
+	serv_ops->free_net_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &param);
+
+	kfree(param.msix_entries);
+}
+
 static int nbl_dev_request_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
 {
 	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
@@ -445,7 +510,74 @@ static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
 	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
 }
 
+static int nbl_dev_netdev_open(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->netdev_open(netdev);
+}
+
+static int nbl_dev_netdev_stop(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->netdev_stop(netdev);
+}
+
+static netdev_tx_t nbl_dev_start_xmit(struct sk_buff *skb,
+				      struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_resource_pt_ops *pt_ops = NBL_DEV_MGT_TO_RES_PT_OPS(dev_mgt);
+
+	return pt_ops->start_xmit(skb, netdev);
+}
+
+static void nbl_dev_netdev_get_stats64(struct net_device *netdev,
+				       struct rtnl_link_stats64 *stats)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->get_stats64(netdev, stats);
+}
+
+static netdev_features_t
+nbl_dev_netdev_features_check(struct sk_buff *skb, struct net_device *netdev,
+			      netdev_features_t features)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->features_check(skb, netdev, features);
+}
+
+static u16 nbl_dev_netdev_select_queue(struct net_device *netdev,
+				       struct sk_buff *skb,
+				       struct net_device *sb_dev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->select_queue(netdev, skb, sb_dev);
+}
+
 static const struct net_device_ops netdev_ops_leonis_pf = {
+	.ndo_open = nbl_dev_netdev_open,
+	.ndo_stop = nbl_dev_netdev_stop,
+	.ndo_start_xmit = nbl_dev_start_xmit,
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
+	.ndo_features_check = nbl_dev_netdev_features_check,
+	.ndo_select_queue = nbl_dev_netdev_select_queue,
 };
 
 static int nbl_dev_setup_netops_leonis(void *priv, struct net_device *netdev,
@@ -460,6 +592,63 @@ static int nbl_dev_setup_netops_leonis(void *priv, struct net_device *netdev,
 	return 0;
 }
 
+static void nbl_dev_remove_netops(struct net_device *netdev)
+{
+	netdev->netdev_ops = NULL;
+}
+
+static int nbl_dev_cfg_netdev(struct net_device *netdev,
+			      struct nbl_dev_mgt *dev_mgt,
+			      struct nbl_init_param *param,
+			      struct nbl_register_net_result *register_result)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_net_ops *net_dev_ops =
+		NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt);
+	u64 vlan_features = 0;
+	int ret = 0;
+
+	if (param->pci_using_dac)
+		netdev->features |= NETIF_F_HIGHDMA;
+	netdev->watchdog_timeo = 5 * HZ;
+
+	vlan_features = register_result->vlan_features ?
+				register_result->vlan_features :
+				register_result->features;
+	netdev->hw_features |=
+		nbl_features_to_netdev_features(register_result->hw_features);
+	netdev->features |=
+		nbl_features_to_netdev_features(register_result->features);
+	netdev->vlan_features |= nbl_features_to_netdev_features(vlan_features);
+
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+
+	SET_DEV_MIN_MTU(netdev, ETH_MIN_MTU);
+	SET_DEV_MAX_MTU(netdev, register_result->max_mtu);
+	netdev->mtu = min_t(u16, register_result->max_mtu, NBL_DEFAULT_MTU);
+	if (is_valid_ether_addr(register_result->mac))
+		eth_hw_addr_set(netdev, register_result->mac);
+	else
+		eth_hw_addr_random(netdev);
+
+	ether_addr_copy(netdev->perm_addr, netdev->dev_addr);
+
+	netdev->needed_headroom =
+		serv_ops->get_tx_headroom(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+
+	ret = net_dev_ops->setup_netdev_ops(dev_mgt, netdev, param);
+	if (ret)
+		goto set_ops_fail;
+	return 0;
+set_ops_fail:
+	return ret;
+}
+
+static void nbl_dev_reset_netdev(struct net_device *netdev)
+{
+	nbl_dev_remove_netops(netdev);
+}
+
 static int nbl_dev_register_net(struct nbl_dev_mgt *dev_mgt,
 				struct nbl_register_net_result *register_result)
 {
@@ -528,6 +717,62 @@ static void nbl_dev_vsi_common_remove(struct nbl_dev_mgt *dev_mgt,
 {
 }
 
+static int nbl_dev_vsi_common_start(struct nbl_dev_mgt *dev_mgt,
+				    struct net_device *netdev,
+				    struct nbl_dev_vsi *vsi)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	void *p = NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt);
+	int ret;
+
+	vsi->napi_netdev = netdev;
+
+	ret = serv_ops->setup_q2vsi(p, vsi->vsi_id);
+	if (ret) {
+		dev_err(dev, "Setup q2vsi failed\n");
+		goto set_q2vsi_fail;
+	}
+
+	ret = serv_ops->setup_rss(p, vsi->vsi_id);
+	if (ret) {
+		dev_err(dev, "Setup rss failed\n");
+		goto set_rss_fail;
+	}
+
+	ret = serv_ops->setup_rss_indir(p, vsi->vsi_id);
+	if (ret) {
+		dev_err(dev, "Setup rss indir failed\n");
+		goto setup_rss_indir_fail;
+	}
+
+	ret = serv_ops->enable_napis(p, vsi->index);
+	if (ret) {
+		dev_err(dev, "Enable napis failed\n");
+		goto enable_napi_fail;
+	}
+	return 0;
+
+enable_napi_fail:
+setup_rss_indir_fail:
+	serv_ops->remove_rss(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+set_rss_fail:
+	serv_ops->remove_q2vsi(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+set_q2vsi_fail:
+	return ret;
+}
+
+static void nbl_dev_vsi_common_stop(struct nbl_dev_mgt *dev_mgt,
+				    struct nbl_dev_vsi *vsi)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->disable_napis(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				vsi->index);
+	serv_ops->remove_rss(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+	serv_ops->remove_q2vsi(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+}
+
 static int nbl_dev_vsi_data_register(struct nbl_dev_mgt *dev_mgt,
 				     struct nbl_init_param *param,
 				     void *vsi_data)
@@ -564,12 +809,55 @@ static void nbl_dev_vsi_data_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
 	nbl_dev_vsi_common_remove(dev_mgt, vsi);
 }
 
+static int nbl_dev_vsi_data_start(void *dev_priv, struct net_device *netdev,
+				  void *vsi_data)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)dev_priv;
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	int ret;
+
+	ret = nbl_dev_vsi_common_start(dev_mgt, netdev, vsi);
+	return ret;
+}
+
+static void nbl_dev_vsi_data_stop(void *dev_priv, void *vsi_data)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)dev_priv;
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	nbl_dev_vsi_common_stop(dev_mgt, vsi);
+}
+
+static int nbl_dev_vsi_data_netdev_build(struct nbl_dev_mgt *dev_mgt,
+					 struct nbl_init_param *param,
+					 struct net_device *netdev,
+					 void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	vsi->netdev = netdev;
+	return nbl_dev_cfg_netdev(netdev, dev_mgt, param,
+				  &vsi->register_result);
+}
+
+static void nbl_dev_vsi_data_netdev_destroy(struct nbl_dev_mgt *dev_mgt,
+					    void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	nbl_dev_reset_netdev(vsi->netdev);
+}
+
 static struct nbl_dev_vsi_tbl vsi_tbl[NBL_VSI_MAX] = {
 	[NBL_VSI_DATA] = {
 		.vsi_ops = {
 			.register_vsi = nbl_dev_vsi_data_register,
 			.setup = nbl_dev_vsi_data_setup,
 			.remove = nbl_dev_vsi_data_remove,
+			.start = nbl_dev_vsi_data_start,
+			.stop = nbl_dev_vsi_data_stop,
+			.netdev_build = nbl_dev_vsi_data_netdev_build,
+			.netdev_destroy = nbl_dev_vsi_data_netdev_destroy,
 		},
 	},
 };
@@ -857,6 +1145,156 @@ void nbl_dev_remove(void *p)
 }
 
 /* ----------  Dev start process  ---------- */
+static int nbl_dev_start_net_dev(struct nbl_adapter *adapter,
+				 struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct net_device *netdev = net_dev->netdev;
+	struct nbl_netdev_priv *net_priv;
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	void *priv = NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt);
+	struct nbl_ring_param ring_param = {0};
+	struct nbl_dev_vsi *vsi;
+	u16 net_vector_id, queue_num;
+	int ret;
+
+	vsi = nbl_dev_vsi_select(dev_mgt, NBL_VSI_DATA);
+	if (!vsi)
+		return -EFAULT;
+
+	queue_num = vsi->queue_num;
+	netdev = alloc_etherdev_mqs(sizeof(struct nbl_netdev_priv), queue_num,
+				    queue_num);
+	if (!netdev) {
+		dev_err(dev, "Alloc net device failed\n");
+		ret = -ENOMEM;
+		goto alloc_netdev_fail;
+	}
+
+	SET_NETDEV_DEV(netdev, dev);
+	net_priv = netdev_priv(netdev);
+	net_priv->adapter = adapter;
+	nbl_dev_set_netdev_priv(netdev, vsi);
+
+	net_dev->netdev = netdev;
+	common->msg_enable = netif_msg_init(-1, DEFAULT_MSG_ENABLE);
+	serv_ops->set_mask_en(priv, 1);
+
+	ring_param.tx_ring_num = net_dev->kernel_queue_num;
+	ring_param.rx_ring_num = net_dev->kernel_queue_num;
+	ring_param.queue_size = net_priv->queue_size;
+	ret = serv_ops->alloc_rings(priv, netdev, &ring_param);
+	if (ret) {
+		dev_err(dev, "Alloc rings failed\n");
+		goto alloc_rings_fail;
+	}
+
+	ret = serv_ops->setup_net_resource_mgt(priv, netdev,
+					       vsi->register_result.vlan_proto,
+					       vsi->register_result.vlan_tci,
+					       vsi->register_result.rate);
+	if (ret) {
+		dev_err(dev, "setup net mgt failed\n");
+		goto setup_net_mgt_fail;
+	}
+
+	/* netdev build must before setup_txrx_queues. Because snoop check mac
+	 * trust the mac if pf use ip link cfg the mac for vf. We judge the
+	 * case will not permit accord queue has alloced when vf modify mac.
+	 */
+	ret = vsi->ops->netdev_build(dev_mgt, param, netdev, vsi);
+	if (ret) {
+		dev_err(dev, "Build netdev failed, selected vsi %d\n",
+			vsi->index);
+		goto build_netdev_fail;
+	}
+
+	net_vector_id = msix_info->serv_info[NBL_MSIX_NET_TYPE].base_vector_id;
+	ret = serv_ops->setup_txrx_queues(priv, vsi->vsi_id,
+					  net_dev->kernel_queue_num,
+					  net_vector_id);
+	if (ret) {
+		dev_err(dev, "Set queue map failed\n");
+		goto set_queue_fail;
+	}
+
+	ret = vsi->ops->start(dev_mgt, netdev, vsi);
+	if (ret) {
+		dev_err(dev, "Start vsi failed, selected vsi %d\n", vsi->index);
+		goto start_vsi_fail;
+	}
+
+	ret = nbl_dev_request_net_irq(dev_mgt);
+	if (ret) {
+		dev_err(dev, "request irq failed\n");
+		goto request_irq_fail;
+	}
+
+	netif_carrier_off(netdev);
+	ret = register_netdev(netdev);
+	if (ret) {
+		dev_err(dev, "Register netdev failed\n");
+		goto register_netdev_fail;
+	}
+	set_bit(NBL_DOWN, adapter->state);
+
+	return 0;
+register_netdev_fail:
+	nbl_dev_free_net_irq(dev_mgt);
+request_irq_fail:
+	vsi->ops->stop(dev_mgt, vsi);
+start_vsi_fail:
+	serv_ops->remove_txrx_queues(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				     vsi->vsi_id);
+set_queue_fail:
+	vsi->ops->netdev_destroy(dev_mgt, vsi);
+build_netdev_fail:
+	serv_ops->remove_net_resource_mgt(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+setup_net_mgt_fail:
+	serv_ops->free_rings(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+alloc_rings_fail:
+	free_netdev(netdev);
+alloc_netdev_fail:
+	return ret;
+}
+
+static void nbl_dev_stop_net_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_vsi *vsi;
+	struct net_device *netdev;
+
+	if (!net_dev)
+		return;
+
+	netdev = net_dev->netdev;
+	vsi = net_dev->vsi_ctrl.vsi_list[NBL_VSI_DATA];
+	if (!vsi)
+		return;
+
+	unregister_netdev(netdev);
+	rtnl_lock();
+	netif_device_detach(netdev);
+	rtnl_unlock();
+
+	vsi->ops->netdev_destroy(dev_mgt, vsi);
+	vsi->ops->stop(dev_mgt, vsi);
+	nbl_dev_free_net_irq(dev_mgt);
+	serv_ops->remove_net_resource_mgt(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	serv_ops->remove_txrx_queues(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				     vsi->vsi_id);
+	serv_ops->free_rings(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+
+	free_netdev(netdev);
+}
 
 static int nbl_dev_start_common_dev(struct nbl_adapter *adapter,
 				    struct nbl_init_param *param)
@@ -908,6 +1346,17 @@ int nbl_dev_start(void *p, struct nbl_init_param *param)
 	int ret;
 
 	ret = nbl_dev_start_common_dev(adapter, param);
+	if (ret)
+		goto start_common_dev_fail;
+
+	ret = nbl_dev_start_net_dev(adapter, param);
+	if (ret)
+		goto start_net_dev_fail;
+	return 0;
+
+start_net_dev_fail:
+	nbl_dev_stop_common_dev(adapter);
+start_common_dev_fail:
 	return ret;
 }
 
@@ -915,5 +1364,6 @@ void nbl_dev_stop(void *p)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
 
+	nbl_dev_stop_net_dev(adapter);
 	nbl_dev_stop_common_dev(adapter);
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
index b83b79a8001f..11e590bb00dc 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
@@ -13,6 +13,146 @@
 
 #include "nbl_service.h"
 
+static int nbl_serv_set_promisc_mode(void *priv, u16 vsi_id, u16 mode);
+
+static void nbl_serv_set_queue_param(struct nbl_serv_ring *ring, u16 desc_num,
+				     struct nbl_txrx_queue_param *param,
+				     u16 vsi_id, u16 global_vec_id)
+{
+	param->vsi_id = vsi_id;
+	param->dma = ring->dma;
+	param->desc_num = desc_num;
+	param->local_queue_id = ring->local_queue_id / 2;
+	param->global_vec_id = global_vec_id;
+	param->intr_en = 1;
+	param->intr_mask = 1;
+	param->extend_header = 1;
+	param->rxcsum = 1;
+	param->split = 0;
+}
+
+/*
+ * In virtio mode, the emulator triggers the configuration of
+ * txrx_registers only based on tx_ring, so the rx_info needs
+ * to be delivered first before the tx_info can be delivered.
+ */
+static int nbl_serv_setup_queues(struct nbl_service_mgt *serv_mgt,
+				 struct nbl_serv_ring_vsi_info *vsi_info)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_txrx_queue_param param = {0};
+	struct nbl_serv_ring *ring;
+	struct nbl_serv_vector *vector;
+	u16 start = vsi_info->ring_offset,
+	    end = vsi_info->ring_offset + vsi_info->ring_num;
+	int i, ret = 0;
+
+	for (i = start; i < end; i++) {
+		vector = &ring_mgt->vectors[i];
+		ring = &ring_mgt->rx_rings[i];
+		nbl_serv_set_queue_param(ring, ring_mgt->rx_desc_num, &param,
+					 vsi_info->vsi_id,
+					 vector->global_vec_id);
+
+		ret = disp_ops->setup_queue(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    &param, false);
+		if (ret)
+			return ret;
+	}
+
+	for (i = start; i < end; i++) {
+		vector = &ring_mgt->vectors[i];
+		ring = &ring_mgt->tx_rings[i];
+		nbl_serv_set_queue_param(ring, ring_mgt->tx_desc_num, &param,
+					 vsi_info->vsi_id,
+					 vector->global_vec_id);
+
+		ret = disp_ops->setup_queue(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    &param, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void nbl_serv_flush_rx_queues(struct nbl_service_mgt *serv_mgt,
+				     u16 ring_offset, u16 ring_num)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	int i;
+
+	for (i = ring_offset; i < ring_offset + ring_num; i++)
+		disp_ops->kick_rx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
+}
+
+static int nbl_serv_setup_rings(struct nbl_service_mgt *serv_mgt,
+				struct net_device *netdev,
+				struct nbl_serv_ring_vsi_info *vsi_info,
+				bool use_napi)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	void *p = NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt);
+	u16 start = vsi_info->ring_offset,
+	    end = vsi_info->ring_offset + vsi_info->ring_num;
+	int i, ret = 0;
+
+	for (i = start; i < end; i++) {
+		ring_mgt->tx_rings[i].dma =
+			disp_ops->start_tx_ring(p, i);
+		if (!ring_mgt->tx_rings[i].dma) {
+			netdev_err(netdev, "Fail to start tx ring %d", i);
+			ret = -EFAULT;
+			break;
+		}
+	}
+	if (i != end) {
+		while (--i + 1 > start)
+			disp_ops->stop_tx_ring(p, i);
+		goto tx_err;
+	}
+
+	for (i = start; i < end; i++) {
+		ring_mgt->rx_rings[i].dma =
+			disp_ops->start_rx_ring(p, i, use_napi);
+		if (!ring_mgt->rx_rings[i].dma) {
+			netdev_err(netdev, "Fail to start rx ring %d", i);
+			ret = -EFAULT;
+			break;
+		}
+	}
+	if (i != end) {
+		while (--i + 1 > start)
+			disp_ops->stop_rx_ring(p, i);
+		goto rx_err;
+	}
+
+	return 0;
+
+rx_err:
+	for (i = start; i < end; i++)
+		disp_ops->stop_tx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
+tx_err:
+	return ret;
+}
+
+static void nbl_serv_stop_rings(struct nbl_service_mgt *serv_mgt,
+				struct nbl_serv_ring_vsi_info *vsi_info)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u16 start = vsi_info->ring_offset,
+	    end = vsi_info->ring_offset + vsi_info->ring_num;
+	int i;
+
+	for (i = start; i < end; i++)
+		disp_ops->stop_tx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
+
+	for (i = start; i < end; i++)
+		disp_ops->stop_rx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
+}
+
 static int nbl_serv_set_tx_rings(struct nbl_serv_ring_mgt *ring_mgt,
 				 struct net_device *netdev, struct device *dev)
 {
@@ -104,6 +244,297 @@ static void nbl_serv_remove_vectors(struct nbl_serv_ring_mgt *ring_mgt,
 	ring_mgt->vectors = NULL;
 }
 
+int nbl_serv_vsi_open(void *priv, struct net_device *netdev, u16 vsi_index,
+		      u16 real_qps, bool use_napi)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info =
+		&ring_mgt->vsi_info[vsi_index];
+	int ret = 0;
+
+	if (vsi_info->started)
+		return 0;
+
+	ret = nbl_serv_setup_rings(serv_mgt, netdev, vsi_info, use_napi);
+	if (ret) {
+		netdev_err(netdev, "Fail to setup rings\n");
+		goto setup_rings_fail;
+	}
+
+	ret = nbl_serv_setup_queues(serv_mgt, vsi_info);
+	if (ret) {
+		netdev_err(netdev, "Fail to setup queues\n");
+		goto setup_queue_fail;
+	}
+	nbl_serv_flush_rx_queues(serv_mgt, vsi_info->ring_offset,
+				 vsi_info->ring_num);
+	ret = disp_ops->cfg_dsch(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				 vsi_info->vsi_id, true);
+	if (ret) {
+		netdev_err(netdev, "Fail to setup dsch\n");
+		goto setup_dsch_fail;
+	}
+
+	vsi_info->active_ring_num = real_qps;
+	ret = disp_ops->setup_cqs(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				  vsi_info->vsi_id, real_qps, false);
+	if (ret)
+		goto setup_cqs_fail;
+
+	vsi_info->started = true;
+	return 0;
+
+setup_cqs_fail:
+	disp_ops->cfg_dsch(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+			   NBL_COMMON_TO_VSI_ID(common), false);
+setup_dsch_fail:
+	disp_ops->remove_all_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				    NBL_COMMON_TO_VSI_ID(common));
+setup_queue_fail:
+	nbl_serv_stop_rings(serv_mgt, vsi_info);
+setup_rings_fail:
+	return ret;
+}
+
+int nbl_serv_vsi_stop(void *priv, u16 vsi_index)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info =
+		&ring_mgt->vsi_info[vsi_index];
+
+	if (!vsi_info->started)
+		return 0;
+
+	vsi_info->started = false;
+	/* modify defalt action and rss configuration */
+	disp_ops->remove_cqs(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+			     vsi_info->vsi_id);
+
+	/* clear dsch config */
+	disp_ops->cfg_dsch(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+			   vsi_info->vsi_id, false);
+
+	/* disable and rest tx/rx logic queue */
+	disp_ops->remove_all_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				    vsi_info->vsi_id);
+
+	/* free tx and rx bufs */
+	nbl_serv_stop_rings(serv_mgt, vsi_info);
+
+	return 0;
+}
+
+int nbl_serv_netdev_open(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+	int num_cpus, real_qps, ret = 0;
+
+	if (!test_bit(NBL_DOWN, adapter->state))
+		return -EBUSY;
+
+	netdev_dbg(netdev, "Nbl open\n");
+
+	netif_carrier_off(netdev);
+
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+
+	if (vsi_info->active_ring_num) {
+		real_qps = vsi_info->active_ring_num;
+	} else {
+		num_cpus = num_online_cpus();
+		real_qps = num_cpus > vsi_info->ring_num ? vsi_info->ring_num :
+							   num_cpus;
+	}
+
+	ret = nbl_serv_vsi_open(serv_mgt, netdev, NBL_VSI_DATA, real_qps, 1);
+	if (ret)
+		goto vsi_open_fail;
+
+	ret = netif_set_real_num_tx_queues(netdev, real_qps);
+	if (ret)
+		goto setup_real_qps_fail;
+	ret = netif_set_real_num_rx_queues(netdev, real_qps);
+	if (ret)
+		goto setup_real_qps_fail;
+
+	netif_tx_start_all_queues(netdev);
+	clear_bit(NBL_DOWN, adapter->state);
+	set_bit(NBL_RUNNING, adapter->state);
+	netif_carrier_on(netdev);
+	netdev_dbg(netdev, "Nbl open ok!\n");
+	nbl_serv_set_promisc_mode((void *)serv_mgt, vsi_info->vsi_id, 1);
+	return 0;
+
+setup_real_qps_fail:
+	nbl_serv_vsi_stop(serv_mgt, NBL_VSI_DATA);
+vsi_open_fail:
+	return ret;
+}
+
+int nbl_serv_netdev_stop(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+	if (!test_bit(NBL_RUNNING, adapter->state))
+		return -EBUSY;
+
+	netdev_dbg(netdev, "Nbl stop\n");
+	set_bit(NBL_DOWN, adapter->state);
+	clear_bit(NBL_RUNNING, adapter->state);
+
+	netif_tx_stop_all_queues(netdev);
+	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
+	synchronize_net();
+	nbl_serv_vsi_stop(serv_mgt, NBL_VSI_DATA);
+	nbl_serv_set_promisc_mode((void *)serv_mgt, vsi_info->vsi_id, 0);
+	netdev_dbg(netdev, "Nbl stop ok!\n");
+
+	return 0;
+}
+
+static void nbl_serv_get_stats64(struct net_device *netdev,
+				 struct rtnl_link_stats64 *stats)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_stats net_stats = { 0 };
+
+	if (!stats) {
+		netdev_err(netdev, "get_link_stats64 stats is null\n");
+		return;
+	}
+
+	disp_ops->get_net_stats(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				&net_stats);
+
+	stats->rx_packets = net_stats.rx_packets;
+	stats->tx_packets = net_stats.tx_packets;
+	stats->rx_bytes = net_stats.rx_bytes;
+	stats->tx_bytes = net_stats.tx_bytes;
+	stats->multicast = net_stats.rx_multicast_packets;
+
+	stats->rx_errors = 0;
+	stats->tx_errors = 0;
+	stats->rx_length_errors = netdev->stats.rx_length_errors;
+	stats->rx_crc_errors = netdev->stats.rx_crc_errors;
+	stats->rx_frame_errors = netdev->stats.rx_frame_errors;
+	stats->rx_dropped = 0;
+	stats->tx_dropped = 0;
+}
+
+static netdev_features_t nbl_serv_features_check(struct sk_buff *skb,
+						 struct net_device *dev,
+						 netdev_features_t features)
+{
+	u32 l2_l3_hrd_len = 0, l4_hrd_len = 0, total_hrd_len = 0;
+	u8 l4_proto = 0;
+	__be16 protocol, frag_off;
+	unsigned char *exthdr;
+	int ret;
+	union {
+		struct iphdr *v4;
+		struct ipv6hdr *v6;
+		unsigned char *hdr;
+	} ip;
+	union {
+		struct tcphdr *tcp;
+		struct udphdr *udp;
+		unsigned char *hdr;
+	} l4;
+
+	/* No point in doing any of this if neither checksum nor GSO are
+	 * being requested for this frame. We can rule out both by just
+	 * checking for CHECKSUM_PARTIAL.
+	 */
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return features;
+
+	/* We cannot support GSO if the MSS is going to be less than
+	 * 256 bytes or bigger than 16383 bytes. If it is then we need
+	 *to drop support for GSO.
+	 */
+	if (skb_is_gso(skb) &&
+	    (skb_shinfo(skb)->gso_size < NBL_TX_TSO_MSS_MIN ||
+	     skb_shinfo(skb)->gso_size > NBL_TX_TSO_MSS_MAX))
+		features &= ~NETIF_F_GSO_MASK;
+
+	l2_l3_hrd_len = (u32)(skb_transport_header(skb) - skb->data);
+
+	ip.hdr = skb_network_header(skb);
+	l4.hdr = skb_transport_header(skb);
+	protocol = vlan_get_protocol(skb);
+
+	if (protocol == htons(ETH_P_IP)) {
+		l4_proto = ip.v4->protocol;
+	} else if (protocol == htons(ETH_P_IPV6)) {
+		exthdr = ip.hdr + sizeof(*ip.v6);
+		l4_proto = ip.v6->nexthdr;
+		if (l4.hdr != exthdr) {
+			ret = ipv6_skip_exthdr(skb, exthdr - skb->data,
+					       &l4_proto, &frag_off);
+			if (ret < 0)
+				goto out_rm_features;
+		}
+	} else {
+		goto out_rm_features;
+	}
+
+	switch (l4_proto) {
+	case IPPROTO_TCP:
+		l4_hrd_len = (l4.tcp->doff) * 4;
+		break;
+	case IPPROTO_UDP:
+		l4_hrd_len = sizeof(struct udphdr);
+		break;
+	case IPPROTO_SCTP:
+		l4_hrd_len = sizeof(struct sctphdr);
+		break;
+	default:
+		goto out_rm_features;
+	}
+
+	total_hrd_len = l2_l3_hrd_len + l4_hrd_len;
+
+	// TX checksum offload support total header len is [0, 255]
+	if (total_hrd_len > NBL_TX_CHECKSUM_OFFLOAD_L2L3L4_HDR_LEN_MAX)
+		goto out_rm_features;
+
+	// TSO support total header len is [42, 128]
+	if (total_hrd_len < NBL_TX_TSO_L2L3L4_HDR_LEN_MIN ||
+	    total_hrd_len > NBL_TX_TSO_L2L3L4_HDR_LEN_MAX)
+		features &= ~NETIF_F_GSO_MASK;
+
+	if (skb->encapsulation)
+		goto out_rm_features;
+
+	return features;
+
+out_rm_features:
+	return features & ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
+			    NETIF_F_SCTP_CRC | NETIF_F_GSO_MASK);
+}
+
+static u16
+nbl_serv_select_queue(struct net_device *netdev, struct sk_buff *skb,
+		      struct net_device *sb_dev)
+{
+	return netdev_pick_tx(netdev, skb, sb_dev);
+}
+
 static int
 nbl_serv_register_net(void *priv, struct nbl_register_net_param *register_param,
 		      struct nbl_register_net_result *register_result)
@@ -345,6 +776,23 @@ static void nbl_serv_set_mask_en(void *priv, bool enable)
 	ring_mgt->net_msix_mask_en = enable;
 }
 
+static int nbl_serv_set_promisc_mode(void *priv, u16 vsi_id, u16 mode)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->set_promisc_mode(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					  vsi_id, mode);
+}
+
+static u32 nbl_serv_get_tx_headroom(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_tx_headroom(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
 static int nbl_serv_init_chip(void *priv)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
@@ -436,6 +884,95 @@ static int nbl_serv_enable_mailbox_irq(void *priv, u16 vector_id,
 	return 0;
 }
 
+static irqreturn_t nbl_serv_clean_rings(int __always_unused irq, void *data)
+{
+	struct nbl_serv_vector *vector = (struct nbl_serv_vector *)data;
+
+	napi_schedule_irqoff(&vector->nbl_napi->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int nbl_serv_request_net_irq(void *priv,
+				    struct nbl_msix_info_param *msix_info)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_serv_ring *tx_ring, *rx_ring;
+	struct nbl_serv_vector *vector;
+	u32 irq_num;
+	int i, ret = 0;
+
+	for (i = 0; i < ring_mgt->tx_ring_num; i++) {
+		tx_ring = &ring_mgt->tx_rings[i];
+		rx_ring = &ring_mgt->rx_rings[i];
+		vector = &ring_mgt->vectors[i];
+		vector->tx_ring = tx_ring;
+		vector->rx_ring = rx_ring;
+
+		irq_num = msix_info->msix_entries[i].vector;
+		snprintf(vector->name, sizeof(vector->name),
+			 "nbl_txrx%d@pci:%s", i,
+			 pci_name(NBL_COMMON_TO_PDEV(common)));
+		ret = devm_request_irq(dev, irq_num, nbl_serv_clean_rings, 0,
+				       vector->name, vector);
+		if (ret) {
+			nbl_err(common, "TxRx Queue %u req irq with error %d",
+				i, ret);
+			goto request_irq_err;
+		}
+	}
+
+	net_resource_mgt->num_net_msix = msix_info->msix_num;
+
+	return 0;
+
+request_irq_err:
+	while (--i + 1) {
+		vector = &ring_mgt->vectors[i];
+
+		irq_num = msix_info->msix_entries[i].vector;
+		irq_set_affinity_hint(irq_num, NULL);
+		devm_free_irq(dev, irq_num, vector);
+	}
+	return ret;
+}
+
+static void nbl_serv_free_net_irq(void *priv,
+				  struct nbl_msix_info_param *msix_info)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_serv_vector *vector;
+	u32 irq_num;
+	int i;
+
+	for (i = 0; i < ring_mgt->tx_ring_num; i++) {
+		vector = &ring_mgt->vectors[i];
+
+		irq_num = msix_info->msix_entries[i].vector;
+		irq_set_affinity_hint(irq_num, NULL);
+		devm_free_irq(dev, irq_num, vector);
+	}
+}
+
+static u16 nbl_serv_get_global_vector(void *priv, u16 local_vec_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_global_vector(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   NBL_COMMON_TO_VSI_ID(common),
+					   local_vec_id);
+}
+
 static u16 nbl_serv_get_msix_entry_id(void *priv, u16 local_vec_id)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
@@ -481,6 +1018,47 @@ static void nbl_serv_set_netdev_ops(void *priv,
 			(void *)net_device_ops;
 }
 
+static void nbl_serv_remove_net_resource_mgt(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_mgt;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct device *dev;
+
+	net_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	dev = NBL_COMMON_TO_DEV(common);
+
+	if (net_mgt) {
+		devm_kfree(dev, net_mgt);
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt) = NULL;
+	}
+}
+
+static int nbl_serv_setup_net_resource_mgt(void *priv,
+					   struct net_device *netdev,
+					   u16 vlan_proto, u16 vlan_tci,
+					   u32 rate)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+	int size = sizeof(struct nbl_serv_net_resource_mgt);
+
+	net_resource_mgt = devm_kzalloc(dev, size, GFP_KERNEL);
+	if (!net_resource_mgt)
+		return -ENOMEM;
+
+	net_resource_mgt->netdev = netdev;
+	net_resource_mgt->serv_mgt = serv_mgt;
+	net_resource_mgt->vlan_proto = vlan_proto;
+	net_resource_mgt->vlan_tci = vlan_tci;
+	net_resource_mgt->max_tx_rate = rate;
+	NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt) = net_resource_mgt;
+
+	return 0;
+}
+
 static int nbl_serv_register_vsi_info(void *priv,
 				      struct nbl_vsi_param *vsi_param)
 {
@@ -529,6 +1107,9 @@ static struct nbl_service_ops serv_ops = {
 	.destroy_msix_map = nbl_serv_destroy_msix_map,
 	.enable_mailbox_irq = nbl_serv_enable_mailbox_irq,
 
+	.request_net_irq = nbl_serv_request_net_irq,
+	.free_net_irq = nbl_serv_free_net_irq,
+	.get_global_vector = nbl_serv_get_global_vector,
 	.get_msix_entry_id = nbl_serv_get_msix_entry_id,
 
 	.register_net = nbl_serv_register_net,
@@ -549,9 +1130,23 @@ static struct nbl_service_ops serv_ops = {
 	.disable_napis = nbl_serv_disable_napis,
 	.set_mask_en = nbl_serv_set_mask_en,
 
+	.set_promisc_mode = nbl_serv_set_promisc_mode,
+	.get_tx_headroom = nbl_serv_get_tx_headroom,
+
+	.vsi_open = nbl_serv_vsi_open,
+	.vsi_stop = nbl_serv_vsi_stop,
+	/* For netdev ops */
+	.netdev_open = nbl_serv_netdev_open,
+	.netdev_stop = nbl_serv_netdev_stop,
+	.get_stats64 = nbl_serv_get_stats64,
+	.features_check = nbl_serv_features_check,
+	.select_queue = nbl_serv_select_queue,
+
 	.set_netdev_ops = nbl_serv_set_netdev_ops,
 	.get_vsi_id = nbl_serv_get_vsi_id,
 	.get_eth_id = nbl_serv_get_eth_id,
+	.setup_net_resource_mgt = nbl_serv_setup_net_resource_mgt,
+	.remove_net_resource_mgt = nbl_serv_remove_net_resource_mgt,
 };
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
index 273218200526..49d7fea5a7cc 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
@@ -123,4 +123,10 @@ struct nbl_service_mgt {
 	struct nbl_serv_net_resource_mgt *net_resource_mgt;
 };
 
+int nbl_serv_netdev_open(struct net_device *netdev);
+int nbl_serv_netdev_stop(struct net_device *netdev);
+int nbl_serv_vsi_open(void *priv, struct net_device *netdev, u16 vsi_index,
+		      u16 real_qps, bool use_napi);
+int nbl_serv_vsi_stop(void *priv, u16 vsi_index);
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index fe176ee72128..6b2bb6d15fdf 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -161,4 +161,5 @@ int nbl_common_alloc_hash_node(void *priv, void *key, void *data,
 			       void **out_data);
 void *nbl_common_get_hash_node(void *priv, void *key);
 void nbl_common_free_hash_node(void *priv, void *key);
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
index 29b541649a90..b6eab6a621dc 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
@@ -50,7 +50,6 @@ struct nbl_service_ops {
 	int (*setup_rss_indir)(void *priv, u16 vsi_id);
 	int (*alloc_rings)(void *priv, struct net_device *dev,
 			   struct nbl_ring_param *param);
-	void (*cpu_affinity_init)(void *priv, u16 rings_num);
 	void (*free_rings)(void *priv);
 	int (*enable_napis)(void *priv, u16 vsi_index);
 	void (*disable_napis)(void *priv, u16 vsi_index);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 0ab4dd981c8a..77d98f15a6c8 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -29,6 +29,8 @@
 
 #define NBL_MAX_FUNC					(520)
 
+#define SET_DEV_MIN_MTU(netdev, mtu) ((netdev)->min_mtu = (mtu))
+#define SET_DEV_MAX_MTU(netdev, mtu) ((netdev)->max_mtu = (mtu))
 /* Used for macros to pass checkpatch */
 #define NBL_NAME(x)					x
 
@@ -255,7 +257,48 @@ enum {
 	NBL_FEATURES_COUNT
 };
 
+static const netdev_features_t nbl_netdev_features[] = {
+	[NBL_NETIF_F_SG_BIT] = NETIF_F_SG,
+	[NBL_NETIF_F_IP_CSUM_BIT] = NETIF_F_IP_CSUM,
+	[NBL_NETIF_F_IPV6_CSUM_BIT] = NETIF_F_IPV6_CSUM,
+	[NBL_NETIF_F_HIGHDMA_BIT] = NETIF_F_HIGHDMA,
+	[NBL_NETIF_F_HW_VLAN_CTAG_TX_BIT] = NETIF_F_HW_VLAN_CTAG_TX,
+	[NBL_NETIF_F_HW_VLAN_CTAG_RX_BIT] = NETIF_F_HW_VLAN_CTAG_RX,
+	[NBL_NETIF_F_HW_VLAN_CTAG_FILTER_BIT] = NETIF_F_HW_VLAN_CTAG_FILTER,
+	[NBL_NETIF_F_TSO_BIT] = NETIF_F_TSO,
+	[NBL_NETIF_F_GSO_ROBUST_BIT] = NETIF_F_GSO_ROBUST,
+	[NBL_NETIF_F_TSO6_BIT] = NETIF_F_TSO6,
+	[NBL_NETIF_F_GSO_GRE_BIT] = NETIF_F_GSO_GRE,
+	[NBL_NETIF_F_GSO_GRE_CSUM_BIT] = NETIF_F_GSO_GRE_CSUM,
+	[NBL_NETIF_F_GSO_UDP_TUNNEL_BIT] = NETIF_F_GSO_UDP_TUNNEL,
+	[NBL_NETIF_F_GSO_UDP_TUNNEL_CSUM_BIT] = NETIF_F_GSO_UDP_TUNNEL_CSUM,
+	[NBL_NETIF_F_GSO_PARTIAL_BIT] = NETIF_F_GSO_PARTIAL,
+	[NBL_NETIF_F_GSO_UDP_L4_BIT] = NETIF_F_GSO_UDP_L4,
+	[NBL_NETIF_F_SCTP_CRC_BIT] = NETIF_F_SCTP_CRC,
+	[NBL_NETIF_F_NTUPLE_BIT] = NETIF_F_NTUPLE,
+	[NBL_NETIF_F_RXHASH_BIT] = NETIF_F_RXHASH,
+	[NBL_NETIF_F_RXCSUM_BIT] = NETIF_F_RXCSUM,
+	[NBL_NETIF_F_HW_VLAN_STAG_TX_BIT] = NETIF_F_HW_VLAN_STAG_TX,
+	[NBL_NETIF_F_HW_VLAN_STAG_RX_BIT] = NETIF_F_HW_VLAN_STAG_RX,
+	[NBL_NETIF_F_HW_VLAN_STAG_FILTER_BIT] = NETIF_F_HW_VLAN_STAG_FILTER,
+	[NBL_NETIF_F_HW_TC_BIT] = NETIF_F_HW_TC,
+};
+
 #define NBL_FEATURE(name)			(1 << (NBL_##name##_BIT))
+#define NBL_FEATURE_TEST_BIT(val, loc)		(((val) >> (loc)) & 0x1)
+
+static inline netdev_features_t nbl_features_to_netdev_features(u64 features)
+{
+	netdev_features_t netdev_features = 0;
+	int i = 0;
+
+	for (i = 0; i < NBL_FEATURES_COUNT; i++) {
+		if (NBL_FEATURE_TEST_BIT(features, i))
+			netdev_features += nbl_netdev_features[i];
+	}
+
+	return netdev_features;
+};
 
 enum nbl_performance_mode {
 	NBL_QUIRKS_NO_TOE,
-- 
2.47.3


