Return-Path: <netdev+bounces-57768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506CE8140A6
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D18F1F20FF2
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F0346AB;
	Fri, 15 Dec 2023 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S14cYUnY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AF5692
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ce7c1b07e1so180159b3a.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702611053; x=1703215853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12hd2wvEpjx1jjZIuoo9JjQkayQ2+EIXRatonagGrWk=;
        b=S14cYUnYIIcE/Bju0C1DbU3Zsfsc6PMAZlbFv66yksf6VT1QxhqUFwu9x5J2L2FgN1
         6JMC24U486pmpVEGn7ghyYobm2IKOLF1aq+uWa6574xc0vgO84dJl+nIMglFGjUQ5ww7
         z1qzYvAfipORZ0dJoqnFcs1ngGW/bKusVrgsj/mUkKb1G2hr7Eb0p9U3oeWbh4Fi3JX3
         fsp490V7TW4grW+EgY2gZJ7L5z/y18OLJwUxp7stM1paMFctrdWyowujGhlG1NguMhaj
         OGEvr9uEcmn7r6Kwus8tbm+PEjSzTImMqKOZEWc5+E64dB4ZgiMR/pOEeEgM6vRYA8Mk
         jMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702611053; x=1703215853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12hd2wvEpjx1jjZIuoo9JjQkayQ2+EIXRatonagGrWk=;
        b=ddOgUTVxkiZhbNe8Fge1mnd4iKQzXMqArPXdcfi6cAEbqb3KNL+2xq1JWSydbeOC2t
         y7mhZki2mjvyZIZCvHIqOpAnCBHsr3eH5/Qt9RWEmIKJE1JAELVWQgYTTWBSH/K4Ldyh
         atX9ESBQm6iajD4AJoUgx6In8nHheOprjS93P1/6nhGOBdkUZh9vNcY4EJK44sdogPOi
         cKQxelTqNb86kkofxTlRPU+I0Zy8Z8XFn0AQtbr5+f45wpemEj6wjiXLXiJNW/INj2WT
         Ye7WfNWX8Mtv/zlGmkW2bZOkmtTtsU9ppeojcWHEPKX1D7JS79Lh/TefGZL2mWg02jLo
         kMoA==
X-Gm-Message-State: AOJu0YzXycZ16Gufd32GQwS97mHCpqkjZEGW21ZmYbk81BROuC2+kWVW
	zEmG9qWgu0CxwjAGkYJlUxg=
X-Google-Smtp-Source: AGHT+IG1dGmEINF3AnccXmqHgiZyq6mRcsZNRQxWqUunnWXXLcNWhZozqpqQnP2XMbWHTRunGWz8VQ==
X-Received: by 2002:a05:6a00:850a:b0:6ce:7be1:3cfd with SMTP id ha10-20020a056a00850a00b006ce7be13cfdmr10216826pfb.61.1702611052884;
        Thu, 14 Dec 2023 19:30:52 -0800 (PST)
Received: from localhost.localdomain ([23.104.209.6])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7850f000000b006ce467a2475sm3702775pfn.181.2023.12.14.19.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 19:30:51 -0800 (PST)
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
Subject: [PATCH net-next v11 2/3] skbuff: Add a function to check if a page belongs to page_pool
Date: Fri, 15 Dec 2023 11:30:10 +0800
Message-Id: <20231215033011.12107-3-liangchen.linux@gmail.com>
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

Wrap code for checking if a page is a page_pool page into a
function for better readability and ease of reuse.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Mina Almasry <almarsymina@google.com>
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


