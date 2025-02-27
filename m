Return-Path: <netdev+bounces-170264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D18A48080
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE9617B34A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09833230242;
	Thu, 27 Feb 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zaGAyN1i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54022E3F4
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664684; cv=none; b=SeMKvNRd5NavHGV4SGTKD9/J6eCIXGC3LOSXQBdDJP+8aLErQtLf7l9J2j/0GvT886g/q4DeuEg4BNGQcPgc76TPU4XDHGHABsBwA9Km2mg3M0+v8I0cBMhu54dk0Qi1tG4D/8Nr0dKgGOkW/DBVcPsHUBBpvbCun735XhpVvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664684; c=relaxed/simple;
	bh=j61e0N27wCslNPs5xJEjmaf4nzoxdtoyBrz7d/FxS2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5GUfIOcNYiY9tIW5N7JCQuB7zJTQ7dZRoQMEZEpDaaVqHbxA4A6h7UlJHx0lHaGeF56apOQ1NksDwXd6frs6mwtoNNopJu2QfnGTJF9md1zGxM9BUomtjidNP8Yl7b691lh6U2P8nJ/ULByc127LhGRuZWbjFj2kEJtqkwpJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zaGAyN1i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N9ysxQNObpMj0tWTkCYvhUMD6pgSFGpBY5F4SuiIMoE=; b=zaGAyN1ir95YVFpBH/l2clB/C6
	ELGOAHxUhnzWb2aSaFC/W9lTCHcs4TeT1mp/5OsyXt+fMOpBjadz8IXffkh/C54sb09La7dV2y6yY
	cvYS7vsYuw0igvJqPRKwjDKjG0uCp3zspwJgqjcA8GeXvfszkkEnkxps0FTUT/6rNigA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tneOd-000bnQ-Bz; Thu, 27 Feb 2025 14:57:51 +0100
Date: Thu, 27 Feb 2025 14:57:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/11] net: stmmac: provide set_clk_tx_rate()
 hook
Message-ID: <97073a6f-3200-46da-856b-e7431e09c859@lunn.ch>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0F-0052sS-Lr@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tna0F-0052sS-Lr@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 09:16:23AM +0000, Russell King (Oracle) wrote:
> Several stmmac sub-drivers which support RGMII follow the same pattern.
> They calculate the transmit clock rate, and then call clk_set_rate().
> 
> Analysis of several implementation documents suggests that the platform
> is responsible for providing the transmit clock to the DWMAC core's
> clk_tx_i. The expected rates are:
> 
> 	10Mbps	100Mbps	1Gbps
> MII	2.5MHz	25MHz
> RMII	2.5MHz	25MHz
> GMII			125MHz
> RGMI	2.5MHz	25MHz	125MHz
> 
> It seems some platforms require this clock to be manually configured,
> but there are outputs from the MAC core that indicate the speed, so a
> platform may use these to automatically configure the clock. Thus, we
> can't just provide one solution to configure this clock rate.
> 
> Moreover, the clock may need to be derived from one of several sources
> depending on the interface mode.
> 
> Provide a platform hook that is passed the transmit clock, interface
> mode and speed.
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

