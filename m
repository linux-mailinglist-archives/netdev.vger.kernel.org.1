Return-Path: <netdev+bounces-62227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0368264B8
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 16:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 999DAB213B3
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37BE134D5;
	Sun,  7 Jan 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvpnBwmO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8F134BA
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 15:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ADBAC433C9;
	Sun,  7 Jan 2024 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704641424;
	bh=DgJN5ZCSY+8Z49nYLK4xQB4Yk/frwF53i40DqSOqygc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LvpnBwmOpy1ZmexCiOLjfBuEj0cqePUKB3DVEUbL5qqzO9sowIyzvUK4vPlQO/bfL
	 Cd2LXSfYKQ26sexMBCH+duwMtb8B3jtYvYv9z1wKdzqRDzCTcxGdLbPQ0X4mBOvlpt
	 C890RXZcxIvbjFoPac2WFtSSb3aYGn1m9YNQ9PjCYYYBajBY9CTU4HMOzKQhOv/Ixp
	 DhLI+audng1UziZLwhNYMolFpr3QZsvSE+xYV7/5+HMJPQfOPUHoNCWotg1iuv3aId
	 ng5BMK1m6nOXxpK6XC9aHFPuCB9ZRTkt9txCWsuGagVmHHg9Hco1UxUL4aixJRLR0g
	 fMgLvv4eRLCqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D664C4167E;
	Sun,  7 Jan 2024 15:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip6_tunnel: fix NEXTHDR_FRAGMENT handling in
 ip6_tnl_parse_tlv_enc_lim()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170464142411.16555.11084596873526088210.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 15:30:24 +0000
References: <20240105170313.2946078-1-edumazet@google.com>
In-Reply-To: <20240105170313.2946078-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Jan 2024 17:03:13 +0000 you wrote:
> syzbot pointed out [1] that NEXTHDR_FRAGMENT handling is broken.
> 
> Reading frag_off can only be done if we pulled enough bytes
> to skb->head. Currently we might access garbage.
> 
> [1]
> BUG: KMSAN: uninit-value in ip6_tnl_parse_tlv_enc_lim+0x94f/0xbb0
> ip6_tnl_parse_tlv_enc_lim+0x94f/0xbb0
> ipxip6_tnl_xmit net/ipv6/ip6_tunnel.c:1326 [inline]
> ip6_tnl_start_xmit+0xab2/0x1a70 net/ipv6/ip6_tunnel.c:1432
> __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
> netdev_start_xmit include/linux/netdevice.h:4954 [inline]
> xmit_one net/core/dev.c:3548 [inline]
> dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3564
> __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4349
> dev_queue_xmit include/linux/netdevice.h:3134 [inline]
> neigh_connected_output+0x569/0x660 net/core/neighbour.c:1592
> neigh_output include/net/neighbour.h:542 [inline]
> ip6_finish_output2+0x23a9/0x2b30 net/ipv6/ip6_output.c:137
> ip6_finish_output+0x855/0x12b0 net/ipv6/ip6_output.c:222
> NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> ip6_output+0x323/0x610 net/ipv6/ip6_output.c:243
> dst_output include/net/dst.h:451 [inline]
> ip6_local_out+0xe9/0x140 net/ipv6/output_core.c:155
> ip6_send_skb net/ipv6/ip6_output.c:1952 [inline]
> ip6_push_pending_frames+0x1f9/0x560 net/ipv6/ip6_output.c:1972
> rawv6_push_pending_frames+0xbe8/0xdf0 net/ipv6/raw.c:582
> rawv6_sendmsg+0x2b66/0x2e70 net/ipv6/raw.c:920
> inet_sendmsg+0x105/0x190 net/ipv4/af_inet.c:847
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg net/socket.c:745 [inline]
> ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
> ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
> __sys_sendmsg net/socket.c:2667 [inline]
> __do_sys_sendmsg net/socket.c:2676 [inline]
> __se_sys_sendmsg net/socket.c:2674 [inline]
> __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> [...]

Here is the summary with links:
  - [net] ip6_tunnel: fix NEXTHDR_FRAGMENT handling in ip6_tnl_parse_tlv_enc_lim()
    https://git.kernel.org/netdev/net/c/d375b98e0248

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



