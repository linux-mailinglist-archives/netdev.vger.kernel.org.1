Return-Path: <netdev+bounces-230728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E37DBEE56C
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDEA189EB67
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE72E92C3;
	Sun, 19 Oct 2025 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XQRB4pjH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AA92E7F08
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877968; cv=none; b=gbxnOaW3wEqxHCb7mvH4IyN+f045zEvIxi7fdchJwaIf0OPcV0hI8V5U3UGF7/ao5rQSGLb/e4eamb2mwwzxG/rHe5dT6I3bwZcy88R+UFTi+zV/c9FaLYNZl5SWm3xAJrvl+6VF2j2ZL95eBIlK/hkPPnbNO3kj0tYsAb2NkSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877968; c=relaxed/simple;
	bh=s8ejYighvmLMq95T7S87043rXSbZ91PrBVPsAZq7lQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZEzoW5RIylMAfJntDt8/Jp40iCnFo6x3qrNuAzZOfbAKIhA4RNTPxOmQZrM4YRvI+YlPpaDugIOXRmliWvQ6tbowin5fDavFoboG2I8uImVZxVDKocBbR+1Gr1bP4+sDt/8BDTAmQQs/opLQZdoZqIVzbMGEvNtTQmfWjhyjGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XQRB4pjH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07d4d24d09so590794766b.2
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877962; x=1761482762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrmrPg7KoaPB7foFkLKPjuRekkrBByS4QryzdooURAY=;
        b=XQRB4pjHPmAa/RNftPK2YKQQEZI8wDnQSeLvG1EjhVnUfrOimHR/Nj+HsPqw7AMh50
         bjtAvJDniqoYfyhg11OuakxCm85+J0qpS8YDpYhBCLhsoI0VG7nJDDJeVjGaKSuN0ERl
         GUBAooVww+kNIM817pUcCjXsgOSTtvcxTEhZGU0tPr/7Qf2vLj54lhh15RR3ojq7cBWw
         C6bDiCfqN2oAts5tK0zCXVbjztY56pp+dGOTN7/mStLxeeR4lkbV/hjcYIlqy1BvHq8Q
         Zh5nS0wGbZkusc4NrUgNmmV4GAfDUkOR5h0u7JEbfHXohvtS03QX/vJf29bEbL5p/WRf
         MCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877962; x=1761482762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrmrPg7KoaPB7foFkLKPjuRekkrBByS4QryzdooURAY=;
        b=PSNfPQRUJqZ4/ONFYg/8iaoIEYQb7s8JSMDCyINu+fMfUNkOqBGS7Lp139i3kz/SK9
         dea6TegLvIGMoFlquN/xqf5RTQLTFamNHRoWiTgMu9tOw75iE3OYEbqXAekYc2XswLa7
         +yk1boBwwkXR1Jl3LN2MW2GDcsNagvaoNmX1HHfU6jD2d50eWD0yFjE37ps9yvpAbwMi
         qxQMbhecJhYhcqzIaXfoYdQcFkHvRQ27KXcuAdJ1rJEQ1seckLdxEu5olnf3it5S3czU
         uVXyzPYwKkRXDcsLFkileUaONbDt38t2UjST2oaCw0bKFDAZqYf14N0m4j0pmk4Uow7m
         7E/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoHJdoMmjzf1iPqHwXUQ1TcJ+FcU6h0zOcJPwKeQcayaMnNX9p2kxlUeQQR9/tpLXOoF6elHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3IKMVVPSb1NkGekatS2aHOVdmTkxVuEofKSNutvBzDKvJvw0w
	086n6t3UpSTuqmgAQN2r49agw6rOTkqVNhhZuh/sXr4mzqLjs59tcAMI2yABpq4GlDYB6pJIlan
	P0UiD
X-Gm-Gg: ASbGncujrdX5DRPcwl6RLvbP1MijtiKn1xjsX9Gnd/YnpIeHavFm1ujrf4Y6FMn/hOe
	1JRyIPSFa2DDM+6m5wi85RoKtGL7AAHlha414Xiz1oYishyXIbrxkaC3WZpxU9TQg/5QaRXwPvz
	jLAsS9Hj6hE7rY0ue8CH7aeaNIU9/WVgk/rklkQys4UxTtsMGx2uI8m9L2eB1eE7yjd0gkmn8bP
	sMp8Rx7LiKDMJNg1BdQtPZCtlZJOC2c5iu+Qiu2++7/fyXNXzu4pWMaegQlNmdOnJlvoZ1nxWd/
	vMpCBnf5SAvuHu/nLepk0o3cyBwgSzY4JPkmhOpqAP3zAieUwAQSOHWiAnaIM20O04XvA43QFF7
	3T2gZnCbIliQkJ/XDsGdqqaOc6bqm2ABHlokz2xEObm5eZUYonxVcqDo8C9fXT63JREBxgLcIgV
	HJRtsdmtPfEDDyIvy9eJB23QPGx7sazLVp83YVOK800CRDUkg3m+5U2pg0OV/NqFtVBcFnpg==
X-Google-Smtp-Source: AGHT+IFsZIyWeyIKdrUkwOLkqgr6Vqyu4++1ILzF6JxAKn8J0k7Z8tTU+SOPMPjA0jwI/TVyRKo/UQ==
X-Received: by 2002:a17:906:9c84:b0:b3e:1400:6cab with SMTP id a640c23a62f3a-b647314956cmr1152138266b.17.1760877962223;
        Sun, 19 Oct 2025 05:46:02 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83960e6sm502615866b.33.2025.10.19.05.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:46:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:36 +0200
Subject: [PATCH bpf-next v2 12/15] selftests/bpf: Cover skb metadata access
 after vlan push/pop helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-12-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
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
 netdev@vger.kernel.org, kernel-team@cloudflare.com
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
index df6248dbaae8..e83b33526595 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -482,6 +482,12 @@ void test_xdp_context_tuntap(void)
 		test_tuntap_mirred(skel->progs.ing_xdp,
 				   skel->progs.clone_dynptr_rdonly_before_meta_dynptr_write,
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
index dba76f84c0c5..8d2b0512f8d3 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -49,6 +49,16 @@ static bool check_metadata(const char *file, int line, __u8 *meta_have)
 
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
@@ -525,4 +535,37 @@ int clone_dynptr_rdonly_before_meta_dynptr_write(struct __sk_buff *ctx)
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


