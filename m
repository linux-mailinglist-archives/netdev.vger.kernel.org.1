Return-Path: <netdev+bounces-275780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIN4F3dE1GnVsQcAu9opvQ
	(envelope-from <netdev+bounces-275780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:40:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FA63A833C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 052B03051CA4
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 23:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D283A0E95;
	Mon,  6 Apr 2026 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+Y4qcVw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218F331204
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775518809; cv=none; b=uhrWDj4feQzjtCjZ6Z9nStpKwTBdISIRUvmfKqaPEe7/7iY+jJGugzwdvGS+SrrWScpNcqcVYjRV6T20NYW+VCiBsKU4lBunLw9ngJtaEAZgWnrY25QzYdGt6vpR/lftQ/jGdUPwoOwiuyFiJeA0ly1ny/bddFrrklpi0tS3NRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775518809; c=relaxed/simple;
	bh=CWIkWtwpJeb4vHJFfC4PCEjDUMuaeBaM7uMpBBqmiGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=atWU1u0kACXOIeAW6SuzuuJwS9V+tsC98qKyE2TtEqF99BYpOygAAqNA6K4S5QR6KVMDdpLxrujGRb0moPU7kosFldcy/DgdvZhmrUy5S/Bnk3UKj+okPGV7AwP36EchJVoYFUw85E2Tb4K1+PUA9mZwJW2XD01gFcSoPQ65EiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+Y4qcVw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0c30b51bfso98679195ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775518807; x=1776123607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BUO3CLc2gtSy2zH66hbdhPx8499IHw5WXw0lt20Nxg=;
        b=S+Y4qcVwZA3TJjXejDkzJ/L9xQWwigJJ8uquCpSRFilciIeTs25vvsfRDhrrgqo9qx
         T0bk1n0R5Hs+/bUTcbEmS/xIiGE07O6FHMK8vSZ01GBjB0ze2z6RVRHSTA0wuEg5WMBJ
         Zm1P08JAptpw/bSOXq7jG4WKFwXB9diFP0jJPRTsxbLucQmelyHpeWk+lqXQ367Vg+Pb
         CCuQ1p8d6pubFKumUJGZ7rNrjoRnuCd+1Wz8w9XuJ6K+1sFqnbW0YwK8qrlyxSxG9RbF
         6zQL60/t9UQLmviPE+bXosEi/4NEPrkzdVCIR7IemmlUmv6bYD0CMonXMFCnAIIbnWf9
         THgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775518807; x=1776123607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BUO3CLc2gtSy2zH66hbdhPx8499IHw5WXw0lt20Nxg=;
        b=eYJ5QAtgR0c4X8B27tG4IMaz6vnCi+tdHpm1v8gtGykR8ypJ3FN/F+fgNKw2efGlbU
         DgIHKZC1XGcywuQ2HetCQpeiHDtDdASpdVXcyZpIpIP3tcPdFsaeaROYnWygtuEEnf3m
         WQ2EFh9VpPoHCBqTuHW8+7ktzVZOczdi/zNk4KPgRgeBb1YHqdGo1oMlV/On/9IGhziy
         ayNnyjbbXZB07gQSAzCUDyZAHZJgqtBVOSv09+ZZzajpS34HKmaA7GAJ0JR8TwBaE9rh
         YZXVNY3DJxaJoigtG6jjWZCvUe9MBcELKtzNSQX2iZ7dpg1p+N8eQICo54pl8vL8RIwy
         nQ/Q==
X-Gm-Message-State: AOJu0YzNTSzNJuS8bvGYivzFn5zE3g5DdD/+LQZ09uw4GOmXiPVbAzgE
	MQwLAbS/yu4f9OPgCExOMUyrjqaSN/ue9759W3sur+ZMW4N0XDgBQU+EAG8Zr0ULSmGfpn901qZ
	hIoc6o34bpcNgVz8jtCgJKIml/j/BZ1tw+NrZbQNoKLxT8bR+uuwF4QO4cxx2pSA9y3/oi8Q84e
	8Sbia95mfgWnlPCxFeznrVzyS4fMbx/LphDSHDEi8S5kHGro0DgSpMjz3qGX/f3lk=
X-Received: from pgbdp9.prod.google.com ([2002:a05:6a02:f09:b0:c73:bb62:5551])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:b114:b0:39f:3559:7501 with SMTP id adf61e73a8af0-39f35597682mr9949018637.41.1775518806372;
 Mon, 06 Apr 2026 16:40:06 -0700 (PDT)
Date: Mon,  6 Apr 2026 23:40:00 +0000
In-Reply-To: <20260406234002.3610542-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406234002.3610542-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260406234002.3610542-2-hramamurthy@google.com>
Subject: [PATCH net-next v4 1/3] gve: skip error logging for retryable AdminQ commands
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, yyd@google.com, jacob.e.keller@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275780-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21]
X-Rspamd-Queue-Id: D2FA63A833C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.53.0.1213.gd9a14994de-goog


