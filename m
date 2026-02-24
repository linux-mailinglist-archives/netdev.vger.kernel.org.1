Return-Path: <netdev+bounces-260421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNa2MXZsnWkkQAQAu9opvQ
	(envelope-from <netdev+bounces-260421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:16:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2746E184690
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DBD430AE363
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A560836A03F;
	Tue, 24 Feb 2026 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL/fbVok"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A471368298
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924383; cv=none; b=AiHW3PDrj2CyT3uyG8OqeGcmBOJc4XDINpoY86uCd9AweLgEJJqz/rMBEB/zzeeEu1lnRrtAbKhCtpHi8RaGC89fc0TtvCtb/wP98lSZW+Q55HSgzF1HHIge3gDTMGv1o72bb7UTOlR5afgsqtxmhV/tEta3vFz7mr7LAHEd6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924383; c=relaxed/simple;
	bh=qaDmA0lNjQxbJAs4VqDecUDWE2B3cty47vNOBPAfTtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBX8Syd9+u4lWQ/sJrt5y8ftL4kgZanXq8IvE+/Z6DuaOdYQE993LVgYxDUkAgj24GQ9u8fOVGJ2SbIj15GcJ4aeECJu9jNHXC+FeJIEqI6YGZjelvYqKw5TC/pXPx5p0osbMz9gqXA0gq7E5QLFDQeF+IQvOj+Y/XCtIwVMyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gL/fbVok; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771924381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtYpqnG0pIgs1KTnYevf/fwWfoJ3Kgs7l1BKuiXn/HU=;
	b=gL/fbVokmj0B/d4ZfHTgs2CXrPv7/+4lXC7gVMHF6IisXeQWLw63x5+ZFEwnRLVSmzfT76
	rUneBva5glzGWthZJaThAdlnj+0XEax3B16GGiUqznUMvoSthugF+x0vjHD89kW4LHQh8Q
	BSb0kYRDJ7GgEmWbsajWToX1P7REe84=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-cF84m5qMMROuLRcgrqPWfA-1; Tue,
 24 Feb 2026 04:12:57 -0500
X-MC-Unique: cF84m5qMMROuLRcgrqPWfA-1
X-Mimecast-MFC-AGG-ID: cF84m5qMMROuLRcgrqPWfA_1771924376
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B8161956059;
	Tue, 24 Feb 2026 09:12:56 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.225.132])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A2D61955F43;
	Tue, 24 Feb 2026 09:12:54 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 4/4] dpll: add pin filtering by parent-device and parent-pin
Date: Tue, 24 Feb 2026 10:12:43 +0100
Message-ID: <20260224091243.58501-5-poros@redhat.com>
In-Reply-To: <20260224091243.58501-1-poros@redhat.com>
References: <20260224091243.58501-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260421-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2746E184690
X-Rspamd-Action: no action

The existing "device" argument in "dpll pin show" sent DPLL_A_ID
in the pin dump request, but the kernel does not use this attribute
for pin dump filtering. Replace it with client-side parent-device
filtering that checks DPLL_A_PIN_PARENT_ID inside nested
DPLL_A_PIN_PARENT_DEVICE attributes.

Also add parent-pin filtering for mux pin hierarchies using the
same approach with DPLL_A_PIN_PARENT_PIN nested attributes.

Rename the "device" argument to "parent-device" to better reflect
the actual semantics.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 bash-completion/dpll | 12 ++++--
 dpll/dpll.c          | 88 ++++++++++++++++++++++++++++++++++----------
 man/man8/dpll.8      | 10 +++--
 3 files changed, 85 insertions(+), 25 deletions(-)

diff --git a/bash-completion/dpll b/bash-completion/dpll
index f81a2d2caa1012..b3ba0d306183ac 100644
--- a/bash-completion/dpll
+++ b/bash-completion/dpll
@@ -153,11 +153,16 @@ _dpll_pin()
                         "$(_dpll_direct_complete pin_id)" -- "$cur" ) )
                     return 0
                     ;;
-                device)
+                parent-device)
                     COMPREPLY=( $( compgen -W \
                         "$(_dpll_direct_complete device_id)" -- "$cur" ) )
                     return 0
                     ;;
+                parent-pin)
+                    COMPREPLY=( $( compgen -W \
+                        "$(_dpll_direct_complete pin_id)" -- "$cur" ) )
+                    return 0
+                    ;;
                 module-name)
                     COMPREPLY=( $( compgen -W \
                         "$(_dpll_direct_complete module_name)" -- "$cur" ) )
@@ -177,8 +182,9 @@ _dpll_pin()
                     return 0
                     ;;
                 *)
-                    COMPREPLY=( $( compgen -W "id device module-name clock-id \
-                        board-label panel-label package-label type" \
+                    COMPREPLY=( $( compgen -W "id parent-device parent-pin \
+                        module-name clock-id board-label panel-label \
+                        package-label type" \
                         -- "$cur" ) )
                     return 0
                     ;;
diff --git a/dpll/dpll.c b/dpll/dpll.c
index e39e56fc5632aa..facf150f63d565 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -788,6 +788,24 @@ static int dpll_filter_parse_str(struct dpll *dpll, const char *name,
 	return 0;
 }
 
+static int dpll_filter_parse_u32(struct dpll *dpll, const char *name,
+				 __u32 *dst, uint64_t *present,
+				 uint64_t flag)
+{
+	const char *str = dpll_argv_next(dpll);
+
+	if (!str) {
+		pr_err("%s requires an argument\n", name);
+		return -EINVAL;
+	}
+	if (get_u32(dst, str, 0)) {
+		pr_err("invalid %s: %s\n", name, str);
+		return -EINVAL;
+	}
+	*present |= flag;
+	return 0;
+}
+
 static int dpll_filter_parse_u64(struct dpll *dpll, const char *name,
 				 __u64 *dst, uint64_t *present,
 				 uint64_t flag)
@@ -871,6 +889,8 @@ static bool dpll_device_dump_filter(struct dpll_device_filter *filter,
 #define DPLL_FILTER_PIN_PANEL_LABEL	BIT(3)
 #define DPLL_FILTER_PIN_PACKAGE_LABEL	BIT(4)
 #define DPLL_FILTER_PIN_TYPE		BIT(5)
+#define DPLL_FILTER_PIN_PARENT_DEVICE	BIT(6)
+#define DPLL_FILTER_PIN_PARENT_PIN	BIT(7)
 
 struct dpll_pin_filter {
 	uint64_t present;
@@ -880,9 +900,31 @@ struct dpll_pin_filter {
 	const char *panel_label;
 	const char *package_label;
 	__u32 type;
+	__u32 parent_device_id;
+	__u32 parent_pin_id;
 };
 
+static bool filter_match_nested_id(const struct nlmsghdr *nlh,
+				   uint16_t nest_type, __u32 expected_id)
+{
+	const struct nlattr *attr;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		struct nlattr *tb_nest[DPLL_A_PIN_MAX + 1] = {};
+
+		if (mnl_attr_get_type(attr) != nest_type)
+			continue;
+
+		mnl_attr_parse_nested(attr, attr_pin_cb, tb_nest);
+		if (filter_match_u32(tb_nest[DPLL_A_PIN_PARENT_ID],
+				     expected_id))
+			return true;
+	}
+	return false;
+}
+
 static bool dpll_pin_dump_filter(struct dpll_pin_filter *filter,
+				 const struct nlmsghdr *nlh,
 				 struct nlattr **tb)
 {
 	if (!filter || !filter->present)
@@ -907,6 +949,14 @@ static bool dpll_pin_dump_filter(struct dpll_pin_filter *filter,
 	if ((filter->present & DPLL_FILTER_PIN_TYPE) &&
 	    !filter_match_u32(tb[DPLL_A_PIN_TYPE], filter->type))
 		return false;
+	if ((filter->present & DPLL_FILTER_PIN_PARENT_DEVICE) &&
+	    !filter_match_nested_id(nlh, DPLL_A_PIN_PARENT_DEVICE,
+				    filter->parent_device_id))
+		return false;
+	if ((filter->present & DPLL_FILTER_PIN_PARENT_PIN) &&
+	    !filter_match_nested_id(nlh, DPLL_A_PIN_PARENT_PIN,
+				    filter->parent_pin_id))
+		return false;
 	return true;
 }
 
@@ -1230,7 +1280,8 @@ static int cmd_device(struct dpll *dpll)
 
 static void cmd_pin_help(void)
 {
-	pr_err("Usage: dpll pin show [ id PIN_ID ] [ device DEVICE_ID ]\n");
+	pr_err("Usage: dpll pin show [ id PIN_ID ]\n");
+	pr_err("                     [ parent-device DEVICE_ID ] [ parent-pin PIN_ID ]\n");
 	pr_err("                     [ module-name NAME ] [ clock-id ID ]\n");
 	pr_err("                     [ board-label LABEL ] [ panel-label LABEL ]\n");
 	pr_err("                     [ package-label LABEL ] [ type TYPE ]\n");
@@ -1607,7 +1658,7 @@ static int cmd_pin_show_cb(const struct nlmsghdr *nlh, void *data)
 	/* First parse to get main attributes */
 	mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_pin_cb, tb);
 
-	if (!dpll_pin_dump_filter(filter, tb))
+	if (!dpll_pin_dump_filter(filter, nlh, tb))
 		return MNL_CB_OK;
 
 	/* Pass 1: Count multi-attr occurrences and allocate */
@@ -1691,12 +1742,9 @@ static int cmd_pin_show_dump_cb(const struct nlmsghdr *nlh, void *data)
 	struct nlattr *tb[DPLL_A_PIN_MAX + 1] = {};
 	int ret;
 
-	/* Lightweight pre-parse for filter check before expensive
-	 * multi-attr processing in cmd_pin_show_cb.
-	 */
 	mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_pin_cb, tb);
 
-	if (!dpll_pin_dump_filter(filter, tb))
+	if (!dpll_pin_dump_filter(filter, nlh, tb))
 		return MNL_CB_OK;
 
 	open_json_object(NULL);
@@ -1726,8 +1774,7 @@ static int cmd_pin_show_id(struct dpll *dpll, __u32 id,
 	return 0;
 }
 
-static int cmd_pin_show_dump(struct dpll *dpll, bool has_device_id,
-			     __u32 device_id,
+static int cmd_pin_show_dump(struct dpll *dpll,
 			     struct dpll_pin_filter *filter)
 {
 	struct nlmsghdr *nlh;
@@ -1737,11 +1784,6 @@ static int cmd_pin_show_dump(struct dpll *dpll, bool has_device_id,
 					  NLM_F_REQUEST | NLM_F_ACK |
 						  NLM_F_DUMP);
 
-	/* If device_id specified, filter pins by device */
-	if (has_device_id)
-		mnl_attr_put_u32(nlh, DPLL_A_ID, device_id);
-
-	/* Open JSON array for multiple pins */
 	open_json_array(PRINT_JSON, "pin");
 
 	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_pin_show_dump_cb,
@@ -1760,19 +1802,27 @@ static int cmd_pin_show_dump(struct dpll *dpll, bool has_device_id,
 
 static int cmd_pin_show(struct dpll *dpll)
 {
-	bool has_pin_id = false, has_device_id = false;
 	struct dpll_pin_filter filter = {};
-	__u32 pin_id = 0, device_id = 0;
+	bool has_pin_id = false;
+	__u32 pin_id = 0;
 
 	while (dpll_argc(dpll) > 0) {
 		if (dpll_argv_match(dpll, "id")) {
 			if (dpll_parse_u32(dpll, "id", &pin_id))
 				return -EINVAL;
 			has_pin_id = true;
-		} else if (dpll_argv_match(dpll, "device")) {
-			if (dpll_parse_u32(dpll, "device", &device_id))
+		} else if (dpll_argv_match(dpll, "parent-device")) {
+			if (dpll_filter_parse_u32(dpll, "parent-device",
+						  &filter.parent_device_id,
+						  &filter.present,
+						  DPLL_FILTER_PIN_PARENT_DEVICE))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "parent-pin")) {
+			if (dpll_filter_parse_u32(dpll, "parent-pin",
+						  &filter.parent_pin_id,
+						  &filter.present,
+						  DPLL_FILTER_PIN_PARENT_PIN))
 				return -EINVAL;
-			has_device_id = true;
 		} else if (dpll_argv_match(dpll, "module-name")) {
 			if (dpll_filter_parse_str(dpll, "module-name",
 						  &filter.module_name,
@@ -1820,7 +1870,7 @@ static int cmd_pin_show(struct dpll *dpll)
 	if (has_pin_id)
 		return cmd_pin_show_id(dpll, pin_id, &filter);
 
-	return cmd_pin_show_dump(dpll, has_device_id, device_id, &filter);
+	return cmd_pin_show_dump(dpll, &filter);
 }
 
 static int cmd_pin_parse_parent_device(struct dpll *dpll, struct nlmsghdr *nlh)
diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
index a4280153b4d67b..86bc1a7e56d9f8 100644
--- a/man/man8/dpll.8
+++ b/man/man8/dpll.8
@@ -161,7 +161,7 @@ Device type:
 
 .SH PIN COMMANDS
 
-.SS dpll pin show [ id ID ] [ device ID ] [ module-name NAME ] [ clock-id ID ] [ board-label LABEL ] [ panel-label LABEL ] [ package-label LABEL ] [ type TYPE ]
+.SS dpll pin show [ id ID ] [ parent-device DEVICE_ID ] [ parent-pin PIN_ID ] [ module-name NAME ] [ clock-id ID ] [ board-label LABEL ] [ panel-label LABEL ] [ package-label LABEL ] [ type TYPE ]
 
 Display information about DPLL pins. If no arguments are specified,
 shows all pins in the system.
@@ -171,8 +171,12 @@ shows all pins in the system.
 Show only the pin with the specified numeric identifier.
 
 .TP
-.BI device " ID"
-Show only pins associated with the specified device ID.
+.BI parent-device " DEVICE_ID"
+Show only pins that have the specified DPLL device as a parent.
+
+.TP
+.BI parent-pin " PIN_ID"
+Show only pins that have the specified pin as a parent (mux pins).
 
 .TP
 .BI module-name " NAME"
-- 
2.52.0


