Return-Path: <netdev+bounces-196529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F39AD532F
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5AA51BC4CB5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE52E6125;
	Wed, 11 Jun 2025 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="kFjYBxIb"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9412E6101
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639124; cv=none; b=fgSXe37ZGBxFVMvBoNwbe2R7M9NJ+L/RnwhCqzT+McekrmgirissqhJ56b9uU4t0PoEFXaTu1Yj8jxuJtzsEfcPChdlY8LMbBkxLmjmFkNub45XwEg0TXZSlqkkePv+GxH+cE4wwiBibX+uo9W/+PMXV/FrWOuwKzYo1ESzTvfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639124; c=relaxed/simple;
	bh=wnJTpkDrEHyuY2PJfJL6HLytkyJMuXGvj1zDP7fepm8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE8c5GSOb6cUwjlbPjpeoDUhOz0dbtojILmd56rTFZPNFKPcECxEbRikAAbHLozk02b8HrMFQZ1DIIs58DDH71l+JR9mXKKArj35TVgbwSHvnGyD3gtp0FT127rrWcIdkQSoBfuzOCvHJP+tnnzdsc1BFIAVMU2mjnwwSU94z64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=kFjYBxIb; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4FB3C20728;
	Wed, 11 Jun 2025 12:51:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AUgj3Ao6aaUo; Wed, 11 Jun 2025 12:51:52 +0200 (CEST)
Received: from EXCH-04.secunet.de (unknown [10.32.0.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 98706201A7;
	Wed, 11 Jun 2025 12:51:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 98706201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1749639112;
	bh=JPBVWjB+LBMlBOqjg58gCWV0yyZ+MLnr20C0a7mxTMM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=kFjYBxIbCQ3maXNhamJBO2k0U5T7PZ67HlhcpscySmhdFYV7tZ/hXXY3XIG42G//G
	 kbvL7pEk4srelhmJGVj1EJAvFof3t8LeAdGLb8U9HeRswOhtbJbqt5XRUyPWV43KdP
	 PwZkZq6iqKmi7wEDgycG2vWby1n8yxRInl7EsTUeR6yvlhM5xBV+9y4GMw8R76Bduz
	 mFH9rxZCzJCjKSRwCvESeyXo/D5cDHkj0HibvuWqrVCt2x9zZv8SrwnfkPMlmG/WpH
	 s554zEb/nGjK29UPvyck0ea1fYS3krE1pKAEiL2mYyvFKlhqgdasxkGtejB7uRhUcb
	 1mXi5/vHBGFEg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-04.secunet.de
 (10.32.0.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 11 Jun
 2025 12:51:52 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 12:51:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 697773182AC9; Wed, 11 Jun 2025 12:51:51 +0200 (CEST)
Date: Wed, 11 Jun 2025 12:51:51 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Aakash Kumar S <saakashkumar@marvell.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <akamaluddin@marvell.com>
Subject: Re: [PATCH]    xfrm: Duplicate =?utf-8?Q?S?=
 =?utf-8?B?UEkgSGFuZGxpbmcg4oCT?= IPsec-v3 Compliance Concern
Message-ID: <aElfx2P9VBN/q0A6@gauss3.secunet.de>
References: <20250609065014.381215-1-saakashkumar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250609065014.381215-1-saakashkumar@marvell.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Mon, Jun 09, 2025 at 12:20:14PM +0530, Aakash Kumar S wrote:
>         The issue originates when Strongswan initiates an XFRM_MSG_ALLOCSPI
>         Netlink message, which triggers the kernel function xfrm_alloc_spi().
>         This function is expected to ensure uniqueness of the Security Parameter
>         Index (SPI) for inbound Security Associations (SAs). However, it can
>         return success even when the requested SPI is already in use, leading
>         to duplicate SPIs assigned to multiple inbound SAs, differentiated
>         only by their destination addresses.
> 
>         This behavior causes inconsistencies during SPI lookups for inbound packets.
>         Since the lookup may return an arbitrary SA among those with the same SPI,
>         packet processing can fail, resulting in packet drops.
> 
>         According to RFC 6071, in IPsec-v3, a unicast SA is uniquely identified
>         by the SPI alone. Therefore, relying on additional fields
>         (such as destination addresses, proto) to disambiguate SPIs contradicts
>         the RFC and undermines protocol correctness.

This is not quite right, RFC 4301 says:

If the packet is addressed to the IPsec device and AH or ESP is
specified as the protocol, the packet is looked up in the SAD.
For unicast traffic, use only the SPI (or SPI plus protocol).

So using the potocol as as lookup key is OK.

> 
>         Current implementation:
>         xfrm_spi_hash() lookup function computes hash using daddr, proto, and family.
>         So if two SAs have the same SPI but different destination addresses or protocols,
>         they will:
>            a. Hash into different buckets
>            b. Be stored in different linked lists (byspi + h)
>            c. Not be seen in the same hlist_for_each_entry_rcu() iteration.
>         As a result, the lookup will result in NULL and kernel allows that Duplicate SPI
> 
>         Proposed Change:
>         xfrm_state_lookup_byspi() does a truly global search - across all states,
>         regardless of hash bucket and matches SPI for a specified family
> 
>         Signed-off-by: Aakash Kumar S <saakashkumar@marvell.com>
> ---
>  net/xfrm/xfrm_state.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 341d79ecb5c2..4a3d6fbb3fba 100644
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
> @@ -2565,18 +2564,12 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
>  	err = -ENOENT;
>  
>  	if (minspi == maxspi) {
> -		x0 = xfrm_state_lookup(net, mark, &x->id.daddr, minspi, x->id.proto, x->props.family);
> -		if (x0) {
> -			NL_SET_ERR_MSG(extack, "Requested SPI is already in use");
> -			xfrm_state_put(x0);
> -			goto unlock;
> -		}
>  		newspi = minspi;
>  	} else {
>  		u32 spi = 0;
>  		for (h = 0; h < high-low+1; h++) {
>  			spi = get_random_u32_inclusive(low, high);
> -			x0 = xfrm_state_lookup(net, mark, &x->id.daddr, htonl(spi), x->id.proto, x->props.family);
> +			x0 = xfrm_state_lookup_byspi(net, htonl(spi), x->props.family);
>  			if (x0 == NULL) {
>  				newspi = htonl(spi);
>  				break;
> @@ -2587,6 +2580,14 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
>  	if (newspi) {
>  		spin_lock_bh(&net->xfrm.xfrm_state_lock);
>  		x->id.spi = newspi;
> +
> +		x0 = xfrm_state_lookup_byspi(net, newspi, x->props.family);
> +		if (x0) {
> +			NL_SET_ERR_MSG(extack, "Requested SPI is already in use");
> +			xfrm_state_put(x0);
> +			goto unlock;
> +		}
> +

This looks wrong. xfrm_state_lookup_byspi takes the xfrm_state_lock as
well. Also, now we do the lookup twice if minspi != maxspi and the
extack message is wrong in that case. And the SPI is still not guaraneed
to be unique because the lookup depends on the address family.

Maybe it is better to create a new lookup function that does exactly
what we need for this case.


