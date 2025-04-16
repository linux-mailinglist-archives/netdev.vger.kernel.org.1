Return-Path: <netdev+bounces-183501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E3FA90DA9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 23:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E94460172
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB0A233132;
	Wed, 16 Apr 2025 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBxfbuI7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493114B950
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744838344; cv=none; b=Z0sXs3gKnibxU16nQ4RMlLi+hZvaRGIQkWx0vO/+1wCEWUkvY8ydMCHBEZg5NMDIM6Xj5S7KmoiEINb2qdftcLxqyzgQQXhKh2hs0hETLDbSO7AEqC60j3fVYkwaUmpJyJW6g1RikEs3dqg5iFz2L4Yv8E6ZWkyhEXbS5jAyAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744838344; c=relaxed/simple;
	bh=+A9Dv01LeL2+fUaquWm3WcRFQG7J6+3l5puOYXWK9zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3c+HtKt0a7TXQKsyTNnYpU5LFAHERbVShd1zxSqKL3wav7Ja7HHvRnVayrLTHK4M4RzVtsoe3LoasmDsP/okdAV+yY63USv18rFqgvpMDYJ1QsRS0yLOQDKxkdfvFjW0uZ7EEB7dbIm51GjaPi2waXCQaiiXZAeth+T4SUZdW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBxfbuI7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744838342; x=1776374342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+A9Dv01LeL2+fUaquWm3WcRFQG7J6+3l5puOYXWK9zk=;
  b=PBxfbuI7ih3Sz+gtOhGE4fhHHQ0d+Wdhf6Iq062B5qbPBXJ1Ba3zpP21
   zsxsyn/jISDL3tHM6kyDLoSlSlfADzKme7AiECGU8WnJHOZhc58hX214J
   xaCn9UJZYcrzt2yxxQtpKeil5A0uvWJKCjNWEW68Nfaoo+0apN4BNskzu
   dfQa0fJgMF9R9smkIcKzw+ipYGKhM64c1G0Ouvv0Dv2ITkQ73VuNsKXRA
   10/wi/5go1LeP1eCukUySMzPPGkUfw5cVA1LFSHYTSD2sR2xBUa/FMBJR
   z+FoUy/Lt1p9TppOpLXz6lnEU2HfPgsxtiGBFcDfcL+kzyI4vc7sNuskC
   A==;
X-CSE-ConnectionGUID: oPKqQyx3QwusoWVRCp0nTA==
X-CSE-MsgGUID: 9W5OPlUMRKWOXax1SdavQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46496232"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46496232"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 14:19:00 -0700
X-CSE-ConnectionGUID: XCY8QJplSt+WqAwK4CRM2Q==
X-CSE-MsgGUID: t6boakpPR2SCHV0aqI7lVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130909739"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.55])
  by fmviesa008.fm.intel.com with ESMTP; 16 Apr 2025 14:19:00 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	milena.olech@intel.com,
	anton.nadezhdin@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH iwl-next 2/9] idpf: use existing queue chunk info instead of preparing it
Date: Wed, 16 Apr 2025 14:18:14 -0700
Message-ID: <20250416211821.444076-3-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416211821.444076-1-pavan.kumar.linga@intel.com>
References: <20250416211821.444076-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue chunk info received from the device control plane
is stored in the persistent data section. Necessary info from
these chunks is parsed and stored in the queue structure.
While sending the enable/disable queues virtchnl message,
queue chunk info is prepared using the stored queue info.
Instead of that, use the stored queue chunks directly which has
info about all the queues that needs to be enabled/disabled.

Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   6 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 188 +++++-------------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   6 +-
 3 files changed, 52 insertions(+), 148 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 1536f6ce5ec7..b1a8ce0bc072 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -844,7 +844,7 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 	chunks = &vport->adapter->vport_config[vport->idx]->qid_reg_info;
 
 	idpf_send_disable_vport_msg(vport);
-	idpf_send_disable_queues_msg(vport);
+	idpf_send_disable_queues_msg(vport, chunks);
 	idpf_send_map_unmap_queue_vector_msg(vport, false);
 	/* Normally we ask for queues in create_vport, but if the number of
 	 * initially requested queues have changed, for example via ethtool
@@ -1378,7 +1378,7 @@ static int idpf_vport_open(struct idpf_vport *vport)
 		goto intr_deinit;
 	}
 
-	err = idpf_send_enable_queues_msg(vport);
+	err = idpf_send_enable_queues_msg(vport, chunks);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to enable queues for vport %u: %d\n",
 			vport->vport_id, err);
@@ -1419,7 +1419,7 @@ static int idpf_vport_open(struct idpf_vport *vport)
 disable_vport:
 	idpf_send_disable_vport_msg(vport);
 disable_queues:
-	idpf_send_disable_queues_msg(vport);
+	idpf_send_disable_queues_msg(vport, chunks);
 unmap_queue_vectors:
 	idpf_send_map_unmap_queue_vector_msg(vport, false);
 intr_deinit:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 6d18022c5aa1..ed19ba1d0919 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1000,6 +1000,24 @@ static void idpf_init_avail_queues(struct idpf_adapter *adapter)
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
@@ -1727,116 +1745,20 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
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
@@ -1846,27 +1768,23 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool ena)
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
@@ -1999,27 +1917,31 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
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
 
@@ -2038,26 +1960,6 @@ int idpf_send_disable_queues_msg(struct idpf_vport *vport)
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
index 3aee08c1352d..30436e7492a8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -44,8 +44,10 @@ int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
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


