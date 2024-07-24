Return-Path: <netdev+bounces-112765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE2693B115
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 14:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9297B1F248F2
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 12:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4A5158A19;
	Wed, 24 Jul 2024 12:55:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30175158213;
	Wed, 24 Jul 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825703; cv=none; b=qB+3aQNRtPcqW/xmi7R+WbUCgrX7WzNx3u4iRf8noScKGzFTm3qVF+6eX+xpgqDh5lnQkvCWSnwJUgVG5mf8QUMdi9Ek3bpdo6qtJcjoyayx8r9Va72O4uJk4x3dmMWCRxzqpYAYn2+jAX3lTRbW/Q71eBMA9qZDi9N08k/YH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825703; c=relaxed/simple;
	bh=baP/VxuMe3Gv9wgDKWvRUVdvxrabDBcEq05S/iqWzf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZWXbpu3G4qLYZ5C+D498wAAHnzuCZxJU9j2CS0gnr5Z7Tyc9rFVAHhkizJHrrxc+lebKLhDdIDSHK4hn/42zev9crqO0v27wXe60R724crmdmJr8l6plUC/exKNVnIslo1HMcRwwg6mYeywZITUwPzWM51UEuLx/rEVVyw0X928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WTYl31Pz0zyN44;
	Wed, 24 Jul 2024 20:50:07 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DB3BE1800A5;
	Wed, 24 Jul 2024 20:54:57 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Jul 2024 20:54:57 +0800
Message-ID: <e7a9b79b-f1ab-4690-a3cf-4e9238e31790@huawei.com>
Date: Wed, 24 Jul 2024 20:54:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v11 09/14] mm: page_frag: use __alloc_pages() to replace
 alloc_pages_node()
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
 <20240719093338.55117-10-linyunsheng@huawei.com>
 <e9982acd0eba5d06d178d0157aedfba569d5a09a.camel@gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <e9982acd0eba5d06d178d0157aedfba569d5a09a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/22 5:41, Alexander H Duyck wrote:

...

>>  	if (unlikely(!page)) {
>> -		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>> +		page = __alloc_pages(gfp, 0, numa_mem_id(), NULL);
>>  		if (unlikely(!page)) {
>>  			memset(nc, 0, sizeof(*nc));
>>  			return NULL;
> 
> So if I am understanding correctly this is basically just stripping the
> checks that were being performed since they aren't really needed to
> verify the output of numa_mem_id.
> 
> Rather than changing the code here, it might make more sense to update
> alloc_pages_node_noprof to move the lines from
> __alloc_pages_node_noprof into it. Then you could put the VM_BUG_ON and
> warn_if_node_offline into an else statement which would cause them to
> be automatically stripped for this and all other callers. The benefit

I suppose you meant something like below:

@@ -290,10 +290,14 @@ struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
 static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
                                                   unsigned int order)
 {
-       if (nid == NUMA_NO_NODE)
+       if (nid == NUMA_NO_NODE) {
                nid = numa_mem_id();
+       } else {
+               VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
+               warn_if_node_offline(nid, gfp_mask);
+       }

-       return __alloc_pages_node_noprof(nid, gfp_mask, order);
+       return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
 }


> would likely be much more significant and may be worthy of being
> accepted on its own merit without being a part of this patch set as I
> would imagine it would show slight gains in terms of performance and
> binary size by dropping the unnecessary instructions.

Below is the result, it does reduce the binary size for
__page_frag_alloc_align() significantly as expected, but also
increase the size for other functions, which seems to be passing
a runtime nid, so the trick above doesn't work. I am not sure if
the overall reduction is significant enough to justify the change?
It seems that depends on how many future callers are passing runtime
nid to alloc_pages_node() related APIs.

[linyunsheng@localhost net-next]$ ./scripts/bloat-o-meter vmlinux.org vmlinux
add/remove: 1/2 grow/shrink: 13/8 up/down: 160/-256 (-96)
Function                                     old     new   delta
bpf_map_alloc_pages                          708     764     +56
its_probe_one                               2836    2860     +24
iommu_dma_alloc                              984    1008     +24
__iommu_dma_alloc_noncontiguous.constprop    1180    1192     +12
e843419@0f3f_00011fb1_4348                     -       8      +8
its_vpe_irq_domain_deactivate                312     316      +4
its_vpe_irq_domain_alloc                    1492    1496      +4
its_irq_domain_free                          440     444      +4
iommu_dma_map_sg                            1328    1332      +4
dpaa_eth_probe                              5524    5528      +4
dpaa2_eth_xdp_xmit                           676     680      +4
dpaa2_eth_open                               564     568      +4
dma_direct_get_required_mask                 116     120      +4
__dma_direct_alloc_pages.constprop           656     660      +4
its_vpe_set_affinity                         928     924      -4
its_send_single_command                      340     336      -4
its_alloc_table_entry                        456     452      -4
dpaa_bp_seed                                 232     228      -4
arm_64_lpae_alloc_pgtable_s1                 680     676      -4
__arm_lpae_alloc_pages                       900     896      -4
e843419@0473_00005079_16ec                     8       -      -8
e843419@0189_00001c33_1c8                      8       -      -8
ringbuf_map_alloc                            612     600     -12
__page_frag_alloc_align                      740     536    -204
Total: Before=30306836, After=30306740, chg -0.00%



