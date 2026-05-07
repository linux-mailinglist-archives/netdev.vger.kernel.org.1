Return-Path: <netdev+bounces-285493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNCTEnIA/WmxVwAAu9opvQ
	(envelope-from <netdev+bounces-285493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:13:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD69A4EF267
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 607A13035B48
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913DD341AD6;
	Thu,  7 May 2026 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y371287X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737033ADA0
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188389; cv=none; b=jsNAD0++UZvxJcUVLAtySba+nSnJdYXYUI3IHLg4PuO/pwxCqoiAJURXg8sFNRuUjE2g5IEk9gHq8vuD4GmJSFw/yaK811IHlKPkwjRjj8dHyhaNAvXqhLcfMxm7/adNQ91TFIsCQ1ScILA8U+pL2JxgsbNXEvgrHTGF4SwxfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188389; c=relaxed/simple;
	bh=xGCwW9AJ00w0E9A81uL8RSVHIPPhwZ/YeQ2rEJ++s8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UF6pohdeLtAXQvlcLQh59y5EqsQlILElxuir7GGcqsrARWZ1yzCxqEdgqW+e56Gjgq0bDKN/KwIq4p67SaiqcdvnpaE/1ixtmwNg/dgt0quWEfwwElEA1qPooy/H1OTzy6/57fHrhDzAeWAptUpFl1RfXOh+5OHE+HYVFyQK2rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y371287X; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c80b103360cso736965a12.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778188388; x=1778793188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B/sqZJ2nakkLZrxrJSKax1gOUohwsZLRlvLL9dCFNUk=;
        b=Y371287XpAj/hDctipR/DeYdogkp7MQO6kCAYUBgz8sdqU1UHp8HudfewwBq4pK1Ro
         I83whixGaRpIruIluiZcV0Ylm9GEnEaC2Sfe3SHBXMKTXEugisphkJz/aqNy5UqeHQh/
         IXWCdiTgVHyoNK0q1x9xwFphi0IvacX5eePzsFitD/oX1kJsh5Yjek4uZNfcSejSTIdU
         fEOvIMK6I7bg6p7Z7UUAT4U0swQ19JwbjCJidJQgFa/o5C1QwPpk6YRDNaxV/shspBd0
         2r4SiB/JAIchh115AwDMZS5FaOpwjcgmaxqul3DLOtr2h91iRG+bNbYE6hwepY+TVYdw
         ZI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778188388; x=1778793188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/sqZJ2nakkLZrxrJSKax1gOUohwsZLRlvLL9dCFNUk=;
        b=N9Y1Tgca7UOOhdp9GOTgrko1ZZSaitD4ArjbDt90mtBIanQZJSz2l7gwgZWFuB9DDM
         ptsL2C2xEoYDr4CdfESeLyuat8rb/5v2ZWZzNnnkmZzonWvKZ2VgqRI1I6RWoypimSQ5
         wbRw4O2Z0FuLFo+oo+6cpk2rGKHnPZtuC4EAfH28uSBll66p+caBgYvOT0VxB/TGWAoG
         zLCN7HAqdQCEoKxBYA0D7uMql+/2401MHpL3aYSDRCCusBwx2ygfXsy1G0DdyhAvn3ru
         513yaIpYMyHOraeNben2YWpwmKxwi3JO2ILCQT2T36+7kUz9oN73R3wvFtHt8QWivqnk
         xJDQ==
X-Gm-Message-State: AOJu0YxcsZ065pIQOfcPEI1c5eAi2i39tUc9mEd5HYEQ22zVCvjHEK2r
	a8MsCL5I+ISBKWM0b4YpKEPd8LHnCAl3mVPWD2+U1lTQGGmfh6rDbQW4Esj10s6alIbFyvkgLOn
	EWET49t9mU4r9JDmCfnH6hGjZ2rrZHWnPW2CNkpw6y39nrXR+I3q8R7Z2vjhk7uDU2yCaUFD8OR
	HIOoC91HkiWM5WLfzTZnhpPDp28jdidPyK7lyaM3xQhtlfUdYNDaMQYNLoiJYCM4w=
X-Received: from pgjw1.prod.google.com ([2002:a63:fb41:0:b0:c7b:fdce:6626])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9392:b0:3a2:ebfc:6bf5 with SMTP id adf61e73a8af0-3aa5ac1aa08mr10649787637.52.1778188387276;
 Thu, 07 May 2026 14:13:07 -0700 (PDT)
Date: Thu,  7 May 2026 21:13:02 +0000
In-Reply-To: <20260507211304.3046526-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507211304.3046526-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507211304.3046526-2-hramamurthy@google.com>
Subject: [PATCH net-next v6 1/3] gve: skip error logging for retryable AdminQ commands
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
X-Rspamd-Queue-Id: DD69A4EF267
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285493-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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


