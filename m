Return-Path: <netdev+bounces-235989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B19AC37B53
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C01774F9584
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E93451C9;
	Wed,  5 Nov 2025 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TWKJnZQ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043B34EEED
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374012; cv=none; b=OtH/baF94JBE+ohULCChDFxMvADCgPH26SSWLcc7qJNI8hRRVMQhUfjZMOoi853Rvn4S4zzV2lNuZw9WXdY/iOc65qh6vdSeIETqYnv6jhp/OxjQzvFys44MQmBj9pAB3MAy9m0z5T6C4mFBij94acnFz3KFpOMPA52Q+ezXFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374012; c=relaxed/simple;
	bh=uhu0sRpXgug9K1t55YK9U9d2pdZu/7f5aErzrjJKfwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MldrgltG9nuGeuwevko5GPbzcQZvib//afLJhNjElH4O8DPxxEZ9cRq7ea+jWwUU8l66q9CoHguUBqMQAjvVZNFtUuw1n6VJrC2fbtiVCxXcWAz6Iy758Iy/1aw/gm+tP73JDF1GDCBWCLmwNAuTLbQADiIDLMfYLzy6e4/s1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TWKJnZQ4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7260435287so27928466b.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 12:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374008; x=1762978808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rv+wMki2mCxR77hpbTFywu+l5+/0oJt0cFCPtAcjVTQ=;
        b=TWKJnZQ4JZ/i2S6GtW6UevdRKcl+irqGpplLwnxQvSLu8qAxqgNZ9mcRTQB2XObCS9
         dYJ9lS1fti5liM/K6lUgcX2oDMywe0bVTAGoQZJJAuTUk0UEOP1gKpAJPsHN2R9WnrCw
         oE9/O/7MRmtSLG52yATK1zXoU+A82LLcmPXdmUqMfIQIeEpIgtYKS471P+vY6HxP3xcx
         0j3fo/8SZfqJDlavaKALCOUxmK1fBYCMR7u+7Nx2q5kPTtKmFy+yb8D0zAzc38zsBfhE
         rr582VXLk7rJc2rPxgsLnGcaDHKAAg87ADaerDz/yRg4EhpdOA1l3vJBCabI47weQAlC
         qhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374008; x=1762978808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rv+wMki2mCxR77hpbTFywu+l5+/0oJt0cFCPtAcjVTQ=;
        b=Oyg1yRlwxXnK9zKWICEQ8cvsGkCSy62PKSOykQL8uUMv2iuqZEY6DSNYQzzHOfK7Ia
         Oox/KdFsGlHy9nDDV/yDWe4GTfP4T4ic1Lpok0/t+jDw3PNqk9G4qv1+/jCVD2jf2q3v
         pKPbLPx/MWjKhPYcYkdrA5uTqcCXFpZWn8nOjxtFriTWnlRFIhq4On+3nbKv0/+sVOIz
         +UnwOO8GPIi+HyjdFzN4i2vZN7bJu6VArpiA2ADPal2J2mWV5L3SCGOiZx1FIBgZM2oW
         K9ScUmQSouGha8VPvJZroQMydZAWpbPr7ewPczwm8XzcTokG5xHyXDnt1JA9ZQ2r6LjT
         SqFw==
X-Forwarded-Encrypted: i=1; AJvYcCU9RbOPoAkBSDjtAQKz0N2d3uo9Me7Wqd7NTer82bxpewMh/J9O85MxCHVfAXgM2k1yDFiftDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7HZr8JmrStUxqOJLYv5z8uY8Nu3X/2sAAt0onNgQkjluUMwn
	XsdYdoD/07DzXgFdmWUAaEajxSV/OZvG367adXwqiz9RguMXmHywYzJZc8IaB5D037Y=
X-Gm-Gg: ASbGncsQkG21ct2YxRiFDRpM2un5ifZ2HIDtPPh1SROqzJ9BTF9Nnw94tXYsfXyl7ae
	TLZx7SKbAcASTvQiLOHT/E4GlmIrr/Ld1wAQ53SQx9CWjTzhhBM5jzJhi5ft8D9mAyzFNhWZJ1V
	BGiNwfQbsvPKz1T3NTmTZLHbjGhW8P7i2QNqYp45vZ3pUO9rKzPmbWNb9uv93jgs5TANea5Ov6C
	oaODs1GQpEXGTzQSwrHFMN1MLpAhnbSQgBhWFREadEEQnxjlTqpE4Hzu8Ti+mLMSEBjucZFY03R
	0gy/Gg/aGe/dGzdOxboLAyqGKlepcLzU+quhdN3CeyZ9qDFH+2i+3YYYcAQDdyz3UgtSSIfSAUW
	5bpSJSzTd4MxIp8s6kXOBpZchU9rba4G3OrCyMmfK5xmR9IU4yvu+FoEJ3wZl+4DQV8n/P34Q4U
	TlbE/Jx71BQToKE8LtMqe1XHHUfPuA5aSX1rqPK+u0kCzdtnXMQYh8qfRQ
X-Google-Smtp-Source: AGHT+IFJl6cV/igj9ynYt/np2euiEErVUs6ipzRxDpzOrmiIGK5pn6V7TFkRn0BV8m+0B6n5vWZfJA==
X-Received: by 2002:a17:906:c346:b0:b72:6b3c:1f0d with SMTP id a640c23a62f3a-b726b3c21a3mr289980266b.35.1762374008260;
        Wed, 05 Nov 2025 12:20:08 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728968208esm41400266b.52.2025.11.05.12.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:20:07 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:50 +0100
Subject: [PATCH bpf-next v4 13/16] selftests/bpf: Cover skb metadata access
 after vlan push/pop helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-13-5ceb08a9b37b@cloudflare.com>
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
index a70de55c6997..04c7487bb350 100644
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


