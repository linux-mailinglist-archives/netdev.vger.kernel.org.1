Return-Path: <netdev+bounces-202069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C25CFAEC29C
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B921C450FF
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7BD28F53F;
	Fri, 27 Jun 2025 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWubhjeN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280D028C862
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751063376; cv=none; b=jCAwXe2vXyYqDYHyxmyCeTfIT06yRtrpSabsSOaXyRkQJzrk9z/BXIx3h01MHs0TRHX6dZFMzI84bjCqezxopABxC6oFE4jTibvQzfnSuDzXWyOAWIdOkVsWlbtJrnT/Hgqwd0UTUPOI5RUSq7xRzWEARFSHm7GBx8j7M5XIm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751063376; c=relaxed/simple;
	bh=Eq68Xvju2V+rYV9nMQRdXpxP5x2zMyXc1jmQ6XOt3Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuejzrgxigWPLlq7F6i75bmWi28x7NN6/bC/xsBYZc2MLUxLSIgbT6PYcR43Q9utFGa4rHhRh2oXgbxX+WLP4pueECfwXa5Y+8/ZtEkhK8xXvB93UZhS+ApMzbQGxS4Gx1bpsuLnX5SvL6UbeIbKSItVx9m2/3Z7ugPDHzXVPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWubhjeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7FAC4CEE3;
	Fri, 27 Jun 2025 22:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751063375;
	bh=Eq68Xvju2V+rYV9nMQRdXpxP5x2zMyXc1jmQ6XOt3Sc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LWubhjeNm0t0ER02U/fS/SFaPZAfR9/KBvIRauwz7EhLw8evAToMmmjnKC16B1eO0
	 6pOWL9AsbhILuvvgHeOblv5y7QhAFLBlEmd0nT4/ErWBpOhMrvz2Xk4AC1gObXxRpZ
	 E81TpBaJpHEh+hikHuwh9ppn3Ce3fQV0OxjDyagoLQSgrtaXaoJNn8YsZ7EEo7nEuO
	 J1oloO6PDemRLkXBU8hw3ucixdMjPTnRtJXUpbq6DRXmZGBHfTojuCvxbzybsisF90
	 QCQImcMm/L57luyQgsosQ9FP6pIlEg/TK01gfjg5vGIAy7lSeiecoC3lAbD0kjdpDc
	 5lU3mO1sjKfdQ==
Date: Fri, 27 Jun 2025 15:29:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] ip6_tunnel: enable to change proto of fb
 tunnels
Message-ID: <20250627152934.6379eefc@kernel.org>
In-Reply-To: <20250626215919.2825347-1-nicolas.dichtel@6wind.com>
References: <20250626215919.2825347-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 23:55:09 +0200 Nicolas Dichtel wrote:
> I finally checked  all params, let's do this properly (:

Nice :)

> -static void ip6_tnl0_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p)
> +static int ip6_tnl0_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p,
> +			   bool strict)
>  {
> -	/* for default tnl0 device allow to change only the proto */
> +	/* For the default ip6tnl0 device, allow changing only the protocol (the

nit: the "(the" may look better on the next line?

> +	 * IP6_TNL_F_CAP_PER_PACKET flag is set on ip6tnl0, and all other
> +	 * parameters are 0).
> +	 */
> +	if (strict &&
> +	    (!ipv6_addr_any(&p->laddr) || !ipv6_addr_any(&p->raddr) ||
> +	     p->flags != t->parms.flags || p->hop_limit || p->encap_limit ||
> +	     p->flowinfo || p->link || p->fwmark || p->collect_md))
> +		return -EINVAL;
> +
>  	t->parms.proto = p->proto;
>  	netdev_state_change(t->dev);
> +	return 0;
>  }
>  
>  static void
> @@ -1680,7 +1691,7 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
>  			} else
>  				t = netdev_priv(dev);
>  			if (dev == ip6n->fb_tnl_dev)
> -				ip6_tnl0_update(t, &p1);
> +				ip6_tnl0_update(t, &p1, false);
>  			else
>  				ip6_tnl_update(t, &p1);
>  		}
> @@ -2053,8 +2064,31 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
>  	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
>  	struct ip_tunnel_encap ipencap;
>  
> -	if (dev == ip6n->fb_tnl_dev)
> -		return -EINVAL;
> +	if (dev == ip6n->fb_tnl_dev) {
> +		struct ip6_tnl *t = netdev_priv(ip6n->fb_tnl_dev);

the compiler complains that t is declared here but not used..

> +
> +		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
> +			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
> +			 * let's ignore this flag.
> +			 */
> +			ipencap.flags &= ~TUNNEL_ENCAP_FLAG_CSUM6;
> +			if (memchr_inv(&ipencap, 0, sizeof(ipencap))) {
> +				NL_SET_ERR_MSG(extack,
> +					       "Only protocol can be changed for fallback tunnel, not encap params");
> +				return -EINVAL;
> +			}
> +		}
> +
> +		ip6_tnl_netlink_parms(data, &p);
> +		if (ip6_tnl0_update(netdev_priv(ip6n->fb_tnl_dev), &p,

.. you probably meant to use it here?
-- 
pw-bot: cr

