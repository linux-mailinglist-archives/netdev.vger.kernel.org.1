Return-Path: <netdev+bounces-202516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593E0AEE1A7
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC307AFEDF
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7A6290DB2;
	Mon, 30 Jun 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aI/WCAZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3628CF75
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295376; cv=none; b=abYfI2R3Fuk/cVshrB7k2VkB3f/C8heSYRRhp8w//GjMyjEBj68O+TIdgf22fXCvRy7ceNOgXgn2fk6+0EYrtDywuFe1TwxCrjLY8ijpbBbZommuzJv8QxuPmruLUE+AIuFAg9958OK1bpEwKrKlkeU+9u9A6LGQksNKQHteFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295376; c=relaxed/simple;
	bh=bcJ281bpbDhuU6BgwgKuXd3WmLyjZ1hGNAJT1SjtPLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i9Oo4Ng5LIJCYBpbfEv0kri7F4EkJP04l2MgdF+RgDdIE7kCVJQTB7qlfMUkUON2oMrQ5x7v3PkqXGRcZMs9F3qOLRJ+dUZAeyypa75kiCtW4T/2Ah/IfKRYi0xAYh7iAtla5/nz9PSJff3yXN6n3HNgKHCBzziBOhTJZhR+3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aI/WCAZu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0e0271d82so779650166b.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295373; x=1751900173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wd/ArnVql/H5k/5GaJzR+Ct+lWoyFxZX4lCEXe1R+oo=;
        b=aI/WCAZu+gbWfIA2Er3uVKsLjU5F4AU39TlOgwetqWNG43QZfogNLiW6W2EtjQxxLh
         MLL72LbfdvQxNZaq7ZtejUvndFVpmJJD+Prr221d86yyPFNNkJN9V057V5OlE0/WR8CN
         vrCS2NS2R+JpdNBUa0DD8AIskbHdoZQ4Xwbxx0530sQzw45K5OzJpYi7RdNr88T+OKR4
         PUJBuKHrXQSoC41/eedCuV6P1eQc8WqX79/XpV1vcD25VrGAMr9l+EVod1ADoVLXzuL5
         NOh2qjRln++/ArIHFr757MCUredryINwSJsmtwNsa8cjVioI+FCndePuR+EtQjFy2oca
         tzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295373; x=1751900173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wd/ArnVql/H5k/5GaJzR+Ct+lWoyFxZX4lCEXe1R+oo=;
        b=G/HIyAd/ZmwbshB/+4MYn1nQ2Rc+by19K0VZnrE8/fp0XMdUc+FNyTJEBuwk8whyTB
         F/W3pV6TZtZyV+hotVO5joZMV/3OYyuSUykhoqa44n9ElIlbADPolMBKAZvL2C13bQiV
         x78+AEXG1IR8IucbE4n73ZgcF0K1FA242NmZzAvo1e5g7Mhm85FylWFWEMTb1QKtkXGj
         x4djObrwLOx9OGDxt/iISouCTcMtEqpOsArQmHJpGR3fYeyxh1up/SJkuhPChtgA+SmD
         H9hMoIKIQZOFRicGe73+LX12OdM4zs0TZmciHWtPoPAF0NrBeF9Jp3mWuZsODY0K9rhG
         a+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUI59zjSyOglZb7zRKh2NIwG1fjTkBzWb9nm7YdXekQnpYKaSVaLX7oA8aPGw08Xk13+2FU+Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQb3pkHt7+sCvfnoLWNibKgJGtWTbWJQsOyqO/mBvAL/L/2DNl
	2BE3HoGO0ggDB7aY2IzVEGMYz1TIQZ36BnlSRmtI2mILonCL4RroXEwsDNdet/bX58Q=
X-Gm-Gg: ASbGncvZnwKqV/agTw+I/AoWnlHEvDd3XEqKKqD7+plu12tNdZeSSQUzKPZxzWAJlMg
	XYC76fayCzPAtgBp9TkEIO0RqBcYX/bY9r5hNZ2fzmHAAriEezQbgnmE5AjwHs+up6e4lh1qUjx
	fgnBxdQuaH9Y5W/lxVomE/SmAEEgDYm1Ww5vZR7qYE22z4k9WURlzmwMmsW4MdAoV9U643tftlk
	fnveUWmFkduzQ6vD0lpP1WlEo7hBUpigdmDfccbFiXORZpb5pc17EP+EutLkhcA1q8UOe0peeIh
	gzeZ1fWCCwghY9TF+jLCTCOBpR/xSLt1MHthna82xP2YTllBnYpzhg==
X-Google-Smtp-Source: AGHT+IF2g7GbEJbyWNUObyc80qE2x1Su5QHyZz5SyEYNAL8iUYRQvV3b00w8+fmIDcNhmafwQ8fk/A==
X-Received: by 2002:a17:906:dc94:b0:add:f2c8:7d3f with SMTP id a640c23a62f3a-ae3500e092emr1225022066b.33.1751295373154;
        Mon, 30 Jun 2025 07:56:13 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bb5csm679741166b.112.2025.06.30.07.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:56:12 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:45 +0200
Subject: [PATCH bpf-next 12/13] selftests/bpf: Cover lack of access to skb
 metadata at ip layer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-12-f17da13625d8@cloudflare.com>
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Arthur Fabre <arthur@arthurfabre.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Currently we don't expect skb metadata to persist beyond the device hooks.
Extend the test run BPF program from the Netfilter pre-routing hook to
verify this behavior.

Note, that the added test has no observable side-effect yet. This will be
addressed by the next change.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 94 ++++++++++++++++------
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 62 +++++++++-----
 tools/testing/selftests/bpf/test_progs.h           |  1 +
 3 files changed, 115 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 79c4c58276e6..4cf8e009a054 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -19,6 +19,9 @@ static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
 	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
 };
 
+#define PACKET_LEN \
+	(sizeof(struct ethhdr) + sizeof(struct iphdr) + TEST_PAYLOAD_LEN)
+
 void test_xdp_context_error(int prog_fd, struct bpf_test_run_opts opts,
 			    __u32 data_meta, __u32 data, __u32 data_end,
 			    __u32 ingress_ifindex, __u32 rx_queue_index,
@@ -120,18 +123,38 @@ void test_xdp_context_test_run(void)
 	test_xdp_context_test_run__destroy(skel);
 }
 
+static void init_test_packet(__u8 *pkt)
+{
+	struct ethhdr *eth = &(struct ethhdr){
+		.h_dest = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 },
+		.h_source = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x02 },
+		.h_proto = htons(ETH_P_IP),
+	};
+	struct iphdr *iph = &(struct iphdr){
+		.ihl = 5,
+		.version = IPVERSION,
+		.ttl = IPDEFTTL,
+		.protocol = 61, /* host internal protocol */
+		.saddr = inet_addr("10.0.0.2"),
+		.daddr = inet_addr("10.0.0.1"),
+	};
+
+	eth = memcpy(pkt, eth, sizeof(*eth));
+	pkt += sizeof(*eth);
+	iph = memcpy(pkt, iph, sizeof(*iph));
+	pkt += sizeof(*iph);
+	memcpy(pkt, test_payload, sizeof(test_payload));
+
+	iph->tot_len = htons(sizeof(*iph) + sizeof(test_payload));
+	iph->check = build_ip_csum(iph);
+}
+
 static int send_test_packet(int ifindex)
 {
+	__u8 packet[PACKET_LEN];
 	int n, sock = -1;
-	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
-
-	/* The ethernet header is not relevant for this test and doesn't need to
-	 * be meaningful.
-	 */
-	struct ethhdr eth = { 0 };
 
-	memcpy(packet, &eth, sizeof(eth));
-	memcpy(packet + sizeof(eth), test_payload, TEST_PAYLOAD_LEN);
+	init_test_packet(packet);
 
 	sock = socket(AF_PACKET, SOCK_RAW, IPPROTO_RAW);
 	if (!ASSERT_GE(sock, 0, "socket"))
@@ -271,17 +294,18 @@ void test_xdp_context_veth(void)
 static void test_tuntap(struct bpf_program *xdp_prog,
 			struct bpf_program *tc_prio_1_prog,
 			struct bpf_program *tc_prio_2_prog,
+			struct bpf_program *nf_prog,
 			struct bpf_map *result_map)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
-	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *nf_link = NULL;
 	struct netns_obj *ns = NULL;
-	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
+	__u8 packet[PACKET_LEN];
 	int tap_fd = -1;
 	int tap_ifindex;
 	int ret;
 
-	if (!clear_test_result(result_map))
+	if (result_map && !clear_test_result(result_map))
 		return;
 
 	ns = netns_new(TAP_NETNS, true);
@@ -292,6 +316,8 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
 		goto close;
 
+	SYS(close, "ip link set dev " TAP_NAME " addr 02:00:00:00:00:01");
+	SYS(close, "ip addr add dev " TAP_NAME " 10.0.0.1/24");
 	SYS(close, "ip link set dev " TAP_NAME " up");
 
 	tap_ifindex = if_nametoindex(TAP_NAME);
@@ -303,10 +329,14 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
 		goto close;
 
-	tc_opts.prog_fd = bpf_program__fd(tc_prio_1_prog);
-	ret = bpf_tc_attach(&tc_hook, &tc_opts);
-	if (!ASSERT_OK(ret, "bpf_tc_attach"))
-		goto close;
+	if (tc_prio_1_prog) {
+		LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1,
+			    .prog_fd = bpf_program__fd(tc_prio_1_prog));
+
+		ret = bpf_tc_attach(&tc_hook, &tc_opts);
+		if (!ASSERT_OK(ret, "bpf_tc_attach"))
+			goto close;
+	}
 
 	if (tc_prio_2_prog) {
 		LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 2,
@@ -317,28 +347,33 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 			goto close;
 	}
 
+	if (nf_prog) {
+		LIBBPF_OPTS(bpf_netfilter_opts, nf_opts,
+			    .pf = NFPROTO_IPV4, .hooknum = NF_INET_PRE_ROUTING);
+
+		nf_link = bpf_program__attach_netfilter(nf_prog, &nf_opts);
+		if (!ASSERT_OK_PTR(nf_link, "attach_netfilter"))
+			goto close;
+	}
+
 	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(xdp_prog),
 			     0, NULL);
 	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
 		goto close;
 
-	/* The ethernet header is not relevant for this test and doesn't need to
-	 * be meaningful.
-	 */
-	struct ethhdr eth = { 0 };
-
-	memcpy(packet, &eth, sizeof(eth));
-	memcpy(packet + sizeof(eth), test_payload, TEST_PAYLOAD_LEN);
-
+	init_test_packet(packet);
 	ret = write(tap_fd, packet, sizeof(packet));
 	if (!ASSERT_EQ(ret, sizeof(packet), "write packet"))
 		goto close;
 
-	assert_test_result(result_map);
+	if (result_map)
+		assert_test_result(result_map);
 
 close:
 	if (tap_fd >= 0)
 		close(tap_fd);
+	if (nf_link)
+		bpf_link__destroy(nf_link);
 	netns_free(ns);
 }
 
@@ -354,27 +389,38 @@ void test_xdp_context_tuntap(void)
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls,
 			    NULL, /* tc prio 2 */
+			    NULL, /* netfilter */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_read"))
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls_dynptr_read,
 			    NULL, /* tc prio 2 */
+			    NULL, /* netfilter */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_slice"))
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls_dynptr_slice,
 			    NULL, /* tc prio 2 */
+			    NULL, /* netfilter */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_write"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_write,
 			    skel->progs.ing_cls_dynptr_read,
+			    NULL, /* netfilter */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_slice_rdwr"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_slice_rdwr,
 			    skel->progs.ing_cls_dynptr_slice,
+			    NULL, /* netfilter */
 			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_nf_hook"))
+		test_tuntap(skel->progs.ing_xdp,
+			    NULL, /* tc prio 1 */
+			    NULL, /* tc prio 2 */
+			    skel->progs.ing_nf,
+			    NULL /* ignore result for now */);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index b6fed72b1005..41411d164190 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1,15 +1,25 @@
 #include <stdbool.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
+#include <linux/ip.h>
 #include <linux/pkt_cls.h>
 
+#include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_kfuncs.h"
 
+#define META_OFFSET (sizeof(struct ethhdr) + sizeof(struct iphdr))
 #define META_SIZE 32
 
+#define NF_DROP 0
+#define NF_ACCEPT 1
+
 #define ctx_ptr(ctx, mem) (void *)(unsigned long)ctx->mem
 
+struct bpf_nf_ctx {
+	struct sk_buff *skb;
+} __attribute__((preserve_access_index));
+
 /* Demonstrates how metadata can be passed from an XDP program to a TC program
  * using bpf_xdp_adjust_meta.
  * For the sake of testing the metadata support in drivers, the XDP program uses
@@ -60,6 +70,20 @@ int ing_cls_dynptr_read(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Check that we can't get a dynptr slice to skb metadata yet */
+SEC("netfilter")
+int ing_nf(struct bpf_nf_ctx *ctx)
+{
+	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
+	struct bpf_dynptr meta;
+
+	bpf_dynptr_from_skb(skb, BPF_DYNPTR_F_SKB_METADATA, &meta);
+	if (bpf_dynptr_size(&meta) != 0)
+		return NF_DROP;
+
+	return NF_ACCEPT;
+}
+
 /* Write to metadata using bpf_dynptr_write helper */
 SEC("tc")
 int ing_cls_dynptr_write(struct __sk_buff *ctx)
@@ -68,7 +92,7 @@ int ing_cls_dynptr_write(struct __sk_buff *ctx)
 	__u8 *src;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
-	src = bpf_dynptr_slice(&data, sizeof(struct ethhdr), NULL, META_SIZE);
+	src = bpf_dynptr_slice(&data, META_OFFSET, NULL, META_SIZE);
 	if (!src)
 		return TC_ACT_SHOT;
 
@@ -108,7 +132,7 @@ int ing_cls_dynptr_slice_rdwr(struct __sk_buff *ctx)
 	__u8 *src, *dst;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
-	src = bpf_dynptr_slice(&data, sizeof(struct ethhdr), NULL, META_SIZE);
+	src = bpf_dynptr_slice(&data, META_OFFSET, NULL, META_SIZE);
 	if (!src)
 		return TC_ACT_SHOT;
 
@@ -126,14 +150,18 @@ int ing_cls_dynptr_slice_rdwr(struct __sk_buff *ctx)
 SEC("xdp")
 int ing_xdp_zalloc_meta(struct xdp_md *ctx)
 {
-	struct ethhdr *eth = ctx_ptr(ctx, data);
+	const void *data_end = ctx_ptr(ctx, data_end);
+	const struct ethhdr *eth;
+	const struct iphdr *iph;
 	__u8 *meta;
 	int ret;
 
-	/* Drop any non-test packets */
-	if (eth + 1 > ctx_ptr(ctx, data_end))
+	/* Expect Eth | IPv4 (proto=61) | ... */
+	eth = ctx_ptr(ctx, data);
+	if (eth + 1 > data_end || eth->h_proto != bpf_htons(ETH_P_IP))
 		return XDP_DROP;
-	if (eth->h_proto != 0)
+	iph = (void *)(eth + 1);
+	if (iph + 1 > data_end || iph->protocol != 61)
 		return XDP_DROP;
 
 	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
@@ -153,7 +181,8 @@ SEC("xdp")
 int ing_xdp(struct xdp_md *ctx)
 {
 	__u8 *data, *data_meta, *data_end, *payload;
-	struct ethhdr *eth;
+	const struct ethhdr *eth;
+	const struct iphdr *iph;
 	int ret;
 
 	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
@@ -164,18 +193,15 @@ int ing_xdp(struct xdp_md *ctx)
 	data_end  = ctx_ptr(ctx, data_end);
 	data      = ctx_ptr(ctx, data);
 
-	eth = (struct ethhdr *)data;
-	payload = data + sizeof(struct ethhdr);
-
-	if (payload + META_SIZE > data_end ||
-	    data_meta + META_SIZE > data)
+	/* Expect Eth | IPv4 (proto=61) | meta blob */
+	eth = (void *)data;
+	if (eth + 1 > data_end || eth->h_proto != bpf_htons(ETH_P_IP))
 		return XDP_DROP;
-
-	/* The Linux networking stack may send other packets on the test
-	 * interface that interfere with the test. Just drop them.
-	 * The test packets can be recognized by their ethertype of zero.
-	 */
-	if (eth->h_proto != 0)
+	iph = (void *)(eth + 1);
+	if (iph + 1 > data_end || iph->protocol != 61)
+		return XDP_DROP;
+	payload = (void *)(iph + 1);
+	if (payload + META_SIZE > data_end || data_meta + META_SIZE > data)
 		return XDP_DROP;
 
 	__builtin_memcpy(data_meta, payload, META_SIZE);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index df2222a1806f..204f54cdaab1 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -20,6 +20,7 @@ typedef __u16 __sum16;
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/filter.h>
+#include <linux/netfilter.h>
 #include <linux/perf_event.h>
 #include <linux/socket.h>
 #include <linux/unistd.h>

-- 
2.43.0


