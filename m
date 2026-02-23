Return-Path: <netdev+bounces-260215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGj0LBPMnGlHKQQAu9opvQ
	(envelope-from <netdev+bounces-260215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:52:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9C417DC5F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 118BC307CEAB
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E33793A2;
	Mon, 23 Feb 2026 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZZdeoqFl"
X-Original-To: netdev@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651236B07F
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883435; cv=none; b=TEm5QGjPnDHGA0wW1O96chSd/nsdQZRMedyoG2VYNH+68GbgyQnjVAKP78PJ5JAwU02K4Wv4z0InlT1UDoVsMft8M0iw+n8ZDj+mWjbuFfZML+om9TGBKyNSB6MMxec/KygQhkzv2WwyBWrRaBrhR0mfUYMEtbFvE4jkBCiuTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883435; c=relaxed/simple;
	bh=dM6mRtCLUcjt6L2jlOuO9V9mY5jMkqGuzil49ZxJXec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwONz1hfFSSJXRoVVePkj9dFWyLuVjIFQMm75Spzs+rlo4SJT2rHiRFlKZakKT5GLqUOiAPsbA7z5l0OpbpYvjhUAnrWyv2RfgCUOwE99HpmWD0WVkz/WV1dBt5gFfyMXtL+sxGqHU7gz2FfN80RQgz8VgoogbdM3RxCor543Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZZdeoqFl; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZKQ3sP4zlfddf;
	Mon, 23 Feb 2026 21:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883433; x=1774475434; bh=czTvO
	pQsXG39cSlGU/DxM2ak2Ga6CwHZdY9+00eiKSc=; b=ZZdeoqFlsliahfDmE402U
	GhY9/wJ5hp7MDC5p+7AGw+e18jwpkmHmOrKbr/vrORbzL/motkJNZ9vf6/22Clmc
	xgs2d5CSzhDOdA39JkZuvQ+towZHDIUVGmIjdkG40GLuBIC6PifQ49lZ+rVH8Xo8
	KDOIltW+sqaTEExocRXHXd9oTlpdPHVTuUdLJUGxOys0qqonlm2q8Cg1Ysad2MnK
	joxtjmFk1dRqXCMt4xEKoF95A2c6pLVWsMfi6szyuHilfkJQ7a1KOYFniTrGEtaZ
	RgPEQcUM4jnAjTufS542EUB/5tzlvFwSU4Y81+w/t06UBMrNk8g3zW5oz0ySijG/
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mrdKrSrPdpBs; Mon, 23 Feb 2026 21:50:33 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZKN4wPxzlh1Wf;
	Mon, 23 Feb 2026 21:50:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Manish Chopra <manishc@marvell.com>,
	netdev@vger.kernel.org
Subject: [PATCH 21/62] qed: Make _qed_mcp_cmd_and_union() easier to analyze
Date: Mon, 23 Feb 2026 13:49:09 -0800
Message-ID: <20260223214950.2153735-22-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223214950.2153735-1-bvanassche@acm.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260215-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim,acm.org:email,marvell.com:email]
X-Rspamd-Queue-Id: 0F9C417DC5F
X-Rspamd-Action: no action

Make the implementation of this function compatible with clang's
compile-time thread-safety analysis by moving error-handling code to the
end of this function. No functionality has been changed.

Cc: Manish Chopra <manishc@marvell.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 56 ++++++++++++-----------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethe=
rnet/qlogic/qed/qed_mcp.c
index 7e37fe631a58..462e758c5890 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -467,7 +467,7 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 	int rc =3D 0;
=20
 	/* Wait until the mailbox is non-occupied */
-	do {
+	for (;;) {
 		/* Exit the loop if there is no pending command, or if the
 		 * pending command is completed during this iteration.
 		 * The spinlock stays locked until the command is sent.
@@ -486,18 +486,14 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
=20
 		spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
=20
+		if (++cnt >=3D QED_DRV_MB_MAX_RETRIES)
+			goto retries_exceeded_1;
+
 		if (QED_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP))
 			usleep_range(QED_MCP_RESP_ITER_US,
 				     QED_MCP_RESP_ITER_US * 2);
 		else
 			udelay(QED_MCP_RESP_ITER_US);
-	} while (++cnt < QED_DRV_MB_MAX_RETRIES);
-
-	if (cnt >=3D QED_DRV_MB_MAX_RETRIES) {
-		DP_NOTICE(p_hwfn,
-			  "The MFW mailbox is occupied by an uncompleted command. Failed to s=
end command 0x%08x [param 0x%08x].\n",
-			  p_mb_params->cmd, p_mb_params->param);
-		return -EAGAIN;
 	}
=20
 	/* Send the mailbox command */
@@ -513,7 +509,7 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 	spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
=20
 	/* Wait for the MFW response */
-	do {
+	for (;;) {
 		/* Exit the loop if the command is already completed, or if the
 		 * command is completed during this iteration.
 		 * The spinlock stays locked until the list element is removed.
@@ -537,24 +533,9 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 			goto err;
=20
 		spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
-	} while (++cnt < QED_DRV_MB_MAX_RETRIES);
-
-	if (cnt >=3D QED_DRV_MB_MAX_RETRIES) {
-		DP_NOTICE(p_hwfn,
-			  "The MFW failed to respond to command 0x%08x [param 0x%08x].\n",
-			  p_mb_params->cmd, p_mb_params->param);
-		qed_mcp_print_cpu_info(p_hwfn, p_ptt);
-
-		spin_lock_bh(&p_hwfn->mcp_info->cmd_lock);
-		qed_mcp_cmd_del_elem(p_hwfn, p_cmd_elem);
-		spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
=20
-		if (!QED_MB_FLAGS_IS_SET(p_mb_params, AVOID_BLOCK))
-			qed_mcp_cmd_set_blocking(p_hwfn, true);
-
-		qed_hw_err_notify(p_hwfn, p_ptt,
-				  QED_HW_ERR_MFW_RESP_FAIL, NULL);
-		return -EAGAIN;
+		if (++cnt >=3D QED_DRV_MB_MAX_RETRIES)
+			goto retries_exceeded_2;
 	}
=20
 	qed_mcp_cmd_del_elem(p_hwfn, p_cmd_elem);
@@ -576,6 +557,29 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 err:
 	spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
 	return rc;
+
+retries_exceeded_1:
+	DP_NOTICE(p_hwfn,
+		  "The MFW mailbox is occupied by an uncompleted command. Failed to se=
nd command 0x%08x [param 0x%08x].\n",
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
=20
 static int qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,

