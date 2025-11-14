Return-Path: <netdev+bounces-238729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF26FC5E739
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70AC34F1547
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9559298CC4;
	Fri, 14 Nov 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTAgPFuu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084128934F;
	Fri, 14 Nov 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763138726; cv=none; b=T05cjIh0yUH/KvSwk/ZjN0pPcJK9RgbBTYLDI8WIUVNv/Bj1c+6GUJ3JxctrfB6cg3S0ZKhf/B0HrV1zPbw3V/hWHSADw/fakPkOHmy17JWVrtrThkHknrtaEAzgIB3YGQAK2kdxz0BmQffyp8OUcoNolAKvuE0emdScysSxfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763138726; c=relaxed/simple;
	bh=tyQ4CiJcUc+21AjGAuoXulpVqk8DHy06PL/Fy3PLj7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6PpSF4ee0iLYZsev4IIHnfxUew+OUm37uhOxz5vIAdTMjXhIQMfJe99M90eK9yfMk8H0PjRVUxJCEf4/gyFnJps3SJC13MyCJT7pwJBIA/O3vrx12PNePWRegQjTepCUSFPn9oarlZYbg2dVYK9rUFuz1LReuEWaWRVr4Qtohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTAgPFuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D077DC116D0;
	Fri, 14 Nov 2025 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763138726;
	bh=tyQ4CiJcUc+21AjGAuoXulpVqk8DHy06PL/Fy3PLj7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rTAgPFuuXqLm10IeMFXRELduRW17vEVmcEGp6r1MGazrRgLPpTFHXYmBCFj+UBqmW
	 K/yTFkUYY3C+StUxHrJQySrHpsGGGz6tbf17LgIEX5GrtWcK6p1331FNZAhxRdz/GN
	 mFRdHTHh+g0LGkM2yC8ptQEjLZZ9jn4a2OXMWCcrClgRuzyIVzs1HcnNQ7pd4I0Ucy
	 wXaOwjuTG5aLekV0fJ4IC/jTsDhOnEspe+RVy1iDnE+x/cLe7HukU8mabTGGjpUunO
	 emtsJ2TsqXsr/HTolaqFiVwpF3jFPedE9mmFRUN8VL0/3EpA7OvzBuZUTst5KKFdZw
	 Tn2G2yIvzvKUA==
Date: Fri, 14 Nov 2025 16:45:21 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next] net: bnx2x: convert to use get_rx_ring_count
Message-ID: <aRdcoSNrFF_aIvjk@horms.kernel.org>
References: <20251112-bnx_grxrings-v1-1-1c2cb73979e2@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-bnx_grxrings-v1-1-1c2cb73979e2@debian.org>

On Wed, Nov 12, 2025 at 01:50:23AM -0800, Breno Leitao wrote:
> Convert the bnx2x driver to use the new .get_rx_ring_count ethtool
> operation instead of implementing .get_rxnfc solely for handling
> ETHTOOL_GRXRINGS command. This simplifies the code by replacing the
> switch statement with a direct return of the queue count.
> 
> The new callback provides the same functionality in a more direct way,
> following the ongoing ethtool API modernization.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


