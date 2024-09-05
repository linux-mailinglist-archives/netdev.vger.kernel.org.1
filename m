Return-Path: <netdev+bounces-125525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C78296D85F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0D3288FA1
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BAB1A08AB;
	Thu,  5 Sep 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtotPNk0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A901A0714;
	Thu,  5 Sep 2024 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538847; cv=none; b=iyTxSPZq8LFk45GEFNXDllckT4+HDS756wSqGs3ym3erxhocBGhDG4ht8xZfp3r7PoFZtnr1Gfy7/UZX8B1zk0qOY4CvL6vhOO0OJkULHX1YgOFH77H3PIpQCG1wLInII+soKliIoKqmvGr1E3d7ae0x3av1t8DL6oFXqNT1wR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538847; c=relaxed/simple;
	bh=84MM6JTVspuKKcVeckzhRC07JdTUl9SJEHiWg8mSABU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFlLVp3lzLuBl1DLTEG0Dmxdn26Q79G71PuD6uph8L2bYevZNtj66WxlFqgipNnUu4zP+9dVznsn0GxKxUTxETow5x63vocNCucVzGumaL9n5rYLnVJiX9IrJN3R3Vw+bh+BmUGg4DAi0Suh1H3BF9raBgjr4Bhq4dqz8hXvfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtotPNk0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bb9d719d4so6316645e9.3;
        Thu, 05 Sep 2024 05:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538843; x=1726143643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOxczkFwiDGKPc4Q1Be0RBZme5IWUpiyWu4JPki7X3c=;
        b=QtotPNk0T4ZfEyvwAbu7iVbwvUZZDtXFI73QLCJs0ZBjhH6Z42k5joLCI/64iVL4Wz
         PRSzJzuIZJKatqlT3iK21VFr7LRX9wp/hEgXKhIShMUO8iHAOqhHb3kWkJBrLIX8a58d
         cCSnNdVqJPvgmuBfcK42Rzdxxd4rEW+Y7EWxCl/3CAh+F99EWTiLMGotQ+kTs2JBWJRN
         HsU0W2dsFTh25igAZNoVDzOF2u/f7EGrfx0JFCatD0v3WjGFO6TgKosB/lobvENUZ8Mu
         BAmukx30X5x6fvT43YiPQTM7D5yoQd5dTpbtElXukafpb7nztDTsVjIqURziaRPHVg7i
         p5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538843; x=1726143643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOxczkFwiDGKPc4Q1Be0RBZme5IWUpiyWu4JPki7X3c=;
        b=isF/00mnn0z08Jwbe39ItECOjHN9axHkywRYnJVvrKAbwur/R6WrHKAL0qtnbQyizN
         q8U1d6GDuezuuokav48Tk1hWzpQppf1P+IsJGTPdm96g3/T8Y8TFEGKKwbhHmQ4jsjjE
         e85G+E4bnQa1H7nACPq5tl6upY9TaSjJ/JbzTWFnC0aN8qiqdJRch0XBSAuDI8D9oV/i
         T/QRapOSZ3RUQcPhz60zyCzGwjpBF1G1Ysoof3XK2vTcu8ng9YS44+WyiHFFnOAXMycv
         ElL4DtcrrMqFquhRlSgE393oH3bzNcaNKWkhMuGosQvLEOX11VDTfkZcTdjacrh/Mdqe
         CuZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiBiY6YxTaKjzVGTgHWuUvHl2w9MHIiQYJTw5RQs8E7Lphw5ixF8ofvlbWHOgZrYN5g3vwO80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPftHXfvRQ88e+fecq5R4ofhpOE0ui9HtZtYRTbpkOIrJqr0fQ
	qQn5GcTumis5cKaPOvfJFkBTIjz+hoZj0O38mxgjBqNbkldNDL2vSg0HmLIeID8=
X-Google-Smtp-Source: AGHT+IFIMOtWTE7nc52Zm83jQ/AiqL2iSABH0dSCn1yNfiRYu8xGM+H5TXzsTWsjAVAdNSNf1k5bLQ==
X-Received: by 2002:a05:600c:1d9b:b0:426:8ee5:5d24 with SMTP id 5b1f17b1804b1-42c880f41f0mr82578955e9.20.1725538843022;
        Thu, 05 Sep 2024 05:20:43 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:42 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: [PATCH 14/18] lib/test_parman: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:22 +0200
Message-ID: <20240905122020.872466-15-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of pseudo-random functions requires inclusion of
<linux/prandom.h> header instead of <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
---
 lib/test_parman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_parman.c b/lib/test_parman.c
index 35e32243693c..f9b97426a337 100644
--- a/lib/test_parman.c
+++ b/lib/test_parman.c
@@ -39,7 +39,7 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/parman.h>
 
 #define TEST_PARMAN_PRIO_SHIFT 7 /* defines number of prios for testing */
-- 
2.46.0


