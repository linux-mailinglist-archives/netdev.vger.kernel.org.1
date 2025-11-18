Return-Path: <netdev+bounces-239352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC4C671A4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A446C358091
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FF623EAA5;
	Tue, 18 Nov 2025 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VxXtZLUb"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD461F2C45;
	Tue, 18 Nov 2025 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763435888; cv=none; b=V+57Fqq4Ogtt96dUvB/PXmQmFVMC8CjCEZ6KIeLyo80wmvK1b1urwXtDadGsvI4mKVUgYnwmm+XJT6peWGDI7siK5zI31Tm4SIbWoWjGFrtAcEWSYO9gg4Yzjsq5xt7ytdCgs0hGyF+ztHsEjvmLuxjhMD4qy+zPVHiHAQynq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763435888; c=relaxed/simple;
	bh=5wilVtT94whUvMDN2BUAjA8f8Vm6R+UUxIzc+kh6l20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkAdzmIGRRkGK6HtHvZ1XrjGrSgGyXUypedjhsAeNsyJBnylPD9UbVRw/HRwaehcuVPWkwhwB4jDJotXQT+e4QLxwgsL7yuzi4hg0oHFk8FUViRDJ8gPDYmFqLI2nBGfZAPDau48U4rqWlsj30SL+GnYfrWN1crF4KUH2DBjYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VxXtZLUb; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id F2C22252B1;
	Tue, 18 Nov 2025 04:17:55 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q48RIkfJKmOk; Tue, 18 Nov 2025 04:17:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763435875; bh=5wilVtT94whUvMDN2BUAjA8f8Vm6R+UUxIzc+kh6l20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VxXtZLUb4FmNsJ7HRkfcaLBSx2Bpz7IM+Ad3nlM5KxhKjYzQU5LTA9tr79eZQdvXT
	 GtcLXxJf18PP57SfNtt/54PorSjAVGFqu0a8o9ww1Alk+i4az9lvOS82soHxBAVuvo
	 eQcouf6jJ1tsxre3u1GDmVsGpLpb6KFGlWMOLfGa9xRAuJ9WjXIQx/FA7M/WPtYfI6
	 s9oxKTFDhek6+NYQREpuk/mKUkdWtRgZo5VAYvD+zxvH034lrJ/5nDA+iIYSmmaOJ4
	 lHKHsLI7lPZjFXPDAwVAyS3VF9u9wTFOlE1F2tFkbk5M+weGAtFTJ4svMbMLYRv3ea
	 kCksqWCCafAFg==
Date: Tue, 18 Nov 2025 03:17:34 +0000
From: Yao Zi <ziyao@disroot.org>
To: Xi Ruoyao <xry111@xry111.site>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai	 <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Runhua He <hua@aosc.io>
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
Message-ID: <aRvlTra1DaPwnmU4@pie>
References: <20251111105252.53487-1-ziyao@disroot.org>
 <20251111105252.53487-3-ziyao@disroot.org>
 <aRMs-B2KndX-JNks@shell.armlinux.org.uk>
 <aRhoHJioqvfT2tEv@pie>
 <f40bcb32b2bb47b83705706a0a326fc8e027ee00.camel@xry111.site>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f40bcb32b2bb47b83705706a0a326fc8e027ee00.camel@xry111.site>

On Sun, Nov 16, 2025 at 02:50:48PM +0800, Xi Ruoyao wrote:
> On Sat, 2025-11-15 at 11:46 +0000, Yao Zi wrote:
> > On Tue, Nov 11, 2025 at 12:32:56PM +0000, Russell King (Oracle) wrote:
> > > On Tue, Nov 11, 2025 at 10:52:51AM +0000, Yao Zi wrote:
> > > > +	plat->bus_id		= pci_dev_id(pdev);
> > > > +	plat->phy_addr		= -1;
> > > > +	plat->phy_interface	= PHY_INTERFACE_MODE_GMII;
> > > > +	plat->clk_csr		= STMMAC_CSR_20_35M;
> > > 
> > > Could you include a comment indicating what the stmmac clock rate
> > > actually is (the rate which is used to derive this divider) ? As
> > > this is PCI, I'm guessing it's 33MHz, which fits with your divider
> > > value.
> > 
> > The divider is taken from vendor driver, and the clock path isn't
> > mentioned in the datasheet, either. I don't think it's 33MHz since
> > it's
> > a PCIe chip, and there's no 33MHz clock supplied by PCIe.
> > 
> > The datasheet[1] (Chinese website, requires login) mentions that the
> > controller requires a 25MHz external clock input/oscillator to
> > function,
> > 
> > > 25MHz Crystal Input pin.
> > > 
> > > If use external oscillator or clock from another device.
> > >   1. When connect an external 25MHz oscillator or clock from another
> > >   device to XTAL_O pin, XTAL_I must be shorted to GND.
> > >   2. When connect an external 25MHz oscillator or clock from another
> > >   device to XTAL_I pin, keep the XTAL_O floating.
> > 
> > 25MHz fits in STMMAC_CSR_20_35M, too, so it's more likely the clock
> > source.
> > 
> > I don't think this guess could be confirmed without vendor's help,
> > should the information be included as comment.
> 
> I used the "beep" function of a multimeter to "probe" the connectivity
> of the two YT6801 chips on a XB612B0 V1.1 board.  There are two 25 MHz
> oscillators on the board, each connected to a YT6801.

Sorry for not being clear here, I'm sure the controller requires an
oscillators to function (since the datasheet states so). What's unclear
here is whether the 20~35MHz clock provided for internal MDIO bus is
dervided from it.

Anyway, I would add a comment to mention this in v3. Thanks.

Best regards,
Yao Zi

> -- 
> Xi Ruoyao <xry111@xry111.site>

