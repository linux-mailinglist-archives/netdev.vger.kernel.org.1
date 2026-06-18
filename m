Return-Path: <netdev+bounces-300399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xme4FHrIM2rpGAYAu9opvQ
	(envelope-from <netdev+bounces-300399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:29:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5193569F521
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:29:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="o/Q4TwDN";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300399-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300399-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 495CF3041B3E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996193E9580;
	Thu, 18 Jun 2026 10:27:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F243ECBD9
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:27:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778466; cv=none; b=Wfy7UONKxSfvxTpGhsqlNO/kwxjDptnOS1cGAsuJguLFaW2ybZCZH42d1qSzK7lc8Ys+Q5CoMkPjS+dcxYgb3YPaDZj+rspqNqB1vKQsobccMByrwIUk7H9yjRXf0BbA7OaoPcWhVpTJD0OtsWSrYCd1ttku9LKR2loSg3WLtVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778466; c=relaxed/simple;
	bh=YS0u1EKD53vo2t6W+IEib8k/HgYIgbkb0atxBhbXQmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dq/796jv9frvqf9OnYUKWRuhGQ9yQFzJAdFdXURApZLqevcKqTntRITbk7vGT7Ck1DCVsU0PZ2qgG2rNb7zNPvqKzpPvO9mF4JHlrYsBf/NtgKCb0B3TlDDch6OREUW8h6/NAyGci1Aq1atsGUEDY7DiVA2MaGmTsFZdQHyjgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/Q4TwDN; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so689784a91.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781778462; x=1782383262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cYyaGPf1aE+4RqqUs8yjO/wC6Ni+rND+DrZOmahUAI=;
        b=o/Q4TwDNzBAyOzFLdHlPb8t22uBR3VwUUVlYXuy8AlrbPDTQzE9C85/G1SiJI2yyMF
         jJ3+8DBCftw0sORjKGEhNb1UePubiR2JaZsw0zaDd8oxekANElUzcb9ZSpCF+zMiIBQP
         40i0A0BQO1dlaFP2K2W7jBYrUq24DWIq8MusFeMycy4L5m2vCgz/SY/aBsZZS0vz9QYR
         no2FGFjbXxGJwEZVC4att8N6pzUcnkL7v53fD6zYZ6NhTMHdAme2LYsdbVd3WHKVHaPs
         NT71/aKIxQB+7mvqB9KeLCRZxFuXlok7xxRtFUFxnbc/Mm7PGbDsGN9ofi8ucFhDY8jY
         Kwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778462; x=1782383262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2cYyaGPf1aE+4RqqUs8yjO/wC6Ni+rND+DrZOmahUAI=;
        b=f9ud9xpqwKHysco0CJIbD+edpWHSeNiT42gIBGKUL5qN9O2dQ8DtJdTr/vDjPwPNoj
         6t2AgXoP1mJh25clEuzdGrpg98DGm/5XUXeEUzGeEai9wp1BTwbd0E7boRMpjbjc9Cst
         0j2xXT4D36ocP2g5bRFjb0V5pd51DpDmrO0rBBU3Vcak+c0pEsArOJZzqtd6jwAWl8zM
         S/Eak+AjyEhTy8U7qrWy112Vy7o7OWRCNcTLHdL24kd15/+dkG9d7XCrt828PPgCpv3Z
         kg6ALCL7oGUSv8Do29j3c7Aa6ZeyCLmYksp3a31MhcVcneMEiXGlvQubsP1FL6v9dXDr
         Bp/w==
X-Forwarded-Encrypted: i=1; AFNElJ8IF06Qn0tu8x7llzaBrq/yiMrkTO1EcF46x797kvKsg+/+hgTdfZadP1oT2e9X9fk2Gfe6vW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/IAk7SUey6vUiRdD2TeyUwlTXn2Ptci1hvBDXM5MDrO39P+t
	oL56ErY3yLZ/wTAfJd0h02SBVwoJlfYmi0KeTOBUAAcvIL9Gr0/YeFnG
X-Gm-Gg: AfdE7cm+aHC/mN/FWNi1Y7Nr7nuxkJEtUVUe+iqYgyuiqNofwea6GFcLChL5dyxkBdo
	gvXX6th2LKW7uPTkFKaFatdZhUHTA4IQ6GKT9gyMtWRxfLhQysrLarvPb6i/kfImRv1C89SCF2G
	rmgILfmh0ZYAM2zHxE31xWVy/dYnsZtpXMneZ3zcxbX4AZMZI0APkIDPh6HZgXX9pez0u1dTjcp
	5qGFwgQiZbr9NGTj3bb+HEsbkqVfVKReD5bApl9OlgthsclOSbKXVdzS9oT+IGpGy5ZoynGYuR9
	2ujWQQa0y4qGUb5hPBPS+67B7qLAsfMqcz0I57MSB03reaSj4FcykUz4Qg0chVRtzqQ9/OdiSB8
	jIwunuhkZXFAWJI7xOjp8rHCnKkusW/dvpdCvkJyA7RzQ4cB/3UgRlXp42jkVft0M4ghmvp20Bx
	YYD7XJ39wyhDam1iAwY1jVKscr92+TRjTsQypJplF9dG1DQ97kYUA=
X-Received: by 2002:a17:90b:2812:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-37ce46d8c8bmr3179447a91.23.1781778461702;
        Thu, 18 Jun 2026 03:27:41 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521cac5bsm8997512a91.5.2026.06.18.03.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:27:41 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 2/2] selftests/bpf: test rejection of a packet-modifying SK_SKB stream parser
Date: Thu, 18 Jun 2026 10:27:08 +0000
Message-ID: <20260618102718.2331468-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
References: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300399-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:bobbyeshleman@gmail.com,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5193569F521

Verify that attaching an SK_SKB stream parser that can modify the packet
is rejected, while a read-only parser still attaches.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 31 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  7 +++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
index 621b3b71888e..1d7231728eaf 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
@@ -431,6 +431,35 @@ static void test_sockmap_strp_verdict(int family, int sotype)
 	test_sockmap_strp__destroy(strp);
 }
 
+static void test_sockmap_strp_parser_reject(void)
+{
+	struct test_sockmap_strp *strp = NULL;
+	int parser_mod, parser_ro, link;
+	int err, map;
+
+	strp = test_sockmap_strp__open_and_load();
+	if (!ASSERT_OK_PTR(strp, "test_sockmap_strp__open_and_load"))
+		return;
+
+	map = bpf_map__fd(strp->maps.sock_map);
+	parser_mod = bpf_program__fd(strp->progs.prog_skb_parser_resize);
+	parser_ro = bpf_program__fd(strp->progs.prog_skb_parser);
+
+	err = bpf_prog_attach(parser_mod, map, BPF_SK_SKB_STREAM_PARSER, 0);
+	ASSERT_ERR(err, "bpf_prog_attach parser_mod");
+
+	link = bpf_link_create(parser_ro, map, BPF_SK_SKB_STREAM_PARSER, NULL);
+	if (!ASSERT_GE(link, 0, "bpf_link_create parser_ro"))
+		goto out;
+
+	err = bpf_link_update(link, parser_mod, NULL);
+	ASSERT_ERR(err, "bpf_link_update parser_mod");
+out:
+	if (link >= 0)
+		close(link);
+	test_sockmap_strp__destroy(strp);
+}
+
 void test_sockmap_strp(void)
 {
 	if (test__start_subtest("sockmap strp tcp pass"))
@@ -451,4 +480,6 @@ void test_sockmap_strp(void)
 		test_sockmap_strp_multiple_pkt(AF_INET, SOCK_STREAM);
 	if (test__start_subtest("sockmap strp tcp dispatch"))
 		test_sockmap_strp_dispatch_pkt(AF_INET, SOCK_STREAM);
+	if (test__start_subtest("sockmap strp parser reject pkt mod"))
+		test_sockmap_strp_parser_reject();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
index dde3d5bec515..fe88fa6d40bc 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
@@ -50,4 +50,11 @@ int prog_skb_parser_partial(struct __sk_buff *skb)
 	return 10;
 }
 
+SEC("sk_skb/stream_parser")
+int prog_skb_parser_resize(struct __sk_buff *skb)
+{
+	bpf_skb_change_tail(skb, skb->len, 0);
+	return skb->len;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


