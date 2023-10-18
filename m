Return-Path: <netdev+bounces-42083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA167CD187
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DE81F22D9C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9853264A;
	Wed, 18 Oct 2023 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCghe7l0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F292A23
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C09E2C433C7;
	Wed, 18 Oct 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697590823;
	bh=kskSWQ0w9cYtScqhxqydNcVja1H1vMTC0Q0GkklpthU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CCghe7l0JnNZjPG/cQK3TNabVIbl+qezrOPpijyIJDfvlo88z98KxzSpFxj9p+ajs
	 7KatCnGYsjYH2FnTuZLy7kIp5oZWb4P+plM7eS0C50w7OShTcR3zbgN+zr6SsnNGd5
	 wsuisCju805NE2noOKNXYWQtbqjO7HzB70dbyTxVHK0JGRO5+SzQXj0jT30J+XbyO7
	 CvuUqwFF1rktmRiHsMeiRdr+CPcxepTCHay3ICyRxJNqos31qO94I8fM54qTNVpsfv
	 j2NAVCv6WNplvF5kUcwE3TExrJRTPms/rc/OvxJ5KWL/7GSXxMfg9gzLGQZovnWc7D
	 IcsVT758kckBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6FBBC04E24;
	Wed, 18 Oct 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tun: prevent negative ifindex
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169759082367.18882.16867622987042544165.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 01:00:23 +0000
References: <20231016180851.3560092-1-edumazet@google.com>
In-Reply-To: <20231016180851.3560092-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Oct 2023 18:08:51 +0000 you wrote:
> After commit 956db0a13b47 ("net: warn about attempts to register
> negative ifindex") syzbot is able to trigger the following splat.
> 
> Negative ifindex are not supported.
> 
> WARNING: CPU: 1 PID: 6003 at net/core/dev.c:9596 dev_index_reserve+0x104/0x210
> Modules linked in:
> CPU: 1 PID: 6003 Comm: syz-executor926 Not tainted 6.6.0-rc4-syzkaller-g19af4a4ed414 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : dev_index_reserve+0x104/0x210
> lr : dev_index_reserve+0x100/0x210
> sp : ffff800096a878e0
> x29: ffff800096a87930 x28: ffff0000d04380d0 x27: ffff0000d04380f8
> x26: ffff0000d04380f0 x25: 1ffff00012d50f20 x24: 1ffff00012d50f1c
> x23: dfff800000000000 x22: ffff8000929c21c0 x21: 00000000ffffffea
> x20: ffff0000d04380e0 x19: ffff800096a87900 x18: ffff800096a874c0
> x17: ffff800084df5008 x16: ffff80008051f9c4 x15: 0000000000000001
> x14: 1fffe0001a087198 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> x8 : ffff0000d41c9bc0 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : ffff800091763d88 x4 : 0000000000000000 x3 : ffff800084e04748
> x2 : 0000000000000001 x1 : 00000000fead71c7 x0 : 0000000000000000
> Call trace:
> dev_index_reserve+0x104/0x210
> register_netdevice+0x598/0x1074 net/core/dev.c:10084
> tun_set_iff+0x630/0xb0c drivers/net/tun.c:2850
> __tun_chr_ioctl+0x788/0x2af8 drivers/net/tun.c:3118
> tun_chr_ioctl+0x38/0x4c drivers/net/tun.c:3403
> vfs_ioctl fs/ioctl.c:51 [inline]
> __do_sys_ioctl fs/ioctl.c:871 [inline]
> __se_sys_ioctl fs/ioctl.c:857 [inline]
> __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
> __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
> invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
> el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
> do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
> el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
> el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
> el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
> irq event stamp: 11348
> hardirqs last enabled at (11347): [<ffff80008a716574>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> hardirqs last enabled at (11347): [<ffff80008a716574>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
> hardirqs last disabled at (11348): [<ffff80008a627820>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
> softirqs last enabled at (11138): [<ffff8000887ca53c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
> softirqs last enabled at (11138): [<ffff8000887ca53c>] release_sock+0x15c/0x1b0 net/core/sock.c:3531
> softirqs last disabled at (11136): [<ffff8000887ca41c>] spin_lock_bh include/linux/spinlock.h:356 [inline]
> softirqs last disabled at (11136): [<ffff8000887ca41c>] release_sock+0x3c/0x1b0 net/core/sock.c:3518
> 
> [...]

Here is the summary with links:
  - [net] tun: prevent negative ifindex
    https://git.kernel.org/netdev/net/c/cbfbfe3aee71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



