Return-Path: <netdev+bounces-129822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B518986668
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A179A1C2354E
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 18:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D2C13DBBE;
	Wed, 25 Sep 2024 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6O8yCwW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542417BB4;
	Wed, 25 Sep 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289213; cv=none; b=oSZrp0+329zRlL1k9eXY+ZBwQ9beXqXrEdc3dr4IPICYmsv3wjNU9wxZLK0Swp9ynA9qvMbPExytvKS96g/CHphK+Sv9DoD+NcVd6QcKyai4KgO8x/4geZdcAZ9ZdI47Hy9cnxAJR50ZBqnwEEf2/mIHrV8hxIxkxQ0NCFwfvIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289213; c=relaxed/simple;
	bh=dvQzEz3KjBEyGA4yDAkDvOVrPQ/YoWEcvjsUzrXSFXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrcnt6G0WviweLKdlh76DFtVPpMHayV14VJ4PLo4jFg64Lk74/f9dM0tcTv7w2MwQuCGF31Tnbm+7SC92y2XXympM6/XdoMCiSYrzULt0v8wMsF9R99PICpzFdGrEiX24eB8C5cqUShRy+3SjVLZsQLFmTUQDoVFlgUw/IuXeS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6O8yCwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71899C4CEC3;
	Wed, 25 Sep 2024 18:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727289211;
	bh=dvQzEz3KjBEyGA4yDAkDvOVrPQ/YoWEcvjsUzrXSFXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6O8yCwW08tYcQZv9oQ6lRnsetCKtXdzuBttLNPlxm3wDBEaC0AaYyiLHh42OX3it
	 ExUAXzieV28Mn5J0Lb9syJRnfvEhPI9M/dBzfMwgufcog2XhzBx/MxZVQjqA1A6Pit
	 FcRxbwBjicJgfaU3b9JVdN2KW1e9QpejGY9sXT53zEfgp/RSAW8outrP0zsHBskMmu
	 e73eCZTOJoYvHXG5cPxwvxFjcrkqcEzv/hZ6qzTDHeyvOhAxF1ZRfzB3B97/epHnrt
	 OyB4LJ9i6/B48QCW1lMPDCVJGhd4H/o72Nk5P/hJyKy7qXHBk7uxy5WqOsUsKDizAn
	 XPlAtaLUH/ykQ==
Date: Wed, 25 Sep 2024 19:33:27 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, yuxuanzhe@outlook.com,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix a race between socket set up and I/O
 thread creation
Message-ID: <20240925183327.GW4029621@kernel.org>
References: <1210177.1727215681@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1210177.1727215681@warthog.procyon.org.uk>

On Tue, Sep 24, 2024 at 11:08:01PM +0100, David Howells wrote:
> In rxrpc_open_socket(), it sets up the socket and then sets up the I/O
> thread that will handle it.  This is a problem, however, as there's a gap
> between the two phases in which a packet may come into rxrpc_encap_rcv()
> from the UDP packet but we oops when trying to wake the not-yet created I/O
> thread.
> 
> As a quick fix, just make rxrpc_encap_rcv() discard the packet if there's
> no I/O thread yet.
> 
> A better, but more intrusive fix would perhaps be to rearrange things such
> that the socket creation is done by the I/O thread.
> 
> Fixes: a275da62e8c1 ("rxrpc: Create a per-local endpoint receive queue and I/O thread")
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

...:wq

> diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
> index 0300baa9afcd..5c0a5374d51a 100644
> --- a/net/rxrpc/io_thread.c
> +++ b/net/rxrpc/io_thread.c
> @@ -27,8 +27,9 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
>  {
>  	struct sk_buff_head *rx_queue;
>  	struct rxrpc_local *local = rcu_dereference_sk_user_data(udp_sk);
> +	struct task_struct *io_thread = READ_ONCE(local->io_thread);

Hi David,

The line above dereferences local.
But the line below assumes that it may be NULL.
This seems inconsistent.

Flagged by Smatch.

>  
> -	if (unlikely(!local)) {
> +	if (unlikely(!local || !io_thread)) {
>  		kfree_skb(skb);
>  		return 0;
>  	}

