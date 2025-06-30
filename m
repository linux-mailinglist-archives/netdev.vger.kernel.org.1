Return-Path: <netdev+bounces-202614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C2BAEE58A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D581189F8C7
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD062BEC28;
	Mon, 30 Jun 2025 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="sGN8rCf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB629CB4D
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303860; cv=none; b=Lk/N+SI+FtUQDoInJ+y8RdtiFImb7Y4/J8/gm7L5VMTUfATuLukvWHmHMkGSUvYbjWoQeNx6KMtQp28pesQQu6LNJYvZO1H4aMOAswXekifYHYnR8/34zMm9HVRmjhonegnLQQe2Tlemq0Ck4hZo0E27bwXYLGBQiwFUWvfHCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303860; c=relaxed/simple;
	bh=eyGkyJV0MLgoYsd401OIgWgj+kW9ZAGeWCSGK+iDlrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXuJoqJ5MR+9KN+6HDns3vq2mpU0dcA17I+NqP8FWjjd9uTfME1Yzfs/+gqzSQl3P8dqKCASAZzqALnR/ChORseOTZIdlNvvWobLMVn0Zz0qLcHJflmR2HsXFAKf361JMJ2cx6Ff2GQ4JeecIkkWRzwlszcJA/+Fb+fATJuV5sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=sGN8rCf2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7426c4e3d57so378184b3a.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303857; x=1751908657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5NXLyDoYKSOyB9Apg886vIxC4LlUqj7hrcCCh5BYpo=;
        b=sGN8rCf2JtBhsw22Qmi89fWDNunoIP5UmtQTz8k89GWNASKjrRcYfMCba91Q5uoZaT
         xBzETRlzRc4F1ln/5cKDou7/d70sP64w5ZU31ysHB/J0gPyfSLj9AP5/LWqLFyXJo/NY
         5C2OEt2iqkRZ8fkhHMfjttfPuuDQPllg05QCBtNrA1g04ZeobswGeevm5p1kSCK8T9J1
         iAcsHBRKmvBxgn42AHsWYqftStTgLqvEGCBujZ0tDpCuiH/ZL12M6X1jKT8oMsejuvz+
         hUomZ4C1V9iJwaebMZTGCCOh7zadYO3iQycFoxMsoZzHBYUamPVKLNI8oWabL7CCEuWX
         sePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303857; x=1751908657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5NXLyDoYKSOyB9Apg886vIxC4LlUqj7hrcCCh5BYpo=;
        b=QxcYfORjgjR0VxRjNfkTH1Wkcfk9igyqDmS+s2ZI+1nA9jwQj055D77noaJ5ZRgBZm
         gkVripLNQbESA79lsAavvgr3vB31IrsIFPlqHm1XGtqnH3ixSp/q3XGfX1UGwVf5WMo6
         BKYOvhuDTD3lzb2LnEv8oh72u4EIwysBpWixJKe5uQ8offwVChxdg72KkMgREGWYE1RL
         6YM3IHN4e5Q3g48/F3zc33hamdNu97ZkWbi6Pg+zwNP8rGBxKlQjku+tenICn8E0Nmdt
         7/hcdkF4SauyfB3/98gzvqzTJdsDfaWsTGSQ4Ip8E1zahcaZux1polxTWjw7S/dI9K6y
         K5jg==
X-Gm-Message-State: AOJu0YwdVzNHRvw7P5RftrSd50y6UmJiJsG+/NdGYnWBIVBahPy3aebY
	TVftn90RBnA02+DEgLsj+Jyqjo7uJErrEflr+5hovFjF4vnynTU9qsmeJNcOJPV8Iv5YCvmJA5l
	X+vdREGM=
X-Gm-Gg: ASbGncukpi02iktai3bP9y26rTZrpiY4QFtx1b7Q7Qavk7DmUeYbv22za0jZfKfgHPL
	nSPh3LsCAiaEJHZcpz4L7bXMYYRihcnFvDBgzBHXPfAJ8j9XfV9MXV/Mxd6MsSsxSexyjqW3Rp9
	KsNF7orlqGDti3aN5ZP/yVvlFbzf8HBFQNGNL1b+dTkdzHYp//WwWGGFHA6ArkYKZri32MoyXh4
	fUVSAdtDewJUEdVBQhhFtUgOtc0ARc8wYTl9oJnz6q34HodoYcNK4aeMm5HtnnAIGNvCsW9BFgq
	HxeKEEyizufSNrnaqVoZ7Jy0hpYG5ziQ5ZwoMTJKM3750eP0mQ==
X-Google-Smtp-Source: AGHT+IGxIpEBvEshtPIxEArDVOeVWTThj6jF7arS6WPZX4r9eSzcrsoa+UXujbSFQ65T11zHqvQ8RQ==
X-Received: by 2002:a05:6a00:b21:b0:742:938a:3ece with SMTP id d2e1a72fcca58-74b0a68ab95mr4050094b3a.6.1751303856879;
        Mon, 30 Jun 2025 10:17:36 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:36 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 09/12] selftests/bpf: Make ehash buckets configurable in socket iterator tests
Date: Mon, 30 Jun 2025 10:17:02 -0700
Message-ID: <20250630171709.113813-10-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630171709.113813-1-jordan@jrife.io>
References: <20250630171709.113813-1-jordan@jrife.io>
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


