Return-Path: <netdev+bounces-286849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB93CstjAmossQEAu9opvQ
	(envelope-from <netdev+bounces-286849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:18:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E092517387
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDA7E3021E59
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4646935FF57;
	Mon, 11 May 2026 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXQVoEZi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD133F8B7
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541497; cv=none; b=I+3U61oP7n7bKg5VtYO1VSBMBk+J+XijttAaPVTsHjlfHzFPHmIg2UWVQMsiTwr1LezhlcnICc0cEUzSuEAN/XNzoS92rHq1w93gL5D7LhSxaAC9AuO3mr5QUA92FYLDu+jwJovdoCZ/kMSPPKdQ0kiAGbhVCWm+EIiK6MmuJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541497; c=relaxed/simple;
	bh=D7jwT5+P9GPaKtdOknKfFHUVxk8SJE5ICTBFYQ/syWg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l3e5N+0WHQUg7hWaRWuDloVo5zB013XdTvLeYPMfq7mOc+SoBqsYmFmnXGv9HIh8DB44Amq5q09mAdwcFC5MGF6tBiGjWIoBuFuBDgTOdgzsixsdZIlpaFn0c6a1oyr+eJV4EEGWia63Yhy7JzLoVlSzp/GKc2n4KqK9b1Q/ThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXQVoEZi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b7c904d476so52607535ad.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778541495; x=1779146295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVRjWnF7dfpw+sf9w400yMSAjapoX6G6soK/dql9e+8=;
        b=VXQVoEZilDHsjI3QnUjON2Pd/F6xt84Etcc+Thm0V/9K7qqNTZqRCjQadJivfQi+Rq
         vCSOUoMlxj1zVL811gwuj+9jKsWynKYnQ37eRMz3jyY8ViDuB2AFJ928c1CUDudSRgDJ
         tHs5h4PzZ7sTXewy+7uS/QKbaE+aaIR2M8nZ87yC/tNiNAigwJuPajU+krZsx6VZOCw9
         hO9EzIpkqho4X3CaReQIL4nOMLO4c0kDe/3XMxBFirrXQ6BcYXVgq/xoSuDcPsatqS0w
         Fq7/X/tpHIgH9uRLzwZjWeQZeQ9k+2aTjlqNBUTAcsFBvku3v3h5j2nmq859pMLcr83I
         Y6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778541495; x=1779146295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVRjWnF7dfpw+sf9w400yMSAjapoX6G6soK/dql9e+8=;
        b=JNEvxrXpuaZeQ3KrLobhheaKVgofXtCMaw2Snm2n5KxEJTQ/Dc1aQjh8eQipwuOQi4
         UWHJGItNV+DymqNej7+Hx+jxK/JwZqZ/VVqRjEiU5nLSPlNA1k4jrVlrfr3kWQFKZNGC
         h5DuyF+Soh6mhhoDxia2EilECr+hJWu0y6fOF+fDqSdUK8OgREdF2CDK69MQU+NIYwfU
         mil6hpPDhKGhf9+u3VZEg+cG8bIrhHuByZLrAscssGqR02f3cjaUPMfo6CD7VcE7R3VO
         HbiNAMqp/bNKM4rbGL0pvS2DRhVhpF2RagtkjBSaI1cS4mT6fQq8pa1cn/DL7p4O0J6Q
         ScyA==
X-Gm-Message-State: AOJu0Yzv8t/mzjy/46huhIBr9XELjMcFAFStnmEbs3JxLWMlF5CH76G8
	3g/1OvQY2CIM2+y4Cg8Pz4M/j4Y6tdcwBhdeUIlVgXH4wfq1156qK9j/cEUxs75m/zA1EJ66zNU
	Oz7xAbEW+jP/6SlzzcwSBKNPtoXK3Y9kEUrYWUhl5E+kGC5ECUa9i8FQE4qxVX0RuTECpMtotkP
	jm1WXTSzCcyrYC6EpJIkq1Pk3lnFg2vGmdu/FqpnM4puWCMbKo+ECNjBi0OR0JxUc=
X-Received: from plps22.prod.google.com ([2002:a17:902:9896:b0:2ba:f5a6:38db])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f70b:b0:2b9:ea53:4cfc with SMTP id d9443c01a7336-2bc7aa204a9mr116417635ad.19.1778541494921;
 Mon, 11 May 2026 16:18:14 -0700 (PDT)
Date: Mon, 11 May 2026 23:18:10 +0000
In-Reply-To: <20260511231812.1801984-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511231812.1801984-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511231812.1801984-2-hramamurthy@google.com>
Subject: [PATCH net-next v7 1/3] gve: skip error logging for retryable AdminQ commands
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, jstultz@google.com, tglx@kernel.org, 
	sboyd@kernel.org, willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, jordanrhee@google.com, 
	thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com, 
	horms@kernel.org, dwmw2@infradead.org, jacob.e.keller@intel.com, 
	yyd@google.com, jefrogers@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7E092517387
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286849-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

From: Jordan Rhee <jordanrhee@google.com>

AdminQ commands may return -EAGAIN under certain transient conditions.
These commands are intended to be retried by the driver, so logging
a formal error to the system log is misleading and creates
unnecessary noise.

Modify the logging logic to skip the error message when the result
is -EAGAIN, and move logging to dev_err_ratelimited() to avoid
spamming the log.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v7:
- fixed type of err to be int instead of u32 (Sashiko)
- Picked up Jake Keller's review tag

Changes in v4:
- call out change to dev_err_ratelimited() in the commit message (Jacob Keller)
- remove extra print when adminQ status is GVE_ADMINQ_COMMAND_UNSET (Jacob Keller)
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 30 ++++++++++++++------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 08587bf40ed4..c7544cd1d857 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -416,16 +416,10 @@ static bool gve_adminq_wait_for_cmd(struct gve_priv *priv, u32 prod_cnt)
 
 static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
 {
-	if (status != GVE_ADMINQ_COMMAND_PASSED &&
-	    status != GVE_ADMINQ_COMMAND_UNSET) {
-		dev_err(&priv->pdev->dev, "AQ command failed with status %d\n", status);
-		priv->adminq_cmd_fail++;
-	}
 	switch (status) {
 	case GVE_ADMINQ_COMMAND_PASSED:
 		return 0;
 	case GVE_ADMINQ_COMMAND_UNSET:
-		dev_err(&priv->pdev->dev, "parse_aq_err: err and status both unset, this should not be possible.\n");
 		return -EINVAL;
 	case GVE_ADMINQ_COMMAND_ERROR_ABORTED:
 	case GVE_ADMINQ_COMMAND_ERROR_CANCELLED:
@@ -455,6 +449,16 @@ static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
 	}
 }
 
+static bool gve_adminq_is_retryable(enum gve_adminq_opcodes opcode)
+{
+	switch (opcode) {
+	case GVE_ADMINQ_REPORT_NIC_TIMESTAMP:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /* Flushes all AQ commands currently queued and waits for them to complete.
  * If there are failures, it will return the first error.
  */
@@ -477,14 +481,24 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
 
 	for (i = tail; i < head; i++) {
 		union gve_adminq_command *cmd;
-		u32 status, err;
+		u32 status;
+		int err;
 
 		cmd = &priv->adminq[i & priv->adminq_mask];
 		status = be32_to_cpu(READ_ONCE(cmd->status));
 		err = gve_adminq_parse_err(priv, status);
-		if (err)
+		if (err) {
+			enum gve_adminq_opcodes opcode =
+				be32_to_cpu(READ_ONCE(cmd->opcode));
+			priv->adminq_cmd_fail++;
+			if (!gve_adminq_is_retryable(opcode) || err != -EAGAIN)
+				dev_err_ratelimited(&priv->pdev->dev,
+						    "AQ command %d failed with status %d\n",
+						    opcode, status);
+
 			// Return the first error if we failed.
 			return err;
+		}
 	}
 
 	return 0;
-- 
2.54.0.563.g4f69b47b94-goog


