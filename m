Return-Path: <netdev+bounces-230726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB83BEE560
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D36C1896319
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8372EA163;
	Sun, 19 Oct 2025 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="N4dl4by1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D72EA174
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877962; cv=none; b=r6bEOsQC4N/BLX8bozCtI57wgP9TD1BR/JYNkj1yzLQ/sABDUfOf5LGsPgUA2GW8TM8jPOjowIblYEJ9Inm3v9jkDvADm35UCklCJCNiy9R6XsLjmv8CsEcNtBuVKMR1HggN42lPtqwb8ULkjHMr4jM160ZWl1AWHtgP/DSmYzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877962; c=relaxed/simple;
	bh=j3wCzvjor6QWsp2tVWjjOGv4H6e3eag/h8EaKZRMXRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tNgIioiOVNGBILmI4qx4y65/BCc+MpZ3Qp3564ewLmBqCDhW7OeJZYybp/tnXdiKFS14uumyFzFXsdMd+frSGBvz08h6Dqg/b3ooH4Yg/3fl0+cnsYIr3ssUmZZx0WgWceEu+L5i3QPQsjJzSlKByzwB+H9l1yobo9ruLxmBjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=N4dl4by1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso654893366b.3
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877958; x=1761482758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXiP56DFDvDVt7D+WYCLf0zDFn3OmAK7byzBV+D+DjQ=;
        b=N4dl4by1yxIWgYjdfHSr8rcoR2Mg1byQe12mU8TMx3AA+Bm01YSJoGD/n6iGhe8dpc
         O8/epZQG31jjS3I/2sbQd5OzZkkOCDh+uudRMltRGoc/Ds4zUSQuVsqNOxyrVpo5MwL7
         9GW2UIqR27hI3B7PLhmJiKf2kENrAtMtLmUQm7BAWzdp2t1x/jSj68EjTFCJZJuQ8EVv
         jhaU66CrrPLOXFQHwG5+90YO+yRg9/6O5F3rfmNHvF6K3AFHV+l5hlk6vGHLlz0cVVM2
         yXaDBVcGL2HdbRgEkLFrmDX6JuSgzDuisqyT71EUMnr4+d+bwL6u2ekiEvrezRK6gjyT
         PY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877958; x=1761482758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXiP56DFDvDVt7D+WYCLf0zDFn3OmAK7byzBV+D+DjQ=;
        b=RuXTUoMs+LrjUtgbyNPPcywGjDOQKtk8n0sn66agi6lwvSxampqGLJ8L49F6mnXipV
         r3ILz2yR+29/6XRhXgJTI5TAF+3z6z4+7rZttp7TrCYw9+AFzu9iA9jtKI/XZhCwQhkn
         aLVpnCi47M9LBYckmZwq7Kg/ufJXL5kEuL9Ezlm6kvCsB6luOho4+FLv7WKd7wTYX0P/
         vkLH6dmGyEVqiZibsnu+coOyEi9np0AKTME4kw9PmH/JNzmmXMVVgYFE68LD1cw7/QXh
         bevpQWzlcmOAqS8FtHzdAvXjTIXV3BQpdPkp8Wkh0QmXK7K4CAFnL+fYThAtlWSQhGpn
         2gPw==
X-Forwarded-Encrypted: i=1; AJvYcCWaMzlO1X+vIlHfV2NhbESvRMoUMc+l7rU9uHeVrC75PRfNfKL+kndW477VhlDFHy4PVi+ORLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4t1PDIrksvCftQXrZmpM++FpU6tt6L1kPvyxIKBubt/tUymh
	FiyCQvMmXITRqqeZKRyTk0Wf2BKuxsmolZDkU65lTtRVA4RdXubW3z4FwrkzPqdGig0G/iswWQP
	ImZVx
X-Gm-Gg: ASbGncsE8PomeBSkN+j6kYB2BCDe0cy+x7eLA4eOeoqZWZWM+f2YWBJFXxHJ654TOKn
	2o7QAWgaKfyW9une6Gd3N2Upxw4XKPyaU41qWLgbZHh8YllyDam3s14hMWnPPE04l15mF0BVUi8
	wN4y6Ec0LHgESKeTRDzmGMHY96BTHL2BGn07S4lpp6zdKRqEZeBd3aIHCoCfMs2Jegh6k/xl+UC
	U5xsEIMNDJj9/mObLWIBk7yo3rxgyaC2RTf8f1GNhrFivRiivtS137aRhFa+7fc4ZVlOUX8zZjn
	SUR12h8yd6zYZ/GAjuceLm0hGYwrJR7uIPIlFCnTXy2aWGlwso6Do6Z6JzWmw3w8uijHu6VLyMx
	HJ9TqCDtWyr5LVtULpNoYrA/7h5KPgTprkkriKJiu1hH+9zTprftj/NsYNHB9C1RZurrNcInkJy
	GtQ8AA1q0EM/qRVKjembSUejrmo17O158UtMcah2kcyKsjLOiT9w7kDHuwcHM=
X-Google-Smtp-Source: AGHT+IFYNuuYdJQZqLTesVfJKHZBhILHTCf/LfpzeW8r2w+TggjstXcp4pEsHdvf3pzzA34xrxoujA==
X-Received: by 2002:a17:906:13d0:b0:b64:980e:6ecd with SMTP id a640c23a62f3a-b64980e7800mr774891566b.18.1760877958314;
        Sun, 19 Oct 2025 05:45:58 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb03671csm493666166b.38.2025.10.19.05.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:57 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:34 +0200
Subject: [PATCH bpf-next v2 10/15] selftests/bpf: Dump skb metadata on
 verification failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-10-f9a58f3eb6d6@cloudflare.com>
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

Add diagnostic output when metadata verification fails to help with
troubleshooting test failures. Introduce a check_metadata() helper that
prints both expected and received metadata to the BPF program's stderr
stream on mismatch. The userspace test reads and dumps this stream on
failure.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 28 +++++++++++++++++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 30 +++++++++++++++++++---
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 93a1fbe6a4fd..a3de37942fa4 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -171,6 +171,25 @@ static int write_test_packet(int tap_fd)
 	return 0;
 }
 
+enum {
+	BPF_STDOUT = 1,
+	BPF_STDERR = 2,
+};
+
+static void dump_err_stream(const struct bpf_program *prog)
+{
+	char buf[512];
+	int ret;
+
+	ret = 0;
+	do {
+		ret = bpf_prog_stream_read(bpf_program__fd(prog), BPF_STDERR,
+					   buf, sizeof(buf), NULL);
+		if (ret > 0)
+			fwrite(buf, sizeof(buf[0]), ret, stderr);
+	} while (ret > 0);
+}
+
 void test_xdp_context_veth(void)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
@@ -249,7 +268,8 @@ void test_xdp_context_veth(void)
 	if (!ASSERT_OK(ret, "send_test_packet"))
 		goto close;
 
-	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+	if (!ASSERT_TRUE(skel->bss->test_pass, "test_pass"))
+		dump_err_stream(tc_prog);
 
 close:
 	close_netns(nstoken);
@@ -314,7 +334,8 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_OK(ret, "write_test_packet"))
 		goto close;
 
-	ASSERT_TRUE(*test_pass, "test_pass");
+	if (!ASSERT_TRUE(*test_pass, "test_pass"))
+		dump_err_stream(tc_prio_2_prog ? : tc_prio_1_prog);
 
 close:
 	if (tap_fd >= 0)
@@ -385,7 +406,8 @@ static void test_tuntap_mirred(struct bpf_program *xdp_prog,
 	if (!ASSERT_OK(ret, "write_test_packet"))
 		goto close;
 
-	ASSERT_TRUE(*test_pass, "test_pass");
+	if (!ASSERT_TRUE(*test_pass, "test_pass"))
+		dump_err_stream(tc_prog);
 
 close:
 	if (tap_fd >= 0)
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 11288b20f56c..33480bcb8ec1 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -18,6 +18,11 @@
  * TC program then verifies if the passed metadata is correct.
  */
 
+enum {
+	BPF_STDOUT = 1,
+	BPF_STDERR = 2,
+};
+
 bool test_pass;
 
 static const __u8 meta_want[META_SIZE] = {
@@ -27,6 +32,23 @@ static const __u8 meta_want[META_SIZE] = {
 	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
 };
 
+static bool check_metadata(const char *file, int line, __u8 *meta_have)
+{
+	if (!__builtin_memcmp(meta_have, meta_want, META_SIZE))
+		return true;
+
+	bpf_stream_printk(BPF_STDERR,
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
@@ -36,7 +58,7 @@ int ing_cls(struct __sk_buff *ctx)
 	if (meta_have + META_SIZE > data)
 		goto out;
 
-	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;
@@ -54,7 +76,7 @@ int ing_cls_dynptr_read(struct __sk_buff *ctx)
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
 	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
 
-	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;
@@ -92,7 +114,7 @@ int ing_cls_dynptr_slice(struct __sk_buff *ctx)
 	if (!meta_have)
 		goto out;
 
-	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;
@@ -153,7 +175,7 @@ int ing_cls_dynptr_offset_rd(struct __sk_buff *ctx)
 		goto out;
 	__builtin_memcpy(dst, src, chunk_len);
 
-	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;

-- 
2.43.0


