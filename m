Return-Path: <netdev+bounces-77547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8843B872283
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAB51C22010
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75671272A0;
	Tue,  5 Mar 2024 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUGCSOJ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F71272A6
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651790; cv=none; b=SFxGANpkgc9UCSN+a7PjPxfAG/c8yaeJwt7Hd7CvnS0nng1pj35bXw901C0MP+FfmiLyjtsEcZj1YdJ4atklzQV3scAiPOZz8klKOKYi9mlSo8oXRd8b8uSonEH9a7JNXSwTObez7PrlCofitISJql8svVmdBp33mhOW06wDwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651790; c=relaxed/simple;
	bh=EA1u5Zvhdfxa76+8+e38RcsYzNXTgKCziO1I303PMI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU06RDgH8iNcpRpIQQnZ6NWT8FTw5nKw0qBWrZeiwVJUZoF3zu3kkRPtDJy/2r8oUSb2RNL7sGfXtkrdOL1INaX6mUP5NZM/6Zc6+fdENBbKFBTkjNxPdz/+WvlQ7u5njALs0HxaZGy3E3sCZeo4ZehMoBk29dLcWxwqzsdx2ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUGCSOJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE04AC43390;
	Tue,  5 Mar 2024 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709651790;
	bh=EA1u5Zvhdfxa76+8+e38RcsYzNXTgKCziO1I303PMI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUGCSOJ5SWtTkxscMvObcCoPXEIg5SK/7nLfNVXIIM49oRtVjQjVX9PwVrnMbYrI8
	 mKAaPPztsGj4UAnRmeQPFyLr6P0RrjeENxiINyAiAqPJlZ2GsO9zQRl2IubbEAJRDF
	 M0fq8tv9jeIWb+mueKX5xH7cNKmHgnv5qcnpe4gb5hrtkGoSkHLtspdZiSttuqO2yx
	 WtO7kpKVRA6+gWoGj8m8/X/LlCZb/0sFHGqaDsX29rJ7T6Ym3b7dB+naqEEyrn57P5
	 ivFSbf814HaHNXR2b4bv0OJxYdf5CzAga9p0j6nGVm3qYHkhlhnN/UjG0p+6zMXQxT
	 nF90ThEn6feaw==
Date: Tue, 5 Mar 2024 15:16:26 +0000
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 14/22] ovpn: implement peer lookup logic
Message-ID: <20240305151626.GM2357@kernel.org>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-15-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-15-antonio@openvpn.net>

On Mon, Mar 04, 2024 at 04:09:05PM +0100, Antonio Quartulli wrote:
> In a multi-peer scenario there are a number of situations when a
> specific peer needs to be looked up.
> 
> We may want to lookup a peer by:
> 1. its ID
> 2. its VPN destination IP
> 3. its tranport IP/port couple

nit: transport

     checkpatch.pl --codespell is your friend here.

> For each of the above, there is a specific routing table referencing all
> peers for fast look up.
> 
> Case 2. is a bit special in the sense that an outgoing packet may not be
> sent to the peer VPN IP directly, but rather to a network behind it. For
> this reason we first perform a nexthop lookup in the system routing
> table and then we use the retrieved nexthop as peer search key.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

...

> +/**
> + * ovpn_nexthop_lookup4() - looks up the IP of the nexthop for the given destination
> + *
> + * Looks up in the IPv4 system routing table the IP of the nexthop to be used
> + * to reach the destination passed as argument. If no nexthop can be found, the
> + * destination itself is returned as it probably has to be used as nexthop.
> + *
> + * @ovpn: the private data representing the current VPN session
> + * @dst: the destination to be looked up

I think you need to document @src instead of @dst here.

> + *
> + * Return the IP of the next hop if found or the dst itself otherwise
> + */
> +static __be32 ovpn_nexthop_lookup4(struct ovpn_struct *ovpn, __be32 src)
> +{
> +	struct rtable *rt;
> +	struct flowi4 fl = {
> +		.daddr = src
> +	};
> +
> +	rt = ip_route_output_flow(dev_net(ovpn->dev), &fl, NULL);
> +	if (IS_ERR(rt)) {
> +		net_dbg_ratelimited("%s: no nexthop found for %pI4\n", ovpn->dev->name, &src);
> +		/* if we end up here this packet is probably going to be
> +		 * thrown away later
> +		 */
> +		return src;
> +	}
> +
> +	if (!rt->rt_uses_gateway)
> +		goto out;
> +
> +	src = rt->rt_gw4;
> +out:
> +	return src;
> +}
> +
> +/**
> + * ovpn_nexthop_lookup6() - looks up the IPv6 of the nexthop for the given destination
> + *
> + * Looks up in the IPv6 system routing table the IP of the nexthop to be used
> + * to reach the destination passed as argument. If no nexthop can be found, the
> + * destination itself is returned as it probably has to be used as nexthop.
> + *
> + * @ovpn: the private data representing the current VPN session
> + * @dst: the destination to be looked up

And here.

> + *
> + * Return the IP of the next hop if found or the dst itself otherwise
> + */
> +static struct in6_addr ovpn_nexthop_lookup6(struct ovpn_struct *ovpn, struct in6_addr addr)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +	struct rt6_info *rt;
> +	struct flowi6 fl = {
> +		.daddr = addr,
> +	};
> +
> +	rt = (struct rt6_info *)ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl,
> +								NULL);
> +	if (IS_ERR(rt)) {
> +		net_dbg_ratelimited("%s: no nexthop found for %pI6\n", ovpn->dev->name, &addr);
> +		/* if we end up here this packet is probably going to be thrown away later */
> +		return addr;
> +	}
> +
> +	if (rt->rt6i_flags & RTF_GATEWAY)
> +		addr = rt->rt6i_gateway;
> +
> +	dst_release((struct dst_entry *)rt);
> +#endif
> +	return addr;
> +}

...

