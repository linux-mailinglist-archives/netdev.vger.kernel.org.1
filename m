Return-Path: <netdev+bounces-115843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC7A948013
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 19:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9765E287434
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9009115CD74;
	Mon,  5 Aug 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbTpKaEV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9B15C15A
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877844; cv=none; b=bO4vtGb8KlBDhwnTelNuZzX6VyhseTV8Wi+/6+HM7VYP7+WyZF62Dt+hgdEHhI8pWyozyGm+TpFnRGQGaXBvIYdy9oC3+RZITJP9R8dqcMszjlm6nxESerfhBrWeHkYf7eZkfxXq9Nmtl69klY5mNeLc3IN5HiIjSq+ofZKVP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877844; c=relaxed/simple;
	bh=HsrZ6fkYAb3f/x2iD2fPVAi/RoVIQ0NO5hgEatk9qk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZG4QIbfOczTfqodyUvKHbUJdHE9QEfLf0onFMwp+C0PYa1OueQN94g+4B0RP6sPGbIKv6jCPAQVNz/Ip8yN6Sd39f3VHh9JCgCYAmGg1zI8xeVlJLJq5gxbIBEgYyBUTSdGDGt2DFM8rT8LHs3JrQ72phRgzNNTrl1qN1HJHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbTpKaEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2830C32782;
	Mon,  5 Aug 2024 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722877844;
	bh=HsrZ6fkYAb3f/x2iD2fPVAi/RoVIQ0NO5hgEatk9qk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbTpKaEVRCs4227QwYn+CqSXYfDoJyFkb2mZ/l1aCJbyhLc32QRtrLAkFjdQH+VDm
	 /L8A6dKAGz8HJ+gFe84xShuH8GDlAsKXnoKz2egixoSaY6RJ4xkXdYO92IX5x6Ncms
	 VX47+aJJxzzswqv1ElTl8dZhCw2yfSim6+QFSz7pf9DCZSfgvF4bElgDQXVfGqwBKg
	 BlsDnazjjV+qVDCdRCuFpZpIi2B0wTx5A4qYC5pKyBQteZiemSiRpFH1NnwK6hGNIw
	 D5AaSQ3gLEkyU+ai9EfcbJzSNQBoIsgNa941Sotn7Ts8beUAdzaybIn3R3Mp7rolnW
	 meAzHGdZNVOPg==
Date: Mon, 5 Aug 2024 18:10:40 +0100
From: Simon Horman <horms@kernel.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 08/16] xfrm: iptfs: add user packet (tunnel
 ingress) handling
Message-ID: <20240805171040.GN2636630@kernel.org>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804203346.3654426-9-chopps@chopps.org>

On Sun, Aug 04, 2024 at 04:33:37PM -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add tunnel packet output functionality. This is code handles
> the ingress to the tunnel.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>

...

> +/**
> + * iptfs_prepare_output() -  prepare the skb for output
> + * @x: xfrm state
> + * @skb: the packet
> + *
> + * Return: Error value, if 0 then skb values should be as follows:
> + *    - transport_header should point at ESP header
> + *    - network_header should point at Outer IP header
> + *    - mac_header should point at protocol/nexthdr of the outer IP
> + */
> +static int iptfs_prepare_output(struct xfrm_state *x, struct sk_buff *skb)
> +{
> +	if (x->outer_mode.family == AF_INET)
> +		return iptfs_encap_add_ipv4(x, skb);
> +	if (x->outer_mode.family == AF_INET6) {
> +#if IS_ENABLED(CONFIG_IPV6)
> +		return iptfs_encap_add_ipv6(x, skb);

iptfs_encap_add_ipv6 is flagged as unused when IPV6 is not enabled.
Perhaps it should also be wrapped in a CONFIG_IPV6 check.

> +#else
> +		WARN_ON_ONCE(1);
> +		return -EAFNOSUPPORT;
> +#endif
> +	}
> +	WARN_ON_ONCE(1);
> +	return -EOPNOTSUPP;
> +}
> +

...

