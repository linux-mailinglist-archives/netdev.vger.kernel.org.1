Return-Path: <netdev+bounces-205580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5187AFF529
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B1A541DD0
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1ED250C18;
	Wed,  9 Jul 2025 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="K1Hj3jQE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D92472BC
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102228; cv=none; b=S+WIoXHDX9Cu2Nr5zslS5usb0/4F0uHZ0LqP+Nc0bZNVLyOFdU/5eRNCJAhuCFzNE+LotW+fqpRhkffyTDOvGbS27rvnHDaN0dkv9J0lAEcsXPPpvXoviY1c4H6Z2Ait6oyLkC1sR1WVIEmdNHRaVZfRy0VjW1bMImjt3qnv7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102228; c=relaxed/simple;
	bh=ii0lhnsuHEZZ21rnkBA0wx5pkbY0pk/4pyArG18nLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDTkYQ25LwSVgGbW8qqpbdl+a0Z/dytjlkmr+m60Alp9rBYHaqRP3Yjbwh1ywKFcs9JZy8MABx/OSa39qZlYippVILcv69EeNwlC1xV5yaKIGN6PITKYIqbvZp5dd1FopuK3OZ/uZfxMlxAs/dvpNuBqLMr1q7TG0i0CMQmhpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=K1Hj3jQE; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b350c85cf4eso76069a12.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 16:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102226; x=1752707026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=K1Hj3jQEXQDFp9wWkaaog5e9TXsBSJtpOzyvgHGjRhZnYCCCUje41jXf/jEbWvUwUD
         Dft+zebpCvTxKgT65DNAL/MnAH7VFjxD60lmxsMvUFFU52ZJqpbmzJOm87QvuesgEu3o
         wvXgZHLsX2Jxq4cAakqGBom0ZXuaZAKCpFvsemvdh20/Z8b5hUGdOgIo5nyyROi3RRZF
         DR7kVR0GxmAYzsErexRQuIaQuIQfbGTCdAwjjwfCfgKkVudXafgF7qstGozZM1mW9N4D
         p0CAhHvA9hrm8oNNyPapeqzYDKL3PdUmz91g6pgVjpdBoFG8CGmo7knsuqkSgF1CYnXz
         TQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102226; x=1752707026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=B1Pri9tuKmhBkprvhzg4Hg1dQ0tG9Y5LzQ8BDhC1b3IqEjS6NcjVQfPRikFcGOcAN7
         vhdVFXJyiqMfgSApVTOVKzrOb5Bn6X6tcdvTRemqntTggzoPCav8Xmz+FM3BXn6hNSxy
         kp4xX/hsfqT7F6jE8w4hPFCUavlKMMCgxvcelMNxp0tPckiQ4t/BhPkEi56WmTc8QeDV
         Dqwf+aq9JGu1QZjHv3FWF1fZ5G3QjFlVtMpkz2Zning8J7P0GYRehpL5OBYGND36asBQ
         iSsQWQ1Ql/c4P5R/B0r1Ba73xN03NqpKKIet0c6A0WH8BEv1BK+LwbRGDLEYChH9KdjI
         i80Q==
X-Gm-Message-State: AOJu0YxHw6f8FaACqqBfC+MXvdK4x5iqzVJd7oq2OoWRaOuGe/aqR6jl
	UHbwTRa58OYq7vWH/otYtUgZNoe2wk4aRjQaanEz1DVDhN5INpwMYJo//fFGmSa5nTYFFwmm/gw
	b3vAF
X-Gm-Gg: ASbGncu+fVQI0A2iPzEievXXdnsvIDhrmRmvccmEzNmXb51w7S34KFWbMfbHT1Yg3oa
	0BsCOG9+LVPIdppsCFToOP+4WdQcp+Gjbl2npmAHsY0qVxzo2n+3J0F1z+NAaLi0t8Fx1LhK7hN
	g/y5BrNruLLAGfyvD/whLVS+YhxB73207mpLAxtO9VYNC+FHpPUeiFaWuEmiDPSC4B3KygCGk3V
	JHbmcBjmahWvsG0PmWNDcbHnslo0PZqRPTVpqzo7/yMr0xzjYhYNlcddmjJM18pidS8ppd9pmM3
	zaRqCtHmGpNBT2m6tL/66SxrfOBx6JHCSHF7sbIAlBSSo8fgP4o=
X-Google-Smtp-Source: AGHT+IEu/Q4/OW8Mzuy9tKF8hJDhRJ6nz2z6SlpNs/fnrXJli0oI7FyMkFEYdOujnXxhPFAhJ6SfKw==
X-Received: by 2002:a17:902:e747:b0:234:ed31:fc9f with SMTP id d9443c01a7336-23ddb2f2255mr26063645ad.11.1752102226286;
        Wed, 09 Jul 2025 16:03:46 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:46 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 07/12] selftests/bpf: Allow for iteration over multiple ports
Date: Wed,  9 Jul 2025 16:03:27 -0700
Message-ID: <20250709230333.926222-8-jordan@jrife.io>
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


