Return-Path: <netdev+bounces-211566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09365B1A24F
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90CB3A680B
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2826D4DF;
	Mon,  4 Aug 2025 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eNNhoUvJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4117926CE1A
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311978; cv=none; b=hj95wld4rGqzxma/tLTDM4MLUxsB6PEYDpBxBm1plwpPIbOPOf/m0WA5rgZ51l+u1XSTZX0/o5iwVxoFwZjX0BKrvbMstYl4ijVQ21gkWFBHcw4zLCyOF1sLjozV2iqu20xmOmqRKOzlUfwYwYOB4iz9IYKnuy1+h9rp1j7TtjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311978; c=relaxed/simple;
	bh=b2AErcy4JiasUYk6Ay8Qa4qaZtrlk5T4baTDWxVHQj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1NquAsIcFwAUnxFO4bFUqo4XE/jxsPe0ugKQqEdloKomqgyZGSyy9iknbrlWB39GrKn03NVzllbxFjslLncKkJxO6MRGBmrZthCt1p4BWOJPc0NWqvhAee3CuJoS4Uth8XBgwF7+rUNo68hZERsx3Ix1GjugZiIwSDCgSQMswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eNNhoUvJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae9c2754a00so1067303366b.2
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754311974; x=1754916774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lmcz013S0LSVkr6atlRSjhkmTXgOh1M6jbvUAXVLpHU=;
        b=eNNhoUvJH2E4/yvsWD7klLoA7ZkeIp2lp7rY7SnZk9XzyZtzs4kF5ENB2Zw5gylsjI
         ZkITeDZCbueiHdyviW9Zf3gN0de1IANyOO00mzi+FIDTFZjrn85NTzpO1oh8v+C1Ypi0
         bfwB18XfYJtoFsNDC4w/j64f8O2lIiz2ZMv+1ybxoPLbCYsglwUMLNnDaf5nQZ6Pb4nT
         Y+EpO7UD5RAPjRg0KNmY4synadT8fWCldNIIiO+Ts2TbxDMQkcOQDj1AMGeaQgL0F9pG
         D3h4i6ZfMx1N94TGOzwlm1zLuh8zNASp+AacmTwHIqsGMbFS6iZQOP5wRTrGVHSMs14Z
         2UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311974; x=1754916774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lmcz013S0LSVkr6atlRSjhkmTXgOh1M6jbvUAXVLpHU=;
        b=mqDovMxqEbT5i+lnoRX1QLDeBrRowBtb4byYb9v0fqSRCI+IXFsbTYGsMWzI+TFicL
         5LSd43jyeZor4OfGCml1HJ4ERkRBtfh1N2a1UN3fOKL/KgBk+U8okb4b/r2dKmfixj6A
         unv/4gVWSiiqCxL7f9JgTuSP2GN3Rkr9c1VTvdGJwTNYkmrbdY8UBvwRN1sOLDfOimPV
         XqRCiSrMVDnBpicBR1tzKIaUWw6NJJWr6WPd9jvXMuikrJswZ/x0vOa9t/HgtfnD9Bpb
         L5dZdcE5JEfsLXGvVfjdpjFqyvydqnhjWHTLrPxyojoR25vE8k5U2UShdOsfAz61ZzV3
         I66Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2hu5yh52yBhsSQ/xFugAhRE6KIEkuawVidibDQ8ojvorYiUZ1J85hI90vN3y8CfPiLzlE+iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5AEIMYpPhKiVS1E2o3INhHoJwYLUITW6ciiN2UcWrDsCyiiV
	lbuwN4IvtVaynloZdbZZXqiUqWSMmt31HuaaNAdXE2iEO4TJqvQoHwrd8fMW+rbB//E=
X-Gm-Gg: ASbGncuwlMJ38xebQXa31ktgVLNGgIY460VtG15cW/QW+W1+FR3A2HZpuoyPG51sdoo
	fKd0yIB8e+mymG7T7zWWIcsoa5UGSdT4hK//H8YWc3NGFqTJ1jnUSmV0vqKa0YT+Hx0JCTwlVSh
	TAAjOda975Ycfvg+DzK+jzbEylBMeWOyU0MtIEJQ4iB3WV8knq49wCshfV85DseclEzcD7FxXpp
	pP28J1BfO6X5UnwnZ10ElO/VPJMxPLb+zo7feafMuDZiX+HiIDEpGdofzDJe9PCIcBoJPCJfHxT
	GMFdOvs48MjfWU90G6uZFetBflN9sipdcBo7yBBSV0pDdIHoxgjQR+6TsZyuiAWAHxl+MzsBnIW
	aw4wV9tLMxNjL8/I=
X-Google-Smtp-Source: AGHT+IGpWf1xM8VlrIrSEojHZjFfUA0HUVZ25SOt8E4VEka9M8EMRN1rA+ypuPnYwCNy4uD9LBeCrQ==
X-Received: by 2002:a17:907:86a0:b0:af9:3d0a:f391 with SMTP id a640c23a62f3a-af940169e8emr1023175166b.28.1754311974410;
        Mon, 04 Aug 2025 05:52:54 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7ac0sm6702781a12.35.2025.08.04.05.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:52:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 04 Aug 2025 14:52:30 +0200
Subject: [PATCH bpf-next v6 7/9] selftests/bpf: Cover write access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-skb-metadata-thru-dynptr-v6-7-05da400bfa4b@cloudflare.com>
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

Add tests what exercise writes to skb metadata in two ways:
1. indirectly, using bpf_dynptr_write helper,
2. directly, using a read-write dynptr slice.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
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


