Return-Path: <netdev+bounces-194438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7172AC971C
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8751C20F6A
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA00283154;
	Fri, 30 May 2025 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="mm0Kul7O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC127C17F
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640708; cv=none; b=HBGzbFANkVlrZyvHgSyhQIbURI6eSeTAu5sKfGPZE6l3bmhR2k61d9nFyCBmo2lI+2m6X24ik/46n+BbU+zlNRoMRLD6OiWsOJJZl5d/Z7LnFAt09Ko4TNDk4BpfUXcPnTMyHAfvyw0PKtTjYuosNpvQYm3kBAr76Zhx/a8Olas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640708; c=relaxed/simple;
	bh=ii0lhnsuHEZZ21rnkBA0wx5pkbY0pk/4pyArG18nLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHIdmoGMHExCKo2qONo+fLZiAb9rQcvfasFSAHVLzuqAjwVpcLkTCnJGZV0gfMupdBTNGkJ7kwZCl+1fzr+X9lC7bR3cERH96rn4OrlOn1Ghi7Owlwtwvg4NLXKNNgiB5N/pNawkck8O479DqeHPPbWw7GEhoLcbPUdU0xlFo7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=mm0Kul7O; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3108652400cso324570a91.1
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640706; x=1749245506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=mm0Kul7OCqF7teCecv9itxh6q7U3yCiAmZ86L7b5YPIA4p7DpyeVCEDmHreIflNaFn
         tXFTDhc58c7AtBpLkjFjTy90SFivoyXqJKeY84LDXodZdPq+FmpNMb2fR+Z+C2ootKC2
         BleRQ4EAmZsaB/B+MtbQFGcqRH9Ag2d78OK8luZit1OezZKtInN6qrnElYlxKWfAA9VV
         skdxWth6Tdb6o2STa5o9WLHew+7tIU8EqU3VSP0wplr908QElu4KgWOmZK4vOlwu/lGA
         +tr5ynybO4qdfWxYBvfBsLU2zBsb6jy1kQGjQ3Jb6zCW1ACvteSMKxbAlOyCA88INxBO
         IR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640706; x=1749245506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZZ0jvcYwhY5yt1MXnZuSSYPelQKSbT2EiEftdDOFWk=;
        b=slt27oTeKu2CNJytCjQqaBf/Ovw7pSVYrvxIVW7RM3B3Gdhql077oJsNvrR1GAvHxd
         0bhi6OaX8BnALJWhgoK1RF1ddHp//WRi7HGVZ18jEhESGkE77fkRuWhRMbEfXpjwymAY
         NvGtabDS6xq/fYHTBIbYYY5Y8qRwTTS/cbKYpeBPjaI/SskJFoB4WB72YcK9s6fwKxe4
         SNoTR9VRe1oq/RNEMlGTFPtZp2Ntc6Mo4rscD2is0IwfhWBB77FhlMCFBwIqonJGMoFE
         W03tIKsZKnDGBqtpUyEXkjOqKPO0JvQDfeB/ra/IrEVuNmHx/7Z6haGmMsj7/G7Iyw0r
         atag==
X-Gm-Message-State: AOJu0Yzmt0TScWpFXOFzW0ciT5b+YpFPhrM13zvKqXijXA5WgXmyIPep
	mi4Zjc5JLBGEUhsTjX8ZV+FE7PVAu1TUFunlS/C+vsbFNvyKAixFA4dNhNUyym5cR/F+EogUjAd
	DORMmPPc=
X-Gm-Gg: ASbGnctAFYta3RAG3hmE5V4VchIk3m6XNunJQ2GWjZb09Eckat1GgT36Ljah7yiWjpq
	jdZ///oSNu6AufOxzOLta3/FhUkFaHOf6NXCWC/rSZHpRpAey/VXOQ/QvVshlhGVLERCb6dBMXH
	v4RdZCxG/Ab41PAWZhRKqjjZGBix9jFHx8MjaN1arqrHEaY5Y2UOq280qrU7n9wbAR+NdofShnM
	u5idWSqsAVH/tBYKfBx7fGsPedxjoTRQs5YbUV4dwHFFu5vLk0IvO9nVpBNF3JBsKhp2/bAWnnr
	MnUPYfJGigNOF2EthZgQW7+a9hQqLvJ2h/kq2a3e
X-Google-Smtp-Source: AGHT+IEW6DUT4RwEdjjRvW2pHlWUpu9SvFiYToPKW1jMtx8KToVpsVLkuVXhDPwSOA7MOT0QlZTncA==
X-Received: by 2002:a05:6a00:2e04:b0:725:f1f2:43eb with SMTP id d2e1a72fcca58-747c0ef16e6mr1922553b3a.6.1748640706194;
        Fri, 30 May 2025 14:31:46 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:45 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 07/12] selftests/bpf: Allow for iteration over multiple ports
Date: Fri, 30 May 2025 14:30:49 -0700
Message-ID: <20250530213059.3156216-8-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530213059.3156216-1-jordan@jrife.io>
References: <20250530213059.3156216-1-jordan@jrife.io>
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


