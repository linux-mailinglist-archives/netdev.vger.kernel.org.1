Return-Path: <netdev+bounces-104490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40290CB5C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8841C225D3
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167CF1367;
	Tue, 18 Jun 2024 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cG3E9bhh"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA22139A2
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712706; cv=none; b=IqLf7Kt8XULjhBAAa5Ry+xcv470QUVg2P7sS7O7d1qjVCt82q4LFd+E7isJ1D0PETq8zHGGJNo+IuRJZEeX/YBUXJIMV9xUNbz/Bx8wC7+mr1UpdxTGpqKHKi0lHHkiIHXy9UuXg6qu/7qQBst/5+qCJC8gmT6emBfDAcVYSCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712706; c=relaxed/simple;
	bh=UMjVd7RHQ63js6eSz28rks3WGS2/v5QZ+Xm12lll1gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKjC3CwTArwosBdVb4xFsjyt4OtVdO/M/GcebeijpVRghDSy7QYDo1GLvg7WzyZ8aZff3/Mdia35OknW+bzaUaGVyoLXjmnchA6IDGsoXPMDZ9SA2+y87RGzzIvjGJV11T/5J8YTIGGtwagOtioCCyDmVcnz7F7LqTZUWnFwKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cG3E9bhh; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718712700; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Twyc4IiZE/kAoQxa9HsUrXlUIn4AwQ7+1+J+cBzuMMo=;
	b=cG3E9bhhF28LGEM8jqyuSeUkmNk80qbl/TvCN6D/vl2goDZtudes+BPMZ13Cjh6GRV/3Po1ZeRl4PM29CxXDWoZfj/IDjcbK778spAup1RUUnzVz+0sGviG3QLxBi//yKygOyI0bK26ZKiFpbWsx6CrxhjOAhp2uJb0GDUEvnv8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8k9Tj3_1718712698;
Received: from 30.221.128.129(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W8k9Tj3_1718712698)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 20:11:39 +0800
Message-ID: <46eed1f7-e3bc-4d30-a5b6-edf049160fd8@linux.alibaba.com>
Date: Tue, 18 Jun 2024 20:11:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: Add tracepoint for rxtstamp coalescing
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Mike Maloney <maloney@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 Soheil Hassas Yeganeh <soheil@google.com>
References: <20240611045830.67640-1-lulie@linux.alibaba.com>
 <c4ae602bd44e6b6ad739e1e17c444ca75587435e.camel@redhat.com>
 <CANn89iK88gJG2PsEnXWmN=kPydVqbNGZeLQ69p+Ho+60FWzaSw@mail.gmail.com>
 <8fe6208c-c408-4a14-acbc-84a1130b3ddf@linux.alibaba.com>
 <CAF=yD-Jxq2nZ2X0C3cRLUnszddwdGMS+nhCPs2uWjGqc=Amd7g@mail.gmail.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <CAF=yD-Jxq2nZ2X0C3cRLUnszddwdGMS+nhCPs2uWjGqc=Amd7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/14 20:02, Willem de Bruijn wrote:
>>>> On Tue, 2024-06-11 at 12:58 +0800, Philo Lu wrote:
>>>>> During tcp coalescence, rx timestamps of the former skb ("to" in
>>>>> tcp_try_coalesce), will be lost. This may lead to inaccurate
>>>>> timestamping results if skbs come out of order.
>>>>>
>>>>> Here is an example.
>>>>> Assume a message consists of 3 skbs, namely A, B, and C. And these skbs
>>>>> are processed by tcp in the following order:
>>>>> A -(1us)-> C -(1ms)-> B
>>>>
>>>> IMHO the above order makes the changelog confusing
>>>>
>>>>> If C is coalesced to B, the final rx timestamps of the message will be
>>>>> those of C. That is, the timestamps show that we received the message
>>>>> when C came (including hardware and software). However, we actually
>>>>> received it 1ms later (when B came).
>>>>>
>>>>> With the added tracepoint, we can recognize such cases and report them
>>>>> if we want.
>>>>
>>>> We really need very good reasons to add new tracepoints to TCP. I'm
>>>> unsure if the above example match such requirement. The reported
>>>> timestamp actually matches the first byte in the aggregate segment,
>>>> inferring anything more is IMHO stretching too far the API semantic.
>>>>
>>>
>>> Note the current behavior was a conscious choice, see
>>> commit 98aaa913b4ed2503244 ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE
>>> to TCP recvmsg")
>>> for the rationale.
>>>
>>
>> IIUC, the behavior of returning the timestamp of the skb with highest
>> sequence number works well without disorder. But once disorder occurs,
>> tcp coalescence can cause this issue.
>>
>>> Perhaps another application would need to add a new timestamp to report
>>> both the oldest and newest timestamps.
>>
>> I prefer this way, we do need both oldest and newest timestamps of a
>> message to find if any packet is unexpected delayed after sending.
>> But given there can be both hardware and software timestamps, we may
>> need more fields in sk_buff to carry these new timestamps.
> 
> Unfortunately returning multiple timestamps in tcp_recv_timestamp
> requires a new extended struct scm_timestamping, and likely an extra
> field to store both after coalescing.
> 
> FWIW, I maintain a patch that also changes semantics, by returning not
> the timestamp associated with the last byte in the message (which is
> the current defined behavior), but the first byte that makes the
> socket readable. Usually just the first byte, unless SO_RCVLOWAT is
> set.
> 
> It is definitely easier to define a flag like SOF_TIMESTAMPING_POLLIN
> that changes behavior of the one timestamp returned, than to return
> two timestamps.

I believe this is a step forward because now we can choose to get the 
oldest or newest timestamps. However, even with this option, it seems 
still unclear whether and how long an skb gets stuck in the out-of-order 
queue.

>>>
>>> Or add a socket flag to prevent coalescing for applications needing
>>> precise timestamps.
>>>
>>> Willem might know better about this.
>>>
>>> I agree the tracepoint seems not needed. What about solving the issue instead ?
>> Thanks.
> 
> A tracepoint is also not needed as a bpftrace program with kfunc on
> tcp_try_coalesce should be able to access this information already
> without kernel modifications. Or if it has to be at this line, a
> program with kprobe at offset, but that requires manual register
> reading.

Though using bpf fentry/kprobe could be feasible, I wonder if there are 
better solutions with lower cost.
(And bpf fentry/kprobe may fail because tcp_try_coalesce is static)

I mean, usually we use timestamping to reason where a jitter occurs, so 
it is expected to keep working in background (with the target 
application). In this case, kprobe without offset introduces much 
overhead in such a hot function, while kprobe with offset is of low 
compatibility for production.

The tracepoint can solve the problem, which doesn't bother the receiver 
with TIMESTAMPING disabled, and is stable enough. And I'm looking 
forward to any suggestions.

Thanks.
-- 
Philo

