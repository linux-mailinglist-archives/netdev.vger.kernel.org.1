Return-Path: <netdev+bounces-260085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI5JJ1hznGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:33:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B62178C4B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD47B308A51D
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078102EDD7D;
	Mon, 23 Feb 2026 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr1Bx+YA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98352EDD45;
	Mon, 23 Feb 2026 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860683; cv=none; b=DfiJkp1vPDuCIB1jUvgl86p3Za9xB/fM8G/E156NjCpdWPJ/DgNh4DGH/i1wz3acPupZbFahgF9sqD86vWowGJpXF/M1uyRi/OuyypD5lFnp4+g6umJ/0bR1PEpqDNgLsq/FCJxFnO7fwSBPbSHvjoSp/VZeYRGCi8G/WP/riAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860683; c=relaxed/simple;
	bh=Dweq7oqtgV5vV7+Nk9lIGffgPM0V6SHAR+/STKKhKtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/Z5EwQkkMmU87IRk0swzhmOrO0fVp8K4ye1EhyrqXiGWqelSVPTNLfSwAgTnd9Ivq5b3Zan24dneFTSy5hHin3xh1Ise9el9PkKRygH2MQZZu1wD1TsnKWYRkuGEtX3vKqbTabSR5Cp57YZRqM4PPhlRL4PrDYDEY8wfNDxAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr1Bx+YA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC44C19423;
	Mon, 23 Feb 2026 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860683;
	bh=Dweq7oqtgV5vV7+Nk9lIGffgPM0V6SHAR+/STKKhKtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lr1Bx+YA/mLGpWK9i1+lMlKfCmdsGpaW6StW6iWN021zkTDatH6HLTnxBWOLIFf2i
	 eVEIicffRptiEyYY/pQk/dB/Ts5KfrrmcfW6bqkHRAq9zAhL1tgOkR4RdmXyTUTljq
	 /k901WJ/6qkFZO9c1vOvE7FWR171DS5ccb/Q+U+Z+I21m5N7O3T0FrpN4toJObCcin
	 UTT3CEufeb0zC4KR3UvAl/0wj5BYEn8wMoUraIXSLr0qXGR58ZNkU/JNM5a4dxw8GJ
	 kqL+Kba3X2Ka3yWU8Fe33sWS1wM6YuIDaK0wJwDDXXkcQKRRqyarkhnqMzhOGgn30A
	 M3SHglLyNvQIQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Feb 2026 16:28:39 +0100
Subject: [PATCH iproute2-next v2 2/3] utils: timestamp: add JSON support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-ipr-monitor-json-v2-2-f91fccccf917@kernel.org>
References: <20260223-ipr-monitor-json-v2-0-f91fccccf917@kernel.org>
In-Reply-To: <20260223-ipr-monitor-json-v2-0-f91fccccf917@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1652; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Dweq7oqtgV5vV7+Nk9lIGffgPM0V6SHAR+/STKKhKtU=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGmccsejWdm87T3yB8ZgmVTPJrzXj9IvS2d+K3zeRMoG7YWJj
 4h1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmmccscACgkQfCLwwvNHCperpgD9E8nf
 jeUOoIdIzMc6YljYLJlp9TYXo7znMstVuO6X7kIBAMZYD96Ijewz3OqwZnDOgEYyIlf2WcRQNvP
 UJLcBUQIF
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260085-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 54B62178C4B
X-Rspamd-Action: no action

Supporting JSON is easy with the helpers. The biggest modification is to
extract the end value. Different keys are used depending on the short or
long timestamp option being used, to ease the parsing.

No behavioural changes intended for the moment, this is a preparation for a
future usage of print_timestamp() within a JSON context.

Like in other helpers supporting JSON, the output stream 'fp' is ignored,
which is fine, because it is always set to 'stdout'.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: ignore 'fp' which is always set to 'stdout' (Stephen)
---
 lib/utils.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/utils.c b/lib/utils.c
index 13e8c098..1215fe31 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1277,21 +1277,23 @@ int print_timestamp(FILE *fp)
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
+		print_string(PRINT_ANY, "timestamp_short", "[%s] ", ts);
 	} else {
 		char *tstr = asctime(tm);
 
 		tstr[strlen(tstr)-1] = 0;
-		fprintf(fp, "Timestamp: %s %ld usec\n",
-			tstr, tv.tv_usec);
+		snprintf(ts, sizeof(ts), "%s %ld usec", tstr, tv.tv_usec);
+		print_string(PRINT_ANY, "timestamp", "Timestamp: %s\n", ts);
 	}
 
 	return 0;

-- 
2.51.0


