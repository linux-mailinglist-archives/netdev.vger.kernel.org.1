Return-Path: <netdev+bounces-37511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8417B5BC8
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 22:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C65A3281D84
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F92200C8;
	Mon,  2 Oct 2023 20:07:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5B1D53B
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 20:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02719C433C8;
	Mon,  2 Oct 2023 20:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696277251;
	bh=FZvCKPJ01tn0EEdrhF9GhUHZ+BYZhZIJfSC7xN7B4xk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UN2ox1IpZxb+A+46gmvudWroavUCQ0Vm23sdt96h414S1MBugFJVbZ+G0EzOGFi07
	 L5l9i4RbGNnWUom9XnxsCdgw07Ksib88dPM8/+ll+/wMJH1p4xD0dSiZs55WmSqNPG
	 RNig/Z4PXMUWkG0uCY4RTSCz6Fbq+H41LnBxx0XcKTO29eYyf2t9+Gbee1xMQmVZBx
	 nUpcnfyIvTsnD1Th/I9/f71jPrbtl+VaQmQivNuMtl882lPrC7N2CEKmnbUqcQGdSQ
	 vRnu40RBiRKxve7E/3waj5Ptm54HpPHkQ4xpZbZfx43QKrEzMveApRpuq8K8B8ahhs
	 WsY6ELnvxeLGw==
Message-ID: <57df308d-a97f-f20e-c2f4-90dca6171c6f@kernel.org>
Date: Mon, 2 Oct 2023 14:07:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCHv4 net] ipv4/fib: send notify when delete source address
 routes
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>,
 Thomas Haller <thaller@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>
References: <20230922075508.848925-1-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230922075508.848925-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/23 1:55 AM, Hangbin Liu wrote:
> After deleting an interface address in fib_del_ifaddr(), the function
> scans the fib_info list for stray entries and calls fib_flush() and
> fib_table_flush(). Then the stray entries will be deleted silently and no
> RTM_DELROUTE notification will be sent.
> 
> This lack of notification can make routing daemons, or monitor like
> `ip monitor route` miss the routing changes. e.g.
> 
> + ip link add dummy1 type dummy
> + ip link add dummy2 type dummy
> + ip link set dummy1 up
> + ip link set dummy2 up
> + ip addr add 192.168.5.5/24 dev dummy1
> + ip route add 7.7.7.0/24 dev dummy2 src 192.168.5.5
> + ip -4 route
> 7.7.7.0/24 dev dummy2 scope link src 192.168.5.5
> 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
> + ip monitor route
> + ip addr del 192.168.5.5/24 dev dummy1
> Deleted 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
> Deleted broadcast 192.168.5.255 dev dummy1 table local proto kernel scope link src 192.168.5.5
> Deleted local 192.168.5.5 dev dummy1 table local proto kernel scope host src 192.168.5.5
> 
> As Ido reminded, fib_table_flush() isn't only called when an address is
> deleted, but also when an interface is deleted or put down. The lack of
> notification in these cases is deliberate. And commit 7c6bb7d2faaf
> ("net/ipv6: Add knob to skip DELROUTE message on device down") introduced
> a sysctl to make IPv6 behave like IPv4 in this regard. So we can't send
> the route delete notify blindly in fib_table_flush().
> 
> To fix this issue, let's add a new flag in "struct fib_info" to track the
> deleted prefer source address routes, and only send notify for them.
> 
> After update:
> + ip monitor route
> + ip addr del 192.168.5.5/24 dev dummy1
> Deleted 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
> Deleted broadcast 192.168.5.255 dev dummy1 table local proto kernel scope link src 192.168.5.5
> Deleted local 192.168.5.5 dev dummy1 table local proto kernel scope host src 192.168.5.5
> Deleted 7.7.7.0/24 dev dummy2 scope link src 192.168.5.5
> 
> Suggested-by: Thomas Haller <thaller@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v4: As David Ahern said, do not use bitfield as it has higher overhead.
> v3: update patch description
> v2: Add a bit in fib_info to mark the deleted src route.
> ---
>  include/net/ip_fib.h     | 1 +
>  net/ipv4/fib_semantics.c | 1 +
>  net/ipv4/fib_trie.c      | 4 ++++
>  3 files changed, 6 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



