Return-Path: <netdev+bounces-195411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8485FAD0077
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EC43AD721
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B48267B94;
	Fri,  6 Jun 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h23P9u9P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A988C2C3242;
	Fri,  6 Jun 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206232; cv=none; b=EcVY3vXtEH8c7xPScQpz98ob8e4kxXthoFI4fJO3f3lprhlAKG2q9QJvURFF6lvCvDRDjjZbugL1W8OQu8l6EdyoaFW99E9LLuA4mRHgBA/Htl56grG8LM9gjToIOYmhX5J3Ew+yj2K1P4oe2KkfcMaLakQIx4U50af3CFfU25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206232; c=relaxed/simple;
	bh=Mq4k4ekcbiqjRIxZJ0xXM1aKpS5twuBvYi6/9eFoJo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bito4myopx6FUom7ZrV5ZDAPnbPQZl/QDodtZu8kayN3vj8xaWXUAsNAoU0c871UGLRIs5GjW4k/+NZqx1m4Ko/ZRAialG6V8bfuZr/+AA4Y24TlGL9gEi+UwbPvLzseYm06ZJkF3IaZ3/Sr+D14N7hOI8IoIRAx4jo9RcNQWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h23P9u9P; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso2306682b3a.2;
        Fri, 06 Jun 2025 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749206230; x=1749811030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NdtxJEbjhatRvCDWF7ffdW5RJ6Yji8odY3/KOt6aPsc=;
        b=h23P9u9P2iy1P2igEqGnvqgONTTZVKs1Q6TsQBOJLmqfiZc96aMUK5gZMLlvPX6XgB
         NxLUfDQhrooStQA/KCf8fkEv7qM3F+WMbL1AvP/h46DGnIiavzDmhzRiZkKXfSQX/6tC
         Xp2i6ww3pg3IWGwHBaSTMHKqgfp5aTgXMK7EIZtMBoWBZwjE5aIrCPHvMPRoKagjry0g
         17XyZJOB+mq7pFgESTxiM/4c37D4w0jgu39gD6wIpMTCxrgm1wHGlHbgJehAwptDdirM
         4T8u8BmS5G9Ljk7s6V89tthYuGij8SmsrPK9B/6KNdpp99ehXi9If3pYMe5GGQ4+Y+mI
         j9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749206230; x=1749811030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdtxJEbjhatRvCDWF7ffdW5RJ6Yji8odY3/KOt6aPsc=;
        b=fC5UhgUa0tcMvDfKJakc0+KG3rUvH+p4NuV0FyN54J5U0cUI7Uq/qtdYTivDDzio7B
         4XN/OyNGnAbn4mobnaJ20+WirD4uzkHEpVcXtbbkHl2XOzu6KSg8B69ibkR1gtSWXiRG
         2PLwvGmNEOE6zy8GWJgkTe4krEfidqJ9QF3hOOLl5LgYQGtYb8k/Mc0/lzcmvIL/4j7e
         JzFc8s659u172rUoF4D7d5B03JFnggOx7oMbHHpQXEwjo1LOD65Fd+cvFJ0YvYskLkYW
         Ov0NOzbNvknZ4NBsN8BnkpZkfVXIapL5Q09xUDFZu2o+dpOyi7ZxG1Y+iD2+zuVQOE3L
         f0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOsqiPL2Xrm8e5TgCh6WhQpFug+rr6wl5M6+a2dsZge2Mbk89won+XE3FkloA/Kn+dsIiijlrtb3JIHIU=@vger.kernel.org, AJvYcCVMrbhVHhXpFydSWFAIhhwVS1BDwKDgP9PaTO/Dbtbl2p2CIhgqpC8HDV/V49gvU320RgpBHIeu@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbkTs/rxMXaiECD8/4U1mWvDPeEgU0NTMUG08Z2B2dBlYVrWN
	wpqPA5zeKsB/4SN4CsX2XkxiFQiq3TakmFd+rmZ5ZyW69mzwhS3TmUzs
X-Gm-Gg: ASbGncvkKNcCkq0GL3oRZFXNhNhEg7J/kPF7mxQ+SGAGUvJ4cUxTozxxvvI/q0kA4Ad
	E3HvyaVQnBMazt9Lwr3M+6g6FMtR+zdBKpuzVkz6GaHjaNWGUVwwN8mcPB+StyLSZEDOZJWLSBX
	VlUWdHxYNCz9tlPxtisx3euuhdeFsBVM+ebrTHVqaHPIjpAUbvS90olehiAFaPwjYNWSd60Ql86
	4N0rQVf9TA2BPH/OZ8PWRzWqhUjca4f5keaTXg5hLBHm1iQ9IxyAfLV6RVeVhLIV0cEDjQVneIL
	shPmtEnD7gKkVXX423a/qbllh7NHSavGSYYmQNJJpoQPVx9DrwM8CTAolUB6s44WdaLPhACEKIR
	gDyuYFQjAGJZ8uoA=
X-Google-Smtp-Source: AGHT+IESWEQByLV3zPRY07M398R8ZoM9qPk001wtKdUGokyw0THc1FuuH31hxl2c0VkrBS+61mTUzA==
X-Received: by 2002:a05:6a00:2e0d:b0:746:24c9:c92e with SMTP id d2e1a72fcca58-74827e810demr4833871b3a.8.1749206229803;
        Fri, 06 Jun 2025 03:37:09 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b084695sm1033041b3a.96.2025.06.06.03.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 03:37:09 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: richardcochran@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] ptp: remove unnecessary brace in ptp_clock_unregister()
Date: Fri,  6 Jun 2025 19:36:59 +0900
Message-ID: <20250606103659.8336-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are unnecessary brace used in the conditional statement where
ptp_vclock_in_use() is used in ptp_clock_unregister(). This should be
removed.

Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/ptp/ptp_clock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 35a5994bf64f..0ae9f074fc52 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -412,9 +412,8 @@ static int unregister_vclock(struct device *dev, void *data)
 
 int ptp_clock_unregister(struct ptp_clock *ptp)
 {
-	if (ptp_vclock_in_use(ptp)) {
+	if (ptp_vclock_in_use(ptp))
 		device_for_each_child(&ptp->dev, NULL, unregister_vclock);
-	}
 
 	ptp->defunct = 1;
 	wake_up_interruptible(&ptp->tsev_wq);
--

