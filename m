Return-Path: <netdev+bounces-195284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A562ACF2E4
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4DC1894AD8
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B691A256E;
	Thu,  5 Jun 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8oo2HPn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E266D19CC27
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136805; cv=none; b=HfuluB2FndgpsZ/s16l7KoSgObgucN8S0C5maUu79Dmk8G20AsVO6xywVAErynn254Bb21mYMpFcZm0WCb2qgfV25yrNvM6TshoSsNclbAVOf1yWCr1zCClnuZEUp5YVVfJOlrv75uMORkp+7eV/fbATP70IesNsNfXi26Knf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136805; c=relaxed/simple;
	bh=C2hrVP4iq6G/D0ITLGuWErToHPSiRm1khOOFFl2cILk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W6KFZPuGdnz5LxIhYxl6b+S/M1p/zYJybabpnR9TXhi4uUZtqZVi9Wow50QTP9w00GHIhGWQ38yWcvm0yh+rFIIf9O19EBFED7qQlqHCW7mbTOZBmIMWu+bKMm8bZkIwZ0YvmRpaw28LWeSmHnZY+qfsh1DMggD2NBvcndG2WbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8oo2HPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52876C4CEE7;
	Thu,  5 Jun 2025 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749136804;
	bh=C2hrVP4iq6G/D0ITLGuWErToHPSiRm1khOOFFl2cILk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a8oo2HPnyCuGTlsLe1m8iLOIasnzGVSALpCi0aju6xEIxucVUzrhBFhvyxwzeDsqj
	 EmnwM7b65ld7iGtcKvMV+8zv1T6yQBgiuCWnl9KbxLjxb8AOWdC9nzeEt4yW0CbUGs
	 h2vLMbz5s/U9b8qDClFzhqQ2mERDqekX8MtdY/95BkVn9adEhxbbZ9NI0534biA3Jg
	 o9hCi9CP5hOH6Kw4UbPt2b7V587Bq/aM/zIvzabGVFqR6uEIKBDmuWeUhccCx2/2Nk
	 v4gfQCy+LWlF04A4d4LkfnG9apL0K4GzELWdt8ka165k6nkGRzWlSMKfI5qkdWw7eQ
	 SpIiOTxYMQQ7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7108638111D8;
	Thu,  5 Jun 2025 15:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: prevent a NULL deref in rtnl_create_link()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174913683626.3113343.2498396599502227239.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 15:20:36 +0000
References: <20250604105815.1516973-1-edumazet@google.com>
In-Reply-To: <20250604105815.1516973-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+9fc858ba0312b42b577e@syzkaller.appspotmail.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Jun 2025 10:58:15 +0000 you wrote:
> At the time rtnl_create_link() is running, dev->netdev_ops is NULL,
> we must not use netdev_lock_ops() or risk a NULL deref if
> CONFIG_NET_SHAPER is defined.
> 
> Use netif_set_group() instead of dev_set_group().
> 
>  RIP: 0010:netdev_need_ops_lock include/net/netdev_lock.h:33 [inline]
>  RIP: 0010:netdev_lock_ops include/net/netdev_lock.h:41 [inline]
>  RIP: 0010:dev_set_group+0xc0/0x230 net/core/dev_api.c:82
> Call Trace:
>  <TASK>
>   rtnl_create_link+0x748/0xd10 net/core/rtnetlink.c:3674
>   rtnl_newlink_create+0x25c/0xb00 net/core/rtnetlink.c:3813
>   __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
>   rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
>   rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
>   netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2534
>   netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>   netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
>   netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
>   sock_sendmsg_nosec net/socket.c:712 [inline]
> 
> [...]

Here is the summary with links:
  - [net] net: prevent a NULL deref in rtnl_create_link()
    https://git.kernel.org/netdev/net/c/feafc73f3e6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



