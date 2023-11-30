Return-Path: <netdev+bounces-52503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DBB7FEE6A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 12:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965921C20A76
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 11:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60A3D965;
	Thu, 30 Nov 2023 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfPUad8O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1E284
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 03:59:38 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d00689f5c8so8054085ad.3
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 03:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701345577; x=1701950377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4UjmZfACngDCvpkyy81/IrPoWizpPZEkLdIVW/4fro=;
        b=FfPUad8Os6YLJh64PkotEQgJX7mYqPS2BoIPt7H75Dp6sk6e9YDr3Xb4P0n+RZaj4w
         aIrKb7MXVrkcsRaMQ5oSo9nRmYnwwQjMzS5ilQtj7rgwTaHYLEve8ZZ5LWh09bL/b3qG
         zy8f04hPlu+ZGW/CVSAK+cyvSeBzhWx31QSZ9xX+gokjxVOxg1eyNhkoi0bDs7FgBWj3
         GtPwe8Bv4kBPkz0zj2sxoeIx/zbLIhCmvW1qerQY9BLtZLXpji1sytj8ZmrjANeneqOZ
         qUJgaIyUsxA/eZHrvWXbWHji0qXDLfA1DDNlfcoCyOIw731Ic1ogl2nwukavfzKrSj6T
         rjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701345577; x=1701950377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4UjmZfACngDCvpkyy81/IrPoWizpPZEkLdIVW/4fro=;
        b=paDxg4itHghWPjbsTtNTuSvsyCC7aHipIVEDrTnDB9MkYwu1wYTqU0+nJklQ9eNRQC
         JUkm44dFgUm+k/EyC+naRK/wHy1vj2+RjPN7unDuLqhBL/hq6KYn6HZHkf9aVeTjX6Kj
         pETX6qbb3MIJXxJ1w/C6XAkYVysZWGTfQNdqi9C6naui/B4xlQ3ThoqB5zlfnlNW49vX
         R7X3VKqm5Sb5clnfqcqtEotSy4ZuB3Y3K143hhoH54NLiLL/DfnI7ZkJ8U2eyV/DuP8K
         +wvRAeOdxMpN8qqYShGLoNg2CDvf7wWTpMQv2T/H8EL4wWXB+oQDz0xwkZIJyPatmpbK
         F3TQ==
X-Gm-Message-State: AOJu0Yx+tVT2yyYfsOcOhww2N/Dh9zClGvl6ZcX7KsdUFosf2ZEy6kn9
	MhZgMIE2R81XYwncogv66qwoMWG/VzGSGdCS
X-Google-Smtp-Source: AGHT+IGQPbwg2/v+iM7Z5IwBB/Tw9Enrlsk/fWYHKf0MrHmKrLdE9W5Fo7jHLLxhldr5J/MePpKApw==
X-Received: by 2002:a17:902:eb84:b0:1cf:a204:b52d with SMTP id q4-20020a170902eb8400b001cfa204b52dmr23847249plg.22.1701345577508;
        Thu, 30 Nov 2023 03:59:37 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001cfa718039bsm472530pls.216.2023.11.30.03.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 03:59:36 -0800 (PST)
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
Subject: [PATCH net-next v6 4/4] skbuff: Optimization of SKB coalescing for page pool
Date: Thu, 30 Nov 2023 19:56:11 +0800
Message-Id: <20231130115611.6632-5-liangchen.linux@gmail.com>
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
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
---
 include/net/page_pool/helpers.h |  5 ++++
 net/core/skbuff.c               | 41 +++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 9dc8eaf8a959..268bc9d9ffd3 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -278,6 +278,11 @@ static inline long page_pool_unref_page(struct page *page, long nr)
 	return ret;
 }
 
+static inline void page_pool_ref_page(struct page *page)
+{
+	atomic_long_inc(&page->pp_ref_count);
+}
+
 static inline bool page_pool_is_last_ref(struct page *page)
 {
 	/* If page_pool_unref_page() returns 0, we were the last user */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 31e57c29c556..2d797f33d809 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -947,6 +947,24 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
 	return napi_pp_put_page(virt_to_page(data), napi_safe);
 }
 
+/**
+ * skb_pp_frag_ref() - Increase fragment reference count of a page
+ * @page:	page of the fragment on which to increase a reference
+ *
+ * Increase fragment reference count (pp_ref_count) on a page, but if it is
+ * not a page pool page, fallback to increase a reference(_refcount) on a
+ * normal page.
+ */
+static void skb_pp_frag_ref(struct page *page)
+{
+	struct page *head_page = compound_head(page);
+
+	if (likely(skb_frag_is_pp_page(head_page)))
+		page_pool_ref_page(head_page);
+	else
+		page_ref_inc(head_page);
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
+			skb_pp_frag_ref(skb_frag_page(&from_shinfo->frags[i]));
+	else
+		for (i = 0; i < from_shinfo->nr_frags; i++)
+			__skb_frag_ref(&from_shinfo->frags[i]);
 
 	to->truesize += delta;
 	to->len += len;
-- 
2.31.1


