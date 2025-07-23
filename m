Return-Path: <netdev+bounces-209459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4612CB0F97B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C4D1882A09
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADAB242D92;
	Wed, 23 Jul 2025 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SdAw+bCJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FCE242917
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292224; cv=none; b=go6mz0ibYi/mNPmBEi8YgJiWZxYhZSL9w80j8/he61cnSFmt00NZ+YE0otdkxYAM7KTOckZSVsqf8huQJHWj8J41GgPQY2QvL3ArOBB8bqh/XN0roE/7tnYT02u6dxaQX+a1YgF7TxsJ2C+PexYJsW0vsdImvFsyM7onPF0psQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292224; c=relaxed/simple;
	bh=8UvmGS7h0yO0BSunpUymHkUESAoala8S1ndq9rN7ZTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YwK8rvvQlU7bZWBKQxUO6d1qOMtYtbaEEDYwjvMjIY8+KYZPfsQZ8k51lUCqNZoZbqndSqjW/FgoNFCysWDEXqcqiUaQESwBVAXeAoAnNUYAgVAddIZxsQ9O9fHZs8GAocHHnTw/Ro0CbR12zGT9n6b1JIz+mJFZ2ZRlfmgnJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SdAw+bCJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae9be1697easo234144966b.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753292221; x=1753897021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+9GnuERSsXNaL5bk3V6N2fM/0EV1p+TClLOoYPWF4Q=;
        b=SdAw+bCJhvQP1hI6FjVuk6WmVwRCFVe3TKZV07UFSvjuv/2jCddnXXHFgB+yg2wOvw
         nNVfonKq2K/lvZvgkRmQ7DAbwYI3FpWQ5sxKKkK84n5oN/ZyXChB97LgXMooZ2SAa5+h
         XktFr6gMYw5c1DpFMkSQ97Is1DrE0c0CbmN6bgyhFQDo9XOKS36SrvPWbW8kGeZn4p2o
         q70eWhJMCuNZAcwpVj52sAmQ/I/Hx38vJH9gFWkLaEKjtPTRYX9fDCmqezwU7lxOY7G6
         Vdr8ZIarLQ4mUE9fGBy7I3OzOeWZgX1lsLnYXuEhI4P9oyLCaZYKTsUfiLNwvpLn4fjI
         UNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292221; x=1753897021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+9GnuERSsXNaL5bk3V6N2fM/0EV1p+TClLOoYPWF4Q=;
        b=k0hRXBUduzYCWkW4uatwExccLj+L/zME2cl4IL0YOf0O6zqQNcXEYbYXlftnR/4FFF
         tAxh+miku0U015rbuSTrRyIOYDjDiTacPiuRfqqRZkkJOM/qIyd69JVWMFsKwUoq2H/v
         iDnygcduPUdlaiVcvmjROximDOQQAzZkLXm6dScY8ZBwm9JiV+VVHDgQVeIZjiXeoQ2C
         jAZ60B76P25K6GWAXBuhdtmzL7ES+zhnf3dVyFHvhXmPFMtikaWUYI/pKO+OuLc0YVZ5
         GYnxNQiahwWhJoROx34pfHJamMkQmmbZrl7OAPr8vghC1SEz84snSd+ZKpmDS91DbURq
         Uuxw==
X-Forwarded-Encrypted: i=1; AJvYcCVRJDcQq/h4Zg58niGloWJ6Vwav6CpkOoNiQ8PaOFvCIuy8HUSmXdrQjVsZc/A5MEQjQNhHWKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJz1A0tK/WDzPZJCfRb3ptGfYGSB+//kvU15ax5re62t9Xwm2v
	635Q2No131mTspDd/DT1FQXhof2tHMzZnmOIH897h+2Mn5sf+DK2BNRYGb1eBBiXCpw=
X-Gm-Gg: ASbGncuCoT8MrseVRo8iwZRHd/Qg/NVxwu64P+aOmAem+LLntW4r9f+XrHrXmE7vAnu
	NnOGrYNXF8WzEroIqSaT5rbx4wet1P/XBobquu9ckvqt6zEjJhpSGJT2B3Nk5k9QU/sBDzH+Tcv
	vxCXixnzPEnkA1aMPzC7fmdQQo3EXrHDJdtPnNmYKwEBRPFYhUqZdnYg3ZRCKMNKAE7XDh8/NFm
	Goke6ANDmvSGCkuYG0+EkqZQdYfkJZO4nC66Vd+fPStR1BtY+4UzX73rXhzKJAcVAlropkyM3Vd
	FnVslzMhFBzo8NGhUtZLexcuCmvGo10Kjc011y5Gj7UELq6nOPiHeQ+jzHpgwGA7PdaR7Vl4sie
	bLFrqM/aNrKIkudJvwAZEsqohBNIL+h1+BOy6Su6Y1Zm1wvOMy3o0ngHUzw1xb0S0cgyJ/j4=
X-Google-Smtp-Source: AGHT+IFc6HXavV66ybyLmOnG8N9+2YMBLbetQAFGzKIBuI04cFc74unXdMixC97uqsGJtG1LavcTQg==
X-Received: by 2002:a17:907:6ea7:b0:ae3:c72f:6383 with SMTP id a640c23a62f3a-af2f48b0ac8mr394506566b.17.1753292220717;
        Wed, 23 Jul 2025 10:37:00 -0700 (PDT)
Received: from cloudflare.com (79.184.149.187.ipv4.supernova.orange.pl. [79.184.149.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7c7ebdsm1074784666b.37.2025.07.23.10.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:37:00 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 23 Jul 2025 19:36:52 +0200
Subject: [PATCH bpf-next v4 7/8] selftests/bpf: Cover write access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-skb-metadata-thru-dynptr-v4-7-a0fed48bcd37@cloudflare.com>
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
In-Reply-To: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
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

Add tests what exercise writes to skb metadata in two ways:
1. indirectly, using bpf_dynptr_write helper,
2. directly, using a read-write dynptr slice.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 36 ++++++++++--
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 67 ++++++++++++++++++++++
 2 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 7e4526461a4c..79c4c58276e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -269,7 +269,8 @@ void test_xdp_context_veth(void)
 }
 
 static void test_tuntap(struct bpf_program *xdp_prog,
-			struct bpf_program *tc_prog,
+			struct bpf_program *tc_prio_1_prog,
+			struct bpf_program *tc_prio_2_prog,
 			struct bpf_map *result_map)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
@@ -302,11 +303,20 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
 		goto close;
 
-	tc_opts.prog_fd = bpf_program__fd(tc_prog);
+	tc_opts.prog_fd = bpf_program__fd(tc_prio_1_prog);
 	ret = bpf_tc_attach(&tc_hook, &tc_opts);
 	if (!ASSERT_OK(ret, "bpf_tc_attach"))
 		goto close;
 
+	if (tc_prio_2_prog) {
+		LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 2,
+			    .prog_fd = bpf_program__fd(tc_prio_2_prog));
+
+		ret = bpf_tc_attach(&tc_hook, &tc_opts);
+		if (!ASSERT_OK(ret, "bpf_tc_attach"))
+			goto close;
+	}
+
 	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(xdp_prog),
 			     0, NULL);
 	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
@@ -341,13 +351,29 @@ void test_xdp_context_tuntap(void)
 		return;
 
 	if (test__start_subtest("data_meta"))
-		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls,
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.ing_cls,
+			    NULL, /* tc prio 2 */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_read"))
-		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls_dynptr_read,
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.ing_cls_dynptr_read,
+			    NULL, /* tc prio 2 */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_slice"))
-		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls_dynptr_slice,
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.ing_cls_dynptr_slice,
+			    NULL, /* tc prio 2 */
+			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_write"))
+		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
+			    skel->progs.ing_cls_dynptr_write,
+			    skel->progs.ing_cls_dynptr_read,
+			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_slice_rdwr"))
+		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
+			    skel->progs.ing_cls_dynptr_slice_rdwr,
+			    skel->progs.ing_cls_dynptr_slice,
 			    skel->maps.test_result);
 
 	test_xdp_meta__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 0ba647fb1b1d..e7879860f403 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -60,6 +60,24 @@ int ing_cls_dynptr_read(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Write to metadata using bpf_dynptr_write helper */
+SEC("tc")
+int ing_cls_dynptr_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr data, meta;
+	__u8 *src;
+
+	bpf_dynptr_from_skb(ctx, 0, &data);
+	src = bpf_dynptr_slice(&data, sizeof(struct ethhdr), NULL, META_SIZE);
+	if (!src)
+		return TC_ACT_SHOT;
+
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	bpf_dynptr_write(&meta, 0, src, META_SIZE, 0);
+
+	return TC_ACT_UNSPEC; /* pass */
+}
+
 /* Read from metadata using read-only dynptr slice */
 SEC("tc")
 int ing_cls_dynptr_slice(struct __sk_buff *ctx)
@@ -82,6 +100,55 @@ int ing_cls_dynptr_slice(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Write to metadata using writeable dynptr slice */
+SEC("tc")
+int ing_cls_dynptr_slice_rdwr(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr data, meta;
+	__u8 *src, *dst;
+
+	bpf_dynptr_from_skb(ctx, 0, &data);
+	src = bpf_dynptr_slice(&data, sizeof(struct ethhdr), NULL, META_SIZE);
+	if (!src)
+		return TC_ACT_SHOT;
+
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	dst = bpf_dynptr_slice_rdwr(&meta, 0, NULL, META_SIZE);
+	if (!dst)
+		return TC_ACT_SHOT;
+
+	__builtin_memcpy(dst, src, META_SIZE);
+
+	return TC_ACT_UNSPEC; /* pass */
+}
+
+/* Reserve and clear space for metadata but don't populate it */
+SEC("xdp")
+int ing_xdp_zalloc_meta(struct xdp_md *ctx)
+{
+	struct ethhdr *eth = ctx_ptr(ctx, data);
+	__u8 *meta;
+	int ret;
+
+	/* Drop any non-test packets */
+	if (eth + 1 > ctx_ptr(ctx, data_end))
+		return XDP_DROP;
+	if (eth->h_proto != 0)
+		return XDP_DROP;
+
+	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
+	if (ret < 0)
+		return XDP_DROP;
+
+	meta = ctx_ptr(ctx, data_meta);
+	if (meta + META_SIZE > ctx_ptr(ctx, data))
+		return XDP_DROP;
+
+	__builtin_memset(meta, 0, META_SIZE);
+
+	return XDP_PASS;
+}
+
 SEC("xdp")
 int ing_xdp(struct xdp_md *ctx)
 {

-- 
2.43.0


