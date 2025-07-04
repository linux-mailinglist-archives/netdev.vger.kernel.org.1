Return-Path: <netdev+bounces-204060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75B3AF8C0D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAFE3A02BB
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48E42BD03F;
	Fri,  4 Jul 2025 08:26:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43B42BD03C
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617618; cv=none; b=VW9WA+9NoSuqcmQJlOsyZ8l1gzua4JInJ/dm8IIoV32jHTb/1ct9ZRLx4ONkG88qy8WkCqlB8ZfwLI5N+/cEDPYOeVJqmCIgI/CIiUkcgB2jz+Z1cMNE6L4RD8oLjdjztOvcD3hOWUDukN+oabeE9sK02mYjrrubVNt9zqjscxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617618; c=relaxed/simple;
	bh=9rLW76PiU8kxGz2wkzwgVQ/4unn3cMJeqBMXxzoUOcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAHsrC96szPAuCXTOhMRfU4TqC/9HgH6lEGDSIAA2ySuZskRM7ML1/YWuGp725dFHYWqjg32q+Vs1e+U4f86Et2FHKVkrLUIiIcTSjjfsRepaVAGqbvz6FLQ25MJnr+SPfhEQd3q5AcFoPKfQHDU2o0T0HXEnQI+oRsYgOTahss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id DCBB860491; Fri,  4 Jul 2025 10:26:47 +0200 (CEST)
Date: Fri, 4 Jul 2025 10:26:39 +0200
From: Florian Westphal <fw@strlen.de>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Paul Wouters <paul@nohats.ca>,
	Andreas Steffen <andreas.steffen@strongswan.org>,
	Tobias Brunner <tobias@strongswan.org>,
	Antony Antony <antony@phenome.org>, Tuomo Soini <tis@foobar.fi>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: Re: [PATCH RFC ipsec-next] pfkey: Deprecate pfkey
Message-ID: <aGeQPzULveCLU4Bq@strlen.de>
References: <aGd60lOmCtytjTYU@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGd60lOmCtytjTYU@gauss3.secunet.de>

Steffen Klassert <steffen.klassert@secunet.com> wrote:
> The pfkey user configuration interface was replaced by the netlink
> user configuration interface more than a decade ago. In between
> all maintained IKE implementations moved to the netlink interface.
> So let 'config NET_KEY' default to no in Kconfig. The pfkey code
> will be removed in a second step.

I'd suggest to also do something like
b144fcaf46d4 ("dccp: Print deprecation notice.")

> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> ---
>  net/xfrm/Kconfig | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> index f0157702718f..aedea7a892db 100644
> --- a/net/xfrm/Kconfig
> +++ b/net/xfrm/Kconfig
> @@ -110,14 +110,17 @@ config XFRM_IPCOMP
>  	select CRYPTO_DEFLATE
>  
>  config NET_KEY
> -	tristate "PF_KEY sockets"
> +	tristate "PF_KEY sockets (deprecated)"
>  	select XFRM_ALGO
> +	default n
>  	help
>  	  PF_KEYv2 socket family, compatible to KAME ones.
> -	  They are required if you are going to use IPsec tools ported
> -	  from KAME.
>  
> -	  Say Y unless you know what you are doing.
> +	  The PF_KEYv2 socket interface is deprecated and
> +	  scheduled for removal. Please use the netlink
> +	  interface (XFRM_USER) to configure IPsec.

Perhaps this should mention that all existing IKE daemons
no longer need this resp. that this is only required for
ancient/unmaintained KAME tools?

