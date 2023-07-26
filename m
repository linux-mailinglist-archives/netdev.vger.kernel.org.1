Return-Path: <netdev+bounces-21505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3D763BC4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2E71C2137A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A87F37987;
	Wed, 26 Jul 2023 15:58:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8DE57F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123BFC433C7;
	Wed, 26 Jul 2023 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690387080;
	bh=SXjQQclgm363tId62vp08VSS5BKxnsPwV6jed4AW5bI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LLSf2JaDahbI5Ja90Y2tC9DFaM4LNTdPYK3ymBthHZAyVvNNCzjqAgZivKNZpFHPd
	 VRpjLP5vUZukvRdDBjEpEya7V0btIGgiZzpU1kxSda/BZ8+i5HpvycygDV2cpU1Iqg
	 oz3Z9WjKT3xGGECKxwO/LP9Tk/Scia9/H8iROoQby6yh69PCqlCAVebb8Mj3iVD0C0
	 xEsaYxFFKzdVLjYvOBfQhl4pqRu8lAOGRonMAyREzTRN8lQpFXyDKM/tMNQd2+LDOr
	 dgnpyX+IQABjr5n+POgfveyuEqVlXKHK4i3iHzzBkV6mySqx5fx7tUVKWTbQMsh+WN
	 8OnVhIuyjUJVA==
Message-ID: <9a421bef-2b19-8619-601e-b00c0b1dc515@kernel.org>
Date: Wed, 26 Jul 2023 09:57:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [Questions] Some issues about IPv4/IPv6 nexthop route (was Re:
 [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush fib)
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
References: <ZLZnGkMxI+T8gFQK@shredder> <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1> <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1> <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1> <20230724084820.4aa133cc@hermes.local>
 <ZMDyoRzngXVESEd1@Laptop-X1>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZMDyoRzngXVESEd1@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/23 4:17 AM, Hangbin Liu wrote:
> Hi Stephen, Ido, David,
> On Mon, Jul 24, 2023 at 08:48:20AM -0700, Stephen Hemminger wrote:
>> On Mon, 24 Jul 2023 16:56:37 +0800
>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>>
>>> The NetworkManager keeps a cache of the routes. Missing/Wrong events mean that
>>> the cache becomes inconsistent. The IPv4 will not send src route delete info
>>> if it's bond to other device. While IPv6 only modify the src route instead of
>>> delete it, and also no notify. So NetworkManager developers complained and
>>> hope to have a consistent and clear notification about route modify/delete.
>>
>> Read FRR they get it right. The routing daemons have to track kernel,
>> and the semantics have been worked out for years.
> 
> Since we are talking about whether we should fix the issues or doc them. I
> have some other route issues reported by NetworkManager developers. And want
> discuss with you.
> 
> For IPv4, we add new route instead append the nexthop to same dest(or do I
> miss something?). Since the route are not merged, the nexthop weight is not
> shown, which make them look like the same for users. For IPv4, the scope is
> also not shown, which look like the same for users.
> 
> While IPv6 will append another nexthop to the route if dest is same. But there
> are 2 issues here:
> 1. the *type* and *protocol* field are actally ignored
> 2. when do `ip monitor route`, the info dumpped in fib6_add_rt2node()
>    use the config info from user space. When means `ip monitor` show the
>    incorrect type and protocol
> 
> So my questions are, should we show weight/scope for IPv4? How to deal the
> type/proto info missing for IPv6? How to deal with the difference of merging
> policy for IPv4/IPv6?
> 
> Here is the reproducer:
> 
> + ip link add dummy0 up type dummy
> + ip link add dummy1 up type dummy
> + ip link add dummy2 up type dummy
> + ip addr add 172.16.104.1/24 dev dummy1
> + ip addr add 172.16.104.2/24 dev dummy2

> + ip route add 172.16.105.0/24 table 100 via 172.16.104.100 dev dummy1
> + ip route append 172.16.105.0/24 table 100 via 172.16.104.100 dev dummy2

> + ip route add 172.16.106.0/24 table 100 nexthop via 172.16.104.100 dev dummy1 weight 1
> + ip route append 172.16.106.0/24 table 100 nexthop via 172.16.104.100 dev dummy1 weight 2

Weight only has meaning with a multipath route. In both of these caess
these are 2 separate entries in the FIB with the second one only hit
under certain conditions.


> + ip route show table 100
> 172.16.105.0/24 via 172.16.104.100 dev dummy1
> 172.16.105.0/24 via 172.16.104.100 dev dummy2
> 172.16.106.0/24 via 172.16.104.100 dev dummy1
> 172.16.106.0/24 via 172.16.104.100 dev dummy1
> 
> + ip route add local default dev dummy1 table 200
> + ip route add 172.16.107.0/24 table 200 nexthop via 172.16.104.100 dev dummy1
> + ip route prepend default dev dummy1 table 200
> + ip route append 172.16.107.0/24 table 200 nexthop via 172.16.104.100 dev dummy1

similarly here with prepend and append.

For all of these, look at fib_tests.sh, ipv4_rt_add(). It runs through
combination of flags and in some cases only documents existing behavior.


> + ip route show table 200
> default dev dummy1 scope link
> local default dev dummy1 scope host
> 172.16.107.0/24 via 172.16.104.100 dev dummy1
> 172.16.107.0/24 via 172.16.104.100 dev dummy1
> 
> + ip addr add 2001:db8:101::1/64 dev dummy1
> + ip addr add 2001:db8:101::2/64 dev dummy2
> + ip route add 2001:db8:102::/64 via 2001:db8:101::10 dev dummy1 table 100
> + ip route prepend 2001:db8:102::/64 via 2001:db8:101::10 dev dummy2 table 100
> + ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
> + ip route prepend unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 1
Unfortunately the original IPv6 multipath implementation did not follow
the same semantics as IPv4. Each leg in a MP route is a separate entry
and the append and prepend work differently for v6. :-(

This difference is one of the many goals of the separate nexthop objects
-- aligning ipv4 and ipv6 behavior which can only be done with a new
API. There were many attempts to make the legacy route infrastructure
more closely aligned between v4 and v6 and inevitably each was reverted
because it broke some existing user.


> + ip monitor route &
> + sleep 1
> + ip route add 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel table 100
> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 table 100 proto kernel metric 1024 pref medium
> + ip route prepend 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp table 100
> 2001:db8:104::/64 table 100 proto bgp metric 1024 pref medium
>         nexthop via 2001:db8:101::10 dev dummy2 weight 1
>         nexthop via 2001:db8:101::10 dev dummy1 weight 1
> + ip -6 route show table 100
> 2001:db8:102::/64 metric 1024 pref medium
>         nexthop via 2001:db8:101::10 dev dummy1 weight 1
>         nexthop via 2001:db8:101::10 dev dummy2 weight 1
> local 2001:db8:103::/64 metric 1024 pref medium
>         nexthop via 2001:db8:101::10 dev dummy1 weight 1
>         nexthop via 2001:db8:101::10 dev dummy2 weight 1
> 2001:db8:104::/64 proto kernel metric 1024 pref medium
>         nexthop via 2001:db8:101::10 dev dummy1 weight 1
>         nexthop via 2001:db8:101::10 dev dummy2 weight 1
> + kill $!
> 
> Thanks
> Hangbin


