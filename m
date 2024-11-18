Return-Path: <netdev+bounces-145780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B88B9D0B97
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DCC282A79
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B9E18B47E;
	Mon, 18 Nov 2024 09:26:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E1188A0D;
	Mon, 18 Nov 2024 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921986; cv=none; b=t2C/P7mfgl580uS9TSIiwpfdvVv7TXQRZGbDTBZlO7vLiRVOqcVX5V3W9WyawCIj01Ky2oWfu+bknANQWShoeRWX5VgsWRRnNW4kQFeSz29CJQe4roOhK+Clo8ggWcLRbF7KgNO+w9Pxw+6FN8zwCbIrtPU+ldK5lN2J4VqPVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921986; c=relaxed/simple;
	bh=OVwFVUiY+VLSoK/903nT9owaFfGg3Q/SlJs3t3OeFbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FbB96LLf9NcIKCcLYpiNq/th3bx9knTIAYT5SOOB29/GDWkqhswH1iu5M+ER/LpA6WPbl3/hPtLCO0bZEyIaPWh1QZpflPf7sJ2QOOLvLuR+eO5pXs5iTQNVWeQRO1YrPXrbxI/AGqOzARUu49hfdltvU5bHB+EwdNqoHLDx0LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XsMDG2sx9z1V4b0;
	Mon, 18 Nov 2024 17:05:50 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id EE946140393;
	Mon, 18 Nov 2024 17:08:25 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Nov 2024 17:08:25 +0800
Message-ID: <40c9b515-1284-4c49-bdce-c9eeff5092f9@huawei.com>
Date: Mon, 18 Nov 2024 17:08:25 +0800
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
 <204272e7-82c3-4437-bb0d-2c3237275d1f@huawei.com>
 <4564c77b-a54d-4307-b043-d08e314c4c5f@huawei.com> <87ldxp4n9v.fsf@toke.dk>
 <eab44c89-5ada-48b6-b880-65967c0f3b49@huawei.com>
 <be049c33-936a-4c93-94ff-69cd51b5de8e@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <be049c33-936a-4c93-94ff-69cd51b5de8e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/12 22:19, Jesper Dangaard Brouer wrote:
>>
>> Yes, there seems to be many MM system internals, like the CONFIG_SPARSEMEM*
>> config, memory offline/online and other MM specific optimization that it
>> is hard to tell it is feasible.
>>
>> It would be good if MM experts can clarify on this.
>>
> 
> Yes, please.  Can Alex Duyck or MM-experts point me at some code walking
> entire system page table?
> 
> Then I'll write some kernel code (maybe module) that I can benchmark how
> long it takes on my machine with 384GiB. I do like Alex'es suggestion,
> but I want to assess the overhead of doing this on modern hardware.
> 

After looking more closely into MM subsystem, it seems there is some existing
pattern or API to walk the entire pages from the buddy allocator subsystem,
see the kmemleak_scan() in mm/kmemleak.c:
https://elixir.bootlin.com/linux/v6.12/source/mm/kmemleak.c#L1680

I used that to walk the pages in a arm64 system with over 300GB memory,
it took about 1.3 sec to do the walking, which seems acceptable?

