Return-Path: <netdev+bounces-191916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81796ABDE6B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235084E4146
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972722512F1;
	Tue, 20 May 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="PIpnOHkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B32512C2
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752686; cv=none; b=H8nq4raLAqhcI4iufs3MpYvxT0WqoE4c3DmT6AWFlY62CZXb8rStzpEFpsPjbleMl5RLacibfl39mbWIRJTqDft9znymMSxYLC/sYfpWYeCvCbNElmWBy6bssa1RRh9zFguFj8EJti/q97pEnPfQmKqmR7TmALFMoC/HXzmC/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752686; c=relaxed/simple;
	bh=foepoQWthtqzAO/amSXmA+Ijs1+fWhMG2CBZ9t6Tz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvefAdw+5LunopsPIlirHpQ5kvFVmK1ygaB729sfmbhrNEOJLdNCPRhngQMxitCwfs5rvPDiHxCI+tO2FzBLFrZt0Z/N0ogum1c39oJspRjoSOVMfC/KQlzSck3vu1Wq34oCRglPgsy1x7sxlmm4dSUDELFMDpnEC9MrOjnu60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=PIpnOHkQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7376e00c0a2so479212b3a.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752684; x=1748357484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=PIpnOHkQpQe/hb2d/2787LlMQWafZMQfakY7Oj9Fv70Oo5OAefo4GuLb4+4zc1ewPL
         KPW7A9VQCqkAr0tUMtu96c3OcEpYC5E6RzZJJBBWb21fodRWjCyopmn6wq+N1mOgwQ9Z
         mWg5F0Ran3otbQVWChxuBK+mq1c9nANSnfvov75w0Mmd7/N+/GUTJLNBXb7dc5OeH7cM
         UPoNsT45XS74gLoWMA/NHNG7+NlL5SENejqva1KCnc8ygqUQ9eFbn4zrfCf+9wBA9ob9
         BixtOEMFA2pct/2beFd07wY/eImXq1B+XOftl+mvwRsfUIBDn0CUn++V8wUVji1YeIIO
         +QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752684; x=1748357484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=gah9wXH8URSaUii8ZAwiZCRUaz77ImNlbH1U9HiAE6F07yDXf9tuCMXfzQa9PaDC7n
         KRJ4auMnOZ4YaYSl9j/fv0s9fmwV2Cu72OpzghhMEBUDL6vcQkPCY8yolznxfyphmhHW
         mFiCn1hs7xrnYmKBXyxGOZZIUiSEfVWCmsEXGnHaCQWG0mKXaewJ5eoheE4/htWpXTRG
         lz4VdCb93uHW957Apu1rCbnBKBgr84s5bHIf865fHMLVdztEUta9tns5BRK2t+AIDeRp
         oa4uztwkuLf+9Io2vvd12XJOn6WrGxeUEh7pRGdoRPUClCZuejG+yPybOyGwNhy1SkzF
         a7Vw==
X-Gm-Message-State: AOJu0YyyOc43UE/E1ETa1lDHdoIDDSYXmg/dwVHSbE37nLP2uR9J0o44
	aNGVjgSeI4SQLSPzU3rBUrsjrX1fZBB5tQShPUgpDGDkcB3RsthOlePBRqpWoXBSqk8kqG1S9Qq
	/Y4tIX2s=
X-Gm-Gg: ASbGncto8lYBjsRi8P0rJJyB2D9vYjv4c17TnHuuYYmSd55YVqxbkgsdVXtka1xJH+0
	J4i9P4SMgvZD1yK1ie9xMJHCSpbW9fOjieOQcBd0bxPCAJXQrRxt+3uNEyk8F1hhZ5cosUKXS/Z
	WuygbvgEmMsLx2QiRGIwIPHvaArfAWIpDW6ij4UnjExaYclwe/+WUg6+GfGlUY3z7qjdj2McdYS
	ekW0+86uI24hV3Ij1y/iiMWUmcsPIW3ixAT7hXQIq1tcZctf/WKfwTkJaq42Jhr+pKDSSAhvP9t
	rBvGtKGQdO+dmKafuG0kx2+2YmeaVDrY33Y7K4uT
X-Google-Smtp-Source: AGHT+IF0F6xtLP2HHB5uOTkdRK6j/UQO37x83W9I0aWOiPNT9KpY2EBgs1u6lQupNnv0Z3avSxv17A==
X-Received: by 2002:a05:6a20:3d0f:b0:1f3:2cf5:c964 with SMTP id adf61e73a8af0-216219bd5d4mr8771721637.6.1747752684194;
        Tue, 20 May 2025 07:51:24 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:23 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 06/10] selftests/bpf: Add tests for bucket resume logic in listening sockets
Date: Tue, 20 May 2025 07:50:53 -0700
Message-ID: <20250520145059.1773738-7-jordan@jrife.io>
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


