Return-Path: <netdev+bounces-25119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022BA77302A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A1F2814A0
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233CE174E1;
	Mon,  7 Aug 2023 20:11:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F16174DE
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A42FC433C9;
	Mon,  7 Aug 2023 20:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691439100;
	bh=PfjOquckUIhzFdoFI7sx7wNa7Uf6MSSqNVPFzLc7nP0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qUSVlTz17BdHEBgyHjIuYlv0qHuS4Kx+JxATTtG9GTWZTxyNewNAd6XrfqxLtk1Y5
	 NFnIEmNv5ykL0iNh+/bJmxzhyfMOROyBOkUimcI61EQNHq1GeTZH7Ljq9pw0GiWAJ8
	 gMaHjHSVVE62B6nct+VXBHf9Ae6nJZgheRc8d58uYDI8B5PKSUwCAEjEs48YSt87Iq
	 2j9yWE7K4OeXtQxmBTuEiCF2GMtVsQYXoh2oCcvU7e4kUdN61yIPbnpsWQarTPu1B0
	 O+O2GaaoVG5oqIXJFNGjR/pgxThyiDv/lLc01LojnaVvwcnoVNmcmB1zdrQRJ7GXDx
	 98RJN91sODXww==
Message-ID: <15d32b22-22b0-64e3-a49e-88d780c24616@kernel.org>
Date: Mon, 7 Aug 2023 22:11:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next] page_pool: Clamp ring size to 32K
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 Alexander H Duyck <alexander.duyck@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
References: <20230807034932.4000598-1-rkannoth@marvell.com>
 <b8eb926e-cfc9-b082-5bb9-719be3937c5d@kernel.org>
 <0aa395ee0386b4b470c152b95cc8a0517ee2d2cd.camel@gmail.com>
 <20230807102045.365e4c6c@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230807102045.365e4c6c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/08/2023 19.20, Jakub Kicinski wrote:
> On Mon, 07 Aug 2023 07:18:21 -0700 Alexander H Duyck wrote:
>>> Page pool (PP) is just a cache of pages.  The driver octeontx2 (in link)
>>> is creating an excessive large cache of pages.  The drivers RX
>>> descriptor ring size should be independent of the PP ptr_ring size, as
>>> it is just a cache that grows as a functions of the in-flight packet
>>> workload, it functions as a "shock absorber".
>>>
>>> 32768 pages (4KiB) is approx 128 MiB, and this will be per RX-queue.
>>>
>>> The RX-desc ring (obviously) pins down these pages (immediately), but PP
>>> ring starts empty.  As the workload varies the "shock absorber" effect
>>> will let more pages into the system, that will travel the PP ptr_ring.
>>> As all pages originating from the same PP instance will get recycled,
>>> the in-flight pages in the "system" (PP ptr_ring) will grow over time.
>>>
>>> The PP design have the problem that it never releases or reduces pages
>>> in this shock absorber "closed" system. (Cc. PP people/devel) we should
>>> consider implementing a MM shrinker callback (include/linux/shrinker.h).
>>>
>>> Are the systems using driver octeontx2 ready to handle 128MiB memory per
>>> RX-queue getting pinned down overtime? (this could lead to some strange
>>> do debug situation if the memory is not sufficient)
>>
>> I'm with Jesper on this. It doesn't make sense to be tying the
>> page_pool size strictly to the ring size. The amount of recycling you
>> get will depend on how long the packets are on the stack, not in the
>> driver.
>>

Thanks for agreeing with me, and I agree with you :-)

>> For example, in the case of something like a software router or bridge
>> that is just taking the Rx packets and routing them to Tx you could
>> theoretically get away with a multiple of NAPI_POLL_WEIGHT since you
>> would likely never need much more than that as the Tx would likely be
>> cleaned about as fast as the Rx can consume the pages.
>>

I agree.

>> Rather than overriding the size here wouldn't it make more sense to do
>> it in the octeontx2 driver? With that at least you would know that you
>> were the one that limited the size instead of having the value modified
>> out from underneath you.
>>

I'm not fully agreeing here.  I don't think we can expect driver
developer to be experts on page_pool cache dynamics.  I'm more on
Jakub's side here, as perhaps we/net-core can come up with some control
system, even if this means we change this underneath drivers.


>> That said, one change that might help to enable this kind of change
>> would be look at adding a #define so that this value wouldn't be so
>> much a magic number and would be visible to the drivers should it ever
>> be changed in the future.
> 
> All the points y'all making are valid, sizing the cache is a hard
> problem. But the proposed solution goes in the wrong direction, IMO.
> The driver doesn't know. I started hacking together page pool control
> over netlink. I think that the pool size selection logic should be in
> the core, with inputs taken from user space / workload (via netlink).
> 
> If it wasn't for the fact that I'm working on that API I'd probably
> side with you. And 64k descriptors is impractically large.
> 
> Copy / pasting from the discussion on previous version:
> 
>    Tuning this in the driver relies on the assumption that the HW /
>    driver is the thing that matters. I'd think that the workload,
>    platform (CPU) and config (e.g. is IOMMU enabled?) will matter at
>    least as much. While driver developers will end up tuning to whatever
>    servers they have, random single config and most likely.. iperf.
> 
>    IMO it's much better to re-purpose "pool_size" and treat it as the ring
>    size, because that's what most drivers end up putting there.

I disagree here, as driver developers should not treat "pool_size" as
the ring size.  It seems to be a copy-paste-programming scheme without
understanding PP dynamics.

>    Defer tuning of the effective ring size to the core and user input
>    (via the "it will be added any minute now" netlink API for configuring
>    page pools)...
> 

I agree here, that tuning ring size is a hard problem, and this is
better handled in the core.  Happy to hear, that/if Jakub is working on
this.

>    So capping the recycle ring to 32k instead of returning the error seems
>    like an okay solution for now.

As a temporary solution, I'm actually fine with capping at 32k.
Driver developer loose some feedback control, but perhaps that is okay,
if we can agree that the net-core should control tuning this anyhow.

--Jesper

