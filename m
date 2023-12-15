Return-Path: <netdev+bounces-57769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FDC8140A7
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D1BB2211E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D3946AC;
	Fri, 15 Dec 2023 03:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTkPTtiI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2806953B8
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b9dbbaa9a9so238494b6e.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702611061; x=1703215861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH8JE7RX2AG09Ee8T7TBD98rU2IlRL47FNJ/XRL4ggY=;
        b=QTkPTtiIKWDUcC1GL/rU7FryGj40jTJG/l8+0ptPKbxbBTchT4AcnrcRDCWWlikv/+
         450e9sg12ZeoBDBrrGPyEQv/BbcnRsm0SfS2Kk+Zb/Y9BHk01JpWwOp7NPg2UI89GjPG
         LBowh0Dlh+BvGEcmw2NJhgokbTrKIb5iNw20Xu1R3zdav5uOOPFMu+AkRU5gII9lNTF8
         Mob1/tN5Z3oB5dvvO47s5Q57PJxaggNwq03xBDu3jzydauroSYXw75H3FqdrJ7109aQI
         sb5cG8hKlNMgIk8htSpYm3RBihpho2GNpkOg3c/cowxDSiy/SpWdTEOewhR3hifTbcJ8
         84bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702611061; x=1703215861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH8JE7RX2AG09Ee8T7TBD98rU2IlRL47FNJ/XRL4ggY=;
        b=hubt8ZRd4abXsX7xByeaDtnrBQSLgt9vxCeY7benUFXN4++NJtYUF1VuobIsGcnHro
         OLH1ed88KMpn71tDmvj52Ohj/UlTzpUXWaVKIIAVYv0drNPOoOZClSvC8ojca3F48caa
         hm61LcSnt1BJ3bfOYmBm+R+XhdRlb70JAJZzmkx/BvPB0UiAfFcdLp/5g5LW3D1MJJD8
         IRL0Rgdrg3cQnnTuE3e9SiYDCzrJV6ECG9sId4VqLvwrMKCm/FxN3zHJ9XLeO+f0UJeV
         8Zxm5/ciOu2rp3MPqB/sFaD11NhQMewk9YKq5dtv3ZZonbfICs6wyzGG478yiCRkCAT6
         S1mQ==
X-Gm-Message-State: AOJu0YzdChBXjYZPJ6bvSZCshIibuiCKsAXtu4nRoaeWaJ/B4YrtNaPu
	hzM1pTbTb2PgQn2X5ku8pTI=
X-Google-Smtp-Source: AGHT+IESZfpT6HwFqjKqBUdBuBfxsgq6TarG/TO3M212JYVWWelKU8fvA5JObVa8HMPeiL8XmcFBeA==
X-Received: by 2002:a05:6808:1b1f:b0:3b8:b73b:d991 with SMTP id bx31-20020a0568081b1f00b003b8b73bd991mr14586506oib.52.1702611061135;
        Thu, 14 Dec 2023 19:31:01 -0800 (PST)
Received: from localhost.localdomain ([23.104.209.6])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7850f000000b006ce467a2475sm3702775pfn.181.2023.12.14.19.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 19:31:00 -0800 (PST)
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
Subject: [PATCH net-next v11 3/3] skbuff: Optimization of SKB coalescing for page pool
Date: Fri, 15 Dec 2023 11:30:11 +0800
Message-Id: <20231215033011.12107-4-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231215033011.12107-1-liangchen.linux@gmail.com>
References: <20231215033011.12107-1-liangchen.linux@gmail.com>
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


