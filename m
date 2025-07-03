Return-Path: <netdev+bounces-203577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB17AF676D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225DF1C43A8B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA4E229B2E;
	Thu,  3 Jul 2025 01:51:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246E9219A9B;
	Thu,  3 Jul 2025 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507479; cv=none; b=RPxVSU1Pky6hMS+fZHzRCi+b3pFUKHa4qKsBXu12FO0oV9biO9ESOLsaTMrqv8hQ3O5j/KpgGmvzhU1RzJA757+Zcyso+WU8cLJz7fRrM/rygT7REt0T4VJgMIkSbEd5NI/HN/d5L56eqqsKAFtqIVLDoRpaj/aPDUvpuxlj90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507479; c=relaxed/simple;
	bh=sNEQEnKuqE5ED2CNiceZlJzn+qdC9+MNHxfFb1fe/yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbKLr9Dpy+Ov9XV/sX2itlmK+axW3LP6ls3Tqo522x3pTKxL7Jy4pgEkA6AqmJZmRTRYxVEnVCm7OeuXhk4wUf6Htmh3VojYFcU9VSc/4b5j11mlLtvedqEjz/ZEgSlyIqEmjZGaMnaGYrSjehMIT7zBTpPEa+Mz8ikKjaj+sfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507392t1dde0829
X-QQ-Originating-IP: UupTy+JW8obp2Fp4CFy/3t2/sY69ThsAUW9vldRuxBk=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:49:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3269869034678843262
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
Subject: [PATCH 09/15] net: rnpgbe: Add netdev register and init tx/rx memory
Date: Thu,  3 Jul 2025 09:48:53 +0800
Message-Id: <20250703014859.210110-10-dong100@mucse.com>
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
X-QQ-XMAILINFO: NWwUqlpH66YH7Ld0SX/SKKkbzkZlEZoNq4x2YGrGBaIOWru30/YAz2V8
	eQT3MnEqBA0bEqZjVoN3wg5ks9jjaZf2+u67KLssZATZMYnr8lP6Lwb0eVRiUb3WkTda5rZ
	vKqSPW569RO8iMYVQNFQU+rqWUat0jHy2vB6ScDwwcQz6Jcc2+3EowwcZrKMkzlJ99Waa1u
	954oZiGR3RKSRGoaarPb4/nwiPYYOazXt7Q5+ymVFjM2+eGUrzwc106pM9T6hf7/IKjgfLd
	Ks4bDCxzPfgTHYj+mEnQ8kGpnZlrPPO09IpJzR81OCnSJpqtlDGEpMcEBVOV8rXBvdgtxZ6
	pOvZeCgIfTmWVNLflVIiy1oZ6RNsyJBwxnKIldC0rsNdLb/wuhHK97XUgVr/vimMb3pYh/m
	kI5jmuVC2V2jdArQrzuWgBZeARVk+S4rHtqVKt+gN/SLT002KR70xnrkdjg8+ijkrBcALbi
	Lh/YTPKJe7uOKtvb5MZJKLy+sVB6XMGrL0IOB2B7T1E1pX8wuhbblbIMH2t7s/DW7HxI0dO
	0KVfVYUP/83hAEyo/V0fTauraNaeT8/ARJcxWOXa06Z6KfhqDNm6gh3UQmmYd7SnMwFCA6U
	1UiCRZcqmlS+ziokmafSqFk3iOdUufrPPhBg+XhpAzl1UXE7uZMIujAVTpOOBdvYJNfW0Ci
	17dOa9YVkdTsbQ3XwM3iM/itJCuzZzU3vCK9igZHMT2ofOqaO4gvFePyhZKeghzif2ru9E0
	cRS3yiroqLq4LxjNDr0PeS07h7XMCzROZ05vgcOrt8gPjcCR4VNTKERKud15v5W7iaAmtQ3
	r36ydNblG2lL25J+C0LqHxfdvYYiftIrrUUdiUyPZfcQr3/rDMH301CUePfL3oJfSf0n5kW
	Vn3zmyJGnsdNjWsn6vXuwNs2Zff/ZmGZTrb9qr5oaNHNaEpkiwiM5q6tCeVqOfhbt6tUasw
	zRVe4ji9KHWgmXtRKaCWcXfJuitOKpG9kD2wfNHc3IRW2t+z2dlwIUp/hB0tq1nNL6gV19z
	c0dKsXLsVviJOq4MeR
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Initialize tx/rx memory for tx/rx desc.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 145 +++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 358 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  84 +++-
 4 files changed, 586 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 82df7f133f10..feb74048b9e0 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -247,6 +247,7 @@ struct mucse_hw {
 };
 
 enum mucse_state_t {
+	__MMUCSE_TESTING,
 	__MUCSE_DOWN,
 	__MUCSE_SERVICE_SCHED,
 	__MUCSE_PTP_TX_IN_PROGRESS,
@@ -306,6 +307,134 @@ struct mucse_rx_queue_stats {
 	u64 rx_clean_count;
 };
 
+union rnpgbe_rx_desc {
+	struct {
+		union {
+			__le64 pkt_addr;
+			struct {
+				__le32 addr_lo;
+				__le32 addr_hi;
+			};
+		};
+		__le64 resv_cmd;
+#define M_RXD_FLAG_RS (0)
+	};
+	struct {
+		__le32 rss_hash;
+		__le16 mark;
+		__le16 rev1;
+#define M_RX_L3_TYPE_MASK BIT(15)
+#define VEB_VF_PKG BIT(1)
+#define VEB_VF_IGNORE_VLAN BIT(0)
+#define REV_OUTER_VLAN BIT(5)
+		__le16 len;
+		__le16 padding_len;
+		__le16 vlan;
+		__le16 cmd;
+#define M_RXD_STAT_VLAN_VALID BIT(15)
+#define M_RXD_STAT_STAG BIT(14)
+#define M_RXD_STAT_TUNNEL_NVGRE (0x02 << 13)
+#define M_RXD_STAT_TUNNEL_VXLAN (0x01 << 13)
+#define M_RXD_STAT_TUNNEL_MASK (0x03 << 13)
+#define M_RXD_STAT_ERR_MASK (0x1f << 8)
+#define M_RXD_STAT_SCTP_MASK (0x04 << 8)
+#define M_RXD_STAT_L4_MASK (0x02 << 8)
+#define M_RXD_STAT_L4_SCTP (0x02 << 6)
+#define M_RXD_STAT_L4_TCP (0x01 << 6)
+#define M_RXD_STAT_L4_UDP (0x03 << 6)
+#define M_RXD_STAT_IPV6 BIT(5)
+#define M_RXD_STAT_IPV4 (0 << 5)
+#define M_RXD_STAT_PTP BIT(4)
+#define M_RXD_STAT_DD BIT(1)
+#define M_RXD_STAT_EOP BIT(0)
+	} wb;
+} __packed;
+
+struct rnpgbe_tx_desc {
+	union {
+		__le64 pkt_addr;
+		struct {
+			__le32 adr_lo;
+			__le32 adr_hi;
+		};
+	};
+	union {
+		__le64 vlan_cmd_bsz;
+		struct {
+			__le32 blen_mac_ip_len;
+			__le32 vlan_cmd;
+		};
+	};
+#define M_TXD_FLAGS_VLAN_PRIO_MASK 0xe000
+#define M_TX_FLAGS_VLAN_PRIO_SHIFT 13
+#define M_TX_FLAGS_VLAN_CFI_SHIFT 12
+#define M_TXD_VLAN_VALID (0x80000000)
+#define M_TXD_SVLAN_TYPE (0x02000000)
+#define M_TXD_VLAN_CTRL_NOP (0x00 << 13)
+#define M_TXD_VLAN_CTRL_RM_VLAN (0x20000000)
+#define M_TXD_VLAN_CTRL_INSERT_VLAN (0x40000000)
+#define M_TXD_L4_CSUM (0x10000000)
+#define M_TXD_IP_CSUM (0x8000000)
+#define M_TXD_TUNNEL_MASK (0x3000000)
+#define M_TXD_TUNNEL_VXLAN (0x1000000)
+#define M_TXD_TUNNEL_NVGRE (0x2000000)
+#define M_TXD_L4_TYPE_UDP (0xc00000)
+#define M_TXD_L4_TYPE_TCP (0x400000)
+#define M_TXD_L4_TYPE_SCTP (0x800000)
+#define M_TXD_FLAG_IPv4 (0)
+#define M_TXD_FLAG_IPv6 (0x200000)
+#define M_TXD_FLAG_TSO (0x100000)
+#define M_TXD_FLAG_PTP (0x4000000)
+#define M_TXD_CMD_RS (0x040000)
+#define M_TXD_CMD_INNER_VLAN (0x08000000)
+#define M_TXD_STAT_DD (0x020000)
+#define M_TXD_CMD_EOP (0x010000)
+#define M_TXD_PAD_CTRL (0x01000000)
+};
+
+struct mucse_tx_buffer {
+	struct rnpgbe_tx_desc *next_to_watch;
+	unsigned long time_stamp;
+	struct sk_buff *skb;
+	unsigned int bytecount;
+	unsigned short gso_segs;
+	bool gso_need_padding;
+	__be16 protocol;
+	__be16 priv_tags;
+	DEFINE_DMA_UNMAP_ADDR(dma);
+	DEFINE_DMA_UNMAP_LEN(len);
+	union {
+		u32 mss_len_vf_num;
+		struct {
+			__le16 mss_len;
+			u8 vf_num;
+			u8 l4_hdr_len;
+		};
+	};
+	union {
+		u32 inner_vlan_tunnel_len;
+		struct {
+			u8 tunnel_hdr_len;
+			u8 inner_vlan_l;
+			u8 inner_vlan_h;
+			u8 resv;
+		};
+	};
+	bool ctx_flag;
+};
+
+struct mucse_rx_buffer {
+	struct sk_buff *skb;
+	dma_addr_t dma;
+	struct page *page;
+#if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
+	__u32 page_offset;
+#else /* (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536) */
+	__u16 page_offset;
+#endif /* (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536) */
+	__u16 pagecnt_bias;
+};
+
 struct mucse_ring {
 	struct mucse_ring *next;
 	struct mucse_q_vector *q_vector;
@@ -349,6 +478,7 @@ struct mucse_ring {
 	u16 next_to_use;
 	u16 next_to_clean;
 	u16 device_id;
+	u16 next_to_alloc;
 	struct mucse_queue_stats stats;
 	struct u64_stats_sync syncp;
 	union {
@@ -434,6 +564,21 @@ struct rnpgbe_info {
 	void (*get_invariants)(struct mucse_hw *hw);
 };
 
+static inline struct netdev_queue *txring_txq(const struct mucse_ring *ring)
+{
+	return netdev_get_tx_queue(ring->netdev, ring->queue_index);
+}
+
+#define M_RXBUFFER_1536 (1536)
+static inline unsigned int mucse_rx_bufsz(struct mucse_ring *ring)
+{
+	return (M_RXBUFFER_1536 - NET_IP_ALIGN);
+}
+
+#define M_TX_DESC(R, i) (&(((struct rnpgbe_tx_desc *)((R)->desc))[i]))
+#define M_RX_DESC(R, i) (&(((union rnpgbe_rx_desc *)((R)->desc))[i]))
+
+#define M_RX_DMA_ATTR (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
 /* Device IDs */
 #ifndef PCI_VENDOR_ID_MUCSE
 #define PCI_VENDOR_ID_MUCSE 0x8848
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 95c913212182..0dbb942eb4c7 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
+#include <linux/vmalloc.h>
+
 #include "rnpgbe.h"
 #include "rnpgbe_lib.h"
 
@@ -460,3 +462,359 @@ void rnpgbe_clear_interrupt_scheme(struct mucse *mucse)
 	rnpgbe_free_q_vectors(mucse);
 	rnpgbe_reset_interrupt_capability(mucse);
 }
+
+/**
+ * rnpgbe_clean_tx_ring - Free Tx Buffers
+ * @tx_ring: ring to be cleaned
+ **/
+static void rnpgbe_clean_tx_ring(struct mucse_ring *tx_ring)
+{
+	unsigned long size;
+	u16 i = tx_ring->next_to_clean;
+	struct mucse_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
+
+	/* ring already cleared, nothing to do */
+	if (!tx_ring->tx_buffer_info)
+		return;
+
+	while (i != tx_ring->next_to_use) {
+		struct rnpgbe_tx_desc *eop_desc, *tx_desc;
+
+		dev_kfree_skb_any(tx_buffer->skb);
+		/* unmap skb header data */
+		dma_unmap_single(tx_ring->dev, dma_unmap_addr(tx_buffer, dma),
+				 dma_unmap_len(tx_buffer, len), DMA_TO_DEVICE);
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
+ * Return 0 on success, negative on failure
+ **/
+static int rnpgbe_setup_tx_resources(struct mucse_ring *tx_ring,
+				     struct mucse *mucse)
+{
+	struct device *dev = tx_ring->dev;
+	int orig_node = dev_to_node(dev);
+	int numa_node = NUMA_NO_NODE;
+	int size;
+
+	size = sizeof(struct mucse_tx_buffer) * tx_ring->count;
+
+	if (tx_ring->q_vector)
+		numa_node = tx_ring->q_vector->numa_node;
+	tx_ring->tx_buffer_info = vzalloc_node(size, numa_node);
+	if (!tx_ring->tx_buffer_info)
+		tx_ring->tx_buffer_info = vzalloc(size);
+	if (!tx_ring->tx_buffer_info)
+		goto err;
+	/* round up to nearest 4K */
+	tx_ring->size = tx_ring->count * sizeof(struct rnpgbe_tx_desc);
+	tx_ring->size = ALIGN(tx_ring->size, 4096);
+	set_dev_node(dev, numa_node);
+	tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size, &tx_ring->dma,
+					   GFP_KERNEL);
+	set_dev_node(dev, orig_node);
+	if (!tx_ring->desc)
+		tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size,
+						   &tx_ring->dma,
+						   GFP_KERNEL);
+	if (!tx_ring->desc)
+		goto err;
+
+	memset(tx_ring->desc, 0, tx_ring->size);
+	tx_ring->next_to_use = 0;
+	tx_ring->next_to_clean = 0;
+	return 0;
+
+err:
+	vfree(tx_ring->tx_buffer_info);
+	tx_ring->tx_buffer_info = NULL;
+	return -ENOMEM;
+}
+
+/**
+ * rnpgbe_setup_all_tx_resources - allocate all queues Tx resources
+ * @mucse: pointer to private structure
+ *
+ * Allocate memory for tx_ring.
+ * Return 0 on success, negative on failure
+ **/
+static int rnpgbe_setup_all_tx_resources(struct mucse *mucse)
+{
+	int i, err = 0;
+
+	for (i = 0; i < (mucse->num_tx_queues); i++) {
+		err = rnpgbe_setup_tx_resources(mucse->tx_ring[i], mucse);
+		if (!err)
+			continue;
+
+		goto err_setup_tx;
+	}
+
+	return 0;
+err_setup_tx:
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
+static void rnpgbe_free_all_tx_resources(struct mucse *mucse)
+{
+	int i;
+
+	for (i = 0; i < (mucse->num_tx_queues); i++)
+		rnpgbe_free_tx_resources(mucse->tx_ring[i]);
+}
+
+/**
+ * rnpgbe_setup_rx_resources - allocate Rx resources (Descriptors)
+ * @rx_ring:    rx descriptor ring (for a specific queue) to setup
+ * @mucse: pointer to private structure
+ *
+ * Returns 0 on success, negative on failure
+ **/
+static int rnpgbe_setup_rx_resources(struct mucse_ring *rx_ring,
+				     struct mucse *mucse)
+{
+	struct device *dev = rx_ring->dev;
+	int orig_node = dev_to_node(dev);
+	int numa_node = NUMA_NO_NODE;
+	int size;
+
+	size = sizeof(struct mucse_rx_buffer) * rx_ring->count;
+	if (rx_ring->q_vector)
+		numa_node = rx_ring->q_vector->numa_node;
+
+	rx_ring->rx_buffer_info = vzalloc_node(size, numa_node);
+	if (!rx_ring->rx_buffer_info)
+		rx_ring->rx_buffer_info = vzalloc(size);
+
+	if (!rx_ring->rx_buffer_info)
+		goto err;
+	/* Round up to nearest 4K */
+	rx_ring->size = rx_ring->count * sizeof(union rnpgbe_rx_desc);
+	rx_ring->size = ALIGN(rx_ring->size, 4096);
+	set_dev_node(dev, numa_node);
+	rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
+					   &rx_ring->dma,
+					   GFP_KERNEL);
+	set_dev_node(dev, orig_node);
+	if (!rx_ring->desc)
+		rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
+						   &rx_ring->dma,
+						   GFP_KERNEL);
+	if (!rx_ring->desc)
+		goto err;
+	memset(rx_ring->desc, 0, rx_ring->size);
+	rx_ring->next_to_clean = 0;
+	rx_ring->next_to_use = 0;
+
+	return 0;
+err:
+	vfree(rx_ring->rx_buffer_info);
+	rx_ring->rx_buffer_info = NULL;
+	return -ENOMEM;
+}
+
+/**
+ * rnpgbe_clean_rx_ring - Free Rx Buffers per Queue
+ * @rx_ring: ring to free buffers from
+ **/
+static void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring)
+{
+	u16 i = rx_ring->next_to_clean;
+	struct mucse_rx_buffer *rx_buffer = &rx_ring->rx_buffer_info[i];
+
+	/* Free all the Rx ring sk_buffs */
+	while (i != rx_ring->next_to_alloc) {
+		if (rx_buffer->skb) {
+			struct sk_buff *skb = rx_buffer->skb;
+
+			dev_kfree_skb(skb);
+			rx_buffer->skb = NULL;
+		}
+		dma_sync_single_range_for_cpu(rx_ring->dev, rx_buffer->dma,
+					      rx_buffer->page_offset,
+					      mucse_rx_bufsz(rx_ring),
+					      DMA_FROM_DEVICE);
+		/* free resources associated with mapping */
+		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
+				     PAGE_SIZE,
+				     DMA_FROM_DEVICE,
+				     M_RX_DMA_ATTR);
+		__page_frag_cache_drain(rx_buffer->page,
+					rx_buffer->pagecnt_bias);
+		rx_buffer->page = NULL;
+		i++;
+		rx_buffer++;
+		if (i == rx_ring->count) {
+			i = 0;
+			rx_buffer = rx_ring->rx_buffer_info;
+		}
+	}
+
+	rx_ring->next_to_alloc = 0;
+	rx_ring->next_to_clean = 0;
+	rx_ring->next_to_use = 0;
+}
+
+/**
+ * rnpgbe_free_rx_resources - Free Rx Resources
+ * @rx_ring: ring to clean the resources from
+ *
+ * Free all receive software resources
+ **/
+static void rnpgbe_free_rx_resources(struct mucse_ring *rx_ring)
+{
+	rnpgbe_clean_rx_ring(rx_ring);
+	vfree(rx_ring->rx_buffer_info);
+	rx_ring->rx_buffer_info = NULL;
+	/* if not set, then don't free */
+	if (!rx_ring->desc)
+		return;
+
+	dma_free_coherent(rx_ring->dev, rx_ring->size, rx_ring->desc,
+			  rx_ring->dma);
+	rx_ring->desc = NULL;
+}
+
+/**
+ * rnpgbe_setup_all_rx_resources - allocate all queues Rx resources
+ * @mucse: pointer to private structure
+ *
+ * Return 0 on success, negative on failure
+ **/
+static int rnpgbe_setup_all_rx_resources(struct mucse *mucse)
+{
+	int i, err = 0;
+
+	for (i = 0; i < mucse->num_rx_queues; i++) {
+		err = rnpgbe_setup_rx_resources(mucse->rx_ring[i], mucse);
+		if (!err)
+			continue;
+
+		goto err_setup_rx;
+	}
+
+	return 0;
+err_setup_rx:
+	while (i--)
+		rnpgbe_free_rx_resources(mucse->rx_ring[i]);
+	return err;
+}
+
+/**
+ * rnpgbe_free_all_rx_resources - Free Rx Resources for All Queues
+ * @mucse: pointer to private structure
+ *
+ * Free all receive software resources
+ **/
+static void rnpgbe_free_all_rx_resources(struct mucse *mucse)
+{
+	int i;
+
+	for (i = 0; i < (mucse->num_rx_queues); i++) {
+		if (mucse->rx_ring[i]->desc)
+			rnpgbe_free_rx_resources(mucse->rx_ring[i]);
+	}
+}
+
+/**
+ * rnpgbe_setup_txrx - Allocate Tx/Rx Resources for All Queues
+ * @mucse: pointer to private structure
+ *
+ * Allocate all send/receive software resources
+ **/
+int rnpgbe_setup_txrx(struct mucse *mucse)
+{
+	int err;
+
+	err = rnpgbe_setup_all_tx_resources(mucse);
+	if (err)
+		return err;
+
+	err = rnpgbe_setup_all_rx_resources(mucse);
+	if (err)
+		goto err_setup_rx;
+	return 0;
+err_setup_rx:
+	rnpgbe_free_all_tx_resources(mucse);
+	return err;
+}
+
+/**
+ * rnpgbe_free_txrx - Clean Tx/Rx Resources for All Queues
+ * @mucse: pointer to private structure
+ *
+ * Free all send/receive software resources
+ **/
+void rnpgbe_free_txrx(struct mucse *mucse)
+{
+	rnpgbe_free_all_tx_resources(mucse);
+	rnpgbe_free_all_rx_resources(mucse);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index ab55c5ae1482..150d03f9ada9 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -22,5 +22,7 @@
 
 int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
 void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
+int rnpgbe_setup_txrx(struct mucse *mucse);
+void rnpgbe_free_txrx(struct mucse *mucse);
 
 #endif /* _RNPGBE_LIB_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index bfe7b34be78e..95a68b6d08a5 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/etherdevice.h>
 #include <linux/firmware.h>
+#include <linux/rtnetlink.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_mbx_fw.h"
@@ -194,6 +195,67 @@ static int init_firmware_for_n210(struct mucse_hw *hw)
 	return err;
 }
 
+/**
+ * rnpgbe_open - Called when a network interface is made active
+ * @netdev: network interface device structure
+ *
+ * Returns 0 on success, negative value on failure
+ *
+ * The open entry point is called when a network interface is made
+ * active by the system (IFF_UP).
+ **/
+static int rnpgbe_open(struct net_device *netdev)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+	int err;
+
+	/* disallow open during test */
+	if (test_bit(__MMUCSE_TESTING, &mucse->state))
+		return -EBUSY;
+
+	netif_carrier_off(netdev);
+	err = rnpgbe_setup_txrx(mucse);
+
+	return err;
+}
+
+/**
+ * rnpgbe_close - Disables a network interface
+ * @netdev: network interface device structure
+ *
+ * Returns 0, this is not allowed to fail
+ *
+ * The close entry point is called when an interface is de-activated
+ * by the OS.
+ **/
+static int rnpgbe_close(struct net_device *netdev)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+
+	rnpgbe_free_txrx(mucse);
+
+	return 0;
+}
+
+static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
+				     struct net_device *netdev)
+{
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+const struct net_device_ops rnpgbe_netdev_ops = {
+	.ndo_open = rnpgbe_open,
+	.ndo_stop = rnpgbe_close,
+	.ndo_start_xmit = rnpgbe_xmit_frame,
+};
+
+static void rnpgbe_assign_netdev_ops(struct net_device *dev)
+{
+	dev->netdev_ops = &rnpgbe_netdev_ops;
+	dev->watchdog_timeo = 5 * HZ;
+}
+
 static int rnpgbe_sw_init(struct mucse *mucse)
 {
 	struct mucse_hw *hw = &mucse->hw;
@@ -368,7 +430,7 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 		err = -EIO;
 		goto err_free_net;
 	}
-
+	rnpgbe_assign_netdev_ops(netdev);
 	err = rnpgbe_sw_init(mucse);
 	if (err)
 		goto err_free_net;
@@ -384,8 +446,8 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_HIGHDMA;
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	netdev->hw_features |= netdev->features;
 	eth_hw_addr_set(netdev, hw->perm_addr);
-	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 	memcpy(netdev->perm_addr, hw->perm_addr, netdev->addr_len);
 	ether_addr_copy(hw->addr, hw->perm_addr);
 	timer_setup(&mucse->service_timer, rnpgbe_service_timer, 0);
@@ -394,11 +456,17 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 	err = rnpgbe_init_interrupt_scheme(mucse);
 	if (err)
 		goto err_free_net;
+
 	err = register_mbx_irq(mucse);
 	if (err)
 		goto err_free_irq;
-
+	strscpy(netdev->name, "eth%d", sizeof(netdev->name));
+	err = register_netdev(netdev);
+	if (err)
+		goto err_register;
 	return 0;
+err_register:
+	remove_mbx_irq(mucse);
 err_free_irq:
 	rnpgbe_clear_interrupt_scheme(mucse);
 err_free_net:
@@ -468,9 +536,15 @@ static void rnpgbe_rm_adpater(struct mucse *mucse)
 	struct mucse_hw *hw = &mucse->hw;
 
 	netdev = mucse->netdev;
+	if (mucse->flags2 & M_FLAG2_NO_NET_REG) {
+		free_netdev(netdev);
+		return;
+	}
 	pr_info("= remove rnpgbe:%s =\n", netdev->name);
 	cancel_work_sync(&mucse->service_task);
 	timer_delete_sync(&mucse->service_timer);
+	if (netdev->reg_state == NETREG_REGISTERED)
+		unregister_netdev(netdev);
 	hw->ops.driver_status(hw, false, mucse_driver_insmod);
 	remove_mbx_irq(mucse);
 	rnpgbe_clear_interrupt_scheme(mucse);
@@ -507,6 +581,10 @@ static void __rnpgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 
 	*enable_wake = false;
 	netif_device_detach(netdev);
+	rtnl_lock();
+	if (netif_running(netdev))
+		rnpgbe_free_txrx(mucse);
+	rtnl_unlock();
 	remove_mbx_irq(mucse);
 	rnpgbe_clear_interrupt_scheme(mucse);
 	pci_disable_device(pdev);
-- 
2.25.1


