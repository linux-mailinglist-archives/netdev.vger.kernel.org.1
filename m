Return-Path: <netdev+bounces-136095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D3F9A0496
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD52F281832
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14262036E7;
	Wed, 16 Oct 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="svm83vBC"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E011865E2;
	Wed, 16 Oct 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068462; cv=none; b=krWmGOyOIitk4JLRLAQFy8kJzDqX+plepenBiMhCXmV5Cs8mThSfuOwZjAJ14mSPHNtVPEvAT6r7+I3o/HVsdOmactvrNoLXv2HWElFn74fsZQyv5s+DHCS94//6Y2ucBTt2R8Q4FOEgB10wz8JADWUoVPkr87nhqkZxJGPolh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068462; c=relaxed/simple;
	bh=82YI7Z52AFsteD5PsTQd98UUo48eHMHj25ilOXMJ9lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atPMb0addIMPRX7v44RABznmw5mFANEMyPRnA0mBKxt4Pu1Q6xoW3IIu+v+jO7AWkATj+eJCVg0Loonh2CWY2pq39Mwu9N5HDBbAx3d4fn0wRxMwAuAyVAVo1iXKQtPo00pfbdscdCmb1imZ4FLVqXbMdwG5UIV00Fs7dJmvI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=svm83vBC; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729068456; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vqPkEBMNc4XMmyNn8kfg23RI9ATLDy2sfoPdlwSx/js=;
	b=svm83vBCjJ0D8PaC6yXtZYu4GqLYHYl5a1QeY55rlqfXHk+ArSkfyQYS45o1WNWbLqQ7EoOt+CTXGmFR5ujTGB8g8ZRC2XTbt5SbduubepHdbYCs5FiL5v6AeF4k6zq8SU63MKdwp64LLU2Gv7mXiXByts1RGx5oVouLQgw6m0E=
Received: from 30.221.128.116(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WHGiB83_1729068455 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 16:47:36 +0800
Message-ID: <bd4e9e18-caf8-45eb-9b53-8bc5fc24e925@linux.alibaba.com>
Date: Wed, 16 Oct 2024 16:47:35 +0800
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

It's in packet per seconds (msg/sec). I make the cpu fully busy by 
binding the nic irq the same cpu with the server socket. The consumption 
is like:

%Cpu0:
3.0 us,  35.0 sy,  0.0 ni,  0.0 id,  0.0 wa,  7.0 hi,  55.0 si,  0.0 st

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

Thank you for your suggestion. I'll try it to see if I can get higher pps.
-- 
Philo


