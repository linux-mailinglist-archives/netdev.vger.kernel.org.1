Return-Path: <netdev+bounces-287183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P8dFxQ+A2po2AEAu9opvQ
	(envelope-from <netdev+bounces-287183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:49:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB9C522EA1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60F6A317AFD0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1782239D3F1;
	Tue, 12 May 2026 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMOAil2L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64B839D3CE;
	Tue, 12 May 2026 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594096; cv=none; b=Jb5buI8Xw3R0JI+wKPOiaSTFGBRdxS23aNu5mSWGBm/qx0hmPwuuyuTs2W9EKEkpwavEdcc1gFxtBZ83XZUcOJEwhZIzzRdxnMdsc4ChcwO528DHVgW/Rv2AE8L5Lb/8+ieKjvrS2ZjjHs8m9WmAzWfCUwqzA3bUUkO+FSh6fRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594096; c=relaxed/simple;
	bh=8FUrlrnlV2S6IbQzISn71o21kS6vMOb4QyGxMRKQLhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POUG+i4b+xsB3VTMID05607FM/WAn2DT+GsDnn1OuCVQ0Jq7H0DR6C2mjSWUNHVskKU+dOmP8kKBn0wamkTGNEboQ5etH/m+iZekFdUxiK0Onp0XCXKxbLfIHW2aLMXNOTHdl3uyMotwQpdNb0S2JyLYhxK9CzGVKjEwsndmMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMOAil2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626DAC2BCFA;
	Tue, 12 May 2026 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594095;
	bh=8FUrlrnlV2S6IbQzISn71o21kS6vMOb4QyGxMRKQLhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EMOAil2LP3RXQaSYLvOdjEAcx/+vWF7UQieKCZ5bPd/Na731IVp7R5WdbFCTdJfrR
	 LQGs79cWxu4/tNwNO2oodluAbFxGPwWzWwfUX+sFeIaWUN6YWAwRmO7rNtdtQnHXWd
	 rxvY3FD1ZSDzwnWeSXhseqojhdGaYuYsiz+VnoPJBk67zhRqCtVTEuywfkAl6bLxm7
	 zO33mjvVKeARllNi6NgiK7psUJWZ/YjsXz2cOCBLsMh9EJnqfqvowJPrLulH10ZeRc
	 T0Uf2/SKDLH+PG5CvelGBwIXtOn8Wf3sOXSeSWpLkFgePWoMS9dSrms2iX/9XBHdfs
	 sniWXNatMgiEg==
Message-ID: <18855e57-f050-411f-9958-d4babcc81ba3@kernel.org>
Date: Tue, 12 May 2026 15:54:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Simon Schippers <simon@schippers-hamm.de>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-4-hawk@kernel.org>
 <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
 <8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
 <e3a91545-13cd-4f87-8375-d707865bdbca@schippers-hamm.de>
 <6a597dbd-70bf-4b14-b495-2f7248fd3220@kernel.org>
 <20260508190626.4285fac0@kernel.org>
 <f459b95c-80d5-4e05-84b2-f574c92724de@kernel.org>
 <20260510085602.57c7a081@kernel.org>
 <daa05c21-dcfc-4cc4-aa22-9e25c7f6c743@kernel.org>
 <41023c34-87a3-4e4f-b3ab-3ed53d171910@schippers-hamm.de>
 <b78f002a-8cb9-4857-bf8f-0137e790f644@kernel.org>
 <873511fa-4316-4411-a76b-ec4c5805abd3@schippers-hamm.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <873511fa-4316-4411-a76b-ec4c5805abd3@schippers-hamm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CEB9C522EA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287183-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,veth_bql_test_virtme.sh:url]
X-Rspamd-Action: no action




On 11/05/2026 22.37, Simon Schippers wrote:
> On 5/11/26 20:08, Jesper Dangaard Brouer wrote:
>>
>>
>> On 11/05/2026 11.55, Simon Schippers wrote:
>>> On 5/11/26 10:11, Jesper Dangaard Brouer wrote:
>>>>
>>>>
>>>> On 10/05/2026 17.56, Jakub Kicinski wrote:
>>>>> On Sat, 9 May 2026 11:09:51 +0200 Jesper Dangaard Brouer wrote:
>>>>>> On 09/05/2026 04.06, Jakub Kicinski wrote:
>>>>>>> On Thu, 7 May 2026 21:09:09 +0200 Jesper Dangaard Brouer wrote:
>>>>>>>> Not against being able to modify VETH_RING_SIZE, but I don't think it is
>>>>>>>> the solution here.
>>>>>>>
>>>>>>> Was it evaluated, tho?
>>>>>>>
>>>>>>> It's obviously super easy these days have AI spew no end of complex
>>>>>>> code. So it'd be great to have some solid, ideally production-like
>>>>>>> data to back this all up.
>>>>>>>
>>>>>>> VETH_RING_SIZE seems trivial, ethtool set ringparam
>>>>>>
>>>>>> No, unfortunately we cannot just decrease the VETH_RING_SIZE.
>>>>>
>>>>> To be clear - I said may it configurable with ethtool -G
>>>>> not change the default.
>>>>>
>>>>
>>>> Sure, I understand the desire to make VETH_RING_SIZE configurable.
>>>> If doing so we are making Linux network stack harder to tune and setup
>>>> correctly. E.g. adding a qdisc to veth would also require changing the
>>>> ring size, but if system also uses XDP then tuning below 64 (likely 128)
>>>> will lead to hard-to-find packet drops.
>>>
>>> I mean 64 still could be a 4x improvement at least.
>>>
>>
>> No not really, setting it to 64 will give same (bad) latency from "BQL
>> off" which that patchset is trying to address.
>>
>>>>
>>>> I prefer adding something (like BQL) that auto-tune how much of the ring
>>>> queue we are using.  Good queues function as shock absorbers when
>>>> concurrent processes in the OS have scheduling noise.
>>>>
>>>> I acknowledge that Simon Schippers found that the BQL implementation was
>>>> actually not auto-tuning.  We need to work on this, my prototype
>>>> implementation [1] [2] works surprisingly well.
>>>>
>>>>
>>>> - [1] https://lore.kernel.org/all/3e43117f-356d-4086-a176-abd7fe2e6f0a@kernel.org/2-09-veth-time-based-bql-coalescing.patch
>>>> - [2] https://lore.kernel.org/all/3e43117f-356d-4086-a176-abd7fe2e6f0a@kernel.org/
>>>>
>>>>
>>>>>> The reason is that XDP-redirect into veth don't have any
>>>>>> back-pressure and would simply drop packets if queue size becomes
>>>>>> less than the NAPI budget (64). (Yes, we use both normal path and
>>>>>> XDP-redirect in production).
>>>>>
>>>>> Doesn't this mean you have a queue which is not under BQL control?
>>>>>
>>>>
>>>> It is a matter of perspective. BQL needs between 17-55 elements in the
>>>> 256 queue.  At the same time we handle if the ring runs full, e.g. due
>>>> to a sudden burst of XDP redirected packets, which pushes packets into
>>>> the qdisc layer.
>>>
>>> You are checking inflight/limit in /sys directory to get the 17-55
>>> number, right?
>>>
>>
>> Nope, I'm using a bpftrace program to keep track of the inflight/limit
>> in a BPF hashmap.  Reading from /sys will not be accurate.
> 
> Ah nice.

Add the option --hist to have both NAPI and BQL histograms printed when
script ends.  This will give you an accurate pattern of how inflight and
limit evolves.

>>
>> I moved the selftests into a github repo [1] to allow us to collaborate
>> and evaluate the changes more easily.  I explicitly kept the new BPF
>> based BQL tracking as a commit[2] for your benefit.
>>
>>   [1] https://github.com/netoptimizer/veth-backpressure-performance-testing/tree/main/selftests
>>
>>   [2] https://github.com/netoptimizer/veth-backpressure-performance-testing/commit/f25c5dc92977
> 
> Thanks for sharing. After minor issues I was able to set it up
> (currently I am just using plain v5, will look at the coalescing patch
> when I find the time):
> 
> Can confirm the latency reduction with the default settings, in my case
> 4.888ms to 0.241ms.
> 
> With the same script I was also able to see a performance slow down:
> veth_bql_test_virtme.sh --qdisc fq_codel --nrules 0
> --> ~510 Kpps
> Same with --bql-disable
> --> ~570 Kpps
> --> 12% faster
> 

Thanks for running these benchmarks.

Notice that --nrules 0 can easily result in no-queuing (on average),
because the veth NAPI consumer is faster than the producer.  You will
likely see BQL inflight=1 and sink reported avg latency very low
(remember it okay that sink get high latency penalty as long at ping
latency remains low, as that show AQM is working).

There is an important gotcha. We actually have micro-burst of queuing
(likely due to scheduling noise). Reading BQL stats from /sys will show
BQL inflight=1, but when using the option --hist is it visible that
@inflight have a long tail (see below signature).  The "qdisc" output
line also shows this happening via requeues increasing (approx 17/sec in
a test with 567Kpps). (this was with the time-based BQL impl).


>>
>> Sorry for cutting the remaining of the message, but I ran out of time,
>> as things are a bit challenging/hectic here at Cloudflare at the moment.
>>
>> --Jesper
> 
> All good, just ignore it. I think I misunderstood something anyway.

Okay, I'll ignore it as I couldn't make sense of it ;-)
--Jesper



--- BQL inflight histogram (VETH_BQL_UNIT=1, values = packets) ---
@inflight:
[0, 1)            306565 |@ 
      |
[1, 2)           9250454 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2, 3)           5561919 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[3, 4)            354341 |@ 
      |
[4, 5)             50137 | 
      |
[5, 6)             16771 | 
      |
[6, 7)              6001 | 
      |
[7, 8)              3076 | 
      |
[8, 9)              1949 | 
      |
[9, 10)             1965 | 
      |
[10, 11)            1954 | 
      |
[11, 12)            1914 | 
      |
[12, 13)            1732 | 
      |
[13, 14)            1559 | 
      |
[14, 15)            1405 | 
      |
[15, 16)            1269 | 
      |
[16, 17)            1194 | 
      |
[17, 18)            1190 | 
      |
[18, 19)            1148 | 
      |
[19, 20)            1079 | 
      |
[20, 21)            1008 | 
      |
[21, 22)             951 | 
      |
[22, 23)             870 | 
      |
[23, 24)             826 | 
      |
[24, 25)             775 | 
      |
[25, 26)             764 | 
      |
[26, 27)             740 | 
      |
[27, 28)             714 | 
      |
[28, 29)             665 | 
      |
[29, 30)             626 | 
      |
[30, 31)             607 | 
      |
[31, 32)             601 | 
      |
[32, 33)             583 | 
      |
[33, 34)             593 | 
      |
[34, 35)             574 | 
      |
[35, 36)             562 | 
      |
[36, 37)             554 | 
      |
[37, 38)             538 | 
      |
[38, 39)             528 | 
      |
[39, 40)             525 | 
      |
[40, 41)             512 | 
      |
[41, 42)             542 | 
      |
[42, 43)             529 | 
      |
[43, 44)             526 | 
      |
[44, 45)             513 | 
      |
[45, 46)             503 | 
      |
[46, 47)             485 | 
      |
[47, 48)             480 | 
      |
[48, 49)             473 | 
      |
[49, 50)             474 | 
      |
[50, 51)             476 | 
      |
[51, 52)             476 | 
      |
[52, 53)             465 | 
      |
[53, 54)             454 | 
      |
[54, 55)             446 | 
      |
[55, 56)             430 | 
      |
[56, 57)             425 | 
      |
[57, 58)             425 | 
      |
[58, 59)             422 | 
      |
[59, 60)             407 | 
      |
[60, 61)             390 | 
      |
[61, 62)             370 | 
      |
[62, 63)             354 | 
      |
[63, 64)             343 | 
      |
[64, 65)             325 | 
      |
[65, 66)             303 | 
      |
[66, 67)             158 | 
      |
[67, 68)             136 | 
      |
[68, 69)             124 | 
      |
[69, 70)             110 | 
      |
[70, 71)              99 | 
      |
[71, 72)              94 | 
      |
[72, 73)              82 | 
      |
[73, 74)              74 | 
      |
[74, 75)              58 | 
      |
[75, 76)              52 | 
      |
[76, 77)              45 | 
      |
[77, 78)              40 | 
      |
[78, 79)              39 | 
      |
[79, 80)              38 | 
      |
[80, 81)              21 | 
      |
[81, 82)               4 | 
      |
[82, 83)               4 | 
      |
[83, 84)               4 | 
      |
[84, 85)               2 | 
      |
[85, 86)               2 | 
      |
[86, 87)               2 | 
      |
[87, 88)               2 | 
      |
[88, 89)               1 | 
      |


--- BQL limit histogram (auto-tuned, values = packets) ---
@limit_val:
[61, 62)          221346 |@ 
      |
[62, 63)               0 | 
      |
[63, 64)          772169 |@@@ 
      |
[64, 65)        10053949 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[65, 66)               0 | 
      |
[66, 67)               0 | 
      |
[67, 68)               0 | 
      |
[68, 69)               0 | 
      |
[69, 70)               0 | 
      |
[70, 71)          457838 |@@ 
      |
[71, 72)               0 | 
      |
[72, 73)          610198 |@@@ 
      |
[73, 74)               0 | 
      |
[74, 75)               0 | 
      |
[75, 76)               0 | 
      |
[76, 77)               0 | 
      |
[77, 78)               0 | 
      |
[78, 79)         2328284 |@@@@@@@@@@@@ 
      |
[79, 80)         1150181 |@@@@@ 
      |

@inflight_stats: count 15593965, average 1, total 23078061

@limit_stats: count 15593965, average 67, total 1054054856



