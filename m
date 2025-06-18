Return-Path: <netdev+bounces-199140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93320ADF29D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851941BC38F7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB012F237D;
	Wed, 18 Jun 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="h22ycdZ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7D22F0C44
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263959; cv=none; b=p35u1FFCxLT1KfiCjzy6zGqFQtqhu1Qk7o3YHW3l7Uf3XN4FHFMZRjXspFNm1Rzp55deoo97vX7oiyUarLh3ngimnOXdyK27KiScVcCKqSX8s1rFW3jcFwJF+rbXZyJ0yZYShmtStVMbq9XhVrSrT/DbVpuTf1dLGS+Fvb7NIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263959; c=relaxed/simple;
	bh=ii0lhnsuHEZZ21rnkBA0wx5pkbY0pk/4pyArG18nLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPrwjVNa9ob2HA+/H/9l97fiaXKvaRPruZC6oHbuFsGLMiXtEiM3Xf5PzOc5illu1G7LQqh4AmFcbu9HLDxY711zbOUFx7xFPNhkL8+XIWGi30hAoOR9AXE2UNuXz0EsaCLjJs4cEIkCC6cVJ97rZ8A1JxqPGEwbU+54vsZCNR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=h22ycdZ+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313bcf6e565so1200714a91.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263957; x=1750868757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=h22ycdZ+iihHiUpdGOr0Zxl2JpD8YrC3xFpKnaGXx01irAatVW2HSVnbLDw7h6Bsk+
         76SXd7dP1Svt9ui/dDK5pBRkrLbMhQI/IXGlgdMcarHC8fJPPIOeB9qmefsGOjk2riYt
         qTzOdALEUXZq4FSInXWI3KJsthp4IyFwDutd8bbC1kPKDgxO6Rq+gPNNI7+rjyI7AbAT
         nQkxtBJkouInSxoEYPy18vQ9sgffVJARhuM64IObgIRT8JJcaX8UtjBCEal07SHy3HHh
         K5wElAF8SdQRdbM5Z7QwN65StS2YzzxlaNWSyjCrHgrtIhL1sRdtc5OeyQzLkUmXYIys
         QWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263957; x=1750868757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=XFzorykaQyixZo3i/R6NdhlIbIBhNncPLdffClg0IFf/P3EWMvYlWG5cwksOXeghND
         1dkN0sfp+c0l9NAQVBJwYic2zcKJ4OG3zDcGHsftnz3qiKWEgzWXMhmDRIsEis0VPZ7g
         On5g9e8hEYNff5CkEQuucTHSAtIuhQ4Gb6hFN+0Ib+ussLT7lXaS0YUJRIGCIMXI3Qmu
         FaFDQzF+YtnWVVU7erQyu2OON+Ei5Q/jyINFiAysYkdy8QJHatmpeeT6z/+gcEMkTnJb
         lPiLqJpo0rXZZb3lAdc87zH5EQ8K5N6yl4IfUZ58u9DbHgGZcbZcXjFDF8+kOQKLlEmJ
         zmYQ==
X-Gm-Message-State: AOJu0YyAiQ1Ndg1PWc3znhZynZMNwQH9ixy0JmkGBqrN3KDyXEJcrDjU
	ded2+G0oDK6zVJ46JLwEvnNktGmc/DNOHTlYyl/g2v5PwfmoRy7nPMzS8tb6vX/MdA48btKKsfT
	XxbT37IU=
X-Gm-Gg: ASbGncs3ITP8J2MVVjiQGnkxueSG1hdsx33FgIAclblzKhPRX/YJi0RKUsOgvK9EtaS
	Ik+YPiJNjwrLle0EdtXYM0p5DZMre1Bql+s9E055wwukCUWW5UoqC66rQ47z3+chJyEJ+2SROAa
	aDq8Lo9UQEYjz7t9xF09iSg0qY9F3Hre+KZEr9ZvI+0vNKDKBLe/QQDYTFlyr30MJ3M2W+p1LuP
	2lu7kL1lG15RAnv+0i+jN4E8gyA69kfqE5nCiqeYimVLZ8MAaWxISbDF2EkqHCpamTPslaIsIq3
	aE8oaHvaEkwAvTa1ogehX13Xerac4asRIZ7YKC3ttZzIZXjR2DE=
X-Google-Smtp-Source: AGHT+IE5vIUGCLO1k9q+tumxa6ro596rsZLCiLZAxCyKLHEPeGX1LVfWINdX7m0JRqCOQ22id94e5Q==
X-Received: by 2002:a17:90b:2cc5:b0:311:a314:c2c9 with SMTP id 98e67ed59e1d1-3142562c595mr4342996a91.1.1750263956707;
        Wed, 18 Jun 2025 09:25:56 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:56 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 07/12] selftests/bpf: Allow for iteration over multiple ports
Date: Wed, 18 Jun 2025 09:25:38 -0700
Message-ID: <20250618162545.15633-8-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618162545.15633-1-jordan@jrife.io>
References: <20250618162545.15633-1-jordan@jrife.io>
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


