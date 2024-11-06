Return-Path: <netdev+bounces-142406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD4C9BEEF8
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80E9286150
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2CC1DF97A;
	Wed,  6 Nov 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUrGuBIJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55A646;
	Wed,  6 Nov 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899507; cv=none; b=XDDZof6xvzVlfsDvv9m9AgyYE39uN9UB9uSCt6tvElmLfBDxUK3KSa7kxqkPXEm1/FhyRqd3gAEWMN9RQi5JKhRw9AuTLnJpON5kF1vlu0cgxcyebIFi0SK/cIBIvUXe2pB/R0lP5PU2M8IFCQg3LY8LfG79sraDpcP0TwYdOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899507; c=relaxed/simple;
	bh=116sGymRPGxitIATLh63Hu4bt7vFtHZYdaTU44MGasg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yug4kI16puH31boI/uUhUd5YeYNkx0HZQnmbFiryZd17AojrDA0Y479aIFyVfiIPWwjJmTFmtev7Fi+f6yr0zuAQ1GgpQ9vKeDh43hGltNch5gE7SvsiVuhBQvfxd3Qd1M5rj5RR/cqYyXfDgr8bTJdkTUl6gY9Ef8MAK+4Y86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUrGuBIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A80FC4CED3;
	Wed,  6 Nov 2024 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730899507;
	bh=116sGymRPGxitIATLh63Hu4bt7vFtHZYdaTU44MGasg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YUrGuBIJv1qi8hzM0QUpV/DuyXkCd2ksGSx6fggOz070whoF7aDf3hk4NyKamwJya
	 DgoLj27XHpgNGbwBk+PV8DRnLSAy5btBnSSBvDD65Oi3IYhJvwIL0axKwBS7ui4iNR
	 yE5r8ZDlsTGGRary7720MS/x7WG0P4Bw3SEKLWfHEOblNyXtN9O6Wy7nVW7BYyH/Kf
	 6MUtKypDaBNjUoeOL9FdEniDj6xB1HiJSGqbZ2IzwXBSZ3W8ucCd0noTi3QH1cVu6i
	 4Qe8Xd1k65bwKMvXXHVhN8IzWdJE2OwCii+u8KG1fmPGvrc2R7ms4rH3SbXIIJb1On
	 lk12pztt8QeSw==
Message-ID: <18ba4489-ad30-423e-9c54-d4025f74c193@kernel.org>
Date: Wed, 6 Nov 2024 14:25:00 +0100
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
 kernel-team <kernel-team@cloudflare.com>, Viktor Malik <vmalik@redhat.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <0c146fb8-4c95-4832-941f-dfc3a465cf91@kernel.org>
 <204272e7-82c3-4437-bb0d-2c3237275d1f@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <204272e7-82c3-4437-bb0d-2c3237275d1f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 26/10/2024 09.33, Yunsheng Lin wrote:
> On 2024/10/25 22:07, Jesper Dangaard Brouer wrote:
> 
> ...
> 
>>
>>>> You and Jesper seems to be mentioning a possible fact that there might
>>>> be 'hundreds of gigs of memory' needed for inflight pages, it would be nice
>>>> to provide more info or reasoning above why 'hundreds of gigs of memory' is
>>>> needed here so that we don't do a over-designed thing to support recording
>>>> unlimited in-flight pages if the driver unbound stalling turns out impossible
>>>> and the inflight pages do need to be recorded.
>>>
>>> I don't have a concrete example of a use that will blow the limit you
>>> are setting (but maybe Jesper does), I am simply objecting to the
>>> arbitrary imposing of any limit at all. It smells a lot of "640k ought
>>> to be enough for anyone".
>>>
>>
>> As I wrote before. In *production* I'm seeing TCP memory reach 24 GiB
>> (on machines with 384GiB memory). I have attached a grafana screenshot
>> to prove what I'm saying.
>>
>> As my co-worker Mike Freemon, have explain to me (and more details in
>> blogposts[1]). It is no coincident that graph have a strange "sealing"
>> close to 24 GiB (on machines with 384GiB total memory).  This is because
>> TCP network stack goes into a memory "under pressure" state when 6.25%
>> of total memory is used by TCP-stack. (Detail: The system will stay in
>> that mode until allocated TCP memory falls below 4.68% of total memory).
>>
>>   [1] https://blog.cloudflare.com/unbounded-memory-usage-by-tcp-for-receive-buffers-and-how-we-fixed-it/
> 
> Thanks for the info.

Some more info from production servers.

(I'm amazed what we can do with a simple bpftrace script, Cc Viktor)

In below bpftrace script/oneliner I'm extracting the inflight count, for
all page_pool's in the system, and storing that in a histogram hash.

sudo bpftrace -e '
  rawtracepoint:page_pool_state_release { @cnt[probe]=count();
   @cnt_total[probe]=count();
   $pool=(struct page_pool*)arg0;
   $release_cnt=(uint32)arg2;
   $hold_cnt=$pool->pages_state_hold_cnt;
   $inflight_cnt=(int32)($hold_cnt - $release_cnt);
   @inflight=hist($inflight_cnt);
  }
  interval:s:1 {time("\n%H:%M:%S\n");
   print(@cnt); clear(@cnt);
   print(@inflight);
   print(@cnt_total);
  }'

The page_pool behavior depend on how NIC driver use it, so I've run this 
on two prod servers with drivers bnxt and mlx5, on a 6.6.51 kernel.

Driver: bnxt_en
- kernel 6.6.51

@cnt[rawtracepoint:page_pool_state_release]: 8447
@inflight:
[0]             507 |                                        |
[1]             275 |                                        |
[2, 4)          261 |                                        |
[4, 8)          215 |                                        |
[8, 16)         259 |                                        |
[16, 32)        361 |                                        |
[32, 64)        933 |                                        |
[64, 128)      1966 |                                        |
[128, 256)   937052 |@@@@@@@@@                               |
[256, 512)  5178744 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)     73908 |                                        |
[1K, 2K)    1220128 |@@@@@@@@@@@@                            |
[2K, 4K)    1532724 |@@@@@@@@@@@@@@@                         |
[4K, 8K)    1849062 |@@@@@@@@@@@@@@@@@@                      |
[8K, 16K)   1466424 |@@@@@@@@@@@@@@                          |
[16K, 32K)   858585 |@@@@@@@@                                |
[32K, 64K)   693893 |@@@@@@                                  |
[64K, 128K)  170625 |@                                       |

Driver: mlx5_core
  - Kernel: 6.6.51

@cnt[rawtracepoint:page_pool_state_release]: 1975
@inflight:
[128, 256)         28293 |@@@@                               |
[256, 512)        184312 |@@@@@@@@@@@@@@@@@@@@@@@@@@@        |
[512, 1K)              0 |                                   |
[1K, 2K)            4671 |                                   |
[2K, 4K)          342571 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[4K, 8K)          180520 |@@@@@@@@@@@@@@@@@@@@@@@@@@@        |
[8K, 16K)          96483 |@@@@@@@@@@@@@@                     |
[16K, 32K)         25133 |@@@                                |
[32K, 64K)          8274 |@                                  |


The key thing to notice that we have up-to 128,000 pages in flight on
these random production servers. The NIC have 64 RX queue configured,
thus also 64 page_pool objects.

--Jesper

