Return-Path: <netdev+bounces-17943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D0E753A87
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 14:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32FC1C2153E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 12:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EAF13717;
	Fri, 14 Jul 2023 12:16:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7F13700
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 12:16:40 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B48A2722;
	Fri, 14 Jul 2023 05:16:38 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R2VnB2Q2dz18Lkm;
	Fri, 14 Jul 2023 20:15:58 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 14 Jul
 2023 20:16:35 +0800
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
To: Jakub Kicinski <kuba@kernel.org>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>, Yunsheng Lin
	<yunshenglin0825@gmail.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
	<liangchen.linux@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <20230629120226.14854-2-linyunsheng@huawei.com>
 <20230707170157.12727e44@kernel.org>
 <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
 <20230710113841.482cbeac@kernel.org>
 <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
 <20230711093705.45454e41@kernel.org>
 <1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
 <46ad09d9-6596-cf07-5cab-d6ceb1e36f3c@huawei.com>
 <20230712102603.5038980e@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <9a5b4c50-2401-b3e7-79aa-33d3ccee41c5@huawei.com>
Date: Fri, 14 Jul 2023 20:16:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230712102603.5038980e@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/13 1:26, Jakub Kicinski wrote:
> On Wed, 12 Jul 2023 20:34:12 +0800 Yunsheng Lin wrote:
>>>> C sources can include $path/page_pool.h, headers should generally only
>>>> include $path/page_pool/types.h.  
>>
>> Does spliting the page_pool.h as above fix the problem about including
>> a ton of static inline functions from "linux/dma-mapping.h" in skbuff.c?
>>
>> As the $path/page_pool/helpers.h which uses dma_get_cache_alignment()
>> must include the "linux/dma-mapping.h" which has dma_get_cache_alignment()
>> defining as a static inline function.
>> and if skbuff.c include $path/page_pool.h or $path/page_pool/helpers.h,
>> doesn't we still have the same problem? Or do I misunderstand something
>> here?
> 
> I should have clarified that "types.h" should also include pure
> function declarations (and possibly static line wrappers like
> pure get/set functions which only need locally defined types).

So "types.h" is not supposed/allowed to include any header and
it can include any function declarations and static line wrappers
which do not depend on any other header? It means we need to forward
declaring a lot of 'struct' type for function declarations, right?
If it is the case, the "types.h" does not seems to match it's
naming when we can not really define most of the 'struct' in "types.h",
such as 'struct page_pool' need to include some header in order to
have definition of 'struct delayed_work'.
Similar issue for 'helpers.h', as it will include most of the
definition of 'struct', which are not really helpers, right?

> 
> The skbuff.h only needs to include $path/page_pool/types.h, right?

It seems doable, it need trying to prove it is indeed that case.

> 
> I know that Olek has a plan to remove the skbuff dependency completely
> but functionally / for any future dependencies - this should work?

I am not experienced and confident enough to say about this for now.

