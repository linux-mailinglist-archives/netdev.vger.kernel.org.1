Return-Path: <netdev+bounces-213663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4522EB261C8
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15DD560B3E
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C2F2FD1D8;
	Thu, 14 Aug 2025 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WYOJVeig"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBA2FD1C2
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165606; cv=none; b=uzvGn5VhZAC1ThJQbPPRuQuoMu6Zg+15+eMx1/c7hXyYbq245O0LD8cHQilMjeknfnqPr2ApkaKInoghZhCRR1eemmErhVvSPXJrRynVpGgduW0ECsKwT4f6xwV3kK4lVYAhTz7VP1bDP2/2ye9r2GbGmbJ738cKBQEd++fcw2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165606; c=relaxed/simple;
	bh=vYHpJ4Hi1ZmZgog10GuNhM4LYvgvsijTEb4MUW4i6O8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqkRWWIPEJCHPpyVvcH5cB7YBp0Obooxi2w8tjE/fjiCILURtA44sopZP0ypct8qN/tl2YqWx4m3uRRZE9m9sOyASgzwCD5Ala1lDHD/FYVYIf4Yg+Byy+ja6piil1FmlMymqfsi42zojGUEDexuWyF+gN7TczDirnrOKzl9ay8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WYOJVeig; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so108655166b.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755165603; x=1755770403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GtCBepJWcW/BWW1/pwSGEND6QwvTsQ6+w/+6pMcyZk=;
        b=WYOJVeigSto/zoMKdiL4r+Klz+pM6hH4BaqAuAkDRbPEVxWe29cQckzyxniEqyESqz
         AzGN1d+aWYz8b2wRdnkel5QVpwObC9nQ/NWa7Ckjk1H1zEmqiyuP5hhFBlNY0/iHuLez
         CxiYGp9yzSG0gXsVRXTTuNunmPh/LQxs2KKaxPRzshISh8+8AUKHchrlk/+Vz1mtgTgI
         jYMveumdZJUc1DrQWpbTYyFERdEQXSjNUkmzUzHeuSnDR9y2EFSi6M0Iy/0HOMbuCp1I
         nn2zhrT3XcXWGx/Rgr0DyVI9U9sPsZGDyL5KR/JNR9r7j7cRuM6X1iovFEpYo8DCdvPU
         tqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165603; x=1755770403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GtCBepJWcW/BWW1/pwSGEND6QwvTsQ6+w/+6pMcyZk=;
        b=CrsAf/wesoApNZl2wuQ1DcTSt7OngyuntVujgF0MKOk5BNRTtWH7CLmLGlftvZ5uHa
         rcME1hMhuMfSOIlqjNVPnWat5jx2QdQx9oqkMDGeNI7GIyhRPFhcDbYv+ZnXMOciLTiq
         PpkNgO2S9BydNBvzduhRXQ0ZJsXi2eigze/jk3DmGUup2q6WtOK6g5Is4LRwHh8+PVLW
         fW2yvrmyeAX+jnJ5QG/HF0cDv3NclJQfyWoCxVgtEP1J/BzoVlmQo003X/b5vepKyVkP
         AgGJfn0w+nkSNcMEp8Jd5MmuylLgOdepNd1zOaNUev9sjXyxgN/dhXhcinPasBqtzMbr
         XgGw==
X-Forwarded-Encrypted: i=1; AJvYcCWuVntAWxCHjDIvjD3aX0jECryA09Bw2cjXgMEm4peB+4+MfWTSEJ/eQ/Ew/i4jbMR+ErDlSGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQzJduzqd41sqNyrm2WduV9Q/MQt18eB5NQTH1M3gp1nd+tVu
	xipptPzoEHLOg9KFRCfZNHAA8c/zWlBBtf4kGwSFKJbL4IacYVJeeKfkA4abGrivkhk=
X-Gm-Gg: ASbGncuXXHWfO5kyVlLl3J52A+nor7ZhyEnoui51qdxx6T3JFBLGiMAyDrQkjUa8Tby
	F5obLPbbIUW2SmxnLH/F2W6ljvmH/C5+8vK5dBdd09lV6JU2c9NKD1vw7ESEo3MVORnpHdxA4Vp
	geCIRKDp/s2PM4TqU7Pf1qZ8lkXn7b76OILvhOh1EWxq9hQtqm2PG+2G0jeHCrPQYJbqtfRy1f0
	ZgfugPF6ErIIVHBL73MOtNdAERWPH5UR+CcpeN2zU7VwfD01RZMFZ7d7CZIJXBhwChVppHXVp07
	r/PtqaEU9nkCK48imrx2aYarz9AhQ/+7N/qloaJJ+mfjnYU65Q33nCKoapJ4fFBM5Wu5z6h9qv8
	VtetfALuhq16dPIA=
X-Google-Smtp-Source: AGHT+IF/USL6PvnVaspAoHrnr0lPAjnfN5KTSqyYWwIkPTRnWKrRn9hgqk0EpO3+jOaCT7ZqliVhhA==
X-Received: by 2002:a17:907:7f9f:b0:ad8:9a3b:b274 with SMTP id a640c23a62f3a-afcb99072d6mr221701666b.52.1755165603266;
        Thu, 14 Aug 2025 03:00:03 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:f6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a219ecfsm2545805166b.94.2025.08.14.03.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:00:02 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 14 Aug 2025 11:59:35 +0200
Subject: [PATCH bpf-next v7 9/9] selftests/bpf: Cover metadata access from
 a modified skb clone
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-skb-metadata-thru-dynptr-v7-9-8a39e636e0fb@cloudflare.com>
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

Demonstrate that, when processing an skb clone, the metadata gets truncated
if the program contains a direct write to either the payload or the
metadata, due to an implicit unclone in the prologue, and otherwise the
dynptr to the metadata is limited to being read-only.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/config                 |   1 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 123 +++++++++++--
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 191 +++++++++++++++++++++
 3 files changed, 305 insertions(+), 10 deletions(-)

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
index 24a7b4b7fdb6..46e0730174ed 100644
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
@@ -385,6 +464,30 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.ing_cls_dynptr_offset_oob,
 			    skel->progs.ing_cls,
 			    skel->maps.test_result);
+	if (test__start_subtest("clone_data_meta_empty_on_data_write"))
+		test_tuntap_mirred(skel->progs.ing_xdp,
+				   skel->progs.clone_data_meta_empty_on_data_write,
+				   &skel->bss->test_pass);
+	if (test__start_subtest("clone_data_meta_empty_on_meta_write"))
+		test_tuntap_mirred(skel->progs.ing_xdp,
+				   skel->progs.clone_data_meta_empty_on_meta_write,
+				   &skel->bss->test_pass);
+	if (test__start_subtest("clone_dynptr_empty_on_data_slice_write"))
+		test_tuntap_mirred(skel->progs.ing_xdp,
+				   skel->progs.clone_dynptr_empty_on_data_slice_write,
+				   &skel->bss->test_pass);
+	if (test__start_subtest("clone_dynptr_empty_on_meta_slice_write"))
+		test_tuntap_mirred(skel->progs.ing_xdp,
+				   skel->progs.clone_dynptr_empty_on_meta_slice_write,
+				   &skel->bss->test_pass);
+	if (test__start_subtest("clone_dynptr_rdonly_before_data_dynptr_write"))
+		test_tuntap_mirred(skel->progs.ing_xdp,
+				   skel->progs.clone_dynptr_rdonly_before_data_dynptr_write,
+				   &skel->bss->test_pass);
+	if (test__start_subtest("clone_dynptr_rdonly_before_meta_dynptr_write"))
+		test_tuntap_mirred(skel->progs.ing_xdp,
+				   skel->progs.clone_dynptr_rdonly_before_meta_dynptr_write,
+				   &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index ee3d8adf5e9c..d79cb74b571e 100644
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
@@ -301,4 +303,193 @@ int ing_xdp(struct xdp_md *ctx)
 	return XDP_PASS;
 }
 
+/*
+ * Check that skb->data_meta..skb->data is empty if prog writes to packet
+ * _payload_ using packet pointers. Applies only to cloned skbs.
+ */
+SEC("tc")
+int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
+{
+	struct ethhdr *eth = ctx_ptr(ctx, data);
+
+	if (eth + 1 > ctx_ptr(ctx, data_end))
+		goto out;
+	/* Ignore non-test packets */
+	if (eth->h_proto != 0)
+		goto out;
+
+	/* Expect no metadata */
+	if (ctx->data_meta != ctx->data)
+		goto out;
+
+	/* Packet write to trigger unclone in prologue */
+	eth->h_proto = 42;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
+/*
+ * Check that skb->data_meta..skb->data is empty if prog writes to packet
+ * _metadata_ using packet pointers. Applies only to cloned skbs.
+ */
+SEC("tc")
+int clone_data_meta_empty_on_meta_write(struct __sk_buff *ctx)
+{
+	struct ethhdr *eth = ctx_ptr(ctx, data);
+	__u8 *md = ctx_ptr(ctx, data_meta);
+
+	if (eth + 1 > ctx_ptr(ctx, data_end))
+		goto out;
+	/* Ignore non-test packets */
+	if (eth->h_proto != 0)
+		goto out;
+
+	if (md + 1 > ctx_ptr(ctx, data)) {
+		/* Expect no metadata */
+		test_pass = true;
+	} else {
+		/* Metadata write to trigger unclone in prologue */
+		*md = 42;
+	}
+out:
+	return TC_ACT_SHOT;
+}
+
+/*
+ * Check that skb_meta dynptr is writable but empty if prog writes to packet
+ * _payload_ using a dynptr slice. Applies only to cloned skbs.
+ */
+SEC("tc")
+int clone_dynptr_empty_on_data_slice_write(struct __sk_buff *ctx)
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
+
+	/* Expect no metadata */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) > 0)
+		goto out;
+
+	/* Packet write to trigger unclone in prologue */
+	eth->h_proto = 42;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
+/*
+ * Check that skb_meta dynptr is writable but empty if prog writes to packet
+ * _metadata_ using a dynptr slice. Applies only to cloned skbs.
+ */
+SEC("tc")
+int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr data, meta;
+	const struct ethhdr *eth;
+	__u8 *md;
+
+	bpf_dynptr_from_skb(ctx, 0, &data);
+	eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
+	if (!eth)
+		goto out;
+	/* Ignore non-test packets */
+	if (eth->h_proto != 0)
+		goto out;
+
+	/* Expect no metadata */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) > 0)
+		goto out;
+
+	/* Metadata write to trigger unclone in prologue */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	md = bpf_dynptr_slice_rdwr(&meta, 0, NULL, sizeof(*md));
+	if (md)
+		*md = 42;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
+/*
+ * Check that skb_meta dynptr is read-only before prog writes to packet payload
+ * using dynptr_write helper. Applies only to cloned skbs.
+ */
+SEC("tc")
+int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr data, meta;
+	const struct ethhdr *eth;
+
+	bpf_dynptr_from_skb(ctx, 0, &data);
+	eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
+	if (!eth)
+		goto out;
+	/* Ignore non-test packets */
+	if (eth->h_proto != 0)
+		goto out;
+
+	/* Expect read-only metadata before unclone */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	if (!bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != META_SIZE)
+		goto out;
+
+	/* Helper write to payload will unclone the packet */
+	bpf_dynptr_write(&data, offsetof(struct ethhdr, h_proto), "x", 1, 0);
+
+	/* Expect no metadata after unclone */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != 0)
+		goto out;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
+/*
+ * Check that skb_meta dynptr is read-only if prog writes to packet
+ * metadata using dynptr_write helper. Applies only to cloned skbs.
+ */
+SEC("tc")
+int clone_dynptr_rdonly_before_meta_dynptr_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr data, meta;
+	const struct ethhdr *eth;
+
+	bpf_dynptr_from_skb(ctx, 0, &data);
+	eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
+	if (!eth)
+		goto out;
+	/* Ignore non-test packets */
+	if (eth->h_proto != 0)
+		goto out;
+
+	/* Expect read-only metadata */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	if (!bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != META_SIZE)
+		goto out;
+
+	/* Metadata write. Expect failure. */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	if (bpf_dynptr_write(&meta, 0, "x", 1, 0) != -EINVAL)
+		goto out;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0


