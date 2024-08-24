Return-Path: <netdev+bounces-121675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5B095DFC7
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 21:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C511C20CBD
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E782E61FFC;
	Sat, 24 Aug 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUHUB2W/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1514A85
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724527105; cv=none; b=Cz1xe9pl5obn3/7ApKcRaANT7GR3NFaT95KjJacFcfv2juKP9Ddk9HCGaE4zfgxt2fqhVmNpC3LykyQLm2WUPCqUQORS762zNpzZwfXYDKGSSnlBJHpwr3rotGhcKW7nhvKg6K8MJqVIhitG6+k2v7fmdVs1qHQOtMNdqoUsQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724527105; c=relaxed/simple;
	bh=n10LorMpuZGif2oWfQKhADEBHVwWm78vredTi659Jeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIkJTXZKt24vXXJVG0H3mZ+ncxSkq8uH+McZCluzPKTcsMHOUxRoomS6p6niInNuEHAXP/jKvbd12PA5lVH6MkC85QLEO5nVp4fJiF1eO8OPBJBWEoFPXGB6nvs543fU6PbNx1Ietc5TnkE0KRD/DaGOiniV2f6dvkkDazyGgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUHUB2W/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294B1C32781;
	Sat, 24 Aug 2024 19:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724527104;
	bh=n10LorMpuZGif2oWfQKhADEBHVwWm78vredTi659Jeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUHUB2W/yiilKyDOZEwv8fvtfvaPhtdnWuM0i3+LajieCPmPfhCroYGyH4wz2opMk
	 3colkM1g6u+HXSJycoPf5zshV9HY1uzSbUHzpZd3NHyp04l2SJJNCi2i1dP0Gq4QUV
	 pQ2SNGqzPoyAuIwlKR0JXkDn7dCwGwNl2FlRd7kEMl6uPDcBnCUhcV99HoxD9FOFAZ
	 qBdFzgQnRnVKVdRUYILrGPzdoU14cUdIohSMsGkgoKIqapYxjbvrs5aexmwMnEWYDc
	 Mapr1PFcGvyYPRdRYc2nY5d82qy+DoSpzz2jU+ZLO6W824ddFD3RxGz2Rh+hwsMC7x
	 69cQE8XLKl4Nw==
Date: Sat, 24 Aug 2024 20:18:19 +0100
From: Simon Horman <horms@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	netdev@vger.kernel.org, felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com, pablo@netfilter.org,
	laforge@gnumonks.org, xeb@mail.ru
Subject: Re: [PATCH net-next v4 05/13] flow_dissector: UDP encap
 infrastructure
Message-ID: <20240824191819.GU2164@kernel.org>
References: <20240823201557.1794985-1-tom@herbertland.com>
 <20240823201557.1794985-6-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823201557.1794985-6-tom@herbertland.com>

On Fri, Aug 23, 2024 at 01:15:49PM -0700, Tom Herbert wrote:
> Add infrastructure for parsing into UDP encapsulations
> 
> Add function __skb_flow_dissect_udp that is called for IPPROTO_UDP.
> The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsing of UDP
> encapsulations. If the flag is set when parsing a UDP packet then
> a socket lookup is performed. The offset of the base network header,
> either an IPv4 or IPv6 header, is tracked and passed to
> __skb_flow_dissect_udp so that it can perform the socket lookup
> 
> If a socket is found and it's for a UDP encapsulation (encap_type is
> set in the UDP socket) then a switch is performed on the encap_type
> value (cases are UDP_ENCAP_* values)
> 
> An encapsulated packet in UDP can either be indicated by an
> EtherType or IP protocol. The processing for dissecting a UDP encap
> protocol returns a flow dissector return code. If
> FLOW_DISSECT_RET_PROTO_AGAIN or FLOW_DISSECT_RET_IPPROTO_AGAIN is
> returned then the corresponding  encapsulated protocol is dissected.
> The nhoff is set to point to the header to process.  In the case
> FLOW_DISSECT_RET_PROTO_AGAIN the EtherType protocol is returned and
> the IP protocol is set to zero. In the case of
> FLOW_DISSECT_RET_IPPROTO_AGAIN, the IP protocol is returned and
> the EtherType protocol is returned unchanged
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

...

> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c

...

> @@ -806,6 +807,134 @@ __skb_flow_dissect_batadv(const struct sk_buff *skb,
>  	return FLOW_DISSECT_RET_PROTO_AGAIN;
>  }
>  
> +static enum flow_dissect_ret
> +__skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
> +		       struct flow_dissector *flow_dissector,
> +		       void *target_container, const void *data,
> +		       int *p_nhoff, int hlen, __be16 *p_proto,
> +		       u8 *p_ip_proto, int base_nhoff, unsigned int flags,
> +		       unsigned int num_hdrs)
> +{
> +	enum flow_dissect_ret ret;
> +	struct udphdr _udph;
> +	int nhoff;
> +
> +	if (!(flags & FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS))
> +		return FLOW_DISSECT_RET_OUT_GOOD;
> +
> +	/* Check that the netns for the skb device is the same as the caller's,
> +	 * and only dissect UDP if we haven't yet encountered any encapsulation.
> +	 * The goal is to ensure that the socket lookup is being done in the
> +	 * right netns. Encapsulations may push packets into different name
> +	 * spaces, so this scheme is restricting UDP dissection to cases where
> +	 * they are in the same name spaces or at least the original name space.
> +	 * This should capture the majority of use cases for UDP encaps, and
> +	 * if we do encounter a UDP encapsulation within a different namespace
> +	 * then the only effect is we don't attempt UDP dissection
> +	 */
> +	if (dev_net(skb->dev) != net || num_hdrs > 0)
> +		return FLOW_DISSECT_RET_OUT_GOOD;
> +
> +	switch (*p_proto) {
> +#ifdef CONFIG_INET
> +	case htons(ETH_P_IP): {
> +		const struct udphdr *udph;
> +		const struct iphdr *iph;
> +		struct iphdr _iph;
> +		struct sock *sk;
> +
> +		iph = __skb_header_pointer(skb, base_nhoff, sizeof(_iph), data,
> +					   hlen, &_iph);
> +		if (!iph)
> +			return FLOW_DISSECT_RET_OUT_BAD;
> +
> +		udph = __skb_header_pointer(skb, *p_nhoff, sizeof(_udph), data,
> +					    hlen, &_udph);
> +		if (!udph)
> +			return FLOW_DISSECT_RET_OUT_BAD;
> +
> +		rcu_read_lock();
> +		/* Look up the UDPv4 socket and get the encap_type */
> +		sk = __udp4_lib_lookup(net, iph->saddr, udph->source,
> +				       iph->daddr, udph->dest,
> +				       inet_iif(skb), inet_sdif(skb),
> +				       net->ipv4.udp_table, NULL);
> +		if (!sk || !udp_sk(sk)->encap_type) {
> +			rcu_read_unlock();
> +			return FLOW_DISSECT_RET_OUT_GOOD;
> +		}
> +
> +		encap_type = udp_sk(sk)->encap_type;

Hi Tom,

I guess a local change went astray, or something like that,
because encap_type isn't declared in this scope.

> +		rcu_read_unlock();
> +
> +		break;
> +	}

...

-- 
pw-bot: cr

