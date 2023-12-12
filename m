Return-Path: <netdev+bounces-56232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2052E80E376
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBC32824DB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C93CDDAA;
	Tue, 12 Dec 2023 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhNC2WFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7012BF
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:47:08 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5df49931b4eso29034757b3.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702356428; x=1702961228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy8mPAbgU8ZgrcQ/1h5szjJtHjD9gGgnTRkW1ZyBk8I=;
        b=MhNC2WFX2V+LkBtM4LbhVzf3uYO4fOO9u9tt0udkojda5t/YmsLlGgs+LCiQkZ920D
         EpYZqB2FRPatZoTw9oVG4NAyhlHwuWIqpk5pz4RhvnCX2amUYeG4UvbvOyM8ftMadBY0
         oJc9cVqHY0/9UPYQCYdS1t8Deff6alHd2DL2TxsGRHmNVoFgHS6G1lVOSR/IqUDY+2JM
         1pgsZwYKR6FmK0k99VAGikfX/lfFGvuCOM4xQj4Ma73dU39504lUDj0Ath7z7Jf4i//Y
         dYvrj0LUcqV+Y1LLl3oyEcyylBpJgx0znrN6Oucj4qT16K0/FJEA3nM2zjubdg3f+hbr
         pK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702356428; x=1702961228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xy8mPAbgU8ZgrcQ/1h5szjJtHjD9gGgnTRkW1ZyBk8I=;
        b=CrrOWyAObvbYkAS966qFDebm7aAniLkfZJYNVkxMRqdn6W1/sguRQqHCpvuRvKJgBD
         ZHuG/ZnoQS6AQc2iaSGHFnLpXtOSv8lgEQ0GXkQ70OdAqKUoZBPfa1bBZl+AoRHYHjSS
         u+nZvx282VmXd2CakYYmy4rrsi0i9NKF0a2GVwbhxB+Ot+6gsdwqb6dOSc/Z2KJDziuS
         oXBU7ixAYPGLL0jKd37yivWposQUqvHg5yUGlvp0vP0VYMrkWbWc1dG4/M5giZf7zrwa
         xuKH+2c9lsOEOVfT4BPgi/6PLSl/zSppnLtQuXbmBNwF6rmytUxWVqgDv4Eytg2hjC8s
         2lIA==
X-Gm-Message-State: AOJu0YxgLAKJEt68CyiyxHMoxmefkT77FB2bgpwE1kJK9KdH05OC0h4z
	Ce4q6Pej1snb7DWGpWCpUUc=
X-Google-Smtp-Source: AGHT+IGA9g8eE/SWDu6q7E6jkPopxD7eyMd8Debz34dZKa+HpahnBf4xnYfPaJXh/AvFaLurymReQA==
X-Received: by 2002:a05:690c:a85:b0:5e1:ddc0:1af1 with SMTP id ci5-20020a05690c0a8500b005e1ddc01af1mr430791ywb.33.1702356427970;
        Mon, 11 Dec 2023 20:47:07 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902848300b001d33e6521b9sm36143plo.14.2023.12.11.20.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:47:06 -0800 (PST)
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
	liangchen.linux@gmail.com
Subject: [PATCH net-next v9 3/4] skbuff: Add a function to check if a page belongs to page_pool
Date: Tue, 12 Dec 2023 12:46:13 +0800
Message-Id: <20231212044614.42733-4-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212044614.42733-1-liangchen.linux@gmail.com>
References: <20231212044614.42733-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap code for checking if a page is a page_pool page into a
function for better readability and ease of reuse.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 net/core/skbuff.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b157efea5dea..7e26b56cda38 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -890,6 +890,11 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
+static bool is_pp_page(struct page *page)
+{
+	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
+}
+
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 bool napi_pp_put_page(struct page *page, bool napi_safe)
 {
@@ -905,7 +910,7 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
 	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
 	 * to avoid recycling the pfmemalloc page.
 	 */
-	if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE))
+	if (unlikely(!is_pp_page(page)))
 		return false;
 
 	pp = page->pp;
-- 
2.31.1


