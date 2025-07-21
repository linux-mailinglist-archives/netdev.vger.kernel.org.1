Return-Path: <netdev+bounces-208583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B65E9B0C34B
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8921885386
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2622BDC19;
	Mon, 21 Jul 2025 11:35:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324952877F5;
	Mon, 21 Jul 2025 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097756; cv=none; b=k6sdeRpXzlsH/ukd8CegfZUSOGls874GqaVyfnPlhyBC7cRVMpF38Vo6ntwBPwK3xML0UzLvdjbwKTtQz7sibVlj1jcczZt7aRiik2uiRmTaYem5+0E5uwSM/HfMzlYyxF95Aru3z/AzU/b+Dwe9Fo4aUTrFSWfPWsKnTlwvTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097756; c=relaxed/simple;
	bh=RG6bwRcCcc1AiujH53GQyNTnkI+tnuAoYlt6gJnlQgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1wUc7kdEhn6dqstKVuY5caeqJ6+w7g/FlI+nSP4HvWI0P7CvHfmnI/eKfFTqEnpHwGUyk7uTqvVwk5FE5z3bbfV2KLqgQvRqcUOKJalVX8tvXyd/tdkUav3rxLebJBuuwxemsjDGPv7IrNa3aXCs58S5eDRficTR8XsM4YHY6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097632ta8b187fc
X-QQ-Originating-IP: kQTHuZbwoijf/mBgLEJHmJzRAFSqrcNJP5vPuBlD6ck=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:33:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13417546290855177934
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
Subject: [PATCH v2 14/15] net: rnpgbe: Add base rx function
Date: Mon, 21 Jul 2025 19:32:37 +0800
Message-Id: <20250721113238.18615-15-dong100@mucse.com>
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
X-QQ-XMAILINFO: OURTxbnUKnooUJ6y2Az48U6J3xNy4TRCGfczQqV03qLl24qT6CC3V+tS
	iwVomMr9qaBZSi4Hrs4yJ5lVuzdCJqG+b3/aLCBaA1Gq5d0xVxo0Bmfd8DcDlB0jup5C+ES
	bMfFUA+IEXturv9D0b3qYXPSlfS1mlse/OmKaYdAso8qOBijtymYo4wjQdF8gCSL+df+WSF
	yHq+U0Js77jgS50/iwTybiRY/LxEtvxwb8/wmqkdtyXjVwiyJVmR2M18gCSqSyZCi6S0aXS
	ri8HREK7ZRR4cAp+wOnRzQT2WUbvRplRh9oMOvaiJ8rYmQnI77mla+thnWnENmP/96CVT9b
	6vGuqRCXgRTBiitW45+q9EOJDcqY7mS5dLDrnVnmYft+m9auvO8q0+1nNFXk0Jm7rn2Yj0F
	a/orRHJfKQyOP+FfI/0U9K0ObyAH/wHw3PN+SAV3+NJb6FKdPguTf8K5VxX+X48fl/8ikxO
	7VSymYlyQ6ZNmIw6IV/s4lj1dshq56WNRr7+EAdrCvl/35ZFbIxbbOcGBfegEejMgP4ZTTC
	4+k+6O9Y5d1prDdOv7F7lKKEMu32fcW4uGNHqGEzl72GFUY3LYG8iEC1zbAh4UvHE5NGODS
	iRF1vNnAk6zTVYblLabFobltPJk5sOc4M99KEUBUseKBMBpMLn+x2PUu7MSfZDsv3M/UOwo
	bWxMy99D5QE4C7Pe0HuWhMr0HK1eQjZF9FSYoYuypH0VHcNkzka17cWmIX6w/M9d4PUGg9W
	2vgFwFAomrjJ0gtuZcdDsuU4/lsg+NK1zYRTUfwRv8kuQSeA5fLS4yQ/HGEecb4yxFLPjjj
	1LlGXp0Gca7tBjUd5mYGvfNGn3FhnWONJ/STbKXuSFH2Tbj1+0W9fU1AFPcmxo34FnwiOFP
	vtClG41Ewr14PisRu09d3GnWSZZ8JqwfSsB//cnCrBdDpJi01+gOIz9effbGSxWTHYXnfGt
	yEpNFg3pjCTAfiLP7DsutK9IJc36MFKmsdiCbHI5effIWAlbROre8X9kKlBcRa+VF3vBZqu
	4iuYWRxfQbzM21SCCwtLaNK2sSjlKSI1cowsrlcJi3z77j7Qeh
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Initialize rx clean function.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  23 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 547 +++++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  33 ++
 3 files changed, 602 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 26774c214da0..9d8d939d81a4 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -362,6 +362,7 @@ struct mucse_rx_queue_stats {
 	u64 rx_equal_count;
 	u64 rx_clean_times;
 	u64 rx_clean_count;
+	u64 rx_resync;
 };
 
 union rnpgbe_rx_desc {
@@ -492,6 +493,7 @@ struct mucse_ring {
 	struct mucse_q_vector *q_vector;
 	struct net_device *netdev;
 	struct device *dev;
+	struct page_pool *page_pool;
 	void *desc;
 	union {
 		struct mucse_tx_buffer *tx_buffer_info;
@@ -584,6 +586,7 @@ struct mucse {
 #define M_FLAG_NEED_LINK_UPDATE BIT(0)
 #define M_FLAG_MSIX_ENABLED BIT(1)
 #define M_FLAG_MSI_ENABLED BIT(2)
+#define M_FLAG_SRIOV_ENABLED BIT(23)
 	u32 flags2;
 #define M_FLAG2_NO_NET_REG BIT(0)
 #define M_FLAG2_INSMOD BIT(1)
@@ -633,6 +636,14 @@ static inline u16 mucse_desc_unused(struct mucse_ring *ring)
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
@@ -644,12 +655,21 @@ static inline __le64 build_ctob(u32 vlan_cmd, u32 mac_ip_len, u32 size)
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
+static inline __le16 rnpgbe_test_staterr(union rnpgbe_rx_desc *rx_desc,
+					 const u16 stat_err_bits)
+{
+	return rx_desc->wb.cmd & cpu_to_le16(stat_err_bits);
+}
+
 #define M_TX_DESC(R, i) (&(((struct rnpgbe_tx_desc *)((R)->desc))[i]))
 #define M_RX_DESC(R, i) (&(((union rnpgbe_rx_desc *)((R)->desc))[i]))
 
@@ -681,6 +701,7 @@ static inline unsigned int mucse_rx_bufsz(struct mucse_ring *ring)
 
 #define M_TRY_LINK_TIMEOUT (4 * HZ)
 
+#define M_RX_BUFFER_WRITE (16)
 #define m_rd_reg(reg) readl(reg)
 #define m_wr_reg(reg, val) writel((val), reg)
 #define hw_wr32(hw, reg, val) m_wr_reg((hw)->hw_addr + (reg), (val))
@@ -700,6 +721,8 @@ static inline unsigned int mucse_rx_bufsz(struct mucse_ring *ring)
 #define mucse_dbg(mucse, fmt, arg...) \
 	dev_dbg(&(mucse)->pdev->dev, fmt, ##arg)
 
+#define M_SKB_PAD (NET_SKB_PAD + NET_IP_ALIGN)
+
 void rnpgbe_service_event_schedule(struct mucse *mucse);
 
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 1e1919750a9b..675ed12cffcb 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -3,11 +3,16 @@
 
 #include <linux/vmalloc.h>
 #include <linux/iopoll.h>
+#include <net/page_pool/helpers.h>
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_lib.h"
 #include "rnpgbe_mbx_fw.h"
 
+static bool rnpgbe_alloc_rx_buffers(struct mucse_ring *rx_ring,
+				    u16 cleaned_count);
 /**
  * rnpgbe_set_rss_queues - Allocate queues for RSS
  * @mucse: pointer to private structure
@@ -285,6 +290,409 @@ static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
 	return total_bytes == 0;
 }
 
+/**
+ * rnpgbe_get_buffer - get the rx_buffer to be used
+ * @rx_ring: pointer to rx ring
+ * @rx_desc: pointer to rx_ring for this packet
+ * @skb: pointer skb for this packet
+ * @size: data size in this desc
+ * @return: rx_buffer.
+ **/
+static struct mucse_rx_buffer *rnpgbe_get_buffer(struct mucse_ring *rx_ring,
+						 union rnpgbe_rx_desc *rx_desc,
+						 struct sk_buff **skb,
+						 const unsigned int size)
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
+/**
+ * rnpgbe_add_rx_frag - Add no-linear data to the skb
+ * @rx_ring: pointer to rx ring
+ * @rx_buffer: pointer to rx_buffer
+ * @skb: pointer skb for this packet
+ * @size: data size in this desc
+ **/
+static void rnpgbe_add_rx_frag(struct mucse_ring *rx_ring,
+			       struct mucse_rx_buffer *rx_buffer,
+			       struct sk_buff *skb,
+			       unsigned int size)
+{
+	unsigned int truesize = SKB_DATA_ALIGN(M_SKB_PAD + size);
+
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
+			rx_buffer->page_offset, size, truesize);
+}
+
+/**
+ * rnpgbe_build_skb - Try to build a sbk based on rx_buffer
+ * @rx_ring: pointer to rx ring
+ * @rx_buffer: pointer to rx_buffer
+ * @rx_desc: pointer to rx desc for this data
+ * @size: data size in this desc
+ * @return: skb for this rx_buffer
+ **/
+static struct sk_buff *rnpgbe_build_skb(struct mucse_ring *rx_ring,
+					struct mucse_rx_buffer *rx_buffer,
+					union rnpgbe_rx_desc *rx_desc,
+					unsigned int size)
+{
+	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
+				SKB_DATA_ALIGN(size + M_SKB_PAD);
+	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
+	struct sk_buff *skb;
+
+	net_prefetch(va);
+	/* build an skb around the page buffer */
+	skb = build_skb(va - M_SKB_PAD, truesize);
+	if (unlikely(!skb))
+		return NULL;
+
+	/* update pointers within the skb to store the data */
+	skb_reserve(skb, M_SKB_PAD);
+	__skb_put(skb, size);
+
+	skb_mark_for_recycle(skb);
+
+	return skb;
+}
+
+/**
+ * rnpgbe_put_rx_buffer - clear rx_buffer for next use
+ * @rx_ring: pointer to rx ring
+ * @rx_buffer: pointer to rx_buffer
+ **/
+static void rnpgbe_put_rx_buffer(struct mucse_ring *rx_ring,
+				 struct mucse_rx_buffer *rx_buffer)
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
+ *
+ * @return: true for not end of packet
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
+/**
+ * rnpgbe_pull_tail - Pull header to linear portion of buffer
+ * @skb: Current socket buffer containing buffer in progress
+ **/
+static void rnpgbe_pull_tail(struct sk_buff *skb)
+{
+	skb_frag_t *frag = &skb_shinfo(skb)->frags[0];
+	unsigned int pull_len;
+	unsigned char *va;
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
+/**
+ * rnpgbe_cleanup_headers - Correct corrupted or empty headers
+ * @skb: Current socket buffer containing buffer in progress
+ * @return: true if an error was encountered and skb was freed.
+ **/
+static bool rnpgbe_cleanup_headers(struct sk_buff *skb)
+{
+	if (IS_ERR(skb))
+		return true;
+	/* place header in linear portion of buffer */
+	if (!skb_headlen(skb))
+		rnpgbe_pull_tail(skb);
+	/* if eth_skb_pad returns an error the skb was freed */
+	if (eth_skb_pad(skb))
+		return true;
+
+	return false;
+}
+
+/**
+ * rnpgbe_rx_hash - Setup hash type for skb
+ * @ring: Rx ring being processed
+ * @rx_desc: Rx descriptor for current buffer
+ * @skb: Current socket buffer containing buffer in progress
+ **/
+static void rnpgbe_rx_hash(struct mucse_ring *ring,
+			   union rnpgbe_rx_desc *rx_desc,
+			   struct sk_buff *skb)
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
+static void rnpgbe_rx_checksum(struct mucse_ring *ring,
+			       union rnpgbe_rx_desc *rx_desc,
+			       struct sk_buff *skb)
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
+/**
+ * rnpgbe_process_skb_fields - Setup skb header fields from desc
+ * @rx_ring: structure containing ring specific data
+ * @rx_desc: current Rx descriptor being processed
+ * @skb: skb currently being received and modified
+ *
+ * rnpgbe_process_skb_fields checks the ring, descriptor information
+ * in order to setup the hash, chksum, vlan, protocol, and other
+ * fields within the skb.
+ **/
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
+			u16 vlan_tci = htons(ETH_P_8021Q);
+			u16 vid_outer;
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
+ * rnpgbe_clean_rx_irq - Clean completed descriptors from Rx ring
+ * @q_vector: structure containing interrupt and ring information
+ * @rx_ring: rx descriptor ring to transact packets on
+ * @budget: Total limit on number of packets to process
+ *
+ * rnpgbe_clean_rx_irq tries to check dd in desc, handle this desc
+ * if dd is set which means data is write-back by hw
+ *
+ * @return: amount of work completed.
+ **/
+static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
+			       struct mucse_ring *rx_ring,
+			       int budget)
+{
+	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
+	u16 cleaned_count = mucse_desc_unused_rx(rx_ring);
+	unsigned int driver_drop_packets = 0;
+	bool fail_alloc = false;
+	bool new = false;
+
+	while (likely(total_rx_packets < budget)) {
+		struct mucse_rx_buffer *rx_buffer;
+		union rnpgbe_rx_desc *rx_desc;
+		struct sk_buff *skb;
+		unsigned int size;
+
+		/* return some buffers to hardware, one at a time is too slow */
+		if (cleaned_count >= M_RX_BUFFER_WRITE) {
+			new = rnpgbe_alloc_rx_buffers(rx_ring, cleaned_count);
+			fail_alloc = new || fail_alloc;
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
+		rx_buffer = rnpgbe_get_buffer(rx_ring, rx_desc, &skb, size);
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
+		rnpgbe_put_rx_buffer(rx_ring, rx_buffer);
+		cleaned_count++;
+
+		/* place incomplete frames back on ring for completion */
+		if (rnpgbe_is_non_eop(rx_ring, rx_desc, skb))
+			continue;
+
+		/* verify the packet layout is correct */
+		if (rnpgbe_cleanup_headers(skb)) {
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
  * rnpgbe_poll - NAPI polling RX/TX cleanup routine
  * @napi: napi struct with our devices info in it
@@ -299,12 +707,27 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 	struct mucse_q_vector *q_vector =
 		container_of(napi, struct mucse_q_vector, napi);
 	struct mucse *mucse = q_vector->mucse;
+	int per_ring_budget, work_done = 0;
 	bool clean_complete = true;
 	struct mucse_ring *ring;
-	int work_done = 0;
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
@@ -829,6 +1252,35 @@ static void rnpgbe_free_all_tx_resources(struct mucse *mucse)
 		rnpgbe_free_tx_resources(mucse->tx_ring[i]);
 }
 
+/**
+ * mucse_alloc_page_pool - Alloc page poll for tis ring
+ * @rx_ring: pointer to rx ring
+ * @return: 0 if success
+ **/
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
  * @rx_ring: rx descriptor ring (for a specific queue) to setup
@@ -871,6 +1323,8 @@ static int rnpgbe_setup_rx_resources(struct mucse_ring *rx_ring,
 	memset(rx_ring->desc, 0, rx_ring->size);
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
+	if (mucse_alloc_page_pool(rx_ring)
+		goto err;
 
 	return 0;
 err:
@@ -901,6 +1355,7 @@ static void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring)
 					      rx_buffer->page_offset,
 					      mucse_rx_bufsz(rx_ring),
 					      DMA_FROM_DEVICE);
+		page_pool_recycle_direct(rx_ring->page_pool, rx_buffer->page);
 		rx_buffer->page = NULL;
 		i++;
 		rx_buffer++;
@@ -933,6 +1388,10 @@ static void rnpgbe_free_rx_resources(struct mucse_ring *rx_ring)
 	dma_free_coherent(rx_ring->dev, rx_ring->size, rx_ring->desc,
 			  rx_ring->dma);
 	rx_ring->desc = NULL;
+	if (rx_ring->page_pool) {
+		page_pool_destroy(rx_ring->page_pool);
+		rx_ring->page_pool = NULL;
+	}
 }
 
 /**
@@ -1076,6 +1535,91 @@ void rnpgbe_disable_rx_queue(struct mucse_ring *ring)
 	ring_wr32(ring, DMA_RX_START, 0);
 }
 
+/**
+ * mucse_alloc_mapped_page - Alloc page for this rx_buffer
+ * @rx_ring: pointer to rx ring
+ * @bi: pointer to this rx_buffer structure
+ *
+ * mucse_alloc_mapped_page alloc memory page for this rx_buffer
+ **/
+static bool mucse_alloc_mapped_page(struct mucse_ring *rx_ring,
+				    struct mucse_rx_buffer *bi)
+{
+	struct page *page = bi->page;
+	dma_addr_t dma;
+
+	page = page_pool_dev_alloc_pages(rx_ring->page_pool);
+	dma = page_pool_get_dma_addr(page);
+
+	bi->dma = dma;
+	bi->page = page;
+	bi->page_offset = M_SKB_PAD;
+
+	if (likely(page))
+		return true;
+	else
+		return false;
+}
+
+/**
+ * rnpgbe_alloc_rx_buffers - Replace used receive buffers
+ * @rx_ring: ring to place buffers on
+ * @cleaned_count: number of buffers to replace
+ **/
+static bool rnpgbe_alloc_rx_buffers(struct mucse_ring *rx_ring,
+				    u16 cleaned_count)
+{
+	u64 fun_id = ((u64)(rx_ring->pfvfnum) << (32 + 24));
+	union rnpgbe_rx_desc *rx_desc;
+	u16 i = rx_ring->next_to_use;
+	struct mucse_rx_buffer *bi;
+	bool err = false;
+	u16 *data;
+	u16 bufsz;
+	/* nothing to do */
+	if (!cleaned_count)
+		return err;
+
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
+		data = page_address(bi->page) + bi->page_offset;
+		*data = CHECK_DATA;
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
+
 /**
  * rnpgbe_configure_rx_ring - Configure Rx ring after Reset
  * @mucse: pointer to private structure
@@ -1115,6 +1659,7 @@ static void rnpgbe_configure_rx_ring(struct mucse *mucse,
 	ring_wr32(ring, DMA_REG_RX_INT_DELAY_TIMER,
 		  mucse->rx_usecs * hw->usecstocount);
 	ring_wr32(ring, DMA_REG_RX_INT_DELAY_PKTCNT, mucse->rx_frames);
+	rnpgbe_alloc_rx_buffers(ring, mucse_desc_unused_rx(ring));
 }
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 5a3334789f66..c138919c1b9a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -6,6 +6,7 @@
 
 #include "rnpgbe.h"
 
+#define CHECK_DATA (0xabcd)
 #define RING_OFFSET(n) (0x100 * (n))
 #define DMA_DUMY (0xc)
 #define DMA_AXI_EN (0x10)
@@ -123,6 +124,38 @@ static inline void rnpgbe_irq_disable(struct mucse *mucse)
 	}
 }
 
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
+static inline void mucse_update_rx_tail(struct mucse_ring *rx_ring,
+					u32 val)
+{
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
+}
+
 int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
 void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
 int rnpgbe_setup_txrx(struct mucse *mucse);
-- 
2.25.1


