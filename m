Return-Path: <netdev+bounces-223720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EC0B5A3E1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21F2487CA2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377172F9D99;
	Tue, 16 Sep 2025 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qp7asGzo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9CB2E7BC0
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057866; cv=none; b=Prbg8Dqbn1n3GiowCXuDcxHSbgUYgqQQHEOPzY23m2AjEYN0he9keVDf/lp0fydIAQB0j11K0icWUo/mPGtbWqJMJX07SwNe+ND4R3dTvRf1Ic4dZ5Iysgv2LumaqPgXGSzOsgbTVI46LMz28Qj9ymazM8RLdNfGxXvKRnDj9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057866; c=relaxed/simple;
	bh=LP6ZRagWBdxeVw+YfiHmPptwNySx5umrCTuT1IbM2xE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=COEvzustgp5z1cIwd0JgSJnq6SwtD/1xcMXl+S1dlaIfYh3AK9Xk3ZKJ0KYph0TulmanJm3VaHgNc5NQ+wTdAazr3lju9SWEH0B7qtXxPXcUBEw4wvD8YA+Nk2x+XDgSkkb3L6vUg0LP/O15UrqvQfojpcycy6Ytodct/VdHyhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qp7asGzo; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BC149454B7;
	Tue, 16 Sep 2025 21:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758057857;
	bh=q5nT8jhqPHVE6bhlgcmllcv0Y1IYbvYUTgMHrWJCXbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=qp7asGzoECnnJnujBn0fM3sEnGSHt5cIK54rJNx9aBwWAh6fn71payrPP7SpzVqaM
	 3u+HopVZ/GpFTAKSXehxCSa/I+qF1y0ML2Z/qqXXbJuQ96a9XiIDgVrEt/7xk6WK+c
	 A/MAw5jaMNc4+ZxGujWrYUptS1rWSn0oWyiGzcJ2WAoFLYA9MoXaB9981GGvOmkJvX
	 qXpfRX1Eshmjcd2feHvDgc63R2MLY7DNkR06eX1PtmfpuUOzCn8MRmf0uuPGDhmtrR
	 LRys5d9E+bncJme7qDb01mYoT288yB7MTSWCFz7yIJnGnSiHXGNFTnudJJgQxU8Ckj
	 DFlvphuqy4R5w==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH v2 1/4 iproute2-next] lib: Update backend of print_size to accept 64 bit size
Date: Tue, 16 Sep 2025 14:24:00 -0700
Message-Id: <20250916212403.3429851-2-jay.vosburgh@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916212403.3429851-1-jay.vosburgh@canonical.com>
References: <20250916212403.3429851-1-jay.vosburgh@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	In preparation for accepting 64 bit burst sizes, modify
sprint_size, the formatting function behind print_size, to accept __u64 as
its size parameter.  Also include a "Gb" size category.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
---

v2: add Jamal's ack

 include/json_print.h  |  4 ++--
 lib/json_print_math.c | 11 +++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/json_print.h b/include/json_print.h
index daebcf5d25f5..59edd5b2467e 100644
--- a/include/json_print.h
+++ b/include/json_print.h
@@ -68,7 +68,7 @@ _PRINT_FUNC(on_off, bool)
 _PRINT_FUNC(null, const char*)
 _PRINT_FUNC(string, const char*)
 _PRINT_FUNC(uint, unsigned int)
-_PRINT_FUNC(size, __u32)
+_PRINT_FUNC(size, __u64)
 _PRINT_FUNC(u64, uint64_t)
 _PRINT_FUNC(hhu, unsigned char)
 _PRINT_FUNC(hu, unsigned short)
@@ -109,6 +109,6 @@ static inline int print_bool_opt(enum output_type type,
 }
 
 /* A backdoor to the size formatter. Please use print_size() instead. */
-char *sprint_size(__u32 sz, char *buf);
+char *sprint_size(__u64 sz, char *buf);
 
 #endif /* _JSON_PRINT_H_ */
diff --git a/lib/json_print_math.c b/lib/json_print_math.c
index f4d504995924..3e951cd9f504 100644
--- a/lib/json_print_math.c
+++ b/lib/json_print_math.c
@@ -7,25 +7,28 @@
 #include "utils.h"
 #include "json_print.h"
 
-char *sprint_size(__u32 sz, char *buf)
+char *sprint_size(__u64 sz, char *buf)
 {
 	long kilo = 1024;
 	long mega = kilo * kilo;
+	long giga = mega * kilo;
 	size_t len = SPRINT_BSIZE - 1;
 	double tmp = sz;
 
-	if (sz >= mega && fabs(mega * rint(tmp / mega) - sz) < 1024)
+	if (sz >= giga && fabs(giga * rint(tmp / giga) - sz) < 1024)
+		snprintf(buf, len, "%gGb", rint(tmp / giga));
+	else if (sz >= mega && fabs(mega * rint(tmp / mega) - sz) < 1024)
 		snprintf(buf, len, "%gMb", rint(tmp / mega));
 	else if (sz >= kilo && fabs(kilo * rint(tmp / kilo) - sz) < 16)
 		snprintf(buf, len, "%gKb", rint(tmp / kilo));
 	else
-		snprintf(buf, len, "%ub", sz);
+		snprintf(buf, len, "%llub", sz);
 
 	return buf;
 }
 
 int print_color_size(enum output_type type, enum color_attr color,
-		     const char *key, const char *fmt, __u32 sz)
+		     const char *key, const char *fmt, __u64 sz)
 {
 	SPRINT_BUF(buf);
 
-- 
2.25.1


