Return-Path: <netdev+bounces-259991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPgcMPIrnGmcAQQAu9opvQ
	(envelope-from <netdev+bounces-259991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:29:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43021174E2A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC703303CEA1
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A16B3612F9;
	Mon, 23 Feb 2026 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhExL9V5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0735D5F2;
	Mon, 23 Feb 2026 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842189; cv=none; b=qDL0r+iHDXR6dnwnFUKpGFwH7uqgI+MPrXVGnMnHCKM1MAYzZJ5Hm3dUlRfckMYlx+HmvbRRtTaAeKcfbJ4q4SMHRxTH3NSBhUUfLxs1HDc8omLEHrgHNZatyx6zo1sokPuXXpdgHOhPOIyGTfaGUh2IqG3ZVdkErGY9hARPsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842189; c=relaxed/simple;
	bh=YdN8h5/5ahlC9WoQk9zZj46hjdWTwKKl0UPlS60r5Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6ksafjXvZzZ48r7VDepVodM2giL0WcOLxB5h1py/BPoWX1+vCPP13yw9bIq/XN21oSQPPxN+yUfKXFWtMRenJHrMV7CKHMfRX7mf1EI8eMhT6XHGY9jRJAIQu2XArCdivPPcTSrZaYQC5MY4q3E8hjhRbPLEF0bJPCwEx6p0qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhExL9V5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771842187; x=1803378187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YdN8h5/5ahlC9WoQk9zZj46hjdWTwKKl0UPlS60r5Xs=;
  b=BhExL9V527273o0urUwNSEx7L6vZiieZed1zfNoTF3uv33Ul/gSB8073
   lqk527OQskUHuMc/u8aeGDfB9mtQFwm+a5RjKsVP6jwBm0E2UEtNS1kOP
   lCYIHlTt16BrdW6yfINUZsaiaCOAl03CmvL4cYNIqSD3tcspVXnndPQL6
   re8YJsj24mJFag/WR8sZdVgWfkxPpu0q/BdP6HHwW8GwzubZBRFY5OGZu
   vPLiQ6mD8ziBOnLQR+XFKS7wbrMn/vJGImZsUiz8P0nT1pCPkpbA+ULa4
   v72KU6PaX3fv5YQzKbdp8gfN/yPBPilg6isOkchZsJM7flUl2ainojkTi
   g==;
X-CSE-ConnectionGUID: AeRsuT3ySo2BuzTcra7Pbg==
X-CSE-MsgGUID: JgC98eNSQpeU5NcxcDJB4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76444771"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="76444771"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 02:23:05 -0800
X-CSE-ConnectionGUID: mM4SQT8UQ8mjoZYbWj4ZVg==
X-CSE-MsgGUID: uU36Gu8GSqS3SELbLMO6yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="246121827"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 23 Feb 2026 02:23:00 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C1EEA28169;
	Mon, 23 Feb 2026 10:22:57 +0000 (GMT)
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
Subject: [PATCH iwl-next 08/10] ixgbevf: add pseudo header split
Date: Mon, 23 Feb 2026 10:52:15 +0100
Message-ID: <20260223095222.3205363-9-larysa.zaremba@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259991-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43021174E2A
X-Rspamd-Action: no action

From: Natalia Wochtman <natalia.wochtman@intel.com>

Introduce pseudo header split support in the ixgbevf driver, specifically
targeting ixgbe_mac_82599_vf.

On older hardware (e.g. ixgbe_mac_82599_vf), RX DMA write size can only be
limited in 1K increments. This causes issues when attempting to fit
multiple packets per page, as a DMA write may overwrite the
headroom of the next packet.

To address this, introduce pseudo header split support, where the hardware
copies the full L2 header into a dedicated header buffer. This avoids the
need for HR/TR alignment and allows safe skb construction from the header
buffer without risking overwrites.

Given that once packet is too big to fit into a single page, the behaviour
is the same for all supported HW, use pseudo header split only for smaller
packets.

Signed-off-by: Natalia Wochtman <natalia.wochtman@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |   8 +
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 178 +++++++++++++++---
 2 files changed, 161 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 61883b1e1f78..86b23f595d4c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -90,6 +90,7 @@ struct ixgbevf_ring {
 		u32 truesize;		/* Rx buffer full size */
 		u32 pending;		/* Sent-not-completed descriptors */
 	};
+	u32 hdr_truesize;		/* Rx header buffer full size */
 	u16 count;			/* amount of descriptors */
 	u16 next_to_clean;
 	u32 next_to_use;
@@ -108,6 +109,8 @@ struct ixgbevf_ring {
 		struct ixgbevf_tx_queue_stats tx_stats;
 		struct ixgbevf_rx_queue_stats rx_stats;
 	};
+	struct libeth_fqe *hdr_fqes;
+	struct page_pool *hdr_pp;
 	struct xdp_rxq_info xdp_rxq;
 	u64 hw_csum_rx_error;
 	u8 __iomem *tail;
@@ -117,6 +120,7 @@ struct ixgbevf_ring {
 	 */
 	u16 reg_idx;
 	int queue_index; /* needed for multiqueue queue management */
+	u32 hdr_buf_len;
 	u32 rx_buf_len;
 	struct libeth_xdp_buff_stash xdp_stash;
 	unsigned int dma_size;		/* length in bytes */
@@ -152,6 +156,8 @@ struct ixgbevf_ring {
 
 #define IXGBEVF_RX_PAGE_LEN(hr)		(ALIGN_DOWN(LIBETH_RX_PAGE_LEN(hr), \
 					 IXGBE_SRRCTL_BSIZEPKT_STEP))
+#define IXGBEVF_RX_SRRCTL_BUF_SIZE(mtu)	(ALIGN((mtu) + LIBETH_RX_LL_LEN, \
+					       IXGBE_SRRCTL_BSIZEPKT_STEP))
 
 #define IXGBE_TX_FLAGS_CSUM		BIT(0)
 #define IXGBE_TX_FLAGS_VLAN		BIT(1)
@@ -350,6 +356,8 @@ enum ixbgevf_state_t {
 	__IXGBEVF_QUEUE_RESET_REQUESTED,
 };
 
+#define IXGBEVF_FLAG_HSPLIT	BIT(0)
+
 enum ixgbevf_boards {
 	board_82599_vf,
 	board_82599_vf_hv,
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index b0f34f097bf6..790e86135fbd 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -561,6 +561,12 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 		.truesize	= rx_ring->truesize,
 		.count		= rx_ring->count,
 	};
+	const struct libeth_fq_fp hdr_fq = {
+		.pp		= rx_ring->hdr_pp,
+		.fqes		= rx_ring->hdr_fqes,
+		.truesize	= rx_ring->hdr_truesize,
+		.count		= rx_ring->count,
+	};
 	u16 ntu = rx_ring->next_to_use;
 
 	/* nothing to do or no valid netdev defined */
@@ -578,6 +584,12 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 
 		rx_desc->read.pkt_addr = cpu_to_le64(addr);
 
+		if (hdr_fq.pp) {
+			addr = libeth_rx_alloc(&hdr_fq, ntu);
+			if (addr == DMA_MAPPING_ERROR)
+				return;
+		}
+
 		rx_desc++;
 		ntu++;
 		if (unlikely(ntu == fq.count)) {
@@ -820,6 +832,32 @@ LIBETH_XDP_DEFINE_FINALIZE(static ixgbevf_xdp_finalize_xdp_napi,
 			   ixgbevf_xdp_flush_tx, ixgbevf_xdp_rs_and_bump);
 LIBETH_XDP_DEFINE_END();
 
+static u32 ixgbevf_rx_hsplit_wa(const struct libeth_fqe *hdr,
+				struct libeth_fqe *buf, u32 data_len)
+{
+	u32 copy = data_len <= L1_CACHE_BYTES ? data_len : ETH_HLEN;
+	struct page *hdr_page, *buf_page;
+	const void *src;
+	void *dst;
+
+	if (unlikely(netmem_is_net_iov(buf->netmem)) ||
+	    !libeth_rx_sync_for_cpu(buf, copy))
+		return 0;
+
+	hdr_page = __netmem_to_page(hdr->netmem);
+	buf_page = __netmem_to_page(buf->netmem);
+
+	dst = page_address(hdr_page) + hdr->offset +
+	      pp_page_to_nmdesc(hdr_page)->pp->p.offset;
+	src = page_address(buf_page) + buf->offset +
+	      pp_page_to_nmdesc(buf_page)->pp->p.offset;
+
+	memcpy(dst, src, LARGEST_ALIGN(copy));
+	buf->offset += copy;
+
+	return copy;
+}
+
 static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 				struct ixgbevf_ring *rx_ring,
 				int budget)
@@ -859,6 +897,23 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		rmb();
 
 		rx_buffer = &rx_ring->rx_fqes[rx_ring->next_to_clean];
+
+		if (unlikely(rx_ring->hdr_pp)) {
+			struct libeth_fqe *hdr_buff;
+			unsigned int hdr_size = 0;
+
+			hdr_buff = &rx_ring->hdr_fqes[rx_ring->next_to_clean];
+
+			if (!xdp->data) {
+				hdr_size = ixgbevf_rx_hsplit_wa(hdr_buff,
+								rx_buffer,
+								size);
+				size -= hdr_size ? : size;
+			}
+
+			libeth_xdp_process_buff(xdp, hdr_buff, hdr_size);
+		}
+
 		libeth_xdp_process_buff(xdp, rx_buffer, size);
 
 		cleaned_count++;
@@ -1598,6 +1653,90 @@ static void ixgbevf_setup_vfmrqc(struct ixgbevf_adapter *adapter)
 	IXGBE_WRITE_REG(hw, IXGBE_VFMRQC, vfmrqc);
 }
 
+static void ixgbevf_rx_destroy_pp(struct ixgbevf_ring *rx_ring)
+{
+	struct libeth_fq fq = {
+		.pp	= rx_ring->pp,
+		.fqes	= rx_ring->rx_fqes,
+	};
+
+	libeth_rx_fq_destroy(&fq);
+	rx_ring->rx_fqes = NULL;
+	rx_ring->pp = NULL;
+
+	if (!rx_ring->hdr_pp)
+		return;
+
+	fq = (struct libeth_fq) {
+		.pp	= rx_ring->hdr_pp,
+		.fqes	= rx_ring->hdr_fqes,
+	};
+
+	libeth_rx_fq_destroy(&fq);
+	rx_ring->hdr_fqes = NULL;
+	rx_ring->hdr_pp = NULL;
+}
+
+static int ixgbevf_rx_create_pp(struct ixgbevf_ring *rx_ring)
+{
+	u32 adapter_flags = rx_ring->q_vector->adapter->flags;
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
+	u32 frame_size;
+	int ret;
+
+	/* Some HW requires DMA write sizes to be aligned to 1K,
+	 * which warrants fake header split usage, but this is
+	 * not an issue if the frame size is at its maximum of 3K
+	 */
+	frame_size =
+		IXGBEVF_RX_SRRCTL_BUF_SIZE(READ_ONCE(rx_ring->netdev->mtu));
+	fq.hsplit = (adapter_flags & IXGBEVF_FLAG_HSPLIT) &&
+		    frame_size < fq.buf_len;
+	ret = libeth_rx_fq_create(&fq, &rx_ring->q_vector->napi);
+	if (ret)
+		return ret;
+
+	rx_ring->pp = fq.pp;
+	rx_ring->rx_fqes = fq.fqes;
+	rx_ring->truesize = fq.truesize;
+	rx_ring->rx_buf_len = fq.buf_len;
+
+	if (!fq.hsplit)
+		return 0;
+
+	fq = (struct libeth_fq) {
+		.count		= rx_ring->count,
+		.nid		= NUMA_NO_NODE,
+		.type		= LIBETH_FQE_HDR,
+		.xdp		= !!rx_ring->xdp_prog,
+		.idx		= rx_ring->queue_index,
+	};
+
+	ret = libeth_rx_fq_create(&fq, &rx_ring->q_vector->napi);
+	if (ret)
+		goto err;
+
+	rx_ring->hdr_pp = fq.pp;
+	rx_ring->hdr_fqes = fq.fqes;
+	rx_ring->hdr_truesize = fq.truesize;
+	rx_ring->hdr_buf_len = fq.buf_len;
+
+	return 0;
+
+err:
+	ixgbevf_rx_destroy_pp(rx_ring);
+	return ret;
+}
+
 static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 				      struct ixgbevf_ring *ring)
 {
@@ -2718,6 +2857,9 @@ static int ixgbevf_sw_init(struct ixgbevf_adapter *adapter)
 			goto out;
 	}
 
+	if (adapter->hw.mac.type == ixgbe_mac_82599_vf)
+		adapter->flags |= IXGBEVF_FLAG_HSPLIT;
+
 	/* assume legacy case in which PF would only give VF 2 queues */
 	hw->mac.max_tx_queues = 2;
 	hw->mac.max_rx_queues = 2;
@@ -3152,43 +3294,29 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
 }
 
 /**
- * ixgbevf_setup_rx_resources - allocate Rx resources (Descriptors)
+ * ixgbevf_setup_rx_resources - allocate Rx resources
  * @adapter: board private structure
  * @rx_ring: Rx descriptor ring (for a specific queue) to setup
  *
- * Returns 0 on success, negative on failure
+ * Returns: 0 on success, negative on failure.
  **/
 int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
 			       struct ixgbevf_ring *rx_ring)
 {
-	struct libeth_fq fq = {
-		.count		= rx_ring->count,
-		.nid		= NUMA_NO_NODE,
-		.type		= LIBETH_FQE_MTU,
-		.xdp		= !!rx_ring->xdp_prog,
-		.idx		= rx_ring->queue_index,
-		.buf_len	= IXGBEVF_RX_PAGE_LEN(rx_ring->xdp_prog ?
-						      LIBETH_XDP_HEADROOM :
-						      LIBETH_SKB_HEADROOM),
-	};
 	int ret;
 
-	ret = libeth_rx_fq_create(&fq, &rx_ring->q_vector->napi);
+	ret = ixgbevf_rx_create_pp(rx_ring);
 	if (ret)
 		return ret;
 
-	rx_ring->pp = fq.pp;
-	rx_ring->rx_fqes = fq.fqes;
-	rx_ring->truesize = fq.truesize;
-	rx_ring->rx_buf_len = fq.buf_len;
-
 	u64_stats_init(&rx_ring->syncp);
 
 	/* Round up to nearest 4K */
 	rx_ring->dma_size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
 	rx_ring->dma_size = ALIGN(rx_ring->dma_size, 4096);
 
-	rx_ring->desc = dma_alloc_coherent(fq.pp->p.dev, rx_ring->dma_size,
+	rx_ring->desc = dma_alloc_coherent(rx_ring->pp->p.dev,
+					   rx_ring->dma_size,
 					   &rx_ring->dma, GFP_KERNEL);
 
 	if (!rx_ring->desc)
@@ -3200,16 +3328,15 @@ int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
 	if (ret)
 		goto err;
 
-	xdp_rxq_info_attach_page_pool(&rx_ring->xdp_rxq, fq.pp);
+	xdp_rxq_info_attach_page_pool(&rx_ring->xdp_rxq, rx_ring->pp);
 
 	rx_ring->xdp_prog = adapter->xdp_prog;
 
 	return 0;
 err:
-	libeth_rx_fq_destroy(&fq);
-	rx_ring->rx_fqes = NULL;
-	rx_ring->pp = NULL;
+	ixgbevf_rx_destroy_pp(rx_ring);
 	dev_err(rx_ring->dev, "Unable to allocate memory for the Rx descriptor ring\n");
+
 	return ret;
 }
 
@@ -4138,10 +4265,11 @@ static int ixgbevf_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
 	struct bpf_prog *old_prog;
 	bool requires_mbuf;
 
-	requires_mbuf = frame_size > IXGBEVF_RX_PAGE_LEN(LIBETH_XDP_HEADROOM);
+	requires_mbuf = frame_size > IXGBEVF_RX_PAGE_LEN(LIBETH_XDP_HEADROOM) ||
+			adapter->flags & IXGBEVF_FLAG_HSPLIT;
 	if (prog && !prog->aux->xdp_has_frags && requires_mbuf) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "Configured MTU requires non-linear frames and XDP prog does not support frags");
+				   "Configured MTU or HW limitations require non-linear frames and XDP prog does not support frags");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.52.0


