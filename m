Return-Path: <netdev+bounces-211564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF33B1A24D
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3E73A6B41
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8C826C3AC;
	Mon,  4 Aug 2025 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KDPBdU6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6450F26B97E
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311975; cv=none; b=AdHzradcIM3APaFsXeGQRPj/3Kal/zNn8LomwzCBbi4b3ncTSlhFJFXmPzF1uu5GHbnqsRTdokYc5kBWQONaqg87W6MsZ5rbI+O9ndSM9YXPzS6UQcJFbVozy9uBOVTVh2gVO8SzCmG5+DetfNsxJ7XN6rk+fQv6f/CjTuTE1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311975; c=relaxed/simple;
	bh=rOgEaue3k1efCvteS9x+AYID405oKjOeQI0S/MAOO/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G8Hy+0dhI7lpguuHBV9UkPd5RBcU3OUatf/vDVK80ZXbq6qWV+SP2lUVZhs6U68pY1RPRKPJ6Kcjxlym5X6FiRsCFM4rbjAVTR6bS5Ld8i/ffBs9JW8mVNlYiUQ+ctW90+oMAZYd0IrfKw4R13qSS9VytbD3bJiPrslC2Krw3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KDPBdU6T; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af95525bac4so344180666b.0
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754311971; x=1754916771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0fIqnzU78JFEGt4tPHYQLQeFtpWNKhdVMlxMCo22pY=;
        b=KDPBdU6TC1e/PFOFQ9PLtXRFiPJFGcgyVqAFWtVD/lhqUb7GLJC+TQvMgGn3z/JaK3
         BQtPwU0QMYhQ8Bwsh3s9W8lwIDYAoQbwr1QmbPpb+DmzDXjq+7mSyuJ54EIIwhDVGUVb
         w5bPIyElM8m9lZSlZVAZmxo1Qlbt0ns68ajUt8bkQcxfl4+xcwaFbCHiUKDUCSEmjGc+
         BLveUTuS06tQe9+MzZ40H5ncxjEmoSKEksDWNs3Exh85IU6MHUU4rKZmAbSNfen6G6wa
         lCuXejfhdiEjnXCSiZjrz9+WP833Okhfs/BBuJmSyQ99bq9OzEuZMsaZoazF9uliPjBO
         RPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311971; x=1754916771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0fIqnzU78JFEGt4tPHYQLQeFtpWNKhdVMlxMCo22pY=;
        b=G8mc4IMWSQmnWW0JTguBA28ep2wOpaNwlp1JXpQucRcYnMJGCLBVWlkb569/+BTwbB
         RXMJgXJM4kHyQwCKY5bqZbU30yJm4C8CQ+yKhXABg3/UuZgG7Aa0qnjNnoQdLd+/GfLc
         3IGwf8TSx2tIVZUN3sGFiTedzO5nD1yIDv7IkgrQzsSGIXP7n9uXVhryze6BLehq/PP6
         Z/zergOmEi+SkJ+uSTRQjqrcKVTq+QB2mEE9C3EL7/JAkcmP5rmM2keyjca9WC+FikZR
         WRoNV50EiWp2U+5ptWlz8CMNrrpWLKPw5aJ8kqagUaDAmVvF2rRJ07Gt5dyY85cjBoT3
         LvCg==
X-Forwarded-Encrypted: i=1; AJvYcCXigUmjS8AbHwlIeE94c4cYaF4WDs4FGg3pkb6hmqrhSCAxO2vVgpEyyRBDd1otCpdBzDG+D9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMXVTqdc1PJMlcoWxaWb/sFtmrkHb1PffZrvJknuWSajulRkbA
	Jc62hzFZHq50zDWiCqi2mJLlaH/bgop1sSuccWM5Bfl3k0odo6R0HgrzhmDyL23g2f8=
X-Gm-Gg: ASbGncv6SG2Tw6PHrut5X5mlaz793avE1Kqi1jXvvYmrc6kZcQ+gwanzrw0VYSS0iUO
	yl2NGPW+OyjVdyB8+g5408i+5keqzm+vckQHvEaXY/VXaxmlqAD5UqoKfaHwg0MbcjLIV/fYbqS
	nkAxxaHBZgK11zSsn/4CTfaTV50N7goSeVSn2YGjGC6Z5fN6wg3h5mA6oEIBoJuY0BsrfVqbcEy
	9w+6nwzE2gty8n6Lu/uoP9x8/rKyf/LbBVbcHc90pY5lQrT1O7bKfvSLsrt9hZACprcV/TGqyNv
	mpubTljHbON79dDhnmpdnnlR84QUyYMS52nodFcXmdl8EjsxckAK7VirWDzQ8Tz925EVxOTFxFq
	SvBp4swDBYRyxwLY=
X-Google-Smtp-Source: AGHT+IGC+96MxYB3tnSb04fERYjiIDWOgwqlhiC2t0CokbpFxRwPYHlHGVxptCr1fJEqO0bHyd7o+Q==
X-Received: by 2002:a17:907:1c89:b0:ae0:d78a:2366 with SMTP id a640c23a62f3a-af93ffc93e3mr902790666b.4.1754311970599;
        Mon, 04 Aug 2025 05:52:50 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2436c2sm717453766b.141.2025.08.04.05.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:52:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 04 Aug 2025 14:52:28 +0200
Subject: [PATCH bpf-next v6 5/9] selftests/bpf: Parametrize
 test_xdp_context_tuntap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-skb-metadata-thru-dynptr-v6-5-05da400bfa4b@cloudflare.com>
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
In-Reply-To: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

We want to add more test cases to cover different ways to access the
metadata area. Prepare for it. Pull up the skeleton management.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
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


