Return-Path: <netdev+bounces-191919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DF7ABDDD4
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1700A1BA2BBA
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F701252297;
	Tue, 20 May 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="scn4PKKr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858DF2517A7
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752689; cv=none; b=R/+ALdHJxKawhMlh4WBZdnZVJObEhLCbv4uo9vrBYWFMjfpW+17frSqqnMFg640VsF3gSFnbmu9PNQxP0MNULuyCQbJ1g0G/3cG240bqvAeD6DDzgh0kvyeBpJ0KMfCH9wDbBGOU6GxFDxFk11tKzJnSQOPkwaW+YgxL2pbyu1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752689; c=relaxed/simple;
	bh=rP1K+5z0WkyIl9Ea+9Y4nW7xP4x7P5Cd18KG21Jb6hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX69QlODwK61Y+fwRM2VGV1bZw2Yu3vthOFIjmwgb68W+883cAweaHgAUqmf7poTR5kCIYBnE24QXenxzH6h/H4OMpz+kjelvN+y1O5ILZHgny/EIGbOKzcmog2Rlha8RBY3klyHCWdnUhmJv8KoeRo0tc61pj2wXao6mgjSDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=scn4PKKr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c1145a38so494539b3a.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752686; x=1748357486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRf1+zTuaTm7zQYa3U31C9Gp9YgahFqNmFp7ck+nv4A=;
        b=scn4PKKrFCk0SZskLp7K3ifi7Trn+9TOw/t8lMTh1e3W1GO4SN3tImiouGQvrdURXM
         gkcmh5dW6fsRnE3LmRS9rZlQCH89hspWnlEQKlxCdJd7uaSvDNi0GT3Yx3xeEQkKjvTD
         FXqIsDuGhZtrVs78zIaF8l0ZP4+ij4a/ev5IIUUDXyr6aMPbGkLUaQQs0hscmSl8rrbt
         NvgO42W4ShjBRqJtFUWf4OKEdVo92cLrXFk2yJYxk7yWIB+u7LvxlA9+/BgUAeeg5FXh
         DtXamuk7utvFVQLfJd2RaffYXyJGQNhzOh191eeivFNnQ209wBnYBDsj12+OJ0vZQxAQ
         cNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752686; x=1748357486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRf1+zTuaTm7zQYa3U31C9Gp9YgahFqNmFp7ck+nv4A=;
        b=nlSo64oGE4rWHeHwy6Q90IdOScmAUwokbTQBzUtVWWcgD2K7ZkzZRkzuVur2ZjczIy
         3v/RT1FquAPL1ZMH3M/Xuqj8kD8VIfnvQ7ajk6SP8rtgY28zJvhTbpviL25xF/dUMusA
         84Mbu50m/8qhpA6Xm9hZ7JuwXJVlKrQZzUrQThIXKLXibjoN4A8bUSZF7g3Yw7q+W76x
         6eavdne6cg3zUFz2nKNMz5a7TlEHU0GrQq5AYVN/hU3Ucw08dm7kMueUZFxGQkEcZIMd
         BE6rBFKgOtkF6JxfYgFZCTXK2Sg8C2sqbAibbJBKTIV3PbLPMmHyHDlrUPr59/lKCb6w
         3/kA==
X-Gm-Message-State: AOJu0Yy8L/j1O1Yp2fV21GEafvshIqwm1J7qi3LQqz/Ah8B9eHziEsKc
	c8dtQYPxyBZZIxL0cTkYmElmPlDjISrsxN+WLbFodaJCBJMvhdcxpjoy5JZzVlEVTWPVON8Qj+K
	eCsQzvZ4=
X-Gm-Gg: ASbGncuXkujCwBlyHdMcAmeOBcE9a2/DsBPphy/g+bDd7EX1RcsNY5ZTpw4e3jSNvAD
	dHtdiAom3jVVoI0lsyEqNvbBdoCglf16hV+gSZqq/XGQ5A6YIjIoKEoUE9gaGU5uiGrRq+YifMS
	KarXG3oU57gF4IhcXXAZdkpGVyq6PMfbiWDUoDkvpqLOvJ4zVARLtjBbKrKT2ht+UIDZjV02UVF
	bOtAFWWE+DnNc5SooLHv41kaG88D/OQWbb3HFVeShafTVOoiQdPnk8sSHw9ejHeQsjdzNYoQM42
	3FDA724iti+nFy5WYOuGzBU+Z5NkZOBFnWgM8oFQ
X-Google-Smtp-Source: AGHT+IFdYoPD1Lm/9btF2ctXHiZev9mr0WdDH2zpF6+m5hhAKCkrLzdHSl4TLfoIS4zM9LupKDHV1g==
X-Received: by 2002:a05:6a00:4b10:b0:730:9989:d2d4 with SMTP id d2e1a72fcca58-742a987d7b0mr9607168b3a.3.1747752686609;
        Tue, 20 May 2025 07:51:26 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:26 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 08/10] selftests/bpf: Make ehash buckets configurable in socket iterator tests
Date: Tue, 20 May 2025 07:50:55 -0700
Message-ID: <20250520145059.1773738-9-jordan@jrife.io>
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

Prepare for bucket resume tests for established TCP sockets by making
the number of ehash buckets configurable. Subsequent patches force all
established sockets into the same bucket by setting ehash_buckets to
one.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 0d0f1b4debff..847e4b87ab92 100644
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
@@ -452,6 +466,9 @@ static void do_resume_test(struct test_case *tc)
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


