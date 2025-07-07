Return-Path: <netdev+bounces-204630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446C5AFB801
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87E33B581F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25C7218ABD;
	Mon,  7 Jul 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="giUqaJDt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E02116E9
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903478; cv=none; b=BXYY+DfkSSqnpf/lCxwnuMhB/RtaVZ9aC6cmMF+pnnXcwgFkQz5/61dRA3AlAhVVgcSfn6DGX1lniP8bkCGVpzgccbtkdlsBvM4hZNF4+BkiAlgPDaH5C00Chqqq7q/lGrCfNky9gSphzg0RfsPpxH6+ZinGiyIhxVc2wJGNAZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903478; c=relaxed/simple;
	bh=ii0lhnsuHEZZ21rnkBA0wx5pkbY0pk/4pyArG18nLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnG8iRA3wA/a+xp8lBqWY8NnFT3ThNsQwKm7I3RvLiTMN+mANALNT3xJNiYFWsY5utC9pYuHGfZ8HnF+OSLP62qCofPGZQ7YrZOVhmCtnPUjtPUlNCLNM4TtWdZlUIUZvhtucBsRju0cuCAg98RnKdoulLUNRR+w4ZbM9DseXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=giUqaJDt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235248ba788so2453935ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903476; x=1752508276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=giUqaJDt+D6558aGL2nRTNr4tS3EKEcvnjMhWua3Erm24TAYAA/OBI/HEtsHD+E3No
         ClvegUGyB7rCeydyPXopSME6Q1NCZH4oj+S9J09kGOJXuvyqPBEbvxHBE34Yc362zQl0
         2X2EtiZtXVczSgFobwklq6RQg6S79NAgdYSqkQiT0KR6N0OKV6FY/MJcHax6DspPPu+P
         liOtVDs3ajry1/mgTCf3qa5pARUH3LlkioCaKcChcKk7UdAq1Kc9c+h/r0cZyuG0cj/3
         UJtsLqb6hgBi4GSejPjc9QtQzOVRXgocXH8I5DqRqVvPL+Y8n7zT2tE+Rizay5TIcLfb
         a8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903476; x=1752508276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=KSfB8NnnPB7z1EX4NfJlAijdBlaiOcdg3SnYr1ruF+uFfygCvtZAYjK+Gt0yBZ9GNQ
         zoW/dgTBrbZ+Jw1EbasSsxgJpBCk+Z8liPgqfOcPDdSJQRXi4FyVH2yRQbsvSZ79cVIn
         QgUVsi/1/DbqV2NVkQ0dAMMK6bO66vYk/VALTecEcONhpI9F1q54FLBMoDSGsJbrYTax
         sZluHDEyEIeFJ/8RTgFxhfYLhKKPUsFvZPRZR/zvVIyV8W/3imWijb0IYxdphbfrDFUD
         /hDHwkP/fcAqucbqfOeZW5It7uVIWXGqccger9sfJ85amx55QRuh9DY0kq+CbeXOSWIR
         9y4A==
X-Gm-Message-State: AOJu0Ywm41MwzP3MWGkl/ueCl+1rxyR4uJhbFtE/te07U6ahXFq8Icl+
	t/p7mYwDLQI9k+tczZ/Pe90HVrP1z9Jm7fm/+NmbJDJO++iNGzQqKJPgiabwSGUD3xeq0BlpPtV
	oScY8
X-Gm-Gg: ASbGnctHgKsiLFFJWHyx3zBNTOjKbx8ls+rr3G7C9jUySYn9l945bkR8FLyMBFsJmXw
	ddI6V4w0i2L6nBT20i9fvnlqWQr2rKafoc7vDmjIZ7k5ipMrG186bAFHW5icuMHoexTdakqIZ/Z
	6Az3gYTKChYEUIFp4Q/EX+DK0v9cl2xdUeRUsSw0LAvLs2oGu2GgGQsOuPyW/bcKVzXWBZEmsWH
	3AWRAh/MLq6JgvMQDhB3NYxCDCCNAYT3B3YpPM1aW0MbNMv0q+BGv5MoQPnBBikqEnF+K1/DgKU
	tVI31QDIdQma4nKm32Ev8HwM6lYJ2wTyIyUTmHNjNzl/jt5W78M=
X-Google-Smtp-Source: AGHT+IHw6vqyjMErnWgTqW8VuB0mANsxbhhqZLqj4ip88jNAthOzZgeqLmVWUDX6ixTcy4HMwZvDoA==
X-Received: by 2002:a17:903:2f8a:b0:236:71f1:d345 with SMTP id d9443c01a7336-23c85eb06femr73942495ad.1.1751903476665;
        Mon, 07 Jul 2025 08:51:16 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:16 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 07/12] selftests/bpf: Allow for iteration over multiple ports
Date: Mon,  7 Jul 2025 08:50:55 -0700
Message-ID: <20250707155102.672692-8-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>
References: <20250707155102.672692-1-jordan@jrife.io>
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


