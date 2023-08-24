Return-Path: <netdev+bounces-30252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DB778692D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788511C20E08
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E8525A;
	Thu, 24 Aug 2023 08:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E872A3D90
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B9FCC433C9;
	Thu, 24 Aug 2023 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692864023;
	bh=wszYkWiwH4pSiZBtvp2KRTXchP5BeljlbrPRZQ0ECvg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CbirVqUsFBiZN9AVFVMaWgaHMnv122jfFweMLBHKP3TpiICrrIpyE+9y46JWE1g7n
	 evuFC/bxGQBtmVY/k/FBHddmIaZ2N/a/wTBWs1/79zKSGo8FPWYVwpRmre0GSKcnk6
	 s2sOsiIWu/3kZDTxarEDsED+iuaOuZwMlqs0mnpk937BOBoKEunjAhPKiKCK1hhe+N
	 NpkQqYsYj/eU+SHdzCzLhgtId3USkPDslSNRVVIibTNffz0+cNURrA3piTqI9pyObo
	 QENTTjBuIXjvEBzaa3bj4lg5YfTwikCf0aq8B9UYUVBL83sCRCbdCY10bZ9s30VZQW
	 djt4hMiOFM6Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61B66E33093;
	Thu, 24 Aug 2023 08:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rtnetlink: Reject negative ifindexes in RTM_NEWLINK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169286402339.1543.14446432556518633186.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 08:00:23 +0000
References: <20230823064348.2252280-1-idosch@nvidia.com>
In-Reply-To: <20230823064348.2252280-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, razor@blackwall.org, jiri@nvidia.com,
 mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 23 Aug 2023 09:43:48 +0300 you wrote:
> Negative ifindexes are illegal, but the kernel does not validate the
> ifindex in the ancillary header of RTM_NEWLINK messages, resulting in
> the kernel generating a warning [1] when such an ifindex is specified.
> 
> Fix by rejecting negative ifindexes.
> 
> [1]
> WARNING: CPU: 0 PID: 5031 at net/core/dev.c:9593 dev_index_reserve+0x1a2/0x1c0 net/core/dev.c:9593
> [...]
> Call Trace:
>  <TASK>
>  register_netdevice+0x69a/0x1490 net/core/dev.c:10081
>  br_dev_newlink+0x27/0x110 net/bridge/br_netlink.c:1552
>  rtnl_newlink_create net/core/rtnetlink.c:3471 [inline]
>  __rtnl_newlink+0x115e/0x18c0 net/core/rtnetlink.c:3688
>  rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3701
>  rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6427
>  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
>  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>  netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
>  netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
>  sock_sendmsg_nosec net/socket.c:728 [inline]
>  sock_sendmsg+0xd9/0x180 net/socket.c:751
>  ____sys_sendmsg+0x6ac/0x940 net/socket.c:2538
>  ___sys_sendmsg+0x135/0x1d0 net/socket.c:2592
>  __sys_sendmsg+0x117/0x1e0 net/socket.c:2621
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [net] rtnetlink: Reject negative ifindexes in RTM_NEWLINK
    https://git.kernel.org/netdev/net/c/30188bd7838c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



