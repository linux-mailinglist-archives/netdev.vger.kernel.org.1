Return-Path: <netdev+bounces-57228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2A7812692
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 05:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493B328224D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124E57F9;
	Thu, 14 Dec 2023 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlHCjUyg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58611BF5
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 20:30:18 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b9f8c9307dso4580348b6e.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 20:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702528218; x=1703133018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH8JE7RX2AG09Ee8T7TBD98rU2IlRL47FNJ/XRL4ggY=;
        b=hlHCjUygj8ya/4+YDE/2mX/y5DIilvgrcnfjE//8biag/JutO8bfNgym9axc5cJSM7
         bS913mQeGh8Gb0jGsNaEQnjQNvCXyG+XGZ18voc4dlS1LfVNy9/uO0SEZgKt/K+52Rlt
         5vY2R+wtbk9Y7zkkh+5CZiSK38WbxqYtMTLWa0MHZSnQFM5WIMKewA4Rn6rEevrCdusa
         G+kbqpkP4fztmyUf9pPvCJCBru1sUdgX02D4U6+aIGUeR32kYAPhaHo56e7EVFph28l+
         ycpHpEKj4gbJstLT3q42keNuOH1mx2wPQ1w143fhYa6kZKLyjc/ytV/YirIYlfrgMrGs
         A8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702528218; x=1703133018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH8JE7RX2AG09Ee8T7TBD98rU2IlRL47FNJ/XRL4ggY=;
        b=DQfVPDt71fzMufmA4Db6d6iT69W1vzV2YLZ+yXUkKHYkJKkjyC1HEszgt/Fdm7fg4r
         6TeYfnMF5L8HbBYgRq7gvKneklTg8Lw76KazIZ6ReYVoAW7JucdtZKrV8ZyAFyDlBgmo
         pHqNafjW6KCz/KwKprP9mIXSCHrjm+9k1f4OLgUGky+dwiU5utKrLXdcotAt5TKmt7E2
         BfsHoaucg6Qfr3Wu/YD/6JPefikJmTKIH+PRnZ/JCdcdjkZJ4odz8mhVIuQwaJFVFzw5
         3qJn/mt1uBHMctpMIryunFA11yT8TXmRTHH0pEC9LFtCQG4wNXtweIggvqu9C1Bs+rap
         nSSQ==
X-Gm-Message-State: AOJu0Yz0vIWc08JBoCy5eO5ETA2uQe0dUxj9M3qjPr83Tl3cFFlFh6YC
	U9E5Smql50sHE++PcA2iEmY=
X-Google-Smtp-Source: AGHT+IH0z5Jsc/2aOqdw141+MndIT7KSNK8QOI97WWYMyq7Er73hCdbxtT81RIltsPn/DLZwO6lnnA==
X-Received: by 2002:a05:6808:1786:b0:3b9:cc1e:4726 with SMTP id bg6-20020a056808178600b003b9cc1e4726mr12004769oib.75.1702528217746;
        Wed, 13 Dec 2023 20:30:17 -0800 (PST)
Received: from localhost.localdomain ([23.104.213.5])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001cc8cf4ad16sm374412plb.246.2023.12.13.20.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 20:30:16 -0800 (PST)
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
Subject: [PATCH net-next v10 4/4] skbuff: Optimization of SKB coalescing for page pool
Date: Thu, 14 Dec 2023 12:28:33 +0800
Message-Id: <20231214042833.21316-4-liangchen.linux@gmail.com>
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
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 include/net/page_pool/helpers.h |  5 ++++
 net/core/skbuff.c               | 52 +++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index d0c5e7e6857a..0dc8fab43bef 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -281,6 +281,11 @@ static inline long page_pool_unref_page(struct page *page, long nr)
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
index 7e26b56cda38..cebdeafe691b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -947,6 +947,37 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
 	return napi_pp_put_page(virt_to_page(data), napi_safe);
 }
 
+/**
+ * skb_pp_frag_ref() - Increase fragment references of a page pool aware skb
+ * @skb:	page pool aware skb
+ *
+ * Increase the fragment reference count (pp_ref_count) of a skb. This is
+ * intended to gain fragment references only for page pool aware skbs,
+ * i.e. when skb->pp_recycle is true, and not for fragments in a
+ * non-pp-recycling skb. It has a fallback to increase references on normal
+ * pages, as page pool aware skbs may also have normal page fragments.
+ */
+static int skb_pp_frag_ref(struct sk_buff *skb)
+{
+	struct skb_shared_info *shinfo;
+	struct page *head_page;
+	int i;
+
+	if (!skb->pp_recycle)
+		return -EINVAL;
+
+	shinfo = skb_shinfo(skb);
+
+	for (i = 0; i < shinfo->nr_frags; i++) {
+		head_page = compound_head(skb_frag_page(&shinfo->frags[i]));
+		if (likely(is_pp_page(head_page)))
+			page_pool_ref_page(head_page);
+		else
+			page_ref_inc(head_page);
+	}
+	return 0;
+}
+
 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
 	if (end_offset == SKB_SMALL_HEAD_HEADROOM)
@@ -5769,17 +5800,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
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
@@ -5836,8 +5862,10 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* if the skb is not cloned this does nothing
 	 * since we set nr_frags to 0.
 	 */
-	for (i = 0; i < from_shinfo->nr_frags; i++)
-		__skb_frag_ref(&from_shinfo->frags[i]);
+	if (skb_pp_frag_ref(from)) {
+		for (i = 0; i < from_shinfo->nr_frags; i++)
+			__skb_frag_ref(&from_shinfo->frags[i]);
+	}
 
 	to->truesize += delta;
 	to->len += len;
-- 
2.31.1


