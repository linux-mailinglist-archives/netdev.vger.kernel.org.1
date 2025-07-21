Return-Path: <netdev+bounces-208577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52924B0C332
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09DE87B0B26
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251232D3723;
	Mon, 21 Jul 2025 11:34:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE942D29D8;
	Mon, 21 Jul 2025 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097682; cv=none; b=rH5Pc3NLyZ+EqQ2NWOu3rxqP8MSjWT3f/4UfciyW9IbOoAGJG7umHwFqrfynNZS1b0zrtWzLwjcim4TEfK2/xJvT8x/TJBLaGgRa1zBc+5N0ZepyKFDv0HiB4TOBikdV+28THuDjgQ7h3JEoEp7Fn+aQpajlIgrlULHnIohWGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097682; c=relaxed/simple;
	bh=DTUYV1e6EHZF9z0ThQa5/erkc+t56AU4jOeZWsYYigw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nmhLMOy0knQpzMsF+0PBGe4XMOQzic9EqtTsXJDvDlIye+WR/fb4C3FQgTZlFP0BulrVFK69WMktKWHlusnYcHKNUzglD7YWEwKfhYIldEGHVimcs6HRUZmIYso+alzZJn6h6ewbN9U+tlfWFjD1TGw0m7xEjT+D7oorcuZVYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097608tbf371e3e
X-QQ-Originating-IP: zGrKS85rYRkLmemFiNjwNtfEjBmyv8pxC+l/gyQv9Jo=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:33:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7820022088678493601
EX-QQ-RecipientCnt: 23
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
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
	alexanderduyck@fb.com,
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH v2 09/15] net: rnpgbe: Add netdev register and init tx/rx memory
Date: Mon, 21 Jul 2025 19:32:32 +0800
Message-Id: <20250721113238.18615-10-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721113238.18615-1-dong100@mucse.com>
References: <20250721113238.18615-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MzDEtv5QipDt9Snp9S65y16728JGm38IG4udaC7Qk7QG12b0bF//73Kg
	++xtirktcBoreYCb9YcelD7RUz7VWD1nXLVQ8e7IsYE43A8s9xdIuzxSwBc2ZcYTmD175Wx
	xnI/OFE7l1MFwZhlya6SruSR1j1j40oN+2pfT1lpGoGU+xdnDEWRwDGLEfkygAEVVTJeaw1
	3kk4BkqrSWfichvuIJOmfZ/j5HE5xh0shXOddqULpAUbUIU6a8OiCMTkSWs+ykmgxMjVewZ
	GzkHbA1f8iRCah698Du2/HYFBXv4AO+fzrEMpqHKm94qZk0kSMNI6BKb7EaXy4B2C3F5aVB
	E1ffZYKgNEYfDb/zczMXQ67l2sM3mbGSM0D1vRgpBs1BiZSoc8MORBcojgtBKr23lkz7X7o
	xgd5HA4DrzeUKGv+0Bm2fzQxSF4sBhSSdsb6cjlGdwwPyvNiUw4pGSXPKTBfMpPkbssLI4l
	reazDG0GbH5UnC/1olugXHguYDkfsglfdugET9Ejx/Cw3/wWU2oJPFvm1oKNknvYC6Lions
	26bL6cpkmddWQ0VHi7Z3vkAHS1Sh0qH+NnUTr/NaOshcOZHaAzK05C+7kWOW3CCQGx24Wdj
	YhcZ0hdkqWyTbBooytaoo4o2+EObKLHj/lNCMyylbeh/Bognf4goIs3ajEXg/0jTvtLmGsJ
	smC2rpoLp97rj9jBJpZqP84IRIAb65qQwbsdZ7eeXDqhcbQXbG3MKRQtVEoaHI8TZEJudT3
	zYuI8Py6zXrzKeqat4w+ma9MhlNrQzYmU/b20+KuWBHbtYPxSJYc1fAQOMEhKrvmQOHSLXq
	SjL7radX3RrehZECr47DFvIwrA1XnotsPlxr1ubAVtrTTC7EPDjHpznmmOy1/4jyIZBzH/P
	UW2LD7I8XrMfzzgT0boza9rkNORXnVCFeJwSfU2J46ATTF+Tr/1PuK1a8tsD1H1v5c6fRJw
	rqM+G0zj4NXVM/NiKTfwKvwHXpH8D1WH9Wu86fcSSGlHRMLYhgIuury0jAcN8jF0/mZQLt3
	uEJ4sjs7L67DVS2tyhtVoUJp8OH4ac3DNjzttb3lCscLQjKX4xM+gOLR1A8nk=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Initialize tx/rx memory for tx/rx desc.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 140 +++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 355 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  94 ++++-
 4 files changed, 589 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 212e5b8fd7b4..cb0d73589687 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -248,6 +248,7 @@ struct mucse_hw {
 };
 
 enum mucse_state_t {
+	__MUCSE_TESTING,
 	__MUCSE_DOWN,
 	__MUCSE_SERVICE_SCHED,
 	__MUCSE_PTP_TX_IN_PROGRESS,
@@ -307,6 +308,129 @@ struct mucse_rx_queue_stats {
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
+			u16 mss_len;
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
+	__u32 page_offset;
+};
+
 struct mucse_ring {
 	struct mucse_ring *next;
 	struct mucse_q_vector *q_vector;
@@ -350,6 +474,7 @@ struct mucse_ring {
 	u16 next_to_use;
 	u16 next_to_clean;
 	u16 device_id;
+	u16 next_to_alloc;
 	struct mucse_queue_stats stats;
 	struct u64_stats_sync syncp;
 	union {
@@ -436,6 +561,21 @@ struct rnpgbe_info {
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
index 2bf8a7f7f303..abf3eef3291a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
+#include <linux/vmalloc.h>
+
 #include "rnpgbe.h"
 #include "rnpgbe_lib.h"
 
@@ -498,3 +500,356 @@ void rnpgbe_clear_interrupt_scheme(struct mucse *mucse)
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
+	struct mucse_tx_buffer *tx_buffer;
+	u16 i = tx_ring->next_to_clean;
+	unsigned long size;
+
+	tx_buffer = &tx_ring->tx_buffer_info[i];
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
+ * @return: 0 on success, negative on failure
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
+ * @return: 0 on success, negative on failure
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
+ * @rx_ring: rx descriptor ring (for a specific queue) to setup
+ * @mucse: pointer to private structure
+ *
+ * @return: 0 on success, negative on failure
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
+	struct mucse_rx_buffer *rx_buffer;
+	u16 i = rx_ring->next_to_clean;
+
+	rx_buffer = &rx_ring->rx_buffer_info[i];
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
+ * @return: 0 on success, negative on failure
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
+ *
+ * @return: 0 on success, negative on failure
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
index 0df519a50185..6b2f68320c9e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -24,5 +24,7 @@
 
 int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
 void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
+int rnpgbe_setup_txrx(struct mucse *mucse);
+void rnpgbe_free_txrx(struct mucse *mucse);
 
 #endif /* _RNPGBE_LIB_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 8fc1af1c00bc..16a111a10862 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/etherdevice.h>
 #include <linux/firmware.h>
+#include <linux/rtnetlink.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_mbx_fw.h"
@@ -83,6 +84,78 @@ static void rnpgbe_service_task(struct work_struct *work)
 {
 }
 
+/**
+ * rnpgbe_open - Called when a network interface is made active
+ * @netdev: network interface device structure
+ *
+ * The open entry point is called when a network interface is made
+ * active by the system (IFF_UP).
+ *
+ * @return: 0 on success, negative value on failure
+ **/
+static int rnpgbe_open(struct net_device *netdev)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+	int err;
+
+	/* disallow open during test */
+	if (test_bit(__MUCSE_TESTING, &mucse->state))
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
+ * The close entry point is called when an interface is de-activated
+ * by the OS.
+ *
+ * @return: 0, this is not allowed to fail
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
+/**
+ * rnpgbe_xmit_frame - Send a skb to driver
+ * @skb: skb structure to be sent
+ * @netdev: network interface device structure
+ *
+ * @return: NETDEV_TX_OK or NETDEV_TX_BUSY
+ **/
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
+/**
+ * rnpgbe_assign_netdev_ops - Assign netdev ops to the device
+ * @dev: network interface device structure
+ **/
+static void rnpgbe_assign_netdev_ops(struct net_device *dev)
+{
+	dev->netdev_ops = &rnpgbe_netdev_ops;
+	dev->watchdog_timeo = 5 * HZ;
+}
+
 /**
  * rnpgbe_sw_init - Init driver private status
  * @mucse: pointer to private structure
@@ -289,7 +362,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 			"mucse_mbx_get_capability failed!\n");
 		goto err_free_net;
 	}
-
+	rnpgbe_assign_netdev_ops(netdev);
 	err = rnpgbe_sw_init(mucse);
 	if (err)
 		goto err_free_net;
@@ -305,6 +378,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_HIGHDMA;
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	netdev->hw_features |= netdev->features;
 	eth_hw_addr_set(netdev, hw->perm_addr);
 	memcpy(netdev->perm_addr, hw->perm_addr, netdev->addr_len);
 	ether_addr_copy(hw->addr, hw->perm_addr);
@@ -314,11 +388,17 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
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
@@ -389,8 +469,14 @@ static void rnpgbe_rm_adapter(struct mucse *mucse)
 
 	rnpgbe_devlink_unregister(mucse);
 	netdev = mucse->netdev;
+	if (mucse->flags2 & M_FLAG2_NO_NET_REG) {
+		free_netdev(netdev);
+		return;
+	}
 	cancel_work_sync(&mucse->service_task);
 	timer_delete_sync(&mucse->service_timer);
+	if (netdev->reg_state == NETREG_REGISTERED)
+		unregister_netdev(netdev);
 	hw->ops.driver_status(hw, false, mucse_driver_insmod);
 	remove_mbx_irq(mucse);
 	rnpgbe_clear_interrupt_scheme(mucse);
@@ -432,6 +518,10 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev,
 
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


