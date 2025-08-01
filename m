Return-Path: <netdev+bounces-211347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DD9B181D5
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 14:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4326C3A9244
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1785231832;
	Fri,  1 Aug 2025 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jCleiGto"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B44179A3;
	Fri,  1 Aug 2025 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051632; cv=none; b=MMN8ggwwLt1b1KF8+8jD4KPBpUnClfg8um+k0uotnJiWSUOhfOfloA4zqq9HPr5MdZQqPmnyYJRUiZ4rBW73FIO+JMyaB/MZhGAVvVuhRziO2dp93QZ9asXEzNq9TKzxe5aE606TnF3ClrHYu/k5ha19g2Z6GewsX6nC5aOE670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051632; c=relaxed/simple;
	bh=tOt/u+92c3Ti/pTeA3NIfthW+H8n/eCQgNhYNHSjaN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWsN6rMX85K+QR+9+PPC0lH8QkdISBoK91AbCPst7Lh56oO1pBHDGWAXU3clx1CLqyBLTmMJXMK0M3mBqu6Wwvot8SFzHhgYWyjwv8QA+joru8hgPtKoK+p/2EhnLt9JMrkAankvO/Khr4ZcliimIlUcLbAq27JpVWUa+IF2+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jCleiGto; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ryXE6yqAKCgV6SrjE/rIPR99+ajWXdRoh/hICBnA/l4=; b=jCleiGto8tJg0yKdcE36wudtEQ
	egGDioaeZo1u2VmqCH+A583t69h1EM0+EDrz9INhjZmKV58jLnpfJJ5r2XeVrEMQlin9KMB3bmttX
	tCpcxCfTG9T/jt0MbRmmEXoLFPCCcjFzLqjGhV/kcemVEVB2KL+UcdSUG3TYjQ34q2qG8ZYQM1VWR
	rF33brDfIRK/Vrdl/tlIfZxqXVCR2xv2guGxWhmX3Wh5JoNYhYxJlPHPkhGRq6EqZpPuDN6yoT81Q
	UVKssldAW/TDy5jtC0LhviFusZzMW5PjgwFa/8b0HlgRcT8bZo3UzOiz5yiTPFIvgmOrJ7ZcJydOg
	ZpcM2rsA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58312)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhox9-0006US-14;
	Fri, 01 Aug 2025 13:33:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhox4-00024T-2m;
	Fri, 01 Aug 2025 13:33:34 +0100
Date: Fri, 1 Aug 2025 13:33:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>,
	Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Csaba Buday <buday.csaba@prolan.hu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: mdio_bus: Use devm for getting reset GPIO
Message-ID: <aIy0HqFvCggTEyUk@shell.armlinux.org.uk>
References: <20250728153455.47190-2-csokas.bence@prolan.hu>
 <95449490-fa58-41d4-9493-c9213c1f2e7d@sirena.org.uk>
 <CAMuHMdVdsZtRpbbWsRC_YSYgGojA-wxdxRz7eytJvc+xq2uqEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVdsZtRpbbWsRC_YSYgGojA-wxdxRz7eytJvc+xq2uqEw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 01, 2025 at 02:25:17PM +0200, Geert Uytterhoeven wrote:
> Hi Mark,
> 
> On Fri, 1 Aug 2025 at 14:01, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Jul 28, 2025 at 05:34:55PM +0200, Bence Csókás wrote:
> > > Commit bafbdd527d56 ("phylib: Add device reset GPIO support") removed
> > > devm_gpiod_get_optional() in favor of the non-devres managed
> > > fwnode_get_named_gpiod(). When it was kind-of reverted by commit
> > > 40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()"), the devm
> > > functionality was not reinstated. Nor was the GPIO unclaimed on device
> > > remove. This leads to the GPIO being claimed indefinitely, even when the
> > > device and/or the driver gets removed.
> >
> > I'm seeing multiple platforms including at least Beaglebone Black,
> > Tordax Mallow and Libre Computer Alta printing errors in
> > next/pending-fixes today:
> >
> > [    3.252885] mdio_bus 4a101000.mdio:00: Resources present before probing
> >
> > Bisects are pointing to this patch which is 3b98c9352511db in -next,
> 
> My guess is that &mdiodev->dev is not the correct device for
> resource management.

No, looking at the patch, the patch is completely wrong.

Take for example mdiobus_register_gpiod(). Using devm_*() there is
completely wrong, because this is called from mdiobus_register_device().
This is not the probe function for the device, and thus there is no
code to trigger the release of the resource on unregistration.

Moreover, when the mdiodev is eventually probed, if the driver fails
or the driver is unbound, the GPIO will be released, but a reference
will be left behind.

Using devm* with a struct device that is *not* currently being probed
is fundamentally wrong - an abuse of devm.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

