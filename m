Return-Path: <netdev+bounces-230727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCB5BEE563
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1E094EAF26
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F242EA498;
	Sun, 19 Oct 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GRJNY9p+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670842EA46B
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877964; cv=none; b=hMUKf/VZ9xRj0x7NzMD53jst5Pgd6b1CR+l8dAmq9h466A7GC0d4/owVWzglogMqVUyOJojEpXEY/L2qupRSABrYlVN1E3zEwWeyr55QdPnaUNllQ0XbcAL6GVS3LWJGAB07eO1ctZmrQwprz/PwHOspy7zS38MzKsPn24/GE5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877964; c=relaxed/simple;
	bh=9bMFW5HlTADRbtDaOiOSff+WzK3vNaMYFT6OovA6rWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XybNQ8Z7ZzwN+Y+h1a4mLiGFRTXWLRgydqibGRRNho7UxKQ5pUCY2QQItA9kdTjZU8zSpGmPapgztHBIj9tE19T5QD5AyqNR2GbgqFbuDHURva9ZNwWr63B/UpBcwVIn8pvnBynOFMs2oUhnJZ14biUFbbb8wbLrHj6oPxX6gJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GRJNY9p+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so721244066b.3
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877960; x=1761482760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWb06XbiC/Ghu5psY6ZDtCdUlhVGHcGFTCaD3dYiVcA=;
        b=GRJNY9p+A2FU0Wn/+FX1n7GY8V8XBeZjAW7wwB49F0ryDfat0RIMzP6A2aqwEiNrZI
         obWbmVvvzJcDU+jB1ct7vumsnBJWJTBCN2cYI7+Ls+Tl5GSI1fkxzbvmZqQvfW/1ji+x
         7XMq+BdmnFuPcWqTj3dMCvMsSKgp8zKc6P1o5aQwKSQWrbamzCFKcBcXosOUtea+TkMo
         k1Xr4e/sx0sS6HL7yepe/r2iX0i7hO4qZiD9CHo4yauDHIfh784zqJ+AKqDfK4nmzvHI
         SjR/bU+M97un489BqlMBUZYDqUeKas7LSihScJtlE1RJyMfkdb+b6zuhbkWgSk6DU9zc
         GRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877960; x=1761482760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWb06XbiC/Ghu5psY6ZDtCdUlhVGHcGFTCaD3dYiVcA=;
        b=eLoD4I9M6bwnbjrVgFtSahkQygus22EQjhHzwdh/HxqpikbHyC5N44ctLWUX467qDo
         KzoAybL6D0Wbhgt1T8LZYdSpM6V2o6ah6RjFYS2reU0jwN9NcuFR7pIOZzmxNrsgWtd5
         zuUov5xpzMbZ2wZSWMd4i/XolPJT442Fcy/KgGwdarg5K1ng4ksM05tf8o2m66lXZHgg
         vms3Pu4WdF9o91di3DKwYFxQtE/5zZfKE8eEaOfEtmwwiLDQv/H4nwqfo4t61p8P2HDJ
         Tw3vTx7JXK2/lVRcj2DSlHPK3306BgbMh6JPpPYAShRG8IQDCyftrFaoO49ZOEOYNpLn
         QVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXwUTs9hKl7ZYpNcU+BL5sgQCk/GxBf85b3sbVGtRjZnL2PFmqaQiUieQXLDi14BvztKBlft8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVo6r6DiKR17fUd/PTdZnEH948HUybu+4SyAGSbieFTillKAWp
	PCIlzTjotZUJ1vFtrS/qWzfQ+u/KgBnlYL8jxUSNkbmFwc5vWA9Sn/cxAFytx6khWJSQSLILDks
	FhjG9
X-Gm-Gg: ASbGncsyOvcY0JpQWoQxyC6563AiSRo4UUN6hAqgK4V26CMzwEsVrDB0FV5JZaNEAeq
	+gIhe868y9VOzce5v/b0fHE0U0J0iGEsDS13XSS9DQ3vsBFnmvTwvvvW1ggeMFGpVi/o2xTnPrM
	wDYluWYTq35ATFQfT38C1/tiiWt8094XivYUPDYtXX6hrH9zSnpLrwH9Yo0nJ90NUE3NlSlCvAD
	TMgVXF4BlungwFs3imyfhPhPXSREqFmtYIAD2LQQy9sDrMUGexyRi+eoSmOb8ToyIvlxB9y5Kob
	rsO+uP3sTViylaIML4tSHwF2QVKq+UwdIvvliFVUeW6ZIv/htFJy0bQTbx/yNiRMcrnFRPZxjDu
	UFqyRPpK05XINncKDuO47q6XDqOVILRLFxxbhliktd/1bG4knTpRjOUk+XZ3a6D4Mtndk18JDcL
	YhVEuAc9S/pmR2z7UCzMIUp6En2ofQfeaol8biiYhFTpXdYBet
X-Google-Smtp-Source: AGHT+IFVIHsKShosytEtskKMey3yttj0MpCEw1KOtRaphKkOvfeE0dU/7yPwkDJB+aVs0gwC4TKr/w==
X-Received: by 2002:a17:907:7f0d:b0:b04:274a:fc87 with SMTP id a640c23a62f3a-b6472c61940mr1174667066b.4.1760877960231;
        Sun, 19 Oct 2025 05:46:00 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebf49fd8sm506236566b.83.2025.10.19.05.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:59 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:35 +0200
Subject: [PATCH bpf-next v2 11/15] selftests/bpf: Expect unclone to
 preserve skb metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-11-f9a58f3eb6d6@cloudflare.com>
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

Since pskb_expand_head() no longer clears metadata on unclone, update tests
for cloned packets to expect metadata to remain intact.

Also simplify the clone_dynptr_kept_on_{data,meta}_slice_write tests.
Creating an r/w dynptr slice is sufficient to trigger an unclone in the
prologue, so remove the extraneous writes to the data/meta slice.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 20 ++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 87 ++++++++++++----------
 2 files changed, 59 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index a3de37942fa4..df6248dbaae8 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -458,25 +458,25 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.ing_cls_dynptr_offset_oob,
 			    skel->progs.ing_cls,
 			    &skel->bss->test_pass);
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
index 33480bcb8ec1..dba76f84c0c5 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -326,12 +326,13 @@ int ing_xdp(struct xdp_md *ctx)
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
@@ -340,8 +341,10 @@ int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	/* Expect no metadata */
-	if (ctx->data_meta != ctx->data)
+	if (meta_have + META_SIZE > eth)
+		goto out;
+
+	if (!check_metadata(meta_have))
 		goto out;
 
 	/* Packet write to trigger unclone in prologue */
@@ -353,14 +356,14 @@ int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
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
@@ -368,25 +371,29 @@ int clone_data_meta_empty_on_meta_write(struct __sk_buff *ctx)
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
+	if (!check_metadata(meta_have))
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
@@ -397,29 +404,26 @@ int clone_dynptr_empty_on_data_slice_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	/* Expect no metadata */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) > 0)
+	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (!check_metadata(meta_have))
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
@@ -429,16 +433,13 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
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
+	if (!check_metadata(meta_have))
+		goto out;
 
 	test_pass = true;
 out:
@@ -447,12 +448,14 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
 
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
@@ -465,15 +468,23 @@ int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
 
 	/* Expect read-only metadata before unclone */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (!bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != META_SIZE)
+	if (!bpf_dynptr_is_rdonly(&meta))
+		goto out;
+
+	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (!check_metadata(meta_have))
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
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;

-- 
2.43.0


