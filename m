Return-Path: <netdev+bounces-31442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1445278DDDF
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 20:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053541C203BC
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 18:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CB9748A;
	Wed, 30 Aug 2023 18:57:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF16AA2
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 18:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D52CC433C7;
	Wed, 30 Aug 2023 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693421849;
	bh=eYz+wbpVoZNnKpVgkmTz4D/Bi/Fw7lzsqXsMfuJjsuc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UsRMbpXDG4lR9Pw2VKbx4drw30nTnNGKEgOwm1aFvv6XrK9vqDdedJEASBJRz6zgM
	 OG+n4jrkt2c/r1/X+3DVUUdqVP3jVN/Ry6s7DtaAyTtnFmrZQD2FT2KVkbr2Zd5eSE
	 SJ1eRRUpTxTM1npBMOaU7Tz7cag8jagbD+Y07rAEjKnqpDgsEJyyTNJqIKMZpA41bL
	 FjX/xfMARWgH8X+H85r7fY3zfgDG2jiAseRS3n8Z/ThxlWF+ld1DcO0wphBe9I1Fnn
	 /4xMIdURsEBL38fEMmesr6VOLMZCM/NC3UzPgb5aYAJ60R5/52ND/xZiOIzHHAS+X9
	 VGHT7n0zHfCUQ==
Message-ID: <01baf374-97c0-2a6f-db85-078488795bf9@kernel.org>
Date: Wed, 30 Aug 2023 12:57:28 -0600
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
To: nicolas.dichtel@6wind.com, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Thomas Haller <thaller@redhat.com>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
 <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/30/23 9:29 AM, Nicolas Dichtel wrote:
> Le 30/08/2023 à 08:15, Hangbin Liu a écrit :
>> Different with IPv4, IPv6 will auto merge the same metric routes into
>> multipath routes. But the different type and protocol routes are also
>> merged, which will lost user's configure info. e.g.
>>
>> + ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
>> + ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 100
>> + ip -6 route show table 100
>> local 2001:db8:103::/64 metric 1024 pref medium
>>         nexthop via 2001:db8:101::10 dev dummy1 weight 1
>>         nexthop via 2001:db8:101::10 dev dummy2 weight 1
>>
>> + ip route add 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel table 200
>> + ip route append 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp table 200
>> + ip -6 route show table 200
>> 2001:db8:104::/64 proto kernel metric 1024 pref medium
>>         nexthop via 2001:db8:101::10 dev dummy1 weight 1
>>         nexthop via 2001:db8:101::10 dev dummy2 weight 1
>>
>> So let's skip counting the different type and protocol routes as siblings.
>> After update, the different type/protocol routes will not be merged.
>>
>> + ip -6 route show table 100
>> local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
>> 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
>>
>> + ip -6 route show table 200
>> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel metric 1024 pref medium
>> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp metric 1024 pref medium
> 
> This seems wrong. The goal of 'ip route append' is to add a next hop, not to
> create a new route. Ok, it adds a new route if no route exists, but it seems
> wrong to me to use it by default, instead of 'add', to make things work magically.

Legacy API; nothing can be done about that (ie., that append makes a new
route when none exists).

> 
> It seems more correct to return an error in these cases, but this will change
> the uapi and it may break existing setups.
> 
> Before this patch, both next hops could be used by the kernel. After it, one
> route will be ignored (the former or the last one?). This is confusing and also
> seems wrong.

Append should match all details of a route to add to an existing entry
and make it multipath. If there is a difference (especially the type -
protocol difference is arguable) in attributes, then they are different
routes.


