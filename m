Return-Path: <netdev+bounces-208555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64489B0C1CE
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFEB18C2A9A
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5190E2900BD;
	Mon, 21 Jul 2025 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MFkdeF4F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B02900AD
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095221; cv=none; b=TOlaaQd8wVP1mSf39G7zp4SwkilzRxGgkDBoCtv/BQ4nm72S4amgZZqyDIRx3oUrSQEtw0qsnfrLftG9W1/BTAEH/Z29tEkDUQYXZRe+Y6CbtlBocj6uhRlvPMP/pGp/2Cupe3L6r+E6vDsGWmomFRiUirSxfFez8c9kVQZOVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095221; c=relaxed/simple;
	bh=1VeC0Bst/qavR/sZr8Bgye9/OdJISuMcXIl5uK3f/hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmbcXomSA/cB4kl66xb2fc2J1S4Vln9hFC6n/hMJza8o/XLeWqQ9BoahQmGCrihytxhIrco2OG0WXIRjRgpIWMX0qAYxaXWveUApZwhSzffmLC49pFc0NFbu52X5GiGqwprU6gfxL/dY6gtJ5vo1OTPV0jap1Q7KYAwujazLYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MFkdeF4F; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso7361608a12.2
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 03:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095218; x=1753700018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqDbhqgwJ6TjrNDZdwjZKXUlPl5k+0lUCuPN0gRPr+Y=;
        b=MFkdeF4F0GSEOrOmJnOvbUqFcLErIuYQWxqcbE/NxORpedp2ByEVrNFGmNYpaxS6v4
         pQdzAZKbrV05gI7hP/vyWO+TnURvQY6Y5z2MJ7KliOK/z6omv2Eb7ydm9bKoJkLAlQ+q
         yCGxmUDYv7YRK0rI1IV3t9zdT+im7HDo6lPqh0c0H2RAgpFEWRmFGmS2/Pok31f2Ij2P
         kj5ZplDgv7G32OgR0w7GzUdIc1WWfklEhG17CD9StrnRRvnqu8X+0gRtfzubJVEzW2Dy
         w+7BifhLTrMQTmmoE3lN2dWYwXsi0x84uXEHLHRmPbbCMeweAskJS2xm0iDPSHcoqVaj
         0qKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095218; x=1753700018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqDbhqgwJ6TjrNDZdwjZKXUlPl5k+0lUCuPN0gRPr+Y=;
        b=K8nW1/HUNaocEp9jZEQpyb8xEDqkrIzV6NbXSPcMf72Ofxty3g8aDiQFFrU/e2DhcV
         MtWG9OD/OXk4gvMtl4CrGJWdiQy6sOsSwCCpWfW2vnvycq8VGdwV8JL/e92l4gNhDEK4
         a0puvFhufzWOG5cYjzP1b6iR0XjfN1uZYE7JYqGj5mm+ZixfXMYRGGebb9AUvdlThRc8
         qRefhITmpjTlSJkxN24D8o7kNgaDuE6W6y+u3GKAyw0SU90qer8YGlU2wZqgE43/QoHb
         AH6hciglU5EFf2rHxHGSItb4q0gTMlulqubVsDG34Ga1ruqmKULD/PyLHaUklNAeDwxk
         efeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5yY5JOZIGPedSEjJhSoc9zAnkVrIaFU5rxymY0b8gHhasxBAoamL6FaNYDU6FaOMevbw4YCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjVtS9XYB5X5fAW6VOYhULk2jWmiBXdYrNfIzM37Ve8TZUZSD
	KMoCnTNWCOq6K3S0ZM0+16s3IOloNQ12x9N+NaHqN2kceAL5qPVKnqnG+E8BUErTgRA=
X-Gm-Gg: ASbGncs0Ellh7xI2CFWvymueZ69077gSYVkDLAVGtcCZ3paG3XQQZ1ajcmNq9eXkrgQ
	gwAbhK7o+Fc/Pr5KfjWyqxdri03phlsTB4FIyL57ujosLWpQuPIVnJ7j5jBu/mzorpci/0ENYaf
	ej2xovq8cq5/4jHO74isKAFst0sNVfKeSgYK6OLxRbE/kC9oo7BDw+oV8vsgTvzcarMN0IjjIhD
	KY/Ix/zGjqcemjU4H7s5URn+kSoW1YP607+qpIolb1Edsep5w0X22CYcUESPan5f5hbP62krrHt
	Q1P6btPBjXBPNQBUHjzSwVkteQ81d16zGpQPymLeoIWk9jQz87+bKfPJ61+0nDI/joyNdZZW+sB
	8RFvPmZWG/OENhg==
X-Google-Smtp-Source: AGHT+IEHAEtVyzZJ4EOLp3zKbdJHhu1OQhr8n0ZAXOVGmeLTv0N6hDurHC6p+JZRpk8mpp2Luae3sQ==
X-Received: by 2002:a17:907:b1a:b0:ae3:cc60:8cf0 with SMTP id a640c23a62f3a-ae9ce0b938cmr1324880366b.34.1753095217650;
        Mon, 21 Jul 2025 03:53:37 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7a08c5sm657919666b.33.2025.07.21.03.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:36 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 21 Jul 2025 12:52:47 +0200
Subject: [PATCH bpf-next v3 09/10] selftests/bpf: Cover write access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-9-e92be5534174@cloudflare.com>
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

Add tests what exercise writes to skb metadata in two ways:
1. indirectly, using bpf_dynptr_write helper,
2. directly, using a read-write dynptr slice.

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


