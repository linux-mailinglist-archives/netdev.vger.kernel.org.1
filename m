Return-Path: <netdev+bounces-223753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B95B5A460
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AC4485EEA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D60323F5A;
	Tue, 16 Sep 2025 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="beZKcd1O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA561289378
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059871; cv=none; b=dz78+FIMJibavKFKH3OL+IL//iKyVHlPxlf5LQpUUOHYRZuszwjlhrWFcTdx1Wrq5fVnBsBIRjhIN/kmkN+2LP3raPdoCjlKh01AtNNKWCsMGZr5+ptazUIzxaNOHbqHhuuFKJIm5lmzGXi2zdE/F4R9001eAJ40kFVCzLWUzHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059871; c=relaxed/simple;
	bh=cCd8x/0vomlvYfiYx2zA38OY4Jo2Ak0LNGyjNgCVPcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rjt3o+teRQumaFfaKdVrUH7GADIWEeWBZCiurV4C1/OWJuQz81yKVqlBTOrOnY2S86UZQaTU7ai1am4+8xzs1kFGDErBL+1bCoOCmx9lfXsrzc0jupxo+yPxrHop8qzaSLayey4nbTUIFMkjL1XmIG1scwdqxs+XubSLqt1dqB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=beZKcd1O; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 74536454B7;
	Tue, 16 Sep 2025 21:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758059867;
	bh=u9n+DQm/8tOOpo1syPkC5+tK1k6OAkL28ih37IY9bkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=beZKcd1OAFsks1wQfHobgLH/wkHP1Pi4voyPchRpzRLNemUO6qkOCpIDQmM2NvyDJ
	 B2e5h7o/mIbWpwOTCiJ0MEgp0k0wdhiEBYuJf2/ywwO/5n2Roipsv4inpocyTD/972
	 /wV7QLvj9ReL+5ZE04SLL9xIghGO5VQZoUgF9w2KtE9UV0qwN8571qr/kxSe60CzCI
	 a26Ow8w9K3ZEa6pWPfqAv2swNOJl1SmUAK3Cy6IvdXKg0v4eECpQyH4WF9OnQpZxVL
	 LDC5S1OBbyxVo7wsxhh/lMQ5BoUG4KmcwLl9Jqw4qhuuf/OY8R91c7lvwaQEK/+pnf
	 O5HVOZwbd577A==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH v3 1/4 iproute2-next] lib: Update backend of print_size to accept 64 bit size
Date: Tue, 16 Sep 2025 14:57:28 -0700
Message-Id: <20250916215731.3431465-2-jay.vosburgh@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916215731.3431465-1-jay.vosburgh@canonical.com>
References: <20250916215731.3431465-1-jay.vosburgh@canonical.com>
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
v3: no changes

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


