Return-Path: <netdev+bounces-229202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5805FBD930D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3C984FFB9B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673A310629;
	Tue, 14 Oct 2025 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4yH8vIn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8E2459F3
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443269; cv=none; b=KL8mXxTJVFBuQvpBvBpQLi34mQcbMky4N0NSYH42mtm5E351Ov46ikyuk5W2lqFFMWCAp5zkP9uazEZU4nEdS3EIvXuVp/ZWmea/CAzNaSpTIJweedEYS2exG1VA/JMGv6kNTnM2tdM0fJVBZWGPDbDcBOHHFFaF/WOiO49o3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443269; c=relaxed/simple;
	bh=8vcDXcnwhs3rxYjGuXzeraCiHUjPFfLkO3qyrXBdt3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XQlkDK+gwLU2VPcwQBuqb7WPg+CLHwxSkD/NX5gH8KKFsIhxGBdrFZYUUgEWIftFVnmlUyhWblyKuEMPEa5RIPCuhxMB7WsGVtQlwl1GkyXLupFlSHU1FSLD2XZYP+kdg2lpg0voL5UJVO4yGQEkdaiXWtYJ3I8TgJR92YC5hBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4yH8vIn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2897522a1dfso48729005ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 05:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760443267; x=1761048067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0yuwxDRyoAgsx6in/i8UeLI6Ei3SxN3gVvZwYXOMq/M=;
        b=H4yH8vInoSS83n+2nTu24/crogV1H1jYf+NUT06sV7v1ObpjJ3KJutuF5dMO2EwzYN
         KT37kNBCrhPYqi5S1nAwKZl7fITQySi3oj+TJtiz/MjhAWP5csiNpc9ltJGq2+/2SDCy
         /1YrFjT4rj+z1TEO/iAvPU48/02HY1tt2fUFHQ6uIoE6hOWpgaFJXrqL26pPPp+zZ5jO
         5+OoGzTCo6tIbLHaKXYetEVx/1eVYz6d9YQGiQ1watgCNR/Ct4pJD/+n7pLtabTGFQ3s
         pW+7LeINrkdEDzweFiYmzQnGUelTrzKY9axpeppP8BN89zGrbl6LCRnR8bf97m/NMiIp
         2xIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760443267; x=1761048067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yuwxDRyoAgsx6in/i8UeLI6Ei3SxN3gVvZwYXOMq/M=;
        b=eGt1I1GBU8jbb1t4Rhdv2gpIdPvo9Ol/+bYI94Tc/vUSBrpzFNPKToAPa3tYyGY2QC
         PJuj+wL/JLfUzvTtTY0mgFce0z8CDDrPg3Ok7l7bMSi2yCcaL24WzbcIt+Q29neCXQk6
         uL9xqsYEwqvzmeGr+F703/GbdeV/8RC6JXitoCAjlaUu0/kKekVJsTT/+TCYWlT1Tlih
         VhhwVOFWPfBaZEspm3kdhwhPodXXX0p+r5q2bFbkUf1ozhvRUnQ9pnoFSLa/0qgbBGx6
         CgFF59zRXWTbmT40qizNJRDEHXlifk51AEkW4+T0VwPP9hWZCwfDZMMyzu3BQuGbdHUl
         8H9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9LdfnohA5n9j0OXf1bwXMD7tKwM73sjaMXG0yIzgbN5aK7cj34qMAvlE402pxqlezvHov0Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRAn2k9kuoZl6CzJZz8njA0OSuLLz/mJY+La+sW8rm3B/7tX5L
	tEKHElin/dyYvEw/X4/d6PcH5XqmNw5K2k38r/kmBJA4qXbyLfxRBmyO
X-Gm-Gg: ASbGncvwXu7lLqKFL3ueeTM8bwGn+dWqj9doSsTy7hOV9V9wAXHJ/grj0IVj58DmXlS
	KZ/sGz/kuQfg1TOStcNjob0fSz3ErGpMOUh94m6t6bPKUSr15ClcJhfw+dCaouDYVI4F3Fi42Z2
	Q9kHj5vrNhkHOh81AYesl3JLq1qT281oHlw/JOkQJWx1CVzUnOBEqNDTu7GIsgsYhgtkrgjVDxb
	Zpl1pwBiHkkgrgvnlWvHuobMhCBCPq5oy8rWqlf8H7KMJa618C1pSy6aWhpz5bxy4IIGinIEkvg
	YZQ2ZgnkloP/hBzegXtwdqVgPRyBt3QvJruKqWLizDn/Gv945rVWYgmOSEWKjfYc6Wni3Usx/Ii
	RPu4DsjXRlCgnzCKv69+m9cvURLU9MQgykBpfXLY=
X-Google-Smtp-Source: AGHT+IELofrr7ePRSX0znyiz3djLj5MGb72fhJCt3ux4kiA3yVpA6dKADS7dU33/QDcoos6p6fBzKg==
X-Received: by 2002:a17:902:ebd1:b0:24c:caab:dfd2 with SMTP id d9443c01a7336-290273032a5mr308789575ad.61.1760443266446;
        Tue, 14 Oct 2025 05:01:06 -0700 (PDT)
Received: from Shardul.. ([223.185.43.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3de4asm162662315ad.92.2025.10.14.05.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:01:05 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list),
	Shardul Bankar <shardulsb08@gmail.com>
Subject: [PATCH bpf 1/1] bpf: test_run: fix ctx leak in bpf_prog_test_run_xdp error path
Date: Tue, 14 Oct 2025 17:30:37 +0530
Message-Id: <20251014120037.1981316-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a memory leak in bpf_prog_test_run_xdp() where the context buffer
allocated by bpf_ctx_init() is not freed when the function returns early
due to a data size check.

On the failing path:
  ctx = bpf_ctx_init(...);
  if (kattr->test.data_size_in - meta_sz < ETH_HLEN)
      return -EINVAL;

The early return bypasses the cleanup label that kfree()s ctx, leading to a
leak detectable by kmemleak under fuzzing. Change the return to jump to the
existing free_ctx label.

Fixes: fe9544ed1a2e ("bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN")
Reported-by: BPF Runtime Fuzzer (BRF)
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---
 net/bpf/test_run.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfb03ee0bb62..1782e83de2cb 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1269,7 +1269,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		goto free_ctx;
 
 	if (kattr->test.data_size_in - meta_sz < ETH_HLEN)
-		return -EINVAL;
+		goto free_ctx;
 
 	data = bpf_test_init(kattr, linear_sz, max_linear_sz, headroom, tailroom);
 	if (IS_ERR(data)) {
-- 
2.34.1


