Return-Path: <netdev+bounces-21965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95727657C4
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA10B1C21519
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404B17AAE;
	Thu, 27 Jul 2023 15:35:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490AC171AB
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 15:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AC9C433C8;
	Thu, 27 Jul 2023 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690472131;
	bh=gM6ofG1nGUEoDfXpgi/FASWiYdmEVl7mx7tb7tgZJr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uaYdiayb1L8p5J2I/DVyWBz/MEnRXku3tDpX89iJAVlxuEsY/VsqcOLFtH4DMlxnz
	 mQOkYNVDKCoARX7SXWHD7gKvojw4PY3Kzy1dwWYiYJn2y5yabNJ+OT1rG8PUTqgE1E
	 XMUP92CDa08lqiMPjBMmZ2A8FdW30DBtTiCBnD+uv+m8qTF8bPEgjPOezJXp06lb9l
	 7E88wKIoh7ycQlRcbsQv/DEJSBq5sD4zwRB+x1jntDkcBe7P0YwNNiOLtBz7g6WvXL
	 e/Y4p+aK2jGAbg1DzKiFdWFB4bfdXnmgEE+GLVGGoCM/oa1uGzePNX7UKvUVSGwtv9
	 2lHPcQyQIRerg==
Message-ID: <55dbb48d-dee3-e119-1bdf-edaa080c1c3d@kernel.org>
Date: Thu, 27 Jul 2023 09:35:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [Questions] Some issues about IPv4/IPv6 nexthop route
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
References: <ZLjncWOL+FvtaHcP@Laptop-X1> <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1> <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1> <20230724084820.4aa133cc@hermes.local>
 <ZMDyoRzngXVESEd1@Laptop-X1>
 <9a421bef-2b19-8619-601e-b00c0b1dc515@kernel.org>
 <ZMHwROD1AJrd4pND@Laptop-X1>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZMHwROD1AJrd4pND@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/23 10:19 PM, Hangbin Liu wrote:
> On Wed, Jul 26, 2023 at 09:57:59AM -0600, David Ahern wrote:
>>> So my questions are, should we show weight/scope for IPv4? How to deal the
>>> type/proto info missing for IPv6? How to deal with the difference of merging
>>> policy for IPv4/IPv6?
>>> + ip route add 172.16.105.0/24 table 100 via 172.16.104.100 dev dummy1
>>> + ip route append 172.16.105.0/24 table 100 via 172.16.104.100 dev dummy2
>>
>>> + ip route add 172.16.106.0/24 table 100 nexthop via 172.16.104.100 dev dummy1 weight 1
>>> + ip route append 172.16.106.0/24 table 100 nexthop via 172.16.104.100 dev dummy1 weight 2
>>
>> Weight only has meaning with a multipath route. In both of these caess
>> these are 2 separate entries in the FIB
> 
> Yes, we know these are 2 separate entries. The NM developers know these
> are 2 separate entries. But the uses don't know, and the route daemon don't
> know. If a user add these 2 entires. And kernel show them as the same. The
> route daemon will store them as a same entries. But if the user delete the
> entry. We actually delete one and left one in the kernel. This will make
> the route daemon and user confused.
> 
> So my question is, should we export the weight/scope? Or stop user add
> the second entry? Or just leave it there and ask route daemon/uses try
> the new nexthop api.
> 
>> with the second one only hit under certain conditions.
> 
> Just curious, with what kind of certain conditions we will hit the second one?

Look at the checks in net/ipv4/fib_trie.c starting at line 1573 (comment
before is "/* Step 3: Process the leaf, if that fails fall back to
backtracing */")

> 
>>
>>> + ip route show table 200
>>> default dev dummy1 scope link
>>> local default dev dummy1 scope host
>>> 172.16.107.0/24 via 172.16.104.100 dev dummy1
>>> 172.16.107.0/24 via 172.16.104.100 dev dummy1
>>>
>>> + ip addr add 2001:db8:101::1/64 dev dummy1
>>> + ip addr add 2001:db8:101::2/64 dev dummy2
>>> + ip route add 2001:db8:102::/64 via 2001:db8:101::10 dev dummy1 table 100
>>> + ip route prepend 2001:db8:102::/64 via 2001:db8:101::10 dev dummy2 table 100
>>> + ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
>>> + ip route prepend unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 1
>> Unfortunately the original IPv6 multipath implementation did not follow
>> the same semantics as IPv4. Each leg in a MP route is a separate entry
>> and the append and prepend work differently for v6. :-(
>>
>> This difference is one of the many goals of the separate nexthop objects
>> -- aligning ipv4 and ipv6 behavior which can only be done with a new
>> API. There were many attempts to make the legacy route infrastructure
>> more closely aligned between v4 and v6 and inevitably each was reverted
>> because it broke some existing user.
> 
> Yes, I understand the difficult and risk to aligned the v4/v6 behavior.
> On the other hand, changing to new nexthop api also a large work for the
> routing daemons. Here is a quote from NM developers replied to me.

It is some level of work yes, but the netlink message format between old
and new was left as aligned and similar as possible - to make it easier
to move between old and new api.

> 
> "If the issues (this and others) of the netlink API for route objects can be
> fixed, then there seems less reason to change NetworkManager to nexthop
> objects. If it cannot (won't) be fixed, then would be another argument for using
> nexthop objects..."
> 
> I will check if all the issues could be fixed with new nexthop api.
> 
> Thanks
> Hangbin


