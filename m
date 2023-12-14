Return-Path: <netdev+bounces-57227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F218F81268F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 05:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE2E1C21518
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798711C36;
	Thu, 14 Dec 2023 04:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwVOsMH7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7151988
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 20:30:10 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b86f3cdca0so5879171b6e.3
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 20:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702528209; x=1703133009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12hd2wvEpjx1jjZIuoo9JjQkayQ2+EIXRatonagGrWk=;
        b=AwVOsMH75p3kWL73egN5UefaB9MwK+OcrF6mrobBEgAnP3vtBvzXEycVKitxmMP8gQ
         Ssugv2fRQ9Mu40AufkI0lHZ9ZLk81DAeHZ1uPRkupm1XlFFYP1PgWHXBCiWC4ka/YGmC
         bu4y0ZOtg96j678f6AXAyt8vqGhLoZqxQBD/JFQDzRbS2lLn62V0IEcymH6AXYXjNNvn
         ih1Tp2VGmn8Uezz2TYBaT76duZkEqJ7+b8BDYyUa/ISYi2p3AjqJyZk7uGAyvQpQ6kwv
         3qxW0SOq+Uy6lyJW2PZJsIZoa6t1VNysltZjN1AgzUbwHSPnb84+VjwOx0v2AejDUGkC
         SAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702528209; x=1703133009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12hd2wvEpjx1jjZIuoo9JjQkayQ2+EIXRatonagGrWk=;
        b=Z2LIPwgue9tlHIuC2zyx5buImOVCfiANi7em80lTLf6oifLEHf0QruNwsicXK4z8Zm
         RX4XnFp9w3UTaJvGEXawdhEBwQTJry+KzrHkKva3ASosWhBRW1AA4I4tIl2P1e0QeTne
         wDaEynWyeThVYwIWt1fHkQY+szXgo5W2RPK3SRawEoZbviOuhFdpdTLjiHrlWSW/QB5m
         ex1CtuOYsUF+XEOFyOEQM1Ltx+uMD52F1q9Q+XF9v5Zu7F3d3AqBSrkpcXMUdNN6qtnn
         +u4I3wW4bDxi8q3W4VvlV3u+vqiHwb7nEkVAxW+eQ2A08RXf4L+MoMsIJKDj28O+gfJ6
         FWlQ==
X-Gm-Message-State: AOJu0YzCu1UZWupd9obZsH1xwLxBeb5bADN81JySjVJUqZItEA0jMQ5j
	DKNJ64I9vR8yKDaz4JE5nKw=
X-Google-Smtp-Source: AGHT+IH7q5x9Vj87mf/bYUzfkGpUbxYuGGkA/HlVXlnyegK4kal77EqDxUH5wCIoxGeRmD855seHEg==
X-Received: by 2002:a05:6808:30a7:b0:3b9:d36e:53ff with SMTP id bl39-20020a05680830a700b003b9d36e53ffmr12302901oib.53.1702528209485;
        Wed, 13 Dec 2023 20:30:09 -0800 (PST)
Received: from localhost.localdomain ([23.104.213.5])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001cc8cf4ad16sm374412plb.246.2023.12.13.20.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 20:30:08 -0800 (PST)
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
Subject: [PATCH net-next v10 3/4] skbuff: Add a function to check if a page belongs to page_pool
Date: Thu, 14 Dec 2023 12:28:32 +0800
Message-Id: <20231214042833.21316-3-liangchen.linux@gmail.com>
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


