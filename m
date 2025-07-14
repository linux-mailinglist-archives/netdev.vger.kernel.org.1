Return-Path: <netdev+bounces-206813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BC4B0472F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921864E044B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A8026FA52;
	Mon, 14 Jul 2025 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ZLJmmNw4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055526E710
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516577; cv=none; b=I8nUTU0cSOrdXpMgWPq8zWOLMEjEH1QMXQ6HDj1FMQIATIkoPvC0JZHjcssGWg778Px+8DuwuATvBHdQ9mOAr3gBJrs3ZDRMACzD5pVXeQlYrrrlQvRiXxAUkPqPNaG49HPtUuyfQHtOzzm/Mulpo7X+zo64YxXQKTbv7acTYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516577; c=relaxed/simple;
	bh=ii0lhnsuHEZZ21rnkBA0wx5pkbY0pk/4pyArG18nLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBT+MdweZlizRhckfPnC7FsHBmE9AzYD20N3fBowahe/bYGNPEn1z+zpLoMp89S3wqa3EzZKxTjorm8BuU/gEuybIL55PceqN/+/PBWJCcviSZBYNjK+0O62/i/77HUtOvW6oM6zdmIGkbM43u8l5UG9rNuMBtHQMDM0XY+3Dsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ZLJmmNw4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23e0de905a7so1177455ad.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516575; x=1753121375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=ZLJmmNw4uTysyO/IqOHh2nXk3Ggo4uZPSU8unwZir22mXEX8zXcK+lY8Ic2f1ZGjew
         Jj9wUZW3Gr9R2MOGyLuuctd2RaFYoSRwxpPHwLnO6TXplQFbNtdi9n4GQUhu1ZvJMWTv
         sXNvKVYSlWWbyH8yJUgN1on2/zBpHfd6V8xW3l7hXLmfZhVYL5u7GakIoBAHM8i18DOw
         Gmu3PZ6456Ul101yWUu1lmPMzRcDdcWpTQXOnHmY3wvyaqGR4AFMpKfWsyePzb2x7iYT
         YT/gZEOq0fdjhq+mAlQnOyN4TGT//93kN2ut/7/h531cb5IONm4cDs4/KgvrgCfNwLsV
         k9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516575; x=1753121375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=PC4QVSz/lnhhNwtW0R8P8EIrGSISqW86Ys6Ocp95NfZhOX9pK/Uz04w1eMbUyCdZCV
         HPfrZzPSNM2jSEnfmS8torFAn1Q11Rr8r7Tp9MWJvRBdW6wLtGZSHq7uciszKYW8XhlS
         zgc4Rje7xX7b2clchLP8LlDvdg1Ig5rAyQhYuGXjd/cmtMbsTM4QM0l1ZOIv2E2EbDCv
         JsZAecLYLRAfIqDu5LLFlmgWLaA49ie33GSg4Q0fkuOXCxCY9jl/aMZph5fMqfzNxHsv
         sheQ9GGFJ0OnFBmTL4Y8leZY1C9rMXwWE8u3h5aHVJ9sDxIWGf9S0wF6IXyDcAzVu/E5
         8+Cw==
X-Gm-Message-State: AOJu0YxW/4hNAOKyp83Lb0ZstjP/UHnRY5G8YUdvGH1Y9jSs452mHTfe
	y1g0KuMo9VEErE/BQDTTHsSTWAOhSNMDOe191djQb4NQWbyR4Ny2Ta676Txqa3vRx76I9cTIR/Z
	QUqkN
X-Gm-Gg: ASbGncvhfCxrvGLYFYgdjckCYB+tFiUCLnSbPykeHbJScDVwn57lUrarQdocli7fOCI
	NraGtE6XZ7sR61R/h8wZlLg7j1LJjgXISez8PYYfBwZH9u7UzuVnWMsvkxi0rvLR9p3NQM6oJJc
	NskMJEmRCXqRWEODr/L0iA6mP9G3tc9aSUMEptVHTInlyk36YnjKC6V7sZKCRge+VQHzF0Z4QNo
	NhnGbfFV9UydYYBMO85efTUZ6SxL4c3IfsDfG5DRIybb7DHaH6ZH7TiKRHZnJ4rcXTfk8+NbFX2
	d5dux0ygLyMU+KhKijGcoPs6wDznThVPHcX3oKdWtMbgcSHLXLUhRj7NKWYua2FoJ4bhYWoXQA1
	J8QLOvsoJLg==
X-Google-Smtp-Source: AGHT+IFRgPEBKtLFqi8gJY7v6LZDuBlDdcbexXuyXOCGknr1Nn/FZbdJvZd8m/zZAwZs+ogzNn3Cyg==
X-Received: by 2002:a17:903:2343:b0:234:bfd3:50df with SMTP id d9443c01a7336-23def8e829dmr74961585ad.5.1752516575535;
        Mon, 14 Jul 2025 11:09:35 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:35 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 07/12] selftests/bpf: Allow for iteration over multiple ports
Date: Mon, 14 Jul 2025 11:09:11 -0700
Message-ID: <20250714180919.127192-8-jordan@jrife.io>
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

Prepare to test TCP socket iteration over both listening and established
sockets by allowing the BPF iterator programs to skip the port check.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c | 7 ++-----
 tools/testing/selftests/bpf/progs/sock_iter_batch.c      | 4 ++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 2adacd91fdf8..0d0f1b4debff 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -416,7 +416,6 @@ static void do_resume_test(struct test_case *tc)
 	int err, iter_fd = -1;
 	const char *addr;
 	int *fds = NULL;
-	int local_port;
 
 	counts = calloc(tc->max_socks, sizeof(*counts));
 	if (!ASSERT_OK_PTR(counts, "counts"))
@@ -431,10 +430,8 @@ static void do_resume_test(struct test_case *tc)
 				     tc->init_socks);
 	if (!ASSERT_OK_PTR(fds, "start_reuseport_server"))
 		goto done;
-	local_port = get_socket_local_port(*fds);
-	if (!ASSERT_GE(local_port, 0, "get_socket_local_port"))
-		goto done;
-	skel->rodata->ports[0] = ntohs(local_port);
+	skel->rodata->ports[0] = 0;
+	skel->rodata->ports[1] = 0;
 	skel->rodata->sf = tc->family;
 
 	err = sock_iter_batch__load(skel);
diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index 8f483337e103..40dce6a38c30 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -52,6 +52,8 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 		idx = 0;
 	else if (sk->sk_num == ports[1])
 		idx = 1;
+	else if (!ports[0] && !ports[1])
+		idx = 0;
 	else
 		return 0;
 
@@ -92,6 +94,8 @@ int iter_udp_soreuse(struct bpf_iter__udp *ctx)
 		idx = 0;
 	else if (sk->sk_num == ports[1])
 		idx = 1;
+	else if (!ports[0] && !ports[1])
+		idx = 0;
 	else
 		return 0;
 
-- 
2.43.0


