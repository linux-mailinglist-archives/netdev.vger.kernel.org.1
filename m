Return-Path: <netdev+bounces-235428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A11C30606
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8290C4E9385
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607B5314A8B;
	Tue,  4 Nov 2025 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BajtH6nd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C942313528
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250151; cv=none; b=sUT+2u86kcUm/3XW5sErx+CBffWGO4ItX8zw9RrVHeONkWuN8RrrFFlJIUDbi580wpgXStEMod8kDO6OkJRcy9vGlhk6ylYBrtCQ/dUuhanwTVLppCZG5dKj0hjbv9KKapv0zD2nTxMZErem0SW10gim0GOSFDSzB/RqURASv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250151; c=relaxed/simple;
	bh=jraiNdtDFmypZ/0vIzMJpoD2mq4/3Rkx+q2cz0EMWmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mp40bZNfPb2pU+RCikqE/Gcs5Y2DK0IviBjwSKnlBjL0Ow7PXoTeLZfjeeavqmVBd0ZY3S7KJA8QtoJZFeQHtFqeRz8ndKMLEovJ04zhXuRO4ITJG5AW4r47v5xbsvqVdoliJB3ztDdR73qru395sTRv2KOOx0B+EdK2ogHxPbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BajtH6nd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c3GD3WtzrKWlpy2aI0UjWLqcC9jrT8mGnNqjXDUv8Jk=; b=BajtH6ndoioXThM99+Kw+0rTJv
	Gw8GLOZ3yhKQCBrgW0hjZXOIXiooqeJevBEQD3QklMWbMPQ+xvqd6ClHBHXtAz3MmMDtOc6PmSj6q
	s+grZ7qD4pPt7HC2T2a/cTCdr1POGxbXPsFAE89smW0PlGn5r24MVaIQJzgQYM8HRLVoVtwlROz2X
	6CTL+BGPxLatk/5cNnIeHK/LanaXPXuGPP77ywbuDSW64RJMPTyYQP4UlfZKm+DZQ8jqox1P0f3pr
	lemU83FfAUzaJxmbXwxtM9yj5AfWcGfXvScvq9m1Q4aHmMBbD7cl+PvmSIKFcWbEo2jjIL0siFkFA
	7aUkoIBQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39054)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGDlB-000000001ys-3e1I;
	Tue, 04 Nov 2025 09:55:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGDl7-000000004g1-3uIv;
	Tue, 04 Nov 2025 09:55:25 +0000
Date: Tue, 4 Nov 2025 09:55:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jan Petrous <jan.petrous@oss.nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next 02/11] net: stmmac: s32: move PHY_INTF_SEL_x
 definitions out of the way
Message-ID: <aQnNjWuytebZpZyW@shell.armlinux.org.uk>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
 <E1vFt4S-0000000ChoS-2Ahi@rmk-PC.armlinux.org.uk>
 <aQnJRgJqFY99kDUj@lsv051416.swis.nl-cdc01.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQnJRgJqFY99kDUj@lsv051416.swis.nl-cdc01.nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 04, 2025 at 10:37:10AM +0100, Jan Petrous wrote:
> On Mon, Nov 03, 2025 at 11:50:00AM +0000, Russell King (Oracle) wrote:
> >  /* SoC PHY interface control register */
> > -#define PHY_INTF_SEL_MII	0x00
> > -#define PHY_INTF_SEL_SGMII	0x01
> > -#define PHY_INTF_SEL_RGMII	0x02
> > -#define PHY_INTF_SEL_RMII	0x08
> > +#define S32_PHY_INTF_SEL_MII	0x00
> > +#define S32_PHY_INTF_SEL_SGMII	0x01
> > +#define S32_PHY_INTF_SEL_RGMII	0x02
> > +#define S32_PHY_INTF_SEL_RMII	0x08
> 
> Reviewed-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Thanks. One question: is it possible that bits 3:1 are the dwmac
phy_intf_sel_i inputs, and bit 0 selects an external PCS which
is connected to the dwmac using GMII (and thus would be set bits
3:1 to zero) ?

It's not really relevant as the driver only appears to support
RGMII.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

