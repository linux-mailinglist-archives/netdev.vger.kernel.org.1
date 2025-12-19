Return-Path: <netdev+bounces-245501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F0CCF3FB
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 11:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B02FD30164CD
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39CD2C0F83;
	Fri, 19 Dec 2025 10:00:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AB228851E
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138414; cv=none; b=T3ByU2UDnPupnWNjEA6nh5BZDNMiDjsTljdsIyrx38DL8foqCZ/xxW45pdOxq+H+tFfvujGflRGXnYlj0iUDZfZGM7gqwt8trKwS/x3jWSTEGb/zL1WRK+o6NuljpQu1DWYetKA/NqiChSNfZzTDilbROkA/Ooe8EvTfLjDUAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138414; c=relaxed/simple;
	bh=8KBxPQCN/LuLpypmUHuZcdNyUFKhh1Ub3GqSQJ6G27M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/S7lFxH7aTMY2C9GMSDTqF36PK1fYbv3EP6JUiAf5WNuyRvhGEJ3hf84EvrUOjK7iNeseVoU2CVy9BrzLANd5oE0xaCbtgCnMkrLLK1vhEOpe+FT7QXC2+nYpBdwxjf35kdUn4JaP8qJf5SzhA3DZb/DoApQMIA7uHW8uQ8nsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3196E48CA8;
	Fri, 19 Dec 2025 11:00:04 +0100 (CET)
Message-ID: <4f1829d0-7d79-45bc-9006-65c4e3449a5e@proxmox.com>
Date: Fri, 19 Dec 2025 11:00:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 lkolbe@sodiuswillert.com
References: <20250711114006.480026-1-edumazet@google.com>
 <20250711114006.480026-8-edumazet@google.com>
 <cd44c0d2-17ed-460d-9f89-759987d423dc@proxmox.com>
 <8f8836dd-c46f-403c-b478-a9e89dd62912@proxmox.com>
 <CANn89iL=MTgYygnFaCeaMpSzjooDgnzwUd_ueSnJFxasXwyMwg@mail.gmail.com>
 <c1ae58f7-cf31-4fb6-ac92-8f7b61272226@proxmox.com>
 <CANn89iJRCW3VNsY3vZwurvh52diE+scUfZvwx5bg5Tuoa3L_TQ@mail.gmail.com>
 <64d8fa05-63a2-420e-8b97-c51cb581804a@proxmox.com>
 <CANn89iKPVPHQMgMiA=sum_nAjDg6hK0WSzHjP4onUJhYkj1xUQ@mail.gmail.com>
 <CANn89iKhZ=Ofy45PBrvLLE=nqv6X7CTvrpMdYMLKeVjpN6c-3A@mail.gmail.com>
Content-Language: en-US, de-DE
From: Christian Ebner <c.ebner@proxmox.com>
In-Reply-To: <CANn89iKhZ=Ofy45PBrvLLE=nqv6X7CTvrpMdYMLKeVjpN6c-3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1766138389439

On 12/19/25 9:45 AM, Eric Dumazet wrote:
> On Fri, Dec 19, 2025 at 9:23 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Thu, Dec 18, 2025 at 3:58 PM Christian Ebner <c.ebner@proxmox.com> wrote:
>>>
>>> On 12/18/25 2:19 PM, Eric Dumazet wrote:
>>>> On Thu, Dec 18, 2025 at 1:28 PM Christian Ebner <c.ebner@proxmox.com> wrote:
>>>>>
>>>>> Hi Eric,
>>>>>
>>>>> thank you for your reply!
>>>>>
>>>>> On 12/18/25 11:10 AM, Eric Dumazet wrote:
>>>>>> Can you give us (on receive side) : cat /proc/sys/net/ipv4/tcp_rmem
>>>>>
>>>>> Affected users report they have the respective kernels defaults set, so:
>>>>> - "4096 131072 6291456"  for v.617 builds
>>>>> - "4096 131072 33554432" with the bumped max value of 32M for v6.18 builds
>>>>>
>>>>>> It seems your application is enforcing a small SO_RCVBUF ?
>>>>>
>>>>> No, we can exclude that since the output of `ss -tim` show the default
>>>>> buffer size after connection being established and growing up to the max
>>>>> value during traffic (backups being performed).
>>>>>
>>>>
>>>> The trace you provided seems to show a very different picture ?
>>>>
>>>> [::ffff:10.xx.xx.aa]:8007
>>>>          [::ffff:10.xx.xx.bb]:55554
>>>>             skmem:(r0,rb7488,t0,tb332800,f0,w0,o0,bl0,d20) cubic
>>>> wscale:10,10 rto:201 rtt:0.085/0.015 ato:40 mss:8948 pmtu:9000
>>>> rcvmss:7168 advmss:8948 cwnd:10 bytes_sent:937478 bytes_acked:937478
>>>> bytes_received:1295747055 segs_out:301010 segs_in:162410
>>>> data_segs_out:1035 data_segs_in:161588 send 8.42Gbps lastsnd:3308
>>>> lastrcv:191 lastack:191 pacing_rate 16.7Gbps delivery_rate 2.74Gbps
>>>> delivered:1036 app_limited busy:437ms rcv_rtt:207.551 rcv_space:96242
>>>> rcv_ssthresh:903417 minrtt:0.049 rcv_ooopack:23 snd_wnd:142336 rcv_wnd:7168
>>>>
>>>> rb7488 would suggest the application has played with a very small SO_RCVBUF,
>>>> or some memory allocation constraint (memcg ?)
>>>
>>> Thanks for the hint were to look, however we checked that the process is
>>> not memory constrained and the host has no memory pressure.
>>>
>>> Also `strace -f -e socket,setsockopt -p $(pidof proxmox-backup-proxy)`
>>> shows no syscalls which would change the socket buffer size (though this
>>> still needs to be double checked by affected users for completeness).
>>>
>>> Further, the stalls most often happen mid transfer, starting with the
>>> expected throughput and even might recover from the stall after some
>>> time, continue at regular speed again.
>>>
>>>
>>> Status update for v6.18
>>> -----------------------
>>>
>>> In the meantime, a user reported 2 stale connections with running kernel
>>> 6.18+416dd649f3aa
>>>
>>> The tcpdump pattern looks slightly different, here we got repeating
>>> sequences of:
>>> ```
>>> 224     5.407981        10.xx.xx.bb     10.xx.xx.aa     TCP     4162    40068 → 8007 [PSH, ACK]
>>> Seq=106497 Ack=1 Win=3121 Len=4096 TSval=3198115973 TSecr=3048094015
>>> 225     5.408064        10.xx.xx.aa     10.xx.xx.bb     TCP     66      8007 → 40068 [ACK] Seq=1
>>> Ack=110593 Win=4 Len=0 TSval=3048094223 TSecr=3198115973
>>> ```
>>>
>>> The perf trace for `tcp:tcp_rcvbuf_grow` came back empty while in stale
>>> state, tracing with:
>>> ```
>>> perf record -a -e tcp:tcp_rcv_space_adjust,tcp:tcp_rcvbuf_grow
>>> perf script
>>> ```
>>> produced some output as shown below, so it seems that tcp_rcvbuf_grow()
>>> is never called in that case, while tcp_rcv_space_adjust() is.
>>
>> Autotuning is not enabled for your case, somehow the application is
>> not behaving as expected,

Is there a way for us to check if autotuning is enabled for the TCP 
connection at this point in time? Some tracepoint to identify it being 
deactivated?

>> so maybe you have to change tcp_rmem[2] if a driver is allocating
>> order-2 pages for the 9K frames.

Same here, is there a way for us to check this? Note however that we 
could not identify a specific NIC/driver to cause the behavior, it 
appears for various vendor models.

> 
> I meant to say : change tcp_rmem[1]
> 
> echo "4096 262144 33554432" >/proc/sys/net/ipv4/tcp_rmem

Okay, thanks for the suggestion, let me get back to you with results if 
this changes anything.


>> You have not given what  was on the sender side (linux or other stack ?)

Clients are all Linux hosts, running kernel versions 6.8, 6.14 or 6.17. 
No other TCP stacks.

Best regards,
Christian Ebner


