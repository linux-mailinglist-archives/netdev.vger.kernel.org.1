Return-Path: <netdev+bounces-299122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +CtgHeIGLmqLogQAu9opvQ
	(envelope-from <netdev+bounces-299122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:41:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8060B680318
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:41:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Iqos+tAi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299122-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299122-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDC2D30028C1
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989562EEE86;
	Sun, 14 Jun 2026 01:41:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A862DF13E;
	Sun, 14 Jun 2026 01:41:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401275; cv=none; b=t6HzK8cC4MZ5WGp7djCm+fnXGRRilW6XeHmdMmMsv2jhysw+2HIOP95q+anjlUsxXGBUiEE0QeVvJ2QNBfx7s8zo3pigCd+oGpkJ/bopTpyxEmp7wBMLyq87cf5pznmuMz8eQrB3T5YmLanmtsmX+TBqVnKXOOQ8DvWTa5YPnFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401275; c=relaxed/simple;
	bh=ISa/DXzSgeGIvrWJ+HZnkPQr03s2ycoDfKQPzEkcu+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaHl8R9v6ZEPLI6mj7mnIiWVH4vfDa0wN70sUAtsdWVUzHtSootqxIM58Ac7bjKsjmDq1XKftkXZSb2X+95H4ieom/ExYQ1JMLFHXP842oWMNTqXlfD7ynbaVaGngGGBbKfPWDJEdaDq1rW8XooHbWzIR6RD8Rm/YV7f1Y4yYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iqos+tAi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0BD1F00AC4;
	Sun, 14 Jun 2026 01:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401274;
	bh=rYmuOmNLYOY4fdz1dN9kugcvBM9uiz/C0xCi+CMr1lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iqos+tAiL9Nd7npO8B9H4TmFwZaJ9Ct2dXUtEYGCyM98pX3n3ReTTcqt8GW1rlYAQ
	 06e146EQMSkF/GIRSRQKetd2Ncwv1AY/hFNl/OR+MqbBuff676usB9L5jUnHTtVY5C
	 ZL+PLvBODfmFXD8vmWaNLj3u5Ub+FBzHKVLb8821zqsgze4T23bxiqifYt0aStvWlG
	 4P1ZC0pvSWrd2tGJss0+1Atv1XjwcZJgW92h4a2AXQ503Oe4dcDi1qKzFllRCPSmr8
	 VGinFeX7enP2btV6LhTMah7+KRt3Tf+kITG+gFHPdIpW1r7RN/Qa0qUR9E4JSzwZPj
	 peDnTjAekt+OQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] selftests/bpf: test that TLS crypto is rejected on a sockmap socket
Date: Sat, 13 Jun 2026 18:41:00 -0700
Message-ID: <20260614014102.461064-6-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614014102.461064-1-kuba@kernel.org>
References: <20260614014102.461064-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,cloudflare.com,gmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-299122-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kuba@kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8060B680318

TLS and sockmap are mutually exclusive. We already have a test
for the sockmap side rejecting kTLS, add the inverse test matching
patch 1 of this series.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index cda6b22cf759..34737e8df6ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -116,6 +116,68 @@ static void test_sockmap_ktls_update_fails_when_sock_has_ulp(int family, int map
 	close(s);
 }
 
+static void test_sockmap_ktls_enable_fails_when_in_sockmap(int family, int map)
+{
+	struct tls12_crypto_info_aes_gcm_128 crypto = {
+		.info = {
+			.version     = TLS_1_2_VERSION,
+			.cipher_type = TLS_CIPHER_AES_GCM_128,
+		},
+	};
+	struct sockaddr_storage addr = {};
+	socklen_t len = sizeof(addr);
+	struct sockaddr_in6 *v6;
+	struct sockaddr_in *v4;
+	int err, s, zero = 0;
+
+	switch (family) {
+	case AF_INET:
+		v4 = (struct sockaddr_in *)&addr;
+		v4->sin_family = AF_INET;
+		break;
+	case AF_INET6:
+		v6 = (struct sockaddr_in6 *)&addr;
+		v6->sin6_family = AF_INET6;
+		break;
+	default:
+		PRINT_FAIL("unsupported socket family %d", family);
+		return;
+	}
+
+	s = socket(family, SOCK_STREAM, 0);
+	if (!ASSERT_GE(s, 0, "socket"))
+		return;
+
+	err = bind(s, (struct sockaddr *)&addr, len);
+	if (!ASSERT_OK(err, "bind"))
+		goto close;
+
+	err = getsockname(s, (struct sockaddr *)&addr, &len);
+	if (!ASSERT_OK(err, "getsockname"))
+		goto close;
+
+	err = connect(s, (struct sockaddr *)&addr, len);
+	if (!ASSERT_OK(err, "connect"))
+		goto close;
+
+	/* Add the socket to the sockmap, attaching a psock. */
+	err = bpf_map_update_elem(map, &zero, &s, BPF_ANY);
+	if (!ASSERT_OK(err, "sockmap update elem"))
+		goto close;
+
+	/* Installing the TLS ULP is allowed, it does not touch the datapath. */
+	err = setsockopt(s, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
+	if (!ASSERT_OK(err, "setsockopt(TCP_ULP)"))
+		goto close;
+
+	/* Enabling the TLS crypto datapath must be rejected. */
+	err = setsockopt(s, SOL_TLS, TLS_TX, &crypto, sizeof(crypto));
+	ASSERT_ERR(err, "setsockopt(TLS_TX)");
+
+close:
+	close(s);
+}
+
 static const char *fmt_test_name(const char *subtest_name, int family,
 				 enum bpf_map_type map_type)
 {
@@ -170,6 +232,9 @@ static void run_tests(int family, enum bpf_map_type map_type)
 	if (test__start_subtest(fmt_test_name("update_fails_when_sock_has_ulp", family, map_type)))
 		test_sockmap_ktls_update_fails_when_sock_has_ulp(family, map);
 
+	if (test__start_subtest(fmt_test_name("enable_fails_when_in_sockmap", family, map_type)))
+		test_sockmap_ktls_enable_fails_when_in_sockmap(family, map);
+
 	close(map);
 }
 
-- 
2.54.0


