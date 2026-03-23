Return-Path: <netdev+bounces-270814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGurLuTRwWk9XAQAu9opvQ
	(envelope-from <netdev+bounces-270814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:51:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6712FF12E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD5EF304B4F4
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE853845AA;
	Mon, 23 Mar 2026 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQCPdZ1G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB5310620
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309716; cv=none; b=BLKHqwQRxV+f/Owo1BerjGc9AT0i4JjlArbY7s63ZmfEmkUywi+v+pyzoeBDdtXp8MRrubav61m9ZQxIyR7o9xVwawBa7/YtHck9habfzmnVTXotDy6hex9m5X1ki1UThbIpnRowo/V0xZvF+nrKhz+XVwm5J+n7xYlo2+ZIzgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309716; c=relaxed/simple;
	bh=tH5DpAhEq37bg4pM1Dzw14/Yus49u6Ap/2euxNLrFXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NUKEuAxbFhyMOU9sLIdLIRwEvNEkT6uc68C0ElNIAA+Fhxbq4X4jfSN5keH2FXxjgHooPJqtyxBEUihXVyYSMpSoiNyMKyCembJJFwWNQnazHIgM/QoRGvrv3AA0Lbvk9m2SqLB5Xfma7Gd2w0hJNU4xIr69exuIbma2S5U1+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQCPdZ1G; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2adc527eaf5so6419335ad.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774309714; x=1774914514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCWqRJjoVJuaNpuRmiteVkOsirbUvugIgwz/r3CNIZ8=;
        b=CQCPdZ1GUbjiGZZMainGb2i98Ue+g6OVkNno8Glh59r0FyQHjsz9KhsuhSC1PaIaj/
         yT4FeABIud3SLlGgpXxhmJjTy7owJRIWljL4fFHJOVjtf0uhBcoXlzspEQfcJ4m3hRkx
         95tpDvK6Nv61OkAwTVl1cf3cJ9fAc5CVF3D6TBcryY11JLrWFSF9oNxAVEBpiAl+fRDY
         nin76kPX4scQ/v/MlanfgyPHwcwZBV5RIKgpDkrDZuAiyHt08P/e7IL3evO8vsdDwtTA
         XJw12WXAVdbEyh2G52n0zeeKxj1TS4mb9IXdSiSslyN3MwedMVQytrpizMtb7rf8JZCn
         1m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774309714; x=1774914514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCWqRJjoVJuaNpuRmiteVkOsirbUvugIgwz/r3CNIZ8=;
        b=dNM7ARdT1b1wMGlTWNYi9wJbUVx8z+fa3i7aFPwcHQMvpToyQUN7QOq5c6D/qTxhRC
         1a5C9FXI0OdDt1WFQPW5ldkWF7l+pCpTYzCo7HAyP6xE1Cqp1cbarWBcnE87H0nwws3l
         T1EX5i7WZwEdUIZNfYtmio7HX7OHui/2Yzb8HIt7e9sGS9TN9CcEem2lIR2KtSIMErSQ
         e8HgBNuoTKLFz90z73OccB37T7EcpLgkyPPj0PgYUxlxLfckr9HdCEsg+asapZqvcW0M
         KMZYZiBcIrzC4MFfJz5w++kBfU/DpM4L81hUoJ90rWroxY+e9sHlPNd9d6fZs35exOIa
         zkuw==
X-Gm-Message-State: AOJu0YxaQuKUAU4eYWiTYgBnFO4Z5aVaJnLhEFuS7QZ3Hfp2I5n8sRGP
	aBzegtzkBDxVFxh/Kv58ghNfaZr9Ofm8r9/iYSBggnwkAI7Bl696ByFSx94UQnxBtETpCmnjCfA
	7YhPgL2diY5GFRICDdpHTHDV2nQrdjHpkHiV7nmCf6RHsmqQ6Fswl5VqaDtp2uYlvrlChREdglw
	Hu0kX4ndmicoYoDsrtLIK07x6pqsagwj5kfFDsr+ynQAuYENdyW56pKyy/iuIJpN8=
X-Received: from plbv22.prod.google.com ([2002:a17:903:44d6:b0:2ae:4ac1:400f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d488:b0:2b0:4f82:74b4 with SMTP id d9443c01a7336-2b0827ca214mr131130345ad.47.1774309714070;
 Mon, 23 Mar 2026 16:48:34 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:48:27 +0000
In-Reply-To: <20260323234829.3185051-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323234829.3185051-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323234829.3185051-2-hramamurthy@google.com>
Subject: [PATCH net-next 1/3] gve: skip error logging for retryable AdminQ commands
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270814-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D6712FF12E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jordan Rhee <jordanrhee@google.com>

AdminQ commands may return -EAGAIN under certain transient conditions.
These commands are intended to be retried by the driver, so logging
a formal error to the system log is misleading and creates
unnecessary noise.

Modify the logging logic to skip the error message when the result
is -EAGAIN.

Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 26 +++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 08587bf40ed4..c7834614c5f0 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -416,11 +416,6 @@ static bool gve_adminq_wait_for_cmd(struct gve_priv *priv, u32 prod_cnt)
 
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
@@ -455,6 +450,16 @@ static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
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
@@ -482,9 +487,18 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
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
2.53.0.851.ga537e3e6e9-goog


