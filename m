Return-Path: <netdev+bounces-52500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0A87FEE65
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 12:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F1E1C20B33
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DC33D965;
	Thu, 30 Nov 2023 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsnDMBCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571F610F5
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 03:59:25 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfc2bcffc7so7779475ad.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 03:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701345565; x=1701950365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J730iItaW8fpD9bcYiCc3WSDtwgBtsyA2Jb0R83edv4=;
        b=UsnDMBCHPxVcOBQhQareMb8LgFfhzOTI4UyRXsoqlqCOIUgd3WibCWLjE/FphHOnbP
         5wMSzWqr9tkvgbeTxvzEVP3WhBkjEm1lKGkw2ALfzJpeNOU/mXtM+Sdv7QAHNEzM0ueJ
         RsuDKF13o06RbMQNpTd8iw2oo8hb3Llc60MzePfjVR0sollufO0kuwhlWvkxGFiLZTI+
         KSjW8kCqPTdKYbLnaNbpy/URmureZIV4mSuhcU63nbha7qRtwu5NiZNE3/GRMovricbE
         hAdctCUsPYXEGogypoHgmQzPsLKM203Ujpod2bjxQNlgi1SeaiqWMWcRVUT2uYlGo+t8
         8g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701345565; x=1701950365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J730iItaW8fpD9bcYiCc3WSDtwgBtsyA2Jb0R83edv4=;
        b=iVSs8HcXAfApm7uPStYSCFeOyJesIkW8IbcClyPCznuf78e0xn6pIvqAjJBAv6Tu31
         LLPkG6AA8i12xkUaOaWHcNlBqZLm2gyjV6Xq1DjEXSDqE6dQtem34UfjiDCWJOjdL5XG
         vGyDPCoUrpcbO+zop7XfzpniYH1kJiY6lyqKTryJwm+nezBVKsESYNBcy3F4zW+MIeuM
         kcr2Jw0FWkoZl4G4V6yP3OunsaHCyy+7lI8hMbj43ThSXkzx8aXXyW3IjFHyOdkV0XD4
         6Wv3p8Yhn4INxn2zZ8egXZgerxTFIPtK9DtRrwEsB3Ykcy40J8JHtGOh8RW6StKQHtfE
         1fng==
X-Gm-Message-State: AOJu0YxPvrebgvUcbU/HKes2GE6yrzNuTGxckg3gnh1P/1d/YTk8URfk
	ZsPfWNpjRqTTdvEXFrWPTXU=
X-Google-Smtp-Source: AGHT+IGY3HYZroqUW39ELjMIRzpuePdhXYHqeCf/80vvVvHgcH2WhD/f+1CJF7r0FJpL6g4XS6meBg==
X-Received: by 2002:a17:902:d508:b0:1cf:f28f:2d99 with SMTP id b8-20020a170902d50800b001cff28f2d99mr10704606plg.19.1701345564706;
        Thu, 30 Nov 2023 03:59:24 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001cfa718039bsm472530pls.216.2023.11.30.03.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 03:59:23 -0800 (PST)
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
Subject: [PATCH net-next v6 2/4] page_pool: halve BIAS_MAX for multiple user references of a fragment
Date: Thu, 30 Nov 2023 19:56:09 +0800
Message-Id: <20231130115611.6632-3-liangchen.linux@gmail.com>
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

Referring to patch [1], in order to support multiple users referencing the
same fragment and prevent overflow from pp_ref_count growing, the initial
value of pp_ref_count is halved, leaving room for pp_ref_count to increment
before the page is drained.

[1]
https://lore.kernel.org/all/20211009093724.10539-3-linyunsheng@huawei.com/

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
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


