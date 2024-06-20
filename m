Return-Path: <netdev+bounces-105408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A53F91100D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC991C23F9B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EAA1CB30D;
	Thu, 20 Jun 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqRe5MAa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482671C9EDA;
	Thu, 20 Jun 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906302; cv=none; b=WEkVXSS0O6J4JbImOWi4c03DedfYYuHtQFcDTipGp6qn1V84kUvRoc7kVZspimoFGrdV5CEhndPgCpb4C9npDQmqSWSQve0XUvEh54Q6qEDrUIIbg6GIsLhGvwDVjG+SW9Z1XlV9wSSIRRvPkFtRPDUH/2gw/jvPlYEdqteNakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906302; c=relaxed/simple;
	bh=K4IWdyliZkmZhKKSV+eGfL58Im2XzxDJDCPSFOZ4NNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXG2mF28Dk9BBopB7AVgMSBsxUN/K/JpPpm6KAHsGnjjEOzv9oS/HU8LkWe+RE9Im8bLcxw/De89A1R2+IZQMEIzjdgzMpp7Lrzr4f1zsJWxpItf6wPyoL4+vUmrU1ayNaoBVYnqa/fKkVxGAxSYCaHG/eu1vSYn8y4lUrwwLyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqRe5MAa; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-711b1512aeaso940415a12.3;
        Thu, 20 Jun 2024 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906301; x=1719511101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lti5kgcPeWhIYDqzEsD33v78UGifs1rdopCyxCRLYNo=;
        b=EqRe5MAaHm1RKGWNTbNGuIXjFJJZCh9XYH9QoC00WbkQwvh8ZDyDqTUa1SRJNhmd5U
         HOaxOLn9M4HqXWgJG0a4Wr7p7bWnkeeqt5NF3pplLwOW653UKkQVF82UDyFUKi//FnN6
         4AojZw0PMDdSScD1/iLic10nrlO1wLs6OWfZEZL+17Uw7Ffjb3ys15ga4d8YbOi5vFku
         M0vJw6+h3M8ks/nRVxnBHRZjtktyck9NxLB2L6zN4y/2Eg/QiBArb0+JYK46J2EP/dJz
         9WFHWW5zOUjpuU6Yy1InJVZKcBVlnrwaM06ITWld7lEWgdXQhhI6HKtFb01BxUpU3Qga
         VVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906301; x=1719511101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lti5kgcPeWhIYDqzEsD33v78UGifs1rdopCyxCRLYNo=;
        b=HvESYKySeC0dkYTla3ElZASb0SImvB3DaFWxeJ6mouzPoGfGXTgzuS+4M2Z6sxN4u5
         xC0QWPvKQ/wSa4oQ+NDm5kOPiqpH0JY3zATWt8g6uYSQj5+1Lituakkh8Vdnd+L8gY8P
         /m9C0ui8PAGFzDpHOtJDbgbPO9qfNveup0XcDt6bv2sGgYqmcSfjjP1Nfj0YE9zmetXJ
         N5OEE5ghhw7VAuVED7Q2OrclWjg0OS52xAQCifyu8dEVQbGOWFEtt5hRSUJYrG+bz2p/
         a8oUIvzBfvp2d60eVHuy7S9bhVCmIPsCsdlkJX6PqUSU1ehfCOYyXLwfKdx3Kgo0K7lM
         GGpA==
X-Forwarded-Encrypted: i=1; AJvYcCWmoaQeki63ZBsowMiPPl2rH48zbfVRatIBnsESKd3Y3L4jU6tChjIfxW2DHJIPcbESRhRpKNF88nsZXFtkaMyyLMZTw1mb
X-Gm-Message-State: AOJu0Yza2sGmSmljWo4RGxqALHNpxIdtQQhE+ERLp9EBKfXF8UuXawU7
	B2roZ5r3rCckASixZXnmE+BkTfE7Ck7Jd5bpIqijb09rPpYKaB3VX4b7xWFQC54=
X-Google-Smtp-Source: AGHT+IFht8NxOCyg7z9RpFIr1DfT39gsfSL0btobRHEcyEuZAVDhEroB+sko5XU5BgaZjpnZPlp6Jg==
X-Received: by 2002:a17:90a:4ca6:b0:2c8:647:216 with SMTP id 98e67ed59e1d1-2c8064709bdmr1546880a91.20.1718906300684;
        Thu, 20 Jun 2024 10:58:20 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e56d5d31sm1996388a91.27.2024.06.20.10.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:20 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Karsten Keil <isdn@linux-pingi.de>,
	netdev@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 25/40] mISDN: optimize get_free_devid()
Date: Thu, 20 Jun 2024 10:56:48 -0700
Message-ID: <20240620175703.605111-26-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_free_devid() traverses each bit in device_ids in an open-coded loop.
Simplify it by using the dedicated find_and_set_bit().

It makes the whole function a nice one-liner. And because MAX_DEVICE_ID
is a small constant-time value (63), on 64-bit platforms find_and_set_bit()
call will be optimized to:

	test_and_set_bit(ffs());

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/isdn/mISDN/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/isdn/mISDN/core.c b/drivers/isdn/mISDN/core.c
index ab8513a7acd5..d499b193529a 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -3,6 +3,7 @@
  * Copyright 2008  by Karsten Keil <kkeil@novell.com>
  */
 
+#include <linux/find_atomic.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/stddef.h>
@@ -197,14 +198,9 @@ get_mdevice_count(void)
 static int
 get_free_devid(void)
 {
-	u_int	i;
+	int i = find_and_set_bit((u_long *)&device_ids, MAX_DEVICE_ID + 1);
 
-	for (i = 0; i <= MAX_DEVICE_ID; i++)
-		if (!test_and_set_bit(i, (u_long *)&device_ids))
-			break;
-	if (i > MAX_DEVICE_ID)
-		return -EBUSY;
-	return i;
+	return i <= MAX_DEVICE_ID ? i : -EBUSY;
 }
 
 int
-- 
2.43.0


