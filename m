Return-Path: <netdev+bounces-143866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7651D9C49CF
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 00:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CD81F225AA
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 23:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AB01AE014;
	Mon, 11 Nov 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6xpfNgp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4801A76B5;
	Mon, 11 Nov 2024 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368420; cv=none; b=J89BI+JIsC+EiTAzHKwS42tp0kRdiCLX+Kun7oet5PhZQGCFfEKVYp3AnQxUNYDohkKmelhkRioqD6uqVWMZ2rWodlMSVPUNmfWnr2tuUo9Dp8PCwNVzTpv0PekiyhjgTlAq8xH5a+tedaL2GutZ3Bxp1mOdfyFSS2KE3WE/5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368420; c=relaxed/simple;
	bh=JWfY8vRiaeGiZyo8ym4Cw687a+ggxiOYz9I4JEIqKEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XDa23JaL/34YnrpRiMMbkEk/bPAIbn301tyUZDuJOOoexl2x5AyFsj2Nb6Bx47/wIMQu8G9A3HMySgFFQSDN6MFPk0rTFM7WiNwjzqiH8/2Q9qDUOygwkJ5sH57foxLerrREm/5aRV7ByoScH7iSa2I2aUBXuhItij3R4VfWKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6xpfNgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBBDC4CECF;
	Mon, 11 Nov 2024 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731368418;
	bh=JWfY8vRiaeGiZyo8ym4Cw687a+ggxiOYz9I4JEIqKEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R6xpfNgpEFl5mLSRBtEL2KzLbmyDf95vC3evgiHpWgy58OOQ7Ey7yyWu/BrAdcjNk
	 MZHXltvIpodO061AwJCwcTGvAgjp1jxVd6gyoJI6jVRUWZAXbJ6DI8Amtp2+/7ZbSZ
	 AVM5bvzEOiOu0pL//KSGEHpHOCRmfq9acnBaV9VdJzVg8qLiQkKy/Z2dOacjzMlKTk
	 qt15K5YmDnYKQiAK8K+xlfO4y8EYYzlVB7K0vHpHuePdCZa9dVKuNdv8GvqlU5lT3/
	 WRF4BsloPHql4FelXzIRjVb7CuYWwCHNrdMtJUyj7YyMzfmyq/s9rxQtl62thKQQvi
	 kopSTxBsKmysA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF93809A80;
	Mon, 11 Nov 2024 23:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix data-races around sk->sk_forward_alloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173136842901.12816.12710817241689086556.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 23:40:29 +0000
References: <20241107023405.889239-1-wangliang74@huawei.com>
In-Reply-To: <20241107023405.889239-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 luoxuanqiang@kylinos.cn, kernelxing@tencent.com, kirjanov@gmail.com,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 Nov 2024 10:34:05 +0800 you wrote:
> Syzkaller reported this warning:
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1c5/0x1e0
>  Modules linked in:
>  CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc5 #26
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>  RIP: 0010:inet_sock_destruct+0x1c5/0x1e0
>  Code: 24 12 4c 89 e2 5b 48 c7 c7 98 ec bb 82 41 5c e9 d1 18 17 ff 4c 89 e6 5b 48 c7 c7 d0 ec bb 82 41 5c e9 bf 18 17 ff 0f 0b eb 83 <0f> 0b eb 97 0f 0b eb 87 0f 0b e9 68 ff ff ff 66 66 2e 0f 1f 84 00
>  RSP: 0018:ffffc9000008bd90 EFLAGS: 00010206
>  RAX: 0000000000000300 RBX: ffff88810b172a90 RCX: 0000000000000007
>  RDX: 0000000000000002 RSI: 0000000000000300 RDI: ffff88810b172a00
>  RBP: ffff88810b172a00 R08: ffff888104273c00 R09: 0000000000100007
>  R10: 0000000000020000 R11: 0000000000000006 R12: ffff88810b172a00
>  R13: 0000000000000004 R14: 0000000000000000 R15: ffff888237c31f78
>  FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007ffc63fecac8 CR3: 000000000342e000 CR4: 00000000000006f0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? __warn+0x88/0x130
>   ? inet_sock_destruct+0x1c5/0x1e0
>   ? report_bug+0x18e/0x1a0
>   ? handle_bug+0x53/0x90
>   ? exc_invalid_op+0x18/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? inet_sock_destruct+0x1c5/0x1e0
>   __sk_destruct+0x2a/0x200
>   rcu_do_batch+0x1aa/0x530
>   ? rcu_do_batch+0x13b/0x530
>   rcu_core+0x159/0x2f0
>   handle_softirqs+0xd3/0x2b0
>   ? __pfx_smpboot_thread_fn+0x10/0x10
>   run_ksoftirqd+0x25/0x30
>   smpboot_thread_fn+0xdd/0x1d0
>   kthread+0xd3/0x100
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x34/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
> [...]

Here is the summary with links:
  - [net] net: fix data-races around sk->sk_forward_alloc
    https://git.kernel.org/netdev/net/c/073d89808c06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



