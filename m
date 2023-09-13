Return-Path: <netdev+bounces-33584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889E079EB48
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A1D28178E
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 14:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97839473;
	Wed, 13 Sep 2023 14:41:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25193D6C
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 14:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9BAC433C7;
	Wed, 13 Sep 2023 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694616067;
	bh=wWL+LcAw5WPyJwzia//Gc5ld2vNtPOeVhe23VjXEUZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LA/0ZjiB6zbJI1yoJ3Gu7hYOKjBQ5jfnyxitUuH1wSUbLrD+tmSXTZb8n7EzRsDhQ
	 h6v/aAZrqYlLIWJ97aEb3sr2t22lBXLAQ/gW5XrXy7HngtxLyZXzDjT8S+8EGK+ytT
	 lK1jNVVdajsq3Eb/vHaY5aEHDJtBDKoky3dWSWgfdV7uq1oHblmzUAnr58MfhSlQzL
	 wCWEYlNjPQNNFfld0e+SvMm+6RPXnlKluD5jYB2af9slrxHXFSxUfwi8rJF+ht8Io/
	 PxaSrCXNCoiL8MPs+MI1tuvwHLJuFmBxsmhLUl6yJm6wAXqTr/G9OUEXzyJaT4hu1w
	 JmKwiqHYLXg7Q==
Message-ID: <b6837627-27a9-b870-c85b-799c23705a74@kernel.org>
Date: Wed, 13 Sep 2023 08:41:05 -0600
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
To: nicolas.dichtel@6wind.com, Thomas Haller <thaller@redhat.com>,
 Benjamin Poirier <bpoirier@nvidia.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Ido Schimmel <idosch@idosch.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <ZLobpQ7jELvCeuoD@Laptop-X1> <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1> <20230724084820.4aa133cc@hermes.local>
 <ZL+F6zUIXfyhevmm@Laptop-X1> <20230725093617.44887eb1@hermes.local>
 <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
 <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
 <640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
 <8f5d2cae-17a2-f75d-7659-647d0691083b@kernel.org> <ZNKQdLAXgfVQxtxP@d3>
 <32d40b75d5589b73e17198eb7915c546ea3ff9b1.camel@redhat.com>
 <cc91aa7d-0707-b64f-e7a9-f5ce97d4f313@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <cc91aa7d-0707-b64f-e7a9-f5ce97d4f313@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/13/23 1:58 AM, Nicolas Dichtel wrote:
> Le 11/09/2023 à 11:50, Thomas Haller a écrit :
> [snip]
>> - the fact that it isn't fixed in more than a decade, shows IMO that
>> getting caching right for routes is very hard. Patches that improve the
>> behavior should not be rejected with "look at libnl3 or FRR".
> +1
> 
> I just hit another corner case:
> 
> ip link set ntfp2 up
> ip address add 10.125.0.1/24 dev ntfp2
> ip nexthop add id 1234 via 10.125.0.2 dev ntfp2
> ip route add 10.200.0.0/24 nhid 1234
> 
> Check the config:
> $ ip route
> <snip>
> 10.200.0.0/24 nhid 1234 via 10.125.0.2 dev ntfp2
> $ ip nexthop
> id 1234 via 10.125.0.2 dev ntfp2 scope link
> 
> 
> Set the carrier off on ntfp2:
> ip monitor label link route nexthop&
> ip link set ntfp2 carrier off
> 
> $ ip link set ntfp2 carrier off
> $ [LINK]4: ntfp2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
> DOWN group default
>     link/ether de:ed:02:67:61:1f brd ff:ff:ff:ff:ff:ff
> 
> => No nexthop event nor route event (net.ipv4.nexthop_compat_mode = 1)

carrier down is a link event and as you show here, link events are sent.

> 
> 'ip nexthop' and 'ip route' show that the nexthop and the route have been deleted.

nexthop objects are removed on the link event; any routes referencing
those nexthops are removed.

> 
> If the nexthop infra is not used (ip route add 10.200.0.0/24 via 10.125.0.2 dev
> ntfp2), the route entry is not deleted.
> 
> I wondering if it is expected to not have a nexthop event when one is removed
> due to a carrier lost.
> At least, a route event should be generated when the compat_mode is enabled.

compat_mode is about expanding nhid into the full, legacy route
attributes. See 4f80116d3df3b

