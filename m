Return-Path: <netdev+bounces-209458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CD1B0F977
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5BA3A544F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11805242D65;
	Wed, 23 Jul 2025 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IK3sSMVO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243023F42D
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292223; cv=none; b=LfAkHOB+YBpP6dahqQrAx5ViyWXtacxg7CxbV1JXX7BJxaSXaue2RyC5wsuZNRmMBXUVYekCm27xCvkigzLv7zECZsgHv67HghGv+YHHAQ5lP3ak5G9VlwMlMT5USnXV67nj6zrV1GGS/LJXEjRqodx140OAek2xZG06G9y4U2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292223; c=relaxed/simple;
	bh=RXQA0em6mpFVn+7oVg9GVlkZ2gsW+alw4wAQo+qSjCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dy0rl4YDYiYPpfhMvx2jtXShJ0y5ivF+c2kfRzdAj6JslIBBszZkuq66kpitiUQCfEWxnRmum9JJIHg0fktcaEisdJOm+Ptoj4k+ulTbzHcPB74StZzTyar7d7X+y+KXuoY8saXClIX8YvncLtPLA0CfeGPhWW43aJOFzFIc4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IK3sSMVO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so287795a12.3
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753292219; x=1753897019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqrJ8N5dxfQ/ZnS6euAexSYR33hLFnIxyaZ3CnZNeAs=;
        b=IK3sSMVOUv9AifkZaj3ATrdkCTuGYiUaqJdsJvAscGx9rZ2TbfPByAwPipnrYJtz2O
         hLzh3NcXmm6RrhzVCsukWYDvSAECPZifVZoME+HA6SKM+xT3cYSwBJeQkGIKFp3Zf5gg
         QjXDydpHLnekSIEI1EYsOGmmWUOI/owJIdRurt79DwMUQZyayMbTvAgtvjY9yDEaz+4/
         4YhL9qWnsr4tiBlVmlKT5xh1zfYQHjASpZxuDij3m3wNRjtkCO/dqHBxcjvj7C15atgw
         rFW5itOiHhTehsU6DGZ8oorRW2h5cPQZFoI+cRMel+MUme+fb10CZNbXXdoGH8ahV9Xs
         I8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292219; x=1753897019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqrJ8N5dxfQ/ZnS6euAexSYR33hLFnIxyaZ3CnZNeAs=;
        b=lf26UQLCxxyKc61jXTWtwi+lzit2lDquCkVZBIu+oKH48joOIUnKTmVYusAbAH4Wyc
         qgox6KsLFL03r9rC/0NOeCBgF5FmUHxznDCUuqHktZCcNG8LZIchoetTmlpicUkw+/bN
         AZNU4hvzfmG3mFU0Mny6ihR/MMCsKEYpBJvfhmt7lb4JA7hFyfKM5e8VWPzP9vc3RqZr
         IKd9I08r6k5E+k7xiRWdceqfHaujHgKHbGGQF3/QAk0dEAWVKTHjFq0LRiVQHWE5vvu6
         kEE5Yz6B8KyF3CgAfb9mcJRCEU3o8PWJxBnbncnL1rGL2k/ujYIOg9Pm+PHzj/FC1K+y
         kb+w==
X-Forwarded-Encrypted: i=1; AJvYcCXRpKT5lj5KeYGGpZVasE2bkKkSRmF48+yp6aEdzMNXafCpuBC5N6qZ02LQppx052nutF+vb/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQKn0lYjZUokLH144f/h8A78s52W2GFn9HuIcio+JzkGGxiM5
	wBkcYwBczJoDCJIE0z3GCkY9Ml7xDYH/kJ6tgP13mi3IDbakx214oHFdsworF+zt+OA=
X-Gm-Gg: ASbGncswl2JyIlSXjrBz0TCXFk356CRPjpjp/96bJEcR575zYPMY+hcv6NYRhoobEVR
	28BXyYWpzbA8mwxco0mTLfLpm/Mn1YjwvZnZOiqNwnd3cp6+0aNcstr2QiHXNSxyAYYJtvzJ3/f
	BZgUzO63W3BlIa91ozlQUgx3sPj2czJPGnXjZ4+mep6ezudk+EKIjizvyAUyvElsO0wZQ9QGxFP
	MIWsmc5WCAWrs4cCKjlxlx3ZN6b0FcO0PwBdmxmRDrxaOGptlnSvwAJZn54kEIeojr3K4GQo48v
	gj26WOppm4TUiukMKn8mFMGTjSRdLZ5otlzQIl2brnXDiAaIXIp93u3ARcD0skQJWQnVLrQLVuR
	G14+MEcJeEWnVBXe+oIWhRv3tm9Nnhg7goEEBCGo59LhY3wXuWAyiLLY9JySF7Fj/tzCREGA=
X-Google-Smtp-Source: AGHT+IGhq2JlrS5sQ/xuK0DxCc/tIDF7xdaql2tQWvfSdL2xrc6PGGBC4RiVxRn8rUYWfIJ9oQeWSQ==
X-Received: by 2002:a05:6402:268e:b0:608:155c:bf81 with SMTP id 4fb4d7f45d1cf-6149b5a9c80mr3199500a12.31.1753292219309;
        Wed, 23 Jul 2025 10:36:59 -0700 (PDT)
Received: from cloudflare.com (79.184.149.187.ipv4.supernova.orange.pl. [79.184.149.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c90a4d51sm8710541a12.60.2025.07.23.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:36:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 23 Jul 2025 19:36:51 +0200
Subject: [PATCH bpf-next v4 6/8] selftests/bpf: Cover read access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-skb-metadata-thru-dynptr-v4-6-a0fed48bcd37@cloudflare.com>
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
In-Reply-To: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
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

Exercise reading from SKB metadata area in two new ways:
1. indirectly, with bpf_dynptr_read(), and
2. directly, with bpf_dynptr_slice().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h           |  3 ++
 .../bpf/prog_tests/xdp_context_test_run.c          | 21 +++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 42 ++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 9386dfe8b884..794d44d19c88 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -19,6 +19,9 @@ extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
 extern int bpf_dynptr_from_xdp(struct xdp_md *xdp, __u64 flags,
 			       struct bpf_dynptr *ptr__uninit) __ksym __weak;
 
+extern int bpf_dynptr_from_skb_meta(struct __sk_buff *skb, __u64 flags,
+				    struct bpf_dynptr *ptr__uninit) __ksym __weak;
+
 /* Description
  *  Obtain a read-only pointer to the dynptr's data
  * Returns
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 6c66e27e5bc7..7e4526461a4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -171,6 +171,18 @@ static void assert_test_result(const struct bpf_map *result_map)
 		     "test_result map contains test payload");
 }
 
+static bool clear_test_result(struct bpf_map *result_map)
+{
+	const __u8 v[sizeof(test_payload)] = {};
+	const __u32 k = 0;
+	int err;
+
+	err = bpf_map__update_elem(result_map, &k, sizeof(k), v, sizeof(v), BPF_ANY);
+	ASSERT_OK(err, "update test_result");
+
+	return err == 0;
+}
+
 void test_xdp_context_veth(void)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
@@ -268,6 +280,9 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	int tap_ifindex;
 	int ret;
 
+	if (!clear_test_result(result_map))
+		return;
+
 	ns = netns_new(TAP_NETNS, true);
 	if (!ASSERT_OK_PTR(ns, "create and open ns"))
 		return;
@@ -328,6 +343,12 @@ void test_xdp_context_tuntap(void)
 	if (test__start_subtest("data_meta"))
 		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls,
 			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_read"))
+		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls_dynptr_read,
+			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_slice"))
+		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls_dynptr_slice,
+			    skel->maps.test_result);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index fcf6ca14f2ea..0ba647fb1b1d 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1,8 +1,10 @@
+#include <stdbool.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/pkt_cls.h>
 
 #include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
 
 #define META_SIZE 32
 
@@ -40,6 +42,46 @@ int ing_cls(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Read from metadata using bpf_dynptr_read helper */
+SEC("tc")
+int ing_cls_dynptr_read(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	const __u32 zero = 0;
+	__u8 *dst;
+
+	dst = bpf_map_lookup_elem(&test_result, &zero);
+	if (!dst)
+		return TC_ACT_SHOT;
+
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	bpf_dynptr_read(dst, META_SIZE, &meta, 0, 0);
+
+	return TC_ACT_SHOT;
+}
+
+/* Read from metadata using read-only dynptr slice */
+SEC("tc")
+int ing_cls_dynptr_slice(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	const __u32 zero = 0;
+	__u8 *dst, *src;
+
+	dst = bpf_map_lookup_elem(&test_result, &zero);
+	if (!dst)
+		return TC_ACT_SHOT;
+
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	src = bpf_dynptr_slice(&meta, 0, NULL, META_SIZE);
+	if (!src)
+		return TC_ACT_SHOT;
+
+	__builtin_memcpy(dst, src, META_SIZE);
+
+	return TC_ACT_SHOT;
+}
+
 SEC("xdp")
 int ing_xdp(struct xdp_md *ctx)
 {

-- 
2.43.0


