Return-Path: <netdev+bounces-222601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11296B54F52
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D89178C53
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0730DEC9;
	Fri, 12 Sep 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWYGeY8o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A412E11B5;
	Fri, 12 Sep 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683287; cv=none; b=Sub3RC9qOXswveaQm+JarvlgqmXuRZSxgNaVOa/6i1YfDUKnnq0L4jwWG1oKyyuRVT7QbPeS6O0HzM9iC7XjGOn5fG6tDoZx4VLwCbYFczHxWiOgb8DQbcFfSVvjIigXRyxJ7EJIk9gd8RJ9E4azqBRhoq9KG2t3BZOLDf1gE2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683287; c=relaxed/simple;
	bh=0/a4bZbKqKLmmuf31DqslpGedrcCK4QX5cT92RkrRrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNQSt5RGbCp9lXHFBQwUlkiHenh9lYM55neT84snAKYGPZOR+nSMyemg3Ga47fQHd0075zM+i/Wdsq2qm7t0tTZ0PzJofd5YTbPSx+EEak5IxND6JN7MRpmoad10rVuPiWu/2wcuARoMDXNL+2gV3lqeXPZKmGtWGy3Co072EbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWYGeY8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF70C4CEF1;
	Fri, 12 Sep 2025 13:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757683287;
	bh=0/a4bZbKqKLmmuf31DqslpGedrcCK4QX5cT92RkrRrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWYGeY8oWWwHLTHWmemqWzFIcjY/HijvgHLWH82qdFHaxV36H+8h9IJnK8QpodcV9
	 CqrmyHETI0FW16l2Vl+zH2smKSz9OyX6GyHJqLbfFTm/3/Mq+UBTv2zgAZHyFxqTyt
	 NdNRLhq80Y6W71rohaJc7kMcGmE7qx6iT9BesAF3evKYbRfFkLSOQgfQuw9gkka1dE
	 BFOyTxVh1a+BMVe2W8dECdCqB6wieAYUpaEYjhP/D/UPdq4g2mYSoZeerjzVg3KFg3
	 aOmN0SSgp+vRza7wJcpNttI/8r7vjymPq7aO8BP5AjTgHpWGFcXbsWdPUR8PI4GAwr
	 Tuhuisg+DL1uw==
Date: Fri, 12 Sep 2025 14:21:23 +0100
From: Simon Horman <horms@kernel.org>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: natsemi: fix `rx_dropped` double accounting on
 `netif_rx()` failure
Message-ID: <20250912132123.GB30363@horms.kernel.org>
References: <20250911053310.15966-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911053310.15966-2-yyyynoom@gmail.com>

On Thu, Sep 11, 2025 at 02:33:06PM +0900, Yeounsu Moon wrote:
> `netif_rx()` already increments `rx_dropped` core stat when it fails.
> The driver was also updating `ndev->stats.rx_dropped` in the same path.
> Since both are reported together via `ip -s -s` command, this resulted
> in drops being counted twice in user-visible stats.
> 
> Keep the driver update on `skb_put()` failure, but skip it after
> `netif_rx()` errors.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>

Thanks for your patch,

Thinking out loud: Adding use of ndev->stats to drivers that don't already
do so is discouraged. But here, an existing use is being fixed. And I agree
it is a fix. So this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

