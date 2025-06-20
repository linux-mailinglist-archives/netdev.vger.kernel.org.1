Return-Path: <netdev+bounces-199663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F786AE146E
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 08:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF0E1896CA8
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 06:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A1224AEE;
	Fri, 20 Jun 2025 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GXybDE5U"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41438224AE1
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750402695; cv=none; b=gDxyBPDSwWVTuqNARmalFoDWv/P54zNfHg0i2adKRYG5vvbFlW/XBIStzEXGIGJXZ2BJGj3gAi6xIQqg39pELcmMSXn/YabLgbJ+wceAs4EEbgL9Dzx+/7Kn3QTiduvjFAt6WFQqvwIvztPr+47E8Eb5W72v4sjsIwmG+zxy5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750402695; c=relaxed/simple;
	bh=wthGyPEZoShJux6aoGXN+VUUTZQorQ/qV6IvJzzNV9s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE8hOTXccYF6GNoZ9Kc6DXJDccxPAKOt39q6t9rHHsmI811+Dz3gE2FNpSKqIHkpF1Avv5yvhKtNnPRtwF1ymJmC8faCxSZuXzECCBxjx++zz873fV3svsCNNv2sdGwryyOhKd40HWNctZ2eUgjazk4oRcMbUghLOSJJXYxaxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GXybDE5U; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1FD632082E;
	Fri, 20 Jun 2025 08:58:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Uz7i5S9GFP3; Fri, 20 Jun 2025 08:58:03 +0200 (CEST)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6AE10208A3;
	Fri, 20 Jun 2025 08:58:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6AE10208A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1750402683;
	bh=XzRCkrDfPirdvew+uH3SEe9QC0LZ9eNYFeDPTVENzms=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=GXybDE5Uj9Ezo6j7eER/5Q9z3+CeARu5MxbIPTn55MMczH++tHJ0m5YIy8lTS/KMc
	 hHqmah089wQPJVagzgRVqyKddz6Bhnx4r07pwzrOQszNRtnCdroliXf/3tsOhR38pK
	 6Tr90aJRqQEL78DW/6/td0+XZYkV6wq11WQyMd+0ll+4D/C1H565BdNnhMYs4iV0v9
	 kPaDJUF7MYUwlfLcRpv+/5i3nXnRMoR9OBb93eXAQdsfupU+azC3bL41G4xaHzaTlr
	 MR+mDXJZ1aZ1/V4rN4BXtR0xcmzbBDyO76XweYIPPp+LSAlmJHRd/2VTSuPFcqemzH
	 TAbIzti3eD2sA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 20 Jun
 2025 08:58:03 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Jun
 2025 08:58:02 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4CBBE318428F; Fri, 20 Jun 2025 08:58:02 +0200 (CEST)
Date: Fri, 20 Jun 2025 08:58:02 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Aakash Kumar S <saakashkumar@marvell.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <akamaluddin@marvell.com>,
	<antony@phenome.org>
Subject: Re: [PATCH]    xfrm: Duplicate SPI Handling
Message-ID: <aFUGeu3AeWSLfwHt@gauss3.secunet.de>
References: <20250616100621.837472-1-saakashkumar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250616100621.837472-1-saakashkumar@marvell.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Mon, Jun 16, 2025 at 03:36:21PM +0530, Aakash Kumar S wrote:
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
>         According to RFC 4301 section 4.4.2 , for inbound processing a unicast SA
>         is uniquely identified by the SPI and optionally protocol.
> 
> 	Reproducing the Issue Reliably:
> 	To consistently reproduce the problem, restrict the available SPI range in
> 	charon.conf : spi_min = 0x10000000 spi_max = 0x10000002
> 	This limits the system to only 2 usable SPI values.
> 	Next, create more than 2 Child SA. each using unique pair of src/dst address.
> 	As soon as the 3rd Child SA is initiated, it will be assigned a duplicate
> 	SPI, since the SPI pool is already exhausted.
> 	With a narrow SPI range, the issue is consistently reproducible.
> 	With a broader/default range, it becomes rare and unpredictable.
> 
>         Current implementation:
>         xfrm_spi_hash() lookup function computes hash using daddr, proto, and family.
>         So if two SAs have the same SPI but different destination addresses, then
>         they will:
>            a. Hash into different buckets
>            b. Be stored in different linked lists (byspi + h)
>            c. Not be seen in the same hlist_for_each_entry_rcu() iteration.
>         As a result, the lookup will result in NULL and kernel allows that Duplicate SPI
> 
>         Proposed Change:
>         xfrm_state_lookup_spi_proto() does a truly global search - across all states,
>         regardless of hash bucket and matches SPI and proto.
> 
>         Signed-off-by: Aakash Kumar S <saakashkumar@marvell.com>

Nit: Please remove the leading whitespaces from the commit message
so that I don't have to hand edit it when applying.

> ---
>  include/net/xfrm.h    |  3 +++
>  net/xfrm/xfrm_state.c | 39 +++++++++++++++++++++++++++++++--------
>  2 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 39365fd2ea17..bd128980e8fd 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -1693,6 +1693,9 @@ struct xfrm_state *xfrm_stateonly_find(struct net *net, u32 mark, u32 if_id,
>  				       u8 mode, u8 proto, u32 reqid);
>  struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
>  					      unsigned short family);
> +struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net, __be32 spi,
> +						u8 proto);
> +
>  int xfrm_state_check_expire(struct xfrm_state *x);
>  void xfrm_state_update_stats(struct net *net);
>  #ifdef CONFIG_XFRM_OFFLOAD
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 341d79ecb5c2..9820025610ee 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1714,6 +1714,29 @@ struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
>  }
>  EXPORT_SYMBOL(xfrm_state_lookup_byspi);
>  
> +struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net, __be32 spi, u8 proto)
> +{
> +    struct xfrm_state *x;
> +    unsigned int i;
> +
> +    rcu_read_lock();
> +
> +    for (i = 0; i <= net->xfrm.state_hmask; i++) {
> +        hlist_for_each_entry_rcu(x, &net->xfrm.state_byspi[i], byspi) {
> +            if (x->id.spi == spi && x->id.proto == proto) {
> +                if (!xfrm_state_hold_rcu(x))
> +                    continue;
> +                rcu_read_unlock();
> +                return x;
> +            }
> +        }
> +    }
> +
> +    rcu_read_unlock();
> +    return NULL;
> +}
> +EXPORT_SYMBOL(xfrm_state_lookup_spi_proto);

Do we really need to export this function? It is used just
in net/xfrm/xfrm_state.c


