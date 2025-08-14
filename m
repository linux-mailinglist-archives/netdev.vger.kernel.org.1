Return-Path: <netdev+bounces-213662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E917DB261D4
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666561BC4F1A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B402FC889;
	Thu, 14 Aug 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="a0oZlCgQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3B2FB961
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165603; cv=none; b=Q/ZqRrSrnHwBV6CUfjr534cxqPdBDvTm1lxhI/4c9kCYF90C6vt+BNGYRQ/GZ64n21x2oMWCpnDKU9eaN6n4sIijf7icRSNe5a0KUjx4j539o8+uUF+hi+4H0xyfpJX+LIYeRjmbEH1nLCUwj9/TQSUX2i/FcwWKR/fSErO+zwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165603; c=relaxed/simple;
	bh=b2AErcy4JiasUYk6Ay8Qa4qaZtrlk5T4baTDWxVHQj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EvOPjhpvkzyqc1/bQ0mxRdBjRR8a5zBZ+f4BomzI6r5I0CYPmlhzcojAKl+1Iz/Hkbx0CwxGWbRGdLMrDpaQe70wAisCjblEpsmBsFcOu3ANQ5inejWBJIlAvc/RXc+jEZ8eZ4CEcL+w8BC99yIyjvncuR7U/24rfOZW2MLk28s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=a0oZlCgQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb72d51dcso115297966b.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755165599; x=1755770399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lmcz013S0LSVkr6atlRSjhkmTXgOh1M6jbvUAXVLpHU=;
        b=a0oZlCgQoUFRhwjzyFzBHPiG0lPcixWUC2uMnd7t6FC9gSZBl2PkZyJXqiikIWWfWp
         yQI4s7dDH5vfuT3kbqdKwVF1efiL4X4aeTRbiR3/8FrnrsSNEiqx0YdmoUU2HHE01Uxu
         zJER2WBw7du18Dm0Kekuw2Df7osC5z6ampz9qPVBsiFVu/I6biNRNOq5ClROpqombYGt
         G4h2zaqxAqSZjyFGB6oHR0X6oLS8g0ShUeL7sy6NBV/1wBL/WBCeyowUKWIrPgTiRKRf
         3TEM54aIO9c4eGMNlOWe4kd4PD4Ht54A1Q4YsKX7kDKF7QLKijqNogn/fQAazyg0cLg+
         NeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165599; x=1755770399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lmcz013S0LSVkr6atlRSjhkmTXgOh1M6jbvUAXVLpHU=;
        b=L7iYx3XyPeMlXHe0EczBAtqMjvWzB2PGiLLLMB3FYJajD1+H0Ic58E+gtgysFJ7lVM
         0SJY/V/mmqeiCmNbgGztDhvRYbDq5HMPyL4ImvXwvKRmoTSFw87dx3hYtQSQQtnxpab6
         8jTRVrbZK4NhxBCh6nGi0eze/3dyX2O3/YZJ/s4nhK3SND5ppTpm/qUaGNo9jtS+gZKf
         BG6aPpiS91Yt8DLpXET7nWXvzizBLlmYXKbZjYe0PX7CNikN1CDL0gObM7yDtlz1gUVI
         EURqyZzLENxp3kB6SMDUrTIjFMX14CYfFP4qlDGO95VPAoe/cLXXOIWe3PdD/g916XHC
         7C5A==
X-Forwarded-Encrypted: i=1; AJvYcCUmWthaqsnI3eOFqurz69ffpyt5ldeN1MQEN/m0SxotU/2e/IfAgJkAvmjJ1oLHJUD/VIDTfhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4JGeg2rRaG4ZT53+qint4opF5BZHsTk+yJVaYGpIxhqGI9Cb
	OTB/Msk89oHxAvX40UDP16ub+nll1E2LRJhPdlXm/DC3f3U7rNNR/EQY19sUgjb7cS8=
X-Gm-Gg: ASbGnctWkZWtpCr1ayC50XH6vpa2V2Qd9iGYddS9n1deUF4t3ztLaHp+YVdbgkAYkrV
	DSWJen37fVOr1QnUIja+m+yJdAuSt2h0ohq/I6Kf2rnpsf+3wTl2m0G/oBs7Rqpmw+RGC6OHX3/
	6c0vgp4CYfsovy6VM98qZD1L9G6M9vStv9kwNn0rLiIIPdD4sflxx3IY00SSEOqB9RtBbQiqTF0
	5/A0a4XRzoG9vyMbNn0ntVVYzidrS/3J4KQmJ+7o0dK2hTVAtwbniH9Z2qEZ3gg6h6VSkq3zpKw
	L6JFWQ3xDpfTqWexlq3xGC2108Fx78B6jbbbIJauiYNgxNDCimiTwAfevtCVjkK2gI8EOaoVwJo
	KArESIx9m6zVHnihLrWxr
X-Google-Smtp-Source: AGHT+IG/ningBx90EEwskXezwr8bZtPdvqcgWVmYKQsGbkjF1EPwe0KyKEO1pIdvAS3PeIGigvay5Q==
X-Received: by 2002:a17:907:7f0d:b0:af9:d300:c60f with SMTP id a640c23a62f3a-afcb981f2e3mr238197066b.18.1755165599232;
        Thu, 14 Aug 2025 02:59:59 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:f6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a218cf8sm2583442066b.95.2025.08.14.02.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:59:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 14 Aug 2025 11:59:33 +0200
Subject: [PATCH bpf-next v7 7/9] selftests/bpf: Cover write access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-skb-metadata-thru-dynptr-v7-7-8a39e636e0fb@cloudflare.com>
References: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
In-Reply-To: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
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


