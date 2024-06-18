Return-Path: <netdev+bounces-104450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FBA90C92B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3C72865B4
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135D513AA2F;
	Tue, 18 Jun 2024 10:18:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DA2B9B6
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705911; cv=none; b=NwYxdWGBGydnVZ06H++9qXHbbqgSHU+pSpYmmfCOL81ZGbtppESZ0Z8noCWKdSlpZwyW7qm/lMYsAFs2osLVb38hotuSDfM0ifGGqCtgAaQPqtSv+SgMzr6syodwY3rRON2zXaJgi+8ZfV52M6QMeOQrEXXhFtf2qejuPR+csL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705911; c=relaxed/simple;
	bh=9oZkQ78A9AwDOshKtuF3na/OoAE5qzJPp9VSkV0sd/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mhlQS7U3DodLy63XiyP3Knje5cAlw4P8yPidw83aQaGf/9wknbOC+qhmcOtdx4jhtiWvwKKV/lm8Z+hC4pz3/iXHvXxiRPaMs9dIH58m8pbJLDUshivZnUp9k1UO2vfLI5REfS05ha/sWmpn4XHh5c8lb2O+u0ktDgkZ314OaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz9t1718705781t4f96ge
X-QQ-Originating-IP: v5fNjv/Sali6IKI7VHgaXiRzEcVwnH3dnSBAiet+GKA=
Received: from lap-jiawenwu.trustnetic.com ( [183.159.97.141])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Jun 2024 18:16:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11873391748809433812
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	dumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	rmk+kernel@armlinux.org.uk,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 2/3] net: txgbe: support Flow Director perfect filters
Date: Tue, 18 Jun 2024 18:16:08 +0800
Message-Id: <20240618101609.3580-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240618101609.3580-1-jiawenwu@trustnetic.com>
References: <20240618101609.3580-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Support the addition and deletion of Flow Director filters.

Supported fields: src-ip, dst-ip, src-port, dst-port
Supported flow-types: tcp4, udp4, sctp4, ipv4

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  31 ++
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 427 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.c   | 343 +++++++++++++-
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.h   |  10 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   9 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  26 ++
 6 files changed, 845 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 6fbdbb6c9bb5..ac0e1d42fe55 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2705,6 +2705,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 {
 	netdev_features_t changed = netdev->features ^ features;
 	struct wx *wx = netdev_priv(netdev);
+	bool need_reset = false;
 
 	if (features & NETIF_F_RXHASH) {
 		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN,
@@ -2722,6 +2723,36 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
 
+	if (!(test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)))
+		return 0;
+
+	/* Check if Flow Director n-tuple support was enabled or disabled.  If
+	 * the state changed, we need to reset.
+	 */
+	switch (features & NETIF_F_NTUPLE) {
+	case NETIF_F_NTUPLE:
+		/* turn off ATR, enable perfect filters and reset */
+		if (!(test_and_set_bit(WX_FLAG_FDIR_PERFECT, wx->flags)))
+			need_reset = true;
+
+		clear_bit(WX_FLAG_FDIR_HASH, wx->flags);
+		break;
+	default:
+		/* turn off perfect filters, enable ATR and reset */
+		if (test_and_clear_bit(WX_FLAG_FDIR_PERFECT, wx->flags))
+			need_reset = true;
+
+		/* We cannot enable ATR if RSS is disabled */
+		if (wx->ring_feature[RING_F_RSS].limit <= 1)
+			break;
+
+		set_bit(WX_FLAG_FDIR_HASH, wx->flags);
+		break;
+	}
+
+	if (need_reset)
+		wx->do_reset(netdev);
+
 	return 0;
 }
 EXPORT_SYMBOL(wx_set_features);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 31fde3fa7c6b..d98314b26c19 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -9,6 +9,7 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
 #include "txgbe_type.h"
+#include "txgbe_fdir.h"
 #include "txgbe_ethtool.h"
 
 static int txgbe_set_ringparam(struct net_device *netdev,
@@ -79,6 +80,430 @@ static int txgbe_set_channels(struct net_device *dev,
 	return txgbe_setup_tc(dev, netdev_get_num_tc(dev));
 }
 
+static int txgbe_get_ethtool_fdir_entry(struct txgbe *txgbe,
+					struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fsp =
+		(struct ethtool_rx_flow_spec *)&cmd->fs;
+	union txgbe_atr_input *mask = &txgbe->fdir_mask;
+	struct txgbe_fdir_filter *rule = NULL;
+	struct hlist_node *node;
+
+	/* report total rule count */
+	cmd->data = (1024 << TXGBE_FDIR_PBALLOC_64K) - 2;
+
+	hlist_for_each_entry_safe(rule, node, &txgbe->fdir_filter_list,
+				  fdir_node) {
+		if (fsp->location <= rule->sw_idx)
+			break;
+	}
+
+	if (!rule || fsp->location != rule->sw_idx)
+		return -EINVAL;
+
+	/* set flow type field */
+	switch (rule->filter.formatted.flow_type) {
+	case TXGBE_ATR_FLOW_TYPE_TCPV4:
+		fsp->flow_type = TCP_V4_FLOW;
+		break;
+	case TXGBE_ATR_FLOW_TYPE_UDPV4:
+		fsp->flow_type = UDP_V4_FLOW;
+		break;
+	case TXGBE_ATR_FLOW_TYPE_SCTPV4:
+		fsp->flow_type = SCTP_V4_FLOW;
+		break;
+	case TXGBE_ATR_FLOW_TYPE_IPV4:
+		fsp->flow_type = IP_USER_FLOW;
+		fsp->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
+		fsp->h_u.usr_ip4_spec.proto = 0;
+		fsp->m_u.usr_ip4_spec.proto = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	fsp->h_u.tcp_ip4_spec.psrc = rule->filter.formatted.src_port;
+	fsp->m_u.tcp_ip4_spec.psrc = mask->formatted.src_port;
+	fsp->h_u.tcp_ip4_spec.pdst = rule->filter.formatted.dst_port;
+	fsp->m_u.tcp_ip4_spec.pdst = mask->formatted.dst_port;
+	fsp->h_u.tcp_ip4_spec.ip4src = rule->filter.formatted.src_ip[0];
+	fsp->m_u.tcp_ip4_spec.ip4src = mask->formatted.src_ip[0];
+	fsp->h_u.tcp_ip4_spec.ip4dst = rule->filter.formatted.dst_ip[0];
+	fsp->m_u.tcp_ip4_spec.ip4dst = mask->formatted.dst_ip[0];
+	fsp->h_ext.vlan_etype = rule->filter.formatted.flex_bytes;
+	fsp->m_ext.vlan_etype = mask->formatted.flex_bytes;
+	fsp->h_ext.data[1] = htonl(rule->filter.formatted.vm_pool);
+	fsp->m_ext.data[1] = htonl(mask->formatted.vm_pool);
+	fsp->flow_type |= FLOW_EXT;
+
+	/* record action */
+	if (rule->action == TXGBE_RDB_FDIR_DROP_QUEUE)
+		fsp->ring_cookie = RX_CLS_FLOW_DISC;
+	else
+		fsp->ring_cookie = rule->action;
+
+	return 0;
+}
+
+static int txgbe_get_ethtool_fdir_all(struct txgbe *txgbe,
+				      struct ethtool_rxnfc *cmd,
+				      u32 *rule_locs)
+{
+	struct txgbe_fdir_filter *rule;
+	struct hlist_node *node;
+	int cnt = 0;
+
+	/* report total rule count */
+	cmd->data = (1024 << TXGBE_FDIR_PBALLOC_64K) - 2;
+
+	hlist_for_each_entry_safe(rule, node, &txgbe->fdir_filter_list,
+				  fdir_node) {
+		if (cnt == cmd->rule_cnt)
+			return -EMSGSIZE;
+		rule_locs[cnt] = rule->sw_idx;
+		cnt++;
+	}
+
+	cmd->rule_cnt = cnt;
+
+	return 0;
+}
+
+static int txgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
+			   u32 *rule_locs)
+{
+	struct wx *wx = netdev_priv(dev);
+	struct txgbe *txgbe = wx->priv;
+	int ret = -EOPNOTSUPP;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_GRXRINGS:
+		cmd->data = wx->num_rx_queues;
+		ret = 0;
+		break;
+	case ETHTOOL_GRXCLSRLCNT:
+		cmd->rule_cnt = txgbe->fdir_filter_count;
+		ret = 0;
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		ret = txgbe_get_ethtool_fdir_entry(txgbe, cmd);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		ret = txgbe_get_ethtool_fdir_all(txgbe, cmd, (u32 *)rule_locs);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int txgbe_flowspec_to_flow_type(struct ethtool_rx_flow_spec *fsp,
+				       u8 *flow_type)
+{
+	switch (fsp->flow_type & ~FLOW_EXT) {
+	case TCP_V4_FLOW:
+		*flow_type = TXGBE_ATR_FLOW_TYPE_TCPV4;
+		break;
+	case UDP_V4_FLOW:
+		*flow_type = TXGBE_ATR_FLOW_TYPE_UDPV4;
+		break;
+	case SCTP_V4_FLOW:
+		*flow_type = TXGBE_ATR_FLOW_TYPE_SCTPV4;
+		break;
+	case IP_USER_FLOW:
+		switch (fsp->h_u.usr_ip4_spec.proto) {
+		case IPPROTO_TCP:
+			*flow_type = TXGBE_ATR_FLOW_TYPE_TCPV4;
+			break;
+		case IPPROTO_UDP:
+			*flow_type = TXGBE_ATR_FLOW_TYPE_UDPV4;
+			break;
+		case IPPROTO_SCTP:
+			*flow_type = TXGBE_ATR_FLOW_TYPE_SCTPV4;
+			break;
+		case 0:
+			if (!fsp->m_u.usr_ip4_spec.proto) {
+				*flow_type = TXGBE_ATR_FLOW_TYPE_IPV4;
+				break;
+			}
+			fallthrough;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool txgbe_match_ethtool_fdir_entry(struct txgbe *txgbe,
+					   struct txgbe_fdir_filter *input)
+{
+	struct txgbe_fdir_filter *rule = NULL;
+	struct hlist_node *node2;
+
+	hlist_for_each_entry_safe(rule, node2, &txgbe->fdir_filter_list,
+				  fdir_node) {
+		if (rule->filter.formatted.bkt_hash ==
+		    input->filter.formatted.bkt_hash &&
+		    rule->action == input->action) {
+			wx_dbg(txgbe->wx, "FDIR entry already exist\n");
+			return true;
+		}
+	}
+	return false;
+}
+
+static int txgbe_update_ethtool_fdir_entry(struct txgbe *txgbe,
+					   struct txgbe_fdir_filter *input,
+					   u16 sw_idx)
+{
+	struct hlist_node *node = NULL, *parent = NULL;
+	struct txgbe_fdir_filter *rule;
+	struct wx *wx = txgbe->wx;
+	bool deleted = false;
+	int err;
+
+	hlist_for_each_entry_safe(rule, node, &txgbe->fdir_filter_list,
+				  fdir_node) {
+		/* hash found, or no matching entry */
+		if (rule->sw_idx >= sw_idx)
+			break;
+		parent = node;
+	}
+
+	/* if there is an old rule occupying our place remove it */
+	if (rule && rule->sw_idx == sw_idx) {
+		/* hardware filters are only configured when interface is up,
+		 * and we should not issue filter commands while the interface
+		 * is down
+		 */
+		if (netif_running(wx->netdev) &&
+		    (!input || rule->filter.formatted.bkt_hash !=
+		     input->filter.formatted.bkt_hash)) {
+			err = txgbe_fdir_erase_perfect_filter(wx,
+							      &rule->filter,
+							      sw_idx);
+			if (err)
+				return -EINVAL;
+		}
+
+		hlist_del(&rule->fdir_node);
+		kfree(rule);
+		txgbe->fdir_filter_count--;
+		deleted = true;
+	}
+
+	/* If we weren't given an input, then this was a request to delete a
+	 * filter. We should return -EINVAL if the filter wasn't found, but
+	 * return 0 if the rule was successfully deleted.
+	 */
+	if (!input)
+		return deleted ? 0 : -EINVAL;
+
+	/* initialize node and set software index */
+	INIT_HLIST_NODE(&input->fdir_node);
+
+	/* add filter to the list */
+	if (parent)
+		hlist_add_behind(&input->fdir_node, parent);
+	else
+		hlist_add_head(&input->fdir_node,
+			       &txgbe->fdir_filter_list);
+
+	/* update counts */
+	txgbe->fdir_filter_count++;
+
+	return 0;
+}
+
+static int txgbe_add_ethtool_fdir_entry(struct txgbe *txgbe,
+					struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fsp =
+		(struct ethtool_rx_flow_spec *)&cmd->fs;
+	struct txgbe_fdir_filter *input;
+	union txgbe_atr_input mask;
+	struct wx *wx = txgbe->wx;
+	int err = -EINVAL;
+	u16 ptype = 0;
+	u8 queue;
+
+	if (!(test_bit(WX_FLAG_FDIR_PERFECT, wx->flags)))
+		return -EOPNOTSUPP;
+
+	/* ring_cookie is a masked into a set of queues and txgbe pools or
+	 * we use drop index
+	 */
+	if (fsp->ring_cookie == RX_CLS_FLOW_DISC) {
+		queue = TXGBE_RDB_FDIR_DROP_QUEUE;
+	} else {
+		u32 ring = ethtool_get_flow_spec_ring(fsp->ring_cookie);
+
+		if (ring >= wx->num_rx_queues)
+			return -EINVAL;
+
+		/* Map the ring onto the absolute queue index */
+		queue = wx->rx_ring[ring]->reg_idx;
+	}
+
+	/* Don't allow indexes to exist outside of available space */
+	if (fsp->location >= ((1024 << TXGBE_FDIR_PBALLOC_64K) - 2)) {
+		wx_err(wx, "Location out of range\n");
+		return -EINVAL;
+	}
+
+	input = kzalloc(sizeof(*input), GFP_ATOMIC);
+	if (!input)
+		return -ENOMEM;
+
+	memset(&mask, 0, sizeof(union txgbe_atr_input));
+
+	/* set SW index */
+	input->sw_idx = fsp->location;
+
+	/* record flow type */
+	if (txgbe_flowspec_to_flow_type(fsp,
+					&input->filter.formatted.flow_type)) {
+		wx_err(wx, "Unrecognized flow type\n");
+		goto err_out;
+	}
+
+	mask.formatted.flow_type = TXGBE_ATR_L4TYPE_IPV6_MASK |
+				   TXGBE_ATR_L4TYPE_MASK;
+
+	if (input->filter.formatted.flow_type == TXGBE_ATR_FLOW_TYPE_IPV4)
+		mask.formatted.flow_type &= TXGBE_ATR_L4TYPE_IPV6_MASK;
+
+	/* Copy input into formatted structures */
+	input->filter.formatted.src_ip[0] = fsp->h_u.tcp_ip4_spec.ip4src;
+	mask.formatted.src_ip[0] = fsp->m_u.tcp_ip4_spec.ip4src;
+	input->filter.formatted.dst_ip[0] = fsp->h_u.tcp_ip4_spec.ip4dst;
+	mask.formatted.dst_ip[0] = fsp->m_u.tcp_ip4_spec.ip4dst;
+	input->filter.formatted.src_port = fsp->h_u.tcp_ip4_spec.psrc;
+	mask.formatted.src_port = fsp->m_u.tcp_ip4_spec.psrc;
+	input->filter.formatted.dst_port = fsp->h_u.tcp_ip4_spec.pdst;
+	mask.formatted.dst_port = fsp->m_u.tcp_ip4_spec.pdst;
+
+	if (fsp->flow_type & FLOW_EXT) {
+		input->filter.formatted.vm_pool =
+				(unsigned char)ntohl(fsp->h_ext.data[1]);
+		mask.formatted.vm_pool =
+				(unsigned char)ntohl(fsp->m_ext.data[1]);
+		input->filter.formatted.flex_bytes =
+						fsp->h_ext.vlan_etype;
+		mask.formatted.flex_bytes = fsp->m_ext.vlan_etype;
+	}
+
+	switch (input->filter.formatted.flow_type) {
+	case TXGBE_ATR_FLOW_TYPE_TCPV4:
+		ptype = WX_PTYPE_L2_IPV4_TCP;
+		break;
+	case TXGBE_ATR_FLOW_TYPE_UDPV4:
+		ptype = WX_PTYPE_L2_IPV4_UDP;
+		break;
+	case TXGBE_ATR_FLOW_TYPE_SCTPV4:
+		ptype = WX_PTYPE_L2_IPV4_SCTP;
+		break;
+	case TXGBE_ATR_FLOW_TYPE_IPV4:
+		ptype = WX_PTYPE_L2_IPV4;
+		break;
+	default:
+		break;
+	}
+
+	input->filter.formatted.vlan_id = htons(ptype);
+	if (mask.formatted.flow_type & TXGBE_ATR_L4TYPE_MASK)
+		mask.formatted.vlan_id = htons(0xFFFF);
+	else
+		mask.formatted.vlan_id = htons(0xFFF8);
+
+	/* determine if we need to drop or route the packet */
+	if (fsp->ring_cookie == RX_CLS_FLOW_DISC)
+		input->action = TXGBE_RDB_FDIR_DROP_QUEUE;
+	else
+		input->action = fsp->ring_cookie;
+
+	spin_lock(&txgbe->fdir_perfect_lock);
+
+	if (hlist_empty(&txgbe->fdir_filter_list)) {
+		/* save mask and program input mask into HW */
+		memcpy(&txgbe->fdir_mask, &mask, sizeof(mask));
+		err = txgbe_fdir_set_input_mask(wx, &mask);
+		if (err)
+			goto err_unlock;
+	} else if (memcmp(&txgbe->fdir_mask, &mask, sizeof(mask))) {
+		wx_err(wx, "Hardware only supports one mask per port. To change the mask you must first delete all the rules.\n");
+		goto err_unlock;
+	}
+
+	/* apply mask and compute/store hash */
+	txgbe_atr_compute_perfect_hash(&input->filter, &mask);
+
+	/* check if new entry does not exist on filter list */
+	if (txgbe_match_ethtool_fdir_entry(txgbe, input))
+		goto err_unlock;
+
+	/* only program filters to hardware if the net device is running, as
+	 * we store the filters in the Rx buffer which is not allocated when
+	 * the device is down
+	 */
+	if (netif_running(wx->netdev)) {
+		err = txgbe_fdir_write_perfect_filter(wx, &input->filter,
+						      input->sw_idx, queue);
+		if (err)
+			goto err_unlock;
+	}
+
+	txgbe_update_ethtool_fdir_entry(txgbe, input, input->sw_idx);
+
+	spin_unlock(&txgbe->fdir_perfect_lock);
+
+	return 0;
+err_unlock:
+	spin_unlock(&txgbe->fdir_perfect_lock);
+err_out:
+	kfree(input);
+	return err;
+}
+
+static int txgbe_del_ethtool_fdir_entry(struct txgbe *txgbe,
+					struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fsp =
+		(struct ethtool_rx_flow_spec *)&cmd->fs;
+	int err = 0;
+
+	spin_lock(&txgbe->fdir_perfect_lock);
+	err = txgbe_update_ethtool_fdir_entry(txgbe, NULL, fsp->location);
+	spin_unlock(&txgbe->fdir_perfect_lock);
+
+	return err;
+}
+
+static int txgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
+{
+	struct wx *wx = netdev_priv(dev);
+	struct txgbe *txgbe = wx->priv;
+	int ret = -EOPNOTSUPP;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_SRXCLSRLINS:
+		ret = txgbe_add_ethtool_fdir_entry(txgbe, cmd);
+		break;
+	case ETHTOOL_SRXCLSRLDEL:
+		ret = txgbe_del_ethtool_fdir_entry(txgbe, cmd);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static const struct ethtool_ops txgbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
@@ -100,6 +525,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
 	.set_channels		= txgbe_set_channels,
+	.get_rxnfc		= txgbe_get_rxnfc,
+	.set_rxnfc		= txgbe_set_rxnfc,
 	.get_msglevel		= wx_get_msglevel,
 	.set_msglevel		= wx_set_msglevel,
 };
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
index 6158209e84cb..ef50efbaec0f 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
@@ -90,6 +90,71 @@ static void txgbe_atr_compute_sig_hash(union txgbe_atr_hash_dword input,
 	*hash = sig_hash ^ bucket_hash;
 }
 
+#define TXGBE_COMPUTE_BKT_HASH_ITERATION(_n) \
+do { \
+	u32 n = (_n); \
+	if (TXGBE_ATR_BUCKET_HASH_KEY & (0x01 << n)) \
+		bucket_hash ^= lo_hash_dword >> n; \
+	if (TXGBE_ATR_BUCKET_HASH_KEY & (0x01 << (n + 16))) \
+		bucket_hash ^= hi_hash_dword >> n; \
+} while (0)
+
+/**
+ *  txgbe_atr_compute_perfect_hash - Compute the perfect filter hash
+ *  @input: input bitstream to compute the hash on
+ *  @input_mask: mask for the input bitstream
+ *
+ *  This function serves two main purposes.  First it applies the input_mask
+ *  to the atr_input resulting in a cleaned up atr_input data stream.
+ *  Secondly it computes the hash and stores it in the bkt_hash field at
+ *  the end of the input byte stream.  This way it will be available for
+ *  future use without needing to recompute the hash.
+ **/
+void txgbe_atr_compute_perfect_hash(union txgbe_atr_input *input,
+				    union txgbe_atr_input *input_mask)
+{
+	u32 hi_hash_dword, lo_hash_dword, flow_vm_vlan;
+	u32 bucket_hash = 0;
+	__be32 hi_dword = 0;
+	u32 i = 0;
+
+	/* Apply masks to input data */
+	for (i = 0; i < 11; i++)
+		input->dword_stream[i] &= input_mask->dword_stream[i];
+
+	/* record the flow_vm_vlan bits as they are a key part to the hash */
+	flow_vm_vlan = ntohl(input->dword_stream[0]);
+
+	/* generate common hash dword */
+	for (i = 1; i <= 10; i++)
+		hi_dword ^= input->dword_stream[i];
+	hi_hash_dword = ntohl(hi_dword);
+
+	/* low dword is word swapped version of common */
+	lo_hash_dword = (hi_hash_dword >> 16) | (hi_hash_dword << 16);
+
+	/* apply flow ID/VM pool/VLAN ID bits to hash words */
+	hi_hash_dword ^= flow_vm_vlan ^ (flow_vm_vlan >> 16);
+
+	/* Process bits 0 and 16 */
+	TXGBE_COMPUTE_BKT_HASH_ITERATION(0);
+
+	/* apply flow ID/VM pool/VLAN ID bits to lo hash dword, we had to
+	 * delay this because bit 0 of the stream should not be processed
+	 * so we do not add the VLAN until after bit 0 was processed
+	 */
+	lo_hash_dword ^= flow_vm_vlan ^ (flow_vm_vlan << 16);
+
+	/* Process remaining 30 bit of the key */
+	for (i = 1; i <= 15; i++)
+		TXGBE_COMPUTE_BKT_HASH_ITERATION(i);
+
+	/* Limit hash to 13 bits since max bucket count is 8K.
+	 * Store result at the end of the input stream.
+	 */
+	input->formatted.bkt_hash = (__force __be16)(bucket_hash & 0x1FFF);
+}
+
 static int txgbe_fdir_check_cmd_complete(struct wx *wx)
 {
 	u32 val;
@@ -239,6 +304,188 @@ void txgbe_atr(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype)
 					ring->queue_index);
 }
 
+int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
+{
+	u32 fdirm = 0, fdirtcpm = 0, flex = 0;
+
+	/* Program the relevant mask registers. If src/dst_port or src/dst_addr
+	 * are zero, then assume a full mask for that field.  Also assume that
+	 * a VLAN of 0 is unspecified, so mask that out as well.  L4type
+	 * cannot be masked out in this implementation.
+	 *
+	 * This also assumes IPv4 only.  IPv6 masking isn't supported at this
+	 * point in time.
+	 */
+
+	/* verify bucket hash is cleared on hash generation */
+	if (input_mask->formatted.bkt_hash)
+		wx_dbg(wx, "bucket hash should always be 0 in mask\n");
+
+	/* Program FDIRM and verify partial masks */
+	switch (input_mask->formatted.vm_pool & 0x7F) {
+	case 0x0:
+		fdirm |= TXGBE_RDB_FDIR_OTHER_MSK_POOL;
+		break;
+	case 0x7F:
+		break;
+	default:
+		wx_err(wx, "Error on vm pool mask\n");
+		return -EINVAL;
+	}
+
+	switch (input_mask->formatted.flow_type & TXGBE_ATR_L4TYPE_MASK) {
+	case 0x0:
+		fdirm |= TXGBE_RDB_FDIR_OTHER_MSK_L4P;
+		if (input_mask->formatted.dst_port ||
+		    input_mask->formatted.src_port) {
+			wx_err(wx, "Error on src/dst port mask\n");
+			return -EINVAL;
+		}
+		break;
+	case TXGBE_ATR_L4TYPE_MASK:
+		break;
+	default:
+		wx_err(wx, "Error on flow type mask\n");
+		return -EINVAL;
+	}
+
+	/* Now mask VM pool and destination IPv6 - bits 5 and 2 */
+	wr32(wx, TXGBE_RDB_FDIR_OTHER_MSK, fdirm);
+
+	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0));
+	flex &= ~TXGBE_RDB_FDIR_FLEX_CFG_FIELD0;
+	flex |= (TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC |
+		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6));
+
+	switch ((__force u16)input_mask->formatted.flex_bytes & 0xFFFF) {
+	case 0x0000:
+		/* Mask Flex Bytes */
+		flex |= TXGBE_RDB_FDIR_FLEX_CFG_MSK;
+		break;
+	case 0xFFFF:
+		break;
+	default:
+		wx_err(wx, "Error on flexible byte mask\n");
+		return -EINVAL;
+	}
+	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0), flex);
+
+	/* store the TCP/UDP port masks, bit reversed from port layout */
+	fdirtcpm = ntohs(input_mask->formatted.dst_port);
+	fdirtcpm <<= TXGBE_RDB_FDIR_PORT_DESTINATION_SHIFT;
+	fdirtcpm |= ntohs(input_mask->formatted.src_port);
+
+	/* write both the same so that UDP and TCP use the same mask */
+	wr32(wx, TXGBE_RDB_FDIR_TCP_MSK, ~fdirtcpm);
+	wr32(wx, TXGBE_RDB_FDIR_UDP_MSK, ~fdirtcpm);
+	wr32(wx, TXGBE_RDB_FDIR_SCTP_MSK, ~fdirtcpm);
+
+	/* store source and destination IP masks (little-enian) */
+	wr32(wx, TXGBE_RDB_FDIR_SA4_MSK,
+	     ntohl(~input_mask->formatted.src_ip[0]));
+	wr32(wx, TXGBE_RDB_FDIR_DA4_MSK,
+	     ntohl(~input_mask->formatted.dst_ip[0]));
+
+	return 0;
+}
+
+int txgbe_fdir_write_perfect_filter(struct wx *wx,
+				    union txgbe_atr_input *input,
+				    u16 soft_id, u8 queue)
+{
+	u32 fdirport, fdirvlan, fdirhash, fdircmd;
+	int err = 0;
+
+	/* currently IPv6 is not supported, must be programmed with 0 */
+	wr32(wx, TXGBE_RDB_FDIR_IP6(2), ntohl(input->formatted.src_ip[0]));
+	wr32(wx, TXGBE_RDB_FDIR_IP6(1), ntohl(input->formatted.src_ip[1]));
+	wr32(wx, TXGBE_RDB_FDIR_IP6(0), ntohl(input->formatted.src_ip[2]));
+
+	/* record the source address (little-endian) */
+	wr32(wx, TXGBE_RDB_FDIR_SA, ntohl(input->formatted.src_ip[0]));
+
+	/* record the first 32 bits of the destination address
+	 * (little-endian)
+	 */
+	wr32(wx, TXGBE_RDB_FDIR_DA, ntohl(input->formatted.dst_ip[0]));
+
+	/* record source and destination port (little-endian)*/
+	fdirport = ntohs(input->formatted.dst_port);
+	fdirport <<= TXGBE_RDB_FDIR_PORT_DESTINATION_SHIFT;
+	fdirport |= ntohs(input->formatted.src_port);
+	wr32(wx, TXGBE_RDB_FDIR_PORT, fdirport);
+
+	/* record packet type and flex_bytes (little-endian) */
+	fdirvlan = ntohs(input->formatted.flex_bytes);
+	fdirvlan <<= TXGBE_RDB_FDIR_FLEX_FLEX_SHIFT;
+	fdirvlan |= ntohs(input->formatted.vlan_id);
+	wr32(wx, TXGBE_RDB_FDIR_FLEX, fdirvlan);
+
+	/* configure FDIRHASH register */
+	fdirhash = (__force u32)input->formatted.bkt_hash |
+		   TXGBE_RDB_FDIR_HASH_BUCKET_VALID |
+		   TXGBE_RDB_FDIR_HASH_SIG_SW_INDEX(soft_id);
+	wr32(wx, TXGBE_RDB_FDIR_HASH, fdirhash);
+
+	/* flush all previous writes to make certain registers are
+	 * programmed prior to issuing the command
+	 */
+	WX_WRITE_FLUSH(wx);
+
+	/* configure FDIRCMD register */
+	fdircmd = TXGBE_RDB_FDIR_CMD_CMD_ADD_FLOW |
+		  TXGBE_RDB_FDIR_CMD_FILTER_UPDATE |
+		  TXGBE_RDB_FDIR_CMD_LAST | TXGBE_RDB_FDIR_CMD_QUEUE_EN;
+	if (queue == TXGBE_RDB_FDIR_DROP_QUEUE)
+		fdircmd |= TXGBE_RDB_FDIR_CMD_DROP;
+	fdircmd |= TXGBE_RDB_FDIR_CMD_FLOW_TYPE(input->formatted.flow_type);
+	fdircmd |= TXGBE_RDB_FDIR_CMD_RX_QUEUE(queue);
+	fdircmd |= TXGBE_RDB_FDIR_CMD_VT_POOL(input->formatted.vm_pool);
+
+	wr32(wx, TXGBE_RDB_FDIR_CMD, fdircmd);
+	err = txgbe_fdir_check_cmd_complete(wx);
+	if (err)
+		wx_err(wx, "Flow Director command did not complete!\n");
+
+	return err;
+}
+
+int txgbe_fdir_erase_perfect_filter(struct wx *wx,
+				    union txgbe_atr_input *input,
+				    u16 soft_id)
+{
+	u32 fdirhash, fdircmd;
+	int err = 0;
+
+	/* configure FDIRHASH register */
+	fdirhash = (__force u32)input->formatted.bkt_hash;
+	fdirhash |= TXGBE_RDB_FDIR_HASH_SIG_SW_INDEX(soft_id);
+	wr32(wx, TXGBE_RDB_FDIR_HASH, fdirhash);
+
+	/* flush hash to HW */
+	WX_WRITE_FLUSH(wx);
+
+	/* Query if filter is present */
+	wr32(wx, TXGBE_RDB_FDIR_CMD, TXGBE_RDB_FDIR_CMD_CMD_QUERY_REM_FILT);
+
+	err = txgbe_fdir_check_cmd_complete(wx);
+	if (err) {
+		wx_err(wx, "Flow Director command did not complete!\n");
+		return err;
+	}
+
+	fdircmd = rd32(wx, TXGBE_RDB_FDIR_CMD);
+	/* if filter exists in hardware then remove it */
+	if (fdircmd & TXGBE_RDB_FDIR_CMD_FILTER_VALID) {
+		wr32(wx, TXGBE_RDB_FDIR_HASH, fdirhash);
+		WX_WRITE_FLUSH(wx);
+		wr32(wx, TXGBE_RDB_FDIR_CMD,
+		     TXGBE_RDB_FDIR_CMD_CMD_REMOVE_FLOW);
+	}
+
+	return 0;
+}
+
 /**
  *  txgbe_fdir_enable - Initialize Flow Director control registers
  *  @wx: pointer to hardware structure
@@ -291,12 +538,106 @@ static void txgbe_init_fdir_signature(struct wx *wx)
 	txgbe_fdir_enable(wx, fdirctrl);
 }
 
+/**
+ *  txgbe_init_fdir_perfect - Initialize Flow Director perfect filters
+ *  @wx: pointer to hardware structure
+ **/
+static void txgbe_init_fdir_perfect(struct wx *wx)
+{
+	u32 fdirctrl = TXGBE_FDIR_PBALLOC_64K;
+
+	/* Continue setup of fdirctrl register bits:
+	 *  Turn perfect match filtering on
+	 *  Report hash in RSS field of Rx wb descriptor
+	 *  Initialize the drop queue
+	 *  Move the flexible bytes to use the ethertype - shift 6 words
+	 *  Set the maximum length per hash bucket to 0xA filters
+	 *  Send interrupt when 64 (0x4 * 16) filters are left
+	 */
+	fdirctrl |= TXGBE_RDB_FDIR_CTL_PERFECT_MATCH |
+		    TXGBE_RDB_FDIR_CTL_DROP_Q(TXGBE_RDB_FDIR_DROP_QUEUE) |
+		    TXGBE_RDB_FDIR_CTL_HASH_BITS(0xF) |
+		    TXGBE_RDB_FDIR_CTL_MAX_LENGTH(0xA) |
+		    TXGBE_RDB_FDIR_CTL_FULL_THRESH(4);
+
+	/* write hashes and fdirctrl register, poll for completion */
+	txgbe_fdir_enable(wx, fdirctrl);
+}
+
+static void txgbe_fdir_filter_restore(struct wx *wx)
+{
+	struct txgbe_fdir_filter *filter;
+	struct txgbe *txgbe = wx->priv;
+	struct hlist_node *node;
+	u8 queue = 0;
+	int ret = 0;
+
+	spin_lock(&txgbe->fdir_perfect_lock);
+
+	if (!hlist_empty(&txgbe->fdir_filter_list))
+		ret = txgbe_fdir_set_input_mask(wx, &txgbe->fdir_mask);
+
+	if (ret)
+		goto unlock;
+
+	hlist_for_each_entry_safe(filter, node,
+				  &txgbe->fdir_filter_list, fdir_node) {
+		if (filter->action == TXGBE_RDB_FDIR_DROP_QUEUE) {
+			queue = TXGBE_RDB_FDIR_DROP_QUEUE;
+		} else {
+			u32 ring = ethtool_get_flow_spec_ring(filter->action);
+
+			if (ring >= wx->num_rx_queues) {
+				wx_err(wx, "FDIR restore failed, ring:%u\n",
+				       ring);
+				continue;
+			}
+
+			/* Map the ring onto the absolute queue index */
+			queue = wx->rx_ring[ring]->reg_idx;
+		}
+
+		ret = txgbe_fdir_write_perfect_filter(wx,
+						      &filter->filter,
+						      filter->sw_idx,
+						      queue);
+		if (ret)
+			wx_err(wx, "FDIR restore failed, index:%u\n",
+			       filter->sw_idx);
+	}
+
+unlock:
+	spin_unlock(&txgbe->fdir_perfect_lock);
+}
+
 void txgbe_configure_fdir(struct wx *wx)
 {
 	wx_disable_sec_rx_path(wx);
 
-	if (test_bit(WX_FLAG_FDIR_HASH, wx->flags))
+	if (test_bit(WX_FLAG_FDIR_HASH, wx->flags)) {
 		txgbe_init_fdir_signature(wx);
+	} else if (test_bit(WX_FLAG_FDIR_PERFECT, wx->flags)) {
+		txgbe_init_fdir_perfect(wx);
+		txgbe_fdir_filter_restore(wx);
+	}
 
 	wx_enable_sec_rx_path(wx);
 }
+
+void txgbe_fdir_filter_exit(struct wx *wx)
+{
+	struct txgbe_fdir_filter *filter;
+	struct txgbe *txgbe = wx->priv;
+	struct hlist_node *node;
+
+	spin_lock(&txgbe->fdir_perfect_lock);
+
+	hlist_for_each_entry_safe(filter, node,
+				  &txgbe->fdir_filter_list, fdir_node) {
+		hlist_del(&filter->fdir_node);
+		kfree(filter);
+	}
+	txgbe->fdir_filter_count = 0;
+
+	spin_unlock(&txgbe->fdir_perfect_lock);
+}
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h
index ed245b66dc2a..1f44ce60becb 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h
@@ -4,7 +4,17 @@
 #ifndef _TXGBE_FDIR_H_
 #define _TXGBE_FDIR_H_
 
+void txgbe_atr_compute_perfect_hash(union txgbe_atr_input *input,
+				    union txgbe_atr_input *input_mask);
 void txgbe_atr(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
+int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask);
+int txgbe_fdir_write_perfect_filter(struct wx *wx,
+				    union txgbe_atr_input *input,
+				    u16 soft_id, u8 queue);
+int txgbe_fdir_erase_perfect_filter(struct wx *wx,
+				    union txgbe_atr_input *input,
+				    u16 soft_id);
 void txgbe_configure_fdir(struct wx *wx);
+void txgbe_fdir_filter_exit(struct wx *wx);
 
 #endif /* _TXGBE_FDIR_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index ce49fb725541..41e9ebf11e41 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -283,6 +283,12 @@ static int txgbe_sw_init(struct wx *wx)
 	return 0;
 }
 
+static void txgbe_init_fdir(struct txgbe *txgbe)
+{
+	txgbe->fdir_filter_count = 0;
+	spin_lock_init(&txgbe->fdir_perfect_lock);
+}
+
 /**
  * txgbe_open - Called when a network interface is made active
  * @netdev: network interface device structure
@@ -361,6 +367,7 @@ static int txgbe_close(struct net_device *netdev)
 	txgbe_down(wx);
 	wx_free_irq(wx);
 	wx_free_resources(wx);
+	txgbe_fdir_filter_exit(wx);
 	wx_control_hw(wx, false);
 
 	return 0;
@@ -669,6 +676,8 @@ static int txgbe_probe(struct pci_dev *pdev,
 	txgbe->wx = wx;
 	wx->priv = txgbe;
 
+	txgbe_init_fdir(txgbe);
+
 	err = txgbe_setup_misc_irq(txgbe);
 	if (err)
 		goto err_release_hw;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 5b8c55df35fe..959102c4c379 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -90,6 +90,7 @@
 #define TXGBE_XPCS_IDA_DATA                     0x13004
 
 /********************************* Flow Director *****************************/
+#define TXGBE_RDB_FDIR_DROP_QUEUE               127
 #define TXGBE_RDB_FDIR_CTL                      0x19500
 #define TXGBE_RDB_FDIR_CTL_INIT_DONE            BIT(3)
 #define TXGBE_RDB_FDIR_CTL_PERFECT_MATCH        BIT(4)
@@ -97,6 +98,13 @@
 #define TXGBE_RDB_FDIR_CTL_HASH_BITS(v)         FIELD_PREP(GENMASK(23, 20), v)
 #define TXGBE_RDB_FDIR_CTL_MAX_LENGTH(v)        FIELD_PREP(GENMASK(27, 24), v)
 #define TXGBE_RDB_FDIR_CTL_FULL_THRESH(v)       FIELD_PREP(GENMASK(31, 28), v)
+#define TXGBE_RDB_FDIR_IP6(_i)                  (0x1950C + ((_i) * 4)) /* 0-2 */
+#define TXGBE_RDB_FDIR_SA                       0x19518
+#define TXGBE_RDB_FDIR_DA                       0x1951C
+#define TXGBE_RDB_FDIR_PORT                     0x19520
+#define TXGBE_RDB_FDIR_PORT_DESTINATION_SHIFT   16
+#define TXGBE_RDB_FDIR_FLEX                     0x19524
+#define TXGBE_RDB_FDIR_FLEX_FLEX_SHIFT          16
 #define TXGBE_RDB_FDIR_HASH                     0x19528
 #define TXGBE_RDB_FDIR_HASH_SIG_SW_INDEX(v)     FIELD_PREP(GENMASK(31, 16), v)
 #define TXGBE_RDB_FDIR_HASH_BUCKET_VALID        BIT(15)
@@ -114,8 +122,16 @@
 #define TXGBE_RDB_FDIR_CMD_QUEUE_EN             BIT(15)
 #define TXGBE_RDB_FDIR_CMD_RX_QUEUE(v)          FIELD_PREP(GENMASK(22, 16), v)
 #define TXGBE_RDB_FDIR_CMD_VT_POOL(v)           FIELD_PREP(GENMASK(29, 24), v)
+#define TXGBE_RDB_FDIR_DA4_MSK                  0x1953C
+#define TXGBE_RDB_FDIR_SA4_MSK                  0x19540
+#define TXGBE_RDB_FDIR_TCP_MSK                  0x19544
+#define TXGBE_RDB_FDIR_UDP_MSK                  0x19548
+#define TXGBE_RDB_FDIR_SCTP_MSK                 0x19560
 #define TXGBE_RDB_FDIR_HKEY                     0x19568
 #define TXGBE_RDB_FDIR_SKEY                     0x1956C
+#define TXGBE_RDB_FDIR_OTHER_MSK                0x19570
+#define TXGBE_RDB_FDIR_OTHER_MSK_POOL           BIT(2)
+#define TXGBE_RDB_FDIR_OTHER_MSK_L4P            BIT(3)
 #define TXGBE_RDB_FDIR_FLEX_CFG(_i)             (0x19580 + ((_i) * 4))
 #define TXGBE_RDB_FDIR_FLEX_CFG_FIELD0          GENMASK(7, 0)
 #define TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC        FIELD_PREP(GENMASK(1, 0), 0)
@@ -230,6 +246,13 @@ enum txgbe_fdir_pballoc_type {
 	TXGBE_FDIR_PBALLOC_256K = 3,
 };
 
+struct txgbe_fdir_filter {
+	struct hlist_node fdir_node;
+	union txgbe_atr_input filter;
+	u16 sw_idx;
+	u16 action;
+};
+
 /* TX/RX descriptor defines */
 #define TXGBE_DEFAULT_TXD               512
 #define TXGBE_DEFAULT_TX_WORK           256
@@ -316,7 +339,10 @@ struct txgbe {
 	unsigned int link_irq;
 
 	/* flow director */
+	struct hlist_head fdir_filter_list;
 	union txgbe_atr_input fdir_mask;
+	int fdir_filter_count;
+	spinlock_t fdir_perfect_lock; /* spinlock for FDIR */
 };
 
 #endif /* _TXGBE_TYPE_H_ */
-- 
2.27.0


