Return-Path: <netdev+bounces-102314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B79FD9025BD
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 17:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501AEB2BF3B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D6E1422A8;
	Mon, 10 Jun 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBk4mO6d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF03613E3FD
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032922; cv=none; b=lsUAC/ZZPYljIYsjZEVWEIGppYJOT/YhNfldP6BNYTwzlMexDQ1LlAJ4iDZsxB1aiZ0KPdD+RSaQQfYGPcDwocP36/UHKHdnBfHDXwuEb6bNGvIVxPRCILZfa772CuY6e99OfWexg12zBHjhwYjoWCYEMWLQD8ddIKwXrlJFqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032922; c=relaxed/simple;
	bh=Q3gtFHk9f7GKsrnZAaXEdWH0y3gvYeFJutUp+xxB0p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzAjdZhWhtWYcDqLWvkWhNqHo2csOmSbM36myWTyLz32iHY/dBy/J92G/x/wmxziTEYhXBaiCJpfKlZfJFjh83JXl+mpbQHBoEKEGaObd08SyKs18L+uDMy7+D/ufN1617RFMXISLNPhpZWWewXTSo171/OWVzOxW0xEL2iYbk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBk4mO6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4CFC2BBFC;
	Mon, 10 Jun 2024 15:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718032921;
	bh=Q3gtFHk9f7GKsrnZAaXEdWH0y3gvYeFJutUp+xxB0p8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LBk4mO6dZDDtTeYtJvPumIrpjYb0eUu1ZkjURZdovFCpDm7h9/ldTI1AEKqKbw+HD
	 hboS6+X9bHSRhj6X+kH/FQwJCg5lwPEVhkfB1hNqwEqlGK5L0wAXPRl/oeJZx9Zarp
	 N+RGGk9czwjSh3U15SDDgHRU1cUAuKaUUrW0d8HcQaf8/U6RldCdyDjWWjaH2RE+hg
	 6NO57eUR+ljFm2l3lqqY+1Il6ChCIUAy81DL/bumCJ9vM7AYhs25YdopF5HP8/Ubff
	 0KNXcrg7+ZZzEJleZKVnc5wNE/H139LNy/kr+PEhx0kZ7QfdK0e1IYCygCmRRhF7gK
	 sEDrr63tZqQxQ==
Message-ID: <4ee54a41-77d9-45c7-9493-b12d29a62c4a@kernel.org>
Date: Mon, 10 Jun 2024 09:21:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/5] Allow configuration of multipath hash
 seed
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, mlxsw@nvidia.com
References: <20240607151357.421181-1-petrm@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240607151357.421181-1-petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 9:13 AM, Petr Machata wrote:
> Let me just quote the commit message of patch #2 here to inform the
> motivation and some of the implementation:
> 
>     When calculating hashes for the purpose of multipath forwarding,
>     both IPv4 and IPv6 code currently fall back on
>     flow_hash_from_keys(). That uses a randomly-generated seed. That's a
>     fine choice by default, but unfortunately some deployments may need
>     a tighter control over the seed used.
> 
>     In this patchset, make the seed configurable by adding a new sysctl
>     key, net.ipv4.fib_multipath_hash_seed to control the seed. This seed
>     is used specifically for multipath forwarding and not for the other
>     concerns that flow_hash_from_keys() is used for, such as queue
>     selection. Expose the knob as sysctl because other such settings,
>     such as headers to hash, are also handled that way.
> 
>     Despite being placed in the net.ipv4 namespace, the multipath seed
>     sysctl is used for both IPv4 and IPv6, similarly to e.g. a number of
>     TCP variables. Like those, the multipath hash seed is a per-netns
>     variable.
> 
>     The seed used by flow_hash_from_keys() is a 128-bit quantity.
>     However it seems that usually the seed is a much more modest value.
>     32 bits seem typical (Cisco, Cumulus), some systems go even lower.
>     For that reason, and to decouple the user interface from
>     implementation details, go with a 32-bit quantity, which is then
>     quadruplicated to form the siphash key.
> 
> One example of use of this interface is avoiding hash polarization,
> where two ECMP routers, one behind the other, happen to make consistent
> hashing decisions, and as a result, part of the ECMP space of the latter
> router is never used. Another is a load balancer where several machines
> forward traffic to one of a number of leaves, and the forwarding
> decisions need to be made consistently. (This is a case of a desired
> hash polarization, mentioned e.g. in chapter 6.3 of [0].)
> 
> There has already been a proposal to include a hash seed control
> interface in the past[1].
> 
> - Patches #1-#2 contain the substance of the work
> - Patch #3 is an mlxsw offload
> - Patches #4 and #5 are a selftest
> 
> [0] https://www.usenix.org/system/files/conference/nsdi18/nsdi18-araujo.pdf
> [1] https://lore.kernel.org/netdev/YIlVpYMCn%2F8WfE1P@rnd/
> 
> v2:
> - Patch #2:
>     - Instead of precomputing the siphash key, construct it in place
>       of use thus obviating the need to use RCU.
>     - Instead of dispatching to the flow dissector for cases where
>       user seed is 0, maintain a separate random seed. Initialize it
>       early so that we can avoid a branch at the seed reader.
>     - In documentation, s/only valid/only present/ (when
>       CONFIG_IP_ROUTE_MULTIPATH). Also mention the algorithm is
>       unspecified and unstable in principle.
> - Patch #3:
>     - Update to match changes in patch #2.
> - Patch #4:
>     - New patch.
> - Patch #5:
>     - Do not set seed on test init and run the stability tests first to catch
>       the cases of a missed pernet seed init.
> 
> Petr Machata (5):
>   net: ipv4,ipv6: Pass multipath hash computation through a helper
>   net: ipv4: Add a sysctl to set multipath hash seed
>   mlxsw: spectrum_router: Apply user-defined multipath hash seed
>   selftests: forwarding: lib: Split sysctl_save() out of sysctl_set()
>   selftests: forwarding: router_mpath_hash: Add a new selftest
> 
>  Documentation/networking/ip-sysctl.rst        |  14 +
>  .../ethernet/mellanox/mlxsw/spectrum_router.c |   6 +-
>  include/net/flow_dissector.h                  |   2 +
>  include/net/ip_fib.h                          |  28 ++
>  include/net/netns/ipv4.h                      |   8 +
>  net/core/flow_dissector.c                     |   7 +
>  net/ipv4/route.c                              |  12 +-
>  net/ipv4/sysctl_net_ipv4.c                    |  66 ++++
>  net/ipv6/route.c                              |  12 +-
>  .../testing/selftests/net/forwarding/Makefile |   1 +
>  tools/testing/selftests/net/forwarding/lib.sh |   9 +-
>  .../net/forwarding/router_mpath_seed.sh       | 333 ++++++++++++++++++
>  12 files changed, 484 insertions(+), 14 deletions(-)
>  create mode 100755 tools/testing/selftests/net/forwarding/router_mpath_seed.sh
> 

For the set:

Reviewed-by: David Ahern <dsahern@kernel.org>


