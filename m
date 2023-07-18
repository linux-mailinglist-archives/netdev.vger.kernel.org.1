Return-Path: <netdev+bounces-18754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C853E7588A5
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558AB28176F
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 22:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EA61773A;
	Tue, 18 Jul 2023 22:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6D4168BE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 22:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B052C433C7;
	Tue, 18 Jul 2023 22:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689720185;
	bh=cWNL6O5628brHitpY9ip2jK0Y10iW+HLam2xP54cGfM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NbfkVaq07AIeCltf6Qpu8mzsJ4kSc0obLC7PBkkfAZ6BAM+1z27W3ytcfdGYmUyUy
	 4mA5stqUAqO0QVhYp5WLD6fGehiGCGeZ4xgFRQZXRZJucfumfIeXQDyvun72quoBAH
	 PXScuNqnzzuiejVbEGU6dDC1mwQAMgyFv7p/wUizFpBpt3zJig3bWkXUn8BDBcVmEk
	 d+xcXSUHQSwnqtG8V+pMpJOY7wnWcJXk95sBzqdYlFf6HV3SxDGgPXQmcLyvVzSZzi
	 w9BodcjbW5GHWdGMhelKYdY0WKSM9sj5mQpFUot8aLhPQVDKhMRWTJ5NBF1QNz83tk
	 4NMPMuKwHOjUw==
Message-ID: <07e598bb-aebf-b169-425f-a6e8a84016d4@kernel.org>
Date: Tue, 18 Jul 2023 16:43:04 -0600
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
To: Ivan Babrou <ivan@cloudflare.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 kernel-team <kernel-team@cloudflare.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jakub Kicinski <kuba@kernel.org>
References: <CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com>
 <e64291ac-98e0-894f-12cb-d01347aef36c@kernel.org>
 <CABWYdi38H3umTEqTPbt8DftF2HXZ7ba6+jNphJdvubeh6PLP8w@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CABWYdi38H3umTEqTPbt8DftF2HXZ7ba6+jNphJdvubeh6PLP8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/18/23 4:33 PM, Ivan Babrou wrote:
> On Fri, Jul 14, 2023 at 5:54 PM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 7/14/23 4:13 PM, Ivan Babrou wrote:
>>> As requested by Jakub Kicinski and David Ahern here:
>>>
>>> * https://lore.kernel.org/netdev/20230713201427.2c50fc7b@kernel.org/
>>>
>>> I made some aggregations for the stacks we see leading into
>>> skb:kfree_skb endpoint. There's a lot of data that is not easily
>>> digestible, so I lightly massaged the data and added flamegraphs in
>>> addition to raw stack counts. Here's the gist link:
>>>
>>> * https://gist.github.com/bobrik/0e57671c732d9b13ac49fed85a2b2290
>>
>> I see a lot of packet_rcv as the tip before kfree_skb. How many packet
>> sockets do you have running on that box? Can you accumulate the total
>> packet_rcv -> kfree_skb_reasons into 1 count -- regardless of remaining
>> stacktrace?
> 
> Yan will respond regarding the packet sockets later in the day, he
> knows this stuff better than I do.
> 
> In the meantime, here are the aggregations you requested:
> 
> * Normal: https://gist.githubusercontent.com/bobrik/0e57671c732d9b13ac49fed85a2b2290/raw/ae8aa1bc3b22fad6cf541afeb51aa8049d122d02/flamegraph.normal.packet_rcv.aggregated.svg
> * Spike: https://gist.githubusercontent.com/bobrik/0e57671c732d9b13ac49fed85a2b2290/raw/ae8aa1bc3b22fad6cf541afeb51aa8049d122d02/flamegraph.spike.packet_rcv.aggregated.svg

For the spike, 97% are drops in packet_rcv. Each raw packet socket
causes every packet to be cloned which makes an N-factor on the number
of skbs to be freed. If this is tcpdump or lldp with a filter that would
be what Jakub mentioned in his response.

> 
> I just realized that Github links make flamegraphs non-interactive. If
> you download them and open a local copy, they should work better:

Firefox shows the graphs just fine.

> 
> * Expand to your screen width
> * Working search with highlights
> * Tooltips with counts and percentages
> * Working zoom


