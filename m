Return-Path: <netdev+bounces-32778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FEC79A6B0
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 11:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3154F1C2099C
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB79BE6F;
	Mon, 11 Sep 2023 09:25:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82543BE69
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21F2BC433C8;
	Mon, 11 Sep 2023 09:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694424342;
	bh=jn31EoKWEo59zO1EDlkeGq15ibT4j3P8VBec7ahX66I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gGCqhLihKurpiGK/iqWkUrkrxa0PWdjg86TTZ5RDA7FGmNnkXR3kn/OR3RzMB8mKo
	 PgkGaHcVDV5Pjc/s1Qj+W9nBImXo4yq/wI1jkcubb/Xz22FC11z/2XLBqoRTOuSYK3
	 eOpuNlCpD16bZNBAQB4JTgzn3YEd8Ljr7SBTPhoVAn6FPHNXtMBSkldssS3rvtP02s
	 LSHcjRgPRn8EwIjf61wxW3Qu5o0o8FKZmUoBhaDo+JK1snmLg1IkE1o8vef5sdXkms
	 aPZneSQ4UGTwL8dps6e8woAqGfOD2AUf+Io9EqOPlzCyCOT0tb1TVKmD7orML6tavq
	 OA81i3LbSFH+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D774C00446;
	Mon, 11 Sep 2023 09:25:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] kcm: Fix memory leak in error path of kcm_sendmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169442434205.22330.369402814617105597.git-patchwork-notify@kernel.org>
Date: Mon, 11 Sep 2023 09:25:42 +0000
References: <20230909170310.1978851-1-syoshida@redhat.com>
In-Reply-To: <20230909170310.1978851-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 10 Sep 2023 02:03:10 +0900 you wrote:
> syzbot reported a memory leak like below:
> 
> BUG: memory leak
> unreferenced object 0xffff88810b088c00 (size 240):
>   comm "syz-executor186", pid 5012, jiffies 4294943306 (age 13.680s)
>   hex dump (first 32 bytes):
>     00 89 08 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff83e5d5ff>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:634
>     [<ffffffff84606e59>] alloc_skb include/linux/skbuff.h:1289 [inline]
>     [<ffffffff84606e59>] kcm_sendmsg+0x269/0x1050 net/kcm/kcmsock.c:815
>     [<ffffffff83e479c6>] sock_sendmsg_nosec net/socket.c:725 [inline]
>     [<ffffffff83e479c6>] sock_sendmsg+0x56/0xb0 net/socket.c:748
>     [<ffffffff83e47f55>] ____sys_sendmsg+0x365/0x470 net/socket.c:2494
>     [<ffffffff83e4c389>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2548
>     [<ffffffff83e4c536>] __sys_sendmsg+0xa6/0x120 net/socket.c:2577
>     [<ffffffff84ad7bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84ad7bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [net,v2] kcm: Fix memory leak in error path of kcm_sendmsg()
    https://git.kernel.org/netdev/net/c/c821a88bd720

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



