Return-Path: <netdev+bounces-57226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E28C81268E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 05:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2017AB20BE0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E31C15;
	Thu, 14 Dec 2023 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di7xwpMx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241BD18C
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 20:30:01 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3ba2e4ff6e1so475268b6e.3
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 20:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702528201; x=1703133001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opH6yKOFCq1stbhjGctisEs2u/geFWIQgreNUuYpY7M=;
        b=di7xwpMxvO6T6ut9WOCN+BdzD/5vH4Pv4BBz2VNYT21bnzs/oxKv+12P8WxpzXQx/5
         ahHLZ4eTGBVNrmgF/4snJtEO1DRwq6Fn1gf4Bl+ktjGGdB5+veNzniUkJhvqFVlvKj77
         yEM7fwJgdxC9n5RXjTYhZUvh+fSxWpYP2tKr52hFKmgne+/xzJf3ZWMuraigHWY/WvtO
         hL/n+UL1j7kdHVQ/aYuNIeIKe5z8yj7IEfteADmbh2UQvxTVFEBh5ElEV9RB0W9okRmU
         71RK7I+YgssUzN24Ifj7XdA+qYHMvoMAdB6fvJ1gfjuYaxZOTMQGJz/yBUfyRl2ydWoZ
         DU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702528201; x=1703133001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opH6yKOFCq1stbhjGctisEs2u/geFWIQgreNUuYpY7M=;
        b=QFwjmI/yVJen/8bO5le+FWFZyrqQcrOE/6UzK8Q5i5ndpLVAFV/FCIJh3BcQg8SqCW
         AuwvPQYry9BkNKQTrGWzvFin7I6LEn+rsnFVQn6ItvwNOVb+Qf1DO4KOrzxx04ju8jIi
         fQwt7RJsD1bezKZtZ2LH9BjZrZNHCqaBDXSbabcW6LFWSIRPkZDgoZcZY77w1yuZM1xR
         IKtjqFqvxpDTVpQWQRei1ykqhHwv7D63gmajP6oFswUg0Zb5QukWAXAGp6qqS/+7JlyV
         sFdLpdBDKfM8TgEhVGQ7pJ79kCgjHs9dn3OSAmriSIp1ZzENzsNF/C0r11heWDtoVC2j
         aRRQ==
X-Gm-Message-State: AOJu0YwGh+JKaLF+23wBDIgmsTmXbCHaPKu2WCyMuyvZ0pwkjPXQjwc4
	6pDI+x4kwmJbP1tRqRXPGDM=
X-Google-Smtp-Source: AGHT+IHSq6tyRAQm9rDpjkg41FXCqzWiSEqWUK5GlYuKbUmJf1v17FW4NuGW4kDFUIVkGsgxTsMwOw==
X-Received: by 2002:a05:6808:1924:b0:3b8:43d6:8cec with SMTP id bf36-20020a056808192400b003b843d68cecmr12400014oib.33.1702528200859;
        Wed, 13 Dec 2023 20:30:00 -0800 (PST)
Received: from localhost.localdomain ([23.104.213.5])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001cc8cf4ad16sm374412plb.246.2023.12.13.20.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 20:29:59 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Cc: netdev@vger.kernel.org,
	linux-mm@kvack.org,
	jasowang@redhat.com,
	almasrymina@google.com,
	liangchen.linux@gmail.com,
	Mina Almasry <almarsymina@google.com>
Subject: [PATCH net-next v10 2/4] page_pool: halve BIAS_MAX for multiple user references of a fragment
Date: Thu, 14 Dec 2023 12:28:31 +0800
Message-Id: <20231214042833.21316-2-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231214042833.21316-1-liangchen.linux@gmail.com>
References: <20231214042833.21316-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Up to now, we were only subtracting from the number of used page fragments
to figure out when a page could be freed or recycled. A following patch
introduces support for multiple users referencing the same fragment. So
reduce the initial page fragments value to half to avoid overflowing.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Mina Almasry <almarsymina@google.com>
---
 net/core/page_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 106220b1f89c..436f7ffea7b4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -26,7 +26,7 @@
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
-#define BIAS_MAX	LONG_MAX
+#define BIAS_MAX	(LONG_MAX >> 1)
 
 #ifdef CONFIG_PAGE_POOL_STATS
 /* alloc_stat_inc is intended to be used in softirq context */
-- 
2.31.1


