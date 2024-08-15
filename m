Return-Path: <netdev+bounces-118675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AC69526C2
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 02:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABCB281B68
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F611A32;
	Thu, 15 Aug 2024 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3RqVAp8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F11878
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681179; cv=none; b=tC18EJPesi/OU0o3uuLDfr8Cnm+FhybVh4+YU6F2Yjs9U13AIvBSVPo/t387t+ORKKpafhXeDC/ZR/FijDRaSlxeIVI5JtdSBwQS0t6EBYNSYQzczfupJ8IDvDMTgtxqzTHO54UZNgIDyzzQGedhiPkp7zSpRSVgsjvXFvomLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681179; c=relaxed/simple;
	bh=/gx5TOaEDzO6JxN8lEEjbgT3QyvIk0pfBhc1U3cmtbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQQ6RdOgZSo60ZzxuWKOCjnpAd45K8mVq/9FDxhofPXB3/IPXpNhnARrkU1UL3NV4NxBKC9SVJfaMTSMk0XVHtg35ZAqcQbAh7+dobiZfEnoektS+IsHcsRDnc9tyltqmY105slJfAnU/B7j+7H3IgnBdM2SSpZGXib36SNr5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3RqVAp8; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39b38295008so1565985ab.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 17:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723681177; x=1724285977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SEOGsWlqXwcpw2n5tIfIJsDE2WXNGqxy7z4L0W01jY=;
        b=m3RqVAp8WVVzjOT7iIRDi10x0PxdNxt4TB9SpxCKHbMi5OrhQ3gNo4MeJlC0nZXfRQ
         PknSr1IhaxIaVLiPzuzwcMzETT+bPT09+xAmrX02DgmnZb2AB/PoL5n/9qlZuOcvOAJz
         ++zQXx8PKkHUuAztqHBgA3n0CTZ41qNRW5CSAu6lmH6Lcmn+QTB9JxvMng5X28e7ju/O
         3DVrgdVW0ltmlk2GX/3UiePZQjyrFrKk+DOcpwvMFQRyDM8InfOeSPUsTbkTnCWFGm4r
         cJbOPxtYEPrw1dlBPAnXImJM7KoJB/IXL+bO8l575lEgX/Fhirtn6K0v3Fut/zFQVGjD
         qgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723681177; x=1724285977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SEOGsWlqXwcpw2n5tIfIJsDE2WXNGqxy7z4L0W01jY=;
        b=AQxoXpulJJz+1zfaJxE03X0YYSLS2znUZ2xFyfmSPDvotyH+OxjUGb2Hh05EJfOZZc
         y+vqExRFdv5njNIhoSpV0baoMEBQpOlvCYq/UM5WSwRBI2n1iQlnkaBx5liiRhNJGrVR
         ghaLhjBBjIzkaMNaMA+L2l+A0D4BRG9e8zQwfYzOd2h3/pZQnptxuS72Eq4eRsR1MFgu
         jGYnMmUgdLNWjHrvLvO3FtRWKlPtRB+x8U+e0nC8U/9PU0FiL6dRght6H2vVqNNu7+H1
         gBbRVZuA/mVl8mF8/6lqJYM0Ek0vmy7QTr9oblAyXLdEDjWc25SxeWyEMRan3V59I7Mx
         UvBg==
X-Forwarded-Encrypted: i=1; AJvYcCUoj5i0TG18nUiMaqaaQrZUUgBI8/P1bQvgM654Lszi3xVcKoVul9O90dmaydGaN3JUMxtRzoQA/D09uiBs2P9VjAHgMFS0
X-Gm-Message-State: AOJu0YwhujL6GH0BOusODMVzX5txlruwJcYaaKTsu4kmRhbj9sVejXId
	hSrLaPoXJpxeSrasiYzNNSs0mKFLIEKKtpoN80frBy6urErBGxos
X-Google-Smtp-Source: AGHT+IE3HAt0MpwiDiq6l2ffmq/tvlPmWYckzKhvSvoQUed7eyax/9skQONVdZ3rsmLbzv+0JgObpQ==
X-Received: by 2002:a92:c541:0:b0:39b:2133:8ec7 with SMTP id e9e14a558f8ab-39d124cd81bmr52019095ab.18.1723681176805;
        Wed, 14 Aug 2024 17:19:36 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1ed74e0dsm1244935ab.78.2024.08.14.17.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:19:36 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net v2 1/3] tcp_cubic: fix to run bictcp_update() at least once per RTT
Date: Wed, 14 Aug 2024 19:17:16 -0500
Message-Id: <20240815001718.2845791-2-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815001718.2845791-1-mrzhang97@gmail.com>
References: <20240815001718.2845791-1-mrzhang97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original code bypasses bictcp_update() under certain conditions
to reduce the CPU overhead. Intuitively, when last_cwnd==cwnd,
bictcp_update() is executed 32 times per second. As a result, 
it is possible that bictcp_update() is not executed for several 
RTTs when RTT is short (specifically < 1/32 second = 31 ms and 
last_cwnd==cwnd which may happen in small-BDP networks), 
thus leading to low throughput in these RTTs.

The patched code executes bictcp_update() 32 times per second
if RTT > 31 ms or every RTT if RTT < 31 ms, when last_cwnd==cwnd.

Thanks
Mingrui, and Lisong

Fixes: 91a4599c2ad8 ("tcp_cubic: fix to run bictcp_update() at least once per RTT")
Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
Signed-off-by: Lisong Xu <xu@unl.edu>

---
 net/ipv4/tcp_cubic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 5dbed91c6178..11bad5317a8f 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -218,8 +218,12 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 
 	ca->ack_cnt += acked;	/* count the number of ACKed packets */
 
+	/* Update 32 times per second if RTT > 1/32 second,
+	 *        every RTT if RTT < 1/32 second
+	 *	  even when last_cwnd == cwnd
+	 */
 	if (ca->last_cwnd == cwnd &&
-	    (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
+	    (s32)(tcp_jiffies32 - ca->last_time) <= min(HZ / 32, usecs_to_jiffies(ca->delay_min)))
 		return;
 
 	/* The CUBIC function can update ca->cnt at most once per jiffy.
-- 
2.34.1


