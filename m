Return-Path: <netdev+bounces-88352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1378A6D3C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7834C1F21F7D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F6912C534;
	Tue, 16 Apr 2024 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6a/QgKJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2A12838C
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276235; cv=none; b=cFA2pCwX0yYDFE8rB+6BGXesMpdQqB8P7HDKMwC5h9QzTtAnTaY5SzjquYg6nFNglDctrBT6tIiglA23k7R9eHYMLw/OWnMfY4ZnC64TUnqfmGL9Qn4E/pI5/J7I9/ljSY8A6byxbfoni63iMt/hDlMTh1dEsRNJSgtrc8ZEVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276235; c=relaxed/simple;
	bh=NBj2faIDWfRGvaFskrldJQKqfGDtLnqcZK0ZzhWnlw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dtzw5mFE1WqLChoiVbeOQrDzZJusjkGeXJ7HAPN1T7ZQq25w9Siwqg3Oso+FOA63M9XoR6cajYUnBG/VjOEDVp2w1jZMObMsyWxsgaubap2OSUuyCNwZxV+8c+IJ1N8oq0Eq8Wi1Vt98Cjq2VIMZFIXy6sQfJNC/cJsWCJ/tuG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6a/QgKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD9BC113CE;
	Tue, 16 Apr 2024 14:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276235;
	bh=NBj2faIDWfRGvaFskrldJQKqfGDtLnqcZK0ZzhWnlw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6a/QgKJ5jPw0oOpFuzPk1MQBVrR33ugiu2GIac2tTKKdMaHDHzvbs+zkh/E78OTr
	 27pjoJphG6Tl45cVlIPJ4KjqoUWI43QHl6+UFiGyQVfKRj7v3+i99a+G3Sb70eKEKY
	 wPaeAE+PEA/kfL5QlsIIUDWEUMCr4H1sphkNueiYebUFusQj3bOiESQZbny6fjEF4+
	 Er9PELtY6Vm+ZjSrI+6bPwpK2uojvAEa1QmeAEIC/AlBwywInaZT3euJDJj6EQWqot
	 JRoTR8qrEsdYA8oYR5VS+e2mpGHxHEVP9wa6GUtZiifg/nSMN+ZGDcTmTaWdVSEWn9
	 jo+MT70G1djxQ==
Date: Tue, 16 Apr 2024 15:03:50 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next] ip6_vti: fix memleak on netns dismantle
Message-ID: <20240416140350.GN2320920@kernel.org>
References: <20240415122346.26503-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415122346.26503-1-fw@strlen.de>

+ Steffen Klassert, Herbert Xu, David Ahern

On Mon, Apr 15, 2024 at 02:23:44PM +0200, Florian Westphal wrote:
> kmemleak reports net_device resources are no longer released, restore
> needs_free_netdev toggle.  Sample backtrace:
> 
> unreferenced object 0xffff88810874f000 (size 4096): [..]
>     [<00000000a2b8af8b>] __kmalloc_node+0x209/0x290
>     [<0000000040b0a1a9>] alloc_netdev_mqs+0x58/0x470
>     [<00000000b4be1e78>] vti6_init_net+0x94/0x230
>     [<000000008830c1ea>] ops_init+0x32/0xc0
>     [<000000006a26fa8f>] setup_net+0x134/0x2e0
> [..]
> 
> Cc: Breno Leitao <leitao@debian.org>
> Fixes: a9b2d55a8f1e ("ip6_vti: Do not use custom stat allocator")
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/ipv6/ip6_vti.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> index 4d68a0777b0c..78344cf3867e 100644
> --- a/net/ipv6/ip6_vti.c
> +++ b/net/ipv6/ip6_vti.c
> @@ -901,6 +901,7 @@ static void vti6_dev_setup(struct net_device *dev)
>  {
>  	dev->netdev_ops = &vti6_netdev_ops;
>  	dev->header_ops = &ip_tunnel_header_ops;
> +	dev->needs_free_netdev = true;
>  
>  	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
>  	dev->type = ARPHRD_TUNNEL6;
> -- 
> 2.43.2
> 
> 

