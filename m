Return-Path: <netdev+bounces-205582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B2EAFF52D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0DA7A7133
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB61B25393C;
	Wed,  9 Jul 2025 23:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="jjO061Q+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA325178C
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102230; cv=none; b=KAIcNEVdSlXkZVjmHJsSmTOVV3EvdPOcGTWgA17vh9aoeu+UNAAZDYbE48R9WqJGgyrqy8u01+0Qi+MNV0VYmCqgVlpPZhpts4ftxm2S/a+FQ+IuGFu5l/pqrSVyUUbACmaZPAHjT1RE5Z+Iuq8KPnkFLvmgkwRpRPTaAEbrTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102230; c=relaxed/simple;
	bh=fyehYhxa8G/73wUbDFErCIWrrsV+XEDbPV1wHnsjius=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDWcdTmXc3CcWZUu4pedPix01HTeUlrwCX2vumRJhOSS//liW+VaZWlSRy4YKfv/3ayrhH8gHYgtKqtl9xbZmom6pUyZli/VG48f8ICmoIldwrvY2E537gokuvjYxO7UsFJmur5mKTwaBUkylSkDw+VlUwEXaD29y2d940owpSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=jjO061Q+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313dc7be67aso69470a91.0
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102229; x=1752707029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXWCQ6+3YVI5NTJDWePIBPW7AX78zEDasUFUwt2Y1Ps=;
        b=jjO061Q+tf6Xc9xGhb/+2e9TTa2MsWoJs8jbjpcfEGn6Hi4DtdQMjRRiFiRnjNPXJa
         PX3JdMtONGQJ4tSq89JMrng+iLLToMKUtQpoDY055r/HL6zlV5YTulUOMCwz2iZZesA6
         WbMQqtH1HzbxvXZZiy5aQERnEojHPSBZcn8cKyRO4JXeiJuRZqj+JvT0/ddo2Dm0/kkB
         NAED8wgJR2TjKgQLHr74ULUJsKvz7yrrhm0YQ2UVFhaXGGdGnJ/W0HLqu8Y5g1YRiZu1
         /dgQdpDM4lqfOYfwXiZ6b7eS71KuS1j8qfz+t7z+AqajqGSsl7xw+/bfarSOirUWGPLh
         4XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102229; x=1752707029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXWCQ6+3YVI5NTJDWePIBPW7AX78zEDasUFUwt2Y1Ps=;
        b=aQ6w5oYEYoSAR62Z9I9xhnqrYQwCbqY2SVZzn6WCosBaQrGJXiU1BPWLIOIyrC6Wb3
         lH5kZOhd7VtPu0MRCwOXV4rKn2f24cEJFONs82CxLkRfR0z2qOassB2VrHf6CFvCY9Vs
         SidfcpTwp5fsCpVaQ1HxalnvFhjgP/X4qD85WZbRQlC5hz+idGIbsS/1PKXVOeAm4Qdd
         tNfUd9ZLchces2R+IRHu+Ct1y30wCaktdsDOjDg5SavNsZ4xBe3+AJvckd/8fbsg4is+
         qKAqVT6Kvv3/MflN/g8LKQAdVh2M+b/Elzgu5sYQzq8CMyhYotYzBAm1tfC12er3SEVV
         wPUA==
X-Gm-Message-State: AOJu0YxYyBZEVSdI1TWrYvI0pFYhFgl0WTfuEK40mvpvamLjaxaVf4r4
	wWgNV4ydsZZIyvIQpcKzRDdR1/uABY+Z9GxaPsWRJ9VOiPPyFRmbAcLOmGUZOdraayVlFRMXSF4
	4z8BG
X-Gm-Gg: ASbGnctFgqdTFlGURbt7+8YmaM7VkBriQzmFBl8b9BgSkC0HnS7HxbR8eLZjWgOR/7S
	uqEcooJr1IL3LcqoBTM3nqOdMo9+nKSZeaa1sSPQFKsXUZUTSSjBCaU61007rVtMOLyVUhutvvU
	3h6zjlx7Ctol0OkXq+/PNGmGlsjNY52TxBs6V43MjMgPm+nP41jxGrposguPQeCoEv0MIQDRF9z
	y/JH3WsHQiyk8l4J/t5Z6PpTf0+/fWqb1NW0spmcVNBVTjXf/9tzTXSiY7mxcAr6hPKqV+icqfL
	Gled8hFBJG/ZVfluNhU4ZXVwizWMKjYDrAOXg6v1KTbyPJQffojBlhi6c1rYVQ==
X-Google-Smtp-Source: AGHT+IEWAdiUDs5g926cP8tWYJdNVbl5nnvra6DFvJDYdEf6w3yE+A/qoGBF4Y/4gU/LcnR2+MA05A==
X-Received: by 2002:a17:902:d2c2:b0:235:f1e4:3381 with SMTP id d9443c01a7336-23ddb1bafefmr25687215ad.8.1752102228737;
        Wed, 09 Jul 2025 16:03:48 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:48 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 09/12] selftests/bpf: Make ehash buckets configurable in socket iterator tests
Date: Wed,  9 Jul 2025 16:03:29 -0700
Message-ID: <20250709230333.926222-10-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709230333.926222-1-jordan@jrife.io>
References: <20250709230333.926222-1-jordan@jrife.io>
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


