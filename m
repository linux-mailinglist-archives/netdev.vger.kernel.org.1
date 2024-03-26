Return-Path: <netdev+bounces-81965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1291088BF10
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4268AB2596A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F8F6CDBC;
	Tue, 26 Mar 2024 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="MrfR0vut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D116BFB8
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448146; cv=none; b=aOivKvnt83xzkW8gD5gNfIkVp7AYlaHn5aJmI2E/OmFyCROlenYRXUcntvNxxD9iSbjSA8VScGatt/esJr+h7+DZdD+Dq01Y5/wvXaeSwWsdqPdyUKvMdDoio+MWBRbGIUPKo831Kxw4YdZSf1gYMCjq/ntECAZnGFbC+jq/vgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448146; c=relaxed/simple;
	bh=tBBi8raaoO2Uqv8I9/XItWw3LIwwFKRlGX/aHgTQ/Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BrPg/3d1Kw+FScxBpEYf2ayDUdLs1HKN7mHDo9/MpalfJgozo+kEOxqRodobllmNiVEyZcdujeYpOzuNyXSVQPiDGN7+Fqg1jKMod/YeSj5GeNt6n2JoxEHBrIX4gvK/L+M9TgIB8NDDDJ8RFXP3fD3kKyRuxktk8sOUYtnh3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=MrfR0vut; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41400a9844aso36018925e9.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711448142; x=1712052942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYqtiSbqf05DHjjvR8Yxkw8mBR9Iefhr2bdsOkQZWik=;
        b=MrfR0vut7jcZeEBaK/EGsqnsh9N1cwN7vNBgUK5gxRZf2A8xBXualNH5btrM5kV806
         eTZcy+lCXCbrFo9gzEmrXFb4biSAAv66SvjzGpt7suDflSb6DOzqaBu9VS7JscM6BOtM
         FfPXTYffbT7rBFapSiAbJHp1wTryLE94aR3d8j8sz0n6CY/C7xdercgnRmbsMjoDpkbj
         6vUBIZgbZ7JdAutdTksbYzEZYQiYZ5VgtbQETcdWcAWZGewdKKvDg1iH+LEqsihPVCU2
         hU8myX0hg5A9VL3/FOudXqLoIdlTxVvbS8d+HsFpwXrQiag83rYGYyS9GJPGGzJCKBlH
         LB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448142; x=1712052942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYqtiSbqf05DHjjvR8Yxkw8mBR9Iefhr2bdsOkQZWik=;
        b=raAI3x+D+je7gByVtcgYFqJwmau1Lm+H6gHjTg9giLLcmeuoCQPShfbw5GMBll3kky
         hck8jGxwOhHXXzmDRjlTmypuYVHuXEaRE5XD7A0mbqzTy0QiaBSqFhA/lnz/qJheVopd
         2mVQRcTNsyPakmr1HWhUNZKim1rKZXF1lFoFlRUpc+IJc/5FkiyYqYMGsyfRRuS7Aj0b
         EQz2dw0lq3rEZe6+18B/53gyg/W9SJ6DIF7SwbFes9JpRE0C/pqwgsHSPmZbVrJYTFOZ
         +r3aQdn7DLKF9U2DeggCniHFVj7KxZNcQeGWwfyVgrt4QzoVwUCZwKgVfZgpSq1dOc6H
         7zDw==
X-Forwarded-Encrypted: i=1; AJvYcCVztLQNEs2wCfMxpJBfg7F7x2WHASDuVwPutZ+fvj2T5Htz/LkBEegGIDmfMM6Sv3fjyGlgDVQiX8AHFxXHy2GI+JebhYBu
X-Gm-Message-State: AOJu0YzGleWCMfZxla+h6WD7nq+2tLmkG7NHbNcuxznK6F4Yp8FSC9kS
	XvLrn+1P95cntxzFzQ18DOEQuo1BSAMbArM2izvJ/7mBlYcewuUtdyZ1XbMUdCg=
X-Google-Smtp-Source: AGHT+IFqidp5Y88CMG4yTSVfcfofdFUCK542dk+DkiH5LRH+eFr7IwxlLJS9Yi3JSt6XupPWxEIkXg==
X-Received: by 2002:a5d:448f:0:b0:33d:8c9d:419 with SMTP id j15-20020a5d448f000000b0033d8c9d0419mr926281wrq.24.1711448142453;
        Tue, 26 Mar 2024 03:15:42 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id co20-20020a0560000a1400b00341d4722a9asm1891743wrb.21.2024.03.26.03.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:15:41 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v2 bpf-next 2/3] selftests/bpf: Add BPF_FIB_LOOKUP_MARK tests
Date: Tue, 26 Mar 2024 10:17:41 +0000
Message-Id: <20240326101742.17421-3-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326101742.17421-1-aspsk@isovalent.com>
References: <20240326101742.17421-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch extends the fib_lookup test suite by adding a few test
cases for each IP family to test the new BPF_FIB_LOOKUP_MARK flag
to the bpf_fib_lookup:

  * Test destination IP address selection with and without a mark
    and/or the BPF_FIB_LOOKUP_MARK flag set

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/fib_lookup.c     | 134 ++++++++++++++----
 1 file changed, 105 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index 3379df2d4cf2..a003c6ec50bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -26,6 +26,17 @@
 #define IPV6_TBID_ADDR		"fd00::FFFF"
 #define IPV6_TBID_NET		"fd00::"
 #define IPV6_TBID_DST		"fd00::2"
+#define MARK_NO_POLICY		33
+#define MARK			42
+#define MARK_TABLE		"200"
+#define IPV4_REMOTE_DST		"1.2.3.4"
+#define IPV4_LOCAL		"10.4.0.3"
+#define IPV4_GW1		"10.4.0.1"
+#define IPV4_GW2		"10.4.0.2"
+#define IPV6_REMOTE_DST		"be:ef::b0:10"
+#define IPV6_LOCAL		"fd01::3"
+#define IPV6_GW1		"fd01::1"
+#define IPV6_GW2		"fd01::2"
 #define DMAC			"11:11:11:11:11:11"
 #define DMAC_INIT { 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, }
 #define DMAC2			"01:01:01:01:01:01"
@@ -36,9 +47,11 @@ struct fib_lookup_test {
 	const char *daddr;
 	int expected_ret;
 	const char *expected_src;
+	const char *expected_dst;
 	int lookup_flags;
 	__u32 tbid;
 	__u8 dmac[6];
+	__u32 mark;
 };
 
 static const struct fib_lookup_test tests[] = {
@@ -90,10 +103,47 @@ static const struct fib_lookup_test tests[] = {
 	  .daddr = IPV6_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
 	  .expected_src = IPV6_IFACE_ADDR_SEC,
 	  .lookup_flags = BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	/* policy routing */
+	{ .desc = "IPv4 policy routing, default",
+	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_GW1,
+	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv4 policy routing, mark doesn't point to a policy",
+	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_GW1,
+	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .mark = MARK_NO_POLICY, },
+	{ .desc = "IPv4 policy routing, mark points to a policy",
+	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_GW2,
+	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .mark = MARK, },
+	{ .desc = "IPv4 policy routing, mark points to a policy, but no flag",
+	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_GW1,
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .mark = MARK, },
+	{ .desc = "IPv6 policy routing, default",
+	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV6_GW1,
+	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv6 policy routing, mark doesn't point to a policy",
+	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV6_GW1,
+	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .mark = MARK_NO_POLICY, },
+	{ .desc = "IPv6 policy routing, mark points to a policy",
+	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV6_GW2,
+	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .mark = MARK, },
+	{ .desc = "IPv6 policy routing, mark points to a policy, but no flag",
+	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV6_GW1,
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .mark = MARK, },
 };
 
-static int ifindex;
-
 static int setup_netns(void)
 {
 	int err;
@@ -144,12 +194,24 @@ static int setup_netns(void)
 	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth1.forwarding)"))
 		goto fail;
 
+	/* Setup for policy routing tests */
+	SYS(fail, "ip addr add %s/24 dev veth1", IPV4_LOCAL);
+	SYS(fail, "ip addr add %s/64 dev veth1 nodad", IPV6_LOCAL);
+	SYS(fail, "ip route add %s/32 via %s", IPV4_REMOTE_DST, IPV4_GW1);
+	SYS(fail, "ip route add %s/32 via %s table %s", IPV4_REMOTE_DST, IPV4_GW2, MARK_TABLE);
+	SYS(fail, "ip -6 route add %s/128 via %s", IPV6_REMOTE_DST, IPV6_GW1);
+	SYS(fail, "ip -6 route add %s/128 via %s table %s", IPV6_REMOTE_DST, IPV6_GW2, MARK_TABLE);
+	SYS(fail, "ip rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
+	SYS(fail, "ip -6 rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
+
 	return 0;
 fail:
 	return -1;
 }
 
-static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_lookup_test *test)
+static int set_lookup_params(struct bpf_fib_lookup *params,
+			     const struct fib_lookup_test *test,
+			     int ifindex)
 {
 	int ret;
 
@@ -159,6 +221,9 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_loo
 	params->ifindex = ifindex;
 	params->tbid = test->tbid;
 
+	if (test->lookup_flags & BPF_FIB_LOOKUP_MARK)
+		params->mark = test->mark;
+
 	if (inet_pton(AF_INET6, test->daddr, params->ipv6_dst) == 1) {
 		params->family = AF_INET6;
 		if (!(test->lookup_flags & BPF_FIB_LOOKUP_SRC)) {
@@ -190,40 +255,45 @@ static void mac_str(char *b, const __u8 *mac)
 		mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
 }
 
-static void assert_src_ip(struct bpf_fib_lookup *fib_params, const char *expected_src)
+static void assert_ip_address(int family, void *addr, const char *expected_str)
 {
+	char str[INET6_ADDRSTRLEN];
+	u8 expected_addr[16];
+	int addr_len = 0;
 	int ret;
-	__u32 src6[4];
-	__be32 src4;
 
-	switch (fib_params->family) {
+	switch (family) {
 	case AF_INET6:
-		ret = inet_pton(AF_INET6, expected_src, src6);
-		ASSERT_EQ(ret, 1, "inet_pton(expected_src)");
-
-		ret = memcmp(src6, fib_params->ipv6_src, sizeof(fib_params->ipv6_src));
-		if (!ASSERT_EQ(ret, 0, "fib_lookup ipv6 src")) {
-			char str_src6[64];
-
-			inet_ntop(AF_INET6, fib_params->ipv6_src, str_src6,
-				  sizeof(str_src6));
-			printf("ipv6 expected %s actual %s ", expected_src,
-			       str_src6);
-		}
-
+		ret = inet_pton(AF_INET6, expected_str, expected_addr);
+		ASSERT_EQ(ret, 1, "inet_pton(AF_INET6, expected_str)");
+		addr_len = 16;
 		break;
 	case AF_INET:
-		ret = inet_pton(AF_INET, expected_src, &src4);
-		ASSERT_EQ(ret, 1, "inet_pton(expected_src)");
-
-		ASSERT_EQ(fib_params->ipv4_src, src4, "fib_lookup ipv4 src");
-
+		ret = inet_pton(AF_INET, expected_str, expected_addr);
+		ASSERT_EQ(ret, 1, "inet_pton(AF_INET, expected_str)");
+		addr_len = 4;
 		break;
 	default:
-		PRINT_FAIL("invalid addr family: %d", fib_params->family);
+		PRINT_FAIL("invalid address family: %d", family);
+		break;
+	}
+
+	if (memcmp(addr, expected_addr, addr_len)) {
+		inet_ntop(family, addr, str, sizeof(str));
+		PRINT_FAIL("expected %s actual %s ", expected_str, str);
 	}
 }
 
+static void assert_src_ip(struct bpf_fib_lookup *params, const char *expected)
+{
+	assert_ip_address(params->family, params->ipv6_src, expected);
+}
+
+static void assert_dst_ip(struct bpf_fib_lookup *params, const char *expected)
+{
+	assert_ip_address(params->family, params->ipv6_dst, expected);
+}
+
 void test_fib_lookup(void)
 {
 	struct bpf_fib_lookup *fib_params;
@@ -256,15 +326,18 @@ void test_fib_lookup(void)
 	if (setup_netns())
 		goto fail;
 
-	ifindex = if_nametoindex("veth1");
-	skb.ifindex = ifindex;
+	skb.ifindex = if_nametoindex("veth1");
+	if (!ASSERT_NEQ(skb.ifindex, 0, "if_nametoindex(veth1)"))
+		goto fail;
+
 	fib_params = &skel->bss->fib_params;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		printf("Testing %s ", tests[i].desc);
 
-		if (set_lookup_params(fib_params, &tests[i]))
+		if (set_lookup_params(fib_params, &tests[i], skb.ifindex))
 			continue;
+
 		skel->bss->fib_lookup_ret = -1;
 		skel->bss->lookup_flags = tests[i].lookup_flags;
 
@@ -278,6 +351,9 @@ void test_fib_lookup(void)
 		if (tests[i].expected_src)
 			assert_src_ip(fib_params, tests[i].expected_src);
 
+		if (tests[i].expected_dst)
+			assert_dst_ip(fib_params, tests[i].expected_dst);
+
 		ret = memcmp(tests[i].dmac, fib_params->dmac, sizeof(tests[i].dmac));
 		if (!ASSERT_EQ(ret, 0, "dmac not match")) {
 			char expected[18], actual[18];
-- 
2.34.1


