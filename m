Return-Path: <netdev+bounces-174180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BAEA5DC4E
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE0C188F551
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65BF24168E;
	Wed, 12 Mar 2025 12:06:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0A1DB124
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781179; cv=none; b=r1zfSQejnx+ugarp5ty1Ub+N8TguFGclypKWso7G41C20lwqryV3Gc159NxQrGNxYtmx6BJHn7Q+0CduZMrL7rfIgueH5uRQcVv+BaiIRfMyDyZCiVxu2Hbi81jcxAbm9jfe7JCC0WPx9B9kVtdAWOQSONOWNX9xLzjVfEsthX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781179; c=relaxed/simple;
	bh=AlvIx6+mu9pIdY79c9N5Y/jb3mtbbjdzPtPaR6KqV48=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=inB/p56xJx2gTKZ+Y+DyBZIKmH5bbUmGx+XIaN50iwJFQenO50QVpk+7f+b1byiGH7gtN6t7x2K2OAcoyXSnMcji6MVRljz7v/rzgv5U5MSaxjQ0bwmUniu3f9vkuqrY3Q9FoV9OosuE5qUKYOxSTgdksE/e7mmwU+2eSauSVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZCTjp20x6z2RTLH;
	Wed, 12 Mar 2025 20:01:02 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E62F51A016C;
	Wed, 12 Mar 2025 20:05:23 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Mar 2025 20:05:22 +0800
Message-ID: <8fa8f430-5740-42e8-b720-618811fabb22@huawei.com>
Date: Wed, 12 Mar 2025 20:05:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: Matthew Wilcox <willy@infradead.org>
CC: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Yunsheng
 Lin <yunshenglin0825@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>,
	Yonglong Liu <liuyonglong@huawei.com>, Mina Almasry <almasrymina@google.com>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-mm@kvack.org>, <netdev@vger.kernel.org>, <conduct@kernel.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
 <Z88IYPp_yVLEBFKx@casper.infradead.org>
 <c6ef4594-2d87-4fff-bee2-a09556d33274@huawei.com>
 <Z9BSlzpbNRL2MzPj@casper.infradead.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <Z9BSlzpbNRL2MzPj@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/11 23:11, Matthew Wilcox wrote:
> On Tue, Mar 11, 2025 at 08:25:25PM +0800, Yunsheng Lin wrote:
>>> struct page {
>>> 	unsigned long flags;
>>> 	unsigned long memdesc;
>>
>> It seems there may be memory behind the above 'memdesc' with different size
>> and layout for different subsystem?
> 
> Yes.
> 
>> I am not sure if I understand the case of the same page might be handle in
>> two subsystems concurrently or a page is allocated in one subsystem and
>> then passed to be handled in other subsystem, for examlpe:
>> page_pool owned page is mmap'ed into user space through tcp zero copy,
>> see tcp_zerocopy_vm_insert_batch(), it seems the same page is handled in
>> both networking/page_pool and vm subsystem?
> 
> It's not that arbitrary.  I mean, you could read all the documentation
> I've written about this concept, listen to the talks I've given.  But
> sure, you're a special fucking snowflake and deserve your own unique
> explanation.

If you don't like responding to the above question/comment, I would rather
you strip out them like the other question/comment or just ignore it:(

I am not sure how to interpret the comment, but I am sure it is not a kind
one, so CC 'Code of Conduct Committee' in case there is more coming.

> 
> 

