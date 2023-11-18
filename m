Return-Path: <netdev+bounces-48924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB2A7F009A
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 16:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169201F22911
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C20B199A5;
	Sat, 18 Nov 2023 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CliZe3Tk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E921FC6;
	Sat, 18 Nov 2023 07:51:46 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a86b6391e9so34000057b3.0;
        Sat, 18 Nov 2023 07:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322704; x=1700927504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0d2eKvr3TXuVBrgKyJ84PHfbsLaO9M1lKSW9z0G3/1I=;
        b=CliZe3TkN7RwUCns6Euw1bJup2j6ayFXl5NT81h8uTPGUvhdBUh5diVVPsw3bAbv27
         WZ2XqtPAIvvkC7CD0hD9ixz4h1RcDLrTHRS74k6yrVGcpAiwFT2AGBj0AU7of/fywI/L
         JTTng5KOCH3F3F3JG5l4LczIrrFtSuo46cgoPeRbag2VvuLz7te8cEiyJA9x5SqAc1kh
         K6jXIdOvZhFRpD6r4hAFZf6CykGW9soyWPMRYXBM86k5SaLBbiFH6ulPZlWh+Ur7AbFu
         SLkqGLq07GRBd3MckE6gBcEmhEzwiHsA3J+7Abja/qAvN0ewCQxmvDr8ZSfEaekFZKXm
         5+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322704; x=1700927504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0d2eKvr3TXuVBrgKyJ84PHfbsLaO9M1lKSW9z0G3/1I=;
        b=v8DWeUGOsMEG/nOvZRXGtQNXetznK5b3gSHY4FMsJ8voW2KhCYXJDp74yXgG4jmx4B
         Wy9Gau/uMpkHhVxMJt7zmBzljsdJ+36A3OtccYlnIudugKhjJN4/BiuSvZb2ywamXYSz
         2Bb6vfTV4At9BxwHjxbtLckWpxn601w2TFmsmvCcmenZ1nFPyvmWlasTvDvZYOXMMRod
         Cl0INW2+LHrQKCAupymrRRoYbzqyA2+cOYckP9Ra28SZEE/xp7pKkwze5ah8DWk7emD6
         Bi5KUwp/U7SQ6+Uu6RBtgmkedDDa6BYDFH1KMmXnXDpRkPVoFHS34SakTDxdTL/Epbrh
         ctjg==
X-Gm-Message-State: AOJu0Yyq9LqF2t7qh5s0Wd4QMBlkDaTzp3ujSBGrTvuYla/skZJYY73y
	18FYq+3z3tuDesfzS9/tv8xd7W1czoz0mznF
X-Google-Smtp-Source: AGHT+IELqoxPTAIh1lB3sdLeAXBXNyn+zXCWPkZuWXsEeemBrT9Rti9Mc1tneRNCARA0PmaLxTdqxw==
X-Received: by 2002:a05:690c:2a85:b0:5af:66e7:e382 with SMTP id ek5-20020a05690c2a8500b005af66e7e382mr2522479ywb.34.1700322704464;
        Sat, 18 Nov 2023 07:51:44 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id q126-20020a815c84000000b005a7c829dda2sm1170423ywb.84.2023.11.18.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:44 -0800 (PST)
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
	Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 24/34] mISDN: optimize get_free_devid()
Date: Sat, 18 Nov 2023 07:50:55 -0800
Message-Id: <20231118155105.25678-25-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_free_devid() traverses each bit in device_ids in an open-coded loop.
We can do it faster by using dedicated find_and_set_bit().

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
index ab8513a7acd5..3f97db006cf3 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -197,14 +197,9 @@ get_mdevice_count(void)
 static int
 get_free_devid(void)
 {
-	u_int	i;
+	u_int i = find_and_set_bit((u_long *)&device_ids, MAX_DEVICE_ID + 1);
 
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
2.39.2


