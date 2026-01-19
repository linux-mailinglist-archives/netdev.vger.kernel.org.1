Return-Path: <netdev+bounces-251157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D1D3AEA7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D874E30A3D8B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F85D3876CF;
	Mon, 19 Jan 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTE49UNW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9BD387590;
	Mon, 19 Jan 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835420; cv=none; b=PyOLFbiylMq9S/0EzhSNjKfMzoM/Dr8LWrPXW353Z0l55vaWYyPUefC8law1slsSNG4LOQEXV78uq5z8hNtDSIWUDxZDEQAwWcoKzaqIQjQo21H7rEaTosWBMqxY9IMG2zPFuWmvwM6pSYnSFZdSuIIpGL03H9EgfMzmZYt+GF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835420; c=relaxed/simple;
	bh=Gna5P0d2neBKRcFcACVIWcPd/ClV/AzgKxFO21t/7EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZECSb0+JRoRv5nec6PHB7u7Wmx3Od/LkuUA6UoCvgslx5bIvoYwFvaAZPW3vgDUzAcQFxV/CWvFn5DkdDK69UCDSCHyvAJq9KoopZQ2XzQ81SkGuFrHN4NKvlN/OEJ7JCPwx8ZSICpPEpMZVpMp60yEg4HjLo4kpVYLbJJPsGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTE49UNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030A0C19423;
	Mon, 19 Jan 2026 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768835419;
	bh=Gna5P0d2neBKRcFcACVIWcPd/ClV/AzgKxFO21t/7EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTE49UNWWNyANwFEUlUiuFeLqJ7/QII8ucgllnpZ/OjT2NYHuy/tBm8coB6HMtLB3
	 DYwlh8sJpMcywA5orOameNiVaT4rHmBejd59gKzveFNvioYpyqnAbXdl/I092UCQfQ
	 PIKH9RCRdjOyBVZ5tynaU0h177/TPg65NSQVrJVooJYfkbYYvNskbHw0NaHXVoFJZM
	 P6NoRjXJpU180GaL5zASmawdNBXqCBmlb7EZ6upYIzNxHXs3jKXb98CITvSan0Vqfd
	 1hrboOktUgfego54AqBxNndVdw93dPvAl5exriRCceHwVvWSMUMmsuZ3VHp+AxDLKJ
	 Dilk1m2sUkKbQ==
Date: Mon, 19 Jan 2026 15:10:14 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Faith <faith@zellic.io>,
	Pumpkin Chang <pumpkin@devco.re>,
	Marc Dionne <marc.dionne@auristor.com>, Nir Ohfeld <niro@wiz.io>,
	Willy Tarreau <w@1wt.eu>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, security@kernel.org,
	stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] rxrpc: Fix recvmsg() unconditional requeue
Message-ID: <aW5JVspgbtaAHl-v@horms.kernel.org>
References: <95163.1768428203@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95163.1768428203@warthog.procyon.org.uk>

On Wed, Jan 14, 2026 at 10:03:23PM +0000, David Howells wrote:

...

> diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c

...

> @@ -549,11 +550,21 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  error_requeue_call:
>  	if (!(flags & MSG_PEEK)) {
>  		spin_lock_irq(&rx->recvmsg_lock);
> -		list_add(&call->recvmsg_link, &rx->recvmsg_q);
> -		spin_unlock_irq(&rx->recvmsg_lock);
> -		trace_rxrpc_recvmsg(call_debug_id, rxrpc_recvmsg_requeue, 0);
> +		if (list_empty(&call->recvmsg_link)) {
> +			list_add(&call->recvmsg_link, &rx->recvmsg_q);
> +			rxrpc_see_call(call, rxrpc_call_see_recvmsg_requeue);
> +			spin_unlock_irq(&rx->recvmsg_lock);
> +		} else if (list_is_first(&call->recvmsg_link, &rx->recvmsg_q)) {
> +			spin_unlock_irq(&rx->recvmsg_lock);
> +			rxrpc_put_call(call, rxrpc_call_see_recvmsg_requeue_first);
> +		} else {
> +			list_move(&call->recvmsg_link, &rx->recvmsg_q);
> +			spin_unlock_irq(&rx->recvmsg_lock);
> +			rxrpc_put_call(call, rxrpc_call_see_recvmsg_requeue_move);
> +		}
> + 		trace_rxrpc_recvmsg(call_debug_id, rxrpc_recvmsg_requeue, 0);

Hi David,

If you need to re-spin for some other reason then please
fix the line above so only tabs are used for indentation
(a leading space seems to have sneaked in somehow).

>  	} else {
> -		rxrpc_put_call(call, rxrpc_call_put_recvmsg);
> +		rxrpc_put_call(call, rxrpc_call_put_recvmsg_peek_nowait);
>  	}
>  error_no_call:
>  	release_sock(&rx->sk);
> 

