Return-Path: <netdev+bounces-66100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FAD83D407
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 06:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2503A289FCF
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 05:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07464BE4E;
	Fri, 26 Jan 2024 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKI7SlCl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01AEC2C6
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706248106; cv=none; b=EmetV8myI6Ji2H1kUiXUHojG9UC65Xef7tmvopmHrqlPA1/0FfQXhBu0zlD+5IgRV+4TsjWYi0zYtoF7eDBU1KtOCk4xIns1nzdbI+L4aiTlN2HZBgPfAgMAtD6+l0xJbDznoZJFGMPmr2UeJsBk3nHOimoFEOFhkzpRmJZpM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706248106; c=relaxed/simple;
	bh=5barsvagEJn1rmo/WgUcAFPvKwlSFez6reNUPDYGDOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFMaTn8aPZ0wAcxxK2IFp0Mg2tbTikWP4LDprRx0qCGoUWL/SJ0/QRYc5OcNvo67z8/KzGkdFC/jfVsj/NCiAiTW9lZWxMLvyyUQyXjn8hcTRQpmbH6MdeM0EVYxoKxhbgtz+opyihML5DL2JnwyrcYzA3IRHQiD3IXEZa5FXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKI7SlCl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706248105; x=1737784105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5barsvagEJn1rmo/WgUcAFPvKwlSFez6reNUPDYGDOI=;
  b=QKI7SlClhnKAu4LIuBT8PeJe/7kPUEr2GfTA8BD4bMZlZIhjAc6rja51
   abmEmqhgZwDd/6/1biYyM277DyKzwfMPFEMxQzR9d6Gs7sLY1h3eVUC1j
   8X4HzRyq8BuvQm8PJj7/BwajKdR4Dbtl5qQbPajkD1RvZbUBVdETlB2tY
   Op1gLEaXcowHHkMA8E1vsPPX7dJAkEf+YxK4yVE22l3g3GODy6Db72cAh
   JnqH8ETUzowb3Dky0KwPUf6FEOg2e4RLpYHPbRplYReryBm5sOvnyHD+s
   6mbMUPFw0ynTV98iA092Re/jfOhBP4MFeZLnOb/7I6VMGvBlJWYEkWsKl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9779255"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9779255"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 21:48:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="21306057"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa002.fm.intel.com with ESMTP; 25 Jan 2024 21:48:24 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	igor.bagnucki@intel.com,
	willemdebruijn.kernel@gmail.com,
	Alan Brady <alan.brady@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>
Subject: [PATCH v2 2/7 iwl-next] idpf: refactor vport virtchnl messages
Date: Thu, 25 Jan 2024 21:47:42 -0800
Message-Id: <20240126054747.960172-3-alan.brady@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240126054747.960172-1-alan.brady@intel.com>
References: <20240126054747.960172-1-alan.brady@intel.com>
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

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 185 +++++++-----------
 1 file changed, 69 insertions(+), 116 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 2045726519f8..1cf7293bd532 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -754,7 +754,6 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter, u32 op,
 
 	while (1) {
 		struct idpf_vport_config *vport_config;
-		int payload_size = 0;
 
 		/* Try to get one message */
 		num_q_msg = 1;
@@ -791,47 +790,17 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter, u32 op,
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
@@ -1218,7 +1187,9 @@ static int idpf_send_ver_msg(struct idpf_adapter *adapter)
  */
 static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 {
-	struct virtchnl2_get_capabilities caps = { };
+	struct virtchnl2_get_capabilities caps = {};
+	struct idpf_vc_xn_params xn_params = {};
+	ssize_t reply_sz;
 
 	caps.csum_caps =
 		cpu_to_le32(VIRTCHNL2_CAP_TX_CSUM_L3_IPV4	|
@@ -1275,21 +1246,20 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
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
+	reply_sz = idpf_vc_xn_exec(adapter, xn_params);
+	if (reply_sz < 0)
+		return reply_sz;
+	if (reply_sz < sizeof(adapter->caps))
+		return -EIO;
+
+	return 0;
 }
 
 /**
@@ -1616,8 +1586,10 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 			       struct idpf_vport_max_q *max_q)
 {
 	struct virtchnl2_create_vport *vport_msg;
+	struct idpf_vc_xn_params xn_params = {};
 	u16 idx = adapter->next_vport;
 	int err, buf_size;
+	ssize_t reply_sz;
 
 	buf_size = sizeof(struct virtchnl2_create_vport);
 	if (!adapter->vport_params_reqd[idx]) {
@@ -1648,35 +1620,38 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
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
+	reply_sz = idpf_vc_xn_exec(adapter, xn_params);
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
@@ -1728,26 +1703,19 @@ int idpf_check_supported_desc_ids(struct idpf_vport *vport)
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
+	reply_sz = idpf_vc_xn_exec(vport->adapter, xn_params);
 
-	return err;
+	return reply_sz < 0 ? reply_sz : 0;
 }
 
 /**
@@ -1759,26 +1727,19 @@ int idpf_send_destroy_vport_msg(struct idpf_vport *vport)
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
+	reply_sz = idpf_vc_xn_exec(vport->adapter, xn_params);
 
-	return err;
+	return reply_sz < 0 ? reply_sz : 0;
 }
 
 /**
@@ -1790,26 +1751,19 @@ int idpf_send_enable_vport_msg(struct idpf_vport *vport)
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
+	reply_sz = idpf_vc_xn_exec(vport->adapter, xn_params);
 
-rel_lock:
-	mutex_unlock(&vport->vc_buf_lock);
-
-	return err;
+	return reply_sz < 0 ? reply_sz : 0;
 }
 
 /**
@@ -3427,9 +3381,6 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 			case 0:
 				/* success, move state machine forward */
 				adapter->state = __IDPF_GET_CAPS;
-				err = idpf_send_get_caps_msg(adapter);
-				if (err)
-					goto init_failed;
 				fallthrough;
 			case -EAGAIN:
 				goto restart;
@@ -3440,13 +3391,15 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
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
2.40.1


