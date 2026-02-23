Return-Path: <netdev+bounces-259989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDaYOowrnGmcAQQAu9opvQ
	(envelope-from <netdev+bounces-259989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:27:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 824C2174DB2
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F11730935CB
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255A35C1B6;
	Mon, 23 Feb 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOO0hYqf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7D35BDCA;
	Mon, 23 Feb 2026 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842184; cv=none; b=Fiy7xMIzBK9zfWKEyo/Ui+BiQDPOncLTU+zFH49VZ/9IysxthQtyjf6tLiO9X1Di6r0OQxFM0m5tnWoyYkPaP3QY+tA5cxMeH5v0DvB4joavVsVT6vBk06JF8SfcI3C5SlqBcfjjd+kUAg45U1vUq2VSfGpVxmEkJj8C9TdxYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842184; c=relaxed/simple;
	bh=IW7Yf0xrzs0mSLEDfq/1qgfiyE7Di26Urd5rJdJkYMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzjnF1lp33P4n2rWfI3OUVxoWMjitpepypDg/lauIM9/sN4VEOWnMjw1Pp6hRtF4udazVdy5TTI4/y1gi/0RwjnZI6BdPcYiqdbrlbcW5Upp54+5Kn4jytZrDT8U26CHguTHl/Rbd896cs7iry2gAKJch64o7rp5ItzOHaT1hHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOO0hYqf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771842183; x=1803378183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IW7Yf0xrzs0mSLEDfq/1qgfiyE7Di26Urd5rJdJkYMQ=;
  b=FOO0hYqffXd7d1gtr8+Cx+8IHIXJbJnnstI5zpGk8oTkHYqj+pEHJ4k3
   sCUegqyhIkIRlYvp1sr1NigREnl2UvzOV/ccPMNr/B8FJLvS0sgBZlQXb
   k0mCT0oNce3JsvyNI7/tVH4q5Abm6rTmnY3Jfa+15jwi6UDGxjQ8d5fFn
   Dnq1G0TZwrJwDWzGzi0VgO0YdRWikWPmqKViJFAQbqSnjPZP/avCckaLY
   pNfoGCINjRa4wqDKRDyhbN4q8/oh27mHAilXnoLtlurg40VrMS4NQ6f4v
   rhoQfBzV2/C6tgjMiPW1CzI1epRFNXxOT2PHrKTNEfpVGReGjsENiUTBC
   g==;
X-CSE-ConnectionGUID: vlSKhA7bQzmPzbB4x1ayww==
X-CSE-MsgGUID: ulaauac1Sxynf5cfn8uh7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76444745"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="76444745"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 02:23:00 -0800
X-CSE-ConnectionGUID: 2natCC0eSxSTFc03Scs+RA==
X-CSE-MsgGUID: ReghT47FT/SiBpw+7gAAyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="246121777"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 23 Feb 2026 02:22:55 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 45FC228167;
	Mon, 23 Feb 2026 10:22:53 +0000 (GMT)
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
Subject: [PATCH iwl-next 06/10] ixgbevf: XDP_TX in multi-buffer through libeth
Date: Mon, 23 Feb 2026 10:52:13 +0100
Message-ID: <20260223095222.3205363-7-larysa.zaremba@intel.com>
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
	TAGGED_FROM(0.00)[bounces-259989-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 824C2174DB2
X-Rspamd-Action: no action

Use libeth to support XDP_TX action for segmented packets.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |  14 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 294 ++++++++++++------
 2 files changed, 200 insertions(+), 108 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index eada53c57fcf..67d10e6e9910 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -82,20 +82,22 @@ struct ixgbevf_ring {
 	struct net_device *netdev;
 	struct bpf_prog *xdp_prog;
 	union {
-		struct page_pool *pp;	/* Rx ring */
+		struct page_pool *pp;	/* Rx and XDP rings */
 		struct device *dev;	/* Tx ring */
 	};
 	void *desc;			/* descriptor ring memory */
-	dma_addr_t dma;			/* phys. address of descriptor ring */
-	unsigned int size;		/* length in bytes */
-	u32 truesize;			/* Rx buffer full size */
+	union {
+		u32 truesize;		/* Rx buffer full size */
+		u32 pending;		/* Sent-not-completed descriptors */
+	};
 	u16 count;			/* amount of descriptors */
-	u16 next_to_use;
 	u16 next_to_clean;
+	u32 next_to_use;
 
 	union {
 		struct libeth_fqe *rx_fqes;
 		struct ixgbevf_tx_buffer *tx_buffer_info;
+		struct libeth_sqe *xdp_sqes;
 	};
 	unsigned long state;
 	struct ixgbevf_stats stats;
@@ -115,6 +117,8 @@ struct ixgbevf_ring {
 	int queue_index; /* needed for multiqueue queue management */
 	u32 rx_buf_len;
 	struct libeth_xdp_buff_stash xdp_stash;
+	unsigned int dma_size;		/* length in bytes */
+	dma_addr_t dma;			/* phys. address of descriptor ring */
 } ____cacheline_internodealigned_in_smp;
 
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 558a4fad543a..6be2390daeba 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -306,10 +306,7 @@ static bool ixgbevf_clean_tx_irq(struct ixgbevf_q_vector *q_vector,
 			total_ipsec++;
 
 		/* free the skb */
-		if (ring_is_xdp(tx_ring))
-			libeth_xdp_return_va(tx_buffer->data, true);
-		else
-			napi_consume_skb(tx_buffer->skb, napi_budget);
+		napi_consume_skb(tx_buffer->skb, napi_budget);
 
 		/* unmap skb header data */
 		dma_unmap_single(tx_ring->dev,
@@ -392,9 +389,8 @@ static bool ixgbevf_clean_tx_irq(struct ixgbevf_q_vector *q_vector,
 		       eop_desc, (eop_desc ? eop_desc->wb.status : 0),
 		       tx_ring->tx_buffer_info[i].time_stamp, jiffies);
 
-		if (!ring_is_xdp(tx_ring))
-			netif_stop_subqueue(tx_ring->netdev,
-					    tx_ring->queue_index);
+		netif_stop_subqueue(tx_ring->netdev,
+				    tx_ring->queue_index);
 
 		/* schedule immediate reset if we believe we hung */
 		ixgbevf_tx_timeout_reset(adapter);
@@ -402,9 +398,6 @@ static bool ixgbevf_clean_tx_irq(struct ixgbevf_q_vector *q_vector,
 		return true;
 	}
 
-	if (ring_is_xdp(tx_ring))
-		return !!budget;
-
 #define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
 	if (unlikely(total_packets && netif_carrier_ok(tx_ring->netdev) &&
 		     (ixgbevf_desc_unused(tx_ring) >= TX_WAKE_THRESHOLD))) {
@@ -660,44 +653,83 @@ static inline void ixgbevf_irq_enable_queues(struct ixgbevf_adapter *adapter,
 #define IXGBEVF_XDP_CONSUMED 1
 #define IXGBEVF_XDP_TX 2
 
-static int ixgbevf_xmit_xdp_ring(struct ixgbevf_ring *ring,
-				 struct xdp_buff *xdp)
+static void ixgbevf_clean_xdp_num(struct ixgbevf_ring *xdp_ring, bool in_napi,
+				  u16 to_clean)
+{
+	struct libeth_xdpsq_napi_stats stats = { };
+	u32 ntc = xdp_ring->next_to_clean;
+	struct xdp_frame_bulk cbulk;
+	struct libeth_cq_pp cp = {
+		.bq = &cbulk,
+		.dev = xdp_ring->dev,
+		.xss = &stats,
+		.napi = in_napi,
+	};
+
+	xdp_frame_bulk_init(&cbulk);
+	xdp_ring->pending -= to_clean;
+
+	while (likely(to_clean--)) {
+		libeth_xdp_complete_tx(&xdp_ring->xdp_sqes[ntc], &cp);
+		ntc++;
+		ntc = unlikely(ntc == xdp_ring->count) ? 0 : ntc;
+	}
+
+	xdp_ring->next_to_clean = ntc;
+	xdp_flush_frame_bulk(&cbulk);
+}
+
+static u16 ixgbevf_tx_get_num_sent(struct ixgbevf_ring *xdp_ring)
 {
-	struct ixgbevf_tx_buffer *tx_buffer;
-	union ixgbe_adv_tx_desc *tx_desc;
-	u32 len, cmd_type;
-	dma_addr_t dma;
-	u16 i;
+	u16 ntc = xdp_ring->next_to_clean;
+	u16 to_clean = 0;
 
-	len = xdp->data_end - xdp->data;
+	while (likely(to_clean < xdp_ring->pending)) {
+		u32 idx = xdp_ring->xdp_sqes[ntc].rs_idx;
+		union ixgbe_adv_tx_desc *rs_desc;
 
-	if (unlikely(!ixgbevf_desc_unused(ring)))
-		return IXGBEVF_XDP_CONSUMED;
+		if (!idx--)
+			break;
 
-	dma = dma_map_single(ring->dev, xdp->data, len, DMA_TO_DEVICE);
-	if (dma_mapping_error(ring->dev, dma))
-		return IXGBEVF_XDP_CONSUMED;
+		rs_desc = IXGBEVF_TX_DESC(xdp_ring, idx);
 
-	/* record the location of the first descriptor for this packet */
-	i = ring->next_to_use;
-	tx_buffer = &ring->tx_buffer_info[i];
-
-	dma_unmap_len_set(tx_buffer, len, len);
-	dma_unmap_addr_set(tx_buffer, dma, dma);
-	tx_buffer->data = xdp->data;
-	tx_buffer->bytecount = len;
-	tx_buffer->gso_segs = 1;
-	tx_buffer->protocol = 0;
-
-	/* Populate minimal context descriptor that will provide for the
-	 * fact that we are expected to process Ethernet frames.
-	 */
-	if (!test_bit(__IXGBEVF_TX_XDP_RING_PRIMED, &ring->state)) {
+		if (!(rs_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
+			break;
+
+		xdp_ring->xdp_sqes[ntc].rs_idx = 0;
+
+		to_clean +=
+			(idx >= ntc ? idx : idx + xdp_ring->count) - ntc + 1;
+
+		ntc = (idx + 1 == xdp_ring->count) ? 0 : idx + 1;
+	}
+
+	return to_clean;
+}
+
+static void ixgbevf_clean_xdp_ring(struct ixgbevf_ring *xdp_ring)
+{
+	ixgbevf_clean_xdp_num(xdp_ring, false, xdp_ring->pending);
+}
+
+static u32 ixgbevf_prep_xdp_sq(void *xdpsq, struct libeth_xdpsq *sq)
+{
+	struct ixgbevf_ring *xdp_ring = xdpsq;
+
+	if (unlikely(ixgbevf_desc_unused(xdp_ring) < LIBETH_XDP_TX_BULK)) {
+		u16 to_clean = ixgbevf_tx_get_num_sent(xdp_ring);
+
+		if (likely(to_clean))
+			ixgbevf_clean_xdp_num(xdp_ring, true, to_clean);
+	}
+
+	if (unlikely(!test_bit(__IXGBEVF_TX_XDP_RING_PRIMED,
+			       &xdp_ring->state))) {
 		struct ixgbe_adv_tx_context_desc *context_desc;
 
-		set_bit(__IXGBEVF_TX_XDP_RING_PRIMED, &ring->state);
+		set_bit(__IXGBEVF_TX_XDP_RING_PRIMED, &xdp_ring->state);
 
-		context_desc = IXGBEVF_TX_CTXTDESC(ring, 0);
+		context_desc = IXGBEVF_TX_CTXTDESC(xdp_ring, 0);
 		context_desc->vlan_macip_lens	=
 			cpu_to_le32(ETH_HLEN << IXGBE_ADVTXD_MACLEN_SHIFT);
 		context_desc->fceof_saidx	= 0;
@@ -706,48 +738,98 @@ static int ixgbevf_xmit_xdp_ring(struct ixgbevf_ring *ring,
 				    IXGBE_ADVTXD_DTYP_CTXT);
 		context_desc->mss_l4len_idx	= 0;
 
-		i = 1;
+		xdp_ring->next_to_use = 1;
+		xdp_ring->pending = 1;
+
+		/* Finish descriptor writes before bumping tail */
+		wmb();
+		ixgbevf_write_tail(xdp_ring, 1);
 	}
 
-	/* put descriptor type bits */
-	cmd_type = IXGBE_ADVTXD_DTYP_DATA |
-		   IXGBE_ADVTXD_DCMD_DEXT |
-		   IXGBE_ADVTXD_DCMD_IFCS;
-	cmd_type |= len | IXGBE_TXD_CMD;
+	*sq = (struct libeth_xdpsq) {
+		.count = xdp_ring->count,
+		.descs = xdp_ring->desc,
+		.lock = NULL,
+		.ntu = &xdp_ring->next_to_use,
+		.pending = &xdp_ring->pending,
+		.pool = NULL,
+		.sqes = xdp_ring->xdp_sqes,
+	};
+
+	return ixgbevf_desc_unused(xdp_ring);
+}
 
-	tx_desc = IXGBEVF_TX_DESC(ring, i);
-	tx_desc->read.buffer_addr = cpu_to_le64(dma);
+static void ixgbevf_xdp_xmit_desc(struct libeth_xdp_tx_desc desc, u32 i,
+				  const struct libeth_xdpsq *sq,
+				  u64 priv)
+{
+	union ixgbe_adv_tx_desc *tx_desc =
+		&((union ixgbe_adv_tx_desc *)sq->descs)[i];
 
-	tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
-	tx_desc->read.olinfo_status =
-			cpu_to_le32((len << IXGBE_ADVTXD_PAYLEN_SHIFT) |
+	u32 cmd_type = IXGBE_ADVTXD_DTYP_DATA |
+		       IXGBE_ADVTXD_DCMD_DEXT |
+		       IXGBE_ADVTXD_DCMD_IFCS |
+		       desc.len;
+
+	if (desc.flags & LIBETH_XDP_TX_LAST)
+		cmd_type |= IXGBE_TXD_CMD_EOP;
+
+	if (desc.flags & LIBETH_XDP_TX_FIRST) {
+		struct skb_shared_info *sinfo = sq->sqes[i].sinfo;
+		u16 full_len = desc.len + sinfo->xdp_frags_size;
+
+		tx_desc->read.olinfo_status =
+			cpu_to_le32((full_len << IXGBE_ADVTXD_PAYLEN_SHIFT) |
 				    IXGBE_ADVTXD_CC);
+	}
 
-	/* Avoid any potential race with cleanup */
-	smp_wmb();
+	tx_desc->read.buffer_addr = cpu_to_le64(desc.addr);
+	tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
+}
 
-	/* set next_to_watch value indicating a packet is present */
-	i++;
-	if (i == ring->count)
-		i = 0;
+LIBETH_XDP_DEFINE_START();
+LIBETH_XDP_DEFINE_FLUSH_TX(static ixgbevf_xdp_flush_tx, ixgbevf_prep_xdp_sq,
+			   ixgbevf_xdp_xmit_desc);
+LIBETH_XDP_DEFINE_END();
 
-	tx_buffer->next_to_watch = tx_desc;
-	ring->next_to_use = i;
+static void ixgbevf_xdp_set_rs(struct ixgbevf_ring *xdp_ring, u32 cached_ntu)
+{
+	u32 ltu = (xdp_ring->next_to_use ? : xdp_ring->count) - 1;
+	union ixgbe_adv_tx_desc *desc;
 
-	return IXGBEVF_XDP_TX;
+	desc = IXGBEVF_TX_DESC(xdp_ring, ltu);
+	xdp_ring->xdp_sqes[cached_ntu].rs_idx = ltu + 1;
+	desc->read.cmd_type_len |= cpu_to_le32(IXGBE_TXD_CMD);
 }
 
-static int ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
-			   struct ixgbevf_ring *rx_ring,
+static void ixgbevf_rx_finalize_xdp(struct libeth_xdp_tx_bulk *tx_bulk,
+				    bool xdp_xmit, u32 cached_ntu)
+{
+	struct ixgbevf_ring *xdp_ring = tx_bulk->xdpsq;
+
+	if (!xdp_xmit)
+		goto unlock;
+
+	if (tx_bulk->count)
+		ixgbevf_xdp_flush_tx(tx_bulk, LIBETH_XDP_TX_DROP);
+
+	ixgbevf_xdp_set_rs(xdp_ring, cached_ntu);
+
+	/* Finish descriptor writes before bumping tail */
+	wmb();
+	ixgbevf_write_tail(xdp_ring, xdp_ring->next_to_use);
+unlock:
+	rcu_read_unlock();
+}
+
+static int ixgbevf_run_xdp(struct libeth_xdp_tx_bulk *tx_bulk,
 			   struct libeth_xdp_buff *xdp)
 {
 	int result = IXGBEVF_XDP_PASS;
-	struct ixgbevf_ring *xdp_ring;
-	struct bpf_prog *xdp_prog;
+	const struct bpf_prog *xdp_prog;
 	u32 act;
 
-	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
-
+	xdp_prog = tx_bulk->prog;
 	if (!xdp_prog)
 		goto xdp_out;
 
@@ -756,17 +838,16 @@ static int ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 	case XDP_PASS:
 		break;
 	case XDP_TX:
-		xdp_ring = adapter->xdp_ring[rx_ring->queue_index];
-		result = ixgbevf_xmit_xdp_ring(xdp_ring, &xdp->base);
-		if (result == IXGBEVF_XDP_CONSUMED)
-			goto out_failure;
+		result = IXGBEVF_XDP_TX;
+		if (!libeth_xdp_tx_queue_bulk(tx_bulk, xdp,
+					      ixgbevf_xdp_flush_tx))
+			result = IXGBEVF_XDP_CONSUMED;
 		break;
 	default:
-		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, act);
+		bpf_warn_invalid_xdp_action(tx_bulk->dev, xdp_prog, act);
 		fallthrough;
 	case XDP_ABORTED:
-out_failure:
-		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
+		trace_xdp_exception(tx_bulk->dev, xdp_prog, act);
 		fallthrough; /* handle aborts by dropping packet */
 	case XDP_DROP:
 		result = IXGBEVF_XDP_CONSUMED;
@@ -784,11 +865,19 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	struct ixgbevf_adapter *adapter = q_vector->adapter;
 	u16 cleaned_count = ixgbevf_desc_unused(rx_ring);
+	LIBETH_XDP_ONSTACK_BULK(xdp_tx_bulk);
 	LIBETH_XDP_ONSTACK_BUFF(xdp);
+	u32 cached_ntu;
 	bool xdp_xmit = false;
 	int xdp_res = 0;
 
 	libeth_xdp_init_buff(xdp, &rx_ring->xdp_stash, &rx_ring->xdp_rxq);
+	libeth_xdp_tx_init_bulk(&xdp_tx_bulk, rx_ring->xdp_prog,
+				adapter->netdev, adapter->xdp_ring,
+				adapter->num_xdp_queues);
+	if (xdp_tx_bulk.prog)
+		cached_ntu =
+			((struct ixgbevf_ring *)xdp_tx_bulk.xdpsq)->next_to_use;
 
 	while (likely(total_rx_packets < budget)) {
 		union ixgbe_adv_rx_desc *rx_desc;
@@ -821,11 +910,12 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		if (ixgbevf_is_non_eop(rx_ring, rx_desc))
 			continue;
 
-		xdp_res = ixgbevf_run_xdp(adapter, rx_ring, xdp);
+		xdp_res = ixgbevf_run_xdp(&xdp_tx_bulk, xdp);
 		if (xdp_res) {
 			if (xdp_res == IXGBEVF_XDP_TX)
 				xdp_xmit = true;
 
+			xdp->data = NULL;
 			total_rx_packets++;
 			total_rx_bytes += size;
 			continue;
@@ -870,16 +960,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 	/* place incomplete frames back on ring for completion */
 	libeth_xdp_save_buff(&rx_ring->xdp_stash, xdp);
 
-	if (xdp_xmit) {
-		struct ixgbevf_ring *xdp_ring =
-			adapter->xdp_ring[rx_ring->queue_index];
-
-		/* Force memory writes to complete before letting h/w
-		 * know there are new descriptors to fetch.
-		 */
-		wmb();
-		ixgbevf_write_tail(xdp_ring, xdp_ring->next_to_use);
-	}
+	ixgbevf_rx_finalize_xdp(&xdp_tx_bulk, xdp_xmit, cached_ntu);
 
 	u64_stats_update_begin(&rx_ring->syncp);
 	rx_ring->stats.packets += total_rx_packets;
@@ -909,6 +990,8 @@ static int ixgbevf_poll(struct napi_struct *napi, int budget)
 	bool clean_complete = true;
 
 	ixgbevf_for_each_ring(ring, q_vector->tx) {
+		if (ring_is_xdp(ring))
+			continue;
 		if (!ixgbevf_clean_tx_irq(q_vector, ring, budget))
 			clean_complete = false;
 	}
@@ -1348,6 +1431,7 @@ static void ixgbevf_configure_tx_ring(struct ixgbevf_adapter *adapter,
 	/* reset ntu and ntc to place SW in sync with hardwdare */
 	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
+	ring->pending = 0;
 
 	/* In order to avoid issues WTHRESH + PTHRESH should always be equal
 	 * to or less than the number of on chip descriptors, which is
@@ -1360,8 +1444,12 @@ static void ixgbevf_configure_tx_ring(struct ixgbevf_adapter *adapter,
 		   32;           /* PTHRESH = 32 */
 
 	/* reinitialize tx_buffer_info */
-	memset(ring->tx_buffer_info, 0,
-	       sizeof(struct ixgbevf_tx_buffer) * ring->count);
+	if (!ring_is_xdp(ring))
+		memset(ring->tx_buffer_info, 0,
+		       sizeof(struct ixgbevf_tx_buffer) * ring->count);
+	else
+		memset(ring->xdp_sqes, 0,
+		       sizeof(struct libeth_sqe) * ring->count);
 
 	clear_bit(__IXGBEVF_HANG_CHECK_ARMED, &ring->state);
 	clear_bit(__IXGBEVF_TX_XDP_RING_PRIMED, &ring->state);
@@ -2016,10 +2104,7 @@ static void ixgbevf_clean_tx_ring(struct ixgbevf_ring *tx_ring)
 		union ixgbe_adv_tx_desc *eop_desc, *tx_desc;
 
 		/* Free all the Tx ring sk_buffs */
-		if (ring_is_xdp(tx_ring))
-			libeth_xdp_return_va(tx_buffer->data, false);
-		else
-			dev_kfree_skb_any(tx_buffer->skb);
+		dev_kfree_skb_any(tx_buffer->skb);
 
 		/* unmap skb header data */
 		dma_unmap_single(tx_ring->dev,
@@ -2088,7 +2173,7 @@ static void ixgbevf_clean_all_tx_rings(struct ixgbevf_adapter *adapter)
 	for (i = 0; i < adapter->num_tx_queues; i++)
 		ixgbevf_clean_tx_ring(adapter->tx_ring[i]);
 	for (i = 0; i < adapter->num_xdp_queues; i++)
-		ixgbevf_clean_tx_ring(adapter->xdp_ring[i]);
+		ixgbevf_clean_xdp_ring(adapter->xdp_ring[i]);
 }
 
 void ixgbevf_down(struct ixgbevf_adapter *adapter)
@@ -2834,8 +2919,6 @@ static void ixgbevf_check_hang_subtask(struct ixgbevf_adapter *adapter)
 	if (netif_carrier_ok(adapter->netdev)) {
 		for (i = 0; i < adapter->num_tx_queues; i++)
 			set_check_for_tx_hang(adapter->tx_ring[i]);
-		for (i = 0; i < adapter->num_xdp_queues; i++)
-			set_check_for_tx_hang(adapter->xdp_ring[i]);
 	}
 
 	/* get one bit for every active Tx/Rx interrupt vector */
@@ -2979,7 +3062,10 @@ static void ixgbevf_service_task(struct work_struct *work)
  **/
 void ixgbevf_free_tx_resources(struct ixgbevf_ring *tx_ring)
 {
-	ixgbevf_clean_tx_ring(tx_ring);
+	if (!ring_is_xdp(tx_ring))
+		ixgbevf_clean_tx_ring(tx_ring);
+	else
+		ixgbevf_clean_xdp_ring(tx_ring);
 
 	vfree(tx_ring->tx_buffer_info);
 	tx_ring->tx_buffer_info = NULL;
@@ -2988,7 +3074,7 @@ void ixgbevf_free_tx_resources(struct ixgbevf_ring *tx_ring)
 	if (!tx_ring->desc)
 		return;
 
-	dma_free_coherent(tx_ring->dev, tx_ring->size, tx_ring->desc,
+	dma_free_coherent(tx_ring->dev, tx_ring->dma_size, tx_ring->desc,
 			  tx_ring->dma);
 
 	tx_ring->desc = NULL;
@@ -3023,7 +3109,9 @@ int ixgbevf_setup_tx_resources(struct ixgbevf_ring *tx_ring)
 	struct ixgbevf_adapter *adapter = netdev_priv(tx_ring->netdev);
 	int size;
 
-	size = sizeof(struct ixgbevf_tx_buffer) * tx_ring->count;
+	size = (!ring_is_xdp(tx_ring) ? sizeof(struct ixgbevf_tx_buffer) :
+		sizeof(struct libeth_sqe)) * tx_ring->count;
+
 	tx_ring->tx_buffer_info = vmalloc(size);
 	if (!tx_ring->tx_buffer_info)
 		goto err;
@@ -3031,10 +3119,10 @@ int ixgbevf_setup_tx_resources(struct ixgbevf_ring *tx_ring)
 	u64_stats_init(&tx_ring->syncp);
 
 	/* round up to nearest 4K */
-	tx_ring->size = tx_ring->count * sizeof(union ixgbe_adv_tx_desc);
-	tx_ring->size = ALIGN(tx_ring->size, 4096);
+	tx_ring->dma_size = tx_ring->count * sizeof(union ixgbe_adv_tx_desc);
+	tx_ring->dma_size = ALIGN(tx_ring->dma_size, 4096);
 
-	tx_ring->desc = dma_alloc_coherent(tx_ring->dev, tx_ring->size,
+	tx_ring->desc = dma_alloc_coherent(tx_ring->dev, tx_ring->dma_size,
 					   &tx_ring->dma, GFP_KERNEL);
 	if (!tx_ring->desc)
 		goto err;
@@ -3123,10 +3211,10 @@ int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
 	u64_stats_init(&rx_ring->syncp);
 
 	/* Round up to nearest 4K */
-	rx_ring->size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
-	rx_ring->size = ALIGN(rx_ring->size, 4096);
+	rx_ring->dma_size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
+	rx_ring->dma_size = ALIGN(rx_ring->dma_size, 4096);
 
-	rx_ring->desc = dma_alloc_coherent(fq.pp->p.dev, rx_ring->size,
+	rx_ring->desc = dma_alloc_coherent(fq.pp->p.dev, rx_ring->dma_size,
 					   &rx_ring->dma, GFP_KERNEL);
 
 	if (!rx_ring->desc)
@@ -3200,7 +3288,7 @@ void ixgbevf_free_rx_resources(struct ixgbevf_ring *rx_ring)
 	xdp_rxq_info_detach_mem_model(&rx_ring->xdp_rxq);
 	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 
-	dma_free_coherent(fq.pp->p.dev, rx_ring->size, rx_ring->desc,
+	dma_free_coherent(fq.pp->p.dev, rx_ring->dma_size, rx_ring->desc,
 			  rx_ring->dma);
 	rx_ring->desc = NULL;
 
-- 
2.52.0


