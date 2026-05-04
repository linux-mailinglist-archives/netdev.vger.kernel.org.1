Return-Path: <netdev+bounces-283953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qABIDxXK+Gma0wIAu9opvQ
	(envelope-from <netdev+bounces-283953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:32:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B34C16A7
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48112301CFD4
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841E3E4C90;
	Mon,  4 May 2026 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0ej3Kn1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECAF3E4C76
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912228; cv=none; b=QSPnykBqJDBTFhbNMg1nlt6xcQojVzeWwAepfHRS5UKoWSMjYixRwrvART16E44LvV0q0VjzpfPJFuYVJu7VvLrk5MzIZAKA0ZR4iBUDdUdlHrAghj4gyb6NLaBKOFgQjvhJYMXjXyommgTKaCukdUasLfeotKPX6gM/vQEx6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912228; c=relaxed/simple;
	bh=KuLKEQ75KiOb6J3vTQa7F+cln8EbjFsSeKJJYM7pQQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkEJ8j6onI5rkvuq2qgiw2Yf6CFdnkqhvoClwWkfNRLGe4lzC/44WjCPr/DaMnIqJQbgb5Ya+qSmBSdffTw4VrbgNjFCav4tyccDspTHivbCo2CCnMncQMpM83O3+VvU0kaj+txnuKAtwN/G9X/BN5XRLuwx6T4iaClGWcg8WVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0ej3Kn1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777912223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ri/qaECKIYxQ3kaXnyByGAgUlYY8448dDc6oUJtCfUA=;
	b=G0ej3Kn1FXLULpV5g5lFJ/4yRdTJN6QnsHQESCl50JNcCj2A1sya7owrKJ/vrcXrYMtPvb
	MXL0Z3PBlpv3N63PWu3uiHSoQnvrQQzNhb76nx2nETDByynEHUW1FZor4q/50M+zjorhoC
	y8VJrTw8fiUMDjbY8U5Mj0jFmSu8JgQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-J5h0tCGAPfWQTNf9oHUvAA-1; Mon,
 04 May 2026 12:30:22 -0400
X-MC-Unique: J5h0tCGAPfWQTNf9oHUvAA-1
X-Mimecast-MFC-AGG-ID: J5h0tCGAPfWQTNf9oHUvAA_1777912221
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 488F219560B2;
	Mon,  4 May 2026 16:30:21 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B906919560A6;
	Mon,  4 May 2026 16:30:19 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next v3 2/2] dpll: add frequency monitoring support
Date: Mon,  4 May 2026 18:30:14 +0200
Message-ID: <20260504163014.416317-3-ivecera@redhat.com>
In-Reply-To: <20260504163014.416317-1-ivecera@redhat.com>
References: <20260504163014.416317-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: B32B34C16A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283953-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add support for the new frequency monitoring feature from the kernel
patch series "dpll: add actual frequency monitoring feature". This
includes:

- DPLL_A_FREQUENCY_MONITOR device attribute (enable/disable)
- DPLL_A_PIN_MEASURED_FREQUENCY pin attribute displayed as fractional Hz
  using DPLL_PR_MEASURED_FREQUENCY macro (kernel reports in mHz)
- device set: frequency-monitor { enable | disable }
- Refactor phase-offset-monitor to use new dpll_parse_attr_feature_state
  helper shared with frequency-monitor
- Update man page and bash-completion

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes:
v3 - macro DPLL_PR_MEASURED_FREQUENCY replaced by function
     dpll_pr_measured_frequency
v2 - fixed very long line in the man page
---
 bash-completion/dpll |  4 +--
 dpll/dpll.c          | 63 +++++++++++++++++++++++++++++++++++---------
 man/man8/dpll.8      | 21 +++++++++++++--
 3 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/bash-completion/dpll b/bash-completion/dpll
index 542b99c2fce2..7ddcf529d429 100644
--- a/bash-completion/dpll
+++ b/bash-completion/dpll
@@ -100,7 +100,7 @@ _dpll_device()
                     COMPREPLY=( $( compgen -W "automatic manual" -- "$cur" ) )
                     return 0
                     ;;
-                phase-offset-monitor)
+                phase-offset-monitor|frequency-monitor)
                     COMPREPLY=( $( compgen -W "enable disable true false 0 1" -- "$cur" ) )
                     return 0
                     ;;
@@ -110,7 +110,7 @@ _dpll_device()
                     ;;
                 *)
                     COMPREPLY=( $( compgen -W "id mode phase-offset-monitor \
-                        phase-offset-avg-factor" -- "$cur" ) )
+                        phase-offset-avg-factor frequency-monitor" -- "$cur" ) )
                     return 0
                     ;;
             esac
diff --git a/dpll/dpll.c b/dpll/dpll.c
index 1c5d2b1b7f28..febf2a5d1fbd 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -313,6 +313,26 @@ static int dpll_parse_attr_str(struct dpll *dpll, struct nlmsghdr *nlh,
 	return 0;
 }
 
+static int dpll_parse_attr_feature_state(struct dpll *dpll,
+					struct nlmsghdr *nlh,
+					const char *arg_name, int attr_id)
+{
+	const char *str = dpll_argv_next(dpll);
+	bool val;
+
+	if (!str) {
+		pr_err("%s requires an argument\n", arg_name);
+		return -EINVAL;
+	}
+	if (str_to_bool(str, &val)) {
+		pr_err("invalid %s value: %s (use enable/disable)\n",
+		       arg_name, str);
+		return -EINVAL;
+	}
+	mnl_attr_put_u32(nlh, attr_id, val ? 1 : 0);
+	return 0;
+}
+
 static int dpll_parse_attr_enum(struct dpll *dpll, struct nlmsghdr *nlh,
 				const char *arg_name, int attr_id,
 				int (*parse_func)(struct dpll *, __u32 *))
@@ -473,6 +493,22 @@ static void dpll_pr_phase_offset(struct nlattr *attr)
 	print_s64(PRINT_FP, NULL, "%03lld ps", d.rem);
 }
 
+/* Measured frequency - JSON prints raw mHz value, FP prints fractional Hz */
+static void dpll_pr_measured_frequency(struct nlattr *attr)
+{
+	__u64 val;
+	lldiv_t d;
+
+	if (!attr)
+		return;
+
+	val = mnl_attr_get_u64(attr);
+	d = lldiv(val, DPLL_PIN_MEASURED_FREQUENCY_DIVIDER);
+	print_lluint(PRINT_JSON, "measured-frequency", NULL, val);
+	print_s64(PRINT_FP, NULL, "  measured-frequency: %lld.", d.quot);
+	print_s64(PRINT_FP, NULL, "%03lld Hz\n", d.rem);
+}
+
 /* Print frequency range (or single value if min==max) */
 static void dpll_pr_freq_range(__u64 freq_min, __u64 freq_max)
 {
@@ -660,6 +696,7 @@ static void cmd_device_help(void)
 	pr_err("       dpll device set id DEVICE_ID [ mode { automatic | manual } ]\n");
 	pr_err("                                    [ phase-offset-monitor { enable | disable } ]\n");
 	pr_err("                                    [ phase-offset-avg-factor NUM ]\n");
+	pr_err("                                    [ frequency-monitor { enable | disable } ]\n");
 	pr_err("       dpll device id-get [ module-name NAME ] [ clock-id ID ] [ type TYPE ]\n");
 }
 
@@ -1061,6 +1098,10 @@ static void dpll_device_print_attrs(const struct nlmsghdr *nlh,
 			     str_enable_disable);
 	DPLL_PR_UINT(tb, DPLL_A_PHASE_OFFSET_AVG_FACTOR,
 		     "phase-offset-avg-factor");
+	DPLL_PR_ENUM_STR_FMT(tb, DPLL_A_FREQUENCY_MONITOR,
+			     "frequency-monitor",
+			     "  frequency-monitor: %s\n",
+			     str_enable_disable);
 }
 
 /* Netlink callback - device get (single device) */
@@ -1222,25 +1263,20 @@ static int cmd_device_set(struct dpll *dpll)
 						 dpll_parse_mode))
 				return -EINVAL;
 		} else if (dpll_argv_match(dpll, "phase-offset-monitor")) {
-			const char *str = dpll_argv_next(dpll);
-			bool val;
-
-			if (!str) {
-				pr_err("phase-offset-monitor requires an argument\n");
+			if (dpll_parse_attr_feature_state(dpll, nlh,
+							  "phase-offset-monitor",
+							  DPLL_A_PHASE_OFFSET_MONITOR))
 				return -EINVAL;
-			}
-			if (str_to_bool(str, &val)) {
-				pr_err("invalid phase-offset-monitor value: %s (use enable/disable)\n",
-				       str);
-				return -EINVAL;
-			}
-			mnl_attr_put_u32(nlh, DPLL_A_PHASE_OFFSET_MONITOR,
-					 val ? 1 : 0);
 		} else if (dpll_argv_match(dpll, "phase-offset-avg-factor")) {
 			if (dpll_parse_attr_u32(dpll, nlh,
 						"phase-offset-avg-factor",
 						DPLL_A_PHASE_OFFSET_AVG_FACTOR))
 				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "frequency-monitor")) {
+			if (dpll_parse_attr_feature_state(dpll, nlh,
+							  "frequency-monitor",
+							  DPLL_A_FREQUENCY_MONITOR))
+				return -EINVAL;
 		} else {
 			pr_err("unknown option: %s\n", dpll_argv(dpll));
 			return -EINVAL;
@@ -1604,6 +1640,7 @@ static void dpll_pin_print_attrs(struct nlattr **tb)
 	DPLL_PR_ENUM_STR(tb, DPLL_A_PIN_TYPE, "type", dpll_pin_type_name);
 	DPLL_PR_U64_FMT(tb, DPLL_A_PIN_FREQUENCY, "frequency",
 			"  frequency: %" PRIu64 " Hz\n");
+	dpll_pr_measured_frequency(tb[DPLL_A_PIN_MEASURED_FREQUENCY]);
 
 	dpll_pin_print_freq_supported(tb[DPLL_A_PIN_FREQUENCY_SUPPORTED]);
 
diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
index 89f17af74923..c0d4b9caef2a 100644
--- a/man/man8/dpll.8
+++ b/man/man8/dpll.8
@@ -109,9 +109,11 @@ Lock status (locked-ho-ack, locked, unlocked, holdover)
 Temperature (if supported)
 .IP \[bu]
 Type (PPS or EEC)
+.IP \[bu]
+Frequency monitor status (enable/disable)
 .RE
 
-.SS dpll device set id ID [ mode { automatic | manual } ] [ phase-offset-monitor { enable | disable } ] [ phase-offset-avg-factor FACTOR ]
+.SS dpll device set id ID [ PARAMETER VALUE ] ...
 
 Configure DPLL device parameters.
 
@@ -140,6 +142,14 @@ When enabled, the kernel continuously measures and reports phase differences.
 Set the averaging factor (1-255) applied to phase offset calculations.
 Higher values provide smoother but slower-responding measurements.
 
+.TP
+.BI frequency-monitor " { enable | disable }"
+Enable or disable frequency monitoring on the device. When enabled, the
+kernel continuously measures and reports actual pin frequencies, which can
+be read via the
+.B measured-frequency
+field in pin show output.
+
 .SS dpll device id-get [ module-name NAME ] [ clock-id ID ] [ type TYPE ]
 
 Retrieve the device ID based on identifying attributes. Useful for scripting
@@ -233,7 +243,9 @@ Board label (hardware label from device tree or ACPI)
 .IP \[bu]
 Pin type (mux, ext, synce-eth-port, int-oscillator, gnss)
 .IP \[bu]
-Frequency and supported frequency ranges
+Configured frequency and supported frequency ranges
+.IP \[bu]
+Measured frequency in Hz (when frequency monitoring is enabled)
 .IP \[bu]
 Capabilities (state-can-change, priority-can-change, direction-can-change)
 .IP \[bu]
@@ -372,6 +384,11 @@ Press Ctrl+C to stop monitoring.
 .B dpll device set id 0 phase-offset-monitor enable
 .fi
 
+.SS Enable frequency monitoring on device 0
+.nf
+.B dpll device set id 0 frequency-monitor enable
+.fi
+
 .SS Show all EEC devices
 .nf
 .B dpll device show type eec
-- 
2.53.0


