Return-Path: <netdev+bounces-206815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470C3B0473F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064071A6107D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F72701C7;
	Mon, 14 Jul 2025 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="oFdtf7cY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57AF26FA6E
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516580; cv=none; b=QHriFX8Pt3VPRwUCP+QU4zekNY5B2Sm8R8nDlSSSG2U7RAqq++Lkv2KRAeELRfggfBy1tbN9bP5obA53DpwUVHxrl64Mf7f3vbT8jP4TGmfYonzf2mBwm9PaWmAFzzI8k08yap+1H6BHbBrjMQcu9Gd7iLpSkiBKabodg6GpZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516580; c=relaxed/simple;
	bh=fyehYhxa8G/73wUbDFErCIWrrsV+XEDbPV1wHnsjius=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RA4R6x/hyQKYTKJkHE79h5ykOKQqjLjk4gKkkAZE+jRGRer4y+rJ9jd+EnPVXcukGjFvlwEdCgbLGCf7k5O/XspBEIEdJBC3EWPMZVYTkGL+0vA+lQ3xZvqjxEL5L/ZePl9133vUmw0aILt9G7DRy2OG8gTNBYGJrmoVsL+p/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=oFdtf7cY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so908909a91.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516578; x=1753121378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXWCQ6+3YVI5NTJDWePIBPW7AX78zEDasUFUwt2Y1Ps=;
        b=oFdtf7cYOca6OkNCRe8WNDlBF5EeswW0Y3hJIcmUxOJfDQSGM280KMSY9E6HZwCL1w
         DcvbHfyh8DAOemRAPPe4zgCniioXgEg/1RS5XhwradCsatYH2jBK2jK534UIPHDVRile
         vMf3lPO9znizUNht8Rfb+z0BJcljPKnaD2ytbVAfGSCUR69aYNbUqU/Q41zopYr8PhKN
         pR1s4AObGpePaEsbIC8zxMN/vIZ4Qwfzd99st4TEPv5qkXAmQXqjQicDd5qIvIZvQVif
         Q0HXGESFY6riPZn4vTNGpkY35vGZW8Pz5JE0LdxBNSUgESx4O5YpO78TQey7j+lC9ICK
         cz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516578; x=1753121378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXWCQ6+3YVI5NTJDWePIBPW7AX78zEDasUFUwt2Y1Ps=;
        b=o4FYLB413cxl/ZFHPolSeqvAfyZHM6Tz4DpcXKt+B0HjMRRjwD+CEPqx7eypIYFkWp
         553SfDSoOezuOgIAleRburSS2JchEUMlo09e/EasU2TioiiOK3vGL+3mTRoe9ZbUqYuw
         gJ0/O4bduXcxg/NVLrM8yQy5nB0k49I5Q77ncmFb/TEE1CMEfPOe9Bvi45drrslvfVQS
         LFXsTnhNlhy/AhRNJbC7jUunoFI0uuSe6jLXBYcZodYptCVQpA24WG8H41GCv7yfH29m
         rhHdr4or9N21zor80K+oV7bEuWZ74VCImsUVEZCXHpnOy/wAGb2RV67V0uD7U1BrMv/X
         Ojng==
X-Gm-Message-State: AOJu0YzR3hRREZL2a5xGc48td57WX0DAfNBxx2/ou07IQ5zXoqp5tup6
	fc4S44GCd9f+4zPu9h75DpOFAxg7T/jUHgHRKPN5P/v6msVT1QlyIzx8Kh/tUUpoqgDQAO+hxSd
	Nd9rl
X-Gm-Gg: ASbGncs8bcyHxQgRiz8rQ1buvtlQeKgASYkh6rbhLQo5bvUM/DopEUxTe50p9fpAsYH
	+KFsCc8nYBnMFfPKKkylBpjIhdc9VXu3LDmOQ119EW1SohwQXVtJeZChMAgEneQ7+PLudTSd32K
	SlPXMURJo+qafN/Owjlf5fExlIAcnEBMVQRedBXQDp0Pi+M9Jl+xYYoo+G7zHz0AkjJsk8SGygk
	Loz5Q/H9KnMLm3Lykae93kUJ0zk06X87RGUDkaWtmPQD7RB7CkwPlBealYxSa24AJP5xcCnrD8g
	PAoMhIRYWJJI6nCStOtQQsCxu1BRsW1cZDItqE+xCz0OUEO6f94c7kUmMQd61VuWfBW6MFY8jpj
	IrpeL4qsiKA==
X-Google-Smtp-Source: AGHT+IGXnCXY0SJ8XtvGXcBE0dPm7Nnobzqumz9CcM9LYAnWX8nfskuvLXkD6BLfjhB9jzhyBkLPyQ==
X-Received: by 2002:a17:90b:3cc8:b0:30a:80bc:ad4 with SMTP id 98e67ed59e1d1-31c4f37b71cmr8007503a91.0.1752516577797;
        Mon, 14 Jul 2025 11:09:37 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:37 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v6 bpf-next 09/12] selftests/bpf: Make ehash buckets configurable in socket iterator tests
Date: Mon, 14 Jul 2025 11:09:13 -0700
Message-ID: <20250714180919.127192-10-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
References: <20250714180919.127192-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for bucket resume tests for established TCP sockets by making
the number of ehash buckets configurable. Subsequent patches force all
established sockets into the same bucket by setting ehash_buckets to
one.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 4e15a0c2f237..18da2d901af7 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -6,6 +6,7 @@
 #include "sock_iter_batch.skel.h"
 
 #define TEST_NS "sock_iter_batch_netns"
+#define TEST_CHILD_NS "sock_iter_batch_child_netns"
 
 static const int init_batch_size = 16;
 static const int nr_soreuse = 4;
@@ -304,6 +305,7 @@ struct test_case {
 		     int *socks, int socks_len, struct sock_count *counts,
 		     int counts_len, struct bpf_link *link, int iter_fd);
 	const char *description;
+	int ehash_buckets;
 	int init_socks;
 	int max_socks;
 	int sock_type;
@@ -410,13 +412,25 @@ static struct test_case resume_tests[] = {
 static void do_resume_test(struct test_case *tc)
 {
 	struct sock_iter_batch *skel = NULL;
+	struct sock_count *counts = NULL;
 	static const __u16 port = 10001;
+	struct nstoken *nstoken = NULL;
 	struct bpf_link *link = NULL;
-	struct sock_count *counts;
 	int err, iter_fd = -1;
 	const char *addr;
 	int *fds = NULL;
 
+	if (tc->ehash_buckets) {
+		SYS_NOFAIL("ip netns del " TEST_CHILD_NS);
+		SYS(done, "sysctl -w net.ipv4.tcp_child_ehash_entries=%d",
+		    tc->ehash_buckets);
+		SYS(done, "ip netns add %s", TEST_CHILD_NS);
+		SYS(done, "ip -net %s link set dev lo up", TEST_CHILD_NS);
+		nstoken = open_netns(TEST_CHILD_NS);
+		if (!ASSERT_OK_PTR(nstoken, "open_child_netns"))
+			goto done;
+	}
+
 	counts = calloc(tc->max_socks, sizeof(*counts));
 	if (!ASSERT_OK_PTR(counts, "counts"))
 		goto done;
@@ -453,6 +467,9 @@ static void do_resume_test(struct test_case *tc)
 	tc->test(tc->family, tc->sock_type, addr, port, fds, tc->init_socks,
 		 counts, tc->max_socks, link, iter_fd);
 done:
+	close_netns(nstoken);
+	SYS_NOFAIL("ip netns del " TEST_CHILD_NS);
+	SYS_NOFAIL("sysctl -w net.ipv4.tcp_child_ehash_entries=0");
 	free(counts);
 	free_fds(fds, tc->init_socks);
 	if (iter_fd >= 0)
-- 
2.43.0


