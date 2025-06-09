Return-Path: <netdev+bounces-195630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17763AD1829
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 06:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D090016665C
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 04:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4CC27FB1C;
	Mon,  9 Jun 2025 04:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="KOe51b9e"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24326E17A
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749444880; cv=none; b=ANhVSsbnjqu9iimtqk4F94w9zKzXciQkap+XTbMbcPgtPpIDrsIBmS86RFRfXACuoyFW/W2b84GrGKXN475mndCSQqmU5UBqOBveZjWDd2Mn00s4nbc71/miS4JnJapi7AnZH7YFTk7kyWFvdWQHlcCHB//2Yr3CTk7q4ohqWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749444880; c=relaxed/simple;
	bh=zP9HTYEemg/dzfNxqTavUrDW7l86s3FaPSQDl88Dwyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4qz36LRAyF2EmGXiy1a9KdLpWgVND6IPztZPa0kXCCZRHBZkGNziHudmOfBmxorzY/DrVZWBOnprWEvzoB1PPkf/o/Ud0LVGT7IXCEY0daqEHzDu9toTr3g3IK6OPJJCogOW8cRabkDOVX0rZqW7GiPC1wLQHeSve4rLsUI5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=KOe51b9e; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Qu5rb/plJ5VBp/ia/CyKVGQI0qCsjZybcVr/HB5dRjw=; b=KOe51b9e/Z3jTXWTzuBi0xknrT
	/MuxR820Jfuv7LA6ljymEjLxqqoWCs2K4+UiidHXdJtGpbrVxZvEo1LPWgRAYthNoKCcPDgdP8Q2e
	I53cDT33DRO3pS9YP1ghW3V3A3DZ4gStUnhBn8XE67sFp+b3iTzKf/DuBiBdHJMH6RHhfaWyEhryg
	zWJcsQemEJTTWLC3qcabygWaNePGnzFHwZ+LxMk7SWPkDp841T+aezzGVDGpY2SfPDV6H2lCDEqHl
	MrWA4e/7+nvNCqcObu5kT6ifSBvmIpLKzQ1ID2BFnAKp24vQazvm0ByQtKonhDmjhwb4twBsPKmoZ
	ctVluiYw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uOUWk-00Bikv-0H;
	Mon, 09 Jun 2025 12:54:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 09 Jun 2025 12:54:30 +0800
Date: Mon, 9 Jun 2025 12:54:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aakash Kumar S <saakashkumar@marvell.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, akamaluddin@marvell.com
Subject: Re: [PATCH] xfrm: Duplicate =?utf-8?Q?SPI_?=
 =?utf-8?B?SGFuZGxpbmcg4oCT?= IPsec-v3 Compliance Concern
Message-ID: <aEZpBsgcdTTKr98q@gondor.apana.org.au>
References: <20250602181948.129956-1-saakashkumar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602181948.129956-1-saakashkumar@marvell.com>

On Mon, Jun 02, 2025 at 11:49:48PM +0530, Aakash Kumar S wrote:
>
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 341d79ecb5c2..d0b221a4a625 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -2550,7 +2550,6 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
>  	__be32 minspi = htonl(low);
>  	__be32 maxspi = htonl(high);
>  	__be32 newspi = 0;
> -	u32 mark = x->mark.v & x->mark.m;
>  
>  	spin_lock_bh(&x->lock);
>  	if (x->km.state == XFRM_STATE_DEAD) {
> @@ -2565,7 +2564,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
>  	err = -ENOENT;
>  
>  	if (minspi == maxspi) {
> -		x0 = xfrm_state_lookup(net, mark, &x->id.daddr, minspi, x->id.proto, x->props.family);
> +		x0 = xfrm_state_lookup_byspi(net, minspi, x->props.family);
>  		if (x0) {
>  			NL_SET_ERR_MSG(extack, "Requested SPI is already in use");
>  			xfrm_state_put(x0);
> @@ -2576,7 +2575,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
>  		u32 spi = 0;
>  		for (h = 0; h < high-low+1; h++) {
>  			spi = get_random_u32_inclusive(low, high);
> -			x0 = xfrm_state_lookup(net, mark, &x->id.daddr, htonl(spi), x->id.proto, x->props.family);
> +			x0 = xfrm_state_lookup_byspi(net, htonl(spi), x->props.family);
>  			if (x0 == NULL) {
>  				newspi = htonl(spi);
>  				break;

The patch looks OK to me.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

That function in general has some issues though.  First of all
the SPI search is racy.  We only take the lock and update the
state database after the search.  That means the supposedly unique
SPI may no longer be unique.

The search for an SPI in the range is also prone to DoS attacks
if the SPI range is large and dense at the same time.  That depends
on how user-space constructs the range of course.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

