Return-Path: <netdev+bounces-202514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24879AEE1A2
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B6B7AFC2C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1D128CF65;
	Mon, 30 Jun 2025 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RQayoK8L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8728FFCB
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295372; cv=none; b=VoMQz583XYs75VvKJdeE1e+JyDukJOezQVQssmq4zHM7JtFBD+tAPoCXGuKZ8Ric2y5MDebUG4we55Xwf5QY9M4CvtRvUAZbq1tYCcgB/Xx34xsQD8vAdZQ9nfMqArthR+IgPSCQionCH7MZy5eIJR60v/Ys1SEXbHHjeBgx5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295372; c=relaxed/simple;
	bh=T1fH0b4Zu/Fp5fn9YkABF5O+x6cIxQ9D4jbtUFx3d2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SgVHrRc1p1VTBv8hYTObhToC6rFkLN/mk1FBMSpqjIo10u70jTKifKFEELQAoiYXqwYplloSk3/500Xt1YJZkMo8BQb+jv2rjyDJkz8VG3crTcRqKN72NrphcqxeZ1+OKY0/8418Aau0lBflmsy0uSUKmeSHGK/ZikUHqTxhZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RQayoK8L; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so7145365a12.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295369; x=1751900169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXqd75pUxFrznKIROBLEwC0vL8kjfd0Jo0a495WTqZA=;
        b=RQayoK8L2b8Btzmbv9zHTm97OtjY8+BJaWyhdEz1ouwD9/JolX0zow3I7WVP4cbRF5
         N9NEg/xSxmwCtMREPG8ISdj/fE/ulGotOneLeKo9rSoKWpkpfsTI6ZYNMUJtrDfJfKXm
         rEXB/g1Sqyd+PrejThQmeK0gbg5WZRvUE+Kssalj9XnFdZADbrjsWlsEqFWl+ATPfkap
         ePIV8Xry438KMHA3Qdyxu/wEpU+GP3ShSjM/TEO4Od8SIcvSipyOsEepoS0XRqwMWdZF
         cMzPT7Gd2VmtqjZe6jrOmGQFaTmTzNg5dvHAdp+p3lXTTM/KHdpugnUiVCibpBGIm1oX
         4TYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295369; x=1751900169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXqd75pUxFrznKIROBLEwC0vL8kjfd0Jo0a495WTqZA=;
        b=Zh0nIVu6ndn5gh/0E+bEOQXTh3DS4Bu/l8p1AynHVH5BNEdvLksJqY4JzwSC6fmQMm
         jR5zZN+odb4sskzFaL31Mu37Tjl9G+YxYlAFvDis9NvMxGtGZpcen49Ull8zjyViQ4bG
         eEtnokfmJrp08EBCTKJ6Zmgd/WF0vdnDrV7Yv8tSr+FYQzXQMffmaoaiGNgL4AGFKrXb
         sXWKnzwnNUMWl1nev2HweKZPo7H/3RVLiZ3Amrm9hbcYV54jpa4pePefu/8q8MMRmW0V
         YbFl+WBxSquQeNusCP00GVQljKnZTmYzqnO59Ct5XiC+ztayMm6Y786NWCJPJk1sxYft
         rgzg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Auql9IBgHl5ViCGZvW2sQsCpwR3crhueFXmyrhEB12AKVWG+ekL4/0OFVwQrOC+wZnMMEMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg9cHSzK0Q2FF4EVmmKF+sCebA9Im3Z9Pz4bs2+hyS9Xei9ojT
	ulATtcEhR9f3KzMEiBftCp3wJE0xo/iFWTBNwLKr/0LcUvpq4qPD7st/GGl2ZE/PSXI=
X-Gm-Gg: ASbGncuRNj4Qa+mD2E/WF1rsHeSdyP+6GsVGiWmhy9pknK+3KYbDAiVADAFjwIQPBIs
	Bq12+Hfo9yy62d/ed78k5KBzD/p+wCz3wKNaQ091ObCrlw/cyxpa+znainmG4iLJUvAd63Qk2KC
	TunrPrM7l82qHzZO3Fuj98x8P+WJVFAHhxK/I1pDHmZHBB3kPvjZQSTVWhkQJV4hlQAlzaMi0VQ
	tbV3J9TUJSZAvFJHoiVS24GZ+3DG702lGDqdqbWpyjDkxEKuxJAQeILgLlWL59XOsJHejbZPbT+
	ELU8JESSe05rzfxS68+hSHGJ7+p8doXyryPO6Wh4yECzIIJn1Z78TQ==
X-Google-Smtp-Source: AGHT+IGwGjJpuLLoOO8hAnJm04VO2lfw7t//T6gX0tuxd1MNiL896fzdG96iBp6VbPs4uRC5YafQDg==
X-Received: by 2002:a17:907:3f97:b0:ae3:6cc8:e431 with SMTP id a640c23a62f3a-ae36cc94000mr999707066b.57.1751295369389;
        Mon, 30 Jun 2025 07:56:09 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c0198bsm696454066b.91.2025.06.30.07.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:56:08 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:43 +0200
Subject: [PATCH bpf-next 10/13] selftests/bpf: Cover read access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-10-f17da13625d8@cloudflare.com>
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

Exercise reading from SKB metadata area in two new ways:
1. indirectly, with bpf_dynptr_read(), and
2. directly, with bpf_dynptr_slice().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/include/uapi/linux/bpf.h                     |  9 +++++
 .../bpf/prog_tests/xdp_context_test_run.c          | 21 +++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 42 ++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 719ba230032f..ab5730d2fb29 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7591,4 +7591,13 @@ enum bpf_kfunc_flags {
 	BPF_F_PAD_ZEROS = (1ULL << 0),
 };
 
+/**
+ * enum bpf_dynptr_from_skb_flags - Flags for bpf_dynptr_from_skb()
+ *
+ * @BPF_DYNPTR_F_SKB_METADATA: Create dynptr to the SKB metadata area
+ */
+enum bpf_dynptr_from_skb_flags {
+	BPF_DYNPTR_F_SKB_METADATA = (1ULL << 0),
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
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
index fcf6ca14f2ea..6b11134520be 100644
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
+	bpf_dynptr_from_skb(ctx, BPF_DYNPTR_F_SKB_METADATA, &meta);
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
+	bpf_dynptr_from_skb(ctx, BPF_DYNPTR_F_SKB_METADATA, &meta);
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


