Return-Path: <netdev+bounces-211568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55B5B1A26A
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839DC16A263
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C700126E701;
	Mon,  4 Aug 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S/hH96Zl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7CF25D212
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311983; cv=none; b=nGTdpxqZ+9+S3sXDQTAlt8aByzMcMIEBfGMUblvh6vJawp944ZkIiHkWTCVYtPLoEyrYWX108LZBL1czGd16xMcKsxVWbdc4/EqaeUzgdmEgxb4GE578QhmTdF+8CKvD9bkrBpi7NMMPFCuoSUCy2ArHJEIUUV9bEmrzWEQR+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311983; c=relaxed/simple;
	bh=hs4JAy0dLfj58EnblxsHu01VmyLeXShKcb3UewIRrl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9vemosnPlNDqTosBq2xEWPEsdbinjstlPZy71ADkmyxMPfO1zXr99DHQcl2INeN2Jh4BFDDx37BIFnPNXlleH4X+6MJB7Kv2+jZPo5V9qiVr4YHX1opVk8PNmZRSdRmRUOeF47d/DUsSF5Fg0vF9uLLuCrgbckdpJ/bp0g4FUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S/hH96Zl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so5834519a12.2
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754311980; x=1754916780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4pQfdGG1z5XXA6Mz/eRbTIBT31qa408vIbK4b4R2Ys=;
        b=S/hH96ZlIvpYuf+rxrOsWqvL9TSiwx8nTDxtptvl7jtypi71uANkyGau66QlCaP8eI
         /rc9vKsDEuMUD7i+5XpPRSKATyq9ZpItfQXHrfVbHyAUXOKT+MxBSVZ4YXbAXuocYL4C
         TVnHyaaBZ3hpzME126eIO0GVL+38FfysKd8EC+V0TN40TKCTlgH4CX9r5hhiEG99Vg8c
         zT8wtTHV37JS5zsXFOPtnAF6kDUtnFEouVlN3YoM0cm/WqHasSoYnc05qlyBqamTHVOn
         4/cA9jT/eLgGoZ643mB6I94dH1I5zzC7J6nZAxZ42aorIWILqLR22OhpvocyiOK/WGMF
         Bwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311980; x=1754916780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4pQfdGG1z5XXA6Mz/eRbTIBT31qa408vIbK4b4R2Ys=;
        b=COEg1kqx86c1Q0sIWiM1r27jO3TaPSO4E4qOE8RVBbCVxAQDLKW9yYOUrGKQNQ/UsE
         qntEjPizrtuqXoZLI4iCQjQToCE6K1dZ4jtTKBJWTO/jkh0WW+l/Flp9xElaceZKTE/d
         FxEw71gjs8/7tzvU7HMy6bfNveZ4vlNrfzX9EM6jIv0RwZg5LQ1OAKr2qeSHNlSCj3If
         h7qyLNuY24zHpALCQP06KHRB5Pfj6q8QzcspDo5R++Xwag+kDFEEUyw+hGkWkBuHve46
         pDx8yat+RmOJu5duOzDQ9O2I8eSlz52UeN7GMkGCkCKELpTrS49oRJ6HXVo9fp8/xNi3
         9FOw==
X-Forwarded-Encrypted: i=1; AJvYcCX7QltOlE9pK1rbWmFW4HEc8MzO5nxnWdGOvjEpFGf1FqgccnAS3MnawcwRHtFmOcsVEqTQAEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVOndOgXlNzI+Cl+hfraWGyx/baEc/nvxfJRonOTlTIRsbkEo
	Z4kXfch2yQSSJYmeHPZKtJvCkabPWs9jwWRYpVFWGItQrojha/gx4Dn2ng+HntbFmCM=
X-Gm-Gg: ASbGncuaGJ88St83xZ4erui4A/W8YfHmfYtnMqIpis9lkL2krURqtTAl+QLtsmlMb6c
	l7UzqufvxvTWEAXjPPzItW+T+2WNRK41Hct0hzZfU2ew2ly60WwSqI5oEcOG82JgiISgLnuV6n4
	jozTno5ka5iQnLDSKdiJvzdQiyi+wGELwuaW8uxf0xA7U2y+xrHQhD00F/zIq2I0vLHw5unUaet
	xV3sZ2TbfbKj6dLsUJGHxZDBkI8iyTbCWwZq1hJp6PPZJqlQy/uzcUdevXSr7Wa401uk13zNSa8
	3/pp6FuKvveZZxv4rJtZniZmV1kfWgXN4WmoY1rEABIDA16aU4NfU72iaCa/sIb1LRJ3mr2hpXf
	76hAVr/LUdX5GSScuvH3wgohUN30jfIY=
X-Google-Smtp-Source: AGHT+IFboy0SUNyOf5SrotPSmAV8WSaJe6NhkOucnxu+J+ZooQ08qDWDHLaF1HAdZBLlQQrdyB2Itw==
X-Received: by 2002:aa7:ce03:0:b0:615:6c92:aecc with SMTP id 4fb4d7f45d1cf-615e715f96bmr6485796a12.27.1754311979999;
        Mon, 04 Aug 2025 05:52:59 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f000c3sm6882825a12.4.2025.08.04.05.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:52:59 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 04 Aug 2025 14:52:32 +0200
Subject: [PATCH bpf-next v6 9/9] selftests/bpf: Cover metadata access from
 a modified skb clone
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-skb-metadata-thru-dynptr-v6-9-05da400bfa4b@cloudflare.com>
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

Demonstrate that skb metadata currently gets cleared when a BPF program
which might modify the payload processes a cloned packet.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/config                 |   1 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 107 +++++++++++++++++++--
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  52 ++++++++++
 3 files changed, 150 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 8916ab814a3e..70b28c1e653e 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -61,6 +61,7 @@ CONFIG_MPLS_IPTUNNEL=y
 CONFIG_MPLS_ROUTING=y
 CONFIG_MPTCP=y
 CONFIG_NET_ACT_GACT=y
+CONFIG_NET_ACT_MIRRED=y
 CONFIG_NET_ACT_SKBMOD=y
 CONFIG_NET_CLS=y
 CONFIG_NET_CLS_ACT=y
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 24a7b4b7fdb6..6a59297f3f8d 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -9,6 +9,7 @@
 #define TX_NETNS "xdp_context_tx"
 #define RX_NETNS "xdp_context_rx"
 #define TAP_NAME "tap0"
+#define DUMMY_NAME "dum0"
 #define TAP_NETNS "xdp_context_tuntap"
 
 #define TEST_PAYLOAD_LEN 32
@@ -156,6 +157,22 @@ static int send_test_packet(int ifindex)
 	return -1;
 }
 
+static int write_test_packet(int tap_fd)
+{
+	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
+	int n;
+
+	/* The ethernet header doesn't need to be valid for this test */
+	memset(packet, 0, sizeof(struct ethhdr));
+	memcpy(packet + sizeof(struct ethhdr), test_payload, TEST_PAYLOAD_LEN);
+
+	n = write(tap_fd, packet, sizeof(packet));
+	if (!ASSERT_EQ(n, sizeof(packet), "write packet"))
+		return -1;
+
+	return 0;
+}
+
 static void assert_test_result(const struct bpf_map *result_map)
 {
 	int err;
@@ -276,7 +293,6 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
 	struct netns_obj *ns = NULL;
-	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
 	int tap_fd = -1;
 	int tap_ifindex;
 	int ret;
@@ -322,19 +338,82 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
 		goto close;
 
-	/* The ethernet header is not relevant for this test and doesn't need to
-	 * be meaningful.
-	 */
-	struct ethhdr eth = { 0 };
+	ret = write_test_packet(tap_fd);
+	if (!ASSERT_OK(ret, "write_test_packet"))
+		goto close;
 
-	memcpy(packet, &eth, sizeof(eth));
-	memcpy(packet + sizeof(eth), test_payload, TEST_PAYLOAD_LEN);
+	assert_test_result(result_map);
+
+close:
+	if (tap_fd >= 0)
+		close(tap_fd);
+	netns_free(ns);
+}
+
+/* Write a packet to a tap dev and copy it to ingress of a dummy dev */
+static void test_tuntap_mirred(struct bpf_program *xdp_prog,
+			       struct bpf_program *tc_prog,
+			       bool *test_pass)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct netns_obj *ns = NULL;
+	int dummy_ifindex;
+	int tap_fd = -1;
+	int tap_ifindex;
+	int ret;
 
-	ret = write(tap_fd, packet, sizeof(packet));
-	if (!ASSERT_EQ(ret, sizeof(packet), "write packet"))
+	*test_pass = false;
+
+	ns = netns_new(TAP_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	/* Setup dummy interface */
+	SYS(close, "ip link add name " DUMMY_NAME " type dummy");
+	SYS(close, "ip link set dev " DUMMY_NAME " up");
+
+	dummy_ifindex = if_nametoindex(DUMMY_NAME);
+	if (!ASSERT_GE(dummy_ifindex, 0, "if_nametoindex"))
 		goto close;
 
-	assert_test_result(result_map);
+	tc_hook.ifindex = dummy_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto close;
+
+	tc_opts.prog_fd = bpf_program__fd(tc_prog);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto close;
+
+	/* Setup TAP interface */
+	tap_fd = open_tuntap(TAP_NAME, true);
+	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
+		goto close;
+
+	SYS(close, "ip link set dev " TAP_NAME " up");
+
+	tap_ifindex = if_nametoindex(TAP_NAME);
+	if (!ASSERT_GE(tap_ifindex, 0, "if_nametoindex"))
+		goto close;
+
+	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(xdp_prog), 0, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
+		goto close;
+
+	/* Copy all packets received from TAP to dummy ingress */
+	SYS(close, "tc qdisc add dev " TAP_NAME " clsact");
+	SYS(close, "tc filter add dev " TAP_NAME " ingress "
+		   "protocol all matchall "
+		   "action mirred ingress mirror dev " DUMMY_NAME);
+
+	/* Receive a packet on TAP */
+	ret = write_test_packet(tap_fd);
+	if (!ASSERT_OK(ret, "write_test_packet"))
+		goto close;
+
+	ASSERT_TRUE(*test_pass, "test_pass");
 
 close:
 	if (tap_fd >= 0)
@@ -385,6 +464,14 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.ing_cls_dynptr_offset_oob,
 			    skel->progs.ing_cls,
 			    skel->maps.test_result);
+	if (test__start_subtest("skb_clone_data_meta_empty"))
+		test_tuntap_mirred(skel->progs.ing_xdp,
+				   skel->progs.ing_cls_data_meta_empty,
+				   &skel->bss->test_pass);
+	if (test__start_subtest("skb_clone_dynptr_empty"))
+		test_tuntap_mirred(skel->progs.ing_xdp,
+				   skel->progs.ing_cls_dynptr_empty,
+				   &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index ee3d8adf5e9c..b2363852479c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -26,6 +26,8 @@ struct {
 	__uint(value_size, META_SIZE);
 } test_result SEC(".maps");
 
+bool test_pass;
+
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
@@ -43,6 +45,56 @@ int ing_cls(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Check that skb->data_meta..skb->data is empty */
+SEC("tc")
+int ing_cls_data_meta_empty(struct __sk_buff *ctx)
+{
+	struct ethhdr *eth = ctx_ptr(ctx, data);
+
+	if (eth + 1 > ctx_ptr(ctx, data_end))
+		goto out;
+	/* Ignore non-test packets */
+	if (eth->h_proto != 0)
+		goto out;
+	/* Packet write to trigger unclone in prologue */
+	eth->h_proto = 42;
+
+	/* Expect no metadata */
+	if (ctx->data_meta < ctx->data)
+		goto out;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
+/* Check that skb_meta dynptr is empty */
+SEC("tc")
+int ing_cls_dynptr_empty(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr data, meta;
+	struct ethhdr *eth;
+
+	bpf_dynptr_from_skb(ctx, 0, &data);
+	eth = bpf_dynptr_slice_rdwr(&data, 0, NULL, sizeof(*eth));
+	if (!eth)
+		goto out;
+	/* Ignore non-test packets */
+	if (eth->h_proto != 0)
+		goto out;
+	/* Packet write to trigger unclone in prologue */
+	eth->h_proto = 42;
+
+	/* Expect no metadata */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	if (bpf_dynptr_size(&meta) > 0)
+		goto out;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
 /* Read from metadata using bpf_dynptr_read helper */
 SEC("tc")
 int ing_cls_dynptr_read(struct __sk_buff *ctx)

-- 
2.43.0


