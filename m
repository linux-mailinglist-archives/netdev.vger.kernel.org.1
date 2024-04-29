Return-Path: <netdev+bounces-92035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4EC8B50C2
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 07:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD7C1F21CCF
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 05:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD24FDDCB;
	Mon, 29 Apr 2024 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOxbQTJL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035D7DDB1
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714368852; cv=none; b=b13mP2D2peHUQmo6tdfJoo24XWHKAF9iaC0AAdMpVkJiq9CAKP9pPSPyIapHziWWT3pwC31kf29wLau/0iVBIHmfsbLZVkADy/V954xqe9Z6STN7awIS4zN/rKXBOaTBy5+Y9m+/SrWDKrKE4JApVtbmo4OFuMjsMeAxJvgRy+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714368852; c=relaxed/simple;
	bh=TIXAj1vDw8yeDkEzbdDF0i7iyfyqhgKy44sw2luvvcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cX/V5XMjaoltzaxjKwcLMjeF7ErIE5kZqw1Vi6oSca10S30AoChB0W3hp+m1y1uQkOe0vuNLcIkP7k90p+fe+7ybrrXLVFWUOWM2sv13M85DkJuBeMKvXydhupbDe4i8SdMKgC1HXZr160K0F4vgvcOhsKeKTydnyBTgUAOuGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOxbQTJL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714368849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5HKdktcPTQLHAhy6G4toZcd+wzsJ2LHw+RNWERO240=;
	b=fOxbQTJLIpfujv+Mlj73goK3c2wZlLxeZbQRTMFbmbpOKQDvMCM021hlCxkYk6/hR4NfYn
	g9iELvxbj3qbrDdnj22qCSwRFcCIXwudWXLTuEAANbuDrWEOQObhc5KEi+PYIWGG1cpYip
	T24kbv3rXr1wtXM5uwaadAGH3jWhkzU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-gWSpfZDYOBSLEt5Xg3EsBg-1; Mon, 29 Apr 2024 01:34:06 -0400
X-MC-Unique: gWSpfZDYOBSLEt5Xg3EsBg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69649f1894dso70232506d6.0
        for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 22:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714368846; x=1714973646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5HKdktcPTQLHAhy6G4toZcd+wzsJ2LHw+RNWERO240=;
        b=D6K8yuY0B0yAv6AkV1MTNXs8cI6koXk0tJTd12nKUQPBkOWhwQLN5RHHBXLXWwWxOD
         2Lb26u82DOEHOSQpnvIw+hqhXrt7u+kn0WOiXZoxksuKkcY9fTuQeftz7uly/14kUM9Z
         bygEuLrE0HHHKsItimx8wENsR4rVdBUeOdqDyPJMuN55V4DurRrUrkln7dGnibFLG6O5
         HCIdhIlAGElTpdkawetOanR9BvL6pU7m532T54dDGfWJ5njRJw9c1wZahwc1rGeBYauG
         FzeG1fPz1lj8uHOUQJbE0QYQxIgHQ2BSx+h4q2XwDlngmU75ctexjawGczRAuYwNhxyV
         gH5A==
X-Gm-Message-State: AOJu0Yy1RMjMOYf2WlZKXLWsf+DvA+HUvGFx0roo6nKEwrwLhSJDcWMb
	v1T45+7gxYpYMNmLOWH0HV/roN9cPzG3BYHt6/qwkpPG1JHWBWsj8BM0g9nxdSc4cAD3NQUJRrM
	1Myn3qnDnIQF2NdcAv2lKXWO+BSmYhcmQw6RQ93G2F+ko9ESKzNrYIA==
X-Received: by 2002:ac8:7f46:0:b0:43a:b531:5e6f with SMTP id g6-20020ac87f46000000b0043ab5315e6fmr4488839qtk.62.1714368846052;
        Sun, 28 Apr 2024 22:34:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz6LEEPrYl843QlnQMyzRQSwoCIlYfYduB6F9TQ4+bZl/wQrAkCS2VBwd1jCVVajJTq6TgRg==
X-Received: by 2002:ac8:7f46:0:b0:43a:b531:5e6f with SMTP id g6-20020ac87f46000000b0043ab5315e6fmr4488816qtk.62.1714368845524;
        Sun, 28 Apr 2024 22:34:05 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.210.114])
        by smtp.gmail.com with ESMTPSA id f15-20020ac8470f000000b0043a7cb47069sm2655123qtp.9.2024.04.28.22.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 22:34:05 -0700 (PDT)
Message-ID: <96bd71d6-2978-435f-99f8-c31097487cac@redhat.com>
Date: Mon, 29 Apr 2024 07:33:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] net: psample: add tracepoint
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org, i.maximets@ovn.org, Yotam Gigi <yotam.gi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240424135109.3524355-1-amorenoz@redhat.com>
 <20240424135109.3524355-5-amorenoz@redhat.com> <ZioDvluh7ymBI8qF@shredder>
 <542ed8dd-2d9c-4e4f-81dc-e2a9bdaac3b0@redhat.com> <Zip1zKzG5aF1ceom@shredder>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <Zip1zKzG5aF1ceom@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/24 17:25, Ido Schimmel wrote:
> On Thu, Apr 25, 2024 at 10:06:20AM +0200, Adrian Moreno wrote:
>>
>>
>> On 4/25/24 09:18, Ido Schimmel wrote:
>>> On Wed, Apr 24, 2024 at 03:50:51PM +0200, Adrian Moreno wrote:
>>>> Currently there are no widely-available tools to dump the metadata and
>>>> group information when a packet is sampled, making it difficult to
>>>> troubleshoot related issues.
>>>>
>>>> This makes psample use the event tracing framework to log the sampling
>>>> of a packet so that it's easier to quickly identify the source
>>>> (i.e: group) and context (i.e: metadata) of a packet being sampled.
>>>>
>>>> This patch creates some checkpatch splats, but the style of the
>>>> tracepoint definition mimics that of other modules so it seems
>>>> acceptable.
>>>
>>> I don't see a good reason to add this tracepoint (which we won't be able
>>> to remove) when you can easily do that with bpftrace which by now should
>>> be widely available:
>>>
>>> #!/usr/bin/bpftrace
>>>
>>> kfunc:psample_sample_packet
>>> {
>>>           $ts_us = nsecs() / 1000;
>>>           $secs = $ts_us / 1000000;
>>>           $us = $ts_us % 1000000;
>>>           $group = args.group;
>>>           $skb = args.skb;
>>>           $md = args.md;
>>>
>>>           printf("%-16s %-6d %6llu.%6llu group_num = %u refcount=%u seq=%u skbaddr=%p len=%u data_len=%u sample_rate=%u in_ifindex=%d out_ifindex=%d user_cookie=%rx\n",
>>>                  comm, pid, $secs, $us, $group->group_num, $group->refcount, $group->seq,
>>>                  $skb, $skb->len, $skb->data_len, args.sample_rate,
>>>                  $md->in_ifindex, $md->out_ifindex,
>>>                  buf($md->user_cookie, $md->user_cookie_len));
>>> }
>>>
>>> Example output:
>>>
>>> mausezahn        984      3299.200626 group_num = 1 refcount=1 seq=13775 skbaddr=0xffffa21143fd4000 len=42 data_len=0 sample_rate=10 in_ifindex=0 out_ifindex=20 user_cookie=
>>> \xde\xad\xbe\xef
>>> mausezahn        984      3299.281424 group_num = 1 refcount=1 seq=13776 skbaddr=0xffffa21143fd4000 len=42 data_len=0 sample_rate=10 in_ifindex=0 out_ifindex=20 user_cookie=
>>> \xde\xad\xbe\xef
>>>
>>> Note that it prints the cookie itself unlike the tracepoint which only
>>> prints the hashed pointer.
>>>
>>
>> I agree that bpftrace can do the work relying on kfuncs/kprobes. But I guess
>> that also true for many other tracepoints out there, right?
> 
> Maybe, but this particular tracepoint is not buried deep inside some
> complex function with manipulated data being passed as arguments.
> Instead, this tracepoint is placed at the very beginning of the function
> and takes the function arguments as its own arguments. The tracepoint
> can be easily replaced with fentry/kprobes like I've shown with the
> example above.
> 
>> For development and labs bpftrace is perfectly fine, but using kfuncs and
>> requiring recompilation is harder in production systems compared with using
>> smaller CO-RE tools.
> 
> I used bpftrace because it is very easy to write, but I could have done
> the same with libbpf. I have a bunch of such tools that I wrote over the
> years that I compiled once on my laptop and which I copy to various
> machines where I need them.
>

My worry is that if tools are built around a particular kprobe/kfunc they will 
break if the function name or its arguments change, where as a tracepoint give 
them a bit more stability across kernel versions. This breakage might not be a 
huge problem for bpftrace since the user can change the script at runtime, but 
libbpf programs will need recompilation or some kind of version-detection mechanism.

Given the observability-oriented nature of psample I can very much see tools 
like this being built (I myself plan to write one for OVS repo) and my concern 
is having their stability depend on a function name or arguments not changing 
across versions.


>> If OVS starts using psample heavily and users need to troubleshoot or merely
>> observe packets as they are sampled in a more efficient way, they are likely
>> to use ebpf for that. I think making it a bit easier (as in, providing a
>> sligthly more stable tracepoint) is worth considering.
> 
> I'm not saying that it's not worth considering, I'm simply saying that
> it should be done after gathering operational experience with existing
> mechanisms. It's possible you will conclude that this tracepoint is not
> actually needed.
> 
> Also, there are some disadvantages in using tracepoints compared to
> fentry:
> 
> https://github.com/Mellanox/mlxsw/commit/e996fd583eff1c43aacb9c79e55f5add12402d7d
> https://lore.kernel.org/all/CAEf4BzbhvD_f=y3SDAiFqNvuErcnXt4fErMRSfanjYQg5=7GJg@mail.gmail.com/#t
> 
> Not saying that's the case here, but worth considering / being aware.
> 
>> Can you please expand on your concerns about the tracepoint? It's on the
>> main internal function of the module so, even though the function name or
>> its arguments might change, it doesn't seem probable that it'll disappear
>> altogether. Why else would we want to remove the tracepoint?
> 
> It's not really concerns, but dissatisfaction. It's my impression (might
> be wrong) that this series commits to adding new interfaces without
> first seriously evaluating existing ones. This is true for this patch
> and patch #2 that adds a new netlink command instead of using
> SO_ATTACH_FILTER like existing applications are doing to achieve the
> same goal.
> 
> I guess some will disagree, but wanted to voice my opinion nonetheless.
> 

That's a fair point and I appreciate the feedback.

For patch #2, I can concede that it's just making applications slightly simpler 
without providing any further stability guarantees. I'm OK removing it.

And, I fail to convince you of the usefulness of the tracepoint, I can remove it 
as well.

Thanks.


