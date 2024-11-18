Return-Path: <netdev+bounces-145896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DD79D147F
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBECBB23B39
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DC71ABEBA;
	Mon, 18 Nov 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxtknAct"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838701A08B6;
	Mon, 18 Nov 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942712; cv=none; b=FqHsCWsQNtBxeH/D8sA7rwEQgcRIUd4aAoiW3tdR89TWkuL6uh9YSfDuH+705DoHHPEPGyF4VHs/mB0vn1kh6J0Zc12H1fL+8p/56l0aBTjRX2b/tkQaLy68tC0FhsAD1/8JELORylsu1kL67ioMbboU8Yiv/SRgFnYXvMd3YYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942712; c=relaxed/simple;
	bh=TExeTFz1ilJ8Wj+pToJnI0x993GlFRsjNQUz/EXz1Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTfggCvJdez+CzbHZboJYtjaI+w/J7nR9xfUeiELKxXvNbQiGQjAIWK3abOPY/U/jt3GUDSrJmdnoSPJk5hJ91SBPDCaLR5ayqzEsP9KXjKZhJZx9R+VUWxAfHzs5C/auLYOOX+bqiCsZFgurOuHlj694o+3zd6BioUNVUxa2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxtknAct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3C3C4CECC;
	Mon, 18 Nov 2024 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731942712;
	bh=TExeTFz1ilJ8Wj+pToJnI0x993GlFRsjNQUz/EXz1Rc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZxtknAct4kAdFJ4YgK/gVZ8EBkvmlYRDhUlFtXfWsmvDYSluSC+6dBtR6BJoS/iXq
	 jpE1jyK3ODuVm6GohUgVQYIxEawnJZk43u9b23IQeeu+weWsYdQHinofwo9xTmDy0d
	 mVvnPeYG5sYec6tYDQgLDl0XPVkb3HjdcHwo3zfqoQpiVa9LNsZQmSY8F62AIQU8Dm
	 2DWY1xhEtPsb8mw79ZMFMsfZ0dcNHt+Mmaedobd4isTwCbyLDXEIJAJZ8KJr9FKkWD
	 Bk9SH2vvObBvN7Ga3p5BZr2ZknCfAQnLjzglDDInUUsyUryTYrOZLCaymvje+V0kJ3
	 G+9fYSxKxqw7w==
Message-ID: <17a24d69-7bf0-412c-a32a-b25d82bb4159@kernel.org>
Date: Mon, 18 Nov 2024 16:11:46 +0100
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
 <be049c33-936a-4c93-94ff-69cd51b5de8e@kernel.org>
 <40c9b515-1284-4c49-bdce-c9eeff5092f9@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <40c9b515-1284-4c49-bdce-c9eeff5092f9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/11/2024 10.08, Yunsheng Lin wrote:
> On 2024/11/12 22:19, Jesper Dangaard Brouer wrote:
>>>
>>> Yes, there seems to be many MM system internals, like the CONFIG_SPARSEMEM*
>>> config, memory offline/online and other MM specific optimization that it
>>> is hard to tell it is feasible.
>>>
>>> It would be good if MM experts can clarify on this.
>>>
>>
>> Yes, please.  Can Alex Duyck or MM-experts point me at some code walking
>> entire system page table?
>>
>> Then I'll write some kernel code (maybe module) that I can benchmark how
>> long it takes on my machine with 384GiB. I do like Alex'es suggestion,
>> but I want to assess the overhead of doing this on modern hardware.
>>
> 
> After looking more closely into MM subsystem, it seems there is some existing
> pattern or API to walk the entire pages from the buddy allocator subsystem,
> see the kmemleak_scan() in mm/kmemleak.c:
> https://elixir.bootlin.com/linux/v6.12/source/mm/kmemleak.c#L1680
> 
> I used that to walk the pages in a arm64 system with over 300GB memory,
> it took about 1.3 sec to do the walking, which seems acceptable?

Yes, that seems acceptable to me.

I'll also do a test on one of my 384 GB systems.
  - It took approx 0.391661 seconds.

I just deref page->pp_magic and counted the pages, not many page were
in-use (page_count(page) > 0) as machine has just been rebooted into
this kernel:
  - pages=100592572 in-use:2079607

--Jesper

