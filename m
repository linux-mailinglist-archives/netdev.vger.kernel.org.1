Return-Path: <netdev+bounces-241779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C2FC882E2
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE78E3534EA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5073530ACF0;
	Wed, 26 Nov 2025 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgz0TpeK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B3217736
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764136049; cv=none; b=iuP5FyEmYj7JmR6znPHmpzZGuLVYKoCe1jkjL1zEepXVg1Va0f9560EZe6Og4nA71kowR+3NxsK5OLEfqt0IBptLW62InJFPtCY05xCjKKubQPG/ozVm63KouhzGXU+7ASRLQj0RZwb5nWnArV5tj/T1fEe8kL/hQDZNJ02g1rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764136049; c=relaxed/simple;
	bh=SX4gdnaKbrrM/98jsYyscC7GPKCA8qiYmGpiNZ6mimU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnWkGRcBHImXuc+lMK5m2ar3wyfe+AjJQ8ZVRwQnoX5JTsaWAtKs5XbC9kaXQlw8BqRoi6K2GxkV475YdeJUYk9kXi+Qeimv3RwW6wqEskJrP5Fo0ZNL2Tpa0e+G5BufAj5eNy0xWYoQEzRF46fvse8hjpFWPFOZM97OmcBl/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lgz0TpeK; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29845b06dd2so78244585ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 21:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764136047; x=1764740847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oYN7Mj32IOmlBJhYBCg5Nac20JOashG6O7HeX4jvMpQ=;
        b=Lgz0TpeK9lbozgg3aF3W5/9ovOF69hKLGpl7q4XKRxBngJvz+KFMTB/PUmDoWQOEzn
         hGAp/ZXVJa+L2vke7NfOuNwXyaLj77u6LS9s4/HTjr8OCP8CMtFNKWXZMEOu/v8C0hRY
         7f09xjYhGVUb76WLP0tVlps/bj9npjvEkQvOF5KJvCjVxLcMOSFA5QzcyKNqfS0EmqYT
         MNcS5566NX104p5Cu6ynHC6sim37bp+nPiVi/wBJU+KI2AA5gl0jeQ06gqmni8sBkXYQ
         kj5Hd+rD+PHnKkGRNaYSP1Ad9ARwnLiKKuReMIG36q6mmu2X+XbYpaNpG2cWB0HRzfej
         VPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764136047; x=1764740847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYN7Mj32IOmlBJhYBCg5Nac20JOashG6O7HeX4jvMpQ=;
        b=mS3AUA2BoZsbstIM1GCFCTqXV/KHzMlL+a7W8ryUWw1b8cgno287cT2RR9gdjFRx5W
         ATuts8pbrm2pdHx/LARa9bEa5MGK4AfIDV/piae6cyDucmkB7ncKZuTLt8YOWURn0DcF
         ngbmqkKGGlYvzg0kiJa3rIRqW383ox1W3OZtYCVfqkuxR9f39cI2VkjNGt3CmbYC50MG
         hhNqRROMtSsDFQUgiwBidRjyf2FFZVt+NDMOcV4TIX990AwUyunmoG+cl0r/jB+WbOdC
         vL13K2pT6CQbaHlren0K3P4JGQNTX6T5h0hHtSlSTU5aDZ3wJmkq7y6QLLiyh+1n8yRY
         FH/Q==
X-Gm-Message-State: AOJu0Yy8ALHju3WaY7IDy+8AsD2maZYtiqAhxxSgbpZX3K7kc7m7iOad
	z9tlO4Dj1hMQK9nq4VJ51nTy3NmxyyX86+RZVtgNQCQZquDUjrOnQmKk
X-Gm-Gg: ASbGnctSh1FQopB5BsjHnw8Sn4pdbQzWKmPbpoWmlYPmi+QYC5+wReHLdBSJbIdhx5L
	/GJbpaox3ScRnXIK18Ucy+pwBYZIqXzcyNEOfrDb7l2dCn+p8UWjQKoUJZbVp/QjBmCYawP1+fc
	kQMHEEx3fccNnEnBAn3qczaDZrksIkZ8bRaz1CExWT/9HaMraIjYWBLQx0Io006VFxUO60iMqDH
	locKlQsBENgu/fXuO379r+DKtJwrJTnMwVE3MONdlyFFagqexikN64WwSVOUyYL3ao0cA49i7lH
	+R8ns6D21qp4JmUhXtB7aQuiFxPsM+f6Q9TvAVw43qUZtzf8jx/jg68ArKjXKILx7Nu3xR1jGBo
	CPTDiMard2QgnDJca4jz158cDqZIX5oXs/3A6FCLVi4qY19MZMFwOcIcMOkJ/4y056Zr0K+YcT0
	GE/gH7gGhzv8drO8UKcbcj4I/T9xoVBA==
X-Google-Smtp-Source: AGHT+IGr1tQa7Uao2h+kQ37gSFBMOo/Ip9Hcs/Ret4+9Zty10j81F1qt78ZblE66dvLORo7hYxLb6A==
X-Received: by 2002:a17:903:292:b0:298:43f4:cc4b with SMTP id d9443c01a7336-29b6c50c632mr197507855ad.26.1764136046937;
        Tue, 25 Nov 2025 21:47:26 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1077e9sm188374075ad.15.2025.11.25.21.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 21:47:26 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH net-next] selftests/net/ipsec: Fix variable size type not at the end of struct
Date: Wed, 26 Nov 2025 11:17:11 +0530
Message-ID: <20251126054711.26465-1-ankitkhushwaha.linux@gmail.com>
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

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
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


