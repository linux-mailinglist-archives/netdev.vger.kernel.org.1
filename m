Return-Path: <netdev+bounces-79359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E64A878D7C
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 04:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D2BB2095C
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 03:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3422DAD4B;
	Tue, 12 Mar 2024 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOSUbhhh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E140AD2C
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214112; cv=none; b=sdomhAHbfxe+XCVIrnWMWBtQNh36fWRouedEF0FClISwnQDH+GAf0fjXyTbffNqpI+WdS0VRO0D3C7zAi6U2lLyGtfeluJJnfofQDQinGJL8G9vrzYPu3nv9V+FTHgUZQ4axG1wKQuTiRzNH3pzPNi/2ihG68CUPiP1C6XnwHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214112; c=relaxed/simple;
	bh=jJq6B7IbtZEaYrH4UHaPChse1S7kCWwrdwWpim7Ij/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ax9F8/fHwgNJL2g1SSXPV8COjTlz/CWaA+ZoHflxvzIOJyYxm8t2ivJ+ag73RQcMquYf5rcxG5XLrTcRbXTqcnVwJu5SQJwcjBF8YKmH2NTmoE8dNU7KTnIfFnCR7IMd45l/clcLvdu4+R+ycBBpKCrB58g/bWdBS/Q6TiJnf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOSUbhhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68973C433C7;
	Tue, 12 Mar 2024 03:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710214111;
	bh=jJq6B7IbtZEaYrH4UHaPChse1S7kCWwrdwWpim7Ij/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qOSUbhhh2SrRUZjftvANVH37TC39XXtJbqlZagOl+0RiRj2LnN9pzIErKkL4ACQuL
	 18DWN4QO6I9PpMeqO5ARUwyeV14WxvG3cEO6bCW+HCAUp+BpoKQzFlQU1rAPQ8aWfO
	 anvwIiAYUf0ZIIj5WHI8IVGrU5Rfj1IJVwt+1XaMVibkpZ4SLil+BrgE3ixRszheBW
	 wYIeLGkavnp3USpziE1xjGK3aUgC0HWRXFOR+2JiPcyx4cgAnTPAO3Cj4i4NWL56Kv
	 Kys0G109MbBlfEFsmRRz80yR27ZFEIQG9eOMvmiPpspWpV69hhB03WV7bfOkUYslB4
	 SfHRkheBhVgeQ==
Message-ID: <2a064df1-9c43-4224-aa35-6c7939852d1b@kernel.org>
Date: Mon, 11 Mar 2024 21:28:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] nexthop: Fix out-of-bounds access during
 attribute validation
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com
References: <20240311162307.545385-1-idosch@nvidia.com>
 <20240311162307.545385-4-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240311162307.545385-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 10:23 AM, Ido Schimmel wrote:
> Passing a maximum attribute type to nlmsg_parse() that is larger than
> the size of the passed policy will result in an out-of-bounds access [1]
> when the attribute type is used as an index into the policy array.
> 
> Fix by setting the maximum attribute type according to the policy size,
> as is already done for RTM_NEWNEXTHOP messages. Add a test case that
> triggers the bug.
> 
> No regressions in fib nexthops tests:
> 
>  # ./fib_nexthops.sh
>  [...]
>  Tests passed: 236
>  Tests failed:   0
> 
> [1]
> BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x1e53/0x2940
> Read of size 1 at addr ffffffff99ab4d20 by task ip/610
> 
> CPU: 3 PID: 610 Comm: ip Not tainted 6.8.0-rc7-custom-gd435d6e3e161 #9
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x8f/0xe0
>  print_report+0xcf/0x670
>  kasan_report+0xd8/0x110
>  __nla_validate_parse+0x1e53/0x2940
>  __nla_parse+0x40/0x50
>  rtm_del_nexthop+0x1bd/0x400
>  rtnetlink_rcv_msg+0x3cc/0xf20
>  netlink_rcv_skb+0x170/0x440
>  netlink_unicast+0x540/0x820
>  netlink_sendmsg+0x8d3/0xdb0
>  ____sys_sendmsg+0x31f/0xa60
>  ___sys_sendmsg+0x13a/0x1e0
>  __sys_sendmsg+0x11c/0x1f0
>  do_syscall_64+0xc5/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> [...]
> 
> The buggy address belongs to the variable:
>  rtm_nh_policy_del+0x20/0x40
> 
> Fixes: 2118f9390d83 ("net: nexthop: Adjust netlink policy parsing for a new attribute")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Closes: https://lore.kernel.org/netdev/CANn89i+UNcG0PJMW5X7gOMunF38ryMh=L1aeZUKH3kL4UdUqag@mail.gmail.com/
> Reported-by: syzbot+65bb09a7208ce3d4a633@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/00000000000088981b06133bc07b@google.com/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * Resize 'tb' using ARRAY_SIZE
> 
>  net/ipv4/nexthop.c                          | 29 ++++++++++++---------
>  tools/testing/selftests/net/fib_nexthops.sh |  6 +++++
>  2 files changed, 23 insertions(+), 12 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


> diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
> index d5a281aadbac..ac0b2c6a5761 100755
> --- a/tools/testing/selftests/net/fib_nexthops.sh
> +++ b/tools/testing/selftests/net/fib_nexthops.sh
> @@ -2066,6 +2066,12 @@ basic()
>  	run_cmd "$IP nexthop get id 1"
>  	log_test $? 2 "Nexthop get on non-existent id"
>  
> +	run_cmd "$IP nexthop del id 1"
> +	log_test $? 2 "Nexthop del with non-existent id"
> +
> +	run_cmd "$IP nexthop del id 1 group 1/2/3/4/5/6/7/8"
> +	log_test $? 2 "Nexthop del with non-existent id and extra attributes"
> +
>  	# attempt to create nh without a device or gw - fails
>  	run_cmd "$IP nexthop add id 1"
>  	log_test $? 2 "Nexthop with no device or gateway"

The basic() group of tests do not have a delete, so this is a good
addition. However, the ipv6_fcnal and ipv4_fcnal do have a del - seems
like those tests should have caught the out of bounds access.

