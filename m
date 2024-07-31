Return-Path: <netdev+bounces-114564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8C2942EA1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D55B23AB0
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCCD1B1430;
	Wed, 31 Jul 2024 12:35:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A11B1417;
	Wed, 31 Jul 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429314; cv=none; b=pI3hI+n72feGM7Hw//y8mx4PXCCs/kSWtqgzz9v6ZkO7nVu1u4Zz8E6d++PEmNHwg5Tl0/evI3ZUc0bZY2xuuHPmmdHcTWXCdHfWRtYZ93PDmlm5Uu0Yc5o6gYThLwkeir0jjqplpRqmil4y7r/N+JzbUAkip98Or5gvzSmJp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429314; c=relaxed/simple;
	bh=7woaMrSvfPkIKfB6RgqFAqJK8Sy4SrWjKpHyfryP0WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s35JMZsgw3qocaL93sjxAHpkCt9RYyCLIyKs0oUI7ZE39FMbS3gAp1oSjRRF0mZF+j15VT2ljJ1nuagcE+yV6rJvR8W3yJBVGjGVe7XSvk6NEfnajFK6Rjhr8mSxh1l33YMqigTPCN7Aa1DuZV3/4XZtjyn3uFwl9ZAYbGh182Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WYrzZ2BnPzQnDy;
	Wed, 31 Jul 2024 20:30:50 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C3A4180101;
	Wed, 31 Jul 2024 20:35:09 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 31 Jul 2024 20:35:09 +0800
Message-ID: <e532356e-3153-4132-9d20-940bc3b84ef3@huawei.com>
Date: Wed, 31 Jul 2024 20:35:08 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <ad691cb4a744cbdc7da283c5c068331801482b36.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/30 23:12, Alexander H Duyck wrote:

...

>>         }
>>
>>         nc->pagecnt_bias--;
>>         nc->remaining = remaining - fragsz;
>>
>>         return encoded_page_address(encoded_va) +
>>                 (page_frag_cache_page_size(encoded_va) - remaining);
> 
> Parenthesis here shouldn't be needed, addition and subtractions
> operations can happen in any order with the result coming out the same.

I am playing safe to avoid overflow here, as I am not sure if the allocator
will give us the last page. For example, '0xfffffffffffff000 + 0x1000' will
have a overflow.

