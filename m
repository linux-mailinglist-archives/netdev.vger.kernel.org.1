Return-Path: <netdev+bounces-52502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D137FEE68
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 12:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2489A28210E
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 11:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BE03DB9C;
	Thu, 30 Nov 2023 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmAy4Jo8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893D810E2
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 03:59:31 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cfae5ca719so7856375ad.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 03:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701345571; x=1701950371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqbHmSBHyDiifA4Jyxx0ZxpzcDGefiCrTqwukJus35I=;
        b=TmAy4Jo8KFpaof4DBHUauKviKKk11crkO2vgrgrgenmWZqG3pTqM81kztLdmUxCa1E
         p4ao5Q1LNqoBOmzVeQJkDWGy3mIH3w3Ct0/fHxPFnJpkEaN5jgD0FjhBMl//aXnBTejf
         J4iZcszWr6rzJclJjbvbQj2zE3JuSz0yMnRFHgjq6M/vpBCGNe7RTLPe1kRXBssdx/ef
         ETcUmJ7wJ9Fhe2g0nnOGyTUE834s3QLRGSPO6rGk/amB3KClMekNsT6mQsPRFgAyeyR7
         FlNYRKRtxMLMuHgi5pg2PP9Gj1AIkVWSuDnkA73UBDIer19ymJIy8VGP+4FcFxcM7QW1
         RmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701345571; x=1701950371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqbHmSBHyDiifA4Jyxx0ZxpzcDGefiCrTqwukJus35I=;
        b=Nha6cne6sHon/AYldDlMTy222t7y8HUQRs4//e4YTk6iZNmlfs7z4MYCeAakCroJdQ
         tuQFrBoSAoo3vYK+DRojYXJGPvQlgeTq2x27caIab8kPdBZIW+/CIh0KSMSY961WkLKV
         J8vbwJS7jASaVpLqWJPz775xF9Uv19ex4nDcqmbfy04d9mf1nXNI3s5dXv5hArU57h62
         uv7TzafAsu8dmNv112d6wRN9lgpkBUT3CyU6ZQY6RYiNj5TTwWj3tg76eDPa0Re60+p5
         3i05PlWBIjrNWSF6ZgzTXhScTyAq/DHwBTKvZujrzoRcECdq0Jghf9lx328zjzkQVCbk
         9zFg==
X-Gm-Message-State: AOJu0Yy0+cHarFE6KqX84gX1y0I64dlDmJR5vfNJobQWMxRjtoAE4WR1
	9qQmGIhAzbQvMtlmALJTTLU=
X-Google-Smtp-Source: AGHT+IFPxYDEWz5QUP9V1+q0/wuLjXnVe/hts5cDiBAGpcl9t4OB8fb9xkbu+wgamHO/QGFjCzea3Q==
X-Received: by 2002:a17:902:fc4c:b0:1d0:22b9:d98c with SMTP id me12-20020a170902fc4c00b001d022b9d98cmr4175095plb.38.1701345570948;
        Thu, 30 Nov 2023 03:59:30 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001cfa718039bsm472530pls.216.2023.11.30.03.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 03:59:30 -0800 (PST)
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
Subject: [PATCH net-next v6 3/4] skbuff: Add a function to check if a page belongs to page_pool
Date: Thu, 30 Nov 2023 19:56:10 +0800
Message-Id: <20231130115611.6632-4-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231130115611.6632-1-liangchen.linux@gmail.com>
References: <20231130115611.6632-1-liangchen.linux@gmail.com>
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


