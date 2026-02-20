Return-Path: <netdev+bounces-259758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHgfGvKtmGl4KwMAu9opvQ
	(envelope-from <netdev+bounces-259758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:54:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E7D16A332
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCEDE30333D0
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78413366DC0;
	Fri, 20 Feb 2026 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElPgYIf0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A4C366DBE;
	Fri, 20 Feb 2026 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613658; cv=none; b=ZC6FzCi5gw2lSVscav9+qJIP9DNfWKGE0VLMo7jc66ggmlyzRnG5eUlAp7eoQ3KQUpAN/Nfals4671++Pwv5rxfsLKrtMsi0HN3I+yd3A9joBEc4i+bPqZHgFxmf13AI/EvrpmYIPH+JqmivbubKfw16/dsir3IaaLVNRM1TZv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613658; c=relaxed/simple;
	bh=9ND4Te+vCD8kxlRnTEnyhPCkkUOH5B3APGIVy4z0UiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3z1Zsygwc8TWjiWtVvB/xYiMApDFk4mQjDbCiXwcOKvNf7Je7n82MTuoncVsiX6JrIKhC82MFSW15sMQaQNIHMl5qvGjDRKhs1+Nn+9V4zxg29Jobf1WnrTviqGL3LkBLODeOf5UXE7m1mFmmRTZsyQ/GJnrYWFxYFPaRpiDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElPgYIf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD7BC116C6;
	Fri, 20 Feb 2026 18:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771613658;
	bh=9ND4Te+vCD8kxlRnTEnyhPCkkUOH5B3APGIVy4z0UiM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ElPgYIf0zwKggKMPLF1/mu25RlHvSTsWcDMXFFnTL8YRyZqmWMeIaF4tf7NC4lWNc
	 r9oC88bK6dZVmF/ewy28ZcRk+gX61l5k1spX9q9nG3+rKRoeBDxNc31z9mF41pBKJa
	 2P7M8WBb69DjPV2S0DpHZM7QT8i4L+IAQvrxJ6PQyAkW1NiIV4idu3K7Pxjds6KvhQ
	 QqpzWav3z0jpjGmeQdncd3afQDU61yAY8ITlAgzounPaipdvAQFdJeAH1YEqs7UsR/
	 5V532GYpdFjwYiNgLMQxCqdUl3wRj4Pg0JXrB3g0+e4GBH2WpxzhZAM/XEid/ZZqGY
	 EHJNukc71nRfw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 20 Feb 2026 19:54:02 +0100
Subject: [PATCH iproute2-next 2/3] utils: timestamp: add JSON support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-ipr-monitor-json-v1-2-eb4b0d5f7820@kernel.org>
References: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
In-Reply-To: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9ND4Te+vCD8kxlRnTEnyhPCkkUOH5B3APGIVy4z0UiM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJnrL1aNlHkRPy2eSs4bksaaYXnFU+1v3Nr8rz01G2ez
 /bHPGGu7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIu2MMv1m8zDyu71ketrdN
 zGb/hleXpi6dWb9A8tWz9uwf5rM4WkMYfrMzNpgvj/KqFH7I/v7C/KIJNUsz9JJW7wxysQ8Lexe
 zkB8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259758-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45E7D16A332
X-Rspamd-Action: no action

Only if the output stream is 'stdout', because all JSON helpers like
print_string() only write on 'stdout'.

Supporting JSON is easy with the helpers. The biggest modification is to
extract the end value.

No behavioural changes intended for the moment, this is a preparation for a
future usage of print_timestamp() within a JSON context.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 lib/utils.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/lib/utils.c b/lib/utils.c
index 13e8c098..d7581709 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1277,21 +1277,30 @@ int print_timestamp(FILE *fp)
 {
 	struct timeval tv;
 	struct tm *tm;
+	char ts[40];
 
 	gettimeofday(&tv, NULL);
 	tm = localtime(&tv.tv_sec);
 
 	if (timestamp_short) {
-		char tshort[40];
+		size_t len;
 
-		strftime(tshort, sizeof(tshort), "%Y-%m-%dT%H:%M:%S", tm);
-		fprintf(fp, "[%s.%06ld] ", tshort, tv.tv_usec);
+		len = strftime(ts, sizeof(ts), "%Y-%m-%dT%H:%M:%S", tm);
+		snprintf(ts + len, sizeof(ts) - len, ".%06ld", tv.tv_usec);
+		if (fp == stdout)
+			print_string(PRINT_ANY, "timestamp_short", "[%s] ", ts);
+		else
+			fprintf(fp, "[%s] ", ts);
 	} else {
 		char *tstr = asctime(tm);
 
 		tstr[strlen(tstr)-1] = 0;
-		fprintf(fp, "Timestamp: %s %ld usec\n",
-			tstr, tv.tv_usec);
+		snprintf(ts, sizeof(ts), "%s %ld usec", tstr, tv.tv_usec);
+		if (fp == stdout)
+			print_string(PRINT_ANY, "timestamp",
+				     "Timestamp: %s\n", ts);
+		else
+			fprintf(fp, "Timestamp: %s\n", ts);
 	}
 
 	return 0;

-- 
2.51.0


