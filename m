Return-Path: <netdev+bounces-144076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B49C579C
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076301F23156
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26092309B9;
	Tue, 12 Nov 2024 12:23:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE21F7789;
	Tue, 12 Nov 2024 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414182; cv=none; b=uo9M8K4dfKij/WkXYbiMIXHqguicyGsxI+v3vvJMUq4XsdZJ+rsYjKjiksfF3gehysp3cUYoRNDtn3HUmYLBbGjt5Ee8TK7sHl+Kcu5wlpbvNzppCAdyFvwTyxRMsUr/ZuqmFb/kbi5quaTZcvuTzcYXra89+xz+kZ1LgPQTDO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414182; c=relaxed/simple;
	bh=FXvUlWu0tk3Cat3j9AJ5sE/XDN+mfcU127Ra7wB80qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U3C/FeN0TJPLdzG9fa68eEd3LbAEVHSlx9a0NP+8scBo6zqCMfZ0C1pSj7D/Rmmvmskg4tclDtvAEqsdHpwn4nYKM0t24FrPbiiC0vBb3mBVsUteEzQnFbPDPSf70E/+i0W7QZ2+1vzQZxsBTnxDyLyMpoAjQZz2mVJLCDNPrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xnls418Fyz20t4f;
	Tue, 12 Nov 2024 20:21:44 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A8FA914011D;
	Tue, 12 Nov 2024 20:22:57 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Nov 2024 20:22:57 +0800
Message-ID: <eab44c89-5ada-48b6-b880-65967c0f3b49@huawei.com>
Date: Tue, 12 Nov 2024 20:22:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <87ldxp4n9v.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/12 2:51, Toke Høiland-Jørgensen wrote:

...

>>
>> Is there any other suggestion/concern about how to fix the problem here?
>>
>> From the previous discussion, it seems the main concern about tracking the
>> inflight pages is about how many inflight pages it is needed.
> 
> Yeah, my hardest objection was against putting a hard limit on the
> number of outstanding pages.
> 
>> If there is no other suggestion/concern , it seems the above concern might be
>> addressed by using pre-allocated memory to satisfy the mostly used case, and
>> use the dynamically allocated memory if/when necessary.
> 
> For this, my biggest concern would be performance.
> 
> In general, doing extra work in rarely used code paths (such as device
> teardown) is much preferred to adding extra tracking in the fast path.
> Which would be an argument for Alexander's suggestion of just scanning
> the entire system page table to find pages to unmap. Don't know enough
> about mm system internals to have an opinion on whether this is
> feasible, though.

Yes, there seems to be many MM system internals, like the CONFIG_SPARSEMEM*
config, memory offline/online and other MM specific optimization that it
is hard to tell it is feasible.

It would be good if MM experts can clarify on this.

> 
> In any case, we'll need some numbers to really judge the overhead in
> practice. So benchmarking would be the logical next step in any case :)

Using POC code show that using the dynamic memory allocation does not
seems to be adding much overhead than the pre-allocated memory allocation
in this patch, the overhead is about 10~20ns, which seems to be similar to
the overhead of added overhead in the patch.

> 
> -Toke
> 
> 

