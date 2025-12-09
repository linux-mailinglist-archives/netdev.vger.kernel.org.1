Return-Path: <netdev+bounces-244140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A7ECB04E0
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 15:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8CF304D9E7
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4EB2FE052;
	Tue,  9 Dec 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+Qi2njg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447712FDC3C
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765291195; cv=none; b=F627MxO91ldjyi73ple4/e2MEEwlrWxd5dWcngLGRcIFAf8hxHX/2TCGOK9fcESZ4BmIhMvass3+nFttFhsdV3vxMXfnp22cxaywl2ZKujk84kL8hay/HGSwyCrdS1Ex1I+ICKQ9xiXYqgn5TDIJLQRD2+B6yc1dGdCy7BuF/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765291195; c=relaxed/simple;
	bh=1hF3HAgQ1cEsZk2uWR3S2uVVcw4wBuKrck+ymnignT8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oEqjeaHxu/LxIpisyU1sBb5p8KGuycsXjlshQ6xT6wX03KXKMXwq4emS1QSGsp2OROI7SPGsESP6AmLxo3YG66z18SeYkeX9NcS2jawRHxDj2vZsqbjRyNP8Ws4lwMwIiSAKDAXwrmlPwOYA8w/ezx6FLFo6/C5f0TBTWXqQAT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+Qi2njg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71945C4AF09;
	Tue,  9 Dec 2025 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765291194;
	bh=1hF3HAgQ1cEsZk2uWR3S2uVVcw4wBuKrck+ymnignT8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=S+Qi2njgbf50RzpccDh8b3izRHBU3uR4WWOWek/16607VKFUNARI7aDnuWuN4/FGI
	 /LW00HXI4rZ3+X/VlR6UkbWmZp6NujR9jvkS8gO/ee3HcoQz4bA3XfMI+0vIhyZJ0r
	 MjYqbqQ/vsvRieSk85yigHEtXulKG5rIRrDCbWs/17zIQ99GJbbkjb9uQ6UKJdfTEv
	 HC4ulDPmgX3FDPnLHPV2yvNHzzMCocywIhYDugTcfn8cJxga+ILDOpui3N6CzUi701
	 U5z6OW6xR0d5LdrZ//TtE9Fz7ijnc6q96AHIoiCBeOKsOKVfMr+dEeUXe/xHVVOiym
	 0J1YVt7ZaOaGg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 727BAF4006D;
	Tue,  9 Dec 2025 09:39:53 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 09 Dec 2025 09:39:53 -0500
X-ME-Sender: <xms:uTQ4abvfypaoG8e9QvO-6VluTDP26hJrM75z6HQ_l1T51rn28eZhNg>
    <xme:uTQ4aXQYVr-rSlugkOO5cOicLexvFJo1jdRO5ITyux5MiTiN9Mv4HZG0pEyYWP5lP
    Rm7En7-LVTWv_kV-VtofcUJSoYh5K6_945QXK9E23xCyC2BLfiVhcN3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epjeevhfduheeltedvjefhjeevgffhleegjeevvdfgudeuffefgedtjeeuhfeiudeknecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvghlpe
    epkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    udefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopeifrghnghhlihgrnhhgjeegsehhuhgrfigvihdrtghomhdprhgtphhtth
    hopeihuhgvhhgrihgsihhngheshhhurgifvghirdgtohhmpdhrtghpthhtohepiihhrghn
    ghgthhgrnhhgiihhohhngheshhhurgifvghirdgtohhmpdhrtghpthhtohepsghrrghunh
    gvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvg
    hrnhgvlhdqthhlshdqhhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:uTQ4aW9QbPWlXptec3eKx7VW8-K6ycYU7hs1xGjrCFV9vdqm08EA9g>
    <xmx:uTQ4aabse9VAS7OnY1KJQAFNFMtxWjM6zzW-fm6P0boq1u1wnaUWmg>
    <xmx:uTQ4aUo04CAnAahCaqVDI5h-awvzgmM3dn0WmDqcBgQRCAJeOSyO_g>
    <xmx:uTQ4af0GKf_oToO_wXwMSVMUVhrgvv_fblidPLpOsptVysYQlPGvLg>
    <xmx:uTQ4acnPZXdtKyPYi4j96Xfxu5ybcocDCfqFkJMQKCwzVW9_A5SbXj_F>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4C0CA780054; Tue,  9 Dec 2025 09:39:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWkGxD5CsV8Z
Date: Tue, 09 Dec 2025 09:39:25 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Wang Liang" <wangliang74@huawei.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 "Simon Horman" <horms@kernel.org>, "Christian Brauner" <brauner@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
Message-Id: <13914223-071e-4374-882b-d6ca5257b751@app.fastmail.com>
In-Reply-To: <20251209115852.3827876-1-wangliang74@huawei.com>
References: <20251209115852.3827876-1-wangliang74@huawei.com>
Subject: Re: [PATCH net] net/handshake: Fix null-ptr-deref in handshake_complete()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Dec 9, 2025, at 6:58 AM, Wang Liang wrote:
> A null pointer dereference in handshake_complete() was observed [1].
>
> When handshake_req_next() return NULL in handshake_nl_accept_doit(),
> function handshake_complete() will be called unexpectedly which triggers
> this crash. Fix it by goto out_status when req is NULL.
>
> [1]
> Oops: general protection fault, probably for non-canonical address 
> 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
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
> Fixes: fe67b063f687 ("net/handshake: convert handshake_nl_accept_doit() 
> to FD_PREPARE()")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/handshake/netlink.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
> index 1d33a4675a48..cdaea8b8d004 100644
> --- a/net/handshake/netlink.c
> +++ b/net/handshake/netlink.c
> @@ -106,25 +106,26 @@ int handshake_nl_accept_doit(struct sk_buff *skb, 
> struct genl_info *info)
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
> -- 
> 2.34.1

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/kernel-tls-handshake/aScekpuOYHRM9uOd@morisot.1015granger.net/T/#m7cfa5c11efc626d77622b2981591197a2acdd65e


-- 
Chuck Lever

