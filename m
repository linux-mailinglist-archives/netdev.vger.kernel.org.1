Return-Path: <netdev+bounces-203587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA09AF678F
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53247AE1F6
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198611C5D7A;
	Thu,  3 Jul 2025 01:52:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5924EA80;
	Thu,  3 Jul 2025 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507544; cv=none; b=FPxO7LOM9yLvpA8nRTx5ZkAfbNyC3wxgueCrkpWYhWAA0EdpS2I6L30LBz6KCjxJFen3BHr3g5Jrqsfo07NBcLbpwSmFceOfLU3TSksHZ7aoBSunvDhnFbGnAwBjyJxi2rM8JF5BCQyKLnBcFfEcbtrWSBQVTHgl+iaJlWdpG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507544; c=relaxed/simple;
	bh=1r+MM5LxhP85M349rKeCiNBVRTXnGgq76j9rvxSybn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8mKu2pWrbBKjpkIfE5XV3NgDnIvR712w9enYtONJrA1NkLfoD3czhuOLd29osvTEccb0WRvD8Yad9Ro4jUgkSanRM6u0pO668k4Fo3oGc6ZFdEmWwcXPSCaOC/+GuUomth/ft4yJ65R3k6KOnLTjgsSEAIzS8lKalHd9BXYliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507406t4d32d43c
X-QQ-Originating-IP: Ee29eVjraGbxx9oc0Nka5zWm1lLrbzewMyiIMFTEgdI=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:50:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2215868535102422593
EX-QQ-RecipientCnt: 22
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH 13/15] net: rnpgbe: Add base tx functions
Date: Thu,  3 Jul 2025 09:48:57 +0800
Message-Id: <20250703014859.210110-14-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703014859.210110-1-dong100@mucse.com>
References: <20250703014859.210110-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NRYSeI3Ux+UPEovXoG0KJZrxAX5hRf4jKz+iyUCEm4Z2arkky3qGgxKi
	jnA1zxtgtYkpix1ERX+gqKa5+YcXNL2NCv7pZ1Yi3UdkgrXvnlypoLYBj6vQiU8k02OkSJz
	/fF11YnowsQfhOhSRMDNFrUDobRQwe5vLML62LX2LVR3Dit/zuSIJZYHuYZXvTSaqjgcsPM
	jd45rzumFX/eiEXJqCVt9ctNqqeb+FUBVDitNDZg5DNce9nNjOAEYvskPJFDHh+mChbXfM2
	TBolCICqtuoSFO1/ZObNh+yNOV2ISw8QjsrcsNU4pRPizRH1LOEcphEhqU8cB7WPMpAl1iU
	gpW9H6uHEnPcRzu2IhafVZYlzlc2S3dXF8NJHBtYSIRQejGMd+o3Cipy9UyyLtW+GPBNhS7
	nVxPjMfONb6BG48RJpzUrjizwRr2ZT8ARc3YDagDhi0OZrbUq60+epIh+6gxzysVcbqLrjq
	Y2fs7swIPCgWDpcw7HArjImC5h538Qr/9YUZiuZ5w3Zm0yOnR2NZIPfgoLrHywzyw5eV6u3
	1V1QKgEtg9U0pQOqR5wt2y2gPEr/CBL+uqgMTSvO3N6smcMKjm/QBxSOiS/6umWMB7tu+CW
	7SMGsW/PfYlYgckEeZ41yEah6YnyKEt3+UhkVk1tl0DW9rFaR/ViNGWQyAk7YxA5inRw/00
	uaUh+yciIHXPk2+dnRb4S+GjcLz1te3OL8VodPk2PY3RxWeNpYMICXCXUhfZBE4RAEIRN/O
	zXpIOECY4CiFO1MybUrnWVlJ3k0NyQpJJcDGTvtVGelEitu96DO3NaEP2Yiok2xydOlHRuQ
	ajYgiVHI1HqOyQcCnisXcOdXp756iiHray/UtF2ihrIRk9rxSOvlW7FFKUiQSyRwTIdu2/3
	6HPWQ+DKZfV+ajVYhEHUtmTbb/bcwAmsj7HRdntZKwvYcujdgs0LkOXvpkxRYyt85Xtm4cV
	/AcpAeys6veIdeL8Bp4PyLcboG4Y8F3alNUlOrlVe8Aw8Zji0UadF+pALCyvzTpnogdXCaB
	f9ixHLY7F6I1ktbJ7N
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Initialize tx-map and tx clean functions

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  20 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  56 ++-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   6 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 406 +++++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  14 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  79 +++-
 6 files changed, 568 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 5ca2ec73bbe7..7871cb30db58 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -50,6 +50,7 @@ struct mucse_eth_operations {
 	s32 (*set_rar)(struct mucse_eth_info *eth, u32 index, u8 *addr);
 	s32 (*clear_rar)(struct mucse_eth_info *eth, u32 index);
 	void (*clr_mc_addr)(struct mucse_eth_info *eth);
+	void (*set_rx)(struct mucse_eth_info *eth, bool status);
 };
 
 #define RNPGBE_MAX_MTA 128
@@ -79,6 +80,7 @@ struct mucse_mac_info;
 
 struct mucse_mac_operations {
 	void (*set_mac)(struct mucse_mac_info *mac, u8 *addr, int index);
+	void (*set_mac_rx)(struct mucse_mac_info *mac, bool status);
 };
 
 struct mucse_mac_info {
@@ -221,6 +223,7 @@ struct mucse_hw_operations {
 	void (*set_mbx_ifup)(struct mucse_hw *hw, int enable);
 	void (*check_link)(struct mucse_hw *hw, u32 *speed, bool *link_up,
 			   bool *duplex);
+	void (*set_mac_rx)(struct mucse_hw *hw, bool status);
 };
 
 enum {
@@ -542,6 +545,8 @@ struct mucse_ring {
 
 struct mucse_ring_container {
 	struct mucse_ring *ring;
+	unsigned int total_bytes;
+	unsigned int total_packets;
 	u16 work_limit;
 	u16 count;
 };
@@ -623,11 +628,25 @@ struct rnpgbe_info {
 	void (*get_invariants)(struct mucse_hw *hw);
 };
 
+static inline u16 mucse_desc_unused(struct mucse_ring *ring)
+{
+	u16 ntc = ring->next_to_clean;
+	u16 ntu = ring->next_to_use;
+
+	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
+}
+
 static inline struct netdev_queue *txring_txq(const struct mucse_ring *ring)
 {
 	return netdev_get_tx_queue(ring->netdev, ring->queue_index);
 }
 
+static inline __le64 build_ctob(u32 vlan_cmd, u32 mac_ip_len, u32 size)
+{
+	return cpu_to_le64(((u64)vlan_cmd << 32) | ((u64)mac_ip_len << 16) |
+			   ((u64)size));
+}
+
 #define M_RXBUFFER_1536 (1536)
 static inline unsigned int mucse_rx_bufsz(struct mucse_ring *ring)
 {
@@ -688,6 +707,5 @@ static inline unsigned int mucse_rx_bufsz(struct mucse_ring *ring)
 #define MUCSE_ERR_INVALID_ARGUMENT (-1)
 
 void rnpgbe_service_event_schedule(struct mucse *mucse);
-int rnpgbe_poll(struct napi_struct *napi, int budget);
 
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index cb2448f497fe..edc3f697fa3a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -85,10 +85,23 @@ static void rnpgbe_eth_clr_mc_addr_n500(struct mucse_eth_info *eth)
 		eth_wr32(eth, RNPGBE_ETH_MUTICAST_HASH_TABLE(i), 0);
 }
 
+static void rnpgbe_eth_set_rx_n500(struct mucse_eth_info *eth,
+				   bool status)
+{
+	if (status) {
+		eth_wr32(eth, RNPGBE_ETH_EXCEPT_DROP_PROC, 0);
+		eth_wr32(eth, RNPGBE_ETH_TX_MUX_DROP, 0);
+	} else {
+		eth_wr32(eth, RNPGBE_ETH_EXCEPT_DROP_PROC, 1);
+		eth_wr32(eth, RNPGBE_ETH_TX_MUX_DROP, 1);
+	}
+}
+
 static struct mucse_eth_operations eth_ops_n500 = {
 	.set_rar = &rnpgbe_eth_set_rar_n500,
 	.clear_rar = &rnpgbe_eth_clear_rar_n500,
-	.clr_mc_addr = &rnpgbe_eth_clr_mc_addr_n500
+	.clr_mc_addr = &rnpgbe_eth_clr_mc_addr_n500,
+	.set_rx = &rnpgbe_eth_set_rx_n500,
 };
 
 /**
@@ -111,8 +124,31 @@ static void rnpgbe_mac_set_mac_n500(struct mucse_mac_info *mac,
 	mac_wr32(mac, RNPGBE_MAC_UNICAST_LOW(index), rar_low);
 }
 
+/**
+ * rnpgbe_mac_set_rx_n500 - Setup mac rx status
+ * @mac: pointer to mac structure
+ * @status: true for rx on/ false for rx off
+ *
+ * Setup mac rx status.
+ **/
+static void rnpgbe_mac_set_rx_n500(struct mucse_mac_info *mac,
+				   bool status)
+{
+	u32 value = mac_rd32(mac, R_MAC_CONTROL);
+
+	if (status)
+		value |= MAC_CONTROL_TE | MAC_CONTROL_RE;
+	else
+		value &= ~(MAC_CONTROL_RE);
+
+	mac_wr32(mac, R_MAC_CONTROL, value);
+	value = mac_rd32(mac, R_MAC_FRAME_FILTER);
+	mac_wr32(mac, R_MAC_FRAME_FILTER, value | 1);
+}
+
 static struct mucse_mac_operations mac_ops_n500 = {
 	.set_mac = &rnpgbe_mac_set_mac_n500,
+	.set_mac_rx = &rnpgbe_mac_set_rx_n500,
 };
 
 static int rnpgbe_init_hw_ops_n500(struct mucse_hw *hw)
@@ -318,6 +354,23 @@ static void rnpgbe_check_mac_link_hw_ops_n500(struct mucse_hw *hw,
 	*duplex = !!hw->duplex;
 }
 
+static void rnpgbe_set_mac_rx_hw_ops_n500(struct mucse_hw *hw, bool status)
+{
+	struct mucse_eth_info *eth = &hw->eth;
+	struct mucse_mac_info *mac = &hw->mac;
+
+	if (pci_channel_offline(hw->pdev))
+		return;
+
+	if (status) {
+		mac->ops.set_mac_rx(mac, status);
+		eth->ops.set_rx(eth, status);
+	} else {
+		eth->ops.set_rx(eth, status);
+		mac->ops.set_mac_rx(mac, status);
+	}
+}
+
 static struct mucse_hw_operations hw_ops_n500 = {
 	.init_hw = &rnpgbe_init_hw_ops_n500,
 	.reset_hw = &rnpgbe_reset_hw_ops_n500,
@@ -330,6 +383,7 @@ static struct mucse_hw_operations hw_ops_n500 = {
 	.set_mbx_link_event = &rnpgbe_set_mbx_link_event_hw_ops_n500,
 	.set_mbx_ifup = &rnpgbe_set_mbx_ifup_hw_ops_n500,
 	.check_link = &rnpgbe_check_mac_link_hw_ops_n500,
+	.set_mac_rx = &rnpgbe_set_mac_rx_hw_ops_n500,
 };
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 98031600801b..71a408c941e3 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -26,6 +26,8 @@
 #define RING_VECTOR(n) (0x04 * (n))
 
 /* eth regs */
+#define RNPGBE_ETH_TX_MUX_DROP (0x98)
+#define RNPGBE_ETH_EXCEPT_DROP_PROC (0x0470)
 #define RNPGBE_ETH_BYPASS (0x8000)
 #define RNPGBE_HOST_FILTER_EN (0x800c)
 #define RNPGBE_REDIR_EN (0x8030)
@@ -43,6 +45,10 @@
 #define RNPGBE_LEGANCY_ENABLE (0xd004)
 #define RNPGBE_LEGANCY_TIME (0xd000)
 /* mac regs */
+#define R_MAC_CONTROL (0)
+#define MAC_CONTROL_TE (0x8)
+#define MAC_CONTROL_RE (0x4)
+#define R_MAC_FRAME_FILTER (0x4)
 #define M_RAH_AV 0x80000000
 #define RNPGBE_MAC_UNICAST_LOW(i) (0x44 + (i) * 0x08)
 #define RNPGBE_MAC_UNICAST_HIGH(i) (0x40 + (i) * 0x08)
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index fec084e20513..1aab4cb0bbaa 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -131,6 +131,174 @@ static void mucse_add_ring(struct mucse_ring *ring,
 	head->count++;
 }
 
+/**
+ * rnpgbe_clean_tx_irq - Reclaim resources after transmit completes
+ * @q_vector: structure containing interrupt and ring information
+ * @tx_ring: tx ring to clean
+ * @napi_budget: how many packets driver is allowed to clean
+ **/
+static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
+				struct mucse_ring *tx_ring,
+				int napi_budget)
+{
+	struct mucse *mucse = q_vector->mucse;
+	struct mucse_tx_buffer *tx_buffer;
+	struct rnpgbe_tx_desc *tx_desc;
+	u64 total_bytes = 0, total_packets = 0;
+	int budget = q_vector->tx.work_limit;
+	int i = tx_ring->next_to_clean;
+
+	if (test_bit(__MUCSE_DOWN, &mucse->state))
+		return true;
+
+	tx_ring->tx_stats.poll_count++;
+	tx_buffer = &tx_ring->tx_buffer_info[i];
+	tx_desc = M_TX_DESC(tx_ring, i);
+	i -= tx_ring->count;
+
+	do {
+		struct rnpgbe_tx_desc *eop_desc = tx_buffer->next_to_watch;
+
+		/* if next_to_watch is not set then there is no work pending */
+		if (!eop_desc)
+			break;
+
+		/* prevent any other reads prior to eop_desc */
+		rmb();
+
+		/* if eop DD is not set pending work has not been completed */
+		if (!(eop_desc->vlan_cmd & cpu_to_le32(M_TXD_STAT_DD)))
+			break;
+		/* clear next_to_watch to prevent false hangs */
+		tx_buffer->next_to_watch = NULL;
+
+		/* update the statistics for this packet */
+		total_bytes += tx_buffer->bytecount;
+		total_packets += tx_buffer->gso_segs;
+
+		/* free the skb */
+		napi_consume_skb(tx_buffer->skb, napi_budget);
+
+		/* unmap skb header data */
+		dma_unmap_single(tx_ring->dev, dma_unmap_addr(tx_buffer, dma),
+				 dma_unmap_len(tx_buffer, len), DMA_TO_DEVICE);
+
+		/* clear tx_buffer data */
+		tx_buffer->skb = NULL;
+		dma_unmap_len_set(tx_buffer, len, 0);
+
+		/* unmap remaining buffers */
+		while (tx_desc != eop_desc) {
+			tx_buffer++;
+			tx_desc++;
+			i++;
+			if (unlikely(!i)) {
+				i -= tx_ring->count;
+				tx_buffer = tx_ring->tx_buffer_info;
+				tx_desc = M_TX_DESC(tx_ring, 0);
+			}
+
+			/* unmap any remaining paged data */
+			if (dma_unmap_len(tx_buffer, len)) {
+				dma_unmap_page(tx_ring->dev,
+					       dma_unmap_addr(tx_buffer, dma),
+					       dma_unmap_len(tx_buffer, len),
+					       DMA_TO_DEVICE);
+				dma_unmap_len_set(tx_buffer, len, 0);
+			}
+			budget--;
+		}
+
+		/* move us one more past the eop_desc for start of next pkt */
+		tx_buffer++;
+		tx_desc++;
+		i++;
+		if (unlikely(!i)) {
+			i -= tx_ring->count;
+			tx_buffer = tx_ring->tx_buffer_info;
+			tx_desc = M_TX_DESC(tx_ring, 0);
+		}
+
+		/* issue prefetch for next Tx descriptor */
+		prefetch(tx_desc);
+
+		/* update budget accounting */
+		budget--;
+	} while (likely(budget > 0));
+	netdev_tx_completed_queue(txring_txq(tx_ring), total_packets,
+				  total_bytes);
+	i += tx_ring->count;
+	tx_ring->next_to_clean = i;
+	u64_stats_update_begin(&tx_ring->syncp);
+	tx_ring->stats.bytes += total_bytes;
+	tx_ring->stats.packets += total_packets;
+	tx_ring->tx_stats.tx_clean_count += total_packets;
+	tx_ring->tx_stats.tx_clean_times++;
+	if (tx_ring->tx_stats.tx_clean_times > 10) {
+		tx_ring->tx_stats.tx_clean_times = 0;
+		tx_ring->tx_stats.tx_clean_count = 0;
+	}
+
+	u64_stats_update_end(&tx_ring->syncp);
+	q_vector->tx.total_bytes += total_bytes;
+	q_vector->tx.total_packets += total_packets;
+	tx_ring->tx_stats.send_done_bytes += total_bytes;
+
+#define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
+	if (likely(netif_carrier_ok(tx_ring->netdev) &&
+		   (mucse_desc_unused(tx_ring) >= TX_WAKE_THRESHOLD))) {
+		/* Make sure that anybody stopping the queue after this
+		 * sees the new next_to_clean.
+		 */
+		smp_mb();
+		if (__netif_subqueue_stopped(tx_ring->netdev,
+					     tx_ring->queue_index) &&
+		    !test_bit(__MUCSE_DOWN, &mucse->state)) {
+			netif_wake_subqueue(tx_ring->netdev,
+					    tx_ring->queue_index);
+			++tx_ring->tx_stats.restart_queue;
+		}
+	}
+
+	return total_bytes == 0;
+}
+
+/**
+ * rnpgbe_poll - NAPI Rx polling callback
+ * @napi: structure for representing this polling device
+ * @budget: how many packets driver is allowed to clean
+ *
+ * This function is used for legacy and MSI, NAPI mode
+ **/
+static int rnpgbe_poll(struct napi_struct *napi, int budget)
+{
+	struct mucse_q_vector *q_vector =
+		container_of(napi, struct mucse_q_vector, napi);
+	struct mucse *mucse = q_vector->mucse;
+	struct mucse_ring *ring;
+	int work_done = 0;
+	bool clean_complete = true;
+
+	mucse_for_each_ring(ring, q_vector->tx)
+		clean_complete = rnpgbe_clean_tx_irq(q_vector, ring, budget);
+
+	if (!netif_running(mucse->netdev))
+		clean_complete = true;
+	/* force done */
+	if (test_bit(__MUCSE_DOWN, &mucse->state))
+		clean_complete = true;
+
+	if (!clean_complete)
+		return budget;
+	/* all work done, exit the polling mode */
+	if (likely(napi_complete_done(napi, work_done))) {
+		if (!test_bit(__MUCSE_DOWN, &mucse->state))
+			rnpgbe_irq_enable_queues(mucse, q_vector);
+	}
+
+	return min(work_done, budget - 1);
+}
+
 /**
  * rnpgbe_alloc_q_vector - Allocate memory for a single interrupt vector
  * @mucse: pointer to private structure
@@ -863,8 +1031,14 @@ static void rnpgbe_configure_tx_ring(struct mucse *mucse,
  **/
 void rnpgbe_configure_tx(struct mucse *mucse)
 {
-	u32 i;
+	u32 i, dma_axi_ctl;
+	struct mucse_hw *hw = &mucse->hw;
+	struct mucse_dma_info *dma = &hw->dma;
 
+	/* dma_axi_en.tx_en must be before Tx queues are enabled */
+	dma_axi_ctl = dma_rd32(dma, DMA_AXI_EN);
+	dma_axi_ctl |= TX_AXI_RW_EN;
+	dma_wr32(dma, DMA_AXI_EN, dma_axi_ctl);
 	/* Setup the HW Tx Head and Tail descriptor pointers */
 	for (i = 0; i < (mucse->num_tx_queues); i++)
 		rnpgbe_configure_tx_ring(mucse, mucse->tx_ring[i]);
@@ -955,21 +1129,47 @@ static void rnpgbe_configure_rx_ring(struct mucse *mucse,
 }
 
 /**
- * rnpgbe_configure_rx - Configure 8259x Receive Unit after Reset
+ * rnpgbe_configure_rx - Configure Receive Unit after Reset
  * @mucse: pointer to private structure
  *
  * Configure the Rx unit of the MAC after a reset.
  **/
 void rnpgbe_configure_rx(struct mucse *mucse)
 {
-	int i;
+	int i, dma_axi_ctl;
+	struct mucse_hw *hw = &mucse->hw;
+	struct mucse_dma_info *dma = &hw->dma;
 
 	for (i = 0; i < mucse->num_rx_queues; i++)
 		rnpgbe_configure_rx_ring(mucse, mucse->rx_ring[i]);
+
+	/* dma_axi_en.tx_en must be before Tx queues are enabled */
+	dma_axi_ctl = dma_rd32(dma, DMA_AXI_EN);
+	dma_axi_ctl |= RX_AXI_RW_EN;
+	dma_wr32(dma, DMA_AXI_EN, dma_axi_ctl);
+}
+
+/**
+ * rnpgbe_clean_all_tx_rings - Free Tx Buffers for all queues
+ * @adapter: board private structure
+ **/
+void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
+{
+	int i;
+
+	for (i = 0; i < mucse->num_tx_queues; i++)
+		rnpgbe_clean_tx_ring(mucse->tx_ring[i]);
 }
 
 static irqreturn_t rnpgbe_msix_clean_rings(int irq, void *data)
 {
+	struct mucse_q_vector *q_vector = (struct mucse_q_vector *)data;
+
+	rnpgbe_irq_disable_queues(q_vector);
+
+	if (q_vector->rx.ring || q_vector->tx.ring)
+		napi_schedule_irqoff(&q_vector->napi);
+
 	return IRQ_HANDLED;
 }
 
@@ -1238,3 +1438,203 @@ void rnpgbe_configure_msix(struct mucse *mucse)
 		}
 	}
 }
+
+static void rnpgbe_unmap_and_free_tx_resource(struct mucse_ring *ring,
+					      struct mucse_tx_buffer *tx_buffer)
+{
+	if (tx_buffer->skb) {
+		dev_kfree_skb_any(tx_buffer->skb);
+		if (dma_unmap_len(tx_buffer, len))
+			dma_unmap_single(ring->dev,
+					 dma_unmap_addr(tx_buffer, dma),
+					 dma_unmap_len(tx_buffer, len),
+					 DMA_TO_DEVICE);
+	} else if (dma_unmap_len(tx_buffer, len)) {
+		dma_unmap_page(ring->dev, dma_unmap_addr(tx_buffer, dma),
+			       dma_unmap_len(tx_buffer, len), DMA_TO_DEVICE);
+	}
+	tx_buffer->next_to_watch = NULL;
+	tx_buffer->skb = NULL;
+	dma_unmap_len_set(tx_buffer, len, 0);
+}
+
+static int rnpgbe_tx_map(struct mucse_ring *tx_ring,
+			 struct mucse_tx_buffer *first, u32 mac_ip_len,
+			 u32 tx_flags)
+{
+	struct sk_buff *skb = first->skb;
+	struct mucse_tx_buffer *tx_buffer;
+	struct rnpgbe_tx_desc *tx_desc;
+	skb_frag_t *frag;
+	dma_addr_t dma;
+	unsigned int data_len, size;
+	u16 i = tx_ring->next_to_use;
+	u64 fun_id = ((u64)(tx_ring->pfvfnum) << (56));
+
+	tx_desc = M_TX_DESC(tx_ring, i);
+	size = skb_headlen(skb);
+	data_len = skb->data_len;
+	dma = dma_map_single(tx_ring->dev, skb->data, size, DMA_TO_DEVICE);
+	tx_buffer = first;
+
+	for (frag = &skb_shinfo(skb)->frags[0];; frag++) {
+		if (dma_mapping_error(tx_ring->dev, dma))
+			goto dma_error;
+
+		/* record length, and DMA address */
+		dma_unmap_len_set(tx_buffer, len, size);
+		dma_unmap_addr_set(tx_buffer, dma, dma);
+
+		/* 1st desc */
+		tx_desc->pkt_addr = cpu_to_le64(dma | fun_id);
+
+		while (unlikely(size > M_MAX_DATA_PER_TXD)) {
+			tx_desc->vlan_cmd_bsz = build_ctob(tx_flags,
+							   mac_ip_len,
+							   M_MAX_DATA_PER_TXD);
+			i++;
+			tx_desc++;
+			if (i == tx_ring->count) {
+				tx_desc = M_TX_DESC(tx_ring, 0);
+				i = 0;
+			}
+			dma += M_MAX_DATA_PER_TXD;
+			size -= M_MAX_DATA_PER_TXD;
+			tx_desc->pkt_addr = cpu_to_le64(dma | fun_id);
+		}
+
+		if (likely(!data_len))
+			break;
+		tx_desc->vlan_cmd_bsz = build_ctob(tx_flags, mac_ip_len, size);
+		/* ==== frag== */
+		i++;
+		tx_desc++;
+		if (i == tx_ring->count) {
+			tx_desc = M_TX_DESC(tx_ring, 0);
+			i = 0;
+		}
+
+		size = skb_frag_size(frag);
+		data_len -= size;
+		dma = skb_frag_dma_map(tx_ring->dev, frag, 0, size,
+				       DMA_TO_DEVICE);
+		tx_buffer = &tx_ring->tx_buffer_info[i];
+	}
+
+	/* write last descriptor with RS and EOP bits */
+	tx_desc->vlan_cmd_bsz = build_ctob(tx_flags | M_TXD_CMD_EOP | M_TXD_CMD_RS,
+					   mac_ip_len, size);
+	/* set the timestamp */
+	first->time_stamp = jiffies;
+	tx_ring->tx_stats.send_bytes += first->bytecount;
+
+	/*
+	 * Force memory writes to complete before letting h/w know there
+	 * are new descriptors to fetch.  (Only applicable for weak-ordered
+	 * memory model archs, such as IA-64).
+	 *
+	 * We also need this memory barrier to make certain all of the
+	 * status bits have been updated before next_to_watch is written.
+	 */
+	/* timestamp the skb as late as possible, just prior to notifying
+	 * the MAC that it should transmit this packet
+	 */
+	wmb();
+	/* set next_to_watch value indicating a packet is present */
+	first->next_to_watch = tx_desc;
+	i++;
+	if (i == tx_ring->count)
+		i = 0;
+	tx_ring->next_to_use = i;
+	skb_tx_timestamp(skb);
+	netdev_tx_sent_queue(txring_txq(tx_ring), first->bytecount);
+	/* notify HW of packet */
+	m_wr_reg(tx_ring->tail, i);
+	return 0;
+dma_error:
+	/* clear dma mappings for failed tx_buffer_info map */
+	for (;;) {
+		tx_buffer = &tx_ring->tx_buffer_info[i];
+		rnpgbe_unmap_and_free_tx_resource(tx_ring, tx_buffer);
+		if (tx_buffer == first)
+			break;
+		if (i == 0)
+			i += tx_ring->count;
+		i--;
+	}
+	dev_kfree_skb_any(first->skb);
+	first->skb = NULL;
+	tx_ring->next_to_use = i;
+
+	return -1;
+}
+
+static int __rnpgbe_maybe_stop_tx(struct mucse_ring *tx_ring, u16 size)
+{
+	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
+	/* Herbert's original patch had:
+	 *  smp_mb__after_netif_stop_queue();
+	 * but since that doesn't exist yet, just open code it.
+	 */
+	smp_mb();
+
+	/* We need to check again in a case another CPU has just
+	 * made room available.
+	 */
+	if (likely(mucse_desc_unused(tx_ring) < size))
+		return -EBUSY;
+
+	/* A reprieve! - use start_queue because it doesn't call schedule */
+	netif_start_subqueue(tx_ring->netdev, tx_ring->queue_index);
+	++tx_ring->tx_stats.restart_queue;
+
+	return 0;
+}
+
+static inline int rnpgbe_maybe_stop_tx(struct mucse_ring *tx_ring, u16 size)
+{
+	if (likely(mucse_desc_unused(tx_ring) >= size))
+		return 0;
+	return __rnpgbe_maybe_stop_tx(tx_ring, size);
+}
+
+netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
+				   struct mucse *mucse,
+				   struct mucse_ring *tx_ring)
+{
+	struct mucse_tx_buffer *first;
+	u16 count = TXD_USE_COUNT(skb_headlen(skb));
+	/* keep it not zero */
+	u32 mac_ip_len = 20;
+	u32 tx_flags = 0;
+	unsigned short f;
+
+	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++) {
+		skb_frag_t *frag_temp = &skb_shinfo(skb)->frags[f];
+
+		count += TXD_USE_COUNT(skb_frag_size(frag_temp));
+	}
+
+	if (rnpgbe_maybe_stop_tx(tx_ring, count + 3)) {
+		tx_ring->tx_stats.tx_busy++;
+		return NETDEV_TX_BUSY;
+	}
+
+	/* record the location of the first descriptor for this packet */
+	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
+	first->skb = skb;
+	/* maybe consider len smaller than 60 */
+	first->bytecount = (skb->len > 60) ? skb->len : 60;
+	first->gso_segs = 1;
+	first->priv_tags = 0;
+	first->mss_len_vf_num = 0;
+	first->inner_vlan_tunnel_len = 0;
+	first->ctx_flag = false;
+
+	if (rnpgbe_tx_map(tx_ring, first, mac_ip_len, tx_flags))
+		goto skip_check;
+	rnpgbe_maybe_stop_tx(tx_ring, DESC_NEEDED);
+
+skip_check:
+	return NETDEV_TX_OK;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 65bd97c26eaf..7179e5ebfbf0 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -8,6 +8,9 @@
 
 #define RING_OFFSET(n) (0x100 * (n))
 #define DMA_DUMY (0xc)
+#define DMA_AXI_EN (0x10)
+#define RX_AXI_RW_EN (0x03 << 0)
+#define TX_AXI_RW_EN (0x03 << 2)
 #define DMA_RX_START (0x10)
 #define DMA_RX_READY (0x14)
 #define DMA_TX_START (0x18)
@@ -52,6 +55,12 @@
 #define e_info(msglvl, format, arg...)  \
 	netif_info(mucse, msglvl, mucse->netdev, format, ##arg)
 
+/* now tx max 4k for one desc */
+#define M_MAX_TXD_PWR 12
+#define M_MAX_DATA_PER_TXD (0x1 << M_MAX_TXD_PWR)
+#define TXD_USE_COUNT(S) DIV_ROUND_UP((S), M_MAX_DATA_PER_TXD)
+#define DESC_NEEDED (MAX_SKB_FRAGS + 4)
+
 enum link_event_mask {
 	EVT_LINK_UP = 1,
 	EVT_NO_MEDIA = 2,
@@ -119,6 +128,7 @@ void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
 int rnpgbe_setup_txrx(struct mucse *mucse);
 void rnpgbe_free_txrx(struct mucse *mucse);
 void rnpgbe_configure_tx(struct mucse *mucse);
+void rnpgbe_clean_all_tx_rings(struct mucse *mucse);
 void rnpgbe_disable_rx_queue(struct mucse_ring *ring);
 void rnpgbe_configure_rx(struct mucse *mucse);
 int rnpgbe_request_irq(struct mucse *mucse);
@@ -126,5 +136,7 @@ void rnpgbe_free_irq(struct mucse *mucse);
 void rnpgbe_napi_enable_all(struct mucse *mucse);
 void rnpgbe_napi_disable_all(struct mucse *mucse);
 void rnpgbe_configure_msix(struct mucse *mucse);
-
+netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
+				   struct mucse *mucse,
+				   struct mucse_ring *tx_ring);
 #endif /* _RNPGBE_LIB_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index c2f53af3de09..ea41a758ac49 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -166,12 +166,14 @@ static void rnpgbe_watchdog_update_link(struct mucse *mucse)
 static void rnpgbe_watchdog_link_is_up(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
 
 	/* only continue if link was previously down */
 	if (netif_carrier_ok(netdev))
 		return;
 	netif_carrier_on(netdev);
 	netif_tx_wake_all_queues(netdev);
+	hw->ops.set_mac_rx(hw, true);
 }
 
 /**
@@ -182,6 +184,7 @@ static void rnpgbe_watchdog_link_is_up(struct mucse *mucse)
 static void rnpgbe_watchdog_link_is_down(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
 
 	mucse->link_up = false;
 	mucse->link_speed = 0;
@@ -191,6 +194,7 @@ static void rnpgbe_watchdog_link_is_down(struct mucse *mucse)
 	e_info(drv, "NIC Link is Down\n");
 	netif_carrier_off(netdev);
 	netif_tx_stop_all_queues(netdev);
+	hw->ops.set_mac_rx(hw, false);
 }
 
 /**
@@ -224,11 +228,6 @@ static void rnpgbe_service_task(struct work_struct *work)
 	rnpgbe_service_event_complete(mucse);
 }
 
-int rnpgbe_poll(struct napi_struct *napi, int budget)
-{
-	return 0;
-}
-
 /**
  * rnpgbe_check_fw_from_flash - Check chip-id and bin-id
  * @hw: hardware structure
@@ -418,6 +417,7 @@ static void rnpgbe_down(struct mucse *mucse)
 	struct net_device *netdev = mucse->netdev;
 
 	set_bit(__MUCSE_DOWN, &mucse->state);
+	hw->ops.set_mac_rx(hw, false);
 	hw->ops.set_mbx_link_event(hw, 0);
 	hw->ops.set_mbx_ifup(hw, 0);
 	if (netif_carrier_ok(netdev))
@@ -425,6 +425,7 @@ static void rnpgbe_down(struct mucse *mucse)
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
 	rnpgbe_irq_disable(mucse);
+
 	netif_tx_disable(netdev);
 	rnpgbe_napi_disable_all(mucse);
 	mucse->flags &= ~M_FLAG_NEED_LINK_UPDATE;
@@ -453,14 +454,78 @@ static int rnpgbe_close(struct net_device *netdev)
 static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
 				     struct net_device *netdev)
 {
-	dev_kfree_skb_any(skb);
-	return NETDEV_TX_OK;
+	struct mucse *mucse = netdev_priv(netdev);
+	struct mucse_ring *tx_ring;
+
+	if (!netif_carrier_ok(netdev)) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+	if (skb->len < 33) {
+		if (skb_padto(skb, 33))
+			return NETDEV_TX_OK;
+		skb->len = 33;
+	}
+	if (skb->len > 65535) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+	tx_ring = mucse->tx_ring[skb->queue_mapping];
+	return rnpgbe_xmit_frame_ring(skb, mucse, tx_ring);
+}
+
+static void rnpgbe_get_stats64(struct net_device *netdev,
+			       struct rtnl_link_stats64 *stats)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+	int i;
+
+	rcu_read_lock();
+	for (i = 0; i < mucse->num_rx_queues; i++) {
+		struct mucse_ring *ring = READ_ONCE(mucse->rx_ring[i]);
+		u64 bytes, packets;
+		unsigned int start;
+
+		if (ring) {
+			do {
+				start = u64_stats_fetch_begin(&ring->syncp);
+				packets = ring->stats.packets;
+				bytes = ring->stats.bytes;
+			} while (u64_stats_fetch_retry(&ring->syncp, start));
+			stats->rx_packets += packets;
+			stats->rx_bytes += bytes;
+		}
+	}
+
+	for (i = 0; i < mucse->num_tx_queues; i++) {
+		struct mucse_ring *ring = READ_ONCE(mucse->tx_ring[i]);
+		u64 bytes, packets;
+		unsigned int start;
+
+		if (ring) {
+			do {
+				start = u64_stats_fetch_begin(&ring->syncp);
+				packets = ring->stats.packets;
+				bytes = ring->stats.bytes;
+			} while (u64_stats_fetch_retry(&ring->syncp, start));
+			stats->tx_packets += packets;
+			stats->tx_bytes += bytes;
+		}
+	}
+	rcu_read_unlock();
+	/* following stats updated by rnpgbe_watchdog_task() */
+	stats->multicast = netdev->stats.multicast;
+	stats->rx_errors = netdev->stats.rx_errors;
+	stats->rx_length_errors = netdev->stats.rx_length_errors;
+	stats->rx_crc_errors = netdev->stats.rx_crc_errors;
+	stats->rx_missed_errors = netdev->stats.rx_missed_errors;
 }
 
 const struct net_device_ops rnpgbe_netdev_ops = {
 	.ndo_open = rnpgbe_open,
 	.ndo_stop = rnpgbe_close,
 	.ndo_start_xmit = rnpgbe_xmit_frame,
+	.ndo_get_stats64 = rnpgbe_get_stats64,
 };
 
 static void rnpgbe_assign_netdev_ops(struct net_device *dev)
-- 
2.25.1


