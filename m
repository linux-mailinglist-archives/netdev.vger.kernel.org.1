Return-Path: <netdev+bounces-227176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAFBBA97FF
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCB71898544
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A15330BF62;
	Mon, 29 Sep 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ICJCksc+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7930BBA8
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154978; cv=none; b=Bf1xpe7UBaBIkJ4HLtPFg59rrEh7hzeVwSvHgPu5Ib5YtAD5Opy63voAMf56IXVDQ7taBxuTqOms2wp6tOydICTATYhK/UEkFANqk8wjiQKGZJKjJDWK1J06VvmpJ0IMuBPjU9pMqR5v04vHLbUR6HhYhJftUgsNFYgqQYmFZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154978; c=relaxed/simple;
	bh=uClrBHYDm/Uygic+25dRH8YU2SO+kz7x7OV6Hh5pfAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IeMmZynHhFW214HYOouyxe3Ja0XVZMb4SAHLTnAM0HmayrtwL6r94jEByR6EJgkv5V1YRAsxeJoQlw66rHPnvJW3Fv21YCGfekKhaiFDJSnM6mDxj0GtvZdKkzVYvDxck1DY/fw+w9DSKmqhQQy/utxh7or2YS4VOwJmAvpAWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ICJCksc+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3727611d76so648564566b.2
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154974; x=1759759774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyuHlu34uB78cop0fIFW9VKAyQp9Lgnd/uCJqWdrqzI=;
        b=ICJCksc+taUPy9NRWWJpvHoKWuxWYFiMMJGN4o3ySbM4NdiwPFcVTEA1Kpzy3WVHxg
         dXXeQ1cv4L7PXrFiKeNnQEdmGJQrBpfY0fUP+UJMTH1S1lxucCLVnAXxGlq6Gwzk65xH
         Q1kgbp3QvgAnvcv2Z/y9tygpDLGmS2p0/+szOb5U1HJlpGnYtaNq05OPWl5conr8Fe8j
         IagVlalPnlJOwA4KpezCqX8/BAAhIhoIhPtZPmM2zANbxsXXRuWjZeANwFS0zGq6rhuH
         Xc+a2L49h9UVKcKW09YzbuedvEtmIqUF6KHshAWA5LV3unw8bLrFduLlA0ihg6fRL0Tw
         ysSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154974; x=1759759774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyuHlu34uB78cop0fIFW9VKAyQp9Lgnd/uCJqWdrqzI=;
        b=VzjX5poMFSBSI6PdeJYMhkeAWdrQbgP6wC/Y4Z+1bVvEi69LxRTzZbO6hEFuRMX6lO
         GLSB+QPkdEFSH2P52H4GDt812tjmlwJ1RK23e1me0X3zmLQq+HFVV/Uo+oqEO9cEG/jd
         h6R7O4zmYcaxjPFcQevoWz5/tmykc9hoLbc9aZimwITNBiyVx21rTIBcBh+yWjp8dcIy
         vTNPeMJ/K0ivYgnDbH6OSBFoySAmeQCsdb+4ArG6CKXLL6jOfUBvu0FRW4XMi1ID7cBD
         zNdFsDX0lVdF+MB69QBdSvxBPX34fdkvlU4RProPPpUKE6CkhAVsjYXL9KquoeZHYj9E
         8dXA==
X-Gm-Message-State: AOJu0YwD+Jp3QFkaqwA/dWCMA66zRxSc8PydGRvvVe2rBFonsFBnDKyM
	16eroffo0OVmR0Z1j6fkdViFVkFSNIhCqrPYsJyObdXZldv5l7Xnza/y8CXKxNGiDGUase6TYc9
	hBDlw
X-Gm-Gg: ASbGnctadadMi19ofNezApA7F/hgxRkxPjQigfZ49bMK0pFsKig2bJERgWvAOeA0tCD
	UadwnOLGYmdStgLQYYII5vUabRwMKXkGUX/3Q/RccE8JY9AkvhimWL94iwTTrNzXK1eKYjfhbeo
	17WZyJSuE1AUEA0ILBgZk4oeaGOKUlsbRox2Zk/bCzOe5w6AyctG3dzz9btnBFlNGJsOGvjVTXV
	wpVIsc78zR09hIhKhMSHc+G5VHMdi0/+Pd4HZx/AX/GvASnFgNomxm0luk4M5KqqIwIEzMQEWYM
	bShJA/gYdPPsc4JAEs0OI5fxI3ANYqDThxcIGj0zca1vfUbkvSKMIBNP+ZsHc0abCCQxuJ1ENXy
	AhU18WFP2c9c09GHV2CaYcCt+vkbKaQsDBf7egr81kIA3GYPcp/DIUfUY49cwZodI1syvzPKBIK
	wcZgAmdj7q53fALydYvs+AME39d8pzQV2tP3s=
X-Google-Smtp-Source: AGHT+IEVauC2sgHSJJ7xcsJoPjXKEhEYVD+OrtNyZ+p7snUDYWI/hwOaqbvjKpkV9eX47O/tVfU/PQ==
X-Received: by 2002:a17:907:7e91:b0:b2a:dc08:592e with SMTP id a640c23a62f3a-b34bef96395mr1615837266b.49.1759154974186;
        Mon, 29 Sep 2025 07:09:34 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa494esm932915966b.25.2025.09.29.07.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:33 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:14 +0200
Subject: [PATCH RFC bpf-next 9/9] selftests/bpf: Expect unclone to preserve
 metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-9-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Since pskb_expand_head() no longer clears metadata on unclone, update tests
for cloned packets to expect metadata to remain intact.

Verify metadata contents directly in the BPF program. This allows for
multiple checks as packet passes through a chain of BPF programs, rather
than a one-time check in user-space.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 20 ++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 94 +++++++++++++---------
 2 files changed, 66 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 178292d1251a..6fac79416b70 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -462,25 +462,25 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.ing_cls_dynptr_offset_oob,
 			    skel->progs.ing_cls,
 			    skel->maps.test_result);
-	if (test__start_subtest("clone_data_meta_empty_on_data_write"))
+	if (test__start_subtest("clone_data_meta_kept_on_data_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_data_meta_empty_on_data_write,
+				   skel->progs.clone_data_meta_kept_on_data_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_data_meta_empty_on_meta_write"))
+	if (test__start_subtest("clone_data_meta_kept_on_meta_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_data_meta_empty_on_meta_write,
+				   skel->progs.clone_data_meta_kept_on_meta_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_dynptr_empty_on_data_slice_write"))
+	if (test__start_subtest("clone_dynptr_kept_on_data_slice_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_dynptr_empty_on_data_slice_write,
+				   skel->progs.clone_dynptr_kept_on_data_slice_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_dynptr_empty_on_meta_slice_write"))
+	if (test__start_subtest("clone_dynptr_kept_on_meta_slice_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_dynptr_empty_on_meta_slice_write,
+				   skel->progs.clone_dynptr_kept_on_meta_slice_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_dynptr_rdonly_before_data_dynptr_write"))
+	if (test__start_subtest("clone_dynptr_rdonly_before_data_dynptr_write_then_rw"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_dynptr_rdonly_before_data_dynptr_write,
+				   skel->progs.clone_dynptr_rdonly_before_data_dynptr_write_then_rw,
 				   &skel->bss->test_pass);
 	if (test__start_subtest("clone_dynptr_rdonly_before_meta_dynptr_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index d79cb74b571e..3de85b5668c9 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -28,6 +28,13 @@ struct {
 
 bool test_pass;
 
+static const __u8 meta_want[META_SIZE] = {
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
+	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+};
+
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
@@ -304,12 +311,13 @@ int ing_xdp(struct xdp_md *ctx)
 }
 
 /*
- * Check that skb->data_meta..skb->data is empty if prog writes to packet
+ * Check that skb->data_meta..skb->data is kept in tact if prog writes to packet
  * _payload_ using packet pointers. Applies only to cloned skbs.
  */
 SEC("tc")
-int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
+int clone_data_meta_kept_on_data_write(struct __sk_buff *ctx)
 {
+	__u8 *meta_have = ctx_ptr(ctx, data_meta);
 	struct ethhdr *eth = ctx_ptr(ctx, data);
 
 	if (eth + 1 > ctx_ptr(ctx, data_end))
@@ -318,8 +326,10 @@ int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	/* Expect no metadata */
-	if (ctx->data_meta != ctx->data)
+	if (meta_have + META_SIZE > eth)
+		goto out;
+
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
 		goto out;
 
 	/* Packet write to trigger unclone in prologue */
@@ -331,14 +341,14 @@ int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
 }
 
 /*
- * Check that skb->data_meta..skb->data is empty if prog writes to packet
+ * Check that skb->data_meta..skb->data is kept in tact if prog writes to packet
  * _metadata_ using packet pointers. Applies only to cloned skbs.
  */
 SEC("tc")
-int clone_data_meta_empty_on_meta_write(struct __sk_buff *ctx)
+int clone_data_meta_kept_on_meta_write(struct __sk_buff *ctx)
 {
+	__u8 *meta_have = ctx_ptr(ctx, data_meta);
 	struct ethhdr *eth = ctx_ptr(ctx, data);
-	__u8 *md = ctx_ptr(ctx, data_meta);
 
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		goto out;
@@ -346,25 +356,29 @@ int clone_data_meta_empty_on_meta_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	if (md + 1 > ctx_ptr(ctx, data)) {
-		/* Expect no metadata */
-		test_pass = true;
-	} else {
-		/* Metadata write to trigger unclone in prologue */
-		*md = 42;
-	}
+	if (meta_have + META_SIZE > eth)
+		goto out;
+
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+		goto out;
+
+	/* Metadata write to trigger unclone in prologue */
+	*meta_have = 42;
+
+	test_pass = true;
 out:
 	return TC_ACT_SHOT;
 }
 
 /*
- * Check that skb_meta dynptr is writable but empty if prog writes to packet
- * _payload_ using a dynptr slice. Applies only to cloned skbs.
+ * Check that skb_meta dynptr is writable and was kept in tact if prog creates a
+ * r/w slice to packet _payload_. Applies only to cloned skbs.
  */
 SEC("tc")
-int clone_dynptr_empty_on_data_slice_write(struct __sk_buff *ctx)
+int clone_dynptr_kept_on_data_slice_write(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr data, meta;
+	__u8 meta_have[META_SIZE];
 	struct ethhdr *eth;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
@@ -375,29 +389,26 @@ int clone_dynptr_empty_on_data_slice_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	/* Expect no metadata */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) > 0)
+	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
 		goto out;
 
-	/* Packet write to trigger unclone in prologue */
-	eth->h_proto = 42;
-
 	test_pass = true;
 out:
 	return TC_ACT_SHOT;
 }
 
 /*
- * Check that skb_meta dynptr is writable but empty if prog writes to packet
- * _metadata_ using a dynptr slice. Applies only to cloned skbs.
+ * Check that skb_meta dynptr is writable and was kept in tact if prog creates
+ * an r/w slice to packet _metadata_. Applies only to cloned skbs.
  */
 SEC("tc")
-int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
+int clone_dynptr_kept_on_meta_slice_write(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr data, meta;
 	const struct ethhdr *eth;
-	__u8 *md;
+	__u8 *meta_have;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
 	eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
@@ -407,16 +418,13 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	/* Expect no metadata */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) > 0)
+	meta_have = bpf_dynptr_slice_rdwr(&meta, 0, NULL, META_SIZE);
+	if (!meta_have)
 		goto out;
 
-	/* Metadata write to trigger unclone in prologue */
-	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	md = bpf_dynptr_slice_rdwr(&meta, 0, NULL, sizeof(*md));
-	if (md)
-		*md = 42;
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+		goto out;
 
 	test_pass = true;
 out:
@@ -425,12 +433,14 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
 
 /*
  * Check that skb_meta dynptr is read-only before prog writes to packet payload
- * using dynptr_write helper. Applies only to cloned skbs.
+ * using dynptr_write helper, and becomes read-write afterwards. Applies only to
+ * cloned skbs.
  */
 SEC("tc")
-int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
+int clone_dynptr_rdonly_before_data_dynptr_write_then_rw(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr data, meta;
+	__u8 meta_have[META_SIZE];
 	const struct ethhdr *eth;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
@@ -443,15 +453,23 @@ int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
 
 	/* Expect read-only metadata before unclone */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (!bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != META_SIZE)
+	if (!bpf_dynptr_is_rdonly(&meta))
+		goto out;
+
+	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
 		goto out;
 
 	/* Helper write to payload will unclone the packet */
 	bpf_dynptr_write(&data, offsetof(struct ethhdr, h_proto), "x", 1, 0);
 
-	/* Expect no metadata after unclone */
+	/* Expect r/w metadata after unclone */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != 0)
+	if (bpf_dynptr_is_rdonly(&meta))
+		goto out;
+
+	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
 		goto out;
 
 	test_pass = true;

-- 
2.43.0


