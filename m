Return-Path: <netdev+bounces-257667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ3+GvSIhmmNOgQAu9opvQ
	(envelope-from <netdev+bounces-257667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:36:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B0B104535
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31BB630500FE
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 00:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8633F225390;
	Sat,  7 Feb 2026 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENpFDFSz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A952236FA;
	Sat,  7 Feb 2026 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424518; cv=none; b=CRGsoN6MYjn/RRaOpXIcBelFCj6SArHxmI8SLVTN1jxn3RXGdjKzgXU8d/uN++PljDHf9XW/6l8td7ty2NwbfPQlN/I3ZX0D7wFRcjGO4811UTgsa7w0BPVq1GgKayvpNayMzRWYFd0pn3CpzSopaGKgk5uWtgA/EegCPRS+Tf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424518; c=relaxed/simple;
	bh=pXz9WzBNXTn+31EkTBeAmI67/47Z3TMxUfgQzPA4j+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbYAY0o3wjaUIHbplzCErSwWSt0Bo2IgeCuVIK382ojvJbtBXkdYCENj4oRsM5xYQb1ZFxyyxnHDk/1qytFRmQkYpqmBxGLZPPR0R1ZWGluK91UuhLx79gQ7PZm46XuG/mCbcakSK6qQzyc0KU7ydPFETDDslbuZWNjQDHI9RSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENpFDFSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F082C19424;
	Sat,  7 Feb 2026 00:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770424518;
	bh=pXz9WzBNXTn+31EkTBeAmI67/47Z3TMxUfgQzPA4j+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENpFDFSzSQVQL77qH3rR5KtpFwsCKL8WEEv362fcaQQU5dhOABfRel00KYqRiSp92
	 /i14C48CJHDdGRtshl/fN9+Ffl4r1XyGT0EK0UnDOIVGcIKmp/mHf2/JTk3GS7hJXh
	 6koiaRdlppTNP02RtFsEC0iOz87r0hD/OsrE3X5Wj+62OSuARw701hnp+qr4q7vjze
	 BS4WCJWt8oG+GowCAUm6D3rJqx3zdD638wUjYe+qmba8tQuHMwzqS3jrei4XRP7z3B
	 hWtdrJ7q2GA7uitKfiLUL2psZT/Vx81aSQjKdld+4RIu4oPdxLVO33GIiiIA8nCw9A
	 ffJpRD0ulJt1w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/9] tools: ynltool: add qstats analysis for HW-GRO efficiency / savings
Date: Fri,  6 Feb 2026 16:35:03 -0800
Message-ID: <20260207003509.3927744-4-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260207003509.3927744-1-kuba@kernel.org>
References: <20260207003509.3927744-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257667-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3B0B104535
X-Rspamd-Action: no action

Extend ynltool to compute HW GRO savings metric - how many
packets has HW GRO been able to save the kernel from seeing.

Note that this definition does not actually take into account
whether the segments were or weren't eligible for HW GRO.
If a machine is receiving all-UDP traffic - new metric will show
HW-GRO savings of 0%. Conversely since the super-packet still
counts as a received packet, savings of 100% is not achievable.
Perfect HW-GRO on a machine with 4k MTU and 64kB super-frames
would show ~93.75% savings. With 1.5k MTU we may see up to
~97.8% savings (if my math is right).

Example after 10 sec of iperf on a freshly booted machine
with 1.5k MTU:

  $ ynltool qstats show
  eth0     rx-packets:  40681280               rx-bytes:   61575208437
        rx-alloc-fail:         0      rx-hw-gro-packets:       1225133
                                 rx-hw-gro-wire-packets:      40656633
  $ ynltool qstats hw-gro
  eth0: 96.9% savings

None of the NICs I have access to can report "missed" HW-GRO
opportunities so computing a true "effectiveness" metric
is not possible. One could also argue that effectiveness metric
is inferior in environments where we control both senders and
receivers, the savings metrics will capture both regressions
in receiver's HW GRO effectiveness but also regressions in senders
sending smaller TSO trains. And we care about both. The main
downside is that it's hard to tell at a glance how well the NIC
is doing because the savings will be dependent on traffic patterns.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use %1$s
v1: https://lore.kernel.org/20260205220541.2992807-4-kuba@kernel.org
---
 tools/net/ynl/ynltool/qstats.c | 76 +++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/ynltool/qstats.c b/tools/net/ynl/ynltool/qstats.c
index d19acab0bf2a..a6c28ba4f25c 100644
--- a/tools/net/ynl/ynltool/qstats.c
+++ b/tools/net/ynl/ynltool/qstats.c
@@ -568,6 +568,65 @@ static int do_balance(int argc, char **argv __attribute__((unused)))
 	return ret;
 }
 
+static int do_hw_gro(int argc, char **argv __attribute__((unused)))
+{
+	struct netdev_qstats_get_list *qstats;
+
+	if (argc > 0) {
+		p_err("hw-gro command takes no arguments");
+		return -1;
+	}
+
+	qstats = qstats_dump(0);
+	if (!qstats)
+		return -1;
+
+	if (json_output)
+		jsonw_start_array(json_wtr);
+
+	ynl_dump_foreach(qstats, qs) {
+		char ifname[IF_NAMESIZE];
+		const char *name;
+		double savings;
+
+		if (!qs->_present.rx_packets ||
+		    !qs->_present.rx_hw_gro_packets ||
+		    !qs->_present.rx_hw_gro_wire_packets)
+			continue;
+
+		if (!qs->rx_packets)
+			continue;
+
+		/* How many skbs did we avoid allocating thanks to HW GRO */
+		savings = (double)(qs->rx_hw_gro_wire_packets -
+				   qs->rx_hw_gro_packets) /
+			qs->rx_packets * 100.0;
+
+		name = if_indextoname(qs->ifindex, ifname);
+
+		if (json_output) {
+			jsonw_start_object(json_wtr);
+			jsonw_uint_field(json_wtr, "ifindex", qs->ifindex);
+			if (name)
+				jsonw_string_field(json_wtr, "ifname", name);
+			jsonw_float_field(json_wtr, "savings", savings);
+			jsonw_end_object(json_wtr);
+		} else {
+			if (name)
+				printf("%s", name);
+			else
+				printf("ifindex:%u", qs->ifindex);
+			printf(": %.1f%% savings\n", savings);
+		}
+	}
+
+	if (json_output)
+		jsonw_end_array(json_wtr);
+
+	netdev_qstats_get_list_free(qstats);
+	return 0;
+}
+
 static int do_help(int argc __attribute__((unused)),
 		   char **argv __attribute__((unused)))
 {
@@ -577,9 +636,10 @@ static int do_help(int argc __attribute__((unused)),
 	}
 
 	fprintf(stderr,
-		"Usage: %s qstats { COMMAND | help }\n"
-		"       %s qstats [ show ] [ OPTIONS ]\n"
-		"       %s qstats balance\n"
+		"Usage: %1$s qstats { COMMAND | help }\n"
+		"       %1$s qstats [ show ] [ OPTIONS ]\n"
+		"       %1$s qstats balance\n"
+		"       %1$s qstats hw-gro\n"
 		"\n"
 		"       OPTIONS := { scope queue | group-by { device | queue } }\n"
 		"\n"
@@ -588,9 +648,14 @@ static int do_help(int argc __attribute__((unused)),
 		"       show scope queue      - Display per-queue statistics\n"
 		"       show group-by device  - Display device-aggregated statistics (default)\n"
 		"       show group-by queue   - Display per-queue statistics\n"
-		"       balance               - Analyze traffic distribution balance.\n"
+		"\n"
+		"  Analysis:\n"
+		"       balance               - Traffic distribution between queues.\n"
+		"       hw-gro                - HW GRO effectiveness analysis\n"
+		"                               - savings - delta between packets received\n"
+		"                                 on the wire and packets seen by the kernel.\n"
 		"",
-		bin_name, bin_name, bin_name);
+		bin_name);
 
 	return 0;
 }
@@ -598,6 +663,7 @@ static int do_help(int argc __attribute__((unused)),
 static const struct cmd qstats_cmds[] = {
 	{ "show",	do_show },
 	{ "balance",	do_balance },
+	{ "hw-gro",	do_hw_gro },
 	{ "help",	do_help },
 	{ 0 }
 };
-- 
2.53.0


