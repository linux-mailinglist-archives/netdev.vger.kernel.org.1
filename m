Return-Path: <netdev+bounces-244526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5892FCB95C4
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AABA30BEA68
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92362F49F9;
	Fri, 12 Dec 2025 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkK7cMvb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B342580D7;
	Fri, 12 Dec 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558257; cv=none; b=GNkDhlOTaSM/LXgANth2/IzGROrm4X5yPFrAs15kwIn6NZBGKKz81THtEbg+vPt0bI4QfyArb+YtpClRuO24wIZQC/LrQase+y898GqumJEA5rjsBVkdOYuggtjdW1oa1QXj/EaD+RPAe8doGrm67YWSOzOzFqzOFBemvge2JR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558257; c=relaxed/simple;
	bh=OcHsKLbBZRjLnwJzCx8BqpA7PpLlbGBhVjpwidAlopo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHH6ywil0wG0BNHobaevfJfVSOZIw4ve66FxxjxFafosWw8sLzaC3lK5vpVGYDTFzlZ7JJ0YLwDc5TmgC/p8gFlL7L6r3tUk8ANt0jPprtVNXZO7DFQeEAZhyEsklgr2FvXtM10S6LITju8SeNXcZP5reKgAgEcu3+1L4RINQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkK7cMvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80476C116B1;
	Fri, 12 Dec 2025 16:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765558256;
	bh=OcHsKLbBZRjLnwJzCx8BqpA7PpLlbGBhVjpwidAlopo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkK7cMvbkvvL1TjmBnSXXES/9z7FxXjrEgrRx6E1Uo2r4JuFcSx9CyCqBnSlmu0FY
	 RbKVfGHGVEd0fRyf7VRq+7B5OK1pFw6/gJMSe/QmAyAzNucDgoGBhbD8T6akfsnvVy
	 T2HL0HO2JT2KyKdcKvn7JtkbJ/c5WZf5twN6RJNMjsGjZUr/FAo13xgLBSzQtCwDov
	 MzHal26SX48wioxzJiOALzeWWOnJpIeu0Vx5AWg+xa19wulZvtDnlnBlv0kEn81Z5q
	 BHThl40NyxIWDtIdmITGR8E9DR6CFSw+2Xh6QGbH0+CVdAZSmWstKrQdz6IBzUxhhC
	 wl+uqrhH6b+eA==
Date: Fri, 12 Dec 2025 16:50:52 +0000
From: Simon Horman <horms@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, brauner@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net v2] net/handshake: Fix null-ptr-deref in
 handshake_complete()
Message-ID: <aTxH7E2Jq_S9b6rq@horms.kernel.org>
References: <20251212012723.4111831-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212012723.4111831-1-wangliang74@huawei.com>

On Fri, Dec 12, 2025 at 09:27:23AM +0800, Wang Liang wrote:
> A null pointer dereference in handshake_complete() was observed [1].
> 
> When handshake_req_next() return NULL in handshake_nl_accept_doit(),
> function handshake_complete() will be called unexpectedly which triggers
> this crash. Fix it by goto out_status when req is NULL.
> 
> [1]
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
> RIP: 0010:handshake_complete+0x36/0x2b0 net/handshake/request.c:288
> Call Trace:
>  <TASK>
>  handshake_nl_accept_doit+0x32d/0x7e0 net/handshake/netlink.c:129
>  genl_family_rcv_msg_doit+0x204/0x300 net/netlink/genetlink.c:1115
>  genl_family_rcv_msg+0x436/0x670 net/netlink/genetlink.c:1195
>  genl_rcv_msg+0xcc/0x170 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x14c/0x430 net/netlink/af_netlink.c:2550
>  genl_rcv+0x2d/0x40 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>  netlink_unicast+0x878/0xb20 net/netlink/af_netlink.c:1344
>  netlink_sendmsg+0x897/0xd70 net/netlink/af_netlink.c:1894
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  ____sys_sendmsg+0xa39/0xbf0 net/socket.c:2592
>  ___sys_sendmsg+0x121/0x1c0 net/socket.c:2646
>  __sys_sendmsg+0x155/0x200 net/socket.c:2678
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x5f/0x350 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  </TASK>
> 
> Fixes: fe67b063f687 ("net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()")
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/kernel-tls-handshake/aScekpuOYHRM9uOd@morisot.1015granger.net/T/#m7cfa5c11efc626d77622b2981591197a2acdd65e
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/handshake/netlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks for the update and for addressing my review of v1.

Considering that this function combines __cleanup (via FD_PREPARE) with
goto labels, which IMHO leads to an awkward arrangement of the code, I
think this approach is a good one for a bug fix.

Reviewed-by: Simon Horman <horms@kernel.org>

