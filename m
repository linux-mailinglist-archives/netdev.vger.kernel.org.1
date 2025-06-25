Return-Path: <netdev+bounces-201269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C9AE8B18
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 19:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCCB3A7E45
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6882BE7CD;
	Wed, 25 Jun 2025 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNLDT6tN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33222D2393;
	Wed, 25 Jun 2025 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870806; cv=none; b=ek3mveEBa3pVyoG9mZWt+ud5iY+0CPoBcq9KxAjtqlK9NC5yCB0MEos2OTrmg5S765xopXwEFlLl55njyq63+fnHs2LHa6AHKafyFCuIw7qvOV0+cRr3TJPsxDctirvbld306cRnoa78BkxCQiwkV3k2xOKbVp6sY1RaN8E57yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870806; c=relaxed/simple;
	bh=Cj90ZgPv6v+ZOG+7KTn7if6OZVYZh9MbJWky7ycDd4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mj6kN/ge5HtpKDJsiqUjJvlvpY0pOrSVRtoVrB/ZB2USfGBDWiQrg38pp8DYw0wwjjop5GOv3MHANaZ55HfBbaJJSVPOTvhpmQ/DZruOLvNElOxop5E3KTOXe4UIFeyf99/B9bEYkrnBdWsGtj7Z5BwqgCIv+uxdlXOaM9qDUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNLDT6tN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4875C4CEEA;
	Wed, 25 Jun 2025 17:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750870805;
	bh=Cj90ZgPv6v+ZOG+7KTn7if6OZVYZh9MbJWky7ycDd4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNLDT6tNHUxQNg+AaT94OSuubCCZT54XvJ/Gelecc926Pqpqlw2wqzVA3CMpDTSs1
	 U6JtT+NR+fsenQCx5unlcUIAo4/ukSREWDtF+3Gmn4Q+VrOrQN55N9PNE2NaDiyG3+
	 DZ2RhIJOYv+kCZssXHl4WnLqT/HKHZb0dZsU+Os2PquGh696Q85GHmSTL0G34A5rtQ
	 ASz/NfdMf1JL9RudDM2sKM1BhBHTj20TaR+fIl1PQxIr/jvQCHrHHdq0PAJmBnzrAh
	 pFbJYFbq4Ne5nq5WPckWyKbh43u6IReVPMcvUo94U5eKZsWRThdGDajF7lgnSTEybm
	 6AtWqCioNQ4Hw==
Date: Wed, 25 Jun 2025 18:00:01 +0100
From: Simon Horman <horms@kernel.org>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	ioana.ciornei@nxp.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net] dpaa2-eth: fix xdp_rxq_info leak in
 dpaa2_eth_setup_rx_flow
Message-ID: <20250625170001.GI1562@horms.kernel.org>
References: <20250625104339.GW1562@horms.kernel.org>
 <20250625125547.19602-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625125547.19602-1-wangfushuai@baidu.com>

On Wed, Jun 25, 2025 at 08:55:47PM +0800, Fushuai Wang wrote:
> >> When xdp_rxq_info_reg_mem_model() fails after a successful
> >> xdp_rxq_info_reg(), the kernel may leaks the registered RXQ
> >> info structure. Fix this by calling xdp_rxq_info_unreg() in
> >> the error path, ensuring proper cleanup when memory model
> >> registration fails.
> >>
> >> Fixes: d678be1dc1ec ("dpaa2-eth: add XDP_REDIRECT support")
> >> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> > 
> > Thanks, I agree this is needed.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > But I wonder how these resources are released in the following cases:
> > 
> > * Error in dpaa2_eth_bind_dpni() after at least one
> >   successful call to dpaa2_eth_setup_rx_flow()
> > 
> > * Error in dpaa2_eth_probe() after a successful call to
> >   dpaa2_eth_bind_dpni()
> > 
> > * Driver removal (dpaa2_eth_remove())
> 
> Hi, Simon
> 
> I think these paths also leak xdp_rxq_info.
> I'll add cleanup for them and send v2 shortly.

Great, thanks.

