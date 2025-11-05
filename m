Return-Path: <netdev+bounces-235991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1ECC37B5F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAEBC4FA39F
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A498A34F461;
	Wed,  5 Nov 2025 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XVbwjTLW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3134EF10
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374014; cv=none; b=ryn1eUzkdtMOO7w6mtSOQnPEbTJ8b6YMo5TEwnjxPMaulXF5AR//uDUkw+gFWxyGrirXvSJOry6DsSXTkcFzBAmxjmO2I3hMCkYsiqDsg3+odJJsZa7dbd1cn2Ci4n9OGjno4iuGOWR4rDtNbTkCai0iuZBrsI1rtuLCu1wDuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374014; c=relaxed/simple;
	bh=s9dOPdDssh9uVh8xXJwS8S9YL3U/YhGMODTknNjjdN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ppHFwx0a8UV30GGHgnoJcQfp/7VEawYpGUIDtf7RiqdssEJ3vWo0p+4K+kvN/MpdPcMMlnX2T4B6rmgrW+PAc+scKEeMld691hfgbLfKyi5QeYBpdyfHWqhuoGWlPlOT8GDTw3NQCB5wppa5hP6ZjVzW/GZNBI1jIbvHu3CE4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XVbwjTLW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3c2db014easo42027166b.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 12:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374010; x=1762978810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRjMGQekhCJm4Cmv78QCqTEMQUlb7WHtroQaPtNLGo4=;
        b=XVbwjTLWlBlWH0nRSR0aVDd0DMt7WWMPGooo8JHrqzI6G8/cXtBnOsC6PZqo9EOvHt
         SsiRhIXfRRB0bEPMAzWvMa0y5w8enYgqjgorIXZFLDQfFCEQ68oxgWnlIGK2bb02WkJ4
         i4jWSChcUBrnhHuHHVyKFVGCIxOusDW0QpkPx21hkdwh4UJRvjiGAhmw7hc740zCFtEO
         bBnpxHLhFIYLX8yXIwyJbWun38mvh3qE6HStA85PZ56+a7UImbMf8fJQiohneq4dgtBv
         CVo3YsJp3TE7zPWd1y4Mo05Sat8ej/8INH1dPztwN+u6CQexVpp1LLBtAFRgeDcILhrZ
         p8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374010; x=1762978810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRjMGQekhCJm4Cmv78QCqTEMQUlb7WHtroQaPtNLGo4=;
        b=Ucow6pnoTZWhPtAnfBTHyzNXDGIgbzA/naiS3VtbGYhZrmdEtUf0gOjxpc67pWf9Ei
         ztNbEibdr7mf0cCzGKBnXi0aFgF3bHtID1WSt+fYDl7DVzGpuan+LYLlLgb6UsgSXkyy
         dS4j0tUmRMxHQDtiQLiNbpXE5P32ve1P+p6nkiT5CsbyXfGzssft08lBMFKO+uYEqVzu
         eEITdGruZ4YHcrDWO6fgSN52KfqHDN9qa4avu61qeTr3j2eLGx0qruj/0OaVTZ6xbC/s
         pLPoyzMc/wFROgKj2atlGFeKvID+QIOBYsKGq0jCIp4H9ZaeQlmQScraGv1MHVVzwnfo
         wVjA==
X-Forwarded-Encrypted: i=1; AJvYcCVcVwbjqY0qXGqSqF/91F+T8dvqY6eg81bxJ6xwlA3oxWoGknPphmP5f7tt1bB0tAAT3zPS41w=@vger.kernel.org
X-Gm-Message-State: AOJu0YypeXx06UtU3jA2VlpMF9XciBCn7v79RDE9a1DXitpCA1870cr/
	4i1duVq0PxgQOS04Zv9Vie/rSzw0Ke6STIWGrkFUWiL7lxSqpWZYnVDvjn7NXu+WCgE=
X-Gm-Gg: ASbGnct8AJ+rl6I6BZzamHYkpj++yma405l0IbkyC8GDS7H63T7tnO7JBKfml6DMhwS
	GIZ0Zj+QibAdYFrnZ/Vwp1SA12DdJ6Wzqm7017IVJXvcUx8dz3kJf3tb44Z/EM+Ehy0adjMT4TX
	BolK5EMwkm881y3+tA5uRN2LJQIcAaFOLJLKUiDv2Rwr/17JTVyr4jcHCh9VGlX1UR8QAiqn3x+
	zvi6iMnRhlzDJ7YSJJ0X55Dg2dB1QgrKNYIb7E8nhjcJLMg500bInFryYag3AoZTYupq5GFFALQ
	v9vbfJiibQyMd/qwzyAD/R+3IHuG/uTfNpUv4Uni24sfaKmVr6JuhmhCsLg/gBke+58GWDemv/4
	hJQQCg5eZ+yI4aBsoBh2H+5WZiDrK0pAHuo45cr8xvf9JYFDETDi+/Q3ugCe5rQewVm6tUflcKH
	Ofbws6LhJDAZZqiLusE81BOcyYJ2qqo08j5BvTK48Jn1vvpQ==
X-Google-Smtp-Source: AGHT+IEhGhixETesMpLTec3fAJha6wS8Rr/XsZkgmK206DjQaxhuiWXjLA43Y61AwEoN5oCsTubcVg==
X-Received: by 2002:a17:907:9711:b0:b40:6d68:349a with SMTP id a640c23a62f3a-b72654dd598mr424571966b.39.1762374009704;
        Wed, 05 Nov 2025 12:20:09 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c8127sm45823466b.73.2025.11.05.12.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:20:09 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:51 +0100
Subject: [PATCH bpf-next v4 14/16] selftests/bpf: Cover skb metadata access
 after bpf_skb_adjust_room
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-14-5ceb08a9b37b@cloudflare.com>
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

Add a test to verify that skb metadata remains accessible after calling
bpf_skb_adjust_room(), which modifies the packet headroom and can trigger
head reallocation.

The helper expects an Ethernet frame carrying an IP packet so switch test
packet identification by source MAC address since we can no longer rely on
Ethernet proto being set to zero.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 25 ++++++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 61 ++++++++++++++++++----
 2 files changed, 71 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 97c8f876f673..a3b82cf2f9e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -124,10 +124,10 @@ static int send_test_packet(int ifindex)
 	int n, sock = -1;
 	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
 
-	/* The ethernet header is not relevant for this test and doesn't need to
-	 * be meaningful.
-	 */
-	struct ethhdr eth = { 0 };
+	/* We use the Ethernet header only to identify the test packet */
+	struct ethhdr eth = {
+		.h_source = { 0x12, 0x34, 0xDE, 0xAD, 0xBE, 0xEF },
+	};
 
 	memcpy(packet, &eth, sizeof(eth));
 	memcpy(packet + sizeof(eth), test_payload, TEST_PAYLOAD_LEN);
@@ -160,8 +160,16 @@ static int write_test_packet(int tap_fd)
 	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
 	int n;
 
-	/* The ethernet header doesn't need to be valid for this test */
-	memset(packet, 0, sizeof(struct ethhdr));
+	/* The Ethernet header is mostly not relevant. We use it to identify the
+	 * test packet and some BPF helpers we exercise expect to operate on
+	 * Ethernet frames carrying IP packets. Pretend that's the case.
+	 */
+	struct ethhdr eth = {
+		.h_source = { 0x12, 0x34, 0xDE, 0xAD, 0xBE, 0xEF },
+		.h_proto = htons(ETH_P_IP),
+	};
+
+	memcpy(packet, &eth, sizeof(eth));
 	memcpy(packet + sizeof(struct ethhdr), test_payload, TEST_PAYLOAD_LEN);
 
 	n = write(tap_fd, packet, sizeof(packet));
@@ -484,6 +492,11 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.helper_skb_vlan_push_pop,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
+	if (test__start_subtest("helper_skb_adjust_room"))
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.helper_skb_adjust_room,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 04c7487bb350..6edc84d8dc52 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -20,6 +20,10 @@
 
 bool test_pass;
 
+static const __u8 smac_want[ETH_ALEN] = {
+	0x12, 0x34, 0xDE, 0xAD, 0xBE, 0xEF,
+};
+
 static const __u8 meta_want[META_SIZE] = {
 	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
@@ -27,6 +31,11 @@ static const __u8 meta_want[META_SIZE] = {
 	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
 };
 
+static bool check_smac(const struct ethhdr *eth)
+{
+	return !__builtin_memcmp(eth->h_source, smac_want, ETH_ALEN);
+}
+
 static bool check_metadata(const char *file, int line, __u8 *meta_have)
 {
 	if (!__builtin_memcmp(meta_have, meta_want, META_SIZE))
@@ -281,7 +290,7 @@ int ing_xdp_zalloc_meta(struct xdp_md *ctx)
 	/* Drop any non-test packets */
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		return XDP_DROP;
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		return XDP_DROP;
 
 	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
@@ -321,9 +330,9 @@ int ing_xdp(struct xdp_md *ctx)
 
 	/* The Linux networking stack may send other packets on the test
 	 * interface that interfere with the test. Just drop them.
-	 * The test packets can be recognized by their ethertype of zero.
+	 * The test packets can be recognized by their source MAC address.
 	 */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		return XDP_DROP;
 
 	__builtin_memcpy(data_meta, payload, META_SIZE);
@@ -343,7 +352,7 @@ int clone_data_meta_survives_data_write(struct __sk_buff *ctx)
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	if (meta_have + META_SIZE > eth)
@@ -373,7 +382,7 @@ int clone_data_meta_survives_meta_write(struct __sk_buff *ctx)
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	if (meta_have + META_SIZE > eth)
@@ -406,7 +415,7 @@ int clone_meta_dynptr_survives_data_slice_write(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
@@ -435,7 +444,7 @@ int clone_meta_dynptr_survives_meta_slice_write(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
@@ -469,7 +478,7 @@ int clone_meta_dynptr_rw_before_data_dynptr_write(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	/* Expect read-write metadata before unclone */
@@ -511,7 +520,7 @@ int clone_meta_dynptr_rw_before_meta_dynptr_write(struct __sk_buff *ctx)
 	if (!eth)
 		goto out;
 	/* Ignore non-test packets */
-	if (eth->h_proto != 0)
+	if (!check_smac(eth))
 		goto out;
 
 	/* Expect read-write metadata before unclone */
@@ -568,4 +577,38 @@ int helper_skb_vlan_push_pop(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+SEC("tc")
+int helper_skb_adjust_room(struct __sk_buff *ctx)
+{
+	int err;
+
+	/* Grow a 1 byte hole after the MAC header */
+	err = bpf_skb_adjust_room(ctx, 1, BPF_ADJ_ROOM_MAC, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	/* Shrink a 1 byte hole after the MAC header */
+	err = bpf_skb_adjust_room(ctx, -1, BPF_ADJ_ROOM_MAC, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	/* Grow a 256 byte hole to trigger head reallocation */
+	err = bpf_skb_adjust_room(ctx, 256, BPF_ADJ_ROOM_MAC, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
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


