Return-Path: <netdev+bounces-153248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6819F75D0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45DED7A0FB1
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601DF15B135;
	Thu, 19 Dec 2024 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKIYB7sb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC8155743
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593982; cv=none; b=PcQtPhwb7EsX9OHggg013dhOVBk2+x4RBXUcQQCo+3R1bolD3dlI6jVNrwliSUy9C+Xa7BMT6cUoKfot0UIf0Y5OdcGGw7i/f8KmrPf9n+6L7bTN+Kfj9RaOQBJmvfbD+0pfpUtF8Vd7sIYNplfmOEE9FcCbph/0qCKnaapl80c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593982; c=relaxed/simple;
	bh=jJglPducZh3TyJ4iKjkXSm3paJ4BEWPAYbieGq5xwKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKyyu5c7LkTmciFtfTSmYWvrjA8l7l7rdDs6a6G7i7R6SqfVEizKd34YyJL1zal4sJ1Ac5sgZGLuwxsssvjkQSnvijzRytwiAAWhlGThAKo9y3Rc+GWGK7QswmtMNuuEKyn2EJr9gzdfrdLP3fEpdJXP0K/ICNMDalyfKRZ9Ds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKIYB7sb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734593981; x=1766129981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jJglPducZh3TyJ4iKjkXSm3paJ4BEWPAYbieGq5xwKs=;
  b=PKIYB7sbeBluI7gkjg2Rj4M1A4wDweJjX8eTLkAKx13RLRuX4EmuP+i6
   rxjAXFskNVUh2SZS1jPif1hhWw6ZQ84yXli31mCYGoDvVsCaNmTBmqKxl
   dFQr8DJukUGwsLc8nrYSFV2tB+m7Ey/XS83ahZvcjaEmIhxIlNxz5g7PI
   IvMdSL7Fw3SWuC8MhdHu6YuVMWKurZ3e+XkuW1lavnzSAqitpER3Tiaqh
   1p2NAs4K0c1/zVkdDey4Nuj3fcpQSKru/JsWNUVuN7nBU+xc34XQyqlC+
   3BFSLtrynA0wUTGBW0WiWkTLNPddvu7SNKP4O7KpTIRCmM65dAp6W9i/s
   w==;
X-CSE-ConnectionGUID: Lfbae+U0SWKqrUci9x73Iw==
X-CSE-MsgGUID: fy6Cq9+WQOuVDqNSGOqEtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45588654"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="45588654"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 23:39:41 -0800
X-CSE-ConnectionGUID: lxNKHt2FRcKKqBmepl3AaQ==
X-CSE-MsgGUID: NSciH/K3S0mnYHpiOXvCGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103103140"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 23:39:38 -0800
Date: Thu, 19 Dec 2024 08:36:31 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] gre: Drop ip_route_output_gre().
Message-ID: <Z2PM/8LPMtiYeZ8n@mev-dev.igk.intel.com>
References: <ab7cba47b8558cd4bfe2dc843c38b622a95ee48e.1734527729.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7cba47b8558cd4bfe2dc843c38b622a95ee48e.1734527729.git.gnault@redhat.com>

On Wed, Dec 18, 2024 at 02:17:16PM +0100, Guillaume Nault wrote:
> We already have enough variants of ip_route_output*() functions. We
> don't need a GRE specific one in the generic route.h header file.
> 
> Furthermore, ip_route_output_gre() is only used once, in ipgre_open(),
> where it can be easily replaced by a simple call to
> ip_route_output_key().
> 
> While there, and for clarity, explicitly set .flowi4_scope to
> RT_SCOPE_UNIVERSE instead of relying on the implicit zero
> initialisation.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  include/net/route.h | 14 --------------
>  net/ipv4/ip_gre.c   | 17 ++++++++++-------
>  2 files changed, 10 insertions(+), 21 deletions(-)
> 
> diff --git a/include/net/route.h b/include/net/route.h
> index 84cb1e04f5cd..6947a155d501 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -185,20 +185,6 @@ static inline struct rtable *ip_route_output_ports(struct net *net, struct flowi
>  	return ip_route_output_flow(net, fl4, sk);
>  }
>  
> -static inline struct rtable *ip_route_output_gre(struct net *net, struct flowi4 *fl4,
> -						 __be32 daddr, __be32 saddr,
> -						 __be32 gre_key, __u8 tos, int oif)
> -{
> -	memset(fl4, 0, sizeof(*fl4));
> -	fl4->flowi4_oif = oif;
> -	fl4->daddr = daddr;
> -	fl4->saddr = saddr;
> -	fl4->flowi4_tos = tos;
> -	fl4->flowi4_proto = IPPROTO_GRE;
> -	fl4->fl4_gre_key = gre_key;
> -	return ip_route_output_key(net, fl4);
> -}
> -
>  enum skb_drop_reason
>  ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
>  		      dscp_t dscp, struct net_device *dev,
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index f1f31ebfc793..a020342f618d 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -924,15 +924,18 @@ static int ipgre_open(struct net_device *dev)
>  	struct ip_tunnel *t = netdev_priv(dev);
>  
>  	if (ipv4_is_multicast(t->parms.iph.daddr)) {
> -		struct flowi4 fl4;
> +		struct flowi4 fl4 = {
> +			.flowi4_oif = t->parms.link,
> +			.flowi4_tos = t->parms.iph.tos & INET_DSCP_MASK,
> +			.flowi4_scope = RT_SCOPE_UNIVERSE,
> +			.flowi4_proto = IPPROTO_GRE,
> +			.saddr = t->parms.iph.saddr,
> +			.daddr = t->parms.iph.daddr,
> +			.fl4_gre_key = t->parms.o_key,
> +		};
>  		struct rtable *rt;
>  
> -		rt = ip_route_output_gre(t->net, &fl4,
> -					 t->parms.iph.daddr,
> -					 t->parms.iph.saddr,
> -					 t->parms.o_key,
> -					 t->parms.iph.tos & INET_DSCP_MASK,
> -					 t->parms.link);
> +		rt = ip_route_output_key(t->net, &fl4);
>  		if (IS_ERR(rt))
>  			return -EADDRNOTAVAIL;
>  		dev = rt->dst.dev;
> -- 

Looks even better without the memset
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 2.39.2

