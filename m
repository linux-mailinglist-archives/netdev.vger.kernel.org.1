Return-Path: <netdev+bounces-291526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIG0FJ8VFWptSgcAu9opvQ
	(envelope-from <netdev+bounces-291526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 05:38:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2175D0610
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 05:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1E6D30091E7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46F83BADB5;
	Tue, 26 May 2026 03:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90713AA1A1;
	Tue, 26 May 2026 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779766646; cv=none; b=jUV67XjBoeat5EKpcR4Iuo0tStC/6JjFLEc0BL2D73CyQDmv0szbD2zDodChf1oSxOokJoJgaCFMzscpTwzwMQxoSVpBc7NEfBRQzj511pBsDwDPphcTDeNbK5h+lviGEUXpwuXG2tPHaNaxlQjI4Nt02hl8aY1Z1xSrirZDK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779766646; c=relaxed/simple;
	bh=kwHDZQnDYJ6YhiiINVn7QgK6FHQdsEvHXVsr1/0BnB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWn3yYi7mEZwDUuCvtuf0Bboz5/N+VO8fDqLR2n5RTIZ6OG0r/mLVwhJM4vCrNkIwr+Witb2pKoP3PExfh/pvMPszT6pW2c0IaXfZ97eiA0Ndwi7LJPfsfgHsYUC8zIsz80+5WnwuWgaH/LuaEeaeNMwnuu/wc9zJqUSp4KWAK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz6t1779766564tf51a439a
X-QQ-Originating-IP: YkapiXxEkAvrBgDh4bhrg3VILuHhACNgZq3VYqEBSr8=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 May 2026 11:36:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4701223553081443565
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
Subject: [PATCH net-next v4 3/4] net: rnpgbe: Add RX packet reception support
Date: Tue, 26 May 2026 11:35:38 +0800
Message-Id: <20260526033539.164061-4-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260526033539.164061-1-dong100@mucse.com>
References: <20260526033539.164061-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OGmpL5CFYt/YMTL+E4Xg5EotSmQ7UXoamFWBCyWGuUEl3ZUIHaNelKjJ
	dpdS9B4XC0Ceq04SKtYfodeeisGFCB6TAW2MYqQUOjR57a/F/pDQinvsqOJKCR7Hxci9sR2
	Xbvb+uDRPndXsM8T0VYPSHK1a9xsyrdqXpqVj4/EACjZ8z6ZMxzGbawD6cVpZN7s1EjcFd0
	7nCRjnXPverWb2nUXplWyiRuDEEbqiQw+6aF3Srt+28RAagqMkT3XAACPJi2mSFo3lAVcNE
	g6GobU91STZ6I1WzdLHDyGvST6manuEdu1piXa8t2dwM7ROBAa/tFdTwZ/6e7SM4cJjVH74
	3jB37ssZEusPBVnKKfLvvY5GbKPDRW7ijwBaV8qshGJcaOSbobHcuPHflVQndY9whnFFsz4
	J3/Q7b3+Al2i1utrDn04VL7ZbHsyuXX3h8JMvFf9urtfhJUFRO30DEpHEeToqXkdYpMty8F
	/+ToJJ+Kq6OPhddAwPUg0N/u4NZXyeupMiVJOyFRJ3VG0MrepRJ2vSRR29/uanUAXKYwm4j
	aITi9Pn3lcPUirCbJzRm3kcmTiM5pBOAGhHP/FKKzh1Pm/HXI1dt11eKIt7gxin8IITkhtJ
	DoKfwQNXEuVLs6ge6q1Fmbc0hApDpY/4jtbCJMO10+cp2S4J7PRMJqJZM0KPu31B8Ypxk7o
	ysSNtcL7tiY+o50j616xnUGx/X8BX/AeH1boPP0y2JFoNP5kE5xesv/F23yBBEydZeXwZnJ
	V59LH9nCA/RGsH8kbmL7zdiFyTNzTOGhsTaDC45hzfGDLtJKgRECXLgltAJo6oOq3fvXKxn
	/Mk01PWswAX1teJ+58qjCA5saqOmbBFAVUtmB0CB7aROImQH9UurqSDqxDskWouQTeJLMnI
	erdUBztG1nXtHNMpBJy9hshOzGJ8/QevJJz6zxX2HxVpOTm0C9PEhyR4FISQU4PmYXIOU6M
	i7cgqAinDg1xf8J1fLTkLQlyqJeRoCmt53IA3ncxCGlLKK9N553+Qun4KldTSWB5KN4s4ZX
	/mX7RQTW85UdxP9bGoYqDkpAsCqKQbZ2wuIEFPf50vF/WPM1iZAbZNCwiIIrc2d7ezrLVc8
	Q==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mucse.com];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291526-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.550];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mucse.com:mid,mucse.com:email]
X-Rspamd-Queue-Id: 9B2175D0610
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add basic RX packet reception infrastructure to the rnpgbe driver:
- Add RX descriptor structure (union rnpgbe_rx_desc) with write-back
  format for hardware status
- Add RX buffer management using page_pool for efficient page recycling
  (basic version, 1 page for 1 descriptor, no page splitting; ring depth
  is fixed at 512, 'ethtool ringparm' not yet supported)
- Implement NAPI poll callback (rnpgbe_poll) for RX processing
- Add RX ring setup and cleanup functions
- Implement packet building from page buffer
- Add RX statistics tracking

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/Kconfig            |   1 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  50 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 675 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  26 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   9 +
 6 files changed, 759 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
index 0b3e853d625f..be0fdf268484 100644
--- a/drivers/net/ethernet/mucse/Kconfig
+++ b/drivers/net/ethernet/mucse/Kconfig
@@ -19,6 +19,7 @@ if NET_VENDOR_MUCSE
 config MGBE
 	tristate "Mucse(R) 1GbE PCI Express adapters support"
 	depends on PCI
+	select PAGE_POOL
 	help
 	  This driver supports Mucse(R) 1GbE PCI Express family of
 	  adapters.
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 817e318a9b73..36c170a6e3fc 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -61,7 +61,32 @@ struct rnpgbe_tx_desc {
 #define M_TXD_CMD_EOP         0x010000 /* End of Packet */
 };
 
+union rnpgbe_rx_desc {
+	struct {
+		__le64 pkt_addr; /* Packet buffer address */
+		__le64 resv_cmd; /* cmd status */
+	};
+	struct {
+		__le32 rss_hash; /* RSS HASH */
+		__le16 mark; /* mark info */
+		__le16 rev1;
+		__le16 len; /* Packet length */
+		__le16 padding_len;
+		__le16 vlan; /* VLAN tag */
+		__le16 cmd; /* cmd status */
+#define M_RXD_STAT_DD         BIT(1) /* Descriptor Done */
+#define M_RXD_STAT_EOP        BIT(0) /* End of Packet */
+	} wb;
+};
+
 #define M_TX_DESC(R, i) (&(((struct rnpgbe_tx_desc *)((R)->desc))[i]))
+#define M_RX_DESC(R, i) (&(((union rnpgbe_rx_desc *)((R)->desc))[i]))
+
+static inline __le16 rnpgbe_test_staterr(union rnpgbe_rx_desc *rx_desc,
+					 const u16 stat_err_bits)
+{
+	return rx_desc->wb.cmd & cpu_to_le16(stat_err_bits);
+}
 
 struct mucse_tx_buffer {
 	struct rnpgbe_tx_desc *next_to_watch;
@@ -79,13 +104,24 @@ struct mucse_queue_stats {
 	atomic64_t dropped;
 };
 
+struct mucse_rx_buffer {
+	struct sk_buff *skb;
+	dma_addr_t dma;
+	struct page *page;
+	u32 page_offset;
+};
+
 struct mucse_ring {
 	struct mucse_ring *next;
 	struct mucse_q_vector *q_vector;
 	struct net_device *netdev;
 	struct device *dev;
+	struct page_pool *page_pool;
 	void *desc;
-	struct mucse_tx_buffer *tx_buffer_info;
+	union {
+		struct mucse_tx_buffer *tx_buffer_info;
+		struct mucse_rx_buffer *rx_buffer_info;
+	};
 	void __iomem *ring_addr;
 	void __iomem *tail;
 	void __iomem *irq_mask;
@@ -101,6 +137,7 @@ struct mucse_ring {
 	unsigned int size;
 	struct mucse_queue_stats stats;
 	struct u64_stats_sync syncp;
+	bool drop_status;
 } ____cacheline_internodealigned_in_smp;
 
 static inline u16 mucse_desc_unused(struct mucse_ring *ring)
@@ -111,6 +148,15 @@ static inline u16 mucse_desc_unused(struct mucse_ring *ring)
 	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
 }
 
+static inline u16 mucse_desc_unused_rx(struct mucse_ring *ring)
+{
+	u16 ntc = ring->next_to_clean;
+	u16 ntu = ring->next_to_use;
+
+	/* 16 * 16 = 256 tlp-max-payload size */
+	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 16;
+}
+
 static inline __le64 build_ctob(u32 vlan_cmd, u32 mac_ip_len, u32 size)
 {
 	return cpu_to_le64(((u64)vlan_cmd << 32) | ((u64)mac_ip_len << 16) |
@@ -140,6 +186,7 @@ struct mucse_q_vector {
 #define MAX_Q_VECTORS 8
 
 #define M_DEFAULT_TXD     512
+#define M_DEFAULT_RXD     512
 #define M_DEFAULT_TX_WORK 256
 
 struct mucse {
@@ -159,6 +206,7 @@ struct mucse {
 	int tx_work_limit;
 	int num_tx_queues;
 	int num_q_vectors;
+	int rx_ring_item_count;
 	int num_rx_queues;
 	char mbx_name[32];
 };
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index cbc593902030..03688586b447 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -16,6 +16,7 @@
 #define M_DEFAULT_N210_MHZ             62
 
 #define TX_AXI_RW_EN                   0xc
+#define RX_AXI_RW_EN                   0x03
 #define RNPGBE_DMA_AXI_EN              0x0010
 
 #define RNPGBE_MAX_QUEUES 8
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index e14b69c6956f..3457b5d5d2bc 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -3,7 +3,9 @@
 
 #include <linux/pci.h>
 #include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include <linux/vmalloc.h>
+#include <net/page_pool/helpers.h>
 
 #include "rnpgbe_lib.h"
 #include "rnpgbe.h"
@@ -164,6 +166,396 @@ static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
 	return !!budget;
 }
 
+static bool mucse_alloc_mapped_page(struct mucse_ring *rx_ring,
+				    struct mucse_rx_buffer *bi)
+{
+	struct page *page = bi->page;
+	dma_addr_t dma;
+
+	if (page) {
+		/* Buffer is being reused without going back through the
+		 * page_pool. Do dma_sync for hw use.
+		 */
+		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
+						 bi->page_offset,
+						 PAGE_SIZE - bi->page_offset,
+						 DMA_FROM_DEVICE);
+		return true;
+	}
+
+	page = page_pool_dev_alloc_pages(rx_ring->page_pool);
+	if (unlikely(!page))
+		return false;
+	dma = page_pool_get_dma_addr(page);
+
+	bi->dma = dma;
+	bi->page = page;
+	bi->page_offset = RNPGBE_SKB_PAD;
+
+	return true;
+}
+
+static void mucse_update_rx_tail(struct mucse_ring *rx_ring,
+				 u32 val)
+{
+	rx_ring->next_to_use = val;
+	/*
+	 * Force memory writes to complete before letting h/w
+	 * know there are new descriptors to fetch.  (Only
+	 * applicable for weak-ordered memory model archs,
+	 * such as IA-64).
+	 */
+	wmb();
+	writel(val, rx_ring->tail);
+}
+
+/**
+ * rnpgbe_alloc_rx_buffers - Replace used receive buffers
+ * @rx_ring: ring to place buffers on
+ * @cleaned_count: number of buffers to replace
+ * @return: true if alloc failed
+ **/
+static bool rnpgbe_alloc_rx_buffers(struct mucse_ring *rx_ring,
+				    u16 cleaned_count)
+{
+	u64 fun_id = ((u64)(rx_ring->pfvfnum) << 56);
+	union rnpgbe_rx_desc *rx_desc;
+	u16 i = rx_ring->next_to_use;
+	struct mucse_rx_buffer *bi;
+	bool err = false;
+	u64 addr;
+	/* nothing to do */
+	if (!cleaned_count)
+		return err;
+
+	rx_desc = M_RX_DESC(rx_ring, i);
+	bi = &rx_ring->rx_buffer_info[i];
+	i -= rx_ring->count;
+
+	do {
+		if (!mucse_alloc_mapped_page(rx_ring, bi)) {
+			err = true;
+			break;
+		}
+
+		addr = (u64)(bi->dma + bi->page_offset);
+		rx_desc->pkt_addr = cpu_to_le64(addr | fun_id);
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
+	if (rx_ring->next_to_use != i) {
+		/*
+		 * Force memory writes to complete before letting h/w know
+		 * there are new rx descriptors to fetch.  (Only applicable
+		 * for weak-ordered memory model archs, such as IA-64).
+		 */
+		dma_wmb();
+		/* Notify hw new rx descriptors is ready */
+		mucse_update_rx_tail(rx_ring, i);
+	}
+
+	return err;
+}
+
+/**
+ * rnpgbe_get_buffer - Get the rx_buffer to be used
+ * @rx_ring: pointer to rx ring
+ * @skb: pointer skb for this packet
+ * @size: data size in this desc
+ * @return: rx_buffer.
+ **/
+static struct mucse_rx_buffer *rnpgbe_get_buffer(struct mucse_ring *rx_ring,
+						 struct sk_buff **skb,
+						 const unsigned int size)
+{
+	struct mucse_rx_buffer *rx_buffer;
+
+	rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
+	*skb = rx_buffer->skb;
+	prefetchw(page_address(rx_buffer->page) + rx_buffer->page_offset);
+	/* we are reusing so sync this buffer for CPU use */
+	dma_sync_single_range_for_cpu(rx_ring->dev, rx_buffer->dma,
+				      rx_buffer->page_offset, size,
+				      DMA_FROM_DEVICE);
+
+	return rx_buffer;
+}
+
+/**
+ * rnpgbe_add_rx_frag - Add no-linear data to the skb
+ * @rx_buffer: pointer to rx_buffer
+ * @skb: pointer skb for this packet
+ * @size: data size in this desc
+ **/
+static void rnpgbe_add_rx_frag(struct mucse_rx_buffer *rx_buffer,
+			       struct sk_buff *skb,
+			       unsigned int size)
+{
+	/* FIXME: truesize is PAGE_SIZE for 1 page = 1 descriptor.
+	 * Optimize with page splitting later when refactoring
+	 * the Rx buffer management.
+	 */
+	unsigned int truesize = PAGE_SIZE;
+
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
+			rx_buffer->page_offset, size, truesize);
+}
+
+/**
+ * rnpgbe_build_skb - Try to build a sbk based on rx_buffer
+ * @rx_buffer: pointer to rx_buffer
+ * @size: data size in this desc
+ * @return: skb for this rx_buffer
+ **/
+static struct sk_buff *rnpgbe_build_skb(struct mucse_rx_buffer *rx_buffer,
+					unsigned int size)
+{
+	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
+	unsigned int truesize = PAGE_SIZE;
+	struct sk_buff *skb;
+
+	net_prefetch(va);
+	/* build an skb around the page buffer */
+	skb = build_skb(va - RNPGBE_SKB_PAD, truesize);
+	if (unlikely(!skb))
+		return NULL;
+	/* update pointers within the skb to store the data */
+	skb_reserve(skb, RNPGBE_SKB_PAD);
+	__skb_put(skb, size);
+	skb_mark_for_recycle(skb);
+
+	return skb;
+}
+
+/**
+ * rnpgbe_pull_tail - Pull header to linear portion of buffer
+ * @skb: current socket buffer containing buffer in progress
+ **/
+static void rnpgbe_pull_tail(struct sk_buff *skb)
+{
+	skb_frag_t *frag = &skb_shinfo(skb)->frags[0];
+	unsigned int pull_len;
+	unsigned char *va;
+
+	va = skb_frag_address(frag);
+	pull_len = eth_get_headlen(skb->dev, va, M_RX_HDR_SIZE);
+	/* align pull length to size of long to optimize memcpy performance */
+	skb_copy_to_linear_data(skb, va, ALIGN(pull_len, sizeof(long)));
+	/* update all of the pointers */
+	skb_frag_size_sub(frag, pull_len);
+	skb_frag_off_add(frag, pull_len);
+	skb->data_len -= pull_len;
+	skb->tail += pull_len;
+}
+
+/**
+ * rnpgbe_is_non_eop - Process handling of non-EOP buffers
+ * @rx_ring: rx ring being processed
+ * @rx_desc: rx descriptor for current buffer
+ * @skb: current socket buffer containing buffer in progress
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
+	prefetch(M_RX_DESC(rx_ring, ntc));
+	/* if we are the last buffer then there is nothing else to do */
+	if (likely(rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP)))
+		return false;
+	if (skb_shinfo(skb)->nr_frags < MAX_SKB_FRAGS) {
+		/* place skb in next buffer to be received */
+		rx_ring->rx_buffer_info[ntc].skb = skb;
+	} else {
+		atomic64_inc(&rx_ring->stats.dropped);
+		/* too much frags, force free */
+		dev_kfree_skb_any(skb);
+		rx_ring->drop_status = true;
+	}
+	/* we should clean it since we used all info in it */
+	rx_desc->wb.cmd = 0;
+
+	return true;
+}
+
+/**
+ * rnpgbe_cleanup_headers - Correct corrupted or empty headers
+ * @skb: current socket buffer containing buffer in progress
+ * @return: true if an error was encountered and skb was freed.
+ **/
+static bool rnpgbe_cleanup_headers(struct sk_buff *skb)
+{
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
+ * rnpgbe_process_skb_fields - Setup skb header fields from desc
+ * @rx_ring: structure containing ring specific data
+ * @skb: skb currently being received and modified
+ *
+ * rnpgbe_process_skb_fields checks the ring, descriptor information
+ * in order to setup the hash, chksum, vlan, protocol, and other
+ * fields within the skb.
+ **/
+static void rnpgbe_process_skb_fields(struct mucse_ring *rx_ring,
+				      struct sk_buff *skb)
+{
+	struct net_device *dev = rx_ring->netdev;
+
+	skb_record_rx_queue(skb, rx_ring->queue_index);
+	skb->protocol = eth_type_trans(skb, dev);
+}
+
+/**
+ * rnpgbe_clean_rx_irq - Clean completed descriptors from Rx ring
+ * @q_vector: structure containing interrupt and ring information
+ * @rx_ring: rx descriptor ring to transact packets on
+ * @budget: total limit on number of packets to process
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
+	bool fail_alloc = false;
+
+	while (likely(total_rx_packets < budget)) {
+		struct mucse_rx_buffer *rx_buffer;
+		union rnpgbe_rx_desc *rx_desc;
+		struct sk_buff *skb;
+		unsigned int size;
+
+		if (cleaned_count >= M_RX_BUFFER_WRITE) {
+			if (rnpgbe_alloc_rx_buffers(rx_ring, cleaned_count)) {
+				fail_alloc = true;
+				cleaned_count = mucse_desc_unused_rx(rx_ring);
+			} else {
+				cleaned_count = 0;
+			}
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
+		/* Hardware enfrces: minimum 33-bytes descriptor(no 1-13 byte
+		 * size), multi-descriptors only for jumbo frames > 1536 bytes
+		 * (controlled by M_DEFAULT_SG=96, each descriptor no more than
+		 * 1536 bytes). Small packets use single descriptor.
+		 */
+		size = le16_to_cpu(rx_desc->wb.len);
+
+		if (unlikely(rx_ring->drop_status)) {
+			cleaned_count++;
+			/* drop data until eop */
+			if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP))
+				rx_ring->drop_status = false;
+
+			rx_desc->wb.cmd = 0;
+			rx_ring->next_to_clean++;
+			if (rx_ring->next_to_clean >= rx_ring->count)
+				rx_ring->next_to_clean = 0;
+			continue;
+		}
+
+		/* TODO: hardware error checks (wb.status: crc_err, etc.) in
+		 * the feature. For now the basic RX path relies on the stack
+		 * to drop malformed packets naturally.
+		 */
+
+		rx_buffer = rnpgbe_get_buffer(rx_ring, &skb, size);
+
+		if (skb)
+			rnpgbe_add_rx_frag(rx_buffer, skb, size);
+		else
+			skb = rnpgbe_build_skb(rx_buffer, size);
+
+		if (!skb) {
+			/* drop until eop if multiple descriptors */
+			if (!(rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP)))
+				rx_ring->drop_status = true;
+
+			rx_desc->wb.cmd = 0;
+			rx_ring->next_to_clean++;
+			atomic64_inc(&rx_ring->stats.dropped);
+			if (rx_ring->next_to_clean >= rx_ring->count)
+				rx_ring->next_to_clean = 0;
+			break;
+		}
+
+		rx_buffer->page = NULL;
+		rx_buffer->skb = NULL;
+		cleaned_count++;
+
+		if (rnpgbe_is_non_eop(rx_ring, rx_desc, skb))
+			continue;
+
+		/* verify the packet layout is correct */
+		if (rnpgbe_cleanup_headers(skb)) {
+			/* we should clean it since we used all info in it */
+			atomic64_inc(&rx_ring->stats.dropped);
+			rx_desc->wb.cmd = 0;
+			continue;
+		}
+
+		/* probably a little skewed due to removing CRC */
+		total_rx_bytes += skb->len;
+		rnpgbe_process_skb_fields(rx_ring, skb);
+		rx_desc->wb.cmd = 0;
+		napi_gro_receive(&q_vector->napi, skb);
+		/* update budget accounting */
+		total_rx_packets++;
+	}
+
+	u64_stats_update_begin(&rx_ring->syncp);
+	rx_ring->stats.packets += total_rx_packets;
+	rx_ring->stats.bytes += total_rx_bytes;
+	u64_stats_update_end(&rx_ring->syncp);
+	/* keep polling if alloc mem failed */
+	return fail_alloc ? budget : total_rx_packets;
+}
+
 /**
  * rnpgbe_poll - NAPI Rx polling callback
  * @napi: structure for representing this polling device
@@ -178,6 +570,7 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 		container_of(napi, struct mucse_q_vector, napi);
 	bool clean_complete = true;
 	struct mucse_ring *ring;
+	int per_ring_budget;
 	int work_done = 0;
 
 	mucse_for_each_ring(ring, q_vector->tx) {
@@ -189,6 +582,20 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 	if (unlikely(!budget))
 		return 0;
 
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
+		if (cleaned >= per_ring_budget)
+			clean_complete = false;
+	}
+
 	if (!clean_complete)
 		return budget;
 
@@ -368,12 +775,17 @@ static int rnpgbe_alloc_q_vector(struct mucse *mucse,
 	}
 
 	for (idx = 0; idx < rxr_count; idx++) {
+		ring->dev = &mucse->pdev->dev;
 		mucse_add_ring(ring, &q_vector->rx);
+		ring->count = mucse->rx_ring_item_count;
+		ring->netdev = mucse->netdev;
 		ring->queue_index = eth_queue_idx + idx;
 		ring->rnpgbe_queue_idx = rxr_idx;
 		ring->ring_addr = hw->hw_addr + RING_OFFSET(rxr_idx);
 		ring->irq_mask = ring->ring_addr + RNPGBE_DMA_INT_MASK;
 		ring->trig = ring->ring_addr + RNPGBE_DMA_INT_TRIG;
+		ring->pfvfnum = hw->pfvfnum;
+		u64_stats_init(&ring->syncp);
 		mucse->rx_ring[ring->queue_index] = ring;
 		rxr_idx += step;
 		ring++;
@@ -835,6 +1247,16 @@ static void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
 		rnpgbe_clean_tx_ring(mucse->tx_ring[i]);
 }
 
+/**
+ * rnpgbe_clean_all_rx_rings - Free Rx Buffers for all queues
+ * @mucse: board private structure
+ **/
+static void rnpgbe_clean_all_rx_rings(struct mucse *mucse)
+{
+	for (int i = 0; i < mucse->num_rx_queues; i++)
+		rnpgbe_clean_rx_ring(mucse->rx_ring[i]);
+}
+
 void rnpgbe_down(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
@@ -844,6 +1266,7 @@ void rnpgbe_down(struct mucse *mucse)
 	rnpgbe_napi_disable_all(mucse);
 	rnpgbe_irq_disable(mucse);
 	rnpgbe_clean_all_tx_rings(mucse);
+	rnpgbe_clean_all_rx_rings(mucse);
 }
 
 /**
@@ -862,6 +1285,8 @@ void rnpgbe_up_complete(struct mucse *mucse)
 	rnpgbe_napi_enable_all(mucse);
 	rnpgbe_irq_enable(mucse);
 	netif_tx_start_all_queues(netdev);
+	for (int i = 0; i < mucse->num_rx_queues; i++)
+		mucse_ring_wr32(mucse->rx_ring[i], RNPGBE_RX_START, 1);
 }
 
 /**
@@ -1259,5 +1684,255 @@ void rnpgbe_get_stats64(struct net_device *netdev,
 			stats->tx_bytes += bytes;
 		}
 	}
+
+	for (i = 0; i < mucse->num_rx_queues; i++) {
+		struct mucse_ring *ring = READ_ONCE(mucse->rx_ring[i]);
+		u64 bytes, packets, dropped;
+		unsigned int start;
+
+		if (ring) {
+			do {
+				start = u64_stats_fetch_begin(&ring->syncp);
+				packets = ring->stats.packets;
+				bytes = ring->stats.bytes;
+				dropped = atomic64_read(&ring->stats.dropped);
+			} while (u64_stats_fetch_retry(&ring->syncp, start));
+			stats->rx_packets += packets;
+			stats->rx_dropped += dropped;
+			stats->rx_bytes += bytes;
+		}
+	}
 	rcu_read_unlock();
 }
+
+static int mucse_alloc_page_pool(struct mucse_ring *rx_ring)
+{
+	int ret = 0;
+
+	struct page_pool_params pp_params = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order = 0,
+		.pool_size = rx_ring->count,
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
+/**
+ * rnpgbe_setup_rx_resources - allocate Rx resources (Descriptors)
+ * @rx_ring:    rx descriptor ring (for a specific queue) to setup
+ * @mucse: pointer to private structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_setup_rx_resources(struct mucse_ring *rx_ring,
+				     struct mucse *mucse)
+{
+	struct device *dev = rx_ring->dev;
+	int size;
+
+	size = sizeof(struct mucse_rx_buffer) * rx_ring->count;
+
+	rx_ring->rx_buffer_info = vzalloc(size);
+
+	if (!rx_ring->rx_buffer_info)
+		goto err_return;
+	/* Round up to nearest 4K */
+	rx_ring->size = rx_ring->count * sizeof(union rnpgbe_rx_desc);
+	rx_ring->size = ALIGN(rx_ring->size, 4096);
+	rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size, &rx_ring->dma,
+					   GFP_KERNEL);
+	if (!rx_ring->desc)
+		goto err_free_buffer;
+
+	rx_ring->next_to_clean = 0;
+	rx_ring->next_to_use = 0;
+
+	if (mucse_alloc_page_pool(rx_ring))
+		goto err_free_desc;
+
+	return 0;
+err_free_desc:
+	dma_free_coherent(dev, rx_ring->size, rx_ring->desc,
+			  rx_ring->dma);
+	rx_ring->desc = NULL;
+err_free_buffer:
+	vfree(rx_ring->rx_buffer_info);
+err_return:
+	rx_ring->rx_buffer_info = NULL;
+	return -ENOMEM;
+}
+
+/**
+ * rnpgbe_clean_rx_ring - Free Rx Buffers per Queue
+ * @rx_ring: ring to free buffers from
+ **/
+void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring)
+{
+	struct mucse_rx_buffer *rx_buffer;
+	u16 i;
+
+	/* Stop hw. hardware design guarantees:
+	 * - No new descriptors will be fetched after RX_START=0
+	 * - No DMA will be initiated for already-fetched descriptors
+	 */
+	mucse_ring_wr32(rx_ring, RNPGBE_RX_START, 0);
+	/* Flush posted write to ensure hardware sees the disable command.
+	 * After this read completes, all RX DMA for this ring is
+	 * guaranteed quiesced.
+	 */
+	(void)mucse_ring_rd32(rx_ring, RNPGBE_RX_START);
+	/* Free all the Rx ring sk_buffs */
+	for (i = 0; i < rx_ring->count; i++) {
+		rx_buffer = &rx_ring->rx_buffer_info[i];
+
+		if (rx_buffer->skb) {
+			struct sk_buff *skb = rx_buffer->skb;
+
+			dev_kfree_skb(skb);
+			rx_buffer->skb = NULL;
+		}
+
+		if (rx_buffer->page) {
+			page_pool_put_full_page(rx_ring->page_pool,
+						rx_buffer->page, false);
+			rx_buffer->page = NULL;
+		}
+	}
+
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
+	if (rx_ring->page_pool) {
+		page_pool_destroy(rx_ring->page_pool);
+		rx_ring->page_pool = NULL;
+	}
+}
+
+/**
+ * rnpgbe_setup_all_rx_resources - allocate all queues Rx resources
+ * @mucse: pointer to private structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int rnpgbe_setup_all_rx_resources(struct mucse *mucse)
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
+void rnpgbe_free_all_rx_resources(struct mucse *mucse)
+{
+	for (int i = 0; i < (mucse->num_rx_queues); i++) {
+		if (mucse->rx_ring[i]->desc)
+			rnpgbe_free_rx_resources(mucse->rx_ring[i]);
+	}
+}
+
+/**
+ * rnpgbe_configure_rx_ring - Configure Rx ring info to hw
+ * @mucse: pointer to private structure
+ * @ring: structure containing ring specific data
+ *
+ * Configure the Rx descriptor ring after a reset.
+ **/
+static void rnpgbe_configure_rx_ring(struct mucse *mucse,
+				     struct mucse_ring *ring)
+{
+	struct mucse_hw *hw = &mucse->hw;
+
+	/* Stop hw. hardware design guarantees:
+	 * - No new descriptors will be fetched after RX_START=0
+	 * - No DMA will be initiated for already-fetched descriptors
+	 */
+	mucse_ring_wr32(ring, RNPGBE_RX_START, 0);
+	/* Flush posted write to ensure hardware sees the disable command.
+	 * After this read completes, all RX DMA for this ring is
+	 * guaranteed quiesced.
+	 */
+	(void)mucse_ring_rd32(ring, RNPGBE_RX_START);
+	/* set descripts registers*/
+	mucse_ring_wr32(ring, RNPGBE_RX_BASE_ADDR_LO, (u32)ring->dma);
+	mucse_ring_wr32(ring, RNPGBE_RX_BASE_ADDR_HI,
+			(u32)((u64)ring->dma >> 32) | (hw->pfvfnum << 24));
+	mucse_ring_wr32(ring, RNPGBE_RX_LEN, ring->count);
+	ring->tail = ring->ring_addr + RNPGBE_RX_TAIL;
+	ring->next_to_clean = mucse_ring_rd32(ring, RNPGBE_RX_HEAD);
+	ring->next_to_use = ring->next_to_clean;
+	ring->drop_status = false;
+	mucse_ring_wr32(ring, RNPGBE_RX_SG_LEN, M_DEFAULT_SG);
+	mucse_ring_wr32(ring, RNPGBE_RX_FETCH, M_DEFAULT_RX_FETCH);
+	mucse_ring_wr32(ring, RNPGBE_RX_TIMEOUT_TH, 0);
+	mucse_ring_wr32(ring, RNPGBE_RX_INT_TIMER,
+			M_DEFAULT_INT_TIMER_R * hw->cycles_per_us);
+	mucse_ring_wr32(ring, RNPGBE_RX_INT_PKTCNT, M_DEFAULT_RX_INT_PKTCNT);
+	rnpgbe_alloc_rx_buffers(ring, mucse_desc_unused_rx(ring));
+}
+
+/**
+ * rnpgbe_configure_rx - Configure Receive Unit after Reset
+ * @mucse: pointer to private structure
+ *
+ * Configure the Rx unit after a reset.
+ **/
+void rnpgbe_configure_rx(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 dma_axi_ctl;
+
+	for (int i = 0; i < mucse->num_rx_queues; i++)
+		rnpgbe_configure_rx_ring(mucse, mucse->rx_ring[i]);
+
+	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
+	dma_axi_ctl |= RX_AXI_RW_EN;
+	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index b5aee631ffd6..9a8e6712d016 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -9,11 +9,27 @@ struct mucse_hw;
 struct mucse_ring;
 
 #define RING_OFFSET(n)            (0x1000 + 0x100 * (n))
+#define RNPGBE_RX_START           0x10
 #define RNPGBE_TX_START           0x18
 #define RNPGBE_DMA_INT_MASK       0x24
 #define TX_INT_MASK               BIT(1)
 #define RX_INT_MASK               BIT(0)
 #define INT_VALID                 (BIT(16) | BIT(17))
+#define RNPGBE_RX_BASE_ADDR_HI    0x30
+#define RNPGBE_RX_BASE_ADDR_LO    0x34
+#define RNPGBE_RX_LEN             0x38
+#define RNPGBE_RX_HEAD            0x3c
+#define RNPGBE_RX_TAIL            0x40
+#define M_DEFAULT_RX_FETCH        0x100020
+#define RNPGBE_RX_FETCH           0x44
+#define M_DEFAULT_INT_TIMER_R     30
+#define RNPGBE_RX_INT_TIMER       0x48
+#define M_DEFAULT_RX_INT_PKTCNT   64
+#define RNPGBE_RX_INT_PKTCNT      0x4c
+#define RNPGBE_RX_ARB_DEF_LVL     0x50
+#define RNPGBE_RX_TIMEOUT_TH      0x54
+#define M_DEFAULT_SG              96 /* unit 16b, 1536 bytes */
+#define RNPGBE_RX_SG_LEN          0x58
 #define RNPGBE_TX_BASE_ADDR_HI    0x60
 #define RNPGBE_TX_BASE_ADDR_LO    0x64
 #define RNPGBE_TX_LEN             0x68
@@ -34,13 +50,16 @@ struct mucse_ring;
 #define M_MAX_DATA_PER_TXD        (0x1 << M_MAX_TXD_PWR)
 #define TXD_USE_COUNT(S)          DIV_ROUND_UP((S), M_MAX_DATA_PER_TXD)
 #define DESC_NEEDED               (MAX_SKB_FRAGS + 4)
+#define RNPGBE_SKB_PAD            (NET_SKB_PAD + NET_IP_ALIGN)
+#define M_RX_BUFFER_WRITE         16
+#define M_RX_HDR_SIZE             256
+
 /* hw require this not zero */
 #define M_DEFAULT_MAC_IP_LEN      20
 #define mucse_for_each_ring(pos, head)\
 	for (typeof((head).ring) __pos = (head).ring;\
 	     __pos ? ({ pos = __pos; 1; }) : 0;\
 	     __pos = __pos->next)
-
 int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
 void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
 int register_mbx_irq(struct mucse *mucse);
@@ -50,12 +69,15 @@ void rnpgbe_free_irq(struct mucse *mucse);
 void rnpgbe_irq_disable(struct mucse *mucse);
 void rnpgbe_down(struct mucse *mucse);
 void rnpgbe_up_complete(struct mucse *mucse);
-void mucse_fw_irq_handler(struct mucse_hw *hw);
 void rnpgbe_configure_tx(struct mucse *mucse);
+void rnpgbe_configure_rx(struct mucse *mucse);
 int rnpgbe_setup_all_tx_resources(struct mucse *mucse);
 void rnpgbe_free_all_tx_resources(struct mucse *mucse);
 netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
 				   struct mucse_ring *tx_ring);
 void rnpgbe_get_stats64(struct net_device *netdev,
 			struct rtnl_link_stats64 *stats);
+void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring);
+int rnpgbe_setup_all_rx_resources(struct mucse *mucse);
+void rnpgbe_free_all_rx_resources(struct mucse *mucse);
 #endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index a1e34cd16f14..8fcd1c922153 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -35,6 +35,7 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 static void rnpgbe_configure(struct mucse *mucse)
 {
 	rnpgbe_configure_tx(mucse);
+	rnpgbe_configure_rx(mucse);
 }
 
 /**
@@ -63,11 +64,17 @@ static int rnpgbe_open(struct net_device *netdev)
 	err = rnpgbe_setup_all_tx_resources(mucse);
 	if (err)
 		goto err_free_irqs;
+	err = rnpgbe_setup_all_rx_resources(mucse);
+	if (err)
+		goto err_free_tx;
+
 
 	rnpgbe_configure(mucse);
 	rnpgbe_up_complete(mucse);
 
 	return 0;
+err_free_tx:
+	rnpgbe_free_all_tx_resources(mucse);
 err_free_irqs:
 	rnpgbe_free_irq(mucse);
 	return err;
@@ -89,6 +96,7 @@ static int rnpgbe_close(struct net_device *netdev)
 	rnpgbe_down(mucse);
 	rnpgbe_free_irq(mucse);
 	rnpgbe_free_all_tx_resources(mucse);
+	rnpgbe_free_all_rx_resources(mucse);
 
 	return 0;
 }
@@ -121,6 +129,7 @@ static const struct net_device_ops rnpgbe_netdev_ops = {
 static void rnpgbe_sw_init(struct mucse *mucse)
 {
 	mucse->tx_ring_item_count = M_DEFAULT_TXD;
+	mucse->rx_ring_item_count = M_DEFAULT_RXD;
 	mucse->tx_work_limit = M_DEFAULT_TX_WORK;
 }
 
-- 
2.25.1


