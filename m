Return-Path: <netdev+bounces-206998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CDFB05256
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C023A5FC6
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9726E6E6;
	Tue, 15 Jul 2025 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="be1IOfdj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705E19307F
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752562884; cv=none; b=puW8oE7l/46JB9cMjGo31ZkDtUVTjAoFKIRgYJUXT1c1jEOElUYxLF4AkF3H7UKqflgY1E4cGsr19SDiXJwEZFrzmB3VeAry5yP86a8lwnyg+htkZ0OtakKH6sOF+QmmNEsZ1sJuk3lrQI3UBEr/wYp8Ws3Jj4RpMTAENxY8CpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752562884; c=relaxed/simple;
	bh=fxfbSVj+fk1Ndeq1ATB3dRz1ZuqIFub5WdK7JEY/dfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkEaAkCuETivJDagY2tB3+vwwtwvn6i9ei+QGrtKNbeD5g1g0LIJr7H1I6Vt7fTC/DGaBTH9KkM7BKTeqpjADOC+UuIwkCVbAnoy1I1RZY2OBG0wJt3ai9Q3nR3JYdAeAgFxBZeKMfptIfSgOqOTJ9pr27OOvscx4z19X0JNMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=be1IOfdj; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1752562879; x=1753167679; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=jnqC9yKLQ2Y78KFCIs80rSm9Z70HqexDU7UQ8kaOjM8=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=be1IOfdjGAzP+kD7y8Cso6J7NJjNDI/jBjkPI8vQRwpBhqEzVt00XZm3Y07RMXngyPfC0B/NTb7qpFfYuOlmgQchrikp/5DYL+qqjaiR9gX8tpfqUVwHn6Ipj4cLUR+4pstFAwBUvPyvesROoOtWIkJUIF3SeYAiEvI4Vsx8O6Q=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507150901160877;
        Tue, 15 Jul 2025 09:01:16 +0200
Message-ID: <8a7cea99-0ab5-4dba-bc89-62d4819531eb@cdn77.com>
Date: Tue, 15 Jul 2025 09:01:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] mm/vmpressure: add tracepoint for socket
 pressure detection
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 linux-mm@kvack.org, netdev@vger.kernel.org,
 Matyas Hurtik <matyas.hurtik@cdn77.com>,
 Daniel Sedlak <danie.sedlak@cdn77.com>
References: <20250714143613.42184-1-daniel.sedlak@cdn77.com>
 <20250714143613.42184-3-daniel.sedlak@cdn77.com>
 <CAAVpQUAsZsEKQ65Kuh7wmcf6Yqq8m4im7dYFvVd1RL4QHxMN8g@mail.gmail.com>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <CAAVpQUAsZsEKQ65Kuh7wmcf6Yqq8m4im7dYFvVd1RL4QHxMN8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A006378.6875FCDE.0019,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Hi Kuniyuki,

On 7/14/25 8:02 PM, Kuniyuki Iwashima wrote:
>> +TRACE_EVENT(memcg_socket_under_pressure,
>> +
>> +       TP_PROTO(const struct mem_cgroup *memcg, unsigned long scanned,
>> +               unsigned long reclaimed),
>> +
>> +       TP_ARGS(memcg, scanned, reclaimed),
>> +
>> +       TP_STRUCT__entry(
>> +               __field(u64, id)
>> +               __field(unsigned long, scanned)
>> +               __field(unsigned long, reclaimed)
>> +       ),
>> +
>> +       TP_fast_assign(
>> +               __entry->id = cgroup_id(memcg->css.cgroup);
>> +               __entry->scanned = scanned;
>> +               __entry->reclaimed = reclaimed;
>> +       ),
>> +
>> +       TP_printk("memcg_id=%llu scanned=%lu reclaimed=%lu",
>> +               __entry->id,
> 
> Maybe a noob question: How can we translate the memcg ID
> to the /sys/fs/cgroup/... path ?

IMO this should be really named `cgroup_id` instead of `memcg_id`, but 
we kept the latter to keep consistency with the rest of the file.

To find cgroup path you can use:
- find /sys/fs/cgroup/ -inum `memcg_id`, and it will print "path" to the 
affected cgroup.
- or you can use bpftrace tracepoint hooks and there is a helper 
function [1].

Or we can put the cgroup_path to the tracepoint instead of that ID, but 
I feel it can be too much overhead, the paths can be pretty long.

Link: https://bpftrace.org/docs/latest#functions-cgroup_path [1]
> It would be nice to place this patch first and the description of
> patch 2 has how to use the new stat with this tracepoint.

Sure, can do that. However, I am unsure how a good idea is to 
cross-reference commits, since each may go through a different tree 
because each commit is for a different subsystem. They would have to go 
through one tree, right?


>> +               __entry->scanned,
>> +               __entry->reclaimed)
>> +);
>> +
>>   #endif /* _TRACE_MEMCG_H */
>>
>>   /* This part must be outside protection */
>> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
>> index bd5183dfd879..aa9583066731 100644
>> --- a/mm/vmpressure.c
>> +++ b/mm/vmpressure.c
>> @@ -21,6 +21,8 @@
>>   #include <linux/printk.h>
>>   #include <linux/vmpressure.h>
>>
>> +#include <trace/events/memcg.h>
>> +
>>   /*
>>    * The window size (vmpressure_win) is the number of scanned pages before
>>    * we try to analyze scanned/reclaimed ratio. So the window is used as a
>> @@ -317,6 +319,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>>                           * pressure events can occur.
>>                           */
>>                          WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
>> +                       trace_memcg_socket_under_pressure(memcg, scanned, reclaimed);
> 
> This is triggered only when we enter the memory pressure state
> and not when we leave the state, right ?  Is it possible to issue
> such an event ?

AFAIK, the currently used API in the vmpressure function does not have 
anything like enter or leave the socket memory pressure state. It only 
periodically re-arms the socket pressure for a specific duration. So the 
current tracepoint is called when the socket pressure is re-armed.

I am not sure how feasible it is to rewrite it so we have enter and 
leave logic. I am not that familiar with those code paths.

Thanks!
Daniel



