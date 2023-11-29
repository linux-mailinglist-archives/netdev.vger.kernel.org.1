Return-Path: <netdev+bounces-52117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922BE7FD591
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 12:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A35D282F33
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342DB1C6BA;
	Wed, 29 Nov 2023 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoEXngVg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43423137
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 03:24:46 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf8c462766so48681445ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 03:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701257086; x=1701861886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqbHmSBHyDiifA4Jyxx0ZxpzcDGefiCrTqwukJus35I=;
        b=ZoEXngVgEX8e1dgH/FWuFEDVmMw4RdSYKtqiApXJkATaBP7/fcPOolqg3v17W8mx9g
         RinRW++/r5b5jdcil/fGRf2R8HkTMERia1lOxnoDSxnt1JxYE5gyMZyJ2wh5e770jmi5
         1BM6OgFcwqPWWF5i5/QY0RSo4l0fzefeqNANwrhREcbt3+1VsHbzYQwgP6wZUyIsDdso
         gbrZRVQEm0jtzGLKVA5VTtJ9z5Yx/H/ezJkW2cZYJahKemGHOr/0+CBG4PK5DLk2FUrx
         rFivHZhJbxNJl6YWBvz57NuuvhAma29aD3gtQ+q0kBuPi/nJwTqpd3DcKbeiK4UZpcYf
         9blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257086; x=1701861886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqbHmSBHyDiifA4Jyxx0ZxpzcDGefiCrTqwukJus35I=;
        b=Ah2LukkJVj4QKfdznj0vaSY77onCyt2Yn/kW+QUjdYWiQSNqPjIpK2xOu9XL1/a2qB
         2ATwIr7OH4ninPkr9+hMuAFa+TyYVa1uEsxhdGKHJ1QNgA/3TJYDpLruyBhuJgEDFhdR
         6Z+WqzhXlWo1afRV9TySNrBiOSDQxj1tJDMTw9uZhm+YZt+KneEdoK+6a7IAuyEX+V+T
         433qF2WbA2Yay8ZWlNxHOB9YOMbc9BYIw8RtZI9fVc0jMSYBWVSota4QLUoxk1P4N3Dv
         ST72NGYCYlo/AbVkCluT+APqJu8HYi/BeFCkoDTclnplNBV5HjXxk6sTgPzLXcTgfhuB
         HlaQ==
X-Gm-Message-State: AOJu0YxijFzRGgEyZjEVMsd78Oqb2Tx4OxhyfqCfxNEc4S1NErx8/Mm2
	2IQDG+OLZmqIjPwbJHlWlt0=
X-Google-Smtp-Source: AGHT+IFHWYMdTVTSfsGCk8fDsPpGkHc38ybdSw7NPcTxeq0b8IsPB13SFusKJIRla4cMpvtKqqCKmw==
X-Received: by 2002:a17:902:db06:b0:1cf:c376:6d8d with SMTP id m6-20020a170902db0600b001cfc3766d8dmr12165665plx.32.1701257085724;
        Wed, 29 Nov 2023 03:24:45 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001cfd0ed1604sm5460710plc.87.2023.11.29.03.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 03:24:44 -0800 (PST)
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
	liangchen.linux@gmail.com
Subject: [PATCH net-next v5 3/4] skbuff: Add a function to check if a page belongs to page_pool
Date: Wed, 29 Nov 2023 19:23:03 +0800
Message-Id: <20231129112304.67836-4-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231129112304.67836-1-liangchen.linux@gmail.com>
References: <20231129112304.67836-1-liangchen.linux@gmail.com>
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
index b157efea5dea..31e57c29c556 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -890,6 +890,11 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
+static bool skb_frag_is_pp_page(struct page *page)
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
+	if (unlikely(!skb_frag_is_pp_page(page)))
 		return false;
 
 	pp = page->pp;
-- 
2.31.1


