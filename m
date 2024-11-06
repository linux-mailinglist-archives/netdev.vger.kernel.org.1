Return-Path: <netdev+bounces-142442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F17C9BF24D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A62283C70
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3B2038C5;
	Wed,  6 Nov 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWovxzsU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598EC190075;
	Wed,  6 Nov 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908651; cv=none; b=SeZCPJlI1ipvT8/UrWCO+n9VklCKAyL2ISzmUqG4Gv6FgecJAGAZYLwCzXT5gnH+oynQRo+0qv2l+eQgY4ZYzS2gpungc88TOsR3RX5paBul7HqW2dtg3Bd20WB8RI0ZQtqFgua3lDbIISo/bM3yGlTpV/CcqCi5aiYTXxbznSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908651; c=relaxed/simple;
	bh=hL3/AiTUyM9f/ClgjbViiWTaBnOSPZP5UlllxCvfslE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=PY3KWX9mRV9Aw1iXUayVBJRwdOat/9zpwrnAcb1REfGiTGT2uexAR4sOnMrFAXaxHdomdVGslPkH42w+76guG24ejVVu6WbCSAXdFIo/SvekWVyNuD7B1fbDAAfmgCQNQXZLnRibL4e8QGi7mH0+e2hq1tZJ6Lqxh9ZL67A8qOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWovxzsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2114BC4CEC6;
	Wed,  6 Nov 2024 15:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908651;
	bh=hL3/AiTUyM9f/ClgjbViiWTaBnOSPZP5UlllxCvfslE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=TWovxzsUZoMUcsupSP1TsmzLxOXF8RWpG72e+lNGlZ3II6x6bWP8hGKiczh2xL7aX
	 sh+lc/USMZnbOhUC7B0rGRCMt6/KLxTJoSj8RKGa1Vxl9t0sV5Z9mGhzJf9r94hvXZ
	 B2S39eXuLIYyeGi2xcLEuNbpJeGeApNkl07+55tfMTAfb6VCzZOlh5RyRgvvZ/HFPF
	 TR2dya8+00foq53oIc3yQe/y5KSrYPfDAhpg5r/bQDBeoleZFzRdKTWCRNxh5IKHuL
	 ovLSvaes4hzBMv3KPAT8azf/LxgVFuBIV3bNbGbh4KTv5kIynpgPM8/la7FQ46osi1
	 9nafxBwCZYhmQ==
Content-Type: multipart/mixed; boundary="------------DkaSgiVyEyouYV9Gnp3M5WgO"
Message-ID: <b8b7818a-e44b-45f5-91c2-d5eceaa5dd5b@kernel.org>
Date: Wed, 6 Nov 2024 16:57:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
From: Jesper Dangaard Brouer <hawk@kernel.org>
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
 <18ba4489-ad30-423e-9c54-d4025f74c193@kernel.org>
Content-Language: en-US
In-Reply-To: <18ba4489-ad30-423e-9c54-d4025f74c193@kernel.org>

This is a multi-part message in MIME format.
--------------DkaSgiVyEyouYV9Gnp3M5WgO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/11/2024 14.25, Jesper Dangaard Brouer wrote:
> 
> On 26/10/2024 09.33, Yunsheng Lin wrote:
>> On 2024/10/25 22:07, Jesper Dangaard Brouer wrote:
>>
>> ...
>>
>>>
>>>>> You and Jesper seems to be mentioning a possible fact that there might
>>>>> be 'hundreds of gigs of memory' needed for inflight pages, it would 
>>>>> be nice
>>>>> to provide more info or reasoning above why 'hundreds of gigs of 
>>>>> memory' is
>>>>> needed here so that we don't do a over-designed thing to support 
>>>>> recording
>>>>> unlimited in-flight pages if the driver unbound stalling turns out 
>>>>> impossible
>>>>> and the inflight pages do need to be recorded.
>>>>
>>>> I don't have a concrete example of a use that will blow the limit you
>>>> are setting (but maybe Jesper does), I am simply objecting to the
>>>> arbitrary imposing of any limit at all. It smells a lot of "640k ought
>>>> to be enough for anyone".
>>>>
>>>
>>> As I wrote before. In *production* I'm seeing TCP memory reach 24 GiB
>>> (on machines with 384GiB memory). I have attached a grafana screenshot
>>> to prove what I'm saying.
>>>
>>> As my co-worker Mike Freemon, have explain to me (and more details in
>>> blogposts[1]). It is no coincident that graph have a strange "sealing"
>>> close to 24 GiB (on machines with 384GiB total memory).  This is because
>>> TCP network stack goes into a memory "under pressure" state when 6.25%
>>> of total memory is used by TCP-stack. (Detail: The system will stay in
>>> that mode until allocated TCP memory falls below 4.68% of total memory).
>>>
>>>   [1] 
>>> https://blog.cloudflare.com/unbounded-memory-usage-by-tcp-for-receive-buffers-and-how-we-fixed-it/
>>
>> Thanks for the info.
> 
> Some more info from production servers.
> 
> (I'm amazed what we can do with a simple bpftrace script, Cc Viktor)
> 
> In below bpftrace script/oneliner I'm extracting the inflight count, for
> all page_pool's in the system, and storing that in a histogram hash.
> 
> sudo bpftrace -e '
>   rawtracepoint:page_pool_state_release { @cnt[probe]=count();
>    @cnt_total[probe]=count();
>    $pool=(struct page_pool*)arg0;
>    $release_cnt=(uint32)arg2;
>    $hold_cnt=$pool->pages_state_hold_cnt;
>    $inflight_cnt=(int32)($hold_cnt - $release_cnt);
>    @inflight=hist($inflight_cnt);
>   }
>   interval:s:1 {time("\n%H:%M:%S\n");
>    print(@cnt); clear(@cnt);
>    print(@inflight);
>    print(@cnt_total);
>   }'
> 
> The page_pool behavior depend on how NIC driver use it, so I've run this 
> on two prod servers with drivers bnxt and mlx5, on a 6.6.51 kernel.
> 
> Driver: bnxt_en
> - kernel 6.6.51
> 
> @cnt[rawtracepoint:page_pool_state_release]: 8447
> @inflight:
> [0]             507 |                                        |
> [1]             275 |                                        |
> [2, 4)          261 |                                        |
> [4, 8)          215 |                                        |
> [8, 16)         259 |                                        |
> [16, 32)        361 |                                        |
> [32, 64)        933 |                                        |
> [64, 128)      1966 |                                        |
> [128, 256)   937052 |@@@@@@@@@                               |
> [256, 512)  5178744 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [512, 1K)     73908 |                                        |
> [1K, 2K)    1220128 |@@@@@@@@@@@@                            |
> [2K, 4K)    1532724 |@@@@@@@@@@@@@@@                         |
> [4K, 8K)    1849062 |@@@@@@@@@@@@@@@@@@                      |
> [8K, 16K)   1466424 |@@@@@@@@@@@@@@                          |
> [16K, 32K)   858585 |@@@@@@@@                                |
> [32K, 64K)   693893 |@@@@@@                                  |
> [64K, 128K)  170625 |@                                       |
> 
> Driver: mlx5_core
>   - Kernel: 6.6.51
> 
> @cnt[rawtracepoint:page_pool_state_release]: 1975
> @inflight:
> [128, 256)         28293 |@@@@                               |
> [256, 512)        184312 |@@@@@@@@@@@@@@@@@@@@@@@@@@@        |
> [512, 1K)              0 |                                   |
> [1K, 2K)            4671 |                                   |
> [2K, 4K)          342571 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [4K, 8K)          180520 |@@@@@@@@@@@@@@@@@@@@@@@@@@@        |
> [8K, 16K)          96483 |@@@@@@@@@@@@@@                     |
> [16K, 32K)         25133 |@@@                                |
> [32K, 64K)          8274 |@                                  |
> 
> 
> The key thing to notice that we have up-to 128,000 pages in flight on
> these random production servers. The NIC have 64 RX queue configured,
> thus also 64 page_pool objects.
> 

I realized that we primarily want to know the maximum in-flight pages.

So, I modified the bpftrace oneliner to track the max for each page_pool 
in the system.

sudo bpftrace -e '
  rawtracepoint:page_pool_state_release { @cnt[probe]=count();
   @cnt_total[probe]=count();
   $pool=(struct page_pool*)arg0;
   $release_cnt=(uint32)arg2;
   $hold_cnt=$pool->pages_state_hold_cnt;
   $inflight_cnt=(int32)($hold_cnt - $release_cnt);
   $cur=@inflight_max[$pool];
   if ($inflight_cnt > $cur) {
     @inflight_max[$pool]=$inflight_cnt;}
  }
  interval:s:1 {time("\n%H:%M:%S\n");
   print(@cnt); clear(@cnt);
   print(@inflight_max);
   print(@cnt_total);
  }'

I've attached the output from the script.
For unknown reason this system had 199 page_pool objects.

The 20 top users:

$ cat out02.inflight-max | grep inflight_max | tail -n 20
@inflight_max[0xffff88829133d800]: 26473
@inflight_max[0xffff888293c3e000]: 27042
@inflight_max[0xffff888293c3b000]: 27709
@inflight_max[0xffff8881076f2800]: 29400
@inflight_max[0xffff88818386e000]: 29690
@inflight_max[0xffff8882190b1800]: 29813
@inflight_max[0xffff88819ee83800]: 30067
@inflight_max[0xffff8881076f4800]: 30086
@inflight_max[0xffff88818386b000]: 31116
@inflight_max[0xffff88816598f800]: 36970
@inflight_max[0xffff8882190b7800]: 37336
@inflight_max[0xffff888293c38800]: 39265
@inflight_max[0xffff888293c3c800]: 39632
@inflight_max[0xffff888293c3b800]: 43461
@inflight_max[0xffff888293c3f000]: 43787
@inflight_max[0xffff88816598f000]: 44557
@inflight_max[0xffff888132ce9000]: 45037
@inflight_max[0xffff888293c3f800]: 51843
@inflight_max[0xffff888183869800]: 62612
@inflight_max[0xffff888113d08000]: 73203

Adding all values together:

  grep inflight_max out02.inflight-max | awk 'BEGIN {tot=0} {tot+=$2; 
printf "total:" tot "\n"}' | tail -n 1

total:1707129

Worst case we need a data structure holding 1,707,129 pages.
Fortunately, we don't need a single data structure as this will be split
between 199 page_pool's.

--Jesper

--------------DkaSgiVyEyouYV9Gnp3M5WgO
Content-Type: text/plain; charset=UTF-8; name="out02.inflight-max"
Content-Disposition: attachment; filename="out02.inflight-max"
Content-Transfer-Encoding: base64

MTU6MDc6MDUKQGNudFtyYXd0cmFjZXBvaW50OnBhZ2VfcG9vbF9zdGF0ZV9yZWxlYXNlXTog
NjM0NApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJkOTgwMF06IDMxOApAaW5mbGlnaHRf
bWF4WzB4ZmZmZjg4YTA3MTcwMzgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1
MTM2NzgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJmYzAwMF06IDMxOApA
aW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTM2NTAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4
ZmZmZjg4YTE1MTJkODAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJmZTgw
MF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJkZDgwMF06IDMxOApAaW5mbGln
aHRfbWF4WzB4ZmZmZjg4YTE1MTJkZTgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4
YTA3MTcwNzgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJmZjAwMF06IDMx
OApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJkZDAwMF06IDMxOApAaW5mbGlnaHRfbWF4
WzB4ZmZmZjg4YTE1MTJkYzgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTM2
NjgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTA3MTcwMTAwMF06IDMxOApAaW5m
bGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJmOTgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZm
Zjg4YTA3MTcwNjAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJmYjAwMF06
IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTA3MTcwMDAwMF06IDMxOApAaW5mbGlnaHRf
bWF4WzB4ZmZmZjg4YTE1MTM2MDgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1
MTJmYTgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTM2MDAwMF06IDMxOApA
aW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTM2MTgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4
ZmZmZjg4YTE1MTJkYTAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJkZTAw
MF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJkYjgwMF06IDMxOApAaW5mbGln
aHRfbWF4WzB4ZmZmZjg4YTE1MTJmYjgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4
YTE1MTJmZTAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTM2NDgwMF06IDMx
OApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTA3MTcwNjgwMF06IDMxOApAaW5mbGlnaHRfbWF4
WzB4ZmZmZjg4YTE1MTM2NDAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJm
ZDAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTM2NjAwMF06IDMxOApAaW5m
bGlnaHRfbWF4WzB4ZmZmZjg4YTA3MTcwMTgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZm
Zjg4YTE1MTJkYTgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTA3MTcwMDgwMF06
IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJmZDgwMF06IDMxOApAaW5mbGlnaHRf
bWF4WzB4ZmZmZjg4YTA3MTcwMjAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1
MTM2NTgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTM2MTAwMF06IDMxOApA
aW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJmODAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4
ZmZmZjg4YTA3MTcwNTAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTM2Mzgw
MF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTM2MjAwMF06IDMxOApAaW5mbGln
aHRfbWF4WzB4ZmZmZjg4YTE1MTJkODgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4
YTA3MTcwNDgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJkYjAwMF06IDMx
OApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJmYzgwMF06IDMxOApAaW5mbGlnaHRfbWF4
WzB4ZmZmZjg4YTE1MTJkZjAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJm
ODgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJkZjgwMF06IDMxOApAaW5m
bGlnaHRfbWF4WzB4ZmZmZjg4YTA3MTcwNzAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZm
Zjg4YTE1MTJkYzAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTA3MTcwNDAwMF06
IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTA3MTcwMjgwMF06IDMxOApAaW5mbGlnaHRf
bWF4WzB4ZmZmZjg4YTA3MTcwMzAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1
MTJkOTAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTM2MjgwMF06IDMxOApA
aW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTM2NzAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4
ZmZmZjg4YTE1MTJmOTAwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTM2MzAw
MF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4YTE1MTJmYTAwMF06IDMxOApAaW5mbGln
aHRfbWF4WzB4ZmZmZjg4YTA3MTcwNTgwMF06IDMxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4
OTkxZDk2OTAwMF06IDMzMQpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdiNjgwMF06IDMz
NgpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTkxZDk2YzAwMF06IDMzOQpAaW5mbGlnaHRfbWF4
WzB4ZmZmZjg4OTljYTdiNjAwMF06IDM0MApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdi
MzAwMF06IDM0MgpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdhMTgwMF06IDM0MgpAaW5m
bGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdiMjgwMF06IDM0MgpAaW5mbGlnaHRfbWF4WzB4ZmZm
Zjg4OTljYTdhNzgwMF06IDM0MwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTkxZDk2ZTAwMF06
IDM0MwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTkxZDk2YTAwMF06IDM0NApAaW5mbGlnaHRf
bWF4WzB4ZmZmZjg4OTkxZDk2YjAwMF06IDM0NApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OThi
M2M5MjgwMF06IDM0NQpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdhNDgwMF06IDM0NQpA
aW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdiNDAwMF06IDM0NgpAaW5mbGlnaHRfbWF4WzB4
ZmZmZjg4OThiM2M5MzgwMF06IDM0NwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTkxZDk2ODAw
MF06IDM0NwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTkxZDk2ZjgwMF06IDM0OApAaW5mbGln
aHRfbWF4WzB4ZmZmZjg4OThiM2M5MjAwMF06IDM0OApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4
OTkxZDk2YjgwMF06IDM1MApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OThiM2M5MDgwMF06IDM1
MApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OThiM2M5NjgwMF06IDM1MQpAaW5mbGlnaHRfbWF4
WzB4ZmZmZjg4OTljYTdiNTAwMF06IDM1MQpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OThiM2M5
NzgwMF06IDM1MQpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdiNDgwMF06IDM1MgpAaW5m
bGlnaHRfbWF4WzB4ZmZmZjg4OThiM2M5MzAwMF06IDM1MwpAaW5mbGlnaHRfbWF4WzB4ZmZm
Zjg4OTkxZDk2OTgwMF06IDM1MwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdiNTgwMF06
IDM1NApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdhMjAwMF06IDM1NwpAaW5mbGlnaHRf
bWF4WzB4ZmZmZjg4OThiM2M5MTAwMF06IDM1NwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OThi
M2M5NzAwMF06IDM1NwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdiMTAwMF06IDM1OApA
aW5mbGlnaHRfbWF4WzB4ZmZmZjg4OThiM2M5NDAwMF06IDM1OQpAaW5mbGlnaHRfbWF4WzB4
ZmZmZjg4OTkxZDk2ZDgwMF06IDM2MgpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdiMDgw
MF06IDM2MwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdhMTAwMF06IDM2NApAaW5mbGln
aHRfbWF4WzB4ZmZmZjg4OTljYTdhMDAwMF06IDM2NApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4
OThiM2M5NTgwMF06IDM2NApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdiNzgwMF06IDM2
NApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OThiM2M5NDgwMF06IDM2NQpAaW5mbGlnaHRfbWF4
WzB4ZmZmZjg4OTkxZDk2ZDAwMF06IDM2NQpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTkxZDk2
ODgwMF06IDM2NQpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OThiM2M5MDAwMF06IDM2NQpAaW5m
bGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdhNTgwMF06IDM2NQpAaW5mbGlnaHRfbWF4WzB4ZmZm
Zjg4OTljYTdhNTAwMF06IDM2NgpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdhMjgwMF06
IDM2NgpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdiMDAwMF06IDM2NgpAaW5mbGlnaHRf
bWF4WzB4ZmZmZjg4OTljYTdhNzAwMF06IDM2NwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTkx
ZDk2YTgwMF06IDM2OApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTkxZDk2YzgwMF06IDM2OApA
aW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdhMDgwMF06IDM2OApAaW5mbGlnaHRfbWF4WzB4
ZmZmZjg4OTljYTdhMzgwMF06IDM3MApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTkxZDk2ZjAw
MF06IDM3MQpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTkxZDk2ZTgwMF06IDM3MgpAaW5mbGln
aHRfbWF4WzB4ZmZmZjg4OTljYTdiMzgwMF06IDM3MwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4
OTljYTdiMjAwMF06IDM3MwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdiNzAwMF06IDM3
MwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdhNjgwMF06IDM3MwpAaW5mbGlnaHRfbWF4
WzB4ZmZmZjg4OTljYTdhNDAwMF06IDM3NApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdh
NjAwMF06IDM3NwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OTljYTdhMzAwMF06IDM3OApAaW5m
bGlnaHRfbWF4WzB4ZmZmZjg4OThiM2M5NTAwMF06IDM3OQpAaW5mbGlnaHRfbWF4WzB4ZmZm
Zjg4OThiM2M5MTgwMF06IDM3OQpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4OThiM2M5NjAwMF06
IDM4OQpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODExMTA3OTgwMF06IDQyMDEKQGluZmxpZ2h0
X21heFsweGZmZmY4ODgxMTEyMDUwMDBdOiA0MjAzCkBpbmZsaWdodF9tYXhbMHhmZmZmODg4
MTExMDc5MDAwXTogNDM5MwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODExMzRmYjgwMF06IDQ1
MTkKQGluZmxpZ2h0X21heFsweGZmZmY4ODgxMTEwN2Q4MDBdOiA0NTIwCkBpbmZsaWdodF9t
YXhbMHhmZmZmODg4MTEzNGZjODAwXTogNDU4NgpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODEx
MTA3YTAwMF06IDQ2NTAKQGluZmxpZ2h0X21heFsweGZmZmY4ODgxMTExYjE4MDBdOiA1Njc0
CkBpbmZsaWdodF9tYXhbMHhmZmZmODg4MTExMDdkMDAwXTogNjMxNApAaW5mbGlnaHRfbWF4
WzB4ZmZmZjg4ODI5M2MzZDgwMF06IDExNzE0CkBpbmZsaWdodF9tYXhbMHhmZmZmODg4MTgz
ODZjMDAwXTogMTIzMDIKQGluZmxpZ2h0X21heFsweGZmZmY4ODgyOTNjM2MwMDBdOiAxMjM5
MwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODEzMmNlYTgwMF06IDEyNTAwCkBpbmZsaWdodF9t
YXhbMHhmZmZmODg4MTY1OTY2MDAwXTogMTI5NDAKQGluZmxpZ2h0X21heFsweGZmZmY4ODgx
MTNkMGQ4MDBdOiAxMzM3MApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODE4Mzg2YzgwMF06IDEz
NTEwCkBpbmZsaWdodF9tYXhbMHhmZmZmODg4MTEzZDBjODAwXTogMTQwMjcKQGluZmxpZ2h0
X21heFsweGZmZmY4ODgyMTkwYjA4MDBdOiAxNTE0OQpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4
ODEzMmNlYjgwMF06IDE1NDA1CkBpbmZsaWdodF9tYXhbMHhmZmZmODg4MTMyY2ViMDAwXTog
MTU2MzMKQGluZmxpZ2h0X21heFsweGZmZmY4ODgxODM4NjkwMDBdOiAxNTY4NApAaW5mbGln
aHRfbWF4WzB4ZmZmZjg4ODE4Mzg2YjgwMF06IDE2MTQyCkBpbmZsaWdodF9tYXhbMHhmZmZm
ODg4MTMyY2VkMDAwXTogMTY0NTAKQGluZmxpZ2h0X21heFsweGZmZmY4ODgxNjU5NjQ4MDBd
OiAxNzAwNwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODIxOTBiNTgwMF06IDE3ODc5CkBpbmZs
aWdodF9tYXhbMHhmZmZmODg4MjE5MGI2MDAwXTogMTc5MTUKQGluZmxpZ2h0X21heFsweGZm
ZmY4ODgxOWVlODA4MDBdOiAxNzk3NwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODE5ZWU4NDAw
MF06IDE4MTMyCkBpbmZsaWdodF9tYXhbMHhmZmZmODg4MTE4NjgwMDAwXTogMTgyMDQKQGlu
ZmxpZ2h0X21heFsweGZmZmY4ODgxMTg2ODA4MDBdOiAxODUxNApAaW5mbGlnaHRfbWF4WzB4
ZmZmZjg4ODE5ZWU4MzAwMF06IDE4NTQ2CkBpbmZsaWdodF9tYXhbMHhmZmZmODg4MTgzODY4
MDAwXTogMTg1NTIKQGluZmxpZ2h0X21heFsweGZmZmY4ODgxMDc2ZjE4MDBdOiAxODcwNgpA
aW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODE5ZWU4NzAwMF06IDE4ODAxCkBpbmZsaWdodF9tYXhb
MHhmZmZmODg4MTY1OTY1ODAwXTogMTk1NTYKQGluZmxpZ2h0X21heFsweGZmZmY4ODgyOTNj
M2QwMDBdOiAyMDY3NQpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODE4Mzg2ZDAwMF06IDIwNzQ5
CkBpbmZsaWdodF9tYXhbMHhmZmZmODg4MTgzODZhODAwXTogMjEyMjYKQGluZmxpZ2h0X21h
eFsweGZmZmY4ODgxODM4Njg4MDBdOiAyMTU1OQpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODEw
NzZmMzAwMF06IDIxOTMzCkBpbmZsaWdodF9tYXhbMHhmZmZmODg4MjkzYzNhMDAwXTogMjIw
ODYKQGluZmxpZ2h0X21heFsweGZmZmY4ODgxOWVlODI4MDBdOiAyMjk3NQpAaW5mbGlnaHRf
bWF4WzB4ZmZmZjg4ODE4Mzg2YTAwMF06IDIzNjAwCkBpbmZsaWdodF9tYXhbMHhmZmZmODg4
MTY1OThjMDAwXTogMjQwOTIKQGluZmxpZ2h0X21heFsweGZmZmY4ODgyOTNjMzk4MDBdOiAy
NDA5MwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODE4Mzg2ZjAwMF06IDI0NDM4CkBpbmZsaWdo
dF9tYXhbMHhmZmZmODg4MTEzZDBlODAwXTogMjQ4ODIKQGluZmxpZ2h0X21heFsweGZmZmY4
ODgyOTNjMzkwMDBdOiAyNTIxOApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODE4Mzg2ZDgwMF06
IDI1Mjc2CkBpbmZsaWdodF9tYXhbMHhmZmZmODg4MjkzYzNhODAwXTogMjUyOTIKQGluZmxp
Z2h0X21heFsweGZmZmY4ODgyOTNjM2U4MDBdOiAyNTQyOQpAaW5mbGlnaHRfbWF4WzB4ZmZm
Zjg4ODI5M2MzODAwMF06IDI1Nzk0CkBpbmZsaWdodF9tYXhbMHhmZmZmODg4MTA3NmY2ODAw
XTogMjYwMzAKQGluZmxpZ2h0X21heFsweGZmZmY4ODgyOTEzM2Q4MDBdOiAyNjQ3MwpAaW5m
bGlnaHRfbWF4WzB4ZmZmZjg4ODI5M2MzZTAwMF06IDI3MDQyCkBpbmZsaWdodF9tYXhbMHhm
ZmZmODg4MjkzYzNiMDAwXTogMjc3MDkKQGluZmxpZ2h0X21heFsweGZmZmY4ODgxMDc2ZjI4
MDBdOiAyOTQwMApAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODE4Mzg2ZTAwMF06IDI5NjkwCkBp
bmZsaWdodF9tYXhbMHhmZmZmODg4MjE5MGIxODAwXTogMjk4MTMKQGluZmxpZ2h0X21heFsw
eGZmZmY4ODgxOWVlODM4MDBdOiAzMDA2NwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODEwNzZm
NDgwMF06IDMwMDg2CkBpbmZsaWdodF9tYXhbMHhmZmZmODg4MTgzODZiMDAwXTogMzExMTYK
QGluZmxpZ2h0X21heFsweGZmZmY4ODgxNjU5OGY4MDBdOiAzNjk3MApAaW5mbGlnaHRfbWF4
WzB4ZmZmZjg4ODIxOTBiNzgwMF06IDM3MzM2CkBpbmZsaWdodF9tYXhbMHhmZmZmODg4Mjkz
YzM4ODAwXTogMzkyNjUKQGluZmxpZ2h0X21heFsweGZmZmY4ODgyOTNjM2M4MDBdOiAzOTYz
MgpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODI5M2MzYjgwMF06IDQzNDYxCkBpbmZsaWdodF9t
YXhbMHhmZmZmODg4MjkzYzNmMDAwXTogNDM3ODcKQGluZmxpZ2h0X21heFsweGZmZmY4ODgx
NjU5OGYwMDBdOiA0NDU1NwpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4ODEzMmNlOTAwMF06IDQ1
MDM3CkBpbmZsaWdodF9tYXhbMHhmZmZmODg4MjkzYzNmODAwXTogNTE4NDMKQGluZmxpZ2h0
X21heFsweGZmZmY4ODgxODM4Njk4MDBdOiA2MjYxMgpAaW5mbGlnaHRfbWF4WzB4ZmZmZjg4
ODExM2QwODAwMF06IDczMjAzCkBjbnRfdG90YWxbcmF3dHJhY2Vwb2ludDpwYWdlX3Bvb2xf
c3RhdGVfcmVsZWFzZV06IDY3MjYzMTI5Cg==

--------------DkaSgiVyEyouYV9Gnp3M5WgO--

