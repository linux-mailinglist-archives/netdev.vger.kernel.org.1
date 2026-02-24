Return-Path: <netdev+bounces-260419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEdeBlVsnWnhPwQAu9opvQ
	(envelope-from <netdev+bounces-260419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:16:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E764184681
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D6BD30A2B92
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F336683E;
	Tue, 24 Feb 2026 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIzaSKnT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880120A5F3
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924379; cv=none; b=Zuk6Pek0Ef6ppb3Nz2JNYM4AlGAzEuwDJCSvcXxvCbcZopYmFX32Y4fSplgTZVpv5EgU284RV9lku2VSSx56EEr7Bd6YCpVOnGk2Q6opJG1xkFyTKo1Uqn8vuDadpxopGX9BPV+FzfWirG2V4D+Z1axnT66EYrnV5tse9glOjNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924379; c=relaxed/simple;
	bh=PywyXVUQZxPPwZny5ecIEPcK/SXPQWPgjcpzsC6YE00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqGcb4rPudoouc/T6mxWkIiQg5hO6R4l+b0w0O/P/cdqZCDisXNXiQj7C21bzl55G18WR1GC3lopfOLibv9B04SXKXuRfCeY7WH7enynypI85+qSL68WPnSoGLjuZ+wXO8cKC6MdDvgzVDsAhv92zB28uijVFKyUh9lsAY/6jTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIzaSKnT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771924377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9C8fmqYnzHVYYXE5fUhtkc6rinPl4aovcXFrkDJckgM=;
	b=CIzaSKnTQ5b1kv0qPp/J0K2x/US5it5oQc6RfPLqRM6q9ffIvkWuCFncKgIxbYYzvu5KmV
	nPmtzgm0a/HQN5ZU4Fpe5j7I0L3MW1IjUvgDjO7omdubmElf8RWmPQdQfPjzy08qYRHaW7
	kIjq/bnX8jStK2X1mZ2CnAaAiqJSl+Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-Qyc2V5TAMmWYtxjOGmWv4A-1; Tue,
 24 Feb 2026 04:12:55 -0500
X-MC-Unique: Qyc2V5TAMmWYtxjOGmWv4A-1
X-Mimecast-MFC-AGG-ID: Qyc2V5TAMmWYtxjOGmWv4A_1771924374
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B4B11956075;
	Tue, 24 Feb 2026 09:12:54 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.225.132])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 505E51955F43;
	Tue, 24 Feb 2026 09:12:53 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 3/4] dpll: add client-side filtering for pin show
Date: Tue, 24 Feb 2026 10:12:42 +0100
Message-ID: <20260224091243.58501-4-poros@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260419-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 6E764184681
X-Rspamd-Action: no action

Add client-side filtering support for dpll pin show command.
Users can filter pins by module-name, clock-id, board-label,
panel-label, package-label, and type. Multiple filters use AND
semantics. Filters work with both dump and single GET operations.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 bash-completion/dpll |  22 +++++++-
 dpll/dpll.c          | 120 ++++++++++++++++++++++++++++++++++++++++---
 man/man8/dpll.8      |  37 ++++++++++++-
 3 files changed, 169 insertions(+), 10 deletions(-)

diff --git a/bash-completion/dpll b/bash-completion/dpll
index a614b3eb6ab355..f81a2d2caa1012 100644
--- a/bash-completion/dpll
+++ b/bash-completion/dpll
@@ -158,8 +158,28 @@ _dpll_pin()
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
+                board-label|panel-label|package-label)
+                    # string value, no completion
+                    return 0
+                    ;;
+                type)
+                    COMPREPLY=( $( compgen -W "mux ext synce-eth-port \
+                        int-oscillator gnss" -- "$cur" ) )
+                    return 0
+                    ;;
                 *)
-                    COMPREPLY=( $( compgen -W "id device" -- "$cur" ) )
+                    COMPREPLY=( $( compgen -W "id device module-name clock-id \
+                        board-label panel-label package-label type" \
+                        -- "$cur" ) )
                     return 0
                     ;;
             esac
diff --git a/dpll/dpll.c b/dpll/dpll.c
index aea7b89c39d0b4..e39e56fc5632aa 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -865,6 +865,51 @@ static bool dpll_device_dump_filter(struct dpll_device_filter *filter,
 	return true;
 }
 
+#define DPLL_FILTER_PIN_MODULE_NAME	BIT(0)
+#define DPLL_FILTER_PIN_CLOCK_ID	BIT(1)
+#define DPLL_FILTER_PIN_BOARD_LABEL	BIT(2)
+#define DPLL_FILTER_PIN_PANEL_LABEL	BIT(3)
+#define DPLL_FILTER_PIN_PACKAGE_LABEL	BIT(4)
+#define DPLL_FILTER_PIN_TYPE		BIT(5)
+
+struct dpll_pin_filter {
+	uint64_t present;
+	const char *module_name;
+	__u64 clock_id;
+	const char *board_label;
+	const char *panel_label;
+	const char *package_label;
+	__u32 type;
+};
+
+static bool dpll_pin_dump_filter(struct dpll_pin_filter *filter,
+				 struct nlattr **tb)
+{
+	if (!filter || !filter->present)
+		return true;
+
+	if ((filter->present & DPLL_FILTER_PIN_MODULE_NAME) &&
+	    !filter_match_str(tb[DPLL_A_PIN_MODULE_NAME], filter->module_name))
+		return false;
+	if ((filter->present & DPLL_FILTER_PIN_CLOCK_ID) &&
+	    !filter_match_u64(tb[DPLL_A_PIN_CLOCK_ID], filter->clock_id))
+		return false;
+	if ((filter->present & DPLL_FILTER_PIN_BOARD_LABEL) &&
+	    !filter_match_str(tb[DPLL_A_PIN_BOARD_LABEL], filter->board_label))
+		return false;
+	if ((filter->present & DPLL_FILTER_PIN_PANEL_LABEL) &&
+	    !filter_match_str(tb[DPLL_A_PIN_PANEL_LABEL], filter->panel_label))
+		return false;
+	if ((filter->present & DPLL_FILTER_PIN_PACKAGE_LABEL) &&
+	    !filter_match_str(tb[DPLL_A_PIN_PACKAGE_LABEL],
+			      filter->package_label))
+		return false;
+	if ((filter->present & DPLL_FILTER_PIN_TYPE) &&
+	    !filter_match_u32(tb[DPLL_A_PIN_TYPE], filter->type))
+		return false;
+	return true;
+}
+
 /* Print device attributes */
 static void dpll_device_print_attrs(const struct nlmsghdr *nlh,
 				    struct nlattr **tb)
@@ -1186,6 +1231,9 @@ static int cmd_device(struct dpll *dpll)
 static void cmd_pin_help(void)
 {
 	pr_err("Usage: dpll pin show [ id PIN_ID ] [ device DEVICE_ID ]\n");
+	pr_err("                     [ module-name NAME ] [ clock-id ID ]\n");
+	pr_err("                     [ board-label LABEL ] [ panel-label LABEL ]\n");
+	pr_err("                     [ package-label LABEL ] [ type TYPE ]\n");
 	pr_err("       dpll pin set id PIN_ID [ frequency FREQ ]\n");
 	pr_err("                              [ phase-adjust ADJUST ]\n");
 	pr_err("                              [ esync-frequency FREQ ]\n");
@@ -1546,6 +1594,7 @@ static void dpll_multi_attr_parse(const struct nlmsghdr *nlh, int attr_type,
 /* Callback for pin get (single) */
 static int cmd_pin_show_cb(const struct nlmsghdr *nlh, void *data)
 {
+	struct dpll_pin_filter *filter = data;
 	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
 	struct multi_attr_ctx parent_dev_ctx = { 0 }, parent_pin_ctx = { 0 },
 			      ref_sync_ctx = { 0 };
@@ -1558,6 +1607,9 @@ static int cmd_pin_show_cb(const struct nlmsghdr *nlh, void *data)
 	/* First parse to get main attributes */
 	mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_pin_cb, tb);
 
+	if (!dpll_pin_dump_filter(filter, tb))
+		return MNL_CB_OK;
+
 	/* Pass 1: Count multi-attr occurrences and allocate */
 	count = multi_attr_count_get(nlh, genl, DPLL_A_PIN_PARENT_DEVICE);
 	if (count > 0 && multi_attr_ctx_init(&parent_dev_ctx, count) < 0)
@@ -1635,16 +1687,27 @@ cleanup:
 /* Callback for pin dump (multiple) - wraps each pin in object */
 static int cmd_pin_show_dump_cb(const struct nlmsghdr *nlh, void *data)
 {
+	struct dpll_pin_filter *filter = data;
+	struct nlattr *tb[DPLL_A_PIN_MAX + 1] = {};
 	int ret;
 
+	/* Lightweight pre-parse for filter check before expensive
+	 * multi-attr processing in cmd_pin_show_cb.
+	 */
+	mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_pin_cb, tb);
+
+	if (!dpll_pin_dump_filter(filter, tb))
+		return MNL_CB_OK;
+
 	open_json_object(NULL);
-	ret = cmd_pin_show_cb(nlh, data);
+	ret = cmd_pin_show_cb(nlh, NULL);
 	close_json_object();
 
 	return ret;
 }
 
-static int cmd_pin_show_id(struct dpll *dpll, __u32 id)
+static int cmd_pin_show_id(struct dpll *dpll, __u32 id,
+			   struct dpll_pin_filter *filter)
 {
 	struct nlmsghdr *nlh;
 	int err;
@@ -1653,7 +1716,8 @@ static int cmd_pin_show_id(struct dpll *dpll, __u32 id)
 					  NLM_F_REQUEST | NLM_F_ACK);
 	mnl_attr_put_u32(nlh, DPLL_A_PIN_ID, id);
 
-	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_pin_show_cb, NULL);
+	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_pin_show_cb,
+				     filter);
 	if (err < 0) {
 		pr_err("Failed to get pin %u\n", id);
 		return -1;
@@ -1663,7 +1727,8 @@ static int cmd_pin_show_id(struct dpll *dpll, __u32 id)
 }
 
 static int cmd_pin_show_dump(struct dpll *dpll, bool has_device_id,
-			     __u32 device_id)
+			     __u32 device_id,
+			     struct dpll_pin_filter *filter)
 {
 	struct nlmsghdr *nlh;
 	int err;
@@ -1680,7 +1745,7 @@ static int cmd_pin_show_dump(struct dpll *dpll, bool has_device_id,
 	open_json_array(PRINT_JSON, "pin");
 
 	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_pin_show_dump_cb,
-				     NULL);
+				     filter);
 	if (err < 0) {
 		pr_err("Failed to dump pins\n");
 		close_json_array(PRINT_JSON, NULL);
@@ -1696,6 +1761,7 @@ static int cmd_pin_show_dump(struct dpll *dpll, bool has_device_id,
 static int cmd_pin_show(struct dpll *dpll)
 {
 	bool has_pin_id = false, has_device_id = false;
+	struct dpll_pin_filter filter = {};
 	__u32 pin_id = 0, device_id = 0;
 
 	while (dpll_argc(dpll) > 0) {
@@ -1707,6 +1773,44 @@ static int cmd_pin_show(struct dpll *dpll)
 			if (dpll_parse_u32(dpll, "device", &device_id))
 				return -EINVAL;
 			has_device_id = true;
+		} else if (dpll_argv_match(dpll, "module-name")) {
+			if (dpll_filter_parse_str(dpll, "module-name",
+						  &filter.module_name,
+						  &filter.present,
+						  DPLL_FILTER_PIN_MODULE_NAME))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "clock-id")) {
+			if (dpll_filter_parse_u64(dpll, "clock-id",
+						  &filter.clock_id,
+						  &filter.present,
+						  DPLL_FILTER_PIN_CLOCK_ID))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "board-label")) {
+			if (dpll_filter_parse_str(dpll, "board-label",
+						  &filter.board_label,
+						  &filter.present,
+						  DPLL_FILTER_PIN_BOARD_LABEL))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "panel-label")) {
+			if (dpll_filter_parse_str(dpll, "panel-label",
+						  &filter.panel_label,
+						  &filter.present,
+						  DPLL_FILTER_PIN_PANEL_LABEL))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "package-label")) {
+			if (dpll_filter_parse_str(dpll, "package-label",
+						  &filter.package_label,
+						  &filter.present,
+						  DPLL_FILTER_PIN_PACKAGE_LABEL))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "type")) {
+			if (dpll_filter_parse_enum(dpll, "type",
+						   &filter.type,
+						   &filter.present,
+						   DPLL_FILTER_PIN_TYPE,
+						   str_to_dpll_pin_type,
+						   "mux/ext/synce-eth-port/int-oscillator/gnss"))
+				return -EINVAL;
 		} else {
 			pr_err("unknown option: %s\n", dpll_argv(dpll));
 			return -EINVAL;
@@ -1714,9 +1818,9 @@ static int cmd_pin_show(struct dpll *dpll)
 	}
 
 	if (has_pin_id)
-		return cmd_pin_show_id(dpll, pin_id);
-	else
-		return cmd_pin_show_dump(dpll, has_device_id, device_id);
+		return cmd_pin_show_id(dpll, pin_id, &filter);
+
+	return cmd_pin_show_dump(dpll, has_device_id, device_id, &filter);
 }
 
 static int cmd_pin_parse_parent_device(struct dpll *dpll, struct nlmsghdr *nlh)
diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
index 1407ca9793c96c..a4280153b4d67b 100644
--- a/man/man8/dpll.8
+++ b/man/man8/dpll.8
@@ -161,7 +161,7 @@ Device type:
 
 .SH PIN COMMANDS
 
-.SS dpll pin show [ id ID ] [ device ID ]
+.SS dpll pin show [ id ID ] [ device ID ] [ module-name NAME ] [ clock-id ID ] [ board-label LABEL ] [ panel-label LABEL ] [ package-label LABEL ] [ type TYPE ]
 
 Display information about DPLL pins. If no arguments are specified,
 shows all pins in the system.
@@ -174,6 +174,31 @@ Show only the pin with the specified numeric identifier.
 .BI device " ID"
 Show only pins associated with the specified device ID.
 
+.TP
+.BI module-name " NAME"
+Show only pins provided by the specified kernel module.
+
+.TP
+.BI clock-id " ID"
+Show only pins with the specified 64-bit clock identifier.
+
+.TP
+.BI board-label " LABEL"
+Show only pins with the specified board label.
+
+.TP
+.BI panel-label " LABEL"
+Show only pins with the specified panel label.
+
+.TP
+.BI package-label " LABEL"
+Show only pins with the specified package label.
+
+.TP
+.BI type " TYPE"
+Show only pins of the specified type:
+.BR mux ", " ext ", " synce-eth-port ", " int-oscillator ", " gnss .
+
 .PP
 Output includes:
 .RS
@@ -342,6 +367,16 @@ Press Ctrl+C to stop monitoring.
 .B dpll pin show
 .fi
 
+.SS Show all GNSS pins
+.nf
+.B dpll pin show type gnss
+.fi
+
+.SS Show GNSS pins from specific module
+.nf
+.B dpll pin show type gnss module-name ice
+.fi
+
 .SS Show pin with pretty JSON output
 .nf
 .B dpll -jp pin show id 5
-- 
2.52.0


