Return-Path: <netdev+bounces-253023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MrL/C/dVdGnj4gAAu9opvQ
	(envelope-from <netdev+bounces-253023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:17:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 733FB7C89C
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1872E30063A7
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 05:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E181DF248;
	Sat, 24 Jan 2026 05:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJzw0A0/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC43EBF0F
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769231860; cv=none; b=MGOeCT88fA5O85hAZz8Uzegk3YowvVwjulGKIQCj2gB61FoV5YDhphbvz2W2GmubVOaLEnrx08p91Wp8228Ev5TrbPzlL8enV6+y09mdnTb1/qwj1XVsdhHk/w12HNEwQEHQSowUk3LPMbkS+cTdi8pw4vqVgoAKx8w9r6PJ3MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769231860; c=relaxed/simple;
	bh=iAnprdhO3uDJcSm3zWKRSisBMN6wtlRXW/1FQidOFbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SDmmiqy3fOmwYk2lttodeRogmin2GGgsYxcpk8yYCIqs6P5ZHHC1Sdr+VzwA+ffwUnGUDUhhcppXJOdL9dpOAW2W2R9blf4lLkJuQk7Rrzt0i0IVscd1CSCAojnq/lU783Py12nMe63qh8ePrJRjLmNinXUFR0SN2AybHjqc694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJzw0A0/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so2428607a91.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 21:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769231858; x=1769836658; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqASAUm/GFCdALxLtn9qqyibLFPtenKBFroaARUvxic=;
        b=UJzw0A0/QF3qnOZrM83IGh/GcTuu2slFA7+TJhTEQ5azYWYtayo8+evcZkbHgV6+oJ
         aa5ou+q/XcTKOYEcswaU4R9IIixAghfk7+5yjzdo+ruiNxeJXIFUHzguZ4nG0vufb00t
         g5z0shEXl5fObCSo1lbMOtw6Jk+mQX82wkq/gzWeukvDnylEzW0C5uAP89XH0LcNzpCW
         hmS+SNemPkoD8hRRAPNRlf4ZgFhFcL88vq41YBliD6/7caiRTa8a0loDKDfo7GFBtRty
         kK0luu1nLvgM1XLfRASV/iwadvw0SCeGFAgViNW/6+pU3XM3++WEsm59CD2nWT4nOYFf
         m4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769231858; x=1769836658;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqASAUm/GFCdALxLtn9qqyibLFPtenKBFroaARUvxic=;
        b=EgQvaSiXS7I9FSINTfkKEwbCc+8pb+fvAfYiJQOasAIUw2CygEHFn5RZ4XCMk8xi4O
         vUf8aJTW34qlkT7I4HHx3wBLt8I42ElCW2w9oN2lVfj7QU39p/9RY34XPpHp2Ehiet+s
         N2eEk1g+FujsJrbkWjTqGz+7ccWQX6OjRYDsL0m2vdS70vM3vRaK7U1ZFqDkSy7Pjp43
         fpzAjN6VTbXIs68OOcu10SsSZahFcIdd9YV0C8kr6NSj+PBBNqWan8uGM5yOdeSp2nJr
         nnpwpHtPB8vSwzN0LDq08FKkn+tuC4oZMed2i6QoRm33nuo7CgxaAQtoWrGcM3Hsa36d
         C5tA==
X-Forwarded-Encrypted: i=1; AJvYcCV74b3wMSZuVOxd/CbMg2mzOV/v4GeD7nNVYlqL+eIsO1m/6JuPtQbo02dbF+/JkvDlKkFWntE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tQ5gBwpetAmoc4kbNb8Z53yuYsFgAtVLTwrX9YVFKKmvJxkV
	5T0cDv8zuqWICdxR2o/5jVbPHBeWRxfFgYSNlb8cZ89E8pw1Td/SMiXg
X-Gm-Gg: AZuq6aIlMFkZjk+H2o8flAbJXq8m9xnOSh5byuSKVB0kF78lh9Zu2JB90vwK0HpOtiO
	xd5IHK/8yeWqX1yZoxSVxZqzxaTGTLFCy59ibOHekjnpDXRwOEwBbYYVQ3jY/KQF4f8R0a+IO1i
	lh/8bcnjiajDcSJqG/OV88rBXGaJ0h5DBZSS7B+b4Z6ru8W6BYxUEVdoZHo+y6wicdxvIRQxboU
	8jA1R4I+0nXMSU7R5cwNqC7bZNcDMrXQaN1PIIxMT7V/O2kKUHaVZCe8IymcFF/WtOs5RYN8LHQ
	AjdPZsY8biJK4QKdiu0rtEyTCEPYTZlN+wZUCqpd1k5Lk3LgBhJ+0qfx34YqM7I05fs2w+K24Jt
	+UGKzapoJYMvfqNF0vJNY0octU1QgLYq+oXSFxy1Nq0MVcslHzYep/H3O7ReWt/vIfRcVnGjUYY
	bKXQDJ+lZIlf4PysXzEeE=
X-Received: by 2002:a17:90b:35c9:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-3536700c87bmr4676569a91.6.1769231858082;
        Fri, 23 Jan 2026 21:17:38 -0800 (PST)
Received: from [172.16.80.107] ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354cdd03sm6464750a91.15.2026.01.23.21.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 21:17:37 -0800 (PST)
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Sat, 24 Jan 2026 14:17:19 +0900
Subject: [PATCH] SUNRPC: Replace KUnit tests for memcmp() with
 KUNIT_EXPECT_MEMEQ_MSG()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260124-fix-gcc_krb5-memcmp-v1-1-4648cbbdc78b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAArxL73YJK2eMqEVG21RKaKEQg3T3pc
 2BmEkQKTBH6IkGgmyNfLoMsCzDH7HZCXjODEkoLqSrc+MHdmOkMS42WrLEelax12zWkF5KQSx8
 oa/91GN/3A6+sajtlAAAA
X-Change-ID: 20260124-fix-gcc_krb5-memcmp-2156897e6be1
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ryota Sakamoto <sakamo.ryota@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253023-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sakamoryota@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 733FB7C89C
X-Rspamd-Action: no action

Replace KUnit tests for memcmp() with KUNIT_EXPECT_MEMEQ_MSG() to improve
debugging that prints the hex dump of the buffers when the assertion fails,
whereas memcmp() only returns an integer difference.

Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
---
 net/sunrpc/auth_gss/gss_krb5_test.c | 93 ++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index a5bff02cd7ba48c75a6d270b6584c0f23cb71380..dde1ee934d0d448fe558a633e3d729c490ea26ae 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -63,10 +63,11 @@ static void kdf_case(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, err, 0);
 
 	/* Assert */
-	KUNIT_EXPECT_EQ_MSG(test,
-			    memcmp(param->expected_result->data,
-				   derivedkey.data, derivedkey.len), 0,
-			    "key mismatch");
+	KUNIT_EXPECT_MEMEQ_MSG(test,
+			       param->expected_result->data,
+			       derivedkey.data,
+			       derivedkey.len,
+			       "key mismatch");
 }
 
 static void checksum_case(struct kunit *test)
@@ -111,10 +112,11 @@ static void checksum_case(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, err, 0);
 
 	/* Assert */
-	KUNIT_EXPECT_EQ_MSG(test,
-			    memcmp(param->expected_result->data,
-				   checksum.data, checksum.len), 0,
-			    "checksum mismatch");
+	KUNIT_EXPECT_MEMEQ_MSG(test,
+			       param->expected_result->data,
+			       checksum.data,
+			       checksum.len,
+			       "checksum mismatch");
 
 	crypto_free_ahash(tfm);
 }
@@ -314,10 +316,11 @@ static void rfc3961_nfold_case(struct kunit *test)
 		   param->expected_result->len * 8, result);
 
 	/* Assert */
-	KUNIT_EXPECT_EQ_MSG(test,
-			    memcmp(param->expected_result->data,
-				   result, param->expected_result->len), 0,
-			    "result mismatch");
+	KUNIT_EXPECT_MEMEQ_MSG(test,
+			       param->expected_result->data,
+			       result,
+			       param->expected_result->len,
+			       "result mismatch");
 }
 
 static struct kunit_case rfc3961_test_cases[] = {
@@ -569,14 +572,16 @@ static void rfc3962_encrypt_case(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test,
 			    param->expected_result->len, buf.len,
 			    "ciphertext length mismatch");
-	KUNIT_EXPECT_EQ_MSG(test,
-			    memcmp(param->expected_result->data,
-				   text, param->expected_result->len), 0,
-			    "ciphertext mismatch");
-	KUNIT_EXPECT_EQ_MSG(test,
-			    memcmp(param->next_iv->data, iv,
-				   param->next_iv->len), 0,
-			    "IV mismatch");
+	KUNIT_EXPECT_MEMEQ_MSG(test,
+			       param->expected_result->data,
+			       text,
+			       param->expected_result->len,
+			       "ciphertext mismatch");
+	KUNIT_EXPECT_MEMEQ_MSG(test,
+			       param->next_iv->data,
+			       iv,
+			       param->next_iv->len,
+			       "IV mismatch");
 
 	crypto_free_sync_skcipher(cts_tfm);
 	crypto_free_sync_skcipher(cbc_tfm);
@@ -1194,15 +1199,17 @@ static void rfc6803_encrypt_case(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test, param->expected_result->len,
 			    buf.len + checksum.len,
 			    "ciphertext length mismatch");
-	KUNIT_EXPECT_EQ_MSG(test,
-			    memcmp(param->expected_result->data,
-				   buf.head[0].iov_base, buf.len), 0,
-			    "encrypted result mismatch");
-	KUNIT_EXPECT_EQ_MSG(test,
-			    memcmp(param->expected_result->data +
-				   (param->expected_result->len - checksum.len),
-				   checksum.data, checksum.len), 0,
-			    "HMAC mismatch");
+	KUNIT_EXPECT_MEMEQ_MSG(test,
+			       param->expected_result->data,
+			       buf.head[0].iov_base,
+			       buf.len,
+			       "encrypted result mismatch");
+	KUNIT_EXPECT_MEMEQ_MSG(test,
+			       param->expected_result->data +
+					(param->expected_result->len - checksum.len),
+			       checksum.data,
+			       checksum.len,
+			       "HMAC mismatch");
 
 	crypto_free_ahash(ahash_tfm);
 	crypto_free_sync_skcipher(cts_tfm);
@@ -1687,15 +1694,16 @@ static void rfc8009_encrypt_case(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test,
 			    param->expected_result->len, buf.len,
 			    "ciphertext length mismatch");
-	KUNIT_EXPECT_EQ_MSG(test,
-			    memcmp(param->expected_result->data,
-				   buf.head[0].iov_base,
-				   param->expected_result->len), 0,
-			    "ciphertext mismatch");
-	KUNIT_EXPECT_EQ_MSG(test, memcmp(param->expected_hmac->data,
-					 checksum.data,
-					 checksum.len), 0,
-			    "HMAC mismatch");
+	KUNIT_EXPECT_MEMEQ_MSG(test,
+			       param->expected_result->data,
+			       buf.head[0].iov_base,
+			       param->expected_result->len,
+			       "ciphertext mismatch");
+	KUNIT_EXPECT_MEMEQ_MSG(test,
+			       param->expected_hmac->data,
+			       checksum.data,
+			       checksum.len,
+			       "HMAC mismatch");
 
 	crypto_free_ahash(ahash_tfm);
 	crypto_free_sync_skcipher(cts_tfm);
@@ -1826,10 +1834,11 @@ static void encrypt_selftest_case(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test,
 			    param->plaintext->len, buf.len,
 			    "length mismatch");
-	KUNIT_EXPECT_EQ_MSG(test,
-			    memcmp(param->plaintext->data,
-				   buf.head[0].iov_base, buf.len), 0,
-			    "plaintext mismatch");
+	KUNIT_EXPECT_MEMEQ_MSG(test,
+			       param->plaintext->data,
+			       buf.head[0].iov_base,
+			       buf.len,
+			       "plaintext mismatch");
 
 	crypto_free_sync_skcipher(cts_tfm);
 	crypto_free_sync_skcipher(cbc_tfm);

---
base-commit: 62085877ae6592be830c2267e35dc469cb706308
change-id: 20260124-fix-gcc_krb5-memcmp-2156897e6be1

Best regards,
-- 
Ryota Sakamoto <sakamo.ryota@gmail.com>


