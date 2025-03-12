Return-Path: <netdev+bounces-174311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A8BA5E3D3
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8647189A6AC
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBACF1DE3AF;
	Wed, 12 Mar 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLGZyDDg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D031C84CF
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805337; cv=none; b=BIrMzj9mNKDkvSq9iO4U/AvDIaqGdcKelT6hPcQldp6GeTjy1gWY1Rj6E4q0MqV6ZImjORl9uHn+P3VeNqPNCpwdQORh50KMGWYK67D37PTpF5z5iLEpsdvTNaudgNc0XWh2TfLXXEwpP6K4AicPjdON+Eo5ytHGEY101Rd0uj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805337; c=relaxed/simple;
	bh=RYzjK8wVIc1HHnVu/GI9bATbp6+dbWOnCJI9x5MtnUM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rfdlDCikBgsCxz4t5ZQtbiN+Bwh6j4GZiMmHHiVkDMyvXI0s8BgBfSApwOaPpFNaizKKpkXfPi+m+CImgxOxjPodVHidI8XV+EI8s56MXox9xMXTqwMbwAFl41JA5gx2Tl/4cTV10TFnnp8ay5Eb4aP4P7Rhe0d32ABLjXmQGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLGZyDDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1921C4CEDD;
	Wed, 12 Mar 2025 18:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741805337;
	bh=RYzjK8wVIc1HHnVu/GI9bATbp6+dbWOnCJI9x5MtnUM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=mLGZyDDgZM7UM9oi3ELeAirX/CI0elGGrYRMJPMWiei+vrfF70uBQWvSIfOH4i48k
	 R2W4um1fh7SRhH/UY3bbBsMe7tn43a5+UaBY3vR881M+MCzX0/b7JOrqhqSH5dTBw2
	 RSL/63NjbVDGqhvpV+ydqR+5NxsQJN/mdbCqbj82wF5KS0o9jtGw6ZJviEePdzYlPH
	 /MAUFBi8BeqeXgg4Yhhr/lM5BJBjz7dPraKwBmBbr6Rn0usdckucKfBYGPCzqmf+HK
	 aZ5XHeIFptoeMKijgD/FkQA7KyD6WlAjJgChqZlkdGDHPOh3B1sspD+zuSRrBDfTIP
	 7NAxZAGy2GshQ==
Message-ID: <d143b16a-feda-4307-9e06-6232ecd08a88@kernel.org>
Date: Wed, 12 Mar 2025 12:48:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
From: shuah <shuah@kernel.org>
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
 <52f4e8b1-527a-42fb-9297-2689ba7c7516@kernel.org>
Content-Language: en-US
In-Reply-To: <52f4e8b1-527a-42fb-9297-2689ba7c7516@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/12/25 12:35, Shuah wrote:
> On 3/12/25 06:05, Yunsheng Lin wrote:
>> On 2025/3/11 23:11, Matthew Wilcox wrote:
>>> On Tue, Mar 11, 2025 at 08:25:25PM +0800, Yunsheng Lin wrote:
>>>>> struct page {
>>>>>     unsigned long flags;
>>>>>     unsigned long memdesc;
>>>>
>>>> It seems there may be memory behind the above 'memdesc' with different size
>>>> and layout for different subsystem?
>>>
>>> Yes.
>>>
>>>> I am not sure if I understand the case of the same page might be handle in
>>>> two subsystems concurrently or a page is allocated in one subsystem and
>>>> then passed to be handled in other subsystem, for examlpe:
>>>> page_pool owned page is mmap'ed into user space through tcp zero copy,
>>>> see tcp_zerocopy_vm_insert_batch(), it seems the same page is handled in
>>>> both networking/page_pool and vm subsystem?
>>>
>>> It's not that arbitrary.  I mean, you could read all the documentation
>>> I've written about this concept, listen to the talks I've given.
> 
> You can't point to talk given on the concept - people don't have to go
> find your talks to understand the concept. You are expected to answer
> the question and explain it to us here in this thread.
> 
> But
>>> sure, you're a special fucking snowflake and deserve your own unique
>>> explanation.

Mathew,

This message is a rude personal attack. This isn't the way to treat your
peers in the community. Apology is warranted.

> 
> Yunsheng Lin, This message is a rude personal attack. This isn't the
> way to treat your peers in the community. Apology is warranted.
> 

Yunsheng Lin, I am so sorry I got it wrong. Apologies for the mistake.

thanks,
-- Shuah (on behalf of the CoC committee)



