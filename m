Return-Path: <netdev+bounces-91227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 595998B1C70
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E641C2166B
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F35C7602B;
	Thu, 25 Apr 2024 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vrv5domQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C36F085
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032393; cv=none; b=efjMs88xlWEl6RoD+d8pNMdvogcbaXPgzGyQSunAcPPgrNcBXB1HyTj+tdO47cK5mst5+0BkjbQ/OqiaTE8E0ZkLP6SYZprR+hJkDeq33Qq+pl+OCk4nimkA+SjCUch+iLvT4nY2vK1nhRGrIaG8qDy4nT36aEfI6wNJ25m7mws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032393; c=relaxed/simple;
	bh=z9NWLtvzsZOnZoVEybYdz+wvMQJHZXXa6BGqWDJ1EY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hm2VJBXi/fQ7TlfsFQtj54ZYSeD3yrB8mvz5aE0cnNNXbTosWc+a14Liv1oKuuQjr+T41qjuozfzTKTuQHwA5rWEVS7zUk1cPE4gmuLamCOm4XmfIbqSMNvmUJc41gZK+a79naf1pTe5d5nefs6VBATF52O1npHBulyQNT5D2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vrv5domQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714032390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WcfmhUicLvLqkW2UhSJBj+LL0vSWaU88yJgN8qC9Sg=;
	b=Vrv5domQYXFrodQP2GM8e75GX2msJe5SivTv/Nu/W6nYo+rKDJlvXFX+XTCAIktHT4pt34
	LX8A0SZoJ5VRdP0mP4h0uAcrJt8fbds1UJf9WOMVaycgv6coKlgvYCEv3z2DTakUqrW1kV
	+td7SsGwZ+AQzh9r04SvgHkwSunYlBI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-uS5je0NtOwG98dLjDMHMLQ-1; Thu, 25 Apr 2024 04:06:26 -0400
X-MC-Unique: uS5je0NtOwG98dLjDMHMLQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69bb9eda9caso11667446d6.3
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 01:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714032385; x=1714637185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WcfmhUicLvLqkW2UhSJBj+LL0vSWaU88yJgN8qC9Sg=;
        b=AcohOFwx0iLT/agzcOsyZjwAnwxX+vhtK3WV5kYVXX4fcWD3YO+HKjW3JuwQqEkRHq
         rWhKA9osqn4UpRhN61zBGxzF7y6OgDl/SQeitYJIMhrj3e4+KFs9VZIfkvlD3J7tzwDv
         huKUGRp2E0/qxPt9Tpo30ZHQXwg9PUi2VJkyVfZYT9JdSpOznbz4V+l4C7APNZxlVt6J
         T3tgQ50nM2xdyJ2/HGItq5nT2oJ5oXTq6XQPfaWSLDezxoKksUx7BNzkJQgwXds9Iq6v
         wRgnNRkfg0/80H/j5+o/6DiCm8vNzWI+nI1hF5UYZte1PBaXQLHmCC3MG1PniEmSrpu/
         /Y4A==
X-Gm-Message-State: AOJu0YwoLURLlaMY5ByyncRIqctUHcLPHpLA4WBvS2G25XikTjkPq0Rb
	+j2J3FEcDZQPXEhWjJ9lw2UXHZ7i12rgdElhkosVexCxiAbHWw6w3hYhlm/zw8WwiFb9O2uaJml
	4xzBa+gyiBrwFN8B2iNSf0Fyqj+pZ9hrqLZ+JzOMXPe3FE2DdWBYJ2w==
X-Received: by 2002:a05:6214:4c0a:b0:69b:46ab:e20 with SMTP id qh10-20020a0562144c0a00b0069b46ab0e20mr4834921qvb.17.1714032385158;
        Thu, 25 Apr 2024 01:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGokjAt4b6wIpPK9BDHlrIGSmFRxpa92ObkwRmnAtbspC5ggMjXVxb22y5jRIrRy9/3ambUOA==
X-Received: by 2002:a05:6214:4c0a:b0:69b:46ab:e20 with SMTP id qh10-20020a0562144c0a00b0069b46ab0e20mr4834902qvb.17.1714032384807;
        Thu, 25 Apr 2024 01:06:24 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.210.114])
        by smtp.gmail.com with ESMTPSA id i9-20020a0cf109000000b006a04a3d4fbesm6790260qvl.56.2024.04.25.01.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 01:06:24 -0700 (PDT)
Message-ID: <542ed8dd-2d9c-4e4f-81dc-e2a9bdaac3b0@redhat.com>
Date: Thu, 25 Apr 2024 10:06:20 +0200
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
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <ZioDvluh7ymBI8qF@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/24 09:18, Ido Schimmel wrote:
> On Wed, Apr 24, 2024 at 03:50:51PM +0200, Adrian Moreno wrote:
>> Currently there are no widely-available tools to dump the metadata and
>> group information when a packet is sampled, making it difficult to
>> troubleshoot related issues.
>>
>> This makes psample use the event tracing framework to log the sampling
>> of a packet so that it's easier to quickly identify the source
>> (i.e: group) and context (i.e: metadata) of a packet being sampled.
>>
>> This patch creates some checkpatch splats, but the style of the
>> tracepoint definition mimics that of other modules so it seems
>> acceptable.
> 
> I don't see a good reason to add this tracepoint (which we won't be able
> to remove) when you can easily do that with bpftrace which by now should
> be widely available:
> 
> #!/usr/bin/bpftrace
> 
> kfunc:psample_sample_packet
> {
>          $ts_us = nsecs() / 1000;
>          $secs = $ts_us / 1000000;
>          $us = $ts_us % 1000000;
>          $group = args.group;
>          $skb = args.skb;
>          $md = args.md;
> 
>          printf("%-16s %-6d %6llu.%6llu group_num = %u refcount=%u seq=%u skbaddr=%p len=%u data_len=%u sample_rate=%u in_ifindex=%d out_ifindex=%d user_cookie=%rx\n",
>                 comm, pid, $secs, $us, $group->group_num, $group->refcount, $group->seq,
>                 $skb, $skb->len, $skb->data_len, args.sample_rate,
>                 $md->in_ifindex, $md->out_ifindex,
>                 buf($md->user_cookie, $md->user_cookie_len));
> }
> 
> Example output:
> 
> mausezahn        984      3299.200626 group_num = 1 refcount=1 seq=13775 skbaddr=0xffffa21143fd4000 len=42 data_len=0 sample_rate=10 in_ifindex=0 out_ifindex=20 user_cookie=
> \xde\xad\xbe\xef
> mausezahn        984      3299.281424 group_num = 1 refcount=1 seq=13776 skbaddr=0xffffa21143fd4000 len=42 data_len=0 sample_rate=10 in_ifindex=0 out_ifindex=20 user_cookie=
> \xde\xad\xbe\xef
> 
> Note that it prints the cookie itself unlike the tracepoint which only
> prints the hashed pointer.
> 

I agree that bpftrace can do the work relying on kfuncs/kprobes. But I guess 
that also true for many other tracepoints out there, right?

For development and labs bpftrace is perfectly fine, but using kfuncs and 
requiring recompilation is harder in production systems compared with using 
smaller CO-RE tools.

If OVS starts using psample heavily and users need to troubleshoot or merely 
observe packets as they are sampled in a more efficient way, they are likely to 
use ebpf for that. I think making it a bit easier (as in, providing a sligthly 
more stable tracepoint) is worth considering.

Can you please expand on your concerns about the tracepoint? It's on the main 
internal function of the module so, even though the function name or its 
arguments might change, it doesn't seem probable that it'll disappear 
altogether. Why else would we want to remove the tracepoint?

>>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>>   net/psample/psample.c |  9 +++++++
>>   net/psample/trace.h   | 62 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 71 insertions(+)
>>   create mode 100644 net/psample/trace.h
>>
>> diff --git a/net/psample/psample.c b/net/psample/psample.c
>> index 476aaad7a885..92db8ffa2ba2 100644
>> --- a/net/psample/psample.c
>> +++ b/net/psample/psample.c
>> @@ -18,6 +18,12 @@
>>   #include <net/ip_tunnels.h>
>>   #include <net/dst_metadata.h>
>>   
>> +#ifndef __CHECKER__
>> +#define CREATE_TRACE_POINTS
>> +#endif
>> +
>> +#include "trace.h"
>> +
>>   #define PSAMPLE_MAX_PACKET_SIZE 0xffff
>>   
>>   static LIST_HEAD(psample_groups_list);
>> @@ -470,6 +476,9 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>>   	void *data;
>>   	int ret;
>>   
>> +	if (trace_psample_sample_packet_enabled())
>> +		trace_psample_sample_packet(group, skb, sample_rate, md);
> 
> My understanding is that trace_x_enabled() should only be used if you
> need to do some work to prepare parameters for the tracepoint.
> 

Oh, thanks for that! I was not aware.

>> +
>>   	meta_len = (in_ifindex ? nla_total_size(sizeof(u16)) : 0) +
>>   		   (out_ifindex ? nla_total_size(sizeof(u16)) : 0) +
>>   		   (md->out_tc_valid ? nla_total_size(sizeof(u16)) : 0) +
> 


