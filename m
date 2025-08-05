Return-Path: <netdev+bounces-211784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1511EB1BB78
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 22:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425F3183176
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 20:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236EB21C16E;
	Tue,  5 Aug 2025 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jguyKfFR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A612DDA1;
	Tue,  5 Aug 2025 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754426118; cv=none; b=fPhlyR6f3Sp3dEkiNvtfR7S+xFjsJUZXW+e8kvvKuSFD1Wkt70erGotgYFwjvXeH02mi8oovnXiqnKCZ2ivwVTLT6WZRiK3TI75uiY/oxcZa7HDDR5d2U4BYXj5w5OEhgBjjNF8O3Xkdspv81x7zFNf/rkIBaqRQ10tR5Ro11TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754426118; c=relaxed/simple;
	bh=H7XBzeHOQOWgEm/QZ/dcl/A1X93j8DES9QPGT5ycjQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qs2j1WuHAt7sm74V8Z05QTxspbQYp6xwSvZrEOa5LR2puW1TjgeUytrAwpNqbq7Gqt8zUUWZXMaiyPEZA00OFHQ/Hmv4bTfZBTF6LpT9wwpg+jt08x9Eq3w0r2+HnlGTSJaUCzk1eOF4NLZ8/GfX6sZaQB6CiJG/3EDoLm+LB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jguyKfFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ED3C4CEF0;
	Tue,  5 Aug 2025 20:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754426117;
	bh=H7XBzeHOQOWgEm/QZ/dcl/A1X93j8DES9QPGT5ycjQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jguyKfFRngCsfxtTBVg9jfUJEm7kC1fyxOpx391NO16IENeqSaSB52VWkQwixQ957
	 Ae1WShk034ikx8OFnD2Emzk3b/Q2CJPLPqyzEYhHVOBJHz3QxVGbflkz5TnOJRe/jT
	 4Rh9cXIUYqKx9wukGjT9PdpQT3nEvSpVs1dyMV0V2UhyGFL0y6OegzKqu+wz2kIfzR
	 SwMmsRXLpPOa9ahHaieVdoQgkV7a49vPoX088Nftf8/67r5V4bESpwWeh1jVqkfh0r
	 43dLfk6+VcU0PZEuv+MuhtOrDazwrKKMmC7hImcMFNpM4PVZuUBGuBDNgBcHu2peT0
	 03GAlKSL/uVng==
Date: Tue, 5 Aug 2025 21:35:12 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net-next v4 4/7] net: axienet: Simplify axienet_mdio_setup
Message-ID: <20250805203512.GD61519@horms.kernel.org>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-5-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805153456.1313661-5-sean.anderson@linux.dev>

On Tue, Aug 05, 2025 at 11:34:53AM -0400, Sean Anderson wrote:
> We always put the mdio_node and disable the bus after probing, so
> perform these steps unconditionally.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> (no changes since v1)
> 
>  drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> index dd5f961801dc..1903a1d50b05 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> @@ -302,19 +302,14 @@ int axienet_mdio_setup(struct axienet_local *lp)
>  	ret = axienet_mdio_enable(bus, mdio_node);
>  	if (ret < 0)
>  		goto unregister;
> +
>  	ret = of_mdiobus_register(bus, mdio_node);
> -	if (ret)
> -		goto unregister_mdio_enabled;
>  	of_node_put(mdio_node);
>  	axienet_mdio_mdc_disable(lp);
> -	return 0;
> -
> -unregister_mdio_enabled:
> -	axienet_mdio_mdc_disable(lp);
> -unregister:

Hi Sean,

This function still has code that jumps to unregister.
So this causes a compile error.

This does appear to be addressed in patch 6/7.
So I guess it is just an artefact of refactoring the patches
or something like that.

> -	of_node_put(mdio_node);
> -	mdiobus_free(bus);
> -	lp->mii_bus = NULL;
> +	if (ret) {
> +		mdiobus_free(bus);
> +		lp->mii_bus = NULL;
> +	}
>  	return ret;
>  }

## Form letter - net-next-closed

The merge window for v6.17 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after 11th August.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: defer

