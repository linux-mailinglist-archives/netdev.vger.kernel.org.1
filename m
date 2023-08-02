Return-Path: <netdev+bounces-23662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CBA76D011
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630C51C213AA
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B106AA4;
	Wed,  2 Aug 2023 14:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E588BE3
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 14:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C329EC433C7;
	Wed,  2 Aug 2023 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690986622;
	bh=omrJJb+W+ZQRsLgQkmzMuvL0MAff1nLVyAJPatK7Mbc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=clltoR53tfkazZp/tZgf4XZNftETDrJjUKFE7tXcLSuSlVGXoHckd6ZgXEWSfksH3
	 ucn8JTGwd3+1qIC/oS7Ijmo3JIpqldnIepM1qlRwqM9ONJLbPvqJIUnMbvi2umAGml
	 ZgZgF3V5JW8WaGBb6JH7+fvnGsP0+rK8gjoBYLz7Kh5xiqoCuxYxADTEVfmTBbfVHf
	 CTEoM1NJKhesMVXe8fy24h41i/mv2QQJB8Y8UM5JMW+TNMT3ulIMMGPLvi/fxkAdwy
	 S6rv4Wvzybaf1DYqE40idFJJfVw8xU0wwbyNUHMyMWrhJWhN6rEK8lCst/GaIxP4Rl
	 Oce3vmVPV1sTw==
Message-ID: <d1b1c0cc-c542-e626-9f35-8ad0dabb56b0@kernel.org>
Date: Wed, 2 Aug 2023 16:30:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: Linux NetDev <netdev@vger.kernel.org>, Pengtao He <hepengtao@xiaomi.com>,
 Willem Bruijn <willemb@google.com>, Stanislav Fomichev <sdf@google.com>,
 Xiao Ma <xiaom@google.com>, Patrick Rohr <prohr@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Dave Tucker <datucker@redhat.com>,
 Vincent Bernat <vincent@bernat.ch>, Marek Majkowski <marek@cloudflare.com>
Subject: Re: Performance question: af_packet with bpf filter vs TX path
 skb_clone
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, =?UTF-8?Q?Maciej_=c5=bbenczykowski?=
 <maze@google.com>
References: <CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com>
 <CANn89iJ+iWS_d3Vwg6k03mp4v_6OXHB1oS76A+9p1U7hGKdFng@mail.gmail.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CANn89iJ+iWS_d3Vwg6k03mp4v_6OXHB1oS76A+9p1U7hGKdFng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maze,

Great to see you on the netdev list again. I want to kickstart this
thread again, as I think it is a general netstack issue that should be
solved (I was on vacation when thread was active).

On 21/07/2023 20.14, Eric Dumazet wrote:
> On Fri, Jul 21, 2023 at 7:55 PM Maciej Żenczykowski <maze@google.com> wrote:
>>
>> I've been asked to review:
>>    https://android-review.googlesource.com/c/platform/packages/modules/NetworkStack/+/2648779
>>

So, this is blocking TCP zero-copy send feature, according to link.

>> where it comes to light that in Android due to background debugging of
>> connectivity problems
>> (of which there are *plenty* due to various types of buggy [primarily]
>> wifi networks)
>> we have a permanent AF_PACKET, ETH_P_ALL socket with a cBPF filter:
>>

Many userspace programs/daemons have a permanent AF_PACKET (sock_raw 
"tcpdump") socket running with a cBPF filter attached.

Examples of programs:
  - DHCP clients and servers.
  - LLDP (Link Layer Discovery Protocol) daemons (Cc. Vincent)
  - Path MTU daemons (https://github.com/cloudflare/pmtud/) (Cc Marek)
  - etc.

>>     arp or (ip and udp port 68) or (icmp6 and ip6[40] >= 133 and ip6[40] <= 136)
>>
>> ie. it catches ARP, IPv4 DHCP and IPv6 ND (NS/NA/RS/RA)
>>
>> If I'm reading the kernel code right this appears to cause skb_clone()
>> to be called on *every* outgoing packet,
>> even though most packets will not be accepted by the filter.
>>

So, you are saying the issue only occurs for TX ?

Would it be an option to change your AF_PACKET socket to ignore outgoing 
traffic?

For some of the daemons (listed above) it might be possible to ignore
outgoing packets, and thus not enable the TX hook and thus avoid the skb
cloning.


>> (In the TX path the filter appears to get called *after* the clone,
>> I think that's unlike the RX path where the filter is called first)
>>

I don't fully understand what you are saying here.
Is the RX path affected or not?


>> Unfortunately, I don't think it's possible to eliminate the
>> functionality this socket provides.
>> We need to be able to log RX & TX of ARP/DHCP/ND for debugging /
>> bugreports / etc.
>> and they *really* should be in order wrt. to each other.
>> (and yeah, that means last few minutes history when an issue happens,
>> so not possible to simply enable it on demand)
>>
>> We could of course split the socket into 3 separate ones:
>> - ETH_P_ARP
>> - ETH_P_IP + cbpf udp dport=dhcp
>> - ETH_P_IPV6 + cbpf icmpv6 type=NS/NA/RS/RA
>>
>> But I don't think that will help - I believe we'll still get
>> skb_clone() for every outbound ipv4/ipv6 packet.
>>

I assume this would not help, as it would travel same code path, to
dev_queue_xmit_nit, right?

>> I have some ideas for what could be done to avoid the clone (with
>> existing kernel functionality)... but none of it is pretty...
>> Anyone have any smart ideas?
>>
>> Perhaps a way to move the clone past the af_packet packet_rcv run_filter?
>> Unfortunately packet_rcv() does a little bit of 'setup' before it
>> calls the filter - so this may be hard.
> 
> 
> dev_queue_xmit_nit() also does some 'setup':
> 
> net_timestamp_set(skb2);  (This one could probably be moved into
> af_packet, if packet is not dropped ?)
> <sanitize mac, network, transport headers>
> 

Regarding AF_PACKET socket to ignore outgoing, I think the
(ptype->ignore_outgoing) in top of dev_queue_xmit_nit() list-loop is
doing that trick and thus avoids the skb_clone().

>>
>> Or an 'extra' early pre-filter hook [prot_hook.prefilter()] that has
>> very minimal
>> functionality... like match 2 bytes at an offset into the packet?
>> Maybe even not a hook at all, just adding a
>> prot_hook.prefilter{1,2}_u64_{offset,mask,value}
>> It doesn't have to be perfect, but if it could discard 99% of the
>> packets we don't care about...
>> (and leave filtering of the remaining 1% to the existing cbpf program)
>> that would already be a huge win?
> 
> Maybe if we can detect a cBPF filter does not access mac, network,
> transport header,
> we could run it earlier, before the clone().
> 
> So we could add
> prot_hook.filter_can_run_from_dev_queue_xmit_nit_before_the_clone
> 
> Or maybe we can remove sanitization, because BPF should not do bad
> things if these headers are garbage ?
>

To Maze, have you looked at PoC coding what Eric suggested?
(Prework that allows us to to move filter)


>>
>> Thoughts?
>>

What are your plans for working on a solution for this?

--Jesper

Thread link[1] to people Cc'ed:
  [1] 
https://lore.kernel.org/all/CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com/


