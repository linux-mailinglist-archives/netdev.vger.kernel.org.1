Return-Path: <netdev+bounces-134331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BDA998CE4
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20C01C23C8C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305E11CDFD9;
	Thu, 10 Oct 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ73K5JV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3261CDA25
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576635; cv=none; b=WBxU9csMMPVH7J7GBOXoosSQ5jsMpK/ZdTt6+prGRuOMB84JvpoV6GPfHhd1v5EfBjFcoXKtXmDh0nx6kjNjLTtHa7ZOGHGP7IlsBUo0oIydNy/0xpdsK2KSSU/WZ2co/w1BWm6JdZxb3CtCfw4kFe6wKUxBm2swJKXruZGzDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576635; c=relaxed/simple;
	bh=8g0eXQ+mJKNYyTGLrxPMufpMWcxSh0RSlTTehSZGrp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KgccYTdiYXNieBmLCJbaYrJ69odYSXMLXYdn3uNdE1QaYbOPcjID6bnvy3cGUHJ1hWm5BdVoVNrZPLzrMHbayo7jIoMFXa78PrYlg8H034LlO/lSehDoLthFzKOtY7Aqk91MsH0pM87qpGeGJmRojL4xCm1TJ6gre205Y3c+RW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ73K5JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899F0C4CEC5;
	Thu, 10 Oct 2024 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576634;
	bh=8g0eXQ+mJKNYyTGLrxPMufpMWcxSh0RSlTTehSZGrp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kQ73K5JV0ybisGlvj0RJBYFHW4/ar0knCAc4gUl7mNhVO5e8N/jiZuvkKNB413yPL
	 kVvq59nY5twc+OGu/2pp0HFip1SkWwqX7CAd3TpsWr2cCDzCPl0KiqS4nhCHkwIT5B
	 9t8C1Tecl4mGBX/Txj7uqNl19LC2EyjTmwrcCE63lkeIpLFFPgNUPciO8m0dE07MwC
	 nTxscdxH0nmxHcNl4skt2Ilv6ZUwwiITCvj1bd3IxqfrTt8SOqp17Zs1i/gEg0nS2o
	 WsO/C9Y/ArjB25V0UbDVgQUzUC8VnecRs0j/GY6loXCJkCS9iGhIbDaWhsIN6yJGrr
	 d9hfFiL+73hUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9E3803263;
	Thu, 10 Oct 2024 16:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ppp: fix ppp_async_encode() illegal access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172857663874.2081951.4681408965783420454.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 16:10:38 +0000
References: <20241009185802.3763282-1-edumazet@google.com>
In-Reply-To: <20241009185802.3763282-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+1d121645899e7692f92a@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Oct 2024 18:58:02 +0000 you wrote:
> syzbot reported an issue in ppp_async_encode() [1]
> 
> In this case, pppoe_sendmsg() is called with a zero size.
> Then ppp_async_encode() is called with an empty skb.
> 
> BUG: KMSAN: uninit-value in ppp_async_encode drivers/net/ppp/ppp_async.c:545 [inline]
>  BUG: KMSAN: uninit-value in ppp_async_push+0xb4f/0x2660 drivers/net/ppp/ppp_async.c:675
>   ppp_async_encode drivers/net/ppp/ppp_async.c:545 [inline]
>   ppp_async_push+0xb4f/0x2660 drivers/net/ppp/ppp_async.c:675
>   ppp_async_send+0x130/0x1b0 drivers/net/ppp/ppp_async.c:634
>   ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2280 [inline]
>   ppp_input+0x1f1/0xe60 drivers/net/ppp/ppp_generic.c:2304
>   pppoe_rcv_core+0x1d3/0x720 drivers/net/ppp/pppoe.c:379
>   sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1113
>   __release_sock+0x1da/0x330 net/core/sock.c:3072
>   release_sock+0x6b/0x250 net/core/sock.c:3626
>   pppoe_sendmsg+0x2b8/0xb90 drivers/net/ppp/pppoe.c:903
>   sock_sendmsg_nosec net/socket.c:729 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:744
>   ____sys_sendmsg+0x903/0xb60 net/socket.c:2602
>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2656
>   __sys_sendmmsg+0x3c1/0x960 net/socket.c:2742
>   __do_sys_sendmmsg net/socket.c:2771 [inline]
>   __se_sys_sendmmsg net/socket.c:2768 [inline]
>   __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2768
>   x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] ppp: fix ppp_async_encode() illegal access
    https://git.kernel.org/netdev/net/c/40dddd4b8bd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



