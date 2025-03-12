Return-Path: <netdev+bounces-174310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A444A5E3B7
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CC43BBE68
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E031DE3AF;
	Wed, 12 Mar 2025 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J67Y7RRV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030D51CD20D
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804549; cv=none; b=TGQf+EZ4vdWPRYMC9ol+/yrexGK/NQajIkKsKndMCyqTs3T941K9HlGITfdZjN3jNAZ2St9Oj6NyLUVc5562Cp13s7aBxTJ6x+QsDtBtX3HBL0DfYvqH9OUBqqhiMNSWoKCXi+hESjNhyHoVp2TdblIK4zWtQXfowcBapYHRSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804549; c=relaxed/simple;
	bh=ow1KigtljFBQ1vcnh+0FfWEOUCuNEjBV9gvac4wWkPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bABBMfu2jA9pvg0y9NyyLOMWQoBau04LNUVej9zyvRD2T3xvFhq1YfatwPgrxbAZFwSISLNA4+ny+iKtCEoNQRdvAj7qQ5ZkZhnGEEeIT+Lk4rBuLh1LrN3xnuECz5Bemiutrq8GX29gwfWH9VO6wVqKPm3F0kyIL0Py2uVK/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J67Y7RRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510EBC4CEDD;
	Wed, 12 Mar 2025 18:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741804548;
	bh=ow1KigtljFBQ1vcnh+0FfWEOUCuNEjBV9gvac4wWkPs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J67Y7RRVNOO/MNJ2sZvbGFF15qYvBYL9Kk3a+/71H45yV8ixTNsst4gTVS0DLtl5Q
	 XUYFhI6/9LwE/hX0FAKOqdUREL+XYaOlBphiABiW395wVSheVKciUCTHlhEU2x5ZVj
	 m9/JfvbNGFHEoZpwMl67yRbOBP0dtTJYPqgqc83geg/37Vf7vo4ffo1bTojpwDaocD
	 LBPS+auizg3T7VRkBM4U+ooOszhm54Fi6iW19/pz3EFMlQish+p8P8jonh1IoPKQfK
	 Rk2Q+Ysib/VTprpwu2hI3Gl9PvLGxTwsvPGI6ecJXZxL2Uh2IZn1GDO3Bt3IcAKWhT
	 uXzaOpsPBU3eA==
Message-ID: <52f4e8b1-527a-42fb-9297-2689ba7c7516@kernel.org>
Date: Wed, 12 Mar 2025 12:35:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Yunsheng Lin <yunshenglin0825@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Yonglong Liu <liuyonglong@huawei.com>, Mina Almasry
 <almasrymina@google.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org,
 conduct@kernel.org
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
 <Z88IYPp_yVLEBFKx@casper.infradead.org>
 <c6ef4594-2d87-4fff-bee2-a09556d33274@huawei.com>
 <Z9BSlzpbNRL2MzPj@casper.infradead.org>
 <8fa8f430-5740-42e8-b720-618811fabb22@huawei.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <8fa8f430-5740-42e8-b720-618811fabb22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 06:05, Yunsheng Lin wrote:
> On 2025/3/11 23:11, Matthew Wilcox wrote:
>> On Tue, Mar 11, 2025 at 08:25:25PM +0800, Yunsheng Lin wrote:
>>>> struct page {
>>>> 	unsigned long flags;
>>>> 	unsigned long memdesc;
>>>
>>> It seems there may be memory behind the above 'memdesc' with different size
>>> and layout for different subsystem?
>>
>> Yes.
>>
>>> I am not sure if I understand the case of the same page might be handle in
>>> two subsystems concurrently or a page is allocated in one subsystem and
>>> then passed to be handled in other subsystem, for examlpe:
>>> page_pool owned page is mmap'ed into user space through tcp zero copy,
>>> see tcp_zerocopy_vm_insert_batch(), it seems the same page is handled in
>>> both networking/page_pool and vm subsystem?
>>
>> It's not that arbitrary.  I mean, you could read all the documentation
>> I've written about this concept, listen to the talks I've given.

You can't point to talk given on the concept - people don't have to go
find your talks to understand the concept. You are expected to answer
the question and explain it to us here in this thread.

But
>> sure, you're a special fucking snowflake and deserve your own unique
>> explanation.

Yunsheng Lin, This message is a rude personal attack. This isn't the
way to treat your peers in the community. Apology is warranted.

> 
> If you don't like responding to the above question/comment, I would rather
> you strip out them like the other question/comment or just ignore it:(
> 
> I am not sure how to interpret the comment, but I am sure it is not a kind
> one, so CC 'Code of Conduct Committee' in case there is more coming.
> 

Thank you Mathew for letting us know about this.

thanks,
-- Shuah ((on behalf of the CoC committee)


