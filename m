Return-Path: <netdev+bounces-202513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF98DAEE1B1
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88663B814C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C6728FAAB;
	Mon, 30 Jun 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UakC6v3x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEBF28FAAE
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295371; cv=none; b=YS4HP+aIV34vUuGCMbVxIRwmDEr7OLpNPTxFYa9H/H9bo91+zuFl4SMHmHCy3pkgN3kx4NEYGZLqmTAkULRcMgWpEb27zNhzicFJU9MGvA4G4ipBQYRgF2Ryygc3gQtyhOpLuvOIkppiFP1PJt2YDrPVnNULuhcWPLSTFB2pwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295371; c=relaxed/simple;
	bh=uRNVyE79emPfKVU6XpnZGgITpFG6Ywz7jpzsyJ4I+Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ka4IRdsDU/ERF4B1TrTtp6Rw6Zazz6J1PZYWkdqqDnx4WB38mTDEfc+caCf4YPOl34YzT6raN5+t3as3VUgNOUUOXdQlRdPL3/qs4ZigP8Az48e8ZK8LQsyFe+0pKz03h+Htrx9KU/ESpAMtiz+boMbRvYW94Zk5cQbc5c1cP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UakC6v3x; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0dd62f2adso807629166b.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295367; x=1751900167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7HMMcaoWoXp7CBL/t22KpHPWA7fRL898Q9A4YYFk88=;
        b=UakC6v3xppO0KOiEyyUp2HEbiTI+pQwFG1DRDsHFyYdie26qKI4nRsvmzRq9BPgE6M
         jp2KMhxsH6ecge60YiUJ1+ktAmtSdVzZts4+hHGGZjaEGLix8i5g2tMWhAqnp04/qGQA
         RV3bkgd/KuJYMdHQzz3y9GXKFezJI2Cva0smdQrxm1oEzwyKC6BhhdR32ATQ7U6/4LX6
         WFyM5ZeJFXo/aD0c74L+TK+QJ7E+BqHWr3OQf89bJQhA9MB+ed+qDp5a8I+8HMV0Z++j
         UWovr+030AV+sJnUiEG/OQZ7BP3ZdMcmwkSK9dpjlGsJW3T1VM+trVC12tHjVADUo6ee
         jSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295367; x=1751900167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7HMMcaoWoXp7CBL/t22KpHPWA7fRL898Q9A4YYFk88=;
        b=rNigZJuaTYNqyyeIIcPMdG78IFxpep1XxuQNqyhc2cSrH1IkB7B6X67g+oIb/ivkJN
         arCnjOER2SVpV+J0bQt7G+qwVYUMzu+6B2MLvjCSyp+c9IldeJK3JPB3kU6FokJWYMqf
         xqbN5gOToejyQG78KCXr15cVecXXYuuoMH2KLPtJSjnxtcrdPx7oxlHb8pcQJixY2AvB
         3gBL2aBDwEl8NzxKmH5qpiyUalJQ+zF/IOgLBOJ8aDvxgEBUIY3mhWfTXSdueOYeDvC8
         gGOnJ3J62Pl0fE17SzcC29CRS/mEy3aTRhdcMyfdYX/N/RvvKCcUkNgkwnByWU14TEiT
         5x6g==
X-Forwarded-Encrypted: i=1; AJvYcCV/qz1xnf4WFzyINT6n+ppBjM5RR3CaYdV9ckQirkEMfek5mhpEYRA4feL4zhJ9bfDHJqIGQFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvLVoOlerjOi8znN0nViupb2YUHA6RKskxN53o20JOILhLmAed
	55FiVgY90MS4k2/OhbtedxfadaitFdrjfNUdnw2xMDkKKjndotz1sHul1bRkuX9WLFk=
X-Gm-Gg: ASbGnctsX4sy8f8a7etMhEboptOmqc1EzSmkPJbwaqLtmtg1cOlU53vTCl3gLbadfBq
	Kk1timh+7M6+8zxwXU6YmRbeFZkobzMjAppSrCc/+0k/fY7jR+PRRhNpkfoLvBrWtbH/J59UhDs
	mhkkQ6Ys0C96YjCs9QAabQ3qk9ypeAPuEgGNRpOcEsDhNGE0hMQUPNQCdUhTKBJTv0yvjTFH23c
	V8wjM2Fb+vR4gGC/kkmY9GsFOsOzCfvDqXWYW1wc6p8I+3Ct5xNPW9AbZ+fIFaTDPx/pMziLxA5
	jFkS+/ctPXasGTAek01m/Cx1b+YeMu54fTtDnL8DF9KF6ED7eiV+Dg==
X-Google-Smtp-Source: AGHT+IFGU+jDL5yigFcn8X6bxLQ9XTZKmPKScGoGu0BuR5t2bi0d7iiTmRQIVofE+ZzUg1yVmnZiSA==
X-Received: by 2002:a17:907:94cc:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-ae34fdbf054mr1301464866b.24.1751295367364;
        Mon, 30 Jun 2025 07:56:07 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353639bfcsm695713566b.11.2025.06.30.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:56:06 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:42 +0200
Subject: [PATCH bpf-next 09/13] selftests/bpf: Parametrize
 test_xdp_context_tuntap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-9-f17da13625d8@cloudflare.com>
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

We want to add more test cases to cover different ways to access the
metadata area. Prepare for it. Pull up the skeleton management.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 31 +++++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 0134651d94ab..6c66e27e5bc7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -256,12 +256,13 @@ void test_xdp_context_veth(void)
 	netns_free(tx_ns);
 }
 
-void test_xdp_context_tuntap(void)
+static void test_tuntap(struct bpf_program *xdp_prog,
+			struct bpf_program *tc_prog,
+			struct bpf_map *result_map)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
 	struct netns_obj *ns = NULL;
-	struct test_xdp_meta *skel = NULL;
 	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
 	int tap_fd = -1;
 	int tap_ifindex;
@@ -277,10 +278,6 @@ void test_xdp_context_tuntap(void)
 
 	SYS(close, "ip link set dev " TAP_NAME " up");
 
-	skel = test_xdp_meta__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
-		goto close;
-
 	tap_ifindex = if_nametoindex(TAP_NAME);
 	if (!ASSERT_GE(tap_ifindex, 0, "if_nametoindex"))
 		goto close;
@@ -290,12 +287,12 @@ void test_xdp_context_tuntap(void)
 	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
 		goto close;
 
-	tc_opts.prog_fd = bpf_program__fd(skel->progs.ing_cls);
+	tc_opts.prog_fd = bpf_program__fd(tc_prog);
 	ret = bpf_tc_attach(&tc_hook, &tc_opts);
 	if (!ASSERT_OK(ret, "bpf_tc_attach"))
 		goto close;
 
-	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(skel->progs.ing_xdp),
+	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(xdp_prog),
 			     0, NULL);
 	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
 		goto close;
@@ -312,11 +309,25 @@ void test_xdp_context_tuntap(void)
 	if (!ASSERT_EQ(ret, sizeof(packet), "write packet"))
 		goto close;
 
-	assert_test_result(skel->maps.test_result);
+	assert_test_result(result_map);
 
 close:
 	if (tap_fd >= 0)
 		close(tap_fd);
-	test_xdp_meta__destroy(skel);
 	netns_free(ns);
 }
+
+void test_xdp_context_tuntap(void)
+{
+	struct test_xdp_meta *skel = NULL;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	if (test__start_subtest("data_meta"))
+		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls,
+			    skel->maps.test_result);
+
+	test_xdp_meta__destroy(skel);
+}

-- 
2.43.0


