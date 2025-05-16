Return-Path: <netdev+bounces-191200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CD3ABA621
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0705E1BC103D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E10280011;
	Fri, 16 May 2025 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU9NBwIN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88921E097;
	Fri, 16 May 2025 22:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436393; cv=none; b=cD7e4zTgF/QSL8URDjJjCI6zjFpLJrsRdqgTrE0U1C/iKcTE9ZCxuaosgwX0ATEkFUg7MxxX8YXrwCmlmGDW0tVfmAaYDpERKwtOV/VqQ9OfvBAve9UzxKoS/voEPmgV2CX8JxGEcsa7H/n9tRMs2X2WJr7+e3X94brHoSZTcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436393; c=relaxed/simple;
	bh=4p4BKKhO0VjPlWgoVJGz3XP8j9PNfF1KOKg2YQjyDrk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mx6vIjbRu22TgvUXvI40fTtPb4Ag9bLMt0yEKBBHEEH4SgPFYctZN9w/U+Nlqxs/Q6RA9M4IhRhsBQZi58KQy+FL3Rn768brd+wuL4l1CEHzrTy4Spf290h7qtyNEvTuoXpsxKd1pePGwAKd2mYwBuVvZ4aA625EQhle2Nkyl2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU9NBwIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB336C4CEE4;
	Fri, 16 May 2025 22:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747436392;
	bh=4p4BKKhO0VjPlWgoVJGz3XP8j9PNfF1KOKg2YQjyDrk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YU9NBwINLhTmPliIbo+wevQ5cqqS4s0dim3ueCVLiCr1sGb8XBljF0gI7NwBo2rpQ
	 GACA4x3kVAEt4++wPKjLyAnXmf1Ss0W86rma/VF0qRCKUcm7DLTSxCSMeZ5Dzf1lvz
	 zbKWX5OLUIM6bm7QNReDJh4gIYqfjB06dYsxu+KE21/7FDjwXOFHyijYOHbyk15fEj
	 cuFcUsSgTGGYDvyhm6z9msB2f709Xc0u7M+UMU2ByIxDQeyPz9tpdx5SAVavd52JSl
	 11YVxiX3rXx3VTecC1ZGduwBmDs8F9WTSlEoP8jl3R6hFA+U6X3CI24RtXNPVgS6mN
	 +j5EJtJplWn2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD973806659;
	Fri, 16 May 2025 23:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] team: grab team lock during team_change_rx_flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743642955.4086697.10700383700149322566.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 23:00:29 +0000
References: <20250514220319.3505158-1-stfomichev@gmail.com>
In-Reply-To: <20250514220319.3505158-1-stfomichev@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, andrew+netdev@lunn.ch,
 sdf@fomichev.me, linux-kernel@vger.kernel.org,
 syzbot+53485086a41dbb43270a@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 May 2025 15:03:19 -0700 you wrote:
> Syzkaller reports the following issue:
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:578
> 
>  netdev_lock include/linux/netdevice.h:2751 [inline]
>  netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>  dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:285
>  bond_set_promiscuity drivers/net/bonding/bond_main.c:922 [inline]
>  bond_change_rx_flags+0x219/0x690 drivers/net/bonding/bond_main.c:4732
>  dev_change_rx_flags net/core/dev.c:9145 [inline]
>  __dev_set_promiscuity+0x3f5/0x590 net/core/dev.c:9189
>  netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
>  dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
>  ^^ all of the above is under rcu lock
>  team_change_rx_flags+0x1b3/0x330 drivers/net/team/team_core.c:1785
>  dev_change_rx_flags net/core/dev.c:9145 [inline]
>  __dev_set_promiscuity+0x3f5/0x590 net/core/dev.c:9189
>  netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
>  dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
>  hsr_del_port+0x25e/0x2d0 net/hsr/hsr_slave.c:233
>  hsr_netdev_notify+0x827/0xb60 net/hsr/hsr_main.c:104
>  notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
>  call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
>  call_netdevice_notifiers net/core/dev.c:2228 [inline]
>  unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11970
>  rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
>  rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
>  rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
>  netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
> 
> [...]

Here is the summary with links:
  - [net] team: grab team lock during team_change_rx_flags
    https://git.kernel.org/netdev/net/c/6b1d3c5f675c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



