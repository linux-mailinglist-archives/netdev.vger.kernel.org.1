Return-Path: <netdev+bounces-144120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AC99C5A22
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039A81F23573
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4291FC7D8;
	Tue, 12 Nov 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH8IrupO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B31FC7D1;
	Tue, 12 Nov 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421201; cv=none; b=muIGz/EB+JToBlh0Dtlje4IoqFb9aDiO93+Bviuf35zYL0gAvrIM0HHfr98bo150x9lJqFguUFbTmAotnWU19ZGQ3UQ9/G3axWLKcL7V70V5A1tAZphafImzam3Ti1wJVkpm/6TGFzxNn8pIXjMr5FUCJFHOs8lZF90GSypTduo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421201; c=relaxed/simple;
	bh=pyCRt7WsO3Xx1qWQt6wDCYbx1z5ltqc3D58U2xm3SxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdJvmAgVK6QBVCfcmk7hqSwZoG0SOWbMNqUU0ciWf69Z6rvcHInJYv8BluNK3DqH5ik46aVfYHSJ86B8jR1fZVxKtAGM69fQdjX9yyLIDrv9FOfq1l6OqtydIdxY7nG61rBR+tFq8Ae1SQ6cN7ZIAup7b2ISqwYp5+8aZWfsylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH8IrupO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D22C4CED0;
	Tue, 12 Nov 2024 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421199;
	bh=pyCRt7WsO3Xx1qWQt6wDCYbx1z5ltqc3D58U2xm3SxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mH8IrupOR8xDLzqnBWoXNh0OSoCs8trWxSM5z987hNW/Y/i1EhmNa28VebFQ0OIx5
	 pTUaApI/oK8fFlMk8S0r/AxmcYAZ78iuJJNompwZuzlE+ek+zNrSxSx34XwySJ3VGg
	 got8/Ra1SW4huMVdaEfvjuiSPUS41VSn97NvKP6HmVsGRc6NfxKOvrqAEgXK542RcI
	 y7tzuGLv12YmAJQ7nN4TviSrYAn3vUU7a6t32OnHEUoFN2fmqdrbaTe9KFrx+u1d8E
	 0HvX9ruCIaSWkbU6j/KnLJQFPxVt4H839dNYlPPsWZt+g1gG+oKVnZtTapRRhr8es5
	 koq6gJQehkYrQ==
Message-ID: <be049c33-936a-4c93-94ff-69cd51b5de8e@kernel.org>
Date: Tue, 12 Nov 2024 15:19:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <0c146fb8-4c95-4832-941f-dfc3a465cf91@kernel.org>
 <204272e7-82c3-4437-bb0d-2c3237275d1f@huawei.com>
 <4564c77b-a54d-4307-b043-d08e314c4c5f@huawei.com> <87ldxp4n9v.fsf@toke.dk>
 <eab44c89-5ada-48b6-b880-65967c0f3b49@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <eab44c89-5ada-48b6-b880-65967c0f3b49@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/11/2024 13.22, Yunsheng Lin wrote:
> On 2024/11/12 2:51, Toke Høiland-Jørgensen wrote:
> 
> ...
> 
>>>
>>> Is there any other suggestion/concern about how to fix the problem here?
>>>
>>>  From the previous discussion, it seems the main concern about tracking the
>>> inflight pages is about how many inflight pages it is needed.
>>
>> Yeah, my hardest objection was against putting a hard limit on the
>> number of outstanding pages.
>>
>>> If there is no other suggestion/concern , it seems the above concern might be
>>> addressed by using pre-allocated memory to satisfy the mostly used case, and
>>> use the dynamically allocated memory if/when necessary.
>>
>> For this, my biggest concern would be performance.
>>
>> In general, doing extra work in rarely used code paths (such as device
>> teardown) is much preferred to adding extra tracking in the fast path.
>> Which would be an argument for Alexander's suggestion of just scanning
>> the entire system page table to find pages to unmap. Don't know enough
>> about mm system internals to have an opinion on whether this is
>> feasible, though.
> 
> Yes, there seems to be many MM system internals, like the CONFIG_SPARSEMEM*
> config, memory offline/online and other MM specific optimization that it
> is hard to tell it is feasible.
> 
> It would be good if MM experts can clarify on this.
>

Yes, please.  Can Alex Duyck or MM-experts point me at some code walking
entire system page table?

Then I'll write some kernel code (maybe module) that I can benchmark how
long it takes on my machine with 384GiB. I do like Alex'es suggestion,
but I want to assess the overhead of doing this on modern hardware.

>>
>> In any case, we'll need some numbers to really judge the overhead in
>> practice. So benchmarking would be the logical next step in any case :)
> 
> Using POC code show that using the dynamic memory allocation does not
> seems to be adding much overhead than the pre-allocated memory allocation
> in this patch, the overhead is about 10~20ns, which seems to be similar to
> the overhead of added overhead in the patch.
> 

Overhead around 10~20ns is too large for page_pool, because XDP DDoS
use-case have a very small time budget (which is what page_pool was
designed for).

[1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/hints/traits01_bench_kmod.org#benchmark-basics

  | Link speed | Packet rate           | Time-budget   |
  |            | at smallest pkts size | per packet    |
  |------------+-----------------------+---------------|
  |  10 Gbit/s |  14,880,952 pps       | 67.2 nanosec  |
  |  25 Gbit/s |  37,202,381 pps       | 26.88 nanosec |
  | 100 Gbit/s | 148,809,523 pps       |  6.72 nanosec |


--Jesper

