Return-Path: <netdev+bounces-103581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EC4908B44
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0C01C2261F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6BA19644B;
	Fri, 14 Jun 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="towkAAu/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A55195FEE
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367021; cv=none; b=TYRbQMOEJdhg+22v+dvOaWaS3dKDjpwLgndpupkkD4odaktTKOYWIpLm3s6MN8IWILjIC3r8MG6nJOAAip62RiAgHmmMnotafQlv3RhoiKmwnow4q3bjjYouVT9oIF5I8RYhxV+CEgUTD6VLWNa7AYv4QNPHBegb3kyGpRYOUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367021; c=relaxed/simple;
	bh=0Usbi9n2Ec0+tC/8OvBdPdY5sFoSiE/aUsj1Of0vsZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdXXNbu4ujK1z0WbMyMeqm4mRSPaOOVYed/IBFF76M9bwo9Ar+mpkog7e8X7xRTl/tpuFg/gPu6Wh6PuJrRbGmoOub0hFYLjMFUPSy/tN9qxnael4ljeucOfIxTj9cMWj/KCbQj6+ruNS6WkMKqeqYy2+7xGztph3tCTxiLhUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=towkAAu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D30C2BD10;
	Fri, 14 Jun 2024 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718367021;
	bh=0Usbi9n2Ec0+tC/8OvBdPdY5sFoSiE/aUsj1Of0vsZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=towkAAu/k4p8QItvtX7EzbSPfw2azUPeQELD5JrTh6rIr1PK9g6mhZkdSo0wqB0B4
	 hrKFqbVk4zTLIMFLId3VBVY5sed1G0OJmEJH9fStDtRnF70XuszRWwIt26A/flnTF6
	 gICDt15IZAce7jxwu5A3VCsZzyybsxCLHcL0TIU7sQ6n9KYgD56t7LVxGCpCn84n44
	 DOAnP+lcE88ehbOnWlKFlNGW7UdJZ0pnEc+h6fndmqghDx2ZA5SqgMsZHAl5hVEv62
	 ITRYdjeuuBHlo22/zMd6C6Yfm0is56fC5Zxy933VP88VhajUc/r7M9z+0gBX4m7rEs
	 +KmZNT2OPP9ZA==
Date: Fri, 14 Jun 2024 13:10:17 +0100
From: Simon Horman <horms@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH ipsec 2/2] xfrm: Log input direction mismatch error in
 one place
Message-ID: <20240614121017.GI8447@kernel.org>
References: <f8b541f7b9d361b951ae007e2d769f25cc9a9cdd.1718087437.git.antony.antony@secunet.com>
 <50e4e7fd0b978aaa4721f022a3d5737c377c8375.1718087437.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e4e7fd0b978aaa4721f022a3d5737c377c8375.1718087437.git.antony.antony@secunet.com>

On Tue, Jun 11, 2024 at 08:32:15AM +0200, Antony Antony wrote:
> Previously, the offload data path decrypted the packet before checking
> the direction, leading to error logging and packet dropping. However,
> dropped packets wouldn't be visible in tcpdump or audit log.
> 
> With this fix, the offload path, upon noticing SA direction mismatch,
> will pass the packet to the stack without decrypting it. The L3 layer
> will then log the error, audit, and drop ESP without decrypting or
> decapsulating it.
> 
> This also ensures that the slow path records the error and audit log,
> making dropped packets visible in tcpdump.
> 
> Fixes: 304b44f0d5a4 ("xfrm: Add dir validation to "in" data path lookup")
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

Thanks Antony,

The comment below notwithstanding, this looks good to me.
Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/ipv4/esp4_offload.c | 7 +++++++
>  net/ipv6/esp6_offload.c | 7 +++++++
>  net/xfrm/xfrm_input.c   | 5 -----
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
> index b3271957ad9a..3f28ecbdcaef 100644
> --- a/net/ipv4/esp4_offload.c
> +++ b/net/ipv4/esp4_offload.c
> @@ -56,6 +56,13 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
>  		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
>  				      (xfrm_address_t *)&ip_hdr(skb)->daddr,
>  				      spi, IPPROTO_ESP, AF_INET);
> +
> +		if (unlikely(x && x->dir && x->dir != XFRM_SA_DIR_IN)) {
> +			/* non-offload path will record the error and audit log */
> +			xfrm_state_put(x);
> +			x = NULL;
> +		}
> +
>  		if (!x)
>  			goto out_reset;
>  
> diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
> index 527b7caddbc6..919ebfabbe4e 100644
> --- a/net/ipv6/esp6_offload.c
> +++ b/net/ipv6/esp6_offload.c
> @@ -83,6 +83,13 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
>  		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
>  				      (xfrm_address_t *)&ipv6_hdr(skb)->daddr,
>  				      spi, IPPROTO_ESP, AF_INET6);
> +
> +		if (unlikely(x && x->dir && x->dir != XFRM_SA_DIR_IN)) {
> +			/* non-offload path will record the error and audit log */
> +			xfrm_state_put(x);
> +			x = NULL;
> +		}
> +
>  		if (!x)
>  			goto out_reset;
>  

The logic in the two hunks above seems to be duplicated.
FWIIW, I think it would be nice to consolidate it.

...

