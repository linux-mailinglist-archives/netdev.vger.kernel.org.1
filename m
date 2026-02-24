Return-Path: <netdev+bounces-260420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AmGA2ZsnWkkQAQAu9opvQ
	(envelope-from <netdev+bounces-260420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:16:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6065E184688
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F16E130AE25B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9DF36683E;
	Tue, 24 Feb 2026 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVLcyi5b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458C36A01B
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924382; cv=none; b=SacENDYjhckRi/RkwAEgRY4EuRh4pJMD//iVxvxRHOI40DUYt8FGRP0LspvfJXQRni89FPgGbEA+qkC7H7dYzku0NuXXDIi+Ldg7ujWG8Q+MSt01hIYZeYMIdS9e3ZiMVjZAqWefYg6jZtYGRjxN/HSz7B2tfApiVYicYeMeQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924382; c=relaxed/simple;
	bh=FRKf0eWXwq6v61gqBaArqDIz0lsy9RkQQMwH0NUuWT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esl8M3gYXLaiIi9HPcUywf4c/QdoOHPx6qhWkqIa+Kds9CCN5RQ4Pv4k7oKR6tS49PgDhY1m5VPFVLOthcH7tmEMR5tigMOl/MLJoUnzPnU8aQZLMYjwzaOGjDbQ58+nLVUFMgkXt+Pcd7VCySXeHs+2IuXA414Zj4i+xK27rUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVLcyi5b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771924379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZ8rTqqa/LM/1SI8l786xlxo3UXC2xnvXs9fgosTmEM=;
	b=UVLcyi5by524vPKkNylCirZmxIWEhl4fQH/8sYCZpPGnL76aa3N/mL8oIkbMt+dFAGnbp6
	V8lK/xm46D4x96JzGtQ9OS9uUHkEo3/l9b4nF/YzJNBzBs4sV9A/vka3gZ5Eo6IecT3exB
	vwPk7pJepaaybVN6IvOlubHWOcHyFzw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-GpUaXe2KPp-6JeOgUmg4Yw-1; Tue,
 24 Feb 2026 04:12:53 -0500
X-MC-Unique: GpUaXe2KPp-6JeOgUmg4Yw-1
X-Mimecast-MFC-AGG-ID: GpUaXe2KPp-6JeOgUmg4Yw_1771924373
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E27BE1956095;
	Tue, 24 Feb 2026 09:12:52 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.225.132])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4619B1955F43;
	Tue, 24 Feb 2026 09:12:51 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 2/4] dpll: add client-side filtering for device show
Date: Tue, 24 Feb 2026 10:12:41 +0100
Message-ID: <20260224091243.58501-3-poros@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-260420-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 6065E184688
X-Rspamd-Action: no action

Add client-side filtering support for dpll device show command.
Users can filter devices by module-name, clock-id, type, mode,
and lock-status. Multiple filters use AND semantics. Filters
work with both dump (all devices) and single GET (by id) operations.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 bash-completion/dpll |  25 +++++-
 dpll/dpll.c          | 191 +++++++++++++++++++++++++++++++++++++++++--
 man/man8/dpll.8      |  35 +++++++-
 3 files changed, 243 insertions(+), 8 deletions(-)

diff --git a/bash-completion/dpll b/bash-completion/dpll
index caf86a36f2adf3..a614b3eb6ab355 100644
--- a/bash-completion/dpll
+++ b/bash-completion/dpll
@@ -60,8 +60,31 @@ _dpll_device()
                         "$(_dpll_direct_complete device_id)" -- "$cur" ) )
                     return 0
                     ;;
+                module-name)
+                    COMPREPLY=( $( compgen -W \
+                        "$(_dpll_direct_complete module_name)" -- "$cur" ) )
+                    return 0
+                    ;;
+                clock-id)
+                    # numeric value, no completion
+                    return 0
+                    ;;
+                type)
+                    COMPREPLY=( $( compgen -W "pps eec" -- "$cur" ) )
+                    return 0
+                    ;;
+                mode)
+                    COMPREPLY=( $( compgen -W "manual automatic" -- "$cur" ) )
+                    return 0
+                    ;;
+                lock-status)
+                    COMPREPLY=( $( compgen -W \
+                        "unlocked locked locked-ho-acq holdover" -- "$cur" ) )
+                    return 0
+                    ;;
                 *)
-                    COMPREPLY=( $( compgen -W "id" -- "$cur" ) )
+                    COMPREPLY=( $( compgen -W "id module-name clock-id \
+                        type mode lock-status" -- "$cur" ) )
                     return 0
                     ;;
             esac
diff --git a/dpll/dpll.c b/dpll/dpll.c
index 0effa5a9c67e72..aea7b89c39d0b4 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -616,6 +616,9 @@ dpll_free:
 static void cmd_device_help(void)
 {
 	pr_err("Usage: dpll device show [ id DEVICE_ID ]\n");
+	pr_err("                        [ module-name NAME ] [ clock-id ID ]\n");
+	pr_err("                        [ type TYPE ] [ mode MODE ]\n");
+	pr_err("                        [ lock-status STATUS ]\n");
 	pr_err("       dpll device set id DEVICE_ID [ mode { automatic | manual } ]\n");
 	pr_err("                                    [ phase-offset-monitor { enable | disable } ]\n");
 	pr_err("                                    [ phase-offset-avg-factor NUM ]\n");
@@ -669,6 +672,21 @@ static int str_to_dpll_type(const char *s, __u32 *type)
 	return 0;
 }
 
+static int str_to_dpll_lock_status(const char *s, __u32 *status)
+{
+	if (!strcmp(s, "unlocked"))
+		*status = DPLL_LOCK_STATUS_UNLOCKED;
+	else if (!strcmp(s, "locked"))
+		*status = DPLL_LOCK_STATUS_LOCKED;
+	else if (!strcmp(s, "locked-ho-acq"))
+		*status = DPLL_LOCK_STATUS_LOCKED_HO_ACQ;
+	else if (!strcmp(s, "holdover"))
+		*status = DPLL_LOCK_STATUS_HOLDOVER;
+	else
+		return -EINVAL;
+	return 0;
+}
+
 static const char *dpll_lock_status_error_name(__u32 error)
 {
 	switch (error) {
@@ -735,6 +753,118 @@ static int attr_pin_cb(const struct nlattr *attr, void *data)
 	return MNL_CB_OK;
 }
 
+/*
+ * Dump filter helpers - client-side filtering of dump results.
+ * AND semantics: all specified filters must match.
+ */
+
+static inline bool filter_match_str(struct nlattr *attr, const char *expected)
+{
+	return attr && strcmp(mnl_attr_get_str(attr), expected) == 0;
+}
+
+static inline bool filter_match_u32(struct nlattr *attr, __u32 expected)
+{
+	return attr && mnl_attr_get_u32(attr) == expected;
+}
+
+static inline bool filter_match_u64(struct nlattr *attr, __u64 expected)
+{
+	return attr && mnl_attr_get_u64(attr) == expected;
+}
+
+static int dpll_filter_parse_str(struct dpll *dpll, const char *name,
+				 const char **dst, uint64_t *present,
+				 uint64_t flag)
+{
+	const char *str = dpll_argv_next(dpll);
+
+	if (!str) {
+		pr_err("%s requires an argument\n", name);
+		return -EINVAL;
+	}
+	*dst = str;
+	*present |= flag;
+	return 0;
+}
+
+static int dpll_filter_parse_u64(struct dpll *dpll, const char *name,
+				 __u64 *dst, uint64_t *present,
+				 uint64_t flag)
+{
+	const char *str = dpll_argv_next(dpll);
+
+	if (!str) {
+		pr_err("%s requires an argument\n", name);
+		return -EINVAL;
+	}
+	if (get_u64(dst, str, 0)) {
+		pr_err("invalid %s: %s\n", name, str);
+		return -EINVAL;
+	}
+	*present |= flag;
+	return 0;
+}
+
+static int dpll_filter_parse_enum(struct dpll *dpll, const char *name,
+				  __u32 *dst, uint64_t *present,
+				  uint64_t flag,
+				  int (*convert)(const char *, __u32 *),
+				  const char *valid_values)
+{
+	const char *str = dpll_argv_next(dpll);
+
+	if (!str) {
+		pr_err("%s requires an argument\n", name);
+		return -EINVAL;
+	}
+	if (convert(str, dst)) {
+		pr_err("invalid %s: %s (use %s)\n", name, str, valid_values);
+		return -EINVAL;
+	}
+	*present |= flag;
+	return 0;
+}
+
+#define DPLL_FILTER_DEV_MODULE_NAME	BIT(0)
+#define DPLL_FILTER_DEV_CLOCK_ID	BIT(1)
+#define DPLL_FILTER_DEV_TYPE		BIT(2)
+#define DPLL_FILTER_DEV_MODE		BIT(3)
+#define DPLL_FILTER_DEV_LOCK_STATUS	BIT(4)
+
+struct dpll_device_filter {
+	uint64_t present;
+	const char *module_name;
+	__u64 clock_id;
+	__u32 type;
+	__u32 mode;
+	__u32 lock_status;
+};
+
+static bool dpll_device_dump_filter(struct dpll_device_filter *filter,
+				    struct nlattr **tb)
+{
+	if (!filter || !filter->present)
+		return true;
+
+	if ((filter->present & DPLL_FILTER_DEV_MODULE_NAME) &&
+	    !filter_match_str(tb[DPLL_A_MODULE_NAME], filter->module_name))
+		return false;
+	if ((filter->present & DPLL_FILTER_DEV_CLOCK_ID) &&
+	    !filter_match_u64(tb[DPLL_A_CLOCK_ID], filter->clock_id))
+		return false;
+	if ((filter->present & DPLL_FILTER_DEV_TYPE) &&
+	    !filter_match_u32(tb[DPLL_A_TYPE], filter->type))
+		return false;
+	if ((filter->present & DPLL_FILTER_DEV_MODE) &&
+	    !filter_match_u32(tb[DPLL_A_MODE], filter->mode))
+		return false;
+	if ((filter->present & DPLL_FILTER_DEV_LOCK_STATUS) &&
+	    !filter_match_u32(tb[DPLL_A_LOCK_STATUS], filter->lock_status))
+		return false;
+	return true;
+}
+
 /* Print device attributes */
 static void dpll_device_print_attrs(const struct nlmsghdr *nlh,
 				    struct nlattr **tb)
@@ -765,9 +895,14 @@ static void dpll_device_print_attrs(const struct nlmsghdr *nlh,
 /* Netlink callback - device get (single device) */
 static int cmd_device_show_cb(const struct nlmsghdr *nlh, void *data)
 {
+	struct dpll_device_filter *filter = data;
 	struct nlattr *tb[DPLL_A_MAX + 1] = {};
 
 	mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_cb, tb);
+
+	if (!dpll_device_dump_filter(filter, tb))
+		return MNL_CB_OK;
+
 	dpll_device_print_attrs(nlh, tb);
 
 	return MNL_CB_OK;
@@ -776,10 +911,14 @@ static int cmd_device_show_cb(const struct nlmsghdr *nlh, void *data)
 /* Netlink callback - device dump (multiple devices) */
 static int cmd_device_show_dump_cb(const struct nlmsghdr *nlh, void *data)
 {
+	struct dpll_device_filter *filter = data;
 	struct nlattr *tb[DPLL_A_MAX + 1] = {};
 
 	mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_cb, tb);
 
+	if (!dpll_device_dump_filter(filter, tb))
+		return MNL_CB_OK;
+
 	open_json_object(NULL);
 	dpll_device_print_attrs(nlh, tb);
 	close_json_object();
@@ -787,7 +926,8 @@ static int cmd_device_show_dump_cb(const struct nlmsghdr *nlh, void *data)
 	return MNL_CB_OK;
 }
 
-static int cmd_device_show_id(struct dpll *dpll, __u32 id)
+static int cmd_device_show_id(struct dpll *dpll, __u32 id,
+			      struct dpll_device_filter *filter)
 {
 	struct nlmsghdr *nlh;
 	int err;
@@ -796,7 +936,8 @@ static int cmd_device_show_id(struct dpll *dpll, __u32 id)
 					  NLM_F_REQUEST | NLM_F_ACK);
 	mnl_attr_put_u32(nlh, DPLL_A_ID, id);
 
-	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_device_show_cb, NULL);
+	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_device_show_cb,
+				     filter);
 	if (err < 0) {
 		pr_err("Failed to get device %u\n", id);
 		return -1;
@@ -805,7 +946,8 @@ static int cmd_device_show_id(struct dpll *dpll, __u32 id)
 	return 0;
 }
 
-static int cmd_device_show_dump(struct dpll *dpll)
+static int cmd_device_show_dump(struct dpll *dpll,
+				struct dpll_device_filter *filter)
 {
 	struct nlmsghdr *nlh;
 	int err;
@@ -817,7 +959,7 @@ static int cmd_device_show_dump(struct dpll *dpll)
 	open_json_array(PRINT_JSON, "device");
 
 	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_device_show_dump_cb,
-				     NULL);
+				     filter);
 	if (err < 0) {
 		pr_err("Failed to dump devices\n");
 		close_json_array(PRINT_JSON, NULL);
@@ -831,6 +973,7 @@ static int cmd_device_show_dump(struct dpll *dpll)
 
 static int cmd_device_show(struct dpll *dpll)
 {
+	struct dpll_device_filter filter = {};
 	bool has_id = false;
 	__u32 id = 0;
 
@@ -839,6 +982,42 @@ static int cmd_device_show(struct dpll *dpll)
 			if (dpll_parse_u32(dpll, "id", &id))
 				return -EINVAL;
 			has_id = true;
+		} else if (dpll_argv_match(dpll, "module-name")) {
+			if (dpll_filter_parse_str(dpll, "module-name",
+						  &filter.module_name,
+						  &filter.present,
+						  DPLL_FILTER_DEV_MODULE_NAME))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "clock-id")) {
+			if (dpll_filter_parse_u64(dpll, "clock-id",
+						  &filter.clock_id,
+						  &filter.present,
+						  DPLL_FILTER_DEV_CLOCK_ID))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "type")) {
+			if (dpll_filter_parse_enum(dpll, "type",
+						   &filter.type,
+						   &filter.present,
+						   DPLL_FILTER_DEV_TYPE,
+						   str_to_dpll_type,
+						   "pps/eec"))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "mode")) {
+			if (dpll_filter_parse_enum(dpll, "mode",
+						   &filter.mode,
+						   &filter.present,
+						   DPLL_FILTER_DEV_MODE,
+						   str_to_dpll_mode,
+						   "manual/automatic"))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "lock-status")) {
+			if (dpll_filter_parse_enum(dpll, "lock-status",
+						   &filter.lock_status,
+						   &filter.present,
+						   DPLL_FILTER_DEV_LOCK_STATUS,
+						   str_to_dpll_lock_status,
+						   "unlocked/locked/locked-ho-acq/holdover"))
+				return -EINVAL;
 		} else {
 			pr_err("unknown option: %s\n", dpll_argv(dpll));
 			return -EINVAL;
@@ -846,9 +1025,9 @@ static int cmd_device_show(struct dpll *dpll)
 	}
 
 	if (has_id)
-		return cmd_device_show_id(dpll, id);
+		return cmd_device_show_id(dpll, id, &filter);
 
-	return cmd_device_show_dump(dpll);
+	return cmd_device_show_dump(dpll, &filter);
 }
 
 static int cmd_device_set(struct dpll *dpll)
diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
index e82f083feac64b..1407ca9793c96c 100644
--- a/man/man8/dpll.8
+++ b/man/man8/dpll.8
@@ -60,7 +60,7 @@ and newlines for better human readability.
 
 .SH DEVICE COMMANDS
 
-.SS dpll device show [ id ID ]
+.SS dpll device show [ id ID ] [ module-name NAME ] [ clock-id ID ] [ type TYPE ] [ mode MODE ] [ lock-status STATUS ]
 
 Display information about DPLL devices. If no arguments are specified,
 shows all devices in the system.
@@ -69,6 +69,29 @@ shows all devices in the system.
 .BI id " ID"
 Show only the device with the specified numeric identifier.
 
+.TP
+.BI module-name " NAME"
+Show only devices provided by the specified kernel module.
+
+.TP
+.BI clock-id " ID"
+Show only devices with the specified 64-bit clock identifier.
+
+.TP
+.BI type " TYPE"
+Show only devices of the specified type:
+.BR pps " or " eec .
+
+.TP
+.BI mode " MODE"
+Show only devices in the specified operating mode:
+.BR manual " or " automatic .
+
+.TP
+.BI lock-status " STATUS"
+Show only devices with the specified lock status:
+.BR unlocked ", " locked ", " locked-ho-acq ", " holdover .
+
 .PP
 Output includes:
 .RS
@@ -304,6 +327,16 @@ Press Ctrl+C to stop monitoring.
 .B dpll device set id 0 phase-offset-monitor enable
 .fi
 
+.SS Show all EEC devices
+.nf
+.B dpll device show type eec
+.fi
+
+.SS Show devices from specific module in JSON
+.nf
+.B dpll -jp device show module-name ice
+.fi
+
 .SS Show all pins
 .nf
 .B dpll pin show
-- 
2.52.0


