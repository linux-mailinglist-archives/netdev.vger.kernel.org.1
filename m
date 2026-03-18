Return-Path: <netdev+bounces-269212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDngAcsyu2mEggIAu9opvQ
	(envelope-from <netdev+bounces-269212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:18:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 108002C3C82
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91E7D301FB48
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA8B2BEC2B;
	Wed, 18 Mar 2026 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwfeHWyU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B771C862F
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773875908; cv=none; b=TF56SvjIRV4FMDyGonXe12sNnvYoTdcQ0ZR5cYxiq9F0zO/oU/1MynTSR19bMz4SyRUAiCNYPH4GgvpeeWTamDRI+py47/DRmiDU8silZeHUzziplSh950hZnwQG2HBgwPyhhyAtSght+jAQ/2EdSaajoco2tC9R0IWDE9K+lGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773875908; c=relaxed/simple;
	bh=3ldCpbjIReo95e8rkIL7Ovh12cZctQtYjWJOgbLFguw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0FytJZ3yrBsclMa4OaraLZF79NiPEQGjXuIpqflSqhueZYiY9hJK5bSSNOk6oSiCYLY5dH1mPSlGvdQiw5JI/FlZ7O9AqDOt6WpDq0acGcXrhruEJBX2EOSnlOMJzkZyqZ3TPUju0laUHjiw7+WTq2v5s6w/ZUg3ybgBui5IgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwfeHWyU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b4121c40aso200368f8f.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773875905; x=1774480705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ehy3LFEv1Okh2NOHU6J1PJlVKYSWvARVIndgmZ+QFx0=;
        b=YwfeHWyUq+mJYLcLrZUWWnNl5/vcijDRLceuen61DtAlbKYrm/LCajUV/VFmonNYEL
         U8U9zHX43OtACGldfmi4c3dsA72tdoRUTLrcFoE708q0Lwray29RrcL2m1EMux0mWr4o
         2nrlUSaOWq98UDkUDAW0gJv1TuqkpthA7pg+Q9LiGtvjA3Hsf0sznD6uIXHvR/3Ln+tA
         7S4TkkQJyF8BRAhtL9QhweiZzg+iJCkSIqd1T/5rKk7WGii94rUtuEF9+EmNAzxbBV8g
         UB6Nf8pmc6ebIcgr8Ah3VIzBHlaObQGHxSUbZa+7nZb9PMteEJlcdJfOelFNtQ+C0OFx
         HNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773875905; x=1774480705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ehy3LFEv1Okh2NOHU6J1PJlVKYSWvARVIndgmZ+QFx0=;
        b=T9m2uHeoowPcfngIrXRf3vWsfSKKp46iL8x3cOmnG1eqIhEIud70gxL241boQNwJQU
         f2VInTaMrSeSsTiyl8k1wdNQx8QWs87j2w4xb+XBDo8j2b10NAd+1elxchWWAFnqd1nr
         0Kgql0GPys1bOer4sgobhQgnS8p0CidQW9h55OOqGiWmAa3vyjYS57E9vM5CzKVLfXEm
         KBDtVd5z3d9GSzdIXu995qrph+mFU/qANHWYsgpHNdE8zwlVKXr5829TPehvPsAvLeyX
         M+Tb7hR/S9ehj10+LY9In/Fv5sc15FZsMmPQJEF00FD6aitYHShBSM/QigJ9KrV5dY5x
         A/EA==
X-Gm-Message-State: AOJu0YxGJMz5w4T9bBYpjTNnsg1EPaD7/1bJSWLNDUmEBYg6nVT96ov9
	JQOJ20vMZ9IY1CWI4zM4B6gLccp1U+e9bwNE4UdEpJ8LsuIM8UnvCNmt
X-Gm-Gg: ATEYQzznMae+WWATPiD9j5zK9kyTxWkw0Il0Pr4+QHf44qFEvI0+A46YexNSDUaWOt4
	+tV3cCnZe5W0s5YgXaYmdy0Fs/2CBZlqMldTqvfxCsE2mZnqMfk5svrfNBhTxyYddsNPqB0cbz8
	Z9IfF2TukjyiiAURS1Xzx+i+bdjnUoP4p2ZVnlr1v792s4Uil3xWi58btjTYP/+7w3zDucLyDIE
	b/xVDV4PFxZ9U7rAW9ysI+UTrFVgNlZ8JriNNHD8AneIBjFHx7fg3iLu3J1QOqi/CNUMyjmcMjb
	99ISyfflFFSa1C6UyrnsZYPJRQ+G0ymsx3w9hFxVI1E3j7a4FbN5jWOcnp5D8gEYXdHlZEyavlw
	jZCp6/W3TfOuluBW9aOBv/JM8MoyG04l98OwLcrwem0H93sW5E4xjgD2fkJgQexBHSK8oyyZuA9
	qvq+UZtL2GDTCZ6LkZp9tNiMur7zXX4rGWqFeNcUrG2oeQjA/l8pZE9g7SgI5Vq+pnJ4hj0yN2p
	rE6jMzRKmIK
X-Received: by 2002:a05:6000:1a8e:b0:439:b619:33b2 with SMTP id ffacd0b85a97d-43b527c903bmr8857309f8f.43.1773875904693;
        Wed, 18 Mar 2026 16:18:24 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b5184957bsm12325685f8f.5.2026.03.18.16.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 16:18:24 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] iavf: replace strcat chain with snprintf in iavf_print_adv_rss_cfg
Date: Wed, 18 Mar 2026 23:18:21 +0000
Message-ID: <20260318231821.43551-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-269212-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.739];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 108002C3C82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The hash option string was built using memset + 11 strcat() calls,
which is both unbounded and needlessly verbose. Use a single snprintf()
instead. Also drop the static qualifier on the buffer since there's
no reason for it to persist across calls, and shrink it from 300 to
128 bytes (worst case output is ~85 bytes).

No functional change.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../net/ethernet/intel/iavf/iavf_adv_rss.c    | 73 ++++++++-----------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
index 4d12dfe1b481..6e1c7c39ff9d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
@@ -238,7 +238,7 @@ iavf_print_adv_rss_cfg(struct iavf_adapter *adapter, struct iavf_adv_rss *rss,
 {
 	u32 packet_hdrs = rss->packet_hdrs;
 	u64 hash_flds = rss->hash_flds;
-	static char hash_opt[300];
+	char hash_opt[128];
 	const char *proto;
 
 	if (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_TCP)
@@ -252,44 +252,35 @@ iavf_print_adv_rss_cfg(struct iavf_adapter *adapter, struct iavf_adv_rss *rss,
 	else
 		return;
 
-	memset(hash_opt, 0, sizeof(hash_opt));
-
-	strcat(hash_opt, proto);
-	if (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4)
-		strcat(hash_opt, "v4 ");
-	else
-		strcat(hash_opt, "v6 ");
-
-	if (hash_flds & (IAVF_ADV_RSS_HASH_FLD_IPV4_SA |
-			 IAVF_ADV_RSS_HASH_FLD_IPV6_SA))
-		strcat(hash_opt, "IP SA,");
-	if (hash_flds & (IAVF_ADV_RSS_HASH_FLD_IPV4_DA |
-			 IAVF_ADV_RSS_HASH_FLD_IPV6_DA))
-		strcat(hash_opt, "IP DA,");
-	if (hash_flds & (IAVF_ADV_RSS_HASH_FLD_TCP_SRC_PORT |
-			 IAVF_ADV_RSS_HASH_FLD_UDP_SRC_PORT |
-			 IAVF_ADV_RSS_HASH_FLD_SCTP_SRC_PORT))
-		strcat(hash_opt, "src port,");
-	if (hash_flds & (IAVF_ADV_RSS_HASH_FLD_TCP_DST_PORT |
-			 IAVF_ADV_RSS_HASH_FLD_UDP_DST_PORT |
-			 IAVF_ADV_RSS_HASH_FLD_SCTP_DST_PORT))
-		strcat(hash_opt, "dst port,");
-	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPC_TEID)
-		strcat(hash_opt, "gtp-c,");
-	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_IP_TEID)
-		strcat(hash_opt, "gtp-u ip,");
-	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_EH_TEID)
-		strcat(hash_opt, "gtp-u ext,");
-	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_UP_TEID)
-		strcat(hash_opt, "gtp-u ul,");
-	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_DWN_TEID)
-		strcat(hash_opt, "gtp-u dl,");
-
-	if (!action)
-		action = "";
-
-	if (!result)
-		result = "";
-
-	dev_info(&adapter->pdev->dev, "%s %s %s\n", action, hash_opt, result);
+	snprintf(hash_opt, sizeof(hash_opt), "%s%s %s%s%s%s%s%s%s%s%s",
+		 proto,
+		 (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4) ?
+			"v4" : "v6",
+		 (hash_flds & (IAVF_ADV_RSS_HASH_FLD_IPV4_SA |
+			       IAVF_ADV_RSS_HASH_FLD_IPV6_SA)) ?
+			"IP SA," : "",
+		 (hash_flds & (IAVF_ADV_RSS_HASH_FLD_IPV4_DA |
+			       IAVF_ADV_RSS_HASH_FLD_IPV6_DA)) ?
+			"IP DA," : "",
+		 (hash_flds & (IAVF_ADV_RSS_HASH_FLD_TCP_SRC_PORT |
+			       IAVF_ADV_RSS_HASH_FLD_UDP_SRC_PORT |
+			       IAVF_ADV_RSS_HASH_FLD_SCTP_SRC_PORT)) ?
+			"src port," : "",
+		 (hash_flds & (IAVF_ADV_RSS_HASH_FLD_TCP_DST_PORT |
+			       IAVF_ADV_RSS_HASH_FLD_UDP_DST_PORT |
+			       IAVF_ADV_RSS_HASH_FLD_SCTP_DST_PORT)) ?
+			"dst port," : "",
+		 (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPC_TEID) ?
+			"gtp-c," : "",
+		 (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_IP_TEID) ?
+			"gtp-u ip," : "",
+		 (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_EH_TEID) ?
+			"gtp-u ext," : "",
+		 (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_UP_TEID) ?
+			"gtp-u ul," : "",
+		 (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_DWN_TEID) ?
+			"gtp-u dl," : "");
+
+	dev_info(&adapter->pdev->dev, "%s %s %s\n",
+		 action ? action : "", hash_opt, result ? result : "");
 }
-- 
2.53.0


