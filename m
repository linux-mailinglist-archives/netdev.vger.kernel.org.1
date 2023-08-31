Return-Path: <netdev+bounces-31637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0FF78F28F
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 20:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF06A1C202E7
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442841989C;
	Thu, 31 Aug 2023 18:27:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B48F57
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 18:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CBCC433C7;
	Thu, 31 Aug 2023 18:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693506474;
	bh=723Ya4oty/q02E8B93Q/MYOIyPGv3Rk4F+15t1DLClk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gRiXZur09akESL6wl7teCLMDhsLm7+ARPbh52sPN6KKGiPoGSkISTe5u+0L91Gn4y
	 QhD/7oYLV4pC2qgi8niXB/7g+oE8u0CB3+0E9fspS0fIvI1W+PtZYLKLzPp1JVEhge
	 B9omCz6b38dEQWXm8KjOwT5XUVFahxaCijSEJmXqcg1ljKR1Em30SCInmiR+RZfPmF
	 JaMps1vuIx4HzhsjxdRjHVcij6+133/uPDzBeRMbgH8xXQMEzPv6oCQOHSn0n0WDUP
	 eg63VKxm+K41eDaLWcio9ZB3HivTAJEyWoXbiH4PGJ6IzkMRth3vvNLBbfT5iT+5SE
	 HUDTzjS2O753g==
Message-ID: <2546e031-f189-e1b1-bc50-bc7776045719@kernel.org>
Date: Thu, 31 Aug 2023 12:27:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next] ipv6: do not merge differe type and protocol
 routes
To: nicolas.dichtel@6wind.com, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Thomas Haller <thaller@redhat.com>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
 <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
 <01baf374-97c0-2a6f-db85-078488795bf9@kernel.org>
 <db56de33-2112-5a4c-af94-6c8d26a8bfc1@6wind.com> <ZPBn9RQUL5mS/bBx@Laptop-X1>
 <62bcd732-31ed-e358-e8dd-1df237d735ef@6wind.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <62bcd732-31ed-e358-e8dd-1df237d735ef@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/31/23 5:58 AM, Nicolas Dichtel wrote:
> Le 31/08/2023 à 12:14, Hangbin Liu a écrit :
>> Hi Nicolas,
>> On Thu, Aug 31, 2023 at 10:17:19AM +0200, Nicolas Dichtel wrote:
>>>>>> So let's skip counting the different type and protocol routes as siblings.
>>>>>> After update, the different type/protocol routes will not be merged.
>>>>>>
>>>>>> + ip -6 route show table 100
>>>>>> local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
>>>>>> 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
>>>>>>
>>>>>> + ip -6 route show table 200
>>>>>> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel metric 1024 pref medium
>>>>>> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp metric 1024 pref medium
>>>>>
>>>>> This seems wrong. The goal of 'ip route append' is to add a next hop, not to
>>>>> create a new route. Ok, it adds a new route if no route exists, but it seems
>>>>> wrong to me to use it by default, instead of 'add', to make things work magically.
>>>>
>>>> Legacy API; nothing can be done about that (ie., that append makes a new
>>>> route when none exists).
>>>>
>>>>>
>>>>> It seems more correct to return an error in these cases, but this will change
>>>>> the uapi and it may break existing setups.
>>>>>
>>>>> Before this patch, both next hops could be used by the kernel. After it, one
>>>>> route will be ignored (the former or the last one?). This is confusing and also
>>>>> seems wrong.
>>>>
>>>> Append should match all details of a route to add to an existing entry
>>>> and make it multipath. If there is a difference (especially the type -
>>>> protocol difference is arguable) in attributes, then they are different
>>>> routes.
>>>>
>>>
>>> As you said, the protocol difference is arguable. It's not a property of the
>>> route, just a hint.
>>> I think the 'append' should match a route whatever the protocol is.
>>> 'ip route change' for example does not use the protocol to find the existing
>>> route, it will update it:
>>>
>>> $ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1
>>> $ ip -6 route
>>> 2003:1:2:3::/64 via 2001::2 dev eth1 metric 1024 pref medium
>>> $ ip -6 route change 2003:1:2:3::/64 via 2001::2 dev eth1 protocol bgp
>>> $ ip -6 route
>>> 2003:1:2:3::/64 via 2001::2 dev eth1 proto bgp metric 1024 pref medium
>>> $ ip -6 route change 2003:1:2:3::/64 via 2001::2 dev eth1 protocol kernel
>>> $ ip -6 route
>>> 2003:1:2:3::/64 via 2001::2 dev eth1 proto kernel metric 1024 pref medium
>>
>> Not sure if I understand correctly, `ip route replace` should able to
>> replace all other field other than dest and dev. It's for changing the route,
>> not only nexthop.
>>>
>>> Why would 'append' selects route differently?
>>
>> The append should also works for a single route, not only for append nexthop, no?
> I don't think so. The 'append' should 'join', not add. Adding more cases where a
> route is added instead of appended doesn't make the API clearer.
> 
> With this patch, it will be possible to add a new route with the 'append'
> command when the 'add' command fails:
> $ ip -6 route add local 2003:1:2:3::/64 via 2001::2 dev eth1 table 200
> $ ip -6 route add unicast 2003:1:2:3::/64 via 2001::2 dev eth1 table 200
> RTNETLINK answers: File exists
> 
> $ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1 protocol bgp table 200
> $ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1 protocol kernel table 200
> RTNETLINK answers: File exists
> 
> This makes the API more confusing and complex. And I don't understand how it
> will be used later. There will be 2 routes on the system, but only one will be
> used, which one? This is confusing.
> 
>>
>>>
>>> This patch breaks the legacy API.
>>
>> As the patch's description. Who would expect different type/protocol route
>> should be merged as multipath route? I don't think the old API is correct.
> The question is not 'who expect', but 'is there some systems somewhere that rely
> on this (deliberately or not)'.
> Frankly, the protocol is just informative, so I don't see why it is a problem to
> ignore it with the 'append' command.
> For the type, it is weird, for sure. Rejecting the command seems better than
> duplicating routes. Which route is used by the stack?
> 
> 

Part of my intent with fib_tests.sh was to document the legacy meaning
of 'append, prepend, replace, and change' options while also providing a
test script to detect changes that cause a regression.

I do agree now that protocol is informative (passthrough from the kernel
perspective) so not really part of the route. That should be dropped
from the patch leaving just a check on rt_type as to whether the routes
are different. From there the append, prepend, replace and change
semantics should decide what happens (ie., how the route is inserted).

