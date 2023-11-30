Return-Path: <netdev+bounces-52710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C87F37FFDC5
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687DDB20F1A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 21:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726295A10B;
	Thu, 30 Nov 2023 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nczQtCQM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E31170D
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 13:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701380723; x=1732916723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gbJyS1ni1fasYiNfICmx4OXt8W5RATHo/YDRnY0i+1A=;
  b=nczQtCQMDP2qTISRVw+qY8msNBGY4UBbB0Seu4O0BOYcht1dKqDqEVGs
   c6UmKVRLty6L+/sJPEQmEz6xcjkxU2w+qY/iWFc1ZRrV/HzK8cuDYqTTQ
   6Hkrm7zCYvaDUf+qzzhd8q8WS37OhzhHoWxTQ9Ylpe+A9Hy2ypQXhWvQq
   6aTCGefO4jcz6KfqgecW1V/s5JYVQmlRPEfUHrbc0RcChvTfl+l8iZz9t
   cwGj+RQjNEnpT8y4Qfq6D215adIFSsYBzlsd0zc6aWKJP4Bw9QOs1aakC
   rg0VzmL1/WgM1bQ/smVmh1h1c0MWMXf8OTtRH4m83yULgIZutTR9B7bjt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="373579455"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="373579455"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 13:45:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="745774201"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="745774201"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 13:45:23 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com
Subject: [PATCH iwl-next v1] idpf: refactor some missing field get/prep conversions
Date: Thu, 30 Nov 2023 13:45:11 -0800
Message-Id: <20231130214511.647586-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of idpf correctly uses FIELD_GET and FIELD_PREP, but a couple spots
were missed so fix those.

This conversion was automated via a coccinelle script as posted with the
previous series.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
This patch should be applied after the larger FIELD_PREP/FIELD_GET
conversion series for the Intel drivers.
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c    |  7 +++----
 drivers/net/ethernet/intel/idpf/idpf_txrx.c    | 18 ++++++++----------
 2 files changed, 11 insertions(+), 14 deletions(-)

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
index 1f728a9004d9..f3009d2a3c2e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -505,7 +505,7 @@ static void idpf_rx_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
 
 	/* store the buffer ID and the SW maintained GEN bit to the refillq */
 	refillq->ring[nta] =
-		((buf_id << IDPF_RX_BI_BUFID_S) & IDPF_RX_BI_BUFID_M) |
+		FIELD_PREP(IDPF_RX_BI_BUFID_M, buf_id) |
 		(!!(test_bit(__IDPF_Q_GEN_CHK, refillq->flags)) <<
 		 IDPF_RX_BI_GEN_S);
 
@@ -1825,14 +1825,14 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 		u16 gen;
 
 		/* if the descriptor isn't done, no work yet to do */
-		gen = (le16_to_cpu(tx_desc->qid_comptype_gen) &
-		      IDPF_TXD_COMPLQ_GEN_M) >> IDPF_TXD_COMPLQ_GEN_S;
+		gen = FIELD_GET(IDPF_TXD_COMPLQ_GEN_M,
+				le16_to_cpu(tx_desc->qid_comptype_gen));
 		if (test_bit(__IDPF_Q_GEN_CHK, complq->flags) != gen)
 			break;
 
 		/* Find necessary info of TX queue to clean buffers */
-		rel_tx_qid = (le16_to_cpu(tx_desc->qid_comptype_gen) &
-			 IDPF_TXD_COMPLQ_QID_M) >> IDPF_TXD_COMPLQ_QID_S;
+		rel_tx_qid = FIELD_GET(IDPF_TXD_COMPLQ_QID_M,
+				       le16_to_cpu(tx_desc->qid_comptype_gen));
 		if (rel_tx_qid >= complq->txq_grp->num_txq ||
 		    !complq->txq_grp->txqs[rel_tx_qid]) {
 			dev_err(&complq->vport->adapter->pdev->dev,
@@ -1842,9 +1842,8 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 		tx_q = complq->txq_grp->txqs[rel_tx_qid];
 
 		/* Determine completion type */
-		ctype = (le16_to_cpu(tx_desc->qid_comptype_gen) &
-			IDPF_TXD_COMPLQ_COMPL_TYPE_M) >>
-			IDPF_TXD_COMPLQ_COMPL_TYPE_S;
+		ctype = FIELD_GET(IDPF_TXD_COMPLQ_COMPL_TYPE_M,
+				  le16_to_cpu(tx_desc->qid_comptype_gen));
 		switch (ctype) {
 		case IDPF_TXD_COMPLT_RE:
 			hw_head = le16_to_cpu(tx_desc->q_head_compl_tag.q_head);
@@ -1947,8 +1946,7 @@ void idpf_tx_splitq_build_ctb(union idpf_tx_flex_desc *desc,
 	desc->q.qw1.cmd_dtype =
 		cpu_to_le16(params->dtype & IDPF_FLEX_TXD_QW1_DTYPE_M);
 	desc->q.qw1.cmd_dtype |=
-		cpu_to_le16((td_cmd << IDPF_FLEX_TXD_QW1_CMD_S) &
-			    IDPF_FLEX_TXD_QW1_CMD_M);
+		cpu_to_le16(FIELD_PREP(IDPF_FLEX_TXD_QW1_CMD_M, td_cmd));
 	desc->q.qw1.buf_size = cpu_to_le16((u16)size);
 	desc->q.qw1.l2tags.l2tag1 = cpu_to_le16(params->td_tag);
 }
-- 
2.39.3


