Return-Path: <netdev+bounces-219879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6282CB438BD
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 118D74E33E0
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AB12ED15F;
	Thu,  4 Sep 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixWBUIU0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44C2135B9;
	Thu,  4 Sep 2025 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981730; cv=none; b=P9qUxKePE9KwksDlmzyVipNgMAMp/A3XlZVtNDJCzUqJZCTMMKjnZM8F3W15b0QftorKEikXikSaYFXggZJKjhFMhLIUjCFfktp0sRvt96MYKNJVTvRoSi6slLdxhEAMlgu5yxk3zIxBWgQlrYc3+XKOYzFwGuMtXN02Gb5pJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981730; c=relaxed/simple;
	bh=ErbxO5/wHN1AdSE92UHPrTjG2PfFKUR4AzwDgopvUss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKhhlKOgX+GsxBKDpzEhsPdZ18MKXegiRJdwRDCYEL/CeHI0AvAllHw3ilE0+H7XdKptnHf6EVaIBO5pb0K2D9b/syRcA2Nl3qWQfcaZslJ0IJMmBF9m+JWADGGRp44ovDLcuPNLA78lC7guyOxeZML+TMs4inptGr8TXDpe5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixWBUIU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D167C4CEF0;
	Thu,  4 Sep 2025 10:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756981729;
	bh=ErbxO5/wHN1AdSE92UHPrTjG2PfFKUR4AzwDgopvUss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixWBUIU0YQ6tHk3M8l4X1k2WTRKz+XCz6x17USQfH+ncdZ8e4t2Q3J+D+nBd3IM7Y
	 L79xi2dgRFC3nUjxYbvHDOQSIz4wokb7+6qhNNyFj+u7aXL8jh+5T5WWdTPZTvJdtf
	 UBqrZXOMiVxMAr1y1NXwzNsk8rQHLXWuuKhdH2y9QTBCPd56LWBOZ6l2aNZp5K/TSU
	 3m4czHUCYKZjBnVAGNKlID1oHbgnvpiaxD3wALS/L6W0x4t8EM8hGI8zscn5KAaZg5
	 sPKI+0kvR6HP1PNqZqYm53WHFvUfudFYgg+OLGHnzT6N5kaN6CQxiD7uU/u++e2zZZ
	 5qTCOt0zPLzTw==
Date: Thu, 4 Sep 2025 11:28:45 +0100
From: Simon Horman <horms@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't
 contain invalid address
Message-ID: <20250904102845.GG372207@horms.kernel.org>
References: <20250904031222.40953-3-ziyao@disroot.org>
 <20250904095457.GE372207@horms.kernel.org>
 <20250904095657.GF372207@horms.kernel.org>
 <aLlleb271owHNIbt@pie>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLlleb271owHNIbt@pie>

On Thu, Sep 04, 2025 at 10:10:01AM +0000, Yao Zi wrote:
> On Thu, Sep 04, 2025 at 10:56:57AM +0100, Simon Horman wrote:
> > On Thu, Sep 04, 2025 at 10:54:57AM +0100, Simon Horman wrote:
> > > On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
> > > > We must set the clk_phy pointer to NULL to indicating it isn't available
> > > > if the optional phy clock couldn't be obtained. Otherwise the error code
> > > > returned by of_clk_get() could be wrongly taken as an address, causing
> > > > invalid pointer dereference when later clk_phy is passed to
> > > > clk_prepare_enable().
> > > > 
> > > > Fixes: da114122b831 ("net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy")
> > > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > 
> > > ...
> > > 
> > > Hi,
> > > 
> > > I this patch doesn't seem to match upstream code.
> > > 
> > > Looking over the upstream code, it seems to me that
> > > going into the code in question .clk_phy should
> > > be NULL, as bsp_priv it is allocated using devm_kzalloc()
> > > over in rk_gmac_setup()
> > > 
> > > While the upstream version of the code your patch modifies
> > > is as follows. And doesn't touch .clk_phy if integrated_phy is not set.
> > > 
> > >         if (plat->phy_node && bsp_priv->integrated_phy) {
> > >                 bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
> > >                 ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> > >                 if (ret)
> > >                         return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
> > >                 clk_set_rate(bsp_priv->clk_phy, 50000000);
> > >         }
> > > 
> > > Am I missing something?
> > 
> > Oops, I missed that da114122b831 is present in net-next (but not net).
> > Let me look over this a second time.
> 
> Oops, yes. Though this is a fix patch, it should target net-next instead
> of net since the commit causing problems hasn't landed in net. Sorry for
> the confusion.

It's ok. I'm pretty good at confusing myself without any assistance.

