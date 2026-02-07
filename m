Return-Path: <netdev+bounces-257666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAQvA+OIhmmOOgQAu9opvQ
	(envelope-from <netdev+bounces-257666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:35:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACCB104507
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AAB1302BE03
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 00:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7F221D5AF;
	Sat,  7 Feb 2026 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNFMxypA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0F21ABD7;
	Sat,  7 Feb 2026 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424517; cv=none; b=IcTZzEHgmbLbABvVLCjpbqGFXWU3Mon0T7dF/rw4o8jBuSw+ItulI6tJ0I0G+LtrpdMitpDLXImTHUE1HO9epTx9tZ2blLaxtGmE8tvyCk/Gk2R0bg19qrBYYzUSfkkFAlPGONi0rNALlvtJ/PKFpfCmfxy/+3HVY/cclUvdtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424517; c=relaxed/simple;
	bh=bRY2BHHqZekiUXzi9An4H1EIwUlBR0yf3lMGwHx+Qas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlIR+DwCEap0XIU8h1+v1KWLXVWdAMZWU4g6s1RDfK8DTw8TC4B1MQvy0rW7/WkCZBdbXYwlV/roZxTlWQn3kRgQsMuTfsP0jBFtnw2RMWzKFcvYmUJCLxA1/FRP5+DhJafwaX0UOgwREzyMlYN/uwydRKU1Dgcntcx5NB4bbr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNFMxypA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B18EC116C6;
	Sat,  7 Feb 2026 00:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770424517;
	bh=bRY2BHHqZekiUXzi9An4H1EIwUlBR0yf3lMGwHx+Qas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNFMxypAN2GaUHbqB7vQOTAdB0RbCa6PZbucwT7YGHP3NfFfHsnLeQrsnawyQY6Ut
	 I+6v0bh/8WXl4nBBaNwJAj9h7BX2eB8/KXF2PdjLcxI6bbI18Xov5fOTh61StIsZHT
	 yO7ci0spf/XS9M3198r4qOl1WfjwxnhDFRbgtP1Z+JDRJYSeOLt2si5Fg+FuntEEAj
	 to/uJ9Dyq+2GM0etbtLljlZHlRZGN0KcVB4V+0thx8D9eBns6mKgoevhPYlXo5+1w2
	 xD26cyZXkIH8G4f2otB/UJrHs6RPwXHiMg89sopFO/tk0Bx57oyW+g2pXj4apkQ4DL
	 yYUrpNMvBLNsg==
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
Subject: [PATCH net-next v2 2/9] tools: ynltool: factor out qstat dumping
Date: Fri,  6 Feb 2026 16:35:02 -0800
Message-ID: <20260207003509.3927744-3-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-257666-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7ACCB104507
X-Rspamd-Action: no action

The logic to open a socket and dump the queues is the same
across sub-commands. Factor it out, we'll need it again.

No functional changes intended.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynltool/qstats.c | 95 +++++++++++++++-------------------
 1 file changed, 41 insertions(+), 54 deletions(-)

diff --git a/tools/net/ynl/ynltool/qstats.c b/tools/net/ynl/ynltool/qstats.c
index 31fb45709ffa..d19acab0bf2a 100644
--- a/tools/net/ynl/ynltool/qstats.c
+++ b/tools/net/ynl/ynltool/qstats.c
@@ -237,13 +237,47 @@ static void print_plain_qstats(struct netdev_qstats_get_list *qstats)
 	}
 }
 
-static int do_show(int argc, char **argv)
+static struct netdev_qstats_get_list *
+qstats_dump(enum netdev_qstats_scope scope)
 {
 	struct netdev_qstats_get_list *qstats;
 	struct netdev_qstats_get_req *req;
 	struct ynl_error yerr;
 	struct ynl_sock *ys;
-	int ret = 0;
+
+	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	if (!ys) {
+		p_err("YNL: %s", yerr.msg);
+		return NULL;
+	}
+
+	req = netdev_qstats_get_req_alloc();
+	if (!req) {
+		p_err("failed to allocate qstats request");
+		goto err_close;
+	}
+
+	if (scope)
+		netdev_qstats_get_req_set_scope(req, scope);
+
+	qstats = netdev_qstats_get_dump(ys, req);
+	netdev_qstats_get_req_free(req);
+	if (!qstats) {
+		p_err("failed to get queue stats: %s", ys->err.msg);
+		goto err_close;
+	}
+
+	ynl_sock_destroy(ys);
+	return qstats;
+
+err_close:
+	ynl_sock_destroy(ys);
+	return NULL;
+}
+
+static int do_show(int argc, char **argv)
+{
+	struct netdev_qstats_get_list *qstats;
 
 	/* Parse options */
 	while (argc > 0) {
@@ -268,29 +302,9 @@ static int do_show(int argc, char **argv)
 		}
 	}
 
-	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
-	if (!ys) {
-		p_err("YNL: %s", yerr.msg);
+	qstats = qstats_dump(scope);
+	if (!qstats)
 		return -1;
-	}
-
-	req = netdev_qstats_get_req_alloc();
-	if (!req) {
-		p_err("failed to allocate qstats request");
-		ret = -1;
-		goto exit_close;
-	}
-
-	if (scope)
-		netdev_qstats_get_req_set_scope(req, scope);
-
-	qstats = netdev_qstats_get_dump(ys, req);
-	netdev_qstats_get_req_free(req);
-	if (!qstats) {
-		p_err("failed to get queue stats: %s", ys->err.msg);
-		ret = -1;
-		goto exit_close;
-	}
 
 	/* Print the stats as returned by the kernel */
 	if (json_output)
@@ -299,9 +313,7 @@ static int do_show(int argc, char **argv)
 		print_plain_qstats(qstats);
 
 	netdev_qstats_get_list_free(qstats);
-exit_close:
-	ynl_sock_destroy(ys);
-	return ret;
+	return 0;
 }
 
 static void compute_stats(__u64 *values, unsigned int count,
@@ -406,10 +418,7 @@ static int cmp_ifindex_type(const void *a, const void *b)
 static int do_balance(int argc, char **argv __attribute__((unused)))
 {
 	struct netdev_qstats_get_list *qstats;
-	struct netdev_qstats_get_req *req;
 	struct netdev_qstats_get_rsp **sorted;
-	struct ynl_error yerr;
-	struct ynl_sock *ys;
 	unsigned int count = 0;
 	unsigned int i, j;
 	int ret = 0;
@@ -419,29 +428,9 @@ static int do_balance(int argc, char **argv __attribute__((unused)))
 		return -1;
 	}
 
-	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
-	if (!ys) {
-		p_err("YNL: %s", yerr.msg);
+	qstats = qstats_dump(NETDEV_QSTATS_SCOPE_QUEUE);
+	if (!qstats)
 		return -1;
-	}
-
-	req = netdev_qstats_get_req_alloc();
-	if (!req) {
-		p_err("failed to allocate qstats request");
-		ret = -1;
-		goto exit_close;
-	}
-
-	/* Always use queue scope for balance analysis */
-	netdev_qstats_get_req_set_scope(req, NETDEV_QSTATS_SCOPE_QUEUE);
-
-	qstats = netdev_qstats_get_dump(ys, req);
-	netdev_qstats_get_req_free(req);
-	if (!qstats) {
-		p_err("failed to get queue stats: %s", ys->err.msg);
-		ret = -1;
-		goto exit_close;
-	}
 
 	/* Count and sort queues */
 	ynl_dump_foreach(qstats, qs)
@@ -576,8 +565,6 @@ static int do_balance(int argc, char **argv __attribute__((unused)))
 	free(sorted);
 exit_free_qstats:
 	netdev_qstats_get_list_free(qstats);
-exit_close:
-	ynl_sock_destroy(ys);
 	return ret;
 }
 
-- 
2.53.0


