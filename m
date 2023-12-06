Return-Path: <netdev+bounces-54372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E4806CB9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779B6281A65
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AF330345;
	Wed,  6 Dec 2023 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKkY5RBh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E832A4
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:54:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ce5a0c384fso2424712b3a.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 02:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701860094; x=1702464894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJpeq0esGgvSQwPlWYu5mSKUKlrzr2fXLQ04GZyOjBI=;
        b=GKkY5RBhEugujfXGZA5eTzCLUzWXMrrW5rZmhxPn1VVY6GeTdTO5VDNSPXsXZlNhVd
         wyn05E8FZw4gNw/+vnMgJnW3Cd9Ev/s15wdksMmIuwEqUZ1EaWuVtY0RD+JxYo4oJPXQ
         UqQNKAdUR2I+w97tCoqm0QefRWdErIlAhYpeWC69Equ/aU2mfcjcv0r5YO9Jo7EQui1d
         sd9Y5rmHTxlhgOn5hJupRqz3ty60nYXi7xVoOMW6mtWKr6NCxqrs5bj/NoSNyueGFygz
         5pbOY9oW1RlnJx9FIiEDv+CXy/hhum8jPUs9nihXqHAkKngigM25xyNvQzhAa9X6IBMv
         0DXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860094; x=1702464894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJpeq0esGgvSQwPlWYu5mSKUKlrzr2fXLQ04GZyOjBI=;
        b=jFppUv1AUqeBLz82NRoIeJMDNCmrLJr7jXmPieJJZxrCqH2ovhCo+cXEUx+XS5gpCm
         +FbrJP0OX6cHfOlMtg+ThoWQWuSzjNR3wvNM5nkFrdysj68Usk+NaupUJzJEhI5Aks5O
         JRheYHevgGZt6MIZB5XHur/zNepbehB+PTRZPUe1Fy9S1E8fjjdQ3xs8hx7prYRQG2T8
         RJb2mLV5F/ljI5T/QD7bZ+XA1H9ZJvGUNkV8QhJfekB7nYUQ3O8wKAoieh7UmGHgd74S
         aAYDiO2SopIGYikvjUPFMYaNxJm1T1V6FTzCiKTRR/YYBmsth6x0kWOyVnPCX8Wq4Z3j
         n8GA==
X-Gm-Message-State: AOJu0YygSm1/9bCNGJZCQDLypSglVEcaApamX+SkUpjxW/qdHIxS7eNN
	VZhNEXXPAb845HDEKb7MWsw=
X-Google-Smtp-Source: AGHT+IGs32UGGkDmx++vF2WrxMsf6vIKFr/2F29zLgzga5cW6Le3dLh6j/00l5geSI7if5bXr/dyag==
X-Received: by 2002:a05:6a00:1743:b0:6ce:6c6d:1622 with SMTP id j3-20020a056a00174300b006ce6c6d1622mr514790pfc.62.1701860093745;
        Wed, 06 Dec 2023 02:54:53 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id n15-20020a638f0f000000b005c6801efa0fsm5388796pgd.28.2023.12.06.02.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:54:52 -0800 (PST)
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
Subject: [PATCH net-next v7 4/4] skbuff: Optimization of SKB coalescing for page pool
Date: Wed,  6 Dec 2023 18:54:19 +0800
Message-Id: <20231206105419.27952-5-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231206105419.27952-1-liangchen.linux@gmail.com>
References: <20231206105419.27952-1-liangchen.linux@gmail.com>
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
index 7e26b56cda38..3c2515a29376 100644
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
+	if (likely(is_pp_page(head_page)))
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


