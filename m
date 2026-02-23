Return-Path: <netdev+bounces-259986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC2ULwMrnGloAQQAu9opvQ
	(envelope-from <netdev+bounces-259986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:25:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6518D174D09
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF27A3061635
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C885E35BDAA;
	Mon, 23 Feb 2026 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B30MfCwc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912D356A24;
	Mon, 23 Feb 2026 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842176; cv=none; b=deLclEwyvxsEUUbS8qI8a3ztZX1FaPJq38mEQjWIzzTkV1Gkc5//xXFkSk3BVFInGAC/MXdeYRcNXxLRDyM8oESqCQhgiOzVR5cPbAeQu24ltnJxxstn3fz+Q5jzT9U03kMT3vKJnNo9Eg2wO0DY/EmSac0gC4zIsSzUIVXFN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842176; c=relaxed/simple;
	bh=xnNb3CEqJbu4k1T50WwcccFUlY/43ciTLiY1cOWKqig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhJdujedP/8Qrkpl3JgFwgMTQi9RIE9AX/LjIEH82mnm40J+/++FMiQQZmC191+cYXmL7qeZqZr2A0qL5kU5z0Rj9WQ/OwWHTtegSFdhFXgqKSGBw21Jcn4TLab7gfurRG44YQhfNjMZAo+lrUFbedyrWYsjgBLKsirHjJRMLNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B30MfCwc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771842175; x=1803378175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xnNb3CEqJbu4k1T50WwcccFUlY/43ciTLiY1cOWKqig=;
  b=B30MfCwc2uuIERCwubU/DfRmedWxAyJmyvhjHnw/f0zAaGMyNI5Y3i3A
   f4necobwnO89/Sd9j4pzDbHUCq5V5xm7VVxPT0P8fW+zioDTjMQCQDKV8
   M4gT0DsqR992gr/13SFU40KsjBvOP9YNyIDGBN87XgR14WzsVyb08B0NT
   21Hgr9ROyawghYdc3NBC3r4KmBRGv7D+Iop4Rws27IiIBopkoOjuUbY7l
   C5Yq0vWCvBQWmfioYFCIQB6QcDG2IV1xp0M9Ec962axnzZOOnkVML1hM1
   RUeROkrh++YofmpmSeN/gMJEGuBwE3QK78uog5mqMsdpZ0beYmdZ9zg7t
   Q==;
X-CSE-ConnectionGUID: /hIF5cnpRumko/yR5PbGOw==
X-CSE-MsgGUID: nVMPEMPXSo2TG3ubvd/t2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76444710"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="76444710"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 02:22:54 -0800
X-CSE-ConnectionGUID: MlwJDv+jTvOq7ceF7eCQ8A==
X-CSE-MsgGUID: l2fhkdJ6T8ST1BmR3I4E6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="246121740"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 23 Feb 2026 02:22:49 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A7D9E28160;
	Mon, 23 Feb 2026 10:22:46 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next 03/10] ixgbevf: use libeth in Rx processing
Date: Mon, 23 Feb 2026 10:52:10 +0100
Message-ID: <20260223095222.3205363-4-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223095222.3205363-1-larysa.zaremba@intel.com>
References: <20260223095222.3205363-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259986-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6518D174D09
X-Rspamd-Action: no action

Use page_pool buffers by the means of libeth in the Rx queues, this
significantly reduces code complexity of the driver itself.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/ixgbevf/defines.h  |   2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |  25 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 309 ++++++------------
 4 files changed, 116 insertions(+), 221 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 780f113986ea..42637514e804 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -203,6 +203,7 @@ config IXGBE_IPSEC
 config IXGBEVF
 	tristate "Intel(R) 10GbE PCI Express Virtual Function Ethernet support"
 	depends on PCI_MSI
+	select LIBETH_XDP
 	help
 	  This driver supports Intel(R) PCI Express virtual functions for the
 	  Intel(R) ixgbe driver.  For more information on how to identify your
diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index e177d1d58696..afc927dd1438 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -71,7 +71,7 @@ typedef u32 ixgbe_link_speed;
 #define IXGBE_PSRTYPE_L2HDR	0x00001000
 
 /* SRRCTL bit definitions */
-#define IXGBE_SRRCTL_BSIZEPKT_SHIFT	10     /* so many KBs */
+#define IXGBE_SRRCTL_BSIZEPKT_STEP	1024
 #define IXGBE_SRRCTL_RDMTS_SHIFT	22
 #define IXGBE_SRRCTL_RDMTS_MASK		0x01C00000
 #define IXGBE_SRRCTL_DROP_EN		0x10000000
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 5885756a21d0..698091d42dbd 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -42,12 +42,6 @@ struct ixgbevf_tx_buffer {
 	u32 tx_flags;
 };
 
-struct ixgbevf_rx_buffer {
-	dma_addr_t dma;
-	struct page *page;
-	__u32 page_offset;
-};
-
 struct ixgbevf_stats {
 	u64 packets;
 	u64 bytes;
@@ -86,18 +80,21 @@ struct ixgbevf_ring {
 	struct ixgbevf_q_vector *q_vector;	/* backpointer to q_vector */
 	struct net_device *netdev;
 	struct bpf_prog *xdp_prog;
-	struct device *dev;
+	union {
+		struct page_pool *pp;	/* Rx ring */
+		struct device *dev;	/* Tx ring */
+	};
 	void *desc;			/* descriptor ring memory */
 	dma_addr_t dma;			/* phys. address of descriptor ring */
 	unsigned int size;		/* length in bytes */
+	u32 truesize;			/* Rx buffer full size */
 	u16 count;			/* amount of descriptors */
 	u16 next_to_use;
 	u16 next_to_clean;
-	u16 next_to_alloc;
 
 	union {
+		struct libeth_fqe *rx_fqes;
 		struct ixgbevf_tx_buffer *tx_buffer_info;
-		struct ixgbevf_rx_buffer *rx_buffer_info;
 	};
 	unsigned long state;
 	struct ixgbevf_stats stats;
@@ -116,6 +113,7 @@ struct ixgbevf_ring {
 	 */
 	u16 reg_idx;
 	int queue_index; /* needed for multiqueue queue management */
+	u32 rx_buf_len;
 } ____cacheline_internodealigned_in_smp;
 
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
@@ -145,13 +143,8 @@ struct ixgbevf_ring {
 
 #define MAXIMUM_ETHERNET_VLAN_SIZE (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
 
-#define IXGBEVF_SKB_PAD		(NET_SKB_PAD + NET_IP_ALIGN)
-#if (PAGE_SIZE < 8192)
-#define IXGBEVF_MAX_FRAME_BUILD_SKB \
-	(SKB_WITH_OVERHEAD(IXGBEVF_RXBUFFER_2048) - IXGBEVF_SKB_PAD)
-#else
-#define IXGBEVF_MAX_FRAME_BUILD_SKB	IXGBEVF_RXBUFFER_2048
-#endif
+#define IXGBEVF_RX_PAGE_LEN(hr)		(ALIGN_DOWN(LIBETH_RX_PAGE_LEN(hr), \
+					 IXGBE_SRRCTL_BSIZEPKT_STEP))
 
 #define IXGBE_TX_FLAGS_CSUM		BIT(0)
 #define IXGBE_TX_FLAGS_VLAN		BIT(1)
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index f5a7dd37084f..24b8f4bb415b 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -30,6 +30,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/atomic.h>
+#include <net/libeth/xdp.h>
 #include <net/xfrm.h>
 
 #include "ixgbevf.h"
@@ -82,6 +83,7 @@ static const struct pci_device_id ixgbevf_pci_tbl[] = {
 MODULE_DEVICE_TABLE(pci, ixgbevf_pci_tbl);
 
 MODULE_DESCRIPTION("Intel(R) 10 Gigabit Virtual Function Network Driver");
+MODULE_IMPORT_NS("LIBETH");
 MODULE_LICENSE("GPL v2");
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
@@ -304,7 +306,7 @@ static bool ixgbevf_clean_tx_irq(struct ixgbevf_q_vector *q_vector,
 
 		/* free the skb */
 		if (ring_is_xdp(tx_ring))
-			page_frag_free(tx_buffer->data);
+			libeth_xdp_return_va(tx_buffer->data, true);
 		else
 			napi_consume_skb(tx_buffer->skb, napi_budget);
 
@@ -521,35 +523,6 @@ static void ixgbevf_process_skb_fields(struct ixgbevf_ring *rx_ring,
 
 	if (ixgbevf_test_staterr(rx_desc, IXGBE_RXDADV_STAT_SECP))
 		ixgbevf_ipsec_rx(rx_ring, rx_desc, skb);
-
-	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
-}
-
-static
-struct ixgbevf_rx_buffer *ixgbevf_get_rx_buffer(struct ixgbevf_ring *rx_ring,
-						const unsigned int size)
-{
-	struct ixgbevf_rx_buffer *rx_buffer;
-
-	rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
-	prefetchw(rx_buffer->page);
-
-	/* we are reusing so sync this buffer for CPU use */
-	dma_sync_single_range_for_cpu(rx_ring->dev,
-				      rx_buffer->dma,
-				      rx_buffer->page_offset,
-				      size,
-				      DMA_FROM_DEVICE);
-
-	return rx_buffer;
-}
-
-static void ixgbevf_put_rx_buffer(struct ixgbevf_ring *rx_ring,
-				  struct ixgbevf_rx_buffer *rx_buffer)
-{
-	dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
-			     DMA_FROM_DEVICE, IXGBEVF_RX_DMA_ATTR);
-	rx_buffer->page = NULL;
 }
 
 /**
@@ -579,41 +552,6 @@ static bool ixgbevf_is_non_eop(struct ixgbevf_ring *rx_ring,
 	return true;
 }
 
-static bool ixgbevf_alloc_mapped_page(struct ixgbevf_ring *rx_ring,
-				      struct ixgbevf_rx_buffer *bi)
-{
-	struct page *page = bi->page;
-	dma_addr_t dma;
-
-	/* alloc new page for storage */
-	page = dev_alloc_page();
-	if (unlikely(!page)) {
-		rx_ring->rx_stats.alloc_rx_page_failed++;
-		return false;
-	}
-
-	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0, PAGE_SIZE,
-				 DMA_FROM_DEVICE, IXGBEVF_RX_DMA_ATTR);
-
-	/* if mapping failed free memory back to system since
-	 * there isn't much point in holding memory we can't use
-	 */
-	if (dma_mapping_error(rx_ring->dev, dma)) {
-		__free_page(page);
-
-		rx_ring->rx_stats.alloc_rx_page_failed++;
-		return false;
-	}
-
-	bi->dma = dma;
-	bi->page = page;
-	bi->page_offset = IXGBEVF_SKB_PAD;
-	rx_ring->rx_stats.alloc_rx_page++;
-
-	return true;
-}
-
 /**
  * ixgbevf_alloc_rx_buffers - Replace used receive buffers; packet split
  * @rx_ring: rx descriptor ring (for a specific queue) to setup buffers on
@@ -623,39 +561,34 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 				     u16 cleaned_count)
 {
 	union ixgbe_adv_rx_desc *rx_desc;
-	struct ixgbevf_rx_buffer *bi;
-	unsigned int i = rx_ring->next_to_use;
+	const struct libeth_fq_fp fq = {
+		.pp		= rx_ring->pp,
+		.fqes		= rx_ring->rx_fqes,
+		.truesize	= rx_ring->truesize,
+		.count		= rx_ring->count,
+	};
+	u16 ntu = rx_ring->next_to_use;
 
 	/* nothing to do or no valid netdev defined */
 	if (!cleaned_count || !rx_ring->netdev)
 		return;
 
-	rx_desc = IXGBEVF_RX_DESC(rx_ring, i);
-	bi = &rx_ring->rx_buffer_info[i];
-	i -= rx_ring->count;
+	rx_desc = IXGBEVF_RX_DESC(rx_ring, ntu);
 
 	do {
-		if (!ixgbevf_alloc_mapped_page(rx_ring, bi))
-			break;
+		dma_addr_t addr;
 
-		/* sync the buffer for use by the device */
-		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
-						 bi->page_offset,
-						 IXGBEVF_RXBUFFER_3072,
-						 DMA_FROM_DEVICE);
+		addr = libeth_rx_alloc(&fq, ntu);
+		if (addr == DMA_MAPPING_ERROR)
+			return;
 
-		/* Refresh the desc even if pkt_addr didn't change
-		 * because each write-back erases this info.
-		 */
-		rx_desc->read.pkt_addr = cpu_to_le64(bi->dma + bi->page_offset);
+		rx_desc->read.pkt_addr = cpu_to_le64(addr);
 
 		rx_desc++;
-		bi++;
-		i++;
-		if (unlikely(!i)) {
+		ntu++;
+		if (unlikely(ntu == rx_ring->count)) {
 			rx_desc = IXGBEVF_RX_DESC(rx_ring, 0);
-			bi = rx_ring->rx_buffer_info;
-			i -= rx_ring->count;
+			ntu = 0;
 		}
 
 		/* clear the length for the next_to_use descriptor */
@@ -664,14 +597,9 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 		cleaned_count--;
 	} while (cleaned_count);
 
-	i += rx_ring->count;
-
-	if (rx_ring->next_to_use != i) {
+	if (likely(rx_ring->next_to_use != ntu)) {
 		/* record the next descriptor to use */
-		rx_ring->next_to_use = i;
-
-		/* update next to alloc since we have filled the ring */
-		rx_ring->next_to_alloc = i;
+		rx_ring->next_to_use = ntu;
 
 		/* Force memory writes to complete before letting h/w
 		 * know there are new descriptors to fetch.  (Only
@@ -679,7 +607,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 		 * such as IA-64).
 		 */
 		wmb();
-		ixgbevf_write_tail(rx_ring, i);
+		ixgbevf_write_tail(rx_ring, ntu);
 	}
 }
 
@@ -716,10 +644,6 @@ static bool ixgbevf_cleanup_headers(struct ixgbevf_ring *rx_ring,
 		}
 	}
 
-	/* if eth_skb_pad returns an error the skb was freed */
-	if (eth_skb_pad(skb))
-		return true;
-
 	return false;
 }
 
@@ -732,15 +656,15 @@ static bool ixgbevf_cleanup_headers(struct ixgbevf_ring *rx_ring,
  *
  * This function will add the data contained in rx_buffer->page to the skb.
  **/
-static void ixgbevf_add_rx_frag(struct ixgbevf_ring *rx_ring,
-				struct ixgbevf_rx_buffer *rx_buffer,
+static void ixgbevf_add_rx_frag(const struct libeth_fqe *rx_buffer,
 				struct sk_buff *skb,
 				unsigned int size)
 {
-	unsigned int truesize = SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size);
+	u32 hr = netmem_get_pp(rx_buffer->netmem)->p.offset;
 
-	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
-			rx_buffer->page_offset, size, truesize);
+	skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
+			       rx_buffer->netmem, rx_buffer->offset + hr,
+			       size, rx_buffer->truesize);
 }
 
 static inline void ixgbevf_irq_enable_queues(struct ixgbevf_adapter *adapter,
@@ -751,38 +675,6 @@ static inline void ixgbevf_irq_enable_queues(struct ixgbevf_adapter *adapter,
 	IXGBE_WRITE_REG(hw, IXGBE_VTEIMS, qmask);
 }
 
-static struct sk_buff *ixgbevf_build_skb(struct ixgbevf_ring *rx_ring,
-					 struct ixgbevf_rx_buffer *rx_buffer,
-					 struct xdp_buff *xdp,
-					 union ixgbe_adv_rx_desc *rx_desc)
-{
-	unsigned int metasize = xdp->data - xdp->data_meta;
-	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
-				SKB_DATA_ALIGN(xdp->data_end -
-					       xdp->data_hard_start);
-	struct sk_buff *skb;
-
-	/* Prefetch first cache line of first page. If xdp->data_meta
-	 * is unused, this points to xdp->data, otherwise, we likely
-	 * have a consumer accessing first few bytes of meta data,
-	 * and then actual data.
-	 */
-	net_prefetch(xdp->data_meta);
-
-	/* build an skb around the page buffer */
-	skb = napi_build_skb(xdp->data_hard_start, truesize);
-	if (unlikely(!skb))
-		return NULL;
-
-	/* update pointers within the skb to store the data */
-	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-	__skb_put(skb, xdp->data_end - xdp->data);
-	if (metasize)
-		skb_metadata_set(skb, metasize);
-
-	return skb;
-}
-
 #define IXGBEVF_XDP_PASS 0
 #define IXGBEVF_XDP_CONSUMED 1
 #define IXGBEVF_XDP_TX 2
@@ -866,7 +758,7 @@ static int ixgbevf_xmit_xdp_ring(struct ixgbevf_ring *ring,
 
 static int ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 			   struct ixgbevf_ring *rx_ring,
-			   struct xdp_buff *xdp)
+			   struct libeth_xdp_buff *xdp)
 {
 	int result = IXGBEVF_XDP_PASS;
 	struct ixgbevf_ring *xdp_ring;
@@ -878,13 +770,13 @@ static int ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 	if (!xdp_prog)
 		goto xdp_out;
 
-	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	act = bpf_prog_run_xdp(xdp_prog, &xdp->base);
 	switch (act) {
 	case XDP_PASS:
 		break;
 	case XDP_TX:
 		xdp_ring = adapter->xdp_ring[rx_ring->queue_index];
-		result = ixgbevf_xmit_xdp_ring(xdp_ring, xdp);
+		result = ixgbevf_xmit_xdp_ring(xdp_ring, &xdp->base);
 		if (result == IXGBEVF_XDP_CONSUMED)
 			goto out_failure;
 		break;
@@ -897,6 +789,7 @@ static int ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 		fallthrough; /* handle aborts by dropping packet */
 	case XDP_DROP:
 		result = IXGBEVF_XDP_CONSUMED;
+		libeth_xdp_return_buff(xdp);
 		break;
 	}
 xdp_out:
@@ -911,16 +804,15 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 	struct ixgbevf_adapter *adapter = q_vector->adapter;
 	u16 cleaned_count = ixgbevf_desc_unused(rx_ring);
 	struct sk_buff *skb = rx_ring->skb;
+	LIBETH_XDP_ONSTACK_BUFF(xdp);
 	bool xdp_xmit = false;
-	struct xdp_buff xdp;
 	int xdp_res = 0;
 
-	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
-	xdp_init_buff(&xdp, IXGBEVF_RXBUFFER_3072, &rx_ring->xdp_rxq);
+	xdp->base.rxq = &rx_ring->xdp_rxq;
 
 	while (likely(total_rx_packets < budget)) {
-		struct ixgbevf_rx_buffer *rx_buffer;
 		union ixgbe_adv_rx_desc *rx_desc;
+		struct libeth_fqe *rx_buffer;
 		unsigned int size;
 
 		/* return some buffers to hardware, one at a time is too slow */
@@ -940,18 +832,14 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		 */
 		rmb();
 
-		rx_buffer =
-			ixgbevf_get_rx_buffer(rx_ring, IXGBEVF_RXBUFFER_3072);
+		rx_buffer = &rx_ring->rx_fqes[rx_ring->next_to_clean];
+		libeth_rx_sync_for_cpu(rx_buffer, size);
 
 		/* retrieve a buffer from the ring */
 		if (!skb) {
-			unsigned int offset = rx_buffer->page_offset;
-			unsigned char *hard_start;
-
-			hard_start = page_address(rx_buffer->page) +
-				     rx_buffer->page_offset - offset;
-			xdp_prepare_buff(&xdp, hard_start, offset, size, true);
-			xdp_res = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
+			libeth_xdp_prepare_buff(xdp, rx_buffer, size);
+			prefetch(xdp->data);
+			xdp_res = ixgbevf_run_xdp(adapter, rx_ring, xdp);
 		}
 
 		if (xdp_res) {
@@ -961,10 +849,9 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			total_rx_packets++;
 			total_rx_bytes += size;
 		} else if (skb) {
-			ixgbevf_add_rx_frag(rx_ring, rx_buffer, skb, size);
+			ixgbevf_add_rx_frag(rx_buffer, skb, size);
 		} else {
-			skb = ixgbevf_build_skb(rx_ring, rx_buffer,
-						&xdp, rx_desc);
+			skb = xdp_build_skb_from_buff(&xdp->base);
 		}
 
 		/* exit if we failed to retrieve a buffer */
@@ -973,7 +860,6 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			break;
 		}
 
-		ixgbevf_put_rx_buffer(rx_ring, rx_buffer);
 		cleaned_count++;
 
 		/* fetch next buffer in frame if non-eop */
@@ -1542,7 +1428,8 @@ static void ixgbevf_configure_tx(struct ixgbevf_adapter *adapter)
 #define IXGBE_SRRCTL_BSIZEHDRSIZE_SHIFT	2
 
 static void ixgbevf_configure_srrctl(struct ixgbevf_adapter *adapter,
-				     struct ixgbevf_ring *ring, int index)
+				     struct ixgbevf_ring *ring, int index,
+				     bool rlpml_valid)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 srrctl;
@@ -1550,7 +1437,11 @@ static void ixgbevf_configure_srrctl(struct ixgbevf_adapter *adapter,
 	srrctl = IXGBE_SRRCTL_DROP_EN;
 
 	srrctl |= IXGBEVF_RX_HDR_SIZE << IXGBE_SRRCTL_BSIZEHDRSIZE_SHIFT;
-	srrctl |= IXGBEVF_RXBUFFER_3072 >> IXGBE_SRRCTL_BSIZEPKT_SHIFT;
+	if (rlpml_valid)
+		srrctl |= DIV_ROUND_UP(ring->rx_buf_len,
+				       IXGBE_SRRCTL_BSIZEPKT_STEP);
+	else
+		srrctl |= ring->rx_buf_len / IXGBE_SRRCTL_BSIZEPKT_STEP;
 	srrctl |= IXGBE_SRRCTL_DESCTYPE_ADV_ONEBUF;
 
 	IXGBE_WRITE_REG(hw, IXGBE_VFSRRCTL(index), srrctl);
@@ -1681,9 +1572,10 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	union ixgbe_adv_rx_desc *rx_desc;
+	u8 reg_idx = ring->reg_idx;
+	bool rlpml_valid = false;
 	u64 rdba = ring->dma;
 	u32 rxdctl;
-	u8 reg_idx = ring->reg_idx;
 
 	/* disable queue to avoid issues while updating state */
 	rxdctl = IXGBE_READ_REG(hw, IXGBE_VFRXDCTL(reg_idx));
@@ -1709,10 +1601,6 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 	IXGBE_WRITE_REG(hw, IXGBE_VFRDT(reg_idx), 0);
 	ring->tail = adapter->io_addr + IXGBE_VFRDT(reg_idx);
 
-	/* initialize rx_buffer_info */
-	memset(ring->rx_buffer_info, 0,
-	       sizeof(struct ixgbevf_rx_buffer) * ring->count);
-
 	/* initialize Rx descriptor 0 */
 	rx_desc = IXGBEVF_RX_DESC(ring, 0);
 	rx_desc->wb.upper.length = 0;
@@ -1720,16 +1608,21 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 	/* reset ntu and ntc to place SW in sync with hardwdare */
 	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
-	ring->next_to_alloc = 0;
-
-	ixgbevf_configure_srrctl(adapter, ring, reg_idx);
 
 	/* RXDCTL.RLPML does not work on 82599 */
 	if (adapter->hw.mac.type != ixgbe_mac_82599_vf) {
-		rxdctl &= ~(IXGBE_RXDCTL_RLPMLMASK |
-			    IXGBE_RXDCTL_RLPML_EN);
+		u32 pkt_len =
+			READ_ONCE(adapter->netdev->mtu) + LIBETH_RX_LL_LEN;
+
+		rxdctl &= ~(IXGBE_RXDCTL_RLPMLMASK | IXGBE_RXDCTL_RLPML_EN);
+		if (pkt_len <= IXGBE_RXDCTL_RLPMLMASK) {
+			rxdctl |= pkt_len | IXGBE_RXDCTL_RLPML_EN;
+			rlpml_valid = true;
+		}
 	}
 
+	ixgbevf_configure_srrctl(adapter, ring, reg_idx, rlpml_valid);
+
 	rxdctl |= IXGBE_RXDCTL_ENABLE | IXGBE_RXDCTL_VME;
 	IXGBE_WRITE_REG(hw, IXGBE_VFRXDCTL(reg_idx), rxdctl);
 
@@ -2125,8 +2018,6 @@ void ixgbevf_up(struct ixgbevf_adapter *adapter)
  **/
 static void ixgbevf_clean_rx_ring(struct ixgbevf_ring *rx_ring)
 {
-	u16 i = rx_ring->next_to_clean;
-
 	/* Free Rx ring sk_buff */
 	if (rx_ring->skb) {
 		dev_kfree_skb(rx_ring->skb);
@@ -2134,29 +2025,14 @@ static void ixgbevf_clean_rx_ring(struct ixgbevf_ring *rx_ring)
 	}
 
 	/* Free all the Rx ring pages */
-	while (i != rx_ring->next_to_alloc) {
-		struct ixgbevf_rx_buffer *rx_buffer;
-
-		rx_buffer = &rx_ring->rx_buffer_info[i];
+	for (u32 i = rx_ring->next_to_clean; i != rx_ring->next_to_use; ) {
+		const struct libeth_fqe *rx_fqe = &rx_ring->rx_fqes[i];
 
-		/* Invalidate cache lines that may have been written to by
-		 * device so that we avoid corrupting memory.
-		 */
-		dma_sync_single_range_for_cpu(rx_ring->dev,
-					      rx_buffer->dma,
-					      rx_buffer->page_offset,
-					      IXGBEVF_RXBUFFER_3072,
-					      DMA_FROM_DEVICE);
-
-		/* free resources associated with mapping */
-		ixgbevf_put_rx_buffer(rx_ring, rx_buffer);
-		__free_page(rx_buffer->page);
-		i++;
-		if (i == rx_ring->count)
+		libeth_rx_recycle_slow(rx_fqe->netmem);
+		if (unlikely(++i == rx_ring->count))
 			i = 0;
 	}
 
-	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 }
@@ -2175,7 +2051,7 @@ static void ixgbevf_clean_tx_ring(struct ixgbevf_ring *tx_ring)
 
 		/* Free all the Tx ring sk_buffs */
 		if (ring_is_xdp(tx_ring))
-			page_frag_free(tx_buffer->data);
+			libeth_xdp_return_va(tx_buffer->data, false);
 		else
 			dev_kfree_skb_any(tx_buffer->skb);
 
@@ -3257,12 +3133,26 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
 int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
 			       struct ixgbevf_ring *rx_ring)
 {
-	int size;
+	struct libeth_fq fq = {
+		.count		= rx_ring->count,
+		.nid		= NUMA_NO_NODE,
+		.type		= LIBETH_FQE_MTU,
+		.xdp		= !!rx_ring->xdp_prog,
+		.idx		= rx_ring->queue_index,
+		.buf_len	= IXGBEVF_RX_PAGE_LEN(rx_ring->xdp_prog ?
+						      LIBETH_XDP_HEADROOM :
+						      LIBETH_SKB_HEADROOM),
+	};
+	int ret;
 
-	size = sizeof(struct ixgbevf_rx_buffer) * rx_ring->count;
-	rx_ring->rx_buffer_info = vmalloc(size);
-	if (!rx_ring->rx_buffer_info)
-		goto err;
+	ret = libeth_rx_fq_create(&fq, &rx_ring->q_vector->napi);
+	if (ret)
+		return ret;
+
+	rx_ring->pp = fq.pp;
+	rx_ring->rx_fqes = fq.fqes;
+	rx_ring->truesize = fq.truesize;
+	rx_ring->rx_buf_len = fq.buf_len;
 
 	u64_stats_init(&rx_ring->syncp);
 
@@ -3270,25 +3160,29 @@ int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
 	rx_ring->size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
 	rx_ring->size = ALIGN(rx_ring->size, 4096);
 
-	rx_ring->desc = dma_alloc_coherent(rx_ring->dev, rx_ring->size,
+	rx_ring->desc = dma_alloc_coherent(fq.pp->p.dev, rx_ring->size,
 					   &rx_ring->dma, GFP_KERNEL);
 
 	if (!rx_ring->desc)
 		goto err;
 
 	/* XDP RX-queue info */
-	if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
-			     rx_ring->queue_index, 0) < 0)
+	ret = __xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
+				 rx_ring->queue_index, 0, rx_ring->truesize);
+	if (ret)
 		goto err;
 
+	xdp_rxq_info_attach_page_pool(&rx_ring->xdp_rxq, fq.pp);
+
 	rx_ring->xdp_prog = adapter->xdp_prog;
 
 	return 0;
 err:
-	vfree(rx_ring->rx_buffer_info);
-	rx_ring->rx_buffer_info = NULL;
+	libeth_rx_fq_destroy(&fq);
+	rx_ring->rx_fqes = NULL;
+	rx_ring->pp = NULL;
 	dev_err(rx_ring->dev, "Unable to allocate memory for the Rx descriptor ring\n");
-	return -ENOMEM;
+	return ret;
 }
 
 /**
@@ -3329,17 +3223,24 @@ static int ixgbevf_setup_all_rx_resources(struct ixgbevf_adapter *adapter)
  **/
 void ixgbevf_free_rx_resources(struct ixgbevf_ring *rx_ring)
 {
+	struct libeth_fq fq = {
+		.fqes	= rx_ring->rx_fqes,
+		.pp	= rx_ring->pp,
+	};
+
 	ixgbevf_clean_rx_ring(rx_ring);
 
 	rx_ring->xdp_prog = NULL;
+	xdp_rxq_info_detach_mem_model(&rx_ring->xdp_rxq);
 	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
-	vfree(rx_ring->rx_buffer_info);
-	rx_ring->rx_buffer_info = NULL;
 
-	dma_free_coherent(rx_ring->dev, rx_ring->size, rx_ring->desc,
+	dma_free_coherent(fq.pp->p.dev, rx_ring->size, rx_ring->desc,
 			  rx_ring->dma);
-
 	rx_ring->desc = NULL;
+
+	libeth_rx_fq_destroy(&fq);
+	rx_ring->rx_fqes = NULL;
+	rx_ring->pp = NULL;
 }
 
 /**
-- 
2.52.0


