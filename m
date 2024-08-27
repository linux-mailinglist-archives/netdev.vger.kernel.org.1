Return-Path: <netdev+bounces-122292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE7E9609A4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB3A1F241B4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42AD1A3BBC;
	Tue, 27 Aug 2024 12:07:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2FF1A38EA;
	Tue, 27 Aug 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760420; cv=none; b=uJO+v4YZfHvKNvp4tQQbV1BU/Q0WmIy2f8J6sqyT4OZW9ILM1qAEgs6RLcqeU0E8FRqMVLVsff+GPklTangoeB+bpgcEGiaFxY7MPaq4i7ZUzgzZ1jk875laZ7/OpkQS4n9inBU6APAMszQwxkqbHZwZRRjMFyzD/YMj2KEYl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760420; c=relaxed/simple;
	bh=QaaIcvz8u+qvKkRH7ot0SQAlCsTh5muzi6BpGWmjhuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gPBFJog0yJtyOrXolh6D3xQKP1NEv5889F7HR9aVrj3RI1HI6K5N8ArLe9k3WVqJBTFMcF0kKan3O9/xABOh0fvR/LrmImVemCsUChiRDZWA383I0zrOX47SKTv0dGuFCUcmp54yGaYb2habVd6i0Fir04p7JvWMtC1JQxdFu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WtR9K0s4Rz1S8ss;
	Tue, 27 Aug 2024 20:06:45 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C8BA8140136;
	Tue, 27 Aug 2024 20:06:55 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Aug 2024 20:06:55 +0800
Message-ID: <67c7c28d-bbfa-457d-a5bb-cb06806e5433@huawei.com>
Date: Tue, 27 Aug 2024 20:06:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 08/13] mm: page_frag: use __alloc_pages() to
 replace alloc_pages_node()
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240826124021.2635705-1-linyunsheng@huawei.com>
 <20240826124021.2635705-9-linyunsheng@huawei.com>
 <CAKgT0Ue+6Gke9YguEDiq6whqQg0DdjPjSDDiRHEeVe5MX80+-Q@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Ue+6Gke9YguEDiq6whqQg0DdjPjSDDiRHEeVe5MX80+-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/27 1:00, Alexander Duyck wrote:
> On Mon, Aug 26, 2024 at 5:46 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> It seems there is about 24Bytes binary size increase for
>> __page_frag_cache_refill() after refactoring in arm64 system
>> with 64K PAGE_SIZE. By doing the gdb disassembling, It seems
>> we can have more than 100Bytes decrease for the binary size
>> by using __alloc_pages() to replace alloc_pages_node(), as
>> there seems to be some unnecessary checking for nid being
>> NUMA_NO_NODE, especially when page_frag is part of the mm
>> system.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  mm/page_frag_cache.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>> index bba59c87d478..e0ad3de11249 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -28,11 +28,11 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>         gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>>                    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>> -       page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>> -                               PAGE_FRAG_CACHE_MAX_ORDER);
>> +       page = __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
>> +                            numa_mem_id(), NULL);
>>  #endif
>>         if (unlikely(!page)) {
>> -               page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>> +               page = __alloc_pages(gfp, 0, numa_mem_id(), NULL);
>>                 if (unlikely(!page)) {
>>                         nc->encoded_page = 0;
>>                         return NULL;
> 
> I still think this would be better served by fixing alloc_pages_node
> to drop the superfluous checks rather than changing the function. We
> would get more gain by just addressing the builtin constant and
> NUMA_NO_NODE case there.

I am supposing by 'just addressing the builtin constant and NUMA_NO_NODE
case', it meant the below change from the previous discussion:

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 01a49be7c98d..009ffb50d8cd 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -290,6 +290,9 @@ struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
 static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
                                                   unsigned int order)
 {
+       if (__builtin_constant_p(nid) && nid == NUMA_NO_NODE)
+               return __alloc_pages_noprof(gfp_mask, order, numa_mem_id(), NULL);
+
        if (nid == NUMA_NO_NODE)
                nid = numa_mem_id();


Actually it does not seem to get more gain by judging from binary size
changing as below, vmlinux.org is the image after this patchset, and
vmlinux is the image after this patchset with this patch reverted and
with above change applied.

[linyunsheng@localhost net-next]$ ./scripts/bloat-o-meter vmlinux.org vmlinux
add/remove: 0/2 grow/shrink: 16/12 up/down: 432/-340 (92)
Function                                     old     new   delta
new_slab                                     808    1124    +316
its_probe_one                               2860    2908     +48
dpaa2_eth_set_dist_key                      1096    1112     +16
rx_default_dqrr                             2776    2780      +4
pcpu_unmap_pages                             356     360      +4
iommu_dma_map_sg                            1328    1332      +4
hns3_nic_net_timeout                         704     708      +4
hns3_init_all_ring                          1168    1172      +4
hns3_clear_all_ring                          372     376      +4
enetc_refill_rx_ring                         448     452      +4
enetc_free_rxtx_rings                        276     280      +4
dpaa2_eth_xdp_xmit                           676     680      +4
dpaa2_eth_rx                                1716    1720      +4
__iommu_dma_alloc_noncontiguous             1176    1180      +4
__arm_lpae_alloc_pages                       896     900      +4
___slab_alloc                               2120    2124      +4
pcpu_free_pages.constprop                    236     232      -4
its_vpe_irq_domain_alloc                    1496    1492      -4
its_alloc_table_entry                        456     452      -4
hns3_reset_notify_init_enet                  628     624      -4
dpaa_cleanup_tx_fd                           556     552      -4
dpaa_bp_seed                                 232     228      -4
blk_update_request                           944     940      -4
blk_execute_rq                               540     536      -4
arm_64_lpae_alloc_pgtable_s1                 680     676      -4
__arm_lpae_unmap                            1596    1592      -4
__arm_lpae_free_pgtable                      256     252      -4
___kmalloc_large_node                        340     336      -4
e843419@0f86_000124d9_a4                       8       -      -8
alloc_slab_page                              284       -    -284
Total: Before=30534822, After=30534914, chg +0.00%



