Return-Path: <netdev+bounces-114943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09099944BC2
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64951F214CF
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38DB1A00F7;
	Thu,  1 Aug 2024 12:54:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3818A6B0;
	Thu,  1 Aug 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516852; cv=none; b=dCpoyAHjKw2iT0iBcwptDFButzwxDJFqPWW7g8WZWmVJfBBR8NfDB7fE/6V8wlfSW+hRoHYhiEXYauR0SaXG2/Fmd1qvsMXEKqspymiWjGEzK2dxK99RwB1E6pyoJ9bbzbRn+NqwYEXGC3eJ0g1cYa/ir3YJYZLAiuzzbN92c+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516852; c=relaxed/simple;
	bh=sOiP90+5YQJeSN7pfvNIG69kZGEAVDNsmcYV1+8j3FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dsbB6+egQ2JtQbVJiRRtWGNBdnpWVwCi5cN4M0vPNfO61LQ/BfZ8hFrrtTJ4kPll3jEZeTsIP++F2XvGS6y2K6zAt/b7t+c2KWjzTbG3hAHccxAixTcr8uWJnWbihYtoEkvQNb5Jflv4x+UnK+XfQErITixje2HweJNyv82DoCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WZTLr1xkQzQnD1;
	Thu,  1 Aug 2024 20:49:40 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 724751800A0;
	Thu,  1 Aug 2024 20:54:00 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 1 Aug 2024 20:54:00 +0800
Message-ID: <86368be7-3344-4fc0-bd03-d79e84f48c35@huawei.com>
Date: Thu, 1 Aug 2024 20:53:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v11 08/14] mm: page_frag: some minor refactoring before
 adding new API
To: Alexander H Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
 <20240719093338.55117-9-linyunsheng@huawei.com>
 <dbf876b000158aed8380d6ac3a3f6e8dd40ace7b.camel@gmail.com>
 <fdc778be-907a-49bd-bf10-086f45716181@huawei.com>
 <CAKgT0UeQ9gwYo7qttak0UgXC9+kunO2gedm_yjtPiMk4VJp9yQ@mail.gmail.com>
 <5a0e12c1-0e98-426a-ab4d-50de2b09f36f@huawei.com>
 <af06fc13-ae3f-41ca-9723-af1c8d9d051d@huawei.com>
 <ad691cb4a744cbdc7da283c5c068331801482b36.camel@gmail.com>
 <e532356e-3153-4132-9d20-940bc3b84ef3@huawei.com>
 <17ae2088c08d34a17db8eeb1fa2821d686198a5b.camel@gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <17ae2088c08d34a17db8eeb1fa2821d686198a5b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/1 1:02, Alexander H Duyck wrote:
> On Wed, 2024-07-31 at 20:35 +0800, Yunsheng Lin wrote:
>> On 2024/7/30 23:12, Alexander H Duyck wrote:
>>
>> ...
>>
>>>>         }
>>>>
>>>>         nc->pagecnt_bias--;
>>>>         nc->remaining = remaining - fragsz;
>>>>
>>>>         return encoded_page_address(encoded_va) +
>>>>                 (page_frag_cache_page_size(encoded_va) - remaining);
>>>
>>> Parenthesis here shouldn't be needed, addition and subtractions
>>> operations can happen in any order with the result coming out the same.
>>
>> I am playing safe to avoid overflow here, as I am not sure if the allocator
>> will give us the last page. For example, '0xfffffffffffff000 + 0x1000' will
>> have a overflow.
> 
> So what if it does though? When you subtract remaining it will
> underflow and go back to the correct value shouldn't it?

I guess that it is true that underflow will bring back the correct value.
But I am not sure what does it hurt to have a parenthesis here, doesn't having
a parenthesis make it more obvious that 'size - remaining' indicate the offset
of allocated fragment and not having to scratch my head and wondering if there
is overflow/underflow problem? Or is there any performance trick behind the above
comment?

