Return-Path: <netdev+bounces-97756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0248CD075
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E1F1C21DD5
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46AE13FD6A;
	Thu, 23 May 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNiNoSJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1713CFAF
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460828; cv=none; b=YJzUrDZApyxQsYNnH2RExv7w+PKrT0YwqItieube5bBzcX7mOAOL9Ceumgysju14etcX5nl++0N5FzKz+o0p6w3xeCY6h2xmkj38zzF3+9fZoH43PSr1NlWG4wsOR0FkTmXonrKn6cw6GShvWxQO8xdonLDTNVhhgF1HaGo8Jeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460828; c=relaxed/simple;
	bh=1niubsiRMPPp9x1NGdg3+MgYXbDsKG/8qo1urWMaL0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GLNHGLw/BVVQFkM3chopAwLApos5WNg/QRXGzUGAKkEQQxCZvzmklkBPWX0LbRlna3XA/Wr0p8h2JNuSFC4lL966AAe0iK+wWUHTS/Hc8WBI46uwtJvU6dclrIVUY2pAi0PRQja2K/IKSdk2jqlROP+c8Pr8EE67PAMaQMpnl98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNiNoSJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53DF3C32782;
	Thu, 23 May 2024 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716460828;
	bh=1niubsiRMPPp9x1NGdg3+MgYXbDsKG/8qo1urWMaL0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hNiNoSJA08Qfk1kHB/G2jnAPa1eG04Ad5U3ZJSdaBPjxEmDOcAKh9F8Bx6wtn8Cn3
	 q7Iu/9zw/WmFEqJvdkyNL1HWewMqDgkGzmE+vWtAJ5ExdiN//uTzXukob8e1sY9fZO
	 fHcRB31x+BZJkkTmD2W8H4lHt4BM/iY/Uhd7g0J4PnWhIHt4Bfm0C8LF+EU0ZA8cdL
	 hca8Nt5UnoKX+owGv0m8jVY6PkVhGZm3YB27fxUjHkFRUFWAHXzQO63+Kf+kgp8RAP
	 7VGkN++tFBkVh0fMWiNHFc3ifWE29DodVhAEmyIUquFdZFTc9roXab8GglnNxge3I7
	 QSd1CxA9mMwFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DA59C54BB2;
	Thu, 23 May 2024 10:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: relax socket state check at accept time.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171646082824.30155.5215615405031483910.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 10:40:28 +0000
References: <23ab880a44d8cfd967e84de8b93dbf48848e3d8c.1716299669.git.pabeni@redhat.com>
In-Reply-To: <23ab880a44d8cfd967e84de8b93dbf48848e3d8c.1716299669.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, cpaasch@apple.com, ncardwell@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 May 2024 16:01:00 +0200 you wrote:
> Christoph reported the following splat:
> 
> WARNING: CPU: 1 PID: 772 at net/ipv4/af_inet.c:761 __inet_accept+0x1f4/0x4a0
> Modules linked in:
> CPU: 1 PID: 772 Comm: syz-executor510 Not tainted 6.9.0-rc7-g7da7119fe22b #56
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> RIP: 0010:__inet_accept+0x1f4/0x4a0 net/ipv4/af_inet.c:759
> Code: 04 38 84 c0 0f 85 87 00 00 00 41 c7 04 24 03 00 00 00 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ec b7 da fd <0f> 0b e9 7f fe ff ff e8 e0 b7 da fd 0f 0b e9 fe fe ff ff 89 d9 80
> RSP: 0018:ffffc90000c2fc58 EFLAGS: 00010293
> RAX: ffffffff836bdd14 RBX: 0000000000000000 RCX: ffff888104668000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffffffff836bdb89 R09: fffff52000185f64
> R10: dffffc0000000000 R11: fffff52000185f64 R12: dffffc0000000000
> R13: 1ffff92000185f98 R14: ffff88810754d880 R15: ffff8881007b7800
> FS:  000000001c772880(0000) GS:ffff88811b280000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb9fcf2e178 CR3: 00000001045d2002 CR4: 0000000000770ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  inet_accept+0x138/0x1d0 net/ipv4/af_inet.c:786
>  do_accept+0x435/0x620 net/socket.c:1929
>  __sys_accept4_file net/socket.c:1969 [inline]
>  __sys_accept4+0x9b/0x110 net/socket.c:1999
>  __do_sys_accept net/socket.c:2016 [inline]
>  __se_sys_accept net/socket.c:2013 [inline]
>  __x64_sys_accept+0x7d/0x90 net/socket.c:2013
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x58/0x100 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x4315f9
> Code: fd ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 ab b4 fd ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffdb26d9c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
> RAX: ffffffffffffffda RBX: 0000000000400300 RCX: 00000000004315f9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00000000006e1018 R08: 0000000000400300 R09: 0000000000400300
> R10: 0000000000400300 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000040cdf0 R14: 000000000040ce80 R15: 0000000000000055
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [v2,net] net: relax socket state check at accept time.
    https://git.kernel.org/netdev/net/c/26afda78cda3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



