Return-Path: <netdev+bounces-39915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C467C4E36
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 11:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCAE1C20BF1
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87641A71F;
	Wed, 11 Oct 2023 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F101A718
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:09:42 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780579C
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:09:35 -0700 (PDT)
X-QQ-mid: bizesmtp86t1697015208tvnl8z7o
Received: from wxdbg.localdomain.com ( [115.200.230.47])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Oct 2023 17:06:47 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: mA5V8Pu2WCGpV66I6nmhWMmDQAce+IJQ+7FUPua4iAvS9k+FgpSGgSQipwiMG
	zJdq+E5LUxBGaB4LaLFVE+SqVL+6RYJUx3Oy+tdTpheHaAxVGh5AUaaysu0xAQu4SXr7O+D
	aKKDTdkCiCsFcTC1HIZGMV8CwnNNsxXUwT0XaKQ6SY7qak5u/DodojrMZ3RukX1pDkNvslj
	O5yWyvkl3AMBpHO47aBjNvrNu76EiGFESsz9MM4tSMLhE3lHwIjlzfNevkUJNW0CMXOQmmC
	1HAum9n2WcBQv0QJhKBAM/5oRiYkVqC+FA0D8bM9fslRpqTvU5IdC1FJoZT+fnufLtAPexG
	uPF+otTK2ScFcjmoqMRcme9TH19AmH/GaTqAChir7w44FUGfbSCj5ElXa6Vphusq7tj7Vmy
	Im0InzMDsIk=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7492415995347604427
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 1/3] net: libwx: support hardware statistics
Date: Wed, 11 Oct 2023 17:19:04 +0800
Message-Id: <20231011091906.70486-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231011091906.70486-1-jiawenwu@trustnetic.com>
References: <20231011091906.70486-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement update and clear Rx/Tx statistics.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 169 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   8 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  99 ++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  20 ++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  81 +++++++++
 6 files changed, 377 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 93cb6f2294e7..ddc5f6d20b9c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -3,9 +3,171 @@
 
 #include <linux/pci.h>
 #include <linux/phy.h>
+#include <linux/ethtool.h>
 
 #include "wx_type.h"
 #include "wx_ethtool.h"
+#include "wx_hw.h"
+
+struct wx_stats {
+	char stat_string[ETH_GSTRING_LEN];
+	size_t sizeof_stat;
+	off_t stat_offset;
+};
+
+#define WX_STAT(str, m) { \
+		.stat_string = str, \
+		.sizeof_stat = sizeof(((struct wx *)0)->m), \
+		.stat_offset = offsetof(struct wx, m) }
+
+static const struct wx_stats wx_gstrings_stats[] = {
+	WX_STAT("rx_dma_pkts", stats.gprc),
+	WX_STAT("tx_dma_pkts", stats.gptc),
+	WX_STAT("rx_dma_bytes", stats.gorc),
+	WX_STAT("tx_dma_bytes", stats.gotc),
+	WX_STAT("rx_total_pkts", stats.tpr),
+	WX_STAT("tx_total_pkts", stats.tpt),
+	WX_STAT("rx_long_length_count", stats.roc),
+	WX_STAT("rx_short_length_count", stats.ruc),
+	WX_STAT("os2bmc_rx_by_bmc", stats.o2bgptc),
+	WX_STAT("os2bmc_tx_by_bmc", stats.b2ospc),
+	WX_STAT("os2bmc_tx_by_host", stats.o2bspc),
+	WX_STAT("os2bmc_rx_by_host", stats.b2ogprc),
+	WX_STAT("rx_no_dma_resources", stats.rdmdrop),
+	WX_STAT("tx_busy", tx_busy),
+	WX_STAT("non_eop_descs", non_eop_descs),
+	WX_STAT("tx_restart_queue", restart_queue),
+	WX_STAT("rx_csum_offload_good_count", hw_csum_rx_good),
+	WX_STAT("rx_csum_offload_errors", hw_csum_rx_error),
+	WX_STAT("alloc_rx_buff_failed", alloc_rx_buff_failed),
+};
+
+/* drivers allocates num_tx_queues and num_rx_queues symmetrically so
+ * we set the num_rx_queues to evaluate to num_tx_queues. This is
+ * used because we do not have a good way to get the max number of
+ * rx queues with CONFIG_RPS disabled.
+ */
+#define WX_NUM_RX_QUEUES netdev->num_tx_queues
+#define WX_NUM_TX_QUEUES netdev->num_tx_queues
+
+#define WX_QUEUE_STATS_LEN ( \
+		(WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
+		(sizeof(struct wx_queue_stats) / sizeof(u64)))
+#define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
+#define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
+
+int wx_get_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return WX_STATS_LEN;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL(wx_get_sset_count);
+
+void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+{
+	u8 *p = data;
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
+			ethtool_sprintf(&p, wx_gstrings_stats[i].stat_string);
+		for (i = 0; i < netdev->num_tx_queues; i++) {
+			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
+			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
+		}
+		for (i = 0; i < WX_NUM_RX_QUEUES; i++) {
+			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
+			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
+		}
+		break;
+	}
+}
+EXPORT_SYMBOL(wx_get_strings);
+
+void wx_get_ethtool_stats(struct net_device *netdev,
+			  struct ethtool_stats *stats, u64 *data)
+{
+	struct wx *wx = netdev_priv(netdev);
+	struct wx_ring *ring;
+	unsigned int start;
+	int i, j;
+	char *p;
+
+	wx_update_stats(wx);
+
+	for (i = 0; i < WX_GLOBAL_STATS_LEN; i++) {
+		p = (char *)wx + wx_gstrings_stats[i].stat_offset;
+		data[i] = (wx_gstrings_stats[i].sizeof_stat ==
+			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+	}
+
+	for (j = 0; j < netdev->num_tx_queues; j++) {
+		ring = wx->tx_ring[j];
+		if (!ring) {
+			data[i++] = 0;
+			data[i++] = 0;
+			continue;
+		}
+
+		do {
+			start = u64_stats_fetch_begin(&ring->syncp);
+			data[i] = ring->stats.packets;
+			data[i + 1] = ring->stats.bytes;
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
+		i += 2;
+	}
+	for (j = 0; j < WX_NUM_RX_QUEUES; j++) {
+		ring = wx->rx_ring[j];
+		if (!ring) {
+			data[i++] = 0;
+			data[i++] = 0;
+			continue;
+		}
+
+		do {
+			start = u64_stats_fetch_begin(&ring->syncp);
+			data[i] = ring->stats.packets;
+			data[i + 1] = ring->stats.bytes;
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
+		i += 2;
+	}
+}
+EXPORT_SYMBOL(wx_get_ethtool_stats);
+
+void wx_get_mac_stats(struct net_device *netdev,
+		      struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct wx *wx = netdev_priv(netdev);
+	struct wx_hw_stats *hwstats;
+
+	wx_update_stats(wx);
+
+	hwstats = &wx->stats;
+	mac_stats->MulticastFramesXmittedOK = hwstats->mptc;
+	mac_stats->BroadcastFramesXmittedOK = hwstats->bptc;
+	mac_stats->MulticastFramesReceivedOK = hwstats->mprc;
+	mac_stats->BroadcastFramesReceivedOK = hwstats->bprc;
+}
+EXPORT_SYMBOL(wx_get_mac_stats);
+
+void wx_get_pause_stats(struct net_device *netdev,
+			struct ethtool_pause_stats *stats)
+{
+	struct wx *wx = netdev_priv(netdev);
+	struct wx_hw_stats *hwstats;
+
+	wx_update_stats(wx);
+
+	hwstats = &wx->stats;
+	stats->tx_pause_frames = hwstats->lxontxc + hwstats->lxofftxc;
+	stats->rx_pause_frames = hwstats->lxonoffrxc;
+}
+EXPORT_SYMBOL(wx_get_pause_stats);
 
 void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 {
@@ -14,5 +176,12 @@ void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 	strscpy(info->driver, wx->driver_name, sizeof(info->driver));
 	strscpy(info->fw_version, wx->eeprom_id, sizeof(info->fw_version));
 	strscpy(info->bus_info, pci_name(wx->pdev), sizeof(info->bus_info));
+	if (wx->num_tx_queues <= WX_NUM_TX_QUEUES) {
+		info->n_stats = WX_STATS_LEN -
+				   (WX_NUM_TX_QUEUES - wx->num_tx_queues) *
+				   (sizeof(struct wx_queue_stats) / sizeof(u64)) * 2;
+	} else {
+		info->n_stats = WX_STATS_LEN;
+	}
 }
 EXPORT_SYMBOL(wx_get_drvinfo);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index e85538c69454..16d1a09369a6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -4,5 +4,13 @@
 #ifndef _WX_ETHTOOL_H_
 #define _WX_ETHTOOL_H_
 
+int wx_get_sset_count(struct net_device *netdev, int sset);
+void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data);
+void wx_get_ethtool_stats(struct net_device *netdev,
+			  struct ethtool_stats *stats, u64 *data);
+void wx_get_mac_stats(struct net_device *netdev,
+		      struct ethtool_eth_mac_stats *mac_stats);
+void wx_get_pause_stats(struct net_device *netdev,
+			struct ethtool_pause_stats *stats);
 void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index f0063d569c80..a3c5de9d547a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2001,6 +2001,105 @@ int wx_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
 }
 EXPORT_SYMBOL(wx_vlan_rx_kill_vid);
 
+/**
+ * wx_update_stats - Update the board statistics counters.
+ * @wx: board private structure
+ **/
+void wx_update_stats(struct wx *wx)
+{
+	struct wx_hw_stats *hwstats = &wx->stats;
+
+	u64 non_eop_descs = 0, alloc_rx_buff_failed = 0;
+	u64 hw_csum_rx_good = 0, hw_csum_rx_error = 0;
+	u64 restart_queue = 0, tx_busy = 0;
+	u32 i;
+
+	/* gather some stats to the wx struct that are per queue */
+	for (i = 0; i < wx->num_rx_queues; i++) {
+		struct wx_ring *rx_ring = wx->rx_ring[i];
+
+		non_eop_descs += rx_ring->rx_stats.non_eop_descs;
+		alloc_rx_buff_failed += rx_ring->rx_stats.alloc_rx_buff_failed;
+		hw_csum_rx_good += rx_ring->rx_stats.csum_good_cnt;
+		hw_csum_rx_error += rx_ring->rx_stats.csum_err;
+	}
+	wx->non_eop_descs = non_eop_descs;
+	wx->alloc_rx_buff_failed = alloc_rx_buff_failed;
+	wx->hw_csum_rx_error = hw_csum_rx_error;
+	wx->hw_csum_rx_good = hw_csum_rx_good;
+
+	for (i = 0; i < wx->num_tx_queues; i++) {
+		struct wx_ring *tx_ring = wx->tx_ring[i];
+
+		restart_queue += tx_ring->tx_stats.restart_queue;
+		tx_busy += tx_ring->tx_stats.tx_busy;
+	}
+	wx->restart_queue = restart_queue;
+	wx->tx_busy = tx_busy;
+
+	hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
+	hwstats->gptc += rd32(wx, WX_TDM_PKT_CNT);
+	hwstats->gorc += rd64(wx, WX_RDM_BYTE_CNT_LSB);
+	hwstats->gotc += rd64(wx, WX_TDM_BYTE_CNT_LSB);
+	hwstats->tpr += rd64(wx, WX_RX_FRAME_CNT_GOOD_BAD_L);
+	hwstats->tpt += rd64(wx, WX_TX_FRAME_CNT_GOOD_BAD_L);
+	hwstats->crcerrs += rd64(wx, WX_RX_CRC_ERROR_FRAMES_L);
+	hwstats->rlec += rd64(wx, WX_RX_LEN_ERROR_FRAMES_L);
+	hwstats->bprc += rd64(wx, WX_RX_BC_FRAMES_GOOD_L);
+	hwstats->bptc += rd64(wx, WX_TX_BC_FRAMES_GOOD_L);
+	hwstats->mprc += rd64(wx, WX_RX_MC_FRAMES_GOOD_L);
+	hwstats->mptc += rd64(wx, WX_TX_MC_FRAMES_GOOD_L);
+	hwstats->roc += rd32(wx, WX_RX_OVERSIZE_FRAMES_GOOD);
+	hwstats->ruc += rd32(wx, WX_RX_UNDERSIZE_FRAMES_GOOD);
+	hwstats->lxonoffrxc += rd32(wx, WX_MAC_LXONOFFRXC);
+	hwstats->lxontxc += rd32(wx, WX_RDB_LXONTXC);
+	hwstats->lxofftxc += rd32(wx, WX_RDB_LXOFFTXC);
+	hwstats->o2bgptc += rd32(wx, WX_TDM_OS2BMC_CNT);
+	hwstats->b2ospc += rd32(wx, WX_MNG_BMC2OS_CNT);
+	hwstats->o2bspc += rd32(wx, WX_MNG_OS2BMC_CNT);
+	hwstats->b2ogprc += rd32(wx, WX_RDM_BMC2OS_CNT);
+	hwstats->rdmdrop += rd32(wx, WX_RDM_DRP_PKT);
+
+	for (i = 0; i < wx->mac.max_rx_queues; i++)
+		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
+}
+EXPORT_SYMBOL(wx_update_stats);
+
+/**
+ *  wx_clear_hw_cntrs - Generic clear hardware counters
+ *  @wx: board private structure
+ *
+ *  Clears all hardware statistics counters by reading them from the hardware
+ *  Statistics counters are clear on read.
+ **/
+void wx_clear_hw_cntrs(struct wx *wx)
+{
+	u16 i = 0;
+
+	for (i = 0; i < wx->mac.max_rx_queues; i++)
+		wr32(wx, WX_PX_MPRC(i), 0);
+
+	rd32(wx, WX_RDM_PKT_CNT);
+	rd32(wx, WX_TDM_PKT_CNT);
+	rd64(wx, WX_RDM_BYTE_CNT_LSB);
+	rd32(wx, WX_TDM_BYTE_CNT_LSB);
+	rd32(wx, WX_RDM_DRP_PKT);
+	rd32(wx, WX_RX_UNDERSIZE_FRAMES_GOOD);
+	rd32(wx, WX_RX_OVERSIZE_FRAMES_GOOD);
+	rd64(wx, WX_RX_FRAME_CNT_GOOD_BAD_L);
+	rd64(wx, WX_TX_FRAME_CNT_GOOD_BAD_L);
+	rd64(wx, WX_RX_MC_FRAMES_GOOD_L);
+	rd64(wx, WX_TX_MC_FRAMES_GOOD_L);
+	rd64(wx, WX_RX_BC_FRAMES_GOOD_L);
+	rd64(wx, WX_TX_BC_FRAMES_GOOD_L);
+	rd64(wx, WX_RX_CRC_ERROR_FRAMES_L);
+	rd64(wx, WX_RX_LEN_ERROR_FRAMES_L);
+	rd32(wx, WX_RDB_LXONTXC);
+	rd32(wx, WX_RDB_LXOFFTXC);
+	rd32(wx, WX_MAC_LXONOFFRXC);
+}
+EXPORT_SYMBOL(wx_clear_hw_cntrs);
+
 /**
  *  wx_start_hw - Prepare hardware for Tx/Rx
  *  @wx: pointer to hardware structure
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 48d3ccabc272..12c20a7c364d 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -41,5 +41,7 @@ int wx_get_pcie_msix_counts(struct wx *wx, u16 *msix_count, u16 max_msix_count);
 int wx_sw_init(struct wx *wx);
 int wx_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid);
 int wx_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid);
+void wx_update_stats(struct wx *wx);
+void wx_clear_hw_cntrs(struct wx *wx);
 
 #endif /* _WX_HW_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index e04d4a5eed7b..2823861e5a92 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -488,6 +488,7 @@ static bool wx_is_non_eop(struct wx_ring *rx_ring,
 		return false;
 
 	rx_ring->rx_buffer_info[ntc].skb = skb;
+	rx_ring->rx_stats.non_eop_descs++;
 
 	return true;
 }
@@ -721,6 +722,7 @@ static int wx_clean_rx_irq(struct wx_q_vector *q_vector,
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
+			rx_ring->rx_stats.alloc_rx_buff_failed++;
 			rx_buffer->pagecnt_bias++;
 			break;
 		}
@@ -877,9 +879,11 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
 
 		if (__netif_subqueue_stopped(tx_ring->netdev,
 					     tx_ring->queue_index) &&
-		    netif_running(tx_ring->netdev))
+		    netif_running(tx_ring->netdev)) {
 			netif_wake_subqueue(tx_ring->netdev,
 					    tx_ring->queue_index);
+			++tx_ring->tx_stats.restart_queue;
+		}
 	}
 
 	return !!budget;
@@ -956,6 +960,7 @@ static int wx_maybe_stop_tx(struct wx_ring *tx_ring, u16 size)
 
 	/* A reprieve! - use start_queue because it doesn't call schedule */
 	netif_start_subqueue(tx_ring->netdev, tx_ring->queue_index);
+	++tx_ring->tx_stats.restart_queue;
 
 	return 0;
 }
@@ -1533,8 +1538,10 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 		count += TXD_USE_COUNT(skb_frag_size(&skb_shinfo(skb)->
 						     frags[f]));
 
-	if (wx_maybe_stop_tx(tx_ring, count + 3))
+	if (wx_maybe_stop_tx(tx_ring, count + 3)) {
+		tx_ring->tx_stats.tx_busy++;
 		return NETDEV_TX_BUSY;
+	}
 
 	/* record the location of the first descriptor for this packet */
 	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
@@ -2665,8 +2672,11 @@ void wx_get_stats64(struct net_device *netdev,
 		    struct rtnl_link_stats64 *stats)
 {
 	struct wx *wx = netdev_priv(netdev);
+	struct wx_hw_stats *hwstats;
 	int i;
 
+	wx_update_stats(wx);
+
 	rcu_read_lock();
 	for (i = 0; i < wx->num_rx_queues; i++) {
 		struct wx_ring *ring = READ_ONCE(wx->rx_ring[i]);
@@ -2702,6 +2712,12 @@ void wx_get_stats64(struct net_device *netdev,
 	}
 
 	rcu_read_unlock();
+
+	hwstats = &wx->stats;
+	stats->rx_errors = hwstats->crcerrs + hwstats->rlec;
+	stats->multicast = hwstats->qmprc;
+	stats->rx_length_errors = hwstats->rlec;
+	stats->rx_crc_errors = hwstats->crcerrs;
 }
 EXPORT_SYMBOL(wx_get_stats64);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index e3fc49284219..165e82de772e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -59,6 +59,25 @@
 #define WX_TS_ALARM_ST_DALARM        BIT(1)
 #define WX_TS_ALARM_ST_ALARM         BIT(0)
 
+/* statistic */
+#define WX_TX_FRAME_CNT_GOOD_BAD_L   0x1181C
+#define WX_TX_BC_FRAMES_GOOD_L       0x11824
+#define WX_TX_MC_FRAMES_GOOD_L       0x1182C
+#define WX_RX_FRAME_CNT_GOOD_BAD_L   0x11900
+#define WX_RX_BC_FRAMES_GOOD_L       0x11918
+#define WX_RX_MC_FRAMES_GOOD_L       0x11920
+#define WX_RX_CRC_ERROR_FRAMES_L     0x11928
+#define WX_RX_LEN_ERROR_FRAMES_L     0x11978
+#define WX_RX_UNDERSIZE_FRAMES_GOOD  0x11938
+#define WX_RX_OVERSIZE_FRAMES_GOOD   0x1193C
+#define WX_MAC_LXONOFFRXC            0x11E0C
+
+/*********************** Receive DMA registers **************************/
+#define WX_RDM_DRP_PKT               0x12500
+#define WX_RDM_PKT_CNT               0x12504
+#define WX_RDM_BYTE_CNT_LSB          0x12508
+#define WX_RDM_BMC2OS_CNT            0x12510
+
 /************************* Port Registers ************************************/
 /* port cfg Registers */
 #define WX_CFG_PORT_CTL              0x14400
@@ -94,6 +113,9 @@
 #define WX_TDM_CTL_TE                BIT(0) /* Transmit Enable */
 #define WX_TDM_PB_THRE(_i)           (0x18020 + ((_i) * 4))
 #define WX_TDM_RP_IDX                0x1820C
+#define WX_TDM_PKT_CNT               0x18308
+#define WX_TDM_BYTE_CNT_LSB          0x1830C
+#define WX_TDM_OS2BMC_CNT            0x18314
 #define WX_TDM_RP_RATE               0x18404
 
 /***************************** RDB registers *********************************/
@@ -106,6 +128,8 @@
 /* statistic */
 #define WX_RDB_PFCMACDAL             0x19210
 #define WX_RDB_PFCMACDAH             0x19214
+#define WX_RDB_LXOFFTXC              0x19218
+#define WX_RDB_LXONTXC               0x1921C
 /* ring assignment */
 #define WX_RDB_PL_CFG(_i)            (0x19300 + ((_i) * 4))
 #define WX_RDB_PL_CFG_L4HDR          BIT(1)
@@ -218,6 +242,8 @@
 #define WX_MNG_MBOX_CTL              0x1E044
 #define WX_MNG_MBOX_CTL_SWRDY        BIT(0)
 #define WX_MNG_MBOX_CTL_FWRDY        BIT(2)
+#define WX_MNG_BMC2OS_CNT            0x1E090
+#define WX_MNG_OS2BMC_CNT            0x1E094
 
 /************************************* ETH MAC *****************************/
 #define WX_MAC_TX_CFG                0x11000
@@ -301,6 +327,7 @@ enum WX_MSCA_CMD_value {
 #define WX_PX_RR_WP(_i)              (0x01008 + ((_i) * 0x40))
 #define WX_PX_RR_RP(_i)              (0x0100C + ((_i) * 0x40))
 #define WX_PX_RR_CFG(_i)             (0x01010 + ((_i) * 0x40))
+#define WX_PX_MPRC(_i)               (0x01020 + ((_i) * 0x40))
 /* PX_RR_CFG bit definitions */
 #define WX_PX_RR_CFG_VLAN            BIT(31)
 #define WX_PX_RR_CFG_SPLIT_MODE      BIT(26)
@@ -768,9 +795,16 @@ struct wx_queue_stats {
 	u64 bytes;
 };
 
+struct wx_tx_queue_stats {
+	u64 restart_queue;
+	u64 tx_busy;
+};
+
 struct wx_rx_queue_stats {
+	u64 non_eop_descs;
 	u64 csum_good_cnt;
 	u64 csum_err;
+	u64 alloc_rx_buff_failed;
 };
 
 /* iterator for handling rings in ring container */
@@ -814,6 +848,7 @@ struct wx_ring {
 	struct wx_queue_stats stats;
 	struct u64_stats_sync syncp;
 	union {
+		struct wx_tx_queue_stats tx_stats;
 		struct wx_rx_queue_stats rx_stats;
 	};
 } ____cacheline_internodealigned_in_smp;
@@ -845,6 +880,33 @@ enum wx_isb_idx {
 	WX_ISB_MAX
 };
 
+/* Statistics counters collected by the MAC */
+struct wx_hw_stats {
+	u64 gprc;
+	u64 gptc;
+	u64 gorc;
+	u64 gotc;
+	u64 tpr;
+	u64 tpt;
+	u64 bprc;
+	u64 bptc;
+	u64 mprc;
+	u64 mptc;
+	u64 roc;
+	u64 ruc;
+	u64 lxonoffrxc;
+	u64 lxontxc;
+	u64 lxofftxc;
+	u64 o2bgptc;
+	u64 b2ospc;
+	u64 o2bspc;
+	u64 b2ogprc;
+	u64 rdmdrop;
+	u64 crcerrs;
+	u64 rlec;
+	u64 qmprc;
+};
+
 struct wx {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 
@@ -920,6 +982,14 @@ struct wx {
 	u32 wol;
 
 	u16 bd_number;
+
+	struct wx_hw_stats stats;
+	u64 tx_busy;
+	u64 non_eop_descs;
+	u64 restart_queue;
+	u64 hw_csum_rx_good;
+	u64 hw_csum_rx_error;
+	u64 alloc_rx_buff_failed;
 };
 
 #define WX_INTR_ALL (~0ULL)
@@ -953,6 +1023,17 @@ wr32m(struct wx *wx, u32 reg, u32 mask, u32 field)
 	wr32(wx, reg, val);
 }
 
+static inline u64
+rd64(struct wx *wx, u32 reg)
+{
+	u64 lsb, msb;
+
+	lsb = rd32(wx, reg);
+	msb = rd32(wx, reg + 4);
+
+	return (lsb | msb << 32);
+}
+
 /* On some domestic CPU platforms, sometimes IO is not synchronized with
  * flushing memory, here use readl() to flush PCI read and write.
  */
-- 
2.27.0


