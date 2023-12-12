Return-Path: <netdev+bounces-56233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C59180E377
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECB11C21AAF
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD2EDDBD;
	Tue, 12 Dec 2023 04:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZjjYrRJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA482A6
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:47:14 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5de93b677f4so34195407b3.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702356434; x=1702961234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFWemhcq3iWkKRI6tn/zqc4e/tC1iGvS7MPKFXTRkH8=;
        b=aZjjYrRJTjoqndb3scTMbEvM95PP2ipr8tOUALIunfpET4BlLmctJppIvhQoDHQz+L
         an3nUncvzNUZ4wyixv/PGOVGSxsbGHo75MsEQhspjThy3xjMSyytmUiCFj/okmXib8Po
         hbi07+adlLJrTzuhI7MJ7XM8AyXvScb6r/MQeou/PxWSE2/k4KCIT6KooECkJVpIizFj
         1V01uBHsZn899g3XY2GmHIVGxN7JxZjBMwEKgO8jcgYPl4uUwEsH0/cLmT3WL1zgzeQg
         P1sKUt7EgT2T1QPBCRvDP+XzLT12tb2q+Fa8S6OKo228XqqpfPlySuGlgZyOWVU2pfbh
         MioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702356434; x=1702961234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFWemhcq3iWkKRI6tn/zqc4e/tC1iGvS7MPKFXTRkH8=;
        b=fV9VVg/gG/RTXj86UkQUvV4PuwqXKU6Ep/0zYILX69DV8mtA8XoqRxPY/Ntm9LV0m/
         hiAQKmYpSSoNKUeJm+8F5JWCYqB8tBqiw6gUJQJb0nLg9jQYeRnvId6OPETV1SV+ck9W
         Zue/5nmLm4kr5FS4P309OXE1NrPb/3tK6fHpbnRLWmZi+x3V9WytUk1G5kUVexqzo37/
         F16XtSlLOyNoBNm9UsP14IoWph5JcdjQUxFJ5zbEngPFFJDAGuNQvCjn7FtAii2882g9
         M2/g2YvysEQPiECaIlK6XZyxGj8YeV5NfZLpISXIj5S2DZOWkzqKf5XT0BXlxGDWv3KB
         3Zcw==
X-Gm-Message-State: AOJu0YzzDYBp4tm+SH0nWgV17rhtjl1xjjdVmcSYNDzu55oemoZXo11r
	0Vtjx0VdlfPHmoIQH4oTfsw=
X-Google-Smtp-Source: AGHT+IHzrYMNGS990OVpZeccdIFHJ3aA/asumUK1WJAgqD5HD7+Ei5kNU/2+qXlJ0rbhtv3Loc2p4A==
X-Received: by 2002:a0d:f486:0:b0:5d7:1940:7d85 with SMTP id d128-20020a0df486000000b005d719407d85mr4186163ywf.92.1702356433985;
        Mon, 11 Dec 2023 20:47:13 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902848300b001d33e6521b9sm36143plo.14.2023.12.11.20.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:47:13 -0800 (PST)
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
Subject: [PATCH net-next v9 4/4] skbuff: Optimization of SKB coalescing for page pool
Date: Tue, 12 Dec 2023 12:46:14 +0800
Message-Id: <20231212044614.42733-5-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212044614.42733-1-liangchen.linux@gmail.com>
References: <20231212044614.42733-1-liangchen.linux@gmail.com>
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
 net/core/skbuff.c               | 43 ++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 12 deletions(-)

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
index 7e26b56cda38..783a04733109 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -947,6 +947,26 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
 	return napi_pp_put_page(virt_to_page(data), napi_safe);
 }
 
+/**
+ * skb_pp_frag_ref() - Increase fragment reference count of a page
+ * @page:	page of the fragment on which to increase a reference
+ *
+ * Increase the fragment reference count (pp_ref_count) of a page. This is
+ * intended to gain a fragment reference only for page pool aware skbs,
+ * i.e. when skb->pp_recycle is true, and not for fragments in a
+ * non-pp-recycling skb. It has a fallback to increase a reference on a
+ * normal page, as page pool aware skbs may also have normal page fragments.
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
@@ -5769,17 +5789,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
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
@@ -5836,8 +5851,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
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


