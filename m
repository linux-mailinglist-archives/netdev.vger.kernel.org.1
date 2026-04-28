Return-Path: <netdev+bounces-281948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFPhHO/Q8GlpZAEAu9opvQ
	(envelope-from <netdev+bounces-281948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:23:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7388487BF2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D261D3053CC4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EA2313298;
	Tue, 28 Apr 2026 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbctiBo/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22C395D8B
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389691; cv=none; b=UpsDhe/P8F5Q6aIGYxHwkgG35IfapBUNlf0rJy7a2QVguqkpo8Hg24DjCnkVEscks20CngR2lekXZlQNfIafhQOaXZg5bODfp/T0nr6vQPZEOrLe4nmQdeFb987cXIAmLhXMdM0e00w0b7tMLdgSLdZeSXuNKcREevQscKUeUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389691; c=relaxed/simple;
	bh=ouyM7NMwaC73seyX5OtU4PkMzWA7HJQj271PXbXZhZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe905EboZQQLkPTwmmhKqk1yiB8I4vxnl/545293lgK+/zrdMAAtyuclBp5zAPyPaZyiGlup6waLf+cap7qh+KwM/m8RsPnJ4HhDiyn1fmzAySifHu4YndFcwcBHXig3aApp3Gjmgat1zqBmRxwh1yy89Ebp1Qcrefp2RKf3cv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbctiBo/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777389688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LngOVqkgAQYIYscWAk3WuyZjE2QNDFJUpv4XnHa99Xk=;
	b=MbctiBo/6qjk2h87OJ+ZspJC0knZtHOhNtOu3JzMMpH4r3U+Roh51P9yCs07q54GWZmbFP
	ksZyTUJ2xdGvkmJ7DZMxsSWHfPqiLG0WTLPnIiQaYqI4BuH1pMRtbSu6Rfha2jYxkdgYzN
	OEyjnHLcCzTs7DQ99n2hrSf4tWkeuBA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-V32rblDONQiZZfcLnHzTBw-1; Tue,
 28 Apr 2026 11:21:24 -0400
X-MC-Unique: V32rblDONQiZZfcLnHzTBw-1
X-Mimecast-MFC-AGG-ID: V32rblDONQiZZfcLnHzTBw_1777389683
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D36F195608F;
	Tue, 28 Apr 2026 15:21:23 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.234])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0D8C195608E;
	Tue, 28 Apr 2026 15:21:21 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 2/2] dpll: add frequency monitoring support
Date: Tue, 28 Apr 2026 17:21:15 +0200
Message-ID: <20260428152115.2815860-3-ivecera@redhat.com>
In-Reply-To: <20260428152115.2815860-1-ivecera@redhat.com>
References: <20260428152115.2815860-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: C7388487BF2
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-281948-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 bash-completion/dpll |  4 +--
 dpll/dpll.c          | 62 ++++++++++++++++++++++++++++++++++----------
 man/man8/dpll.8      | 19 ++++++++++++--
 3 files changed, 68 insertions(+), 17 deletions(-)

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
index e8056ff6a24b..6d8c0cbb8a34 100644
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
@@ -425,6 +445,21 @@ static __s64 mnl_attr_get_sint(const struct nlattr *attr)
 		}                                                              \
 	} while (0)
 
+/* Measured frequency - JSON prints raw mHz value, FP prints fractional Hz */
+#define DPLL_PR_MEASURED_FREQUENCY(tb, attr_id)                                \
+	do {                                                                   \
+		if (tb[attr_id]) {                                             \
+			__u64 val = mnl_attr_get_u64(tb[attr_id]);             \
+			lldiv_t d = lldiv(val,                                 \
+				DPLL_PIN_MEASURED_FREQUENCY_DIVIDER);           \
+			print_lluint(PRINT_JSON, "measured-frequency",         \
+				     NULL, val);                                \
+			print_s64(PRINT_FP, NULL,                              \
+				  "  measured-frequency: %lld.", d.quot);       \
+			print_s64(PRINT_FP, NULL, "%03lld Hz\n", d.rem);       \
+		}                                                              \
+	} while (0)
+
 /* Generic version with custom format */
 #define DPLL_PR_ENUM_STR_FMT(tb, attr_id, name, format_str, name_func)         \
 	do {                                                                   \
@@ -657,6 +692,7 @@ static void cmd_device_help(void)
 	pr_err("       dpll device set id DEVICE_ID [ mode { automatic | manual } ]\n");
 	pr_err("                                    [ phase-offset-monitor { enable | disable } ]\n");
 	pr_err("                                    [ phase-offset-avg-factor NUM ]\n");
+	pr_err("                                    [ frequency-monitor { enable | disable } ]\n");
 	pr_err("       dpll device id-get [ module-name NAME ] [ clock-id ID ] [ type TYPE ]\n");
 }
 
@@ -1058,6 +1094,10 @@ static void dpll_device_print_attrs(const struct nlmsghdr *nlh,
 			     str_enable_disable);
 	DPLL_PR_UINT(tb, DPLL_A_PHASE_OFFSET_AVG_FACTOR,
 		     "phase-offset-avg-factor");
+	DPLL_PR_ENUM_STR_FMT(tb, DPLL_A_FREQUENCY_MONITOR,
+			     "frequency-monitor",
+			     "  frequency-monitor: %s\n",
+			     str_enable_disable);
 }
 
 /* Netlink callback - device get (single device) */
@@ -1219,25 +1259,20 @@ static int cmd_device_set(struct dpll *dpll)
 						 dpll_parse_mode))
 				return -EINVAL;
 		} else if (dpll_argv_match(dpll, "phase-offset-monitor")) {
-			const char *str = dpll_argv_next(dpll);
-			bool val;
-
-			if (!str) {
-				pr_err("phase-offset-monitor requires an argument\n");
-				return -EINVAL;
-			}
-			if (str_to_bool(str, &val)) {
-				pr_err("invalid phase-offset-monitor value: %s (use enable/disable)\n",
-				       str);
+			if (dpll_parse_attr_feature_state(dpll, nlh,
+							  "phase-offset-monitor",
+							  DPLL_A_PHASE_OFFSET_MONITOR))
 				return -EINVAL;
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
@@ -1601,6 +1636,7 @@ static void dpll_pin_print_attrs(struct nlattr **tb)
 	DPLL_PR_ENUM_STR(tb, DPLL_A_PIN_TYPE, "type", dpll_pin_type_name);
 	DPLL_PR_U64_FMT(tb, DPLL_A_PIN_FREQUENCY, "frequency",
 			"  frequency: %" PRIu64 " Hz\n");
+	DPLL_PR_MEASURED_FREQUENCY(tb, DPLL_A_PIN_MEASURED_FREQUENCY);
 
 	dpll_pin_print_freq_supported(tb[DPLL_A_PIN_FREQUENCY_SUPPORTED]);
 
diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
index 89f17af74923..59ec4208f251 100644
--- a/man/man8/dpll.8
+++ b/man/man8/dpll.8
@@ -111,7 +111,7 @@ Temperature (if supported)
 Type (PPS or EEC)
 .RE
 
-.SS dpll device set id ID [ mode { automatic | manual } ] [ phase-offset-monitor { enable | disable } ] [ phase-offset-avg-factor FACTOR ]
+.SS dpll device set id ID [ mode { automatic | manual } ] [ phase-offset-monitor { enable | disable } ] [ phase-offset-avg-factor FACTOR ] [ frequency-monitor { enable | disable } ]
 
 Configure DPLL device parameters.
 
@@ -140,6 +140,14 @@ When enabled, the kernel continuously measures and reports phase differences.
 Set the averaging factor (1-255) applied to phase offset calculations.
 Higher values provide smoother but slower-responding measurements.
 
+.TP
+.BI frequency-monitor " { enable | disable | true | false | 0 | 1 }"
+Enable or disable frequency monitoring on the device. When enabled, the
+kernel continuously measures and reports actual pin frequencies, which can
+be read via the
+.B measured-frequency
+field in pin show output.
+
 .SS dpll device id-get [ module-name NAME ] [ clock-id ID ] [ type TYPE ]
 
 Retrieve the device ID based on identifying attributes. Useful for scripting
@@ -233,7 +241,9 @@ Board label (hardware label from device tree or ACPI)
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
@@ -372,6 +382,11 @@ Press Ctrl+C to stop monitoring.
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


