Return-Path: <netdev+bounces-237577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21420C4D59D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 447994F29D4
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC5434B416;
	Tue, 11 Nov 2025 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uYrF4xCj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF933074AA;
	Tue, 11 Nov 2025 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859275; cv=none; b=LGfOPI8MsJ/6PEi9p4znfM5G8tHncTCLHN1oWhYI6PB/PK64vNUMzjMM6sfbq/dN2TE8imi8RZpR3jV75E9WDursdoir/+XW/l7Noc8A/jml7IyVqd0/jCEueN4etzNg2/3p3STQzD8y87sKsKeVo+q39PafhtKzqfSdKafXO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859275; c=relaxed/simple;
	bh=hBoKi8T7wh9LfRJDliVbP3JmLVzjjh7uoJOL3pAbrTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7WeGUWiqB97sdhUH5se2SH1QpJN0JyGXcWAnXxlAsNiEVtqJ7jhjp5vnlCKQGvNgBO1DebTm3JxeTlVQ4WMlw6JzgHt/7QDx5etj31Y5VgU1D14Q0b5TumgbqKW+sYLwDUMyDEvoIXlGrmyo3Zi2sj7UxvBOOD+HLrpLJUgvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uYrF4xCj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uifBXMa1C5ZNlcHfMF2Hg7gQ1vHtDAL5DkdT9yrJ1+s=; b=uYrF4xCjo+e3Z2oLUkpdYXb1u0
	E7rKnasq8sigoihKprilrq8KShhq6dsm2N/ZrrRhJ+QSaqCJ05z7KtEbpX1UYr4px3VeedQ25tKuC
	3GaOO93ZvW/dO/Z1iArulF5i2f9V55+2gpO+W+X22UVPMtnaRMYV2k68iToCsWQPnwOQcjmQrapKy
	ZBGNzVeqamjHVEqix9KD2NlHwtSAYChYDZYfHsGoyGhImbOrOwTxIo4p80h5H1oNuYKc9pdXkWds3
	L123dec6HDSBgjFE93yLeZ7CE6SwTN5XZHvuhBa9HRJGP8jss9KLfztd3jYWqNHJmsL5AZgbqLKs0
	LE8MklNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41764)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vImDk-000000002Si-27t5;
	Tue, 11 Nov 2025 11:07:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vImDc-000000002t0-2gFg;
	Tue, 11 Nov 2025 11:07:24 +0000
Date: Tue, 11 Nov 2025 11:07:24 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Runhua He <hua@aosc.io>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
Message-ID: <aRMY7GyocIJkgzZ2@shell.armlinux.org.uk>
References: <20251111105252.53487-1-ziyao@disroot.org>
 <20251111105252.53487-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111105252.53487-3-ziyao@disroot.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 11, 2025 at 10:52:51AM +0000, Yao Zi wrote:
> +	plat->bus_id		= pci_dev_id(pdev);
> +	plat->phy_addr		= -1;
> +	plat->phy_interface	= PHY_INTERFACE_MODE_GMII;
> +	plat->clk_csr		= STMMAC_CSR_20_35M;
> +	plat->tx_coe		= 1;
> +	plat->rx_coe		= 1;
> +	plat->maxmtu		= JUMBO_LEN;
> +	plat->rx_queues_to_use	= 1;
> +	plat->tx_queues_to_use	= 1;
> +	plat->clk_ref_rate	= 125000000;
> +	plat->core_type		= DWMAC_CORE_GMAC4;
> +	plat->suspend		= stmmac_pci_plat_suspend;
> +	plat->resume		= motorcomm_resume;
> +	plat->flags		= STMMAC_FLAG_TSO_EN;

Can you also set STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP here, so if EEE
is used, we can shut down the transmit clock to the PHY if the PHY
supports that? I would like all new glue drivers to set this where
possible please.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

