Return-Path: <netdev+bounces-115902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F929484D9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F981C22072
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FB716EBF4;
	Mon,  5 Aug 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdUP0i7P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E91D16D4C5
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893372; cv=none; b=bjBAE0vDyp35iMQNAvDQV0rAHgb2jWTp7/b7j06rneDPepUhij8SjxISQIPOCWB8kj8OOe2YkvSmSgrp72vPhHnXZNLgOFgaX0BKQKUPGTGVa912pPF4ifp+czFESwgo87Fwx6IVfb5xmezNSCtc3FCQHB1ecJaSubRHfkw47gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893372; c=relaxed/simple;
	bh=wS+QILf0gmoqMDisDoG2xNEVyZUfVd2Z0P8GEqLK2zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddvmnrfRYu7lwbaU3Rst6wzwQhjbU3ICWxhxvQh6F3n8Zh1wBLiuPPDiPingV8CamwH//n/XbHrRr1026rcYD197+a2wfAhwrFEnqkXsuOai5UjEVrLe8Ooikt9LbKgeO3MOENHjG0uSH8LuCV1YBZFhulvLaqlj9p7jeWbkbKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdUP0i7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608E8C32782;
	Mon,  5 Aug 2024 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722893371;
	bh=wS+QILf0gmoqMDisDoG2xNEVyZUfVd2Z0P8GEqLK2zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cdUP0i7PMaNwiT8jLGJbDLtkR325n2vMU27sipKhMX4oPHsEj2i9YS0GkbgYqFclw
	 92ku89V3nMAObf+iNjuE+S7j93hC2MpQLdLjNBtyNVeGuxs4zinIYtiheziqKl+C9O
	 qGch2YZ9TQx98ZNhGtae8FAMVEcKovZMKxmeKGrH74U78LYA4FSzXiVNzBZwyOkpSZ
	 /EhIIicCi/FGMN0yV/kc7pTYJUcoLTr5hzEne24ouHuSwHSMTBjuTzmQj9uBRdTTu1
	 mvRQZTCk59QUdQvXfTAGLyRLqE2NebMCIflw55WxDFIOXUMfDq8KR+lewqtXTkTrUP
	 SEGWsCG5dbIeA==
Date: Mon, 5 Aug 2024 14:29:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com,
 donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
 willemdebruijn.kernel@gmail.com, jdamato@fastly.com,
 marcin.s.wojtas@gmail.com, linux@armlinux.org.uk
Subject: Re: [PATCH net-next v2 02/12] eth: mvpp2: implement new RSS context
 API
Message-ID: <20240805142930.45a80248@kernel.org>
In-Reply-To: <1683568d-41b5-ffc8-2b08-ac734fe993a7@gmail.com>
References: <20240803042624.970352-1-kuba@kernel.org>
	<20240803042624.970352-3-kuba@kernel.org>
	<1683568d-41b5-ffc8-2b08-ac734fe993a7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Aug 2024 12:25:28 +0100 Edward Cree wrote:
> > mvpp2 doesn't have a key for the hash, it defaults to
> > an empty/previous indir table.  
> 
> Given that, should this be after patch #6?  So as to make it
>  obviously correct not to populate ethtool_rxfh_context_key(ctx)
>  with the default context's key.

It's a bit different. Patch 6 is about devices which have a key but 
the same key is used for all contexts. mvpp2 has no key at all
even for context 0 (get_rxfh_key_size is not defined).

> > @@ -5750,6 +5792,7 @@ static const struct net_device_ops mvpp2_netdev_ops = {
> >  
> >  static const struct ethtool_ops mvpp2_eth_tool_ops = {
> >  	.cap_rss_ctx_supported	= true,
> > +	.rxfh_max_context_id	= MVPP22_N_RSS_TABLES,  
> 
> Max ID is inclusive, not exclusive, so I think this should be
>  MVPP22_N_RSS_TABLES - 1?

I totally did check this before sending:

 * @rxfh_max_context_id: maximum (exclusive) supported RSS context ID.  If this
 *	is zero then the core may choose any (nonzero) ID, otherwise the core
 *	will only use IDs strictly less than this value, as the @rss_context
 *	argument to @create_rxfh_context and friends.

But you're right, the code acts as if it was inclusive :S

Coincidentally, the default also appears exclusive:

	u32 limit = ops->rxfh_max_context_id ?: U32_MAX;

U32_MAX can't be used, it has special meaning:

#define ETH_RXFH_CONTEXT_ALLOC		0xffffffff

These seem like net-worthy fixes, no?

