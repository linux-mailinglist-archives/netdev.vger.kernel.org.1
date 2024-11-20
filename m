Return-Path: <netdev+bounces-146482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EFC9D393D
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 12:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7921A1F26D4C
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3570519CCEC;
	Wed, 20 Nov 2024 11:14:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496D19D8A0;
	Wed, 20 Nov 2024 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101267; cv=none; b=CqbwHFbtxbRMz4nbMC5CUXaIsSPZeKfrT5L2gkjdyFSPEZVVTCgkZH/yHZDuabttwWuQY48We9D4N4tRQK06TpGvLx01AVlQvn1LOru5lFCBwVw+8/cAi6UfUvZ9N8eEVFfFvsF9Lg1bdsA8oR7V48W9APlVOp1DmU0Q9rr93L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101267; c=relaxed/simple;
	bh=h2H7/bSt0YhSwbQYiq3jOu0lOrTaaQx9Why/WNJEuaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sl6m4HiHnmnoHUQ0GmkMQGfsmJ7KiRagPV1DPROzA6CcG3zj6MkYhhj0405xgIJaxv0RaWKS53P3e0uCrNAoam4kLWMSDaajPTFBD++FtIu/RpafVa7dbM+BBTcicP67Xz4eMVkMeTdpVPvrN3uA7GZPVz1YYKlcSSiD/t896bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppbE_1732100204 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:44 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 11/21] motorcomm:yt6801: Implement some net_device_ops function
Date: Wed, 20 Nov 2024 19:14:14 +0800
Message-Id: <20241120105625.22508-12-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement following callback function
.ndo_stop
.ndo_start_xmit
.ndo_get_stats64
.ndo_set_mac_address
.ndo_validate_addr
.ndo_vlan_rx_add_vid
.ndo_vlan_rx_kill_vid
.ndo_poll_controller
.ndo_set_features
.ndo_fix_features
.ndo_set_rx_mode

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 196 ++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index fa1587e69..ed65c9cc9 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -996,6 +996,25 @@ static int fxgmac_open(struct net_device *netdev)
 	return ret;
 }
 
+static int fxgmac_close(struct net_device *netdev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	mutex_lock(&pdata->mutex);
+	fxgmac_stop(pdata);		/* Stop the device */
+	pdata->dev_state = FXGMAC_DEV_CLOSE;
+	fxgmac_channels_rings_free(pdata); /* Free the channels and rings */
+	hw_ops->reset_phy(pdata);
+	phy_disconnect(pdata->phydev);
+	mutex_unlock(&pdata->mutex);
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s ok\n", __func__);
+
+	return 0;
+}
+
 #define EFUSE_FISRT_UPDATE_ADDR				255
 #define EFUSE_SECOND_UPDATE_ADDR			209
 #define EFUSE_MAX_ENTRY					39
@@ -1981,9 +2000,186 @@ static netdev_tx_t fxgmac_xmit(struct sk_buff *skb, struct net_device *netdev)
 
 	return NETDEV_TX_OK;
 }
+
+static void fxgmac_get_stats64(struct net_device *netdev,
+			       struct rtnl_link_stats64 *s)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_stats *pstats = &pdata->stats;
+
+	if (test_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate))
+		return;
+
+	pdata->hw_ops.read_mmc_stats(pdata);
+
+	s->rx_packets = pstats->rxframecount_gb;
+	s->rx_bytes = pstats->rxoctetcount_gb;
+	s->rx_errors = pstats->rxframecount_gb - pstats->rxbroadcastframes_g -
+		       pstats->rxmulticastframes_g - pstats->rxunicastframes_g;
+
+	s->rx_length_errors = pstats->rxlengtherror;
+	s->rx_crc_errors = pstats->rxcrcerror;
+	s->rx_fifo_errors = pstats->rxfifooverflow;
+
+	s->tx_packets = pstats->txframecount_gb;
+	s->tx_bytes = pstats->txoctetcount_gb;
+	s->tx_errors = pstats->txframecount_gb - pstats->txframecount_g;
+	s->tx_dropped = netdev->stats.tx_dropped;
+}
+
+static int fxgmac_set_mac_address(struct net_device *netdev, void *addr)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct sockaddr *saddr = addr;
+
+	if (!is_valid_ether_addr(saddr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	eth_hw_addr_set(netdev, saddr->sa_data);
+	memcpy(pdata->mac_addr, saddr->sa_data, netdev->addr_len);
+	hw_ops->set_mac_address(pdata, saddr->sa_data);
+	hw_ops->set_mac_hash(pdata);
+
+	yt_dbg(pdata, "fxgmac,set mac addr to %pM\n", netdev->dev_addr);
+
+	return 0;
+}
+
+static int fxgmac_vlan_rx_add_vid(struct net_device *netdev, __be16 proto,
+				  u16 vid)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	set_bit(vid, pdata->active_vlans);
+	hw_ops->update_vlan_hash_table(pdata);
+
+	yt_dbg(pdata, "fxgmac,add rx vlan %d\n", vid);
+
+	return 0;
+}
+
+static int fxgmac_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto,
+				   u16 vid)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	clear_bit(vid, pdata->active_vlans);
+	hw_ops->update_vlan_hash_table(pdata);
+
+	yt_dbg(pdata, "fxgmac,del rx vlan %d\n", vid);
+
+	return 0;
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void fxgmac_poll_controller(struct net_device *netdev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_channel *channel;
+
+	if (pdata->per_channel_irq) {
+		channel = pdata->channel_head;
+		for (u32 i = 0; i < pdata->channel_count; i++, channel++)
+			fxgmac_dma_isr(channel->dma_irq_rx, channel);
+	} else {
+		disable_irq(pdata->dev_irq);
+		fxgmac_isr(pdata->dev_irq, pdata);
+		enable_irq(pdata->dev_irq);
+	}
+}
+#endif /* CONFIG_NET_POLL_CONTROLLER */
+
+static netdev_features_t fxgmac_fix_features(struct net_device *netdev,
+					     netdev_features_t features)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	u32 fifo_size;
+
+	fifo_size = pdata->hw_ops.calculate_max_checksum_size(pdata);
+	if (netdev->mtu > fifo_size) {
+		features &= ~NETIF_F_IP_CSUM;
+		features &= ~NETIF_F_IPV6_CSUM;
+	}
+
+	return features;
+}
+
+static int fxgmac_set_features(struct net_device *netdev,
+			       netdev_features_t features)
+{
+	netdev_features_t rxhash, rxcsum, rxvlan, rxvlan_filter, tso;
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops;
+
+	hw_ops = &pdata->hw_ops;
+	rxhash = pdata->netdev_features & NETIF_F_RXHASH;
+	rxcsum = pdata->netdev_features & NETIF_F_RXCSUM;
+	rxvlan = pdata->netdev_features & NETIF_F_HW_VLAN_CTAG_RX;
+	rxvlan_filter = pdata->netdev_features & NETIF_F_HW_VLAN_CTAG_FILTER;
+	tso = pdata->netdev_features & (NETIF_F_TSO | NETIF_F_TSO6);
+
+	if ((features & (NETIF_F_TSO | NETIF_F_TSO6)) && !tso) {
+		yt_dbg(pdata, "enable tso.\n");
+		pdata->hw_feat.tso = 1;
+		hw_ops->config_tso(pdata);
+	} else if (!(features & (NETIF_F_TSO | NETIF_F_TSO6)) && tso) {
+		yt_dbg(pdata, "disable tso.\n");
+		pdata->hw_feat.tso = 0;
+		hw_ops->config_tso(pdata);
+	}
+
+	if ((features & NETIF_F_RXHASH) && !rxhash)
+		hw_ops->enable_rss(pdata);
+	else if (!(features & NETIF_F_RXHASH) && rxhash)
+		hw_ops->disable_rss(pdata);
+
+	if ((features & NETIF_F_RXCSUM) && !rxcsum)
+		hw_ops->enable_rx_csum(pdata);
+	else if (!(features & NETIF_F_RXCSUM) && rxcsum)
+		hw_ops->disable_rx_csum(pdata);
+
+	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && !rxvlan)
+		hw_ops->enable_rx_vlan_stripping(pdata);
+	else if (!(features & NETIF_F_HW_VLAN_CTAG_RX) && rxvlan)
+		hw_ops->disable_rx_vlan_stripping(pdata);
+
+	if ((features & NETIF_F_HW_VLAN_CTAG_FILTER) && !rxvlan_filter)
+		hw_ops->enable_rx_vlan_filtering(pdata);
+	else if (!(features & NETIF_F_HW_VLAN_CTAG_FILTER) && rxvlan_filter)
+		hw_ops->disable_rx_vlan_filtering(pdata);
+
+	pdata->netdev_features = features;
+
+	yt_dbg(pdata, "fxgmac,set features done,%llx\n", (u64)features);
+	return 0;
+}
+
+static void fxgmac_set_rx_mode(struct net_device *netdev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	hw_ops->config_rx_mode(pdata);
+}
+
 static const struct net_device_ops fxgmac_netdev_ops = {
 	.ndo_open		= fxgmac_open,
+	.ndo_stop		= fxgmac_close,
 	.ndo_start_xmit		= fxgmac_xmit,
+	.ndo_get_stats64	= fxgmac_get_stats64,
+	.ndo_set_mac_address	= fxgmac_set_mac_address,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_vlan_rx_add_vid	= fxgmac_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= fxgmac_vlan_rx_kill_vid,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= fxgmac_poll_controller,
+#endif
+	.ndo_set_features	= fxgmac_set_features,
+	.ndo_fix_features	= fxgmac_fix_features,
+	.ndo_set_rx_mode	= fxgmac_set_rx_mode,
 };
 
 const struct net_device_ops *fxgmac_get_netdev_ops(void)
-- 
2.34.1


