Return-Path: <netdev+bounces-287182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCIGJR8yA2oA1gEAu9opvQ
	(envelope-from <netdev+bounces-287182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:58:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1471C521D58
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4AEB30B0183
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD8339A4BC;
	Tue, 12 May 2026 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Woj61NY+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E16397B03
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593958; cv=none; b=ukX7IkZFULdTGvwlo0NxK+dG6vSsKQrI5tR4o1IJFukLTd0uZJ+66CDYfpne8tsSuZXQapmZItZt847OZ67oDGMaFm7g3Jdjao0OvgKzj2o1Ww+fCJZ3b0EqcMJdcx2q3ANwdaMeR+0MGki6zyTGmEND1GBisbnRI/t+vo3w2lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593958; c=relaxed/simple;
	bh=CI09rjw1id8j2uzBg7qddTN9fC/ddsDWfIeKhBcO+0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euJ59V7nhrh2l9mN+idvot3vO38gvU2Vte46KkX45oPPlidhhdh/FQNBg3pshR5AvIL90RjCfPQM5TdAoxuNsjyzFkGGImivUmDmR0MPkuKuanXq/ArEotKwbM6afKQjyeHnVkrJIqVZ301rUxNA6Jrs8te9H0nS0o36miTad/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Woj61NY+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778593956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXZOyv9L5S/DM2phzpa3roYXamSDn9dOfRc37Ylb6xM=;
	b=Woj61NY+/XRMKS0i2mXYyJhzqp8dIoGtnSSSCJfAMbIbPWdfq2l6fhj+xTs4t6Y0mGCNFI
	dpN5/LvrSgi5JiSYLwDPzv7ntt331Qt0tfFjcHZnZG3W5jzi3liCXxVfU6V5yPAp3avywo
	msdjgRW6c9FbpfYaJPXZy4IaQ6/1pu4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-CwMLYe8IOL2E7UPR1hq8JQ-1; Tue,
 12 May 2026 09:52:35 -0400
X-MC-Unique: CwMLYe8IOL2E7UPR1hq8JQ-1
X-Mimecast-MFC-AGG-ID: CwMLYe8IOL2E7UPR1hq8JQ_1778593954
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DC8B180058C;
	Tue, 12 May 2026 13:52:34 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.50.226])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 216A219560A2;
	Tue, 12 May 2026 13:52:31 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	vgrinber@redhat.com,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 2/2] dpll: monitor: add -t/--timestamp and --tshort options
Date: Tue, 12 May 2026 15:52:25 +0200
Message-ID: <20260512135225.167158-2-poros@redhat.com>
In-Reply-To: <20260512135225.167158-1-poros@redhat.com>
References: <20260512135225.167158-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 1471C521D58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287182-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Bring dpll monitor in line with the rest of iproute2 by allowing each
received notification to be prefixed with a wall-clock timestamp.

  -t / --timestamp  emit a separate "Timestamp:" line before each event,
                    using the default text form of print_timestamp()
                    (matches ip / bridge / tc -t monitor)
  --tshort          emit a compact ISO 8601 prefix
                    "[YYYY-MM-DDTHH:MM:SS.uuuuuu]" inline instead
                    (matches ip -ts monitor)

When combined with -j, the timestamp shows up as a "timestamp" /
"timestamp_short" field on each notification object, the same way
ip -j -t mptcp monitor integrates the helper.

The flag is parsed globally but only consulted from the monitor
callback, so passing -t to non-monitor commands is a no-op.

--tshort has no short alias, so its long_options entry uses an
identifier above the ASCII range (OPT_TSHORT = 256) following the
iproute2 convention used in misc/ss.c, instead of consuming an
ASCII letter that could later collide with a real short option.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 bash-completion/dpll |  8 ++++++--
 dpll/dpll.c          | 21 +++++++++++++++++++--
 man/man8/dpll.8      | 23 ++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/bash-completion/dpll b/bash-completion/dpll
index 7ddcf529d429db..f615d69147d140 100644
--- a/bash-completion/dpll
+++ b/bash-completion/dpll
@@ -299,7 +299,7 @@ _dpll_monitor()
 _dpll()
 {
     local cur prev words cword
-    local opt='--Version --json --pretty'
+    local opt='--Version --json --pretty --timestamp --tshort'
     local objects="device pin monitor"
 
     _init_completion || return
@@ -326,7 +326,11 @@ _dpll()
                 return 0
                 ;;
             -j|--json)
-                COMPREPLY=( $( compgen -W "--pretty $objects" -- "$cur" ) )
+                COMPREPLY=( $( compgen -W "--pretty --timestamp --tshort $objects" -- "$cur" ) )
+                return 0
+                ;;
+            -t|--timestamp|--tshort)
+                COMPREPLY=( $( compgen -W "monitor" -- "$cur" ) )
                 return 0
                 ;;
             *)
diff --git a/dpll/dpll.c b/dpll/dpll.c
index 81caa510078830..a3cda2c2903f71 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -29,7 +29,10 @@
 
 #define pr_err(args...) fprintf(stderr, ##args)
 
+#define OPT_TSHORT 256
+
 int json;
+int timestamp;
 
 struct dpll {
 	struct mnlu_gen_socket nlg;
@@ -535,7 +538,8 @@ static void help(void)
 {
 	pr_err("Usage: dpll [ OPTIONS ] OBJECT { COMMAND | help }\n"
 	       "where  OBJECT := { device | pin | monitor }\n"
-	       "       OPTIONS := { -V | --Version | -j | --json | -p | --pretty }\n");
+	       "       OPTIONS := { -V | --Version | -j | --json | -p | --pretty |\n"
+	       "                    -t | --timestamp | --tshort }\n");
 }
 
 static int cmd_device(struct dpll *dpll);
@@ -599,9 +603,11 @@ int main(int argc, char **argv)
 		{ "Version", no_argument, NULL, 'V' },
 		{ "json", no_argument, NULL, 'j' },
 		{ "pretty", no_argument, NULL, 'p' },
+		{ "timestamp", no_argument, NULL, 't' },
+		{ "tshort", no_argument, NULL, OPT_TSHORT },
 		{ NULL, 0, NULL, 0 }
 	};
-	const char *opt_short = "Vjp";
+	const char *opt_short = "Vjpt";
 	struct dpll *dpll;
 	int err, opt, ret;
 
@@ -624,6 +630,13 @@ int main(int argc, char **argv)
 		case 'p':
 			pretty = true;
 			break;
+		case 't':
+			timestamp = 1;
+			break;
+		case OPT_TSHORT:
+			timestamp = 1;
+			timestamp_short = 1;
+			break;
 		default:
 			pr_err("Unknown option.\n");
 			help();
@@ -2305,6 +2318,8 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
 
 		new_json_obj_plain(json);
 		open_json_object(NULL);
+		if (timestamp)
+			print_timestamp(stdout);
 		print_string(PRINT_JSON, "name", NULL, json_name);
 		open_json_object("msg");
 		print_string(PRINT_FP, NULL, "[%s] ", cmd_name);
@@ -2334,6 +2349,8 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
 
 		new_json_obj_plain(json);
 		open_json_object(NULL);
+		if (timestamp)
+			print_timestamp(stdout);
 		print_string(PRINT_JSON, "name", NULL, json_name);
 		open_json_object("msg");
 		print_string(PRINT_FP, NULL, "[%s] ", cmd_name);
diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
index 6b52970972f41a..43daa0cac2d5d2 100644
--- a/man/man8/dpll.8
+++ b/man/man8/dpll.8
@@ -29,7 +29,9 @@ dpll \- Digital Phase Locked Loop (DPLL) subsystem management
 .IR OPTIONS " := { "
 \fB\-V\fR | \fB\-\-Version\fR |
 \fB\-j\fR | \fB\-\-json\fR |
-\fB\-p\fR | \fB\-\-pretty\fR }
+\fB\-p\fR | \fB\-\-pretty\fR |
+\fB\-t\fR | \fB\-\-timestamp\fR |
+\fB\-\-tshort\fR }
 
 .SH DESCRIPTION
 The
@@ -58,6 +60,25 @@ Output results in JavaScript Object Notation (JSON).
 When combined with \-j, generates a pretty JSON output with indentation
 and newlines for better human readability.
 
+.TP
+.BR "\-t" , " \-\-timestamp"
+When used with the
+.B monitor
+object, print a
+.B Timestamp:
+line before each received notification, in the same format used by
+.BR "ip monitor" .
+
+.TP
+.B "\-\-tshort"
+Like
+.BR \-t ,
+but emits a more compact, ISO 8601 inline prefix
+.RB \(lq [ YYYY-MM-DD T HH:MM:SS . uuuuuu ] \(rq
+in front of each notification instead of a separate
+.B Timestamp:
+line.
+
 .SH DEVICE COMMANDS
 
 .SS dpll device show [ id ID ] [ module-name NAME ] [ clock-id ID ] [ type TYPE ] [ mode MODE ] [ lock-status STATUS ]
-- 
2.53.0


