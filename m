Return-Path: <netdev+bounces-208553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311A6B0C1C3
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CEE27A637D
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924E528FFF3;
	Mon, 21 Jul 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YnMCfI78"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B29292B5E
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095217; cv=none; b=Hj5xzyjGk4trALB70s5VMh0fGpRQFu0ANTOLGZGvBp1W/NSWgJD4YXeUaoCRwvKe9IJ8w+hgqjrYkauchCeOVcCXmg57bJTj8gYuTLBnI74QXMUnESX0p+S+R4IH/dr63DBZGR0mnxz9/Jc+988hcO4O7WNdJ4kmtJCjbqJka0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095217; c=relaxed/simple;
	bh=uRNVyE79emPfKVU6XpnZGgITpFG6Ywz7jpzsyJ4I+Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyO7CsiiQBLpAY1HBu7K444PVIHp+RKLO9EEfzyOZyxtNueXygHwzl2CKuy89qi9g2tuFNg4zH5yRvqMug+hoOtnAnEDH8YoWxV5pVr1Gc6LRvBrxKSytWgT3aM1x84EcJsZQ1hmnNTOVISxVuAdgEsDt9YmKxc5F/YQYPB9A7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YnMCfI78; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-612a338aed8so6239158a12.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095214; x=1753700014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7HMMcaoWoXp7CBL/t22KpHPWA7fRL898Q9A4YYFk88=;
        b=YnMCfI78b7synolT+xKM1MkObRrukeIwAXp6CSeLRuvlqVTF1Qp3S0XTDb1rMyHj2s
         Nb0D4WCQYe/EEpBuLNMRosNw1izUBgtWahXWZhUHj4BihzWUkFCDsTrmXvkecoxDETJp
         ueBEscImnR/woVB1sEuTYZsbonMz04N5Uy85+MVC3IRrL4dR8xXusdxN5qeJICEblRKA
         6hQiNUhp1Wygt0EoqswdzTBNa8cftIbwtCY2wRUigq6pLvDpOeImouOz5w3/C4tkfhZS
         hAn344+1AattJkFJz2c6a7NidUIrdtCo4E2J6ITCP+TDVY3ZkCbKbvjFZMjVrkkukc/V
         70Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095214; x=1753700014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7HMMcaoWoXp7CBL/t22KpHPWA7fRL898Q9A4YYFk88=;
        b=uGOyCRnQX0Eo6bfT1ZLruZTYJSxVDPwgBlbzntsZ+c7DrDquZezKJcSL2R6O+8JB00
         kHO6MO2JmxVtv6986TvxHKp5HYeOVJApXfY32DyJS0W4qY2rhd/Wz48EN5mfeUNPgy7F
         Pa6KBDxvy3TAvinqtDb43muaRD47zr8mzVyEs95HfWLR68QrgeEC8mMP0vSqrXpxditH
         ByPNzA7JxYMuQcxtHaonOmbxTV3zG/KBTBCYvRowpWYLj3HbiVLwpkJO/kQoMOUswq5U
         qwiTVvscWPgoULRgI+jRLtOyb4rxOoSQ/gMd2WinuFPx6Mbwl9ICfo6UcGFFEYUooE3E
         LeDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJHOzdp3tf5NeI2O37VZePdjtBI1a8ZYjz7Mv9atqkhqPw8/2y9SDWXRXNf3YRkNNU4HskdLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQCMeyOKpCTUbD0VnhYov8+tdMiLqNqOhzWBW1iQAEVV2uzncK
	yITbvIwxGx5z3Gl0YEpyBOim+83doA+VkNFlSQZHXPMhDQ1IFnsVqmaeTUyyG9u2BD8=
X-Gm-Gg: ASbGncvBdYQyRDJ5Vdh1mgbS4pL3AWXT2x1/koWOTWbLJftZJPVwMNp3tIHg/+KzKnN
	ktEqVfXHaYrYcwYGxp9W4OhYwig4sLSe1KRmFhZDgLR8IrxJQTRK/B6ymc0qRmvgaKDeX26v/2c
	g1M8JV8mcUtEAD3ymHHS0fmh9b77HteZyn+Q2pL/rI/9F0DVw8y3W7VGMgv0uqqn/ULrCRV5kJu
	7h7sOqkylzkEz/ew2IuoBN2vMtjI7dL6cGSaUYQcxE30cZjGepLdrb/Gf1qvuoZojBtcdd9uT2x
	LtpGZ/piVcz78j30XnQLLQBgZdPwwY3U5eEn5Vil5ucHHT3ckQhmXpEdFXaNcQBb/1aB9izPyLS
	fsTOZYGf3zrxb0Q==
X-Google-Smtp-Source: AGHT+IG3TBn3/a64XNavmgsR5xqtrjPmkBz1S/rcOZt65MqDgsRBjjfB7VC0+m02zu94z10crci02w==
X-Received: by 2002:a05:6402:1d55:b0:612:b057:90ab with SMTP id 4fb4d7f45d1cf-612b05793femr12408609a12.17.1753095213988;
        Mon, 21 Jul 2025 03:53:33 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612e7125fb4sm4012845a12.9.2025.07.21.03.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:33 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 21 Jul 2025 12:52:45 +0200
Subject: [PATCH bpf-next v3 07/10] selftests/bpf: Parametrize
 test_xdp_context_tuntap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-7-e92be5534174@cloudflare.com>
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

We want to add more test cases to cover different ways to access the
metadata area. Prepare for it. Pull up the skeleton management.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 31 +++++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 0134651d94ab..6c66e27e5bc7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -256,12 +256,13 @@ void test_xdp_context_veth(void)
 	netns_free(tx_ns);
 }
 
-void test_xdp_context_tuntap(void)
+static void test_tuntap(struct bpf_program *xdp_prog,
+			struct bpf_program *tc_prog,
+			struct bpf_map *result_map)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
 	struct netns_obj *ns = NULL;
-	struct test_xdp_meta *skel = NULL;
 	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
 	int tap_fd = -1;
 	int tap_ifindex;
@@ -277,10 +278,6 @@ void test_xdp_context_tuntap(void)
 
 	SYS(close, "ip link set dev " TAP_NAME " up");
 
-	skel = test_xdp_meta__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
-		goto close;
-
 	tap_ifindex = if_nametoindex(TAP_NAME);
 	if (!ASSERT_GE(tap_ifindex, 0, "if_nametoindex"))
 		goto close;
@@ -290,12 +287,12 @@ void test_xdp_context_tuntap(void)
 	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
 		goto close;
 
-	tc_opts.prog_fd = bpf_program__fd(skel->progs.ing_cls);
+	tc_opts.prog_fd = bpf_program__fd(tc_prog);
 	ret = bpf_tc_attach(&tc_hook, &tc_opts);
 	if (!ASSERT_OK(ret, "bpf_tc_attach"))
 		goto close;
 
-	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(skel->progs.ing_xdp),
+	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(xdp_prog),
 			     0, NULL);
 	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
 		goto close;
@@ -312,11 +309,25 @@ void test_xdp_context_tuntap(void)
 	if (!ASSERT_EQ(ret, sizeof(packet), "write packet"))
 		goto close;
 
-	assert_test_result(skel->maps.test_result);
+	assert_test_result(result_map);
 
 close:
 	if (tap_fd >= 0)
 		close(tap_fd);
-	test_xdp_meta__destroy(skel);
 	netns_free(ns);
 }
+
+void test_xdp_context_tuntap(void)
+{
+	struct test_xdp_meta *skel = NULL;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	if (test__start_subtest("data_meta"))
+		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls,
+			    skel->maps.test_result);
+
+	test_xdp_meta__destroy(skel);
+}

-- 
2.43.0


