Return-Path: <netdev+bounces-120542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C00959BA0
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC68B223A5
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB56193437;
	Wed, 21 Aug 2024 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggJNCvbw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF119259F
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242719; cv=none; b=rVgM3KENoZ5kqXTW5WgQpZ/u6ZR2O5ghMuGVZCltoEQXqAxCcwEt6/OEwdYeX6GrsunNJiz4Jaqatg96A746ZEEJWDFO+X+VU6gCuDV1jb78sYkFWI/PmyBdUiXx18QAdNQ0I4wW7FkYG8wfgPRIzXHYS53Y5r6HybYu4yWiSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242719; c=relaxed/simple;
	bh=Bplgbc5+AGzJQrtpXBfoXdKvweJ3GpUBwaRJDKQ3iBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJQzGy2nbJQKBShrbtHNxhn4qbmgXMC6R3aVObSNGsYyz5BWuZNBN1CpvWgJwHfvVR7jpt9BnSoSRKFLxzrF1WGIIrzxQ8mBO8e4wku2TxNt0wzGfYVQS2VdP8o4ao3pXShJlItme+v93E/UORo2wG4ve/wq/Wvk0y+C/JD2Ius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggJNCvbw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724242718; x=1755778718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bplgbc5+AGzJQrtpXBfoXdKvweJ3GpUBwaRJDKQ3iBQ=;
  b=ggJNCvbw4DpaQMKPjKvcteYuCgp1MRGVMdTJeZeR5yH41IFcf8EW2fmX
   RxgeEK1kjIqrpPjX1k18UDhMTxIwKstArrWEfaZnon+WjXwjlb5pQR6wg
   EL4NalP4m0Mrty89wmWX2ypt6uPtYdoh1SPNobvIKgEzxlm6jzwV6TaRI
   XLGHbIQ2sDozmlWca9StdQQ9Nwj2/yvI0o8EwPT5Wgk2BUNfktCLmOtL+
   aHfBGAHWZA0QUlBd461XOyxBcf2slSUHGhUuGohYaUU/gV06S//JyklGQ
   3tFwayG+HbGo9F+vqelkuGwBygsH8IWJ59VbVpCWW0q2a+PofnfHJcVqu
   w==;
X-CSE-ConnectionGUID: 0QDK73VNRWiEDVDDpL8YvQ==
X-CSE-MsgGUID: VpC0GqG3S4OyuTYvO9p5lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="34017128"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="34017128"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:18:22 -0700
X-CSE-ConnectionGUID: snm5S25KQ1OHeNw15qGAtA==
X-CSE-MsgGUID: b8VhIdGhSCyG+fZi88PYhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="60732507"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa006.fm.intel.com with ESMTP; 21 Aug 2024 05:18:19 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A3B5F28796;
	Wed, 21 Aug 2024 13:18:18 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	alexandr.lobakin@intel.com
Subject: [PATCH iwl-next v10 10/14] iavf: define Rx descriptors as qwords
Date: Wed, 21 Aug 2024 14:15:35 +0200
Message-Id: <20240821121539.374343-11-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240821121539.374343-1-wojciech.drewek@intel.com>
References: <20240821121539.374343-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

The union iavf_32byte_rx_desc consists of two unnamed structs defined
inside. One of them represents legacy 32 byte descriptor and second the
16 byte descriptor (extended to 32 byte). Each of them consists of
bunch of unions, structs and __le fields that represent specific fields
in descriptor.

This commit changes the representation of iavf_32byte_rx_desc union
to store four __le64 fields (qw0, qw1, qw2, qw3) that represent
quad-words. Those quad-words will be then accessed by calling
leXY_get_bits macros in upcoming commits.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h       |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_trace.h |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c  |  49 +++++----
 drivers/net/ethernet/intel/iavf/iavf_txrx.h  |   7 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h  | 102 +++++--------------
 5 files changed, 59 insertions(+), 107 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 871431bed64a..07b48034a22b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -82,7 +82,7 @@ struct iavf_vsi {
 
 #define MAXIMUM_ETHERNET_VLAN_SIZE (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
 
-#define IAVF_RX_DESC(R, i) (&(((union iavf_32byte_rx_desc *)((R)->desc))[i]))
+#define IAVF_RX_DESC(R, i) (&(((struct iavf_rx_desc *)((R)->desc))[i]))
 #define IAVF_TX_DESC(R, i) (&(((struct iavf_tx_desc *)((R)->desc))[i]))
 #define IAVF_TX_CTXTDESC(R, i) \
 	(&(((struct iavf_tx_context_desc *)((R)->desc))[i]))
diff --git a/drivers/net/ethernet/intel/iavf/iavf_trace.h b/drivers/net/ethernet/intel/iavf/iavf_trace.h
index 62212011c807..c5e4d1823886 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_trace.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_trace.h
@@ -112,7 +112,7 @@ DECLARE_EVENT_CLASS(
 	iavf_rx_template,
 
 	TP_PROTO(struct iavf_ring *ring,
-		 union iavf_32byte_rx_desc *desc,
+		 struct iavf_rx_desc *desc,
 		 struct sk_buff *skb),
 
 	TP_ARGS(ring, desc, skb),
@@ -140,7 +140,7 @@ DECLARE_EVENT_CLASS(
 DEFINE_EVENT(
 	iavf_rx_template, iavf_clean_rx_irq,
 	TP_PROTO(struct iavf_ring *ring,
-		 union iavf_32byte_rx_desc *desc,
+		 struct iavf_rx_desc *desc,
 		 struct sk_buff *skb),
 
 	TP_ARGS(ring, desc, skb));
@@ -148,7 +148,7 @@ DEFINE_EVENT(
 DEFINE_EVENT(
 	iavf_rx_template, iavf_clean_rx_irq_rx,
 	TP_PROTO(struct iavf_ring *ring,
-		 union iavf_32byte_rx_desc *desc,
+		 struct iavf_rx_desc *desc,
 		 struct sk_buff *skb),
 
 	TP_ARGS(ring, desc, skb));
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 26b424fd6718..1103395e415b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -766,7 +766,7 @@ int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
 	u64_stats_init(&rx_ring->syncp);
 
 	/* Round up to nearest 4K */
-	rx_ring->size = rx_ring->count * sizeof(union iavf_32byte_rx_desc);
+	rx_ring->size = rx_ring->count * sizeof(struct iavf_rx_desc);
 	rx_ring->size = ALIGN(rx_ring->size, 4096);
 	rx_ring->desc = dma_alloc_coherent(fq.pp->p.dev, rx_ring->size,
 					   &rx_ring->dma, GFP_KERNEL);
@@ -845,7 +845,7 @@ bool iavf_alloc_rx_buffers(struct iavf_ring *rx_ring, u16 cleaned_count)
 		.count		= rx_ring->count,
 	};
 	u16 ntu = rx_ring->next_to_use;
-	union iavf_rx_desc *rx_desc;
+	struct iavf_rx_desc *rx_desc;
 
 	/* do nothing if no valid netdev defined */
 	if (!rx_ring->netdev || !cleaned_count)
@@ -863,7 +863,7 @@ bool iavf_alloc_rx_buffers(struct iavf_ring *rx_ring, u16 cleaned_count)
 		/* Refresh the desc even if buffer_addrs didn't change
 		 * because each write-back erases this info.
 		 */
-		rx_desc->read.pkt_addr = cpu_to_le64(addr);
+		rx_desc->qw0 = cpu_to_le64(addr);
 
 		rx_desc++;
 		ntu++;
@@ -873,7 +873,7 @@ bool iavf_alloc_rx_buffers(struct iavf_ring *rx_ring, u16 cleaned_count)
 		}
 
 		/* clear the status bits for the next_to_use descriptor */
-		rx_desc->wb.qword1.status_error_len = 0;
+		rx_desc->qw1 = 0;
 
 		cleaned_count--;
 	} while (cleaned_count);
@@ -901,19 +901,18 @@ bool iavf_alloc_rx_buffers(struct iavf_ring *rx_ring, u16 cleaned_count)
  * @skb: skb currently being received and modified
  * @rx_desc: the receive descriptor
  **/
-static void iavf_rx_checksum(struct iavf_vsi *vsi,
-			     struct sk_buff *skb,
-			     union iavf_rx_desc *rx_desc)
+static void iavf_rx_checksum(struct iavf_vsi *vsi, struct sk_buff *skb,
+			     struct iavf_rx_desc *rx_desc)
 {
 	struct libeth_rx_pt decoded;
 	u32 rx_error, rx_status;
 	bool ipv4, ipv6;
-	u8 ptype;
 	u64 qword;
+	u8 ptype;
 
 	skb->ip_summed = CHECKSUM_NONE;
 
-	qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
+	qword = le64_to_cpu(rx_desc->qw1);
 	ptype = FIELD_GET(IAVF_RXD_QW1_PTYPE_MASK, qword);
 
 	decoded = libie_rx_pt_parse(ptype);
@@ -967,7 +966,7 @@ static void iavf_rx_checksum(struct iavf_vsi *vsi,
  * @rx_ptype: Rx packet type
  **/
 static void iavf_rx_hash(struct iavf_ring *ring,
-			 union iavf_rx_desc *rx_desc,
+			 struct iavf_rx_desc *rx_desc,
 			 struct sk_buff *skb,
 			 u8 rx_ptype)
 {
@@ -981,8 +980,8 @@ static void iavf_rx_hash(struct iavf_ring *ring,
 	if (!libeth_rx_pt_has_hash(ring->netdev, decoded))
 		return;
 
-	if ((rx_desc->wb.qword1.status_error_len & rss_mask) == rss_mask) {
-		hash = le32_to_cpu(rx_desc->wb.qword0.hi_dword.rss);
+	if ((rx_desc->qw1 & rss_mask) == rss_mask) {
+		hash = le64_get_bits(rx_desc->qw0, IAVF_RXD_LEGACY_RSS_M);
 		libeth_rx_pt_set_hash(skb, hash, decoded);
 	}
 }
@@ -1000,7 +999,7 @@ static void iavf_rx_hash(struct iavf_ring *ring,
  **/
 static void
 iavf_process_skb_fields(struct iavf_ring *rx_ring,
-			union iavf_rx_desc *rx_desc, struct sk_buff *skb,
+			struct iavf_rx_desc *rx_desc, struct sk_buff *skb,
 			u8 rx_ptype)
 {
 	iavf_rx_hash(rx_ring, rx_desc, skb, rx_ptype);
@@ -1101,7 +1100,7 @@ static struct sk_buff *iavf_build_skb(const struct libeth_fqe *rx_buffer,
  * that this is in fact a non-EOP buffer.
  **/
 static bool iavf_is_non_eop(struct iavf_ring *rx_ring,
-			    union iavf_rx_desc *rx_desc,
+			    struct iavf_rx_desc *rx_desc,
 			    struct sk_buff *skb)
 {
 	u32 ntc = rx_ring->next_to_clean + 1;
@@ -1143,7 +1142,8 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
 		struct libeth_fqe *rx_buffer;
-		union iavf_rx_desc *rx_desc;
+		struct iavf_rx_desc *rx_desc;
+		u16 ext_status = 0;
 		unsigned int size;
 		u16 vlan_tag = 0;
 		u8 rx_ptype;
@@ -1163,7 +1163,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		 * which is always zero because packet split isn't used, if the
 		 * hardware wrote DD then the length will be non-zero
 		 */
-		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
+		qword = le64_to_cpu(rx_desc->qw1);
 
 		/* This memory barrier is needed to keep us from reading
 		 * any other fields out of the rx_desc until we have
@@ -1219,7 +1219,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		/* probably a little skewed due to removing CRC */
 		total_rx_bytes += skb->len;
 
-		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
+		qword = le64_to_cpu(rx_desc->qw1);
 		rx_ptype = FIELD_GET(IAVF_RXD_QW1_PTYPE_MASK, qword);
 
 		/* populate checksum, VLAN, and protocol */
@@ -1227,11 +1227,16 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 
 		if (qword & BIT(IAVF_RX_DESC_STATUS_L2TAG1P_SHIFT) &&
 		    rx_ring->flags & IAVF_TXRX_FLAGS_VLAN_TAG_LOC_L2TAG1)
-			vlan_tag = le16_to_cpu(rx_desc->wb.qword0.lo_dword.l2tag1);
-		if (rx_desc->wb.qword2.ext_status &
-		    cpu_to_le16(BIT(IAVF_RX_DESC_EXT_STATUS_L2TAG2P_SHIFT)) &&
-		    rx_ring->flags & IAVF_RXR_FLAGS_VLAN_TAG_LOC_L2TAG2_2)
-			vlan_tag = le16_to_cpu(rx_desc->wb.qword2.l2tag2_2);
+			vlan_tag = le64_get_bits(rx_desc->qw0,
+						 IAVF_RXD_LEGACY_L2TAG1_M);
+
+		ext_status = le64_get_bits(rx_desc->qw2,
+					   IAVF_RXD_LEGACY_EXT_STATUS_M);
+
+		if ((ext_status & IAVF_RX_DESC_EXT_STATUS_L2TAG2P_M) &&
+		    (rx_ring->flags & IAVF_RXR_FLAGS_VLAN_TAG_LOC_L2TAG2_2))
+			vlan_tag = le64_get_bits(rx_desc->qw2,
+						 IAVF_RXD_LEGACY_L2TAG2_2_M);
 
 		iavf_trace(clean_rx_irq_rx, rx_ring, rx_desc, skb);
 		iavf_receive_skb(rx_ring, skb, vlan_tag);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index e8421994235b..59e7a58bc0f7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -80,8 +80,6 @@ enum iavf_dyn_idx_t {
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) | \
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP))
 
-#define iavf_rx_desc iavf_32byte_rx_desc
-
 /**
  * iavf_test_staterr - tests bits in Rx descriptor status and error fields
  * @rx_desc: pointer to receive descriptor (in le64 format)
@@ -92,11 +90,10 @@ enum iavf_dyn_idx_t {
  * The status_error_len doesn't need to be shifted because it begins
  * at offset zero.
  */
-static inline bool iavf_test_staterr(union iavf_rx_desc *rx_desc,
+static inline bool iavf_test_staterr(struct iavf_rx_desc *rx_desc,
 				     const u64 stat_err_bits)
 {
-	return !!(rx_desc->wb.qword1.status_error_len &
-		  cpu_to_le64(stat_err_bits));
+	return !!(rx_desc->qw1 & cpu_to_le64(stat_err_bits));
 }
 
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
index f6b09e57abce..c1a4506fbaba 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -178,82 +178,29 @@ struct iavf_hw {
 	char err_str[16];
 };
 
-/* RX Descriptors */
-union iavf_16byte_rx_desc {
-	struct {
-		__le64 pkt_addr; /* Packet buffer address */
-		__le64 hdr_addr; /* Header buffer address */
-	} read;
-	struct {
-		struct {
-			struct {
-				union {
-					__le16 mirroring_status;
-					__le16 fcoe_ctx_id;
-				} mirr_fcoe;
-				__le16 l2tag1;
-			} lo_dword;
-			union {
-				__le32 rss; /* RSS Hash */
-				__le32 fd_id; /* Flow director filter id */
-				__le32 fcoe_param; /* FCoE DDP Context id */
-			} hi_dword;
-		} qword0;
-		struct {
-			/* ext status/error/pktype/length */
-			__le64 status_error_len;
-		} qword1;
-	} wb;  /* writeback */
-};
-
-union iavf_32byte_rx_desc {
-	struct {
-		__le64  pkt_addr; /* Packet buffer address */
-		__le64  hdr_addr; /* Header buffer address */
-			/* bit 0 of hdr_buffer_addr is DD bit */
-		__le64  rsvd1;
-		__le64  rsvd2;
-	} read;
-	struct {
-		struct {
-			struct {
-				union {
-					__le16 mirroring_status;
-					__le16 fcoe_ctx_id;
-				} mirr_fcoe;
-				__le16 l2tag1;
-			} lo_dword;
-			union {
-				__le32 rss; /* RSS Hash */
-				__le32 fcoe_param; /* FCoE DDP Context id */
-				/* Flow director filter id in case of
-				 * Programming status desc WB
-				 */
-				__le32 fd_id;
-			} hi_dword;
-		} qword0;
-		struct {
-			/* status/error/pktype/length */
-			__le64 status_error_len;
-		} qword1;
-		struct {
-			__le16 ext_status; /* extended status */
-			__le16 rsvd;
-			__le16 l2tag2_1;
-			__le16 l2tag2_2;
-		} qword2;
-		struct {
-			union {
-				__le32 flex_bytes_lo;
-				__le32 pe_status;
-			} lo_dword;
-			union {
-				__le32 flex_bytes_hi;
-				__le32 fd_id;
-			} hi_dword;
-		} qword3;
-	} wb;  /* writeback */
-};
+/**
+ * struct iavf_rx_desc - Receive descriptor (both legacy and flexible)
+ * @qw0: quad word 0
+ * @qw1: quad word 1
+ * @qw2: quad word 2
+ * @qw3: quad word 3
+ */
+struct iavf_rx_desc {
+	aligned_le64 qw0;
+/* The hash signature (RSS). */
+#define IAVF_RXD_LEGACY_RSS_M			GENMASK_ULL(63, 32)
+/* Stripped L2 Tag from the receive packet. */
+#define IAVF_RXD_LEGACY_L2TAG1_M		GENMASK_ULL(33, 16)
+
+	aligned_le64 qw1;
+	aligned_le64 qw2;
+/* Extracted second word of the L2 Tag 2. */
+#define IAVF_RXD_LEGACY_L2TAG2_2_M		GENMASK_ULL(63, 48)
+/* Extended status bits. */
+#define IAVF_RXD_LEGACY_EXT_STATUS_M		GENMASK_ULL(11, 0)
+
+	aligned_le64 qw3;
+} __aligned(4 * sizeof(__le64));
 
 enum iavf_rx_desc_status_bits {
 	/* Note: These are predefined bit offsets */
@@ -347,6 +294,8 @@ enum iavf_rx_desc_ext_status_bits {
 	IAVF_RX_DESC_EXT_STATUS_PELONGB_SHIFT	= 11,
 };
 
+#define IAVF_RX_DESC_EXT_STATUS_L2TAG2P_M	BIT(IAVF_RX_DESC_EXT_STATUS_L2TAG2P_SHIFT)
+
 enum iavf_rx_desc_pe_status_bits {
 	/* Note: These are predefined bit offsets */
 	IAVF_RX_DESC_PE_STATUS_QPID_SHIFT	= 0, /* 18 BITS */
@@ -574,4 +523,5 @@ struct iavf_eth_stats {
 	u64 tx_discards;		/* tdpc */
 	u64 tx_errors;			/* tepc */
 };
+
 #endif /* _IAVF_TYPE_H_ */
-- 
2.40.1


