Return-Path: <netdev+bounces-244157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A0FCB0CB9
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 19:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43F5630E97E8
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A742DBF47;
	Tue,  9 Dec 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPxigFvL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A12D7803;
	Tue,  9 Dec 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303610; cv=none; b=dvWREYin1LRyKObafWU+yaCuA/0WnpLz0cfe/vQU3wSbefybr385wgiu1KFOoUqThsuOKJbeHODYuSEd+rrVrgl3Am7O1H8Bjk0jMJxFKOZujJZG1eoNSvjQWjHMwwyvhGrpK7LuLybpBBRHPUWlCP0hfS1wCn0P8ExUw6OqARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303610; c=relaxed/simple;
	bh=oXy8lcGgtyzeGMTsH2PksKxqz7e9MQNYzW6NnAqIqZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5VUZdeZuG4VKglhEpbWNyaFHT04jNxICgSzdx44G4z7esP6khqowN/sbAhP3L5kexLAw3gmGcluk70Qor3hvmelmozeE9dVmCQe0LqfZzrZeblh4uk3Cs29RY+2s5Y/LnlgKbe10AdMabl0YMv4KXqIuVvvQYlyG/oV6ObdGxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPxigFvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1616DC4CEF5;
	Tue,  9 Dec 2025 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765303610;
	bh=oXy8lcGgtyzeGMTsH2PksKxqz7e9MQNYzW6NnAqIqZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPxigFvLniyWs5QRv642DWfvPC2ZR34AqFt6kCDRYgP5dY0nJVn/XKY92oJnnpwla
	 PW0K47sve9XjJrVCkUfPraj0rNYKc7l1UaNCzCIVvnOaUma0KOBpn+tyBmmtyX85nx
	 UF6KlgwtA1sic1BqMSd3q8vnPCyiPyn6v2dHJFFt8uTos5+xiVl5ORZuBeqSEj6QoC
	 KC8AxsaYzkpa7TiYHFvKgzVLSy+dGjdzGVunWRirR+wA/QlDWNi+ROOeuNNeN0kk+N
	 kN5zXw9pmjLiARrswBGKiEv+1V7+487qbOePu2EGdh6chECHfBhEKQwEyahzRMScj0
	 9OtKpON4gy5NA==
Date: Tue, 9 Dec 2025 18:06:46 +0000
From: Simon Horman <horms@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, brauner@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net] net/handshake: Fix null-ptr-deref in
 handshake_complete()
Message-ID: <aThlNuc-kjPqd9kh@horms.kernel.org>
References: <20251209115852.3827876-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209115852.3827876-1-wangliang74@huawei.com>

On Tue, Dec 09, 2025 at 07:58:52PM +0800, Wang Liang wrote:
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
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/handshake/netlink.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
> index 1d33a4675a48..cdaea8b8d004 100644
> --- a/net/handshake/netlink.c
> +++ b/net/handshake/netlink.c
> @@ -106,25 +106,26 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	err = -EAGAIN;
>  	req = handshake_req_next(hn, class);
> -	if (req) {
> -		sock = req->hr_sk->sk_socket;
> -
> -		FD_PREPARE(fdf, O_CLOEXEC, sock->file);
> -		if (fdf.err) {
> -			err = fdf.err;
> -			goto out_complete;
> -		}
> -
> -		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
> -		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
> -		if (err)
> -			goto out_complete; /* Automatic cleanup handles fput */
> -
> -		trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
> -		fd_publish(fdf);
> -		return 0;
> +	if (!req)
> +		goto out_status;
> +
> +	sock = req->hr_sk->sk_socket;
> +
> +	FD_PREPARE(fdf, O_CLOEXEC, sock->file);
> +	if (fdf.err) {
> +		err = fdf.err;
> +		goto out_complete;
>  	}
>  
> +	get_file(sock->file); /* FD_PREPARE() consumes a reference. */
> +	err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
> +	if (err)
> +		goto out_complete; /* Automatic cleanup handles fput */
> +
> +	trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
> +	fd_publish(fdf);
> +	return 0;
> +
>  out_complete:
>  	handshake_complete(req, -EIO, NULL);
>  out_status:

Hi,

Clang 21.1.7 W=1 builds are rather unhappy about this:

  net/handshake/netlink.c:110:3: error: cannot jump from this goto statement to its label
    110 |                 goto out_status;
        |                 ^
  net/handshake/netlink.c:114:13: note: jump bypasses initialization of variable with __attribute__((cleanup))
    114 |         FD_PREPARE(fdf, O_CLOEXEC, sock->file);
        |                    ^
  net/handshake/netlink.c:104:3: error: cannot jump from this goto statement to its label
    104 |                 goto out_status;
        |                 ^
  net/handshake/netlink.c:114:13: note: jump bypasses initialization of variable with __attribute__((cleanup))
    114 |         FD_PREPARE(fdf, O_CLOEXEC, sock->file);
        |                    ^
  net/handshake/netlink.c:100:3: error: cannot jump from this goto statement to its label
    100 |                 goto out_status;
        |                 ^
  net/handshake/netlink.c:114:13: note: jump bypasses initialization of variable with __attribute__((cleanup))
    114 |         FD_PREPARE(fdf, O_CLOEXEC, sock->file);
        |                    ^

My undersatnding of the problem is as follows:

FD_PREPARE uses __cleanup to call class_fd_prepare_destructor when
resources when fdf goes out of scope.

Prior to this patch this was when the if (req) block was existed.
Either via return or a goto due to an error.

Now it is when handshake_nl_accept_doit() itself is exited.
Again via a return or a goto due to error.

But, importantly, such a goto can now occur before fdf is initialised.
Boom!

-- 
pw-bot: changes-requested

