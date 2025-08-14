Return-Path: <netdev+bounces-213824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA72B26FB8
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 21:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8BE7BAE58
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 19:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8CA3597B;
	Thu, 14 Aug 2025 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN+dWmVw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6C241139;
	Thu, 14 Aug 2025 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755199946; cv=none; b=RymdTBJnpHxSF0DWtIQwzBDDfI14I1X3QDvksuAE5mbxhRWr1TcEO6wj0w56r6LBdjHG1qpb/u1Pktx9Csb5/+qmfAY4CM7g5rjoj60Zbr6ARs9QiQmRSdKCcC/MN5gxv1UErMRhVS3/7fpWfupNmWm3iJQNG/ksoOuzuuezMy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755199946; c=relaxed/simple;
	bh=Gzhj7YwkhnbNmqe5w9L0B4nmUN+mEwwJmuX/gu0/Szc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=it4bSu7uAVgk8LGCl0bxmu7lcb8yz3IGMnYzoz3z1JMWaquiKdgTYQPZKMpwVlbQ7Y1/Q82JHWQTcEnmLNLlKUuC95oYpV+ygubUfGOEB0VSXXm1tcYcSxQukDJyR804ol4JPWvJCXtWLpVOqoi0M6xneWCMieGHnwYDFEzk+co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN+dWmVw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9d41c3a44so198523f8f.0;
        Thu, 14 Aug 2025 12:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755199943; x=1755804743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hhUB1NFTF7xUTayhYlJEfsBBpcak+eRcTlvoGoZNx8k=;
        b=MN+dWmVw9ROaABHXYc7HT5kTT7fTCoLjOnbR7Yw88pb0BKhNgrNAX32sK1oEjnu3w6
         bJuba/O3qDTq9VaNYsjbFd+0m3wxo3s2tS8pTiUsgm6Sks1fvBdoZ2JCAff93l37/jPC
         XNDhXaMbTl7S4lv2Z14FZPPhmp82myPhkgx1ueUam868lRFB6PwLhQR0+jd3op0a0AFf
         6YphEEdvADYcLbau8VdH4aJoX/2yA1XMM9Y9OUYlUPaORjKr+f1HQDvECnILeIdCCo78
         YXdqRrfwUh6lM3SOYHGF0o1JwUdo27Nt12JKFES+9kx4hqOHlDl+SK+9YTKTlCJFiS2D
         zSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755199943; x=1755804743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhUB1NFTF7xUTayhYlJEfsBBpcak+eRcTlvoGoZNx8k=;
        b=R7vLJIMGP7mL/O0MrZGNq/nm0cEKLc2d8MKIvkxHPO6rV2RZuVK2dR33N/hNQXBcrA
         rjt8BD4cV/QQHtiaf5FlKyofc9/2XCzD8wc7nieWdTZBMd9w/A/Ic2MsNcnm+2YvHX4l
         mwxEc5UMLqYDS0pmoNhjW4KSRdkdevo4eolGh8EEQpDs+NEq7TqwxTYFd1Ga4qZHHIMI
         cphQmg9akeexxXJLbVnnc9IugbUT9MrDS01DLHUyK0roG5dd/RL72H8B94htC1zkRqBu
         SyZyuD/xwxgR6V1qmzhACyZVagaRB3CNFmnn/qeDCDK0K4/zy3J3PwRd0WQYa3/OZQ7g
         gKvw==
X-Forwarded-Encrypted: i=1; AJvYcCVteckP/HknvftQxWOzFi43qnhZdxLwyuj6uLS8cbANwBmMkRQpdGsMmUJ+vsMp9NaUuqaXWYid36oGjSo=@vger.kernel.org, AJvYcCWKdhQ3Q9qbwsVLoTFc6YFL90lwEC01LDsSgs+IeInbam9WTeRNcdhMNA3dON8RwNyiEQkWwlEM@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8emykWcjcSapS922oOxzDcAeHzHcGPD6s9YMTUVX2rFIRMr0
	XuXZ8GhEg69FCOC5cq5JKWzBVS5T+/8mutXTXLcgMG1Ux/2Gu1DWdEWx
X-Gm-Gg: ASbGnctPQBUYjGjsectRAzlddyU/Uo7AGQUVhhX2nwTtvj6siigPVPF5Ec2mRMj13uL
	qj0p29WmXex9QH3LMV+pr1RYn6JssOd5IL/lnZJ6yxloVNkyjvFEH/uDNzLQRmnDEKlrmChAyb8
	Pmbz9NsMkfeJFFhMEZ5EDd33cqULUPWM9QxFW9vhcJP1+mgIPxQwy1zqYwxOcZDgmjEXdi1a+0I
	elyrspzqb86vakEpONA2q+fdoV1MN/78reGlRGrusVusRlxhx5h83wXF73vBfUUyuDZsaeOVlNR
	wX8iheOmG7B98vgWh0aaimLoS7Hzy8o7mfRXjV7JVcxrDb+pRbvht/8FUJaXAvdGdWqQwxO8QuY
	qbsakfLmtB+6SpTvk+x9+76qMh/wK78qU7zWUBvxEW5Xof678vL04U3ZX98DPwGUi3Ym2J0+kZQ
	==
X-Google-Smtp-Source: AGHT+IFNE8lNReUvGQQAr1wHb9H+pyZXKODmatPlpuNTM9BJb2sYGnBPEr8AhsKDjoNrxl354yMmPA==
X-Received: by 2002:a05:6000:220b:b0:3a4:d4a0:1315 with SMTP id ffacd0b85a97d-3b9edfa294bmr1515009f8f.6.1755199943011;
        Thu, 14 Aug 2025 12:32:23 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm51910902f8f.18.2025.08.14.12.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 12:32:22 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH net-next] xfrm: xfrm_user: use strscpy() for alg_name
Date: Thu, 14 Aug 2025 21:32:17 +0200
Message-Id: <20250814193217.819835-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the strcpy() calls that copy the canonical algorithm name into
alg_name with strscpy() to avoid potential overflows and guarantee NULL
termination.

Destination is alg_name in xfrm_algo/xfrm_algo_auth/xfrm_algo_aead
(size CRYPTO_MAX_ALG_NAME).

Tested in QEMU (BusyBox/Alpine rootfs):
 - Added ESP AEAD (rfc4106(gcm(aes))) and classic ESP (sha256 + cbc(aes))
 - Verified canonical names via ip -d xfrm state
 - Checked IPComp negative (unknown algo) and deflate path

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 net/xfrm/xfrm_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 59f258daf830..d65def556b6b 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -593,7 +593,7 @@ static int attach_one_algo(struct xfrm_algo **algpp, u8 *props,
 	if (!p)
 		return -ENOMEM;
 
-	strcpy(p->alg_name, algo->name);
+	strscpy(p->alg_name, algo->name);
 	*algpp = p;
 	return 0;
 }
@@ -620,7 +620,7 @@ static int attach_crypt(struct xfrm_state *x, struct nlattr *rta,
 	if (!p)
 		return -ENOMEM;
 
-	strcpy(p->alg_name, algo->name);
+	strscpy(p->alg_name, algo->name);
 	x->ealg = p;
 	x->geniv = algo->uinfo.encr.geniv;
 	return 0;
@@ -649,7 +649,7 @@ static int attach_auth(struct xfrm_algo_auth **algpp, u8 *props,
 	if (!p)
 		return -ENOMEM;
 
-	strcpy(p->alg_name, algo->name);
+	strscpy(p->alg_name, algo->name);
 	p->alg_key_len = ualg->alg_key_len;
 	p->alg_trunc_len = algo->uinfo.auth.icv_truncbits;
 	memcpy(p->alg_key, ualg->alg_key, (ualg->alg_key_len + 7) / 8);
@@ -684,7 +684,7 @@ static int attach_auth_trunc(struct xfrm_algo_auth **algpp, u8 *props,
 	if (!p)
 		return -ENOMEM;
 
-	strcpy(p->alg_name, algo->name);
+	strscpy(p->alg_name, algo->name);
 	if (!p->alg_trunc_len)
 		p->alg_trunc_len = algo->uinfo.auth.icv_truncbits;
 
@@ -714,7 +714,7 @@ static int attach_aead(struct xfrm_state *x, struct nlattr *rta,
 	if (!p)
 		return -ENOMEM;
 
-	strcpy(p->alg_name, algo->name);
+	strscpy(p->alg_name, algo->name);
 	x->aead = p;
 	x->geniv = algo->uinfo.aead.geniv;
 	return 0;
-- 
2.34.1


