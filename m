Return-Path: <netdev+bounces-143028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2859A9C0F22
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A8A2857C2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D85B21731F;
	Thu,  7 Nov 2024 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/z/nr9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09044218333
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008424; cv=none; b=aREX/piW8gu42sAaWrtXoXd/PddQp09CV2KkwvEPf7J/2KCBDznUdyK/eSC229FL6VRK7mCOC97DsHkfQvoUk4GNxzyI3SLkzPjju7KLaOQCNqN2VuOUC01HMgLJLirK2txtzt/Jk7+8p9Ai9CgrLZKVxLjngQCryB+6FqDGC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008424; c=relaxed/simple;
	bh=9cvgJMx5iwD4rNCECn7aTRXk+0s9qi2U1grX3S2fY80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sp9XTB+ict97mqp6V4s9Q5kTluxsAUc7iCgFWksyVHi1T/9cESa5lrz4PK9aNdpljp5GAPsF8wSziO0PPBw6hD6Ku8DQCF/CqYxsEPiefXIc3TrEdhWklwNhiHSblzHIEZBhx+n6BUpH6EMfdgzepM0KS+RgqQfhl4ess0v9fWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/z/nr9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734DAC4CECC;
	Thu,  7 Nov 2024 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731008423;
	bh=9cvgJMx5iwD4rNCECn7aTRXk+0s9qi2U1grX3S2fY80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g/z/nr9lvPR7fLOk8bYeCPPhDpa/gzRL/FHRb5BPBgZLd0s+z+J/6iQcMaGfx6h9D
	 Q8I5/DfUEunvVDO/A/xMF73ioX6Uek4muMfI2VqUKXVvQvbL+oJEHGxofN6Tv872ao
	 6sC13J7DqCEvjSlgNF7HaR/9EIG+Xlgu49t8VRF5jum91O4uf1igimHDZ5mjrETuwn
	 BdQqQ5UTxqH5SkScE86o8Dumn5ugkm9UBg8daumZND+fAHWSyFHEh4ZqaV06LiffXg
	 hWeqlERATJUrFRfo0bwIU/kgxQbejSsto7WInO6Qm1wJVgR+qTNZ9IUTE610/6sGoq
	 DN6pAgttEFRaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCC3809A80;
	Thu,  7 Nov 2024 19:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: do not leave a dangling sk pointer in
 __smc_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173100843274.2072933.7772314537199195964.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 19:40:32 +0000
References: <20241106221922.1544045-1-edumazet@google.com>
In-Reply-To: <20241106221922.1544045-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, kuniyu@amazon.com,
 ignat@cloudflare.com, alibuda@linux.alibaba.com, wenjia@linux.ibm.com,
 dust.li@linux.alibaba.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Nov 2024 22:19:22 +0000 you wrote:
> Thanks to commit 4bbd360a5084 ("socket: Print pf->create() when
> it does not clear sock->sk on failure."), syzbot found an issue with AF_SMC:
> 
> smc_create must clear sock->sk on failure, family: 43, type: 1, protocol: 0
>  WARNING: CPU: 0 PID: 5827 at net/socket.c:1565 __sock_create+0x96f/0xa30 net/socket.c:1563
> Modules linked in:
> CPU: 0 UID: 0 PID: 5827 Comm: syz-executor259 Not tainted 6.12.0-rc6-next-20241106-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>  RIP: 0010:__sock_create+0x96f/0xa30 net/socket.c:1563
> Code: 03 00 74 08 4c 89 e7 e8 4f 3b 85 f8 49 8b 34 24 48 c7 c7 40 89 0c 8d 8b 54 24 04 8b 4c 24 0c 44 8b 44 24 08 e8 32 78 db f7 90 <0f> 0b 90 90 e9 d3 fd ff ff 89 e9 80 e1 07 fe c1 38 c1 0f 8c ee f7
> RSP: 0018:ffffc90003e4fda0 EFLAGS: 00010246
> RAX: 099c6f938c7f4700 RBX: 1ffffffff1a595fd RCX: ffff888034823c00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00000000ffffffe9 R08: ffffffff81567052 R09: 1ffff920007c9f50
> R10: dffffc0000000000 R11: fffff520007c9f51 R12: ffffffff8d2cafe8
> R13: 1ffffffff1a595fe R14: ffffffff9a789c40 R15: ffff8880764298c0
> FS:  000055557b518380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa62ff43225 CR3: 0000000031628000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   sock_create net/socket.c:1616 [inline]
>   __sys_socket_create net/socket.c:1653 [inline]
>   __sys_socket+0x150/0x3c0 net/socket.c:1700
>   __do_sys_socket net/socket.c:1714 [inline]
>   __se_sys_socket net/socket.c:1712 [inline]
> 
> [...]

Here is the summary with links:
  - [net] net/smc: do not leave a dangling sk pointer in __smc_create()
    https://git.kernel.org/netdev/net/c/d293958a8595

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



