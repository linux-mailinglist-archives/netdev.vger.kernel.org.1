Return-Path: <netdev+bounces-203124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15947AF08A3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD4D7A4B28
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FFA1B0439;
	Wed,  2 Jul 2025 02:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eICL/c+k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9041149C64
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424190; cv=none; b=HdzdjFNTcG6Ml8kluu9YS/Xq29EnAqCMG3l8dnyr+YMy3vXQmOYDnAi6b9NMmy6MY384H1aPqDJQocOAQxGhJ9jURzf+PYT1w9mStKOtgc3A3vULUZGc3nmYKIqEO8jJHd5vDysJMTqGuvK22Jy1WYUWqCtKyb/uBdtpxjo2dgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424190; c=relaxed/simple;
	bh=IzAdJAiN7T3Zipdm0YPllcTD7NazI5EY7ANdPTXCdwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZ/xLbhMEtPWN6/0sL1uDOsxoB43a5+7hQ8dpF/E93QY1q9ZRjXEJ9uy+3kxZw7d20gy85oxJvTLVTMq+8XF9AKAMzpu7l430FYqgHpy0H3VkfD8wCQeqK0E3BRAk3oAp30nqkG/A+6NFKW0OFb05qSf0egW0BXDYQCXUv62b+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eICL/c+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D598AC4CEEB;
	Wed,  2 Jul 2025 02:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751424190;
	bh=IzAdJAiN7T3Zipdm0YPllcTD7NazI5EY7ANdPTXCdwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eICL/c+kBcJHHA+plrQUBkoID+nCxReg/yRdLqPNazhk0DhJW6VT6SdnQkMXFPW7J
	 Zvo0KXrGP5d77sRLhk2vwkozPJP7B2jzezc0BpSHu82Sa5JxjhZ+iCpFv9izR20XMU
	 whOFhf/5x0BkDeYRAUK02yGVlk/WQUXEhE/LeTJsXvoXBIIfPe4pQzcJ7YngU7HVSf
	 uMOjj/ddHupcS1wUA0ev6QjPXhfHkbOQrqn8pixGZ+5pHwHFATMm41ao2HX5mnAyS0
	 tLUheNTUsMcb5Ah7I2IBV5lUBNR/AJcdxRZc+PtgmpiUF9stQvkpmm5PysSarkDlLj
	 SVtFR0Kue7j1A==
Date: Tue, 1 Jul 2025 19:43:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
 leon@kernel.org, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 3/5] eth: mlx5: migrate to the *_rxfh_context
 ops
Message-ID: <20250701194309.1dcb7467@kernel.org>
In-Reply-To: <14654215-aa09-48c5-a12d-9fa99bb9e2cc@nvidia.com>
References: <20250630160953.1093267-1-kuba@kernel.org>
	<20250630160953.1093267-4-kuba@kernel.org>
	<14654215-aa09-48c5-a12d-9fa99bb9e2cc@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Jul 2025 09:25:41 +0300 Gal Pressman wrote:
> > +	mlx5e_rx_res_rss_get_rxfh(priv->rx_res, rxfh->rss_context,
> > +				  ethtool_rxfh_context_indir(ctx),
> > +				  ethtool_rxfh_context_key(ctx),
> > +				  &ctx->hfunc, &symmetric);  
> 
> We don't expect it to fail so no return value check here, but maybe a
> WARN_ON_ONCE() should be added?

Hm.. you know what, I think I'll pop that WARN_ON_ONCE() inside
mlx5e_rx_res_rss_get_rxfh() and make it return void. Core doesn't
call get_rxfh for custom contexts any more, the only calls to
mlx5e_rx_res_rss_get_rxfh() are this one right after creation
and the one that asks for context 0, which I suppose must always exist.

