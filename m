Return-Path: <netdev+bounces-139304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862D59B15F1
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 09:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21503283141
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 07:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A318B499;
	Sat, 26 Oct 2024 07:33:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C517CA02;
	Sat, 26 Oct 2024 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729928014; cv=none; b=YdHxXv45GyRAGE0hPlDF9zUk5K3FulqUlhwF1JUct9pBYQyGS3DvCwaL2xizTqzuSNg6VSJWCs4e1MHNGQHG4NXru6q76/403GwWfZVztSMytQCl6q7J5n8LYogF/b54NeBb7UNPs3RnTUPdpKEBQbWGGaWrofJ5Espj0LRB3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729928014; c=relaxed/simple;
	bh=n7utlUV9n5HtpAE/g/JIp5AtQo76IlU43lAwxB4lQC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ieKMNNKMEqOcMbiWIrXiMwrzszpHLvehNrVJqE5ViGWMhMhHB5A2uRtYSdwHUlgT1dTKBPYmjAaA//AWRdwKOZtqI70xy+GUD6qDTGAf7bohReiyOeiZ/jvwS8Vuxik0onMZuYINAHrB9iFbJCTbMznEOpGTbBPShEBY4RS88tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XbBGT00Zsz1ynN1;
	Sat, 26 Oct 2024 15:33:36 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 286BE1A016C;
	Sat, 26 Oct 2024 15:33:29 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Oct 2024 15:33:28 +0800
Message-ID: <204272e7-82c3-4437-bb0d-2c3237275d1f@huawei.com>
Date: Sat, 26 Oct 2024 15:33:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <fanghaiqing@huawei.com>,
	<liuyonglong@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, kernel-team
	<kernel-team@cloudflare.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <0c146fb8-4c95-4832-941f-dfc3a465cf91@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <0c146fb8-4c95-4832-941f-dfc3a465cf91@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/25 22:07, Jesper Dangaard Brouer wrote:

...

> 
>>> You and Jesper seems to be mentioning a possible fact that there might
>>> be 'hundreds of gigs of memory' needed for inflight pages, it would be nice
>>> to provide more info or reasoning above why 'hundreds of gigs of memory' is
>>> needed here so that we don't do a over-designed thing to support recording
>>> unlimited in-flight pages if the driver unbound stalling turns out impossible
>>> and the inflight pages do need to be recorded.
>>
>> I don't have a concrete example of a use that will blow the limit you
>> are setting (but maybe Jesper does), I am simply objecting to the
>> arbitrary imposing of any limit at all. It smells a lot of "640k ought
>> to be enough for anyone".
>>
> 
> As I wrote before. In *production* I'm seeing TCP memory reach 24 GiB
> (on machines with 384GiB memory). I have attached a grafana screenshot
> to prove what I'm saying.
> 
> As my co-worker Mike Freemon, have explain to me (and more details in
> blogposts[1]). It is no coincident that graph have a strange "sealing"
> close to 24 GiB (on machines with 384GiB total memory).  This is because
> TCP network stack goes into a memory "under pressure" state when 6.25%
> of total memory is used by TCP-stack. (Detail: The system will stay in
> that mode until allocated TCP memory falls below 4.68% of total memory).
> 
>  [1] https://blog.cloudflare.com/unbounded-memory-usage-by-tcp-for-receive-buffers-and-how-we-fixed-it/

Thanks for the info.

> 
> 
>>> I guess it is common sense to start with easy one until someone complains
>>> with some testcase and detailed reasoning if we need to go the hard way as
>>> you and Jesper are also prefering waiting over having to record the inflight
>>> pages.
>>
>> AFAIU Jakub's comment on his RFC patch for waiting, he was suggesting
>> exactly this: Add the wait, and see if the cases where it can stall turn
>> out to be problems in practice.
> 
> +1
> 
> I like Jakub's approach.

As mentioned in Toke's comment, I am still not convinced that there is some
easy way of waiting here, doing the kick in the kernel space is hard enough,
I am not even sure if kick need to be done or how it can be done in the user
space if some page_pool owned page is held from user space for the cases of zero
rx copy, io_uring and devmem tcp? killing the userspace app?

If you and Toke still think the waiting is the way out for the problem here, maybe
we should wait for jakub's opinion and let him decide if he want to proceed with
his waiting patch.

> 
> --Jesper

