Return-Path: <netdev+bounces-16148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA7F74B8C1
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 23:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB3328195F
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 21:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B0517ABD;
	Fri,  7 Jul 2023 21:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99F17AA5
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 21:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1432C433C7;
	Fri,  7 Jul 2023 21:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688766180;
	bh=tCgGBJ3pXQNoLInl05N8ggBg0z70ngJ/jWzVJlswNqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gmG/+d+Jls/8EphBn+wWsapc3qMJvdUoqvcissPDjbRE/M8vuDMYAVX5O7Dql6t86
	 PK9/4EVsOyIskS/VPOqZg+2EEu33soysGIAxyDpX0w1kjxAS9+efncxFxQpXrO8V7j
	 pOkewzI19aC4A29BzUhxZ/meA0q0gWEM6Pl/XfMl2oMIFsVOtqKqVWE7Q79iV8piar
	 +mh3PcPBVoGY5ZjS2HUg7H+iffDUzpTfTgzoq0Wz/KqFjY8T3jv0ciCWfDc3TSMj2E
	 SLiFR7uiUTQ45iJmB84c/iRL+apIS4UG+xzoVMY4ZCo+mHiehQPdYpmzJ/iUoWeP9z
	 rrxJHLDaW7Fbw==
Message-ID: <4950eec4-b5ec-89ab-2e1d-311ad5dcdc0c@kernel.org>
Date: Fri, 7 Jul 2023 15:42:58 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 net] icmp6: Fix null-ptr-deref of
 fib6_null_entry->rt6i_idev in icmp6_dev().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Wang Yufen <wangyufen@huawei.com>
References: <20230706233024.63730-1-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230706233024.63730-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/23 5:30 PM, Kuniyuki Iwashima wrote:
> With some IPv6 Ext Hdr (RPL, SRv6, etc.), we can send a packet that
> has the link-local address as src and dst IP and will be forwarded to
> an external IP in the IPv6 Ext Hdr.
> 
> For example, the script below generates a packet whose src IP is the
> link-local address and dst is updated to 11::.
> 
>   # for f in $(find /proc/sys/net/ -name *seg6_enabled*); do echo 1 > $f; done
>   # python3
>   >>> from socket import *
>   >>> from scapy.all import *
>   >>>
>   >>> SRC_ADDR = DST_ADDR = "fe80::5054:ff:fe12:3456"
>   >>>
>   >>> pkt = IPv6(src=SRC_ADDR, dst=DST_ADDR)
>   >>> pkt /= IPv6ExtHdrSegmentRouting(type=4, addresses=["11::", "22::"], segleft=1)
>   >>>
>   >>> sk = socket(AF_INET6, SOCK_RAW, IPPROTO_RAW)
>   >>> sk.sendto(bytes(pkt), (DST_ADDR, 0))
> 
> For such a packet, we call ip6_route_input() to look up a route for the
> next destination in these three functions depending on the header type.
> 
>   * ipv6_rthdr_rcv()
>   * ipv6_rpl_srh_rcv()
>   * ipv6_srh_rcv()
> 
> If no route is found, fib6_null_entry is set to skb, and the following

ip6_null_entry is the one set on the skb.

> dst_input(skb) calls ip6_pkt_drop().
> 
> Finally, in icmp6_dev(), we dereference skb_rt6_info(skb)->rt6i_idev->dev
> as the input device is the loopback interface.  Then, we have to check if
> skb_rt6_info(skb)->rt6i_idev is NULL or not to avoid NULL pointer deref
> for fib6_null_entry.
> 

...

> 
> Fixes: 4832c30d5458 ("net: ipv6: put host and anycast routes on device with address")
> Reported-by: Wang Yufen <wangyufen@huawei.com>
> Closes: https://lore.kernel.org/netdev/1ddf7fc8-bcb3-ab48-4894-24158e8a9d0f@huawei.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv6/icmp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index 9edf1f45b1ed..bd6479e3c757 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -424,7 +424,10 @@ static struct net_device *icmp6_dev(const struct sk_buff *skb)
>  	if (unlikely(dev->ifindex == LOOPBACK_IFINDEX || netif_is_l3_master(skb->dev))) {
>  		const struct rt6_info *rt6 = skb_rt6_info(skb);
>  
> -		if (rt6)
> +		/* The destination could be an external IP in Ext Hdr (SRv6, RPL, etc.),
> +		 * and fib6_null_entry could be set to skb if no route is found.
> +		 */
> +		if (rt6 && rt6->rt6i_idev)
>  			dev = rt6->rt6i_idev->dev;
>  	}
>  

Reviewed-by: David Ahern <dsahern@kernel.org>


