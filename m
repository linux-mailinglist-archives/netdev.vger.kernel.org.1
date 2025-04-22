Return-Path: <netdev+bounces-184769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E76A971EB
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65FD1884FC1
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE228A3E2;
	Tue, 22 Apr 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG/Ti9nk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DE2199252
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338021; cv=none; b=Bv/3OdXrg1oOQ6TajAc/syN79cU+2ZYABImulkUjq5lLUT8S/obCnYXaONuhaigr5M+EL1avaNX9/OV+vOQs6f9HBvGE2ANmJDUaS1HfGYBe34nlaSfa9yxkQ8Nzd3m/WoSJl5oapw7RXKUxBGN4KsK5yDL9/3IMygyC0XNHtls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338021; c=relaxed/simple;
	bh=uS+NW8Y4dc5xpJmdpcLo8BFyXBbM9TQxx4BVJ+kC3YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDL1emfcQz2fY8kpLRVxlOcCLHKL5dPmAXE6s5sucHOuBiY1jXUKcEYngKD9DZtZtmvH55pzROBokXTKLUquOqvnYcjvPeNtEYzZL1+H4p9KtlnZizGdtLD9iCPMcV7M/l6saxp9mjA5vnUpd8oDxUpjlP2yUUihuYbPdgnkDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG/Ti9nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8491FC4CEE9;
	Tue, 22 Apr 2025 16:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745338020;
	bh=uS+NW8Y4dc5xpJmdpcLo8BFyXBbM9TQxx4BVJ+kC3YM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KG/Ti9nkF3aM1gmutyt0mvxxiLbpZh17B0TOZenhe3P5aPRGaO6SKnRhbzyDPYUhZ
	 UJSqLmAJy2PZzVYRQgXrmJy9NDP6tk5ykFOEqyxTcmLwGzJFAMCypYIBiKdylRhAqb
	 iAGl7lULvdPUxf7gVO5s2WGg0wtv5XtXfF07t8n+wlp80f7qQF93i+0V3YIVhwbuGY
	 1fTzmITDCCz9XSOqifZoRDoc3LaYSt9wBuvbHc+YHayz1K36rOk1P31nGV+JuXEPTt
	 VhsZrpkQfDiAggKBXzMkzv2l+Ma5RzvSU48wwrnd12px89Bmv0e+YwBPM8xGkPcXWG
	 gFtRvXTrurVQQ==
Message-ID: <649a886e-a914-433e-b6d2-152a69a0ad5d@kernel.org>
Date: Tue, 22 Apr 2025 09:06:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] ipv4: prefer multipath nexthop that matches
 source address
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com, kuniyu@amazon.com,
 Willem de Bruijn <willemb@google.com>
References: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
 <20250420180537.2973960-2-willemdebruijn.kernel@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250420180537.2973960-2-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/25 12:04 PM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> With multipath routes, try to ensure that packets leave on the device
> that is associated with the source address.
> 
> Avoid the following tcpdump example:
> 
>     veth0 Out IP 10.1.0.2.38640 > 10.2.0.3.8000: Flags [S]
>     veth1 Out IP 10.1.0.2.38648 > 10.2.0.3.8000: Flags [S]
> 
> Which can happen easily with the most straightforward setup:
> 
>     ip addr add 10.0.0.1/24 dev veth0
>     ip addr add 10.1.0.1/24 dev veth1
> 
>     ip route add 10.2.0.3 nexthop via 10.0.0.2 dev veth0 \
>     			  nexthop via 10.1.0.2 dev veth1
> 
> This is apparently considered WAI, based on the comment in
> ip_route_output_key_hash_rcu:
> 
>     * 2. Moreover, we are allowed to send packets with saddr
>     *    of another iface. --ANK
> 
> It may be ok for some uses of multipath, but not all. For instance,
> when using two ISPs, a router may drop packets with unknown source.
> 
> The behavior occurs because tcp_v4_connect makes three route
> lookups when establishing a connection:
> 
> 1. ip_route_connect calls to select a source address, with saddr zero.
> 2. ip_route_connect calls again now that saddr and daddr are known.
> 3. ip_route_newports calls again after a source port is also chosen.
> 
> With a route with multiple nexthops, each lookup may make a different
> choice depending on available entropy to fib_select_multipath. So it
> is possible for 1 to select the saddr from the first entry, but 3 to
> select the second entry. Leading to the above situation.
> 
> Address this by preferring a match that matches the flowi4 saddr. This
> will make 2 and 3 make the same choice as 1. Continue to update the
> backup choice until a choice that matches saddr is found.
> 
> Do this in fib_select_multipath itself, rather than passing an fl4_oif
> constraint, to avoid changing non-multipath route selection. Commit
> e6b45241c57a ("ipv4: reset flowi parameters on route connect") shows
> how that may cause regressions.
> 
> Also read ipv4.sysctl_fib_multipath_use_neigh only once. No need to
> refresh in the loop.
> 
> This does not happen in IPv6, which performs only one lookup.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> Side-quest: I wonder if the second route lookup in ip_route_connect
> is vestigial since the introduction of the third route lookup with
> ip_route_newports. IPv6 has neither second nor third lookup, which
> hints that perhaps both can be removed.
> ---
>  include/net/ip_fib.h     |  3 ++-
>  net/ipv4/fib_semantics.c | 39 +++++++++++++++++++++++++--------------
>  net/ipv4/route.c         |  2 +-
>  3 files changed, 28 insertions(+), 16 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



