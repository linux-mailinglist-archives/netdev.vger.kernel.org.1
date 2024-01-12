Return-Path: <netdev+bounces-63358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 790C382C5F2
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 20:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336091F22D76
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 19:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185B716436;
	Fri, 12 Jan 2024 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz0zeDe1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346416435
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 19:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40525C43390;
	Fri, 12 Jan 2024 19:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705088230;
	bh=Itutr3LhC5MduXhp/dTECrpdJnRsL+y4kON4NeynOsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iz0zeDe1DipDuSnfBEAQ2iMHMsQUduhtfxhJLcPVIgfTevpXtR9i9JODa9TJ2nJRs
	 iihTkZBqAyN8lw0XST4Pzdg7WQE5UtrhtPstTRGCyYAU1H0bNWPTMKsiqhMjDg8bM8
	 ToSvx1dD0TWZk95ymmKlm5nGCRVwvHoL1BJpOd0se5nOBmpwBqPGEwQ6R5v28P7/2s
	 jdJiFoOebU+Xs1KCE2zI65jSyyGIPKuOBJe9HUtBx3SIBaH7fslMoBStCOd2FH6W56
	 yS+aDCc9X19ID2fMUU7ZctKAKQM875t2rk7L65vboRbou6ny/aVd/VbDGtiQrmd62y
	 bfg1Bfic5nLBQ==
Date: Fri, 12 Jan 2024 19:37:05 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang.tang@linux.dev>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>,
	Peter Krystad <peter.krystad@linux.intel.com>
Subject: Re: [PATCH net 4/5] mptcp: use OPTION_MPTCP_MPJ_SYN in
 subflow_check_req()
Message-ID: <20240112193705.GF392144@kernel.org>
References: <20240111194917.4044654-1-edumazet@google.com>
 <20240111194917.4044654-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111194917.4044654-5-edumazet@google.com>

On Thu, Jan 11, 2024 at 07:49:16PM +0000, Eric Dumazet wrote:
> syzbot reported that subflow_check_req() was using uninitialized data in
> subflow_check_req() [1]
> 
> This is because mp_opt.token is only set when OPTION_MPTCP_MPJ_SYN is also set.
> 
> While we are are it, fix mptcp_subflow_init_cookie_req()
> to test for OPTION_MPTCP_MPJ_ACK.
> 
> [1]
> 
> BUG: KMSAN: uninit-value in subflow_token_join_request net/mptcp/subflow.c:91 [inline]
>  BUG: KMSAN: uninit-value in subflow_check_req+0x1028/0x15d0 net/mptcp/subflow.c:209
>   subflow_token_join_request net/mptcp/subflow.c:91 [inline]
>   subflow_check_req+0x1028/0x15d0 net/mptcp/subflow.c:209
>   subflow_v6_route_req+0x269/0x410 net/mptcp/subflow.c:367
>   tcp_conn_request+0x153a/0x4240 net/ipv4/tcp_input.c:7164
>  subflow_v6_conn_request+0x3ee/0x510
>   tcp_rcv_state_process+0x2e1/0x4ac0 net/ipv4/tcp_input.c:6659
>   tcp_v6_do_rcv+0x11bf/0x1fe0 net/ipv6/tcp_ipv6.c:1669
>   tcp_v6_rcv+0x480b/0x4fb0 net/ipv6/tcp_ipv6.c:1900
>   ip6_protocol_deliver_rcu+0xda6/0x2a60 net/ipv6/ip6_input.c:438
>   ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
>   NF_HOOK include/linux/netfilter.h:314 [inline]
>   ip6_input+0x15d/0x430 net/ipv6/ip6_input.c:492
>   dst_input include/net/dst.h:461 [inline]
>   ip6_rcv_finish+0x5db/0x870 net/ipv6/ip6_input.c:79
>   NF_HOOK include/linux/netfilter.h:314 [inline]
>   ipv6_rcv+0xda/0x390 net/ipv6/ip6_input.c:310
>   __netif_receive_skb_one_core net/core/dev.c:5532 [inline]
>   __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5646
>   netif_receive_skb_internal net/core/dev.c:5732 [inline]
>   netif_receive_skb+0x58/0x660 net/core/dev.c:5791
>   tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
>   tun_get_user+0x53af/0x66d0 drivers/net/tun.c:2002
>   tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
>   call_write_iter include/linux/fs.h:2020 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x8ef/0x1490 fs/read_write.c:584
>   ksys_write+0x20f/0x4c0 fs/read_write.c:637
>   __do_sys_write fs/read_write.c:649 [inline]
>   __se_sys_write fs/read_write.c:646 [inline]
>   __x64_sys_write+0x93/0xd0 fs/read_write.c:646
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Local variable mp_opt created at:
>   subflow_check_req+0x6d/0x15d0 net/mptcp/subflow.c:145
>   subflow_v6_route_req+0x269/0x410 net/mptcp/subflow.c:367
> 
> CPU: 1 PID: 5924 Comm: syz-executor.3 Not tainted 6.7.0-rc8-syzkaller-00055-g5eff55d725a4 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> 
> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


