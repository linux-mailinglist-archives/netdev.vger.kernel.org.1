Return-Path: <netdev+bounces-287634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAUtHl+QBGoVLgIAu9opvQ
	(envelope-from <netdev+bounces-287634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:53:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABCA535824
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE881301E753
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD1938D3F9;
	Wed, 13 May 2026 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpfGT+5q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9183A38C42D
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683887; cv=none; b=W31scj0q1IrI4dpUbs6pfNRqb5RqWZhyHIJnLpUHxySk8oopez7iAEGaxt+bzLlhZ81aAjehNwD+9gOppb3Zo4Ufmn0O+w4yKhiqunTEtGCLjyYGbtcY5I7K68T4P9vnpfrgVi7sE9NFwPbtPyGVhfmxxRfJS9mOd0WQKe3mMJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683887; c=relaxed/simple;
	bh=PSFIJsBdTeCDOOgMijlIGrhqwHtrjiyEo7gRAWxImsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsE0VgQj0vGEpawX18eOSZPQfQW9BWb+k8j16yrZMEax0U1aiFbrhxp9JwEeUCNi48dNbb3SW5cHwqlsYQ1gRzN1HK6D71wDvGaOLLNJfUH58tJn1ZGfLiBSgbAP8UuGrBN0ny7L4AIVmX7r7am9MU/EX+fjzfSbemgb36BL1D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpfGT+5q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778683883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ikLQmG7M/hjYBz3IVSdTTRgCmwo04Sgl8qNHVFph9s=;
	b=FpfGT+5qQmB/01KqumX/qqSaRLDv3+Pxrhqcz3Jvdy4DUrkunIsOib352SwNCDxqH/q6vt
	pXHfuYS6VxF934W6LgQ82M63Fkv1Uin8NT6dl9Mp/3TYBofuLr9uQdvPgTMyrR34bH0WvW
	2O8XLyUWAEHAG3eGcLAv06xnrgCi4oQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-ywDeVgy8OUCueLkH1F5HVQ-1; Wed,
 13 May 2026 10:51:21 -0400
X-MC-Unique: ywDeVgy8OUCueLkH1F5HVQ-1
X-Mimecast-MFC-AGG-ID: ywDeVgy8OUCueLkH1F5HVQ_1778683881
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5B1E195609E;
	Wed, 13 May 2026 14:51:20 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F6A519560A7;
	Wed, 13 May 2026 14:51:19 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 1/2] dpll: add pin operstate attribute support
Date: Wed, 13 May 2026 16:51:14 +0200
Message-ID: <20260513145115.174597-2-ivecera@redhat.com>
In-Reply-To: <20260513145115.174597-1-ivecera@redhat.com>
References: <20260513145115.174597-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 3ABCA535824
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287634-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Kernel commit 781c8893a5da8 ("dpll: add pin operational state")
added the DPLL_A_PIN_OPERSTATE attribute which reports the operational
state of a pin with respect to its parent DPLL device. The attribute
is nested inside parent-device and can have values: active, standby,
no-signal, qual-failed.

Add operstate filtering for pin show command, allowing to filter pins
by their operational state on parent device. Update bash-completion
and man page accordingly.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 bash-completion/dpll |  7 ++++++-
 dpll/dpll.c          | 50 +++++++++++++++++++++++++++++++++++++++++++-
 man/man8/dpll.8      | 16 ++++++++++++--
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/bash-completion/dpll b/bash-completion/dpll
index 7ddcf529d429..9ff38a46c279 100644
--- a/bash-completion/dpll
+++ b/bash-completion/dpll
@@ -190,10 +190,15 @@ _dpll_pin()
                         "connected disconnected selectable" -- "$cur" ) )
                     return 0
                     ;;
+                operstate)
+                    COMPREPLY=( $( compgen -W \
+                        "active standby no-signal qual-failed" -- "$cur" ) )
+                    return 0
+                    ;;
                 *)
                     COMPREPLY=( $( compgen -W "id parent-device parent-pin \
                         module-name clock-id board-label panel-label \
-                        package-label type direction state" \
+                        package-label type direction state operstate" \
                         -- "$cur" ) )
                     return 0
                     ;;
diff --git a/dpll/dpll.c b/dpll/dpll.c
index febf2a5d1fbd..bd9ab3c6033f 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -59,6 +59,16 @@ static struct str_num_map pin_state_map[] = {
 	},
 };
 
+static struct str_num_map pin_operstate_map[] = {
+	{ .str = "active", .num = DPLL_PIN_OPERSTATE_ACTIVE },
+	{ .str = "standby", .num = DPLL_PIN_OPERSTATE_STANDBY },
+	{ .str = "no-signal", .num = DPLL_PIN_OPERSTATE_NO_SIGNAL },
+	{ .str = "qual-failed", .num = DPLL_PIN_OPERSTATE_QUAL_FAILED },
+	{
+		.str = NULL,
+	},
+};
+
 static struct str_num_map pin_type_map[] = {
 	{ .str = "mux", .num = DPLL_PIN_TYPE_MUX },
 	{ .str = "ext", .num = DPLL_PIN_TYPE_EXT },
@@ -162,6 +172,17 @@ static int str_to_dpll_pin_state(const char *state_str, __u32 *state)
 	return 0;
 }
 
+static int str_to_dpll_pin_operstate(const char *str, __u32 *operstate)
+{
+	int num;
+
+	num = str_map_lookup_str(pin_operstate_map, str);
+	if (num < 0)
+		return num;
+	*operstate = num;
+	return 0;
+}
+
 static int str_to_dpll_pin_direction(const char *dir_str, __u32 *direction)
 {
 	int num;
@@ -968,6 +989,7 @@ static bool dpll_device_dump_filter(struct dpll_device_filter *filter,
 #define DPLL_FILTER_PIN_PARENT_PIN	BIT(7)
 #define DPLL_FILTER_PIN_DIRECTION	BIT(8)
 #define DPLL_FILTER_PIN_STATE		BIT(9)
+#define DPLL_FILTER_PIN_OPERSTATE	BIT(10)
 
 struct dpll_pin_filter {
 	uint64_t present;
@@ -981,6 +1003,7 @@ struct dpll_pin_filter {
 	__u32 parent_pin_id;
 	__u32 direction;
 	__u32 state;
+	__u32 operstate;
 };
 
 static bool filter_match_nested_id(const struct nlmsghdr *nlh,
@@ -1030,6 +1053,11 @@ static bool filter_match_nested_parent_device(const struct nlmsghdr *nlh,
 				      filter->state))
 			continue;
 
+		if ((filter->present & DPLL_FILTER_PIN_OPERSTATE) &&
+		    !filter_match_u32(tb_nest[DPLL_A_PIN_OPERSTATE],
+				      filter->operstate))
+			continue;
+
 		return true;
 	}
 	return false;
@@ -1063,7 +1091,8 @@ static bool dpll_pin_dump_filter(struct dpll_pin_filter *filter,
 		return false;
 	if ((filter->present & (DPLL_FILTER_PIN_PARENT_DEVICE |
 				DPLL_FILTER_PIN_DIRECTION |
-				DPLL_FILTER_PIN_STATE)) &&
+				DPLL_FILTER_PIN_STATE |
+				DPLL_FILTER_PIN_OPERSTATE)) &&
 	    !filter_match_nested_parent_device(nlh, filter))
 		return false;
 	if ((filter->present & DPLL_FILTER_PIN_PARENT_PIN) &&
@@ -1426,6 +1455,14 @@ static const char *dpll_pin_state_name(__u32 state)
 	return str ? str : "unknown";
 }
 
+static const char *dpll_pin_operstate_name(__u32 operstate)
+{
+	const char *str;
+
+	str = str_map_lookup_uint(pin_operstate_map, operstate);
+	return str ? str : "unknown";
+}
+
 static const char *dpll_pin_direction_name(__u32 direction)
 {
 	const char *str;
@@ -1561,6 +1598,9 @@ static void dpll_pin_print_parent_devices(struct nlattr *attr)
 				 " prio %u");
 		DPLL_PR_ENUM_STR_FMT(tb_parent, DPLL_A_PIN_STATE, "state",
 				     " state %s", dpll_pin_state_name);
+		DPLL_PR_ENUM_STR_FMT(tb_parent, DPLL_A_PIN_OPERSTATE,
+				     "operstate", " operstate %s",
+				     dpll_pin_operstate_name);
 		dpll_pr_phase_offset(tb_parent[DPLL_A_PIN_PHASE_OFFSET]);
 
 		print_nl();
@@ -1992,6 +2032,14 @@ static int cmd_pin_show(struct dpll *dpll)
 						   str_to_dpll_pin_state,
 						   "connected/disconnected/selectable"))
 				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "operstate")) {
+			if (dpll_filter_parse_enum(dpll, "operstate",
+						   &filter.operstate,
+						   &filter.present,
+						   DPLL_FILTER_PIN_OPERSTATE,
+						   str_to_dpll_pin_operstate,
+						   "active/standby/no-signal/qual-failed"))
+				return -EINVAL;
 		} else {
 			pr_err("unknown option: %s\n", dpll_argv(dpll));
 			return -EINVAL;
diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
index c0d4b9caef2a..f4cbcfc005c1 100644
--- a/man/man8/dpll.8
+++ b/man/man8/dpll.8
@@ -171,7 +171,10 @@ Device type:
 
 .SH PIN COMMANDS
 
-.SS dpll pin show [ id ID ] [ parent-device DEVICE_ID ] [ parent-pin PIN_ID ] [ module-name NAME ] [ clock-id ID ] [ board-label LABEL ] [ panel-label LABEL ] [ package-label LABEL ] [ type TYPE ] [ direction DIR ] [ state STATE ]
+.SS dpll pin show [ id ID ] [ parent-device DEVICE_ID ] \
+[ parent-pin PIN_ID ] [ module-name NAME ] [ clock-id ID ] \
+[ board-label LABEL ] [ panel-label LABEL ] [ package-label LABEL ] \
+[ type TYPE ] [ direction DIR ] [ state STATE ] [ operstate OPERSTATE ]
 
 Display information about DPLL pins. If no arguments are specified,
 shows all pins in the system.
@@ -229,6 +232,15 @@ When combined with
 .BR parent-device ,
 only the specified parent-device relationship is checked.
 
+.TP
+.BI operstate " OPERSTATE"
+Show only pins that have a parent-device relationship with the specified
+operational state:
+.BR active ", " standby ", " no-signal ", " qual-failed .
+When combined with
+.BR parent-device ,
+only the specified parent-device relationship is checked.
+
 .PP
 Output includes:
 .RS
@@ -251,7 +263,7 @@ Capabilities (state-can-change, priority-can-change, direction-can-change)
 .IP \[bu]
 Phase adjustment range, granularity, and current value
 .IP \[bu]
-Parent device relationships (direction, priority, state, phase offset)
+Parent device relationships (direction, priority, state, operstate, phase offset)
 .IP \[bu]
 Parent pin relationships
 .IP \[bu]
-- 
2.53.0


