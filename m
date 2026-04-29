Return-Path: <netdev+bounces-282173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NDoL8he8WmFgQEAu9opvQ
	(envelope-from <netdev+bounces-282173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:28:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 011DA48DF6F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56DCF3016FD0
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF042571C7;
	Wed, 29 Apr 2026 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTZrDMnw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC97623ED5B
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426107; cv=none; b=obh6Et+HxOKTm5khCxMXW0P8AsBngxeCe4mp7tYKyE+ZgqA2PfRUnhzhIQfIN1XluHf4Cy5qtYwHxemcSv1hkAoIAD87ArKyVEgZWIT/m0UmScR+7eB2n6yeQvTdBzuY/0ZmjeKyfH0I0uux7p4eI4hp/wZc1C8NB0y+smxfgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426107; c=relaxed/simple;
	bh=xGCwW9AJ00w0E9A81uL8RSVHIPPhwZ/YeQ2rEJ++s8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FgJfWPesMDUUobRdphuiggmuqttQUc4yGOLs9CRisL+mDBMqU0by2rE87ZSx9Tigr6WzJPrdX7nBHyfpAlY6SI0gxlQesbDtAbNy7WoAIYfIUVfSBCB0HDKU2377j3Pig7IcdpjhpDyb5LKm2GZP69DvlCsVTx1H4p4RyGVc5/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NTZrDMnw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2e91add2aso22681495ad.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777426105; x=1778030905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B/sqZJ2nakkLZrxrJSKax1gOUohwsZLRlvLL9dCFNUk=;
        b=NTZrDMnwap6d8k5krbMSUDLKYe8Jx4JvAplxIKNJPhnkS7ZN7ApdUbQRcbFu+7yI9A
         kOwNUFQcOiHCq3o2U7kTALKbH/zWad4+n006f24obW/0X3KkrQKXGYrDWZRCRTLD9zGu
         KbXncm9ManJsiP7GY7U5vyhNCk1FK1KXwhIz4Oh46vIknBd+p/p5TP1jU1S1x3zxA5vm
         hANvn8AqaRVsqyzobh0ThTykRQ0zYShh/T1vIvr8ZR/WhWmvpYFKcUZANtDGKTtF9/kI
         RF2O4I58NyR/ECbFpmUz6coy5nIg35vmdTH1R7mlywz7hsQ0XOsOzAkz6xRCmSOGABVX
         mvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777426105; x=1778030905;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/sqZJ2nakkLZrxrJSKax1gOUohwsZLRlvLL9dCFNUk=;
        b=FolyC2Ngy9+n0FV5IH0+1Y054xWxGNBSk6SEr/0IuhqpoDB94BYYgytZQGCw73ujYV
         zVeNIbfhsLrvwVPYHJpZlshxi4UFer7xuTSYG9DiLj/H40ztf8sHU8L3G/72XFG1DNh2
         4K6mLK4uV5sfFFemamEEorhi8VRcIV3t+q/AVZNBlYGNE8ywUwMRDAWjhjKjyA4Zor0S
         wQ2vJYBeOpz0xx6Hrj4EoBkMKmUKQcdH3NkOtTyQxyIDP9A/QGmQ3j95QHKJ4lFLhAC9
         jlL3WZxnlZ+5aYcONyk1pKhNyhrWWsIbo9tGsTw70FeAWJVBOnW8fiUK3kJl8bIO/RrX
         NvMA==
X-Gm-Message-State: AOJu0YyjHGfcaLPwmIum2M+il5aJvSSg/U4T7Bf5yekDvDZQscraqr3Y
	IyBEex9PyhFU3wFbscSEVsLqlWTnBre6DXt5sn7XGC7kIsEy/8WX2Z7sK7gaNZI/ZdKUrh8Xt1t
	tKHerZKXn6TviHlPgM22bgzFFSpg974RbayK25AMjFbl7fBtBW8ueM2rjxHALI/tq9DI2hdcAJq
	3H9CS1Q0I5dOyVqV8A0XE7de9CzzTLEZ3L6dPtI+S5uK8S13hyFdW0Wj3GgesNDEI=
X-Received: from plbkk13.prod.google.com ([2002:a17:903:70d:b0:2b2:506e:862d])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a2b:b0:2b0:9101:1b77 with SMTP id d9443c01a7336-2b987391b1bmr17075435ad.17.1777426104885;
 Tue, 28 Apr 2026 18:28:24 -0700 (PDT)
Date: Wed, 29 Apr 2026 01:28:17 +0000
In-Reply-To: <20260429012819.3102675-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260429012819.3102675-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429012819.3102675-2-hramamurthy@google.com>
Subject: [PATCH net-next v5 1/3] gve: skip error logging for retryable AdminQ commands
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, jstultz@google.com, tglx@kernel.org, 
	sboyd@kernel.org, willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, jordanrhee@google.com, 
	thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com, 
	horms@kernel.org, dwmw2@infradead.org, jacob.e.keller@intel.com, 
	yyd@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 011DA48DF6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282173-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Jordan Rhee <jordanrhee@google.com>

AdminQ commands may return -EAGAIN under certain transient conditions.
These commands are intended to be retried by the driver, so logging
a formal error to the system log is misleading and creates
unnecessary noise.

Modify the logging logic to skip the error message when the result
is -EAGAIN, and move logging to dev_err_ratelimited() to avoid
spamming the log.

Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v4:
- call out change to dev_err_ratelimited() in the commit message (Jacob Keller)
- remove extra print when adminQ status is GVE_ADMINQ_COMMAND_UNSET (Jacob Keller)
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 27 +++++++++++++++-----
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 08587bf40ed4..a65b14835aa0 100644
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
@@ -482,9 +486,18 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
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
2.54.0.545.g6539524ca2-goog


