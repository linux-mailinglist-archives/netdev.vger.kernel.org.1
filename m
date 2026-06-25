Return-Path: <netdev+bounces-301943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9DRwKiwLPWpQwQgAu9opvQ
	(envelope-from <netdev+bounces-301943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:04:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 901FD6C4F42
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:04:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oWUf3G4W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301943-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301943-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE9553013BB6
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1213AE6F8;
	Thu, 25 Jun 2026 11:03:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925983AD527
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 11:03:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385417; cv=none; b=lJplNfzi75MMX9CLPTQRkGJvMQb7WF4NwU4gMMMYg9Ak4sRlUSZE/B8CcpJG3M8hUcc2UoXzJwerN2rRNljkmPMMzrr989YmMqZV3sFNGQ90ux9ElYVOoZi4sPyjUxqHbKixUsf41+xjAQQzTDHfFxJ2AoanIc9hkNz5xZC6a2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385417; c=relaxed/simple;
	bh=XR/ijwy0to/QQCsRBXOhFG6fO5xl62JdfB0L68hbzMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbFgZ8qbHDdbqgJ+xFAp+9KoaTGOCVpTq/om7xpe4xtHqARPTb/lkBQq3bAKests4XQWrUQ2qjuZClk54kOSZTFx3oh5yjEpysaFzyGgb5Fg2wmxGyj9b7JHPE3MUiCz6hW3Ama45Z2TZVNE79kSaSPoilznSZsRm+ODkcMN3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWUf3G4W; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49230a567a9so9357035e9.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385411; x=1782990211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9oeqTdNCxWtKvJYP8ZQP5Nn9aXr1LaBKmN17AtVy/U=;
        b=oWUf3G4WH6Q+TkVShDNqUDZq2bjU/NEilOHzRoNd1EYevm50e06mbU/IcO2Rcyw8gG
         CpZRGCDcZ7ffWY2iGZxPA3fssXpyVYiicTITabzHo0TeiEcatsG8+lF+WivYEAINAu+0
         81wy2wf0Uv3mg92ckmL2kcH5yT2SeU73SN2bHj48pao5x0fQD+vKmJCDbjMNCvaRTJFy
         JvNQvc+yUGtd69pQ3Ms5mp2HT0zuaZrseJjlZcjpFHpIUEgdASmeIpPXILzN/Gh9+/8b
         hWBjB+hgUobX1j7WgrAI74ayEYu0fRufxYnWdp8HaC2OQW57SiKiwo5ZbggX65ULVnfS
         aHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385411; x=1782990211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9oeqTdNCxWtKvJYP8ZQP5Nn9aXr1LaBKmN17AtVy/U=;
        b=pE52vW0uYvEnlK/nxfASH7ilrlw9Do/9u7c6WlmXeHKxe2jemHYPRL5ot/Enz0jj63
         EgGdpit/cAoSFLuJrFPQh+9ep5ExRWoxsq+oMN8dmfGpI2IlND/RGRjMVhsKcYkInAET
         g19VYBP80uBiPm6is/PjJND874Cxos5JpVw2yAvRs6KeqHXLwuDOSwr2EGefhlgDAKwB
         KaAZiNFNJl2+CWkv8wCRuVGHPbAyuCmkb89JPFgwZ5CKThNTND2jW8ADnyOUavPNSnB2
         4rQkcx4pdBJLuuvpkgOWUdXGgUhLogYEiNtJkWX9YDi5unaWGjYhRwCW/vXHpys3bkqm
         jmXA==
X-Forwarded-Encrypted: i=1; AFNElJ+UV7nqu9rS0W+QLJj+kOGaYtpOr943pR1EKz2rjo36rSxoaDYahQFivfNO63OqVHGNvcX22zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rqu2Y74piN7lViDdq4r09br8jpcKWQV0Zj2r+34rv+hVPnHv
	YvkpCYViKBUGiHvaUJW+e80h6bmzMlDGPGktL5Wj+hqIorw+0+0TPGT/
X-Gm-Gg: AfdE7cmMvJi04C8/72hhhcYui8vbTnxUM8KGkm5GuYkBoh3+owEhjvGjHdAPShStkTK
	Subz6KPkkHcElx9fpGoSLzxnUj8JqauIqreckQUEh4hnBUibfq7cRVUKOp6q1+RFgLroRdFILzS
	nRvnqnyElcN5E0levudU/nU24uMcLeAM3xrr0EGCbjWsEfx83D9Yy4ihZ0nxBM9xdYqam9TX/YZ
	bWsND7SIBYH89C7g4pnNklq+vBUksTrqxm4cqBJ46pFv+wTqeafZOcsSM1c7aatXWhI7IW9Tinm
	DxpngtKsrfhiH/3/hlmHOXdALbX+v8Vz7l37n+LSr3KrU900v+l+BsZGqDOBlETKxpRw5sTx/V5
	2O7ObePjvwze01C7kZyzGYZVfMn31l+S50QCuafeM8hKPTORZAW9TuBY2VtMzJXwOwksbFR6o8y
	GDDmdeYVLWx/Qhkj3u
X-Received: by 2002:a05:600c:820d:b0:490:bcc1:4edb with SMTP id 5b1f17b1804b1-49266884b7emr26370405e9.27.1782385411129;
        Thu, 25 Jun 2026 04:03:31 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-46c9ed7491esm11071917f8f.37.2026.06.25.04.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:03:30 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v10 5/5] selftests/bpf: add bpf_icmp_send no route test
Date: Thu, 25 Jun 2026 11:03:21 +0000
Message-Id: <20260625110321.28236-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625110321.28236-1-mahe.tardy@gmail.com>
References: <20260625110321.28236-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301943-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:mahe.tardy@gmail.com,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,vger.kernel.org,google.com,redhat.com,davemloft.net];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,etsalapatis.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 901FD6C4F42

For normal live cgroup_skb paths, the skb should already be routed. The
exception is for test run via BPF_PROG_TEST_RUN with packets created
via bpf_prog_test_run_skb. Those lack dst route and thus the icmp_send
would quietly fail by returning early.

This test exercises this and makes sure the kfunc returns -ENETUNREACH.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index bb532aa0d158..ffaf0fe1880b 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -169,6 +169,29 @@ static void run_icmp_test(struct icmp_send *skel, int af, const char *ip,
 	}
 }

+static void run_icmp_no_route_test(struct icmp_send *skel)
+{
+	struct ipv4_packet pkt = pkt_v4;
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt,
+		.data_size_in = sizeof(pkt),
+	);
+	int err;
+
+	pkt.iph.version = 4;
+	pkt.iph.daddr = inet_addr("127.0.0.1");
+	pkt.tcp.dest = htons(80);
+	skel->bss->server_port = 80;
+	skel->bss->unreach_type = ICMP_DEST_UNREACH;
+	skel->bss->unreach_code = ICMP_HOST_UNREACH;
+	skel->data->kfunc_ret = KFUNC_RET_UNSET;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.egress), &opts);
+	if (!ASSERT_OK(err, "test_run"))
+		return;
+	ASSERT_EQ(skel->data->kfunc_ret, -ENETUNREACH, "kfunc_ret_no_route");
+}
+
 void test_icmp_send_unreach_cgroup(void)
 {
 	struct icmp_send *skel;
@@ -193,6 +216,9 @@ void test_icmp_send_unreach_cgroup(void)
 	if (test__start_subtest("ipv6"))
 		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);

+	if (test__start_subtest("no_route"))
+		run_icmp_no_route_test(skel);
+
 cleanup:
 	icmp_send__destroy(skel);
 	if (cgroup_fd >= 0)
--
2.34.1


