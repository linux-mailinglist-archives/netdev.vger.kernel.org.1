Return-Path: <netdev+bounces-232979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED9EC0A996
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 15:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167F63B30E3
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A61E2EA735;
	Sun, 26 Oct 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TZ29X/wy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4122E8E11
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488336; cv=none; b=b0vjsGnvJDbpm5KP4iHHgvKGhE66tbeuBgqqNuv/LIisFwEVGkp0v8NCppfpYv98j3glyJEeR30jJmwms2eQ3u3vDCLWjk4RiJtiek+PM6l5SeF59OrZE6692n32NkRAQI0ARDAOEcQE2HaNv697v71JenT9J6aNgCbfvWoZCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488336; c=relaxed/simple;
	bh=QLtifLAo6DoQNQzqPAPg3BdJ/ZCpnYmryjgKOcJtCDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QelFSVj0xsW89f2LHzgswCUOU8c54sbsAiirh/a5Jp2z9ifrQWyXOdQeMjDj6a87AOpv7wH/NcRrpKbEp1qPKp2sexSCURFLWONn/sKzIeenPCdnetNjSCOZRSbAYTy0P5ay/3CX+JO0qJPc0tq/3Y5Nnzy6y2OHF91CKWpvGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TZ29X/wy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b6d83bf1077so327901866b.3
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488333; x=1762093133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7z6z0qFsyvfpYZ94W/vWTb8pxF4QWqgrEJLgT+yyI8=;
        b=TZ29X/wykdPsK79dkwfMtI0mH9vyh363JFB3AvWPze5TAyVTaysb4GmY/nJPbDtFoL
         DImjhMSZFJfxZAfTQmgjjaqBs69ya4fqXwlQN9CVXm96WNGLqPhYqLc1Hk7ggvjJrBaD
         gryxx6WXZjdOLlrexpRaHHxAYxOZV7cxU8IwsoGIKiInGgAydy5URVAc4Pe5l7a/S1cO
         PNrqnRqYBIG2mrKLc3GIejDHYkJmAYQWj/xOsMlvi8T7s3EB8d05vkPOwTTB32kjNvLI
         I9EPr5DvvLDLs6FNaeBlT+mytY+Cl4D3bQQM6N5wXbpC+m14Z2jZ/F00GDYmBPl9pfYl
         ZTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488333; x=1762093133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7z6z0qFsyvfpYZ94W/vWTb8pxF4QWqgrEJLgT+yyI8=;
        b=Qv2G8n211vV+Ly5ig/TRFheqMNrHVQlPdRerGR1QMnT0lJLWsEEbNALTnBAe05gVDO
         xwvG4SMJ1b7Fd69zD+yA0z0V2xTbjT/kz+0nYR/x9u55vlhnVgdBsZbdWyxz7s3y9zOI
         ser5QLgaEjf1JZRcycVRurEaXVV0djINeiFFzJBmQ+QES1/m4kd4inL8yWDlWH/gQYh7
         UGULJRxBfa4R9IBLTeOyTK7kRj3HjXe8VPTcD62b82y+1uN9BeacAMC6td0ErD6jqz7V
         zXWhVsRJPnxqNe+68AZEWE+vBfkqD6eDqia1DsW+j5en1i/xTLqLh63q1AodQWdV45zt
         LNXw==
X-Forwarded-Encrypted: i=1; AJvYcCUKWiArlH5/AkRnALLJp8oKKLuR+KuWPoyikRHaKv+KdmX5BKZfpFIO3Jx/O8+NA/z+faesGqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZD3d9yfcE992JapmR2NRqATVwyXekRVMh9KHiZpEitpx+O/n
	UmaOia494iaSUiOAAhJa5jcsmGNqD0E+/tVXw1fVxGv90W8hFyDF6fQrvJo3yrQV+eY=
X-Gm-Gg: ASbGncs852mJK4MfQcyr70REf5ACIYu+QCb1H4anQ27+PNbpQ0U9op3GxQ9K5L6em2I
	UcwBH6KaTCQnzNt4W7PFFadx8XbduGuyh0xUac/qP2lHbiqJckLYAES6khkNffswgxBkUYVjyas
	zx/e1pd/BIPX314yO0WXQ9suALs2I+IBz/ORuQ4hN1jS0XvGByjaaje5GXPjYmYPF6mff0oKZSj
	bwjmeTcBpnL+e/O5ln5UwXnm9hMmoymuayRKzE+sQzzgl78Yay0omMqEB+ca4qDGgfAU3lEEAmJ
	THYWpsleUjaw8w+NSmEE04woHo9wf6MpVCltNUNJqW6JpuPQsQBR9rI+LC8RdB0U6QEXGqiLFyD
	WJMrzZjKHPQvcnbRZOp6oAFNrPqwCrzP2I90E4X/PrvoxjINMe3L+4hjlWxtF4hxZNoEzOm4xaC
	wDvLK7dnQz1RNfqckbQpzBzLIWugvsPrn1WUk17qB2jElAbg==
X-Google-Smtp-Source: AGHT+IHJvlwy7v1F8N3cycRZrmkjSsl1meGJXvz7OXM7p5PUXryDbr4CaoiylSWqji6oVKxWBeztiw==
X-Received: by 2002:a17:906:81d9:b0:b6d:5b0c:289e with SMTP id a640c23a62f3a-b6d5b0c447fmr707687466b.0.1761488332693;
        Sun, 26 Oct 2025 07:18:52 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85359687sm475555166b.23.2025.10.26.07.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:31 +0100
Subject: [PATCH bpf-next v3 11/16] selftests/bpf: Dump skb metadata on
 verification failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-11-37cceebb95d3@cloudflare.com>
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
index 11288b20f56c..74d7e2aab2ef 100644
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
+			  &meta_want[0x00], &meta_have[0x10]);
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


