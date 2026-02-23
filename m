Return-Path: <netdev+bounces-260086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH8NMAZznGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:32:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E14DB178C26
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA00230372D9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916D2F5321;
	Mon, 23 Feb 2026 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvcUDEp9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162082F3621;
	Mon, 23 Feb 2026 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860685; cv=none; b=m4OXXsYPNsCLeI+Db5ScceB2pyK4IdsygHdsavG/LOdDO6PyAQyGLkPvSYV9EOT6lY4+tJMPrnHiUGsiyqFGu+ZoFMqvPhVvEgc7vcHMOo98LH5gqxHb1vWRbapM86noOBXMyYHkXP6q+agjanjJD6Hyz09SLvbpHULQUJvQLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860685; c=relaxed/simple;
	bh=Ht0t75qRYANDA/1+A7psyigJet3N9S4aK9ekPlRMMsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uLSck1bS+DVxBzF+1TGtKwq9TT6/A+6JuB6lKq8+71ECYCaVy5bvsghdAh5GU3n+hesiskG8nw83Qb23+2hxtM6Ids8gj2Lx7J5GK8IGpe/A8Z6PbopRimqk6zmz1cHIzeyCjpZlkNJXiNy2O1Ov9E8sZdD3d97IKxrq+bv0xAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvcUDEp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0C3C116C6;
	Mon, 23 Feb 2026 15:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860684;
	bh=Ht0t75qRYANDA/1+A7psyigJet3N9S4aK9ekPlRMMsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FvcUDEp9nplL594VW7tBZtGhrrgE6quoEUBLVsndKdahNVVWjxUhx7JbkCE6GOQ+U
	 D85XztQC+6LvEZU6CA8XAZmOd1nQp0M1Oii4N5bIXd3STyLI5ujnkPd/qmeOUZhb5s
	 DCEgdwxx71NgOPAJXe1y0i9uE5JXE+o3Sw0rBrjOkzaVf33ISt0w4FrkxGg1KJzicL
	 YUpTaMQm9PVLTAfc9hg1NIqSWdaA7vpmFXEpjusX+KTNuKVnsMs8zEivNnUxskWn/8
	 UjwrahOe182dvwCqaEPIkH2Ji0ntHRzE2QZCCeqnow/ApmRdGAucT2qKMzJiehav+M
	 H760X4hRlRV3w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Feb 2026 16:28:40 +0100
Subject: [PATCH iproute2-next v2 3/3] mptcp: monitor: add JSON support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-ipr-monitor-json-v2-3-f91fccccf917@kernel.org>
References: <20260223-ipr-monitor-json-v2-0-f91fccccf917@kernel.org>
In-Reply-To: <20260223-ipr-monitor-json-v2-0-f91fccccf917@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6581; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ht0t75qRYANDA/1+A7psyigJet3N9S4aK9ekPlRMMsI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLnFB3PWfFJMu/Omvzfq6KurnlnydEgcWLjb+3idctYD
 kr7OWTyd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwk7AQjwxsPO6+XZTw5flOi
 eBP1A/wOBDs0zbwbeqiNz6Wv3POJNSPDnqBN6RPfdtkb+6b5LphzLiuvxvT4X7nDMv3Twh0DO26
 yAAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260086-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E14DB178C26
X-Rspamd-Action: no action

The command 'ip [-t[s]] mptcp monitor' now produces an output with the JSON
format.

The previous text output has been preserved.

The JSON support has been added thanks to the print_*() helpers. Note that
it is also needed to add a signal handler to exit without errors in case of
SIGINT or SIGTERM, and close the JSON. This last step will print the final
']' when stopping 'ip -j mptcp monitor'.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 - print token with print_0xhex(), and add missing space after ',' (AI)
 - use atexit() to close the JSON (Stephen)
 - always call delete_json_obj(): nothing is done when JSON is not used.
---
 ip/ipmptcp.c | 86 +++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 27 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 18ec05a8..3df89db5 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -2,6 +2,7 @@
 
 #include <arpa/inet.h>
 #include <netinet/in.h>
+#include <signal.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -476,8 +477,9 @@ static void print_addr(const char *key, int af, struct rtattr *value)
 	char str[INET6_ADDRSTRLEN];
 
 	if (inet_ntop(af, data, str, sizeof(str))) {
-		printf(" %s=", key);
-		color_fprintf(stdout, ifa_family_color(af), "%s", str);
+		print_string(PRINT_FP, NULL, " %s=", key);
+		print_color_string(PRINT_ANY, ifa_family_color(af), key, "%s",
+				   str);
 	}
 }
 
@@ -485,12 +487,13 @@ static void print_iface(int index)
 {
 	const char *ifname;
 
-	printf(" ifindex=%d", index);
+	print_int(PRINT_ANY, "ifindex", " ifindex=%d", index);
 
 	ifname = index ? ll_index_to_name(index) : NULL;
 	if (ifname) {
-		printf(" dev=");
-		color_fprintf(stdout, COLOR_IFNAME, "%s", ifname);
+		print_string(PRINT_FP, NULL, " dev=", NULL);
+		print_color_string(PRINT_ANY, COLOR_IFNAME, "dev", "%s",
+				   ifname);
 	}
 }
 
@@ -509,30 +512,34 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 	if (n->nlmsg_type != genl_family)
 		return 0;
 
+	open_json_object(NULL);
+
 	if (timestamp)
 		print_timestamp(stdout);
 
-	if (ghdr->cmd >= ARRAY_SIZE(event_to_str)) {
-		printf("[UNKNOWN %u]\n", ghdr->cmd);
+	if (ghdr->cmd >= ARRAY_SIZE(event_to_str) ||
+	    event_to_str[ghdr->cmd] == NULL) {
+		char event[40];
+
+		snprintf(event, sizeof(event), "UNKNOWN %u", ghdr->cmd);
+		print_string(PRINT_ANY, "event", "[%s]", event);
 		goto out;
 	}
 
-	if (event_to_str[ghdr->cmd] == NULL) {
-		printf("[UNKNOWN %u]\n", ghdr->cmd);
-		goto out;
-	}
-
-	printf("[%16s]", event_to_str[ghdr->cmd]);
+	print_string(PRINT_ANY, "event", "[%16s]", event_to_str[ghdr->cmd]);
 
 	parse_rtattr(tb, MPTCP_ATTR_MAX, (void *) ghdr + GENL_HDRLEN, len);
 
 	if (tb[MPTCP_ATTR_TOKEN])
-		printf(" token=%08x", rta_getattr_u32(tb[MPTCP_ATTR_TOKEN]));
+		print_0xhex(PRINT_ANY, "token", " token=%08x",
+			    rta_getattr_u32(tb[MPTCP_ATTR_TOKEN]));
 
 	if (tb[MPTCP_ATTR_REM_ID])
-		printf(" remid=%u", rta_getattr_u8(tb[MPTCP_ATTR_REM_ID]));
+		print_uint(PRINT_ANY, "remid", " remid=%u",
+			   rta_getattr_u8(tb[MPTCP_ATTR_REM_ID]));
 	if (tb[MPTCP_ATTR_LOC_ID])
-		printf(" locid=%u", rta_getattr_u8(tb[MPTCP_ATTR_LOC_ID]));
+		print_uint(PRINT_ANY, "locid", " locid=%u",
+			   rta_getattr_u8(tb[MPTCP_ATTR_LOC_ID]));
 
 	if (tb[MPTCP_ATTR_SADDR4])
 		print_addr("saddr4", AF_INET, tb[MPTCP_ATTR_SADDR4]);
@@ -543,49 +550,74 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 	if (tb[MPTCP_ATTR_DADDR6])
 		print_addr("daddr6", AF_INET6, tb[MPTCP_ATTR_DADDR6]);
 	if (tb[MPTCP_ATTR_SPORT])
-		printf(" sport=%u", rta_getattr_be16(tb[MPTCP_ATTR_SPORT]));
+		print_uint(PRINT_ANY, "sport", " sport=%u",
+			   rta_getattr_be16(tb[MPTCP_ATTR_SPORT]));
 	if (tb[MPTCP_ATTR_DPORT])
-		printf(" dport=%u", rta_getattr_be16(tb[MPTCP_ATTR_DPORT]));
+		print_uint(PRINT_ANY, "dport", " dport=%u",
+			   rta_getattr_be16(tb[MPTCP_ATTR_DPORT]));
 	if (tb[MPTCP_ATTR_BACKUP])
-		printf(" backup=%u", rta_getattr_u8(tb[MPTCP_ATTR_BACKUP]));
+		print_uint(PRINT_ANY, "backup", " backup=%u",
+			   rta_getattr_u8(tb[MPTCP_ATTR_BACKUP]));
 	if (tb[MPTCP_ATTR_ERROR])
-		printf(" error=%u", rta_getattr_u8(tb[MPTCP_ATTR_ERROR]));
+		print_uint(PRINT_ANY, "error", " error=%u",
+			   rta_getattr_u8(tb[MPTCP_ATTR_ERROR]));
 	if (tb[MPTCP_ATTR_TIMEOUT])
-		printf(" timeout=%u", rta_getattr_u32(tb[MPTCP_ATTR_TIMEOUT]));
+		print_uint(PRINT_ANY, "timeout", " timeout=%u",
+			   rta_getattr_u32(tb[MPTCP_ATTR_TIMEOUT]));
 	if (tb[MPTCP_ATTR_IF_IDX])
 		print_iface(rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
 	if (tb[MPTCP_ATTR_RESET_REASON])
-		printf(" reset_reason=%u", rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
+		print_uint(PRINT_ANY, "reset_reason", " reset_reason=%u",
+			   rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
 	if (tb[MPTCP_ATTR_RESET_FLAGS])
-		printf(" reset_flags=0x%x", rta_getattr_u32(tb[MPTCP_ATTR_RESET_FLAGS]));
+		print_0xhex(PRINT_ANY, "reset_flags", " reset_flags=%#x",
+			    rta_getattr_u32(tb[MPTCP_ATTR_RESET_FLAGS]));
 
 	if (tb[MPTCP_ATTR_FLAGS])
 		flags = rta_getattr_u16(tb[MPTCP_ATTR_FLAGS]);
 	if ((flags & MPTCP_PM_EV_FLAG_SERVER_SIDE) ||
 	    (tb[MPTCP_ATTR_SERVER_SIDE] && rta_getattr_u8(tb[MPTCP_ATTR_SERVER_SIDE]))) {
 		flags &= ~MPTCP_PM_EV_FLAG_SERVER_SIDE;
-		printf(" server_side");
+		print_string(PRINT_FP, NULL, " server_side", NULL);
+		print_bool(PRINT_JSON, "server_side", NULL, true);
 	}
 	if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0) {
 		flags &= ~MPTCP_PM_EV_FLAG_DENY_JOIN_ID0;
-		printf(" deny_join_id0");
+		print_string(PRINT_FP, NULL, " deny_join_id0", NULL);
+		print_bool(PRINT_JSON, "deny_join_id0", NULL, true);
 	}
 	if (flags) /* remaining bits */
-		printf(" flags=0x%x", flags);
+		print_0xhex(PRINT_ANY, "flags", " flags=%#x", flags);
 
-	puts("");
 out:
+	print_nl();
+	close_json_object();
 	fflush(stdout);
+
 	return 0;
 }
 
+static void sig_exit(int signo)
+{
+	exit(0);
+}
+
 static int mptcp_monitor(void)
 {
+	struct sigaction sa = { .sa_handler = sig_exit,
+				.sa_flags = SA_RESTART };
+
 	if (genl_add_mcast_grp(&genl_rth, genl_family, MPTCP_PM_EV_GRP_NAME) < 0) {
 		perror("can't subscribe to mptcp events");
 		return 1;
 	}
 
+	new_json_obj(json);
+	atexit(delete_json_obj);
+
+	sigaction(SIGINT, &sa, NULL);
+	sigaction(SIGTERM, &sa, NULL);
+
 	if (rtnl_listen(&genl_rth, mptcp_monitor_msg, stdout) < 0)
 		return 2;
 

-- 
2.51.0


