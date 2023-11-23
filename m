Return-Path: <netdev+bounces-50345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A94887F5668
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 03:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B74B21083
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20EC440B;
	Thu, 23 Nov 2023 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+RjT4rS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B7019D
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 18:25:49 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so284687a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 18:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700706349; x=1701311149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ckz0BT3FoY1fPyVjyQnTnzfq2MM9cj13QlAFuNldDOw=;
        b=Q+RjT4rSGAOuGcCbA+vGUsxvSxaLTiO/r53jZaqs3HgEYivBV2S91NMPqiTFTF7G5G
         WCoHcQ575fPrXBJqaKb7/vNqePzsiS+wgWJjgq2xW6JahCZa9eCXXtU6FwL8r+AeXrAZ
         KqgjRN45obPv14qy28nwwFLczdCfd58pzMdlepegjOaaudpm+Y6tWcfi8Y14ygxXI4j2
         uoIMN7xifxedC6s1L6SKdLudyDfb2eRk9mHZk/+8v0mnTf/scxyiT1nfeWdffDJDVw3Z
         2QQzG5RD0vJXip8hwrqoBg3f/AzXB29bsTdp6dLbAclE3WKuZH7OLyD2SUuYCMShf41y
         OQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700706349; x=1701311149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ckz0BT3FoY1fPyVjyQnTnzfq2MM9cj13QlAFuNldDOw=;
        b=hwYDlb46QQH1Qg1IZi//Otqukw7VDpUR+vQsYVf2l9zPE6XRh5Yg/0c9PxKRIoouZJ
         11LlFYsC/QCKX1CXuJRc/ddbdX29xNdFWJQNjRK2arBkN7yLWDxhyI5zQZa+wlNzjWEu
         Sb+6OYXu/Oq91zkuHx4+TzydtLhAG3Iy5J9ylEbxayNw4iL+VDqjCOHPiTZqyQUjkHGq
         yXF3BeFfamDCn9a8LDO68nfjPbmTDsG280mMqtYjui41BVrCSZxV/r0mVB9mLS7P0yF2
         oXVfnzeAcjLFpMIXNREzqtE3ZYA1wbTEfclsEj095P1SudmF8q+a44453xtuirj49/jJ
         RRfw==
X-Gm-Message-State: AOJu0YxCw2MKQeMm6jJcZ8guPuqQPeal5OeHnGaj/+5dGcmZx2a/SN9O
	/xBUj0gZFQMZy9iFcbzWynY=
X-Google-Smtp-Source: AGHT+IG84g+POiFTa5Vn2S/1Coe2Uvzj3bj8oN8gGe1gdstU/uYpZ3sgW8Hev8enfI1R1Jlq0HKnTA==
X-Received: by 2002:a05:6a21:3390:b0:16b:80f2:f30c with SMTP id yy16-20020a056a21339000b0016b80f2f30cmr4859501pzb.26.1700706348804;
        Wed, 22 Nov 2023 18:25:48 -0800 (PST)
Received: from localhost.localdomain ([204.44.110.111])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001ce6452a741sm32880ply.25.2023.11.22.18.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 18:25:47 -0800 (PST)
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
Subject: [PATCH net-next v2 2/3] page_pool: halve BIAS_MAX for fragment multiple user references
Date: Thu, 23 Nov 2023 10:25:15 +0800
Message-Id: <20231123022516.6757-2-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231123022516.6757-1-liangchen.linux@gmail.com>
References: <20231123022516.6757-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Referring to patch [1], in order to support multiple users referencing the
same fragment and prevent overflow from pp_ref_count growing, the initial
value of pp_ref_count is halved, leaving room for pp_ref_count to increment
before the page is drained.

[1]
https://lore.kernel.org/all/20211009093724.10539-3-linyunsheng@huawei.com/

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 net/core/page_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index df2a06d7da52..5221b5b11bad 100644
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


