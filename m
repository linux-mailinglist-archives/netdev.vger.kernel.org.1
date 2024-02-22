Return-Path: <netdev+bounces-74124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA11860228
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 20:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83FB1F2AA1B
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFF214B83E;
	Thu, 22 Feb 2024 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mj4K7JhX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0756B3DB9A
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628697; cv=none; b=d5mEqsCbNr8P164DQrPDdMC9UymJwTT5k82OTBX8rAa5fyvj9rAF30XrgLvtHFfEZvrxBuM7z314yxJLHp+8e04BFyRycjzWjXiP98ASAnaQPUSpM6DZbcRPyooDaMZaILgUXZ/EIA1RXA9G/ZbiYAKdivuPkvxo0lag3pxeUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628697; c=relaxed/simple;
	bh=mJ/Lto9BZVdSSG17XAi0f4d4Ap4XrscyHwfIcNNEvSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBwOVqEOTrbiydqNL0Eop2eA+7oJgMhv8J9zS6LvgQtaTW7RfsI+6nSSweut1zD4UqPo3OlPpqRGmaTjMmpWJddpEWNh5+cwtvCsZUvDnwkPL3UextLk6RfDD2OWUHaLBYPymakulaUxLa4Ut6GgYFEcO998KlB9wZPHkbAo66g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mj4K7JhX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708628696; x=1740164696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mJ/Lto9BZVdSSG17XAi0f4d4Ap4XrscyHwfIcNNEvSE=;
  b=mj4K7JhXlLdpoBZkVFmIGWi5RYlFtyMFELLlMJ97+jlOI4IYh8CB8D/m
   BUfHj6gJjAJxmJW6BeFbRozz+ndvuRrHPdwLZcCO0KR6YkUp9zC3751Kp
   xLxF4fDZwU2m5DQK39GdcBe8HBEL/ThFvbnIWzBxlUSDuLHYTJ7NsuXKF
   OzTe14Kiv1gKRg9Bi26q/8eEDLs8zIYE82ugV53UNCP5VMXElpoyfXE0C
   rTcMzBG5yP8LGEZI8kiW3a9FBIuRGGxm3uuHrpEPoMvGaUkqE+AVTVLkq
   ClJUs0Zb0idvHRsBZWFzkd1h36HzyxNyQzDUJnCPFJWV471BwQj/9KjKy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13506366"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13506366"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 11:04:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10171189"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa004.fm.intel.com with ESMTP; 22 Feb 2024 11:04:55 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>
Subject: [PATCH v6 03/11 iwl-next] idpf: refactor vport virtchnl messages
Date: Thu, 22 Feb 2024 11:04:33 -0800
Message-ID: <20240222190441.2610930-4-alan.brady@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222190441.2610930-1-alan.brady@intel.com>
References: <20240222190441.2610930-1-alan.brady@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reworks the way vport related virtchnl messages work to take
advantage of the added transaction API. It is fairly mechanical as, to
use the transaction API, the function just needs to fill out an
appropriate idpf_vc_xn_params struct to pass to idpf_vc_xn_exec which
will take care of the actual send and recv.

Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 185 +++++++-----------
 1 file changed, 69 insertions(+), 116 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 95ca10f644b2..2dab7122615f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -858,7 +858,6 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter, u32 op,
 
 	while (1) {
 		struct idpf_vport_config *vport_config;
-		int payload_size = 0;
 
 		/* Try to get one message */
 		num_q_msg = 1;
@@ -895,47 +894,17 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter, u32 op,
 		if (err)
 			goto post_buffs;
 
-		if (ctlq_msg.data_len)
-			payload_size = ctlq_msg.ctx.indirect.payload->size;
-
 		/* All conditions are met. Either a message requested is
 		 * received or we received a message to be processed
 		 */
 		switch (ctlq_msg.cookie.mbx.chnl_opcode) {
 		case VIRTCHNL2_OP_VERSION:
-			err = idpf_vc_xn_forward_reply(adapter, &ctlq_msg);
-			break;
 		case VIRTCHNL2_OP_GET_CAPS:
-			if (ctlq_msg.cookie.mbx.chnl_retval) {
-				dev_err(&adapter->pdev->dev, "Failure initializing, vc op: %u retval: %u\n",
-					ctlq_msg.cookie.mbx.chnl_opcode,
-					ctlq_msg.cookie.mbx.chnl_retval);
-				err = -EBADMSG;
-			} else if (msg) {
-				memcpy(msg, ctlq_msg.ctx.indirect.payload->va,
-				       min_t(int, payload_size, msg_size));
-			}
-			work_done = true;
-			break;
 		case VIRTCHNL2_OP_CREATE_VPORT:
-			idpf_recv_vchnl_op(adapter, NULL, &ctlq_msg,
-					   IDPF_VC_CREATE_VPORT,
-					   IDPF_VC_CREATE_VPORT_ERR);
-			break;
 		case VIRTCHNL2_OP_ENABLE_VPORT:
-			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
-					   IDPF_VC_ENA_VPORT,
-					   IDPF_VC_ENA_VPORT_ERR);
-			break;
 		case VIRTCHNL2_OP_DISABLE_VPORT:
-			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
-					   IDPF_VC_DIS_VPORT,
-					   IDPF_VC_DIS_VPORT_ERR);
-			break;
 		case VIRTCHNL2_OP_DESTROY_VPORT:
-			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
-					   IDPF_VC_DESTROY_VPORT,
-					   IDPF_VC_DESTROY_VPORT_ERR);
+			err = idpf_vc_xn_forward_reply(adapter, &ctlq_msg);
 			break;
 		case VIRTCHNL2_OP_CONFIG_TX_QUEUES:
 			idpf_recv_vchnl_op(adapter, vport, &ctlq_msg,
@@ -1322,7 +1291,9 @@ static int idpf_send_ver_msg(struct idpf_adapter *adapter)
  */
 static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 {
-	struct virtchnl2_get_capabilities caps = { };
+	struct virtchnl2_get_capabilities caps = {};
+	struct idpf_vc_xn_params xn_params = {};
+	ssize_t reply_sz;
 
 	caps.csum_caps =
 		cpu_to_le32(VIRTCHNL2_CAP_TX_CSUM_L3_IPV4	|
@@ -1379,21 +1350,20 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 			    VIRTCHNL2_CAP_PROMISC		|
 			    VIRTCHNL2_CAP_LOOPBACK);
 
-	return idpf_send_mb_msg(adapter, VIRTCHNL2_OP_GET_CAPS, sizeof(caps),
-				(u8 *)&caps, 0);
-}
+	xn_params.vc_op = VIRTCHNL2_OP_GET_CAPS;
+	xn_params.send_buf.iov_base = &caps;
+	xn_params.send_buf.iov_len = sizeof(caps);
+	xn_params.recv_buf.iov_base = &adapter->caps;
+	xn_params.recv_buf.iov_len = sizeof(adapter->caps);
+	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 
-/**
- * idpf_recv_get_caps_msg - Receive virtchnl get capabilities message
- * @adapter: Driver specific private structure
- *
- * Receive virtchnl get capabilities message. Returns 0 on success, negative on
- * failure.
- */
-static int idpf_recv_get_caps_msg(struct idpf_adapter *adapter)
-{
-	return idpf_recv_mb_msg(adapter, VIRTCHNL2_OP_GET_CAPS, &adapter->caps,
-				sizeof(struct virtchnl2_get_capabilities));
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
+	if (reply_sz < 0)
+		return reply_sz;
+	if (reply_sz < sizeof(adapter->caps))
+		return -EIO;
+
+	return 0;
 }
 
 /**
@@ -1720,8 +1690,10 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 			       struct idpf_vport_max_q *max_q)
 {
 	struct virtchnl2_create_vport *vport_msg;
+	struct idpf_vc_xn_params xn_params = {};
 	u16 idx = adapter->next_vport;
 	int err, buf_size;
+	ssize_t reply_sz;
 
 	buf_size = sizeof(struct virtchnl2_create_vport);
 	if (!adapter->vport_params_reqd[idx]) {
@@ -1752,35 +1724,38 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 		return err;
 	}
 
-	mutex_lock(&adapter->vc_buf_lock);
-
-	err = idpf_send_mb_msg(adapter, VIRTCHNL2_OP_CREATE_VPORT, buf_size,
-			       (u8 *)vport_msg, 0);
-	if (err)
-		goto rel_lock;
-
-	err = idpf_wait_for_event(adapter, NULL, IDPF_VC_CREATE_VPORT,
-				  IDPF_VC_CREATE_VPORT_ERR);
-	if (err) {
-		dev_err(&adapter->pdev->dev, "Failed to receive create vport message");
-
-		goto rel_lock;
-	}
-
 	if (!adapter->vport_params_recvd[idx]) {
 		adapter->vport_params_recvd[idx] = kzalloc(IDPF_CTLQ_MAX_BUF_LEN,
 							   GFP_KERNEL);
 		if (!adapter->vport_params_recvd[idx]) {
 			err = -ENOMEM;
-			goto rel_lock;
+			goto free_vport_params;
 		}
 	}
 
-	vport_msg = adapter->vport_params_recvd[idx];
-	memcpy(vport_msg, adapter->vc_msg, IDPF_CTLQ_MAX_BUF_LEN);
+	xn_params.vc_op = VIRTCHNL2_OP_CREATE_VPORT;
+	xn_params.send_buf.iov_base = vport_msg;
+	xn_params.send_buf.iov_len = buf_size;
+	xn_params.recv_buf.iov_base = adapter->vport_params_recvd[idx];
+	xn_params.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN;
+	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
+	if (reply_sz < 0) {
+		err = reply_sz;
+		goto free_vport_params;
+	}
+	if (reply_sz < IDPF_CTLQ_MAX_BUF_LEN) {
+		err = -EIO;
+		goto free_vport_params;
+	}
 
-rel_lock:
-	mutex_unlock(&adapter->vc_buf_lock);
+	return 0;
+
+free_vport_params:
+	kfree(adapter->vport_params_recvd[idx]);
+	adapter->vport_params_recvd[idx] = NULL;
+	kfree(adapter->vport_params_reqd[idx]);
+	adapter->vport_params_reqd[idx] = NULL;
 
 	return err;
 }
@@ -1832,26 +1807,19 @@ int idpf_check_supported_desc_ids(struct idpf_vport *vport)
  */
 int idpf_send_destroy_vport_msg(struct idpf_vport *vport)
 {
-	struct idpf_adapter *adapter = vport->adapter;
+	struct idpf_vc_xn_params xn_params = {};
 	struct virtchnl2_vport v_id;
-	int err;
+	ssize_t reply_sz;
 
 	v_id.vport_id = cpu_to_le32(vport->vport_id);
 
-	mutex_lock(&vport->vc_buf_lock);
-
-	err = idpf_send_mb_msg(adapter, VIRTCHNL2_OP_DESTROY_VPORT,
-			       sizeof(v_id), (u8 *)&v_id, 0);
-	if (err)
-		goto rel_lock;
-
-	err = idpf_min_wait_for_event(adapter, vport, IDPF_VC_DESTROY_VPORT,
-				      IDPF_VC_DESTROY_VPORT_ERR);
-
-rel_lock:
-	mutex_unlock(&vport->vc_buf_lock);
+	xn_params.vc_op = VIRTCHNL2_OP_DESTROY_VPORT;
+	xn_params.send_buf.iov_base = &v_id;
+	xn_params.send_buf.iov_len = sizeof(v_id);
+	xn_params.timeout_ms = IDPF_VC_XN_MIN_TIMEOUT_MSEC;
+	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
 
-	return err;
+	return reply_sz < 0 ? reply_sz : 0;
 }
 
 /**
@@ -1863,26 +1831,19 @@ int idpf_send_destroy_vport_msg(struct idpf_vport *vport)
  */
 int idpf_send_enable_vport_msg(struct idpf_vport *vport)
 {
-	struct idpf_adapter *adapter = vport->adapter;
+	struct idpf_vc_xn_params xn_params = {};
 	struct virtchnl2_vport v_id;
-	int err;
+	ssize_t reply_sz;
 
 	v_id.vport_id = cpu_to_le32(vport->vport_id);
 
-	mutex_lock(&vport->vc_buf_lock);
-
-	err = idpf_send_mb_msg(adapter, VIRTCHNL2_OP_ENABLE_VPORT,
-			       sizeof(v_id), (u8 *)&v_id, 0);
-	if (err)
-		goto rel_lock;
-
-	err = idpf_wait_for_event(adapter, vport, IDPF_VC_ENA_VPORT,
-				  IDPF_VC_ENA_VPORT_ERR);
-
-rel_lock:
-	mutex_unlock(&vport->vc_buf_lock);
+	xn_params.vc_op = VIRTCHNL2_OP_ENABLE_VPORT;
+	xn_params.send_buf.iov_base = &v_id;
+	xn_params.send_buf.iov_len = sizeof(v_id);
+	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
+	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
 
-	return err;
+	return reply_sz < 0 ? reply_sz : 0;
 }
 
 /**
@@ -1894,26 +1855,19 @@ int idpf_send_enable_vport_msg(struct idpf_vport *vport)
  */
 int idpf_send_disable_vport_msg(struct idpf_vport *vport)
 {
-	struct idpf_adapter *adapter = vport->adapter;
+	struct idpf_vc_xn_params xn_params = {};
 	struct virtchnl2_vport v_id;
-	int err;
+	ssize_t reply_sz;
 
 	v_id.vport_id = cpu_to_le32(vport->vport_id);
 
-	mutex_lock(&vport->vc_buf_lock);
-
-	err = idpf_send_mb_msg(adapter, VIRTCHNL2_OP_DISABLE_VPORT,
-			       sizeof(v_id), (u8 *)&v_id, 0);
-	if (err)
-		goto rel_lock;
-
-	err = idpf_min_wait_for_event(adapter, vport, IDPF_VC_DIS_VPORT,
-				      IDPF_VC_DIS_VPORT_ERR);
+	xn_params.vc_op = VIRTCHNL2_OP_DISABLE_VPORT;
+	xn_params.send_buf.iov_base = &v_id;
+	xn_params.send_buf.iov_len = sizeof(v_id);
+	xn_params.timeout_ms = IDPF_VC_XN_MIN_TIMEOUT_MSEC;
+	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
 
-rel_lock:
-	mutex_unlock(&vport->vc_buf_lock);
-
-	return err;
+	return reply_sz < 0 ? reply_sz : 0;
 }
 
 /**
@@ -3538,9 +3492,6 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 			case 0:
 				/* success, move state machine forward */
 				adapter->state = __IDPF_GET_CAPS;
-				err = idpf_send_get_caps_msg(adapter);
-				if (err)
-					goto init_failed;
 				fallthrough;
 			case -EAGAIN:
 				goto restart;
@@ -3551,13 +3502,15 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 				goto init_failed;
 			}
 		case __IDPF_GET_CAPS:
-			if (idpf_recv_get_caps_msg(adapter))
+			err = idpf_send_get_caps_msg(adapter);
+			if (err)
 				goto init_failed;
 			adapter->state = __IDPF_INIT_SW;
 			break;
 		default:
 			dev_err(&adapter->pdev->dev, "Device is in bad state: %d\n",
 				adapter->state);
+			err = -EINVAL;
 			goto init_failed;
 		}
 		break;
-- 
2.43.0


