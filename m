Return-Path: <netdev+bounces-272275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB8DBhu3xWnxAwUAu9opvQ
	(envelope-from <netdev+bounces-272275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:45:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDD133CBD4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 832AF301EF0D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596AF347BC6;
	Thu, 26 Mar 2026 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVXuBtEs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499F34216C
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565134; cv=none; b=MNANOb4Xkg2CsjsnlEkqqLlppqM7ilc6JIiwC2WlJ+l9vjzZpOHB5WqVRiDWGa/OLsLPpWscfb8tagwbUbkATyymwMe1sPbYAse7ns9H3D6Yum5CWoxTMz2S1KJW2MgDTwEIQ+rmlFeFUBn1wP3RLVB7Xp0elU4b4jcLMBSkoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565134; c=relaxed/simple;
	bh=oZYgYFj1aqx2X4B8JT5W6Sywd6j3ZYGmoQ5hWKQDfVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tokEYcDyimsH1xOX37COYRvwcy8/Txq+WhDpYC7Wosk5p7a17BHWX+avslT6FItgGvHdb7qFi7MtLWuO/hdOzdhWgE+yWRHavwAhEvxtF8VB1OOtkA6BBQmsOsBZ5Y0+erH0SCIRzNb7N/q3APVeZqXm/nqO0RO6I6PlpA548YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVXuBtEs; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35c0f03b2a1so4280308a91.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774565132; x=1775169932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEniFEpXYdog1o1ES50Hw6/3TT14/XWuA8fK5Ar+y7E=;
        b=pVXuBtEsS+x41nYy9uCU7Oc31h+E+a3wCT8JCRrS5uTzdt9+XlmQ1DkI2XXkrdAIO6
         IWZc6AcsLSteEL+sBIsPhKcKXo0itCTFLLmXEzzgWmFCCN7TtzTz8Ubx7+6mxN0r3x5C
         d+htrDeCp7FJLbemfbURk3WQMLiRPSzWHFpqXwJ410C00J+5o4eQ5wThs1vJsm5K1Yi7
         cgKKV1OwB2Qq2I7EXk+4EtA5yWkNQjtNpezIA4twxyi3EDiRnVuXHAmsrgKRXop0e5xz
         pLbQC/woW4n+nk1qQQ4ZqIGolTYsOG+3KKsiUbJ0BjfN0ZyeTSSlv4/d/6Nhu07C/uGZ
         Dr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774565132; x=1775169932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEniFEpXYdog1o1ES50Hw6/3TT14/XWuA8fK5Ar+y7E=;
        b=krUdthu5HUaSpsQ7dXckZNJSrntYyRDn+ZF3WKqk2cTL4R6T+HhiEtf0smrTx1/8YZ
         ufekJ4bsW18oaJxR2lzD1NaJstFySdC716F6SFfJ2ygsK4OYb9U+FWwEcVN9e9ar3/pb
         rTOOv7mgbQCRVKjhEs9hEK4kJb8+9kb48rYAGr5npNqwJUtqGwsZy5Wf+VmoCUru4oDd
         liIB/7rBb5fEtLy1Q7vPdFCkFtb9MUMlIMWyMehpnorrOTygHjDvQ5oy5h1DxcTHkOxI
         J2qg0RLr5PrQoXmHi3gSfL98HU8vi6hMUdCRQjvzIB9H2UijqRLvbp6bFIIbTgRRPQ+s
         q5nA==
X-Gm-Message-State: AOJu0YzAFXM8Vk4fFDjQvq4/94A+CiF2aduQHUfZmLmNUsgv2DEhQn59
	CPNYjTE5W1Mg/lbGRX3dYKW7XJTI/P9bQsY/zRyoUEfs1pjaCgk8nVlSH36C8496YQKv9B2Uz3G
	EdLVsIw0aIN2rgMjMoilKQMSHksJOItjv3uENAd7yEAcugJ7HfQBHq9lha5i4xKhcrdPFflR5AY
	viHMcZz3TMAnUNYpBKV892QsRuaOaT4WPiTVf16UoC4H4GHGSsY7/K+lU3IGH8SzE=
X-Received: from pgip3.prod.google.com ([2002:a63:c143:0:b0:c5e:84e5:d15c])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d83:b0:39b:edcd:d936 with SMTP id adf61e73a8af0-39c8787f016mr349555637.16.1774565131988;
 Thu, 26 Mar 2026 15:45:31 -0700 (PDT)
Date: Thu, 26 Mar 2026 22:45:25 +0000
In-Reply-To: <20260326224527.1044097-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326224527.1044097-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326224527.1044097-2-hramamurthy@google.com>
Subject: [PATCH net-next v2 1/3] gve: skip error logging for retryable AdminQ commands
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, yyd@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272275-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEDD133CBD4
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
2.53.0.1018.g2bb0e51243-goog


