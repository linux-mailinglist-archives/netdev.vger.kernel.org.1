Return-Path: <netdev+bounces-161901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4441BA247F4
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 10:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6483A81D7
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8C126C02;
	Sat,  1 Feb 2025 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hDjcR9JJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C905BA34;
	Sat,  1 Feb 2025 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738401634; cv=none; b=hMadfFGLax/GS8WOdIsbpA6ZJz2rdVLRvXAOpiSNizH4KfD2T1dWdlnxgiv68l7vSGdnh9XzFRs2ykJiyx62YXIkWdHRHYyBlMgvKMIhrAf2W70XKs7ut0NiJj78jbZ7zmeeF+5iFh6PD+P6ozo3sWddj3gWdIoG1GZY0h/jr3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738401634; c=relaxed/simple;
	bh=88QZCiJ/E5yVGj+dInL7M8Qo9HGF0txNSyN+I3eGtUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAniIORyl1T37AZCXX4q5+ygTNBfzPjn+1sFc7XlP40evjW7m32c22U5Vb5qrLBQoOmg0o0BInRVoO3OoejUrsd6wE/lZqAhDAq5zqslZqCvioVKHYeKmKs0Wxm1oSMpAej3PZHUxqKRmHwAfSSvLpxfrfkiiG+Mtm++RQ1PBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hDjcR9JJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NABKLZ3cQMbB3qNj2fTiRb+22S35Pg3r8c3gmdy5sdY=; b=hDjcR9JJx2Dck7oYyjMYofG4Jd
	FYGGCR2dQqlsOFEq+7ZigpBfSp78O7TCYbXnCZWDZLQYldwZ1nT75F8Y1xDDnSTr6zvNMeRRCBHkx
	rtGnLDdAIFr8fcU+2bRlBHfx+oplhluh4ANNCA1/1Ahc8Zw882R2rcXE2FAZqaJDtPIEZMFXWqBgJ
	Rka8PjgTQYjkJSNEKtHgkshbQww8FJ0jkkyNfEEKsUtdZQpDL6oP9ZH+sHi4/QOCTd2GOrQQLikhG
	1K4LfNi86bZoM3cxDMfAOccSVhqjYvbT3LTZm4lZISBR9SJKeQbXkRVRL1K9Sc0im2y5VVbGB5kVt
	cwogsK0A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55052)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1te9fj-0001WT-0V;
	Sat, 01 Feb 2025 09:20:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1te9fe-0006j5-0R;
	Sat, 01 Feb 2025 09:20:10 +0000
Date: Sat, 1 Feb 2025 09:20:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: olteanv@gmail.com, Woojung.Huh@microchip.com, andrew@lunn.ch,
	hkallweit1@gmail.com, Jose.Abreu@synopsys.com,
	maxime.chevallier@bootlin.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sadhan.Rudresh@synopsys.com,
	Siddhant.Kumar@synopsys.com
Subject: Re: [WARNING: ATTACHMENT UNSCANNED]Re: [WARNING: ATTACHMENT
 UNSCANNED]Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <Z53nSexf2BaUQiCY@shell.armlinux.org.uk>
References: <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250130100227.isffoveezoqk5jpw@skbuf>
 <Z5tcKFLRPcBkaw58@shell.armlinux.org.uk>
 <DM4PR12MB5088BA650B164D5CEC33CA08D3E82@DM4PR12MB5088.namprd12.prod.outlook.com>
 <Z5zxC3hwk4C0s456@shell.armlinux.org.uk>
 <DM3PR11MB87369DE499570C4D4A6E3C9FECEB2@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB87369DE499570C4D4A6E3C9FECEB2@DM3PR11MB8736.namprd11.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 01, 2025 at 01:12:00AM +0000, Tristram.Ha@microchip.com wrote:
> > On Fri, Jan 31, 2025 at 02:36:49PM +0000, Jose Abreu wrote:
> > > From: Russell King (Oracle) <linux@armlinux.org.uk>
> > > Date: Thu, Jan 30, 2025 at 11:02:00
> > >
> > > > Would it be safe to set these two bits with newer XPCS hardware when
> > > > programming it for 1000base-X mode, even though documentation e.g.
> > > > for SJA1105 suggests that these bits do not apply when operating in
> > > > 1000base-X mode?
> > >
> > > It's hard to provide a clear answer because our products can all be modified
> > > by final customer. I hope this snippet below can help:
> > >
> > > "Nothing has changed in "AN control register" ever since at least for a decade.
> > > Having said that, bit[4] and bit[3] are valid for SGMII mode and not valid
> > > for 1000BASE-X mode (I don't know why customer says 'serdes' mode.
> > > There is no such mode in ethernet standard). So, customer shall
> > > leave this bits at default value of 0.  Even if they set to 1, there is no
> > > impact (as those bits are not used in 1000BASE-X mode)."
> > 
> > Thanks for the reply Jose, that's useful.
> > 
> > Tristram, I think you need to talk to your hardware people to find out
> > where this requirement to set these two bits comes from as it seems it
> > isn't a property that comes from Synopsys' IP (I suppose unless your
> > IP is older than ten years.)
> > 
> > That said, Jose's response indicates that we can set these two bits
> > with impunity provided another of Synopsys's customers hasn't modified
> > their integration of XPCS to require these bits to be set to zero. So,
> > while I think we can do that unconditionally (as per the patch
> > attached) I think we need a clearer comment to state why it's being
> > done (and I probably need to now modify the commit message - this was
> > created before Jose's reply.)
> > 
> > So, I think given the last two patches I've sent, I believe I've
> > covered both of the issues that you have with XPCS:
> > 
> > 1) the need to set bits 4 and 3 in AN control for 1000base-X in KSZ9477
> >    (subject to a better commit message and code comment, which will be
> >     dependent on your research as to where this requirement has come
> >     from.)
> > 
> > 2) the lack of MAC_AUTO_SW support in KSZ9477 which can be enabled by
> >    writing DW_XPCS_SGMII_MODE_MAC_MANUAL to xpcs->sgmii_mode.
> > 
> > We now need to work out a way to identify this older IP. I think for
> > (2) we could potentially do something like (error handling omitted for
> > clarity):
> > 
> >         if (xpcs->sgmii_mode == DW_XPCS_SGMII_MODE_MAC_AUTO) {
> >                 xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL,
> >                             DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW,
> >                             DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW);
> > 
> >                 ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL);
> > 
> >                 /* If MAC_AUTO_SW doesn't retain the MAC_AUTO_SW bit, then the
> >                  * XPCS implementation does not support this feature, and we
> >                  * have to manually configure the BMCR for the link parameters.
> >                  */
> >                 if (ret >= 0 && !(ret & DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW))
> >                         xpcs->sgmii_mode = DW_XPCS_SGMII_MODE_MAC_MANUAL;
> >         }
> 
> The IP document says version 3.10a and has date August 2013.
> 
> Indeed it does not make sense to use SGMII_LINK_STS and
> TX_CONFIG_PHY_SIDE_SGMII in 1000BASEX mode.
> 
> My thinking is there may be a hardware bug to prevent 1000BASEX mode to
> work when auto-negotiation is enabled.  And somehow setting those bits
> workaround that, and those bits have different meanings.
> 
> In order not to use those bits auto-negotiation needs to be disabled.  Is
> there a way to do that in normal driver activation?

You do not want to do that. While you may negotiate with a PHY using
1000base-X that has "bypass" mode enabled, anything that doesn't have
a "bypass" mode or has it disabled won't work.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

