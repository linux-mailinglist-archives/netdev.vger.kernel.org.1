Return-Path: <netdev+bounces-260224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wElnIAbQnGllKQQAu9opvQ
	(envelope-from <netdev+bounces-260224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:09:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7BD17E022
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5082930ABB87
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1037D125;
	Mon, 23 Feb 2026 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gKhj3I/p"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C317137D11C
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884159; cv=none; b=gxjZiasq4QPL0sI7c9idmqhpxBs9Ld0nROXrpXp7esxsTz8RvZNKaoq0UOHSU19WVrO7v5gKS+ptvucoXj1Eicg+6eiNH6+PhJr7Z1epFB6MxIKVOlrSuZkAVlUKQAD1gTOyQNg5vZ7c5Ca+PM7BI7yAcpbEGM1O6FZ8soYTSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884159; c=relaxed/simple;
	bh=1eBpmBEpkHHV97uSB5UkM7lbKBxkQ7CVC6+nR4Zi828=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqZzC5P/K7fj00+DzJ3yor9RrspuHzj4YSeXJyYMTEpIRNt41vY6AXi80tQ4cU6BqKoYbvspvajAZ9c/CvXoELtuB61i91OnE/s3MQevfNJS+HAE+9hj7IO69rEycwAceHU8TwLMft1aZwD+An7w19bHXz3giMi8GHegIR8HMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gKhj3I/p; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771884156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uri/I4AZsFrXpFzvmWE2/9AwrNVhoOzWGiG8INwSqUg=;
	b=gKhj3I/pxgC1F4eHO0hYt6/ouR88cxQg44IlpsizonwqkZDUzVXL8PD2x8AvLhcP6KKMCB
	7q90LowSCmL7woaTFwwOen0riIfQzy6oovLRw+h73iri/o8peWAcEcgmK8owr3teFihrmB
	zEFeQWo6Vv3/uqHfYMDJkmjrLAq5DwU=
From: Bart Van Assche <bart.vanassche@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Manish Chopra <manishc@marvell.com>,
	netdev@vger.kernel.org
Subject: [PATCH 21/62] qed: Make _qed_mcp_cmd_and_union() easier to analyze
Date: Mon, 23 Feb 2026 14:00:21 -0800
Message-ID: <20260223220102.2158611-22-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-1-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260224-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bart.vanassche@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:email]
X-Rspamd-Queue-Id: 1A7BD17E022
X-Rspamd-Action: no action

From: Bart Van Assche <bvanassche@acm.org>

Make the implementation of this function compatible with clang's
compile-time thread-safety analysis by moving error-handling code to the
end of this function. No functionality has been changed.

Cc: Manish Chopra <manishc@marvell.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 56 ++++++++++++-----------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index 7e37fe631a58..462e758c5890 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -467,7 +467,7 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 	int rc = 0;
 
 	/* Wait until the mailbox is non-occupied */
-	do {
+	for (;;) {
 		/* Exit the loop if there is no pending command, or if the
 		 * pending command is completed during this iteration.
 		 * The spinlock stays locked until the command is sent.
@@ -486,18 +486,14 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 
 		spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
 
+		if (++cnt >= QED_DRV_MB_MAX_RETRIES)
+			goto retries_exceeded_1;
+
 		if (QED_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP))
 			usleep_range(QED_MCP_RESP_ITER_US,
 				     QED_MCP_RESP_ITER_US * 2);
 		else
 			udelay(QED_MCP_RESP_ITER_US);
-	} while (++cnt < QED_DRV_MB_MAX_RETRIES);
-
-	if (cnt >= QED_DRV_MB_MAX_RETRIES) {
-		DP_NOTICE(p_hwfn,
-			  "The MFW mailbox is occupied by an uncompleted command. Failed to send command 0x%08x [param 0x%08x].\n",
-			  p_mb_params->cmd, p_mb_params->param);
-		return -EAGAIN;
 	}
 
 	/* Send the mailbox command */
@@ -513,7 +509,7 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 	spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
 
 	/* Wait for the MFW response */
-	do {
+	for (;;) {
 		/* Exit the loop if the command is already completed, or if the
 		 * command is completed during this iteration.
 		 * The spinlock stays locked until the list element is removed.
@@ -537,24 +533,9 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 			goto err;
 
 		spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
-	} while (++cnt < QED_DRV_MB_MAX_RETRIES);
-
-	if (cnt >= QED_DRV_MB_MAX_RETRIES) {
-		DP_NOTICE(p_hwfn,
-			  "The MFW failed to respond to command 0x%08x [param 0x%08x].\n",
-			  p_mb_params->cmd, p_mb_params->param);
-		qed_mcp_print_cpu_info(p_hwfn, p_ptt);
-
-		spin_lock_bh(&p_hwfn->mcp_info->cmd_lock);
-		qed_mcp_cmd_del_elem(p_hwfn, p_cmd_elem);
-		spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
 
-		if (!QED_MB_FLAGS_IS_SET(p_mb_params, AVOID_BLOCK))
-			qed_mcp_cmd_set_blocking(p_hwfn, true);
-
-		qed_hw_err_notify(p_hwfn, p_ptt,
-				  QED_HW_ERR_MFW_RESP_FAIL, NULL);
-		return -EAGAIN;
+		if (++cnt >= QED_DRV_MB_MAX_RETRIES)
+			goto retries_exceeded_2;
 	}
 
 	qed_mcp_cmd_del_elem(p_hwfn, p_cmd_elem);
@@ -576,6 +557,29 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 err:
 	spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
 	return rc;
+
+retries_exceeded_1:
+	DP_NOTICE(p_hwfn,
+		  "The MFW mailbox is occupied by an uncompleted command. Failed to send command 0x%08x [param 0x%08x].\n",
+		  p_mb_params->cmd, p_mb_params->param);
+	return -EAGAIN;
+
+retries_exceeded_2:
+	DP_NOTICE(p_hwfn,
+		  "The MFW failed to respond to command 0x%08x [param 0x%08x].\n",
+		  p_mb_params->cmd, p_mb_params->param);
+	qed_mcp_print_cpu_info(p_hwfn, p_ptt);
+
+	spin_lock_bh(&p_hwfn->mcp_info->cmd_lock);
+	qed_mcp_cmd_del_elem(p_hwfn, p_cmd_elem);
+	spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
+
+	if (!QED_MB_FLAGS_IS_SET(p_mb_params, AVOID_BLOCK))
+		qed_mcp_cmd_set_blocking(p_hwfn, true);
+
+	qed_hw_err_notify(p_hwfn, p_ptt,
+			  QED_HW_ERR_MFW_RESP_FAIL, NULL);
+	return -EAGAIN;
 }
 
 static int qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,

