Return-Path: <netdev+bounces-147526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D43C9D9EFA
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 22:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07474165ECE
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4961DF257;
	Tue, 26 Nov 2024 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FFYZHdso"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF01DDA24
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657420; cv=none; b=dDi3BvzKyvErbTio9/A++QFT4oEhD2tRG8+6uAHP3k90f0j7HjcCLSXB+8OJv8DIvx0xrFXxurAvJ9G/4V5dRBwcnHKZB1him+gB+oU5viEp9KS/MgUf8X1LOtyPick3pvv2M31FdFKGyt905SOOU1ms33gIjG9TLhAAzU2TGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657420; c=relaxed/simple;
	bh=RhMVcfwDjgwApC2eBZUZBrY6cSLZUrEhkmUR5nW0adQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fihPDo4P4Kgk8wLQzztYNaRswB1F0a72u9gip5pKRJGhztotd1zFZtUntXRO2a/vS6NnI4FYFg4upQTRChOlrdArLgETgazZbKwybObUbhv27WmESgV7Thgss+jmw6K5DEzE0MYRl+EoGlbzc/Qft0rryfdmxcXR9MOxVKOL9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FFYZHdso; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=boX705ixGpX0WIhU4HsHMX1LO3WzB02Fz6xUUWqOtdg=; b=FFYZHdsokE0B/sNH1TVhXQGepS
	YcmDSz+0gpqG1KHdFM+5lQSHUBjhH3JTcTxjsWMGBxw97s+9LgiKBrZ6JHQ8SP9i8jdvCC7JSh+li
	Es0g3quRaeHJHsL821rY4mu0+0mn7maNDYLja9l6cKU6I/Huw1bvCXGedqsTIp86fRhiPCDb+MrFO
	XrcZS7Pf122Mv76xy3DRRXKia8j4I5lUL3KjUYupkfQ0B2hTvGg5X2s9xIBSukMvBGEVwPeEnG/gy
	WtaRvGmHOzJS8CSgTXQ8fS+ih3MYTXXgIsHBV9H3tS+OxaWJoEZff9lTCK7JH56wkQVYXM5YWJI0y
	L3KwSlOA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42268)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tG3L5-0007k1-2T;
	Tue, 26 Nov 2024 21:43:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tG3L0-0004sg-1X;
	Tue, 26 Nov 2024 21:43:14 +0000
Date: Tue, 26 Nov 2024 21:43:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 15/16] net: phylink: add negotiation of
 in-band capabilities
Message-ID: <Z0ZA8u0QrCKVA6pe@shell.armlinux.org.uk>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
 <E1tFrp6-005xR2-6W@rmk-PC.armlinux.org.uk>
 <e8a11b23-3918-458f-8888-4ca32058968a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a11b23-3918-458f-8888-4ca32058968a@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 26, 2024 at 10:18:56PM +0100, Andrew Lunn wrote:
> > +		if (pcs_ib_caps && pcs_ib_caps != LINK_INBAND_DISABLE) {
> > +			/* PCS supports reporting in-band capabilities, and
> > +			 * supports more than disable mode.
> > +			 */
> > +			if (pcs_ib_caps & LINK_INBAND_DISABLE)
> > +				neg_mode = PHYLINK_PCS_NEG_OUTBAND;
> > +			else if (pcs_ib_caps & LINK_INBAND_ENABLE)
> > +				pcs_ib_only = true;
> > +		}
> > +
> > +		if (phy_ib_caps && phy_ib_caps != LINK_INBAND_DISABLE) {
> > +			/* PHY supports in-band capabilities, and supports
> > +			 * more than disable mode.
> > +			 */
> > +			if (phy_ib_caps & LINK_INBAND_DISABLE)
> > +				pl->phy_ib_mode = LINK_INBAND_DISABLE;
> > +			else if (phy_ib_caps & LINK_INBAND_BYPASS)
> > +				pl->phy_ib_mode = LINK_INBAND_BYPASS;
> > +			else if (phy_ib_caps & LINK_INBAND_ENABLE)
> > +				phy_ib_only = true;
> 
> Looking at the different handling between PCS and PHY, i asked myself,
> does PCS BYPASS exist? If it is invalid, i don't see a check if the
> PCS is reporting it and should we be issuing a warning?

Yes, it does exist - see for example MVNETA_GMAC_AN_BYPASS_ENABLE for
mvneta - but there's complications to using it that need sorting first.

The problem is if SGMII enters bypass mode, then the duplex is
configured according to MVNETA_GMAC_CONFIG_FULL_DUPLEX. In wonderful
Marvell style, it makes no mention about the speed setting. It does
say that it's supported for "SGMII modes". One assumes that it would
do the same thing and fall back to setting described by the two speed
bits, but the documentation doesn't say that. Maybe "SGMII modes" is
referring to Base-X only and not Cisco SGMII.

The problem of what seems to be almost an industry wide abuse of the
"SGMII" term creating a trainwreck strikes again!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

