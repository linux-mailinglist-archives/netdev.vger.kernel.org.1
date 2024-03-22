Return-Path: <netdev+bounces-81284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A6886DF3
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 15:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E031F21BB8
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974546525;
	Fri, 22 Mar 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="e+vJimGa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D74654F
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116096; cv=none; b=ODYqteTgGL+LvqCH3qiCYeQsrr3S8y0V/hQBbQPeMfEqzIqVW870HqPmY1dZFSM9s0E2GsEQmSZyNR3+fXTSrhz4PaQKeQV3evLyEYx2oXj5iy3FdFP7CDzMUEj9h6JUFHotDcbB8kKuA/vhfWjQ2KbFw/TJ5Bl0WLOWBAwPkDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116096; c=relaxed/simple;
	bh=37sATqIfOVQKqYJxCGJHJ1kkNfxACMIdUeredky+p3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sAKHTxoWGwHJZoKt8ofP3iQ3dtqz5RWZCkpRfEkJujz4UiJ7kAe67qX3F5St1Lbz24F1GIb5OVOMIo/Q+zXD4luYZOoKxC4r41D3UDCoo3Ag4Z8k5NZbNlkwxvF94ryyWJJ3LVuVbYBzrbBCeTmdeR+yFEKuC1NHX9xPEBZ8tac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=e+vJimGa; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44f2d894b7so278089066b.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711116093; x=1711720893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z6I1b9v/tSQz/PCer32Tf2+7TWdp28O89hdLhsR+Ic=;
        b=e+vJimGaOpxv34gqksgTy+58cF4XnZDLFUdRtj7mfrW2L2mRQsEXGLdjYbrUwnQ53x
         FG43XCV2GRM9gJZEVdIRHd3vXdNPKkQ7va0SRyDm4XWA4FZreYKw1iAjt/Fn6mHpcWBl
         SmmHn5WpeKmTe1FuTHmo38e6FseiTW8Z/JSumznvo3LecOSRfRWkoSjuS2ny8ofjeLLZ
         qOKolAnq2RwVCGn6XCwe+fksi1vWeSd7bZVnhTpXrca9Qpy2ELaFDHUIEkK5Zm8WSynN
         NHmbzPVwd9s/yXQBrPXyzdbRBpFw1B6uFlac06IeZdraFhK6olgre9cPCFJCR1skpc9Z
         OxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116093; x=1711720893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z6I1b9v/tSQz/PCer32Tf2+7TWdp28O89hdLhsR+Ic=;
        b=sLu3SgmcTqeoJqhKFYgAymPrE8/Cp85GK/miv8cxM8cE6N+Zq7v5SoasFkuRWyTCW1
         YjP8FqxsQIdY0W6xUYwJujE+RoRArfeHi3dEWdbIyQHuskVpd9xvrPUNCnisZqB4A28r
         vCJn0c+GzM461shDF/KyIPJUIz4Rx/9sBffTvsPstabXlW6+dX17MAzK7Eat2bovBzdT
         M840hkzNeQnOaxvLPultyKTYSIvvuQnlOReBKe/TDvHaE3aKT6nLVoIM9IBGcCkGFrJl
         2PDjaV+Y9r1ijLKLkucHHBmB+k805IYw31R5li75grbhdTXQDODdobjaOKrxJRXsmSFk
         eCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/on3AIhNTN3Eg9WFbxYfEjlzS/dWH8tFZEAsc4OOT9XqtQF1yOoJE2FVRT7wT4B9wPyyDWMq5tqC8okuvLQflD5CdmnsG
X-Gm-Message-State: AOJu0YyICLTINi65HtFJIgjoWwqPnSd/u9KbmxqGFFmt1InvlCeyQVd6
	zrXmStUcK6fvSui3AHuSUQWf6r5Ty3BWuLeIQ2ZLsHqkYZ6WH3RK3UNZsn3/qcM=
X-Google-Smtp-Source: AGHT+IHR6DPJ1Z00OjpqibWUOS9hytyGFwmNN6UiY3cJ1Lo943ah4uOIK6gYyjK24h1TB/lBXrjeEg==
X-Received: by 2002:a17:906:b816:b0:a47:3062:c768 with SMTP id dv22-20020a170906b81600b00a473062c768mr1134480ejb.13.1711116093053;
        Fri, 22 Mar 2024 07:01:33 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709063e8600b00a45ffe583acsm1038929ejj.187.2024.03.22.07.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:01:31 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 2/2] selftests/bpf: Add BPF_FIB_LOOKUP_MARK tests
Date: Fri, 22 Mar 2024 14:02:44 +0000
Message-Id: <20240322140244.50971-3-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322140244.50971-1-aspsk@isovalent.com>
References: <20240322140244.50971-1-aspsk@isovalent.com>
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

To test this functionality another network namespace and a new veth
pair were added to the test.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/fib_lookup.c     | 160 ++++++++++++++----
 1 file changed, 131 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index 3379df2d4cf2..a78316431f32 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -10,6 +10,7 @@
 #include "fib_lookup.skel.h"
 
 #define NS_TEST			"fib_lookup_ns"
+#define NS_REMOTE		"remote_ns"
 #define IPV6_IFACE_ADDR		"face::face"
 #define IPV6_IFACE_ADDR_SEC	"cafe::cafe"
 #define IPV6_ADDR_DST		"face::3"
@@ -26,6 +27,17 @@
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
@@ -36,9 +48,12 @@ struct fib_lookup_test {
 	const char *daddr;
 	int expected_ret;
 	const char *expected_src;
+	const char *expected_dst;
 	int lookup_flags;
 	__u32 tbid;
 	__u8 dmac[6];
+	__u32 mark;
+	const char *ifname;
 };
 
 static const struct fib_lookup_test tests[] = {
@@ -90,10 +105,47 @@ static const struct fib_lookup_test tests[] = {
 	  .daddr = IPV6_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
 	  .expected_src = IPV6_IFACE_ADDR_SEC,
 	  .lookup_flags = BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	/* policy routing */
+	{ .desc = "IPv4 policy routing, default",
+	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_GW1, .ifname = "veth3",
+	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv4 policy routing, mark doesn't point to a policy",
+	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_GW1, .ifname = "veth3",
+	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .mark = MARK_NO_POLICY, },
+	{ .desc = "IPv4 policy routing, mark points to a policy",
+	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_GW2, .ifname = "veth3",
+	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .mark = MARK, },
+	{ .desc = "IPv4 policy routing, mark points to a policy, but no flag",
+	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_GW1, .ifname = "veth3",
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .mark = MARK, },
+	{ .desc = "IPv6 policy routing, default",
+	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV6_GW1, .ifname = "veth3",
+	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv6 policy routing, mark doesn't point to a policy",
+	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV6_GW1, .ifname = "veth3",
+	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .mark = MARK_NO_POLICY, },
+	{ .desc = "IPv6 policy routing, mark points to a policy",
+	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV6_GW2, .ifname = "veth3",
+	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .mark = MARK, },
+	{ .desc = "IPv6 policy routing, mark points to a policy, but no flag",
+	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV6_GW1, .ifname = "veth3",
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .mark = MARK, },
 };
 
-static int ifindex;
-
 static int setup_netns(void)
 {
 	int err;
@@ -144,12 +196,40 @@ static int setup_netns(void)
 	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth1.forwarding)"))
 		goto fail;
 
+	/* Setup for policy routing tests */
+	SYS(fail, "ip link add veth3 type veth peer name veth4");
+	SYS(fail, "ip link set dev veth3 up");
+	SYS(fail, "ip link set dev veth4 netns %s up", NS_REMOTE);
+
+	SYS(fail, "ip addr add %s/24 dev veth3", IPV4_LOCAL);
+	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW1);
+	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW2);
+	SYS(fail, "ip addr add %s/64 dev veth3 nodad", IPV6_LOCAL);
+	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW1);
+	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW2);
+	SYS(fail, "ip route add %s/32 via %s", IPV4_REMOTE_DST, IPV4_GW1);
+	SYS(fail, "ip route add %s/32 via %s table %s", IPV4_REMOTE_DST, IPV4_GW2, MARK_TABLE);
+	SYS(fail, "ip -6 route add %s/128 via %s", IPV6_REMOTE_DST, IPV6_GW1);
+	SYS(fail, "ip -6 route add %s/128 via %s table %s", IPV6_REMOTE_DST, IPV6_GW2, MARK_TABLE);
+	SYS(fail, "ip rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
+	SYS(fail, "ip -6 rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
+
+	err = write_sysctl("/proc/sys/net/ipv4/conf/veth3/forwarding", "1");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.conf.veth3.forwarding)"))
+		goto fail;
+
+	err = write_sysctl("/proc/sys/net/ipv6/conf/veth3/forwarding", "1");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth3.forwarding)"))
+		goto fail;
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
 
@@ -159,6 +239,9 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_loo
 	params->ifindex = ifindex;
 	params->tbid = test->tbid;
 
+	if (test->lookup_flags & BPF_FIB_LOOKUP_MARK)
+		params->mark = test->mark;
+
 	if (inet_pton(AF_INET6, test->daddr, params->ipv6_dst) == 1) {
 		params->family = AF_INET6;
 		if (!(test->lookup_flags & BPF_FIB_LOOKUP_SRC)) {
@@ -190,40 +273,45 @@ static void mac_str(char *b, const __u8 *mac)
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
@@ -231,6 +319,7 @@ void test_fib_lookup(void)
 	struct __sk_buff skb = { };
 	struct fib_lookup *skel;
 	int prog_fd, err, ret, i;
+	int default_ifindex;
 
 	/* The test does not use the skb->data, so
 	 * use pkt_v6 for both v6 and v4 test.
@@ -248,6 +337,7 @@ void test_fib_lookup(void)
 	prog_fd = bpf_program__fd(skel->progs.fib_lookup);
 
 	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip netns add %s", NS_REMOTE);
 
 	nstoken = open_netns(NS_TEST);
 	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
@@ -256,15 +346,23 @@ void test_fib_lookup(void)
 	if (setup_netns())
 		goto fail;
 
-	ifindex = if_nametoindex("veth1");
-	skb.ifindex = ifindex;
+	default_ifindex = if_nametoindex("veth1");
+	if (!ASSERT_NEQ(default_ifindex, 0, "if_nametoindex(veth1)"))
+		goto fail;
+
 	fib_params = &skel->bss->fib_params;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		printf("Testing %s ", tests[i].desc);
 
-		if (set_lookup_params(fib_params, &tests[i]))
+		if (tests[i].ifname)
+			skb.ifindex = if_nametoindex(tests[i].ifname);
+		else
+			skb.ifindex = default_ifindex;
+
+		if (set_lookup_params(fib_params, &tests[i], skb.ifindex))
 			continue;
+
 		skel->bss->fib_lookup_ret = -1;
 		skel->bss->lookup_flags = tests[i].lookup_flags;
 
@@ -278,6 +376,9 @@ void test_fib_lookup(void)
 		if (tests[i].expected_src)
 			assert_src_ip(fib_params, tests[i].expected_src);
 
+		if (tests[i].expected_dst)
+			assert_dst_ip(fib_params, tests[i].expected_dst);
+
 		ret = memcmp(tests[i].dmac, fib_params->dmac, sizeof(tests[i].dmac));
 		if (!ASSERT_EQ(ret, 0, "dmac not match")) {
 			char expected[18], actual[18];
@@ -299,5 +400,6 @@ void test_fib_lookup(void)
 	if (nstoken)
 		close_netns(nstoken);
 	SYS_NOFAIL("ip netns del " NS_TEST);
+	SYS_NOFAIL("ip netns del " NS_REMOTE);
 	fib_lookup__destroy(skel);
 }
-- 
2.34.1


