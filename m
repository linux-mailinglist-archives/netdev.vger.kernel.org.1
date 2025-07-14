Return-Path: <netdev+bounces-206811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E1CB04739
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4F21AA0985
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6626C3A2;
	Mon, 14 Jul 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="GOEwqv7C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493826E6EA
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516576; cv=none; b=ZWStEzZKgLBVnvcKd+gQSWcKsWy9Cwa2qN2zh6Rt8pvSJwXRtbvpBk8KXcjVOEAt1Vrc60BkVRh/RZNvBPSFqj1E5UrwPnUoSgWa54CnPnb9fRzoiJY+4eGOPGLV3Zm4/vJVH33KGEBF9hvh7moytbvRJfKC7ihAC/FOSF8C3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516576; c=relaxed/simple;
	bh=foepoQWthtqzAO/amSXmA+Ijs1+fWhMG2CBZ9t6Tz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcqOHkp4EXZsXTjS1BHAki9z7+h5eYJOlZo4JhmR3YCk83lYoVNMd6KJPlzwzRYZFdyk1aBsMaM4zWBd+fJs4vwcKWsGXIFzZhyjZoaPcXmks6CDOjEyZpwc8LjNRpBPiYm8oHXLPEB4iXt7TJ3R7zrvbv2J3lVxTdR132dZhSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=GOEwqv7C; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-237d849253fso4966215ad.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516574; x=1753121374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=GOEwqv7CetpVbUDPzX0i2vocinxDIQcmiOQ9hGm5gfzjtBjRFYljAxCv+66qrWwDBd
         gJFfmbcOBc+WnUaBhKYIVRoRx+YWvuE/SY4DEn7ZpAsfoppa+ASjaC7u9DIaZDhobgKG
         5Ku7a++TM4baiwEmcvCi940uO0oi0izDLZI+StkB0KDz4ra6o3F9puehGlxn9xD9+ryc
         9xCkPv8WocEMYwe70jP3jzScAe36BAwYUieqxK6alaXWgR33LfZadudhp9VKiwEn+RyW
         /ZW6Ar+83NrqsQHK8eQJRWDszKdAOMqPs1kpJf29SlZGvvpR2MGzxqBAw47/101+bBXI
         mZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516574; x=1753121374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=cq9YYGoojwKO9lytbdIbjxafQsXY14LNYETmn4C4PM9X0RWnJ9UwGMqHlaKlPTXmGc
         7q+NKyB6+9hq1m8d5ax+kmFzQ7dOy+0c6HrqxYmxyVI/dtlGm4B1nRRnatgmpn4A/Z7E
         ARqnwsJwlWyNiev53kOJG/byg21aHKg6nL2XZfVpBanHWy6jAlkbJpw8Fk32jgbKMKrp
         1uPlqIpRz/X039G3I1Z3XJDCqK50nfAKDapw1tZghztDxbjaxeI1qyukV3hQqQPK2t39
         QJ5JioHdXSS7497ui5YJcAhNz7v+Iyt0oZryzmkHjWK3yKcm+3m/Mo/tJd7emOjxTJCW
         SlVw==
X-Gm-Message-State: AOJu0YzfLndBVHGdxVLwO41m/UoyvzTeocaGr3AsslLZ96+g0iyxuMHR
	6L82c1UKY0hLnZiuCZ7Qil2+o0rp3iYOewVE860/+WuaCdyLwWeJFm6mVBU6EooUGVRR2/+AaS3
	9NxPk
X-Gm-Gg: ASbGncv4yzRYldkgMgpyXbaWwYd4yEstKH2Gu139cYwVDGuX2jIQSFi6cAi1wdr9MfT
	EPVfsMhIRWP5zSbiNDnG3oXjs4N31PvSl2Jfo99vlafbTbhE8vSt+MvPH90h62CoRaZylU5fG3q
	IJ1BBVIeaAYNhRnbH620fFs3bHcfJ3SWg9nm4J0WoIdbGvXxEVDIHXdId9UTA+YiCoRwQwBebM3
	BK6KZ1IUlCoGQMVlRRJVkKQVzzouNGFI/aPNMZUoqwUlKhRzS8LH3hYGIHhmy3JOVFO6sQA+/cs
	8ivTx5AOTAFLUmdGSSwe+a6KoHV9UjID4E336SCN2xrEbCLW5m49FtxRpu8t9LuZmG3iwATi3iT
	6hdvUi6DHpg==
X-Google-Smtp-Source: AGHT+IF4LbK0d6KAHKC4bWQilGTFlSFuomzHi6+LSsRe/rrXjA3H6SuX2zl4/HR0nX9LuMCyYeJBSg==
X-Received: by 2002:a17:903:1c9:b0:234:c8f6:1b09 with SMTP id d9443c01a7336-23dede84f28mr74980305ad.9.1752516574381;
        Mon, 14 Jul 2025 11:09:34 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:34 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 06/12] selftests/bpf: Add tests for bucket resume logic in listening sockets
Date: Mon, 14 Jul 2025 11:09:10 -0700
Message-ID: <20250714180919.127192-7-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
References: <20250714180919.127192-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replicate the set of test cases used for UDP socket iterators to test
similar scenarios for TCP listening sockets.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index a4517bee34d5..2adacd91fdf8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -358,6 +358,53 @@ static struct test_case resume_tests[] = {
 		.family = AF_INET6,
 		.test = force_realloc,
 	},
+	{
+		.description = "tcp: resume after removing a seen socket (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_seen,
+	},
+	{
+		.description = "tcp: resume after removing one unseen socket (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_unseen,
+	},
+	{
+		.description = "tcp: resume after removing all unseen sockets (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_all,
+	},
+	{
+		.description = "tcp: resume after adding a few sockets (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		/* Use AF_INET so that new sockets are added to the head of the
+		 * bucket's list.
+		 */
+		.family = AF_INET,
+		.test = add_some,
+	},
+	{
+		.description = "tcp: force a realloc to occur (listening)",
+		.init_socks = init_batch_size,
+		.max_socks = init_batch_size * 2,
+		.sock_type = SOCK_STREAM,
+		/* Use AF_INET6 so that new sockets are added to the tail of the
+		 * bucket's list, needing to be added to the next batch to force
+		 * a realloc.
+		 */
+		.family = AF_INET6,
+		.test = force_realloc,
+	},
 };
 
 static void do_resume_test(struct test_case *tc)
-- 
2.43.0


