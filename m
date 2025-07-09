Return-Path: <netdev+bounces-205581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3EAFF52B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2A054262B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF62517A5;
	Wed,  9 Jul 2025 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="hjJt+I0y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20D2505A9
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102229; cv=none; b=LGLlo16D3EFVIFsxsp1fnYscliPhke7fCwx08oq5Ordj6pTRja5qMmvzBROcYJtjh2eyy0ONpCLfC4GPHUf0mVjtJiCromoPw+wLy18lHoTm66qPHLvUEdRVtYxV8IESy6r/bTg99A3JUfgLQ23IRp1rfAzC+MqTt4jPSAVEkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102229; c=relaxed/simple;
	bh=KpaAZSzE0Xh8q3DSD6/TEtreQDWx77BOjF6mVkC0wDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVbjgQKDy62z5acSOjtiQ3ewofCqeMavrplJdCr+4B76v0m5RyaqgBAkqsFGrssZeN2FFQDuBd5hiWfbd5SLHmZlKc6LXTgWJobqFs9VTvusK5yDKffNa3jsCjyNf7YFtlyFR4i4o+jtJTa8QVhUDHqYhRRZOHZ7LTcgt0I5zVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=hjJt+I0y; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2fcd6fe970so72901a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 16:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102228; x=1752707028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZKdoOQwlfR0KROJ2v6wBzEhaRvcP0creswUNdSHqGE=;
        b=hjJt+I0ybPEJa/kgiADmrZxDxIL3E0OIo2TBbOgs5sOJWS3MB4TmDkVoPcCcigwBdW
         hS4p8djtdb/DyvByXMjHyWfxsaSq3dlYtNLpVdkFne2Djs+3erkllbNb3E1fVVQBLQIU
         JJAcSTk2F7EI74cENkstHLu+3ukufJn9UdzlZ82Cufq9Jiy9Qa4h2zP5uKpyp2+v5pbc
         HWCOPcEi0Ul9FEud3kFV4lCOz6r/JIgsRcQdxVUFhU3+qm3uZ7vuSHhMgVDgbm8fcQ7E
         CluteYpW8kl4v9EvTuEHes9LoLYTPI2HWOTnax3M/CdfTOad7c7UBiSogoMn+9J19gxa
         zv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102228; x=1752707028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZKdoOQwlfR0KROJ2v6wBzEhaRvcP0creswUNdSHqGE=;
        b=SHmYBrrEWo4k36El6dTCgGdEmvAwlRHiFBoK+7zWPV8hafKKaDwvG6qOQ1g+eDyAzi
         LpLzR+nO1mylk9zAjBSaQl+oSYzx8fDf6aZN2tAg0kk3ugjavn462raDj4niyOfjfxd+
         dMLgm+VmVVkXeR92+DmmyF3lJfe1doZhji+yxjUTCK3wXRA0OyDcv0egtVkdKT2onNpl
         Snds9YofIHVC/y2l0h6t++YXoVRQDAe44BwJpev3SBt/3f6HvaENosmwG1DIU+0w3oeF
         DUk4NcWvneEadas3fwT7+snv5efBXI+2rFfILccFgEoDxvE1Snsiv8tRGGGkoDqRlua1
         Me9g==
X-Gm-Message-State: AOJu0Yz8K/DztuA49iEhqT5qAmm/0iyoCHCA7B19f08Nhvz1sIn0LSMD
	V701UZ+7UUjMW0Sl+fMnPa+X2XUzzd5gxKoFz7QMhy3qs+9RQuTrIeZFP1Ytc2MXQSqRQnH5tG3
	1aCIi
X-Gm-Gg: ASbGnct97y10MSLUHsOJ2QY9QCZZi4CciMtzUak53V8Tph/SV1sxzpeR87ra6s1nGko
	Ue7s7NdhyDvXttBoNV45j6+AKPT9wcdtczwhCvfRIrytXS5eY+l8MfM5bknypUQdBXyG+LfeMaQ
	TT3h8Q9XFIaEtzndcRaXeeQWdIgBaZao1yd07eOkAqEWLqEtk+I1ACXJZXkmaLBi2Ab9qUzAB4o
	FEARs7TLf6cozRR7xOh/9VkuMUr15UiX/exuMvcbb7FkZqtq6HF0ipYcM7KgAQadsTj8OKd1/eB
	/QFCqn/AaOO818LrRNACosxaL0mw38lEVF00rnQRR0n1k28KRks=
X-Google-Smtp-Source: AGHT+IHtqY5Sc7QYF0PNTsEWIECXhJMXkkdmc+TUJd8fvVjWmuClEdO8eXgRZB79scXJhjEs4GsyCw==
X-Received: by 2002:a17:903:120c:b0:236:71f1:d345 with SMTP id d9443c01a7336-23ddb19c6b4mr23718765ad.1.1752102227503;
        Wed, 09 Jul 2025 16:03:47 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:47 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 08/12] selftests/bpf: Allow for iteration over multiple states
Date: Wed,  9 Jul 2025 16:03:28 -0700
Message-ID: <20250709230333.926222-9-jordan@jrife.io>
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

Add parentheses around loopback address check to fix up logic and make
the socket state filter configurable for the TCP socket iterators.
Iterators can skip the socket state check by setting ss to 0.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/prog_tests/sock_iter_batch.c        |  3 +++
 tools/testing/selftests/bpf/progs/sock_iter_batch.c   | 11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 0d0f1b4debff..4e15a0c2f237 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -433,6 +433,7 @@ static void do_resume_test(struct test_case *tc)
 	skel->rodata->ports[0] = 0;
 	skel->rodata->ports[1] = 0;
 	skel->rodata->sf = tc->family;
+	skel->rodata->ss = 0;
 
 	err = sock_iter_batch__load(skel);
 	if (!ASSERT_OK(err, "sock_iter_batch__load"))
@@ -498,6 +499,8 @@ static void do_test(int sock_type, bool onebyone)
 		skel->rodata->ports[i] = ntohs(local_port);
 	}
 	skel->rodata->sf = AF_INET6;
+	if (sock_type == SOCK_STREAM)
+		skel->rodata->ss = TCP_LISTEN;
 
 	err = sock_iter_batch__load(skel);
 	if (!ASSERT_OK(err, "sock_iter_batch__load"))
diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index 40dce6a38c30..a36361e4a5de 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -23,6 +23,7 @@ static bool ipv4_addr_loopback(__be32 a)
 }
 
 volatile const unsigned int sf;
+volatile const unsigned int ss;
 volatile const __u16 ports[2];
 unsigned int bucket[2];
 
@@ -42,10 +43,10 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 	sock_cookie = bpf_get_socket_cookie(sk);
 	sk = bpf_core_cast(sk, struct sock);
 	if (sk->sk_family != sf ||
-	    sk->sk_state != TCP_LISTEN ||
-	    sk->sk_family == AF_INET6 ?
+	    (ss && sk->sk_state != ss) ||
+	    (sk->sk_family == AF_INET6 ?
 	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr) :
-	    !ipv4_addr_loopback(sk->sk_rcv_saddr))
+	    !ipv4_addr_loopback(sk->sk_rcv_saddr)))
 		return 0;
 
 	if (sk->sk_num == ports[0])
@@ -85,9 +86,9 @@ int iter_udp_soreuse(struct bpf_iter__udp *ctx)
 	sock_cookie = bpf_get_socket_cookie(sk);
 	sk = bpf_core_cast(sk, struct sock);
 	if (sk->sk_family != sf ||
-	    sk->sk_family == AF_INET6 ?
+	    (sk->sk_family == AF_INET6 ?
 	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr) :
-	    !ipv4_addr_loopback(sk->sk_rcv_saddr))
+	    !ipv4_addr_loopback(sk->sk_rcv_saddr)))
 		return 0;
 
 	if (sk->sk_num == ports[0])
-- 
2.43.0


