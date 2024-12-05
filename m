Return-Path: <netdev+bounces-149222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5897D9E4CAA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195F7284261
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA1719066E;
	Thu,  5 Dec 2024 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh/bb6Kz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A031190052
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369420; cv=none; b=kwPzfkjZKPY7xbCdwnhBNRlo/GaiUmEbXQ/ClQKVfShn6GXlAfJVj1f34jLkeOCK9dkjgcLAWorau63ImunMUqv+MMWhC1E0LBDscp32mupFB/kIbKyZXmwlWCyEi/frJ9+beQ2/RrGMkeZuX5QO6dfRduSVY4fclBmw2V2wb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369420; c=relaxed/simple;
	bh=PqUyrA3MA1Q02qeZ1/cff0u6VNIxy+4Ab5QFK4pwnS0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FdfaBFrFwn2jaCnuj6Nc8l/TcyTb3R0wCeEQcee4s1f0UrG/uH4L9+JkqRlUebqrvr/kygTkevo0/XjYu9DsF3qUKdYU+SpVd7kkUG/JrOpw2BHHnUOE5a3FnvCtDbO8rOkKh10dnxwce/GHBMPwcLB+vq7Q6t0vn6HH3mO6GeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh/bb6Kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC326C4CEDC;
	Thu,  5 Dec 2024 03:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733369418;
	bh=PqUyrA3MA1Q02qeZ1/cff0u6VNIxy+4Ab5QFK4pwnS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gh/bb6KzybtEsbT0mzQ+f3Gq6ydmv8eeM+Dro2yCfpjT9resHJhIToAE9QIH1+DEH
	 SJkacNroQ35F3g7H2YPHy1UYyeKI3d1mbypet+NGeXqEOd7DSCC6rgBHMtivfSx/uO
	 K8lXmFkgsD8CUaJ73t3O6j6JGqRjbCY6PXAajjKapAHRfUxT7PpuQQ/KpGvMz7BjKj
	 S39DZn8dbgJ5vxtTrxH7KAKBzr6GYYD+avAHiJEGSUIIJZYih/TGLt0b5C6Hl7UnTp
	 yKmgHKwHQNKUptab5PrK/z2+R/rj2VGasAADYW5BJlFDGKdnT2DrnRm3wnyIfkaffX
	 P9v/H87dJKU+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEFE380A94C;
	Thu,  5 Dec 2024 03:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] geneve: do not assume mac header is set in
 geneve_xmit_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173336943349.1431012.13367502657744524334.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:30:33 +0000
References: <20241203182122.2725517-1-edumazet@google.com>
In-Reply-To: <20241203182122.2725517-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+3ec5271486d7cb2d242a@syzkaller.appspotmail.com, sbrivio@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Dec 2024 18:21:21 +0000 you wrote:
> We should not assume mac header is set in output path.
> 
> Use skb_eth_hdr() instead of eth_hdr() to fix the issue.
> 
> sysbot reported the following :
> 
>  WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 skb_mac_header include/linux/skbuff.h:3052 [inline]
>  WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 eth_hdr include/linux/if_ether.h:24 [inline]
>  WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 geneve_xmit_skb drivers/net/geneve.c:898 [inline]
>  WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 geneve_xmit+0x4c38/0x5730 drivers/net/geneve.c:1039
> Modules linked in:
> CPU: 0 UID: 0 PID: 11635 Comm: syz.4.1423 Not tainted 6.12.0-syzkaller-10296-gaaf20f870da0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>  RIP: 0010:skb_mac_header include/linux/skbuff.h:3052 [inline]
>  RIP: 0010:eth_hdr include/linux/if_ether.h:24 [inline]
>  RIP: 0010:geneve_xmit_skb drivers/net/geneve.c:898 [inline]
>  RIP: 0010:geneve_xmit+0x4c38/0x5730 drivers/net/geneve.c:1039
> Code: 21 c6 02 e9 35 d4 ff ff e8 a5 48 4c fb 90 0f 0b 90 e9 fd f5 ff ff e8 97 48 4c fb 90 0f 0b 90 e9 d8 f5 ff ff e8 89 48 4c fb 90 <0f> 0b 90 e9 41 e4 ff ff e8 7b 48 4c fb 90 0f 0b 90 e9 cd e7 ff ff
> RSP: 0018:ffffc90003b2f870 EFLAGS: 00010283
> RAX: 000000000000037a RBX: 000000000000ffff RCX: ffffc9000dc3d000
> RDX: 0000000000080000 RSI: ffffffff86428417 RDI: 0000000000000003
> RBP: ffffc90003b2f9f0 R08: 0000000000000003 R09: 000000000000ffff
> R10: 000000000000ffff R11: 0000000000000002 R12: ffff88806603c000
> R13: 0000000000000000 R14: ffff8880685b2780 R15: 0000000000000e23
> FS:  00007fdc2deed6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b30a1dff8 CR3: 0000000056b8c000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
>   netdev_start_xmit include/linux/netdevice.h:5011 [inline]
>   __dev_direct_xmit+0x58a/0x720 net/core/dev.c:4490
>   dev_direct_xmit include/linux/netdevice.h:3181 [inline]
>   packet_xmit+0x1e4/0x360 net/packet/af_packet.c:285
>   packet_snd net/packet/af_packet.c:3146 [inline]
>   packet_sendmsg+0x2700/0x5660 net/packet/af_packet.c:3178
>   sock_sendmsg_nosec net/socket.c:711 [inline]
>   __sock_sendmsg net/socket.c:726 [inline]
>   __sys_sendto+0x488/0x4f0 net/socket.c:2197
>   __do_sys_sendto net/socket.c:2204 [inline]
>   __se_sys_sendto net/socket.c:2200 [inline]
>   __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] geneve: do not assume mac header is set in geneve_xmit_skb()
    https://git.kernel.org/netdev/net/c/8588c99c7d47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



