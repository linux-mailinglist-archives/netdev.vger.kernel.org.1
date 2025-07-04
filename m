Return-Path: <netdev+bounces-204150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF1AF9330
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A1B586349
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 12:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB202F2C51;
	Fri,  4 Jul 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Nn6noK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F4A2DCC0B;
	Fri,  4 Jul 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633565; cv=none; b=aF5TS+enX77IK+ekFKK3fgezv8c/WiRLIFfpBPOD5VhtVx3oBWB06m5GWer+n1waWCqJxa+YjXv2GOxqq2H1fSislc+g4JVOxYmNVvJDcmebCPGHD7FM4iCe+BH/s1fuBOqQ3mBVeCcaRRuuUHrb3j0/NsbkygiEPpyY1ZYSphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633565; c=relaxed/simple;
	bh=BwTgwJk/w8OAPNSSBh0rejGdOj5T1w6oM4l2gfNoNtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei7aVYS5V/mf8oi9dOkAPNUAghecHO5dOC9VxILVIrytb1Q5wO2oZp6XuXM4HrUmZioQUwGSAUyZSzhww6xkCDcQBfZg+BreSHt6GgsAL8SguGu5F1g4zCQe+9oTuqQKhjxy0YLcuYpaTvwOlUDADVLq/mj1/N/fDT0L5PYxgZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8Nn6noK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0d7b32322so134538066b.2;
        Fri, 04 Jul 2025 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751633561; x=1752238361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnUGHcVjr5smGuX+/BCmZq9MD0bG5HhFaqkQCVpK0PM=;
        b=f8Nn6noK1ndSOJG66IhuM4BcONtEcd3USBAebkLqfKCPUMwDzpjFG/XZlAQTMrkyZX
         5Cr0rGr6nzkLWkdOPMKXufhAqA+8er2sO63iw4UIXZKkA3sYXJj316Xt0iez6KGYH502
         elQtkS4SU+UhYko6loNwrdpusasrA+5TeqjL26OjkjgnzaOjD2TOyrgsoI6GJdULf4g+
         g/2ODjF7r14//Ji3S18wxyID+6tx2H7646VvhRnxeA1eSBeSaKGvALOC4+Yqh3Y0Mm4F
         GKPsURieHf3PO33RWkz7jh+AP4I5O0S9ceFgnprp1l96sEmHLMBertV71IGHZ2kufS+O
         mumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751633561; x=1752238361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnUGHcVjr5smGuX+/BCmZq9MD0bG5HhFaqkQCVpK0PM=;
        b=sasb4z+qTI5VZ+qVGtYo+FXlG4tPkg+aPy9Y+uzS7sFtjHsLBURWWojtu1GdG7XO6V
         mwo/ZY58A62GEkXjJe6Whl+heqNityR9GZxLSAUMgEY9OAB167XSIoXaoZJK0/YaFwci
         IuSPXL6ecq269OoJNX0VsiUlxAxr7gReM8E5q4Lvo7i4Mchaw46GD8lWIrPYulnijpo2
         paTUQupisYLLYjWWu+Wqcna7/zqwTvH211v2U7rZA9+ZvShg7r+7Q/PX5ilLEBmUsSry
         72nwE21Av09pkLw+olvstFnhSN7ZhHtif+f3OkfnS2JeiGWgjVoYm1lrL3gp8K+yTfId
         hKjA==
X-Forwarded-Encrypted: i=1; AJvYcCWaaIeN2Iwm6nMyxhElWOIp3zShLLn731NEa0PnJvFMxdGuq3nVBxk4nJJZSuqWNCVAQzCXa0UsAekQmtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ziUqobUk/xv8VW8XtE49AotqNVLApPnihG+4BH4SLnj9mHjL
	LU6IEEK/XgYTA4+hQlBK358BJdJEnXd+T1WD0UQdLvX6MXGUYiZXa10r9K6gO9OZlbPdmg==
X-Gm-Gg: ASbGncsKho3sCExvurRyZpOmr2eDEjuX1Nh6GH3zzGN3PF/eVJCslxUgkDg5hvwTraQ
	CEAnM7B9OpZ1v++MpB3rWr5nKq56s62SAltvTR1iOVNobCLoC8jQeGdafopwPANLlTTFzPiP4t6
	RdJxVYIViHW2wDk9WXTLEoezbgodEllqnAJpj+l4U1WqCAuUen6OCsHDE8nhs7C6XGhvefvQym3
	yUw1gogJ73pQuibX0+Sow6/ZquST2uSxUF+0/BcHWthEnMk7AIydcH4UVrpeS5pmnn5MK6O/N5D
	JaYZeIMrEVPXkr4tmpzNfBTNxRQ+JpRkoZj2m+Oc6C3cZ+xecjf0wEAjBFpBuhcETzctZmNjcJA
	8G5q5WJmRzfo7ZZDdD1Ju5hqyu3+HZrTdtM5svg5mUrUZspNyBmsn027xmHu9fmBMFNDPKtgm
X-Google-Smtp-Source: AGHT+IHB/nMRA5QMRBk3Z7LZlJ4emSose3IiIfC2mrO73e+K+x6AcNa2oelYFny+wME2ZmoYMFWyiw==
X-Received: by 2002:a17:907:bd8e:b0:ae0:d011:c185 with SMTP id a640c23a62f3a-ae3fe4851aamr186829466b.18.1751633561157;
        Fri, 04 Jul 2025 05:52:41 -0700 (PDT)
Received: from legolas.fritz.box (p200300d0af416e00eb84418c678abf7e.dip0.t-ipconnect.de. [2003:d0:af41:6e00:eb84:418c:678a:bf7e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b64f5asm166346066b.162.2025.07.04.05.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 05:52:40 -0700 (PDT)
From: Markus Theil <theil.markus@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	akpm@linux-foundation.org,
	Jason@zx2c4.com,
	Markus Theil <theil.markus@gmail.com>
Subject: [PATCH v2 4/4] test_hash.c: replace custom PRNG by prandom
Date: Fri,  4 Jul 2025 14:52:33 +0200
Message-ID: <20250704125233.2653779-5-theil.markus@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704125233.2653779-1-theil.markus@gmail.com>
References: <20250704125233.2653779-1-theil.markus@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use default PRNG, as there is no real need
for a custom solution here.

We know the sequence provided by our seed
and do not need to do bit magic in order
to obtain a non-zero byte. Just iterate a
small number of times, if needed.

Signed-off-by: Markus Theil <theil.markus@gmail.com>
---
 lib/tests/test_hash.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/lib/tests/test_hash.c b/lib/tests/test_hash.c
index a7af39662a0a..308446ea3431 100644
--- a/lib/tests/test_hash.c
+++ b/lib/tests/test_hash.c
@@ -17,39 +17,21 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/module.h>
+#include <linux/prandom.h>
 #include <linux/hash.h>
 #include <linux/stringhash.h>
 #include <kunit/test.h>
 
-/* 32-bit XORSHIFT generator.  Seed must not be zero. */
-static u32 __attribute_const__
-xorshift(u32 seed)
-{
-	seed ^= seed << 13;
-	seed ^= seed >> 17;
-	seed ^= seed << 5;
-	return seed;
-}
-
-/* Given a non-zero x, returns a non-zero byte. */
-static u8 __attribute_const__
-mod255(u32 x)
-{
-	x = (x & 0xffff) + (x >> 16);	/* 1 <= x <= 0x1fffe */
-	x = (x & 0xff) + (x >> 8);	/* 1 <= x <= 0x2fd */
-	x = (x & 0xff) + (x >> 8);	/* 1 <= x <= 0x100 */
-	x = (x & 0xff) + (x >> 8);	/* 1 <= x <= 0xff */
-	return x;
-}
-
 /* Fill the buffer with non-zero bytes. */
-static void fill_buf(char *buf, size_t len, u32 seed)
+static void fill_buf(char *buf, size_t len, struct rnd_state *prng)
 {
 	size_t i;
 
 	for (i = 0; i < len; i++) {
-		seed = xorshift(seed);
-		buf[i] = mod255(seed);
+		/* we know our seeds, no need to worry about endless runtime */
+		do {
+			buf[i] = (u8) prandom_u32_state(prng);
+		} while (!buf[i]);
 	}
 }
 
@@ -143,11 +125,13 @@ test_int_hash(struct kunit *test, unsigned long long h64, u32 hash_or[2][33])
 
 static void test_string_or(struct kunit *test)
 {
-	char buf[SIZE+1];
+	struct rnd_state prng;
 	u32 string_or = 0;
+	char buf[SIZE+1];
 	int i, j;
 
-	fill_buf(buf, SIZE, 1);
+	prandom_seed_state(&prng, 0x1);
+	fill_buf(buf, SIZE, &prng);
 
 	/* Test every possible non-empty substring in the buffer. */
 	for (j = SIZE; j > 0; --j) {
@@ -171,9 +155,11 @@ static void test_hash_or(struct kunit *test)
 	char buf[SIZE+1];
 	u32 hash_or[2][33] = { { 0, } };
 	unsigned long long h64 = 0;
+	struct rnd_state prng;
 	int i, j;
 
-	fill_buf(buf, SIZE, 1);
+	prandom_seed_state(&prng, 0x1);
+	fill_buf(buf, SIZE, &prng);
 
 	/* Test every possible non-empty substring in the buffer. */
 	for (j = SIZE; j > 0; --j) {
-- 
2.49.0


