Return-Path: <netdev+bounces-95957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4198C3E9E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161B4281751
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B668F149C5C;
	Mon, 13 May 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7xEi92b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91707148852
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594952; cv=none; b=m83jLDS2NdIteA7LBPyVWGGrtZMWNi+326QU60QmMwKYIvcZMlwB/PD3q+YJKBFTRbk7tkDwC91s1yHihQyXhc0ndALMrie8JfiDVYrm4R6/l8KCwzJbAAW/6YbRYFp8B4OL9O8WgAMnIM5n3QR3T5NZ69EboslWRThU1pPMZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594952; c=relaxed/simple;
	bh=iDWWnRmlffX6GCdCuMSA4T+Jb7psPzs5hMRWTbhqMCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIkqxv44on0vbzwzaG4ZnAUIJUWUdARStEELa6jvnAVh/h1+oLdKC1nfgsw7gsLFNZOlgazuKrG+0KOjr9J6o+iksuiwFm0TQZnFi45KTxCCUvQW1WKL+Fu/oF2h1CnbiUAO2Il5JISTrWOr1jrfYPim40AQgrRt8J+WgNdtmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7xEi92b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736C1C113CC;
	Mon, 13 May 2024 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715594952;
	bh=iDWWnRmlffX6GCdCuMSA4T+Jb7psPzs5hMRWTbhqMCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7xEi92buH5p1LZzAN99l4F5CUxHnLCCJJPz3Ucy15TtUJ33TGJmIpduuIxVTpaZ5
	 vVM2Y4QsPhJQx9PVSowbRQC3zA3z3iYVi0n5y/lFPZKXysF7aE2DVjkEWXmrD1o1vi
	 C41UEm7V03pSNm+Kzt/i+0G4NXoitXBn4hxVI0JHgSRqTS+SymnhoOO+sTYExRVdQU
	 pktQ6MH/a9vlaDG2JL5ejqAGa9w0Yvtw/CPZDeqPhQvGvMKumwbvHhbghlcwpWa6R+
	 v6nftnYzQRGr3PXK/yhIV4BZZIjkRy7D+R25N2gPzQLk1ddYqJ7KA4cYPHV4QfBwsg
	 g05PJriR+R56w==
Date: Mon, 13 May 2024 11:09:08 +0100
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
Message-ID: <20240513100908.GK2787@kernel.org>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506011637.27272-8-antonio@openvpn.net>

On Mon, May 06, 2024 at 03:16:20AM +0200, Antonio Quartulli wrote:
> An ovpn_peer object holds the whole status of a remote peer
> (regardless whether it is a server or a client).
> 
> This includes status for crypto, tx/rx buffers, napi, etc.
> 
> Only support for one peer is introduced (P2P mode).
> Multi peer support is introduced with a later patch.
> 
> Along with the ovpn_peer, also the ovpn_bind object is introcued
> as the two are strictly related.
> An ovpn_bind object wraps a sockaddr representing the local
> coordinates being used to talk to a specific peer.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

...

> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
> index ee05b8a2c61d..b79d4f0474b0 100644
> --- a/drivers/net/ovpn/ovpnstruct.h
> +++ b/drivers/net/ovpn/ovpnstruct.h
> @@ -17,12 +17,19 @@
>   * @dev: the actual netdev representing the tunnel
>   * @registered: whether dev is still registered with netdev or not
>   * @mode: device operation mode (i.e. p2p, mp, ..)
> + * @lock: protect this object
> + * @event_wq: used to schedule generic events that may sleep and that need to be
> + *            performed outside of softirq context

nit: events_wq

> + * @peer: in P2P mode, this is the only remote peer
>   * @dev_list: entry for the module wide device list
>   */
>  struct ovpn_struct {
>  	struct net_device *dev;
>  	bool registered;
>  	enum ovpn_mode mode;
> +	spinlock_t lock; /* protect writing to the ovpn_struct object */
> +	struct workqueue_struct *events_wq;
> +	struct ovpn_peer __rcu *peer;
>  	struct list_head dev_list;
>  };
>  

...

