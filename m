Return-Path: <netdev+bounces-285183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJXBC61K/GmZNwAAu9opvQ
	(envelope-from <netdev+bounces-285183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:17:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD54E4A2B
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66CAA3014865
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC63E34887B;
	Thu,  7 May 2026 08:17:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A3B32E6BB;
	Thu,  7 May 2026 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141858; cv=none; b=ZEczi//KELBMnWYx79zC66j3aRM2LfCGs1afrgm42MP2+ExfgCTsgpI4pcsmjUT33xFdowRTeUUQrapE6ex80TRg8uBKXjoRnWl/BvqrR9peFav1GDRJtID6DMZV7r39pQ8ShCqAe1OROPENIamxMrrz/3+sUx78/RbfJnQlpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141858; c=relaxed/simple;
	bh=z68g64ikAGszKlud0du2J7DUqBbH9Nd08AEeJKLWEuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ppD5JnOOm8x40ViwswfJ4h4K7gKJtINsAzumc4OtN4rVfgkKXmw1uIcOLpngVwPQHoKOqmDbJ6VkMH0GbBWx/X38iHQ+Z5jMwRg7lVoMazhobo5lfXrWTdV00hUHE0Z5VC9lw9tlkZ5kcogEaeybmXi46SH1NHSa0W4Z19w0gBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1778141758t61c2de93
X-QQ-Originating-IP: vMy1IB82cAfiu2oobkveuCauj377T7loz6XvHsch1S0=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 May 2026 16:15:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6538994593496832807
EX-QQ-RecipientCnt: 12
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v3 2/4] net: rnpgbe: Add basic TX packet transmission support
Date: Thu,  7 May 2026 16:15:37 +0800
Message-Id: <20260507081539.171844-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260507081539.171844-1-dong100@mucse.com>
References: <20260507081539.171844-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OG0WlE0zuF8HiLtdlF8/n2GWnPXgTXY9wGTiE1Y2pby0+HFkscftZjOP
	2fC1fvCazLdq/0e2fN8nWiGX8/ktEUj2RuldzHi5N74vYbkP0qhIxOBcA4cZElVuRiChTY0
	CjqwjI+iEObS8PmIG8eqPbYmzWlaJ3kiOZSjxTW6wvta8RPfwBdNIvlf6DgaRIeeA1kIJqK
	HlyQdFbRjz6EIJdR3/uAotAiFFJGwBCcCdM2h0oGnOtPbfCrRkChXY5UZcsllnWTi2Aj827
	X9hrSAKvH7tzOnzqDvy2ULM0mzyXPwIMFbwFvbAXQF/GVzJcyzoxADzTrmRU4eaQ7lbDLx9
	2U1kK+FYBqntVGD5WsLmwb/yofDE6MgzNJ2jYgLBMOiGq77elLX5JbDE9OMiVB4A8n0qLV2
	4GWuiNOhZe/tDKC7HAZHjUurpU39Cg8VCbH+q0zKBYlOcpwEO64omAeHFdI8Gf+/KkY9lwM
	yxPrCiNIXrCX6CtrJZS6uiVyroHfXuJgoQDNlEykIL/34WvYTetmIv/T9/t3olGeaoJKn9/
	dtfen4n/LRu7vQoUuQRqCvmPLXriZqoWbWfadSnG+s8pBe/+/vywr9M65unxbn8AkAXbroq
	zB9rlXln+VRJu00Z8xeMN08Q1n/H7vzu7nWy/ekVMJg2ZSFpMHBsGWfF+HHwXGXX5MotvX3
	ecKXbPhj4wRxxKcNYigrKEM9GvtDhcfwpafNg5bXg0q+XRf3OftTq0J+7UC6bAvlBn2tWpi
	Hg9xRC/GLEwIUFiUFfQ6p8NMVRa5io5Q4kEv0/OFIVXkLf7tD/OQx4ehbN4qSY0GmDw5qGM
	vVvDJ5Ha5haL03OiN33CpvzldMAxi39mdgnkEj1yquwemSoONS2lMnT7yyZibxicx8MnySH
	b8HQyBrdh0KK3IrtwST5FQKZAaxWTQMcJnS4igz0CUXDoTOPGpO0fTK2GhKQDraRAvbZv6w
	eBK84UCQ4gd9NIwz2KdvDE9yyIcIljtI+kvUS+tVVrR+pU/YZiVdqE+JtQ8H4YIbr5tHpk3
	QlsnuwI7gnzc76hD7+ncxEs3IsqMdkdtT0vrzvuFiUE4hdRiWnCxWQW0S+avxQr8JzGl55G
	w==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: B8CD54E4A2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mucse.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285183-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Implement basic transmit path for the RNPGBE driver:
- Add TX descriptor structure (rnpgbe_tx_desc) and TX buffer management
- Implement rnpgbe_xmit_frame_ring() for packet transmission
- Add TX ring resource allocation and cleanup functions
- Implement TX completion handling via rnpgbe_clean_tx_irq()
- Implement statistics collection for TX packets/bytes

This enables basic packet transmission functionality for the RNPGBE driver.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  79 ++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   4 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   3 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 597 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  27 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  33 +-
 6 files changed, 734 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index cbe60f168346..45eacaba6c55 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -43,20 +43,85 @@ struct mucse_hw {
 	struct pci_dev *pdev;
 	struct mucse_mbx_info mbx;
 	int port;
+	u16 cycles_per_us;
 	u8 pfvfnum;
 };
 
+struct rnpgbe_tx_desc {
+	__le64 pkt_addr; /* Packet buffer address */
+	union {
+		__le64 vlan_cmd_bsz;
+		struct {
+			__le32 blen_mac_ip_len;
+			__le32 vlan_cmd; /* vlan & cmd status */
+		};
+	};
+#define M_TXD_CMD_RS          0x040000 /* Report Status */
+#define M_TXD_STAT_DD         0x020000 /* Descriptor Done */
+#define M_TXD_CMD_EOP         0x010000 /* End of Packet */
+};
+
+#define M_TX_DESC(R, i) (&(((struct rnpgbe_tx_desc *)((R)->desc))[i]))
+
+struct mucse_tx_buffer {
+	struct rnpgbe_tx_desc *next_to_watch;
+	struct sk_buff *skb;
+	unsigned int bytecount;
+	unsigned short gso_segs;
+	DEFINE_DMA_UNMAP_ADDR(dma);
+	DEFINE_DMA_UNMAP_LEN(len);
+	bool mapped_as_page;  /* true if dma was mapped with dma_map_page */
+};
+
+struct mucse_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 dropped;
+};
+
 struct mucse_ring {
 	struct mucse_ring *next;
 	struct mucse_q_vector *q_vector;
+	struct net_device *netdev;
+	struct device *dev;
+	void *desc;
+	struct mucse_tx_buffer *tx_buffer_info;
 	void __iomem *ring_addr;
+	void __iomem *tail;
 	void __iomem *irq_mask;
 	void __iomem *trig;
 	u8 queue_index;
 	/* hw ring idx */
 	u8 rnpgbe_queue_idx;
+	u8 pfvfnum;
+	u16 count;
+	u16 next_to_use;
+	u16 next_to_clean;
+	dma_addr_t dma;
+	unsigned int size;
+	struct mucse_queue_stats stats;
+	struct u64_stats_sync syncp;
 } ____cacheline_internodealigned_in_smp;
 
+static inline u16 mucse_desc_unused(struct mucse_ring *ring)
+{
+	u16 ntc = ring->next_to_clean;
+	u16 ntu = ring->next_to_use;
+
+	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
+}
+
+static inline __le64 build_ctob(u32 vlan_cmd, u32 mac_ip_len, u32 size)
+{
+	return cpu_to_le64(((u64)vlan_cmd << 32) | ((u64)mac_ip_len << 16) |
+			   ((u64)size));
+}
+
+static inline struct netdev_queue *txring_txq(const struct mucse_ring *ring)
+{
+	return netdev_get_tx_queue(ring->netdev, ring->queue_index);
+}
+
 struct mucse_ring_container {
 	struct mucse_ring *ring;
 	u16 count;
@@ -72,17 +137,15 @@ struct mucse_q_vector {
 	struct mucse_ring ring[] ____cacheline_internodealigned_in_smp;
 };
 
-struct mucse_stats {
-	u64 tx_dropped;
-};
-
 #define MAX_Q_VECTORS 8
 
+#define M_DEFAULT_TXD     512
+#define M_DEFAULT_TX_WORK 256
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 	struct mucse_hw hw;
-	struct mucse_stats stats;
 #define M_FLAG_MSI_EN              BIT(0)
 #define M_FLAG_MSIX_SINGLE_EN      BIT(1)
 #define M_FLAG_MSIX_EN             BIT(2)
@@ -92,6 +155,8 @@ struct mucse {
 	struct mucse_ring *rx_ring[RNPGBE_MAX_QUEUES]
 		____cacheline_aligned_in_smp;
 	struct mucse_q_vector *q_vector[MAX_Q_VECTORS];
+	int tx_ring_item_count;
+	int tx_work_limit;
 	int num_tx_queues;
 	int num_q_vectors;
 	int num_rx_queues;
@@ -116,4 +181,8 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 	writel((val), (hw)->hw_addr + (reg))
 #define mucse_hw_rd32(hw, reg) \
 	readl((hw)->hw_addr + (reg))
+#define mucse_ring_wr32(ring, reg, val) \
+	writel((val), (ring)->ring_addr + (reg))
+#define mucse_ring_rd32(ring, reg) \
+	readl((ring)->ring_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 921cc325a991..291e77d573fe 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -93,6 +93,8 @@ static void rnpgbe_init_n500(struct mucse_hw *hw)
 
 	mbx->fwpf_ctrl_base = MUCSE_N500_FWPF_CTRL_BASE;
 	mbx->fwpf_shm_base = MUCSE_N500_FWPF_SHM_BASE;
+
+	hw->cycles_per_us = M_DEFAULT_N500_MHZ;
 }
 
 /**
@@ -110,6 +112,8 @@ static void rnpgbe_init_n210(struct mucse_hw *hw)
 
 	mbx->fwpf_ctrl_base = MUCSE_N210_FWPF_CTRL_BASE;
 	mbx->fwpf_shm_base = MUCSE_N210_FWPF_SHM_BASE;
+
+	hw->cycles_per_us = M_DEFAULT_N210_MHZ;
 }
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 0dce78e4a91b..cbc593902030 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -7,12 +7,15 @@
 #define MUCSE_N500_FWPF_CTRL_BASE      0x28b00
 #define MUCSE_N500_FWPF_SHM_BASE       0x2d000
 #define MUCSE_N500_RING_MSIX_BASE      0x28700
+#define M_DEFAULT_N500_MHZ             125
 #define MUCSE_GBE_PFFW_MBX_CTRL_OFFSET 0x5500
 #define MUCSE_GBE_FWPF_MBX_MASK_OFFSET 0x5700
 #define MUCSE_N210_FWPF_CTRL_BASE      0x29400
 #define MUCSE_N210_FWPF_SHM_BASE       0x2d900
 #define MUCSE_N210_RING_MSIX_BASE      0x29000
+#define M_DEFAULT_N210_MHZ             62
 
+#define TX_AXI_RW_EN                   0xc
 #define RNPGBE_DMA_AXI_EN              0x0010
 
 #define RNPGBE_MAX_QUEUES 8
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 329c8ea0dcbe..c0873f0bff20 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -3,6 +3,7 @@
 
 #include <linux/pci.h>
 #include <linux/netdevice.h>
+#include <linux/vmalloc.h>
 
 #include "rnpgbe_lib.h"
 #include "rnpgbe.h"
@@ -46,6 +47,120 @@ static void rnpgbe_irq_enable_queues(struct mucse_q_vector *q_vector)
 	}
 }
 
+/**
+ * rnpgbe_clean_tx_irq - Reclaim resources after transmit completes
+ * @q_vector: structure containing interrupt and ring information
+ * @tx_ring: tx ring to clean
+ * @napi_budget: Used to determine if we are in netpoll
+ *
+ * @return: true is for work done within budget, otherwise false
+ **/
+static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
+				struct mucse_ring *tx_ring,
+				int napi_budget)
+{
+	int budget = q_vector->mucse->tx_work_limit;
+	u64 total_bytes = 0, total_packets = 0;
+	struct mucse_tx_buffer *tx_buffer;
+	struct rnpgbe_tx_desc *tx_desc;
+	int i = tx_ring->next_to_clean;
+
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
+		total_bytes += tx_buffer->bytecount;
+		total_packets += tx_buffer->gso_segs;
+		napi_consume_skb(tx_buffer->skb, napi_budget);
+		if (tx_buffer->mapped_as_page) {
+			dma_unmap_page(tx_ring->dev,
+				       dma_unmap_addr(tx_buffer, dma),
+				       dma_unmap_len(tx_buffer, len),
+				       DMA_TO_DEVICE);
+		} else {
+			dma_unmap_single(tx_ring->dev,
+					 dma_unmap_addr(tx_buffer, dma),
+					 dma_unmap_len(tx_buffer, len),
+					 DMA_TO_DEVICE);
+		}
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
+		prefetch(tx_desc);
+		budget--;
+	} while (likely(budget > 0));
+	netdev_tx_completed_queue(txring_txq(tx_ring), total_packets,
+				  total_bytes);
+	i += tx_ring->count;
+	tx_ring->next_to_clean = i;
+	u64_stats_update_begin(&tx_ring->syncp);
+	tx_ring->stats.bytes += total_bytes;
+	tx_ring->stats.packets += total_packets;
+	u64_stats_update_end(&tx_ring->syncp);
+
+#define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
+	if (likely(netif_carrier_ok(tx_ring->netdev) &&
+		   (mucse_desc_unused(tx_ring) >= TX_WAKE_THRESHOLD))) {
+		/* Make sure that anybody stopping the queue after this
+		 * sees the new next_to_clean.
+		 */
+		smp_mb();
+		if (__netif_subqueue_stopped(tx_ring->netdev,
+					     tx_ring->queue_index)) {
+			netif_wake_subqueue(tx_ring->netdev,
+					    tx_ring->queue_index);
+		}
+	}
+
+	return !!budget;
+}
+
 /**
  * rnpgbe_poll - NAPI Rx polling callback
  * @napi: structure for representing this polling device
@@ -58,12 +173,22 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 {
 	struct mucse_q_vector *q_vector =
 		container_of(napi, struct mucse_q_vector, napi);
+	bool clean_complete = true;
+	struct mucse_ring *ring;
 	int work_done = 0;
 
+	mucse_for_each_ring(ring, q_vector->tx) {
+		if (!rnpgbe_clean_tx_irq(q_vector, ring, budget))
+			clean_complete = false;
+	}
+
 	/* Exit if we are called by netpoll */
 	if (unlikely(!budget))
 		return 0;
 
+	if (!clean_complete)
+		return budget;
+
 	if (likely(napi_complete_done(napi, work_done)))
 		rnpgbe_irq_enable_queues(q_vector);
 
@@ -214,12 +339,17 @@ static int rnpgbe_alloc_q_vector(struct mucse *mucse,
 	ring = q_vector->ring;
 
 	for (idx = 0; idx < txr_count; idx++) {
+		ring->dev = &mucse->pdev->dev;
 		mucse_add_ring(ring, &q_vector->tx);
+		ring->count = mucse->tx_ring_item_count;
+		ring->netdev = mucse->netdev;
 		ring->queue_index = eth_queue_idx + idx;
 		ring->rnpgbe_queue_idx = txr_idx;
 		ring->ring_addr = hw->hw_addr + RING_OFFSET(txr_idx);
 		ring->irq_mask = ring->ring_addr + RNPGBE_DMA_INT_MASK;
 		ring->trig = ring->ring_addr + RNPGBE_DMA_INT_TRIG;
+		ring->pfvfnum = hw->pfvfnum;
+		u64_stats_init(&ring->syncp);
 		mucse->tx_ring[ring->queue_index] = ring;
 		txr_idx += step;
 		ring++;
@@ -585,10 +715,97 @@ static void rnpgbe_napi_disable_all(struct mucse *mucse)
 		napi_disable(&mucse->q_vector[i]->napi);
 }
 
+/**
+ * rnpgbe_clean_tx_ring - Free Tx Buffers
+ * @tx_ring: ring to be cleaned
+ **/
+static void rnpgbe_clean_tx_ring(struct mucse_ring *tx_ring)
+{
+	u16 i = tx_ring->next_to_clean;
+	struct mucse_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
+	unsigned long size;
+
+	/* first stop hw */
+	mucse_ring_wr32(tx_ring, RNPGBE_TX_START, 0);
+	/* ring already cleared, nothing to do */
+	if (!tx_ring->tx_buffer_info)
+		return;
+
+	while (i != tx_ring->next_to_use) {
+		struct rnpgbe_tx_desc *eop_desc, *tx_desc;
+
+		dev_kfree_skb_any(tx_buffer->skb);
+		/* unmap skb header data */
+		if (dma_unmap_len(tx_buffer, len)) {
+			if (tx_buffer->mapped_as_page) {
+				dma_unmap_page(tx_ring->dev,
+					       dma_unmap_addr(tx_buffer, dma),
+					       dma_unmap_len(tx_buffer, len),
+					       DMA_TO_DEVICE);
+			} else {
+				dma_unmap_single(tx_ring->dev,
+						 dma_unmap_addr(tx_buffer, dma),
+						 dma_unmap_len(tx_buffer, len),
+						 DMA_TO_DEVICE);
+			}
+		}
+		eop_desc = tx_buffer->next_to_watch;
+		tx_desc = M_TX_DESC(tx_ring, i);
+		/* unmap remaining buffers */
+		while (tx_desc != eop_desc) {
+			tx_buffer++;
+			tx_desc++;
+			i++;
+			if (unlikely(i == tx_ring->count)) {
+				i = 0;
+				tx_buffer = tx_ring->tx_buffer_info;
+				tx_desc = M_TX_DESC(tx_ring, 0);
+			}
+
+			/* unmap any remaining paged data */
+			if (dma_unmap_len(tx_buffer, len))
+				dma_unmap_page(tx_ring->dev,
+					       dma_unmap_addr(tx_buffer, dma),
+					       dma_unmap_len(tx_buffer, len),
+					       DMA_TO_DEVICE);
+		}
+		/* move us one more past the eop_desc for start of next pkt */
+		tx_buffer++;
+		i++;
+		if (unlikely(i == tx_ring->count)) {
+			i = 0;
+			tx_buffer = tx_ring->tx_buffer_info;
+		}
+	}
+
+	netdev_tx_reset_queue(txring_txq(tx_ring));
+	size = sizeof(struct mucse_tx_buffer) * tx_ring->count;
+	memset(tx_ring->tx_buffer_info, 0, size);
+	/* Zero out the descriptor ring */
+	memset(tx_ring->desc, 0, tx_ring->size);
+	tx_ring->next_to_use = 0;
+	tx_ring->next_to_clean = 0;
+}
+
+/**
+ * rnpgbe_clean_all_tx_rings - Free Tx Buffers for all queues
+ * @mucse: board private structure
+ **/
+static void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
+{
+	for (int i = 0; i < mucse->num_tx_queues; i++)
+		rnpgbe_clean_tx_ring(mucse->tx_ring[i]);
+}
+
 void rnpgbe_down(struct mucse *mucse)
 {
+	struct net_device *netdev = mucse->netdev;
+
+	netif_tx_stop_all_queues(netdev);
+	netif_tx_disable(netdev);
 	rnpgbe_napi_disable_all(mucse);
 	rnpgbe_irq_disable(mucse);
+	rnpgbe_clean_all_tx_rings(mucse);
 }
 
 /**
@@ -597,7 +814,387 @@ void rnpgbe_down(struct mucse *mucse)
  **/
 void rnpgbe_up_complete(struct mucse *mucse)
 {
+	struct net_device *netdev = mucse->netdev;
+
 	rnpgbe_configure_msix(mucse);
 	rnpgbe_napi_enable_all(mucse);
 	rnpgbe_irq_enable(mucse);
+	netif_tx_start_all_queues(netdev);
+}
+
+/**
+ * rnpgbe_free_tx_resources - Free Tx Resources per Queue
+ * @tx_ring: tx descriptor ring for a specific queue
+ *
+ * Free all transmit software resources
+ **/
+static void rnpgbe_free_tx_resources(struct mucse_ring *tx_ring)
+{
+	rnpgbe_clean_tx_ring(tx_ring);
+	vfree(tx_ring->tx_buffer_info);
+	tx_ring->tx_buffer_info = NULL;
+	/* if not set, then don't free */
+	if (!tx_ring->desc)
+		return;
+
+	dma_free_coherent(tx_ring->dev, tx_ring->size, tx_ring->desc,
+			  tx_ring->dma);
+	tx_ring->desc = NULL;
+}
+
+/**
+ * rnpgbe_setup_tx_resources - allocate Tx resources (Descriptors)
+ * @tx_ring: tx descriptor ring (for a specific queue) to setup
+ * @mucse: pointer to private structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_setup_tx_resources(struct mucse_ring *tx_ring,
+				     struct mucse *mucse)
+{
+	struct device *dev = tx_ring->dev;
+	int size;
+
+	size = sizeof(struct mucse_tx_buffer) * tx_ring->count;
+
+	tx_ring->tx_buffer_info = vzalloc(size);
+	if (!tx_ring->tx_buffer_info)
+		goto err_return;
+	/* round up to nearest 4K */
+	tx_ring->size = tx_ring->count * sizeof(struct rnpgbe_tx_desc);
+	tx_ring->size = ALIGN(tx_ring->size, 4096);
+	tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size, &tx_ring->dma,
+					   GFP_KERNEL);
+	if (!tx_ring->desc)
+		goto err_free_buffer;
+
+	tx_ring->next_to_use = 0;
+	tx_ring->next_to_clean = 0;
+
+	return 0;
+
+err_free_buffer:
+	vfree(tx_ring->tx_buffer_info);
+err_return:
+	tx_ring->tx_buffer_info = NULL;
+	return -ENOMEM;
+}
+
+/**
+ * rnpgbe_configure_tx_ring - Configure Tx ring after Reset
+ * @mucse: pointer to private structure
+ * @ring: structure containing ring specific data
+ *
+ * Configure the Tx descriptor ring after a reset.
+ **/
+static void rnpgbe_configure_tx_ring(struct mucse *mucse,
+				     struct mucse_ring *ring)
+{
+	struct mucse_hw *hw = &mucse->hw;
+
+	mucse_ring_wr32(ring, RNPGBE_TX_START, 0);
+	mucse_ring_wr32(ring, RNPGBE_TX_BASE_ADDR_LO, (u32)ring->dma);
+	mucse_ring_wr32(ring, RNPGBE_TX_BASE_ADDR_HI,
+			(u32)(((u64)ring->dma) >> 32) | (hw->pfvfnum << 24));
+	mucse_ring_wr32(ring, RNPGBE_TX_LEN, ring->count);
+	ring->next_to_clean = mucse_ring_rd32(ring, RNPGBE_TX_HEAD);
+	ring->next_to_use = ring->next_to_clean;
+	ring->tail = ring->ring_addr + RNPGBE_TX_TAIL;
+	writel(ring->next_to_use, ring->tail);
+	mucse_ring_wr32(ring, RNPGBE_TX_FETCH_CTRL, M_DEFAULT_TX_FETCH);
+	mucse_ring_wr32(ring, RNPGBE_TX_INT_TIMER,
+			M_DEFAULT_INT_TIMER * hw->cycles_per_us);
+	mucse_ring_wr32(ring, RNPGBE_TX_INT_PKTCNT, M_DEFAULT_INT_PKTCNT);
+	/* Ensure all config is written before enabling queue */
+	wmb();
+	mucse_ring_wr32(ring, RNPGBE_TX_START, 1);
+}
+
+/**
+ * rnpgbe_configure_tx - Configure Transmit Unit after Reset
+ * @mucse: pointer to private structure
+ *
+ * Configure the Tx DMA after a reset.
+ **/
+void rnpgbe_configure_tx(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 i, dma_axi_ctl;
+
+	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
+	dma_axi_ctl |= TX_AXI_RW_EN;
+	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
+	/* Setup the HW Tx Head and Tail descriptor pointers */
+	for (i = 0; i < mucse->num_tx_queues; i++)
+		rnpgbe_configure_tx_ring(mucse, mucse->tx_ring[i]);
+}
+
+/**
+ * rnpgbe_setup_all_tx_resources - allocate all queues Tx resources
+ * @mucse: pointer to private structure
+ *
+ * Allocate memory for tx_ring.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int rnpgbe_setup_all_tx_resources(struct mucse *mucse)
+{
+	int i, err = 0;
+
+	for (i = 0; i < mucse->num_tx_queues; i++) {
+		err = rnpgbe_setup_tx_resources(mucse->tx_ring[i], mucse);
+		if (!err)
+			continue;
+
+		goto err_free_res;
+	}
+
+	return 0;
+err_free_res:
+	while (i--)
+		rnpgbe_free_tx_resources(mucse->tx_ring[i]);
+	return err;
+}
+
+/**
+ * rnpgbe_free_all_tx_resources - Free Tx Resources for All Queues
+ * @mucse: pointer to private structure
+ *
+ * Free all transmit software resources
+ **/
+void rnpgbe_free_all_tx_resources(struct mucse *mucse)
+{
+	for (int i = 0; i < (mucse->num_tx_queues); i++)
+		rnpgbe_free_tx_resources(mucse->tx_ring[i]);
+}
+
+static int rnpgbe_tx_map(struct mucse_ring *tx_ring,
+			 struct mucse_tx_buffer *first, u32 mac_ip_len,
+			 u32 tx_flags)
+{
+	/* hw need this in high 8 bytes desc */
+	u64 fun_id = ((u64)(tx_ring->pfvfnum) << (56));
+	struct mucse_tx_buffer *tx_buffer;
+	struct sk_buff *skb = first->skb;
+	struct rnpgbe_tx_desc *tx_desc;
+	u16 i = tx_ring->next_to_use;
+	unsigned int data_len, size;
+	skb_frag_t *frag;
+	dma_addr_t dma;
+
+	tx_desc = M_TX_DESC(tx_ring, i);
+	size = skb_headlen(skb);
+	data_len = skb->data_len;
+	frag = &skb_shinfo(skb)->frags[0];
+
+	if (size) {
+		dma = dma_map_single(tx_ring->dev, skb->data, size,
+				     DMA_TO_DEVICE);
+		first->mapped_as_page = false;
+	} else if (data_len) {
+		size = skb_frag_size(frag);
+		dma = skb_frag_dma_map(tx_ring->dev, frag, 0,
+				       size, DMA_TO_DEVICE);
+		first->mapped_as_page = true;
+		data_len -= size;
+		frag++;
+	} else {
+		goto err_unmap;
+	}
+
+	tx_buffer = first;
+
+	dma_unmap_len_set(tx_buffer, len, 0);
+	dma_unmap_addr_set(tx_buffer, dma, 0);
+
+	for (;; frag++) {
+		if (dma_mapping_error(tx_ring->dev, dma))
+			goto err_unmap;
+
+		/* record length, and DMA address */
+		dma_unmap_len_set(tx_buffer, len, size);
+		dma_unmap_addr_set(tx_buffer, dma, dma);
+
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
+		tx_buffer->mapped_as_page = true;
+	}
+
+	/* write last descriptor with RS and EOP bits */
+	tx_desc->vlan_cmd_bsz = build_ctob(tx_flags | M_TXD_CMD_EOP |
+					   M_TXD_CMD_RS,
+					   mac_ip_len, size);
+
+	/*
+	 * Force memory writes to complete before letting h/w know there
+	 * are new descriptors to fetch.  (Only applicable for weak-ordered
+	 * memory model archs, such as IA-64).
+	 *
+	 * We also need this memory barrier to make certain all of the
+	 * status bits have been updated before next_to_watch is written.
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
+	writel(i, tx_ring->tail);
+
+	return 0;
+err_unmap:
+	for (;;) {
+		tx_buffer = &tx_ring->tx_buffer_info[i];
+		if (dma_unmap_len(tx_buffer, len)) {
+			if (tx_buffer->mapped_as_page) {
+				dma_unmap_page(tx_ring->dev,
+					       dma_unmap_addr(tx_buffer, dma),
+					       dma_unmap_len(tx_buffer, len),
+					       DMA_TO_DEVICE);
+			} else {
+				dma_unmap_single(tx_ring->dev,
+						 dma_unmap_addr(tx_buffer, dma),
+						 dma_unmap_len(tx_buffer, len),
+						 DMA_TO_DEVICE);
+			}
+		}
+		dma_unmap_len_set(tx_buffer, len, 0);
+		dma_unmap_addr_set(tx_buffer, dma, 0);
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
+	return -ENOMEM;
+}
+
+static int rnpgbe_maybe_stop_tx(struct mucse_ring *tx_ring, u16 size)
+{
+	if (likely(mucse_desc_unused(tx_ring) >= size))
+		return 0;
+
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
+
+	return 0;
+}
+
+netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
+				   struct mucse_ring *tx_ring)
+{
+	u16 count = TXD_USE_COUNT(skb_headlen(skb));
+	/* hw requires it not zero */
+	u32 mac_ip_len = M_DEFAULT_MAC_IP_LEN;
+	struct mucse_tx_buffer *first;
+	u32 tx_flags = 0;
+	unsigned short f;
+
+	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++) {
+		skb_frag_t *frag_temp = &skb_shinfo(skb)->frags[f];
+
+		count += TXD_USE_COUNT(skb_frag_size(frag_temp));
+	}
+
+	if (rnpgbe_maybe_stop_tx(tx_ring, count + 3))
+		return NETDEV_TX_BUSY;
+
+	/* record the location of the first descriptor for this packet */
+	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
+	first->skb = skb;
+	first->bytecount = skb->len;
+	first->gso_segs = 1;
+
+	if (rnpgbe_tx_map(tx_ring, first, mac_ip_len, tx_flags)) {
+		u64_stats_update_begin(&tx_ring->syncp);
+		tx_ring->stats.dropped++;
+		u64_stats_update_end(&tx_ring->syncp);
+
+		goto out;
+	}
+
+	rnpgbe_maybe_stop_tx(tx_ring, DESC_NEEDED);
+out:
+	return NETDEV_TX_OK;
+}
+
+/**
+ * rnpgbe_get_stats64 - Get stats for this netdev
+ * @netdev: network interface device structure
+ * @stats: stats data
+ **/
+void rnpgbe_get_stats64(struct net_device *netdev,
+			struct rtnl_link_stats64 *stats)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+	int i;
+
+	rcu_read_lock();
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
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index baee4430a3a9..b5aee631ffd6 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -6,17 +6,36 @@
 
 struct mucse;
 struct mucse_hw;
+struct mucse_ring;
 
 #define RING_OFFSET(n)            (0x1000 + 0x100 * (n))
+#define RNPGBE_TX_START           0x18
 #define RNPGBE_DMA_INT_MASK       0x24
 #define TX_INT_MASK               BIT(1)
 #define RX_INT_MASK               BIT(0)
 #define INT_VALID                 (BIT(16) | BIT(17))
+#define RNPGBE_TX_BASE_ADDR_HI    0x60
+#define RNPGBE_TX_BASE_ADDR_LO    0x64
+#define RNPGBE_TX_LEN             0x68
+#define RNPGBE_TX_HEAD            0x6c
+#define RNPGBE_TX_TAIL            0x70
+#define M_DEFAULT_TX_FETCH        0x80008
+#define RNPGBE_TX_FETCH_CTRL      0x74
+#define M_DEFAULT_INT_TIMER       100
+#define RNPGBE_TX_INT_TIMER       0x78
+#define M_DEFAULT_INT_PKTCNT      48
+#define RNPGBE_TX_INT_PKTCNT      0x7c
 #define RNPGBE_DMA_INT_TRIG       0x2c
 /* |  31:24   | .... |    15:8   |    7:0    | */
 /* |  pfvfnum |      | tx vector | rx vector | */
 #define RING_VECTOR(n)            (0x04 * (n))
 
+#define M_MAX_TXD_PWR             12
+#define M_MAX_DATA_PER_TXD        (0x1 << M_MAX_TXD_PWR)
+#define TXD_USE_COUNT(S)          DIV_ROUND_UP((S), M_MAX_DATA_PER_TXD)
+#define DESC_NEEDED               (MAX_SKB_FRAGS + 4)
+/* hw require this not zero */
+#define M_DEFAULT_MAC_IP_LEN      20
 #define mucse_for_each_ring(pos, head)\
 	for (typeof((head).ring) __pos = (head).ring;\
 	     __pos ? ({ pos = __pos; 1; }) : 0;\
@@ -31,4 +50,12 @@ void rnpgbe_free_irq(struct mucse *mucse);
 void rnpgbe_irq_disable(struct mucse *mucse);
 void rnpgbe_down(struct mucse *mucse);
 void rnpgbe_up_complete(struct mucse *mucse);
+void mucse_fw_irq_handler(struct mucse_hw *hw);
+void rnpgbe_configure_tx(struct mucse *mucse);
+int rnpgbe_setup_all_tx_resources(struct mucse *mucse);
+void rnpgbe_free_all_tx_resources(struct mucse *mucse);
+netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
+				   struct mucse_ring *tx_ring);
+void rnpgbe_get_stats64(struct net_device *netdev,
+			struct rtnl_link_stats64 *stats);
 #endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index d2530aa4b7ba..8ef719a0d891 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -26,6 +26,17 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * rnpgbe_configure - Configure info to hw
+ * @mucse: pointer to private structure
+ *
+ * rnpgbe_configure configure mac, tx, rx regs to hw
+ **/
+static void rnpgbe_configure(struct mucse *mucse)
+{
+	rnpgbe_configure_tx(mucse);
+}
+
 /**
  * rnpgbe_open - Called when a network interface is made active
  * @netdev: network interface device structure
@@ -49,6 +60,11 @@ static int rnpgbe_open(struct net_device *netdev)
 	if (err)
 		goto err_free_irqs;
 
+	err = rnpgbe_setup_all_tx_resources(mucse);
+	if (err)
+		goto err_free_irqs;
+
+	rnpgbe_configure(mucse);
 	rnpgbe_up_complete(mucse);
 
 	return 0;
@@ -72,6 +88,7 @@ static int rnpgbe_close(struct net_device *netdev)
 
 	rnpgbe_down(mucse);
 	rnpgbe_free_irq(mucse);
+	rnpgbe_free_all_tx_resources(mucse);
 
 	return 0;
 }
@@ -81,25 +98,32 @@ static int rnpgbe_close(struct net_device *netdev)
  * @skb: skb structure to be sent
  * @netdev: network interface device structure
  *
- * Return: NETDEV_TX_OK
+ * Return: NETDEV_TX_OK or NETDEV_TX_BUSY when insufficient descriptors
  **/
 static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
 				     struct net_device *netdev)
 {
 	struct mucse *mucse = netdev_priv(netdev);
+	struct mucse_ring *tx_ring;
 
-	dev_kfree_skb_any(skb);
-	mucse->stats.tx_dropped++;
+	tx_ring = mucse->tx_ring[skb_get_queue_mapping(skb)];
 
-	return NETDEV_TX_OK;
+	return rnpgbe_xmit_frame_ring(skb, tx_ring);
 }
 
 static const struct net_device_ops rnpgbe_netdev_ops = {
 	.ndo_open       = rnpgbe_open,
 	.ndo_stop       = rnpgbe_close,
 	.ndo_start_xmit = rnpgbe_xmit_frame,
+	.ndo_get_stats64 = rnpgbe_get_stats64,
 };
 
+static void rnpgbe_sw_init(struct mucse *mucse)
+{
+	mucse->tx_ring_item_count = M_DEFAULT_TXD;
+	mucse->tx_work_limit = M_DEFAULT_TX_WORK;
+}
+
 /**
  * rnpgbe_add_adapter - Add netdev for this pci_dev
  * @pdev: PCI device information structure
@@ -172,6 +196,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	}
 
 	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	rnpgbe_sw_init(mucse);
 	err = rnpgbe_reset_hw(hw);
 	if (err) {
 		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
-- 
2.25.1


