Return-Path: <netdev+bounces-130576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF8798ADD7
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30071F23233
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E6D1A2541;
	Mon, 30 Sep 2024 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYnhkpsV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71301A0BD1
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727221; cv=none; b=ckFJfmOk/3TE3P7As1xqVzG+nuII5c3OEVCwgr9cElGF1NyQzTZdvtgYe7Pigd39/Cm9CQKxAiB//NDF4cxUrv9TLx+ZwDWauHMSdYcF3h5EPTSTeYIXkBl71fDYcBoSxzf92/z9Vd4A7H6lSNb1HUxRSO8OLD0RENZgZ8OGKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727221; c=relaxed/simple;
	bh=QCabOFyjz/9789nssv0DMhLQlRo6ZtJa+RMYl3QA2aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTbjmcU37Hh7A3HQGdFEBcQBCgN847fnnt6WjK7KPyj9HLrOg9bsDxhnW0wC+PuFNoVqpUuJATO53tmoiI1FAynBAlWH+j+JTwQwrqKRv66EpizUU5QVkMtvnydJjkdskTQJKXLZ/J8l9gRYn6fTqk+jV7V+AiCPE5vw1RpnisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYnhkpsV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727727218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6ce+k6Atn+qrW3kCUH4ga1Kn2zJml2TCYfASckzxJw=;
	b=UYnhkpsVBPmxmuIN6jk03+1xk0aAXfHTwkcfoRiFHeqe7t1lUvcnd3OXISfhqrZLkBrL2b
	DeFOa9gptXXgcuKgKSjQ+ZX0yvQWZIX+tw3qkOdrdL8HtoYH33+4+lXJ2EXGz38u2PldYi
	EfrptOqAEO7zxVziYJ5BZ+dYZVhK1uM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-MY8GH7vAOva5gVx0LqYGMw-1; Mon,
 30 Sep 2024 16:13:33 -0400
X-MC-Unique: MY8GH7vAOva5gVx0LqYGMw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA89D1955D56;
	Mon, 30 Sep 2024 20:13:31 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.45.224.53])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8EDB19560AA;
	Mon, 30 Sep 2024 20:13:28 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Manish Chopra <manishc@marvell.com>,
	netdev@vger.kernel.org
Cc: Caleb Sander <csander@purestorage.com>,
	Alok Prasad <palok@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/4] qed: make 'ethtool -d' 10 times faster
Date: Mon, 30 Sep 2024 22:13:04 +0200
Message-ID: <20240930201307.330692-2-mschmidt@redhat.com>
In-Reply-To: <20240930201307.330692-1-mschmidt@redhat.com>
References: <20240930201307.330692-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

As a side effect of commit 5401c3e09928 ("qed: allow sleep in
qed_mcp_trace_dump()"), 'ethtool -d' became much slower.
Almost all the time is spent collecting the "mcp_trace".
It is caused by sleeping too long in _qed_mcp_cmd_and_union.
When called with sleeping not allowed, the function delays for 10 µs
between firmware polls. But if sleeping is allowed, it sleeps for 10 ms
instead.

The sleeps in _qed_mcp_cmd_and_union are unnecessarily long.
Replace msleep with usleep_range, which allows to achieve a similar
polling interval like in the no-sleeping mode (10 - 20 µs).

The only caller, qed_mcp_cmd_and_union, can stop doing the
multiplication/division of the usecs/max_retries. The polling interval
and the number of retries do not need to be parameters at all.

On my test system, 'ethtool -d' now takes 4 seconds instead of 44.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 36 ++++++++++-------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index 16e6bd466143..00f0abc1c2d2 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -459,12 +459,11 @@ static void qed_mcp_print_cpu_info(struct qed_hwfn *p_hwfn,
 static int
 _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt,
-		       struct qed_mcp_mb_params *p_mb_params,
-		       u32 max_retries, u32 usecs)
+		       struct qed_mcp_mb_params *p_mb_params)
 {
-	u32 cnt = 0, msecs = DIV_ROUND_UP(usecs, 1000);
 	struct qed_mcp_cmd_elem *p_cmd_elem;
 	u16 seq_num;
+	u32 cnt = 0;
 	int rc = 0;
 
 	/* Wait until the mailbox is non-occupied */
@@ -488,12 +487,13 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
 
 		if (QED_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP))
-			msleep(msecs);
+			usleep_range(QED_MCP_RESP_ITER_US,
+				     QED_MCP_RESP_ITER_US * 2);
 		else
-			udelay(usecs);
-	} while (++cnt < max_retries);
+			udelay(QED_MCP_RESP_ITER_US);
+	} while (++cnt < QED_DRV_MB_MAX_RETRIES);
 
-	if (cnt >= max_retries) {
+	if (cnt >= QED_DRV_MB_MAX_RETRIES) {
 		DP_NOTICE(p_hwfn,
 			  "The MFW mailbox is occupied by an uncompleted command. Failed to send command 0x%08x [param 0x%08x].\n",
 			  p_mb_params->cmd, p_mb_params->param);
@@ -520,9 +520,10 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		 */
 
 		if (QED_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP))
-			msleep(msecs);
+			usleep_range(QED_MCP_RESP_ITER_US,
+				     QED_MCP_RESP_ITER_US * 2);
 		else
-			udelay(usecs);
+			udelay(QED_MCP_RESP_ITER_US);
 
 		spin_lock_bh(&p_hwfn->mcp_info->cmd_lock);
 
@@ -536,9 +537,9 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 			goto err;
 
 		spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
-	} while (++cnt < max_retries);
+	} while (++cnt < QED_DRV_MB_MAX_RETRIES);
 
-	if (cnt >= max_retries) {
+	if (cnt >= QED_DRV_MB_MAX_RETRIES) {
 		DP_NOTICE(p_hwfn,
 			  "The MFW failed to respond to command 0x%08x [param 0x%08x].\n",
 			  p_mb_params->cmd, p_mb_params->param);
@@ -564,7 +565,8 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		   "MFW mailbox: response 0x%08x param 0x%08x [after %d.%03d ms]\n",
 		   p_mb_params->mcp_resp,
 		   p_mb_params->mcp_param,
-		   (cnt * usecs) / 1000, (cnt * usecs) % 1000);
+		   (cnt * QED_MCP_RESP_ITER_US) / 1000,
+		   (cnt * QED_MCP_RESP_ITER_US) % 1000);
 
 	/* Clear the sequence number from the MFW response */
 	p_mb_params->mcp_resp &= FW_MSG_CODE_MASK;
@@ -581,8 +583,6 @@ static int qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 				 struct qed_mcp_mb_params *p_mb_params)
 {
 	size_t union_data_size = sizeof(union drv_union_data);
-	u32 max_retries = QED_DRV_MB_MAX_RETRIES;
-	u32 usecs = QED_MCP_RESP_ITER_US;
 
 	/* MCP not initialized */
 	if (!qed_mcp_is_init(p_hwfn)) {
@@ -606,13 +606,7 @@ static int qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		return -EINVAL;
 	}
 
-	if (QED_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP)) {
-		max_retries = DIV_ROUND_UP(max_retries, 1000);
-		usecs *= 1000;
-	}
-
-	return _qed_mcp_cmd_and_union(p_hwfn, p_ptt, p_mb_params, max_retries,
-				      usecs);
+	return _qed_mcp_cmd_and_union(p_hwfn, p_ptt, p_mb_params);
 }
 
 static int _qed_mcp_cmd(struct qed_hwfn *p_hwfn,
-- 
2.46.2


