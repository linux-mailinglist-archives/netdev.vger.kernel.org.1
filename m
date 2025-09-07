Return-Path: <netdev+bounces-220656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC2CB478A1
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52BF3B82BD
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4B7194A65;
	Sun,  7 Sep 2025 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tzRW60Lz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDF7081E
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757209808; cv=none; b=KtskfPOZ0+Uv2fFkIc1gIupenoostxsdy5HecFLy1IOVsRy7pw9D5kyu+2a6YoWQyhEat1Xv0yU+r6mxjUtYaQdFn3w8yFAEbRNNcRtwTNfosSabYBnQwrVvTaNWNkizn7Kn9czTnOxQoYlxaSk4HWgFXPg46NNmh6QUbV/1WRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757209808; c=relaxed/simple;
	bh=gWCfXCYiEg2TDV9nKN8YjmgdZN5mApOcBplo/gxWROw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXj4b+Ev7rUK+PjY88NVw3x9lXH9sdonzdTWSIplmmUlyFGkjeMKTVf5otqfyXu2ZJMKLh+0HETRlDwxK6oxBIz7saOGRvNpfE1zk6kYiEM53/hgqlWfRRcaJRVbSvagiB+LF0jjSnwDmt/5xWh30Sz1Wz63sCocHcs+pqt/cMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tzRW60Lz; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D5B7C43F24;
	Sun,  7 Sep 2025 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757209348;
	bh=xL5v0AAPfk7u/SIoZ0TFLsQl2HWNv9ulxf7OBh4HSDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=tzRW60LzUAaRxXmQGwpmDvxgHu5ZNKpS1Nn0fdL+XPyRvyvBtgfT045Pgbr7hsuXJ
	 CKz4pAF0VOgyxYEHF/TGQ5VnFtybXmjXCyKHoGb2/aRIosGZCXVeGUBrEbtTCSC7td
	 U/+ZPP3bThvgdqgFSJBQcfnF+kN6NeygvxAj/IKGemUVI3Q6qS79R9lpSJq/OXp8lZ
	 gphkebvrK4K69Lf9eRaHov2wybp4FGMcz5Txst9AUFSp26RGxWlQ6MfVZeI144uSRr
	 JNiWVn3sO+uzkB72rOaXUocbj3J9OSovg6U8Z4YRv0Z8Kd6uswjlEuvsQI6WQhDidZ
	 wwsiO6Ugbqi4w==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH 1/4 iproute2-next] lib: Update backend of print_size to accept 64 bit size
Date: Sat,  6 Sep 2025 18:42:13 -0700
Message-Id: <20250907014216.2691844-2-jay.vosburgh@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
References: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
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

Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
---
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


