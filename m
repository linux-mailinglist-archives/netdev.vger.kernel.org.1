Return-Path: <netdev+bounces-196101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F855AD3853
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EAD17C4E8
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314012BD034;
	Tue, 10 Jun 2025 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djQNNT6s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C02A2BD02E
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560338; cv=none; b=sthrKUq3cxFC93nVPqVDi8JaWlhgT2jxsgDqdkuHXThxvQR/ch+77cI2VhVsBmRf7r2rL8LDjbcgm+/K/3dsddd73QOhGn0PVP89e8QHZiwg5rFeTDR3S//5RVUr0I0Uhd+dLiT+an4n93NHTB+r6g6W0V+jbLbwcbAMZligFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560338; c=relaxed/simple;
	bh=CbZXkmpEW1Db5ggtlB3I5iqPnSGmXZMykC82rffI8WY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fq42TzR9TSA7RPlURDM3yzxJQwzpSb0plV23N+Nt6A/yS4ysmlKfD98UqHEm1XtBZGezEQ58C1OqRKWnY+MPgOQsLUa0FlIVCI9raMkGmJvNl0FMVJt2lDUa+WcCwN/GcmOSLVNGhc763R9z1/4GLvptXOxNwuh/ZoTc/GfNWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djQNNT6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ED9C4CEF2;
	Tue, 10 Jun 2025 12:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749560337;
	bh=CbZXkmpEW1Db5ggtlB3I5iqPnSGmXZMykC82rffI8WY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=djQNNT6suZFqP7eRfa8D+d3SZ7+PpIZwegwG4DVE4LDxGZmOrV5qwrzVHlVVQsh4u
	 Moi7ykf7VATXnf/zRlLvQL08Z8Y/I6ta4X55p/H160eRae9vRDMWdHQ03iI7osAZr5
	 qoaX9gafQijssxUfyyV0eNpu+x76znARNGHlA2t2NAJo/mzoDQPcOEKjDMq8mmcFYO
	 Q4pCux6IGRoqwkZd+qilKEGb1+OsQiiMV/5y1U5/xWaLqeqmOhBLaYkzNHr0KFx1dB
	 J+LUaX0qw7lYvggz9o1fKjmYYyI+GDxMVvqzSxpTvoZMdmdlIlOuiwcPJb/HvoU4aW
	 iTPEhADdhKwmA==
Date: Tue, 10 Jun 2025 05:58:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/14] ipmr, ip6mr: Allow MC-routing
 locally-generated MC packets
Message-ID: <20250610055856.5ca1558a@kernel.org>
In-Reply-To: <cover.1749499963.git.petrm@nvidia.com>
References: <cover.1749499963.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 22:50:16 +0200 Petr Machata wrote:
> Multicast routing is today handled in the input path. Locally generated MC
> packets don't hit the IPMR code. Thus if a VXLAN remote address is
> multicast, the driver needs to set an OIF during route lookup. In practice
> that means that MC routing configuration needs to be kept in sync with the
> VXLAN FDB and MDB. Ideally, the VXLAN packets would be routed by the MC
> routing code instead.

I think this leads to kmemleaks:

unreferenced object 0xffff88800aabe740 (size 232):
comm "kworker/0:2", pid 471, jiffies 4295215616
hex dump (first 32 bytes):
00 40 df 08 80 88 ff ff 00 f7 5d 98 ff ff ff ff  .@........].....
a1 55 19 95 ff ff ff ff 00 00 00 00 00 00 00 00  .U..............
backtrace (crc b1fabddb):
kmem_cache_alloc_noprof (./include/linux/kmemleak.h:43 mm/slub.c:4152 mm/slub.c:4197 mm/slub.c:4204) 
dst_alloc (net/core/dst.c:89) 
ip6_rt_pcpu_alloc (net/ipv6/route.c:342 net/ipv6/route.c:1419) 
ip6_pol_route (net/ipv6/route.c:1468 net/ipv6/route.c:2305) 
fib6_rule_lookup (./include/net/ip6_fib.h:617 net/ipv6/ip6_fib.c:326) 
ip6_route_output_flags (net/ipv6/route.c:2699) 
ip6_dst_lookup_tail.constprop.0 (net/ipv6/ip6_output.c:1128) 
ip6_dst_lookup_flow (net/ipv6/ip6_output.c:1260) 
udp_tunnel6_dst_lookup (net/ipv6/ip6_udp_tunnel.c:165 net/ipv6/ip6_udp_tunnel.c:135) ip6_udp_tunnel 
vxlan_xmit_one (drivers/net/vxlan/vxlan_core.c:2540 (discriminator 4)) vxlan 
vxlan_xmit (drivers/net/vxlan/vxlan_core.c:2809) vxlan 
dev_hard_start_xmit (./include/linux/netdevice.h:5215 ./include/linux/netdevice.h:5224 net/core/dev.c:3830 net/core/dev.c:3846) 
__dev_queue_xmit (net/core/dev.h:356 net/core/dev.c:4714) 
ip6_finish_output2 (./include/net/neighbour.h:539 net/ipv6/ip6_output.c:141) 
ip6_finish_output.constprop.0 (net/ipv6/ip6_output.c:215 net/ipv6/ip6_output.c:226) 
mld_sendpack (net/ipv6/mcast.c:1872) 

hit by netdevsim udp_tunnel_nic.sh

Also, do you have a branch with the iproute2 patches we could pull 
in the CI?

