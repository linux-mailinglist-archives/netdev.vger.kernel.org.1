Return-Path: <netdev+bounces-200775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE5DAE6D13
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 027497B2E33
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23D926CE3A;
	Tue, 24 Jun 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNSe8XzP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A826CE14;
	Tue, 24 Jun 2025 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784238; cv=none; b=TqvXfNwlBuNp39xcP9uiyk6JP7wPETYKwa7fvXtReSfuxu8sUVva3xEW8MxoS9pptKL+Y3kqXaUUxhO5BiFpvv7sfsphNOrAPensFVZDhX+99Dw3GlUbru9SuLB6nbvxza8HGDHx7A6IhzX1bfXLLjGdj4UC2Z9Uo1guGDqBuUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784238; c=relaxed/simple;
	bh=PCeeZOwI/irjOE8p3u9Oq+RiilT/ViQuulQmfvqJHco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQKMYG8T5CfwzEOfF9VemnNTGjZk6s++ka3x8iiwwGIDB1ZKoNleat2uqQ0PRoiD/gbUKC6xFiak3rGuRCdRgIBONECjD5/fHNPFFdM6akzi9p1F65dX65rDpbdiDLAC7cvjR1n0CEIQIZtW07uHbN2xz5hmIZjRjcEFuLGen4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNSe8XzP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450cf214200so50258155e9.1;
        Tue, 24 Jun 2025 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750784235; x=1751389035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ag4mnC5eJRCUxLTReat2RQLI2EcUmNe/wTygZNWu1eY=;
        b=TNSe8XzPJCUXUls9ujHEgvX3onAXjB7XVoIQ45AjIj8sV2ZCOkImiqsXXE4vLL7KGo
         KtCLzpJ0AmJ81NLmw/F2VC1N+ENHlWeOwhzNidXpZXFj+UEmAkCjGl1lME7atQSKwUdy
         dL2Q5yDRZqoFoYykBo3xhO7ButjlTrvoJyBSuuoUBHIjF70Px4rotyoIE5IV69P3NihL
         kY+KvZ0+bYlsWtQXTbRiDCF7iU9XQZJV8MGiLv1bx28Xz6JUTzOJ6txFuozHLf14Wazt
         Gd/RGrNjRQE3AI7WLQKcovAsfUhuJDl+DtXC2sms8OReuUjavfkNTTTbeFcK5p8vOQ+j
         QrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784235; x=1751389035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ag4mnC5eJRCUxLTReat2RQLI2EcUmNe/wTygZNWu1eY=;
        b=TNups7dqAr1jBY6umfd3Ti0W94E9hfOH57lmlhUGIu7DQocVqUtcqXttDCTgagfXcd
         7nX9yUiKYtjt3Un4xj/pohcGd8jVq+zstiZ381WkCcpgkcl/dVQ/aRZwaigbI8Oy27OD
         wv/UtwR305dJUlXLIiPA7o6E6FkerCJdZ9praftzbIOpsv9hMXeU2cPVQj0i3VoMaWuT
         zkO9zI+5L4LUvm8W1gxnrdKcNSHB493K/RdfSJ3e5r9d7DoO6MBA/jbdkaj7Q2gBsMlb
         9rbdbrTESiDkNcMczQt4+e9uibQaxRa/pYrdP7BnzQlUPjjbtdzviAsWu1zg+Jv/r25f
         Q5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWjYXin1eNzcdqyT/Uqx1gt/dKbITa3PcNtmsBzQ1oZ/5fkw/ZaZjJYTxL/0IUh9DxDdei7T7dEXMCF9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rmNRUVBeAjG11iWx4RslimOTYyklPIETKfV58Zyi6x3IyOQl
	zoxdYQrbc0cP0PYIUUt/+r72Fs3oMcXWr+1hWHF+5G3X0Z0iBNTj56MyKDzQsg==
X-Gm-Gg: ASbGncu4YjlF7M+T3Mz8zqLwisWBYaa4qF/wLiof6QoZNgCuM3pS6nuSuRGtxlvzqwk
	s2fI4jRRGYRo1mY1GmFOB5/zsNUwl+08O/roUL+6cmHIZd7dr9zhRkpQG2e6GFUwlIu0K4O0EHK
	AmGWfThufzlCQ/pj7Bz8UPOCUdn4o9CVqOrDHuxJaneHkTqUuX0fVLIfflISOTz8+UFBka7l/K7
	oZEHReGc9M3b4lD3Vu3lbYzQtMRyksh01bY0Tf61GaxFWpJM1dgEujxCxW7YJIreXFp7UdVAeYe
	1BmDI41qAYxSuvt7J+/8zJGMnOR+yPbv7z9jRsrBy1n8SvKtHG2jUZg=
X-Google-Smtp-Source: AGHT+IG1TaQhopggRtFZ6BxchTOnnB83lYHTD99p9uLYRGv+Klk5Jx5Ozewl4M8JhKfOOCw1SsmBnA==
X-Received: by 2002:a05:600c:8b14:b0:453:a88:d509 with SMTP id 5b1f17b1804b1-453659ca92cmr202500195e9.10.1750784235133;
        Tue, 24 Jun 2025 09:57:15 -0700 (PDT)
Received: from i5 ([2a02:3037:6e0:5198:a4:1088:ac76:adf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac92c6sm181464355e9.22.2025.06.24.09.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:57:14 -0700 (PDT)
From: RubenKelevra <rubenkelevra@gmail.com>
To: nhorman@tuxdriver.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	RubenKelevra <rubenkelevra@gmail.com>
Subject: [PATCH] uapi: net_dropmon: drop unused is_drop_point_hw macro
Date: Tue, 24 Jun 2025 18:57:11 +0200
Message-ID: <20250624165711.1188691-1-rubenkelevra@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4ea7e38696c7 ("dropmon: add ability to detect when hardware
drops rx packets") introduced is_drop_point_hw, but the symbol was
never referenced anywhere in the kernel tree and is currently not used
by dropwatch. I could not find, to the best of my abilities, a current
out-of-tree user of this macro.

The definition also contains a syntax error in its for-loop, so any
project that tried to compile against it would fail. Removing the
macro therefore eliminates dead code without breaking existing
users.

Fixes: 4ea7e38696c7e ("dropmon: add ability to detect when hardware dropsrxpackets")
Signed-off-by: RubenKelevra <rubenkelevra@gmail.com>
---
 include/uapi/linux/net_dropmon.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/uapi/linux/net_dropmon.h b/include/uapi/linux/net_dropmon.h
index 9dd41c2f58a6..87cbef48d4c7 100644
--- a/include/uapi/linux/net_dropmon.h
+++ b/include/uapi/linux/net_dropmon.h
@@ -10,13 +10,6 @@ struct net_dm_drop_point {
 	__u32 count;
 };
 
-#define is_drop_point_hw(x) do {\
-	int ____i, ____j;\
-	for (____i = 0; ____i < 8; i ____i++)\
-		____j |= x[____i];\
-	____j;\
-} while (0)
-
 #define NET_DM_CFG_VERSION  0
 #define NET_DM_CFG_ALERT_COUNT  1
 #define NET_DM_CFG_ALERT_DELAY 2
-- 
2.50.0


