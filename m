Return-Path: <netdev+bounces-50706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A02B7F6CF2
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 08:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A5B20F4E
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 07:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9237524E;
	Fri, 24 Nov 2023 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpwqE16e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90F1D5E
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 23:35:32 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c1f8b0c149so1076637a12.3
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 23:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700811332; x=1701416132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+7Fm45mXPbJos9JDi9Ng8q2lxxttPsawkbzBvsMyCY=;
        b=MpwqE16enhOkb0XEosc2bPe0hEAWGc5m0cLwv17+7xgQ6Dyx+xUa9stL89swSx5qCX
         Ef5pQdqxNHUOw0qAXYN8R1jZv6z5GM70ADAgYMKdg77uXs/b0LFE8DHbltvoVb6EEQc5
         KcruNb7rWatWqjzpyekavZqaYaiAF1UfNLN7fvUfuxjAkOXjtDEzjPDKJw7CD4Bmelqb
         wZPEjicq5SfVaoWFaZTPlsBeXHOQxXfmBdqyGn51o82hPQ37mIYecmk94HRGXftuZqXD
         ODbbgpqs2DxFw4MPTQXVdkrvSU32kusCs2w0/HKNfuUiKn2xfsmAfi+jLmXYuDWSxBi0
         FtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700811332; x=1701416132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+7Fm45mXPbJos9JDi9Ng8q2lxxttPsawkbzBvsMyCY=;
        b=P1OgASPLjer34w7cBVZDsrt+YdcQUHFAmUOm6GDgkxsul0rMNQNSZxKr5iMlPvBCxa
         W5KCN5NEsyoEheHJXFZ1c9glK+VioOwokmV4ZtlrxkbnEPaefabEQVEIfufHMR4c89Ry
         D0ia5LrctOEwHN7LKutgvl6ThDAdAmTtrChZZ+GGUnE6CC1mECGbTUc5RIXIyTR8SML4
         epD+o7ZDlnfzaGp/kzzGlVSgrDxWJOlXFs3/kGWgd5n5JXYFNJmWYo8ntwEGio5zkq6P
         V4itK9DXw/ixKzz+qDUdeGL1XJL+HAbC1cKeoO+mbbVsPsNesRFA7srJyhnm0kTL87VF
         TrfQ==
X-Gm-Message-State: AOJu0YyVYiEfy/6zqIDneQM9doHZsoOj+R25G5/lCH/l/xq5A0uM582s
	oTCNRgJm93VQeDV3eQXXFu4=
X-Google-Smtp-Source: AGHT+IEY5zFaHsjjsH+W05ik6A5APVeYSGIO3q3AFeGd/v8kdg+F0wdCUU5FPt/FldayEbptAC3s9w==
X-Received: by 2002:a05:6a20:4388:b0:18b:30d1:8140 with SMTP id i8-20020a056a20438800b0018b30d18140mr2442174pzl.6.1700811331713;
        Thu, 23 Nov 2023 23:35:31 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902e84f00b001b9d7c8f44dsm2499329plg.182.2023.11.23.23.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:35:30 -0800 (PST)
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
Subject: [PATCH net-next v3 3/3] skbuff: Optimization of SKB coalescing for page pool
Date: Fri, 24 Nov 2023 15:34:39 +0800
Message-Id: <20231124073439.52626-4-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231124073439.52626-1-liangchen.linux@gmail.com>
References: <20231124073439.52626-1-liangchen.linux@gmail.com>
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
 include/net/page_pool/helpers.h | 22 ++++++++++++++++++++++
 net/core/skbuff.c               | 23 +++++++++++------------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 700f435292e7..6b3c0d4d47f5 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -402,4 +402,26 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
+static inline bool page_pool_is_pp_page(struct page *page)
+{
+	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
+}
+
+/**
+ * page_pool_get_frag_ref() - Increase fragment reference count of a page
+ * @page:	page of the fragment on which to increase a reference
+ *
+ * Increase fragment reference count (pp_ref_count) on a page, but if it is
+ * not a page pool page, fallback to increase a reference(_refcount) on a
+ * normal page.
+ */
+static inline void page_pool_get_frag_ref(struct page *page)
+{
+	struct page *head_page = compound_head(page);
+
+	if (likely(page_pool_is_pp_page(head_page)))
+		atomic_long_inc(&head_page->pp_ref_count);
+	else
+		get_page(head_page);
+}
 #endif /* _NET_PAGE_POOL_HELPERS_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b157efea5dea..54e6945ead56 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5764,17 +5764,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
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
@@ -5831,8 +5826,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* if the skb is not cloned this does nothing
 	 * since we set nr_frags to 0.
 	 */
-	for (i = 0; i < from_shinfo->nr_frags; i++)
-		__skb_frag_ref(&from_shinfo->frags[i]);
+	if (from->pp_recycle)
+		for (i = 0; i < from_shinfo->nr_frags; i++)
+			page_pool_get_frag_ref(skb_frag_page(&from_shinfo->frags[i]));
+	else
+		for (i = 0; i < from_shinfo->nr_frags; i++)
+			__skb_frag_ref(&from_shinfo->frags[i]);
 
 	to->truesize += delta;
 	to->len += len;
-- 
2.31.1


