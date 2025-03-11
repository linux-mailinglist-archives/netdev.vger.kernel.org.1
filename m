Return-Path: <netdev+bounces-173870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9ACA5C0F1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C74A16CDBD
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCC225A327;
	Tue, 11 Mar 2025 12:19:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D88259C89
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695554; cv=none; b=bzJxLvFRy4zrJe37fPK8d/LKpK48kAbI9/Q66gXNXccD3VLd7WI0o/fPOHuKeE1fdlltB4nuWUJ/DtdbGdHRwy7Sm+ZzEitNX7K0gzBSU+LEB66aUxXsOwiiAIhkSEpZTjUbsDYX7gwI+wUrJ/n/eZYU5jZ3HhLTL0VWpetrjM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695554; c=relaxed/simple;
	bh=cUgPGh5p1BGwvpbxV5VbyGnJnRnzWJltzLsTN6o0Go4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HkEJO39KOWTESCfiuxbIHjVxO8cE8LsrIEan/46shCqZgBDgKYVnhXD7DDo0udfipvzql+/D7BRRYNeJD9HPceMh2j9tdXHhUBQtYH/cnWBTVt5i5fhHmWCanfWTz4je6CG4hS8cE+1041AenYEr+DR/WRN54nhh/5B3ctehPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZBt963VztzyRrq;
	Tue, 11 Mar 2025 20:19:06 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E2738180080;
	Tue, 11 Mar 2025 20:19:09 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 20:19:07 +0800
Message-ID: <136f1d94-2cdd-43f6-a195-b87c55df2110@huawei.com>
Date: Tue, 11 Mar 2025 20:19:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Yunsheng
 Lin <yunshenglin0825@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>
CC: Yonglong Liu <liuyonglong@huawei.com>, Mina Almasry
	<almasrymina@google.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-mm@kvack.org>, <netdev@vger.kernel.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
 <2c363f6a-f9e4-4dd2-941d-db446c501885@huawei.com> <875xkgykmi.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <875xkgykmi.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/10 23:24, Toke Høiland-Jørgensen wrote:

>>
>> I guess that is one of the disadvantages that an advanced struct like
>> Xarray is used:(
> 
> Sure, there will be some overhead from using xarray, but I think the
> simplicity makes up for it; especially since we can limit this to the

As my understanding, it is more complicated, it is just that complexity
is hidden before xarray now.

Even if there is no space in 'struct page' to store the id, the
'struct page' pointer itself can be used as id if the xarray can
use pointer as id. But it might mean the memory utilization might
not be as efficient as it should be, and performance hurts too if
there is more memory to be allocated and freed.

It seems it is just a matter of choices between using tailor-made
page_pool specific optimization and using some generic advanced
struct like xarray.

I chose the tailor-made one because it ensure least overhead as
much as possibe from performance and memory utilization perspective,
for example, the 'single producer, multiple consumer' guarantee
offered by NAPI context can avoid some lock and atomic operation.

> cases where it's absolutely needed.

The above can also be done for using page_pool_item too as the
lower 2 bits can be used to indicate the pointer in 'struct page'
is 'page_pool_item' or 'page_pool', I just don't think it is
necessary yet as it might add more checking in the fast path.

> 
> -Toke
> 
> 

