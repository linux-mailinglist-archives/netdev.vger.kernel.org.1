Return-Path: <netdev+bounces-43482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030E27D38D4
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB49D2813BD
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD51A583;
	Mon, 23 Oct 2023 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NZR/yraA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AE1B26B
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 14:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74247C433C8;
	Mon, 23 Oct 2023 14:04:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NZR/yraA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1698069857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a50K0V9T1FPsR2jaKp1w4O6pzSmklgTtl4SI1anzDNw=;
	b=NZR/yraAyQD6UFh5OFNCQwAN8jFa0XXnp5//mlWQvFo7VrBJlkIs/Los7YsKijowzzCMrN
	TjYIzwVoyCzNEgSl5csIDcuJLWw/FG+CmawZlQmsVSJGvE76RPTAq7dWigIPcH4jJ5RWCA
	zg4lZUDB48ZR/K6VLkx/SQTQHYqRKiQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c64f3372 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 14:04:16 +0000 (UTC)
Date: Mon, 23 Oct 2023 16:04:13 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireguard: Fix leaking sockets in wg_socket_init error
 paths
Message-ID: <ZTZ9XfPOXD4JXdjk@zx2c4.com>
References: <20231023130609.595122-1-dxld@darkboxed.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023130609.595122-1-dxld@darkboxed.org>

Hi,

The signed-off-by is missing and the subject does not match the format
of any other wireguard commits.

On Mon, Oct 23, 2023 at 03:06:09PM +0200, Daniel Gröber wrote:
> This doesn't seem to be reachable normally, but while working on a patch

"Normally" as in what? At all? Or?

> for the address binding code I ended up triggering this leak and had to
> reboot to get rid of the leaking wg sockets.

This commit message doesn't describe any rationale for this patch. Can
you describe the bug?

> ---
>  drivers/net/wireguard/socket.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
> index 0414d7a6ce74..c35163f503e7 100644
> --- a/drivers/net/wireguard/socket.c
> +++ b/drivers/net/wireguard/socket.c
> @@ -387,7 +387,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
>  	ret = udp_sock_create(net, &port4, &new4);
>  	if (ret < 0) {
>  		pr_err("%s: Could not create IPv4 socket\n", wg->dev->name);
> -		goto out;
> +		goto err;

`new4` is either NULL or has already been freed here in the `goto retry`
case. `new6` is NULL here.

>  	}
>  	set_sock_opts(new4);
>  	setup_udp_tunnel_sock(net, new4, &cfg);
> @@ -402,7 +402,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
>  				goto retry;
>  			pr_err("%s: Could not create IPv6 socket\n",
>  			       wg->dev->name);
> -			goto out;
> +			goto err;

`new4` has just been freed by `udp_tunnel_sock_release` just above the
context. `new6` is NULL.

>  		}
>  		set_sock_opts(new6);
>  		setup_udp_tunnel_sock(net, new6, &cfg);
> @@ -414,6 +414,11 @@ int wg_socket_init(struct wg_device *wg, u16 port)
>  out:
>  	put_net(net);
>  	return ret;
> +
> +err:
> +	sock_free(new4 ? new4->sk : NULL);
> +	sock_free(new6 ? new6->sk : NULL);
> +	goto out;
>  }
>  
>  void wg_socket_reinit(struct wg_device *wg, struct sock *new4,

I don't see the bug. If there is one, maybe try again with a real patch
that describes it better. If there isn't one, what is the point?

Jason

