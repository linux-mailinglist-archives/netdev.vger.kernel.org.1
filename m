Return-Path: <netdev+bounces-215182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C090DB2D799
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29A3724686
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4975A2DFA5C;
	Wed, 20 Aug 2025 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dfc36yd0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48BA2DE70E;
	Wed, 20 Aug 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680872; cv=none; b=S7PlStmF/RGvsgkaxhrbTx/x1yyoXT8YR2eifLpfPJCuBw/8z5cpR1mQA6ycwD70bgsmT7oXyW+KnQm4nnfsHixsX8LtkA+fWztVJC3gZnVqHfEkf+wUxjUI1nM6k6rkTZCeIIZisL6ttUe3ijvI7rh66itoPo4nNFlDPvI33uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680872; c=relaxed/simple;
	bh=K+hNOoY2S2a7wYY7Y5Zh7sJqtD4xc9YuSnOOS7Iei1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kw7rFCf2iAa7VNO8bI3GqcDZoQjtqS8ne6ol8B0EOqebqakJuLzBXmewqTMx+aeaxJbeYT9hhD7NjC4kQJu7SEMGGBOUqcMFeyUkpLMi/87qufUt1UsnjcR8RTkFzoyar3p/ZS3MrwljzRHaof01pZiP19aVAFBS4QjtFP17OCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dfc36yd0; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 554D8C6B3BC;
	Wed, 20 Aug 2025 09:07:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ED811606A0;
	Wed, 20 Aug 2025 09:07:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00E1A1C22D3DD;
	Wed, 20 Aug 2025 11:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755680867; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z8utVnpA3llRWAXXbX9PGiUe9zUs7oBfNtvROnz16Rw=;
	b=dfc36yd0kl/xQiQowOENNSILUyGCuH086qgBYevV0684aRqBSzGtkwtMt4ZEYneerqsTdw
	SAcPZU6MiTqJwOb8Kj3/PMFUojf/i5W3cOlI5I/EX03jHO4O0pFxH57DSRmSs4jyw6TOgz
	xRKYSn7b0VWWun7zbBMCN+YYjV2buV92ok/CvSh2/EthXfoNa3i0INvWoFO7OqrH41SBUC
	Vn/u1LxoClSDHEZYI1FtRy1JX1i9fA0zfwhHccac/EetJxQyc4VNEGJ4VuqvvEIz2NVCFw
	+4gluvQOlpMcIthMMqsWjQiUU9vQRrAgxZg7TxEIFfRoqh+1tgaX2B4fiLyT6w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 20 Aug 2025 11:07:33 +0200
Subject: [PATCH ethtool v3 2/3] ethtool: pse-pd: Add PSE priority support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-b4-feature_poe_pw_budget-v3-2-c3d57362c086@bootlin.com>
References: <20250820-b4-feature_poe_pw_budget-v3-0-c3d57362c086@bootlin.com>
In-Reply-To: <20250820-b4-feature_poe_pw_budget-v3-0-c3d57362c086@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Dent Project <dentproject@linuxfoundation.org>, 
 Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for PSE (Power Sourcing Equipment) priority management:
- Add priority configuration parameter (prio) for port priority management
- Display power domain index, maximum priority, and current priority

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Improve doc thanks to Oleksij.
- Add a missing semicolon.
---
 ethtool.8.in     | 31 +++++++++++++++++++++++++++++++
 ethtool.c        |  1 +
 netlink/pse-pd.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 29b8a8c..553592b 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -561,6 +561,7 @@ ethtool \- query or control network driver and hardware settings
 .RB [ c33\-pse\-admin\-control
 .BR enable | disable ]
 .BN c33\-pse\-avail\-pw\-limit N
+.BN prio N
 .HP
 .B ethtool \-\-flash\-module\-firmware
 .I devname
@@ -1911,6 +1912,26 @@ This attribute specifies the allowed power limit ranges in mW for
 configuring the c33-pse-avail-pw-limit parameter. It defines the valid
 power levels that can be assigned to the c33 PSE in compliance with the
 c33 standard.
+.TP
+.B power-domain-index
+Reports the index of the PSE power domain the port belongs to. Every
+port belongs to exactly one power domain. Port priorities are defined
+within that power domain.
+
+Each power domain may have its own maximum budget (e.g., 100 W per
+domain) in addition to a system-wide budget (e.g., 200 W overall).
+Domain limits are enforced first: if a single domain reaches its budget,
+only ports in that domain are affected. The system-wide budget is
+enforced across all domains.
+.TP
+.B priority-max
+Reports the maximum configurable port priority value within the reported
+power domain. The valid range for prio is 0 to priority-max (inclusive).
+.TP
+.B priority
+Reports the currently configured port priority within the reported power
+domain. Lower numeric values indicate higher priority: 0 is the highest
+priority.
 
 .RE
 .TP
@@ -1930,6 +1951,16 @@ This parameter manages c33 PSE Admin operations in accordance with the IEEE
 This parameter manages c33 PSE Available Power Limit in mW, in accordance
 with the IEEE 802.3-2022 33.2.4.4 Variables (pse_available_power)
 specification.
+.TP
+.B prio \ N
+Set the port priority, scoped to the port's power domain
+as reported by power-domain-index. Lower values indicate higher
+priority; 0 is the highest. The valid range is 0 to the
+priority-max reported by --show-pse.
+
+When a single domain exceeds its budget, ports in that domain are
+powered up/down by priority (highest first for power-up; lowest shed
+first).
 
 .RE
 .TP
diff --git a/ethtool.c b/ethtool.c
index 215f566..948d551 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6339,6 +6339,7 @@ static const struct option args[] = {
 		.xhelp	= "		[ podl-pse-admin-control enable|disable ]\n"
 			  "		[ c33-pse-admin-control enable|disable ]\n"
 			  "		[ c33-pse-avail-pw-limit N ]\n"
+			  "		[ prio N ]\n"
 	},
 	{
 		.opts	= "--flash-module-firmware",
diff --git a/netlink/pse-pd.c b/netlink/pse-pd.c
index fd1fc4d..f761871 100644
--- a/netlink/pse-pd.c
+++ b/netlink/pse-pd.c
@@ -420,6 +420,29 @@ int pse_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		}
 	}
 
+	if (tb[ETHTOOL_A_PSE_PW_D_ID]) {
+		u32 val;
+
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_PSE_PW_D_ID]);
+		print_uint(PRINT_ANY, "power-domain-index",
+			   "Power domain index: %u\n", val);
+	}
+
+	if (tb[ETHTOOL_A_PSE_PRIO_MAX]) {
+		u32 val;
+
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_PSE_PRIO_MAX]);
+		print_uint(PRINT_ANY, "priority-max",
+			   "Max allowed priority: %u\n", val);
+	}
+
+	if (tb[ETHTOOL_A_PSE_PRIO]) {
+		u32 val;
+
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_PSE_PRIO]);
+		print_uint(PRINT_ANY, "priority", "Priority: %u\n", val);
+	}
+
 	close_json_object();
 
 	return MNL_CB_OK;
@@ -487,6 +510,12 @@ static const struct param_parser spse_params[] = {
 		.handler	= nl_parse_direct_u32,
 		.min_argc	= 1,
 	},
+	{
+		.arg		= "prio",
+		.type		= ETHTOOL_A_PSE_PRIO,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
 	{}
 };
 

-- 
2.43.0


