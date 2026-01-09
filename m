Return-Path: <netdev+bounces-248539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB67D0AE23
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 16:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B905B30F2B8C
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 15:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA2135E53F;
	Fri,  9 Jan 2026 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOcCxIYH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678B3385AC
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972141; cv=none; b=SXeBIhy5Tu8jecfC3W7yGKnUQ7lPkEklgH8f+P1KfHz6qDbiDT5SUHpBYEaQdzyJ7MR0tZ85iH2w72XbM1k+P6j9iVd7AhG5JK0XArWhnpxoAgZaO5759lyBeh+TCfNCFG1BZJDQZ4XySq1ChDNulH/4OeSdhRIhEi4+m0HL8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972141; c=relaxed/simple;
	bh=/0dRPRjqg3IHIqgYOrn2vyyviwdlxxFzHDkKNcZEB7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hGmm54UCGyDnzkq0knRsSSGReRV4CbLF31QSjD40nkBEsV/kNia3/eQ2aV7tvuld9dXkaIyBH/uV5siK22XTj7SqYPPihTNQ56wdsqoncexen5Kak+E1Zcju2C2zjLST/Tr9fK+RZtsoPoT8bLEJ5u2hsR8cB+ww0+15JPhrW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOcCxIYH; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0d52768ccso31339905ad.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 07:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767972137; x=1768576937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l02srCpqwS/PPVAYoAwmWqO0txf7t8pnFoogY5rh/QA=;
        b=KOcCxIYH7ZfzPZW1EgMeCaHB8qzTB4V8M6dVzLqboXwd/Hov8grmVhhBnWFEZruIAI
         PMH0+w7EJVtTiszm0ibb3c6A+OO7Fbgdc6nvKgbjcB/ADx8G31SitVtH4IoVhgsx4gvb
         sXkIFHmq2xukww/+00iDj7O+MzukW+exdkkWyyC64XiVGnGYNfn3cvvHzInhciOS9u7m
         lSCrsIQ4YHxdDejbHnoGFTEbDhuoPsCCCRQ1KbvSzb+cS9Yc91uEZeq2K22cxB9sA84Y
         4MUtGye4XgcRrX8rQ/8/62/jgNMMSPOVG4ORPFgv9S9137O29rxrOFAkUd3PXIWZlr4r
         9Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767972137; x=1768576937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l02srCpqwS/PPVAYoAwmWqO0txf7t8pnFoogY5rh/QA=;
        b=WLnlHJSH5Usm9rJdj4wx1ee1QyxwrHjfRlvhzli2hCWJ13rojEPfbjwNthCsvbBcQG
         MtyVz7r/b4dZ5eaLpbM8W/ww1d03ohK8dp59emirYKy5zjCiIpn3B11439KOjg5LsRf8
         7yscQZhEekaCwr/w4vFS87RGzyIHQdB/cxXeCtlJg0aAenabJBCopyEskpldA81XQakK
         bQJjuZ0gFFcK01DvJqq22pa2I+YHxyomlqAbHRzvZfVxy2VGmeQAWCbEfqmHG2zmhzBJ
         XuY5iPEApkcc/l4aLGT/xx8WzFbWJ/gKzGxp+6YkyOR0aMsW+W7YFsShDeVBG9B6Rslu
         5AqQ==
X-Gm-Message-State: AOJu0YwIZh7yHzCKbyd5Lkhqoa4HibxL/UThL+PX0B9+7bh2WL1phwhk
	gi6z7tqtogbTo4SrOabtOm8pDU3bJst4dvN7WCbE+h4wHivMIIYf6EYRwR4bwyl0
X-Gm-Gg: AY/fxX60VmRF9i7x+a0zU47JXmDmGY14VMo6c9yZrzvdr/DcNi6IG487EXlNrncBbw1
	uIBJV1caIvtoUPTOUpaklEGIYnmdz88z52Osv40lsIF4dCzsOxElyEQqMlfivVXzAvrS6c9K5RR
	zQgASaKMdVd1Xck3DEKaeGzaiHxa7f60TMhjGEsvJfBEx5GojiYgbf58BWRRcdY0weUiJ0pJSWr
	Qb8IdhUKMrYUYvJyZvscfgTram/8n8leIr1oz8/Ru4DEBKD8KyvrvhMmS4gmDl7jSrpAXVP7J+6
	mMyYw1aZsL5X4PZYTjTus2ryWv0RuBAcnmgJyQC0AWX7e1wIpXaSmzyU2+6zaaxUb/hrxcyDkE0
	uGR8xf1399QsUXV78C+090IpGNcuwkRTZ048MWa4Va8Z4mKFhshBjf8gQ+BA2az8L1kfRvF6me+
	KLYmp7xR/W/CVBK4EpXQHjh2Ecn83PbAlOIz/uUmjC
X-Google-Smtp-Source: AGHT+IFjwhs5i9G743dkgLzBhWBTZ55yy5yc6JsaoH2/JUYyPH+SQo8zbecqIuA/7HClY6kISME1yw==
X-Received: by 2002:a17:903:478d:b0:2a0:b438:fc15 with SMTP id d9443c01a7336-2a3ee468407mr97193875ad.11.1767972136629;
        Fri, 09 Jan 2026 07:22:16 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc87f8sm108021895ad.77.2026.01.09.07.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 07:22:16 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH RESEND net-next] selftests/net/ipsec: Fix variable size type not at the end of struct
Date: Fri,  9 Jan 2026 20:52:01 +0530
Message-ID: <20260109152201.15668-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "struct alg" object contains a union of 3 xfrm structures:

	union {
		struct xfrm_algo;
		struct xfrm_algo_aead;
		struct xfrm_algo_auth;
	}

All of them end with a flexible array member used to store key material,
but the flexible array appears at *different offsets* in each struct.
bcz of this, union itself is of variable-sized & Placing it above
char buf[...] triggers:

ipsec.c:835:5: warning: field 'u' with variable sized type 'union
(unnamed union at ipsec.c:831:3)' not at the end of a struct or class
is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
  835 |                 } u;
      |                   ^

one fix is to use "TRAILING_OVERLAP()" which works with one flexible
array member only.

But In "struct alg" flexible array member exists in all union members,
but not at the same offset, so TRAILING_OVERLAP cannot be applied.

so the fix is to explicitly overlay the key buffer at the correct offset
for the largest union member (xfrm_algo_auth). This ensures that the
flexible-array region and the fixed buffer line up.

No functional change.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
CCed Gustavo and linux-hardening as suggested by Simon.

Previous patch: https://lore.kernel.org/all/aSiXmp4mh7M3RaRv@horms.kernel.org/t/#u
---
 tools/testing/selftests/net/ipsec.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 0ccf484b1d9d..f4afef51b930 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -43,6 +43,10 @@

 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))

+#ifndef offsetof
+#define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
+#endif
+
 #define IPV4_STR_SZ	16	/* xxx.xxx.xxx.xxx is longest + \0 */
 #define MAX_PAYLOAD	2048
 #define XFRM_ALGO_KEY_BUF_SIZE	512
@@ -827,13 +831,16 @@ static int xfrm_fill_key(char *name, char *buf,
 static int xfrm_state_pack_algo(struct nlmsghdr *nh, size_t req_sz,
 		struct xfrm_desc *desc)
 {
-	struct {
+	union {
 		union {
 			struct xfrm_algo	alg;
 			struct xfrm_algo_aead	aead;
 			struct xfrm_algo_auth	auth;
 		} u;
-		char buf[XFRM_ALGO_KEY_BUF_SIZE];
+		struct {
+			unsigned char __offset_to_FAM[offsetof(struct xfrm_algo_auth, alg_key)];
+			char buf[XFRM_ALGO_KEY_BUF_SIZE];
+		};
 	} alg = {};
 	size_t alen, elen, clen, aelen;
 	unsigned short type;
--
2.52.0


