Return-Path: <netdev+bounces-232981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B154DC0A975
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 15:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC03B4E8E7F
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A444A2EA486;
	Sun, 26 Oct 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Csg9X50C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D5255F22
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488338; cv=none; b=nFmw9oTSLwuU87Pq5aSX84dojMfhcPy/nxdFNVT0/3etXiYRtpAALPgZqVT7tisQhGz23y2NVfP7ntBw8ee1gtgghSd4LC3Sy9brVGobXCTCkaMnE1zBziqjfbKit6ITQ5KJt1mQ1Ga3lKdx7gHEpdMddELsu3UQAUcRcDuqy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488338; c=relaxed/simple;
	bh=pBIPl0Sj69DM8pTOAoip8oieBc8gUckTxtkPnxzx6n0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EtIqeRxalKWTECrN6vVgwtmEpLriN3Zsi2MDYMQzEzvQi65vZI4KgPduDjenemyCZIbB0MP1X+T0bK8h8ruwDyUbF0d8IxRG3/lzhk8p0E29pL+Kr25ogWY/k3ZmI6LgUcb+U6ipaUudJODP2njK/RuJb44y14beehCNQJrq2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Csg9X50C; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d83bf1077so327908266b.3
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488335; x=1762093135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JY8euxhjSxZrEWfi+Bt2Wa2V4/aMRr49LtAScynF/tU=;
        b=Csg9X50C+/9R0FaBgapiaX+kVFNygPV/VXm0Ueu/jS/WliFK6KX7jWuKR3sw0+sF+h
         sGfeJ0Ow1fGEeH5UdFWNTTyiHi3p0mErQWLnwH8NEwGBBK90PV7PT0T42A+G46r0WFbp
         jaldtrVf8z4NYyH7nG9Qhd0GjvlOIQOCQY0eONEyQMahz+mcZwlhC661LrVVIEm6uXfd
         fDEY4O/ZaFqqbiyk9lBEIo8xwpVUTWgsIAJBa1xYrsYa/pRux9A7QvLQXr0oPAG6i7bI
         NCzzJn5oHBFI73cjekXLnNQBWmwNXQl0GIQmg6Iynep2jXkhl3K5P3ntZwFXKlnu45Vx
         g8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488335; x=1762093135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY8euxhjSxZrEWfi+Bt2Wa2V4/aMRr49LtAScynF/tU=;
        b=S8DU5PGAUoI9FcfBccCyNlRrdFOIOS+LEcmzReMhzC5zdElp/FVGbTBuG2bZT99ZT/
         EoecSoilLir6Ln/8RS1mFuEfCo4XxwhECe14qLXu/orCjDvQK9Rq6oeegvBZOLG617vT
         ISDiQo7fV3HUcfsCYXTTy9AzNsgb0qs2MsFm5awbRKqeHgxd3G+CrUPt28nu+3pQ9uZH
         cgwZ1Wi86ElXZluldRMB9dEDOaL50Prj/P56TgkFy5gS5XkC1svcgPjh81w0dHRs12Et
         dfuEXIBE59ZnoNBNYs+BR33t8/fod2/OheNJOesiHV8B4iGm80e7Hx23kCgRKlFfXoQL
         XKFg==
X-Forwarded-Encrypted: i=1; AJvYcCV0AVOZHQZxXTSuSkgf+hIlOat4jnMpQDlYTyAZJ5TUA/nsy/8nwHvmsp60E0Ee+Vc4zJbRa/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGt3WYJaYA6JDO2+R/mK9DQvCMvpkVsdk0QDuzz9ArvLrAOpX
	iSaViYtSIQGIjja+3tEwspXUfG3pemlyh+9d8+42n6Elzxs+9HC3UrBQEDHZFDUqSJw=
X-Gm-Gg: ASbGncvwU2VUMFbmXlqzq9EbwqnsboePUIwlY9d9BD5VhZ6Xa4GI+VhRmgvfQYtOVMm
	SsovqXSq+sWEIeGY7jWza6pT+6uV29/gAF55BesBuEWcuAvQkfh72sYUHaUpsR17fppqQPpXsDI
	qEjs8oRqD/tqR0pYsS7JU9LILX4Wv1QGJL7JQ4OnLG6wS4m3DsCBCOcUhPvDiHJcNssTA3ZfZ0u
	epNME2M0WBe25Y6YYG8h7nYZiSic3AeDyzVvL1x/BadNZm8RknMNBOEbrmynlZtJLjIbGa5omSd
	8FXkJaSiegQFSZ9FFP8dMvywCIDhFLadOAufqc4EjAPbxqLZOSBHAyY3LM9sVldvKwNU41WDn9Z
	kzuA1yi5gI3xdrat2O20/4slnF3xLvlFO4JF9MxiyEiILVRarhE3Y4HngFjQ6WyWLe9zZ6kNtlq
	RiIwotw0Mb+DYAWPBXIj9RmFJrT+YDNWgJ2vMsjvAsso8nU5gOkS5xWgup
X-Google-Smtp-Source: AGHT+IEwJNWc/+h4JzNiZ5lThxqJnC7kZPTHf5RuXlOgga+GOzDS/nOn2zV6EQ8WYQgPNrnB7B/kXw==
X-Received: by 2002:a17:906:f589:b0:b04:61aa:6adc with SMTP id a640c23a62f3a-b647195b6c9mr3717174466b.7.1761488335111;
        Sun, 26 Oct 2025 07:18:55 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm469862466b.39.2025.10.26.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:54 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:33 +0100
Subject: [PATCH bpf-next v3 13/16] selftests/bpf: Cover skb metadata access
 after vlan push/pop helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-13-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
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
bpf_skb_vlan_push() and bpf_skb_vlan_pop(), which modify the packet
headroom.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  6 +++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 43 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index a129c3057202..97c8f876f673 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -478,6 +478,12 @@ void test_xdp_context_tuntap(void)
 		test_tuntap_mirred(skel->progs.ing_xdp,
 				   skel->progs.clone_meta_dynptr_rw_before_meta_dynptr_write,
 				   &skel->bss->test_pass);
+	/* Tests for BPF helpers which touch headroom */
+	if (test__start_subtest("helper_skb_vlan_push_pop"))
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.helper_skb_vlan_push_pop,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index ee89e1124cd8..41e1d76e90a0 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -44,6 +44,16 @@ static bool check_metadata(const char *file, int line, __u8 *meta_have)
 
 #define check_metadata(meta_have) check_metadata(__FILE__, __LINE__, meta_have)
 
+static bool check_skb_metadata(const char *file, int line, struct __sk_buff *skb)
+{
+	__u8 *data_meta = ctx_ptr(skb, data_meta);
+	__u8 *data = ctx_ptr(skb, data);
+
+	return data_meta + META_SIZE <= data && (check_metadata)(file, line, data_meta);
+}
+
+#define check_skb_metadata(skb) check_skb_metadata(__FILE__, __LINE__, skb)
+
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
@@ -525,4 +535,37 @@ int clone_meta_dynptr_rw_before_meta_dynptr_write(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+SEC("tc")
+int helper_skb_vlan_push_pop(struct __sk_buff *ctx)
+{
+	int err;
+
+	/* bpf_skb_vlan_push assumes HW offload for primary VLAN tag. Only
+	 * secondary tag push triggers an actual MAC header modification.
+	 */
+	err = bpf_skb_vlan_push(ctx, 0, 42);
+	if (err)
+		goto out;
+	err = bpf_skb_vlan_push(ctx, 0, 207);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	err = bpf_skb_vlan_pop(ctx);
+	if (err)
+		goto out;
+	err = bpf_skb_vlan_pop(ctx);
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


