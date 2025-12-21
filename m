Return-Path: <netdev+bounces-245650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0098DCD443A
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 19:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 611A2300F59B
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9782D46B4;
	Sun, 21 Dec 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xkRuettw"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50228369D
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766343009; cv=none; b=E1yFbyIqUAS4oGD8FYAlaEfM9rpLcXo/vSEQBMYE25srUZASsGz274tCoecIbQH0p22+rgj8F4HgjxGC0rAKD9TyZPEhXtc9YpzhLtogcb/oeOzXkJfaJdA9qXibVnT8hOrLIYsP3hKkepyQnFAt4I8Hw1DKAnERaWTXnlb4GQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766343009; c=relaxed/simple;
	bh=g2wxUB3iyIqLTZ9Y1I+65IEO2C2JojPwst0oJ3o91sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cm7YFlP0M5X3ZZ5N2ehJpdTc8zlaEpYewcX5CMHnETJg5KAh2Heh/OSHK1If2TmvylCv/Tua44E4qkgzoJDsbZe0W8h3WMuzzMQLM3vCxGTvab4su2ElA1hQkLOF0i3xisrC4VbKfqDZKGEF42yoFKlTCk9IYVxkoLZssHXSEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xkRuettw; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1c6ba073-79e5-461b-ae76-4ef22fe04632@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766342997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ykQLa/dYfp/gOImLXLlw9LGrjSln7k1/ON+U/XP3bG0=;
	b=xkRuettw+ZIWUTc4uvwsI4yabMXMBEtjAyes/bjLF/lVS/7eb45I+vURjj390lVK4I8xeN
	QmSh1C3LzvZSUsHePVPtyMS09HhPTrwhqfpOft3OUxF+nIMQQIKgoy1/dq9GliZPP59CbD
	/cEwb50PQe3douqnyNQmnbDAdr5roow=
Date: Sun, 21 Dec 2025 18:49:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 1/2] net: fib: restore ECMP balance from loopback
To: Ido Schimmel <idosch@nvidia.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org
References: <20251220032335.3517241-1-vadim.fedorenko@linux.dev>
 <willemdebruijn.kernel.25af879fdb851@gmail.com> <aUgnGahB9uXbvrbh@shredder>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aUgnGahB9uXbvrbh@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/12/2025 16:58, Ido Schimmel wrote:
> On Sun, Dec 21, 2025 at 10:55:15AM -0500, Willem de Bruijn wrote:
>> Vadim Fedorenko wrote:
>>> Preference of nexthop with source address broke ECMP for packets with
>>> source addresses which are not in the broadcast domain, but rather added
>>> to loopback/dummy interfaces. Original behaviour was to balance over
>>> nexthops while now it uses the latest nexthop from the group.
>>>
>>> For the case with 198.51.100.1/32 assigned to dummy0 and routed using
>>> 192.0.2.0/24 and 203.0.113.0/24 networks:
>>>
>>> 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
>>>      link/ether d6:54:8a:ff:78:f5 brd ff:ff:ff:ff:ff:ff
>>>      inet 198.51.100.1/32 scope global dummy0
>>>         valid_lft forever preferred_lft forever
>>> 7: veth1@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>>>      link/ether 06:ed:98:87:6d:8a brd ff:ff:ff:ff:ff:ff link-netnsid 0
>>>      inet 192.0.2.2/24 scope global veth1
>>>         valid_lft forever preferred_lft forever
>>>      inet6 fe80::4ed:98ff:fe87:6d8a/64 scope link proto kernel_ll
>>>         valid_lft forever preferred_lft forever
>>> 9: veth3@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>>>      link/ether ae:75:23:38:a0:d2 brd ff:ff:ff:ff:ff:ff link-netnsid 0
>>>      inet 203.0.113.2/24 scope global veth3
>>>         valid_lft forever preferred_lft forever
>>>      inet6 fe80::ac75:23ff:fe38:a0d2/64 scope link proto kernel_ll
>>>         valid_lft forever preferred_lft forever
>>>
>>> ~ ip ro list:
>>> default
>>> 	nexthop via 192.0.2.1 dev veth1 weight 1
>>> 	nexthop via 203.0.113.1 dev veth3 weight 1
>>> 192.0.2.0/24 dev veth1 proto kernel scope link src 192.0.2.2
>>> 203.0.113.0/24 dev veth3 proto kernel scope link src 203.0.113.2
>>>
>>> before:
>>>     for i in {1..255} ; do ip ro get 10.0.0.$i; done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
>>>      255 veth3
>>>
>>> after:
>>>     for i in {1..255} ; do ip ro get 10.0.0.$i; done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
>>>      122 veth1
>>>      133 veth3
> 
> The commit message only explains the problem, but not the solution...

Well, the solution is to try to restore original logic. But ok, I'll
explain it explicitly

> 
>>>
>>> Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
>>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>> ---
>>> v1 -> v2:
>>>
>>> - add score calculation for nexthop to keep original logic
>>> - adjust commit message to explain the config
>>> - use dummy device instead of loopback
>>> ---
>>>
>>>   net/ipv4/fib_semantics.c | 24 ++++++++----------------
>>>   1 file changed, 8 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
>>> index a5f3c8459758..4d3650d20ff2 100644
>>> --- a/net/ipv4/fib_semantics.c
>>> +++ b/net/ipv4/fib_semantics.c
>>> @@ -2167,8 +2167,8 @@ void fib_select_multipath(struct fib_result *res, int hash,
>>>   {
>>>   	struct fib_info *fi = res->fi;
>>>   	struct net *net = fi->fib_net;
>>> -	bool found = false;
>>>   	bool use_neigh;
>>> +	int score = -1;
>>>   	__be32 saddr;
>>>   
>>>   	if (unlikely(res->fi->nh)) {
>>> @@ -2180,7 +2180,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
>>>   	saddr = fl4 ? fl4->saddr : 0;
>>>   
>>>   	change_nexthops(fi) {
>>> -		int nh_upper_bound;
>>> +		int nh_upper_bound, nh_score = 0;
>>>   
>>>   		/* Nexthops without a carrier are assigned an upper bound of
>>>   		 * minus one when "ignore_routes_with_linkdown" is set.
>>> @@ -2190,24 +2190,16 @@ void fib_select_multipath(struct fib_result *res, int hash,
>>>   		    (use_neigh && !fib_good_nh(nexthop_nh)))
>>>   			continue;
>>>   
>>> -		if (!found) {
>>> +		if (saddr && nexthop_nh->nh_saddr == saddr)
>>> +			nh_score += 2;
>>> +		if (hash <= nh_upper_bound)
>>> +			nh_score++;
>>> +		if (score < nh_score) {
>>>   			res->nh_sel = nhsel;
>>>   			res->nhc = &nexthop_nh->nh_common;
>>> -			found = !saddr || nexthop_nh->nh_saddr == saddr;
>>
>> if score == 3 return immediately?
> 
> We can also return early in the input path (!saddr) when score is 1.
> This seems to work:
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 4d3650d20ff2..0caf38e44c73 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -2197,6 +2197,8 @@ void fib_select_multipath(struct fib_result *res, int hash,
>   		if (score < nh_score) {
>   			res->nh_sel = nhsel;
>   			res->nhc = &nexthop_nh->nh_common;
> +			if (nh_score == 3 || (!saddr && nh_score == 1))
> +				return;
>   			score = nh_score;
>   		}
> 

It makes sense to amortize the loop. Going to send v3

> Tested with net/fib_tests.sh and forwarding/router_multipath.sh
> 
>>
>>> +			score = nh_score;
>>>   		}
>>>   
>>> -		if (hash > nh_upper_bound)
>>> -			continue;
>>> -
>>> -		if (!saddr || nexthop_nh->nh_saddr == saddr) {
>>> -			res->nh_sel = nhsel;
>>> -			res->nhc = &nexthop_nh->nh_common;
>>> -			return;
>>> -		}
>>> -
>>> -		if (found)
>>> -			return;
>>> -
>>>   	} endfor_nexthops(fi);
>>>   }
>>>   #endif
>>> -- 
>>> 2.47.3
>>>
>>
>>


