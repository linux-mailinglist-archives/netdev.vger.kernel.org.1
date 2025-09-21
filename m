Return-Path: <netdev+bounces-225041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B46CB8DD5F
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 17:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F953B07A5
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6A1C7017;
	Sun, 21 Sep 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDw6QFEh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4CE1BC4E
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758468934; cv=none; b=S/dVKfRoYU/s4rCNfu/6R92+xDjXWKLmBtkFuBmggkcGd6sNCB2hlxLpBfbddAeuB0ji0cJWw3zujHh9upSWf3JyjZWKealbpbZSbEwLhd/mjXFTRTIM0dKahcvkqjOHeWiKJgTXd4/EDFebymZsukWWKFRlEuOieW1fZhYVv4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758468934; c=relaxed/simple;
	bh=grtvNTfwCljhFQFwvTRrQRjwp/xF7o7u4BdyU3d5h6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUqyuw/8okJJXwsS1ZsxNUKDH9P3xqBzAPLEWsRaX208RAHuGehaClTBR81yQCCElU9XHX4lbNRrQnG4fyDvx7jJGzshRiCMWr/O53VfUISI4vFH3s5mRref3D81Akrq5O4f1FLHJHAmYYSVHdQPmbfrfI4IK+ebv/y7SE43j6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDw6QFEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD30AC4CEE7;
	Sun, 21 Sep 2025 15:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758468934;
	bh=grtvNTfwCljhFQFwvTRrQRjwp/xF7o7u4BdyU3d5h6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gDw6QFEh01gwsiO8Xscj4NgHh5RsqAkkibHLn0+BuDRkdyqnXWryLDtTK/9iEwd+S
	 JffH/DQUTImiLFrquJVXWHhNAGKccKdeurAB5iHPNy1QIdA/opHuleiv+c7bPJl1Ar
	 tOmneeeqfaaiXr6lPNWg4+XjVXUGGYS75l54zN8wQSQ0MoIJf8THTEmaMKe9qHQmIu
	 GEgE5xPeZhazT/Q12w+tB2cDPcVcgKY5wJ6XfEcqlqxeecav79BSlmCNdmIcsF6RMD
	 J/wG9Zo9RX6sJ+cUh5cPjQsPJxDcgwgf9mGgr5l+HlaKE+UaSw2Cp+TQenaM8bI+7X
	 XJpvGSLbuXLjQ==
Message-ID: <d4b32b8e-568b-41e1-a9e7-5868d76066f7@kernel.org>
Date: Sun, 21 Sep 2025 09:35:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] nexthop: Forbid FDB status change while nexthop
 is in a group
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, petrm@nvidia.com, aroulin@nvidia.com
References: <20250921150824.149157-1-idosch@nvidia.com>
 <20250921150824.149157-2-idosch@nvidia.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250921150824.149157-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 9:08 AM, Ido Schimmel wrote:
> The kernel forbids the creation of non-FDB nexthop groups with FDB
> nexthops:
> 
>  # ip nexthop add id 1 via 192.0.2.1 fdb
>  # ip nexthop add id 2 group 1
>  Error: Non FDB nexthop group cannot have fdb nexthops.
> 
> And vice versa:
> 
>  # ip nexthop add id 3 via 192.0.2.2 dev dummy1
>  # ip nexthop add id 4 group 3 fdb
>  Error: FDB nexthop group can only have fdb nexthops.
> 
> However, as long as no routes are pointing to a non-FDB nexthop group,
> the kernel allows changing the type of a nexthop from FDB to non-FDB and
> vice versa:
> 
>  # ip nexthop add id 5 via 192.0.2.2 dev dummy1
>  # ip nexthop add id 6 group 5
>  # ip nexthop replace id 5 via 192.0.2.2 fdb
>  # echo $?
>  0
> 
> This configuration is invalid and can result in a NPD [1] since FDB
> nexthops are not associated with a nexthop device:
> 
>  # ip route add 198.51.100.1/32 nhid 6
>  # ping 198.51.100.1
> 
> Fix by preventing nexthop FDB status change while the nexthop is in a
> group:
> 
>  # ip nexthop add id 7 via 192.0.2.2 dev dummy1
>  # ip nexthop add id 8 group 7
>  # ip nexthop replace id 7 via 192.0.2.2 fdb
>  Error: Cannot change nexthop FDB status while in a group.
> 
> [1]
> BUG: kernel NULL pointer dereference, address: 00000000000003c0
> [...]
> Oops: Oops: 0000 [#1] SMP
> CPU: 6 UID: 0 PID: 367 Comm: ping Not tainted 6.17.0-rc6-virtme-gb65678cacc03 #1 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
> RIP: 0010:fib_lookup_good_nhc+0x1e/0x80
> [...]
> Call Trace:
>  <TASK>
>  fib_table_lookup+0x541/0x650
>  ip_route_output_key_hash_rcu+0x2ea/0x970
>  ip_route_output_key_hash+0x55/0x80
>  __ip4_datagram_connect+0x250/0x330
>  udp_connect+0x2b/0x60
>  __sys_connect+0x9c/0xd0
>  __x64_sys_connect+0x18/0x20
>  do_syscall_64+0xa4/0x2a0
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> Fixes: 38428d68719c ("nexthop: support for fdb ecmp nexthops")
> Reported-by: syzbot+6596516dd2b635ba2350@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/68c9a4d2.050a0220.3c6139.0e63.GAE@google.com/
> Tested-by: syzbot+6596516dd2b635ba2350@syzkaller.appspotmail.com
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/nexthop.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



