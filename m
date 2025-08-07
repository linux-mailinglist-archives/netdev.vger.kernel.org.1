Return-Path: <netdev+bounces-212065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD1AB1DA64
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 16:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0183B9F10
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD51C862E;
	Thu,  7 Aug 2025 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGuZ0+Rv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39BA1C860A
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578196; cv=none; b=aydxFjqtUwZTyY2lLd2t3i3X3/6TfiOubqwWjiNaCmBXzWxJj7uiSgwOyjL7fWazZQe0rcCj84Yu4Y74ub8IJndHQB0lAn48nGKQ6UKbtImADKMEZ2FrdjGjn7Tl0PrQUKoJxp2LkyIxzIHyJc/84NaKKjFrHPE7l9EbfZBW4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578196; c=relaxed/simple;
	bh=awQdJrYXAecGnr4quehGzWBp4FkLUytRfbJIVDbGXKU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oxUGjG5OG8FXOSYJwG7DIivBZ2D3RLy8yltt7BfscRNPB8dMttRwCFTEALtDNWhQ5gT8co9N3SrSraCwLYCJO4Vw9e+cNanDZnOEEByqu/aRPqWm8v0YnJ8fuSdSewI7JZL77zvCrre+r/gComKKCLgp2QiAHJ0PQlhK+x9A7HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGuZ0+Rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E083C4CEEB;
	Thu,  7 Aug 2025 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754578194;
	bh=awQdJrYXAecGnr4quehGzWBp4FkLUytRfbJIVDbGXKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sGuZ0+RvIYRbCAYuz/Z0ZlIeI4JNFUIotPuUVWCSjvCNgCS8D9XAMiCt0gFnBRes9
	 fyJsRPCBzQond2BaCqIdVEmKkB7OQRv0oEK2IOMQq4kRnHzeD5M37VDiKoB2/VdUid
	 oXfxX17tL4hoHVhgTfqJs5hLbUEUzuyS8pvRTJ/YC0EMr2VDjrlJBcQB8nkujG/Vcu
	 n42REexs5x2ZW6ZzeFp/JUY5sAqGRj1GcDNyN7A6Gnk3rzHaBrnvjAJdDQMoINrTh9
	 hmPZpx9NnYAT2kjPdgijnwfOw8OJCfxL++gYibQZXtG6ulqpwzNxw6sMoMIjgILQqm
	 8QKwO/pBY4e4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E3E383BF4E;
	Thu,  7 Aug 2025 14:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pptp: fix pptp_xmit() error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175457820772.3587247.13197311955004551563.git-patchwork-notify@kernel.org>
Date: Thu, 07 Aug 2025 14:50:07 +0000
References: <20250807142146.2877060-1-edumazet@google.com>
In-Reply-To: <20250807142146.2877060-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Aug 2025 14:21:46 +0000 you wrote:
> I accidentally added a bug in pptp_xmit() that syzbot caught for us.
> 
> Only call ip_rt_put() if a route has been allocated.
> 
> BUG: unable to handle page fault for address: ffffffffffffffdb
> PGD df3b067 P4D df3b067 PUD df3d067 PMD 0
> Oops: Oops: 0002 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 6346 Comm: syz.0.336 Not tainted 6.16.0-next-20250804-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> RIP: 0010:arch_atomic_add_return arch/x86/include/asm/atomic.h:85 [inline]
> RIP: 0010:raw_atomic_sub_return_release include/linux/atomic/atomic-arch-fallback.h:846 [inline]
> RIP: 0010:atomic_sub_return_release include/linux/atomic/atomic-instrumented.h:327 [inline]
> RIP: 0010:__rcuref_put include/linux/rcuref.h:109 [inline]
> RIP: 0010:rcuref_put+0x172/0x210 include/linux/rcuref.h:173
> Call Trace:
>  <TASK>
>  dst_release+0x24/0x1b0 net/core/dst.c:167
>  ip_rt_put include/net/route.h:285 [inline]
>  pptp_xmit+0x14b/0x1a90 drivers/net/ppp/pptp.c:267
>  __ppp_channel_push+0xf2/0x1c0 drivers/net/ppp/ppp_generic.c:2166
>  ppp_channel_push+0x123/0x660 drivers/net/ppp/ppp_generic.c:2198
>  ppp_write+0x2b0/0x400 drivers/net/ppp/ppp_generic.c:544
>  vfs_write+0x27b/0xb30 fs/read_write.c:684
>  ksys_write+0x145/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] pptp: fix pptp_xmit() error path
    https://git.kernel.org/netdev/net/c/ae633388cae3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



