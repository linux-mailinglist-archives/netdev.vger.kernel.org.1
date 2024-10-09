Return-Path: <netdev+bounces-133712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236F8996C50
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AA81C20A0E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEF2198E61;
	Wed,  9 Oct 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fog81OU1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C1198A25;
	Wed,  9 Oct 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481072; cv=none; b=ES2NIbi0KWbocD7wOBQ80Q4foe02hD4ZUhQbfbnJqfDPN/4wFz30S2IacmhhaEoR/g4V7AcVcApwQXVl6GrOD6RoptT1iAmwr8sNf1uCtM/TyLpgoI4N8e7gL0jxdI4KaxsQg6R57/l2DsL7XAA7KQfxiJUxyn6dO5wEdpfww+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481072; c=relaxed/simple;
	bh=FRa49j8KQxaEOnV6Aimw0MapA9Lysb1eUV6fb8guLTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx043RvB1YrrbMW2CAo4BF6WsteAOAJzHDPzQNXf76Lkkwd9ZNz8CdYkueqqFZrJXEdvmzKh6ljUsXFQHtoKD9J5pe9LTFSfPkiEBcGWGwdVmjyEi+r9l6FE7gEVEz1RY3poor3cwAFc8L/abTHL4Hp2PRatTciKVkvsKYLv00s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fog81OU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F61C4CEC5;
	Wed,  9 Oct 2024 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728481072;
	bh=FRa49j8KQxaEOnV6Aimw0MapA9Lysb1eUV6fb8guLTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fog81OU15SqVibKE4ULX0GWqPjxySqR9iQkFhoG7Qrgh+sjEKjEI8tC+1B2JX0nAh
	 IifWunaa7QikR0rVQ1mLepIc7/nT2omPiDKEVMDN4NZxKdihVGI+2sIHIFIVsYXcwH
	 O3zbBwAooir1zCCX3T0np3XdueXnN/axVJhr23NJ6RWZd4JdRHBikE0IztdTttyN/G
	 pwGOQkAjJgzq3ftVPi76dQRFZyndfjPASz2cXJajiTQoLybbwRaCl32A65R7x4MhQu
	 7vcSit3RFdj/9CfoOG5geujoSiyr8TOsywt53nbMATEnLbPCCmxiN3BSkfbM123OU+
	 daPaJN9FqRkaA==
Date: Wed, 9 Oct 2024 14:37:46 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 03/12] net: tunnel: make
 skb_vlan_inet_prepare() return drop reasons
Message-ID: <20241009133746.GA99782@kernel.org>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-4-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009022830.83949-4-dongml2@chinatelecom.cn>

On Wed, Oct 09, 2024 at 10:28:21AM +0800, Menglong Dong wrote:
> Make skb_vlan_inet_prepare return the skb drop reasons, which is just
> what pskb_may_pull_reason() returns. Meanwhile, adjust all the call of
> it.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v5:
> - make skb_vlan_inet_prepare() return drop reasons, instead of introduce
>   a wrapper for it.
> v3:
> - fix some format problems,  as Alexander advised

Reviewed-by: Simon Horman <horms@kernel.org>


