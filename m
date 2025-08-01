Return-Path: <netdev+bounces-211356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94395B1823B
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7AA57AC696
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0B03FB1B;
	Fri,  1 Aug 2025 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="goBBN0+C"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2362628D;
	Fri,  1 Aug 2025 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054122; cv=none; b=VJtW2iqtfmxapyzkVVucq8hJ2f70KzM437H/mZX1jDP7PI0TNiPcFB5c9I3XaUshRwxUbnUOBfOPFq8902mwfgDDdykUvUSCsrUXNzE1Zj4O0tcvJlMbWSqI9IwvVV20IYNwO2gfiy1BR2vPI1Ma1/jHcB7b0OPE4FxmRH6nviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054122; c=relaxed/simple;
	bh=KpY+pHTlEqtqKPX++6/jobAXDKvdILMuJ5/p/I4i5n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0oa8F168fjo1fsdO5upFjSnmAmVeEKM2KrReTVJbFfirWkq1oUOVS6RZuhtfl5nKaeSQaOVchRTR/+E7tafSaKT2dPoMsn3/DQggOW3VcMDqxaJ+Fv+LN+L2txFk3vdXjZaMMD+99rXKhVMp7e4iAKkUpM28g024hivv4RdDGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=goBBN0+C; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Kad9jR19PDpT1ZcaPhylvlERiT+jB6wY6uHs03XcUFA=; b=goBBN0+CfNCrvTuDwuvuVQJM/z
	uGPmZwn0XR4bv6YmSUS+73iloqSjMUegnZqe8xyTrVUIhdP6lMGkSqf+BAPQcXir5Jbx7qAr/aO1W
	TxgWjm/yFITBN8fbzdZ1e+Zoktoq3i/JAR3jOMS5zZub+5yyBdLnqXP5KqB+cJ6FN1jwb+Tbs3X0v
	OofLtY6MaU7ABSdxm3fQNsrTuNdVUUi4qfmQvcxAc6PgSYzOHs7m3Jwo1aXFNOSDkUhsr7trxyYJz
	VKVtHHZTeDd7yiozVAh74qzw+d4bTSgfKD+/U1aHcof4z78NCPH5hudMz5sych2k9ZjrWVjTb/eGK
	TIcYEzrw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43298)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhpbJ-0006YZ-28;
	Fri, 01 Aug 2025 14:15:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhpbG-00026a-0a;
	Fri, 01 Aug 2025 14:15:06 +0100
Date: Fri, 1 Aug 2025 14:15:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Mark Brown <broonie@kernel.org>,
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
Message-ID: <aIy92jXyhISZ5mZB@shell.armlinux.org.uk>
References: <20250728153455.47190-2-csokas.bence@prolan.hu>
 <95449490-fa58-41d4-9493-c9213c1f2e7d@sirena.org.uk>
 <CAMuHMdVdsZtRpbbWsRC_YSYgGojA-wxdxRz7eytJvc+xq2uqEw@mail.gmail.com>
 <aIy0HqFvCggTEyUk@shell.armlinux.org.uk>
 <86bb6477-56d9-415a-a0ad-9a5d963a285e@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86bb6477-56d9-415a-a0ad-9a5d963a285e@prolan.hu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 01, 2025 at 03:04:31PM +0200, Csókás Bence wrote:
> Hi,
> 
> On 2025. 08. 01. 14:33, Russell King (Oracle) wrote:
> > On Fri, Aug 01, 2025 at 02:25:17PM +0200, Geert Uytterhoeven wrote:
> > > Hi Mark,
> > > 
> > > On Fri, 1 Aug 2025 at 14:01, Mark Brown <broonie@kernel.org> wrote:
> > > > On Mon, Jul 28, 2025 at 05:34:55PM +0200, Bence Csókás wrote:
> > > > > Commit bafbdd527d56 ("phylib: Add device reset GPIO support") removed
> > > > > devm_gpiod_get_optional() in favor of the non-devres managed
> > > > > fwnode_get_named_gpiod(). When it was kind-of reverted by commit
> > > > > 40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()"), the devm
> > > > > functionality was not reinstated. Nor was the GPIO unclaimed on device
> > > > > remove. This leads to the GPIO being claimed indefinitely, even when the
> > > > > device and/or the driver gets removed.
> > > > 
> > > > I'm seeing multiple platforms including at least Beaglebone Black,
> > > > Tordax Mallow and Libre Computer Alta printing errors in
> > > > next/pending-fixes today:
> > > > 
> > > > [    3.252885] mdio_bus 4a101000.mdio:00: Resources present before probing
> > > > 
> > > > Bisects are pointing to this patch which is 3b98c9352511db in -next,
> > > 
> > > My guess is that &mdiodev->dev is not the correct device for
> > > resource management.
> > 
> > No, looking at the patch, the patch is completely wrong.
> > 
> > Take for example mdiobus_register_gpiod(). Using devm_*() there is
> > completely wrong, because this is called from mdiobus_register_device().
> > This is not the probe function for the device, and thus there is no
> > code to trigger the release of the resource on unregistration.
> > 
> > Moreover, when the mdiodev is eventually probed, if the driver fails
> > or the driver is unbound, the GPIO will be released, but a reference
> > will be left behind.
> > 
> > Using devm* with a struct device that is *not* currently being probed
> > is fundamentally wrong - an abuse of devm.
> 
> The real question is: why on Earth is mdiobus_register_device() called
> _before_ the probe()?

Please review the code and *understand* it before making changes. This
is what any experienced programmer will do, so please get into that
habbit - it'll help you not to get a bad name in the kernel community.

If you don't understand that mdiobus_register_device() would be called
outside of the device's probe function, then you need to gain that
knowledge through research.

Please treat this as a learning exercise.

First step: grep -r mdiobus_register_device drivers/net/phy

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

