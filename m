Return-Path: <netdev+bounces-64862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4166837508
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB5D287004
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E966482C3;
	Mon, 22 Jan 2024 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8K/cR0m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1EF481AA
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957914; cv=none; b=aUmpLSqWAurmYlkOAJtTsQTn8DSCGg47l07KWifwY5/ak6VDHiIr1R45Q7Zvor80POauYV4emFnVW/6o88l27l0iu6eO1vAnu8ldjhwbZ9dBCEvRUavy68RrlrOizH4UpOezhLM6w6vwtzglsb8TIAjghXGUcI8yPZU/sa+lYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957914; c=relaxed/simple;
	bh=Wg1BSOqUGL2Q418Pq8sOVJHJspd+D03+mf8kMB5/+oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+2sdcyfuc66qv65X7Cty7cozvdfuW9TeoDvqY7gFWrtx7YLdD7Tly+/K/K5xdJZvx2v3tXfWbwIlGy7h5ZGpL2l0NDFD5FSp+2re51s2kSCPxDgQVqc9AaC0l7K1Smnu80VLKKSo9jPAj1k/g0WT9MwH2UABye8aVQZhVnqjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8K/cR0m; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705957913; x=1737493913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wg1BSOqUGL2Q418Pq8sOVJHJspd+D03+mf8kMB5/+oo=;
  b=d8K/cR0m5TGLkmrwhE8nXMkB5P+n2I7HGNbX3v4M7bkdL7ByMGIMckkO
   vC2oalW64scvHzDtP2IKvczt5u7NWcnuYKj5EASWM5w4WWuktkt+ZJr1I
   SSJKoIog+HZyNTuDi4WDHCyjy4ALovAiE9iWOZNj+hghvCUdezrr/cRWm
   r5HNSRtA8MG0aZhVOKl5sVkiwGUp9+epZqIiOb37J00KsWegvRX05hvPb
   +14vv70OrwHv9kjb0yzlXZ2xhzbKDXrgqbaLZRbmNYvEuGM4XLoyLd+ne
   SrMFEcfcvAUBe6Maxt/CTMoKvqKiUdRzmwVuhOzVSE1YJAZR8grEZVYt3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="19897145"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="19897145"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 13:11:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="27494338"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by orviesa002.jf.intel.com with ESMTP; 22 Jan 2024 13:11:52 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH 5/6 iwl-next] idpf: refactor idpf_recv_mb_msg
Date: Mon, 22 Jan 2024 13:11:24 -0800
Message-Id: <20240122211125.840833-6-alan.brady@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122211125.840833-1-alan.brady@intel.com>
References: <20240122211125.840833-1-alan.brady@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all the messages are using the transaction API, we can rework
idpf_recv_mb_msg quite a lot to simplify it. Due to this, we remove
idpf_find_vport as no longer used and alter idpf_recv_event_msg
slightly.

Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |   3 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 254 +++---------------
 3 files changed, 35 insertions(+), 224 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 393f6e46012f..2d5449b9288a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -1031,8 +1031,7 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport);
 int idpf_get_vec_ids(struct idpf_adapter *adapter,
 		     u16 *vecids, int num_vecids,
 		     struct virtchnl2_vector_chunks *chunks);
-int idpf_recv_mb_msg(struct idpf_adapter *adapter, u32 op,
-		     void *msg, int msg_size);
+int idpf_recv_mb_msg(struct idpf_adapter *adapter);
 int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
 		     u16 msg_size, u8 *msg, u16 cookie);
 void idpf_set_ethtool_ops(struct net_device *netdev);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index f027acd93843..edb47730b697 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1251,7 +1251,7 @@ void idpf_mbx_task(struct work_struct *work)
 		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task,
 				   msecs_to_jiffies(300));
 
-	idpf_recv_mb_msg(adapter, VIRTCHNL2_OP_UNKNOWN, NULL, 0);
+	idpf_recv_mb_msg(adapter);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index bde7a42206a4..0f3788610b43 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -63,12 +63,12 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
 
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
@@ -76,7 +76,7 @@ static void idpf_recv_event_msg(struct idpf_vport *vport,
 	u32 event;
 
 	if (payload_size < sizeof(*v2e)) {
-		dev_err_ratelimited(&vport->adapter->pdev->dev, "Failed to receive valid payload for event msg (op %d len %d)\n",
+		dev_err_ratelimited(&adapter->pdev->dev, "Failed to receive valid payload for event msg (op %d len %d)\n",
 				    ctlq_msg->cookie.mbx.chnl_opcode,
 				    payload_size);
 		return;
@@ -87,10 +87,10 @@ static void idpf_recv_event_msg(struct idpf_vport *vport,
 
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
@@ -212,125 +212,6 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
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
@@ -702,119 +583,50 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
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
-
-	while (1) {
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
+	int post_err, err = 0;
+	u16 num_recv;
 
-		/* If we are here a message is received. Check if we are looking
-		 * for a specific message based on opcode. If it is different
-		 * ignore and post buffers
+	while (!err) {
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
 
-		err = idpf_ctlq_post_rx_buffs(&adapter->hw, adapter->hw.arq,
-					      &num_q_msg, &dma_mem);
-		/* If post failed clear the only buffer we supplied */
-		if (err && dma_mem)
-			dma_free_coherent(&adapter->pdev->dev, dma_mem->size,
-					  dma_mem->va, dma_mem->pa);
+		post_err = idpf_ctlq_post_rx_buffs(&adapter->hw,
+						   adapter->hw.arq,
+						   &num_recv, &dma_mem);
 
-		/* Applies only if we are looking for a specific opcode */
-		if (work_done)
+		/* If post failed clear the only buffer we supplied */
+		if (post_err) {
+			if (dma_mem)
+				dmam_free_coherent(&adapter->pdev->dev,
+						   dma_mem->size, dma_mem->va,
+						   dma_mem->pa);
 			break;
+		}
 	}
 
 	return err;
-- 
2.40.1


