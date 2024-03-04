Return-Path: <netdev+bounces-77238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E713E870C1E
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D3BB245C2
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167AA7B3DE;
	Mon,  4 Mar 2024 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcTVYooH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8604CE04
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586332; cv=none; b=UMGiuHbl1k+nfNuGYwiHSxnC0+yfuFrlPtVdOMRwISfqkINC6aYyC3ip1Nll3MQXk4WePLktZSInyeHvkCrp5wPFHWbR5phH+mE3qXJn/tTXpfFx1SSK70CjL2y5M2KnQQxCuVmj3LBS43e6gULId+aF9ww6krzeO1nPU9Id+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586332; c=relaxed/simple;
	bh=uTrxLfN28LNmHlcBrqBjWphqXKlRUDFaL+04UTveYoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQ3LOdt1cu/VUTLvZmYLTd6rrPRcIEGeWWqZbMLT2TgfCqepvcdjpUI0vWekZpHLpwlWwC0DAB7aFH5Vj4XNH6MVhzkhZ/MEEp5hentzADsEKbuH0KlczAi6gBWJZsGI37exWbX7uysqugvVPGB8D/7XbVwakqdvIPOJOxa1IAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcTVYooH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709586330; x=1741122330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uTrxLfN28LNmHlcBrqBjWphqXKlRUDFaL+04UTveYoY=;
  b=ZcTVYooHwhpl9xjZNNpSldgjwPkp9JC2J7EuGYETGa6TD+KDihXuCHZt
   tj24+oi39NGD1vQ8E/JodtaOaBwr5RAp73z+uY7dM3z8JfQZi1lSui+MF
   SdsUEcybQY/FVTvcC2b4otBFpzkc+WZHXm9ix7O5XCTpcyS8AJfo9UO+F
   wfrZyB0BPZCjfJUXJVu5ltts0F34SkHZESTHPBKQzLBauIfYH0qAbEbjM
   FUAhtahWX7NspXYbzkmFrOLsoh3ks6N6p9UGqaEwiGYHI9aHe+h7u3o8Y
   2/Lj9Mh7JXkgbeRlCIGHTXTPyoVCg1Qt4L/LMlhGmVvzfXafkOZfBtfrY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21561105"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="21561105"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9539741"
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
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net-next 07/11] idpf: refactor idpf_recv_mb_msg
Date: Mon,  4 Mar 2024 13:05:07 -0800
Message-ID: <20240304210514.3412298-8-anthony.l.nguyen@intel.com>
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

Now that all the messages are using the transaction API, we can rework
idpf_recv_mb_msg quite a lot to simplify it. Due to this, we remove
idpf_find_vport as no longer used and alter idpf_recv_event_msg
slightly.

Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 254 +++---------------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   3 +-
 3 files changed, 37 insertions(+), 222 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 96c0b6d38799..4c6c7b9db762 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1254,7 +1254,7 @@ void idpf_mbx_task(struct work_struct *work)
 		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task,
 				   msecs_to_jiffies(300));
 
-	idpf_recv_mb_msg(adapter, VIRTCHNL2_OP_UNKNOWN, NULL, 0);
+	idpf_recv_mb_msg(adapter);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d1107507a98c..cf8aff26c3a9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -160,12 +160,12 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
 
 /**
  * idpf_recv_event_msg - Receive virtchnl event message
- * @vport: virtual port structure
+ * @adapter: Driver specific private structure
  * @ctlq_msg: message to copy from
  *
  * Receive virtchnl event message
  */
-static void idpf_recv_event_msg(struct idpf_vport *vport,
+static void idpf_recv_event_msg(struct idpf_adapter *adapter,
 				struct idpf_ctlq_msg *ctlq_msg)
 {
 	int payload_size = ctlq_msg->ctx.indirect.payload->size;
@@ -173,7 +173,7 @@ static void idpf_recv_event_msg(struct idpf_vport *vport,
 	u32 event;
 
 	if (payload_size < sizeof(*v2e)) {
-		dev_err_ratelimited(&vport->adapter->pdev->dev, "Failed to receive valid payload for event msg (op %d len %d)\n",
+		dev_err_ratelimited(&adapter->pdev->dev, "Failed to receive valid payload for event msg (op %d len %d)\n",
 				    ctlq_msg->cookie.mbx.chnl_opcode,
 				    payload_size);
 		return;
@@ -184,10 +184,10 @@ static void idpf_recv_event_msg(struct idpf_vport *vport,
 
 	switch (event) {
 	case VIRTCHNL2_EVENT_LINK_CHANGE:
-		idpf_handle_event_link(vport->adapter, v2e);
+		idpf_handle_event_link(adapter, v2e);
 		return;
 	default:
-		dev_err(&vport->adapter->pdev->dev,
+		dev_err(&adapter->pdev->dev,
 			"Unknown event %d from PF\n", event);
 		break;
 	}
@@ -310,125 +310,6 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
 	return err;
 }
 
-/**
- * idpf_find_vport - Find vport pointer from control queue message
- * @adapter: driver specific private structure
- * @vport: address of vport pointer to copy the vport from adapters vport list
- * @ctlq_msg: control queue message
- *
- * Return 0 on success, error value on failure. Also this function does check
- * for the opcodes which expect to receive payload and return error value if
- * it is not the case.
- */
-static int idpf_find_vport(struct idpf_adapter *adapter,
-			   struct idpf_vport **vport,
-			   struct idpf_ctlq_msg *ctlq_msg)
-{
-	bool no_op = false, vid_found = false;
-	int i, err = 0;
-	char *vc_msg;
-	u32 v_id;
-
-	vc_msg = kcalloc(IDPF_CTLQ_MAX_BUF_LEN, sizeof(char), GFP_KERNEL);
-	if (!vc_msg)
-		return -ENOMEM;
-
-	if (ctlq_msg->data_len) {
-		size_t payload_size = ctlq_msg->ctx.indirect.payload->size;
-
-		if (!payload_size) {
-			dev_err(&adapter->pdev->dev, "Failed to receive payload buffer\n");
-			kfree(vc_msg);
-
-			return -EINVAL;
-		}
-
-		memcpy(vc_msg, ctlq_msg->ctx.indirect.payload->va,
-		       min_t(size_t, payload_size, IDPF_CTLQ_MAX_BUF_LEN));
-	}
-
-	switch (ctlq_msg->cookie.mbx.chnl_opcode) {
-	case VIRTCHNL2_OP_VERSION:
-	case VIRTCHNL2_OP_GET_CAPS:
-	case VIRTCHNL2_OP_CREATE_VPORT:
-	case VIRTCHNL2_OP_SET_SRIOV_VFS:
-	case VIRTCHNL2_OP_ALLOC_VECTORS:
-	case VIRTCHNL2_OP_DEALLOC_VECTORS:
-	case VIRTCHNL2_OP_GET_PTYPE_INFO:
-		goto free_vc_msg;
-	case VIRTCHNL2_OP_ENABLE_VPORT:
-	case VIRTCHNL2_OP_DISABLE_VPORT:
-	case VIRTCHNL2_OP_DESTROY_VPORT:
-		v_id = le32_to_cpu(((struct virtchnl2_vport *)vc_msg)->vport_id);
-		break;
-	case VIRTCHNL2_OP_CONFIG_TX_QUEUES:
-		v_id = le32_to_cpu(((struct virtchnl2_config_tx_queues *)vc_msg)->vport_id);
-		break;
-	case VIRTCHNL2_OP_CONFIG_RX_QUEUES:
-		v_id = le32_to_cpu(((struct virtchnl2_config_rx_queues *)vc_msg)->vport_id);
-		break;
-	case VIRTCHNL2_OP_ENABLE_QUEUES:
-	case VIRTCHNL2_OP_DISABLE_QUEUES:
-	case VIRTCHNL2_OP_DEL_QUEUES:
-		v_id = le32_to_cpu(((struct virtchnl2_del_ena_dis_queues *)vc_msg)->vport_id);
-		break;
-	case VIRTCHNL2_OP_ADD_QUEUES:
-		v_id = le32_to_cpu(((struct virtchnl2_add_queues *)vc_msg)->vport_id);
-		break;
-	case VIRTCHNL2_OP_MAP_QUEUE_VECTOR:
-	case VIRTCHNL2_OP_UNMAP_QUEUE_VECTOR:
-		v_id = le32_to_cpu(((struct virtchnl2_queue_vector_maps *)vc_msg)->vport_id);
-		break;
-	case VIRTCHNL2_OP_GET_STATS:
-		v_id = le32_to_cpu(((struct virtchnl2_vport_stats *)vc_msg)->vport_id);
-		break;
-	case VIRTCHNL2_OP_GET_RSS_LUT:
-	case VIRTCHNL2_OP_SET_RSS_LUT:
-		v_id = le32_to_cpu(((struct virtchnl2_rss_lut *)vc_msg)->vport_id);
-		break;
-	case VIRTCHNL2_OP_GET_RSS_KEY:
-	case VIRTCHNL2_OP_SET_RSS_KEY:
-		v_id = le32_to_cpu(((struct virtchnl2_rss_key *)vc_msg)->vport_id);
-		break;
-	case VIRTCHNL2_OP_EVENT:
-		v_id = le32_to_cpu(((struct virtchnl2_event *)vc_msg)->vport_id);
-		break;
-	case VIRTCHNL2_OP_LOOPBACK:
-		v_id = le32_to_cpu(((struct virtchnl2_loopback *)vc_msg)->vport_id);
-		break;
-	case VIRTCHNL2_OP_CONFIG_PROMISCUOUS_MODE:
-		v_id = le32_to_cpu(((struct virtchnl2_promisc_info *)vc_msg)->vport_id);
-		break;
-	case VIRTCHNL2_OP_ADD_MAC_ADDR:
-	case VIRTCHNL2_OP_DEL_MAC_ADDR:
-		v_id = le32_to_cpu(((struct virtchnl2_mac_addr_list *)vc_msg)->vport_id);
-		break;
-	default:
-		no_op = true;
-		break;
-	}
-
-	if (no_op)
-		goto free_vc_msg;
-
-	for (i = 0; i < idpf_get_max_vports(adapter); i++) {
-		if (adapter->vport_ids[i] == v_id) {
-			vid_found = true;
-			break;
-		}
-	}
-
-	if (vid_found)
-		*vport = adapter->vports[i];
-	else
-		err = -EINVAL;
-
-free_vc_msg:
-	kfree(vc_msg);
-
-	return err;
-}
-
 /* API for virtchnl "transaction" support ("xn" for short).
  *
  * We are reusing the completion lock to serialize the accesses to the
@@ -804,118 +685,53 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 /**
  * idpf_recv_mb_msg - Receive message over mailbox
  * @adapter: Driver specific private structure
- * @op: virtchannel operation code
- * @msg: Received message holding buffer
- * @msg_size: message size
  *
  * Will receive control queue message and posts the receive buffer. Returns 0
  * on success and negative on failure.
  */
-int idpf_recv_mb_msg(struct idpf_adapter *adapter, u32 op,
-		     void *msg, int msg_size)
+int idpf_recv_mb_msg(struct idpf_adapter *adapter)
 {
-	struct idpf_vport *vport = NULL;
 	struct idpf_ctlq_msg ctlq_msg;
 	struct idpf_dma_mem *dma_mem;
-	bool work_done = false;
-	int num_retry = 2000;
-	u16 num_q_msg;
-	int err;
+	int post_err, err;
+	u16 num_recv;
 
 	while (1) {
-		/* Try to get one message */
-		num_q_msg = 1;
-		dma_mem = NULL;
-		err = idpf_ctlq_recv(adapter->hw.arq, &num_q_msg, &ctlq_msg);
-		/* If no message then decide if we have to retry based on
-		 * opcode
-		 */
-		if (err || !num_q_msg) {
-			/* Increasing num_retry to consider the delayed
-			 * responses because of large number of VF's mailbox
-			 * messages. If the mailbox message is received from
-			 * the other side, we come out of the sleep cycle
-			 * immediately else we wait for more time.
-			 */
-			if (!op || !num_retry--)
-				break;
-			if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags)) {
-				err = -EIO;
-				break;
-			}
-			msleep(20);
-			continue;
-		}
-
-		/* If we are here a message is received. Check if we are looking
-		 * for a specific message based on opcode. If it is different
-		 * ignore and post buffers
+		/* This will get <= num_recv messages and output how many
+		 * actually received on num_recv.
 		 */
-		if (op && ctlq_msg.cookie.mbx.chnl_opcode != op)
-			goto post_buffs;
-
-		err = idpf_find_vport(adapter, &vport, &ctlq_msg);
-		if (err)
-			goto post_buffs;
-
-		/* All conditions are met. Either a message requested is
-		 * received or we received a message to be processed
-		 */
-		switch (ctlq_msg.cookie.mbx.chnl_opcode) {
-		case VIRTCHNL2_OP_VERSION:
-		case VIRTCHNL2_OP_GET_CAPS:
-		case VIRTCHNL2_OP_CREATE_VPORT:
-		case VIRTCHNL2_OP_ENABLE_VPORT:
-		case VIRTCHNL2_OP_DISABLE_VPORT:
-		case VIRTCHNL2_OP_DESTROY_VPORT:
-		case VIRTCHNL2_OP_CONFIG_TX_QUEUES:
-		case VIRTCHNL2_OP_CONFIG_RX_QUEUES:
-		case VIRTCHNL2_OP_ENABLE_QUEUES:
-		case VIRTCHNL2_OP_DISABLE_QUEUES:
-		case VIRTCHNL2_OP_ADD_QUEUES:
-		case VIRTCHNL2_OP_DEL_QUEUES:
-		case VIRTCHNL2_OP_MAP_QUEUE_VECTOR:
-		case VIRTCHNL2_OP_UNMAP_QUEUE_VECTOR:
-		case VIRTCHNL2_OP_GET_STATS:
-		case VIRTCHNL2_OP_GET_RSS_LUT:
-		case VIRTCHNL2_OP_SET_RSS_LUT:
-		case VIRTCHNL2_OP_GET_RSS_KEY:
-		case VIRTCHNL2_OP_SET_RSS_KEY:
-		case VIRTCHNL2_OP_SET_SRIOV_VFS:
-		case VIRTCHNL2_OP_ALLOC_VECTORS:
-		case VIRTCHNL2_OP_DEALLOC_VECTORS:
-		case VIRTCHNL2_OP_GET_PTYPE_INFO:
-		case VIRTCHNL2_OP_LOOPBACK:
-		case VIRTCHNL2_OP_CONFIG_PROMISCUOUS_MODE:
-		case VIRTCHNL2_OP_ADD_MAC_ADDR:
-		case VIRTCHNL2_OP_DEL_MAC_ADDR:
-			err = idpf_vc_xn_forward_reply(adapter, &ctlq_msg);
-			break;
-		case VIRTCHNL2_OP_EVENT:
-			idpf_recv_event_msg(vport, &ctlq_msg);
+		num_recv = 1;
+		err = idpf_ctlq_recv(adapter->hw.arq, &num_recv, &ctlq_msg);
+		if (err || !num_recv)
 			break;
-		default:
-			dev_warn(&adapter->pdev->dev,
-				 "Unhandled virtchnl response %d\n",
-				 ctlq_msg.cookie.mbx.chnl_opcode);
-			break;
-		}
 
-post_buffs:
-		if (ctlq_msg.data_len)
+		if (ctlq_msg.data_len) {
 			dma_mem = ctlq_msg.ctx.indirect.payload;
+		} else {
+			dma_mem = NULL;
+			num_recv = 0;
+		}
+
+		if (ctlq_msg.cookie.mbx.chnl_opcode == VIRTCHNL2_OP_EVENT)
+			idpf_recv_event_msg(adapter, &ctlq_msg);
 		else
-			num_q_msg = 0;
+			err = idpf_vc_xn_forward_reply(adapter, &ctlq_msg);
+
+		post_err = idpf_ctlq_post_rx_buffs(&adapter->hw,
+						   adapter->hw.arq,
+						   &num_recv, &dma_mem);
 
-		err = idpf_ctlq_post_rx_buffs(&adapter->hw, adapter->hw.arq,
-					      &num_q_msg, &dma_mem);
 		/* If post failed clear the only buffer we supplied */
-		if (err && dma_mem)
-			dma_free_coherent(&adapter->pdev->dev, dma_mem->size,
-					  dma_mem->va, dma_mem->pa);
+		if (post_err) {
+			if (dma_mem)
+				dmam_free_coherent(&adapter->pdev->dev,
+						   dma_mem->size, dma_mem->va,
+						   dma_mem->pa);
+			break;
+		}
 
-		/* Applies only if we are looking for a specific opcode */
-		if (work_done)
+		/* virtchnl trying to shutdown, stop cleaning */
+		if (err == -ENXIO)
 			break;
 	}
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index f008c793e486..83da5d8da56b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -21,8 +21,7 @@ int idpf_get_reg_intr_vecs(struct idpf_vport *vport,
 int idpf_queue_reg_init(struct idpf_vport *vport);
 int idpf_vport_queue_ids_init(struct idpf_vport *vport);
 
-int idpf_recv_mb_msg(struct idpf_adapter *adapter, u32 op,
-		     void *msg, int msg_size);
+int idpf_recv_mb_msg(struct idpf_adapter *adapter);
 int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
 		     u16 msg_size, u8 *msg, u16 cookie);
 
-- 
2.41.0


