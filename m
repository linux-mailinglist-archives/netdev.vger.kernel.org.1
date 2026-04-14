Return-Path: <netdev+bounces-278401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBvpALEe3mk1ngkAu9opvQ
	(envelope-from <netdev+bounces-278401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:02:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C83F9119
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 281D630156E6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F80364029;
	Tue, 14 Apr 2026 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYmQvF6x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271303537C4
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164452; cv=none; b=pWO8hp9RNp5ms8xdkUrEQm0kEwk9BYuVpyi6+e4s91mgmPLgS1xj/ga2Iroh3OrNaAfQYA1NuOChXK0x0VP+Pik0nkYTUXGRLqCtBc8l7VgeLTYQDqwGKo9KnQZuE6TK3J+/qjlJSL9H3ZmFFdjQWDZNpx7FfWN/JMmD2ujsFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164452; c=relaxed/simple;
	bh=EDaI4DwCtOxjzyRDucxBZuOaYlUyriM1IxBjt3ZVDiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwErfLzleGeSFbui2M1LaNHeEXWuYSu/GnbTIPv0XxaBV2t9Z4CRwjm/KeTgDAY2vghsI/5cUDrj2DL2FNFJYz9YD3haglR5EZDoDb1jz186owzGKxjCibs2Tgg8ZP9jn7NhZYMJTpGSsEYtyXX+HBLSouhp11Llg2x4G9PkBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYmQvF6x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776164450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUuW6S8vq+qFO9JpVN9QFMuGPGZumM43B/zb/rVii/U=;
	b=VYmQvF6xiV7EKDv4Mlz9b8uo7DZXvkccnVv70BcqC7tcA4Bf/cpfsZJsWKGTd34gBiu/78
	dTw/EUkQPzNTXYck/flc9wa06MkwfzYtdlmYsIGL+rv92h5h42OZbkE5a2us0Ilyen0UGB
	DxqYGingwqcsAmjb+nTNEMJuv6TLhkk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-j5qJb-hUPtepsz5YqfYV-A-1; Tue,
 14 Apr 2026 07:00:46 -0400
X-MC-Unique: j5qJb-hUPtepsz5YqfYV-A-1
X-Mimecast-MFC-AGG-ID: j5qJb-hUPtepsz5YqfYV-A_1776164445
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6342118002F5;
	Tue, 14 Apr 2026 11:00:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 902B13000C1D;
	Tue, 14 Apr 2026 11:00:41 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v3 5/5] iavf: refactor virtchnl polling into single function
Date: Tue, 14 Apr 2026 13:00:06 +0200
Message-ID: <20260414110006.124286-6-jtornosm@redhat.com>
In-Reply-To: <20260414110006.124286-1-jtornosm@redhat.com>
References: <20260414110006.124286-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RSPAMD_URIBL_FAIL(0.00)[intel.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278401-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A76C83F9119
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

At this moment, the driver has two separate functions for polling virtchnl
messages from the admin queue:
- iavf_poll_virtchnl_msg() for init-time (no timeout, no completion
  handler)
- iavf_poll_virtchnl_response() for runtime (with timeout, calls
  completion)

Refactor by enhancing iavf_poll_virtchnl_msg() to handle both use cases:
1. Init-time mode (timeout_ms=0):
  - Polls until matching opcode found or queue empty
  - Returns raw message data without processing through completion handler
  - Exits immediately on empty queue (no sleep/retry)
2. Runtime mode (timeout_ms>0):
  - Polls with timeout using condition callback or opcode check
  - Processes all messages through iavf_virtchnl_completion()
  - Supports custom completion callback (takes priority) or falls back
    to checking adapter->current_op against expected opcode
  - Uses pending parameter to skip sleep when more messages queued
  - Uses 50-75 usec sleep (due to commit 9e3f23f44f32 ("i40e: reduce wait
    time for adminq command completion"))

By unifying message handling, both init-time and runtime messages can be
processed through the completion handler when appropriate, ensuring
consistent state updates and maintaining backward compatibility with all
existing call sites.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |   9 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  13 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 247 ++++++++----------
 3 files changed, 125 insertions(+), 144 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index b012a91b0252..9b25c5a65d2a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -607,11 +607,10 @@ void iavf_disable_vlan_stripping(struct iavf_adapter *adapter);
 void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			      enum virtchnl_ops v_opcode,
 			      enum iavf_status v_retval, u8 *msg, u16 msglen);
-int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
-				bool (*condition)(struct iavf_adapter *, const void *),
-				const void *cond_data,
-				enum virtchnl_ops v_opcode,
-				unsigned int timeout_ms);
+int iavf_poll_virtchnl_msg(struct iavf_hw *hw, struct iavf_arq_event_info *event,
+			   enum virtchnl_ops op_to_poll, unsigned int timeout_ms,
+			   bool (*condition)(struct iavf_adapter *, const void *),
+			   const void *cond_data);
 int iavf_config_rss(struct iavf_adapter *adapter);
 void iavf_cfg_queues_bw(struct iavf_adapter *adapter);
 void iavf_cfg_queues_quanta_size(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 80277d495a8d..b0db15fd8ddb 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1075,6 +1075,7 @@ static bool iavf_mac_change_done(struct iavf_adapter *adapter, const void *data)
  */
 static int iavf_set_mac_sync(struct iavf_adapter *adapter, const u8 *addr)
 {
+	struct iavf_arq_event_info event;
 	int ret;
 
 	netdev_assert_locked(adapter->netdev);
@@ -1083,8 +1084,16 @@ static int iavf_set_mac_sync(struct iavf_adapter *adapter, const u8 *addr)
 	if (ret)
 		return ret;
 
-	return iavf_poll_virtchnl_response(adapter, iavf_mac_change_done, addr,
-					   VIRTCHNL_OP_UNKNOWN, 2500);
+	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
+	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
+	if (!event.msg_buf)
+		return -ENOMEM;
+
+	ret = iavf_poll_virtchnl_msg(&adapter->hw, &event, VIRTCHNL_OP_UNKNOWN,
+				     2500, iavf_mac_change_done, addr);
+
+	kfree(event.msg_buf);
+	return ret;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index df124f840ddb..ef9a251060d9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -54,55 +54,121 @@ int iavf_send_api_ver(struct iavf_adapter *adapter)
 }
 
 /**
- * iavf_poll_virtchnl_msg
+ * iavf_virtchnl_completion_done - Check if virtchnl operation completed
+ * @adapter: adapter structure
+ * @condition: optional callback for custom completion check
+ * @cond_data: context data for callback
+ * @op_to_poll: opcode to check against current_op (if no callback)
+ *
+ * Checks if operation is complete. Callback takes priority if provided,
+ * otherwise checks if current_op matches op_to_poll.
+ *
+ * Return: true if operation completed
+ */
+static inline bool
+iavf_virtchnl_completion_done(struct iavf_adapter *adapter,
+			      bool (*condition)(struct iavf_adapter *, const void *),
+			      const void *cond_data,
+			      enum virtchnl_ops op_to_poll)
+{
+	if (condition)
+		return condition(adapter, cond_data);
+
+	return adapter->current_op == op_to_poll;
+}
+
+/**
+ * iavf_poll_virtchnl_msg - Poll admin queue for virtchnl message
  * @hw: HW configuration structure
  * @event: event to populate on success
- * @op_to_poll: requested virtchnl op to poll for
+ * @op_to_poll: virtchnl opcode to poll for (used for init-time and runtime
+ *              without callback)
+ * @timeout_ms: timeout in milliseconds (0 = no timeout, exit on empty queue)
+ * @condition: optional callback to check custom completion (runtime use,
+ *             takes priority over op_to_poll check)
+ * @cond_data: context data for condition callback
+ *
+ * Enhanced polling function that handles both init-time and runtime use cases:
+ * - Init-time: Set op_to_poll, timeout_ms=0, condition=NULL
+ *   Polls until matching opcode found or queue empty
+ * - Runtime with callback: Set timeout_ms>0, condition callback, cond_data
+ *   Polls with timeout until condition returns true (op_to_poll not used)
+ * - Runtime without callback: Set op_to_poll, timeout_ms>0, condition=NULL
+ *   Polls with timeout until adapter->current_op == op_to_poll
+ *
+ * Runtime messages are processed through iavf_virtchnl_completion().
+ * For init-time use, returns 0 with raw message data in event buffer.
+ * For runtime use, returns 0 when completion condition is met.
  *
- * Initialize poll for virtchnl msg matching the requested_op. Returns 0
- * if a message of the correct opcode is in the queue or an error code
- * if no message matching the op code is waiting and other failures.
+ * Return: 0 on success, -EAGAIN on timeout, or error code
  */
-static int
-iavf_poll_virtchnl_msg(struct iavf_hw *hw, struct iavf_arq_event_info *event,
-		       enum virtchnl_ops op_to_poll)
+int iavf_poll_virtchnl_msg(struct iavf_hw *hw, struct iavf_arq_event_info *event,
+			   enum virtchnl_ops op_to_poll, unsigned int timeout_ms,
+			   bool (*condition)(struct iavf_adapter *, const void *),
+			   const void *cond_data)
 {
+	struct iavf_adapter *adapter = hw->back;
+	unsigned long timeout = timeout_ms ? jiffies + msecs_to_jiffies(timeout_ms) : 0;
 	enum virtchnl_ops received_op;
 	enum iavf_status status;
-	u32 v_retval;
+	u32 v_retval = 0;
+	u16 pending;
 
-	while (1) {
-		/* When the AQ is empty, iavf_clean_arq_element will return
-		 * nonzero and this loop will terminate.
-		 */
-		status = iavf_clean_arq_element(hw, event, NULL);
-		if (status != IAVF_SUCCESS)
-			return iavf_status_to_errno(status);
-		received_op =
-		    (enum virtchnl_ops)le32_to_cpu(event->desc.cookie_high);
+	do {
+		if (timeout_ms && iavf_virtchnl_completion_done(adapter, condition,
+								cond_data, op_to_poll))
+			return 0;
 
-		if (received_op == VIRTCHNL_OP_EVENT) {
-			struct iavf_adapter *adapter = hw->back;
-			struct virtchnl_pf_event *vpe =
-				(struct virtchnl_pf_event *)event->msg_buf;
+		status = iavf_clean_arq_element(hw, event, &pending);
+		if (status == IAVF_SUCCESS) {
+			received_op = (enum virtchnl_ops)le32_to_cpu(event->desc.cookie_high);
 
-			if (vpe->event != VIRTCHNL_EVENT_RESET_IMPENDING)
-				continue;
+			/* Handle reset events specially */
+			if (received_op == VIRTCHNL_OP_EVENT) {
+				struct virtchnl_pf_event *vpe =
+					(struct virtchnl_pf_event *)event->msg_buf;
 
-			dev_info(&adapter->pdev->dev, "Reset indication received from the PF\n");
-			if (!(adapter->flags & IAVF_FLAG_RESET_PENDING))
-				iavf_schedule_reset(adapter,
-						    IAVF_FLAG_RESET_PENDING);
+				if (vpe->event != VIRTCHNL_EVENT_RESET_IMPENDING)
+					continue;
+
+				dev_info(&adapter->pdev->dev,
+					 "Reset indication received from the PF\n");
+				if (!(adapter->flags & IAVF_FLAG_RESET_PENDING))
+					iavf_schedule_reset(adapter,
+							    IAVF_FLAG_RESET_PENDING);
+
+				return -EIO;
+			}
+
+			v_retval = le32_to_cpu(event->desc.cookie_low);
+
+			if (!timeout_ms) {
+				if (received_op == op_to_poll)
+					return virtchnl_status_to_errno((enum virtchnl_status_code)
+							v_retval);
+			} else {
+				iavf_virtchnl_completion(adapter, received_op,
+							 (enum iavf_status)v_retval,
+							 event->msg_buf, event->msg_len);
+			}
+
+			if (pending)
+				continue;
+		} else if (!timeout_ms) {
+			return iavf_status_to_errno(status);
+		}
 
-			return -EIO;
+		if (timeout_ms) {
+			memset(event->msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
+			usleep_range(50, 75);
 		}
 
-		if (op_to_poll == received_op)
-			break;
-	}
+	} while (!timeout_ms || time_before(jiffies, timeout));
+
+	if (iavf_virtchnl_completion_done(adapter, condition, cond_data, op_to_poll))
+		return 0;
 
-	v_retval = le32_to_cpu(event->desc.cookie_low);
-	return virtchnl_status_to_errno((enum virtchnl_status_code)v_retval);
+	return -EAGAIN;
 }
 
 /**
@@ -124,7 +190,8 @@ int iavf_verify_api_ver(struct iavf_adapter *adapter)
 	if (!event.msg_buf)
 		return -ENOMEM;
 
-	err = iavf_poll_virtchnl_msg(&adapter->hw, &event, VIRTCHNL_OP_VERSION);
+	err = iavf_poll_virtchnl_msg(&adapter->hw, &event, VIRTCHNL_OP_VERSION,
+				     0, NULL, NULL);
 	if (!err) {
 		struct virtchnl_version_info *pf_vvi =
 			(struct virtchnl_version_info *)event.msg_buf;
@@ -294,7 +361,8 @@ int iavf_get_vf_config(struct iavf_adapter *adapter)
 	if (!event.msg_buf)
 		return -ENOMEM;
 
-	err = iavf_poll_virtchnl_msg(hw, &event, VIRTCHNL_OP_GET_VF_RESOURCES);
+	err = iavf_poll_virtchnl_msg(hw, &event, VIRTCHNL_OP_GET_VF_RESOURCES,
+				     0, NULL, NULL);
 	memcpy(adapter->vf_res, event.msg_buf, min(event.msg_len, len));
 
 	/* some PFs send more queues than we should have so validate that
@@ -322,7 +390,8 @@ int iavf_get_vf_vlan_v2_caps(struct iavf_adapter *adapter)
 		return -ENOMEM;
 
 	err = iavf_poll_virtchnl_msg(&adapter->hw, &event,
-				     VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS);
+				     VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS,
+				     0, NULL, NULL);
 	if (!err)
 		memcpy(&adapter->vlan_v2_caps, event.msg_buf,
 		       min(event.msg_len, len));
@@ -342,7 +411,8 @@ int iavf_get_vf_supported_rxdids(struct iavf_adapter *adapter)
 	event.buf_len = sizeof(rxdids);
 
 	err = iavf_poll_virtchnl_msg(&adapter->hw, &event,
-				     VIRTCHNL_OP_GET_SUPPORTED_RXDIDS);
+				     VIRTCHNL_OP_GET_SUPPORTED_RXDIDS,
+				     0, NULL, NULL);
 	if (!err)
 		adapter->supp_rxdids = rxdids;
 
@@ -359,7 +429,8 @@ int iavf_get_vf_ptp_caps(struct iavf_adapter *adapter)
 	event.buf_len = sizeof(caps);
 
 	err = iavf_poll_virtchnl_msg(&adapter->hw, &event,
-				     VIRTCHNL_OP_1588_PTP_GET_CAPS);
+				     VIRTCHNL_OP_1588_PTP_GET_CAPS,
+				     0, NULL, NULL);
 	if (!err)
 		adapter->ptp.hw_caps = caps;
 
@@ -2961,101 +3032,3 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 }
 
-/**
- * iavf_virtchnl_done - Check if virtchnl operation completed
- * @adapter: board private structure
- * @condition: optional callback for custom completion check
- *   (takes priority)
- * @cond_data: context data for callback
- * @v_opcode: virtchnl opcode value we're waiting for if no condition
- *   configured (typically VIRTCHNL_OP_UNKNOWN), if condition not used
- *
- * Checks completion status. Callback takes priority if provided. Otherwise
- * waits for current_op to reach v_opcode (typically VIRTCHNL_OP_UNKNOWN
- * after completion).
- *
- * Return: true if operation completed
- */
-static inline bool iavf_virtchnl_done(struct iavf_adapter *adapter,
-				      bool (*condition)(struct iavf_adapter *, const void *),
-				      const void *cond_data,
-				      enum virtchnl_ops v_opcode)
-{
-	if (condition)
-		return condition(adapter, cond_data);
-
-	return adapter->current_op == v_opcode;
-}
-
-/**
- * iavf_poll_virtchnl_response - Poll admin queue for virtchnl response
- * @adapter: board private structure
- * @condition: optional callback to check if desired response received
- *   (takes priority)
- * @cond_data: context data passed to condition callback
- * @v_opcode: virtchnl opcode value to wait for if no condition configured
- *   (typically VIRTCHNL_OP_UNKNOWN), if condition, not used
- * @timeout_ms: maximum time to wait in milliseconds
- *
- * Polls admin queue and processes all messages until condition returns true
- * or timeout expires. If condition is NULL, waits for current_op to become
- * v_opcode (typically VIRTCHNL_OP_UNKNOWN after operation completes).
- * Caller must hold netdev_lock. This can sleep for up to timeout_ms while
- * polling hardware.
- *
- * Return: 0 on success (condition met), -EAGAIN on timeout or error
- */
-int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
-				bool (*condition)(struct iavf_adapter *, const void *),
-				const void *cond_data,
-				enum virtchnl_ops v_opcode,
-				unsigned int timeout_ms)
-{
-	struct iavf_hw *hw = &adapter->hw;
-	struct iavf_arq_event_info event;
-	enum virtchnl_ops v_op;
-	enum iavf_status v_ret;
-	unsigned long timeout;
-	u16 pending;
-	int ret;
-
-	netdev_assert_locked(adapter->netdev);
-
-	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
-	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
-	if (!event.msg_buf)
-		return -ENOMEM;
-
-	timeout = jiffies + msecs_to_jiffies(timeout_ms);
-	do {
-		if (iavf_virtchnl_done(adapter, condition, cond_data, v_opcode)) {
-			ret = 0;
-			goto out;
-		}
-
-		ret = iavf_clean_arq_element(hw, &event, &pending);
-		if (!ret) {
-			v_op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
-			v_ret = (enum iavf_status)le32_to_cpu(event.desc.cookie_low);
-
-			iavf_virtchnl_completion(adapter, v_op, v_ret,
-						 event.msg_buf, event.msg_len);
-
-			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
-
-			if (pending)
-				continue;
-		}
-
-		usleep_range(50, 75);
-	} while (time_before(jiffies, timeout));
-
-	if (iavf_virtchnl_done(adapter, condition, cond_data, v_opcode))
-		ret = 0;
-	else
-		ret = -EAGAIN;
-
-out:
-	kfree(event.msg_buf);
-	return ret;
-}
-- 
2.53.0


