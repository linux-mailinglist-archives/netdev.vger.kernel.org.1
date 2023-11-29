Return-Path: <netdev+bounces-51983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26FA7FCD4A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59701283462
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA2B33FA;
	Wed, 29 Nov 2023 03:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOCDtq3L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4836EC4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:12:50 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cbe6d514cdso5180210b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701227570; x=1701832370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GuKszrQDXABm8eNJf/PjFxMICrN4TD1NgLfUfAFkdU=;
        b=MOCDtq3Lusv7fAFZyLLBVqWF9pxJlq0jupIp+uuhEQpxRHz4mSaI97g28ldpjvTVQ6
         E9P56HYol0fT3+rB5tVIvUs2j+OvZxRti0vEZHVf7+7GYyypdfRRREUCehya8C5aXYZm
         qXxujdYh1m+fW+/ylvdyH02cKDLYS5re351hf9zGoz0MNA8t5DfRECsAxfhZDx4EcxcA
         EuOEKTUDRR+DGmC7JeCM2slmwYnY1vW4m2Y3u7e4Tsm6IzhLHCEGP7sTK94RIZF2nHUy
         LaOmcE5mEcIE565e6e0Kvdo1SIUmrrlWeJ48aaNv+Ws42zu/Npn0nA0lSW77ilOoRr9L
         44vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701227570; x=1701832370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GuKszrQDXABm8eNJf/PjFxMICrN4TD1NgLfUfAFkdU=;
        b=B00SAU8PZYxVeH1bxun8zTgPW4HcsnVGFHBKkjCCOAc5bdVa/WAOYCxOb5BupWf1IV
         x9E5kBUIE32tH8V4UA0Xx65JUwBQDd72CY65t7vyndKz9667hqnseQMtzOSCm1w/hO13
         evibK0eoXEOnfiak4bqaf6cffOUTfpvC/2ktAysejAKrOVEMpnK68WJ4ECKUBxWoC8Vx
         FI//kyYbYmOAoXGv5ly0ZsFR9+s7sjPo2OiXRr2bIeZowzguGzQwusQEUuxP1aGnuAQ0
         zEdma/ZqtgSgsUK1+ZG1Ct1Sy/B9j+jX3nEFAVMpcX1+DhGMJsvF0ALmzgpQby/8ogsB
         e5Gw==
X-Gm-Message-State: AOJu0YyuzkY6yIYYUUSbeZM53bu/5DjcKETjcf16aU7Lbwf7U//vq+Kx
	leWZ5yiNdGU+2uPNVz5KRVA=
X-Google-Smtp-Source: AGHT+IGsEEJdquJBPiG/GBkkobsxtcbFdcHzqMKOZN1SiLNC912zbQYtY1Un2ROe0Cj6zPrY6mX63g==
X-Received: by 2002:a05:6a20:3d07:b0:18c:4105:9aa8 with SMTP id y7-20020a056a203d0700b0018c41059aa8mr15402788pzi.51.1701227569700;
        Tue, 28 Nov 2023 19:12:49 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b001cfc46baa40sm5669287plx.158.2023.11.28.19.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 19:12:48 -0800 (PST)
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
Subject: [PATCH net-next v4 4/4] skbuff: Optimization of SKB coalescing for page pool
Date: Wed, 29 Nov 2023 11:12:01 +0800
Message-Id: <20231129031201.32014-5-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231129031201.32014-1-liangchen.linux@gmail.com>
References: <20231129031201.32014-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to address the issues encountered with commit 1effe8ca4e34
("skbuff: fix coalescing for page_pool fragment recycling"), the
combination of the following condition was excluded from skb coalescing:

from->pp_recycle = 1
from->cloned = 1
to->pp_recycle = 1

However, with page pool environments, the aforementioned combination can
be quite common(ex. NetworkMananger may lead to the additional
packet_type being registered, thus the cloning). In scenarios with a
higher number of small packets, it can significantly affect the success
rate of coalescing. For example, considering packets of 256 bytes size,
our comparison of coalescing success rate is as follows:

Without page pool: 70%
With page pool: 13%

Consequently, this has an impact on performance:

Without page pool: 2.57 Gbits/sec
With page pool: 2.26 Gbits/sec

Therefore, it seems worthwhile to optimize this scenario and enable
coalescing of this particular combination. To achieve this, we need to
ensure the correct increment of the "from" SKB page's page pool
reference count (pp_ref_count).

Following this optimization, the success rate of coalescing measured in
our environment has improved as follows:

With page pool: 60%

This success rate is approaching the rate achieved without using page
pool, and the performance has also been improved:

With page pool: 2.52 Gbits/sec

Below is the performance comparison for small packets before and after
this optimization. We observe no impact to packets larger than 4K.

packet size     before      after       improved
(bytes)         (Gbits/sec) (Gbits/sec)
128             1.19        1.27        7.13%
256             2.26        2.52        11.75%
512             4.13        4.81        16.50%
1024            6.17        6.73        9.05%
2048            14.54       15.47       6.45%
4096            25.44       27.87       9.52%

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 net/core/skbuff.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 310207389f51..893d03264afc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -947,6 +947,24 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
 	return napi_pp_put_page(virt_to_page(data), napi_safe);
 }
 
+/**
+ * skb_pp_get_frag_ref() - Increase fragment reference count of a page
+ * @page:	page of the fragment on which to increase a reference
+ *
+ * Increase fragment reference count (pp_ref_count) on a page, but if it is
+ * not a page pool page, fallback to increase a reference(_refcount) on a
+ * normal page.
+ */
+static inline void skb_pp_get_frag_ref(struct page *page)
+{
+	struct page *head_page = compound_head(page);
+
+	if (likely(skb_frag_is_pp_page(head_page)))
+		atomic_long_inc(&head_page->pp_ref_count);
+	else
+		get_page(head_page);
+}
+
 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
 	if (end_offset == SKB_SMALL_HEAD_HEADROOM)
@@ -5769,17 +5787,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		return false;
 
 	/* In general, avoid mixing page_pool and non-page_pool allocated
-	 * pages within the same SKB. Additionally avoid dealing with clones
-	 * with page_pool pages, in case the SKB is using page_pool fragment
-	 * references (page_pool_alloc_frag()). Since we only take full page
-	 * references for cloned SKBs at the moment that would result in
-	 * inconsistent reference counts.
-	 * In theory we could take full references if @from is cloned and
-	 * !@to->pp_recycle but its tricky (due to potential race with
-	 * the clone disappearing) and rare, so not worth dealing with.
+	 * pages within the same SKB. In theory we could take full
+	 * references if @from is cloned and !@to->pp_recycle but its
+	 * tricky (due to potential race with the clone disappearing) and
+	 * rare, so not worth dealing with.
 	 */
-	if (to->pp_recycle != from->pp_recycle ||
-	    (from->pp_recycle && skb_cloned(from)))
+	if (to->pp_recycle != from->pp_recycle)
 		return false;
 
 	if (len <= skb_tailroom(to)) {
@@ -5836,8 +5849,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* if the skb is not cloned this does nothing
 	 * since we set nr_frags to 0.
 	 */
-	for (i = 0; i < from_shinfo->nr_frags; i++)
-		__skb_frag_ref(&from_shinfo->frags[i]);
+	if (from->pp_recycle)
+		for (i = 0; i < from_shinfo->nr_frags; i++)
+			skb_pp_get_frag_ref(skb_frag_page(&from_shinfo->frags[i]));
+	else
+		for (i = 0; i < from_shinfo->nr_frags; i++)
+			__skb_frag_ref(&from_shinfo->frags[i]);
 
 	to->truesize += delta;
 	to->len += len;
-- 
2.31.1


