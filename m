Return-Path: <netdev+bounces-52118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6CD7FD592
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 12:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1082E282A5C
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34781C696;
	Wed, 29 Nov 2023 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxhj3v/X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952DB84
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 03:24:52 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cf80a7be0aso56302205ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 03:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701257092; x=1701861892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60yowogr+zuknO3ERs4O7G8fQYZaBv4s1gl54jybDiQ=;
        b=Yxhj3v/XSj3xq+mMPhEohgfT1fJbIkhM+JPc6sp27s8MV+xnuiP0RRKc+Lh1/MRmYM
         hXjjIylT3NmScLdh9rpzZObfFZhlqaaw4Sk+b9km38ZQU2r5z83IlOuKSNs7w+Qz7quH
         hdygpdsVhyLOL7yADIwYWDSrQbNnMVY924y3EAux9IDBqO/DnexWKRRECsJaaln4aqtd
         Gx4fbhTgZYPCCpBLCKVH27r0P8pAdopURSJaViwH+R2axNZOUgreq2Qdkny3E/2H6aDS
         U7B4gQASdvZes1X2Z0sfaPDFFM636ARyxcTndzJSmG+VJG+b8udlokMKC/CkO+xIHNyr
         PQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257092; x=1701861892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60yowogr+zuknO3ERs4O7G8fQYZaBv4s1gl54jybDiQ=;
        b=XBMTZUTrus7fXo0vJARWZdpZoc1BD1dJBBg71It8lpAInuK4TdBHjYZuAqsUvIrXtu
         +lNVM4mH6z1Aa3vPopNhvbpDMWgnKstoWszZW69OIR2sL4vjKaqAxUnoOTJve4CgFQ7s
         S3u9QJC7s3l6EeJsxfzwT1A1xPqE7BsXo9LK568FHKZb+rbEPb8QBvUwZ1TBPnnvDoSe
         cBx8qIDRYrsOJ7QxFfPcIrIjHeUJGdsvex359pQhtyLXYBa0JR0wQ9rBG/7lmRzHki3Y
         1Sq0PA0v0BcuaxXbalU1Q6fI0NFWfGXgPHJrHrsoQUylimEeDBTYCkXm3EjeNx4Rj5EF
         x9Xg==
X-Gm-Message-State: AOJu0Yx7c42LjZvPd9tgGGRvU8QigQ2mnRAbA21Ic70MYg7WhU5WnhbH
	bbC+Pji6epvI+0YcPjYa2iHfQzG3SrCt1g==
X-Google-Smtp-Source: AGHT+IG3ycrW11c+jOMiRX0m4x0f2LMO5kHkyzpQoQeO4N3U4j5Xb+awhZJOOwUSY1nrq3eoWqcStQ==
X-Received: by 2002:a17:903:32c8:b0:1cf:b12a:a9eb with SMTP id i8-20020a17090332c800b001cfb12aa9ebmr19342480plr.19.1701257092063;
        Wed, 29 Nov 2023 03:24:52 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001cfd0ed1604sm5460710plc.87.2023.11.29.03.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 03:24:50 -0800 (PST)
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
Subject: [PATCH net-next v5 4/4] skbuff: Optimization of SKB coalescing for page pool
Date: Wed, 29 Nov 2023 19:23:04 +0800
Message-Id: <20231129112304.67836-5-liangchen.linux@gmail.com>
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


