Return-Path: <netdev+bounces-245794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ACDCD8000
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29D5B302DA46
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 03:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC15E2DEA8C;
	Tue, 23 Dec 2025 03:52:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-92.mail.aliyun.com (out28-92.mail.aliyun.com [115.124.28.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31251A08BC;
	Tue, 23 Dec 2025 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461927; cv=none; b=qxB2//MA8zcYnxoARbSTP7+KHoL3vyFOU29DileyAgWs+O77mqKA1l+XHFQJIxE+dNhbaGToM6VacXTGj1Z5b4pidZdsdXTddE+TPlL1tPduWQlDYIjNs3pgHroa2NGaMcTraOK4y/KSK+pCzXbDFQDe8tIXehmmErgPXDh7gsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461927; c=relaxed/simple;
	bh=8cTMMM5iioN7C5D97OJRfxbwYi6xTfFJaaSGH6poz+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2bwXYIhDMBR/hNZDSZ6BxVdEd6tKlgWdg3LvR+kkJ9t2RoqrnFnozj1MYdqtPpkOv99AjXu6doUGcfGJ9leTuKoDHQM7SLzaj5a0rIbMrPQh2Hd5OCSDOCa/uM0NQKVnci2x2FLSjNJIC3zWNU1YuH02t//D1bWYW2nSVjjJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.fqrxX7O_1766461916 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 11:51:58 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 net-next 14/15] net/nebula-matrix: fully support ndo operations
Date: Tue, 23 Dec 2025 11:50:37 +0800
Message-ID: <20251223035113.31122-15-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fully support ndo operations

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
Change-Id: Icb1ed852da1d28f563efdf2b6431ff7bc80f58e3
---
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 211 ++++++++-
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 423 +++++++++++++++++-
 2 files changed, 631 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index d97651c5daa0..45b75e1c4f53 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -1399,6 +1399,33 @@ static void nbl_dev_netdev_get_stats64(struct net_device *netdev, struct rtnl_li
 	serv_ops->get_stats64(netdev, stats);
 }
 
+static void nbl_dev_netdev_set_rx_mode(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->set_rx_mode(netdev);
+}
+
+static void nbl_dev_netdev_change_rx_flags(struct net_device *netdev, int flag)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->change_rx_flags(netdev, flag);
+}
+
+static int nbl_dev_netdev_set_mac(struct net_device *netdev, void *p)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->set_mac(netdev, p);
+}
+
 static int nbl_dev_netdev_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
@@ -1417,14 +1444,190 @@ static int nbl_dev_netdev_rx_kill_vid(struct net_device *netdev, __be16 proto, u
 	return serv_ops->rx_kill_vid(netdev, proto, vid);
 }
 
+static int
+nbl_dev_netdev_set_features(struct net_device *netdev, netdev_features_t features)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->set_features(netdev, features);
+}
+
+static netdev_features_t
+nbl_dev_netdev_features_check(struct sk_buff *skb, struct net_device *netdev,
+			      netdev_features_t features)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->features_check(skb, netdev, features);
+}
+
+static int
+nbl_dev_netdev_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->set_vf_spoofchk(netdev, vf_id, ena);
+}
+
+static void nbl_dev_netdev_tx_timeout(struct net_device *netdev, u32 txqueue)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->tx_timeout(netdev, txqueue);
+}
+
+static int nbl_dev_netdev_bridge_setlink(struct net_device *netdev, struct nlmsghdr *nlh,
+					 u16 flags, struct netlink_ext_ack *extack)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->bridge_setlink(netdev, nlh, flags, extack);
+}
+
+static int nbl_dev_netdev_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
+					 struct net_device *netdev, u32 filter_mask, int nlflags)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->bridge_getlink(skb, pid, seq, netdev, filter_mask, nlflags);
+}
+
+static int nbl_dev_netdev_set_vf_link_state(struct net_device *netdev, int vf_id, int link_state)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->set_vf_link_state(netdev, vf_id, link_state);
+}
+
+static int nbl_dev_netdev_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->set_vf_mac(netdev, vf_id, mac);
+}
+
+static int
+nbl_dev_netdev_set_vf_rate(struct net_device *netdev, int vf_id, int min_rate, int max_rate)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->set_vf_rate(netdev, vf_id, min_rate, max_rate);
+}
+
+static int
+nbl_dev_netdev_set_vf_vlan(struct net_device *netdev, int vf_id, u16 vlan, u8 pri, __be16 proto)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->set_vf_vlan(netdev, vf_id, vlan, pri, proto);
+}
+
+static int
+nbl_dev_netdev_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->set_vf_trust(netdev, vf_id, trusted);
+}
+
+static int
+nbl_dev_netdev_get_vf_config(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->get_vf_config(netdev, vf_id, ivi);
+}
+
+static int
+nbl_dev_netdev_get_vf_stats(struct net_device *netdev, int vf_id, struct ifla_vf_stats *vf_stats)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->get_vf_stats(netdev, vf_id, vf_stats);
+}
+
+static u16
+nbl_dev_netdev_select_queue(struct net_device *netdev, struct sk_buff *skb,
+			    struct net_device *sb_dev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->select_queue(netdev, skb, sb_dev);
+}
+
+static int nbl_dev_netdev_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->change_mtu(netdev, new_mtu);
+}
+
+static int nbl_dev_ndo_get_phys_port_name(struct net_device *netdev, char *name, size_t len)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->get_phys_port_name(netdev, name, len);
+}
+
 static const struct net_device_ops netdev_ops_leonis_pf = {
 	.ndo_open = nbl_dev_netdev_open,
 	.ndo_stop = nbl_dev_netdev_stop,
 	.ndo_start_xmit = nbl_dev_start_xmit,
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
+	.ndo_set_rx_mode = nbl_dev_netdev_set_rx_mode,
+	.ndo_change_rx_flags = nbl_dev_netdev_change_rx_flags,
+	.ndo_set_mac_address = nbl_dev_netdev_set_mac,
 	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
+	.ndo_set_features = nbl_dev_netdev_set_features,
+	.ndo_features_check = nbl_dev_netdev_features_check,
+	.ndo_set_vf_spoofchk = nbl_dev_netdev_set_vf_spoofchk,
+	.ndo_tx_timeout = nbl_dev_netdev_tx_timeout,
+	.ndo_bridge_getlink = nbl_dev_netdev_bridge_getlink,
+	.ndo_bridge_setlink = nbl_dev_netdev_bridge_setlink,
+	.ndo_set_vf_link_state = nbl_dev_netdev_set_vf_link_state,
+	.ndo_set_vf_mac = nbl_dev_netdev_set_vf_mac,
+	.ndo_set_vf_rate = nbl_dev_netdev_set_vf_rate,
+	.ndo_get_vf_config = nbl_dev_netdev_get_vf_config,
+	.ndo_get_vf_stats = nbl_dev_netdev_get_vf_stats,
+	.ndo_select_queue = nbl_dev_netdev_select_queue,
+	.ndo_set_vf_vlan = nbl_dev_netdev_set_vf_vlan,
+	.ndo_set_vf_trust = nbl_dev_netdev_set_vf_trust,
+	.ndo_change_mtu = nbl_dev_netdev_change_mtu,
+	.ndo_get_phys_port_name = nbl_dev_ndo_get_phys_port_name,
 
 };
 
@@ -1434,9 +1637,15 @@ static const struct net_device_ops netdev_ops_leonis_vf = {
 	.ndo_start_xmit = nbl_dev_start_xmit,
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
+	.ndo_set_rx_mode = nbl_dev_netdev_set_rx_mode,
+	.ndo_set_mac_address = nbl_dev_netdev_set_mac,
 	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
-
+	.ndo_features_check = nbl_dev_netdev_features_check,
+	.ndo_tx_timeout = nbl_dev_netdev_tx_timeout,
+	.ndo_select_queue = nbl_dev_netdev_select_queue,
+	.ndo_change_mtu = nbl_dev_netdev_change_mtu,
+	.ndo_get_phys_port_name = nbl_dev_ndo_get_phys_port_name,
 };
 
 static int nbl_dev_setup_netops_leonis(void *priv, struct net_device *netdev,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
index 89d3cf0f1bd4..60d17b12e364 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
@@ -564,6 +564,36 @@ void nbl_serv_cpu_affinity_init(void *priv, u16 rings_num)
 	}
 }
 
+static int nbl_serv_ipv6_exthdr_num(struct sk_buff *skb, int start, u8 nexthdr)
+{
+	int exthdr_num = 0;
+	struct ipv6_opt_hdr _hdr, *hp;
+	unsigned int hdrlen;
+
+	while (ipv6_ext_hdr(nexthdr)) {
+		if (nexthdr == NEXTHDR_NONE)
+			return -1;
+
+		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
+		if (!hp)
+			return -1;
+
+		exthdr_num++;
+
+		if (nexthdr == NEXTHDR_FRAGMENT)
+			hdrlen = 8;
+		else if (nexthdr == NEXTHDR_AUTH)
+			hdrlen = ipv6_authlen(hp);
+		else
+			hdrlen = ipv6_optlen(hp);
+
+		nexthdr = hp->nexthdr;
+		start += hdrlen;
+	}
+
+	return exthdr_num;
+}
+
 static void nbl_serv_set_sfp_state(void *priv, struct net_device *netdev, u8 eth_id,
 				   bool open, bool is_force)
 {
@@ -1410,6 +1440,73 @@ static int nbl_serv_change_mtu(struct net_device *netdev, int new_mtu)
 	return 0;
 }
 
+static int nbl_serv_set_mac(struct net_device *dev, void *p)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(dev);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_vlan_node *vlan_node;
+	struct sockaddr *addr = p;
+	struct nbl_netdev_priv *priv = netdev_priv(dev);
+	int ret = 0;
+
+	if (!is_valid_ether_addr(addr->sa_data)) {
+		netdev_err(dev, "Temp to change a invalid mac address %pM\n", addr->sa_data);
+		return -EADDRNOTAVAIL;
+	}
+
+	if (ether_addr_equal(flow_mgt->mac, addr->sa_data))
+		return 0;
+
+	list_for_each_entry(vlan_node, &flow_mgt->vlan_list, node) {
+		if (!vlan_node->primary_mac_effective)
+			continue;
+		disp_ops->del_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), flow_mgt->mac,
+				      vlan_node->vid, priv->data_vsi);
+		ret = disp_ops->add_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), addr->sa_data,
+					    vlan_node->vid, priv->data_vsi);
+		if (ret) {
+			netdev_err(dev, "Fail to cfg macvlan on vid %u", vlan_node->vid);
+			goto fail;
+		}
+	}
+
+	if (flow_mgt->promisc & BIT(NBL_USER_FLOW)) {
+		disp_ops->del_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), flow_mgt->mac,
+				      0, priv->user_vsi);
+		ret = disp_ops->add_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), addr->sa_data,
+					    0, priv->user_vsi);
+		if (ret) {
+			netdev_err(dev, "Fail to cfg macvlan on vid %u for user", 0);
+			goto fail;
+		}
+	}
+
+	disp_ops->set_spoof_check_addr(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				       priv->data_vsi, addr->sa_data);
+
+	ether_addr_copy(flow_mgt->mac, addr->sa_data);
+	eth_hw_addr_set(dev, addr->sa_data);
+
+	if (!NBL_COMMON_TO_VF_CAP(common))
+		disp_ops->set_eth_mac_addr(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   addr->sa_data, NBL_COMMON_TO_ETH_ID(common));
+
+	return 0;
+fail:
+	list_for_each_entry(vlan_node, &flow_mgt->vlan_list, node) {
+		if (!vlan_node->primary_mac_effective)
+			continue;
+		disp_ops->del_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), addr->sa_data,
+				      vlan_node->vid, priv->data_vsi);
+		disp_ops->add_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), flow_mgt->mac,
+				      vlan_node->vid, priv->data_vsi);
+	}
+	return -EAGAIN;
+}
+
 static int nbl_serv_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 {
 	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(dev);
@@ -1752,6 +1849,195 @@ static void nbl_modify_promisc_mode(struct nbl_serv_net_resource_mgt *net_resour
 	rtnl_unlock();
 }
 
+static void nbl_serv_set_rx_mode(struct net_device *dev)
+{
+	struct nbl_adapter *adapter;
+	struct nbl_service_mgt *serv_mgt;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+
+	adapter = NBL_NETDEV_TO_ADAPTER(dev);
+	serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+
+	nbl_common_queue_work(&net_resource_mgt->rx_mode_async, false);
+}
+
+static void nbl_serv_change_rx_flags(struct net_device *dev, int flag)
+{
+	struct nbl_adapter *adapter;
+	struct nbl_service_mgt *serv_mgt;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+
+	adapter = NBL_NETDEV_TO_ADAPTER(dev);
+	serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+
+	nbl_common_queue_work(&net_resource_mgt->rx_mode_async, false);
+}
+
+static netdev_features_t
+nbl_serv_features_check(struct sk_buff *skb, struct net_device *dev, netdev_features_t features)
+{
+	u32 l2_l3_hrd_len = 0, l4_hrd_len = 0, total_hrd_len = 0;
+	u8 l4_proto = 0;
+	__be16 protocol, frag_off;
+	int ret;
+	unsigned char *exthdr;
+	unsigned int offset = 0;
+	int nexthdr = 0;
+	int exthdr_num = 0;
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
+	 * 256 bytes or bigger than 16383 bytes. If it is then we need to drop support for GSO.
+	 */
+	if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_size < NBL_TX_TSO_MSS_MIN ||
+				skb_shinfo(skb)->gso_size > NBL_TX_TSO_MSS_MAX))
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
+			ret = ipv6_skip_exthdr(skb, exthdr - skb->data, &l4_proto, &frag_off);
+			if (ret < 0)
+				goto out_rm_features;
+		}
+
+		/* IPV6 extension headers
+		 * (1) donot support routing and destination extension headers
+		 * (2) support 2 extension headers mostly
+		 */
+		nexthdr = ipv6_find_hdr(skb, &offset, NEXTHDR_ROUTING, NULL, NULL);
+		if (nexthdr == NEXTHDR_ROUTING) {
+			netdev_info(dev, "skb contain ipv6 routing ext header\n");
+			goto out_rm_features;
+		}
+
+		nexthdr = ipv6_find_hdr(skb, &offset, NEXTHDR_DEST, NULL, NULL);
+		if (nexthdr == NEXTHDR_DEST) {
+			netdev_info(dev, "skb contain ipv6 routing dest header\n");
+			goto out_rm_features;
+		}
+
+		exthdr_num = nbl_serv_ipv6_exthdr_num(skb, exthdr - skb->data, ip.v6->nexthdr);
+		if (exthdr_num < 0 || exthdr_num > 2) {
+			netdev_info(dev, "skb ipv6 exthdr_num:%d\n", exthdr_num);
+			goto out_rm_features;
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
+	return features & ~(NETIF_F_IP_CSUM |
+			    NETIF_F_IPV6_CSUM |
+			    NETIF_F_SCTP_CRC |
+			    NETIF_F_GSO_MASK);
+}
+
+static int nbl_serv_config_rxhash(void *priv, bool enable)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct device *dev = NBL_SERV_MGT_TO_DEV(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+	u32 rxfh_indir_size = 0;
+	u32 *indir = NULL;
+	int i = 0;
+
+	disp_ops->get_rxfh_indir_size(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				NBL_COMMON_TO_VSI_ID(common), &rxfh_indir_size);
+	indir = devm_kcalloc(dev, rxfh_indir_size, sizeof(u32), GFP_KERNEL);
+	if (!indir)
+		return -ENOMEM;
+	if (enable) {
+		if (ring_mgt->rss_indir_user) {
+			memcpy(indir, ring_mgt->rss_indir_user, rxfh_indir_size * sizeof(u32));
+		} else {
+			for (i = 0; i < rxfh_indir_size; i++)
+				indir[i] = i % vsi_info->active_ring_num;
+		}
+	}
+	disp_ops->set_rxfh_indir(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					NBL_COMMON_TO_VSI_ID(common),
+					indir, rxfh_indir_size);
+	devm_kfree(dev, indir);
+	return 0;
+}
+
+static int nbl_serv_set_features(struct net_device *netdev, netdev_features_t features)
+{
+	struct nbl_netdev_priv *priv = netdev_priv(netdev);
+	struct nbl_adapter *adapter = NBL_NETDEV_PRIV_TO_ADAPTER(priv);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	netdev_features_t changed = netdev->features ^ features;
+	bool enable = false;
+
+	if (changed & NETIF_F_RXHASH) {
+		enable = !!(features & NETIF_F_RXHASH);
+		nbl_serv_config_rxhash(serv_mgt, enable);
+	}
+
+	return 0;
+}
+
 static int nbl_serv_set_vf_mac(struct net_device *dev, int vf_id, u8 *mac)
 {
 	struct nbl_service_mgt *serv_mgt = NBL_NETDEV_TO_SERV_MGT(dev);
@@ -1987,6 +2273,31 @@ static int nbl_serv_set_vf_vlan(struct net_device *dev, int vf_id, u16 vlan, u8
 	return ret;
 }
 
+static int nbl_serv_get_vf_config(struct net_device *dev, int vf_id, struct ifla_vf_info *ivi)
+{
+	struct nbl_netdev_priv *priv = netdev_priv(dev);
+	struct nbl_adapter *adapter = NBL_NETDEV_PRIV_TO_ADAPTER(priv);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_serv_vf_info *vf_info = net_resource_mgt->vf_info;
+
+	if (vf_id >= net_resource_mgt->total_vfs || !net_resource_mgt->vf_info)
+		return -EINVAL;
+
+	ivi->vf = vf_id;
+	ivi->spoofchk = vf_info[vf_id].spoof_check;
+	ivi->linkstate = vf_info[vf_id].state;
+	ivi->max_tx_rate = vf_info[vf_id].max_tx_rate;
+	ivi->vlan = vf_info[vf_id].vlan;
+	ivi->vlan_proto = htons(vf_info[vf_id].vlan_proto);
+	ivi->qos = vf_info[vf_id].vlan_qos;
+	ivi->trusted = vf_info[vf_id].trusted;
+	ether_addr_copy(ivi->mac, vf_info[vf_id].mac);
+
+	return 0;
+}
+
 static int nbl_serv_get_vf_stats(struct net_device *dev, int vf_id, struct ifla_vf_stats *vf_stats)
 {
 	struct nbl_service_mgt *serv_mgt = NBL_NETDEV_TO_SERV_MGT(dev);
@@ -2021,6 +2332,98 @@ static int nbl_serv_get_vf_stats(struct net_device *dev, int vf_id, struct ifla_
 	return 0;
 }
 
+static u16
+nbl_serv_select_queue(struct net_device *netdev, struct sk_buff *skb,
+		      struct net_device *sb_dev)
+{
+	return netdev_pick_tx(netdev, skb, sb_dev);
+}
+
+static void nbl_serv_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+{
+	struct nbl_netdev_priv *priv = netdev_priv(netdev);
+	struct nbl_adapter *adapter = NBL_NETDEV_PRIV_TO_ADAPTER(priv);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+
+	ring_mgt->tx_rings[vsi_info->ring_offset + txqueue].need_recovery = true;
+	ring_mgt->tx_rings[vsi_info->ring_offset + txqueue].tx_timeout_count++;
+
+	nbl_warn(common, NBL_DEBUG_QUEUE, "TX timeout on queue %d", txqueue);
+
+	nbl_common_queue_work(&NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)->tx_timeout, false);
+}
+
+static int nbl_serv_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
+				   struct net_device *netdev, u32 filter_mask, int nlflags)
+{
+	struct nbl_netdev_priv *priv = netdev_priv(netdev);
+	struct nbl_adapter *adapter = NBL_NETDEV_PRIV_TO_ADAPTER(priv);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = serv_mgt->net_resource_mgt;
+	u16 bmode;
+
+	bmode = net_resource_mgt->bridge_mode;
+
+	return ndo_dflt_bridge_getlink(skb, pid, seq, netdev, bmode, 0, 0, nlflags,
+				       filter_mask, NULL);
+}
+
+static int nbl_serv_bridge_setlink(struct net_device *netdev, struct nlmsghdr *nlh,
+				   u16 flags, struct netlink_ext_ack *extack)
+{
+	struct nbl_netdev_priv *priv = netdev_priv(netdev);
+	struct nbl_adapter *adapter = NBL_NETDEV_PRIV_TO_ADAPTER(priv);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = serv_mgt->net_resource_mgt;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nlattr *attr, *br_spec;
+	u16 mode;
+	int ret, rem;
+
+	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+
+	nla_for_each_nested(attr, br_spec, rem) {
+		if (nla_type(attr) != IFLA_BRIDGE_MODE)
+			continue;
+
+		mode = nla_get_u16(attr);
+		if (mode != BRIDGE_MODE_VEPA && mode != BRIDGE_MODE_VEB)
+			return -EINVAL;
+
+		if (mode == net_resource_mgt->bridge_mode)
+			continue;
+
+		ret = disp_ops->set_bridge_mode(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), mode);
+		if (ret) {
+			netdev_info(netdev, "bridge_setlink failed 0x%x", ret);
+			return ret;
+		}
+
+		net_resource_mgt->bridge_mode = mode;
+	}
+
+	return 0;
+}
+
+static int nbl_serv_get_phys_port_name(struct net_device *dev, char *name, size_t len)
+{
+	struct nbl_common_info *common = NBL_NETDEV_TO_COMMON(dev);
+	u8 pf_id;
+
+	pf_id = common->eth_id;
+	if ((NBL_COMMON_TO_ETH_MODE(common) == NBL_TWO_ETHERNET_PORT) && common->eth_id == 2)
+		pf_id = 1;
+
+	if (snprintf(name, len, "p%u", pf_id) >= len)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 static int nbl_serv_register_net(void *priv, struct nbl_register_net_param *register_param,
 				 struct nbl_register_net_result *register_result)
 {
@@ -4256,11 +4659,27 @@ static struct nbl_service_ops serv_ops = {
 	.netdev_open = nbl_serv_netdev_open,
 	.netdev_stop = nbl_serv_netdev_stop,
 	.change_mtu = nbl_serv_change_mtu,
-
+	.set_mac = nbl_serv_set_mac,
 	.rx_add_vid = nbl_serv_rx_add_vid,
 	.rx_kill_vid = nbl_serv_rx_kill_vid,
 	.get_stats64 = nbl_serv_get_stats64,
-
+	.set_rx_mode = nbl_serv_set_rx_mode,
+	.change_rx_flags = nbl_serv_change_rx_flags,
+	.set_features = nbl_serv_set_features,
+	.features_check = nbl_serv_features_check,
+	.get_phys_port_name = nbl_serv_get_phys_port_name,
+	.tx_timeout = nbl_serv_tx_timeout,
+	.bridge_setlink = nbl_serv_bridge_setlink,
+	.bridge_getlink = nbl_serv_bridge_getlink,
+	.set_vf_spoofchk = nbl_serv_set_vf_spoofchk,
+	.set_vf_link_state = nbl_serv_set_vf_link_state,
+	.set_vf_mac = nbl_serv_set_vf_mac,
+	.set_vf_rate = nbl_serv_set_vf_rate,
+	.set_vf_vlan = nbl_serv_set_vf_vlan,
+	.get_vf_config = nbl_serv_get_vf_config,
+	.get_vf_stats = nbl_serv_get_vf_stats,
+	.select_queue = nbl_serv_select_queue,
+	.set_vf_trust = nbl_serv_set_vf_trust,
 	.get_rep_queue_info = nbl_serv_get_rep_queue_info,
 	.get_user_queue_info = nbl_serv_get_user_queue_info,
 
-- 
2.43.0


