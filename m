Return-Path: <netdev+bounces-17126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E57506D0
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676771C20F34
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635C02771F;
	Wed, 12 Jul 2023 11:48:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559AE2771D
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 11:48:38 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BDC1BFF
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 04:48:10 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R1GC52s1HzPkCQ;
	Wed, 12 Jul 2023 19:45:37 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 12 Jul
 2023 19:47:57 +0800
Subject: Re: [RFC 00/12] net: huge page backed page_pool
To: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
	<jbrouer@redhat.com>
CC: <netdev@vger.kernel.org>, <brouer@redhat.com>, <almasrymina@google.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <edumazet@google.com>,
	<dsahern@gmail.com>, <michael.chan@broadcom.com>, <willemb@google.com>
References: <20230707183935.997267-1-kuba@kernel.org>
 <1721282f-7ec8-68bd-6d52-b4ef209f047b@redhat.com>
 <20230711170838.08adef4c@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <edf4f724-0c0e-c6ae-ffcb-ec1336448e59@huawei.com>
Date: Wed, 12 Jul 2023 19:47:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230711170838.08adef4c@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/12 8:08, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 17:49:19 +0200 Jesper Dangaard Brouer wrote:
>> I see you have discovered that the next bottleneck are the IOTLB misses.
>> One of the techniques for reducing IOTLB misses is using huge pages.
>> Called "super-pages" in article (below), and they report that this trick
>> doesn't work on AMD (Pacifica arch).
>>
>> I think you have convinced me that the pp_provider idea makes sense for
>> *this* use-case, because it feels like natural to extend PP with
>> mitigations for IOTLB misses. (But I'm not 100% sure it fits Mina's
>> use-case).
> 
> We're on the same page then (no pun intended).
> 
>> What is your page refcnt strategy for these huge-pages. I assume this
>> rely on PP frags-scheme, e.g. using page->pp_frag_count.
>> Is this correctly understood?
> 
> Oh, I split the page into individual 4k pages after DMA mapping.
> There's no need for the host memory to be a huge page. I mean, 
> the actual kernel identity mapping is a huge page AFAIU, and the 
> struct pages are allocated, anyway. We just need it to be a huge 
> page at DMA mapping time.
> 
> So the pages from the huge page provider only differ from normal
> alloc_page() pages by the fact that they are a part of a 1G DMA
> mapping.

If it is about DMA mapping, is it possible to use dma_map_sg()
to enable a big continuous dma map for a lot of discontinuous
4k pages to avoid allocating big huge page?

As the comment:
"The scatter gather list elements are merged together (if possible)
and tagged with the appropriate dma address and length."

https://elixir.free-electrons.com/linux/v4.16.18/source/arch/arm/mm/dma-mapping.c#L1805

