Return-Path: <netdev+bounces-197565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB46FAD9331
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D583A27C5
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5CB20A5E1;
	Fri, 13 Jun 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4e4Gcyx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29E78F4F
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833505; cv=none; b=saCKUP1oJKNgN+5W5NazmDYvpgqH0z777m0JrxkSSyPEilgOCrzOr56pF7+jOKSAVMAXAPemfNS6pCVBw1ioDFyJZlf2T4BW7tYB5hD/f+zXhxGqhKyHzEbhztT9u3KP1NvdJqsQcU3H6eOCOC2jIoje2XUrsLHXCjQD/02Gjqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833505; c=relaxed/simple;
	bh=SuPFuBO2cqco/WpBvkVFCwT7Tm5cDUbK97e5J8EwUEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpQEeeXP7/Kz5mUDi/nfiM4dcGpJ7il9Y4uDaswaI7JEBJTMoOPQS5ZitFCp43cxfnuAVyAdNHD4G3LFi9zqL8aljlQMv1JdxHxDTrFTQWwta/tCzRdcWUQa9JGIpW/FYveqvL17XdW/Q8g/TJvpGN/dt/oJsGK75kexCGLLkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4e4Gcyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77529C4CEE3;
	Fri, 13 Jun 2025 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749833504;
	bh=SuPFuBO2cqco/WpBvkVFCwT7Tm5cDUbK97e5J8EwUEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b4e4Gcyxdz7vrxqmIwxjBwaK6kaSGaKmc8/+mIECMPgtWMbIJEcJXS6ZMAcGXnhLO
	 8K7SQ2zXJL84PB6Rh98wQ1mC6Ihuv0+u2qYDjuUTlHFr7ig4/geBXOhBgkyLB8aHq/
	 l4mTYpaK/gAoFdz8vrzFqay9Kr6MoFC3bAFT7B8JqUKGUmL3p8MHCqY1ljSQPR68wy
	 5E+1fGL5+lt119KM7nfo/Y07wHI57zfbJGx2BiUhgb28rZu3+56RL7HI8Or8Ac7qFd
	 MrAGpIHIyDioXbxwa2wqS6UxtG/TMWIWdIXbrGEYIX/kgHvLz0wxw51U0KP+IzhV6l
	 2L4dv2Yu2Ua6w==
Date: Fri, 13 Jun 2025 09:51:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>,
 Benjamin Poirier <bpoirier@nvidia.com>
Subject: Re: [PATCH net-next v2 04/14] net: ipv4: Add ip_mr_output()
Message-ID: <20250613095143.37b5500b@kernel.org>
In-Reply-To: <ad02c7a76fca399736192bcf7a00e8969fa15e3b.1749757582.git.petrm@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
	<ad02c7a76fca399736192bcf7a00e8969fa15e3b.1749757582.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 22:10:38 +0200 Petr Machata wrote:
> +	/* Forward the frame */
> +	if (c->mfc_origin == htonl(INADDR_ANY) &&
> +	    c->mfc_mcastgrp == htonl(INADDR_ANY)) {
> +		if (ip_hdr(skb)->ttl >
> +				c->_c.mfc_un.res.ttls[c->_c.mfc_parent]) {

weird indent?

> +			/* It's an (*,*) entry and the packet is not coming from
> +			 * the upstream: forward the packet to the upstream
> +			 * only.
> +			 */
> +			psend = c->_c.mfc_parent;
> +			goto last_xmit;
> +		}
> +		goto dont_xmit;
> +	}
> +
> +	for (ct = c->_c.mfc_un.res.maxvif - 1;
> +	     ct >= c->_c.mfc_un.res.minvif; ct--) {
> +		if (ip_hdr(skb)->ttl > c->_c.mfc_un.res.ttls[ct]) {

I'd be tempted to invert condition, continue, save a level of indent.
Presumably we expect TTL to actually be large enough so that'd also
make the expected path not under the if ?

> +			if (psend != -1) {
> +				struct sk_buff *skb2 = skb_clone(skb,
> +								 GFP_ATOMIC);
> +
> +				if (skb2)

maybe this is some local custom in this code but:

				struct sk_buff *skb2;

				skb2 = skb_clone(skb, GFP_ATOMIC);
				if (skb2)

same LoC, less ugly.

> +					ipmr_queue_output_xmit(net, mrt,
> +							       skb2, psend);

