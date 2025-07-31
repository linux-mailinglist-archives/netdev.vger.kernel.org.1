Return-Path: <netdev+bounces-211232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4661B17497
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 18:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E25A831D7
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A48628E607;
	Thu, 31 Jul 2025 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1shAKTp5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC821B9DB;
	Thu, 31 Jul 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977784; cv=none; b=lygxixKaItuceEqBxawWhPx+a5bh/EpZ5aiin9BWNrOIHeTagVAdbNJ22bboQLSOmZwc+5Xgl5f0wV9PmAlM1z67UMZcIoqBY1KVULB2EcMzuXG62r6TjYIMhHcOd7JouajNClgDxP4nxQSjG5XYObRDdjx/ox67wgoak+rvHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977784; c=relaxed/simple;
	bh=dGcxc9yB51Zv0XtFk8+LA//+P7TOs76esWrPlEu5FOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIzAMIjjUrw9iIkyqvyrOf4D784Ww6bKbwI8HizkkY1GCr2aoGma/fIcbwN/bDVgBSEmROlH1R48bfSQB53jnVC1nuQiOaZWg926A2ybldHmjJi5k/c80hbB7lg4zZd1hYdDJfNwNgQBLOLmlVSe8dzrb9RB+IXWCNc3wc30OGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1shAKTp5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rzwC8YvskcqQ/u+h5BGJ/oUgeMImwjxx7We2MbfRan8=; b=1shAKTp5nDng5t9KzxwPlg8e/e
	/tT6QPmdGJ8Y+DYCYLIYRRP9s7N41NKyAA39AVxibdN+LaEdY6VNiPpS8vrSrYYeqLl2feTLRvmR7
	pHJaZ+P9tF8TcVMLWg6fwm51SREYSxB6aV+bucpu1MbBHX0QC3AM+g8NEd2kGpyNZoKG4UIAKKyuy
	PecvD2/TaTRg2Zb+9jiIcG4wB20KBzPNerapra07QeVgGiEhHYrdhti5DB9+GJshqZ4+RS3NeoefC
	N6CIPIbuDTGAV0Gts+mJC1hofznljGMZdI5j0jVHPRBhbdND4TfN036I7mk67EEv71D9wySMIqLDR
	GbCFjy5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46120)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhVk4-0005EY-2R;
	Thu, 31 Jul 2025 17:02:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhVk1-00019c-1p;
	Thu, 31 Jul 2025 17:02:49 +0100
Date: Thu, 31 Jul 2025 17:02:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aIuTqZUWJKCOZYOp@shell.armlinux.org.uk>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <4acdd002-60f5-49b9-9b4b-9c76e8ce3cda@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4acdd002-60f5-49b9-9b4b-9c76e8ce3cda@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 31, 2025 at 05:14:28PM +0200, Andrew Lunn wrote:
> On Thu, Jul 31, 2025 at 04:59:09PM +0200, Alexander Wilhelm wrote:
> > Hello devs,
> > 
> > I'm fairly new to Ethernet PHY drivers and would appreciate your help. I'm
> > working with the Aquantia AQR115 PHY. The existing driver already supports the
> > AQR115C, so I reused that code for the AQR115, assuming minimal differences. My
> > goal is to enable 2.5G link speed. The PHY supports OCSGMII mode, which seems to
> > be non-standard.
> > 
> > * Is it possible to use this mode with the current driver?
> > * If yes, what would be the correct DTS entry?
> > * If not, I’d be willing to implement support. Could you suggest a good starting point?
> 
> If the media is using 2500BaseT, the host side generally needs to be
> using 2500BaseX. There is code which mangles OCSGMII into
> 2500BaseX. You will need that for AQC115.
> 
> You also need a MAC driver which says it supports 2500BaseX.  There is
> signalling between the PHY and the MAC about how the host interface
> should be configured, either SGMII for <= 1G and 2500BaseX for
> 2.5G.

Not necessarily - if the PHY is configured for rate adaption, then it
will stay at 2500Base-X and issue pause frames to the MAC driver to
pace it appropriately.

Given that it _may_ use rate adaption, I would recommend that the MAC
driver uses phylink to get all the implementation correct for that
(one then just needs the MAC driver to do exactly what phylink tells
it to do, no playing any silly games).

> Just watch out for the hardware being broken, e.g:
> 
> static int aqr105_get_features(struct phy_device *phydev)
> {
>         int ret;
> 
>         /* Normal feature discovery */
>         ret = genphy_c45_pma_read_abilities(phydev);
>         if (ret)
>                 return ret;
> 
>         /* The AQR105 PHY misses to indicate the 2.5G and 5G modes, so add them
>          * here
>          */
>         linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
>                          phydev->supported);
>         linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>                          phydev->supported);
> 
> The AQR115 might support 2.5G, but does it actually announce it
> supports 2.5G?

I believe it is capable of advertising 2500BASE-T (otherwise it would
be pretty silly to set the bit in the supported mask.) However, given
that this is a firmware driven PHY, it likely depends on the firmware
build.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

