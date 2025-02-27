Return-Path: <netdev+bounces-170251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD33A47FE4
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1F418937ED
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5307D236427;
	Thu, 27 Feb 2025 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IToPc+J5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B5236424
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663969; cv=none; b=m+IVms4ceVU7/PW0yFtxYhmUP5gNjqI+FYrAlYVXbSGvkj6IFyW/oxbPDwK3gerHB816LKYlg3DTFcMdzGcAWVeureXy4p+grqnx8ByGjXKLGyxq4o3W/9kScPqnp1L8BEdTfYDyiK2RnUjVlZrD77c2f9as8IIYJ32FF4tMgl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663969; c=relaxed/simple;
	bh=UM901/g7+N9FJl/7G9axof2tsLzHggB3NqpgUO3p1Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEjn1wkF8g56DhIF5awdarKyph+pJHOUa9N8j3d+518gVY/w8YnXBZWxoQ4taBBwmU1M+8OJ3wbSZ8aA2uvTaCtTsGmwPHu2Krix4MXcLfB8mx3+BDL2UX9Re4BqlKA45AVIIKPLcpIUE+69ySkTR+w7i4fg90ba4LPARjpmNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IToPc+J5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740663967; x=1772199967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UM901/g7+N9FJl/7G9axof2tsLzHggB3NqpgUO3p1Nw=;
  b=IToPc+J5RXkQu17ajQ2d2rZyUPrSxguIo9wyb60XhSwgOBvklElro7Xa
   2GsCfj0GnGJLJ0ce6+Oc8itCSoSDCt/ymS70AkV3sfS7UjdFbFhBZGepC
   9Kv55delwZPXfa6oo7OPi56Lx2C4PZE1JNpGDlc5YLIUzfip+gc2+Wrfg
   7Rxtl0N/9+Q45KkEAel1rP9M6nqKbvMNkjuXLg/CrtPR7lxysfFoH+hb/
   xDjgbdxTJSsPYnMmZeLkEmga4Nq8h65cMhNjX3LqcZq0sTmIpNDlK7fmq
   O4LPHwrJztspgK62LqRi0q6GX079tp0R6pxEsWQ0rcRc+iI0lfnL7vXeW
   w==;
X-CSE-ConnectionGUID: BJkYyCm0ReKc9n93nL0jdQ==
X-CSE-MsgGUID: w90kEdSNQCyUb4XjB5xFdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="66922751"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="66922751"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 05:46:06 -0800
X-CSE-ConnectionGUID: csjCOY9ARQKW7K18UOYwiA==
X-CSE-MsgGUID: cvfqdnLNSCqMkV95T4zn0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="122039809"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 27 Feb 2025 05:46:04 -0800
Received: from ilmater.igk.intel.com (ilmater.igk.intel.com [10.123.220.50])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AC32F12692;
	Thu, 27 Feb 2025 13:46:02 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v1] idpf: assign extracted ptype to struct libeth_rqe_info field
Date: Thu, 27 Feb 2025 13:38:30 +0100
Message-ID: <20250227123837.547053-1-mateusz.polchlopek@intel.com>
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
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index eae1b6f474e6..72436a582158 100644
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
@@ -944,12 +942,12 @@ idpf_rx_singleq_extract_flex_fields(const union virtchnl2_rx_desc *rx_desc,
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
@@ -972,7 +970,6 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 		struct libeth_rqe_info fields = { };
 		union virtchnl2_rx_desc *rx_desc;
 		struct idpf_rx_buf *rx_buf;
-		u32 ptype;
 
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
 		rx_desc = &rx_q->rx[ntc];
@@ -993,7 +990,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 		 */
 		dma_rmb();
 
-		idpf_rx_singleq_extract_fields(rx_q, rx_desc, &fields, &ptype);
+		idpf_rx_singleq_extract_fields(rx_q, rx_desc, &fields);
 
 		rx_buf = &rx_q->rx_buf[ntc];
 		if (!libeth_rx_sync_for_cpu(rx_buf, fields.len))
@@ -1037,7 +1034,8 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 		total_rx_bytes += skb->len;
 
 		/* protocol */
-		idpf_rx_singleq_process_skb_fields(rx_q, skb, rx_desc, ptype);
+		idpf_rx_singleq_process_skb_fields(rx_q, skb, rx_desc,
+						   fields.ptype);
 
 		/* send completed skb up the stack */
 		napi_gro_receive(rx_q->pp->p.napi, skb);
-- 
2.48.1


