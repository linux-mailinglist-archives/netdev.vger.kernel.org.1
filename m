Return-Path: <netdev+bounces-191918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD21ABDDD1
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2101E3BF991
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE812517B1;
	Tue, 20 May 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="AplVIkNE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319AE2512D9
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752687; cv=none; b=MmJLwbXz93mUylwFXCjDdlP3oZBFPlBKAi/4CA8xvBqb5GqJxpy9w+OTbiFWirGRqVRP4ud+ufGuQg5r2m/6skMtZA+OcWKdzYsR1x8gze+9JA00a+qgV7It8mClj13OiMPHcnr2O5Vahis0hZuFPsA4cFXoFY84th/ue6QKq9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752687; c=relaxed/simple;
	bh=ii0lhnsuHEZZ21rnkBA0wx5pkbY0pk/4pyArG18nLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8XdI7++SOqfuKY2EPci+3nfpPhA4+D6tsYrYHd3Co2eaAZxwCBTTYbSqlZRhUfhYHPe9ZS5+QZyYK9QTxdfQtRcMQWmUZD5fZab4EmijC9aBFb2p3kuHi8pwIs0UEENqDYqV+rZIgB3lV9RFgzLNpYYIIm2t5Q6ZLJ1EpT//4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=AplVIkNE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742cabe1825so136591b3a.2
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752685; x=1748357485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=AplVIkNEtVYVX5zIHS73bZQGykJNtQ7WRUszCgiyfYeyI+q4fst9tNKVLhtrJPkMtT
         lisTrYzEI5b97ef6WYgXO14bp6eaK30g5txc59elxIheMDWlsQ/g5QRMga6Kr+WVl6oG
         vIKNNajP3YjO3vdVk0Xu+6gE9n42ZVPjnbJvfVGSydOuE5x3grWIsrNR//l7SybN0oPu
         0ghhcdmn7bjFrXsYYJpd3m8YQjgcQ+Zef0TQoalOvVbtJtjar0KCYc9zBuk4wMnYA0Ey
         96YWYv9L4uzdO/9tFB0xgsCEbyfbtCDU681FiXyX/54Qxr594sugSdfaSdUlwnu5acfo
         Eq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752685; x=1748357485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=nxq5JAf1UOWtYXwy55tUAAt7419Bh5TZgq65Gu3lrd0rxVdQPCZ+poyCO5OPW4r+g9
         HyZlPalZyrtW9oJ+Ta/es6/rqkgokq5mLk5bMk6C7V7GWnmT4xtaKN3TeIjjuy3H5KXU
         YiDghq83fYHovWiJxvueee1mSRhC+xf+Ydw4yjCcz3Jg7UQRFX0OaRi2W4QQU/Uz98RL
         dF99OGdja17nb5z8oUaoNKklFLMkKD1xaHatGRvmkDfbbQw88QRrN7ZTtUVeSBh3QvSu
         iuylOQBag65jdUSIlRkGtE3uGQnttcmst9HzC3m9v13ZpZLbYj1ttClVgmDWjiVxKG1n
         l+QA==
X-Gm-Message-State: AOJu0Yy7uedIIYgQ4SzRv8AeUFXtFTDwRdM58AzWg9lKiX4PEU8swzmA
	UkeI4ecjD7urMlLk17hFVu2qR5R+mWBtplaVK3boXRs81qJj0nkzWvubfiV6arQRBV4iThrxaiN
	6qgpg0ww=
X-Gm-Gg: ASbGnct8PBD4Ikd1sap+pdr7EK7f52QrBFvn7E1B2ZxFEIJQGlhA9vejIEk0XNEd0qZ
	18UjwGyhNbs6q429nk2edH4Cj3Ux5ilUcK3Zuuf/fXTcursMshNt0mSGtVpFECu2geruVKUTwJc
	e0brqhKYWXNOZDNffY9OgKEYWw9Ytur5MGWRkMzTlRHB+VpsPe10cT24qGZsM7OfIA9HKarYTJr
	zTWHitTwvdI8Ccfm9lqMxC8wHTlvWTLl8sGu4+cQZYCtgGUb5UrJyVSTWyMg5NYpZqHowJDYHvx
	gXz87Q+k8LhGJArPVzoXzBkEJ8lbMzeLl2OD4R/Z
X-Google-Smtp-Source: AGHT+IHjyDiMGErPzOQChwShFJ310J043Ga2vrq37hb9MJB0RLO6I0HeKyUXsiTC1AFSxPfjAHb3pA==
X-Received: by 2002:a05:6a00:4614:b0:742:a02f:ad92 with SMTP id d2e1a72fcca58-742a9914f79mr8414519b3a.5.1747752685361;
        Tue, 20 May 2025 07:51:25 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:25 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 07/10] selftests/bpf: Allow for iteration over multiple ports
Date: Tue, 20 May 2025 07:50:54 -0700
Message-ID: <20250520145059.1773738-8-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520145059.1773738-1-jordan@jrife.io>
References: <20250520145059.1773738-1-jordan@jrife.io>
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


