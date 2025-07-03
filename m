Return-Path: <netdev+bounces-203588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD3AF6791
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60DE525950
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D724EA80;
	Thu,  3 Jul 2025 01:52:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16091DEFC5;
	Thu,  3 Jul 2025 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507554; cv=none; b=UtLZUu+yIC+BPvcFasc+S+hzjpLODXPTeH4060QOLPMmhHGh6R/GiwkZnqOCyT6t9xkjO4eeMCtc7wWsA8aCJ/7bG7cMuQaRNllTmRmoyeOOwgCIthEb0aM6IU2SDN8jVmPEqWlyxXvDCqlqh68684cPDb4h+tZFpUL3VW0gUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507554; c=relaxed/simple;
	bh=fFTFy7YY4e24+F3RbE9XZGNg8pB5yX/3s4KeQyJhAzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWSEOyWgiWa5GxtcIHLaVlWdAhmIgV544ZJI4AgaCEdzc6rObZGM0sjX91O2SAMyKcr6TZwKOHEAYO+aMe6yLy0srKles2eaUt/HgY4CyBAKpKCoiFc8+8J3MB4Xe+IALyPYwTWoJZ4Qiru35BFSMYFuPkbtcArKrYOmpDhjgc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507410t0972093c
X-QQ-Originating-IP: wTxALNgEqKEpNzQPNcVqHT64xQ5wRt1JfIsr+7SOrGs=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:50:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12658208802092347414
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
Subject: [PATCH 14/15] net: rnpgbe: Add base rx function
Date: Thu,  3 Jul 2025 09:48:58 +0800
Message-Id: <20250703014859.210110-15-dong100@mucse.com>
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
X-QQ-XMAILINFO: MBREESna/OUiZZgeoaS+E/+VEXJhm8T2Ok9VfsST1V3+re7/zXdkQNjq
	YbHfdr4QEyvQZlWFpxGaBzPa5hgoAZsZFNe8zQdCGpNNnqLRqm5S7tTYoSQP1k04yGfm1FW
	RtgOkeecPejANfLWzleT6JGUr8ojE2n0fVhydhBMqp1kwougdtutCXmZMd0JQl30ULWZMuj
	rmJg4G8A8zoAWYgQKmylBlZusIvrw8M5hK5sX2n/99Ngd8wxJbDNWj+DrCJypv6onYWiIQq
	ZQCKGZJRi+ZopxXLSAiX5tcHY3oWApw3C5EAq29MH9Ki9SeuhX2UzCpbysjnpQ8H8N3e84B
	AI3edZMX6tuCNNwyXG6uiae8zxtsCn0d2Llfbjj8wILiIQZcbaTXfu5VgiIgnXlOCPVmfyJ
	NlnRH/6iiaLPM2/WU5RSwviqH1S30NSfHIq9hRij3JC2h22e0u2AN7jazt1z/RmieRld0Dx
	maauF9q0VuvRpe+Gx6gfa3pdNlx7y8hohBwJXCYMMoj9i95Tk9nDsJh4uusQLb5qdW8GMql
	5R+mXpSh8Oji5QPMQQ153p/4OvZ93r9Pi1RZgAuPmMVcA53kh1sNrSK3+FRHy/LvAw8rkuz
	S2oPOm0gFGUFnmWioZrotgVuogvLDQ6+QoPqMmaSCPH7I8QtCD5GzSuT6haomAaMkI6YOwE
	RVppJMnGx7RaDoNSVRiybmX3w4RdS3A1qQBxmC9KF/o1xAJfr20DA53F5ZOfYN47eDzRO9f
	I3QnROQN/qlttvCLdmaV6InQYHRkijj1qsfske+trp4a6UA6LUTRvo91mFsbDyMTiGva7AY
	frkPGPGDsLDdjfG9H9CDorhZ/JVHwc6HdVGG5r2t+MSBwQo90fCMKd/q1sQ2KD+V1cT9UD5
	1RMXSwTG870tko47xDIHpJpsT534Cpc5Xti6e9/03BYnqb4rKTaYSTHsFYjDqJ05jo7x15q
	b8xpCAL/ogovc//CnttS/23uiDlSLLnf19IH5P2LCoeKkRh84ycg8XgqZUndfov6QQymT6D
	Vp2YXHH9r4nKv5kXEB
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Initialize rx clean function.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  22 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 586 ++++++++++++++++--
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   3 +-
 3 files changed, 575 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 7871cb30db58..0b6ba4c3a6cb 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -361,6 +361,7 @@ struct mucse_rx_queue_stats {
 	u64 rx_equal_count;
 	u64 rx_clean_times;
 	u64 rx_clean_count;
+	u64 rx_resync;
 };
 
 union rnpgbe_rx_desc {
@@ -496,6 +497,7 @@ struct mucse_ring {
 	struct mucse_q_vector *q_vector;
 	struct net_device *netdev;
 	struct device *dev;
+	struct page_pool *page_pool;
 	void *desc;
 	union {
 		struct mucse_tx_buffer *tx_buffer_info;
@@ -587,6 +589,7 @@ struct mucse {
 #define M_FLAG_NEED_LINK_UPDATE ((u32)(1 << 0))
 #define M_FLAG_MSIX_ENABLED ((u32)(1 << 1))
 #define M_FLAG_MSI_ENABLED ((u32)(1 << 2))
+#define M_FLAG_SRIOV_ENABLED ((u32)(1 << 23))
 	u32 flags2;
 #define M_FLAG2_NO_NET_REG ((u32)(1 << 0))
 #define M_FLAG2_INSMOD ((u32)(1 << 1))
@@ -636,6 +639,14 @@ static inline u16 mucse_desc_unused(struct mucse_ring *ring)
 	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
 }
 
+static inline u16 mucse_desc_unused_rx(struct mucse_ring *ring)
+{
+	u16 ntc = ring->next_to_clean;
+	u16 ntu = ring->next_to_use;
+
+	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 16;
+}
+
 static inline struct netdev_queue *txring_txq(const struct mucse_ring *ring)
 {
 	return netdev_get_tx_queue(ring->netdev, ring->queue_index);
@@ -647,12 +658,22 @@ static inline __le64 build_ctob(u32 vlan_cmd, u32 mac_ip_len, u32 size)
 			   ((u64)size));
 }
 
+#define M_RXBUFFER_256 (256)
 #define M_RXBUFFER_1536 (1536)
 static inline unsigned int mucse_rx_bufsz(struct mucse_ring *ring)
 {
 	return (M_RXBUFFER_1536 - NET_IP_ALIGN);
 }
 
+#define M_RX_HDR_SIZE M_RXBUFFER_256
+
+/* rnpgbe_test_staterr - tests bits in Rx descriptor status and error fields */
+static inline __le16 rnpgbe_test_staterr(union rnpgbe_rx_desc *rx_desc,
+					 const u16 stat_err_bits)
+{
+	return rx_desc->wb.cmd & cpu_to_le16(stat_err_bits);
+}
+
 #define M_TX_DESC(R, i) (&(((struct rnpgbe_tx_desc *)((R)->desc))[i]))
 #define M_RX_DESC(R, i) (&(((union rnpgbe_rx_desc *)((R)->desc))[i]))
 
@@ -684,6 +705,7 @@ static inline unsigned int mucse_rx_bufsz(struct mucse_ring *ring)
 
 #define M_TRY_LINK_TIMEOUT (4 * HZ)
 
+#define M_RX_BUFFER_WRITE (16)
 #define m_rd_reg(reg) readl((void *)(reg))
 #define m_wr_reg(reg, val) writel((val), (void *)(reg))
 #define hw_wr32(hw, reg, val) m_wr_reg((hw)->hw_addr + (reg), (val))
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 1aab4cb0bbaa..05073663ad0e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -2,10 +2,15 @@
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
 #include <linux/vmalloc.h>
+#include <net/page_pool/helpers.h>
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_lib.h"
 
+static bool rnpgbe_alloc_rx_buffers(struct mucse_ring *rx_ring,
+				    u16 cleaned_count);
 /**
  * rnpgbe_set_rss_queues - Allocate queues for RSS
  * @mucse: pointer to private structure
@@ -263,6 +268,419 @@ static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
 	return total_bytes == 0;
 }
 
+#if (PAGE_SIZE < 8192)
+static inline int rnpgbe_compute_pad(int rx_buf_len)
+{
+	int page_size, pad_size;
+
+	page_size = ALIGN(rx_buf_len, PAGE_SIZE / 2);
+	pad_size = SKB_WITH_OVERHEAD(page_size) - rx_buf_len;
+
+	return pad_size;
+}
+
+static inline int rnpgbe_skb_pad(void)
+{
+	int rx_buf_len = M_RXBUFFER_1536;
+
+	return rnpgbe_compute_pad(rx_buf_len);
+}
+
+#define RNP_SKB_PAD rnpgbe_skb_pad()
+
+static inline int rnpgbe_sg_size(void)
+{
+	int sg_size = SKB_WITH_OVERHEAD(PAGE_SIZE / 2) - RNP_SKB_PAD;
+
+	sg_size -= NET_IP_ALIGN;
+	sg_size = ALIGN_DOWN(sg_size, 4);
+
+	return sg_size;
+}
+
+#define SG_SIZE  rnpgbe_sg_size()
+
+static inline unsigned int rnpgbe_rx_offset(void)
+{
+	return RNP_SKB_PAD;
+}
+
+#else /* PAGE_SIZE < 8192 */
+#define RNP_SKB_PAD (NET_SKB_PAD + NET_IP_ALIGN)
+#endif
+
+static struct mucse_rx_buffer *rnpgbe_get_rx_buffer(struct mucse_ring *rx_ring,
+						    union rnpgbe_rx_desc *rx_desc,
+						    struct sk_buff **skb,
+						    const unsigned int size)
+{
+	struct mucse_rx_buffer *rx_buffer;
+	int time = 0;
+	u16 *data;
+
+	rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
+	data = page_address(rx_buffer->page) + rx_buffer->page_offset;
+	*skb = rx_buffer->skb;
+
+	prefetchw(page_address(rx_buffer->page) + rx_buffer->page_offset);
+
+	/* we are reusing so sync this buffer for CPU use */
+try_sync:
+	dma_sync_single_range_for_cpu(rx_ring->dev, rx_buffer->dma,
+				      rx_buffer->page_offset, size,
+				      DMA_FROM_DEVICE);
+
+	if ((*data == CHECK_DATA) && time < 4) {
+		time++;
+		udelay(5);
+		rx_ring->rx_stats.rx_resync++;
+		goto try_sync;
+	}
+
+	return rx_buffer;
+}
+
+static void rnpgbe_add_rx_frag(struct mucse_ring *rx_ring,
+			       struct mucse_rx_buffer *rx_buffer,
+			       struct sk_buff *skb,
+			       unsigned int size)
+{
+#if (PAGE_SIZE < 8192)
+	unsigned int truesize = PAGE_SIZE / 2;
+#else
+	unsigned int truesize = SKB_DATA_ALIGN(RNP_SKB_PAD + size) :
+#endif
+
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
+			rx_buffer->page_offset, size, truesize);
+}
+
+static struct sk_buff *rnpgbe_build_skb(struct mucse_ring *rx_ring,
+					struct mucse_rx_buffer *rx_buffer,
+					union rnpgbe_rx_desc *rx_desc,
+					unsigned int size)
+{
+	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
+	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
+				SKB_DATA_ALIGN(size + RNP_SKB_PAD);
+	struct sk_buff *skb;
+
+	net_prefetch(va);
+	/* build an skb around the page buffer */
+	skb = build_skb(va - RNP_SKB_PAD, truesize);
+	if (unlikely(!skb))
+		return NULL;
+
+	/* update pointers within the skb to store the data */
+	skb_reserve(skb, RNP_SKB_PAD);
+	__skb_put(skb, size);
+
+	skb_mark_for_recycle(skb);
+
+	return skb;
+}
+
+static void rnpgbe_put_rx_buffer(struct mucse_ring *rx_ring,
+				 struct mucse_rx_buffer *rx_buffer,
+				 struct sk_buff *skb)
+{
+	/* clear contents of rx_buffer */
+	rx_buffer->page = NULL;
+	rx_buffer->skb = NULL;
+}
+
+/**
+ * rnpgbe_is_non_eop - process handling of non-EOP buffers
+ * @rx_ring: Rx ring being processed
+ * @rx_desc: Rx descriptor for current buffer
+ * @skb: Current socket buffer containing buffer in progress
+ *
+ * This function updates next to clean.  If the buffer is an EOP buffer
+ * this function exits returning false, otherwise it will place the
+ * sk_buff in the next buffer to be chained and return true indicating
+ * that this is in fact a non-EOP buffer.
+ **/
+static bool rnpgbe_is_non_eop(struct mucse_ring *rx_ring,
+			      union rnpgbe_rx_desc *rx_desc,
+			      struct sk_buff *skb)
+{
+	u32 ntc = rx_ring->next_to_clean + 1;
+
+	/* fetch, update, and store next to clean */
+	ntc = (ntc < rx_ring->count) ? ntc : 0;
+	rx_ring->next_to_clean = ntc;
+
+	prefetch(M_RX_DESC(rx_ring, ntc));
+
+	/* if we are the last buffer then there is nothing else to do */
+	if (likely(rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP)))
+		return false;
+	/* place skb in next buffer to be received */
+	rx_ring->rx_buffer_info[ntc].skb = skb;
+	rx_ring->rx_stats.non_eop_descs++;
+	/* we should clean it since we used all info in it */
+	rx_desc->wb.cmd = 0;
+
+	return true;
+}
+
+static void rnpgbe_pull_tail(struct sk_buff *skb)
+{
+	skb_frag_t *frag = &skb_shinfo(skb)->frags[0];
+	unsigned char *va;
+	unsigned int pull_len;
+
+	/*
+	 * it is valid to use page_address instead of kmap since we are
+	 * working with pages allocated out of the lomem pool per
+	 * alloc_page(GFP_ATOMIC)
+	 */
+	va = skb_frag_address(frag);
+
+	/*
+	 * we need the header to contain the greater of either ETH_HLEN or
+	 * 60 bytes if the skb->len is less than 60 for skb_pad.
+	 */
+	pull_len = eth_get_headlen(skb->dev, va, M_RX_HDR_SIZE);
+
+	/* align pull length to size of long to optimize memcpy performance */
+	skb_copy_to_linear_data(skb, va, ALIGN(pull_len, sizeof(long)));
+
+	/* update all of the pointers */
+	skb_frag_size_sub(frag, pull_len);
+	skb_frag_off_add(frag, pull_len);
+	skb->data_len -= pull_len;
+	skb->tail += pull_len;
+}
+
+static bool rnpgbe_cleanup_headers(struct mucse_ring __maybe_unused *rx_ring,
+				   union rnpgbe_rx_desc *rx_desc,
+				   struct sk_buff *skb)
+{
+	if (IS_ERR(skb))
+		return true;
+	/* place header in linear portion of buffer */
+	if (!skb_headlen(skb))
+		rnpgbe_pull_tail(skb);
+	/* if eth_skb_pad returns an error the skb was freed */
+	/* will padding skb->len to 60 */
+	if (eth_skb_pad(skb))
+		return true;
+
+	return false;
+}
+
+static inline void rnpgbe_rx_hash(struct mucse_ring *ring,
+				  union rnpgbe_rx_desc *rx_desc,
+				  struct sk_buff *skb)
+{
+	int rss_type;
+
+	if (!(ring->netdev->features & NETIF_F_RXHASH))
+		return;
+#define M_RSS_TYPE_MASK 0xc0
+	rss_type = rx_desc->wb.cmd & M_RSS_TYPE_MASK;
+	skb_set_hash(skb, le32_to_cpu(rx_desc->wb.rss_hash),
+		     rss_type ? PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
+}
+
+/**
+ * rnpgbe_rx_checksum - indicate in skb if hw indicated a good cksum
+ * @ring: structure containing ring specific data
+ * @rx_desc: current Rx descriptor being processed
+ * @skb: skb currently being received and modified
+ **/
+static inline void rnpgbe_rx_checksum(struct mucse_ring *ring,
+				      union rnpgbe_rx_desc *rx_desc,
+				      struct sk_buff *skb)
+{
+	skb_checksum_none_assert(skb);
+	/* Rx csum disabled */
+	if (!(ring->netdev->features & NETIF_F_RXCSUM))
+		return;
+
+	/* if outer L3/L4  error */
+	/* must in promisc mode or rx-all mode */
+	if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_ERR_MASK))
+		return;
+	ring->rx_stats.csum_good++;
+	/* at least it is a ip packet which has ip checksum */
+
+	/* It must be a TCP or UDP packet with a valid checksum */
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+}
+
+static inline int ignore_veb_vlan(struct mucse *mucse,
+				  union rnpgbe_rx_desc *rx_desc)
+{
+	if (unlikely((mucse->flags & M_FLAG_SRIOV_ENABLED) &&
+		     (cpu_to_le16(rx_desc->wb.rev1) & VEB_VF_IGNORE_VLAN))) {
+		return 1;
+	}
+	return 0;
+}
+
+static inline __le16 rnpgbe_test_ext_cmd(union rnpgbe_rx_desc *rx_desc,
+					 const u16 stat_err_bits)
+{
+	return rx_desc->wb.rev1 & cpu_to_le16(stat_err_bits);
+}
+
+static void rnpgbe_process_skb_fields(struct mucse_ring *rx_ring,
+				      union rnpgbe_rx_desc *rx_desc,
+				      struct sk_buff *skb)
+{
+	struct net_device *dev = rx_ring->netdev;
+	struct mucse *mucse = netdev_priv(dev);
+
+	rnpgbe_rx_hash(rx_ring, rx_desc, skb);
+	rnpgbe_rx_checksum(rx_ring, rx_desc, skb);
+
+	if (((dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
+	     (dev->features & NETIF_F_HW_VLAN_STAG_RX)) &&
+	    rnpgbe_test_staterr(rx_desc, M_RXD_STAT_VLAN_VALID) &&
+	    !ignore_veb_vlan(mucse, rx_desc)) {
+		if (rnpgbe_test_ext_cmd(rx_desc, REV_OUTER_VLAN)) {
+			u16 vid_inner = le16_to_cpu(rx_desc->wb.vlan);
+			u16 vid_outer;
+			u16 vlan_tci = htons(ETH_P_8021Q);
+
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+					       vid_inner);
+			/* check outer vlan type */
+			if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_STAG))
+				vlan_tci = htons(ETH_P_8021AD);
+			else
+				vlan_tci = htons(ETH_P_8021Q);
+			vid_outer = le16_to_cpu(rx_desc->wb.mark);
+			/* push outer */
+			skb = __vlan_hwaccel_push_inside(skb);
+			__vlan_hwaccel_put_tag(skb, vlan_tci, vid_outer);
+		} else {
+			/* only inner vlan */
+			u16 vid = le16_to_cpu(rx_desc->wb.vlan);
+			/* check vlan type */
+			if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_STAG)) {
+				__vlan_hwaccel_put_tag(skb,
+						       htons(ETH_P_8021AD),
+						       vid);
+			} else {
+				__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+						       vid);
+			}
+		}
+		rx_ring->rx_stats.vlan_remove++;
+	}
+	skb_record_rx_queue(skb, rx_ring->queue_index);
+	skb->protocol = eth_type_trans(skb, dev);
+}
+
+/**
+ * rnpgbe_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
+ * @q_vector: structure containing interrupt and ring information
+ * @rx_ring: rx descriptor ring to transact packets on
+ * @budget: Total limit on number of packets to process
+ *
+ * This function provides a "bounce buffer" approach to Rx interrupt
+ * processing.  The advantage to this is that on systems that have
+ * expensive overhead for IOMMU access this provides a means of avoiding
+ * it by maintaining the mapping of the page to the system.
+ *
+ * Returns amount of work completed.
+ **/
+static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
+			       struct mucse_ring *rx_ring,
+			       int budget)
+{
+	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
+	unsigned int driver_drop_packets = 0;
+	u16 cleaned_count = mucse_desc_unused_rx(rx_ring);
+	bool fail_alloc = false;
+
+	while (likely(total_rx_packets < budget)) {
+		union rnpgbe_rx_desc *rx_desc;
+		struct mucse_rx_buffer *rx_buffer;
+		struct sk_buff *skb;
+		unsigned int size;
+
+		/* return some buffers to hardware, one at a time is too slow */
+		if (cleaned_count >= M_RX_BUFFER_WRITE) {
+			fail_alloc = rnpgbe_alloc_rx_buffers(rx_ring, cleaned_count) || fail_alloc;
+			cleaned_count = 0;
+		}
+		rx_desc = M_RX_DESC(rx_ring, rx_ring->next_to_clean);
+
+		if (!rnpgbe_test_staterr(rx_desc, M_RXD_STAT_DD))
+			break;
+
+		/* This memory barrier is needed to keep us from reading
+		 * any other fields out of the rx_desc until we know the
+		 * descriptor has been written back
+		 */
+		dma_rmb();
+		size = le16_to_cpu(rx_desc->wb.len);
+		if (!size)
+			break;
+
+		rx_buffer = rnpgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
+
+		if (skb)
+			rnpgbe_add_rx_frag(rx_ring, rx_buffer, skb, size);
+		else
+			skb = rnpgbe_build_skb(rx_ring, rx_buffer, rx_desc,
+					       size);
+		/* exit if we failed to retrieve a buffer */
+		if (!skb) {
+			page_pool_recycle_direct(rx_ring->page_pool,
+						 rx_buffer->page);
+			rx_ring->rx_stats.alloc_rx_buff_failed++;
+			break;
+		}
+
+		rnpgbe_put_rx_buffer(rx_ring, rx_buffer, skb);
+		cleaned_count++;
+
+		/* place incomplete frames back on ring for completion */
+		if (rnpgbe_is_non_eop(rx_ring, rx_desc, skb))
+			continue;
+
+		/* verify the packet layout is correct */
+		if (rnpgbe_cleanup_headers(rx_ring, rx_desc, skb)) {
+			/* we should clean it since we used all info in it */
+			rx_desc->wb.cmd = 0;
+			continue;
+		}
+
+		/* probably a little skewed due to removing CRC */
+		total_rx_bytes += skb->len;
+		/* populate checksum, timestamp, VLAN, and protocol */
+		rnpgbe_process_skb_fields(rx_ring, rx_desc, skb);
+		/* we should clean it since we used all info in it */
+		rx_desc->wb.cmd = 0;
+		napi_gro_receive(&q_vector->napi, skb);
+		/* update budget accounting */
+		total_rx_packets++;
+	}
+
+	u64_stats_update_begin(&rx_ring->syncp);
+	rx_ring->stats.packets += total_rx_packets;
+	rx_ring->stats.bytes += total_rx_bytes;
+	rx_ring->rx_stats.driver_drop_packets += driver_drop_packets;
+	rx_ring->rx_stats.rx_clean_count += total_rx_packets;
+	rx_ring->rx_stats.rx_clean_times++;
+	if (rx_ring->rx_stats.rx_clean_times > 10) {
+		rx_ring->rx_stats.rx_clean_times = 0;
+		rx_ring->rx_stats.rx_clean_count = 0;
+	}
+	u64_stats_update_end(&rx_ring->syncp);
+	q_vector->rx.total_packets += total_rx_packets;
+	q_vector->rx.total_bytes += total_rx_bytes;
+
+	if (total_rx_packets >= budget)
+		rx_ring->rx_stats.poll_again_count++;
+	return fail_alloc ? budget : total_rx_packets;
+}
+
 /**
  * rnpgbe_poll - NAPI Rx polling callback
  * @napi: structure for representing this polling device
@@ -276,11 +694,26 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 		container_of(napi, struct mucse_q_vector, napi);
 	struct mucse *mucse = q_vector->mucse;
 	struct mucse_ring *ring;
-	int work_done = 0;
+	int per_ring_budget, work_done = 0;
 	bool clean_complete = true;
+	int cleaned_total = 0;
 
 	mucse_for_each_ring(ring, q_vector->tx)
 		clean_complete = rnpgbe_clean_tx_irq(q_vector, ring, budget);
+	if (q_vector->rx.count > 1)
+		per_ring_budget = max(budget / q_vector->rx.count, 1);
+	else
+		per_ring_budget = budget;
+
+	mucse_for_each_ring(ring, q_vector->rx) {
+		int cleaned = 0;
+
+		cleaned = rnpgbe_clean_rx_irq(q_vector, ring, per_ring_budget);
+		work_done += cleaned;
+		cleaned_total += cleaned;
+		if (cleaned >= per_ring_budget)
+			clean_complete = false;
+	}
 
 	if (!netif_running(mucse->netdev))
 		clean_complete = true;
@@ -799,6 +1232,30 @@ static void rnpgbe_free_all_tx_resources(struct mucse *mucse)
 		rnpgbe_free_tx_resources(mucse->tx_ring[i]);
 }
 
+static int mucse_alloc_page_pool(struct mucse_ring *rx_ring)
+{
+	int ret = 0;
+
+	struct page_pool_params pp_params = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order = 0,
+		.pool_size = rx_ring->size,
+		.nid = dev_to_node(rx_ring->dev),
+		.dev = rx_ring->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.offset = 0,
+		.max_len = PAGE_SIZE,
+	};
+
+	rx_ring->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(rx_ring->page_pool)) {
+		ret = PTR_ERR(rx_ring->page_pool);
+		rx_ring->page_pool = NULL;
+	}
+
+	return ret;
+}
+
 /**
  * rnpgbe_setup_rx_resources - allocate Rx resources (Descriptors)
  * @rx_ring:    rx descriptor ring (for a specific queue) to setup
@@ -841,6 +1298,7 @@ static int rnpgbe_setup_rx_resources(struct mucse_ring *rx_ring,
 	memset(rx_ring->desc, 0, rx_ring->size);
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
+	mucse_alloc_page_pool(rx_ring);
 
 	return 0;
 err:
@@ -870,13 +1328,7 @@ static void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring)
 					      rx_buffer->page_offset,
 					      mucse_rx_bufsz(rx_ring),
 					      DMA_FROM_DEVICE);
-		/* free resources associated with mapping */
-		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
-				     PAGE_SIZE,
-				     DMA_FROM_DEVICE,
-				     M_RX_DMA_ATTR);
-		__page_frag_cache_drain(rx_buffer->page,
-					rx_buffer->pagecnt_bias);
+		page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
 		rx_buffer->page = NULL;
 		i++;
 		rx_buffer++;
@@ -909,6 +1361,10 @@ static void rnpgbe_free_rx_resources(struct mucse_ring *rx_ring)
 	dma_free_coherent(rx_ring->dev, rx_ring->size, rx_ring->desc,
 			  rx_ring->dma);
 	rx_ring->desc = NULL;
+	if (rx_ring->page_pool) {
+		page_pool_destroy(rx_ring->page_pool);
+		rx_ring->page_pool = NULL;
+	}
 }
 
 /**
@@ -1049,44 +1505,103 @@ void rnpgbe_disable_rx_queue(struct mucse_ring *ring)
 	ring_wr32(ring, DMA_RX_START, 0);
 }
 
-#if (PAGE_SIZE < 8192)
-static inline int rnpgbe_compute_pad(int rx_buf_len)
+static bool mucse_alloc_mapped_page(struct mucse_ring *rx_ring,
+				    struct mucse_rx_buffer *bi)
 {
-	int page_size, pad_size;
-
-	page_size = ALIGN(rx_buf_len, PAGE_SIZE / 2);
-	pad_size = SKB_WITH_OVERHEAD(page_size) - rx_buf_len;
+	struct page *page = bi->page;
+	dma_addr_t dma;
 
-	return pad_size;
-}
+	/* since we are recycling buffers we should seldom need to alloc */
+	if (likely(page))
+		return true;
 
-static inline int rnpgbe_sg_size(void)
-{
-	int sg_size = SKB_WITH_OVERHEAD(PAGE_SIZE / 2) - NET_SKB_PAD;
+	page = page_pool_dev_alloc_pages(rx_ring->page_pool);
+	dma = page_pool_get_dma_addr(page);
 
-	sg_size -= NET_IP_ALIGN;
-	sg_size = ALIGN_DOWN(sg_size, 4);
+	bi->dma = dma;
+	bi->page = page;
+	bi->page_offset = RNP_SKB_PAD;
 
-	return sg_size;
+	return true;
 }
 
-#define SG_SIZE  rnpgbe_sg_size()
-static inline int rnpgbe_skb_pad(void)
+static inline void mucse_update_rx_tail(struct mucse_ring *rx_ring,
+					u32 val)
 {
-	int rx_buf_len = SG_SIZE;
-
-	return rnpgbe_compute_pad(rx_buf_len);
+	rx_ring->next_to_use = val;
+	/* update next to alloc since we have filled the ring */
+	rx_ring->next_to_alloc = val;
+	/*
+	 * Force memory writes to complete before letting h/w
+	 * know there are new descriptors to fetch.  (Only
+	 * applicable for weak-ordered memory model archs,
+	 * such as IA-64).
+	 */
+	wmb();
+	m_wr_reg(rx_ring->tail, val);
 }
 
-#define RNP_SKB_PAD rnpgbe_skb_pad()
-static inline unsigned int rnpgbe_rx_offset(void)
+/**
+ * rnpgbe_alloc_rx_buffers - Replace used receive buffers
+ * @rx_ring: ring to place buffers on
+ * @cleaned_count: number of buffers to replace
+ **/
+static bool rnpgbe_alloc_rx_buffers(struct mucse_ring *rx_ring,
+				    u16 cleaned_count)
 {
-	return RNP_SKB_PAD;
-}
+	union rnpgbe_rx_desc *rx_desc;
+	struct mucse_rx_buffer *bi;
+	u16 i = rx_ring->next_to_use;
+	u64 fun_id = ((u64)(rx_ring->pfvfnum) << (32 + 24));
+	bool err = false;
+	u16 bufsz;
+	/* nothing to do */
+	if (!cleaned_count)
+		return err;
 
-#else /* PAGE_SIZE < 8192 */
-#define RNP_SKB_PAD (NET_SKB_PAD + NET_IP_ALIGN)
-#endif
+	rx_desc = M_RX_DESC(rx_ring, i);
+	bi = &rx_ring->rx_buffer_info[i];
+	i -= rx_ring->count;
+	bufsz = mucse_rx_bufsz(rx_ring);
+
+	do {
+		if (!mucse_alloc_mapped_page(rx_ring, bi)) {
+			err = true;
+			break;
+		}
+
+		{
+			u16 *data = page_address(bi->page) + bi->page_offset;
+
+			*data = CHECK_DATA;
+		}
+
+		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
+						 bi->page_offset, bufsz,
+						 DMA_FROM_DEVICE);
+		rx_desc->pkt_addr =
+			cpu_to_le64(bi->dma + bi->page_offset + fun_id);
+
+		/* clean dd */
+		rx_desc->resv_cmd = 0;
+		rx_desc++;
+		bi++;
+		i++;
+		if (unlikely(!i)) {
+			rx_desc = M_RX_DESC(rx_ring, 0);
+			bi = rx_ring->rx_buffer_info;
+			i -= rx_ring->count;
+		}
+		cleaned_count--;
+	} while (cleaned_count);
+
+	i += rx_ring->count;
+
+	if (rx_ring->next_to_use != i)
+		mucse_update_rx_tail(rx_ring, i);
+
+	return err;
+}
 
 static void rnpgbe_configure_rx_ring(struct mucse *mucse,
 				     struct mucse_ring *ring)
@@ -1126,6 +1641,7 @@ static void rnpgbe_configure_rx_ring(struct mucse *mucse,
 	ring_wr32(ring, DMA_REG_RX_INT_DELAY_TIMER,
 		  mucse->rx_usecs * hw->usecstocount);
 	ring_wr32(ring, DMA_REG_RX_INT_DELAY_PKTCNT, mucse->rx_frames);
+	rnpgbe_alloc_rx_buffers(ring, mucse_desc_unused_rx(ring));
 }
 
 /**
@@ -1151,7 +1667,7 @@ void rnpgbe_configure_rx(struct mucse *mucse)
 
 /**
  * rnpgbe_clean_all_tx_rings - Free Tx Buffers for all queues
- * @adapter: board private structure
+ * @mucse: board private structure
  **/
 void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
 {
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 7179e5ebfbf0..5c7e4bd6297f 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -6,6 +6,7 @@
 
 #include "rnpgbe.h"
 
+#define CHECK_DATA (0xabcd)
 #define RING_OFFSET(n) (0x100 * (n))
 #define DMA_DUMY (0xc)
 #define DMA_AXI_EN (0x10)
@@ -106,7 +107,7 @@ static inline void rnpgbe_irq_disable_queues(struct mucse_q_vector *q_vector)
 
 /**
  * rnpgbe_irq_disable - Mask off interrupt generation on the NIC
- * @adapter: board private structure
+ * @mucse: board private structure
  **/
 static inline void rnpgbe_irq_disable(struct mucse *mucse)
 {
-- 
2.25.1


