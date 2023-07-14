Return-Path: <netdev+bounces-17973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA56753E74
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962C61C2145E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1A613AF8;
	Fri, 14 Jul 2023 15:09:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80922EEA8
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 15:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88661C433C8;
	Fri, 14 Jul 2023 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689347386;
	bh=ww7Us7vowYyOpZgs8xGOz75594ha/XwuAl0ngAbLtio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L4BfBhYVI6ounWXA18fpxYJABIbRkbKrd1ZF1ZZkibG5O3in5TcYRxlpMmw6DB1QW
	 OeLIxyDvbxtaZUmRu+pEha5XlDVRNxwPkalKEPUgmpBvSn0jrFIm92jYJMrG05zH1j
	 allsDJvdt7ThiQ3Pdaab5eBRCQEDQYUvPaLM5Lw+1aBf38ke8+kPndUFiI7ytZsCCv
	 hNV4bayPTzELuSv85nhL4JuQJdbEEWGq9n0GEOcUa1x/6onB74OdHN1a3Ky0mrM+25
	 RAHYWfM+FokKecuiNH3BpUyDEppPhuqjKOHOdVscNCg+hpe8Yeaw4J6teBkYah/mk0
	 FKA4ERdSicSfg==
Message-ID: <c015fdb8-9ac1-b45e-89a2-70e8ababae17@kernel.org>
Date: Fri, 14 Jul 2023 09:09:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for
 tcp_listen_queue_drop
Content-Language: en-US
To: Ivan Babrou <ivan@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20230711043453.64095-1-ivan@cloudflare.com>
 <20230711193612.22c9bc04@kernel.org>
 <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
 <20230712104210.3b86b779@kernel.org>
 <CABWYdi3VJU7HUxzKJBKgX9wF9GRvmA0TKVpjuHvJyz_EdpxZFA@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CABWYdi3VJU7HUxzKJBKgX9wF9GRvmA0TKVpjuHvJyz_EdpxZFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/13/23 5:17 PM, Ivan Babrou wrote:
> On Wed, Jul 12, 2023 at 10:42 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Wed, 12 Jul 2023 11:42:26 -0500 Yan Zhai wrote:
>>>   The issue with kfree_skb is not that it fires too frequently (not in
>>> the 6.x kernel now). Rather, it is unable to locate the socket info
>>> when a SYN is dropped due to the accept queue being full. The sk is
>>> stolen upon inet lookup, e.g. in tcp_v4_rcv. This makes it unable to
>>> tell in kfree_skb which socket a SYN skb is targeting (when TPROXY or
>>> socket lookup are used). A tracepoint with sk information will be more
>>> useful to monitor accurately which service/socket is involved.
>>
>> No doubt that kfree_skb isn't going to solve all our needs, but I'd
>> really like you to clean up the unnecessary callers on your systems
>> first, before adding further tracepoints. That way we'll have a clear
>> picture of which points can be solved by kfree_skb and where we need
>> further work.
> 
> The existing UDP tracepoint was there for 12 years and it's a part of
> what kernel exposes to userspace, so I don't think it's fair to remove
> this and break its consumers. I think "do not break userspace" applies
> here. The proposed TCP tracepoint mostly mirrors it, so I think it's
> fair to have it.
> 
> I don't know why kfree_skb is called so much. I also don't agree with
> Yan that it's not actually too much, because it's a lot (especially
> compared with near zero for my proposed tracepoint). I can easily see
> 300-500k calls per second into it:
> 
> $ perf stat -I 1000 -a -e skb:kfree_skb -- sleep 10
> #           time             counts unit events
>      1.000520165             10,108      skb:kfree_skb
>      2.010494526             11,178      skb:kfree_skb
>      3.075503743             10,770      skb:kfree_skb
>      4.122814843             11,334      skb:kfree_skb
>      5.128518432             12,020      skb:kfree_skb
>      6.176504094             11,117      skb:kfree_skb
>      7.201504214             12,753      skb:kfree_skb
>      8.229523643             10,566      skb:kfree_skb
>      9.326499044            365,239      skb:kfree_skb
>     10.002106098            313,105      skb:kfree_skb
> $ perf stat -I 1000 -a -e skb:kfree_skb -- sleep 10
> #           time             counts unit events
>      1.000767744             52,240      skb:kfree_skb
>      2.069762695            508,310      skb:kfree_skb
>      3.102763492            417,895      skb:kfree_skb
>      4.142757608            385,981      skb:kfree_skb
>      5.190759795            430,154      skb:kfree_skb
>      6.243765384            405,707      skb:kfree_skb
>      7.290818228            362,934      skb:kfree_skb
>      8.297764298            336,702      skb:kfree_skb
>      9.314287243            353,039      skb:kfree_skb
>     10.002288423            251,414      skb:kfree_skb
> 
> Most of it is NOT_SPECIFIED (1s data from one CPU during a spike):
> 
> $ perf script | sed 's/.*skbaddr=//' | awk '{ print $NF }' | sort |
> uniq -c | sort -n | tail
>       1 TCP_CLOSE
>       2 NO_SOCKET
>       4 TCP_INVALID_SEQUENCE
>       4 TCP_RESET
>      13 TCP_OLD_DATA
>      14 NETFILTER_DROP
>    4594 NOT_SPECIFIED
> 
> We can start a separate discussion to break it down by category if it
> would help. Let me know what kind of information you would like us to
> provide to help with that. I assume you're interested in kernel stacks
> leading to kfree_skb with NOT_SPECIFIED reason, but maybe there's
> something else.

stack traces would be helpful.

> 
> Even if I was only interested in one specific reason, I would still
> have to arm the whole tracepoint and route a ton of skbs I'm not
> interested in into my bpf code. This seems like a lot of overhead,
> especially if I'm dropping some attack packets.

you can add a filter on the tracepoint event to limit what is passed
(although I have not tried the filter with an ebpf program - e.g.,
reason != NOT_SPECIFIED).

> 
> Perhaps a lot of extra NOT_SPECIFIED stuff can be fixed and removed
> from kfree_skb. It's not something I can personally do as it requires
> much deeper network code understanding than I possess. For TCP we'll
> also have to add some extra reasons for kfree_skb, because currently
> it's all NOT_SPECIFIED (no reason set in the accept path):
> 
> * https://elixir.bootlin.com/linux/v6.5-rc1/source/net/ipv4/tcp_input.c#L6499
> * https://elixir.bootlin.com/linux/v6.5-rc1/source/net/ipv4/tcp_ipv4.c#L1749
> 
> For UDP we already have SKB_DROP_REASON_SOCKET_RCVBUFF, so I tried my
> best to implement what I wanted based on that. It's not very
> approachable, as you'd have to extract the destination port yourself
> from the raw skb. As Yan said, for TCP people often rely on skb->sk,
> which is just not present when the incoming SYN is dropped. I failed
> to find a good example of extracting a destination port that I could
> replicate. So far I have just a per-reason breakdown working:
> 
> * https://github.com/cloudflare/ebpf_exporter/pull/233
> 
> If you have an ebpf example that would help me extract the destination
> port from an skb in kfree_skb, I'd be interested in taking a look and
> trying to make it work.

This is from 2020 and I forget which kernel version (pre-BTF), but it
worked at that time and allowed userspace to summarize drop reasons by
various network data (mac, L3 address, n-tuple, etc):

https://github.com/dsahern/bpf-progs/blob/master/ksrc/pktdrop.c

> 
> The need to extract the protocol level information in ebpf is only
> making kfree_skb more expensive for the needs of catching rare cases
> when we run out of buffer space (UDP) or listen queue (TCP). These two
> cases are very common failure scenarios that people are interested in
> catching with straightforward tracepoints that can give them the
> needed information easily and cheaply.
> 
> I sympathize with the desire to keep the number of tracepoints in
> check, but I also feel like UDP buffer drops and TCP listen drops
> tracepoints are very much justified to exist.

sure, kfree_skb is like the raw_syscall tracepoint - it can be more than
what you need for a specific problem, but it is also give you way more
than you are thinking about today.

