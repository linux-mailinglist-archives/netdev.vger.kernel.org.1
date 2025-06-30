Return-Path: <netdev+bounces-202611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EC8AEE585
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F22B16E927
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FE0299952;
	Mon, 30 Jun 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="M0MWgoeP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF4E2989B1
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303856; cv=none; b=NMy9nOCyX200ztqAB4p9ValU/T45OLaZjy5DhhYYmEF8Ea7+Hbxp9GNzooljksAr6vmWdHf8w9FrV/BYqUD21CFAGjiG8GLQ2pJgwBnTkuPe+1a/1wOSMpk0QimSLomewN4lkaX6ixv6JQWKlMhQxywuC71LYxBJztk3ldumKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303856; c=relaxed/simple;
	bh=foepoQWthtqzAO/amSXmA+Ijs1+fWhMG2CBZ9t6Tz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ie30FLwGUTR5IL/V7/hI9W9dCSqVBmTpgnuB08834DjY/CoHD/rqr48MeCQobBAWazBlv8Q8O18fnjJKd6JUddZ9H0gizlOLz+t9QEM6vtfXwK/6gq0wO73xdSdzByl4YrUB5i7PgQmtPBK5AmZFBtwvaEXZGPaekZs3etaZtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=M0MWgoeP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b34b770868dso610315a12.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303854; x=1751908654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=M0MWgoePw8FkrFUksq1CQ1Ms3dU+Synq+rlOGEIHzQkad0MLoNg/HzI9j0lkOQoTvQ
         QnvFh9eTLIJhgkfXhNYgldFOAzgh1Rj76jreMGrMv6XyEkf4I1MEl10E7CVCvXlrkpaE
         vL1X1tmZyqB5fRJGPvBRlDztx+O+VdeTSFPQTbKL/3pt7QR9oYQLFU2GWKXfvlmZIbf1
         Vh7BjWiaLGT26LlTIDHVC8LCrbFRcRqutzKmH0W3fe77SUa/AAVuRV04AxRRe1Ddd5Z1
         oOJL3ZLmE1e8QIuUTdbsW2xhtxn4Zq8deaUamX2e44w8EL8aTNQBZxNsz2dty0R5bcAW
         1iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303854; x=1751908654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=UyUx0P1SDtbVp6I0r3ln2EWrILWGyzsCC8vZB/WjsOJ2GqoF8cgTs7/YVD8t2N1B8W
         NYcSrdxeHL0Fc40mzTIBy7mG0LlcbtdAkGh/Kqj+pzxj7e0wOziiZORXP3EbQufnIXUn
         Xj5t5hOH00z0v0m1nYPTCSkdxrg4BNxtOru2HdneNhoQupHymol75g+eDOKmswUEsKWk
         KBfBEY6cZ83s02bO5PtRFIUSo8WEKWDSKluYF3xR7iHb+BNf4E6P/5DWPI4Oe3pjVpIX
         hTLuei2QRPIQKkMsiROPkmeLrclCOTignVYKa+B8hp9LfN7wAC0iwMWlLkOwZvTfeMee
         Fb3w==
X-Gm-Message-State: AOJu0YwMsuiFgGXofLjqwXXI2k0Z3l+WQqxwmRYCnA43c4RazY+N6F39
	o42jlxojTAIhU3H5BWcHaOEBbz/cV2ffy/THArd51X0LkF8Krn1cJbKwtOIFN1ZPHFT6kVYaih3
	mkLW7LnE=
X-Gm-Gg: ASbGncv1dj5EuYiTNkk3BSDwNLJkS1soja1U9dIrjQkfvsIrnuEitN4Vwa477CagUYo
	5qDjQXgW8Uu1YF38iw96AAVQmfaHVIF9hBlfGd6ulDftdOXiWHflWhrmRr96jARpF29kUd+InDf
	KS9VdNOUKitUsDC8XTIGbH17t5gAgEEFEzUHSlicsCbWqzULyamrI0y/OBGNC8SCvXTFOpov40I
	kmoILTYG32hdbYNnJ5sM2EJBmPX2bBuygQwExvKpXxfr6YhDnsMuaHi+ldoktIx8L+Y9C5xeptY
	78emhNrr3UhdEAPpNeZCTYglYfQDacfLNm0YvSi4cXTKQy0Hfg==
X-Google-Smtp-Source: AGHT+IFPoOZ7DHExCotaE+9HxKf4rP0cmsuMLpa4XpFjsmFcK+SBuitbW6tTAXGGVyDrRGsbRGDVRg==
X-Received: by 2002:a05:6a20:3d95:b0:21f:419f:80a9 with SMTP id adf61e73a8af0-220b060ec69mr6913020637.10.1751303853806;
        Mon, 30 Jun 2025 10:17:33 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:33 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 06/12] selftests/bpf: Add tests for bucket resume logic in listening sockets
Date: Mon, 30 Jun 2025 10:16:59 -0700
Message-ID: <20250630171709.113813-7-jordan@jrife.io>
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


