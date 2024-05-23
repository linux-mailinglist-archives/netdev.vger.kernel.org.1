Return-Path: <netdev+bounces-97878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44B8CDA61
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 21:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692DD283572
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 19:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ACA762DC;
	Thu, 23 May 2024 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj7LBYBR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E742067
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491135; cv=none; b=ssCj0mIUAdlZ+cqScFfhNluIREnBPIU9FT20gXelLGettv3a+wcH+4FuyuxNhUaug/32itm/WH0BFSPfoKYRK98TSCG2ov4Rt9kF7XOLZLTRf91aBJoR2xxnQiGEqVBm2v559YtpIqODnQoFfy+PE4XxYc47nZhOlkFxmFWboNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491135; c=relaxed/simple;
	bh=CJRQNxUIwpjqGlhwjv5J919t6RaCyaecbfeHMQdvQ+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOvjPtKZ5gEiZEeHVJqUuMdUxCz0Wt8HrDGTO4ZGoNBvVy02CLeM3QUl1EwA4eE1CWK9qHghcoJNsxr7NBcV89bNdrZ/3qe86c29M4oGQj81Z7WTniA/cd4GEZuteF4bB2buVolJv+dZ/7sn6etn6ecl1xdCdkuSOWRSqWFYUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj7LBYBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74E3C2BD10;
	Thu, 23 May 2024 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716491135;
	bh=CJRQNxUIwpjqGlhwjv5J919t6RaCyaecbfeHMQdvQ+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bj7LBYBR4rHjoevvAVultMuq5LEK62BEOIzlwlQcMe2VPtRwNexd0eIlvGnU9Fqjs
	 DE3LQg4eoWw/ps8Sm8P+oVeJva0Z8m6LuvRD2ju+0uVSgeEq690CGVvhkEyw8PcIFI
	 UUPLI0yXT5X/mjh7I77oNkAHePHFO0/MGq1A6h48XNp3bKtctLqpIOd+wBhIdmIHH2
	 Sd7Q3EkHHpCRpen1wE4het8KqEMebgQYjNX2wUqIoCzulWpSrr+P4EpQamrn0ZY++u
	 L/WeGfR0JZvSkRMf9LGPg4ALJZbJux2MarsYDXjtg6V+frBwaIAXSwouR8Tozme4ta
	 pJ+4Yjb9reclw==
Date: Thu, 23 May 2024 20:05:30 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net] net/sched: taprio: fix duration_to_length()
Message-ID: <20240523190530.GP883722@kernel.org>
References: <20240523134549.160106-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523134549.160106-1-edumazet@google.com>

On Thu, May 23, 2024 at 01:45:49PM +0000, Eric Dumazet wrote:
> duration_to_length() is incorrectly using div_u64()
> instead of div64_u64().
> 
> syzbot reported:
> 
> Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 PID: 15391 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-08544-g4b377b4868ef #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
>  RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
>  RIP: 0010:div_u64 include/linux/math64.h:130 [inline]
>  RIP: 0010:duration_to_length net/sched/sch_taprio.c:259 [inline]
>  RIP: 0010:taprio_update_queue_max_sdu+0x287/0x870 net/sched/sch_taprio.c:288
> Code: be 08 00 00 00 e8 99 5b 6a f8 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 13 59 6a f8 48 8b 03 89 c1 48 89 e8 31 d2 <48> f7 f1 48 89 c5 48 83 7c 24 50 00 4c 8b 74 24 30 74 47 e8 c1 19
> RSP: 0018:ffffc9000506eb38 EFLAGS: 00010246
> RAX: 0000000000001f40 RBX: ffff88802f3562e0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88802f3562e0
> RBP: 0000000000001f40 R08: ffff88802f3562e7 R09: 1ffff11005e6ac5c
> R10: dffffc0000000000 R11: ffffed1005e6ac5d R12: 00000000ffffffff
> R13: dffffc0000000000 R14: ffff88801ef59400 R15: 00000000003f0008
> FS:  00007fee340bf6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2c524000 CR3: 0000000024a52000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   taprio_change+0x2dce/0x42d0 net/sched/sch_taprio.c:1911
>   taprio_init+0x9da/0xc80 net/sched/sch_taprio.c:2112
>   qdisc_create+0x9d4/0x11a0 net/sched/sch_api.c:1355
>   tc_modify_qdisc+0xa26/0x1e40 net/sched/sch_api.c:1777
>   rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
>   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
>   netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>   netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
>   netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x221/0x270 net/socket.c:745
>   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>   ___sys_sendmsg net/socket.c:2638 [inline]
>   __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fee3327cee9
> 
> Fixes: fed87cc6718a ("net/sched: taprio: automatically calculate queueMaxSDU based on TC gate durations")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


