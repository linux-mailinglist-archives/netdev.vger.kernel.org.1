Return-Path: <netdev+bounces-163650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B8BA2B25D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4489A188BADC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE91AAA11;
	Thu,  6 Feb 2025 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyrStvvO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998DA1A9B58
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870533; cv=none; b=cy/ZrZd/JTx4sLQR6fRN6MsnXEic3mwZcGPLLLUbNaqOuZHE7jbVyJrBWFuWeAhsjV9IVRmTyEtjzF6BLDviT9ULgI/sJJ/eSCBsR5YqsEZd0rQmP/M7AVrkdohV8wq7Tkvoi3usFZZOEvwSb0fUxQlaqeLo6Tx1yHfnfILUEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870533; c=relaxed/simple;
	bh=lGZWu3jPg52+pH/sJcRfMQ2FRfaimKSO6mvYUMpmPS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbt9Zvx2yd1/yzPJ4Au5IK5cSbezudYoxN0ZuydY3BbtxmAPfoFgPYuJoqBdJM/U0qNfzPoc78uB0HHDos0frPX5l5xk/OYT6fadraa/u7gi1rmusKI8wZJsfDrg95KfQQ7ib6Mgx+gdgSqQsjhVuSzfKT9hQAACcs8wMyM6rGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyrStvvO; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46fd4bf03cbso19863501cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 11:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738870530; x=1739475330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esbRzenWeGW8N6g0TO6k08/dN2AilbZBXiBhfK+nIOM=;
        b=MyrStvvOdE1aU1nJWJ3ZCmGXnA4tzpGUVe0MikBCv4TVwANyxKwRyaArWyfqGo8kKx
         9+QDdJOZAXp4tKpEuRT1B3uzxIDS4Rvt1d3V70EU6sL/JAgu1yustqQx5t5l3ufZy+b8
         BJjXb59syakJyp+Kp307CbqY/gKOs4keOsDR62bI7u4BUt6KQZdTDWWmq8e8PvApTy3v
         sBF3QVHzZhE9jHZ5LrJ4Bwgc8KVnTf6Ej8iGd1IsUG7MEvkIF+EA+Hnz0d6ueh6hcib2
         ng3ovD5ughlqtmcmI4zdFccwCsd4WAWpy/2ZP86mW2SkDaRKBjv2NGWKjBvgn26NJRoS
         fKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738870530; x=1739475330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esbRzenWeGW8N6g0TO6k08/dN2AilbZBXiBhfK+nIOM=;
        b=ehUyYM8k1PuTNC6rbBP7jvwI018El51Ya/PILyVY5FBEvt/0MRJ1mHyYApARwD07eP
         r3P09l0qY31alKmGZl1V6umA9whkszKonf2IWg2OyeDpWCR2Ij4f2WT1TjvbDJjf9ObW
         eFiHkkKy9Hc+788g/VZYCpTGjyc/daxqIEXL1b9b3FOhsArSBj3qgeTbEVR9kBJmZ1NM
         o9JebUnFKUIpmK8WysP++8TbT9k5q6w4kP8xm7wRKS3yyfdLE1PM1h2CIwHtYR9uX443
         lYEEs6FttJc1atVhQU66m+dx8OcCI9bq5QAzgCXSq1GVnWmMruWZ3zbUdBy+SYjzOrwh
         FDOw==
X-Gm-Message-State: AOJu0Yx9Fwljk1c+JAe+yPYWL3BFc4HH4QZLModA2Qzg6fm5SRGwZD9w
	O1GM3gbkOLMpaRcaQsmWB2cGxfRyuplKdCZEO8mFCd1yh7D6lqZK3qVw6w==
X-Gm-Gg: ASbGnct7NZmc1w8qOCd2tMTOzudf+RROKzOnd1cKqqogYSEru20XjLl8L27AmPw9QmR
	AFhE/4+/L7735L4dtN+WWTFfbU2nj6v5l1iSZvAta8pSfc+UnjGhvxNXgI9bSjTb4kt+MsIDZF4
	L1HId5knsquYe2tq+0KXvuBor6hZ9PAwkq5QoEzUI1McdU71oFfglkCkks5aEfeEyAnawpjMkR6
	MSrHJnM/Ww/mMDFoXtof1vJOidOfEGK/r7nxufRGS9HZ0ZpqHsoHjpX8W//kqvAcJSx/vLdY6hT
	HYT3mvNfr2MM90NUNHTJI7krL2MhAfKkAoe8dchifYVG68NCqxgGJTj4mtUSwjD0cvZKvjJrX24
	GTiMx7+jBKQ==
X-Google-Smtp-Source: AGHT+IGoTHrEEBeUWjn5r4vonS/OOerlfSWVzcrqWNyKFLt4Gwr83Q2eDfCLmlOw1/XifeiiRhI9Kg==
X-Received: by 2002:ac8:59c8:0:b0:467:6e25:3f3d with SMTP id d75a77b69052e-471679f24b4mr4794131cf.15.1738870529091;
        Thu, 06 Feb 2025 11:35:29 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492accc2sm8349301cf.30.2025.02.06.11.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 11:35:28 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 3/7] ipv4: initialize inet socket cookies with sockcm_init
Date: Thu,  6 Feb 2025 14:34:50 -0500
Message-ID: <20250206193521.2285488-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
References: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Avoid open coding the same logic.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/ip.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 9f5e33e371fc..6af16545b3e3 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -94,9 +94,8 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 {
 	ipcm_init(ipcm);
 
-	ipcm->sockc.mark = READ_ONCE(inet->sk.sk_mark);
-	ipcm->sockc.priority = READ_ONCE(inet->sk.sk_priority);
-	ipcm->sockc.tsflags = READ_ONCE(inet->sk.sk_tsflags);
+	sockcm_init(&ipcm->sockc, &inet->sk);
+
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
 	ipcm->protocol = inet->inet_num;
-- 
2.48.1.502.g6dc24dfdaf-goog


