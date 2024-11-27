Return-Path: <netdev+bounces-147533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6929DA070
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 02:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D78284747
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 01:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F8E4431;
	Wed, 27 Nov 2024 01:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2KIK2Ob"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F99E360
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732672021; cv=none; b=hkHBSGOrdqcevF+vmuxpTA584ZyDaWXsjEZQqD2fnRRY8sgMTRVHdy7s9QDmY0KkQjI2GZ4QP95oabTjp9REF8Q5aPSSIoQZz29tcDiKwf55/AN/go41UiZYL4gaOc84VgSr6lo99iEePMktoYHlylUYBVhcdmN/XD52GYUV2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732672021; c=relaxed/simple;
	bh=ri6R2F6JhCDDiyidB38SL9I1p6QxnRAAw9SRYbXyPCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJ3qXh7+Jg6aEwmtM4emWVsKmdYVXw9dgf16ywfv7dDQiZlo5iVTCk2KCaZBMd9FgHBmWuJJgMwkYqx8b5rY2nPptX5jIyFGG2eZQJWOUDC4X6CliKDd7kh6KJU9L4njLoI1iQDQNJf0F+6IvR+X3uiDF/IPVHQA4WmWxlvuBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2KIK2Ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8065BC4CECF;
	Wed, 27 Nov 2024 01:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732672019;
	bh=ri6R2F6JhCDDiyidB38SL9I1p6QxnRAAw9SRYbXyPCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a2KIK2ObhqHzURDXBXaVhlbl7h3e6VZwKj1iHZREEbGuNc8UKhmUFJpg0+ZGVWc6+
	 kTSLqgvuLPxMWsCKBBKNqdwF1NcVT/ZGlLP1mTep5J1anl18IzgSxxK9kq63VY/GxY
	 xnD7eZJXg+5fT890PcoZxwynFG2Qqew2w1J0CU3UhNzvexZuYZChtrco8vFDl5I/mM
	 OtOMklPD/vrlaTU6AYQvTxy7A6n3i0MoBNqJlO2zHoueuKjOCSkmmKuPW+L2JC/UTp
	 y5Su1RFwm2OoR+HZE1buejbbr3GiFG4UrLYYUfQo7fltNbHXjUxZ7GvlSCjd98skre
	 bB0GrO6Yyy22Q==
Message-ID: <43fcfc8e-d833-452e-b20b-33395069a384@kernel.org>
Date: Tue, 26 Nov 2024 18:46:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: avoid possible NULL deref in
 modify_prefix_route()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+1de74b0794c40c8eb300@syzkaller.appspotmail.com,
 Kui-Feng Lee <thinker.li@gmail.com>
References: <20241126192827.797037-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241126192827.797037-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/24 12:28 PM, Eric Dumazet wrote:
> syzbot found a NULL deref [1] in modify_prefix_route(), caused by one
> fib6_info without a fib6_table pointer set.
> 
> This can happen for net->ipv6.fib6_null_entry
> 
> [1]
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> CPU: 1 UID: 0 PID: 5837 Comm: syz-executor888 Not tainted 6.12.0-syzkaller-09567-g7eef7e306d3c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>  RIP: 0010:__lock_acquire+0xe4/0x3c40 kernel/locking/lockdep.c:5089
> Code: 08 84 d2 0f 85 15 14 00 00 44 8b 0d ca 98 f5 0e 45 85 c9 0f 84 b4 0e 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 96 2c 00 00 49 8b 04 24 48 3d a0 07 7f 93 0f 84
> RSP: 0018:ffffc900035d7268 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000006 RSI: 1ffff920006bae5f RDI: 0000000000000030
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> R10: ffffffff90608e17 R11: 0000000000000001 R12: 0000000000000030
> R13: ffff888036334880 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000555579e90380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffc59cc4278 CR3: 0000000072b54000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
>   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
>   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
>   spin_lock_bh include/linux/spinlock.h:356 [inline]
>   modify_prefix_route+0x30b/0x8b0 net/ipv6/addrconf.c:4831
>   inet6_addr_modify net/ipv6/addrconf.c:4923 [inline]
>   inet6_rtm_newaddr+0x12c7/0x1ab0 net/ipv6/addrconf.c:5055
>   rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6920
>   netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2541
>   netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
>   netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1347
>   netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1891
>   sock_sendmsg_nosec net/socket.c:711 [inline]
>   __sock_sendmsg net/socket.c:726 [inline]
>   ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2583
>   ___sys_sendmsg+0x135/0x1e0 net/socket.c:2637
>   __sys_sendmsg+0x16e/0x220 net/socket.c:2669
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fd1dcef8b79
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc59cc4378 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd1dcef8b79
> RDX: 0000000000040040 RSI: 0000000020000140 RDI: 0000000000000004
> RBP: 00000000000113fd R08: 0000000000000006 R09: 0000000000000006
> R10: 0000000000000006 R11: 0000000000000246 R12: 00007ffc59cc438c
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> 
> Fixes: 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list of routes.")
> Reported-by: syzbot+1de74b0794c40c8eb300@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67461f7f.050a0220.1286eb.0021.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> CC: Kui-Feng Lee <thinker.li@gmail.com>
> Cc: David Ahern <dsahern@kernel.org>
> ---
>  net/ipv6/addrconf.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



