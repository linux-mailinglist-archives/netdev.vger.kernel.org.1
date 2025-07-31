Return-Path: <netdev+bounces-211162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBBBB16F89
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365053B7A51
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E6B2BEC2E;
	Thu, 31 Jul 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PdMpaKXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C72BE056
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957722; cv=none; b=Mafwlo1pBJFdoCPDP3H0U8COxqQ56rahnpyi6LPWfMzOPjOXQIEIKnJfTZEYQ273Dl44eOYoqSCainf7ZO6qJQCfDkYAj8Ac2KRmLAbwRKZ+osANOyieZkOO48NkZnIvgvSZMZS4hVvx9hk+8eycqePnxt15SGrc1fS+Prs5M08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957722; c=relaxed/simple;
	bh=rOgEaue3k1efCvteS9x+AYID405oKjOeQI0S/MAOO/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V4YuBqKKATAtxP4RvXYBT3JrCg41vFskioerK7tK1sMH+Sqsos++SiJzoJo5lr9oPGe2mHNkFT6pNrxjrOhqev31thUW4zHr7v/V8d5SJgocyDoq9+xt6IL+yZ9O40EvGpYk+nvbrNZBiJNZFB2j3r+HtpgZTIO9YNfWyRoBGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PdMpaKXL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61576e33ce9so1309278a12.1
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 03:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753957719; x=1754562519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0fIqnzU78JFEGt4tPHYQLQeFtpWNKhdVMlxMCo22pY=;
        b=PdMpaKXLxhIYDGDNM06Ib+aGxJ1Tkdf5xHKA3ne3cbdbZk2Pg3DTQxfTLejszuMsjZ
         dhLNneE0bI64YhGllx8UtE3a2YZQ6mJS2QV9fRHgbuLyOMGSe7gykC7WpWbE0wp4gpOp
         ZpitGwtA8o+fnLlskwD0VJcX/r5//6miXtW9Id2ZYlhKWEAUYTmZxGpUHIxfx4UTb/V9
         5CT6tALFaKlzWvn90p5IA+omV2xvKbBkyl7/R6zLJNtLKTM8XTrE9bgftO+4vAmHkvtd
         APiKPGPLoPyZVI6FvecHRhAhDl5alriQebAw/agjQkanDkRO/EkxruIvNTP1mmcyX6hm
         gxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957719; x=1754562519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0fIqnzU78JFEGt4tPHYQLQeFtpWNKhdVMlxMCo22pY=;
        b=X0AX8h/9gaVh7lV2FbhYz9T+3dxg5OJzlR+qVxow1dsz+D/FMmFFljwK42X+obUXXm
         3Z7NS4hy1sYBc815aicDYAAXF31H/ertMjs+Og8OfvxJmNN3BJo/0xv4NLP3MvvQBfHg
         +oJVN7ieoDiFIMvx1uyavWxzYSQRYooArS95dCGI7lPVbVy3qwNyV2DVMbh/VVpU9nwT
         c78U5PP6c5SbqkuzlG0cpjsK4zmCIjegzO2poMaqv5pf3XFpluaqmEIzgFNrmQqEKizS
         DcdqeZoAFQDiRjAAqaz6G1Sv3eeBlztry2yFC0lttAErdhUozMWo/yJ/+03LHZ/p33Bo
         DcGw==
X-Forwarded-Encrypted: i=1; AJvYcCWTKRohCIg332D1i4TPRFa+GLR7QIQGBw2uZuORp/eLl1g9uRWGMqDI2hAGzbh5E27KE3D0qNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Y1r9rVWnaek85LjzXp3QwoJ8fw7or093hPYtk5kz0jURQfsg
	lUVojbddZ8jKTVMnSd3vVgojUeZcOGX1XTjZYl7uX8kt+bosBB4Ya+rpYCtUgAXS9Vc=
X-Gm-Gg: ASbGncsvCR2WtckPcU++U3NDnkZ+g+c0uG/nyXtbhZX/CnLJvVhXjvcuGrCw98PjMk9
	VCgs9Ga73oXI9qgubcozn0+jGbOPaLDY/4T0CI0+uDKgtqZlcC5/U+D/GFCtjhf/hm7M5BQCUnQ
	RvuFF7/2CtL6kbm8A75ATZtRq5qSjiA419bFCQZxaw/OkRAL+mFkiG1onUXIsvyPzGCpCfvJMw/
	Mb6nlul8OkzzOq1aQZaua3WjFqeGjpvcEtp0ycjZeaO9iBYsTEq6kQwPtLgiYwKenW3XYLq7QZt
	tYn3s2GxDq42nRLR68nWNQ2OBPaMXAph/0kLZTDtl/uSDSupi3n3us9Fo5fbqboSU2bTivdQDXS
	zPF9y3fI/jCeM8mGcioeM/RFINDbSpXA=
X-Google-Smtp-Source: AGHT+IGhAH5I26ny2hIIjbvqe0KyYphTS7bzv7zNKkTwjYIl1KEm19a2egQZ7HxJNxFvEymvhEz8Iw==
X-Received: by 2002:a17:907:d17:b0:ae3:c777:6e5e with SMTP id a640c23a62f3a-af91be35b77mr186082366b.19.1753957719336;
        Thu, 31 Jul 2025 03:28:39 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3e80sm88840166b.47.2025.07.31.03.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:28:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 31 Jul 2025 12:28:19 +0200
Subject: [PATCH bpf-next v5 5/9] selftests/bpf: Parametrize
 test_xdp_context_tuntap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-skb-metadata-thru-dynptr-v5-5-f02f6b5688dc@cloudflare.com>
References: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
In-Reply-To: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
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


