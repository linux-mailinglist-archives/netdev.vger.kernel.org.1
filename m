Return-Path: <netdev+bounces-170960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65867A4ADBF
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 21:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E50E165A66
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 20:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298791E0B66;
	Sat,  1 Mar 2025 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PY3aCFPC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD121C3BE9
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859916; cv=none; b=PmbRMOAItNfPDecGphVGUqb+Zb6lCAIXyzrguS/qoeLRN6EenwHHdd2uySTK2PxzZx+sJAGlw+T38QjbSNd5qLzEzawuoyC2pAZLummzSgMXoNxxSaXxtm5zaA4mgxPZoTAE92C9Qjvk69vY6ofOSiv+FvdaRDjDtHkH1blfPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859916; c=relaxed/simple;
	bh=CHprCrFSz1GiRHepl8Dq8IroyU5sN/LtO9aY6fu2A5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1kKnU8AE4F2wTCmztGd6oFl0jokFyboPn1g3sQQiA0rIDFycyDKKfH3LJ1zNB1bRbbBOBq/cYShyW8p+N/80M8MgU770+g4nx1HdmxRVMsA+57XtiLLBT6NrmwE+ZiV9KKbzwE+MOn6K3meDhpp/11Zx48eFpX2REIoCi7b74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PY3aCFPC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740859915; x=1772395915;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CHprCrFSz1GiRHepl8Dq8IroyU5sN/LtO9aY6fu2A5k=;
  b=PY3aCFPCFM15CS02uC2HYD9FBBHb/eVTcv8OSrNfZrboOAzYRDc0Z2LT
   Gy0NRyHd4/sfUIZ5RV6XjXTO1d3RlpqZp4tjQZW9iyaUSKxuizuuZ3Ayt
   tMDwf9/suJRJra4031I5kgXWJDKbQEunrfMbxNrBX28shUck1xIo7sFtg
   Rb4jsmTXZ+d3DdLcqJXWAc0qYc2wOdVFeq0xRzfwRzLTaeJL3MdOz3kMW
   SZzFyPRW/dzPy0lERwrNEASVD4EheijPja87KxrnC5yYCIT4Nq/BDVHbR
   uW1ebLOU0VFnqhiQDfug+FwUf7+MzBOHTCkV9hAvTmEVZYN8xSFY14zwb
   g==;
X-CSE-ConnectionGUID: 53CexmChS0SzU34UGNAx5Q==
X-CSE-MsgGUID: gGAdfVG8R62S1boBKtlj+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="64229824"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="64229824"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 12:11:54 -0800
X-CSE-ConnectionGUID: mqjQbMK5T6yO6U/VYAggmg==
X-CSE-MsgGUID: HyT4tf/4TlKs7FYALxjmhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="140861498"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 01 Mar 2025 12:11:52 -0800
Received: from ilmater.igk.intel.com (ilmater.igk.intel.com [10.123.220.50])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 21053125A0;
	Sat,  1 Mar 2025 20:11:51 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v2] idpf: assign extracted ptype to struct libeth_rqe_info field
Date: Sat,  1 Mar 2025 20:02:44 +0100
Message-ID: <20250301190423.613493-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assign the ptype extracted from qword to the ptype field of struct
libeth_rqe_info.
Remove the now excess ptype param of idpf_rx_singleq_extract_fields(),
idpf_rx_singleq_extract_base_fields() and
idpf_rx_singleq_extract_flex_fields().

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
v2: removed excess function parameter 'ptype' description in
idpf_rx_singleq_extract_fields() - reported by kernel bot. No code or
functional changes.

v1: initial patch
https://lore.kernel.org/netdev/20250227123837.547053-1-mateusz.polchlopek@intel.com/
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
2.48.1


