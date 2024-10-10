Return-Path: <netdev+bounces-134155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8822E99831A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0915B20B3B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877A51BB6B3;
	Thu, 10 Oct 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwUD/mrF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B436D
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554646; cv=none; b=R/eH9FjpOo9VOAHvVnTnvyXgKWftsXZhtiqLueQLWYl3BdM0BsgLkj7u5hZZ+dE3xKGP9azSJZSEDBTyX1uhPNYABXfKAqGRIaIsJW8nYsdp6ykl3uvekDnDnQDgGTUYOYhXzL8bb6p/vVNAb7u62wR42JDb9yU5uHIiJSmvm2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554646; c=relaxed/simple;
	bh=rKWcHZhrSeyPxwmsAEdkOO/5DwwqxAW+y9udG3XezIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzuJsI5t0Vlmw/9NkPQ+zqWlZnahqU4G+63JXyqcloK+8j8Eip85d8s3olsazMYtgqMEj4lN8BE6tnKPesfFCODrmjz/hG5hhn5vVaZnWKbUh777qYOQOoKCQp4D+fkC8a3XdlFoaRQ9B9jHzDakSvpU2+2RIsIjb5Oar/zgWNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwUD/mrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAE8C4CEC6;
	Thu, 10 Oct 2024 10:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728554645;
	bh=rKWcHZhrSeyPxwmsAEdkOO/5DwwqxAW+y9udG3XezIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwUD/mrFR00wDhWIWibcIPQFw6d9dA1sByOzNYQtpcfcZIUqqjyhm+xRxN/HidzoQ
	 ca0EeDGPz11oq01x+ubF4vFxbmntCqexUhFa/hVGYWOlrlRvd6mhwrALj/f7P4a2Gc
	 /1AEbThdVLwCibBJ2eRwpsFuMbBJaHtF7tA7h3GtoKUGYCenfWZSLAsClHtbqBZWVc
	 CHzU5t0CXyaxbb9jxYQZ2zEltOdFPECbq7wuHcpD89JRkE7mWtI57hF4fJ3DTBcVmg
	 yzJfGUmueAgMOsD4La2FLZrKTvMvuwebCxN/rfDBa1JENZzRqFCBLYyOKVZ9JF6CqZ
	 n/PyvlSUHCSEQ==
Date: Thu, 10 Oct 2024 11:04:02 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+1d121645899e7692f92a@syzkaller.appspotmail.com
Subject: Re: [PATCH net] ppp: fix ppp_async_encode() illegal access
Message-ID: <20241010100402.GE1098236@kernel.org>
References: <20241009185802.3763282-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009185802.3763282-1-edumazet@google.com>

On Wed, Oct 09, 2024 at 06:58:02PM +0000, Eric Dumazet wrote:
> syzbot reported an issue in ppp_async_encode() [1]
> 
> In this case, pppoe_sendmsg() is called with a zero size.
> Then ppp_async_encode() is called with an empty skb.
> 
> BUG: KMSAN: uninit-value in ppp_async_encode drivers/net/ppp/ppp_async.c:545 [inline]
>  BUG: KMSAN: uninit-value in ppp_async_push+0xb4f/0x2660 drivers/net/ppp/ppp_async.c:675
>   ppp_async_encode drivers/net/ppp/ppp_async.c:545 [inline]
>   ppp_async_push+0xb4f/0x2660 drivers/net/ppp/ppp_async.c:675
>   ppp_async_send+0x130/0x1b0 drivers/net/ppp/ppp_async.c:634
>   ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2280 [inline]
>   ppp_input+0x1f1/0xe60 drivers/net/ppp/ppp_generic.c:2304
>   pppoe_rcv_core+0x1d3/0x720 drivers/net/ppp/pppoe.c:379
>   sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1113
>   __release_sock+0x1da/0x330 net/core/sock.c:3072
>   release_sock+0x6b/0x250 net/core/sock.c:3626
>   pppoe_sendmsg+0x2b8/0xb90 drivers/net/ppp/pppoe.c:903
>   sock_sendmsg_nosec net/socket.c:729 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:744
>   ____sys_sendmsg+0x903/0xb60 net/socket.c:2602
>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2656
>   __sys_sendmmsg+0x3c1/0x960 net/socket.c:2742
>   __do_sys_sendmmsg net/socket.c:2771 [inline]
>   __se_sys_sendmmsg net/socket.c:2768 [inline]
>   __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2768
>   x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>   slab_post_alloc_hook mm/slub.c:4092 [inline]
>   slab_alloc_node mm/slub.c:4135 [inline]
>   kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4187
>   kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
>   __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
>   alloc_skb include/linux/skbuff.h:1322 [inline]
>   sock_wmalloc+0xfe/0x1a0 net/core/sock.c:2732
>   pppoe_sendmsg+0x3a7/0xb90 drivers/net/ppp/pppoe.c:867
>   sock_sendmsg_nosec net/socket.c:729 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:744
>   ____sys_sendmsg+0x903/0xb60 net/socket.c:2602
>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2656
>   __sys_sendmmsg+0x3c1/0x960 net/socket.c:2742
>   __do_sys_sendmmsg net/socket.c:2771 [inline]
>   __se_sys_sendmmsg net/socket.c:2768 [inline]
>   __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2768
>   x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> CPU: 1 UID: 0 PID: 5411 Comm: syz.1.14 Not tainted 6.12.0-rc1-syzkaller-00165-g360c1f1f24c6 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+1d121645899e7692f92a@syzkaller.appspotmail.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


