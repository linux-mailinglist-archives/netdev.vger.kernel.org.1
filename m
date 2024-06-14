Return-Path: <netdev+bounces-103571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1944908AC8
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8608EB2303D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C2D193064;
	Fri, 14 Jun 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fSMvx7HZ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5513B2AD
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364473; cv=none; b=j1FWhjb05jzbZPPjvXxV20NTuyWVNr324q9zCiFgviHAgitJBPS154ZlD+nhOoTiajrX2W9Kkhl7vtFnYDvsG36jcFLxuutsu7Ssx+UxKDPayx+N4oD+rucxIzj6RxvAGFWy7DWVVQucIZWNRIXEo8sK4czIJ4KYVAMm7nGDbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364473; c=relaxed/simple;
	bh=rZtPBx7+iFD320jxq5znfyw4hLcylDCCKXzYziVuykQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QOcXgA6Cyypbmr/RaNhlOBGbYazfnZS5L/XQ/vMShQUDWXnvci6OTYaYV5xmM1KfYhy/d1QDVQ1ylo5cC4KpcugtGV/A59gij7C3hmzH5dxs4VTiU+O966M1swVAk9v0HdOXBHIcDCkN/Cm5cE9vhokxe0cL7ljOphHaHyQm/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fSMvx7HZ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718364468; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=fcl9qQKSrMK7YS9FRq5JkmCPz9gSI995yCteNRW9h1U=;
	b=fSMvx7HZ1M15JAufUPdvW0k2ZaEOwG340YcAnUaQUi/DMbEyPIZw4U3roGGyWfvl+DsLt8iotaFQH4Oh4eLWn/QIzgaDwGPv5N9fJ5VBphXwi51yWZ/HQ92XNkVaDR9XVpqopi7SXIDj+BX5CLnmePjXugvzYyd2EwzocEQFhWw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8R.y9j_1718364466;
Received: from 30.221.128.116(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W8R.y9j_1718364466)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 19:27:47 +0800
Message-ID: <8fe6208c-c408-4a14-acbc-84a1130b3ddf@linux.alibaba.com>
Date: Fri, 14 Jun 2024 19:27:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Philo Lu <lulie@linux.alibaba.com>
Subject: Re: [PATCH net-next] tcp: Add tracepoint for rxtstamp coalescing
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Mike Maloney <maloney@google.com>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 Soheil Hassas Yeganeh <soheil@google.com>
References: <20240611045830.67640-1-lulie@linux.alibaba.com>
 <c4ae602bd44e6b6ad739e1e17c444ca75587435e.camel@redhat.com>
 <CANn89iK88gJG2PsEnXWmN=kPydVqbNGZeLQ69p+Ho+60FWzaSw@mail.gmail.com>
In-Reply-To: <CANn89iK88gJG2PsEnXWmN=kPydVqbNGZeLQ69p+Ho+60FWzaSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/14 16:25, Eric Dumazet wrote:
> On Fri, Jun 14, 2024 at 10:09 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On Tue, 2024-06-11 at 12:58 +0800, Philo Lu wrote:
>>> During tcp coalescence, rx timestamps of the former skb ("to" in
>>> tcp_try_coalesce), will be lost. This may lead to inaccurate
>>> timestamping results if skbs come out of order.
>>>
>>> Here is an example.
>>> Assume a message consists of 3 skbs, namely A, B, and C. And these skbs
>>> are processed by tcp in the following order:
>>> A -(1us)-> C -(1ms)-> B
>>
>> IMHO the above order makes the changelog confusing
>>
>>> If C is coalesced to B, the final rx timestamps of the message will be
>>> those of C. That is, the timestamps show that we received the message
>>> when C came (including hardware and software). However, we actually
>>> received it 1ms later (when B came).
>>>
>>> With the added tracepoint, we can recognize such cases and report them
>>> if we want.
>>
>> We really need very good reasons to add new tracepoints to TCP. I'm
>> unsure if the above example match such requirement. The reported
>> timestamp actually matches the first byte in the aggregate segment,
>> inferring anything more is IMHO stretching too far the API semantic.
>>
> 
> Note the current behavior was a conscious choice, see
> commit 98aaa913b4ed2503244 ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE
> to TCP recvmsg")
> for the rationale.
> 

IIUC, the behavior of returning the timestamp of the skb with highest 
sequence number works well without disorder. But once disorder occurs, 
tcp coalescence can cause this issue.

> Perhaps another application would need to add a new timestamp to report
> both the oldest and newest timestamps.

I prefer this way, we do need both oldest and newest timestamps of a 
message to find if any packet is unexpected delayed after sending.
But given there can be both hardware and software timestamps, we may 
need more fields in sk_buff to carry these new timestamps.

> 
> Or add a socket flag to prevent coalescing for applications needing
> precise timestamps.
> 
> Willem might know better about this.
> 
> I agree the tracepoint seems not needed. What about solving the issue instead ?
Thanks.

-- 
Philo

