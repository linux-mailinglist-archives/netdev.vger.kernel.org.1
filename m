Return-Path: <netdev+bounces-209264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E39B0ED9B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607F7188FA91
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5C277C8B;
	Wed, 23 Jul 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzH9K+OC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C97244679;
	Wed, 23 Jul 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260509; cv=none; b=EQOmnGjhwIfjfRQA85AhhSwxuF2qxKh75MaYISDgiqZQ1RKh/KrUllo6tqrBAC1l0sWSGM4XTSJ7hH+kyhtX6ca4eROjQKctzUzs2rmbjWQPG7OU886dzFuoB+lBngPJ5VI1Z46+8mTb96FBjr2Kok/8pq7VIJtLicrFo4N0B/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260509; c=relaxed/simple;
	bh=jWXaYGxYYLYiCDGN7xik4lrIyUUKLSRMDJE0kXyPZyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/cSLa5euicFYrvfk9NQwMg34hV5sXTA8zELJdjDWgHyNgVMAx3tmHeUu31cQrZH+RAU8yB+2eEgSji8KQe5EXsgzExkh2GglAd2C2Rhm6Kiy4A4y/wsGJTRUFyUoyRa4BmGVeUTm99bcddMpCmsDyAN2pVMSSUKi/wPLr2Y0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzH9K+OC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso1073862166b.1;
        Wed, 23 Jul 2025 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753260506; x=1753865306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tQowkAFRLXXjw5lYLGQoSknnad2/JoJTmbOjV7xvS8w=;
        b=DzH9K+OCRt68XoiOoxnWWfxbw9RDE7bNGCMOo0Pg72043CgWdrXjZ7cmC/DC799mRS
         /JrmDW9aBiFWoRnR0YVe4Bo2hMlhQJoHIjt0bCeWhtxs+OUeGb7r9L2vQoNNxsxlPRQS
         iTWvTK4QCBH08it8+KopfDsbYiGVSi0wT4LAW8urvYCYSuI4OHpZ9R//kg2he4lDFraA
         WTCy4suP4SbHBWIlt44D5/KREoMoZ4ZwX66RqdLUrTyLCjBdwDY153IRmPr6aiMNeoAE
         qbL9Gz3GJuv0DUfZAi6voVVzwSzFY2i/nN9Pl2kzDAcnI1YEQ7cGqhS4Q+VKiuw9C+AN
         327A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260506; x=1753865306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQowkAFRLXXjw5lYLGQoSknnad2/JoJTmbOjV7xvS8w=;
        b=r0Q8DKtyh6LaWBdilFcLP67s1EBST1XN7XJwyHrB519qjDujUGz5Pm2pKI4M6qvL7X
         N+p2gk+SqgJ/MP4dUUI8yPHBmpHtF7evCvNTylKxLf+7UEh2Gn2CQJ+EQA+ev4bhNDPz
         kh/V4WzyWOCN+4lF6kIX3GTvn40FZ0QprmS4PpZJ3oXJbA6TMzcs8U2TwYDLM8diCBij
         9FQ4QZvjFXS+AYnyxf+TnIQAKjrBxDlCqVb4l9f1nxPzh0SCCmnr8QLiWXCdCdrPmZXb
         yOT+9awS5pzEgctl0HKCDcDGp8dzw63jFilpMtxRb+hzY4z4+5fGUzdI+nOCZ8HZIVaw
         efAg==
X-Forwarded-Encrypted: i=1; AJvYcCX+wPB6OK03xxrwx4IIlnPE/dOBTINNAMAuLmq1vGb8Wj+eSyw4iqCoebsuWas18A8j3LlLth8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyELUCDSLrudbSw+5fA5R7WyxUXjLEA9erolV2xyJXsAFDeEcw7
	hEijqjjdAeuNLcuj2VwDo83RclYgZ06qFP69xgAup9mGkikAIbf7Tqh9
X-Gm-Gg: ASbGncvhx3TVnsGEpIgBJZJYgGv5DxflSqpmtENXhTZeicUa8UHGtFkNIQCCdcO1g8+
	N8gTArxthZHnCxNOUOXfvYv6Qi5Z3N1fGJ+7pfaLLjgucqg3KOHneo8sTRUIKQYvqEn8TB7UHI+
	qUYHR/l5HaPr0LaCTaQC7EU0dQ+QKnWfBnXHJyxleTYCKoKSij3EngFR0QUenggjeTyR1AYPl0b
	/kpsOc9CixUVM+Ay5yrI4Gpw3H5hGDb5T6DvyPSgbnSuv4NVO0NccH9vBMe/Jzzi0QqIjyNRcvA
	973BosTL+CLOJrjmPKRrZyP8ZVjWL1alvpjzt0j+Pvxagp5k7OXarpjvxKiqbK2HW95X67u0wbL
	iXjVk0i1A3PI7HYQFhPrFrlU/Nao=
X-Google-Smtp-Source: AGHT+IHBaoZiRrpOQwd8Zc4/QeSjA7UMm8Njh+vBlpKk7GLwIJiObQl2/SIgTheXyVV5ksVEA3zZtw==
X-Received: by 2002:a17:907:78b:b0:ae0:b49d:9cd with SMTP id a640c23a62f3a-af2f9872929mr186405666b.58.1753260506055;
        Wed, 23 Jul 2025 01:48:26 -0700 (PDT)
Received: from Thishost ([2a01:5ec0:9813:28d9:ba3b:baec:155c:3318])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d7b9csm1005778866b.61.2025.07.23.01.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 01:48:25 -0700 (PDT)
From: Ali Ghaffarian <alighaffarian9@gmail.com>
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Ali Ghaffarian <alighaffarian9@gmail.com>
Subject: [PATCH] Net: ipv4: fixed a coding style issue
Date: Wed, 23 Jul 2025 12:17:36 +0330
Message-ID: <20250723084736.521507-1-alighaffarian9@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a coding style issue.

Signed-off-by: Ali Ghaffarian <alighaffarian9@gmail.com>
---
 net/ipv4/af_inet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092c..e38a977c9 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -445,9 +445,8 @@ int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	int err;
 
 	/* If the socket has its own bind function then use it. (RAW) */
-	if (sk->sk_prot->bind) {
+	if (sk->sk_prot->bind)
 		return sk->sk_prot->bind(sk, uaddr, addr_len);
-	}
 	if (addr_len < sizeof(struct sockaddr_in))
 		return -EINVAL;
 
-- 
2.50.1


