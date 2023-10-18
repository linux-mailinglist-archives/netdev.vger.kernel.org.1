Return-Path: <netdev+bounces-42104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E67CD1E4
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E04B20F8F
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33FA15B7;
	Wed, 18 Oct 2023 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8Nmg2T6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D930A5B
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EED66C433C8;
	Wed, 18 Oct 2023 01:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697593224;
	bh=ucuHisvDKDQda+rqArQYPEbAKWja8UuyY4zxgpBN9Os=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m8Nmg2T6Zh7kDfkMbqb6wtAnTC+s0JYRkZhdR9Sm8x97vYuih19txKR1D9fHWqR5w
	 Dno7dXgRqrE/FlpXid5NajBTQQXIJKledDp5g3+NzoWnV8Ae4E/kEuFAxdTsuAPSXc
	 vxTyGpf7i/GtwwoFkCHEySWvN0O2o9BgD4LdCsTIuFSh/9GDujVle7HdfUf82uN0Dl
	 JoJQYogdjtf1YNvxjd/DgKm8d87h5fEou4G0S8GFSYOvwD70FopRYtwH956dlOECcE
	 VsoMLfDzXDP+zmHPnOLAJo2DayLWlWkTDrM8GgEA+hokNfppFCozmZ0mLiDjY9N5LD
	 X7mcTZn/62aww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9FDFC04E24;
	Wed, 18 Oct 2023 01:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/7] net: xfrm: skip policies marked as dead while reinserting
 policies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169759322388.7564.14270204146303958143.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 01:40:23 +0000
References: <20231017083723.1364940-2-steffen.klassert@secunet.com>
In-Reply-To: <20231017083723.1364940-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Tue, 17 Oct 2023 10:37:17 +0200 you wrote:
> From: Dong Chenchen <dongchenchen2@huawei.com>
> 
> BUG: KASAN: slab-use-after-free in xfrm_policy_inexact_list_reinsert+0xb6/0x430
> Read of size 1 at addr ffff8881051f3bf8 by task ip/668
> 
> CPU: 2 PID: 668 Comm: ip Not tainted 6.5.0-rc5-00182-g25aa0bebba72-dirty #64
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x72/0xa0
>  print_report+0xd0/0x620
>  kasan_report+0xb6/0xf0
>  xfrm_policy_inexact_list_reinsert+0xb6/0x430
>  xfrm_policy_inexact_insert_node.constprop.0+0x537/0x800
>  xfrm_policy_inexact_alloc_chain+0x23f/0x320
>  xfrm_policy_inexact_insert+0x6b/0x590
>  xfrm_policy_insert+0x3b1/0x480
>  xfrm_add_policy+0x23c/0x3c0
>  xfrm_user_rcv_msg+0x2d0/0x510
>  netlink_rcv_skb+0x10d/0x2d0
>  xfrm_netlink_rcv+0x49/0x60
>  netlink_unicast+0x3fe/0x540
>  netlink_sendmsg+0x528/0x970
>  sock_sendmsg+0x14a/0x160
>  ____sys_sendmsg+0x4fc/0x580
>  ___sys_sendmsg+0xef/0x160
>  __sys_sendmsg+0xf7/0x1b0
>  do_syscall_64+0x3f/0x90
>  entry_SYSCALL_64_after_hwframe+0x73/0xdd
> 
> [...]

Here is the summary with links:
  - [1/7] net: xfrm: skip policies marked as dead while reinserting policies
    https://git.kernel.org/netdev/net/c/6d41d4fe2872
  - [2/7] xfrm: interface: use DEV_STATS_INC()
    https://git.kernel.org/netdev/net/c/f7c4e3e5d4f6
  - [3/7] xfrm: fix a data-race in xfrm_gen_index()
    https://git.kernel.org/netdev/net/c/3e4bc23926b8
  - [4/7] xfrm6: fix inet6_dev refcount underflow problem
    https://git.kernel.org/netdev/net/c/cc9b364bb1d5
  - [5/7] net: ipv6: fix return value check in esp_remove_trailer
    https://git.kernel.org/netdev/net/c/dad4e491e30b
  - [6/7] net: ipv4: fix return value check in esp_remove_trailer
    https://git.kernel.org/netdev/net/c/513f61e21933
  - [7/7] xfrm: fix a data-race in xfrm_lookup_with_ifid()
    https://git.kernel.org/netdev/net/c/de5724ca38fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



