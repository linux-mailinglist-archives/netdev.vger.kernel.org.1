Return-Path: <netdev+bounces-92998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5F58B98F2
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C80D282838
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E658AA7;
	Thu,  2 May 2024 10:38:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348C456B7B
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646290; cv=none; b=FFfmL/lET6MsFyOd2QQ5gTkwhq+W82ofRvDrqAjhKvxSLlPaHRDX8EBgMxa0+TFGJea04zDbik6oljrTvgIG66JfZx2y04WER6SpxrfTiK6GKq1UZRpul+xBSuo+8A6geypD98snea+JNFyHjE8q3DokrJu/HF/ezT+YpW9ILV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646290; c=relaxed/simple;
	bh=G7HDwJcRiZk8ewFWdi1Eesxkdxi68ddMf8U/ITO9tes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk/CFm8FlS8cpW1ViGl+/b5KxNyP/mfS26qWCPsj9cjCQB4nhXDcWKmojc/DZeE2FLpfHT+fRZRO3dQrET9ebuKcba8PIJ1W3HchDIe+LAAG/jxl2KOgj5PxGzBIGBvNPtrF+QrM1ce3z9m4xt6os5JUnInTfQ+tNpyJaRk7JP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Thu, 2 May 2024 12:38:04 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, fw@strlen.de
Subject: Re: [PATCH net-next 04/12] gtp: add IPv6 support
Message-ID: <ZjNtDEJFDgSjWanp@calendula>
References: <20240425105138.1361098-1-pablo@netfilter.org>
 <20240425105138.1361098-5-pablo@netfilter.org>
 <20240426204101.GE516117@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426204101.GE516117@kernel.org>

Hi Simon,

On Fri, Apr 26, 2024 at 09:41:01PM +0100, Simon Horman wrote:
> On Thu, Apr 25, 2024 at 12:51:30PM +0200, Pablo Neira Ayuso wrote:
[...]
> > @@ -131,6 +134,11 @@ static inline u32 ipv4_hashfn(__be32 ip)
> >  	return jhash_1word((__force u32)ip, gtp_h_initval);
> >  }
> >  
> > +static inline u32 ipv6_hashfn(const struct in6_addr *ip6)
> > +{
> > +	return jhash(ip6, sizeof(*ip6), gtp_h_initval);
> > +}
> > +
> 
> Hi Pablo,
> 
> I'm would naively expect that the compiler can work out if this needs to
> be inline.

I will remove inline, I saw the warnings from patchwork on this too
after my v2.

> >  /* Resolve a PDP context structure based on the 64bit TID. */
> >  static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid)
> >  {
> 
> ...
> 
> > @@ -878,6 +951,20 @@ static inline void gtp_set_pktinfo_ipv4(struct gtp_pktinfo *pktinfo,
> >  	pktinfo->dev	= dev;
> >  }
> >  
> > +static inline void gtp_set_pktinfo_ipv6(struct gtp_pktinfo *pktinfo,
> > +					struct sock *sk, struct ipv6hdr *ip6h,
> > +					struct pdp_ctx *pctx, struct rt6_info *rt6,
> > +					struct flowi6 *fl6,
> > +					struct net_device *dev)
> > +{
> > +	pktinfo->sk	= sk;
> > +	pktinfo->ip6h	= ip6h;
> > +	pktinfo->pctx	= pctx;
> > +	pktinfo->rt6	= rt6;
> > +	pktinfo->fl6	= *fl6;
> > +	pktinfo->dev	= dev;
> > +}
> 
> Here too.

OK.

> > @@ -1441,7 +1736,14 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
> >  		if (!pctx)
> >  			pctx = pctx_tid;
> >  
> > -		ipv4_pdp_fill(pctx, info);
> > +		switch (pctx->af) {
> > +		case AF_INET:
> > +			ipv4_pdp_fill(pctx, info);
> > +			break;
> > +		case AF_INET6:
> > +			ipv6_pdp_fill(pctx, info);
> > +			break;
> > +		}
> >  
> >  		if (pctx->gtp_version == GTP_V0)
> >  			netdev_dbg(dev, "GTPv0-U: update tunnel id = %llx (pdp %p)\n",
> 
> The code just before the following hunk is:
> 
> 	pctx = kmalloc(sizeof(*pctx), GFP_ATOMIC);
> 	if (pctx == NULL)
> 		return ERR_PTR(-ENOMEM);
> 
> 
> > @@ -1461,7 +1763,24 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
> >  	sock_hold(sk);
> >  	pctx->sk = sk;
> >  	pctx->dev = gtp->dev;
> > -	ipv4_pdp_fill(pctx, info);
> > +	pctx->af = family;
> > +
> > +	switch (pctx->af) {
> > +	case AF_INET:
> > +		if (!info->attrs[GTPA_MS_ADDRESS] ||
> > +		    !info->attrs[GTPA_PEER_ADDRESS])
> > +			return ERR_PTR(-EINVAL);
> 
> So this appears to leak pctx.

Good catch.

> > +
> > +		ipv4_pdp_fill(pctx, info);
> > +		break;
> > +	case AF_INET6:
> > +		if (!info->attrs[GTPA_MS_ADDR6] ||
> > +		    !info->attrs[GTPA_PEER_ADDR6])
> > +			return ERR_PTR(-EINVAL);
> 
> Likewise here.
> 
> Flagged by Smatch.

Thanks Simon.

