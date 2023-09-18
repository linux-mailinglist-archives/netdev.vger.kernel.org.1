Return-Path: <netdev+bounces-34389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EED7A40F5
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9117928155E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 06:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F01953BD;
	Mon, 18 Sep 2023 06:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD2525B
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 06:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B6C2C433C9;
	Mon, 18 Sep 2023 06:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695018022;
	bh=PdRKME1QOWhIdYK1iz91RBb1RJwsI+x9uuQAHa14t7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fn+H9+VE5yWk3jIiml/9nmTldUyRsBbgWmnLO90GnGPARNhFHy7BBhfVw87r+dEUf
	 B18Zk/V5T4c+RK6Kud/KpStsSU26ZaApKna1GULwfiTdSvQr5XSScyyjbQ8cwCgjjU
	 SdI1BrlJxS72+XJE0Oknu2rHcLN1w9VlrnYpLOtyG1H+D3F2arYQ0+mJ54HnXZ8Ug+
	 23K3wnCErI9nYfpAas9YLlk2t3DknWB+qPmiQk8zWq+0NpmRx+opRWHxK/FwMqsrzj
	 +YsvIlg+dLsTawu/vgiFoqPIk+QoHG+LXRX6X4yS2EG626hbRjovMDrplu12dL9upJ
	 pDBu694mwHb7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60A31E11F40;
	Mon, 18 Sep 2023 06:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] dccp: fix dccp_v4_err()/dccp_v6_err() again
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169501802239.15865.14994267231326012591.git-patchwork-notify@kernel.org>
Date: Mon, 18 Sep 2023 06:20:22 +0000
References: <20230915190035.4083297-1-edumazet@google.com>
In-Reply-To: <20230915190035.4083297-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 jannh@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 19:00:35 +0000 you wrote:
> dh->dccph_x is the 9th byte (offset 8) in "struct dccp_hdr",
> not in the "byte 7" as Jann claimed.
> 
> We need to make sure the ICMP messages are big enough,
> using more standard ways (no more assumptions).
> 
> syzbot reported:
> BUG: KMSAN: uninit-value in pskb_may_pull_reason include/linux/skbuff.h:2667 [inline]
> BUG: KMSAN: uninit-value in pskb_may_pull include/linux/skbuff.h:2681 [inline]
> BUG: KMSAN: uninit-value in dccp_v6_err+0x426/0x1aa0 net/dccp/ipv6.c:94
> pskb_may_pull_reason include/linux/skbuff.h:2667 [inline]
> pskb_may_pull include/linux/skbuff.h:2681 [inline]
> dccp_v6_err+0x426/0x1aa0 net/dccp/ipv6.c:94
> icmpv6_notify+0x4c7/0x880 net/ipv6/icmp.c:867
> icmpv6_rcv+0x19d5/0x30d0
> ip6_protocol_deliver_rcu+0xda6/0x2a60 net/ipv6/ip6_input.c:438
> ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
> NF_HOOK include/linux/netfilter.h:304 [inline]
> ip6_input+0x15d/0x430 net/ipv6/ip6_input.c:492
> ip6_mc_input+0xa7e/0xc80 net/ipv6/ip6_input.c:586
> dst_input include/net/dst.h:468 [inline]
> ip6_rcv_finish+0x5db/0x870 net/ipv6/ip6_input.c:79
> NF_HOOK include/linux/netfilter.h:304 [inline]
> ipv6_rcv+0xda/0x390 net/ipv6/ip6_input.c:310
> __netif_receive_skb_one_core net/core/dev.c:5523 [inline]
> __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5637
> netif_receive_skb_internal net/core/dev.c:5723 [inline]
> netif_receive_skb+0x58/0x660 net/core/dev.c:5782
> tun_rx_batched+0x83b/0x920
> tun_get_user+0x564c/0x6940 drivers/net/tun.c:2002
> tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
> call_write_iter include/linux/fs.h:1985 [inline]
> new_sync_write fs/read_write.c:491 [inline]
> vfs_write+0x8ef/0x15c0 fs/read_write.c:584
> ksys_write+0x20f/0x4c0 fs/read_write.c:637
> __do_sys_write fs/read_write.c:649 [inline]
> __se_sys_write fs/read_write.c:646 [inline]
> __x64_sys_write+0x93/0xd0 fs/read_write.c:646
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [v2,net] dccp: fix dccp_v4_err()/dccp_v6_err() again
    https://git.kernel.org/netdev/net/c/6af289746a63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



