Return-Path: <netdev+bounces-77235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4682A870C1A
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0977283D2C
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CE24C62A;
	Mon,  4 Mar 2024 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUrltBet"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087BC1C687
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586330; cv=none; b=S3dd0FIrC37oZ5rdEljzEgblNC2K089z6MxgyDsM/0e9j616AGa+UcfHexXqe6lsi6Fy1r1jE88BXwu1a5uSBxZBQZXHLRpMkbzahQm/iG8z8mgKBdyVkugba/Sj9JmLB3M52aX6RGV+2PY2zOpOYeZc8hgelUJCSlmxAyC3TxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586330; c=relaxed/simple;
	bh=44tD/mi1XFP4yewsarNlmKT/eQFlNWcEg8kTSVy7cNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRGHwMwupo7n5kHgiC64BL9ac0GJkyZVyUwE7/yiZNatmktrCqEjkD8H9/5YlyAvrXPevB/nmdeyt4HaIEZO1olDpQ8LfyDhxuK9PMAF3Bb422kpNvcPsrDAkXcPtU6NjuTk9OLkAjd9OZ3A1r5RlDhYU+C5V/5QYCqiXOW99wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUrltBet; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709586326; x=1741122326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=44tD/mi1XFP4yewsarNlmKT/eQFlNWcEg8kTSVy7cNA=;
  b=TUrltBetpB61sLgInysSjRUX2V0QzA2YK5u8qQBGfaC/1K7un0O6n0d6
   XBZ4vaDM5xaxFC9z5W1AsOmOkg/T9GVmyIsCxVqJr0pguCYBEyiiINdnb
   DGPhiImTb4c/caopHfldXY8U5h03n4mFUyF6/njKSq8Akbg/2xr+xYVjP
   Ssd06dcXvv1OvzKQJLvK1KXIDwC78xWoDXQJ7tkNUCFByh+XwGrrZ+IXN
   jDv8NbLX5RQpXL0j1GhjjneUksK27XpwLiXYNVYDjCQ6rPUedW8JQ6Jb6
   dsyWWDmQwFw9o05+9Gtla3B9OCKLwkLLyb5hVWx2rYjy1XGNEUiy8xUL/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21561090"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="21561090"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9539730"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 04 Mar 2024 13:05:22 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alan Brady <alan.brady@intel.com>,
	anthony.l.nguyen@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net-next 04/11] idpf: refactor queue related virtchnl messages
Date: Mon,  4 Mar 2024 13:05:04 -0800
Message-ID: <20240304210514.3412298-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240304210514.3412298-1-anthony.l.nguyen@intel.com>
References: <20240304210514.3412298-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alan Brady <alan.brady@intel.com>

This reworks queue specific virtchnl messages to use the added
transaction API.  It is fairly mechanical and generally makes the
functions using it more simple. Functions using transaction API no
longer need to take the vc_buf_lock since it's not using it anymore.
After filling out an idpf_vc_xn_params struct, idpf_vc_xn_exec takes
care of the send and recv handling.

This also converts those functions where appropriate to use
auto-variables instead of manually calling kfree. This greatly
simplifies the memory alloc paths and makes them less prone memory
leaks.

Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |   2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 393 ++++++------------
 2 files changed, 136 insertions(+), 259 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index c3b08d4593b0..ed5474c1565a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -553,7 +553,7 @@ struct idpf_vector_lifo {
 struct idpf_vport_config {
 	struct idpf_vport_user_config_data user_config;
 	struct idpf_vport_max_q max_q;
-	void *req_qs_chunks;
+	struct virtchnl2_add_queues *req_qs_chunks;
 	spinlock_t mac_filter_list_lock;
 	DECLARE_BITMAP(flags, IDPF_VPORT_CONFIG_FLAGS_NBITS);
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 2dab7122615f..1d1b421c33a3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -904,47 +904,15 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter, u32 op,
 		case VIRTCHNL2_OP_ENABLE_VPORT:
 		case VIRTCHNL2_OP_DISABLE_VPORT:
 		case VIRTCHNL2_OP_DESTROY_VPORT:
-			err = idpf_vc_xn_forward_reply(adapter, &ctlq_msg);
-			break;
 		case VIRTCHNL2_OP_CONFIG_TX_QUEUES:
-			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
-					   IDPF_VC_CONFIG_TXQ,
-					   IDPF_VC_CONFIG_TXQ_ERR);
-			break;
 		case VIRTCHNL2_OP_CONFIG_RX_QUEUES:
-			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
-					   IDPF_VC_CONFIG_RXQ,
-					   IDPF_VC_CONFIG_RXQ_ERR);
-			break;
 		case VIRTCHNL2_OP_ENABLE_QUEUES:
-			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
-					   IDPF_VC_ENA_QUEUES,
-					   IDPF_VC_ENA_QUEUES_ERR);
-			break;
 		case VIRTCHNL2_OP_DISABLE_QUEUES:
-			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
-					   IDPF_VC_DIS_QUEUES,
-					   IDPF_VC_DIS_QUEUES_ERR);
-			break;
 		case VIRTCHNL2_OP_ADD_QUEUES:
-			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
-					   IDPF_VC_ADD_QUEUES,
-					   IDPF_VC_ADD_QUEUES_ERR);
-			break;
 		case VIRTCHNL2_OP_DEL_QUEUES:
-			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
-					   IDPF_VC_DEL_QUEUES,
-					   IDPF_VC_DEL_QUEUES_ERR);
-			break;
 		case VIRTCHNL2_OP_MAP_QUEUE_VECTOR:
-			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
-					   IDPF_VC_MAP_IRQ,
-					   IDPF_VC_MAP_IRQ_ERR);
-			break;
 		case VIRTCHNL2_OP_UNMAP_QUEUE_VECTOR:
-			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
-					   IDPF_VC_UNMAP_IRQ,
-					   IDPF_VC_UNMAP_IRQ_ERR);
+			err = idpf_vc_xn_forward_reply(adapter, &ctlq_msg);
 			break;
 		case VIRTCHNL2_OP_GET_STATS:
 			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
@@ -1879,11 +1847,13 @@ int idpf_send_disable_vport_msg(struct idpf_vport *vport)
  */
 static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
 {
-	struct virtchnl2_config_tx_queues *ctq;
+	struct virtchnl2_config_tx_queues *ctq __free(kfree) = NULL;
+	struct virtchnl2_txq_info *qi __free(kfree) = NULL;
+	struct idpf_vc_xn_params xn_params = {};
 	u32 config_sz, chunk_sz, buf_sz;
 	int totqs, num_msgs, num_chunks;
-	struct virtchnl2_txq_info *qi;
-	int err = 0, i, k = 0;
+	ssize_t reply_sz;
+	int i, k = 0;
 
 	totqs = vport->num_txq + vport->num_complq;
 	qi = kcalloc(totqs, sizeof(struct virtchnl2_txq_info), GFP_KERNEL);
@@ -1944,10 +1914,8 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
 	}
 
 	/* Make sure accounting agrees */
-	if (k != totqs) {
-		err = -EINVAL;
-		goto error;
-	}
+	if (k != totqs)
+		return -EINVAL;
 
 	/* Chunk up the queue contexts into multiple messages to avoid
 	 * sending a control queue message buffer that is too large
@@ -1961,12 +1929,11 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
 
 	buf_sz = struct_size(ctq, qinfo, num_chunks);
 	ctq = kzalloc(buf_sz, GFP_KERNEL);
-	if (!ctq) {
-		err = -ENOMEM;
-		goto error;
-	}
+	if (!ctq)
+		return -ENOMEM;
 
-	mutex_lock(&vport->vc_buf_lock);
+	xn_params.vc_op = VIRTCHNL2_OP_CONFIG_TX_QUEUES;
+	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 
 	for (i = 0, k = 0; i < num_msgs; i++) {
 		memset(ctq, 0, buf_sz);
@@ -1974,17 +1941,11 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
 		ctq->num_qinfo = cpu_to_le16(num_chunks);
 		memcpy(ctq->qinfo, &qi[k], chunk_sz * num_chunks);
 
-		err = idpf_send_mb_msg(vport->adapter,
-				       VIRTCHNL2_OP_CONFIG_TX_QUEUES,
-				       buf_sz, (u8 *)ctq, 0);
-		if (err)
-			goto mbx_error;
-
-		err = idpf_wait_for_event(vport->adapter, vport,
-					  IDPF_VC_CONFIG_TXQ,
-					  IDPF_VC_CONFIG_TXQ_ERR);
-		if (err)
-			goto mbx_error;
+		xn_params.send_buf.iov_base = ctq;
+		xn_params.send_buf.iov_len = buf_sz;
+		reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+		if (reply_sz < 0)
+			return reply_sz;
 
 		k += num_chunks;
 		totqs -= num_chunks;
@@ -1993,13 +1954,7 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
 		buf_sz = struct_size(ctq, qinfo, num_chunks);
 	}
 
-mbx_error:
-	mutex_unlock(&vport->vc_buf_lock);
-	kfree(ctq);
-error:
-	kfree(qi);
-
-	return err;
+	return 0;
 }
 
 /**
@@ -2011,11 +1966,13 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
  */
 static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 {
-	struct virtchnl2_config_rx_queues *crq;
+	struct virtchnl2_config_rx_queues *crq __free(kfree) = NULL;
+	struct virtchnl2_rxq_info *qi __free(kfree) = NULL;
+	struct idpf_vc_xn_params xn_params = {};
 	u32 config_sz, chunk_sz, buf_sz;
 	int totqs, num_msgs, num_chunks;
-	struct virtchnl2_rxq_info *qi;
-	int err = 0, i, k = 0;
+	ssize_t reply_sz;
+	int i, k = 0;
 
 	totqs = vport->num_rxq + vport->num_bufq;
 	qi = kcalloc(totqs, sizeof(struct virtchnl2_rxq_info), GFP_KERNEL);
@@ -2096,10 +2053,8 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 	}
 
 	/* Make sure accounting agrees */
-	if (k != totqs) {
-		err = -EINVAL;
-		goto error;
-	}
+	if (k != totqs)
+		return -EINVAL;
 
 	/* Chunk up the queue contexts into multiple messages to avoid
 	 * sending a control queue message buffer that is too large
@@ -2113,12 +2068,11 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 
 	buf_sz = struct_size(crq, qinfo, num_chunks);
 	crq = kzalloc(buf_sz, GFP_KERNEL);
-	if (!crq) {
-		err = -ENOMEM;
-		goto error;
-	}
+	if (!crq)
+		return -ENOMEM;
 
-	mutex_lock(&vport->vc_buf_lock);
+	xn_params.vc_op = VIRTCHNL2_OP_CONFIG_RX_QUEUES;
+	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 
 	for (i = 0, k = 0; i < num_msgs; i++) {
 		memset(crq, 0, buf_sz);
@@ -2126,17 +2080,11 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 		crq->num_qinfo = cpu_to_le16(num_chunks);
 		memcpy(crq->qinfo, &qi[k], chunk_sz * num_chunks);
 
-		err = idpf_send_mb_msg(vport->adapter,
-				       VIRTCHNL2_OP_CONFIG_RX_QUEUES,
-				       buf_sz, (u8 *)crq, 0);
-		if (err)
-			goto mbx_error;
-
-		err = idpf_wait_for_event(vport->adapter, vport,
-					  IDPF_VC_CONFIG_RXQ,
-					  IDPF_VC_CONFIG_RXQ_ERR);
-		if (err)
-			goto mbx_error;
+		xn_params.send_buf.iov_base = crq;
+		xn_params.send_buf.iov_len = buf_sz;
+		reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+		if (reply_sz < 0)
+			return reply_sz;
 
 		k += num_chunks;
 		totqs -= num_chunks;
@@ -2145,42 +2093,28 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 		buf_sz = struct_size(crq, qinfo, num_chunks);
 	}
 
-mbx_error:
-	mutex_unlock(&vport->vc_buf_lock);
-	kfree(crq);
-error:
-	kfree(qi);
-
-	return err;
+	return 0;
 }
 
 /**
  * idpf_send_ena_dis_queues_msg - Send virtchnl enable or disable
  * queues message
  * @vport: virtual port data structure
- * @vc_op: virtchnl op code to send
+ * @ena: if true enable, false disable
  *
  * Send enable or disable queues virtchnl message. Returns 0 on success,
  * negative on failure.
  */
-static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
+static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool ena)
 {
+	struct virtchnl2_del_ena_dis_queues *eq __free(kfree) = NULL;
+	struct virtchnl2_queue_chunk *qc __free(kfree) = NULL;
 	u32 num_msgs, num_chunks, num_txq, num_rxq, num_q;
-	struct idpf_adapter *adapter = vport->adapter;
-	struct virtchnl2_del_ena_dis_queues *eq;
+	struct idpf_vc_xn_params xn_params = {};
 	struct virtchnl2_queue_chunks *qcs;
-	struct virtchnl2_queue_chunk *qc;
 	u32 config_sz, chunk_sz, buf_sz;
-	int i, j, k = 0, err = 0;
-
-	/* validate virtchnl op */
-	switch (vc_op) {
-	case VIRTCHNL2_OP_ENABLE_QUEUES:
-	case VIRTCHNL2_OP_DISABLE_QUEUES:
-		break;
-	default:
-		return -EINVAL;
-	}
+	ssize_t reply_sz;
+	int i, j, k = 0;
 
 	num_txq = vport->num_txq + vport->num_complq;
 	num_rxq = vport->num_rxq + vport->num_bufq;
@@ -2199,10 +2133,8 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
 			qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
 		}
 	}
-	if (vport->num_txq != k) {
-		err = -EINVAL;
-		goto error;
-	}
+	if (vport->num_txq != k)
+		return -EINVAL;
 
 	if (!idpf_is_queue_model_split(vport->txq_model))
 		goto setup_rx;
@@ -2214,10 +2146,8 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
 		qc[k].start_queue_id = cpu_to_le32(tx_qgrp->complq->q_id);
 		qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
 	}
-	if (vport->num_complq != (k - vport->num_txq)) {
-		err = -EINVAL;
-		goto error;
-	}
+	if (vport->num_complq != (k - vport->num_txq))
+		return -EINVAL;
 
 setup_rx:
 	for (i = 0; i < vport->num_rxq_grp; i++) {
@@ -2243,10 +2173,8 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
 			qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
 		}
 	}
-	if (vport->num_rxq != k - (vport->num_txq + vport->num_complq)) {
-		err = -EINVAL;
-		goto error;
-	}
+	if (vport->num_rxq != k - (vport->num_txq + vport->num_complq))
+		return -EINVAL;
 
 	if (!idpf_is_queue_model_split(vport->rxq_model))
 		goto send_msg;
@@ -2265,10 +2193,8 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
 	}
 	if (vport->num_bufq != k - (vport->num_txq +
 				    vport->num_complq +
-				    vport->num_rxq)) {
-		err = -EINVAL;
-		goto error;
-	}
+				    vport->num_rxq))
+		return -EINVAL;
 
 send_msg:
 	/* Chunk up the queue info into multiple messages */
@@ -2281,12 +2207,16 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
 
 	buf_sz = struct_size(eq, chunks.chunks, num_chunks);
 	eq = kzalloc(buf_sz, GFP_KERNEL);
-	if (!eq) {
-		err = -ENOMEM;
-		goto error;
-	}
+	if (!eq)
+		return -ENOMEM;
 
-	mutex_lock(&vport->vc_buf_lock);
+	if (ena) {
+		xn_params.vc_op = VIRTCHNL2_OP_ENABLE_QUEUES;
+		xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
+	} else {
+		xn_params.vc_op = VIRTCHNL2_OP_DISABLE_QUEUES;
+		xn_params.timeout_ms = IDPF_VC_XN_MIN_TIMEOUT_MSEC;
+	}
 
 	for (i = 0, k = 0; i < num_msgs; i++) {
 		memset(eq, 0, buf_sz);
@@ -2295,20 +2225,11 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
 		qcs = &eq->chunks;
 		memcpy(qcs->chunks, &qc[k], chunk_sz * num_chunks);
 
-		err = idpf_send_mb_msg(adapter, vc_op, buf_sz, (u8 *)eq, 0);
-		if (err)
-			goto mbx_error;
-
-		if (vc_op == VIRTCHNL2_OP_ENABLE_QUEUES)
-			err = idpf_wait_for_event(adapter, vport,
-						  IDPF_VC_ENA_QUEUES,
-						  IDPF_VC_ENA_QUEUES_ERR);
-		else
-			err = idpf_min_wait_for_event(adapter, vport,
-						      IDPF_VC_DIS_QUEUES,
-						      IDPF_VC_DIS_QUEUES_ERR);
-		if (err)
-			goto mbx_error;
+		xn_params.send_buf.iov_base = eq;
+		xn_params.send_buf.iov_len = buf_sz;
+		reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+		if (reply_sz < 0)
+			return reply_sz;
 
 		k += num_chunks;
 		num_q -= num_chunks;
@@ -2317,13 +2238,7 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
 		buf_sz = struct_size(eq, chunks.chunks, num_chunks);
 	}
 
-mbx_error:
-	mutex_unlock(&vport->vc_buf_lock);
-	kfree(eq);
-error:
-	kfree(qc);
-
-	return err;
+	return 0;
 }
 
 /**
@@ -2337,12 +2252,13 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
  */
 int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 {
-	struct idpf_adapter *adapter = vport->adapter;
-	struct virtchnl2_queue_vector_maps *vqvm;
-	struct virtchnl2_queue_vector *vqv;
+	struct virtchnl2_queue_vector_maps *vqvm __free(kfree) = NULL;
+	struct virtchnl2_queue_vector *vqv __free(kfree) = NULL;
+	struct idpf_vc_xn_params xn_params = {};
 	u32 config_sz, chunk_sz, buf_sz;
 	u32 num_msgs, num_chunks, num_q;
-	int i, j, k = 0, err = 0;
+	ssize_t reply_sz;
+	int i, j, k = 0;
 
 	num_q = vport->num_txq + vport->num_rxq;
 
@@ -2372,10 +2288,8 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 		}
 	}
 
-	if (vport->num_txq != k) {
-		err = -EINVAL;
-		goto error;
-	}
+	if (vport->num_txq != k)
+		return -EINVAL;
 
 	for (i = 0; i < vport->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
@@ -2402,15 +2316,11 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 	}
 
 	if (idpf_is_queue_model_split(vport->txq_model)) {
-		if (vport->num_rxq != k - vport->num_complq) {
-			err = -EINVAL;
-			goto error;
-		}
+		if (vport->num_rxq != k - vport->num_complq)
+			return -EINVAL;
 	} else {
-		if (vport->num_rxq != k - vport->num_txq) {
-			err = -EINVAL;
-			goto error;
-		}
+		if (vport->num_rxq != k - vport->num_txq)
+			return -EINVAL;
 	}
 
 	/* Chunk up the vector info into multiple messages */
@@ -2423,39 +2333,28 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 
 	buf_sz = struct_size(vqvm, qv_maps, num_chunks);
 	vqvm = kzalloc(buf_sz, GFP_KERNEL);
-	if (!vqvm) {
-		err = -ENOMEM;
-		goto error;
-	}
+	if (!vqvm)
+		return -ENOMEM;
 
-	mutex_lock(&vport->vc_buf_lock);
+	if (map) {
+		xn_params.vc_op = VIRTCHNL2_OP_MAP_QUEUE_VECTOR;
+		xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
+	} else {
+		xn_params.vc_op = VIRTCHNL2_OP_UNMAP_QUEUE_VECTOR;
+		xn_params.timeout_ms = IDPF_VC_XN_MIN_TIMEOUT_MSEC;
+	}
 
 	for (i = 0, k = 0; i < num_msgs; i++) {
 		memset(vqvm, 0, buf_sz);
+		xn_params.send_buf.iov_base = vqvm;
+		xn_params.send_buf.iov_len = buf_sz;
 		vqvm->vport_id = cpu_to_le32(vport->vport_id);
 		vqvm->num_qv_maps = cpu_to_le16(num_chunks);
 		memcpy(vqvm->qv_maps, &vqv[k], chunk_sz * num_chunks);
 
-		if (map) {
-			err = idpf_send_mb_msg(adapter,
-					       VIRTCHNL2_OP_MAP_QUEUE_VECTOR,
-					       buf_sz, (u8 *)vqvm, 0);
-			if (!err)
-				err = idpf_wait_for_event(adapter, vport,
-							  IDPF_VC_MAP_IRQ,
-							  IDPF_VC_MAP_IRQ_ERR);
-		} else {
-			err = idpf_send_mb_msg(adapter,
-					       VIRTCHNL2_OP_UNMAP_QUEUE_VECTOR,
-					       buf_sz, (u8 *)vqvm, 0);
-			if (!err)
-				err =
-				idpf_min_wait_for_event(adapter, vport,
-							IDPF_VC_UNMAP_IRQ,
-							IDPF_VC_UNMAP_IRQ_ERR);
-		}
-		if (err)
-			goto mbx_error;
+		reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+		if (reply_sz < 0)
+			return reply_sz;
 
 		k += num_chunks;
 		num_q -= num_chunks;
@@ -2464,13 +2363,7 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 		buf_sz = struct_size(vqvm, qv_maps, num_chunks);
 	}
 
-mbx_error:
-	mutex_unlock(&vport->vc_buf_lock);
-	kfree(vqvm);
-error:
-	kfree(vqv);
-
-	return err;
+	return 0;
 }
 
 /**
@@ -2482,7 +2375,7 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
  */
 int idpf_send_enable_queues_msg(struct idpf_vport *vport)
 {
-	return idpf_send_ena_dis_queues_msg(vport, VIRTCHNL2_OP_ENABLE_QUEUES);
+	return idpf_send_ena_dis_queues_msg(vport, true);
 }
 
 /**
@@ -2496,7 +2389,7 @@ int idpf_send_disable_queues_msg(struct idpf_vport *vport)
 {
 	int err, i;
 
-	err = idpf_send_ena_dis_queues_msg(vport, VIRTCHNL2_OP_DISABLE_QUEUES);
+	err = idpf_send_ena_dis_queues_msg(vport, false);
 	if (err)
 		return err;
 
@@ -2542,22 +2435,21 @@ static void idpf_convert_reg_to_queue_chunks(struct virtchnl2_queue_chunk *dchun
  */
 int idpf_send_delete_queues_msg(struct idpf_vport *vport)
 {
-	struct idpf_adapter *adapter = vport->adapter;
+	struct virtchnl2_del_ena_dis_queues *eq __free(kfree) = NULL;
 	struct virtchnl2_create_vport *vport_params;
 	struct virtchnl2_queue_reg_chunks *chunks;
-	struct virtchnl2_del_ena_dis_queues *eq;
+	struct idpf_vc_xn_params xn_params = {};
 	struct idpf_vport_config *vport_config;
 	u16 vport_idx = vport->idx;
-	int buf_size, err;
+	ssize_t reply_sz;
 	u16 num_chunks;
+	int buf_size;
 
-	vport_config = adapter->vport_config[vport_idx];
+	vport_config = vport->adapter->vport_config[vport_idx];
 	if (vport_config->req_qs_chunks) {
-		struct virtchnl2_add_queues *vc_aq =
-			(struct virtchnl2_add_queues *)vport_config->req_qs_chunks;
-		chunks = &vc_aq->chunks;
+		chunks = &vport_config->req_qs_chunks->chunks;
 	} else {
-		vport_params = adapter->vport_params_recvd[vport_idx];
+		vport_params = vport->adapter->vport_params_recvd[vport_idx];
 		chunks = &vport_params->chunks;
 	}
 
@@ -2574,21 +2466,13 @@ int idpf_send_delete_queues_msg(struct idpf_vport *vport)
 	idpf_convert_reg_to_queue_chunks(eq->chunks.chunks, chunks->chunks,
 					 num_chunks);
 
-	mutex_lock(&vport->vc_buf_lock);
-
-	err = idpf_send_mb_msg(adapter, VIRTCHNL2_OP_DEL_QUEUES,
-			       buf_size, (u8 *)eq, 0);
-	if (err)
-		goto rel_lock;
-
-	err = idpf_min_wait_for_event(adapter, vport, IDPF_VC_DEL_QUEUES,
-				      IDPF_VC_DEL_QUEUES_ERR);
-
-rel_lock:
-	mutex_unlock(&vport->vc_buf_lock);
-	kfree(eq);
+	xn_params.vc_op = VIRTCHNL2_OP_DEL_QUEUES;
+	xn_params.timeout_ms = IDPF_VC_XN_MIN_TIMEOUT_MSEC;
+	xn_params.send_buf.iov_base = eq;
+	xn_params.send_buf.iov_len = buf_size;
+	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
 
-	return err;
+	return reply_sz < 0 ? reply_sz : 0;
 }
 
 /**
@@ -2623,14 +2507,21 @@ int idpf_send_config_queues_msg(struct idpf_vport *vport)
 int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
 			     u16 num_complq, u16 num_rx_q, u16 num_rx_bufq)
 {
-	struct idpf_adapter *adapter = vport->adapter;
+	struct virtchnl2_add_queues *vc_msg __free(kfree) = NULL;
+	struct idpf_vc_xn_params xn_params = {};
 	struct idpf_vport_config *vport_config;
-	struct virtchnl2_add_queues aq = { };
-	struct virtchnl2_add_queues *vc_msg;
+	struct virtchnl2_add_queues aq = {};
 	u16 vport_idx = vport->idx;
-	int size, err;
+	ssize_t reply_sz;
+	int size;
 
-	vport_config = adapter->vport_config[vport_idx];
+	vc_msg = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
+	if (!vc_msg)
+		return -ENOMEM;
+
+	vport_config = vport->adapter->vport_config[vport_idx];
+	kfree(vport_config->req_qs_chunks);
+	vport_config->req_qs_chunks = NULL;
 
 	aq.vport_id = cpu_to_le32(vport->vport_id);
 	aq.num_tx_q = cpu_to_le16(num_tx_q);
@@ -2638,47 +2529,33 @@ int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
 	aq.num_rx_q = cpu_to_le16(num_rx_q);
 	aq.num_rx_bufq = cpu_to_le16(num_rx_bufq);
 
-	mutex_lock(&((struct idpf_vport *)vport)->vc_buf_lock);
-
-	err = idpf_send_mb_msg(adapter, VIRTCHNL2_OP_ADD_QUEUES,
-			       sizeof(struct virtchnl2_add_queues), (u8 *)&aq, 0);
-	if (err)
-		goto rel_lock;
-
-	/* We want vport to be const to prevent incidental code changes making
-	 * changes to the vport config. We're making a special exception here
-	 * to discard const to use the virtchnl.
-	 */
-	err = idpf_wait_for_event(adapter, (struct idpf_vport *)vport,
-				  IDPF_VC_ADD_QUEUES, IDPF_VC_ADD_QUEUES_ERR);
-	if (err)
-		goto rel_lock;
-
-	kfree(vport_config->req_qs_chunks);
-	vport_config->req_qs_chunks = NULL;
+	xn_params.vc_op = VIRTCHNL2_OP_ADD_QUEUES;
+	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
+	xn_params.send_buf.iov_base = &aq;
+	xn_params.send_buf.iov_len = sizeof(aq);
+	xn_params.recv_buf.iov_base = vc_msg;
+	xn_params.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN;
+	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+	if (reply_sz < 0)
+		return reply_sz;
 
-	vc_msg = (struct virtchnl2_add_queues *)vport->vc_msg;
 	/* compare vc_msg num queues with vport num queues */
 	if (le16_to_cpu(vc_msg->num_tx_q) != num_tx_q ||
 	    le16_to_cpu(vc_msg->num_rx_q) != num_rx_q ||
 	    le16_to_cpu(vc_msg->num_tx_complq) != num_complq ||
-	    le16_to_cpu(vc_msg->num_rx_bufq) != num_rx_bufq) {
-		err = -EINVAL;
-		goto rel_lock;
-	}
+	    le16_to_cpu(vc_msg->num_rx_bufq) != num_rx_bufq)
+		return -EINVAL;
 
 	size = struct_size(vc_msg, chunks.chunks,
 			   le16_to_cpu(vc_msg->chunks.num_chunks));
-	vport_config->req_qs_chunks = kmemdup(vc_msg, size, GFP_KERNEL);
-	if (!vport_config->req_qs_chunks) {
-		err = -ENOMEM;
-		goto rel_lock;
-	}
+	if (reply_sz < size)
+		return -EIO;
 
-rel_lock:
-	mutex_unlock(&((struct idpf_vport *)vport)->vc_buf_lock);
+	vport_config->req_qs_chunks = kmemdup(vc_msg, size, GFP_KERNEL);
+	if (!vport_config->req_qs_chunks)
+		return -ENOMEM;
 
-	return err;
+	return 0;
 }
 
 /**
-- 
2.41.0


