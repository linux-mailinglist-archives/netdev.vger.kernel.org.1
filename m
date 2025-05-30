Return-Path: <netdev+bounces-194440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC3AC972A
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D11A42DE0
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8647421A451;
	Fri, 30 May 2025 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="TLT1qBi+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03FA283FE7
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640720; cv=none; b=lMMegykQXjuWXmKp7eozU1cNkyuV0BcLeysXMZe0lASICTfR13b6rFQonZwhHYRb5DCi0iRDzO7yuULrTclwcsEAPbeppugw8KBopx95U3ymtgtK2ElRO4S7imR0p6HA4+vdPwmBlBZ7yVNx6vLI7kajwFlzALwedJYs5HX6e9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640720; c=relaxed/simple;
	bh=eyGkyJV0MLgoYsd401OIgWgj+kW9ZAGeWCSGK+iDlrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUxlp0B0YCWaBTKZIx+01MrQboh1woJPHeS2Z7+mCnDFo9EH6xVJkN+hQNhT5fXlLhaz2COfDc3JTUzbNMOBGFTstUid7JSIJvwtPhmjFvruyJMLh/jsQKKjSXQzbnwkg+vhPagf2T2ZQMAZmuEXq6tQw7EGZffqPVNy3q8rEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=TLT1qBi+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7426c4e3d57so374418b3a.2
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640717; x=1749245517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5NXLyDoYKSOyB9Apg886vIxC4LlUqj7hrcCCh5BYpo=;
        b=TLT1qBi+5vOgItyMcgPN4WSBpGl2uj8sV8MUWAy5QsqbBNa+tmrLrk6rVtfIoQKvia
         /y7Q9ht5IyGdowsgQ8djZrYfmQDRlP60BPKx71UfCT9wOlmsKgfpksEtcDlxEI+z5ERi
         0DAb8Ahwvlx2/imFMwpexzr2xAPHjhjlNOJM7hTgN+/7grE3lfqAE1fdyOMc2LWUYD6G
         LE4O1zRgQ1fh0MoEISvtVI/bLqYzusBiDeer1x6/1nGsKQyV9alw93wEduxtM7N7Laz4
         KwEgAwuMMy5n2aajCHsCaAuej9EabPTXZLgd/URcktqtZTXjXIxIas5cp149B4sVrKHP
         SywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640717; x=1749245517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5NXLyDoYKSOyB9Apg886vIxC4LlUqj7hrcCCh5BYpo=;
        b=ciTkL+vNSjDvk73r3t+JpgKFPYhOPr/A9/gSXWDAXqwuCLUdTmJXutl6klPrwPCSzp
         NZFZhZk+4EAzN8cOxXBm9aR0qLz/KHLv4uLm81hu0cGQBAESNRIV2H6gxjfL2sS3nh3F
         vfjBljFlxrtP33JmHrcSLEMlIUdSh1Z8KmlS55b+XQ00wKXKbSaE5u40WWmiuVJydJHr
         gTnsHu9mQvNTQH6RZJ4DJuQXQ19OLahQOX/2J7Rgyo90dlkAwrFdlzFYQXl2OKzL6PaM
         lhX8kWUGuufztV7uxCM8Shu+WRZ7SXXCz1qOJziQwKJ/+SySftzKfNVfNG5je3PkKJbB
         cxWg==
X-Gm-Message-State: AOJu0YwaL5TCoqqW9DPsPpptH9VcJ10Xr4oQswcrQLH3ZL6sZHXU0GV6
	gDIzaOxBZrxiYrpZAvsGKvHZQc7FJlHK3G/gFiIfogzE3O91XBQrN/ZocwNkiWl/QftmG+ekOzP
	9czh/1fo=
X-Gm-Gg: ASbGncshoQqfPnCBckp/u7IpiOW6rrTP5ujBotNex3bWADn4hSt87GzNkzyQpOAPBfV
	HG5xFPPXubPlBTHvYryKDxVkAOkZnEZwv6C8yMdauKncSpgePtdi+Tsb3EEuXVeLxtb/IqWSo/d
	qOb2ddjFnjSl3SKU+HhuMQISlZbDv7KrfCiRPiAmhVUHP+Z52VW6Y8CQYHFERQWBD6dk5nESWQr
	3FhrRVJhj/3VbKLa3iZuFAqqfm48lbenSwYQMI1WewlG5QohaVacruPU7uIynsYev2bsNE8gPnT
	szMHi0jQeVDfojxkVHgpRaT3U7Ko6UU9+EwXuFpB
X-Google-Smtp-Source: AGHT+IHF301dVb0GTccKpa8LavsPhiDW3Qokrkkamx8y5My52grevveVHWzKJJq9qWG/nHTMq135NQ==
X-Received: by 2002:a05:6a00:a17:b0:725:f462:2ebb with SMTP id d2e1a72fcca58-747c0adbf9emr2323845b3a.0.1748640716726;
        Fri, 30 May 2025 14:31:56 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:56 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 09/12] selftests/bpf: Make ehash buckets configurable in socket iterator tests
Date: Fri, 30 May 2025 14:30:51 -0700
Message-ID: <20250530213059.3156216-10-jordan@jrife.io>
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

Prepare for bucket resume tests for established TCP sockets by making
the number of ehash buckets configurable. Subsequent patches force all
established sockets into the same bucket by setting ehash_buckets to
one.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index afe0f55ead75..4c145c5415f1 100644
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


