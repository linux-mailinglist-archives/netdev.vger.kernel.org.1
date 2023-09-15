Return-Path: <netdev+bounces-33999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DCF7A1423
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 05:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED6C1C20E51
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 03:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDEAED8;
	Fri, 15 Sep 2023 03:07:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF619ED2
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 03:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B34C433C9;
	Fri, 15 Sep 2023 03:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694747246;
	bh=ow8JQ3Di0t4mJmlq6KUZEi2jGCjbKhvEDttYokDF0CI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VnJZPpHwweLtnOvjtuoo+vP9yPLuzY1kZkLworAwlrc8CnNlQXrcCdaeQ+dLWprsu
	 9HlMZIcNnAWKa9902Pm3pYblNZNY5IyDBRVOeEQGfeXoi9LNXxe824eoI0UzwfqCaE
	 mTZxe3bnJEjE6R5GjEJgiyssl8MN8hEMgODZVS7j1Zb5QXDmCic4kczGcuHr41eksy
	 il/X0Sr8wFk40MV5msomvpHeKkSiVvg6Do7V7gfg40AIynuM5Zw8IFLNGaga1XlY3Z
	 Ak6qpgr7wOfEqAfIdCxPxbJMhDD4gu9wVg2cE8++sw0op1YhpalCHUX73LwNABbn0y
	 TrPTG0Z/x4B9g==
Message-ID: <0e146bcf-d8b1-84a3-f8a4-976fc8414b25@kernel.org>
Date: Thu, 14 Sep 2023 21:07:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Content-Language: en-US
To: nicolas.dichtel@6wind.com, Hangbin Liu <liuhangbin@gmail.com>
Cc: Thomas Haller <thaller@redhat.com>, Benjamin Poirier
 <bpoirier@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>,
 Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20230724084820.4aa133cc@hermes.local>
 <ZL+F6zUIXfyhevmm@Laptop-X1> <20230725093617.44887eb1@hermes.local>
 <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
 <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
 <640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
 <8f5d2cae-17a2-f75d-7659-647d0691083b@kernel.org> <ZNKQdLAXgfVQxtxP@d3>
 <32d40b75d5589b73e17198eb7915c546ea3ff9b1.camel@redhat.com>
 <cc91aa7d-0707-b64f-e7a9-f5ce97d4f313@6wind.com> <ZQGG8xqt8m3IHS4z@Laptop-X1>
 <e2b57bea-fb14-cef4-315a-406f0d3a7e4f@6wind.com>
 <767a9486-6734-6113-9346-f4bef04370f0@kernel.org>
 <a4003473-6809-db97-3d06-cec8e08c6ed6@6wind.com>
 <b83e24a4-6de3-0df2-d902-f2cc3cdbaf41@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <b83e24a4-6de3-0df2-d902-f2cc3cdbaf41@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/14/23 9:43 AM, Nicolas Dichtel wrote:
> Le 13/09/2023 à 16:53, Nicolas Dichtel a écrit :
>> Le 13/09/2023 à 16:43, David Ahern a écrit :
>>> On 9/13/23 8:11 AM, Nicolas Dichtel wrote:
>>>> The compat_mode was introduced for daemons that doesn't support the nexthop
>>>> framework. There must be a notification (RTM_DELROUTE) when a route is deleted
>>>> due to a carrier down event. Right now, the backward compat is broken.
>>>
>>> The compat_mode is for daemons that do not understand the nexthop id
>>> attribute, and need the legacy set of attributes for the route - i.e,
>> Yes, it's my point.
>> On my system, one daemon understands and configures nexthop id and another one
>> doesn't understand nexthop id. This last daemon removes routes when an interface
>> is put down but not when the carrier is lost.
>> The kernel doc [1] says:
>> 	Further, updates or deletes of a nexthop configuration generate route
>> 	notifications for each fib entry using the nexthop.
>> So, my understanding is that a RTM_DELROUTE msg should be sent when a nexthop is
>> removed due to a carrier lost event.
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/ip-sysctl.rst#n2116
> 
> I dug a bit more about these (missing) notifications. I will try to describe
> what should be done for cases where there is no notification:
> 
> When an interface is set down:
>  - the single (!multipath) routes associated with this interface should be
>    removed;
>  - for multipath routes:
>    + if all nh use this interface: the routes are deleted;
>    + if only some nh uses this interface :
>      ~ if all other nh already point to a down interface: the routes are deleted;
>      ~ if at least one nh points to an up interface:
>        o the nh are *temporarily* disabled if it's a plain nexthop;
>        o the nh is *definitely* removed if it's a nexthop object;
> When the interface is set up later, disabled nh are restored (ie only plain
> nexthop of multipath routes).
> 
> When an interface loses its carrier:
>  - for routes using plain nexthop: nothing happens;
>  - for routes using nexthop objects:
>    + for single routes: they are deleted;
>    + for multipath routes, the nh is definitely removed if it's a nexthop
>      object (ie the route is deleted if there is no other nexthop in the group);
> When an interface recovers its carrier, there is nothing to do.
> 
> When the last ipv4 address of an interface is removed:
>  - for routes using nexthop objects: nothing happens;
>  - for routes using plain nexthop: the same rules as 'interface down' applies.
> When an ipv4 address is added again on the interface, disabled nh are restored
> (ie only plain nexthop of multipath routes).
> 
> I bet I miss some cases.
> 
> Conclusions:
>  - legacy applications (that are not aware of nexthop objects) cannot maintain a
>    routing cache (even with compat_mode enabled);
>  - fixing only the legacy applications (aka compat_mode) seems too
>    complex;
>  - even if an application is aware of nexthop objects, the rules to maintain a
>    cache are far from obvious.
> 
> I don't understand why there is so much reluctance to not send a notification
> when a route is deleted. This would fix all cases.
> I understand that the goal was to save netlink traffic, but in this case, the
> daemons that are interested in maintaining a routing cache have to fully parse
> their cache to mark/remove routes. For big routing tables, this will cost a lot
> of cpu, so I wonder if it's really a gain for the system. On such systems, there
> is probably more than one daemon in this case, so even more cpu to spend for
> these operations.
> 
> As Thomas said, this discussion has come up for more than a decade. And with the
> nexthop objects support, it's even more complex. There is obviously something to do.
> 
> At least, I would have expected an RTM_DELNEXTHOP msg for each deleted nexthop.
> But this wouldn't solve the routing cache sync for legacy applications.
> 

The split nexthop API is about efficiency. Do not send route
notifications when they are easily derived from other events -- e.g.,
link down or carrier down. The first commit for the nexthop code:

commit ab84be7e54fc3d9b248285f1a14067558d858819
Author: David Ahern <dsahern@gmail.com>
Date:   Fri May 24 14:43:04 2019 -0700

    net: Initial nexthop code

    Barebones start point for nexthops. Implementation for RTM commands,
    notifications, management of rbtree for holding nexthops by id, and
    kernel side data structures for nexthops and nexthop config.

    Nexthops are maintained in an rbtree sorted by id. Similar to routes,
    nexthops are configured per namespace using netns_nexthop struct added
    to struct net.

    Nexthop notifications are sent when a nexthop is added or deleted,
    but NOT if the delete is due to a device event or network namespace
    teardown (which also involves device events). Applications are
    expected to use the device down event to flush nexthops and any
    routes used by the nexthops.

Intent is stated.

The only compatibility with legacy API is around expanding the nhid to a
full set of nexthop attributes to aid a transition to the new API.

This new API also gave an opportunity to bring equivalency between IPv4
and IPv6.

Let's not weaken that model at all.

