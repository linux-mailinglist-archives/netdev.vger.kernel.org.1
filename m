Return-Path: <netdev+bounces-64309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72583236F
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 03:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47ECE1F21119
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 02:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6715B28DDF;
	Fri, 19 Jan 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLP60rHo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382B5664
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632027; cv=none; b=qyVcV02n/RR4BNtBloj9bwGxDg9+ZmBtbUmZ1vJhL3FdJwqrdXfFhUITt9aciv6e7I62SEC5NJIVq1/Q8tCECEZ362HGhuZJAkNYuWKSgYknWp/28V1629v1ZarTV/JRWsew4tEWJVR+rY5cnlQkp5V2PNsh59tepN1NOhKqQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632027; c=relaxed/simple;
	bh=mHxVdQtwTn/Z+H0s1njOdTcoAr1wHe3EqlL8kaOXHoo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lg60JS4WkA0Vzu2HmIoUJ24FNI7cEe1lwgQorYR54PzktuNBw2kIErQ4JCfIkMc8imgk9Q6jdXNnMDoXiGuTuhB1atkteo0yo4izTSTPkAuKgNw/HslfDBVsFhZuVrjSqh2rB+Xn9xeUEhdHrK0vFNYVJzyZjYqR0lLjECTbxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLP60rHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17259C433B1;
	Fri, 19 Jan 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705632027;
	bh=mHxVdQtwTn/Z+H0s1njOdTcoAr1wHe3EqlL8kaOXHoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oLP60rHouZWyJ1ACe5zpLGIvnC1FtmqM9smQ/A8C9WH84hP+I3WUbJVYLrZNCh7Nv
	 +S1rrsDPq++IayP82SYByCMOZ+EHTI9XV4eFMK3VRarASXTil+svbTpHBRl84IueZS
	 Ut/IP7yY+oQpSRLOwF+gooGLAvMz4Bx6MrrdSpDwYRdgcAq5z7ENLfXwlBxlFA8RpS
	 UMID7pJLpIkgGIlFCIMIDJQsCHHrTnVkqdHUtAEPIG7oYhrE1Vow/RADLtWAV5d5iz
	 Zz6tma2RqPhCqAqGQ16YdnRwYNoDLn9UM9d1LAfXV5ZYTxJccutySfB0X3ngZSMa2U
	 SD6GK9CJowdAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07BFFD8C987;
	Fri, 19 Jan 2024 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v4] tcp: make sure init the accept_queue's spinlocks once
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170563202702.16011.7395784777446324220.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jan 2024 02:40:27 +0000
References: <20240118012019.1751966-1-shaozhengchao@huawei.com>
In-Reply-To: <20240118012019.1751966-1-shaozhengchao@huawei.com>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, sming56@aliyun.com,
 hkchu@google.com, weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Jan 2024 09:20:19 +0800 you wrote:
> When I run syz's reproduction C program locally, it causes the following
> issue:
> pvqspinlock: lock 0xffff9d181cd5c660 has corrupted value 0x0!
> WARNING: CPU: 19 PID: 21160 at __pv_queued_spin_unlock_slowpath (kernel/locking/qspinlock_paravirt.h:508)
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> RIP: 0010:__pv_queued_spin_unlock_slowpath (kernel/locking/qspinlock_paravirt.h:508)
> Code: 73 56 3a ff 90 c3 cc cc cc cc 8b 05 bb 1f 48 01 85 c0 74 05 c3 cc cc cc cc 8b 17 48 89 fe 48 c7 c7
> 30 20 ce 8f e8 ad 56 42 ff <0f> 0b c3 cc cc cc cc 0f 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffa8d200604cb8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9d1ef60e0908
> RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9d1ef60e0900
> RBP: ffff9d181cd5c280 R08: 0000000000000000 R09: 00000000ffff7fff
> R10: ffffa8d200604b68 R11: ffffffff907dcdc8 R12: 0000000000000000
> R13: ffff9d181cd5c660 R14: ffff9d1813a3f330 R15: 0000000000001000
> FS:  00007fa110184640(0000) GS:ffff9d1ef60c0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000000 CR3: 000000011f65e000 CR4: 00000000000006f0
> Call Trace:
> <IRQ>
>   _raw_spin_unlock (kernel/locking/spinlock.c:186)
>   inet_csk_reqsk_queue_add (net/ipv4/inet_connection_sock.c:1321)
>   inet_csk_complete_hashdance (net/ipv4/inet_connection_sock.c:1358)
>   tcp_check_req (net/ipv4/tcp_minisocks.c:868)
>   tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2260)
>   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205)
>   ip_local_deliver_finish (net/ipv4/ip_input.c:234)
>   __netif_receive_skb_one_core (net/core/dev.c:5529)
>   process_backlog (./include/linux/rcupdate.h:779)
>   __napi_poll (net/core/dev.c:6533)
>   net_rx_action (net/core/dev.c:6604)
>   __do_softirq (./arch/x86/include/asm/jump_label.h:27)
>   do_softirq (kernel/softirq.c:454 kernel/softirq.c:441)
> </IRQ>
> <TASK>
>   __local_bh_enable_ip (kernel/softirq.c:381)
>   __dev_queue_xmit (net/core/dev.c:4374)
>   ip_finish_output2 (./include/net/neighbour.h:540 net/ipv4/ip_output.c:235)
>   __ip_queue_xmit (net/ipv4/ip_output.c:535)
>   __tcp_transmit_skb (net/ipv4/tcp_output.c:1462)
>   tcp_rcv_synsent_state_process (net/ipv4/tcp_input.c:6469)
>   tcp_rcv_state_process (net/ipv4/tcp_input.c:6657)
>   tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1929)
>   __release_sock (./include/net/sock.h:1121 net/core/sock.c:2968)
>   release_sock (net/core/sock.c:3536)
>   inet_wait_for_connect (net/ipv4/af_inet.c:609)
>   __inet_stream_connect (net/ipv4/af_inet.c:702)
>   inet_stream_connect (net/ipv4/af_inet.c:748)
>   __sys_connect (./include/linux/file.h:45 net/socket.c:2064)
>   __x64_sys_connect (net/socket.c:2073 net/socket.c:2070 net/socket.c:2070)
>   do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
>   RIP: 0033:0x7fa10ff05a3d
>   Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89
>   c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ab a3 0e 00 f7 d8 64 89 01 48
>   RSP: 002b:00007fa110183de8 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
>   RAX: ffffffffffffffda RBX: 0000000020000054 RCX: 00007fa10ff05a3d
>   RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
>   RBP: 00007fa110183e20 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000202 R12: 00007fa110184640
>   R13: 0000000000000000 R14: 00007fa10fe8b060 R15: 00007fff73e23b20
> </TASK>
> 
> [...]

Here is the summary with links:
  - [net,v4] tcp: make sure init the accept_queue's spinlocks once
    https://git.kernel.org/netdev/net/c/615c30a4ef6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



