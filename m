Return-Path: <netdev+bounces-146476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8769D392B
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 12:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5EDB247F0
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7680F1A00ED;
	Wed, 20 Nov 2024 11:02:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44419E994;
	Wed, 20 Nov 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100529; cv=none; b=T4YMrZ5SEytWdw4E3pJ4RMrDSJD/2SreBEFek/acMU6FHNOK/GbInCGJnYtvnrWPIE+7ACsa19kyTbZVecZ2yf7oUTA3A0uCkmyvn5nWTBuhkNJgh/tIOOLCaauILlb/4Gok5FIGbbTb4IzxxgRB5h9cczGxC1G4EDHcqDUtDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100529; c=relaxed/simple;
	bh=wHiWMwZIPRfeWB5HVl/BH0DDw+jXRFv0ZgZaeU2jkyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u/fs0KjQddt7unqHtXanuFS4ekucFmNbr27GRja0M/BsGNzbkCwfvtMVGsYZwNx+cuo4B6Vc+MHyku6x7iYoCS6nucx8z/4kqsmy0mD9gBmPnDL5fUAOKQyiCI7Z5HbibRcLgr79Lnbl6v+CjChEZnmBW+O0YEJTr8gXznP8axI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppbw_1732100204 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:45 +0800
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
Subject: [PATCH net-next v2 12/21] motorcomm:yt6801: Implement .ndo_tx_timeout and .ndo_change_mtu functions
Date: Wed, 20 Nov 2024 18:56:16 +0800
Message-Id: <20241120105625.22508-13-Frank.Sae@motor-comm.com>
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
.ndo_tx_timeout
.ndo_change_mtu
The .ndo_tx_timeout function also will call fxgmac_dump_state to dump nessary
debug information.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../net/ethernet/motorcomm/yt6801/yt6801_hw.c |  69 ++++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 160 ++++++++++++++++++
 2 files changed, 229 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
index 791dd69b7..a70fa4ede 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
@@ -1204,6 +1204,71 @@ static void fxgmac_rx_mmc_int(struct fxgmac_pdata *yt)
 		stats->rxcontrolframe_g += rd32_mac(yt, MMC_RXCONTROLFRAME_G);
 }
 
+static void fxgmac_read_mmc_stats(struct fxgmac_pdata *yt)
+{
+	struct fxgmac_stats *stats = &yt->stats;
+
+	stats->txoctetcount_gb += rd32_mac(yt, MMC_TXOCTETCOUNT_GB_LO);
+	stats->txframecount_gb += rd32_mac(yt, MMC_TXFRAMECOUNT_GB_LO);
+	stats->txbroadcastframes_g += rd32_mac(yt, MMC_TXBROADCASTFRAMES_G_LO);
+	stats->txmulticastframes_g += rd32_mac(yt, MMC_TXMULTICASTFRAMES_G_LO);
+	stats->tx64octets_gb += rd32_mac(yt, MMC_TX64OCTETS_GB_LO);
+	stats->tx65to127octets_gb += rd32_mac(yt, MMC_TX65TO127OCTETS_GB_LO);
+	stats->tx128to255octets_gb += rd32_mac(yt, MMC_TX128TO255OCTETS_GB_LO);
+	stats->tx256to511octets_gb += rd32_mac(yt, MMC_TX256TO511OCTETS_GB_LO);
+	stats->tx512to1023octets_gb +=
+		rd32_mac(yt, MMC_TX512TO1023OCTETS_GB_LO);
+	stats->tx1024tomaxoctets_gb +=
+		rd32_mac(yt, MMC_TX1024TOMAXOCTETS_GB_LO);
+	stats->txunicastframes_gb += rd32_mac(yt, MMC_TXUNICASTFRAMES_GB_LO);
+	stats->txmulticastframes_gb +=
+		rd32_mac(yt, MMC_TXMULTICASTFRAMES_GB_LO);
+	stats->txbroadcastframes_g += rd32_mac(yt, MMC_TXBROADCASTFRAMES_GB_LO);
+	stats->txunderflowerror += rd32_mac(yt, MMC_TXUNDERFLOWERROR_LO);
+	stats->txsinglecollision_g += rd32_mac(yt, MMC_TXSINGLECOLLISION_G);
+	stats->txmultiplecollision_g += rd32_mac(yt, MMC_TXMULTIPLECOLLISION_G);
+	stats->txdeferredframes += rd32_mac(yt, MMC_TXDEFERREDFRAMES);
+	stats->txlatecollisionframes += rd32_mac(yt, MMC_TXLATECOLLISIONFRAMES);
+	stats->txexcessivecollisionframes +=
+		rd32_mac(yt, MMC_TXEXCESSIVECOLLSIONFRAMES);
+	stats->txcarriererrorframes += rd32_mac(yt, MMC_TXCARRIERERRORFRAMES);
+	stats->txoctetcount_g += rd32_mac(yt, MMC_TXOCTETCOUNT_G_LO);
+	stats->txframecount_g += rd32_mac(yt, MMC_TXFRAMECOUNT_G_LO);
+	stats->txexcessivedeferralerror +=
+		rd32_mac(yt, MMC_TXEXCESSIVEDEFERRALERROR);
+	stats->txpauseframes += rd32_mac(yt, MMC_TXPAUSEFRAMES_LO);
+	stats->txvlanframes_g += rd32_mac(yt, MMC_TXVLANFRAMES_G_LO);
+	stats->txoversize_g += rd32_mac(yt, MMC_TXOVERSIZEFRAMES);
+	stats->rxframecount_gb += rd32_mac(yt, MMC_RXFRAMECOUNT_GB_LO);
+	stats->rxoctetcount_gb += rd32_mac(yt, MMC_RXOCTETCOUNT_GB_LO);
+	stats->rxoctetcount_g += rd32_mac(yt, MMC_RXOCTETCOUNT_G_LO);
+	stats->rxbroadcastframes_g += rd32_mac(yt, MMC_RXBROADCASTFRAMES_G_LO);
+	stats->rxmulticastframes_g += rd32_mac(yt, MMC_RXMULTICASTFRAMES_G_LO);
+	stats->rxcrcerror += rd32_mac(yt, MMC_RXCRCERROR_LO);
+	stats->rxalignerror += rd32_mac(yt, MMC_RXALIGNERROR);
+	stats->rxrunterror += rd32_mac(yt, MMC_RXRUNTERROR);
+	stats->rxjabbererror += rd32_mac(yt, MMC_RXJABBERERROR);
+	stats->rxundersize_g += rd32_mac(yt, MMC_RXUNDERSIZE_G);
+	stats->rxoversize_g += rd32_mac(yt, MMC_RXOVERSIZE_G);
+	stats->rx64octets_gb += rd32_mac(yt, MMC_RX64OCTETS_GB_LO);
+	stats->rx65to127octets_gb += rd32_mac(yt, MMC_RX65TO127OCTETS_GB_LO);
+	stats->rx128to255octets_gb += rd32_mac(yt, MMC_RX128TO255OCTETS_GB_LO);
+	stats->rx256to511octets_gb += rd32_mac(yt, MMC_RX256TO511OCTETS_GB_LO);
+	stats->rx512to1023octets_gb +=
+		rd32_mac(yt, MMC_RX512TO1023OCTETS_GB_LO);
+	stats->rx1024tomaxoctets_gb +=
+		rd32_mac(yt, MMC_RX1024TOMAXOCTETS_GB_LO);
+	stats->rxunicastframes_g += rd32_mac(yt, MMC_RXUNICASTFRAMES_G_LO);
+	stats->rxlengtherror += rd32_mac(yt, MMC_RXLENGTHERROR_LO);
+	stats->rxoutofrangetype += rd32_mac(yt, MMC_RXOUTOFRANGETYPE_LO);
+	stats->rxpauseframes += rd32_mac(yt, MMC_RXPAUSEFRAMES_LO);
+	stats->rxfifooverflow += rd32_mac(yt, MMC_RXFIFOOVERFLOW_LO);
+	stats->rxvlanframes_gb += rd32_mac(yt, MMC_RXVLANFRAMES_GB_LO);
+	stats->rxwatchdogerror += rd32_mac(yt, MMC_RXWATCHDOGERROR);
+	stats->rxreceiveerrorframe += rd32_mac(yt, MMC_RXRECEIVEERRORFRAME);
+	stats->rxcontrolframe_g += rd32_mac(yt, MMC_RXCONTROLFRAME_G);
+}
+
 static void fxgmac_config_mmc(struct fxgmac_pdata *pdata)
 {
 	u32 val;
@@ -2610,6 +2675,10 @@ void fxgmac_hw_ops_init(struct fxgmac_hw_ops *hw_ops)
 	/* RX coalescing */
 	hw_ops->config_rx_coalesce = fxgmac_config_rx_coalesce;
 	hw_ops->usec_to_riwt = fxgmac_usec_to_riwt;
+
+	/* MMC statistics support */
+	hw_ops->read_mmc_stats = fxgmac_read_mmc_stats;
+
 	/* Receive Side Scaling */
 	hw_ops->enable_rss = fxgmac_enable_rss;
 	hw_ops->disable_rss = fxgmac_disable_rss;
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index ed65c9cc9..c5c13601e 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -1015,6 +1015,129 @@ static int fxgmac_close(struct net_device *netdev)
 	return 0;
 }
 
+static void fxgmac_dump_state(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	struct fxgmac_stats *pstats = &pdata->stats;
+	struct fxgmac_ring *ring;
+
+	ring = &channel->tx_ring[0];
+	yt_err(pdata, "Tx descriptor info:\n");
+	yt_err(pdata, "Tx cur = 0x%x\n", ring->cur);
+	yt_err(pdata, "Tx dirty = 0x%x\n", ring->dirty);
+	yt_err(pdata, "Tx dma_desc_head = %pad\n", &ring->dma_desc_head);
+	yt_err(pdata, "Tx desc_data_head = %pad\n", &ring->desc_data_head);
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		ring = &channel->rx_ring[0];
+		yt_err(pdata, "Rx[%d] descriptor info:\n", i);
+		yt_err(pdata, "Rx cur = 0x%x\n", ring->cur);
+		yt_err(pdata, "Rx dirty = 0x%x\n", ring->dirty);
+		yt_err(pdata, "Rx dma_desc_head = %pad\n",
+		       &ring->dma_desc_head);
+		yt_err(pdata, "Rx desc_data_head = %pad\n",
+		       &ring->desc_data_head);
+	}
+
+	yt_err(pdata, "Device Registers:\n");
+	yt_err(pdata, "MAC_ISR = %08x\n", rd32_mac(pdata, MAC_ISR));
+	yt_err(pdata, "MAC_IER = %08x\n", rd32_mac(pdata, MAC_IER));
+	yt_err(pdata, "MMC_RISR = %08x\n", rd32_mac(pdata, MMC_RISR));
+	yt_err(pdata, "MMC_RIER = %08x\n", rd32_mac(pdata, MMC_RIER));
+	yt_err(pdata, "MMC_TISR = %08x\n", rd32_mac(pdata, MMC_TISR));
+	yt_err(pdata, "MMC_TIER = %08x\n", rd32_mac(pdata, MMC_TIER));
+
+	yt_err(pdata, "EPHY_CTRL = %04x\n", rd32_mem(pdata, EPHY_CTRL));
+	yt_err(pdata, "MGMT_INT_CTRL0 = %04x\n",
+	       rd32_mem(pdata, MGMT_INT_CTRL0));
+	yt_err(pdata, "LPW_CTRL = %04x\n", rd32_mem(pdata, LPW_CTRL));
+	yt_err(pdata, "MSIX_TBL_MASK = %04x\n", rd32_mem(pdata, MSIX_TBL_MASK));
+
+	yt_err(pdata, "Dump nonstick regs:\n");
+	for (u32 i = GLOBAL_CTRL0; i < MSI_PBA; i += 4)
+		yt_err(pdata, "[%d] = %04x\n", i / 4, rd32_mem(pdata, i));
+
+	pdata->hw_ops.read_mmc_stats(pdata);
+
+	yt_err(pdata, "Dump TX counters:\n");
+	yt_err(pdata, "tx_packets %lld\n", pstats->txframecount_gb);
+	yt_err(pdata, "tx_errors %lld\n",
+	       pstats->txframecount_gb - pstats->txframecount_g);
+	yt_err(pdata, "tx_multicastframes_errors %lld\n",
+	       pstats->txmulticastframes_gb - pstats->txmulticastframes_g);
+	yt_err(pdata, "tx_broadcastframes_errors %lld\n",
+	       pstats->txbroadcastframes_gb - pstats->txbroadcastframes_g);
+
+	yt_err(pdata, "txunderflowerror %lld\n", pstats->txunderflowerror);
+	yt_err(pdata, "txdeferredframes %lld\n",
+	       pstats->txdeferredframes);
+	yt_err(pdata, "txlatecollisionframes %lld\n",
+	       pstats->txlatecollisionframes);
+	yt_err(pdata, "txexcessivecollisionframes %lld\n",
+	       pstats->txexcessivecollisionframes);
+	yt_err(pdata, "txcarriererrorframes %lld\n",
+	       pstats->txcarriererrorframes);
+	yt_err(pdata, "txexcessivedeferralerror %lld\n",
+	       pstats->txexcessivedeferralerror);
+
+	yt_err(pdata, "txsinglecollision_g %lld\n",
+	       pstats->txsinglecollision_g);
+	yt_err(pdata, "txmultiplecollision_g %lld\n",
+	       pstats->txmultiplecollision_g);
+	yt_err(pdata, "txoversize_g %lld\n", pstats->txoversize_g);
+
+	yt_err(pdata, "Dump RX counters:\n");
+	yt_err(pdata, "rx_packets %lld\n", pstats->rxframecount_gb);
+	yt_err(pdata, "rx_errors %lld\n",
+	       pstats->rxframecount_gb - pstats->rxbroadcastframes_g -
+	       pstats->rxmulticastframes_g - pstats->rxunicastframes_g);
+
+	yt_err(pdata, "rx_crc_errors %lld\n", pstats->rxcrcerror);
+	yt_err(pdata, "rxalignerror %lld\n", pstats->rxalignerror);
+	yt_err(pdata, "rxrunterror %lld\n", pstats->rxrunterror);
+	yt_err(pdata, "rxjabbererror %lld\n", pstats->rxjabbererror);
+	yt_err(pdata, "rx_length_errors %lld\n", pstats->rxlengtherror);
+	yt_err(pdata, "rxoutofrangetype %lld\n", pstats->rxoutofrangetype);
+	yt_err(pdata, "rx_fifo_errors %lld\n", pstats->rxfifooverflow);
+	yt_err(pdata, "rxwatchdogerror %lld\n", pstats->rxwatchdogerror);
+	yt_err(pdata, "rxreceiveerrorframe %lld\n",
+	       pstats->rxreceiveerrorframe);
+
+	yt_err(pdata, "rxbroadcastframes_g %lld\n",
+	       pstats->rxbroadcastframes_g);
+	yt_err(pdata, "rxmulticastframes_g %lld\n",
+	       pstats->rxmulticastframes_g);
+	yt_err(pdata, "rxundersize_g %lld\n", pstats->rxundersize_g);
+	yt_err(pdata, "rxoversize_g %lld\n", pstats->rxoversize_g);
+	yt_err(pdata, "rxunicastframes_g %lld\n", pstats->rxunicastframes_g);
+	yt_err(pdata, "rxcontrolframe_g %lld\n", pstats->rxcontrolframe_g);
+
+	yt_err(pdata, "Dump Extra counters:\n");
+	yt_err(pdata, "tx_tso_packets %lld\n", pstats->tx_tso_packets);
+	yt_err(pdata, "rx_split_header_packets %lld\n",
+	       pstats->rx_split_header_packets);
+	yt_err(pdata, "tx_process_stopped %lld\n", pstats->tx_process_stopped);
+	yt_err(pdata, "rx_process_stopped %lld\n", pstats->rx_process_stopped);
+	yt_err(pdata, "tx_buffer_unavailable %lld\n",
+	       pstats->tx_buffer_unavailable);
+	yt_err(pdata, "rx_buffer_unavailable %lld\n",
+	       pstats->rx_buffer_unavailable);
+	yt_err(pdata, "fatal_bus_error %lld\n", pstats->fatal_bus_error);
+	yt_err(pdata, "napi_poll_isr %lld\n", pstats->napi_poll_isr);
+	yt_err(pdata, "napi_poll_txtimer %lld\n", pstats->napi_poll_txtimer);
+	yt_err(pdata, "ephy_poll_timer_cnt %lld\n",
+	       pstats->ephy_poll_timer_cnt);
+	yt_err(pdata, "mgmt_int_isr %lld\n", pstats->mgmt_int_isr);
+}
+
+static void fxgmac_tx_timeout(struct net_device *netdev, unsigned int unused)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	fxgmac_dump_state(pdata);
+	schedule_work(&pdata->restart_work);
+}
+
 #define EFUSE_FISRT_UPDATE_ADDR				255
 #define EFUSE_SECOND_UPDATE_ADDR			209
 #define EFUSE_MAX_ENTRY					39
@@ -2046,6 +2169,41 @@ static int fxgmac_set_mac_address(struct net_device *netdev, void *addr)
 	return 0;
 }
 
+static int fxgmac_change_mtu(struct net_device *netdev, int mtu)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	int old_mtu = netdev->mtu;
+	int ret;
+
+	mutex_lock(&pdata->mutex);
+	fxgmac_stop(pdata);
+	fxgmac_free_tx_data(pdata);
+
+	/* We must unmap rx desc's dma before we change rx_buf_size.
+	 * Becaues the size of the unmapped DMA is set according to rx_buf_size
+	 */
+	fxgmac_free_rx_data(pdata);
+	pdata->jumbo = mtu > ETH_DATA_LEN ? 1 : 0;
+	ret = fxgmac_calc_rx_buf_size(pdata, mtu);
+	if (ret < 0)
+		return ret;
+
+	pdata->rx_buf_size = ret;
+	netdev->mtu = mtu;
+
+	if (netif_running(netdev))
+		fxgmac_start(pdata);
+
+	netdev_update_features(netdev);
+
+	mutex_unlock(&pdata->mutex);
+
+	yt_dbg(pdata, "fxgmac,set MTU from %d to %d. min, max=(%d,%d)\n",
+	       old_mtu, netdev->mtu, netdev->min_mtu, netdev->max_mtu);
+
+	return 0;
+}
+
 static int fxgmac_vlan_rx_add_vid(struct net_device *netdev, __be16 proto,
 				  u16 vid)
 {
@@ -2169,7 +2327,9 @@ static const struct net_device_ops fxgmac_netdev_ops = {
 	.ndo_open		= fxgmac_open,
 	.ndo_stop		= fxgmac_close,
 	.ndo_start_xmit		= fxgmac_xmit,
+	.ndo_tx_timeout		= fxgmac_tx_timeout,
 	.ndo_get_stats64	= fxgmac_get_stats64,
+	.ndo_change_mtu		= fxgmac_change_mtu,
 	.ndo_set_mac_address	= fxgmac_set_mac_address,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_vlan_rx_add_vid	= fxgmac_vlan_rx_add_vid,
-- 
2.34.1


