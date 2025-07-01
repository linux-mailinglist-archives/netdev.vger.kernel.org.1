Return-Path: <netdev+bounces-202719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB669AEEC0C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3817D18862D3
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FD4148832;
	Tue,  1 Jul 2025 01:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0Q1Pqlv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20419BBC
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 01:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332784; cv=none; b=tUCBOg/judXfzGYTnlZbB9R9rUM4LQLZ1aQ6SbNOUUOo/3ePwinlejyN7USSBTPg0XP/OSLYTmEBObGSA8cNN1+xLJCv+M0t/E3xxwO9/DBQ1/vghqvAVgmIzKc9H3RUePlGqP50h/lZPAP3Q+gxO/ab/q0sOhCmz/dvKcaL3Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332784; c=relaxed/simple;
	bh=IBrSc8GQxBLzdhJs3zZneH4hHyIxkjkI6oPZM8dFnXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eh6VDWehDkPJei9amPtIoCP84RUioH9iuo4IQ9IVCSUvgONIQbzUgAODtzaNoisdRR259f+oRoJLZ3zHjlRXpA0QpVTNLDybGGaHUkBOwCuuSaVVGPoZUUwGiNTCG2xElcnVsFcJTw/ZaVd/MB75qL6PJsIDBkr49vW5dxDFKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0Q1Pqlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743C4C4CEE3;
	Tue,  1 Jul 2025 01:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751332782;
	bh=IBrSc8GQxBLzdhJs3zZneH4hHyIxkjkI6oPZM8dFnXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O0Q1PqlvAjchaVuylt9Q9Uo0ZaaQNB72pr4B9HFBHhbveoNX1J37pI5Nrz9AvFTUg
	 ag0CaqvQqPvNoNPfi5rY7887I8FUkYg5vD1EDV+kfqAopQmW2iPUsAxRdPjaVBngEg
	 ytp8j2y3Yv7anqfu4Swg7JhliMd9RWFjsD5dZaukEP5ZAIfyGysjTKH6YFzN4/NaSS
	 FVCqsAcjbAk7Gdnw8SzLe0qrgvB+vyUajsSWC95Po1yTLMpsa9Efb/3ess+xCfHEof
	 KZnxig4yUC0MCxAnANOl+58IKRWP7UZpJL1HPPFtLu9jNhZWL9BqCf8y8aS5s414As
	 BbSaLUg13Y1tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE1338111CE;
	Tue,  1 Jul 2025 01:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: guard ip6_mr_output() with rcu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175133280734.3630108.2288047934531939034.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 01:20:07 +0000
References: <20250627115822.3741390-1-edumazet@google.com>
In-Reply-To: <20250627115822.3741390-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+0141c834e47059395621@syzkaller.appspotmail.com, petrm@nvidia.com,
 roopa@nvidia.com, razor@blackwall.org, bpoirier@nvidia.com, idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Jun 2025 11:58:21 +0000 you wrote:
> syzbot found at least one path leads to an ip_mr_output()
> without RCU being held.
> 
> Add guard(rcu)() to fix this in a concise way.
> 
> WARNING: net/ipv6/ip6mr.c:2376 at ip6_mr_output+0xe0b/0x1040 net/ipv6/ip6mr.c:2376, CPU#1: kworker/1:2/121
> Call Trace:
>  <TASK>
>   ip6tunnel_xmit include/net/ip6_tunnel.h:162 [inline]
>   udp_tunnel6_xmit_skb+0x640/0xad0 net/ipv6/ip6_udp_tunnel.c:112
>   send6+0x5ac/0x8d0 drivers/net/wireguard/socket.c:152
>   wg_socket_send_skb_to_peer+0x111/0x1d0 drivers/net/wireguard/socket.c:178
>   wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
>   wg_packet_tx_worker+0x1c8/0x7c0 drivers/net/wireguard/send.c:276
>   process_one_work kernel/workqueue.c:3239 [inline]
>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3322
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3403
>   kthread+0x70e/0x8a0 kernel/kthread.c:464
>   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: guard ip6_mr_output() with rcu
    https://git.kernel.org/netdev/net-next/c/af232e7615e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



