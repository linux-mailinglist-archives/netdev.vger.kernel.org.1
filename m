Return-Path: <netdev+bounces-254771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KkqM1VFe2l+DAIAu9opvQ
	(envelope-from <netdev+bounces-254771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:32:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F773AFA75
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 235913011763
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C774385514;
	Thu, 29 Jan 2026 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtCFWk4n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67933F8A8
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769686140; cv=none; b=s8Vbp/qDsb1nByQXow+FlWI4oOQePlaoCfFhMK+S9ZPO45x1NOQZCVcMt/d+TJbLE7nQ1/mPrAF8k1Y2+b9PasJ12eRIykzRUUPWmtIKiVFQ6BieweiyoRlKQcWkrL6dc07TeSZAr9Z9KwpYlnyR7mj31mDxzJDWzQQs0xGk7rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769686140; c=relaxed/simple;
	bh=Fdx+BMq3ACq5OZ/GJmdaTC1h+53HqwSXuGmPRqEjRgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6/zF9kDLjBWGwihrS1mr42qjAILV8RM+WT4f5xB9yyVZmbN7AGRIAVIdTGkFL/TR2PRjHEs1M5WsGxTXlgLG0BXlZXdd+SWo1iWOq1A85CM8GK4ndaoqz/JGEDnU+j65oYNbyhDjJErKxdRWRzY31X+4U2pwyYAvmNntrMnYKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtCFWk4n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769686138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xyOewARlXAdDx9eGdjOXC/PiuzLgu4lKqtxRoMbSrDU=;
	b=LtCFWk4nLVQmFIMXeeQSUa/UcGpUUVN/6gMA941KknWSHOnR0YQo/87J4xJBU7aVgs3JJM
	28zna0PPFlLrJTIbfxTRKfu3lXji+gHErg3Moch/lQFo6/FkrhMHqQWTQ3d6Bx5AB++Hig
	ewXWxW0+3dCaOV16oKNuWo05NuV3uIU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-Kc8t1z37MJCNuwWevr6dhQ-1; Thu,
 29 Jan 2026 06:28:56 -0500
X-MC-Unique: Kc8t1z37MJCNuwWevr6dhQ-1
X-Mimecast-MFC-AGG-ID: Kc8t1z37MJCNuwWevr6dhQ_1769686135
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 595D5180044D;
	Thu, 29 Jan 2026 11:28:55 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.225.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7539F1800109;
	Thu, 29 Jan 2026 11:28:53 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	jiri@resnulli.us,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2 net-next] dpll: add mode setting support
Date: Thu, 29 Jan 2026 12:28:49 +0100
Message-ID: <20260129112849.8796-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254771-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F773AFA75
X-Rspamd-Action: no action

Add ability to set DPLL device operating mode (automatic/manual)
through "dpll device set id ID mode MODE" command.

In automatic mode, the DPLL autonomously selects the best input
source based on priority and quality. In manual mode, the input
source must be explicitly configured.

The implementation adds dpll_mode_map for string-to-enum conversion,
str_to_dpll_mode() and dpll_parse_mode() functions, and refactors
dpll_mode_name() to use str_map_lookup_uint() for consistency.

Man page and bash completion updated accordingly.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 bash-completion/dpll |  6 ++++-
 dpll/dpll.c          | 52 +++++++++++++++++++++++++++++++++++---------
 man/man8/dpll.8      | 18 ++++++++++++++-
 3 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/bash-completion/dpll b/bash-completion/dpll
index 6e4d39a5b5b6bb..caf86a36f2adf3 100644
--- a/bash-completion/dpll
+++ b/bash-completion/dpll
@@ -73,6 +73,10 @@ _dpll_device()
                         "$(_dpll_direct_complete device_id)" -- "$cur" ) )
                     return 0
                     ;;
+                mode)
+                    COMPREPLY=( $( compgen -W "automatic manual" -- "$cur" ) )
+                    return 0
+                    ;;
                 phase-offset-monitor)
                     COMPREPLY=( $( compgen -W "enable disable true false 0 1" -- "$cur" ) )
                     return 0
@@ -82,7 +86,7 @@ _dpll_device()
                     return 0
                     ;;
                 *)
-                    COMPREPLY=( $( compgen -W "id phase-offset-monitor \
+                    COMPREPLY=( $( compgen -W "id mode phase-offset-monitor \
                         phase-offset-avg-factor" -- "$cur" ) )
                     return 0
                     ;;
diff --git a/dpll/dpll.c b/dpll/dpll.c
index 846ad4b04c63d2..9dc3f8db373d28 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -42,6 +42,14 @@ static const char *str_enable_disable(bool v)
 	return v ? "enable" : "disable";
 }
 
+static struct str_num_map dpll_mode_map[] = {
+	{ .str = "automatic", .num = DPLL_MODE_AUTOMATIC },
+	{ .str = "manual", .num = DPLL_MODE_MANUAL },
+	{
+		.str = NULL,
+	},
+};
+
 static struct str_num_map pin_state_map[] = {
 	{ .str = "connected", .num = DPLL_PIN_STATE_CONNECTED },
 	{ .str = "disconnected", .num = DPLL_PIN_STATE_DISCONNECTED },
@@ -132,6 +140,17 @@ static bool dpll_no_arg(struct dpll *dpll)
 	return dpll_argc(dpll) == 0;
 }
 
+static int str_to_dpll_mode(const char *mode_str, __u32 *mode)
+{
+	int num;
+
+	num = str_map_lookup_str(dpll_mode_map, mode_str);
+	if (num < 0)
+		return num;
+	*mode = num;
+	return 0;
+}
+
 static int str_to_dpll_pin_state(const char *state_str, __u32 *state)
 {
 	int num;
@@ -154,6 +173,18 @@ static int str_to_dpll_pin_type(const char *type_str, __u32 *type)
 	return 0;
 }
 
+static int dpll_parse_mode(struct dpll *dpll, __u32 *mode)
+{
+	const char *str = dpll_argv(dpll);
+
+	if (str_to_dpll_mode(str, mode)) {
+		pr_err("invalid state: %s (use automatic/manual)\n", str);
+		return -EINVAL;
+	}
+	dpll_arg_inc(dpll);
+	return 0;
+}
+
 static int dpll_parse_state(struct dpll *dpll, __u32 *state)
 {
 	const char *str = dpll_argv(dpll);
@@ -585,21 +616,18 @@ dpll_free:
 static void cmd_device_help(void)
 {
 	pr_err("Usage: dpll device show [ id DEVICE_ID ]\n");
-	pr_err("       dpll device set id DEVICE_ID [ phase-offset-monitor { enable | disable } ]\n");
-	pr_err("                                      [ phase-offset-avg-factor NUM ]\n");
+	pr_err("       dpll device set id DEVICE_ID [ mode { automatic | manual } ]\n");
+	pr_err("                                    [ phase-offset-monitor { enable | disable } ]\n");
+	pr_err("                                    [ phase-offset-avg-factor NUM ]\n");
 	pr_err("       dpll device id-get [ module-name NAME ] [ clock-id ID ] [ type TYPE ]\n");
 }
 
 static const char *dpll_mode_name(__u32 mode)
 {
-	switch (mode) {
-	case DPLL_MODE_MANUAL:
-		return "manual";
-	case DPLL_MODE_AUTOMATIC:
-		return "automatic";
-	default:
-		return "unknown";
-	}
+	const char *str;
+
+	str = str_map_lookup_uint(dpll_mode_map, mode);
+	return str ? str : "unknown";
 }
 
 static const char *dpll_lock_status_name(__u32 status)
@@ -839,6 +867,10 @@ static int cmd_device_set(struct dpll *dpll)
 				return -EINVAL;
 			mnl_attr_put_u32(nlh, DPLL_A_ID, id);
 			has_id = true;
+		} else if (dpll_argv_match_inc(dpll, "mode")) {
+			if (dpll_parse_attr_enum(dpll, nlh, "mode", DPLL_A_MODE,
+						 dpll_parse_mode))
+				return -EINVAL;
 		} else if (dpll_argv_match(dpll, "phase-offset-monitor")) {
 			const char *str = dpll_argv_next(dpll);
 			bool val;
diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
index fcc1c4a67af5d9..e82f083feac64b 100644
--- a/man/man8/dpll.8
+++ b/man/man8/dpll.8
@@ -88,7 +88,7 @@ Temperature (if supported)
 Type (PPS or EEC)
 .RE
 
-.SS dpll device set id ID [ phase-offset-monitor { enable | disable } ] [ phase-offset-avg-factor FACTOR ]
+.SS dpll device set id ID [ mode { automatic | manual } ] [ phase-offset-monitor { enable | disable } ] [ phase-offset-avg-factor FACTOR ]
 
 Configure DPLL device parameters.
 
@@ -96,6 +96,17 @@ Configure DPLL device parameters.
 .BI id " ID"
 Specifies which device to configure (required).
 
+.TP
+.BI mode " { automatic | manual }"
+Set the operating mode of the DPLL device.
+In
+.B automatic
+mode, the DPLL autonomously selects the best available input source
+based on priority and quality. In
+.B manual
+mode, the input source must be explicitly configured and the DPLL
+will not automatically switch sources.
+
 .TP
 .BI phase-offset-monitor " { enable | disable | true | false | 0 | 1 }"
 Enable or disable phase offset monitoring between the device and its pins.
@@ -283,6 +294,11 @@ Press Ctrl+C to stop monitoring.
 .B dpll -j device show id 0
 .fi
 
+.SS Set device 0 to manual mode
+.nf
+.B dpll device set id 0 mode manual
+.fi
+
 .SS Enable phase offset monitoring on device 0
 .nf
 .B dpll device set id 0 phase-offset-monitor enable
-- 
2.52.0


