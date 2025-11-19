Return-Path: <netdev+bounces-240100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E4C70768
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EDC2352EE0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B771C3612E8;
	Wed, 19 Nov 2025 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEwsqXJ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C6304BAB
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763573096; cv=none; b=C8vGzBTulrsqdHGUZuklUX9Mit2u8IzQ/fQBcXkrkCZwUxQgqJzAKNo7sB4wEMtce7HY12DPCwXjXWEWu4jQSzyEECA7vRBYhOeKXuBuACBwyOCmvtAtN2BFBq8RUhVMSgdpcGh7aXp6lJQs+s9t2tLETXiCq7I6mtrbgSbfGxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763573096; c=relaxed/simple;
	bh=LXO4rDdTBgbuM/YA0kPF6N03fGhHLBgeEcVQW1wfkcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqiLpLX2IfiQ6dQzEMlrNSpYKUYqW2tGdScUNp3wktntbfDaYEbv3Lhso91Cn8DEA8jV8J6xP1EX+eFPKDAuSUE86zYSmapm3a4eTj7/Z/CMNyYe5bKWBagbpbesNLOoLjMEWa6oMz5DAwmNRlj1UFYZwiQ2dRIVh6W/rqI8hHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEwsqXJ/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so7898912b3a.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763573094; x=1764177894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OX/n7B61DXx8TflUhCVSCBsbf+p06lqRcS2ORfg3AuQ=;
        b=cEwsqXJ/47LCMMREoFm1rVxzygbiH1bSZKup26kSq/unsPBk7o6u7BmNe+CiDJmpv7
         hfR1r3CMszvF7xCsoWpPoDNxFOX4LvJbIBMIUihrT0ixnLe7mca5HeHUDaGhL9Pw1Ru/
         Ake4J6neRyzRsf+aAPtq/V7AaX0b4Ox348CyppouDrmaQZdriChCVIfzUtdcZTO3p1bo
         f1RfDuWoU/bVTtGAHWe0dHM0erSlsvPTasGAOnhZbqMrn30jTsMyG2+73756pSRgOwO0
         5XjQ4rQVu8YrK5Yyhe4OQJ1GP1R9rnodNWqiDlWGElG6pJfiLHySeGAM8IUojGDfJ4DW
         JG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763573094; x=1764177894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX/n7B61DXx8TflUhCVSCBsbf+p06lqRcS2ORfg3AuQ=;
        b=avQhLBzybaDQpuBRNu+3HV04okzqek8M1/pywh3SUDhRIC4hy4/AYYyTlAWKshqTMa
         kCh2C81W3Kv93Wk87uX5ddbefMxkPq9WclvuufswoN2Jt+AfJSWnnUx+htH7Ts5ck5vt
         C89mAMJj8HJbnm3MWWWtaE2PJ+RamVRMbyOou5HIgbdU056ppwhhbkwriW95jZGhpxVu
         i58ugPPUZRcERBPF2EbwA3XqmDFEVChqRXV/IXniqDklP8ctUx2l9qYmVLC28UBPpJgA
         TODbGI/zy7exFL+6AvFHsHp1Cdc0WE57cwjpGq87hfL9LlY6rPicWAgeKD/CqtxWraAx
         kYig==
X-Forwarded-Encrypted: i=1; AJvYcCUbSPP/LawWcWGfo3rcg9/VKV5jdyFK1zkb5V7kBAqf2moKIZrTVJ+2QVHYBV1bFLMHu6Tjx3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOKcWfaplukFBkaHmXAYzGySHL6Pd5YA/Ul06NNOEJRpp1xub
	08h8Ax3xtnINU2i2FeIyxZ03Whpp+C3I9Pm9d0OfBqTC7yMw68yLFHZe
X-Gm-Gg: ASbGncuT612qKi6MwnFaDo8GOHJkEjpaGih0WWdHpMuoHNiwMp6uWy2sEGe93C6/Kff
	8Y1kjpr934i5bzg/7mK8POMxNUfOPbgFbEcer+ADBqgr8EiWPBIpnX9PEW0583KgFM3r9eHYMWL
	vZENzftaFxR2bGW6P8mCXxbuROu03k20SKAeIA8XYFHgnAjVtWQujcoywyUOOOCmRlwvMcP6RVD
	zOddmYm7vt7Z6jJ+9fAA2EZfwa9fPnQECCYRbEhV1BBA72s1mBXVa5THdRnGwsS/rshpSnWWBnU
	tT2UmDE401Ju6J+1nPkIl6y+sjC6XE8NIPwvYPhNCVEN0h+X9biyTY105JFWwqcE+qCes2J9Tq3
	8oC6kcumrim9YgX9UUSE+PzS/dgx41TABHpRRmGfl289IlAW6zQ+O36QuBtovcExtol7oa/Yy7i
	8qf0Jo8bI=
X-Google-Smtp-Source: AGHT+IEC/HLrLINt0xXoa7ewEDUcprZ6BTZq3/IZpchioggBzCVMw9Hf3alVFdah+AZzS8uQB60heg==
X-Received: by 2002:a05:6300:218e:b0:350:31b3:218a with SMTP id adf61e73a8af0-3613b535290mr355474637.27.1763573093780;
        Wed, 19 Nov 2025 09:24:53 -0800 (PST)
Received: from fedora ([122.173.30.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d24b9sm20209696b3a.17.2025.11.19.09.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 09:24:53 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: ncardwell@google.com
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	kuniyu@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH] net: ipv4: fix spelling typo in comment
Date: Wed, 19 Nov 2025 22:52:39 +0530
Message-ID: <20251119172239.41963-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace "splitted" with "split" in comment.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a18aeca7ab0..0d1c8e805d24 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1600,7 +1600,7 @@ struct sk_buff *tcp_recv_skb(struct sock *sk, u32 seq, u32 *off)
 			return skb;
 		}
 		/* This looks weird, but this can happen if TCP collapsing
-		 * splitted a fat GRO packet, while we released socket lock
+		 * split a fat GRO packet, while we released socket lock
 		 * in skb_splice_bits()
 		 */
 		tcp_eat_recv_skb(sk, skb);
--
2.51.0


