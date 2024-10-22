Return-Path: <netdev+bounces-137728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B39A98C0
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 07:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAECF1F233E0
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 05:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE97145A16;
	Tue, 22 Oct 2024 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOLmdd4Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410213E03E
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 05:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575680; cv=none; b=JCs9g6REgc2NzR4xLY06MyEk1OtsquKCOq7HwekMnOuImvIL81NWNQj6C2KVQXPglV/xOcTiAcmWuOGXTUByxu4xx/4EHXKcVDeHNGPk6JmntC4MIldKE41+bmHoCu579r1NHo5k1ubSRtlp+owX8cIQme4cDmbxulWGIVlBu2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575680; c=relaxed/simple;
	bh=4vdMm3FKDC5L6ogI8BJFDENN5huI+l2l4usYY1+2Mh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qlqSaV6SII3+kQXBGZBwjaVGEZVyU1iyev/cidlzjh3TGbnzsDX24Y6x6v/yHKEACyGl83K2tUu6mBT6BLThkSh5YXq3jyag+KESQt1SVfKqlYekC9hGHfkBRrabprlthb71d/cPWJxtTTbUyH8SDHYg2OgXyytRhLfZBN/CMWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOLmdd4Z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729575679; x=1761111679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4vdMm3FKDC5L6ogI8BJFDENN5huI+l2l4usYY1+2Mh4=;
  b=DOLmdd4Z6yEF/Ek2GAQnMeN0iVaJX7CFtu2Jyh0nhj1ondeQZUicXaXq
   aULyw99eLd6glBBUFNogUgFb0yhBn1S/kvqq3WnAOJ1vXyPevdLYzYtRG
   3PuR/+ftajomCZmzIuXm3tuXfP3lAi8XsQpr5X/GlpHXqPFcYRehT6tRJ
   kXVYo0lzUizwvgCShmLkgLdEHqF/foqgum3pLAONaSqIyxWlLYfmKEU3S
   tFKYaWDzG7X8MbRP57qFcTtd3dil1vMmQXTGY0m9xbu2isTd94OLBnhaU
   urbS0Tc4TNB4xwvNdMrYFnzmUt9VtAtnNs5z82HVXqUW2Cp9iLguv5j/J
   A==;
X-CSE-ConnectionGUID: jdS2TZaXQ8+96h+pXKbpxA==
X-CSE-MsgGUID: qaUwX5LcQZObab9w1Y8i6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="33015624"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="33015624"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 22:41:17 -0700
X-CSE-ConnectionGUID: GjX1V8ZhTr2Ys6odIgVMCg==
X-CSE-MsgGUID: 0F1WzERqT0WYS30U8sW8YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84558111"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 21 Oct 2024 22:41:15 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 625FD27BD1;
	Tue, 22 Oct 2024 06:41:14 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v12 09/14] libeth: move idpf_rx_csum_decoded and idpf_rx_extracted
Date: Tue, 22 Oct 2024 07:41:16 -0400
Message-Id: <20241022114121.61284-10-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241022114121.61284-1-mateusz.polchlopek@intel.com>
References: <20241022114121.61284-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Structs idpf_rx_csum_decoded and idpf_rx_extracted are used both in
idpf and iavf Intel drivers. Change the prefix from idpf_* to libeth_*
and move mentioned structs to libeth's rx.h header file.

Adjust usage in idpf driver.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 51 ++++++++++---------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 16 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 19 -------
 include/net/libeth/rx.h                       | 47 +++++++++++++++++
 4 files changed, 82 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index dfd7cf1d9aa0..eae1b6f474e6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -595,7 +595,7 @@ static bool idpf_rx_singleq_is_non_eop(const union virtchnl2_rx_desc *rx_desc)
  */
 static void idpf_rx_singleq_csum(struct idpf_rx_queue *rxq,
 				 struct sk_buff *skb,
-				 struct idpf_rx_csum_decoded csum_bits,
+				 struct libeth_rx_csum csum_bits,
 				 struct libeth_rx_pt decoded)
 {
 	bool ipv4, ipv6;
@@ -661,10 +661,10 @@ static void idpf_rx_singleq_csum(struct idpf_rx_queue *rxq,
  *
  * Return: parsed checksum status.
  **/
-static struct idpf_rx_csum_decoded
+static struct libeth_rx_csum
 idpf_rx_singleq_base_csum(const union virtchnl2_rx_desc *rx_desc)
 {
-	struct idpf_rx_csum_decoded csum_bits = { };
+	struct libeth_rx_csum csum_bits = { };
 	u32 rx_error, rx_status;
 	u64 qword;
 
@@ -696,10 +696,10 @@ idpf_rx_singleq_base_csum(const union virtchnl2_rx_desc *rx_desc)
  *
  * Return: parsed checksum status.
  **/
-static struct idpf_rx_csum_decoded
+static struct libeth_rx_csum
 idpf_rx_singleq_flex_csum(const union virtchnl2_rx_desc *rx_desc)
 {
-	struct idpf_rx_csum_decoded csum_bits = { };
+	struct libeth_rx_csum csum_bits = { };
 	u16 rx_status0, rx_status1;
 
 	rx_status0 = le16_to_cpu(rx_desc->flex_nic_wb.status_error0);
@@ -798,7 +798,7 @@ idpf_rx_singleq_process_skb_fields(struct idpf_rx_queue *rx_q,
 				   u16 ptype)
 {
 	struct libeth_rx_pt decoded = rx_q->rx_ptype_lkup[ptype];
-	struct idpf_rx_csum_decoded csum_bits;
+	struct libeth_rx_csum csum_bits;
 
 	/* modifies the skb - consumes the enet header */
 	skb->protocol = eth_type_trans(skb, rx_q->netdev);
@@ -891,6 +891,7 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
  * idpf_rx_singleq_extract_base_fields - Extract fields from the Rx descriptor
  * @rx_desc: the descriptor to process
  * @fields: storage for extracted values
+ * @ptype: pointer that will store packet type
  *
  * Decode the Rx descriptor and extract relevant information including the
  * size and Rx packet type.
@@ -900,20 +901,21 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
  */
 static void
 idpf_rx_singleq_extract_base_fields(const union virtchnl2_rx_desc *rx_desc,
-				    struct idpf_rx_extracted *fields)
+				    struct libeth_rqe_info *fields, u32 *ptype)
 {
 	u64 qword;
 
 	qword = le64_to_cpu(rx_desc->base_wb.qword1.status_error_ptype_len);
 
-	fields->size = FIELD_GET(VIRTCHNL2_RX_BASE_DESC_QW1_LEN_PBUF_M, qword);
-	fields->rx_ptype = FIELD_GET(VIRTCHNL2_RX_BASE_DESC_QW1_PTYPE_M, qword);
+	fields->len = FIELD_GET(VIRTCHNL2_RX_BASE_DESC_QW1_LEN_PBUF_M, qword);
+	*ptype = FIELD_GET(VIRTCHNL2_RX_BASE_DESC_QW1_PTYPE_M, qword);
 }
 
 /**
  * idpf_rx_singleq_extract_flex_fields - Extract fields from the Rx descriptor
  * @rx_desc: the descriptor to process
  * @fields: storage for extracted values
+ * @ptype: pointer that will store packet type
  *
  * Decode the Rx descriptor and extract relevant information including the
  * size and Rx packet type.
@@ -923,12 +925,12 @@ idpf_rx_singleq_extract_base_fields(const union virtchnl2_rx_desc *rx_desc,
  */
 static void
 idpf_rx_singleq_extract_flex_fields(const union virtchnl2_rx_desc *rx_desc,
-				    struct idpf_rx_extracted *fields)
+				    struct libeth_rqe_info *fields, u32 *ptype)
 {
-	fields->size = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_PKT_LEN_M,
-				 le16_to_cpu(rx_desc->flex_nic_wb.pkt_len));
-	fields->rx_ptype = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M,
-				     le16_to_cpu(rx_desc->flex_nic_wb.ptype_flex_flags0));
+	fields->len = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_PKT_LEN_M,
+				le16_to_cpu(rx_desc->flex_nic_wb.pkt_len));
+	*ptype = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M,
+			   le16_to_cpu(rx_desc->flex_nic_wb.ptype_flex_flags0));
 }
 
 /**
@@ -936,17 +938,18 @@ idpf_rx_singleq_extract_flex_fields(const union virtchnl2_rx_desc *rx_desc,
  * @rx_q: Rx descriptor queue
  * @rx_desc: the descriptor to process
  * @fields: storage for extracted values
+ * @ptype: pointer that will store packet type
  *
  */
 static void
 idpf_rx_singleq_extract_fields(const struct idpf_rx_queue *rx_q,
 			       const union virtchnl2_rx_desc *rx_desc,
-			       struct idpf_rx_extracted *fields)
+			       struct libeth_rqe_info *fields, u32 *ptype)
 {
 	if (rx_q->rxdids == VIRTCHNL2_RXDID_1_32B_BASE_M)
-		idpf_rx_singleq_extract_base_fields(rx_desc, fields);
+		idpf_rx_singleq_extract_base_fields(rx_desc, fields, ptype);
 	else
-		idpf_rx_singleq_extract_flex_fields(rx_desc, fields);
+		idpf_rx_singleq_extract_flex_fields(rx_desc, fields, ptype);
 }
 
 /**
@@ -966,9 +969,10 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 
 	/* Process Rx packets bounded by budget */
 	while (likely(total_rx_pkts < (unsigned int)budget)) {
-		struct idpf_rx_extracted fields = { };
+		struct libeth_rqe_info fields = { };
 		union virtchnl2_rx_desc *rx_desc;
 		struct idpf_rx_buf *rx_buf;
+		u32 ptype;
 
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
 		rx_desc = &rx_q->rx[ntc];
@@ -989,16 +993,16 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 		 */
 		dma_rmb();
 
-		idpf_rx_singleq_extract_fields(rx_q, rx_desc, &fields);
+		idpf_rx_singleq_extract_fields(rx_q, rx_desc, &fields, &ptype);
 
 		rx_buf = &rx_q->rx_buf[ntc];
-		if (!libeth_rx_sync_for_cpu(rx_buf, fields.size))
+		if (!libeth_rx_sync_for_cpu(rx_buf, fields.len))
 			goto skip_data;
 
 		if (skb)
-			idpf_rx_add_frag(rx_buf, skb, fields.size);
+			idpf_rx_add_frag(rx_buf, skb, fields.len);
 		else
-			skb = idpf_rx_build_skb(rx_buf, fields.size);
+			skb = idpf_rx_build_skb(rx_buf, fields.len);
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb)
@@ -1033,8 +1037,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 		total_rx_bytes += skb->len;
 
 		/* protocol */
-		idpf_rx_singleq_process_skb_fields(rx_q, skb,
-						   rx_desc, fields.rx_ptype);
+		idpf_rx_singleq_process_skb_fields(rx_q, skb, rx_desc, ptype);
 
 		/* send completed skb up the stack */
 		napi_gro_receive(rx_q->pp->p.napi, skb);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 60d15b3e6e2f..63a76e5b7f01 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2895,7 +2895,7 @@ idpf_rx_hash(const struct idpf_rx_queue *rxq, struct sk_buff *skb,
  * skb->protocol must be set before this function is called
  */
 static void idpf_rx_csum(struct idpf_rx_queue *rxq, struct sk_buff *skb,
-			 struct idpf_rx_csum_decoded csum_bits,
+			 struct libeth_rx_csum csum_bits,
 			 struct libeth_rx_pt decoded)
 {
 	bool ipv4, ipv6;
@@ -2923,7 +2923,7 @@ static void idpf_rx_csum(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	if (unlikely(csum_bits.l4e))
 		goto checksum_fail;
 
-	if (csum_bits.raw_csum_inv ||
+	if (!csum_bits.raw_csum_valid ||
 	    decoded.inner_prot == LIBETH_RX_PT_INNER_SCTP) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		return;
@@ -2946,10 +2946,10 @@ static void idpf_rx_csum(struct idpf_rx_queue *rxq, struct sk_buff *skb,
  *
  * Return: parsed checksum status.
  **/
-static struct idpf_rx_csum_decoded
+static struct libeth_rx_csum
 idpf_rx_splitq_extract_csum_bits(const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc)
 {
-	struct idpf_rx_csum_decoded csum = { };
+	struct libeth_rx_csum csum = { };
 	u8 qword0, qword1;
 
 	qword0 = rx_desc->status_err0_qw0;
@@ -2965,9 +2965,9 @@ idpf_rx_splitq_extract_csum_bits(const struct virtchnl2_rx_flex_desc_adv_nic_3 *
 			       qword1);
 	csum.ipv6exadd = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_IPV6EXADD_M,
 				   qword0);
-	csum.raw_csum_inv =
-		le16_get_bits(rx_desc->ptype_err_fflags0,
-			      VIRTCHNL2_RX_FLEX_DESC_ADV_RAW_CSUM_INV_M);
+	csum.raw_csum_valid =
+		!le16_get_bits(rx_desc->ptype_err_fflags0,
+			       VIRTCHNL2_RX_FLEX_DESC_ADV_RAW_CSUM_INV_M);
 	csum.raw_csum = le16_to_cpu(rx_desc->misc.raw_cs);
 
 	return csum;
@@ -3060,7 +3060,7 @@ static int
 idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 			   const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc)
 {
-	struct idpf_rx_csum_decoded csum_bits;
+	struct libeth_rx_csum csum_bits;
 	struct libeth_rx_pt decoded;
 	u16 rx_ptype;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 9c1fe84108ed..b59aa7d8de2c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -213,25 +213,6 @@ enum idpf_tx_ctx_desc_eipt_offload {
 	IDPF_TX_CTX_EXT_IP_IPV4         = 0x3
 };
 
-/* Checksum offload bits decoded from the receive descriptor. */
-struct idpf_rx_csum_decoded {
-	u32 l3l4p : 1;
-	u32 ipe : 1;
-	u32 eipe : 1;
-	u32 eudpe : 1;
-	u32 ipv6exadd : 1;
-	u32 l4e : 1;
-	u32 pprs : 1;
-	u32 nat : 1;
-	u32 raw_csum_inv : 1;
-	u32 raw_csum : 16;
-};
-
-struct idpf_rx_extracted {
-	unsigned int size;
-	u16 rx_ptype;
-};
-
 #define IDPF_TX_COMPLQ_CLEAN_BUDGET	256
 #define IDPF_TX_MIN_PKT_LEN		17
 #define IDPF_TX_DESCS_FOR_SKB_DATA_PTR	1
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 43574bd6612f..ab05024be518 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -198,6 +198,53 @@ struct libeth_rx_pt {
 	enum xdp_rss_hash_type			hash_type:16;
 };
 
+/**
+ * struct libeth_rx_csum - checksum offload bits decoded from the Rx descriptor
+ * @l3l4p: detectable L3 and L4 integrity check is processed by the hardware
+ * @ipe: IP checksum error
+ * @eipe: external (outermost) IP header (only for tunels)
+ * @eudpe: external (outermost) UDP checksum error (only for tunels)
+ * @ipv6exadd: IPv6 header with extension headers
+ * @l4e: L4 integrity error
+ * @pprs: set for packets that skip checksum calculation in the HW pre parser
+ * @nat: the packet is a UDP tunneled packet
+ * @raw_csum_valid: set if raw checksum is valid
+ * @pad: padding to naturally align raw_csum field
+ * @raw_csum: raw checksum
+ */
+struct libeth_rx_csum {
+	u32					l3l4p:1;
+	u32					ipe:1;
+	u32					eipe:1;
+	u32					eudpe:1;
+	u32					ipv6exadd:1;
+	u32					l4e:1;
+	u32					pprs:1;
+	u32					nat:1;
+
+	u32					raw_csum_valid:1;
+	u32					pad:7;
+	u32					raw_csum:16;
+};
+
+/**
+ * struct libeth_rqe_info - receive queue element info
+ * @len: packet length
+ * @ptype: packet type based on types programmed into the device
+ * @eop: whether it's the last fragment of the packet
+ * @rxe: MAC errors: CRC, Alignment, Oversize, Undersizes, Length error
+ * @vlan: C-VLAN or S-VLAN tag depending on the VLAN offload configuration
+ */
+struct libeth_rqe_info {
+	u32					len;
+
+	u32					ptype:14;
+	u32					eop:1;
+	u32					rxe:1;
+
+	u32					vlan:16;
+};
+
 void libeth_rx_pt_gen_hash_type(struct libeth_rx_pt *pt);
 
 /**
-- 
2.38.1


