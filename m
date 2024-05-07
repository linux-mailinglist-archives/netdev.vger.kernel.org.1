Return-Path: <netdev+bounces-94089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFA8BE16D
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEE4281688
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF1156885;
	Tue,  7 May 2024 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dhtHuXad"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59315216D;
	Tue,  7 May 2024 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082837; cv=none; b=BdIsTOXcsxBdRHBLH9hLurDcELCpjH1krquIKSMAizC0J5N4uVUKbu5ZjEbKSwDPhUde/Qi/ywFpTY0Xk0xGCcEcNt7hLCFCHWiKSIdccfLRh0v97QjIFsGu4CAYP3YfkfzOVu540YxwbZ8YhB+kpusyu3NrU+8pohtZWjarzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082837; c=relaxed/simple;
	bh=XrhYbBixyQ93eYNpwcgImtQker1sbZGXhkuNQORBJ04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZeOG9H3lJUbHMrnCRUWn05O8WFkC72pQbGCi09Wk2llWIbSStIKUFH95rbphZgsni+t8VN7xtPs5jbnLkEiV3WrWO0y6r/90lzWifyEyggQbmHMwPmBo/erdQyoeWVMrul+pQ+loZ0wBRa1jdXA+S3ENpRX8Kb0Sh9cLp2GD9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dhtHuXad; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dP9BGOlS8Cdd3nKr9W+gvPxkG5zamPeQIojML0gQTqI=; b=dhtHuXad5DL3K8gxpt2hief4+B
	1fYHo63VUV5viAAWvpYLYhSEkbprtYaib7Il5spzMt8WY8ciSnXbl93PQSC57GRPLj34dP+tFAd2D
	rtjBE849KYEk351BCkjdppkC4fD018vEfkZYXr32MrdwlzP8y9HprH6Lc/00aLGBTXWPKQYSdKQwC
	eKxk7alhYEaAeaAKAp4Spq54JDu1AQbGI979wfwt2QOQnLSzmxF/xvG47BEtWT9pNSwgfq9AcSaYm
	ONjsuBF8eXqGfXsTJFPg+8VYfXgN9+GRCydUyblGimnSuxruOTfuZt0BMr8gqwdnoG5ofOqitm4SS
	mZmC9xtw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58656)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s4JOE-0003ep-0u;
	Tue, 07 May 2024 12:53:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s4JOC-0000JE-KO; Tue, 07 May 2024 12:53:44 +0100
Date: Tue, 7 May 2024 12:53:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, lxu@maxlinear.com,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: phy: add wol config options in phy device
Message-ID: <ZjoWSJNS0BbeySuQ@shell.armlinux.org.uk>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
 <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
 <ZjO4VrYR+FCGMMSp@shell.armlinux.org.uk>
 <ZjoAd2vsiqGhCVCv@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjoAd2vsiqGhCVCv@HYD-DK-UNGSW21.microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 07, 2024 at 03:50:39PM +0530, Raju Lakkaraju wrote:
> Hi Russell King,
> 
> Sorry for late response
> 
> If we have phy's wolopts which holds the user configuration, Ethernet MAC
> device can configure Power Manager's WOL registers whether handle only 
> PHY interrupts or MAC's WOL functionality.

That is the responsibility of the MAC driver to detect whether the MAC
needs to be programmed for WoL, or whether the PHY is doing the wakeup.
This doesn't need phylib to do any tracking.

> In existing code, we don't have any information about PHY's user configure
> to configure the PM mode

So you want the MAC driver to access your new phydev->wolopts. What if
there isn't a PHY, or the PHY is on a pluggable module (e.g. SFP.)
No, you don't want to have phylib tracking this for the MAC. The MAC
needs to track this itself if required.

> The 05/02/2024 16:59, Russell King (Oracle) wrote:
> > and why the PHY isn't retaining it.
> 
> mxl-gpy driver does not have soft_reset( ) function.
> In resume sequence, mxl-gpy driver is clearing the WOL configuration and
> interrupt i.e. gpy_config_init( ) and gpy_config_intr( )

That sounds like the bug in this instance.

If a PHY driver has different behaviour from what's expected then it's
buggy, and implementing workarounds in phylib rather than addressing
the buggy driver is a no-no. Sorry.

Why is mxl-gpy always masking and acknowledging interrupts in
gpy_config_init()? This goes completely against what phylib expects.
Interrupts are supposed to be managed by the config_intr() method,
not the config_init() method.

Moreover, if phydev->interrupts == PHY_INTERRUPT_ENABLED, then we
expect interrupts to remain enabled, yet mxl-gpy *always* disables
all interrupts in gpy_config_init() and then re-enables them in
gpy_config_intr() leaving out the WoL interrupt.

Given that gpy_config_intr() is called immediately after
gpy_config_init() in phy_init_hw(), this is nonsense, and it is this
nonsense that is at the root of the problem here. This is *not*
expected PHY driver behaviour.

See for example the at803x driver, specifically at803x_config_intr().
When PHY_INTERRUPT_ENABLED, it doesn't clear the WoL interrupt (via
the AT803X_INTR_ENABLE_WOL bit.)

The dp83822 driver enables the WoL interrupt in dp83822_config_intr()
if not in fibre mode and interupts are requested to be enabled.

The dp83867 driver leaves the WoL interrupt untouched in
dp83867_config_intr() if interrupts are requested to be enabled - if
it was already enabled (via set_wol()) then that state is preserved
if interrupts are being used. dp83869 is the same.

motorcomm doesn't support interrupts, but does appear to use the
interrupt pin for WoL, and doesn't touch the interrupt mask state in
config_intr/config_init.

mscc looks broken in a similar way to mxl-gpy - even worse, if
userspace hammers on the set_wol() method, it'll read the interrupt
status which appears to clear the status - possibly preventing real
interrupts to be delivered. It also does the
clear-MII_VSC85XX_INT_MASK-on-config_init() which will break WoL.


So, in summary, please fix mxl-gpy.c not to clear the interrupt mask
in the config_init() method. The contents of gpy_config_init() needs
to move to gpy_config_intr(), and it needs not to mask the WoL
interrupt if phydev->interrupts == PHY_INTERRUPT_ENABLED.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

