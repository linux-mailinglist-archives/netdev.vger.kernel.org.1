Return-Path: <netdev+bounces-136435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6422A9A1BEB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28650285661
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A794B1D0E03;
	Thu, 17 Oct 2024 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Wg/OVTD8"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0861D0944;
	Thu, 17 Oct 2024 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151221; cv=none; b=oozt0YYYLZ7pKCHo3vOJum32WFnkTUVUX1Gjj8pEGVjSa3HX6lG+RTIGepztLGqnUisYGOzQ231F7fN4nyni0of/SdpNeIR7/Pf/quuy5t31okmCs7GF1H+Uevq6SrxDmsOfwKJlHpkD45Xq5XrVnB16Xl2wjoSgSMNhfX6WMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151221; c=relaxed/simple;
	bh=WEFdQ/1L+cmTVsAcxrGY36jlTD/ge+KIdlKGr8ku+FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKj6Bj62jtJD6tDCxzMjlIJomqlg2cYkJ7K8HO9x1+kFz6HsV/MM4GEpdRYrkHslPE2yJ+yzN7EPq3WRFjYcAUk0BVshIpjmxSM48rUPxp11bn09fIHcNAz9CKSPj/ihiN6q95GMtqCcBdVhD7C6rWz6N5e9OMF4HLXy9bE7seQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Wg/OVTD8; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729151211; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=p/n6v8y3zOUWRlDxRyulKqDGLAfg7PcAzIuEmf9PNHs=;
	b=Wg/OVTD8xPPbUeyFLkGppjk7aUenuUlXe87AjWXaW5XVQzoJOBAE5MaANHYUVhjEWm9QOHcUd+GN0exChpCyvB9G6EcpjmuiVBktqeBD0YxxDoXM06Qa/LjjefGVtwq9zkhsH0YYvUicj6bWE8VPpwVG6plh7M5mlHmxuoliEYM=
Received: from 30.221.128.107(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WHK3y4z_1729151209 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 15:46:50 +0800
Message-ID: <d9327631-0673-4e70-afe0-5923bda6fd45@linux.alibaba.com>
Date: Thu, 17 Oct 2024 15:46:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 2/3] net/udp: Add 4-tuple hash list basis
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241012012918.70888-1-lulie@linux.alibaba.com>
 <20241012012918.70888-3-lulie@linux.alibaba.com>
 <9d611cbc-3728-463d-ba8a-5732e28b8cf4@redhat.com>
 <2888bb8f-1ee4-4342-968f-82573d583709@linux.alibaba.com>
 <7dde23ec-e813-4495-a0ca-6ed0f1276aa6@redhat.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <7dde23ec-e813-4495-a0ca-6ed0f1276aa6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/16 15:45, Paolo Abeni wrote:
> On 10/16/24 08:30, Philo Lu wrote:
>> On 2024/10/14 18:07, Paolo Abeni wrote:
>>> It would be great if you could please share some benchmark showing the
>>> raw max receive PPS performances for unconnected sockets, with and
>>> without this series applied, to ensure this does not cause any real
>>> regression for such workloads.
>>>
>>
>> Tested using sockperf tp with default msgsize (14B), 3 times for w/ and
>> w/o the patch set, and results show no obvious difference:
>>
>> [msg/sec]  test1    test2    test3    mean
>> w/o patch  514,664  519,040  527,115  520.3k
>> w/  patch  516,863  526,337  527,195  523.5k (+0.6%)
>>
>> Thank you for review, Paolo.
> 
> Are the value in packet per seconds, or bytes per seconds? Are you doing 
> a loopback test or over the wire? The most important question is: is the 
> receiver side keeping (at least) 1 CPU fully busy? Otherwise the test is 
> not very relevant.
> 
> It looks like you have some setup issue, or you are using a relatively 
> low end H/W: the expected packet rate for reasonable server H/W is well 
> above 1M (possibly much more than that, but I can't put my hands on 
> recent H/W, so I can't provide a more accurate figure).
> 
> A single socket, user-space, UDP sender is usually unable to reach such 
> tput without USO, and even with USO you likely need to do an over-the- 
> wire test to really be able to keep the receiver fully busy. AFAICS 
> sockperf does not support USO for the sender.
> 
> You could use the udpgso_bench_tx/udpgso_bench_rx pair from the net 
> selftests directory instead.
> 
> Or you could use pktgen as traffic generator.
> 

I test it again with udpgso_bench_tx/udpgso_bench_rx. In server, 2 cpus 
are involved, one for udpgso_bench_rx and the other for nic rx queue so 
that the si of nic rx cpu is 100%. udpgso_bench_tx runs with payload 
size 20, and the tx pps is larger than rx ensuring rx is the bottleneck.

The outputs of udpgso_bench_rx:
[without patchset]
udp rx:     20 MB/s  1092546 calls/s
udp rx:     20 MB/s  1095051 calls/s
udp rx:     20 MB/s  1094136 calls/s
udp rx:     20 MB/s  1098860 calls/s
udp rx:     20 MB/s  1097963 calls/s
udp rx:     20 MB/s  1097460 calls/s
udp rx:     20 MB/s  1098370 calls/s
udp rx:     20 MB/s  1098089 calls/s
udp rx:     20 MB/s  1095330 calls/s
udp rx:     20 MB/s  1095486 calls/s

[with patchset]
udp rx:     21 MB/s  1105533 calls/s
udp rx:     21 MB/s  1105475 calls/s
udp rx:     21 MB/s  1104244 calls/s
udp rx:     21 MB/s  1105600 calls/s
udp rx:     21 MB/s  1108019 calls/s
udp rx:     21 MB/s  1101971 calls/s
udp rx:     21 MB/s  1104147 calls/s
udp rx:     21 MB/s  1104874 calls/s
udp rx:     21 MB/s  1101987 calls/s
udp rx:     21 MB/s  1105500 calls/s

The averages w/ and w/o the patchset are 1104735 and 1096329, the gap is 
0.8%, which I think is negligible.

Besides, perf shows ~0.6% higher cpu consumption of __udp4_lib_lookup() 
with this patchset (increasing from 5.7% to 6.3%).

Thanks.
-- 
Philo


