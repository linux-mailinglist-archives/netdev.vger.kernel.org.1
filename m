Return-Path: <netdev+bounces-55700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA71F80C025
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 04:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950F5280C63
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 03:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EDD168C6;
	Mon, 11 Dec 2023 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVkoZ1/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0316F1
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 19:53:27 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28862fdfb44so2958651a91.0
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 19:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702266807; x=1702871607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2d8n0WXue9ygrbxloUCx8WAoE9HhkQ6PXxWrjAEYxU=;
        b=CVkoZ1/EqOhWB+lBgbfq4Bzh2V1BIROBlPUH5YNmyscLc5gv+b9vza8oMD8xvQw4/U
         gK6wNkzmnYYx5nUxLv/hCT5W+qLWbeY4cl0rwzKnfFXFF620FX5TVAILKvvlIRDNwZJ9
         ZdtbGXhaPnTSu9LGyLzs8fSrbSMoiwHx258deoIrEdr4QYS7UifvS+kTc2eMejSdUJk4
         oZI3/wqgKq8KTzJ45QmoJapWALNkzQA5TFb9a66XH5v95Unpz9Ywyq/RI6kbNfce2V2n
         lgJcoLpCziB+PzPJZNqi+os4lLRCRlJB0CrNoDRuER4fUC2RMZHPWk4YCVz7NvztepVW
         SM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702266807; x=1702871607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2d8n0WXue9ygrbxloUCx8WAoE9HhkQ6PXxWrjAEYxU=;
        b=ryf5OTMvcbpXc6i1df7proUIm67qiSsTgglKA0t8+tiy3PuO1pUH//IwUMftYZEylv
         CZqlAEltZMzGkdW1zhHNLiOzxudRVtU4MMpwiMALgyM+nEH69rrQXgFLzUF6E7SUgFy5
         iuuTz+h2xPqSKgmGSDxVIoo//6firflMkRDv8XQfCXJirEC7e84vwd1Pq9O68QCtsae1
         UY2k/3silM/Tuzy+px6tXWGO4glhmt9LHCmYHW15Tag+F9jUs48CXLot5vv+LhgCRoGv
         83LEapFVpmqc+kl1pp9EApyrTXIe6Rsjun1viqPwj2cO+vPPo/0ICrtnWGObxyDHG4M+
         d4UQ==
X-Gm-Message-State: AOJu0Yw6TpxHgStOs0MEIYlNZI025eUigiHG0FthOFZYKQGIiMC7jn3/
	O7m4nxLRu/S7cfJXPAxoycgNTK0Rjeo=
X-Google-Smtp-Source: AGHT+IF/9zzYT5dBgAhPgi9UwWntEpQIso8WA4BYMk8jEYQTrt8722TIA7PHJFeT1xdLlXRfSo/WOA==
X-Received: by 2002:a17:902:d4c5:b0:1d0:91c3:aaf2 with SMTP id o5-20020a170902d4c500b001d091c3aaf2mr1656471plg.25.1702266806761;
        Sun, 10 Dec 2023 19:53:26 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001d052d1aaf2sm5411491plh.101.2023.12.10.19.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 19:53:25 -0800 (PST)
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
Subject: [PATCH net-next v8 3/4] skbuff: Add a function to check if a page belongs to page_pool
Date: Mon, 11 Dec 2023 11:52:42 +0800
Message-Id: <20231211035243.15774-4-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231211035243.15774-1-liangchen.linux@gmail.com>
References: <20231211035243.15774-1-liangchen.linux@gmail.com>
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


