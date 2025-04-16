Return-Path: <netdev+bounces-183507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CCAA90DB2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 23:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C6E3BDACF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BFA24A057;
	Wed, 16 Apr 2025 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzfTB1A5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802F524888C
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744838351; cv=none; b=uvl44eQi6MzmZAhJMDgpoKYEdUm9/EUwAY8JPWpfZfPVirOMyDBG+wGLi4AR0SUr9tdwC8brC5nO+3c6b/l6j7qOJflf9iSimNcaPXZaZVf5q9A600ael+ER+VDNkU5z4io94xoGygsNVX4h0JmaDAGP/DhIsYzAemSol69FpfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744838351; c=relaxed/simple;
	bh=g6wdpB1WmaAmXE+ORLe1HAbjuAVXoHlcS9yNMmCsjqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONO9A5fUtCP8zEAKTXzPWCXI9cViOnlwAuCvkiK4ggyKUQdTVb2tk9lOx3ab5CMCXaMVOOxUuxItyXYz33ejMjpS32KCeKOvBJ5uvOAH7WFW4iMLVMCi1gaKin1bdvxDxijeswFecuGKh1gNhgmgq2XYCP/YrLDy1o8RD1eNsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzfTB1A5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744838349; x=1776374349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6wdpB1WmaAmXE+ORLe1HAbjuAVXoHlcS9yNMmCsjqc=;
  b=QzfTB1A5koxoXfCL+TT/WV2WvhRRVhWbT0iildlgTbCh4lpTPQV4PD3H
   zh7Ph5LiQ+d78BGR6EtWDQxy4XzMxnksPa3GRmHmtXrJ1+AnX7Eicb/8t
   A5uGuko5TiLJJ7MLSaxitYNwgszhTO6Cl7+Bcw/iQUWzWqRSB7vxvpzDe
   zmjwI9VEcjxWC+PKTiLy99huw6nRugWIR9EE4P/4Ilrxxc7AAomltu+Za
   /ldsFEUT8gpTmXtxyMjMLcwf9EYeUn2lBC5xHDg24oCQq1Ep/a/Eha3rA
   xE5KTXtKQtOiTSp+GjHbSP1btAfcJBJTzifBA3jGxN+TF0wtFTGk7I1AN
   g==;
X-CSE-ConnectionGUID: BlZtwoMzRUSDhcrwRWIIVA==
X-CSE-MsgGUID: OQGy6g0JSsy7X9sDo3vWaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46496250"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46496250"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 14:19:02 -0700
X-CSE-ConnectionGUID: jaQEfTs0Tl2dHVKGFcMP7g==
X-CSE-MsgGUID: 9EqELcrKTP+ubEzn3xI6SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130909775"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.55])
  by fmviesa008.fm.intel.com with ESMTP; 16 Apr 2025 14:19:02 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	milena.olech@intel.com,
	anton.nadezhdin@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [PATCH iwl-next 9/9] idpf: generalize mailbox API
Date: Wed, 16 Apr 2025 14:18:21 -0700
Message-ID: <20250416211821.444076-10-pavan.kumar.linga@intel.com>
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

Add a control queue parameter to all mailbox APIs in order to
make use of those APIs for non-default mailbox as well.

Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  3 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 33 ++++++++++---------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  6 ++--
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index af0f036c561d..de765e92e29f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1197,7 +1197,7 @@ void idpf_mbx_task(struct work_struct *work)
 		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task,
 				   msecs_to_jiffies(300));
 
-	idpf_recv_mb_msg(adapter);
+	idpf_recv_mb_msg(adapter, adapter->hw.arq);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index 0bb07bcb974b..ac091280e828 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -146,7 +146,8 @@ static void idpf_vf_trigger_reset(struct idpf_adapter *adapter,
 	/* Do not send VIRTCHNL2_OP_RESET_VF message on driver unload */
 	if (trig_cause == IDPF_HR_FUNC_RESET &&
 	    !test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
-		idpf_send_mb_msg(adapter, VIRTCHNL2_OP_RESET_VF, 0, NULL, 0);
+		idpf_send_mb_msg(adapter, adapter->hw.asq,
+				 VIRTCHNL2_OP_RESET_VF, 0, NULL, 0);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index c201fd08dcbf..2195c6d4956d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -197,13 +197,15 @@ static void idpf_recv_event_msg(struct idpf_adapter *adapter,
 
 /**
  * idpf_mb_clean - Reclaim the send mailbox queue entries
- * @adapter: Driver specific private structure
+ * @adapter: driver specific private structure
+ * @asq: send control queue info
  *
  * Reclaim the send mailbox queue entries to be used to send further messages
  *
  * Returns 0 on success, negative on failure
  */
-static int idpf_mb_clean(struct idpf_adapter *adapter)
+static int idpf_mb_clean(struct idpf_adapter *adapter,
+			 struct idpf_ctlq_info *asq)
 {
 	u16 i, num_q_msg = IDPF_DFLT_MBX_Q_LEN;
 	struct idpf_ctlq_msg **q_msg;
@@ -214,7 +216,7 @@ static int idpf_mb_clean(struct idpf_adapter *adapter)
 	if (!q_msg)
 		return -ENOMEM;
 
-	err = idpf_ctlq_clean_sq(adapter->hw.asq, &num_q_msg, q_msg);
+	err = idpf_ctlq_clean_sq(asq, &num_q_msg, q_msg);
 	if (err)
 		goto err_kfree;
 
@@ -237,7 +239,8 @@ static int idpf_mb_clean(struct idpf_adapter *adapter)
 
 /**
  * idpf_send_mb_msg - Send message over mailbox
- * @adapter: Driver specific private structure
+ * @adapter: driver specific private structure
+ * @asq: control queue to send message to
  * @op: virtchnl opcode
  * @msg_size: size of the payload
  * @msg: pointer to buffer holding the payload
@@ -247,8 +250,8 @@ static int idpf_mb_clean(struct idpf_adapter *adapter)
  *
  * Returns 0 on success, negative on failure
  */
-int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
-		     u16 msg_size, u8 *msg, u16 cookie)
+int idpf_send_mb_msg(struct idpf_adapter *adapter, struct idpf_ctlq_info *asq,
+		     u32 op, u16 msg_size, u8 *msg, u16 cookie)
 {
 	struct idpf_ctlq_msg *ctlq_msg;
 	struct idpf_dma_mem *dma_mem;
@@ -262,7 +265,7 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
 	if (idpf_is_reset_detected(adapter))
 		return 0;
 
-	err = idpf_mb_clean(adapter);
+	err = idpf_mb_clean(adapter, asq);
 	if (err)
 		return err;
 
@@ -295,7 +298,7 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
 	ctlq_msg->ctx.indirect.payload = dma_mem;
 	ctlq_msg->ctx.sw_cookie.data = cookie;
 
-	err = idpf_ctlq_send(&adapter->hw, adapter->hw.asq, 1, ctlq_msg);
+	err = idpf_ctlq_send(&adapter->hw, asq, 1, ctlq_msg);
 	if (err)
 		goto send_error;
 
@@ -491,7 +494,7 @@ static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
 	cookie = FIELD_PREP(IDPF_VC_XN_SALT_M, xn->salt) |
 		 FIELD_PREP(IDPF_VC_XN_IDX_M, xn->idx);
 
-	retval = idpf_send_mb_msg(adapter, params->vc_op,
+	retval = idpf_send_mb_msg(adapter, adapter->hw.asq, params->vc_op,
 				  send_buf->iov_len, send_buf->iov_base,
 				  cookie);
 	if (retval) {
@@ -690,12 +693,13 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 
 /**
  * idpf_recv_mb_msg - Receive message over mailbox
- * @adapter: Driver specific private structure
+ * @adapter: driver specific private structure
+ * @arq: control queue to receive message from
  *
  * Will receive control queue message and posts the receive buffer. Returns 0
  * on success and negative on failure.
  */
-int idpf_recv_mb_msg(struct idpf_adapter *adapter)
+int idpf_recv_mb_msg(struct idpf_adapter *adapter, struct idpf_ctlq_info *arq)
 {
 	struct idpf_ctlq_msg ctlq_msg;
 	struct idpf_dma_mem *dma_mem;
@@ -707,7 +711,7 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter)
 		 * actually received on num_recv.
 		 */
 		num_recv = 1;
-		err = idpf_ctlq_recv(adapter->hw.arq, &num_recv, &ctlq_msg);
+		err = idpf_ctlq_recv(arq, &num_recv, &ctlq_msg);
 		if (err || !num_recv)
 			break;
 
@@ -723,8 +727,7 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter)
 		else
 			err = idpf_vc_xn_forward_reply(adapter, &ctlq_msg);
 
-		post_err = idpf_ctlq_post_rx_buffs(&adapter->hw,
-						   adapter->hw.arq,
+		post_err = idpf_ctlq_post_rx_buffs(&adapter->hw, arq,
 						   &num_recv, &dma_mem);
 
 		/* If post failed clear the only buffer we supplied */
@@ -2818,7 +2821,7 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
 void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter)
 {
 	if (adapter->hw.arq && adapter->hw.asq) {
-		idpf_mb_clean(adapter);
+		idpf_mb_clean(adapter, adapter->hw.asq);
 		idpf_ctlq_deinit(&adapter->hw);
 	}
 	adapter->hw.arq = NULL;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 169b06800878..fcb504291450 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -25,9 +25,9 @@ int idpf_vport_queue_ids_init(struct idpf_vport *vport,
 			      struct idpf_q_vec_rsrc *rsrc,
 			      struct idpf_queue_id_reg_info *chunks);
 
-int idpf_recv_mb_msg(struct idpf_adapter *adapter);
-int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
-		     u16 msg_size, u8 *msg, u16 cookie);
+int idpf_recv_mb_msg(struct idpf_adapter *adapter, struct idpf_ctlq_info *arq);
+int idpf_send_mb_msg(struct idpf_adapter *adapter, struct idpf_ctlq_info *asq,
+		     u32 op, u16 msg_size, u8 *msg, u16 cookie);
 
 int idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q);
 u32 idpf_get_vport_id(struct idpf_vport *vport);
-- 
2.43.0


