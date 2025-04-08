Return-Path: <netdev+bounces-180442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2DBA8153F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484733A23F0
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D754D23E359;
	Tue,  8 Apr 2025 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SGJdSSs2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA513B284
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138666; cv=none; b=necXAFoHDz7a+OmoRKw5xsjskExe7niJEYfELGsNeEBcLPgqnubwCDzzhIUTKuU8gEc8C2TTUWTi0xArrwFvCOeYV53AQtfHLEWqMo4dTU8yIMy9WomIerX9F2zdtm8Eyv2xVaP9s9H0G5Cya1wWEavJbn7kZQmg29WQGiekryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138666; c=relaxed/simple;
	bh=TUn13Q2gY7307ga1NVCjItZRBMWyYVaC2yt2AXKO+Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPs5mffCE89z6XEhwdQr++o/7sGWMdpPA7fQpj7icZ32y5s/8WQX7rxSeoozlevcWYsSTx6kBBbuLiH6c23qU+Z6wmJZ4K0fWC63vWhrzrRcpez3sm9vuxqI/ltWrEj7Bw5IezzqITg3es8nzsUT8unX2AuhkylBqe6reH8ZkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SGJdSSs2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kTMv4vYxEzUm5dpYG+MypOSc4ymXE3Ae+3l357p9Ty4=; b=SGJdSSs2C7nMBvTSLvYpH/5mp4
	822hLAWwWuKqzxjVhmmfZ9Kw2Bf6JI0OmSW4ewft+6kw9z35pxbB1pwdMw9sZlC9Kpwj7nJ0tgf63
	eVS+ren+O2qPPYK+wbFnmOsgL0Nh99xIJYBx7iboI4RO7QsB7eoPij7BCQl2BDpI3/Sk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2E8e-008RHT-Jh; Tue, 08 Apr 2025 20:57:36 +0200
Date: Tue, 8 Apr 2025 20:57:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next 3/5] net: stmmac: intel-plat: remove
 eee_usecs_rate and hardware write
Message-ID: <157d8990-4dcc-4f36-ae6b-c908d1d12965@lunn.ch>
References: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
 <E1u1rgT-0013gp-97@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u1rgT-0013gp-97@rmk-PC.armlinux.org.uk>

On Mon, Apr 07, 2025 at 07:59:01PM +0100, Russell King (Oracle) wrote:
> Remove the write to GMAC_1US_TIC_COUNTER for two reasons:
> 
> 1. during initialisation or reinitialisation of the DWMAC core, the
>    core is reset, which sets this register back to its default value.
>    Writing it prior to stmmac_dvr_probe() has no effect.
> 
> 2. Since commit 8efbdbfa9938 ("net: stmmac: Initialize
>    MAC_ONEUS_TIC_COUNTER register"), GMAC4/5 core code will set
>    this register based on the rate of plat->stmmac_clk. This clock
>    is fetched by devm_stmmac_probe_config_dt(), and plat->clk_ptp_rate
>    will be set to its rate profided a "ptp_ref" clock is not provided.
>    In any case, Marek's commit will set the effectual value of this
>    register.
> 
> Therefore, dwmac-intel-plat.c writing GMAC_1US_TIC_COUNTER serves no
> useful purpose and can be removed.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

