Return-Path: <netdev+bounces-37954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 223337B7FB5
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 14:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id AE9661F2249D
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5176713FE0;
	Wed,  4 Oct 2023 12:48:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9213AF6
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 12:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4B6C433C7;
	Wed,  4 Oct 2023 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696423738;
	bh=4jrK6VwOOo28NIVHKliNsx37EfRlcCe4t2IAsfQOjI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JCmewj2RIGnlDRp9T03ob6ZHwxNW/72pyr9Are8fnn+EJwZ9WdqPKGa2vlpCG/HBR
	 FrWNyAqZgC8Rxm8KIrwmYWw5RfrYZmLfvGpOOV5cT+2ShJVJs0Zz70atEEzKw0fcX5
	 /dv/q0DRNTD1I9rCQq4+gLWSMY9XJOXM5I5uR7mrBTZ/c4sBN4bfN2x4iP4M9Dd0bX
	 4qGsS7AzELeVc6NkFFR4ydENY4pcTHYpeVDCwKsM/6WyGfK58Q/Yv4yT7aRHeR4Fxp
	 xJl8sFGLdRq8+ieXNfs6W1mbzZmBB5oUcyq+Iq7BK+aePqkGPJtgIPWNOE//efvti8
	 fWQLACfBzvqOA==
Date: Wed, 4 Oct 2023 14:48:54 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] netlink: annotate data-races around sk->sk_err
Message-ID: <ZR1fNgXLy9w/GnIE@kernel.org>
References: <20231003183455.3410550-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003183455.3410550-1-edumazet@google.com>

On Tue, Oct 03, 2023 at 06:34:55PM +0000, Eric Dumazet wrote:
> syzbot caught another data-race in netlink when
> setting sk->sk_err.
> 
> Annotate all of them for good measure.
> 
> BUG: KCSAN: data-race in netlink_recvmsg / netlink_recvmsg
> 
> write to 0xffff8881613bb220 of 4 bytes by task 28147 on cpu 0:
> netlink_recvmsg+0x448/0x780 net/netlink/af_netlink.c:1994
> sock_recvmsg_nosec net/socket.c:1027 [inline]
> sock_recvmsg net/socket.c:1049 [inline]
> __sys_recvfrom+0x1f4/0x2e0 net/socket.c:2229
> __do_sys_recvfrom net/socket.c:2247 [inline]
> __se_sys_recvfrom net/socket.c:2243 [inline]
> __x64_sys_recvfrom+0x78/0x90 net/socket.c:2243
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> write to 0xffff8881613bb220 of 4 bytes by task 28146 on cpu 1:
> netlink_recvmsg+0x448/0x780 net/netlink/af_netlink.c:1994
> sock_recvmsg_nosec net/socket.c:1027 [inline]
> sock_recvmsg net/socket.c:1049 [inline]
> __sys_recvfrom+0x1f4/0x2e0 net/socket.c:2229
> __do_sys_recvfrom net/socket.c:2247 [inline]
> __se_sys_recvfrom net/socket.c:2243 [inline]
> __x64_sys_recvfrom+0x78/0x90 net/socket.c:2243
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> value changed: 0x00000000 -> 0x00000016
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 28146 Comm: syz-executor.0 Not tainted 6.6.0-rc3-syzkaller-00055-g9ed22ae6be81 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>

Reviewed-by: Simon Horman <horms@kernel.org>


