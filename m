Return-Path: <netdev+bounces-306800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XEr5H6AVUmphLwMAu9opvQ
	(envelope-from <netdev+bounces-306800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:06:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7552741274
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:06:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wp.pl header.s=20241105 header.b="nQ/KTXQY";
	dmarc=pass (policy=none) header.from=wp.pl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306800-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306800-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E77E3018D59
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9EB33CE9A;
	Sat, 11 Jul 2026 10:04:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F241310777
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:04:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783764296; cv=none; b=RJKFYQBI6ho6qR2/1c+0PcniVe76B+G60oQfAMy8848Gi9e5Ig+xu0woAkipfIyNMc3ZycM2YtW9STEmZZNnRN6lu+B4RkwzTDriXUseuwtsZN9VmjroH/XhuLn/U9opq+X3hlte9Y4vN3Mmt1lVBI4zBO7otiHWINMOiM+Nnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783764296; c=relaxed/simple;
	bh=xzMhoQDlKedvgIgklWyx89PfgZxPVKVS8oW9j+4qDPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YvytY+zgweNnD/zXdg4A3gFRSY6zFzl8+okfydH9AiTpw22qXuaMxaTVDbLT+Sj+gwUtDFvy4KEHkgimC/k8T+ZAwVGC9H4bqHZ8YiNafYgxMbZM4qpA9oUBQxAXFSvpv/qMU5SzNyD6wyWILiDK4hTwqD7qV8elfXS/KtaukxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=nQ/KTXQY; arc=none smtp.client-ip=212.77.101.12
Received: (wp-smtpd smtp.wp.pl 18410 invoked from network); 11 Jul 2026 11:58:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1783763885; bh=h3DHdPqyXNxxqC+ktttg56JdBRkuoIHPEXC/1pxK3W4=;
          h=From:To:Cc:Subject;
          b=nQ/KTXQYax/s+j9zn6DpLOPa96Sa2Al2dpH4EwFx2geKF50q9LkO5DzdeFQE2T9ce
           tWnAJkqWiwvJMvvSzzh2NkbglZPAZwM6SaVgmfQ8WFoIE/TZa5vrRLh4xZltoCtlq3
           tRWAb+EDh+mKwsQHQLEwgiq9bQRgqSlvXX1FQsiGyEIrV6DfhrmIrjGXRFb2PGolzf
           7kCiJ72xQ8OLhM6FM14oCiq6N96WmLQCusVMxZRHbxSs7kAyLmOMNcfOH3ZJ88PKXL
           C3F1my5RJSRlb8sLt3fV6DINSw/+HWWui83xW47ZiszW4jv1U74afEN6ePO2dlz/hY
           s0oY9EHeYXrFQ==
Received: from 83.24.36.106.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.24.36.106])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <danieller@nvidia.com>; 11 Jul 2026 11:58:05 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: danieller@nvidia.com,
	mkubecek@suse.cz,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jbe@pengutronix.de,
	netdev@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH ethtool-next v2 1/2] sfpid: print all implemented options
Date: Sat, 11 Jul 2026 11:54:21 +0200
Message-ID: <20260711095803.257213-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 646e2380b3e4c879b7e055d7911e31fc
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IWPk]                               
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306800-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:danieller@nvidia.com,m:mkubecek@suse.cz,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jbe@pengutronix.de,m:netdev@vger.kernel.org,m:olek2@wp.pl,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[wp.pl];
	DKIM_TRACE(0.00)[wp.pl:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[wp.pl];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:from_mime,wp.pl:email,wp.pl:mid,wp.pl:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7552741274

SFP modules implement multiple options. Before the “json” option was
introduced, all options were listed. Currently, only the last option
is listed. This commit fixes this bug. Options are represented as array.

Before:
$ ethtool -m sfp-wan
...
	Option values                             : 0x00 0x32
	Option                                    : RATE_SELECT implemented
...
$ ethtool --json -m sfp-wan
[ {
...
        "option_values": [ 0,50 ],
        "option": "RATE_SELECT implemented",
...
    } ]

After:
$ ethtool -m sfp-wan
...
	Option values                             : 0x00 0x32
	Option                                    : RX_LOS implemented
	Option                                    : TX_DISABLE implemented
	Option                                    : RATE_SELECT implemented
...
$ ethtool --json -m sfp-wan
[ {
...
        "option_values": [ 0,50 ],
        "option": [ "RX_LOS implemented","TX_DISABLE implemented","RATE_SELECT implemented" ],
...
    } ]

Fixes: 4071862f58d8 ("sfpid: Add JSON output handling to --module-info in SFF8079 modules")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
Changes in v2:
 - fix typo introduced -> introduced
 - renamr module_print_array_string() -> module_print_any_array_string_entry()
---
 module-common.c |  8 ++++++++
 module-common.h |  1 +
 sfpid.c         | 48 ++++++++++++++++++++++++++++++++----------------
 3 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/module-common.c b/module-common.c
index 42fccf6..43ff649 100644
--- a/module-common.c
+++ b/module-common.c
@@ -258,6 +258,14 @@ void module_print_any_bool(const char *fn, char *given_json_fn, bool value,
 		printf("\t%-41s : %s\n", fn, str_value);
 }
 
+void module_print_any_array_string_entry(const char *fn, const char *value)
+{
+	if (is_json_context())
+		print_string(PRINT_JSON, NULL, "%s", value);
+	else
+		printf("\t%-41s : %s\n", fn, value);
+}
+
 void module_show_value_with_unit(const __u8 *id, unsigned int reg,
 				 const char *name, unsigned int mult,
 				 const char *unit)
diff --git a/module-common.h b/module-common.h
index 4063448..f3baf2a 100644
--- a/module-common.h
+++ b/module-common.h
@@ -281,6 +281,7 @@ void module_print_any_string(const char *fn, const char *value);
 void module_print_any_float(const char *fn, float value, const char *unit);
 void module_print_any_bool(const char *fn, char *given_json_fn, bool value,
 			   const char *str_value);
+void module_print_any_array_string_entry(const char *fn, const char *value);
 void module_show_value_with_unit(const __u8 *id, unsigned int reg,
 				 const char *name, unsigned int mult,
 				 const char *unit);
diff --git a/sfpid.c b/sfpid.c
index 74a6f51..ec5dd95 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -396,7 +396,6 @@ static void sff8079_show_wavelength_or_copper_compliance(const __u8 *id)
 static void sff8079_show_options(const __u8 *id)
 {
 	static const char *pfx = "Option";
-	char value[64] = "";
 
 	if (is_json_context()) {
 		open_json_array("option_values", "");
@@ -407,35 +406,52 @@ static void sff8079_show_options(const __u8 *id)
 		printf("\t%-41s : 0x%02x 0x%02x\n", "Option values", id[64],
 		       id[65]);
 	}
+
+	if (is_json_context())
+		open_json_array("option", "");
+
 	if (id[65] & (1 << 1))
-		sprintf(value, "%s", "RX_LOS implemented");
+		module_print_any_array_string_entry(pfx,
+			"RX_LOS implemented");
 	if (id[65] & (1 << 2))
-		sprintf(value, "%s", "RX_LOS implemented, inverted");
+		module_print_any_array_string_entry(pfx,
+			"RX_LOS implemented, inverted");
 	if (id[65] & (1 << 3))
-		sprintf(value, "%s", "TX_FAULT implemented");
+		module_print_any_array_string_entry(pfx,
+			"TX_FAULT implemented");
 	if (id[65] & (1 << 4))
-		sprintf(value, "%s", "TX_DISABLE implemented");
+		module_print_any_array_string_entry(pfx,
+			"TX_DISABLE implemented");
 	if (id[65] & (1 << 5))
-		sprintf(value, "%s", "RATE_SELECT implemented");
+		module_print_any_array_string_entry(pfx,
+			"RATE_SELECT implemented");
 	if (id[65] & (1 << 6))
-		sprintf(value, "%s", "Tunable transmitter technology");
+		module_print_any_array_string_entry(pfx,
+			"Tunable transmitter technology");
 	if (id[65] & (1 << 7))
-		sprintf(value, "%s", "Receiver decision threshold implemented");
+		module_print_any_array_string_entry(pfx,
+			"Receiver decision threshold implemented");
 	if (id[64] & (1 << 0))
-		sprintf(value, "%s", "Linear receiver output implemented");
+		module_print_any_array_string_entry(pfx,
+			"Linear receiver output implemented");
 	if (id[64] & (1 << 1))
-		sprintf(value, "%s", "Power level 2 requirement");
+		module_print_any_array_string_entry(pfx,
+			"Power level 2 requirement");
 	if (id[64] & (1 << 2))
-		sprintf(value, "%s", "Cooled transceiver implemented");
+		module_print_any_array_string_entry(pfx,
+			"Cooled transceiver implemented");
 	if (id[64] & (1 << 3))
-		sprintf(value, "%s", "Retimer or CDR implemented");
+		module_print_any_array_string_entry(pfx,
+			"Retimer or CDR implemented");
 	if (id[64] & (1 << 4))
-		sprintf(value, "%s", "Paging implemented");
+		module_print_any_array_string_entry(pfx,
+			"Paging implemented");
 	if (id[64] & (1 << 5))
-		sprintf(value, "%s", "Power level 3 requirement");
+		module_print_any_array_string_entry(pfx,
+			"Power level 3 requirement");
 
-	if (value[0] != '\0')
-		module_print_any_string(pfx, value);
+	if (is_json_context())
+		close_json_array("");
 }
 
 static void sff8079_show_all_common(const __u8 *id)
-- 
2.53.0


