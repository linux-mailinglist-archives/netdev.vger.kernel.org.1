Return-Path: <netdev+bounces-253616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCUXChrud2kVmgEAu9opvQ
	(envelope-from <netdev+bounces-253616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:43:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 464678E01F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDB433007214
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288CC30AABC;
	Mon, 26 Jan 2026 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IX9O3dAu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B630AAD7
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467408; cv=none; b=dDIakCJkyXiRqssMvPnaJ84qaFJuMbbTELXqeED2uAHfg078lxi8qr2K7Yp64n246NBsmsXkBkoeAaSnE5US1LoDWnX+DFsMKeM+J3g72rOotfV7QQp0pID+uhtsPii8BfGEE1oCJSuxvJghSM9Tui3uyKlqq2QZRhruWuwTGk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467408; c=relaxed/simple;
	bh=q910RMZJmcFFwz/3GvXa/Rf0uIeafQ6yr3VNqIN4hUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6Jz2Z7R0qxLgm4bScNbSW4DK7Yde02of1PsbPD+ub0K0E8s846W/d8xc8Pe12YM1SY00heSfaMTFYzvIo5TtLgm3Lzj83yeWIQ9wn2JyE4786f3/xw9RJ92Lm8ZAal0AteSedAxv93K1l7B2ZH1BOAoCrA/0OuqNPmuzNc9pK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IX9O3dAu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769467404; x=1801003404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q910RMZJmcFFwz/3GvXa/Rf0uIeafQ6yr3VNqIN4hUI=;
  b=IX9O3dAust/EBrJTIZazSm3WAsCKUsGPMAj3hc4DY1AB9Sl8+pNaYJYe
   2wRXR6jTjHyPax09Oxi1WkSA6PpoSBdP9F+39Gycm8ytIpajWuxtnlqcm
   xltyt5GkFm56csW5IROe0OhoYwhxnGR/o7e1v/MSSTSyAbYS/l7w4U+Di
   BYHdc07xP2jIFU7Rx93+7bZGLZC59pYO3gg2dCxgvJEfwb0/RI5V2/nNm
   urmsn6pvxgJdsqdOZDWxe5Zgb0GjxB+EszmhT4scnGQ0RNHw+wLldA+Kq
   31maZB4n8vAjKwyy9R5iQCvYMqA5dJyH4OhKY1xUwhtktz6SipDm/rDbs
   A==;
X-CSE-ConnectionGUID: 3xjmzQ7ZQVu9LFW80l5k9g==
X-CSE-MsgGUID: HaO1LH4NTiqEaXPmeJjEzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70369409"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70369409"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 14:43:24 -0800
X-CSE-ConnectionGUID: T+HdY8C/ThWJ9KiJvFR6tg==
X-CSE-MsgGUID: SWr30mmoTfqggdUGiHso4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="230754298"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jan 2026 14:43:23 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 6/7] ice: reshuffle and group Rx and Tx queue fields by cachelines
Date: Mon, 26 Jan 2026 14:43:10 -0800
Message-ID: <20260126224313.3847849-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260126224313.3847849-1-anthony.l.nguyen@intel.com>
References: <20260126224313.3847849-1-anthony.l.nguyen@intel.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253616-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 464678E01F
X-Rspamd-Action: no action

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Place the fields in ice_{rx,tx}_ring used in the same pieces of
hotpath code closer to each other and use
__cacheline_group_{begin,end}_aligned() to isolate the read mostly,
read-write, and cold groups into separate cachelines similarly
to idpf.

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   1 -
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   1 -
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 122 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   3 -
 4 files changed, 70 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 2c007669c197..c6bc29cfb8e6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3388,7 +3388,6 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 				 */
 				rx_rings[i].next_to_use = 0;
 				rx_rings[i].next_to_clean = 0;
-				rx_rings[i].next_to_alloc = 0;
 				*vsi->rx_rings[i] = rx_rings[i];
 			}
 			kfree(rx_rings);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index eea83b26b094..396326a6d5be 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -574,7 +574,6 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
 		     PAGE_SIZE);
 	memset(rx_ring->desc, 0, size);
 
-	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index c51b1e60f717..b6547e1b7c42 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -267,34 +267,49 @@ struct ice_tstamp_ring {
 } ____cacheline_internodealigned_in_smp;
 
 struct ice_rx_ring {
-	/* CL1 - 1st cacheline starts here */
+	__cacheline_group_begin_aligned(read_mostly);
 	void *desc;			/* Descriptor ring memory */
 	struct page_pool *pp;
 	struct net_device *netdev;	/* netdev ring maps to */
-	struct ice_vsi *vsi;		/* Backreference to associated VSI */
 	struct ice_q_vector *q_vector;	/* Backreference to associated vector */
 	u8 __iomem *tail;
-	u16 q_index;			/* Queue number of ring */
-
-	u16 count;			/* Number of descriptors */
-	u16 reg_idx;			/* HW register index of the ring */
-	u16 next_to_alloc;
 
 	union {
 		struct libeth_fqe *rx_fqes;
 		struct xdp_buff **xdp_buf;
 	};
 
-	/* CL2 - 2nd cacheline starts here */
-	struct libeth_fqe *hdr_fqes;
+	u16 count;			/* Number of descriptors */
+	u8 ptp_rx;
+
+	u8 flags;
+#define ICE_RX_FLAGS_CRC_STRIP_DIS	BIT(2)
+#define ICE_RX_FLAGS_MULTIDEV		BIT(3)
+#define ICE_RX_FLAGS_RING_GCS		BIT(4)
+
+	u32 truesize;
+
 	struct page_pool *hdr_pp;
+	struct libeth_fqe *hdr_fqes;
+
+	struct bpf_prog *xdp_prog;
+	struct ice_tx_ring *xdp_ring;
+	struct xsk_buff_pool *xsk_pool;
+
+	/* stats structs */
+	struct ice_ring_stats *ring_stats;
+	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 
+	u32 hdr_truesize;
+
+	struct xdp_rxq_info xdp_rxq;
+	__cacheline_group_end_aligned(read_mostly);
+
+	__cacheline_group_begin_aligned(read_write);
 	union {
 		struct libeth_xdp_buff_stash xdp;
 		struct libeth_xdp_buff *xsk;
 	};
-
-	/* CL3 - 3rd cacheline starts here */
 	union {
 		struct ice_pkt_ctx pkt_ctx;
 		struct {
@@ -302,75 +317,78 @@ struct ice_rx_ring {
 			__be16 vlan_proto;
 		};
 	};
-	struct bpf_prog *xdp_prog;
 
 	/* used in interrupt processing */
 	u16 next_to_use;
 	u16 next_to_clean;
+	__cacheline_group_end_aligned(read_write);
 
-	u32 hdr_truesize;
-	u32 truesize;
-
-	/* stats structs */
-	struct ice_ring_stats *ring_stats;
-
+	__cacheline_group_begin_aligned(cold);
 	struct rcu_head rcu;		/* to avoid race on free */
-	/* CL4 - 4th cacheline starts here */
+	struct ice_vsi *vsi;		/* Backreference to associated VSI */
 	struct ice_channel *ch;
-	struct ice_tx_ring *xdp_ring;
-	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
-	struct xsk_buff_pool *xsk_pool;
-	u16 rx_hdr_len;
-	u16 rx_buf_len;
+
 	dma_addr_t dma;			/* physical address of ring */
+	u16 q_index;			/* Queue number of ring */
+	u16 reg_idx;			/* HW register index of the ring */
 	u8 dcb_tc;			/* Traffic class of ring */
-	u8 ptp_rx;
-#define ICE_RX_FLAGS_CRC_STRIP_DIS	BIT(2)
-#define ICE_RX_FLAGS_MULTIDEV		BIT(3)
-#define ICE_RX_FLAGS_RING_GCS		BIT(4)
-	u8 flags;
-	/* CL5 - 5th cacheline starts here */
-	struct xdp_rxq_info xdp_rxq;
+
+	u16 rx_hdr_len;
+	u16 rx_buf_len;
+	__cacheline_group_end_aligned(cold);
 } ____cacheline_internodealigned_in_smp;
 
 struct ice_tx_ring {
-	/* CL1 - 1st cacheline starts here */
-	struct ice_tx_ring *next;	/* pointer to next ring in q_vector */
+	__cacheline_group_begin_aligned(read_mostly);
 	void *desc;			/* Descriptor ring memory */
 	struct device *dev;		/* Used for DMA mapping */
 	u8 __iomem *tail;
 	struct ice_tx_buf *tx_buf;
+
 	struct ice_q_vector *q_vector;	/* Backreference to associated vector */
 	struct net_device *netdev;	/* netdev ring maps to */
 	struct ice_vsi *vsi;		/* Backreference to associated VSI */
-	/* CL2 - 2nd cacheline starts here */
-	dma_addr_t dma;			/* physical address of ring */
-	struct xsk_buff_pool *xsk_pool;
-	u16 next_to_use;
-	u16 next_to_clean;
-	u16 q_handle;			/* Queue handle per TC */
-	u16 reg_idx;			/* HW register index of the ring */
+
 	u16 count;			/* Number of descriptors */
 	u16 q_index;			/* Queue number of ring */
-	u16 xdp_tx_active;
+
+	u8 flags;
+#define ICE_TX_FLAGS_RING_XDP		BIT(0)
+#define ICE_TX_FLAGS_RING_VLAN_L2TAG1	BIT(1)
+#define ICE_TX_FLAGS_RING_VLAN_L2TAG2	BIT(2)
+#define ICE_TX_FLAGS_TXTIME		BIT(3)
+
+	struct xsk_buff_pool *xsk_pool;
+
 	/* stats structs */
 	struct ice_ring_stats *ring_stats;
-	/* CL3 - 3rd cacheline starts here */
+	struct ice_tx_ring *next;	/* pointer to next ring in q_vector */
+
+	struct ice_tstamp_ring *tstamp_ring;
+	struct ice_ptp_tx *tx_tstamps;
+	__cacheline_group_end_aligned(read_mostly);
+
+	__cacheline_group_begin_aligned(read_write);
+	u16 next_to_use;
+	u16 next_to_clean;
+
+	u16 xdp_tx_active;
+	spinlock_t tx_lock;
+	__cacheline_group_end_aligned(read_write);
+
+	__cacheline_group_begin_aligned(cold);
 	struct rcu_head rcu;		/* to avoid race on free */
 	DECLARE_BITMAP(xps_state, ICE_TX_NBITS);	/* XPS Config State */
 	struct ice_channel *ch;
-	struct ice_ptp_tx *tx_tstamps;
-	spinlock_t tx_lock;
-	u32 txq_teid;			/* Added Tx queue TEID */
-	/* CL4 - 4th cacheline starts here */
-	struct ice_tstamp_ring *tstamp_ring;
-#define ICE_TX_FLAGS_RING_XDP		BIT(0)
-#define ICE_TX_FLAGS_RING_VLAN_L2TAG1	BIT(1)
-#define ICE_TX_FLAGS_RING_VLAN_L2TAG2	BIT(2)
-#define ICE_TX_FLAGS_TXTIME		BIT(3)
-	u8 flags;
+
+	dma_addr_t dma;			/* physical address of ring */
+	u16 q_handle;			/* Queue handle per TC */
+	u16 reg_idx;			/* HW register index of the ring */
 	u8 dcb_tc;			/* Traffic class of ring */
+
 	u16 quanta_prof_id;
+	u32 txq_teid;			/* Added Tx queue TEID */
+	__cacheline_group_end_aligned(cold);
 } ____cacheline_internodealigned_in_smp;
 
 static inline bool ice_ring_ch_enabled(struct ice_tx_ring *ring)
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e68f3e5d35b4..e695a664e53d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -20,9 +20,6 @@ void ice_release_rx_desc(struct ice_rx_ring *rx_ring, u16 val)
 
 	rx_ring->next_to_use = val;
 
-	/* update next to alloc since we have filled the ring */
-	rx_ring->next_to_alloc = val;
-
 	/* QRX_TAIL will be updated with any tail value, but hardware ignores
 	 * the lower 3 bits. This makes it so we only bump tail on meaningful
 	 * boundaries. Also, this allows us to bump tail on intervals of 8 up to
-- 
2.47.1


