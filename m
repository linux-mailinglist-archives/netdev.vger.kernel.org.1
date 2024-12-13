Return-Path: <netdev+bounces-151697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862F09F0A46
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D98188655F
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4005A1C07FC;
	Fri, 13 Dec 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BAynvb7w"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A409F1C3C1E
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087611; cv=none; b=C/sGO7OMfR2u17E8zlPOeuDsRLDMZkxynR+w8fhTLplaEBXc3KtMiwCPyfCZnlOH7ImUD08AtLGVH5Ckcd2NLT+5DIHlOmgkj8DGNmeLNmk53DjL7Nu5Nor2c2JVZgVEGuuET8+1lT9KtpM44dhXHKxDMm1GVjwu5pcXS4/YM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087611; c=relaxed/simple;
	bh=CVc7/ZmxdnRgoCyfzUnd5xmX4XEkW704Q7JoOUHlQLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdQbXNhRjekParSnPAxrMTTPDrB+Y6CYDiiGIrTDv+Gz6T2bNcKC2JP4MPowb6RMN1wFPaauea/ZYWeK3H1zQd9d/jwpDfc1YGGOWni1s5BbE8e7I3tmhWNYp4cpNa0iApue9wBfTxz3IgGQjRF1OvB8TTCO+QkuP/BMWpjRx1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BAynvb7w; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tW1kqG7AA7VKuaZuIchhnJLzAYeE13kvfdYICGMAvpA=; b=BAynvb7wzY0Qw60t6wnpt78/qq
	vFB1MVGBVwIRglh/GEFtMTFb03eloxHgljpyzzDUs2omP3GUblZGcLOIc9evLq0qrEPJfPUQuJgOn
	xDolDmF8a0Ag+MXGKmMfJEkKjpYABzH/x581Dt1BabS44Sbofprj51HoI5P5a622ScSqBlCT1O6yg
	MGUhQmh8uBOBzQbcKrjCJbz9aL22I/+UpbWSzVQ/3GKAjjijlwErDxyH2XgnqjPmz5V0kWQ1Tp/wO
	DpmJnZpgleUDOqghGcZs3+mDQeWuxuzTDS+83fti+X9buWRsGee9bvqHZL5FN3bQGLhto+z1CoCBv
	Kt9Qx8PQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48066)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tM3On-0006ar-0n;
	Fri, 13 Dec 2024 10:59:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tM3Ok-0006Fr-0f;
	Fri, 13 Dec 2024 10:59:54 +0000
Date: Fri, 13 Dec 2024 10:59:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/7] net: stmmac: move tx_lpi_timer tracking to
 phylib
Message-ID: <Z1wTqh-BnvPYLqU8@shell.armlinux.org.uk>
References: <Z1r3MWZOt36SgGxf@shell.armlinux.org.uk>
 <E1tLkSX-006qfS-Rx@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tLkSX-006qfS-Rx@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 12, 2024 at 02:46:33PM +0000, Russell King (Oracle) wrote:
> @@ -1092,6 +1092,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
>  			phy_init_eee(phy, !(priv->plat->flags &
>  				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
>  		priv->eee_enabled = stmmac_eee_init(priv);
> +		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
>  		priv->tx_lpi_enabled = priv->eee_enabled;
>  		stmmac_set_eee_pls(priv, priv->hw, true);
>  	}

While looking deeper at stmmac, there's a bug in the above hunk -
stmmac_eee_init() makes use of priv->tx_lpi_timer, so this member
needs to be set before calling this function. I'll post a v2 shortly.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

