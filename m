Return-Path: <netdev+bounces-29549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A134783B4F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85D9280FE7
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918428473;
	Tue, 22 Aug 2023 07:59:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52227EA8
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C35CC433C7;
	Tue, 22 Aug 2023 07:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692691181;
	bh=SIsiuIU9ZP05+InPbnClNy/GxeTVu4Y9+V4DyLFGsRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T/53yu+Yeaz1aQwZmbNeYM1tgaUnroLLAPX5BmrOnm7AxyO5uioCwFFJRZp97EtbI
	 Scw/OWtNO5itjojzC9DypTT/OX10tbcC9QDfhuYy+c3MN8OT9ojJeBEEF2RVzNQFdb
	 ADIasjL635pScDjoI3G74Q9c6Bro0RJNhy3OyMesVZpkxKs8hjtZZ0w17W6Ro8sEy7
	 QdVGxonhw9u1bnCqLHBHvO4c6ShwHqigCZ0EsmmgYi6S407FdWj+0/6GhZnOXHzu2p
	 aWh0zZgApti/2aplTWcjforLz2gJFODBYmfGnNUw/i80sK98VO6zGBSfMcNt5F2T26
	 ybjzK51Eam36A==
Date: Tue, 22 Aug 2023 09:59:38 +0200
From: Simon Horman <horms@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
	edumazet@google.com, mkl@pengutronix.de,
	Ziyang Xuan <william.xuanziyang@huawei.com>
Subject: Re: [NET 2/2] can: raw: add missing refcount for memory leak fix
Message-ID: <20230822075938.GV2711035@kernel.org>
References: <20230821144547.6658-1-socketcan@hartkopp.net>
 <20230821144547.6658-3-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821144547.6658-3-socketcan@hartkopp.net>

On Mon, Aug 21, 2023 at 04:45:47PM +0200, Oliver Hartkopp wrote:
> Commit ee8b94c8510c ("can: raw: fix receiver memory leak") introduced
> a new reference to the CAN netdevice that has assigned CAN filters.
> But this new ro->dev reference did not maintain its own refcount which
> lead to another KASAN use-after-free splat found by Eric Dumazet.
> 
> This patch ensures a proper refcount for the CAN nedevice.
> 
> Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

...

> @@ -443,44 +448,56 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>  		if (!dev) {
>  			err = -ENODEV;
>  			goto out;
>  		}
>  		if (dev->type != ARPHRD_CAN) {
> -			dev_put(dev);
>  			err = -ENODEV;
> -			goto out;
> +			goto out_put_dev;
>  		}
> +
>  		if (!(dev->flags & IFF_UP))
>  			notify_enetdown = 1;
>  
>  		ifindex = dev->ifindex;
>  
>  		/* filters set by default/setsockopt */
>  		err = raw_enable_allfilters(sock_net(sk), dev, sk);
> -		dev_put(dev);
> +		if (err)
> +			goto out_put_dev;
> +
>  	} else {
>  		ifindex = 0;
>  
>  		/* filters set by default/setsockopt */
>  		err = raw_enable_allfilters(sock_net(sk), NULL, sk);
>  	}
>  
>  	if (!err) {
>  		if (ro->bound) {
>  			/* unregister old filters */
> -			if (ro->dev)
> +			if (ro->dev) {
>  				raw_disable_allfilters(dev_net(ro->dev),
>  						       ro->dev, sk);
> -			else
> +				/* drop reference to old ro->dev */
> +				netdev_put(ro->dev, &ro->dev_tracker);
> +			} else {
>  				raw_disable_allfilters(sock_net(sk), NULL, sk);
> +			}
>  		}
>  		ro->ifindex = ifindex;
>  		ro->bound = 1;
> +		/* bind() ok -> hold a reference for new ro->dev */
>  		ro->dev = dev;
> +		if (ro->dev)
> +			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
>  	}
>  
> - out:
> +out_put_dev:
> +	/* remove potential reference from dev_get_by_index() */
> +	if (dev)
> +		dev_put(dev);

Hi Oliver,

this is possibly not worth a respin, but there is no need to check if dev
is NULL before calling dev_put(), dev_put() will effectively be a no-op
with a NULL argument.

> +out:
>  	release_sock(sk);
>  	rtnl_unlock();
>  
>  	if (notify_enetdown) {
>  		sk->sk_err = ENETDOWN;
> -- 
> 2.39.2
> 
> 

