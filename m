Return-Path: <netdev+bounces-21089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F067626DB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 00:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6877B1C21075
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D18F51;
	Tue, 25 Jul 2023 22:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA118462
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 22:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB67C433C8;
	Tue, 25 Jul 2023 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690324637;
	bh=ibc4z5TWhzUB+1gt3pOwhVennqPbFoRXB2zXlc50XW4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vPQ99O5UO3fDfjKBO4NcTVt3z59y2lt2qz/NtCopYn+xr/pOCTLAfgKvxyGv8X1hI
	 xRc33VrmFna+QbjJVkY7RCkCHQIlJOXnFCHogJApR0OSJVKx2YVSRnkNuEcWWKKoaM
	 locEBRqtVRCZg+oVhfn93FsUor+Yikr5aNjHhYqoMcbvNlOJSH71DU36zs9JVih8AL
	 FPFmgLuj4aYW/puQ4YQG5WhvnSOJsrxd1SQs1K5QAU5p8fEmLIm+p11ci2Cgsy4Tqq
	 +3YJmmh40y4laQ59jJCqu6hILD/EL+ac33451UpeXeE7j9J5ED3DaO7QI7X8ua3hC4
	 qr7+husqjHGIw==
Message-ID: <7fb36754-9e7b-73a7-3c3b-0a8141e4a85f@kernel.org>
Date: Tue, 25 Jul 2023 16:37:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCHv3 net] ipv6: do not match device when remove source route
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>,
 Donald Sharp <sharpd@nvidia.com>
References: <20230720065941.3294051-1-liuhangbin@gmail.com>
 <ZLk0/f82LfebI5OR@shredder> <ZLlJi7OUy3kwbBJ3@shredder>
 <ZLpI6YZPjmVD4r39@Laptop-X1> <ZLzhMDIayD2z4szG@shredder>
 <8c8ba9bd-875f-fe2c-caf1-6621f1ecbb92@kernel.org> <ZL+ekVftp24TzrHz@shredder>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZL+ekVftp24TzrHz@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/23 4:06 AM, Ido Schimmel wrote:
> On Sun, Jul 23, 2023 at 12:12:00PM -0600, David Ahern wrote:
>> On 7/23/23 2:13 AM, Ido Schimmel wrote:
>>>
>>> I don't know, but when I checked the code and tested it I noticed that
>>> the kernel doesn't care on which interface the address is configured.
>>> Therefore, in order for deletion to be consistent with addition and with
>>> IPv4, the preferred source address shouldn't be removed from routes in
>>> the VRF table as long as the address is configured on one of the
>>> interfaces in the VRF.
>>>
>>
>> Deleting routes associated with device 2 when an address is deleted from
>> device 1 is going to introduce as many problems as it solves. The VRF
>> use case is one example.
> 
> This already happens in IPv4:
> 
> # ip link add name dummy1 up type dummy
> # ip link add name dummy2 up type dummy
> # ip address add 192.0.2.1/24 dev dummy1
> # ip route add 198.51.100.0/24 dev dummy2 src 192.0.2.1
> # ip -4 r s
> 192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1 
> 198.51.100.0/24 dev dummy2 scope link src 192.0.2.1 
> # ip address del 192.0.2.1/24 dev dummy1
> # ip -4 r s
> 
> IPv6 only removes the preferred source address from routes, but doesn't
> delete them. The patch doesn't change that.
> 
> Another difference from IPv4 is that IPv6 only removes the preferred
> source address from routes whose first nexthop device matches the device
> from which the address was removed:
> 
> # ip link add name dummy1 up type dummy
> # ip link add name dummy2 up type dummy
> # ip address add 2001:db8:1::1/64 dev dummy1
> # ip route add 2001:db8:2::/64 dev dummy2 src 2001:db8:1::1
> # ip -6 r s
> 2001:db8:1::/64 dev dummy1 proto kernel metric 256 pref medium
> 2001:db8:2::/64 dev dummy2 src 2001:db8:1::1 metric 1024 pref medium
> fe80::/64 dev dummy1 proto kernel metric 256 pref medium
> fe80::/64 dev dummy2 proto kernel metric 256 pref medium
> # ip address del 2001:db8:1::1/64 dev dummy1
> # ip -6 r s
> 2001:db8:2::/64 dev dummy2 src 2001:db8:1::1 metric 1024 pref medium
> fe80::/64 dev dummy1 proto kernel metric 256 pref medium
> fe80::/64 dev dummy2 proto kernel metric 256 pref medium
> 
> And this is despite the fact that the kernel only allowed the route to
> be programmed because the preferred source address was present on
> another interface in the same L3 domain / VRF:
> 
> # ip link add name dummy1 up type dummy
> # ip link add name dummy2 up type dummy
> # ip route add 2001:db8:2::/64 dev dummy2 src 2001:db8:1::1
> Error: Invalid source address.
> 
> The intent of the patch (at least with the changes I proposed) is to
> remove the preferred source address from routes in a VRF when the
> address is no longer configured on any interface in the VRF.
> 
> Note that the above is true for addresses with a global scope. The
> removal of a link-local address from a device should not affect other
> devices. This restriction also applies when a route is added:
> 
> # ip link add name dummy1 up type dummy
> # ip link add name dummy2 up type dummy
> # ip -6 address add fe80::1/64 dev dummy1
> # ip -6 route add 2001:db8:2::/64 dev dummy2 src fe80::1
> Error: Invalid source address.
> # ip -6 address add fe80::1/64 dev dummy2
> # ip -6 route add 2001:db8:2::/64 dev dummy2 src fe80::1

Lot of permutations. It would be good to get these in a test script
along with other variations - e.g.,

# 2 devices with the same source address
ip link add name dummy1 up type dummy
ip link add name dummy2 up type dummy
ip link add name dummy3 up type dummy
ip address add 192.0.2.1/24 dev dummy1
ip address add 192.0.2.1/24 dev dummy3
ip route add 198.51.100.0/24 dev dummy2 src 192.0.2.1
ip address del 192.0.2.1/24 dev dummy1
--> src route should stay

# VRF with single device using src address
ip li add name red up type vrf table 123
ip link add name dummy4 up type dummy vrf red
ip link add name dummy5 up type dummy vrf red
ip address add 192.0.2.1/24 dev dummy4
ip route add 198.51.100.0/24 dev dummy5 src 192.0.2.1
ip address del 192.0.2.1/24 dev dummy4
ip ro ls vrf red

# VRF with two devices using src address
ip li add name red up type vrf table 123
ip link add name dummy4 up vrf red type dummy
ip link add name dummy5 up vrf red type dummy
ip link add name dummy6 up vrf red type dummy
ip address add 192.0.2.1/24 dev dummy4
ip address add 192.0.2.1/24 dev dummy6
ip route add 198.51.100.0/24 dev dummy5 src 192.0.2.1 vrf red
ip address del 192.0.2.1/24 dev dummy4


I can not find my notes but I recall Donald raised a ticket at Cumulus
when FRR tripped over a scenario like this or a related one (something
about routes and address delete). CC'ed Donald in case he recalls the
details

