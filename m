Return-Path: <netdev+bounces-54212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09BE8063F0
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 02:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37D01C211CF
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 01:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457EF8471;
	Wed,  6 Dec 2023 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PI2lc6YM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD34181
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 17:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701824504; x=1733360504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mnZASE63x34yCq6dzY8hV2ZsE25/tYf36JpzHzX+6rQ=;
  b=PI2lc6YMcLdZwrvZyyrAbSFo3roM/6NVmQdMtpKCIGcjWZ7ZZ5MUHyXu
   /wi5wk4wgDIkBc22jU3GtZB7x/CajKjUljWf4VU3+tVebnZhPm0M7YAuZ
   mu9OC8jveixpivVbnDm243FD6ZpeZ0DLMFDSBrPdWIXZPDQNN6/iVVYal
   6Uf9HIzKcILdldjDUxunebu0cWv4JqX11VrUSxIJI/xd+PW1LiQXeNhWA
   +4FqV1itbE/eHaZCqsxmtfRssYzm1FeigGKjkiTvNKwR5WkuJXgfz/N7c
   KLkPUb8TJPUK2e02faK1Z/YvTEQAc39/AULXxp1zDUX2nJV/YmvmYicC8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="12700338"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="12700338"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841655297"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="841655297"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:01:36 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	marcin.szycik@linux.intel.com
Subject: [PATCH iwl-next v2 15/15] idpf: refactor some missing field get/prep conversions
Date: Tue,  5 Dec 2023 17:01:14 -0800
Message-Id: <20231206010114.2259388-16-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of idpf correctly uses FIELD_GET and FIELD_PREP, but a couple spots
were missed so fix those.

Automated conversion with coccinelle script and manually fixed up,
including audits for opportunities to convert to {get,encode,replace}
bits functions.

Add conversions to le16_get/encode/replace_bits where appropriate. And
in one place fix up a cast from a u16 to a u16.

@prep2@
constant shift,mask;
type T;
expression a;
@@
-(((T)(a) << shift) & mask)
+FIELD_PREP(mask, a)

@prep@
constant shift,mask;
type T;
expression a;
@@
-((T)((a) << shift) & mask)
+FIELD_PREP(mask, a)

@get@
constant shift,mask;
type T;
expression a;
@@
-((T)((a) & mask) >> shift)
+FIELD_GET(mask, a)

and applied via:
spatch --sp-file field_prep.cocci --in-place --dir \
 drivers/net/ethernet/intel/

CC: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v2: merged this patch into larger series, modified after Olek's comments
to include bits encoding where changing lines for prep or get.
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  7 +--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 58 +++++++++----------
 2 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 81288a17da2a..447753495c53 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -328,10 +328,9 @@ static void idpf_tx_singleq_build_ctx_desc(struct idpf_queue *txq,
 
 	if (offload->tso_segs) {
 		qw1 |= IDPF_TX_CTX_DESC_TSO << IDPF_TXD_CTX_QW1_CMD_S;
-		qw1 |= ((u64)offload->tso_len << IDPF_TXD_CTX_QW1_TSO_LEN_S) &
-			IDPF_TXD_CTX_QW1_TSO_LEN_M;
-		qw1 |= ((u64)offload->mss << IDPF_TXD_CTX_QW1_MSS_S) &
-			IDPF_TXD_CTX_QW1_MSS_M;
+		qw1 |= FIELD_PREP(IDPF_TXD_CTX_QW1_TSO_LEN_M,
+				  offload->tso_len);
+		qw1 |= FIELD_PREP(IDPF_TXD_CTX_QW1_MSS_M, offload->mss);
 
 		u64_stats_update_begin(&txq->stats_sync);
 		u64_stats_inc(&txq->q_stats.tx.lso_pkts);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 1f728a9004d9..725f2477f979 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -505,9 +505,9 @@ static void idpf_rx_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
 
 	/* store the buffer ID and the SW maintained GEN bit to the refillq */
 	refillq->ring[nta] =
-		((buf_id << IDPF_RX_BI_BUFID_S) & IDPF_RX_BI_BUFID_M) |
-		(!!(test_bit(__IDPF_Q_GEN_CHK, refillq->flags)) <<
-		 IDPF_RX_BI_GEN_S);
+		FIELD_PREP(IDPF_RX_BI_BUFID_M, buf_id) |
+		FIELD_PREP(IDPF_RX_BI_GEN_M,
+			   test_bit(__IDPF_Q_GEN_CHK, refillq->flags));
 
 	if (unlikely(++nta == refillq->desc_count)) {
 		nta = 0;
@@ -1825,14 +1825,14 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 		u16 gen;
 
 		/* if the descriptor isn't done, no work yet to do */
-		gen = (le16_to_cpu(tx_desc->qid_comptype_gen) &
-		      IDPF_TXD_COMPLQ_GEN_M) >> IDPF_TXD_COMPLQ_GEN_S;
+		gen = le16_get_bits(tx_desc->qid_comptype_gen,
+				    IDPF_TXD_COMPLQ_GEN_M);
 		if (test_bit(__IDPF_Q_GEN_CHK, complq->flags) != gen)
 			break;
 
 		/* Find necessary info of TX queue to clean buffers */
-		rel_tx_qid = (le16_to_cpu(tx_desc->qid_comptype_gen) &
-			 IDPF_TXD_COMPLQ_QID_M) >> IDPF_TXD_COMPLQ_QID_S;
+		rel_tx_qid = le16_get_bits(tx_desc->qid_comptype_gen,
+					   IDPF_TXD_COMPLQ_QID_M);
 		if (rel_tx_qid >= complq->txq_grp->num_txq ||
 		    !complq->txq_grp->txqs[rel_tx_qid]) {
 			dev_err(&complq->vport->adapter->pdev->dev,
@@ -1842,9 +1842,8 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 		tx_q = complq->txq_grp->txqs[rel_tx_qid];
 
 		/* Determine completion type */
-		ctype = (le16_to_cpu(tx_desc->qid_comptype_gen) &
-			IDPF_TXD_COMPLQ_COMPL_TYPE_M) >>
-			IDPF_TXD_COMPLQ_COMPL_TYPE_S;
+		ctype = le16_get_bits(tx_desc->qid_comptype_gen,
+				      IDPF_TXD_COMPLQ_COMPL_TYPE_M);
 		switch (ctype) {
 		case IDPF_TXD_COMPLT_RE:
 			hw_head = le16_to_cpu(tx_desc->q_head_compl_tag.q_head);
@@ -1945,11 +1944,10 @@ void idpf_tx_splitq_build_ctb(union idpf_tx_flex_desc *desc,
 			      u16 td_cmd, u16 size)
 {
 	desc->q.qw1.cmd_dtype =
-		cpu_to_le16(params->dtype & IDPF_FLEX_TXD_QW1_DTYPE_M);
+		le16_encode_bits(params->dtype, IDPF_FLEX_TXD_QW1_DTYPE_M);
 	desc->q.qw1.cmd_dtype |=
-		cpu_to_le16((td_cmd << IDPF_FLEX_TXD_QW1_CMD_S) &
-			    IDPF_FLEX_TXD_QW1_CMD_M);
-	desc->q.qw1.buf_size = cpu_to_le16((u16)size);
+		le16_encode_bits(td_cmd, IDPF_FLEX_TXD_QW1_CMD_M);
+	desc->q.qw1.buf_size = cpu_to_le16(size);
 	desc->q.qw1.l2tags.l2tag1 = cpu_to_le16(params->td_tag);
 }
 
@@ -2843,8 +2841,9 @@ static void idpf_rx_splitq_extract_csum_bits(struct virtchnl2_rx_flex_desc_adv_n
 				qword1);
 	csum->ipv6exadd = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_IPV6EXADD_M,
 				    qword0);
-	csum->raw_csum_inv = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_RAW_CSUM_INV_M,
-				       le16_to_cpu(rx_desc->ptype_err_fflags0));
+	csum->raw_csum_inv =
+		le16_get_bits(rx_desc->ptype_err_fflags0,
+			      VIRTCHNL2_RX_FLEX_DESC_ADV_RAW_CSUM_INV_M);
 	csum->raw_csum = le16_to_cpu(rx_desc->misc.raw_cs);
 }
 
@@ -2938,8 +2937,8 @@ static int idpf_rx_process_skb_fields(struct idpf_queue *rxq,
 	struct idpf_rx_ptype_decoded decoded;
 	u16 rx_ptype;
 
-	rx_ptype = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_M,
-			     le16_to_cpu(rx_desc->ptype_err_fflags0));
+	rx_ptype = le16_get_bits(rx_desc->ptype_err_fflags0,
+				 VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_M);
 
 	decoded = rxq->vport->rx_ptype_lkup[rx_ptype];
 	/* If we don't know the ptype we can't do anything else with it. Just
@@ -2953,8 +2952,8 @@ static int idpf_rx_process_skb_fields(struct idpf_queue *rxq,
 
 	skb->protocol = eth_type_trans(skb, rxq->vport->netdev);
 
-	if (FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_RSC_M,
-		      le16_to_cpu(rx_desc->hdrlen_flags)))
+	if (le16_get_bits(rx_desc->hdrlen_flags,
+			  VIRTCHNL2_RX_FLEX_DESC_ADV_RSC_M))
 		return idpf_rx_rsc(rxq, skb, rx_desc, &decoded);
 
 	idpf_rx_splitq_extract_csum_bits(rx_desc, &csum_bits);
@@ -3148,8 +3147,8 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 		dma_rmb();
 
 		/* if the descriptor isn't done, no work yet to do */
-		gen_id = le16_to_cpu(rx_desc->pktlen_gen_bufq_id);
-		gen_id = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M, gen_id);
+		gen_id = le16_get_bits(rx_desc->pktlen_gen_bufq_id,
+				       VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M);
 
 		if (test_bit(__IDPF_Q_GEN_CHK, rxq->flags) != gen_id)
 			break;
@@ -3164,9 +3163,8 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 			continue;
 		}
 
-		pkt_len = le16_to_cpu(rx_desc->pktlen_gen_bufq_id);
-		pkt_len = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_LEN_PBUF_M,
-				    pkt_len);
+		pkt_len = le16_get_bits(rx_desc->pktlen_gen_bufq_id,
+					VIRTCHNL2_RX_FLEX_DESC_ADV_LEN_PBUF_M);
 
 		hbo = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_HBO_M,
 				rx_desc->status_err0_qw1);
@@ -3183,14 +3181,12 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 			goto bypass_hsplit;
 		}
 
-		hdr_len = le16_to_cpu(rx_desc->hdrlen_flags);
-		hdr_len = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_LEN_HDR_M,
-				    hdr_len);
+		hdr_len = le16_get_bits(rx_desc->hdrlen_flags,
+					VIRTCHNL2_RX_FLEX_DESC_ADV_LEN_HDR_M);
 
 bypass_hsplit:
-		bufq_id = le16_to_cpu(rx_desc->pktlen_gen_bufq_id);
-		bufq_id = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_BUFQ_ID_M,
-				    bufq_id);
+		bufq_id = le16_get_bits(rx_desc->pktlen_gen_bufq_id,
+					VIRTCHNL2_RX_FLEX_DESC_ADV_BUFQ_ID_M);
 
 		rxq_set = container_of(rxq, struct idpf_rxq_set, rxq);
 		if (!bufq_id)
-- 
2.39.3


