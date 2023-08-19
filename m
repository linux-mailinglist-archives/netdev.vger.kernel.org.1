Return-Path: <netdev+bounces-29043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CC278172E
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 05:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697521C209AA
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6D5136B;
	Sat, 19 Aug 2023 03:32:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595463C
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 03:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B775C433C7;
	Sat, 19 Aug 2023 03:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692415924;
	bh=yb+WTKigRqsT3NL8XsjWB0mVhvoeR9rc6p1B8UMrwj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lVR7jzD55nKAN9SB30QOM8fdtMQgI8W1LAw346/wQ86LIFFPY/Wy2RssNYEuiHtZ1
	 TYlgIJwfC7mCDV/3YrlAaiF0sW2Rwz89AfDlEk2xxYd0Jg0e8vEjkQH6ii3e6Dm8oG
	 vIYl14F9bDF9cLFTWrBtqh/KSZST9wNqvsyMM+unK1sO6FBDzwhlZODgBnNH4S9jkc
	 w9ORmySkl0mPBA1BpeLGFQCnAgWMVCUsKAMsEnCNtUnDsFsLA3srqZamAZIyYg9VKu
	 OMitLyKjILEnwviZTo9PH+WkFYjFkNw9CRBzAL4h13QwlHH19TLZ+d9m+F3T397Sv5
	 TeqDC1R/rg3OA==
Message-ID: <99759d9b-4c56-5006-2686-cf39fffa9e50@kernel.org>
Date: Fri, 18 Aug 2023 21:32:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 net] ipv4: fix data-races around inet->inet_id
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>
References: <20230819031707.312225-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230819031707.312225-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/23 9:17 PM, Eric Dumazet wrote:
> UDP sendmsg() is lockless, so ip_select_ident_segs()
> can very well be run from multiple cpus [1]
> 
> Convert inet->inet_id to an atomic_t, but implement
> a dedicated path for TCP, avoiding cost of a locked
> instruction (atomic_add_return())
> 
> Note that this patch will cause a trivial merge conflict
> because we added inet->flags in net-next tree.
> 
> v2: added missing change in
> drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> (David Ahern)
> 
> [1]
> 
> BUG: KCSAN: data-race in __ip_make_skb / __ip_make_skb
> 
> read-write to 0xffff888145af952a of 2 bytes by task 7803 on cpu 1:
> ip_select_ident_segs include/net/ip.h:542 [inline]
> ip_select_ident include/net/ip.h:556 [inline]
> __ip_make_skb+0x844/0xc70 net/ipv4/ip_output.c:1446
> ip_make_skb+0x233/0x2c0 net/ipv4/ip_output.c:1560
> udp_sendmsg+0x1199/0x1250 net/ipv4/udp.c:1260
> inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:830
> sock_sendmsg_nosec net/socket.c:725 [inline]
> sock_sendmsg net/socket.c:748 [inline]
> ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2494
> ___sys_sendmsg net/socket.c:2548 [inline]
> __sys_sendmmsg+0x269/0x500 net/socket.c:2634
> __do_sys_sendmmsg net/socket.c:2663 [inline]
> __se_sys_sendmmsg net/socket.c:2660 [inline]
> __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2660
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> read to 0xffff888145af952a of 2 bytes by task 7804 on cpu 0:
> ip_select_ident_segs include/net/ip.h:541 [inline]
> ip_select_ident include/net/ip.h:556 [inline]
> __ip_make_skb+0x817/0xc70 net/ipv4/ip_output.c:1446
> ip_make_skb+0x233/0x2c0 net/ipv4/ip_output.c:1560
> udp_sendmsg+0x1199/0x1250 net/ipv4/udp.c:1260
> inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:830
> sock_sendmsg_nosec net/socket.c:725 [inline]
> sock_sendmsg net/socket.c:748 [inline]
> ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2494
> ___sys_sendmsg net/socket.c:2548 [inline]
> __sys_sendmmsg+0x269/0x500 net/socket.c:2634
> __do_sys_sendmmsg net/socket.c:2663 [inline]
> __se_sys_sendmmsg net/socket.c:2660 [inline]
> __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2660
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> value changed: 0x184d -> 0x184e
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 7804 Comm: syz-executor.1 Not tainted 6.5.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> ==================================================================
> 
> Fixes: 23f57406b82d ("ipv4: avoid using shared IP generator for connected sockets")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  .../chelsio/inline_crypto/chtls/chtls_cm.c        |  2 +-
>  include/net/inet_sock.h                           |  2 +-
>  include/net/ip.h                                  | 15 +++++++++++++--
>  net/dccp/ipv4.c                                   |  4 ++--
>  net/ipv4/af_inet.c                                |  2 +-
>  net/ipv4/datagram.c                               |  2 +-
>  net/ipv4/tcp_ipv4.c                               |  4 ++--
>  net/sctp/socket.c                                 |  2 +-
>  8 files changed, 22 insertions(+), 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



