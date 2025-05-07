Return-Path: <netdev+bounces-188629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9932BAADFDF
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6827C7B4A93
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D79C286402;
	Wed,  7 May 2025 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l6okT1Cl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850212868B9
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622597; cv=none; b=t4VyUuEbgtZIs5tNMut1s8Wp9MeHLIdCMFpeh/y2qDQELzEKLDJDLiacoXss57ARGCuOkrD/sMfaES9p237vJSUTI22vySU8WgMNYN2VjnCsAfUmb9NxVqIYGLc2sMYSTcuoAKGRuFk7t/gGI330Mxha4LjORX/7u6bL78sM8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622597; c=relaxed/simple;
	bh=pmgBmVFHG5dwmHS2I90dALMcPCyLWDDKaLRQX2tDSNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ45W9rSBECvt5zGU7gyTT834wXCaEs2oRChYc7u4jX0ryYMYb7mBQQq6rcsyQ194xIbLTkvCp0drujHmEQGkPSMSUD+acLPAOY0tNw6BuWfsorKc52OWPDU9CtcgyaRGoqc26WoJENfoQPsePi071X/tQCFBR9nsHjOP8osbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l6okT1Cl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7yFiUJMvxd+brtMkZOQ3kNGPogxiayEtQ77mEoxeYG0=; b=l6okT1ClafPedgc+Mz+M2LcJyl
	JNUvSLvFFd/kFLROuLZ+LrbNtNpCAWRMci+J35BFuJfiDoA9c6sweInd5fO+8hnZU+FUwqhhaLHZK
	ZymywsrQyXiu5PTpLNGFPcgKMZxg5pAH7KiXzXiw/8Y2BrPLGneEDJR7HKTfDrFFGQbS6L0bW2UBB
	G1krmc36iBFNcOVaZ3bal5N0iri2HK9k5awloFGQIUcyTfVdTMGcQvgrlEM54sKUr5L/I13Mh3j8i
	Zl9rQhxZeMhS6IZjZurhIP/gfp/vzme68MsgZRf82L3Mq4JpCpeqJJPEWJIh/NMgoZFqFh+6yKdN+
	oSXRz4tQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47350)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uCeK1-0007ZS-0F;
	Wed, 07 May 2025 13:56:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uCeJy-0005nU-0q;
	Wed, 07 May 2025 13:56:22 +0100
Date: Wed, 7 May 2025 13:56:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH net-next] net: phy: remove Kconfig symbol MDIO_DEVRES
Message-ID: <aBtYdq2NurrTIcJi@shell.armlinux.org.uk>
References: <9c2df2f8-6248-4a06-81ef-f873e5a31921@gmail.com>
 <aBs58BUtVAHeMPip@shell.armlinux.org.uk>
 <5ecf2ece-683b-4c7b-a648-aca82d5843ed@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ecf2ece-683b-4c7b-a648-aca82d5843ed@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 07, 2025 at 02:49:05PM +0200, Andrew Lunn wrote:
> On Wed, May 07, 2025 at 11:46:08AM +0100, Russell King (Oracle) wrote:
> > On Wed, May 07, 2025 at 08:17:17AM +0200, Heiner Kallweit wrote:
> > > MDIO_DEVRES is only set where PHYLIB/PHYLINK are set which
> > > select MDIO_DEVRES. So we can remove this symbol.
> > 
> > Does it make sense for mdio_devres to be a separate module from libphy?
> 
> I _think_ Broadcom have one MDIO bus master which is not used for
> PHYs/Switches but regulators or GPIOs or something. In theory, you
> could build a kernel without networking, but still use those
> regulators or GPIOs. But given that Broadcom SoCs are all about
> networking, it does seem like a very unlikely situation.

I'm pointing out that:

libphy-y                        := phy.o phy-c45.o phy-core.o phy_device.o \
                                   linkmode.o phy_link_topology.o \
                                   phy_package.o phy_caps.o mdio_bus_provider.o

mdio_bus_provider.o provides at least some of the functions used by
mdio_devres.

obj-$(CONFIG_PHYLIB)            += mdio_devres.o
obj-$(CONFIG_PHYLIB)            += libphy.o

So, when PHYLIB=m, we end up with mdio_devres and libphy as two separate
loadable modules. I'm questioning whether this makes any sense, or
whether making mdio_devres part of libphy would be more sensible.

Maybe the only case is if mdio_devres adds dependencies we don't want
libphy to have, but I think that needs to be spelt out in the commit.


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

