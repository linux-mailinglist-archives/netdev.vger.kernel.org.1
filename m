Return-Path: <netdev+bounces-221348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DECB503EB
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA201C67A85
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0708636CDE7;
	Tue,  9 Sep 2025 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="xzeheDro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A74371E8D
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437237; cv=none; b=FN/yflHmENnA5mYx5dDzw7a3rIAypAQ0bADyQaoB9ZmxeXdvh6yIvWKVFfbj+QZ3UJv7PN9gYh2IcSXH9YvBazAirrYCT0hc2xE+i80sg2M+/eMhlCfbj37DDvq64gsztrg8LVFcAurfTMve/Qj3B0+rSHK4iCGbpPHjRUzuDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437237; c=relaxed/simple;
	bh=Dm1aTBZc9HI/GtyriEUjTFt9Gu8JrX3TSGIuhtnEeco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6y8tDNNZxoXls71yV4xYN1SCT6wKWpa5MklGlN5FMNmJKWHIMmlEhCXD4MagBc/+aLrtOobAwsgPPUZu6sbCJLbo+o2UchqSnDNLNICB/E1/HYXePWYiCev0E2mG42vl8dxaHuTj+1zO4FwUFwgBrD90O8FHlVQCl4AuA19mFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=xzeheDro; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-248e01cd834so12542335ad.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437236; x=1758042036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qZqsCHPlx4pn/0GrFvLfmlL0eYEuMqWlGHh8qMhlyM=;
        b=xzeheDroXE+j0DVlv6muy7ZlMDXP69PMdKh4V7VraNeFMXwsAzXakUjQghjXaql7qd
         Nz99HGjFq406Rs3I4OOqwnpystbym6x+tANf2a0Dkp7aG+LxqVdV8oy9IGvuasufakgL
         JbjP6cDF3+BA9zZVQivI/CSRM4UDyTCIvsJ40Urw5KFbyPEbTrM/7KdjK4oNeKElLoeT
         gwa7/E85W8sdAlF7gXlIsEyTHVdtEKFun63r5j/YSdC9SlNCs6ITs5mDuNgEm4xUG8KT
         HM7FN5jHh/HggcDyqnVmAEDJYx5R5sZE/fiKN+338OKwjxI3AlmyZct0i2kJ1GEVLcjb
         HRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437236; x=1758042036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qZqsCHPlx4pn/0GrFvLfmlL0eYEuMqWlGHh8qMhlyM=;
        b=dboKJGD59JlEj6f3WQl62k6ROzGm8J2xlu6RLZSPc3RW1SMwPRbwg4sv9p0lH/JXUV
         SG4Zr1Dug5GHJZvNnQEJpV4iskPUWNJ0OUL79Ya4PCaBj5Gn3b1cJMsWYnOxNTLjUe1f
         Gazvs60uBAUYNYLbjIDExjUfavcMpx4nQoFlnRX1evaSwBbNPRvkrML229dv2rNujn//
         1ZGmnh/oOzsDHo5BAJiU/WtEutN0h1FXjJKFlPuqT5yuknWcqrC2Q0C/sUBz4//y/HlA
         SN7Yy6OshZf54iBjfRQzar87kLyNfz2srSsufDTqssNyeVBuTinyIp2F5NlDAMtPLjXA
         HHPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7WtmG/YGqBgLhx7ASGLTRFhZ8qq2gm11jwiiQdl1xXt5IRJ4dS3daCmblnA8pE2kwWbjhBds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJUerVFD/uxRbp9trcVchBsEyCNmY1R8Nm0Chla5xmOqiDyBn
	DkyihdClChr5p3NZ3qT9ut8+P2hf0mi4L4sPHKAAOFcLqMGIoYOl6ite0SSou1mK8AA=
X-Gm-Gg: ASbGncsLyNqMpmaXmUK3Gs2L/SGEuqT/1usTVabOqDkiuqwRrxWea0mCHQ/wDkDRvNG
	3v0RvI69gADjW21Gzfi+kNEIDKoEJhm6svxJdGS80yBgUF9TZZzrEDdQdcJfVoSHamvfKRfXo9E
	rujPfSsaOGbwVKBgFt8X4wxnYdGUx9ZBrvcWttG6hSeYEq2AfplSqPuYbxRPMFKQIdEL7S0XzK2
	KC7ynPcSofXa1yUF+Ij0ZTeOlDjU8fX/z86QQmCuCvsHYEMcsaZN8eiN87YsP0YXjicVAkBlTj3
	T+qQMOWPB+vZ7jD0AOIN8XSvKcUb41HitFx4ivmGPEnOed63+XE0lJ4UvGgMY7V/KwYLPam/zeW
	Jfh/VEWBV2PHfLkRW24odkuSe
X-Google-Smtp-Source: AGHT+IGLqeGuYLqLnjSvXyqUuF3AaMwm/fPoVzI1a73i1YdUXy7AmvgtZs0o4oRpbNNTF6IcxdlpWQ==
X-Received: by 2002:a17:90b:38d0:b0:32b:6d04:e78d with SMTP id 98e67ed59e1d1-32d43fc8366mr9203963a91.6.1757437235542;
        Tue, 09 Sep 2025 10:00:35 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:35 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 08/14] selftests/bpf: Fix off by one error in remove_all_established
Date: Tue,  9 Sep 2025 10:00:02 -0700
Message-ID: <20250909170011.239356-9-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test is meant to destroy all sockets left in the current bucket,
but currently destroys all sockets except the last one. This worked for
the normal TCP socket iterator tests, since the last socket was removed
from the bucket anyway when its counterpart was destroyed. However, with
socket hash iterators this doesn't work, since the last socket stays in
the bucket until it's closed or destroyed explicitly. Fix this before
the next patch which adds test coverage for socket hash iterators.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 27781df8f2fb..e6fc4fd994f9 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -463,7 +463,7 @@ static void remove_all_established(int family, int sock_type, const char *addr,
 	for (i = 0; i < established_socks_len - 1; i++) {
 		close_idx[i] = get_nth_socket(established_socks,
 					      established_socks_len, link,
-					      listen_socks_len + i);
+					      listen_socks_len + i + 1);
 		if (!ASSERT_GE(close_idx[i], 0, "close_idx"))
 			return;
 	}
-- 
2.43.0


