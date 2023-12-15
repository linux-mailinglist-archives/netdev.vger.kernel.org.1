Return-Path: <netdev+bounces-57767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5268140A5
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2593D1F21CD7
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7C2105;
	Fri, 15 Dec 2023 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/ZQhlA6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259646139
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d9f514f796so270313a34.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702611044; x=1703215844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI/pevRDCNy4vYxDqxcAE7fyraFb/oxZUUZjdb4fjPQ=;
        b=d/ZQhlA6yW3MTv1aeGRwe+t5aeJme62sSjgtPXskl/SdGTJpJtlB6VOFplxnXaPW1o
         PgqvYfQbuIWLMgi3+OtNhBmDnwetrkmCZHH+tGr8VIgR9ZGNVz+1YW2cyG3AF0x6X7Ta
         bGdzyILIsSbyJcO9GLvBylb4sqxWTmVXKibsVeEbbTLdsKiKdP4GcxdUh8wcT7+Y8KpM
         pCL/y9K/lgMLonp4Ahf4Mpa3HF3JTPw8NC7J4O31negZqkBlPKzbt0UA6qQJ4gSeN6+q
         2BeEsUTYjKJw6kPYKRlKcJpQBcP66pOhhmN+UxhxQBS9tfLuQndKrG0/Fw+xVSMcTFWa
         pk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702611044; x=1703215844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MI/pevRDCNy4vYxDqxcAE7fyraFb/oxZUUZjdb4fjPQ=;
        b=GXqm4UjD52zrfT3Nre30D9fxTJTEMsvzddUmRe15xmbGmqiqD8f+/0vrbaYMphee9T
         Z0/BWv73j0Bn9m3bT/DrDscOWRVgUrLkoSVXAfZSGONP4EYzLrpFj4UfQHy+bkkrhGfq
         nyY+7aTr0iKLgVAu834Kd1kS1IEW/8eNkVOnKo4WxP6E+8qDt4368z+dOSI+9kTZi3td
         vKZbrwuTaIM1JClRcRtH3UbsO8KYFVQEpp9teE8srOiJvVY7bBuztpYoZCW/aZMgs1zf
         msOHbVH38ar+2Gj2bUQbHVhq2xsMGl733V3+g1i2OLatCt6hKQVvnEJC+f+IJkrWdRYT
         JfUQ==
X-Gm-Message-State: AOJu0YwjVQzB3oAluWjtW4Hl9gk5PvaAYanI9R2Cy4ZuI+11EpubWy9G
	HVdGgIGKTc/Y9vkdliflmZs=
X-Google-Smtp-Source: AGHT+IE9jy9xMj4IKO6KzKkguKf/Za6ZBk1XWhGZM3Gmfsw5ymUQr47IcQW4ZYykkWGi2w3qT/ZT0A==
X-Received: by 2002:a05:6808:219f:b0:3b8:b2cf:3106 with SMTP id be31-20020a056808219f00b003b8b2cf3106mr14357003oib.25.1702611044238;
        Thu, 14 Dec 2023 19:30:44 -0800 (PST)
Received: from localhost.localdomain ([23.104.209.6])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7850f000000b006ce467a2475sm3702775pfn.181.2023.12.14.19.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 19:30:42 -0800 (PST)
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
Subject: [PATCH net-next v11 1/3] page_pool: halve BIAS_MAX for multiple user references of a fragment
Date: Fri, 15 Dec 2023 11:30:09 +0800
Message-Id: <20231215033011.12107-2-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231215033011.12107-1-liangchen.linux@gmail.com>
References: <20231215033011.12107-1-liangchen.linux@gmail.com>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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


