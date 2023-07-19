Return-Path: <netdev+bounces-18828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B071758C3B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 05:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1C71C20F11
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216C210C;
	Wed, 19 Jul 2023 03:50:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48817F9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 03:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8900C433C7;
	Wed, 19 Jul 2023 03:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689738612;
	bh=uYRLiG0eEEeEyB9rSjfG2oNEypsRKJGn/UMNo99hzoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yxa/2wRhWKYW6AWy3lc6L01mXmw5VDZbaM7xGGWQYAFmAb2OYt/IhNEzgsrqWoX3t
	 G8Y/NFozcsSsJQYibl35ZyFEBDuo4t2Sh5cEeMbP5DQVUCJnev7h8laXboF7ipKV9z
	 6iMcY8r4Nc3BgUHRGAyCbRQECHMF5O1E3ZCTVI7jFf2WPDOXyet8HYatVnPF8LYhRb
	 IM3gWb1NM1086dNwmh28CFDRL+4uOyn7Ceg00BnzBMokWA0GtLkE4cGtJjEevH3Ldu
	 W+6xASyz51qbB28PV22l5YmwbIRxcOxmUOCWdDOx8ECNBufV1bP7bB7XrINc3orf/3
	 dkg3irbPAPk4w==
Message-ID: <61298b77-f1e0-9fc8-aa79-9b48f31c6941@kernel.org>
Date: Tue, 18 Jul 2023 21:50:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Stacks leading into skb:kfree_skb
Content-Language: en-US
To: Yan Zhai <yan@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Babrou <ivan@cloudflare.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 kernel-team <kernel-team@cloudflare.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com>
 <e64291ac-98e0-894f-12cb-d01347aef36c@kernel.org>
 <20230718153631.7a08a6ec@kernel.org>
 <CAO3-Pbqo_bfYsstH47hgqx7GC0CUg1H0xUaewq=MkUvb2BzCZA@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAO3-Pbqo_bfYsstH47hgqx7GC0CUg1H0xUaewq=MkUvb2BzCZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/18/23 9:10 PM, Yan Zhai wrote:
> On Tue, Jul 18, 2023 at 5:36 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Fri, 14 Jul 2023 18:54:14 -0600 David Ahern wrote:
>>>> I made some aggregations for the stacks we see leading into
>>>> skb:kfree_skb endpoint. There's a lot of data that is not easily
>>>> digestible, so I lightly massaged the data and added flamegraphs in
>>>> addition to raw stack counts. Here's the gist link:
>>>>
>>>> * https://gist.github.com/bobrik/0e57671c732d9b13ac49fed85a2b2290
>>>
>>> I see a lot of packet_rcv as the tip before kfree_skb. How many packet
>>> sockets do you have running on that box? Can you accumulate the total
>>> packet_rcv -> kfree_skb_reasons into 1 count -- regardless of remaining
>>> stacktrace?
>>
>> On a quick look we have 3 branches which can get us to kfree_skb from
>> packet_rcv:
>>
>>         if (skb->pkt_type == PACKET_LOOPBACK)
>>                 goto drop;
>> ...
>>         if (!net_eq(dev_net(dev), sock_net(sk)))
>>                 goto drop;
>> ...
>>         res = run_filter(skb, sk, snaplen);
>>         if (!res)
>>                 goto drop_n_restore;
>>
>> I'd guess is the last one? Which we should mark with the SOCKET_FILTER
>> drop reason?
> 
> So we have multiple packet socket consumers on our edge:
> * systemd-networkd: listens on ETH_P_LLDPD, which is the role model
> that does not do excessive things

ETH level means raw packet socket which means *all* packets are duplicated.

> * lldpd: I am not sure why we needed this one in presence of
> systemd-networkd, but it is running atm, which contributes to constant
> packet_rcv calls. It listens on ETH_P_ALL because of
> https://github.com/lldpd/lldpd/pull/414. But its filter is doing the
> correct work, so packets hitting this one is mostly "consumed"

This one I am familiar with and its filter -- the fact that the filter
applies *after* the clone means it still contributes to the packet load.

Together these 2 sockets might explain why the filter drop shows up in
packet_rcv.

> 
> Now the bad kids:
> * arping: listens on ETH_P_ALL. This one contributes all the
> skb:kfree_skb spikes, and the reason is sk_rmem_alloc overflows
> rcvbuf. I suspect it is due to a poorly constructed filter so too many
> packets get queued too fast.

Any packet socket is the problem because the filter is applied to the
clone. Clone the packet, run the filter, kfree the packet.

> * conduit-watcher: a health checker, sending packets on ETH_P_IP in
> non-init netns. Majority of packet_rcv on this one goes to direct drop
> due to netns difference.

So this the raw packet socket at L3 that shows up. This one should not
be as large of a contributor to the increases packet load.

> 
> So to conclude, it might be useful to set a reason for rcvbuf related
> drops at least. On the other hand, almost all packets entered
> packet_rcv are shared, so clone failure probably can also be a thing
> under memory pressure.
> 
> 


