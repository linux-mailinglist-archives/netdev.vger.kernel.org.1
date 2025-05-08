Return-Path: <netdev+bounces-189089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2D8AB0590
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 23:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9042B9E586A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 21:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFAD224893;
	Thu,  8 May 2025 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0wjLHwL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B41224222
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741054; cv=none; b=XhAWr+IH3PLV3jBNK0zLgYu0biYunrB+czNkEavLzoy24m643FJklKZ5ACLsKWlxSLShXn1zUJ0g9mBSk1MzenvKonEQRhEFkNwbBqMy5urhQQOEv7wjIVU2ypvt35j2OM7+zHYaKZVmhKHCCpmD8wGyTW1fC5yvtDfaGSJzSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741054; c=relaxed/simple;
	bh=00Ov8hBbTZa2c65/Zl5O8qqe1vzfppQVRNVXJ2Qn9f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5BJxaHUxa0RHaIYLjqILxjwf1g53KD2vteM6P/INtLalyfXAEHzCiqH571NLv8TGCaJ9wl/9+zYjvvEnMBt2iEhd0Z4Wp/z/8whlDRG43a5uloQs6RIoF72vpbKEIS0HlLcVav6K4uAHoh50nZzYLguOSikgJR/9ICq1jVv6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0wjLHwL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746741052; x=1778277052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=00Ov8hBbTZa2c65/Zl5O8qqe1vzfppQVRNVXJ2Qn9f0=;
  b=W0wjLHwLHZ4QpLadtzOyFrJbkqWxm4nob2FMuHTnU7/V03epUHaZ/4T8
   VLhA1ziJALG0Nk08gg9UJGEpLg+k5paC2KczO9Dv6T/qXg6qO4b3luOFy
   ig4hwkdTw29VYZ09dYUiXOt4rtvONDY8wj5wT/qmXHPcdrhSV7ccq+ynj
   iB4JdhezpXSYSBWpxWk+2Q+DogMJ3YAWmhHie+c04FQvqYAiGlujoARV4
   uAK3bA3Tf7NSUp4X1R3hFtsBCjn6IiIH4op+nMnz2QWxx4GAqWIO0OwGg
   3AOIqeLxCMMq1AoaYhMMzkNH1lseWGwuI3Z9euvLimIXziFylv3DISrBw
   w==;
X-CSE-ConnectionGUID: Ths4uzosQIejPc0vGPViww==
X-CSE-MsgGUID: 4N2E+dGbRtG88AJ90I1+yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="47808317"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="47808317"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 14:50:49 -0700
X-CSE-ConnectionGUID: M/EqzSGOQcOnt6q8dWoYTQ==
X-CSE-MsgGUID: 9PFfukReQQqG/wqrSrhhzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="141534271"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.55])
  by orviesa005.jf.intel.com with ESMTP; 08 May 2025 14:50:49 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	milena.olech@intel.com,
	anton.nadezhdin@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH iwl-next v4 2/9] idpf: use existing queue chunk info instead of preparing it
Date: Thu,  8 May 2025 14:50:06 -0700
Message-ID: <20250508215013.32668-3-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508215013.32668-1-pavan.kumar.linga@intel.com>
References: <20250508215013.32668-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue chunk info received from the device control plane is stored in the
persistent data section. Necessary info from these chunks is parsed and
stored in the queue structure. While sending the enable/disable queues
virtchnl message, queue chunk info is prepared using the stored queue
info. Instead of that, use the stored queue chunks directly which has
info about all the queues that needs to be enabled/disabled.

Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   6 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 188 +++++-------------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   6 +-
 3 files changed, 52 insertions(+), 148 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a11097e98517..bc342e79addd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -849,7 +849,7 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 	chunks = &vport->adapter->vport_config[vport->idx]->qid_reg_info;
 
 	idpf_send_disable_vport_msg(vport);
-	idpf_send_disable_queues_msg(vport);
+	idpf_send_disable_queues_msg(vport, chunks);
 	idpf_send_map_unmap_queue_vector_msg(vport, false);
 	/* Normally we ask for queues in create_vport, but if the number of
 	 * initially requested queues have changed, for example via ethtool
@@ -1383,7 +1383,7 @@ static int idpf_vport_open(struct idpf_vport *vport)
 		goto intr_deinit;
 	}
 
-	err = idpf_send_enable_queues_msg(vport);
+	err = idpf_send_enable_queues_msg(vport, chunks);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to enable queues for vport %u: %d\n",
 			vport->vport_id, err);
@@ -1424,7 +1424,7 @@ static int idpf_vport_open(struct idpf_vport *vport)
 disable_vport:
 	idpf_send_disable_vport_msg(vport);
 disable_queues:
-	idpf_send_disable_queues_msg(vport);
+	idpf_send_disable_queues_msg(vport, chunks);
 unmap_queue_vectors:
 	idpf_send_map_unmap_queue_vector_msg(vport, false);
 intr_deinit:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 91fc908e5e20..732d99f66842 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1007,6 +1007,24 @@ static void idpf_init_avail_queues(struct idpf_adapter *adapter)
 	avail_queues->avail_complq = le16_to_cpu(caps->max_tx_complq);
 }
 
+/**
+ * idpf_convert_reg_to_queue_chunks - copy queue chunk information to the right
+ * structure
+ * @dchunks: destination chunks to store data to
+ * @schunks: source chunks to copy data from
+ * @num_chunks: number of chunks to copy
+ */
+static void idpf_convert_reg_to_queue_chunks(struct virtchnl2_queue_chunk *dchunks,
+					     struct idpf_queue_id_reg_chunk *schunks,
+					     u16 num_chunks)
+{
+	for (u16 i = 0; i < num_chunks; i++) {
+		dchunks[i].type = cpu_to_le32(schunks[i].type);
+		dchunks[i].start_queue_id = cpu_to_le32(schunks[i].start_queue_id);
+		dchunks[i].num_queues = cpu_to_le32(schunks[i].num_queues);
+	}
+}
+
 /**
  * idpf_vport_init_queue_reg_chunks - initialize queue register chunks
  * @vport_config: persistent vport structure to store the queue register info
@@ -1734,116 +1752,20 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
  * idpf_send_ena_dis_queues_msg - Send virtchnl enable or disable
  * queues message
  * @vport: virtual port data structure
+ * @chunks: queue register info
  * @ena: if true enable, false disable
  *
  * Send enable or disable queues virtchnl message. Returns 0 on success,
  * negative on failure.
  */
-static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool ena)
+static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport,
+					struct idpf_queue_id_reg_info *chunks,
+					bool ena)
 {
 	struct virtchnl2_del_ena_dis_queues *eq __free(kfree) = NULL;
-	struct virtchnl2_queue_chunk *qc __free(kfree) = NULL;
-	u32 num_msgs, num_chunks, num_txq, num_rxq, num_q;
 	struct idpf_vc_xn_params xn_params = {};
-	struct virtchnl2_queue_chunks *qcs;
-	u32 config_sz, chunk_sz, buf_sz;
+	u32 num_chunks, buf_sz;
 	ssize_t reply_sz;
-	int i, j, k = 0;
-
-	num_txq = vport->num_txq + vport->num_complq;
-	num_rxq = vport->num_rxq + vport->num_bufq;
-	num_q = num_txq + num_rxq;
-	buf_sz = sizeof(struct virtchnl2_queue_chunk) * num_q;
-	qc = kzalloc(buf_sz, GFP_KERNEL);
-	if (!qc)
-		return -ENOMEM;
-
-	for (i = 0; i < vport->num_txq_grp; i++) {
-		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
-
-		for (j = 0; j < tx_qgrp->num_txq; j++, k++) {
-			qc[k].type = cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_TX);
-			qc[k].start_queue_id = cpu_to_le32(tx_qgrp->txqs[j]->q_id);
-			qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
-		}
-	}
-	if (vport->num_txq != k)
-		return -EINVAL;
-
-	if (!idpf_is_queue_model_split(vport->txq_model))
-		goto setup_rx;
-
-	for (i = 0; i < vport->num_txq_grp; i++, k++) {
-		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
-
-		qc[k].type = cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION);
-		qc[k].start_queue_id = cpu_to_le32(tx_qgrp->complq->q_id);
-		qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
-	}
-	if (vport->num_complq != (k - vport->num_txq))
-		return -EINVAL;
-
-setup_rx:
-	for (i = 0; i < vport->num_rxq_grp; i++) {
-		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
-
-		if (idpf_is_queue_model_split(vport->rxq_model))
-			num_rxq = rx_qgrp->splitq.num_rxq_sets;
-		else
-			num_rxq = rx_qgrp->singleq.num_rxq;
-
-		for (j = 0; j < num_rxq; j++, k++) {
-			if (idpf_is_queue_model_split(vport->rxq_model)) {
-				qc[k].start_queue_id =
-				cpu_to_le32(rx_qgrp->splitq.rxq_sets[j]->rxq.q_id);
-				qc[k].type =
-				cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_RX);
-			} else {
-				qc[k].start_queue_id =
-				cpu_to_le32(rx_qgrp->singleq.rxqs[j]->q_id);
-				qc[k].type =
-				cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_RX);
-			}
-			qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
-		}
-	}
-	if (vport->num_rxq != k - (vport->num_txq + vport->num_complq))
-		return -EINVAL;
-
-	if (!idpf_is_queue_model_split(vport->rxq_model))
-		goto send_msg;
-
-	for (i = 0; i < vport->num_rxq_grp; i++) {
-		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
-
-		for (j = 0; j < vport->num_bufqs_per_qgrp; j++, k++) {
-			const struct idpf_buf_queue *q;
-
-			q = &rx_qgrp->splitq.bufq_sets[j].bufq;
-			qc[k].type =
-				cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_RX_BUFFER);
-			qc[k].start_queue_id = cpu_to_le32(q->q_id);
-			qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
-		}
-	}
-	if (vport->num_bufq != k - (vport->num_txq +
-				    vport->num_complq +
-				    vport->num_rxq))
-		return -EINVAL;
-
-send_msg:
-	/* Chunk up the queue info into multiple messages */
-	config_sz = sizeof(struct virtchnl2_del_ena_dis_queues);
-	chunk_sz = sizeof(struct virtchnl2_queue_chunk);
-
-	num_chunks = min_t(u32, IDPF_NUM_CHUNKS_PER_MSG(config_sz, chunk_sz),
-			   num_q);
-	num_msgs = DIV_ROUND_UP(num_q, num_chunks);
-
-	buf_sz = struct_size(eq, chunks.chunks, num_chunks);
-	eq = kzalloc(buf_sz, GFP_KERNEL);
-	if (!eq)
-		return -ENOMEM;
 
 	if (ena) {
 		xn_params.vc_op = VIRTCHNL2_OP_ENABLE_QUEUES;
@@ -1853,27 +1775,23 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool ena)
 		xn_params.timeout_ms = IDPF_VC_XN_MIN_TIMEOUT_MSEC;
 	}
 
-	for (i = 0, k = 0; i < num_msgs; i++) {
-		memset(eq, 0, buf_sz);
-		eq->vport_id = cpu_to_le32(vport->vport_id);
-		eq->chunks.num_chunks = cpu_to_le16(num_chunks);
-		qcs = &eq->chunks;
-		memcpy(qcs->chunks, &qc[k], chunk_sz * num_chunks);
+	num_chunks = chunks->num_chunks;
+	buf_sz = struct_size(eq, chunks.chunks, num_chunks);
+	eq = kzalloc(buf_sz, GFP_KERNEL);
+	if (!eq)
+		return -ENOMEM;
 
-		xn_params.send_buf.iov_base = eq;
-		xn_params.send_buf.iov_len = buf_sz;
-		reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
-		if (reply_sz < 0)
-			return reply_sz;
+	eq->vport_id = cpu_to_le32(vport->vport_id);
+	eq->chunks.num_chunks = cpu_to_le16(num_chunks);
 
-		k += num_chunks;
-		num_q -= num_chunks;
-		num_chunks = min(num_chunks, num_q);
-		/* Recalculate buffer size */
-		buf_sz = struct_size(eq, chunks.chunks, num_chunks);
-	}
+	idpf_convert_reg_to_queue_chunks(eq->chunks.chunks, chunks->queue_chunks,
+					 num_chunks);
 
-	return 0;
+	xn_params.send_buf.iov_base = eq;
+	xn_params.send_buf.iov_len = buf_sz;
+	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+
+	return reply_sz < 0 ? reply_sz : 0;
 }
 
 /**
@@ -2006,27 +1924,31 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 /**
  * idpf_send_enable_queues_msg - send enable queues virtchnl message
  * @vport: Virtual port private data structure
+ * @chunks: queue ids received over mailbox
  *
  * Will send enable queues virtchnl message.  Returns 0 on success, negative on
  * failure.
  */
-int idpf_send_enable_queues_msg(struct idpf_vport *vport)
+int idpf_send_enable_queues_msg(struct idpf_vport *vport,
+				struct idpf_queue_id_reg_info *chunks)
 {
-	return idpf_send_ena_dis_queues_msg(vport, true);
+	return idpf_send_ena_dis_queues_msg(vport, chunks, true);
 }
 
 /**
  * idpf_send_disable_queues_msg - send disable queues virtchnl message
  * @vport: Virtual port private data structure
+ * @chunks: queue ids received over mailbox
  *
  * Will send disable queues virtchnl message.  Returns 0 on success, negative
  * on failure.
  */
-int idpf_send_disable_queues_msg(struct idpf_vport *vport)
+int idpf_send_disable_queues_msg(struct idpf_vport *vport,
+				 struct idpf_queue_id_reg_info *chunks)
 {
 	int err, i;
 
-	err = idpf_send_ena_dis_queues_msg(vport, false);
+	err = idpf_send_ena_dis_queues_msg(vport, chunks, false);
 	if (err)
 		return err;
 
@@ -2045,26 +1967,6 @@ int idpf_send_disable_queues_msg(struct idpf_vport *vport)
 	return idpf_wait_for_marker_event(vport);
 }
 
-/**
- * idpf_convert_reg_to_queue_chunks - Copy queue chunk information to the right
- * structure
- * @dchunks: Destination chunks to store data to
- * @schunks: Source chunks to copy data from
- * @num_chunks: number of chunks to copy
- */
-static void idpf_convert_reg_to_queue_chunks(struct virtchnl2_queue_chunk *dchunks,
-					     struct idpf_queue_id_reg_chunk *schunks,
-					     u16 num_chunks)
-{
-	u16 i;
-
-	for (i = 0; i < num_chunks; i++) {
-		dchunks[i].type = cpu_to_le32(schunks[i].type);
-		dchunks[i].start_queue_id = cpu_to_le32(schunks[i].start_queue_id);
-		dchunks[i].num_queues = cpu_to_le32(schunks[i].num_queues);
-	}
-}
-
 /**
  * idpf_send_delete_queues_msg - send delete queues virtchnl message
  * @vport: virtual port private data structure
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 6823a3814d2b..2251560426df 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -134,8 +134,10 @@ int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
 			     u16 num_complq, u16 num_rx_q, u16 num_rx_bufq);
 int idpf_send_delete_queues_msg(struct idpf_vport *vport,
 				struct idpf_queue_id_reg_info *chunks);
-int idpf_send_enable_queues_msg(struct idpf_vport *vport);
-int idpf_send_disable_queues_msg(struct idpf_vport *vport);
+int idpf_send_enable_queues_msg(struct idpf_vport *vport,
+				struct idpf_queue_id_reg_info *chunks);
+int idpf_send_disable_queues_msg(struct idpf_vport *vport,
+				 struct idpf_queue_id_reg_info *chunks);
 int idpf_send_config_queues_msg(struct idpf_vport *vport);
 
 int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport);
-- 
2.43.0


