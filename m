Return-Path: <netdev+bounces-189088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5182DAB058B
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 23:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E9E9E621D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85264224251;
	Thu,  8 May 2025 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJgF0amB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19B223DDC
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741053; cv=none; b=jhiQkaYYSXWlb2Ok8u7uUEhSj+PXWB1baiozU2ZdeVXL/dXfNIKM2aFtpBLTXUH8H6qNXgw98XpBsJrXF9TAIprHAGSE3U7773vrwAOu+W9iZQglxB3+Hg0ogDNOChX4JcCAhZgFou6XJB0HHzm1QUVx6aLQlyjbrnmxoQ1XP/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741053; c=relaxed/simple;
	bh=0uiBZISWVXhPqQWzpe/GRXBOlLQSBirz/uh7c2gVbiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYq8YkreOHB7kK41amdKH7APDsfvzwqqkQB6ZFjINH5y9oZMIQFZyp2qcHkP1W3bT3AvPjLATI/YuLDS83UBUsC2AtNOUGg8B6ELu9oow6At+UdUTebHWFI3J+9tinr+MCX9QfgxOnWpHtgtJm5xrtL+jw9eSGCMWhZFUJNmHQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJgF0amB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746741051; x=1778277051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0uiBZISWVXhPqQWzpe/GRXBOlLQSBirz/uh7c2gVbiM=;
  b=VJgF0amB4t5m7BKNUtnTgD202SU+2xCv8db0dP/pj+0b1FX7KZnJetXN
   pEOlinyiEmLzRj5tFhZgkkdbS7TrfimoZnvmyuoKdnYsbX3j/XQK5qYam
   GzJRJP6ZCdFJXQVY7DDGrhuXSlPIhhC6hh/DIAeJICIigRqhHxGbQKEze
   iXOOp4iiIVunYqIYRuorqztGhCY7va12ww0RRPzUShHqRPFPxc0OVom/C
   SxwMx0CgMZw/tWTVTil+T06acmznjQo0AVqJtatNMcw/qGgsPlgCifZyU
   j1AvnZzv6z2hwirVeFPfL9vSWKXC+KzP1N9mGwRsQHGMiv/3/LVC2tRH5
   Q==;
X-CSE-ConnectionGUID: wjPyhs0WTgijJSCan1iNeA==
X-CSE-MsgGUID: PnGR+TWFQWuDyMP3D1BdFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="47808315"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="47808315"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 14:50:49 -0700
X-CSE-ConnectionGUID: mTaV/56MRhGIT+zAQ3oexg==
X-CSE-MsgGUID: 7jcxdXCgR9eWAyoiyCcucw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="141534268"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.55])
  by orviesa005.jf.intel.com with ESMTP; 08 May 2025 14:50:49 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	milena.olech@intel.com,
	anton.nadezhdin@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH iwl-next v4 1/9] idpf: introduce local idpf structure to store virtchnl queue chunks
Date: Thu,  8 May 2025 14:50:05 -0700
Message-ID: <20250508215013.32668-2-pavan.kumar.linga@intel.com>
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

Queue ID and register info received from device Control Plane is stored
locally in the same little endian format. As the queue chunks are
retrieved in 3 functions, lexx_to_cpu conversions are done each time.
Instead introduce a new idpf structure to store the received queue info.
It also avoids conditional check to retrieve queue chunks.

With this change, there is no need to store the queue chunks in
'req_qs_chunks' field. So remove that.

Suggested-by: Milena Olech <milena.olech@intel.com>
Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  31 +++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  35 ++--
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 155 +++++++++---------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  11 +-
 4 files changed, 140 insertions(+), 92 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 44a6c23cd560..1f7f56a4773a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -497,18 +497,45 @@ struct idpf_vector_lifo {
 	u16 *vec_idx;
 };
 
+/**
+ * idpf_queue_id_reg_chunk - individual queue ID and register chunk
+ * @qtail_reg_start: queue tail register offset
+ * @qtail_reg_spacing: queue tail register spacing
+ * @type: queue type of the queues in the chunk
+ * @start_queue_id: starting queue ID in the chunk
+ * @num_queues: number of queues in the chunk
+ */
+struct idpf_queue_id_reg_chunk {
+	u64 qtail_reg_start;
+	u32 qtail_reg_spacing;
+	u32 type;
+	u32 start_queue_id;
+	u32 num_queues;
+};
+
+/**
+ * idpf_queue_id_reg_info - struct to store the queue ID and register chunk
+ *			    info received over the mailbox
+ * @num_chunks: number of chunks
+ * @queue_chunks: array of chunks
+ */
+struct idpf_queue_id_reg_info {
+	u16 num_chunks;
+	struct idpf_queue_id_reg_chunk *queue_chunks;
+};
+
 /**
  * struct idpf_vport_config - Vport configuration data
  * @user_config: see struct idpf_vport_user_config_data
  * @max_q: Maximum possible queues
- * @req_qs_chunks: Queue chunk data for requested queues
+ * @qid_reg_info: Struct to store the queue ID and register info
  * @mac_filter_list_lock: Lock to protect mac filters
  * @flags: See enum idpf_vport_config_flags
  */
 struct idpf_vport_config {
 	struct idpf_vport_user_config_data user_config;
 	struct idpf_vport_max_q max_q;
-	struct virtchnl2_add_queues *req_qs_chunks;
+	struct idpf_queue_id_reg_info qid_reg_info;
 	spinlock_t mac_filter_list_lock;
 	DECLARE_BITMAP(flags, IDPF_VPORT_CONFIG_FLAGS_NBITS);
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 7d42f21c86b6..a11097e98517 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -838,6 +838,7 @@ static void idpf_remove_features(struct idpf_vport *vport)
 static void idpf_vport_stop(struct idpf_vport *vport)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
+	struct idpf_queue_id_reg_info *chunks;
 
 	if (np->state <= __IDPF_VPORT_DOWN)
 		return;
@@ -845,6 +846,8 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 	netif_carrier_off(vport->netdev);
 	netif_tx_disable(vport->netdev);
 
+	chunks = &vport->adapter->vport_config[vport->idx]->qid_reg_info;
+
 	idpf_send_disable_vport_msg(vport);
 	idpf_send_disable_queues_msg(vport);
 	idpf_send_map_unmap_queue_vector_msg(vport, false);
@@ -854,7 +857,7 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 	 * instead of deleting and reallocating the vport.
 	 */
 	if (test_and_clear_bit(IDPF_VPORT_DEL_QUEUES, vport->flags))
-		idpf_send_delete_queues_msg(vport);
+		idpf_send_delete_queues_msg(vport, chunks);
 
 	idpf_remove_features(vport);
 
@@ -952,15 +955,14 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 
 	kfree(vport->q_vector_idxs);
 	vport->q_vector_idxs = NULL;
+	kfree(vport_config->qid_reg_info.queue_chunks);
+	vport_config->qid_reg_info.queue_chunks = NULL;
 
 	kfree(adapter->vport_params_recvd[idx]);
 	adapter->vport_params_recvd[idx] = NULL;
 	kfree(adapter->vport_params_reqd[idx]);
 	adapter->vport_params_reqd[idx] = NULL;
-	if (adapter->vport_config[idx]) {
-		kfree(adapter->vport_config[idx]->req_qs_chunks);
-		adapter->vport_config[idx]->req_qs_chunks = NULL;
-	}
+
 	kfree(vport);
 	adapter->num_alloc_vports--;
 }
@@ -1075,6 +1077,7 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	u16 idx = adapter->next_vport;
 	struct idpf_vport *vport;
 	u16 num_max_q;
+	int err;
 
 	if (idx == IDPF_NO_FREE_SLOT)
 		return NULL;
@@ -1107,7 +1110,9 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	if (!vport->q_vector_idxs)
 		goto free_vport;
 
-	idpf_vport_init(vport, max_q);
+	err = idpf_vport_init(vport, max_q);
+	if (err)
+		goto free_vector_idxs;
 
 	/* This alloc is done separate from the LUT because it's not strictly
 	 * dependent on how many queues we have. If we change number of queues
@@ -1117,7 +1122,7 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	rss_data = &adapter->vport_config[idx]->user_config.rss_data;
 	rss_data->rss_key = kzalloc(rss_data->rss_key_size, GFP_KERNEL);
 	if (!rss_data->rss_key)
-		goto free_vector_idxs;
+		goto free_qreg_chunks;
 
 	/* Initialize default rss key */
 	netdev_rss_key_fill((void *)rss_data->rss_key, rss_data->rss_key_size);
@@ -1132,6 +1137,8 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 
 	return vport;
 
+free_qreg_chunks:
+	kfree(adapter->vport_config[idx]->qid_reg_info.queue_chunks);
 free_vector_idxs:
 	kfree(vport->q_vector_idxs);
 free_vport:
@@ -1308,6 +1315,7 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport_config *vport_config;
+	struct idpf_queue_id_reg_info *chunks;
 	int err;
 
 	if (np->state != __IDPF_VPORT_DOWN)
@@ -1327,7 +1335,10 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	if (err)
 		goto intr_rel;
 
-	err = idpf_vport_queue_ids_init(vport);
+	vport_config = adapter->vport_config[vport->idx];
+	chunks = &vport_config->qid_reg_info;
+
+	err = idpf_vport_queue_ids_init(vport, chunks);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to initialize queue ids for vport %u: %d\n",
 			vport->vport_id, err);
@@ -1348,7 +1359,7 @@ static int idpf_vport_open(struct idpf_vport *vport)
 		goto queues_rel;
 	}
 
-	err = idpf_queue_reg_init(vport);
+	err = idpf_queue_reg_init(vport, chunks);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to initialize queue registers for vport %u: %d\n",
 			vport->vport_id, err);
@@ -1389,7 +1400,6 @@ static int idpf_vport_open(struct idpf_vport *vport)
 
 	idpf_restore_features(vport);
 
-	vport_config = adapter->vport_config[vport->idx];
 	if (vport_config->user_config.rss_data.rss_lut)
 		err = idpf_config_rss(vport);
 	else
@@ -1827,6 +1837,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 	enum idpf_vport_state current_state = np->state;
 	struct idpf_adapter *adapter = vport->adapter;
+	struct idpf_vport_config *vport_config;
 	struct idpf_vport *new_vport;
 	int err;
 
@@ -1873,8 +1884,10 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		goto free_vport;
 	}
 
+	vport_config = adapter->vport_config[vport->idx];
+
 	if (current_state <= __IDPF_VPORT_DOWN) {
-		idpf_send_delete_queues_msg(vport);
+		idpf_send_delete_queues_msg(vport, &vport_config->qid_reg_info);
 	} else {
 		set_bit(IDPF_VPORT_DEL_QUEUES, vport->flags);
 		idpf_vport_stop(vport);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 8b8c5415e418..91fc908e5e20 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1007,6 +1007,42 @@ static void idpf_init_avail_queues(struct idpf_adapter *adapter)
 	avail_queues->avail_complq = le16_to_cpu(caps->max_tx_complq);
 }
 
+/**
+ * idpf_vport_init_queue_reg_chunks - initialize queue register chunks
+ * @vport_config: persistent vport structure to store the queue register info
+ * @schunks: source chunks to copy data from
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+static int
+idpf_vport_init_queue_reg_chunks(struct idpf_vport_config *vport_config,
+				 struct virtchnl2_queue_reg_chunks *schunks)
+{
+	struct idpf_queue_id_reg_info *q_info = &vport_config->qid_reg_info;
+	u16 num_chunks = le16_to_cpu(schunks->num_chunks);
+
+	kfree(q_info->queue_chunks);
+
+	q_info->num_chunks = num_chunks;
+	q_info->queue_chunks = kcalloc(num_chunks, sizeof(*q_info->queue_chunks),
+				       GFP_KERNEL);
+	if (!q_info->queue_chunks)
+		return -ENOMEM;
+
+	for (u16 i = 0; i < num_chunks; i++) {
+		struct idpf_queue_id_reg_chunk *dchunk = &q_info->queue_chunks[i];
+		struct virtchnl2_queue_reg_chunk *schunk = &schunks->chunks[i];
+
+		dchunk->qtail_reg_start = le64_to_cpu(schunk->qtail_reg_start);
+		dchunk->qtail_reg_spacing = le32_to_cpu(schunk->qtail_reg_spacing);
+		dchunk->type = le32_to_cpu(schunk->type);
+		dchunk->start_queue_id = le32_to_cpu(schunk->start_queue_id);
+		dchunk->num_queues = le32_to_cpu(schunk->num_queues);
+	}
+
+	return 0;
+}
+
 /**
  * idpf_get_reg_intr_vecs - Get vector queue register offset
  * @vport: virtual port structure
@@ -1067,25 +1103,25 @@ int idpf_get_reg_intr_vecs(struct idpf_vport *vport,
  * are filled.
  */
 static int idpf_vport_get_q_reg(u32 *reg_vals, int num_regs, u32 q_type,
-				struct virtchnl2_queue_reg_chunks *chunks)
+				struct idpf_queue_id_reg_info *chunks)
 {
-	u16 num_chunks = le16_to_cpu(chunks->num_chunks);
+	u16 num_chunks = chunks->num_chunks;
 	int reg_filled = 0, i;
 	u32 reg_val;
 
 	while (num_chunks--) {
-		struct virtchnl2_queue_reg_chunk *chunk;
+		struct idpf_queue_id_reg_chunk *chunk;
 		u16 num_q;
 
-		chunk = &chunks->chunks[num_chunks];
-		if (le32_to_cpu(chunk->type) != q_type)
+		chunk = &chunks->queue_chunks[num_chunks];
+		if (chunk->type != q_type)
 			continue;
 
-		num_q = le32_to_cpu(chunk->num_queues);
-		reg_val = le64_to_cpu(chunk->qtail_reg_start);
+		num_q = chunk->num_queues;
+		reg_val = chunk->qtail_reg_start;
 		for (i = 0; i < num_q && reg_filled < num_regs ; i++) {
 			reg_vals[reg_filled++] = reg_val;
-			reg_val += le32_to_cpu(chunk->qtail_reg_spacing);
+			reg_val += chunk->qtail_reg_spacing;
 		}
 	}
 
@@ -1155,15 +1191,13 @@ static int __idpf_queue_reg_init(struct idpf_vport *vport, u32 *reg_vals,
 /**
  * idpf_queue_reg_init - initialize queue registers
  * @vport: virtual port structure
+ * @chunks: queue registers received over mailbox
  *
  * Return 0 on success, negative on failure
  */
-int idpf_queue_reg_init(struct idpf_vport *vport)
+int idpf_queue_reg_init(struct idpf_vport *vport,
+			struct idpf_queue_id_reg_info *chunks)
 {
-	struct virtchnl2_create_vport *vport_params;
-	struct virtchnl2_queue_reg_chunks *chunks;
-	struct idpf_vport_config *vport_config;
-	u16 vport_idx = vport->idx;
 	int num_regs, ret = 0;
 	u32 *reg_vals;
 
@@ -1172,16 +1206,6 @@ int idpf_queue_reg_init(struct idpf_vport *vport)
 	if (!reg_vals)
 		return -ENOMEM;
 
-	vport_config = vport->adapter->vport_config[vport_idx];
-	if (vport_config->req_qs_chunks) {
-		struct virtchnl2_add_queues *vc_aq =
-		  (struct virtchnl2_add_queues *)vport_config->req_qs_chunks;
-		chunks = &vc_aq->chunks;
-	} else {
-		vport_params = vport->adapter->vport_params_recvd[vport_idx];
-		chunks = &vport_params->chunks;
-	}
-
 	/* Initialize Tx queue tail register address */
 	num_regs = idpf_vport_get_q_reg(reg_vals, IDPF_LARGE_MAX_Q,
 					VIRTCHNL2_QUEUE_TYPE_TX,
@@ -2029,46 +2053,36 @@ int idpf_send_disable_queues_msg(struct idpf_vport *vport)
  * @num_chunks: number of chunks to copy
  */
 static void idpf_convert_reg_to_queue_chunks(struct virtchnl2_queue_chunk *dchunks,
-					     struct virtchnl2_queue_reg_chunk *schunks,
+					     struct idpf_queue_id_reg_chunk *schunks,
 					     u16 num_chunks)
 {
 	u16 i;
 
 	for (i = 0; i < num_chunks; i++) {
-		dchunks[i].type = schunks[i].type;
-		dchunks[i].start_queue_id = schunks[i].start_queue_id;
-		dchunks[i].num_queues = schunks[i].num_queues;
+		dchunks[i].type = cpu_to_le32(schunks[i].type);
+		dchunks[i].start_queue_id = cpu_to_le32(schunks[i].start_queue_id);
+		dchunks[i].num_queues = cpu_to_le32(schunks[i].num_queues);
 	}
 }
 
 /**
  * idpf_send_delete_queues_msg - send delete queues virtchnl message
- * @vport: Virtual port private data structure
+ * @vport: virtual port private data structure
+ * @chunks: queue ids received over mailbox
  *
  * Will send delete queues virtchnl message. Return 0 on success, negative on
  * failure.
  */
-int idpf_send_delete_queues_msg(struct idpf_vport *vport)
+int idpf_send_delete_queues_msg(struct idpf_vport *vport,
+				struct idpf_queue_id_reg_info *chunks)
 {
 	struct virtchnl2_del_ena_dis_queues *eq __free(kfree) = NULL;
-	struct virtchnl2_create_vport *vport_params;
-	struct virtchnl2_queue_reg_chunks *chunks;
 	struct idpf_vc_xn_params xn_params = {};
-	struct idpf_vport_config *vport_config;
-	u16 vport_idx = vport->idx;
 	ssize_t reply_sz;
 	u16 num_chunks;
 	int buf_size;
 
-	vport_config = vport->adapter->vport_config[vport_idx];
-	if (vport_config->req_qs_chunks) {
-		chunks = &vport_config->req_qs_chunks->chunks;
-	} else {
-		vport_params = vport->adapter->vport_params_recvd[vport_idx];
-		chunks = &vport_params->chunks;
-	}
-
-	num_chunks = le16_to_cpu(chunks->num_chunks);
+	num_chunks = chunks->num_chunks;
 	buf_size = struct_size(eq, chunks.chunks, num_chunks);
 
 	eq = kzalloc(buf_size, GFP_KERNEL);
@@ -2078,7 +2092,7 @@ int idpf_send_delete_queues_msg(struct idpf_vport *vport)
 	eq->vport_id = cpu_to_le32(vport->vport_id);
 	eq->chunks.num_chunks = cpu_to_le16(num_chunks);
 
-	idpf_convert_reg_to_queue_chunks(eq->chunks.chunks, chunks->chunks,
+	idpf_convert_reg_to_queue_chunks(eq->chunks.chunks, chunks->queue_chunks,
 					 num_chunks);
 
 	xn_params.vc_op = VIRTCHNL2_OP_DEL_QUEUES;
@@ -2135,8 +2149,6 @@ int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
 		return -ENOMEM;
 
 	vport_config = vport->adapter->vport_config[vport_idx];
-	kfree(vport_config->req_qs_chunks);
-	vport_config->req_qs_chunks = NULL;
 
 	aq.vport_id = cpu_to_le32(vport->vport_id);
 	aq.num_tx_q = cpu_to_le16(num_tx_q);
@@ -2166,11 +2178,7 @@ int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
 	if (reply_sz < size)
 		return -EIO;
 
-	vport_config->req_qs_chunks = kmemdup(vc_msg, size, GFP_KERNEL);
-	if (!vport_config->req_qs_chunks)
-		return -ENOMEM;
-
-	return 0;
+	return idpf_vport_init_queue_reg_chunks(vport_config, &vc_msg->chunks);
 }
 
 /**
@@ -3160,8 +3168,10 @@ int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport)
  * @max_q: vport max queue info
  *
  * Will initialize vport with the info received through MB earlier
+ *
+ * Return: %0 on success, -%errno on failure.
  */
-void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
+int idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	struct virtchnl2_create_vport *vport_msg;
@@ -3176,6 +3186,11 @@ void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
 	rss_data = &vport_config->user_config.rss_data;
 	vport_msg = adapter->vport_params_recvd[idx];
 
+	err = idpf_vport_init_queue_reg_chunks(vport_config,
+					       &vport_msg->chunks);
+	if (err)
+		return err;
+
 	vport_config->max_q.max_txq = max_q->max_txq;
 	vport_config->max_q.max_rxq = max_q->max_rxq;
 	vport_config->max_q.max_complq = max_q->max_complq;
@@ -3208,15 +3223,17 @@ void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
 
 	if (!(vport_msg->vport_flags &
 	      cpu_to_le16(VIRTCHNL2_VPORT_UPLINK_PORT)))
-		return;
+		return 0;
 
 	err = idpf_ptp_get_vport_tstamps_caps(vport);
 	if (err) {
 		pci_dbg(vport->adapter->pdev, "Tx timestamping not supported\n");
-		return;
+		return err == -EOPNOTSUPP ? 0 : err;
 	}
 
 	INIT_WORK(&vport->tstamp_task, idpf_tstamp_task);
+
+	return 0;
 }
 
 /**
@@ -3275,21 +3292,21 @@ int idpf_get_vec_ids(struct idpf_adapter *adapter,
  * Returns number of ids filled
  */
 static int idpf_vport_get_queue_ids(u32 *qids, int num_qids, u16 q_type,
-				    struct virtchnl2_queue_reg_chunks *chunks)
+				    struct idpf_queue_id_reg_info *chunks)
 {
-	u16 num_chunks = le16_to_cpu(chunks->num_chunks);
+	u16 num_chunks = chunks->num_chunks;
 	u32 num_q_id_filled = 0, i;
 	u32 start_q_id, num_q;
 
 	while (num_chunks--) {
-		struct virtchnl2_queue_reg_chunk *chunk;
+		struct idpf_queue_id_reg_chunk *chunk;
 
-		chunk = &chunks->chunks[num_chunks];
-		if (le32_to_cpu(chunk->type) != q_type)
+		chunk = &chunks->queue_chunks[num_chunks];
+		if (chunk->type != q_type)
 			continue;
 
-		num_q = le32_to_cpu(chunk->num_queues);
-		start_q_id = le32_to_cpu(chunk->start_queue_id);
+		num_q = chunk->num_queues;
+		start_q_id = chunk->start_queue_id;
 
 		for (i = 0; i < num_q; i++) {
 			if ((num_q_id_filled + i) < num_qids) {
@@ -3382,30 +3399,18 @@ static int __idpf_vport_queue_ids_init(struct idpf_vport *vport,
 /**
  * idpf_vport_queue_ids_init - Initialize queue ids from Mailbox parameters
  * @vport: virtual port for which the queues ids are initialized
+ * @chunks: queue ids received over mailbox
  *
  * Will initialize all queue ids with ids received as mailbox parameters.
  * Returns 0 on success, negative if all the queues are not initialized.
  */
-int idpf_vport_queue_ids_init(struct idpf_vport *vport)
+int idpf_vport_queue_ids_init(struct idpf_vport *vport,
+			      struct idpf_queue_id_reg_info *chunks)
 {
-	struct virtchnl2_create_vport *vport_params;
-	struct virtchnl2_queue_reg_chunks *chunks;
-	struct idpf_vport_config *vport_config;
-	u16 vport_idx = vport->idx;
 	int num_ids, err = 0;
 	u16 q_type;
 	u32 *qids;
 
-	vport_config = vport->adapter->vport_config[vport_idx];
-	if (vport_config->req_qs_chunks) {
-		struct virtchnl2_add_queues *vc_aq =
-			(struct virtchnl2_add_queues *)vport_config->req_qs_chunks;
-		chunks = &vc_aq->chunks;
-	} else {
-		vport_params = vport->adapter->vport_params_recvd[vport_idx];
-		chunks = &vport_params->chunks;
-	}
-
 	qids = kcalloc(IDPF_MAX_QIDS, sizeof(u32), GFP_KERNEL);
 	if (!qids)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 165767705469..6823a3814d2b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -102,8 +102,10 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter);
 
 int idpf_get_reg_intr_vecs(struct idpf_vport *vport,
 			   struct idpf_vec_regs *reg_vals);
-int idpf_queue_reg_init(struct idpf_vport *vport);
-int idpf_vport_queue_ids_init(struct idpf_vport *vport);
+int idpf_queue_reg_init(struct idpf_vport *vport,
+			struct idpf_queue_id_reg_info *chunks);
+int idpf_vport_queue_ids_init(struct idpf_vport *vport,
+			      struct idpf_queue_id_reg_info *chunks);
 
 bool idpf_vport_is_cap_ena(struct idpf_vport *vport, u16 flag);
 bool idpf_sideband_flow_type_ena(struct idpf_vport *vport, u32 flow_type);
@@ -115,7 +117,7 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter);
 int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
 		     u16 msg_size, u8 *msg, u16 cookie);
 
-void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q);
+int idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q);
 u32 idpf_get_vport_id(struct idpf_vport *vport);
 int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 			       struct idpf_vport_max_q *max_q);
@@ -130,7 +132,8 @@ void idpf_vport_dealloc_max_qs(struct idpf_adapter *adapter,
 			       struct idpf_vport_max_q *max_q);
 int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
 			     u16 num_complq, u16 num_rx_q, u16 num_rx_bufq);
-int idpf_send_delete_queues_msg(struct idpf_vport *vport);
+int idpf_send_delete_queues_msg(struct idpf_vport *vport,
+				struct idpf_queue_id_reg_info *chunks);
 int idpf_send_enable_queues_msg(struct idpf_vport *vport);
 int idpf_send_disable_queues_msg(struct idpf_vport *vport);
 int idpf_send_config_queues_msg(struct idpf_vport *vport);
-- 
2.43.0


