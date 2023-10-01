Return-Path: <netdev+bounces-37293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD517B48EF
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 19:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id E429DB20947
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376E18B1B;
	Sun,  1 Oct 2023 17:47:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6CD2FC
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 17:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D35CC433C7;
	Sun,  1 Oct 2023 17:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696182463;
	bh=VNL+SouT3OsiGYd/abICcjrcDWYcEzjJSaFaLuydeQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DBIdW5FnY8o6rsafG//hdt53G2vfWcCyiKmrjFDjZJJBQJ+onheMcG87+ZQvZOlds
	 fTmq8k0UWAv51F71S0DcAR9rQFbprtfpDnygni49xK2PoTPWgU/fHZQW7cUEgS+ItE
	 y9FK4yjCaIE0N0AkaFHkvluc3wZIWqQbXXAti1ciFAxMrTbaTYpfbkTEDIXtZ7KiYV
	 ljY9Ms+3pzF2NtCMHOyrazIEVaIqmORct+TJbOZYnMQdB9oxKqCs2TAMj8BZNowqmp
	 LFifGnMBVl7DPFcchkFUxWeCkYoB8WZeM1QttOFqYA1J3NcM5K7uSaAoL1HpDKYwuE
	 WWccuqQv4/c9Q==
Date: Sun, 1 Oct 2023 19:47:39 +0200
From: Simon Horman <horms@kernel.org>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
Subject: Re: [PATCH] tipc: Fix uninit-value access in
 __tipc_nl_bearer_enable()
Message-ID: <20231001174739.GS92317@kernel.org>
References: <20230926125120.152133-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926125120.152133-1-syoshida@redhat.com>

On Tue, Sep 26, 2023 at 09:51:20PM +0900, Shigeru Yoshida wrote:
> syzbot reported the following uninit-value access issue:
> 
> =====================================================
> BUG: KMSAN: uninit-value in strscpy+0xc4/0x160
>  strscpy+0xc4/0x160
>  bearer_name_validate net/tipc/bearer.c:147 [inline]
>  tipc_enable_bearer net/tipc/bearer.c:259 [inline]
>  __tipc_nl_bearer_enable+0x634/0x2220 net/tipc/bearer.c:1043
>  tipc_nl_bearer_enable+0x3c/0x70 net/tipc/bearer.c:1052
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:971 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
>  genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1066
>  netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
>  genl_rcv+0x40/0x60 net/netlink/genetlink.c:1075
>  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>  netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
>  netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  sock_sendmsg net/socket.c:753 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2540
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2594
>  __sys_sendmsg net/socket.c:2623 [inline]
>  __do_sys_sendmsg net/socket.c:2632 [inline]
>  __se_sys_sendmsg net/socket.c:2630 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2630
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Uninit was created at:
>  slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
>  slab_alloc_node mm/slub.c:3478 [inline]
>  kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
>  kmalloc_reserve+0x148/0x470 net/core/skbuff.c:559
>  __alloc_skb+0x318/0x740 net/core/skbuff.c:644
>  alloc_skb include/linux/skbuff.h:1286 [inline]
>  netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
>  netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  sock_sendmsg net/socket.c:753 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2540
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2594
>  __sys_sendmsg net/socket.c:2623 [inline]
>  __do_sys_sendmsg net/socket.c:2632 [inline]
>  __se_sys_sendmsg net/socket.c:2630 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2630
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Bearer names must be null-terminated strings. If a bearer name which is not
> null-terminated is passed through netlink, strcpy() and similar functions
> can cause buffer overrun. This causes the above issue.
> 
> This patch fixes this issue by returning -EINVAL if a non-null-terminated
> bearer name is passed.
> 
> Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
> Reported-and-tested-by: syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9425c47dccbcb4c17d51
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


