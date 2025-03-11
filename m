Return-Path: <netdev+bounces-173875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B86A5C129
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0170F164AC0
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486EC256C9F;
	Tue, 11 Mar 2025 12:25:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA3256C88
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695931; cv=none; b=Sa+L6U064ytCQBzjCXN3277mOjdJpoUZL76xLP/2vIsC7/LzVb6+Zvq3CBMkBQunASXAX2DhSPqag8c42147m1LtzzWvYIvlfie/yDbqdn90nagWS+ojztmk17jZY6A9u9u2c18d4k3PAhnKyZwGgQe5Nbucd86mCNVoHGZkMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695931; c=relaxed/simple;
	bh=+/tN1bt60CIfbXc5xAjpXc74jvlVlWleMPZrFcXo9Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XUbRBYN3Qt3qhFJfbB2fjgwLkXAAqgOint/dwSUfS9D/mxWgkwBpkWA9JjUEFnIb+8DPP6nnVBCkWaeDAgP4Bz+QstA4gNYaZvdO1GoLFG6SFv+jO0CYQUEu5BefIktpEzGABp6UQOxqXJtygutxnoumzopVq+xKZEjRbyLEHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZBtDl3d7Kz2CcBv;
	Tue, 11 Mar 2025 20:22:15 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E3FF3140158;
	Tue, 11 Mar 2025 20:25:25 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 20:25:25 +0800
Message-ID: <c6ef4594-2d87-4fff-bee2-a09556d33274@huawei.com>
Date: Tue, 11 Mar 2025 20:25:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: Matthew Wilcox <willy@infradead.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: Yunsheng Lin <yunshenglin0825@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller"
	<davem@davemloft.net>, Yonglong Liu <liuyonglong@huawei.com>, Mina Almasry
	<almasrymina@google.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-mm@kvack.org>, <netdev@vger.kernel.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
 <Z88IYPp_yVLEBFKx@casper.infradead.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <Z88IYPp_yVLEBFKx@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/10 23:42, Matthew Wilcox wrote:
> On Mon, Mar 10, 2025 at 10:13:32AM +0100, Toke Høiland-Jørgensen wrote:
>> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
>>> Also, Using the more space in 'struct page' for the page_pool seems to
>>> make page_pool more coupled to the mm subsystem, which seems to not
>>> align with the folios work that is trying to decouple non-mm subsystem
>>> from the mm subsystem by avoid other subsystem using more of the 'struct
>>> page' as metadata from the long term point of view.
>>
>> This seems a bit theoretical; any future changes of struct page would
>> have to shuffle things around so we still have the ID available,
>> obviously :)
> 
> See https://kernelnewbies.org/MatthewWilcox/Memdescs
> and more immediately
> https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> 
> pagepool is going to be renamed "bump" because it's a bump allocator and
> "pagepool" is a nonsense name.  I haven't looked into it in a lot of
> detail yet, but in the not-too-distant future, struct page will look
> like this (from your point of view):
> 
> struct page {
> 	unsigned long flags;
> 	unsigned long memdesc;

It seems there may be memory behind the above 'memdesc' with different size
and layout for different subsystem?

I am not sure if I understand the case of the same page might be handle in
two subsystems concurrently or a page is allocated in one subsystem and
then passed to be handled in other subsystem, for examlpe:
page_pool owned page is mmap'ed into user space through tcp zero copy,
see tcp_zerocopy_vm_insert_batch(), it seems the same page is handled in
both networking/page_pool and vm subsystem?

And page->mapping seems to have been moved into 'memdesc' as there is no
'mapping' field in 'struct page' you list here? Does we need a similar
field like 'mapping' in the 'memdesc' for page_pool subsystem to support
tcp zero copy?

> 	int _refcount;	// 0 for bump
> 	union {
> 		unsigned long private;
> 		atomic_t _mapcount; // maybe used by bump?  not sure
> 	};
> };
> 
> 'memdesc' will be a pointer to struct bump with the bottom four bits of
> that pointer indicating that it's a struct bump pointer (and not, say, a
> folio or a slab).

The above seems similar as what I was doing, the difference seems to be
that memory behind the above pointer is managed by page_pool itself
instead of mm subsystem allocating 'memdesc' memory from a slab cache?

> 
> So if you allocate a multi-page bump, you'll get N of these pages,
> and they'll all point to the same struct bump where you'll maintain
> your actual refcount.  And you'll be able to grow struct bump to your
> heart's content.  I don't know exactly what struct bump looks like,
> but the core mm will have no requirements on you.
> 

