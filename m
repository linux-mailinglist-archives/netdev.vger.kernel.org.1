Return-Path: <netdev+bounces-235986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E226C37B2C
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C25018863C4
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A364A34E755;
	Wed,  5 Nov 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aTjUS4OY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58034CFC2
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374008; cv=none; b=ZGmsgoLp16TyiXJBeIcTIS061wtJRUQrZUxQN11JbAK5dX4CVSU3PeOlYoQyX0l8bfY2qxQKHkyWNrjtxHu2zcZPsoA9PWMVovCk20OHFYRl1naaVv/dc6lx4QQdL01jBStbGP9HOIDqZuVT2RkU/9B44aN2E2wk0/6ZYQhGIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374008; c=relaxed/simple;
	bh=4TfFid1Q979uRTwKiHMvMpp33YFmvZtP/kUKMyZ8CWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKr+QQnuJiYDXNiGh2htL/rveUE6t9n0l7rms6By/GCx9YPGiuPqwmdaoTF6A8lqrGDOBfLVuPrVWw131NETFRP9UA9TgsIonvot/ZId7TeWd/cQTlY65G1/d1eip/Sx8NrszjO2aQ3clZYf/tmpVrMIVagTE3805INfp60DOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aTjUS4OY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640741cdda7so254965a12.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 12:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374004; x=1762978804; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edqy55xm7sHdms5uig9C4VS/gSulJmnweBVEeyzGNWw=;
        b=aTjUS4OYxkRZ0h1uC+ETlCBt14do94DfsxxmkHRmuYMdBB3NHG4tld/zf3UO0VNBGD
         nkgijoYQVgr4j9mvesdoTwrW1yviO6Ha5Z1WEzEiC6kn5VOU/a8dzJn0jBS9NBM6c96B
         6C6z/OkixG3VSWU5xF2zLjdxnWhDvRh0lKPvGI8kU4MGcbmRQzDwgkzZQZJLK/doLNUJ
         juMOXs7Y5GYlofF2sqZuywWS0SfX3xWXy10D4bvVYrrgsY8CvouMBmrhIK2hfn4pzsaJ
         9cYHI616GfZUw684n2gXWS/T5VmudjjS8VSj+9BhagVo+XwYCEYJLiVoEQUGqMPfdFnR
         bcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374004; x=1762978804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edqy55xm7sHdms5uig9C4VS/gSulJmnweBVEeyzGNWw=;
        b=MjQZE30IDg8pZe5+w9KlnSUq1Wlu3UqkfeVuAQaZq38uCCdaSKuT/d3qFTqYYhjtQE
         75OFh25OTEtH8riU1tvLJUnZE8HJhVgyoIP2ljUPqLy59SaGOatYh6jDyK4UXJpr5YRt
         UnaxBBmZDDo5Gp6+qCButuRDhnGsas9tX0BMXLjhBG1j0OiBfOHT8rZqIajEU76urNfL
         SvS5mlLqOpjoX0N+yB4XM/TwI84Tghb0ax0xEb6B2C+dI576TwEyzVg3Ni0/ggGO26w1
         VMgJd0jzWhTtdryMS1LLJseTp2A/10z4bGX9L3zUCF3zCVzYu9KPAJpN2hNqGuRFPQaA
         zxGA==
X-Forwarded-Encrypted: i=1; AJvYcCU/JWxh+cOTXxt7RJL1bbYFR+/YMydD7fa119vCMLZcE+8TpgSrNo6mDCLCQelNF2uFkiSrgoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxleLPya4qUly9CkC6jtMZ/QGM3ySWiRBPfUcXU4ubvv45CYujh
	0cWgdYMSSdZTT3FVdCZ0vXOfj5odXZNNyLDFJ3zT80O0sB+oeVzGEUrhmaL8pj98DvE=
X-Gm-Gg: ASbGncsr+mwKCQ/FGRC/vDA5wlKkMEPXUtnUyGoDsZHw+yP25djotZ+RuoZM90XzaGW
	sLyqvbKFej31eyrcwFEqiMAmNlgb1lz5z/tc+mmBdC6AOgL4hIf9o7+NGEN9hlDckPveNaiRpJK
	oU/aNuZyxZ8JMuKaNEv24KxQucuWZfkTkLIBcH6LNV5Ux/mXDjYyym16VI3t50Mz1xXAXol6OTg
	d21s3dyfkSqZsMhMXG8BfjFPZsLg4RHEd96YHzLSpBMdj7xEAwGwuFUI50ovucmLRc6spr6zdju
	cuzTg4rBmCto9KfgngcpBcbbP5YStEMfiE4OGtBbaxyg6zvulX/ay14QjtcsdYLaXBFvBZHuYZE
	gY7vv9D8tRUAF7L9WUYCXj5+Idz5D0yBPBNSmnwKeawFZYQjCov/tUzXR8HZoAsNgZsLT9bCCQv
	C8YVvcVqZ6wGDsxxm7NuwXH+8g887opRl9KzWuwbaDyF69zw==
X-Google-Smtp-Source: AGHT+IFrqJ6al0lDu3PofAXR5qlKWjhGh9mRUvCnbM0H+DY6ACNXkq2M4g+ndn0ZO7Jvi6dZw8j+tw==
X-Received: by 2002:a17:907:9483:b0:b04:5a74:b674 with SMTP id a640c23a62f3a-b72655cdd06mr377096566b.58.1762374004172;
        Wed, 05 Nov 2025 12:20:04 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896848a5sm42293666b.57.2025.11.05.12.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:20:03 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:47 +0100
Subject: [PATCH bpf-next v4 10/16] selftests/bpf: Verify skb metadata in
 BPF instead of userspace
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-10-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Move metadata verification into the BPF TC programs. Previously,
userspace read metadata from a map and verified it once at test end.

Now TC programs compare metadata directly using __builtin_memcmp() and
set a test_pass flag. This enables verification at multiple points during
test execution rather than a single final check.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 52 ++++---------
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 88 +++++++++++-----------
 2 files changed, 57 insertions(+), 83 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 178292d1251a..93a1fbe6a4fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -171,33 +171,6 @@ static int write_test_packet(int tap_fd)
 	return 0;
 }
 
-static void assert_test_result(const struct bpf_map *result_map)
-{
-	int err;
-	__u32 map_key = 0;
-	__u8 map_value[TEST_PAYLOAD_LEN];
-
-	err = bpf_map__lookup_elem(result_map, &map_key, sizeof(map_key),
-				   &map_value, TEST_PAYLOAD_LEN, BPF_ANY);
-	if (!ASSERT_OK(err, "lookup test_result"))
-		return;
-
-	ASSERT_MEMEQ(&map_value, &test_payload, TEST_PAYLOAD_LEN,
-		     "test_result map contains test payload");
-}
-
-static bool clear_test_result(struct bpf_map *result_map)
-{
-	const __u8 v[sizeof(test_payload)] = {};
-	const __u32 k = 0;
-	int err;
-
-	err = bpf_map__update_elem(result_map, &k, sizeof(k), v, sizeof(v), BPF_ANY);
-	ASSERT_OK(err, "update test_result");
-
-	return err == 0;
-}
-
 void test_xdp_context_veth(void)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
@@ -270,11 +243,13 @@ void test_xdp_context_veth(void)
 	if (!ASSERT_GE(tx_ifindex, 0, "if_nametoindex tx"))
 		goto close;
 
+	skel->bss->test_pass = false;
+
 	ret = send_test_packet(tx_ifindex);
 	if (!ASSERT_OK(ret, "send_test_packet"))
 		goto close;
 
-	assert_test_result(skel->maps.test_result);
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
 
 close:
 	close_netns(nstoken);
@@ -286,7 +261,7 @@ void test_xdp_context_veth(void)
 static void test_tuntap(struct bpf_program *xdp_prog,
 			struct bpf_program *tc_prio_1_prog,
 			struct bpf_program *tc_prio_2_prog,
-			struct bpf_map *result_map)
+			bool *test_pass)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
@@ -295,8 +270,7 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	int tap_ifindex;
 	int ret;
 
-	if (!clear_test_result(result_map))
-		return;
+	*test_pass = false;
 
 	ns = netns_new(TAP_NETNS, true);
 	if (!ASSERT_OK_PTR(ns, "create and open ns"))
@@ -340,7 +314,7 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_OK(ret, "write_test_packet"))
 		goto close;
 
-	assert_test_result(result_map);
+	ASSERT_TRUE(*test_pass, "test_pass");
 
 close:
 	if (tap_fd >= 0)
@@ -431,37 +405,37 @@ void test_xdp_context_tuntap(void)
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls,
 			    NULL, /* tc prio 2 */
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("dynptr_read"))
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls_dynptr_read,
 			    NULL, /* tc prio 2 */
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("dynptr_slice"))
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls_dynptr_slice,
 			    NULL, /* tc prio 2 */
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("dynptr_write"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_write,
 			    skel->progs.ing_cls_dynptr_read,
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("dynptr_slice_rdwr"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_slice_rdwr,
 			    skel->progs.ing_cls_dynptr_slice,
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("dynptr_offset"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_offset_wr,
 			    skel->progs.ing_cls_dynptr_offset_rd,
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("dynptr_offset_oob"))
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls_dynptr_offset_oob,
 			    skel->progs.ing_cls,
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("clone_data_meta_empty_on_data_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
 				   skel->progs.clone_data_meta_empty_on_data_write,
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index d79cb74b571e..11288b20f56c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -11,37 +11,36 @@
 
 #define ctx_ptr(ctx, mem) (void *)(unsigned long)ctx->mem
 
-/* Demonstrates how metadata can be passed from an XDP program to a TC program
- * using bpf_xdp_adjust_meta.
- * For the sake of testing the metadata support in drivers, the XDP program uses
- * a fixed-size payload after the Ethernet header as metadata. The TC program
- * copies the metadata it receives into a map so it can be checked from
- * userspace.
+/* Demonstrate passing metadata from XDP to TC using bpf_xdp_adjust_meta.
+ *
+ * The XDP program extracts a fixed-size payload following the Ethernet header
+ * and stores it as packet metadata to test the driver's metadata support. The
+ * TC program then verifies if the passed metadata is correct.
  */
 
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__uint(value_size, META_SIZE);
-} test_result SEC(".maps");
-
 bool test_pass;
 
+static const __u8 meta_want[META_SIZE] = {
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
+	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+};
+
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
-	__u8 *data, *data_meta;
-	__u32 key = 0;
-
-	data_meta = ctx_ptr(ctx, data_meta);
-	data      = ctx_ptr(ctx, data);
+	__u8 *meta_have = ctx_ptr(ctx, data_meta);
+	__u8 *data = ctx_ptr(ctx, data);
 
-	if (data_meta + META_SIZE > data)
-		return TC_ACT_SHOT;
+	if (meta_have + META_SIZE > data)
+		goto out;
 
-	bpf_map_update_elem(&test_result, &key, data_meta, BPF_ANY);
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+		goto out;
 
+	test_pass = true;
+out:
 	return TC_ACT_SHOT;
 }
 
@@ -49,17 +48,17 @@ int ing_cls(struct __sk_buff *ctx)
 SEC("tc")
 int ing_cls_dynptr_read(struct __sk_buff *ctx)
 {
+	__u8 meta_have[META_SIZE];
 	struct bpf_dynptr meta;
-	const __u32 zero = 0;
-	__u8 *dst;
-
-	dst = bpf_map_lookup_elem(&test_result, &zero);
-	if (!dst)
-		return TC_ACT_SHOT;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	bpf_dynptr_read(dst, META_SIZE, &meta, 0, 0);
+	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+		goto out;
 
+	test_pass = true;
+out:
 	return TC_ACT_SHOT;
 }
 
@@ -86,20 +85,18 @@ SEC("tc")
 int ing_cls_dynptr_slice(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr meta;
-	const __u32 zero = 0;
-	__u8 *dst, *src;
-
-	dst = bpf_map_lookup_elem(&test_result, &zero);
-	if (!dst)
-		return TC_ACT_SHOT;
+	__u8 *meta_have;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	src = bpf_dynptr_slice(&meta, 0, NULL, META_SIZE);
-	if (!src)
-		return TC_ACT_SHOT;
+	meta_have = bpf_dynptr_slice(&meta, 0, NULL, META_SIZE);
+	if (!meta_have)
+		goto out;
 
-	__builtin_memcpy(dst, src, META_SIZE);
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+		goto out;
 
+	test_pass = true;
+out:
 	return TC_ACT_SHOT;
 }
 
@@ -129,14 +126,12 @@ int ing_cls_dynptr_slice_rdwr(struct __sk_buff *ctx)
 SEC("tc")
 int ing_cls_dynptr_offset_rd(struct __sk_buff *ctx)
 {
-	struct bpf_dynptr meta;
 	const __u32 chunk_len = META_SIZE / 4;
-	const __u32 zero = 0;
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
 	__u8 *dst, *src;
 
-	dst = bpf_map_lookup_elem(&test_result, &zero);
-	if (!dst)
-		return TC_ACT_SHOT;
+	dst = meta_have;
 
 	/* 1. Regular read */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
@@ -155,9 +150,14 @@ int ing_cls_dynptr_offset_rd(struct __sk_buff *ctx)
 	/* 4. Read from a slice starting at an offset */
 	src = bpf_dynptr_slice(&meta, 2 * chunk_len, NULL, chunk_len);
 	if (!src)
-		return TC_ACT_SHOT;
+		goto out;
 	__builtin_memcpy(dst, src, chunk_len);
 
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+		goto out;
+
+	test_pass = true;
+out:
 	return TC_ACT_SHOT;
 }
 

-- 
2.43.0


