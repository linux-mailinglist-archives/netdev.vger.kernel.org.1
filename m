Return-Path: <netdev+bounces-288091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ovVNFK9TBmr1igIAu9opvQ
	(envelope-from <netdev+bounces-288091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:58:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E02305479BB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C50A3015483
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0073D25C2;
	Thu, 14 May 2026 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzYWpsSY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3563D16E6
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799527; cv=none; b=maVYUJHKd6QeaKDBhMoSFMgfskCRJCWoO7us8su153oSSxQqiyJcgCruYqsOgvGHkv5znpmXeI7+Q9CcDJQEj7IUYx6Gj0cpl3XBq85n7FqLdFd+v5AVemYP1E0JpRlpF0el6rsnYSLJrbvKX9tiSYAn9b8xLV9rbBI1GeTHWs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799527; c=relaxed/simple;
	bh=CXVoIcOPxuaRksdpmx75MC8YcIdnTFdvqdwC7VXYXJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OxEp2c64vkg5Cl5j5SWj07NF5KPInDe98cPNjU4P806WcwQHY8DfyOg1xaBy6JIzLpnGzAgpFPyIQJU69Dp/3a8Ga88+8RGesBDQog6g3ronxNGgPqAh7UNO4aShO4YeTy5yz0x87vlUCdKpdBDyDg+y5LjpI8U74Me6fuxePa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uzYWpsSY; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828ab3b033so6269517a12.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778799525; x=1779404325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aFT5tLSU9O68WCt/3vE5Fxc50rKqQbewtmrSVI5069c=;
        b=uzYWpsSYubtSJQ/47Q2TqV++ZLF3iezBtEV1//gKXb6SBJJLVzAfhx0d+uXerXmw6/
         g8gxded/JNlUMgXYnKiSMM2LBN7jWj4v3Lz6WilpUZvcwGTbWOdyOKAo+pRWdEFCUW0m
         RnN+7p0ki/H7r3B3IdGjeOpTmkMi5+9lxIATTHHydk51iU61Y4/90kz/Ye1XNP7kjuOv
         Bs2Abj96AMdNNPQXH0k1dolNV6tu+oC7C9uwZDcJq9IcwbR8x24KrUQh6P7ATeJjcdH/
         ZxZ6FVskN4otmSoK1eg+rhJEIhFf7paY/O8XGUdZrz7pjkAfEMrrgJzbqBLwHAUPR05c
         i+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778799525; x=1779404325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFT5tLSU9O68WCt/3vE5Fxc50rKqQbewtmrSVI5069c=;
        b=bdImztRG3LU/CfkwJrSY+e92a6OdxB6njZUN4ZRobuOTwTRpWpffrQ8EPoMSJasSr4
         EjywucQoU21HzQaX/gbg3b/OnHg3JZZSXJYie5FTWmb8Kswv7L4NsJH8RIdjr8X7K2mr
         i2U/LTru8kGyx34CEflEzOU3nICUch1KzJ9FwEvyZcpqTnHiYnjhHQ43c75bxlpjSYon
         gw2rqSEg9Xf8QpU64tEzE/xHBEH0YO+a/QEwZAMWCfVyMj1XFb8gxlv/wdnvujyZZ5vB
         3XUCKmtEOWpR6dsOJRLanYxjQV35NWn9Um2yZ2JGZ+uFMgPcqMTGz5Bwtgz3/9SJoRvb
         Qftg==
X-Gm-Message-State: AOJu0Yz89ks1tdHnTpumvOrUrOH71xdCWJQp/ae7g3YKcrowpS3Q8T/T
	WIs08IzozlQ29zcnz1SY1upgWTjf9fJzikPfoNbCzLjWTLD/3bV0X+hnNubTRh8DrKpD/aXR/V+
	kv2XJCRR5qqPemYmcdrf10Fg25zJ92AdwwtS1ggXCCWt7bjEY6anMqTZFOEy6BsmDyySYPvY5WJ
	S65logkrys2gFIsGea9mZ51WcsI9d9yZC80vBFEjy1j7Ba/xvq0vLXQPG/nFEkZAM=
X-Received: from pfbmd16.prod.google.com ([2002:a05:6a00:7710:b0:838:4903:1f13])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e13:b0:835:388c:9764 with SMTP id d2e1a72fcca58-83f33deabafmr1429077b3a.37.1778799524958;
 Thu, 14 May 2026 15:58:44 -0700 (PDT)
Date: Thu, 14 May 2026 22:58:40 +0000
In-Reply-To: <20260514225842.110706-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514225842.110706-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260514225842.110706-2-hramamurthy@google.com>
Subject: [PATCH net-next v8 1/3] gve: skip error logging for retryable AdminQ commands
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
X-Rspamd-Queue-Id: E02305479BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-288091-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
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
Changes in v8:
- Fixed opcode extraction for extended commands (Sashiko)

Changes in v7:
- fixed type of err to be int instead of u32 (Sashiko)
- Picked up Jake Keller's review tag

Changes in v4:
- call out change to dev_err_ratelimited() in the commit message (Jacob Keller)
- remove extra print when adminQ status is GVE_ADMINQ_COMMAND_UNSET (Jacob Keller)
---
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 41 ++++++++++++++++----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 08587bf40ed4..0d5a67523cba 100644
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
@@ -455,6 +449,27 @@ static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
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
+static enum gve_adminq_opcodes gve_extract_opcode(union gve_adminq_command *cmd)
+{
+	u32 opcode;
+
+	opcode = be32_to_cpu(READ_ONCE(cmd->opcode));
+	if (opcode == GVE_ADMINQ_EXTENDED_COMMAND)
+		opcode = be32_to_cpu(cmd->extended_command.inner_opcode);
+
+	return opcode;
+}
+
 /* Flushes all AQ commands currently queued and waits for them to complete.
  * If there are failures, it will return the first error.
  */
@@ -477,14 +492,24 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
 
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
+			enum gve_adminq_opcodes opcode = gve_extract_opcode(cmd);
+
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


