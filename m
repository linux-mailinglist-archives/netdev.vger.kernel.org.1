Return-Path: <netdev+bounces-186901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C09AA3CEF
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729A71BC4B71
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1D255F49;
	Tue, 29 Apr 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehJjIKtn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EAE255F2E
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970429; cv=none; b=fmECSOC4+NP8yIBLCeFJoU3PO/zgA1TPgmTovjw4Hhfhm1iL0hmPRLMjSRedANNobPHRcLrW3HSOqlwLJZITlXkGkQDEP9/D09yGqMbYFeaAigZfdM2DmK8L4+8uteuoVSn/pV3GW7gaKEXXwvtbCnivbsE/KbGGsMuOi9yuoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970429; c=relaxed/simple;
	bh=M5Jb2m9Koy4SZ7pUljBsm8wk5n7oWDpNEUXuY4zAz38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ex3dvWh7BnaJ/u+RpDpLGasrTcRlp5JanLhgnflTMOF/s1lmatUAB2bfNMiDpO5R4u0/S/1nhCnwjsqsiqw68G1hDvyObhUEAGSKHSc2LjnYo2LPyrhCxEFUzgG5Y7CupkYj8NDj3oXSz3jua9bnwXeRGIOCvACtgRMJthhnZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehJjIKtn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970428; x=1777506428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M5Jb2m9Koy4SZ7pUljBsm8wk5n7oWDpNEUXuY4zAz38=;
  b=ehJjIKtnk7Fmg5NDC8pHQgyukNhCO9ABah6Pem04CACT/1EqlNUVcdC/
   qm5EdYDtI0Xhk9NXkGKzG+hw97DL95AKE9HArBs0jSpflKkl9aI91EZsM
   wfhOMqC9A2CpQxWHurN4WVkX6GDkBhmB52nbmVx4lDAbvVpXG5rMvPHN0
   J7YZk0f7s90MW9WYyAxWE3Wd5Q6AcQ3HRQMd6hDRNUe9Dpn1f3Xumm2s8
   1r1VCGTsea740h1HoETR+IqXqi/6oUBASfrH+K7GOFTsaAWGsXlfP2VRN
   O9rcj+vzVD5Emp1NK9/a/A8Uf/Pz7FBsSw+tg2w0tn4DcIocnt93j/S1S
   w==;
X-CSE-ConnectionGUID: tdEFdFRvTbOn1x3jk1P7Iw==
X-CSE-MsgGUID: s+Pjx+3qS4O0BnHqGGQTKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990142"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990142"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:05 -0700
X-CSE-ConnectionGUID: 6Z2HnPP5SxiojK9gk8Y90g==
X-CSE-MsgGUID: p4iMfR31QCqTlkNtEMkcnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979653"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:47:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	anthony.l.nguyen@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 12/13] idpf: assign extracted ptype to struct libeth_rqe_info field
Date: Tue, 29 Apr 2025 16:46:47 -0700
Message-ID: <20250429234651.3982025-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
References: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Assign the ptype extracted from qword to the ptype field of struct
libeth_rqe_info.
Remove the now excess ptype param of idpf_rx_singleq_extract_fields(),
idpf_rx_singleq_extract_base_fields() and
idpf_rx_singleq_extract_flex_fields().

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index eae1b6f474e6..2e356dd10812 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -891,7 +891,6 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
  * idpf_rx_singleq_extract_base_fields - Extract fields from the Rx descriptor
  * @rx_desc: the descriptor to process
  * @fields: storage for extracted values
- * @ptype: pointer that will store packet type
  *
  * Decode the Rx descriptor and extract relevant information including the
  * size and Rx packet type.
@@ -901,21 +900,20 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
  */
 static void
 idpf_rx_singleq_extract_base_fields(const union virtchnl2_rx_desc *rx_desc,
-				    struct libeth_rqe_info *fields, u32 *ptype)
+				    struct libeth_rqe_info *fields)
 {
 	u64 qword;
 
 	qword = le64_to_cpu(rx_desc->base_wb.qword1.status_error_ptype_len);
 
 	fields->len = FIELD_GET(VIRTCHNL2_RX_BASE_DESC_QW1_LEN_PBUF_M, qword);
-	*ptype = FIELD_GET(VIRTCHNL2_RX_BASE_DESC_QW1_PTYPE_M, qword);
+	fields->ptype = FIELD_GET(VIRTCHNL2_RX_BASE_DESC_QW1_PTYPE_M, qword);
 }
 
 /**
  * idpf_rx_singleq_extract_flex_fields - Extract fields from the Rx descriptor
  * @rx_desc: the descriptor to process
  * @fields: storage for extracted values
- * @ptype: pointer that will store packet type
  *
  * Decode the Rx descriptor and extract relevant information including the
  * size and Rx packet type.
@@ -925,12 +923,12 @@ idpf_rx_singleq_extract_base_fields(const union virtchnl2_rx_desc *rx_desc,
  */
 static void
 idpf_rx_singleq_extract_flex_fields(const union virtchnl2_rx_desc *rx_desc,
-				    struct libeth_rqe_info *fields, u32 *ptype)
+				    struct libeth_rqe_info *fields)
 {
 	fields->len = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_PKT_LEN_M,
 				le16_to_cpu(rx_desc->flex_nic_wb.pkt_len));
-	*ptype = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M,
-			   le16_to_cpu(rx_desc->flex_nic_wb.ptype_flex_flags0));
+	fields->ptype = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M,
+				  le16_to_cpu(rx_desc->flex_nic_wb.ptype_flex_flags0));
 }
 
 /**
@@ -938,18 +936,17 @@ idpf_rx_singleq_extract_flex_fields(const union virtchnl2_rx_desc *rx_desc,
  * @rx_q: Rx descriptor queue
  * @rx_desc: the descriptor to process
  * @fields: storage for extracted values
- * @ptype: pointer that will store packet type
  *
  */
 static void
 idpf_rx_singleq_extract_fields(const struct idpf_rx_queue *rx_q,
 			       const union virtchnl2_rx_desc *rx_desc,
-			       struct libeth_rqe_info *fields, u32 *ptype)
+			       struct libeth_rqe_info *fields)
 {
 	if (rx_q->rxdids == VIRTCHNL2_RXDID_1_32B_BASE_M)
-		idpf_rx_singleq_extract_base_fields(rx_desc, fields, ptype);
+		idpf_rx_singleq_extract_base_fields(rx_desc, fields);
 	else
-		idpf_rx_singleq_extract_flex_fields(rx_desc, fields, ptype);
+		idpf_rx_singleq_extract_flex_fields(rx_desc, fields);
 }
 
 /**
@@ -972,7 +969,6 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 		struct libeth_rqe_info fields = { };
 		union virtchnl2_rx_desc *rx_desc;
 		struct idpf_rx_buf *rx_buf;
-		u32 ptype;
 
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
 		rx_desc = &rx_q->rx[ntc];
@@ -993,7 +989,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 		 */
 		dma_rmb();
 
-		idpf_rx_singleq_extract_fields(rx_q, rx_desc, &fields, &ptype);
+		idpf_rx_singleq_extract_fields(rx_q, rx_desc, &fields);
 
 		rx_buf = &rx_q->rx_buf[ntc];
 		if (!libeth_rx_sync_for_cpu(rx_buf, fields.len))
@@ -1037,7 +1033,8 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 		total_rx_bytes += skb->len;
 
 		/* protocol */
-		idpf_rx_singleq_process_skb_fields(rx_q, skb, rx_desc, ptype);
+		idpf_rx_singleq_process_skb_fields(rx_q, skb, rx_desc,
+						   fields.ptype);
 
 		/* send completed skb up the stack */
 		napi_gro_receive(rx_q->pp->p.napi, skb);
-- 
2.47.1


