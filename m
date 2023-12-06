Return-Path: <netdev+bounces-54371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E319E806CB8
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83834B20D80
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F23034A;
	Wed,  6 Dec 2023 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg7pYInd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD7A9
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:54:48 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cb55001124so572033b3a.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 02:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701860088; x=1702464888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2d8n0WXue9ygrbxloUCx8WAoE9HhkQ6PXxWrjAEYxU=;
        b=Lg7pYIndf61QlWmisT1xcj50caZkOYEXWP/lIJCmvqSCc0xP6GjZ6KgBZjb+Ogv4f1
         8cT0H8Cixtmg2O3JC3p04iopvY5ePpfDBVa0OF1tR1AHD1HncnvOGIiHUUb2q1FMLslB
         losWj1b+gL4VhILdX1bL2sgO8S6ig16OpNQOa032il+W91m6z9aD9uZc/Dxyp1mnMNvw
         VbLzYeR+aRFDUNo3vlqszGWeuJn6ZwTYNpl/PYsM3QNykZgFwC1eleWVavYflfxgGM3/
         raO9+H4XLkMTYfEuavRgxYHtC4gR30nbt31TCbVyHYE+9NR4N8dVpo3Al+BQG/Nc0IIl
         MEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860088; x=1702464888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2d8n0WXue9ygrbxloUCx8WAoE9HhkQ6PXxWrjAEYxU=;
        b=l08+POpgEmKNnd2lDB1TgfL2XElDbGtOtrSayOLqyAKi87kka05IVIpkrYVEr356ZO
         Iw+1kR81yRPQNxfRnO2iehbcjb0sT4AdiJPb6f2UQtBVmnQb6MPzhJsbFAdck3NAaXlT
         Yd9XQUmO/G/wDf7CAf5qfL5YhbRyeyuhW6OjY1Kr76NyxCU4PijdNpgTIZjCNv8737rt
         3gcKzuLK2KxyfBAfKs4mOR6AAgcy907FcEL+zWXuAWlomkBNyu0S5nBvAhPejhtak3Be
         EeqoJZEh2Gf9wMGMZdZoyZxNAzkc7oxlQk1w76Ioq30mExgisIUP5txNv6/hx3Gi0QTv
         n7Hw==
X-Gm-Message-State: AOJu0YyN04dvFK2JG+I4BVnJ/rjoow66ogm/jizI2vUFGIUtDw2FecXC
	L92N4m58o18FnxS5b84CORE=
X-Google-Smtp-Source: AGHT+IEd77h94hhs6J/CMTnJCe+7Ml/LiOxXG4jzQ3aQZou8zSYUeYniVYIbULJrzgmovOv3R+QYrA==
X-Received: by 2002:a05:6a20:54a0:b0:18b:1a31:ee6a with SMTP id i32-20020a056a2054a000b0018b1a31ee6amr4104734pzk.23.1701860087999;
        Wed, 06 Dec 2023 02:54:47 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id n15-20020a638f0f000000b005c6801efa0fsm5388796pgd.28.2023.12.06.02.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:54:47 -0800 (PST)
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
	liangchen.linux@gmail.com
Subject: [PATCH net-next v7 3/4] skbuff: Add a function to check if a page belongs to page_pool
Date: Wed,  6 Dec 2023 18:54:18 +0800
Message-Id: <20231206105419.27952-4-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231206105419.27952-1-liangchen.linux@gmail.com>
References: <20231206105419.27952-1-liangchen.linux@gmail.com>
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


