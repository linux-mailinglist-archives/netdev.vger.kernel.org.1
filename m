Return-Path: <netdev+bounces-52304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A367FE3F5
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07D41C209CF
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 23:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D853714F;
	Wed, 29 Nov 2023 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLz2jk9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F71C68E
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 23:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09CCC433C8;
	Wed, 29 Nov 2023 23:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701299069;
	bh=emw1V6qMKJGgft1Kf/BZN4BrcQRV5hu521wqg76vFDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sLz2jk9vLsRFVUAypz6yxPuAIlmjBarBrh26UXIUa7T5SuaGAYDTqpuMYfnX/yrNa
	 UxMPGN4++JYitleADHFimwfM51apvZ7tt40RzHxYWhyrU5T6eX1IC2iejwfzZTdgCf
	 UgTwoGxpIdNstETzqLgqZOUYxXzSMf44Uzdiss74nxQHshZBgHu111pC0hFF4Yx4ut
	 lRuVXdsVUXcanvfy1zZHbOtahhXjL8E0Ot0jc9Zuu3QZ2wKhx9yXPUbHApyE2gtw9t
	 C/duvj4lPo/X3gRo8u4wSO6XhqYB7rVpE2+vQVG0bO3bC4u2b3oad2Y3B61TktM3B2
	 WxFDx3uI2hqmg==
Message-ID: <4930145b-7f45-4fb0-90cb-ff1d5e265abe@kernel.org>
Date: Wed, 29 Nov 2023 16:04:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: fix potential NULL deref in fib6_add()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>, Wei Wang <weiwan@google.com>
References: <20231129160630.3509216-1-edumazet@google.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231129160630.3509216-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/23 9:06 AM, Eric Dumazet wrote:
> If fib6_find_prefix() returns NULL, we should silently fallback
> using fib6_null_entry regardless of RT6_DEBUG value.
> 
> syzbot reported:
> 
> WARNING: CPU: 0 PID: 5477 at net/ipv6/ip6_fib.c:1516 fib6_add+0x310d/0x3fa0 net/ipv6/ip6_fib.c:1516
> Modules linked in:
> CPU: 0 PID: 5477 Comm: syz-executor.0 Not tainted 6.7.0-rc2-syzkaller-00029-g9b6de136b5f0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> RIP: 0010:fib6_add+0x310d/0x3fa0 net/ipv6/ip6_fib.c:1516
> Code: 00 48 8b 54 24 68 e8 42 22 00 00 48 85 c0 74 14 49 89 c6 e8 d5 d3 c2 f7 eb 5d e8 ce d3 c2 f7 e9 ca 00 00 00 e8 c4 d3 c2 f7 90 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 38 80 3c 01 00
> RSP: 0018:ffffc90005067740 EFLAGS: 00010293
> RAX: ffffffff89cba5bc RBX: ffffc90005067ab0 RCX: ffff88801a2e9dc0
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc90005067980 R08: ffffffff89cbca85 R09: 1ffff110040d4b85
> R10: dffffc0000000000 R11: ffffed10040d4b86 R12: 00000000ffffffff
> R13: 1ffff110051c3904 R14: ffff8880206a5c00 R15: ffff888028e1c820
> FS: 00007f763783c6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f763783bff8 CR3: 000000007f74d000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> __ip6_ins_rt net/ipv6/route.c:1303 [inline]
> ip6_route_add+0x88/0x120 net/ipv6/route.c:3847
> ipv6_route_ioctl+0x525/0x7b0 net/ipv6/route.c:4467
> inet6_ioctl+0x21a/0x270 net/ipv6/af_inet6.c:575
> sock_do_ioctl+0x152/0x460 net/socket.c:1220
> sock_ioctl+0x615/0x8c0 net/socket.c:1339
> vfs_ioctl fs/ioctl.c:51 [inline]
> __do_sys_ioctl fs/ioctl.c:871 [inline]
> __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
> 
> Fixes: 7bbfe00e0252 ("ipv6: fix general protection fault in fib6_add()")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Wei Wang <weiwan@google.com>
> ---
>  net/ipv6/ip6_fib.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


