Return-Path: <netdev+bounces-235987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A9C37B44
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 106ED4F7B0A
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99F034E774;
	Wed,  5 Nov 2025 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eMTJLRR+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C8134DB7D
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374009; cv=none; b=cW/N0aoROTy/iCluyXGHpRDSD+tyTRJtusL8qzkJYHhBo9iOJoNgI3a8/YM4WvzahXrLOQ7JgKE/ERNiP3lXBwJEA65LhUt/f/zIRQlo7cjVc5gTepvRHzTpZ5AzQUg3jwPGW6MHE4H8mBV/MVeEWfTAB4dhWibJrUQrfH7ynCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374009; c=relaxed/simple;
	bh=Y2LdFSioG8g7ODW7ylq50FrnsN/jGmVNxn8bY70Dfxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/S/GaTRo5P0pgQTMzXUtcU3TE+8t5vOBpFHiN5hkcni7kXB1d/DJZBbuIQM+4Jj2/SSyNdfvDb4Z46BRTTYcJHgCf2O9OT7hgmtwCuR1362fYp9rkm10ZdyNipAuGgVYD8mo1mIxfMyJIEhcfIX2T9UQt/ODKOCjgbvX1bEDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eMTJLRR+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6409e985505so276004a12.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374005; x=1762978805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smKSa5PEnPQYiO/xTRww69R1IfUnmprG+VxEw4Hb8Ac=;
        b=eMTJLRR+jkI/QUR5Jx15hzt07jmo4SiW8TdnB3gQ7ya6cnmTdu1oGJFTrZbtSbjCMG
         1sxEcrTnha1qXPnQfNRj7rjIJV9X0m29jMogrhCEaz0oeanYim0EXiovHAWMy9uLO+J/
         iU4VXemE9t0o2Lab/FGEPdNivcI9lncEM0Kx6Et6F+kndeqDzi5oE0WEM446zx3b+75z
         aa8H4wwlf1lNCaCp8GceeZKF5IKOTcT8PhZWXT4L25jSuSoVWCmkmiFQadjFJgTaHmmi
         g6R3T1qt4YziyL6f01MOWbEESvaqEr0iz8TBaweTcGBwYQZO0ei+BnpiU8T94qHtvsjl
         7FOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374005; x=1762978805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smKSa5PEnPQYiO/xTRww69R1IfUnmprG+VxEw4Hb8Ac=;
        b=UrxGlEyQ1+Tv5NSDOgT05DA4jj48e6yoQ2Xbw0PqbdxblJErCHCiR9879+omwxgps1
         znoVZnyAr/NhncJIetnjFjY2kvE1sE11wLSJT/+MX2JrerAW4e/mrhG14QSnyjEV8Taz
         aXDHji37BAzU63sPzZBp1cWnizo/OqfimN7TgXdU3aR75WFigcZXh9AhctHwu5k2T96t
         bvDUXoiuh8ZHH3v2yqqKz4LB4o/nxmhJlc8Vcp4u2k4oH5laIn+q6++kD7BkrRKkJrf+
         jISEsdXOIvKGENt4S7qrJIeq5KbJhZRwk36vA6cJ9FkaO7iS/8dSUvKPbQ5mSvEb8oyP
         /lZg==
X-Forwarded-Encrypted: i=1; AJvYcCVutv5zTWfoOICCaoMlAEBuLNSKig0U2+LYnHb51MmGALOMCKD5udPpXaazYgHYot6K0aCQLAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEZdb8kcGQNI8+g7Q78uFQL6vtqAEjBEcXVeYxk/hyCRdP7r5
	qud+ymErvNBWut/ZE+ACNoq6VeuRpjepE/JzeEv+l7zGIf5aPBSgZ6xIJITYDFjLlvU=
X-Gm-Gg: ASbGncsbCuGZM2ezGijZv6YWI2Q6YGgaBZD4G0cICBHwQiCdGZDoAURhGsz5rixcCk9
	2nqYGe17aF2UiLO4aQhaf2gCzLl7QFLP29pefvsa8NHL9MYpnY03ZBuaGDmjZohUsdqCZHkRO/d
	PrnGVIaIEsrh8N0Ik8VtmXO8cQwQuELpwJzTM2JRt43vxskiCk35YG66zZRFKwTpMx54W9rBPBl
	U8dttBDJWOapvzixv6EjHFId8IO1cHE2j0Qbfot5S+1jqT5RAw8W7qNK+9ZGUJDndCu3rkGydT8
	8r/wTQtiFAFs5NIRSA2l+RVkJHuFettKSmaiSbdhPfM+iKEOAxySESO38V17QotxBco4frst/VR
	W2a3vN/JT+JlU/z0+UzXmC+O6VQ/oDEE7Hv6EnggWV1dD7ugVh66oeYe6nrTfQP4GT6ZRN49T5Y
	DR0unYFHtXNArJrfPQ1uj3aRJpRGyyThy51AJSAXeL/BmnWXGzbsjQa4Tf
X-Google-Smtp-Source: AGHT+IFNXQINzOeV4swYoRdovmW3cf+3ri/ZC3LWiqRh2j7kLPwbPrOZR0TyAh5EZR3b9uCSKLi0kA==
X-Received: by 2002:a05:6402:35d6:b0:63c:690d:6a46 with SMTP id 4fb4d7f45d1cf-641058d0b39mr4080673a12.13.1762374005502;
        Wed, 05 Nov 2025 12:20:05 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e12fsm42874a12.34.2025.11.05.12.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:20:05 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:48 +0100
Subject: [PATCH bpf-next v4 11/16] selftests/bpf: Dump skb metadata on
 verification failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-11-5ceb08a9b37b@cloudflare.com>
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

Add diagnostic output when metadata verification fails to help with
troubleshooting test failures. Introduce a check_metadata() helper that
prints both expected and received metadata to the BPF program's stderr
stream on mismatch. The userspace test reads and dumps this stream on
failure.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 24 ++++++++++++++++++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 25 ++++++++++++++++++----
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 93a1fbe6a4fd..db3027564261 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -171,6 +171,21 @@ static int write_test_packet(int tap_fd)
 	return 0;
 }
 
+static void dump_err_stream(const struct bpf_program *prog)
+{
+	char buf[512];
+	int ret;
+
+	ret = 0;
+	do {
+		ret = bpf_prog_stream_read(bpf_program__fd(prog),
+					   BPF_STREAM_STDERR, buf, sizeof(buf),
+					   NULL);
+		if (ret > 0)
+			fwrite(buf, sizeof(buf[0]), ret, stderr);
+	} while (ret > 0);
+}
+
 void test_xdp_context_veth(void)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
@@ -249,7 +264,8 @@ void test_xdp_context_veth(void)
 	if (!ASSERT_OK(ret, "send_test_packet"))
 		goto close;
 
-	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+	if (!ASSERT_TRUE(skel->bss->test_pass, "test_pass"))
+		dump_err_stream(tc_prog);
 
 close:
 	close_netns(nstoken);
@@ -314,7 +330,8 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_OK(ret, "write_test_packet"))
 		goto close;
 
-	ASSERT_TRUE(*test_pass, "test_pass");
+	if (!ASSERT_TRUE(*test_pass, "test_pass"))
+		dump_err_stream(tc_prio_2_prog ? : tc_prio_1_prog);
 
 close:
 	if (tap_fd >= 0)
@@ -385,7 +402,8 @@ static void test_tuntap_mirred(struct bpf_program *xdp_prog,
 	if (!ASSERT_OK(ret, "write_test_packet"))
 		goto close;
 
-	ASSERT_TRUE(*test_pass, "test_pass");
+	if (!ASSERT_TRUE(*test_pass, "test_pass"))
+		dump_err_stream(tc_prog);
 
 close:
 	if (tap_fd >= 0)
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 11288b20f56c..3b137c4eed6c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -27,6 +27,23 @@ static const __u8 meta_want[META_SIZE] = {
 	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
 };
 
+static bool check_metadata(const char *file, int line, __u8 *meta_have)
+{
+	if (!__builtin_memcmp(meta_have, meta_want, META_SIZE))
+		return true;
+
+	bpf_stream_printk(BPF_STREAM_STDERR,
+			  "FAIL:%s:%d: metadata mismatch\n"
+			  "  have:\n    %pI6\n    %pI6\n"
+			  "  want:\n    %pI6\n    %pI6\n",
+			  file, line,
+			  &meta_have[0x00], &meta_have[0x10],
+			  &meta_want[0x00], &meta_want[0x10]);
+	return false;
+}
+
+#define check_metadata(meta_have) check_metadata(__FILE__, __LINE__, meta_have)
+
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
@@ -36,7 +53,7 @@ int ing_cls(struct __sk_buff *ctx)
 	if (meta_have + META_SIZE > data)
 		goto out;
 
-	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;
@@ -54,7 +71,7 @@ int ing_cls_dynptr_read(struct __sk_buff *ctx)
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
 	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
 
-	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;
@@ -92,7 +109,7 @@ int ing_cls_dynptr_slice(struct __sk_buff *ctx)
 	if (!meta_have)
 		goto out;
 
-	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;
@@ -153,7 +170,7 @@ int ing_cls_dynptr_offset_rd(struct __sk_buff *ctx)
 		goto out;
 	__builtin_memcpy(dst, src, chunk_len);
 
-	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;

-- 
2.43.0


