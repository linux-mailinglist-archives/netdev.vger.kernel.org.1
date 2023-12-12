Return-Path: <netdev+bounces-56184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFDF80E1D9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924BE1F21B95
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13188C01;
	Tue, 12 Dec 2023 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUXJt/Hu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A426137;
	Mon, 11 Dec 2023 18:28:33 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d2d0661a8dso51964567b3.2;
        Mon, 11 Dec 2023 18:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348112; x=1702952912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k5eqiGBj5/5DwPtrpE4m/Ucis1bOkRyK/lvgWCjgQY=;
        b=MUXJt/HuzQG0n1pJk75TJsqno0B2RvcwtJqS6p6vIJlgw1ENOKUWFBLtN9sECruBaA
         BT7mTAvsKZpNTqJqeoHviKjchN1kfYKsQ4ubVXQdE/KLdbzJ7cep2jg1k73GwscQIcqk
         gy0oFv+aixeijNbjGhyx6qDshbtGJg6ytqNbfI9Lf6Lv23VsIu4CEU9WU8kXTjsW+Etd
         6BTxKdXV2xKa96TsV9wQTIBLNNQ3oszSQcw+k/V7NrruYlaDdYTwxPaAFySc/dgAanTo
         W/qi3vCWyxQhTRoO1FD8FNdfZ6XQCqv7HcCvZSj1X+4OvRJJ7aetyb+9aPX4gMnA6hCp
         cDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348112; x=1702952912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9k5eqiGBj5/5DwPtrpE4m/Ucis1bOkRyK/lvgWCjgQY=;
        b=ntA55nGPN+V0t5PPS9K4HGaTv8qFmHRbK0iflEpdbhW1vyrEtNLzU3b5YWSoSRStrB
         TrCHjjPqCNi4vjPIWwWO5Gy9D5x+9AxdIa9MsxXVIjySOkilODoYVhDUnlTc3P8iXlGl
         kE82tM/kl5+QYZJK17LNV/LLiUCppm/fcUcdqf3nopxM2ZqX86F4X5IdNXKkmAX23dNU
         JjeYMuKEwmmEdq0YD+8+NKDDbdNsWzuJwwoKHwkwBwvLRpiLBg7pg23gN7WAW5UeANs0
         ktImQWH52cCyh7/PSynTxjZAlDBcDIEeKwWINbSpobwCtMcyoG7d0Mv/xFqgH/Le7t3z
         UqAQ==
X-Gm-Message-State: AOJu0YwAeJhOXqdgraCkXo0Hg3mlJtbtt4s39pTb66cMQ0cZRdel/tpr
	2HKobexFJ9HzZa3ehRy30cLb4S6NwSRiMg==
X-Google-Smtp-Source: AGHT+IGv28WoB4lgSsY3KnWz4m20syHxTtIOJodmzHgYhM/BE/Qtyrxdpfg0dGSVdZSH2dpq9w2ttg==
X-Received: by 2002:a81:8245:0:b0:5d7:1940:b399 with SMTP id s66-20020a818245000000b005d71940b399mr4634837ywf.101.1702348112320;
        Mon, 11 Dec 2023 18:28:32 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id v6-20020a81a546000000b005ca4e49bb54sm3359875ywg.142.2023.12.11.18.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:32 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Karsten Keil <isdn@linux-pingi.de>,
	netdev@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 26/35] mISDN: optimize get_free_devid()
Date: Mon, 11 Dec 2023 18:27:40 -0800
Message-Id: <20231212022749.625238-27-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_free_devid() traverses each bit in device_ids in an open-coded loop.
Simplify it by using the dedicated find_and_set_bit().

It makes the whole function a nice one-liner, and because MAX_DEVICE_ID
is a small constant-time value (63), on 64-bit platforms find_and_set_bit()
call will be optimized to:

	ffs();
	test_and_set_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/isdn/mISDN/core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/isdn/mISDN/core.c b/drivers/isdn/mISDN/core.c
index ab8513a7acd5..c829c4eac0e2 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -197,14 +197,9 @@ get_mdevice_count(void)
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
2.40.1


