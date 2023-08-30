Return-Path: <netdev+bounces-31415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C565278D6A4
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 16:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F264281050
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512586AB2;
	Wed, 30 Aug 2023 14:49:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449E6FA1
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 14:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C143C433C7;
	Wed, 30 Aug 2023 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693406959;
	bh=xqJLPkwijSptWmk+xd5HJo3CEWSoSkitn+oHvLJimhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vIqKuNQy+MUNW7ubGBxmoqbxAzLf7F/ZJr/CB5iEiZ0HtstXDn3PWl9998KkXMWx0
	 Mg8nlG3AEnB9qvkI0LAQfRwMSrwl0HID2gM4Q3WX1xNGJNGqxG8se7Xxv1DMCAt9j2
	 v1CyUAwIO2McIM9/oq8hE7aQZ6s8xqzuekxpzCheRZp3qPm5Hzf+4Fel1ZYgSIiy0H
	 06Dd+zxWMhFA/H9lqsmXl7y0bDdvXt8yqxUko2mLHap6FJr6BTDUVRlbqiTja/z/ae
	 F7QoyxTc5Nuu/wxfFwYTn8wuYqwrXM+L2ynragkAHZZZsQF7k+Mrpnta6CRwPw/f1C
	 k2ljk47Oyhe2A==
Message-ID: <06c4cd5f-7241-3a72-0cab-5319b2c8a793@kernel.org>
Date: Wed, 30 Aug 2023 08:49:18 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] ipv6: do not merge differe type and protocol
 routes
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Thomas Haller <thaller@redhat.com>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230830061550.2319741-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/23 12:15 AM, Hangbin Liu wrote:
> Different with IPv4, IPv6 will auto merge the same metric routes into
> multipath routes. But the different type and protocol routes are also
> merged, which will lost user's configure info. e.g.
> 
> + ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
> + ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 100
> + ip -6 route show table 100
> local 2001:db8:103::/64 metric 1024 pref medium
>         nexthop via 2001:db8:101::10 dev dummy1 weight 1
>         nexthop via 2001:db8:101::10 dev dummy2 weight 1
> 
> + ip route add 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel table 200
> + ip route append 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp table 200
> + ip -6 route show table 200
> 2001:db8:104::/64 proto kernel metric 1024 pref medium
>         nexthop via 2001:db8:101::10 dev dummy1 weight 1
>         nexthop via 2001:db8:101::10 dev dummy2 weight 1
> 
> So let's skip counting the different type and protocol routes as siblings.
> After update, the different type/protocol routes will not be merged.
> 
> + ip -6 route show table 100
> local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
> 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
> 
> + ip -6 route show table 200
> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel metric 1024 pref medium
> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp metric 1024 pref medium
> 
> Reported-by: Thomas Haller <thaller@redhat.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2161994
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> All fib test passed:
> Tests passed: 203
> Tests failed:   0

Please add the above tests for this case to the fib tests script.

> ---
>  net/ipv6/ip6_fib.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 28b01a068412..f60f5d14f034 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -1133,6 +1133,11 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>  							rt->fib6_pmtu);
>  				return -EEXIST;
>  			}
> +
> +			if (iter->fib6_type != rt->fib6_type ||
> +			    iter->fib6_protocol != rt->fib6_protocol)
> +				goto next_iter;
> +
>  			/* If we have the same destination and the same metric,
>  			 * but not the same gateway, then the route we try to
>  			 * add is sibling to this route, increment our counter

Reviewed-by: David Ahern <dsahern@kernel.org>


