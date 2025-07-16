Return-Path: <netdev+bounces-207644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E0B080DE
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB591AA76A0
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928112EF9BC;
	Wed, 16 Jul 2025 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWwvJri+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63329292F
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752707995; cv=none; b=BeVcihAxJZuHV8Kq2Mur56Fm4zSgJ8qNT7WeQB1nlydSWDD7wpFyd/AhHahxMQiC9PKT57V0UK85kz+JZWlICNq5Lf/kN6+MLxXLXvWB93bes1q9dv7R3rO9SjBsSUqEOoB+KFWTSzuSVyXWQHkG/B3E641cmUkmrlxwCc8rQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752707995; c=relaxed/simple;
	bh=46CMkmEN4I10XNhRdidQqF1BB2d1mqbn4MvwSJJXh+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lYOVHPcYoKD1BJMGwtTGLSaH4fb1c+9liWPN9W15tUb7PuIqTqLxtGGyCDk7wBjSjgo7kQqIXO3COuKh8WSF/iorpz0UvXm8Hk0Y7cDGFIxSwjc9c/4ndmg2QD2FH6eRZXhy9Pm+UpEPTYcHIyWEBnyk2dbKgTU0c/CpLlNKgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWwvJri+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405C1C4CEE7;
	Wed, 16 Jul 2025 23:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752707995;
	bh=46CMkmEN4I10XNhRdidQqF1BB2d1mqbn4MvwSJJXh+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pWwvJri+B1q9DCGvreynbsMokTMB1jVYV5kyXU/oJHwN/pBGavAMrq/8+XnHjmCJS
	 yK3Dlx1sL+t+GUKcOY9dvpNBOBqn6Yv6/Ym53A8eAkiZ8ONnadMzpGTVWY/4dm77tR
	 5u48kQvFWC+m1A3HaD3ickBIWIL2NqFvrkI5biOQ5Rjxe/4U9WiumM6QU0K4TD7Qyb
	 RMGs1fWVOE+PzOACINJofIt/5bT11SAIj/hq6WOqC+EQMfMp5NND7/3YZrIkR+9rpI
	 P15rHz2dlPaVBE7OPcfmM0k2P/8h+1Z/J/NZkCcoelWKnxO3qwKjQ6QcRZAR1McO5C
	 vx/CENml5pqew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD5383BA38;
	Wed, 16 Jul 2025 23:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: fix UaF in tcp_prune_ofo_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175270801524.1359575.3541894487912368981.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 23:20:15 +0000
References: 
 <b78d2d9bdccca29021eed9a0e7097dd8dc00f485.1752567053.git.pabeni@redhat.com>
In-Reply-To: 
 <b78d2d9bdccca29021eed9a0e7097dd8dc00f485.1752567053.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 10:13:58 +0200 you wrote:
> The CI reported a UaF in tcp_prune_ofo_queue():
> 
> BUG: KASAN: slab-use-after-free in tcp_prune_ofo_queue+0x55d/0x660
> Read of size 4 at addr ffff8880134729d8 by task socat/20348
> 
> CPU: 0 UID: 0 PID: 20348 Comm: socat Not tainted 6.16.0-rc5-virtme #1 PREEMPT(full)
> Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x82/0xd0
>  print_address_description.constprop.0+0x2c/0x400
>  print_report+0xb4/0x270
>  kasan_report+0xca/0x100
>  tcp_prune_ofo_queue+0x55d/0x660
>  tcp_try_rmem_schedule+0x855/0x12e0
>  tcp_data_queue+0x4dd/0x2260
>  tcp_rcv_established+0x5e8/0x2370
>  tcp_v4_do_rcv+0x4ba/0x8c0
>  __release_sock+0x27a/0x390
>  release_sock+0x53/0x1d0
>  tcp_sendmsg+0x37/0x50
>  sock_write_iter+0x3c1/0x520
>  vfs_write+0xc09/0x1210
>  ksys_write+0x183/0x1d0
>  do_syscall_64+0xc1/0x380
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fcf73ef2337
> Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> RSP: 002b:00007ffd4f924708 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcf73ef2337
> RDX: 0000000000002000 RSI: 0000555f11d1a000 RDI: 0000000000000008
> RBP: 0000555f11d1a000 R08: 0000000000002000 R09: 0000000000000000
> R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000008
> R13: 0000000000002000 R14: 0000555ee1a44570 R15: 0000000000002000
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: fix UaF in tcp_prune_ofo_queue()
    https://git.kernel.org/netdev/net-next/c/7eeabfb23738

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



