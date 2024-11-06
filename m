Return-Path: <netdev+bounces-142543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE9A9BF935
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBCE1C21FCB
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACBD20D501;
	Wed,  6 Nov 2024 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X3rgrRxm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76120CCF2
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931978; cv=none; b=hDqyTDMh1JSTmU25o0/iofYpqq/efSjc6+BneeHpf3HtPC/Lg8/nYimd2NkssUfmOn9W/1UbrYWHXIgObi3mwQnhiFNc4EN/bCGx2S32b3+Ab+XxRFZOh7W39QOyR8unhVtCmyQ9Rs6G41NFX018atTP9IGlR32jIG7TfpbwaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931978; c=relaxed/simple;
	bh=vEjvDL/9pRsbu/Y5kaMsh5Pz+1UMjjvbAxje0DPqRyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZXAb8GsTPpihu0p+zYMoD5WrgK/jAk3gHf7stJgcvOuhzO/OR4mLPepk5LBrkz9P0waRtRDqGN4LXCiDP0JFZkwxkkcXg/WGoUJ96thHKyv4XjN9pjeM+q9t9cxmn0UZEDrTN7wDVhibSSjjIxVz8DiuqUMrNiBGcCMZaycNlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X3rgrRxm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b153047b29so19185785a.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 14:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730931976; x=1731536776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eexa5HYKEVjD6R3rV24Gretx25puKESuMNQoJZf1TdY=;
        b=X3rgrRxmdmGBbO4wbWMcSzIdKHcKWt6JST22FPdov87ccqB5eI8qwhJ81zItraPXrH
         NJ1NVnJfpwTlSsSI7qY5RXxVcoUP2jzQM9NJbD4LA94ykYL2+6UtYk67yGWWZ/ke9WhR
         cewi4vcwdZlU6d3LLSuMSe/LRw5EL7VYTcLEZwIcLxVDVjDcL3YQv/SmErSJWA/d9Y7b
         0DnzWhkrauaOQuMnZcq50Qm2BMcxCB6NTi1VPUpSjGazLMwYM3aFiflKXwgWjJ97GuVd
         l1mjfeH6s5FgLUodxt3RLrXq4RrxVQ9ILZJyjsG9zxFplk2xKJi5JCa7wP1NB9xgZ6JC
         LsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931976; x=1731536776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eexa5HYKEVjD6R3rV24Gretx25puKESuMNQoJZf1TdY=;
        b=DEoL0/6KJBAug9/FhQx++HRZdVHDXi+Iq8kOVQjcAZKfCpeJAbxZfCO7xXBGOwEVYf
         VCDSvl5juIMmCfIi/vcOJdM/MXlaOn4RHQIz5j0jo9rlPhvPDYdDEQtkYV0btuLdgjOt
         f57HpJgwd3uKWYTwFj2SqCEsk4Be1Xhkfn2fGl0G7yPJRtW95hHbYvYFnzXrBqvidGMn
         Kb0MgA1esilKPp9/Kj/Yh12YEUpsfiirYpGt8hfM18elBBqXjs4ufOqhhfQbh8Uq/W2u
         pgWFTCrtlmICp6cib2x4V7n+zr2lqTYqfaWo5Pi8PnycfdrXCotM0CKDzPlWKRS3hwiF
         wg/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9B0ykND7wwYQlTktlCNtYhv7wuh00W78wRgHbT9APsN6p+Va5tJDq+F/fVK49+X9Emg8/FXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeE9DCm/EbxsVpYX+69KMTrcWdNVNhM9vw4UqEndd3gM/rvQwx
	nK50Ft9FneT2A2fj76okYnKDTCjP8EQC7Mw7x8zau5edQmDry+feRI5pGDd0Jo8=
X-Google-Smtp-Source: AGHT+IGetZqTTQLie0fDUOt815GdjRKTeDYpP+FuwDi/1WHXqOgmx6xtqwZxNrFwJSssoGEjMtlNQw==
X-Received: by 2002:a05:620a:4104:b0:7b1:4fab:9fb0 with SMTP id af79cd13be357-7b193eed9famr5864837585a.18.1730931975987;
        Wed, 06 Nov 2024 14:26:15 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acf6c46sm2536585a.127.2024.11.06.14.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:26:15 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	cong.wang@bytedance.com,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2 bpf-next 3/8] selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
Date: Wed,  6 Nov 2024 22:25:15 +0000
Message-Id: <20241106222520.527076-4-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241106222520.527076-1-zijianzhang@bytedance.com>
References: <20241106222520.527076-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

total_bytes in msg_loop_rx should also take push into account, otherwise
total_bytes will be a smaller value, which makes the msg_loop_rx end early.

Besides, total_bytes has already taken pop into account, so we don't need
to subtract some bytes from iov_buf in sendmsg_test. The additional
subtraction may make total_bytes a negative number, and msg_loop_rx will
just end without checking anything.

Fixes: 18d4e900a450 ("bpf: Selftests, improve test_sockmap total bytes counter")
Fixes: d69672147faa ("selftests, bpf: Add one test for sockmap with strparser")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 1d59bed90d80..5f4558f1f004 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -606,8 +606,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		}
 		clock_gettime(CLOCK_MONOTONIC, &s->end);
 	} else {
+		float total_bytes, txmsg_pop_total, txmsg_push_total;
 		int slct, recvp = 0, recv, max_fd = fd;
-		float total_bytes, txmsg_pop_total;
 		int fd_flags = O_NONBLOCK;
 		struct timeval timeout;
 		unsigned char k = 0;
@@ -628,10 +628,14 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		total_bytes = (float)iov_length * (float)cnt;
 		if (!opt->sendpage)
 			total_bytes *= (float)iov_count;
-		if (txmsg_apply)
+		if (txmsg_apply) {
+			txmsg_push_total = txmsg_end_push * (total_bytes / txmsg_apply);
 			txmsg_pop_total = txmsg_pop * (total_bytes / txmsg_apply);
-		else
+		} else {
+			txmsg_push_total = txmsg_end_push * cnt;
 			txmsg_pop_total = txmsg_pop * cnt;
+		}
+		total_bytes += txmsg_push_total;
 		total_bytes -= txmsg_pop_total;
 		err = clock_gettime(CLOCK_MONOTONIC, &s->start);
 		if (err < 0)
@@ -800,8 +804,6 @@ static int sendmsg_test(struct sockmap_options *opt)
 
 	rxpid = fork();
 	if (rxpid == 0) {
-		if (txmsg_pop || txmsg_start_pop)
-			iov_buf -= (txmsg_pop - txmsg_start_pop + 1);
 		if (opt->drop_expected || txmsg_ktls_skb_drop)
 			_exit(0);
 
-- 
2.20.1


