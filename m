Return-Path: <netdev+bounces-32375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD3479730D
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 16:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322682815A2
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4726FC5;
	Thu,  7 Sep 2023 14:25:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F856AA5
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 14:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ABAC32791;
	Thu,  7 Sep 2023 14:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694096733;
	bh=BN3NbVn43GP20r6RDmsZkFZsr8HvQQc5bavEBtFBwWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+gPq5BEyeygHXpHpBAp21ubg/sX76oaIZNYZ5mGdNMyptu/HJQhuNmD4eleH1Ag0
	 rcfLUB0ju4yDxcdqVov/8iO6ubTlQUMvUFyMisNjMkSGq+6VBz+5iGM2SO40Ly3qOp
	 XMr5cqHAftBesSDW/l8eahMEjLewEJa781I4V6xeOQYDSq5+tQ20ekUsIIXH/DPdod
	 6OOlIgzD9cbX7ojUACl0RHXXd00cRrVs9O8akY1Rayg2UdmFj1/1L+DEc6M7AEOyd7
	 OWE/8jR0MxRNVl+i+Uwu8a90YJuX6s59S+cqSD090RKRZvyshAynr+Z5qoUEsPqjVp
	 H/H8Jv4fPLy5g==
Date: Thu, 7 Sep 2023 16:25:29 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH net] xfrm: interface: use DEV_STATS_INC()
Message-ID: <20230907142529.GA434333@kernel.org>
References: <20230905132303.1927206-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905132303.1927206-1-edumazet@google.com>

On Tue, Sep 05, 2023 at 01:23:03PM +0000, Eric Dumazet wrote:
> syzbot/KCSAN reported data-races in xfrm whenever dev->stats fields
> are updated.
> 
> It appears all of these updates can happen from multiple cpus.
> 
> Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.
> 
> BUG: KCSAN: data-race in xfrmi_xmit / xfrmi_xmit
> 
> read-write to 0xffff88813726b160 of 8 bytes by task 23986 on cpu 1:
> xfrmi_xmit+0x74e/0xb20 net/xfrm/xfrm_interface_core.c:583
> __netdev_start_xmit include/linux/netdevice.h:4889 [inline]
> netdev_start_xmit include/linux/netdevice.h:4903 [inline]
> xmit_one net/core/dev.c:3544 [inline]
> dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3560
> __dev_queue_xmit+0xeee/0x1de0 net/core/dev.c:4340
> dev_queue_xmit include/linux/netdevice.h:3082 [inline]
> neigh_connected_output+0x231/0x2a0 net/core/neighbour.c:1581
> neigh_output include/net/neighbour.h:542 [inline]
> ip_finish_output2+0x74a/0x850 net/ipv4/ip_output.c:230
> ip_finish_output+0xf4/0x240 net/ipv4/ip_output.c:318
> NF_HOOK_COND include/linux/netfilter.h:293 [inline]
> ip_output+0xe5/0x1b0 net/ipv4/ip_output.c:432
> dst_output include/net/dst.h:458 [inline]
> ip_local_out net/ipv4/ip_output.c:127 [inline]
> ip_send_skb+0x72/0xe0 net/ipv4/ip_output.c:1487
> udp_send_skb+0x6a4/0x990 net/ipv4/udp.c:963
> udp_sendmsg+0x1249/0x12d0 net/ipv4/udp.c:1246
> inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:840
> sock_sendmsg_nosec net/socket.c:730 [inline]
> sock_sendmsg net/socket.c:753 [inline]
> ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2540
> ___sys_sendmsg net/socket.c:2594 [inline]
> __sys_sendmmsg+0x269/0x500 net/socket.c:2680
> __do_sys_sendmmsg net/socket.c:2709 [inline]
> __se_sys_sendmmsg net/socket.c:2706 [inline]
> __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2706
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> read-write to 0xffff88813726b160 of 8 bytes by task 23987 on cpu 0:
> xfrmi_xmit+0x74e/0xb20 net/xfrm/xfrm_interface_core.c:583
> __netdev_start_xmit include/linux/netdevice.h:4889 [inline]
> netdev_start_xmit include/linux/netdevice.h:4903 [inline]
> xmit_one net/core/dev.c:3544 [inline]
> dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3560
> __dev_queue_xmit+0xeee/0x1de0 net/core/dev.c:4340
> dev_queue_xmit include/linux/netdevice.h:3082 [inline]
> neigh_connected_output+0x231/0x2a0 net/core/neighbour.c:1581
> neigh_output include/net/neighbour.h:542 [inline]
> ip_finish_output2+0x74a/0x850 net/ipv4/ip_output.c:230
> ip_finish_output+0xf4/0x240 net/ipv4/ip_output.c:318
> NF_HOOK_COND include/linux/netfilter.h:293 [inline]
> ip_output+0xe5/0x1b0 net/ipv4/ip_output.c:432
> dst_output include/net/dst.h:458 [inline]
> ip_local_out net/ipv4/ip_output.c:127 [inline]
> ip_send_skb+0x72/0xe0 net/ipv4/ip_output.c:1487
> udp_send_skb+0x6a4/0x990 net/ipv4/udp.c:963
> udp_sendmsg+0x1249/0x12d0 net/ipv4/udp.c:1246
> inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:840
> sock_sendmsg_nosec net/socket.c:730 [inline]
> sock_sendmsg net/socket.c:753 [inline]
> ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2540
> ___sys_sendmsg net/socket.c:2594 [inline]
> __sys_sendmmsg+0x269/0x500 net/socket.c:2680
> __do_sys_sendmmsg net/socket.c:2709 [inline]
> __se_sys_sendmmsg net/socket.c:2706 [inline]
> __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2706
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> value changed: 0x00000000000010d7 -> 0x00000000000010d8
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 23987 Comm: syz-executor.5 Not tainted 6.5.0-syzkaller-10885-g0468be89b3fa #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> 
> Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>

Reviewed-by: Simon Horman <horms@kernel.org>


