Return-Path: <netdev+bounces-112983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA2E93C1CA
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1251F2702F
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B351199EB6;
	Thu, 25 Jul 2024 12:19:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDE6199EAF;
	Thu, 25 Jul 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909961; cv=none; b=J1N7l2sss0wQPD1nrfic3WleVugHH3rP2jzipWS2UgDEZ//Gpd9VtuF9wE7GhpSvk5RT6L4G/9he1n04lOZ8E2rHTTXj3LzMqtpb8Rh5BQbIT/GdSy9Ph0u/KHU6d/fANIpSmxxeVu3LNwlkHPIuix370uIzsINaWC0yBO5A44E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909961; c=relaxed/simple;
	bh=u+rFS4zGH0LnrisupDLp4Z1W7oDlfSYhQdfyLD9blkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X4zsjg9XKskbbZDjhxxObPI0qW0GRbY1D8j0qixge+1y36d/nCx9in21undHbexb72rtXHOchp8hGYa33CwTF1nhoumdXmr0cNeDNDlJZSrcXElhE8wvXHtjDc/aie6lcr3WRGmSKw/KpB/FOV726Ez1HYfBT9X9+uzQBB4Q/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WV90s1GdWzxV4Q;
	Thu, 25 Jul 2024 20:19:09 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E901A180101;
	Thu, 25 Jul 2024 20:19:12 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Jul 2024 20:19:12 +0800
Message-ID: <5df99f22-801c-4b0a-a3bc-0e2e0fadfdd3@huawei.com>
Date: Thu, 25 Jul 2024 20:19:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v11 09/14] mm: page_frag: use __alloc_pages() to replace
 alloc_pages_node()
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
 <20240719093338.55117-10-linyunsheng@huawei.com>
 <e9982acd0eba5d06d178d0157aedfba569d5a09a.camel@gmail.com>
 <e7a9b79b-f1ab-4690-a3cf-4e9238e31790@huawei.com>
 <CAKgT0UdxB3OqS41PcGrB9JNkYKxsTDGx_sebkas+-A2bcx=kUA@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UdxB3OqS41PcGrB9JNkYKxsTDGx_sebkas+-A2bcx=kUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/24 23:03, Alexander Duyck wrote:
> On Wed, Jul 24, 2024 at 5:55 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/7/22 5:41, Alexander H Duyck wrote:
>>
>> ...
>>
>>>>      if (unlikely(!page)) {
>>>> -            page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>>>> +            page = __alloc_pages(gfp, 0, numa_mem_id(), NULL);
>>>>              if (unlikely(!page)) {
>>>>                      memset(nc, 0, sizeof(*nc));
>>>>                      return NULL;
>>>
>>> So if I am understanding correctly this is basically just stripping the
>>> checks that were being performed since they aren't really needed to
>>> verify the output of numa_mem_id.
>>>
>>> Rather than changing the code here, it might make more sense to update
>>> alloc_pages_node_noprof to move the lines from
>>> __alloc_pages_node_noprof into it. Then you could put the VM_BUG_ON and
>>> warn_if_node_offline into an else statement which would cause them to
>>> be automatically stripped for this and all other callers. The benefit
>>
>> I suppose you meant something like below:
>>
>> @@ -290,10 +290,14 @@ struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
>>  static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
>>                                                    unsigned int order)
>>  {
>> -       if (nid == NUMA_NO_NODE)
>> +       if (nid == NUMA_NO_NODE) {
>>                 nid = numa_mem_id();
>> +       } else {
>> +               VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
>> +               warn_if_node_offline(nid, gfp_mask);
>> +       }
>>
>> -       return __alloc_pages_node_noprof(nid, gfp_mask, order);
>> +       return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
>>  }
> 
> Yes, that is more or less what I was thinking.
> 
>>> would likely be much more significant and may be worthy of being
>>> accepted on its own merit without being a part of this patch set as I
>>> would imagine it would show slight gains in terms of performance and
>>> binary size by dropping the unnecessary instructions.
>>
>> Below is the result, it does reduce the binary size for
>> __page_frag_alloc_align() significantly as expected, but also
>> increase the size for other functions, which seems to be passing
>> a runtime nid, so the trick above doesn't work. I am not sure if
>> the overall reduction is significant enough to justify the change?
>> It seems that depends on how many future callers are passing runtime
>> nid to alloc_pages_node() related APIs.
>>
>> [linyunsheng@localhost net-next]$ ./scripts/bloat-o-meter vmlinux.org vmlinux
>> add/remove: 1/2 grow/shrink: 13/8 up/down: 160/-256 (-96)
>> Function                                     old     new   delta
>> bpf_map_alloc_pages                          708     764     +56
>> its_probe_one                               2836    2860     +24
>> iommu_dma_alloc                              984    1008     +24
>> __iommu_dma_alloc_noncontiguous.constprop    1180    1192     +12
>> e843419@0f3f_00011fb1_4348                     -       8      +8
>> its_vpe_irq_domain_deactivate                312     316      +4
>> its_vpe_irq_domain_alloc                    1492    1496      +4
>> its_irq_domain_free                          440     444      +4
>> iommu_dma_map_sg                            1328    1332      +4
>> dpaa_eth_probe                              5524    5528      +4
>> dpaa2_eth_xdp_xmit                           676     680      +4
>> dpaa2_eth_open                               564     568      +4
>> dma_direct_get_required_mask                 116     120      +4
>> __dma_direct_alloc_pages.constprop           656     660      +4
>> its_vpe_set_affinity                         928     924      -4
>> its_send_single_command                      340     336      -4
>> its_alloc_table_entry                        456     452      -4
>> dpaa_bp_seed                                 232     228      -4
>> arm_64_lpae_alloc_pgtable_s1                 680     676      -4
>> __arm_lpae_alloc_pages                       900     896      -4
>> e843419@0473_00005079_16ec                     8       -      -8
>> e843419@0189_00001c33_1c8                      8       -      -8
>> ringbuf_map_alloc                            612     600     -12
>> __page_frag_alloc_align                      740     536    -204
>> Total: Before=30306836, After=30306740, chg -0.00%
> 
> I'm assuming the compiler must have uninlined
> __alloc_pages_node_noprof in the previous version of things for the
> cases where it is causing an increase in the code size.
> 
> One alternative approach we could look at doing would be to just add
> the following to the start of the function:
> if (__builtin_constant_p(nid) && nid == NUMA_NO_NODE)
>         return __alloc_pages_noprof(gfp_mask, order, numa_mem_id(), NULL);
> 
> That should yield the best result as it essentially skips over the
> problematic code at compile time for the constant case, otherwise the
> code should be fully stripped so it shouldn't add any additional
> overhead.

Just tried it, it seems it is more complicated than expected too.
For example, the above changing seems to cause alloc_slab_page() to be
inlined to new_slab() and other inlining/uninlining that is hard to
understand.

[linyunsheng@localhost net-next]$ ./scripts/bloat-o-meter vmlinux.org vmlinux
add/remove: 1/2 grow/shrink: 16/11 up/down: 432/-536 (-104)
Function                                     old     new   delta
new_slab                                     808    1124    +316
its_probe_one                               2836    2876     +40
dpaa2_eth_set_dist_key                      1096    1112     +16
e843419@0f3f_00011fb1_4348                     -       8      +8
rx_default_dqrr                             2776    2780      +4
pcpu_unmap_pages                             356     360      +4
its_vpe_irq_domain_alloc                    1492    1496      +4
iommu_dma_init_fq                            520     524      +4
iommu_dma_alloc                              984     988      +4
hns3_nic_net_timeout                         704     708      +4
hns3_init_all_ring                          1168    1172      +4
hns3_clear_all_ring                          372     376      +4
enetc_refill_rx_ring                         448     452      +4
enetc_free_rxtx_rings                        276     280      +4
dpaa2_eth_xdp_xmit                           676     680      +4
dpaa2_eth_rx                                1716    1720      +4
___slab_alloc                               2120    2124      +4
pcpu_free_pages.constprop                    236     232      -4
its_alloc_table_entry                        456     452      -4
hns3_reset_notify_init_enet                  628     624      -4
dpaa_cleanup_tx_fd                           556     552      -4
dpaa_bp_seed                                 232     228      -4
blk_update_request                           944     940      -4
blk_execute_rq                               540     536      -4
arm_64_lpae_alloc_pgtable_s1                 680     676      -4
__kmalloc_large_node                         340     336      -4
__arm_lpae_unmap                            1588    1584      -4
e843419@0473_00005079_16ec                     8       -      -8
__page_frag_alloc_align                      740     536    -204
alloc_slab_page                              284       -    -284
Total: Before=30306836, After=30306732, chg -0.00%

