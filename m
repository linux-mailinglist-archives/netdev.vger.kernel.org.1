Return-Path: <netdev+bounces-134518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A515A999F69
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B151C2220F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA0320B214;
	Fri, 11 Oct 2024 08:55:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8D520B210;
	Fri, 11 Oct 2024 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636946; cv=none; b=Vs7uxB1yMheSEsWha3NjMKOsOJVLq8zHxXxS0vRvH5J5x7RzR/TVUn0+TvVDxht9DU9VRb/lHJpYRYtt3jQ3CvbGXjriTcAQgAbKNBKjmfNUo8MLX3z3990mkNAbDW028BLVBWE7aqpOfBEbduBu22jonBr49TdThc6YKz7XnDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636946; c=relaxed/simple;
	bh=ahyaqI+0GVoJXcLRPELixs1OlwogaHuKNLEO1U+q9Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VJw3hNaZ4gDzgSoLuO1SSnaPnbD+VXozb1uujoOayWAbfogLcw5glUhm8UBavMeWtHA2ZzOdz4GOovjQBlq9QD35VtnxH2jnzfTDg02wVPa0t+6cYPT5Ikp10MsGuRiU1sbDm08u+jU7PuMaIrc75fJycYDgpC/RKxumlQGuK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XQ0mn3pz4z1j8yQ;
	Fri, 11 Oct 2024 16:54:33 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 15BAA140123;
	Fri, 11 Oct 2024 16:55:41 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Oct 2024 16:55:40 +0800
Message-ID: <21036339-3eeb-4606-9a84-d36bddba2b31@huawei.com>
Date: Fri, 11 Oct 2024 16:55:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
To: Furong Xu <0x1207@gmail.com>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <xfr@outlook.com>
References: <20241010114019.1734573-1-0x1207@gmail.com>
 <601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
 <20241011101455.00006b35@gmail.com>
 <CAC_iWjL7Z6qtOkxXFRUnnOruzQsBNoKeuZ1iStgXJxTJ_P9Axw@mail.gmail.com>
 <20241011143158.00002eca@gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241011143158.00002eca@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/11 14:31, Furong Xu wrote:
> Hi Ilias,
> 
> On Fri, 11 Oct 2024 08:06:04 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> 
>> Hi Furong,
>>
>> On Fri, 11 Oct 2024 at 05:15, Furong Xu <0x1207@gmail.com> wrote:
>>>
>>> On Thu, 10 Oct 2024 19:53:39 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>  
>>>> Is there any reason that those drivers not to unset the PP_FLAG_DMA_SYNC_DEV
>>>> when calling page_pool_create()?
>>>> Does it only need dma sync for some cases and not need dma sync for other
>>>> cases? if so, why not do the dma sync in the driver instead?  
>>>
>>> The answer is in this commit:
>>> https://git.kernel.org/netdev/net/c/5546da79e6cc  
>>
>> I am not sure I am following. Where does the stmmac driver call a sync
>> with len 0?
> For now, only drivers/net/ethernet/freescale/fec_main.c does.
> And stmmac driver does not yet, but I will send another patch to make it call sync with
> len 0. This is a proper fix as Jakub Kicinski suggested.

In order to support the above use case, it seems there might be two
options here:
1. Driver calls page_pool_create() without PP_FLAG_DMA_SYNC_DEV and
   handle the dma sync itself.
2. Page_pool may provides a non-dma-sync version of page_pool_put_page()
   API even when Driver calls page_pool_create() with PP_FLAG_DMA_SYNC_DEV.

Maybe option 2 is better one in the longer term as it may provide some
flexibility for the user and enable removing of the DMA_SYNC_DEV in the
future?

