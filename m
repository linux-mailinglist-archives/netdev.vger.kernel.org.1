Return-Path: <netdev+bounces-151731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C162D9F0BEB
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8906E282121
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9351DF277;
	Fri, 13 Dec 2024 12:09:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629241AB528;
	Fri, 13 Dec 2024 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091786; cv=none; b=shmbIjnPPVTwTmM6859Uhr768P7IJOgNSl4jX3sVj+fGbcL9gofYEGGzsOoiI0Q9K14iMUQWR2x+fyBS3ULziiG1+TimXf5tGXp051a+EcaHRJY1isq5fUupZNi2tnKcJm/M4h0hdouBd99i+bL6FM41KK7WkeNDH/gtu8DVhVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091786; c=relaxed/simple;
	bh=Gv1cuYzZU/Fm1t26+3cLI9UOc7qveKadkcMFo+HOFHI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=skjwx0chPlYPhoe/gApmk13PzItqQEonpu88HlU/U0xkCw0SZmd+XLx1zZjebXMqonY2dUcf1ZPP5r81T7nflJ+5jZ7cl0/Hbx7OBxMDQVCaIlmIvHaU3zVzpP1ozb/4Zo9NXxZvR1wkC1p7CiRRwxARRnpNf+AHlFOeql5vLiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y8p772XM8z20lnN;
	Fri, 13 Dec 2024 20:09:55 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F2081140123;
	Fri, 13 Dec 2024 20:09:37 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Dec 2024 20:09:37 +0800
Message-ID: <ce4214ef-706f-46b9-a88a-463fe0afe56b@huawei.com>
Date: Fri, 13 Dec 2024 20:09:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/10] Replace page_frag with page_frag_cache
 (Part-2)
From: Yunsheng Lin <linyunsheng@huawei.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux-MM <linux-mm@kvack.org>
References: <20241206122533.3589947-1-linyunsheng@huawei.com>
 <CAKgT0UeXcsB-HOyeA7kYKHmEUM+d_mbTQJRhXfaiFBg_HcWV0w@mail.gmail.com>
 <3de1b8a3-ae4f-492f-969d-bc6f2c145d09@huawei.com>
 <CAKgT0Uc5A_mtN_qxR6w5zqDbx87SUdCTFOBxVWCarnryRvhqHA@mail.gmail.com>
 <15723762-7800-4498-845e-7383a88f147b@huawei.com>
 <CAKgT0Uf7V+wMa7zz+9j9gwHC+hia3OwL_bo_O-yhn4=Xh0WadA@mail.gmail.com>
 <389876b8-e565-4dc9-bc87-d97a639ff585@huawei.com>
Content-Language: en-US
In-Reply-To: <389876b8-e565-4dc9-bc87-d97a639ff585@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/11 20:52, Yunsheng Lin wrote:
 > It seems that bottleneck is still the freeing side that the above
> result might not be as meaningful as it should be.

Through 'perf top' annotating, there seems to be about 70%+ cpu usage
for the atmoic operation of put_page_testzero() in page_frag_free(),
it was unexpected that the atmoic operation had that much overhead:(

> 
> As we can't use more than one cpu for the free side without some
> lock using a single ptr_ring, it seems something more complicated
> might need to be done in order to support more than one CPU for the
> freeing side?
> 
> Before patch 1, __page_frag_alloc_align took up to 3.62% percent of
> CPU using 'perf top'.
> After patch 1, __page_frag_cache_prepare() and __page_frag_cache_commit_noref()
> took up to 4.67% + 1.01% = 5.68%.
> Having a similar result, I am not sure if the CPU usages is able tell us
> the performance degradation here as it seems to be quite large?
> 

And using 'struct page_frag' to pass the parameter seems to cause some
observable overhead as the testing is very low level, peformance seems to
be negligible using the below patch to avoid passing 'struct page_frag',
3.62% and 3.27% for the cpu usages for __page_frag_alloc_align() before
patch 1 and __page_frag_cache_prepare() after patch 1 respectively.

The new refatcoring avoid some overhead for the old API, but might cause
some overhead for the new API as it is not able to skip the virt_to_page()
for refilling and reusing case, though it seems to be an unlikely case.
Or any better idea how to do refatcoring for unifying the page_frag API?

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 41a91df82631..b83e7655654e 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -39,8 +39,24 @@ static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)

 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
-			      gfp_t gfp_mask, unsigned int align_mask);
+void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
+				gfp_t gfp_mask, unsigned int align_mask);
+
+static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
+					    unsigned int fragsz, gfp_t gfp_mask,
+					    unsigned int align_mask)
+{
+	void *va;
+
+	va = __page_frag_cache_prepare(nc, fragsz, gfp_mask, align_mask);
+	if (likely(va)) {
+		va += nc->offset;
+		nc->offset += fragsz;
+		nc->pagecnt_bias--;
+	}
+
+	return va;
+}

 static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 					  unsigned int fragsz, gfp_t gfp_mask,
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 3f7a203d35c6..729309aee27a 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -90,9 +90,9 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);

-void *__page_frag_alloc_align(struct page_frag_cache *nc,
-			      unsigned int fragsz, gfp_t gfp_mask,
-			      unsigned int align_mask)
+void *__page_frag_cache_prepare(struct page_frag_cache *nc,
+				unsigned int fragsz, gfp_t gfp_mask,
+				unsigned int align_mask)
 {
 	unsigned long encoded_page = nc->encoded_page;
 	unsigned int size, offset;
@@ -151,12 +151,10 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		offset = 0;
 	}

-	nc->pagecnt_bias--;
-	nc->offset = offset + fragsz;
-
-	return encoded_page_decode_virt(encoded_page) + offset;
+	nc->offset = offset;
+	return encoded_page_decode_virt(encoded_page);
 }
-EXPORT_SYMBOL(__page_frag_alloc_align);
+EXPORT_SYMBOL(__page_frag_cache_prepare);

 /*
  * Frees a page fragment allocated out of either a compound or order 0 page.

