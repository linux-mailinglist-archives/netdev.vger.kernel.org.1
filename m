Return-Path: <netdev+bounces-213660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BAEB261BC
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA1E5C3A68
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36D2FA0F6;
	Thu, 14 Aug 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EV7O6pET"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A122F99BE
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165599; cv=none; b=azvx1W8YsHm6TMQX1I4rDlFpSKZc9KK0AvrtHQroVuriZhN4kYz3GgsbnWTBEATel2kBygwA9Qesg1U7y/uFjs//7iI6IaFQgRuHwNtvvDdiFccLHT9rmPHUacXjIkxzms8JoeIaKepeCt6g6FE8KG/pz76/9LP2pkTOoRBLRLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165599; c=relaxed/simple;
	bh=rOgEaue3k1efCvteS9x+AYID405oKjOeQI0S/MAOO/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQki27zu1NMVUrTHBNBXOtqN1Lgeq+GHF7GZvfzdX9uZcTu4CFCwvFFDY0EOeXpgKmwQyzDIjnYCfEldPwmVZRB58Wp8UeHTvwMQAFx24oPqvUv7zyzgrZNoVYkUq+7blgnaEjHldbceEWTBjSbEJsOJaON1P5XG0ixIlXPIieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EV7O6pET; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb72d51dcso115287366b.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755165596; x=1755770396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0fIqnzU78JFEGt4tPHYQLQeFtpWNKhdVMlxMCo22pY=;
        b=EV7O6pET9va1qj/gg2AZATwD/u2IB9w6wGHGJVNpqsHg3/a3fEgzfhwhbdufWjegs+
         zdTKPD5fqW6mAvImb0FJH1TbbuGa/zXCJb/xz+MxmF+DH4WdOBEuFiD3jfbYf3QrUuhu
         RBOvemu4sLR5HOh/Hx3iWiCykUmv9/BCzXQN5yg7VuCk84HGpBDAwo5ki4FTFcjIJIEn
         VLDD3YNUvqha5IK9KyVgIxwjWCvgUGXoRMHzIRvXBylfIVLV1EdFwCoQmufCzn0+LqYr
         mUG3y9tkynSuejfSqOpXO77lb5xsooly0wGMLiZP+X0OLCClj8WpWO++MU9Rz72ej1c7
         qLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165596; x=1755770396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0fIqnzU78JFEGt4tPHYQLQeFtpWNKhdVMlxMCo22pY=;
        b=h1Dmq5u161ZrJdQYSC+FU3ifRWyAAp/TpPPf/GXm85TynJR64RHTiCBA3Z306WaM0I
         aZbn5+ji1FR4vjlsJ2888TCZrHzOhEhViiB1hhXJ8F3lRXBRiR5anDQzeqitoKoUSHIK
         VPA0KPLF9moUAiATI3OA+KQHm94eq8r3K0QF3baBn+zp15p8kt7nsoPaoQTbRXEG6ZSg
         2NJywZnbsPYgCZ+4l8VyuG1K6DehZ8Q/vqt4wVwWcKfrlV8UG2IArx5uM7Vrtl29Srzy
         RWkDvvNPXrdoUeOExRCo+x2L0jA7Z5Qj01xUC/S8cGoUGdPgnnWw4jMBpIWGtXF3gaDg
         J0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8bj8dTuFASxOLaG7sO3Y1cRKNWpl2SFl3WyMX47hnJj4TI+f2vi8ZIOc/8kF137Gwh2BtIqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD6OGT90LwgNyYmQ9fnGd6vEfUZZ+bbxzggvPOaE9yQr/jgeWf
	FDpx13z7V5mlO7UnI4ZqdM558uhpDhkDy8Jj5KP5EGVJUH6HslvwIb/LdCGB0juEtEQ=
X-Gm-Gg: ASbGncvADwAkxTfUe8or1E7y9hcKmIOqRxOuiX4dqvVxbD8b/zU+gvZ98tvqgkvD+59
	e/1GrTcAX1SGVEZDhcwNVybSAASyIPhSFUGgSJbWerqFNLevowR/GZrumCrHHEJRZyszpeYhcgj
	JONNU2fJMT5/ih68/zxae3xCeo+MGTePHAca+XgjvgODQcEsL4othDKCkvKSNW8llAtw0JVFNDW
	N+8Ba675wfn2yS646Ru+bZ94nAYbYhLYy/KViBpwXUROkY6c817Rq/qjQexWvca7iDc+K+g/h0W
	tbYDlwcvfImdSgP6/6b2GRxarORFzW6GpO9wIOveRT99gZ1OetEKeBn8DgTvytdhChg8Nw8yD8Y
	+SVq+kQv5ePJY+pnq97SH
X-Google-Smtp-Source: AGHT+IG8XNjJJ8axUv1kHemYqxYmKs6jEIi80bYTWtmES0etyEbXzIxgH5Vavr+Q88+uoIMG0YYGnA==
X-Received: by 2002:a17:907:7202:b0:ae4:107f:dba2 with SMTP id a640c23a62f3a-afcb981f243mr246458066b.13.1755165595497;
        Thu, 14 Aug 2025 02:59:55 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:f6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3792sm2548731466b.50.2025.08.14.02.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:59:54 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 14 Aug 2025 11:59:31 +0200
Subject: [PATCH bpf-next v7 5/9] selftests/bpf: Parametrize
 test_xdp_context_tuntap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-skb-metadata-thru-dynptr-v7-5-8a39e636e0fb@cloudflare.com>
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

We want to add more test cases to cover different ways to access the
metadata area. Prepare for it. Pull up the skeleton management.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
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


