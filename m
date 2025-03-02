Return-Path: <netdev+bounces-171043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F83A4B441
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 20:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF25816666F
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 19:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EE51D79A6;
	Sun,  2 Mar 2025 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VaPfvJ/+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF51C5D50
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740942390; cv=none; b=t5chjlhjT80pv8aMnM2KD5Pud6kxJtajgNiUDvnhR9CUKvrtPtzQ3Fh5Q4Dma4xBWKbLe4sNhi+4YKIHM5c06J7h0/hye9rFvDrnlBkilb6zIVBWeLnLzyUUwM8eMo/KFdtGXzc/i2r/VojWO+AeRMF6IC41ckNt7rdH1oFHLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740942390; c=relaxed/simple;
	bh=Oieo2kTw9WCbuFbK1uEBSw1p0URotdr2G7DA6pK7Mo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek2H48cVu/7QMWRX7nwUFNZ7YL02MwLDYTZLDpFgZORMJO3sfkCibfJON1LY3e597EHtoCY6a/D0I6OTW2tKpjUazlMN7TEwQwl2aNs9PcfZoiGBvgEhWZKUry7MHlGldpvSDZGEqFyhONZNztrZK8kq2I8vaK8umZS79+p7z/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VaPfvJ/+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sYYj4r+w6rUdJyuyew7pZhA1LY0yebey2M+1Ergpkhs=; b=VaPfvJ/+0RZ6fuvKJpUKRop56g
	s8mt04hBIWGL7mlYeNPjpaz8QtIUTKsZe7FQLsXb7zaO2UHM5uYs3HMuud1u0nR/nPMcSZ+6qLAYb
	Ehf4BxZIBo9Hceu4ttfS/cFefpQ/B9lycBdoKlzfMa8tESmsfbiRNA/YRbOg99sccNjvCqG/dhAXe
	CjsmkGnqmaEBUItwf4jyq00Rof37jFjjqvUrh4q7sVSM2GAdpSTLMTCurHYC4zWiEOGuO1hd4XajO
	f2X9atwR5kXdlrM2rRdbAkRokhN5K5W41Tq3PQLw57XH4bNDBJsdo6N4y/xT5l7QLqfARKcduRuA0
	y+tHJD+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36860)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1toodo-00071c-2v;
	Sun, 02 Mar 2025 19:06:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1toodl-0002zB-0l;
	Sun, 02 Mar 2025 19:06:17 +0000
Date: Sun, 2 Mar 2025 19:06:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev <netdev@vger.kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [QUERY] : STMMAC Clocks
Message-ID: <Z8SsKQXt4SwEvP2I@shell.armlinux.org.uk>
References: <CA+V-a8u04AskomiOqBKLkTzq3uJnFas6sitF6wbNi=md6DtZbw@mail.gmail.com>
 <Z8LjAbz5QmaMeHbO@shell.armlinux.org.uk>
 <CA+V-a8uWcgOsyG8Fy=ivs_zNqU7ur4OHzESQW=4EfYx+q2VJHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+V-a8uWcgOsyG8Fy=ivs_zNqU7ur4OHzESQW=4EfYx+q2VJHg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 02, 2025 at 05:37:32PM +0000, Lad, Prabhakar wrote:
> Hi Russell,
> 
> On Sat, Mar 1, 2025 at 10:35 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Feb 28, 2025 at 09:51:15PM +0000, Lad, Prabhakar wrote:
> > > Hi All,
> > >
> > > I am bit confused related clocks naming in with respect to STMMAC driver,
> > >
> > > We have the below clocks in the binding doc:
> > > - stmmaceth
> > > - pclk
> > > - ptp_ref
> > >
> > > But there isn't any description for this. Based on this patch [0]
> > > which isn't in mainline we have,
> > > - stmmaceth - system clock
> > > - pclk - CSR clock
> > > - ptp_ref - PTP reference clock.
> > >
> > > [0] https://patches.linaro.org/project/netdev/patch/20210208135609.7685-23-Sergey.Semin@baikalelectronics.ru/
> > >
> > > Can somebody please clarify on the above as I am planning to add a
> > > platform which supports the below clocks:
> > > - CSR clock
> > > - AXI system clock
> > > - Tx & Tx-180
> > > - Rx & Rx-180
> >
> > I'm afraid the stmmac driver is a mess when it comes to clocks.
> >
> :-)
> 
> > According to the databook, the DW GMAC IP has several clocks:
> >
> > clk_tx_i - 0° transmit clock
> > clk_tx_180_i - 180° transmit clock (synchronous to the above)
> >
> Ive named them as tx, tx-180 in the vendor specific binding.

Note that although there are separate inputs to the GMAC, they shouldn't
be treated separately - there should be no separate control of each of
them as its required that clk_tx_180_i is merely 180° out of phase with
clk_tx_i. The purpose of these two clocks is to be able to cope with
data that is transferred at both edges of e.g. a 125MHz clock without
requiring an exact 50% duty cycle 125MHz clock.

> > I've recently added generic support for clk_tx_i that platforms can
> > re-use rather than implementing the same thing over and over. You can
> > find that in net-next as of yesterday.
> >
> Thanks for the pointer, Ive rebased my changes on net-next.
> 
> > clk_rx_i - 0° receive clock
> > clk_rx_180_i - 180° of above
> >
> > These are synchronous to the datastream from the PHY, and generally
> > come from the PHY's RXC or from the PCS block integrated with the
> > GMAC. Normally these require no configuration, and thus generally
> > don't need mentioning in firmware.
> >
> On the SoC which I'm working on, these have an ON/OFF bit, so I had to
> extend my binding.
> 
> > The host specific interface clocks in your case are:
> >
> > - clock for AXI (for AXI DMA interface)
> > - clock for CSR (for register access and MDC)
> >
> > There are several different possible synthesis options for these
> > clocks, so there will be quite a bit of variability in these. I haven't
> > yet reviewed the driver for these, but I would like there to be
> > something more generic rather than each platform implementing basically
> > the same thing but differently.
> >
> I agree.

Having looked at this at various points over the weekend, stmmac_clk
seems to be the CSR clock - it's used by stmmac_main.c to calculate
the MDIO divisor. So for all intents and purposes, stmmac_clk is
csr_clk_i.

> > snps,dwc-qos-ethernet.txt lists alternative names for these clocks:
> >
> > "tx" - clk_tx_i (even mentions the official name in the description!)
> > "rx" - clk_rx_i (ditto)
> > "slave_bus" - says this is the CSR clock - however depending on
> >    synthesis options, could be one of several clocks
> > "master_bus" - AHB or AXI clock (which have different hardware names)
> > "ptp_ref" - clk_ptp_ref_i
> >
> I think it was for the older version of the IPs.
> 
> > I would encourage a new platform to either use the DW GMAC naming for
> > these clocks so we can start to have some uniformity, or maybe we could
> > standardise on the list in dwc-qos-ethernet.
> >
> I agree, in that case we need to update the driver and have fallbacks
> to maintain compatibility.
> 
> > However, I would like some standardisation around this. The names used
> > in snps,dwmac with the exception of ptp_ref make no sense as they don't
> > correspond with documentation, and convey no meaning.
> >
> > If we want to go fully with the documentation, then I would suggest:
> >
> >         hclk_i, aclk_i, clk_app_i - optional (depends on interface)
> >         clk_csr_i - optional (if not one of the above should be supplied
> >                               as CSR clock may be the same as one of the
> >                               above.)
> >         clk_tx_i - transmit clock
> >         clk_rx_i - receive clock
> >
> > As there is a configuration where aclk_i and hclk_i could be present
> > (where aclk_i is used for the interface and hclk_i is used for the CSR)
> > it may be better to deviate for clk_csr_i and use "csr" - which would
> > always point at the same clock as one of hclk_i, aclk_i, clk_app_i or
> > the separate clk_csr_i.
> >
> I agree, I think the DT maintainers wouldn't prefer "clk" in the
> prefix and "_i" in the postfix.

Really the DT maintainers shouldn't care about the format of the
clock names - there's a clock-names property, and it takes strings
that is used by the code internally. clock-names already identifies
that what follows are the names of clocks, so "clk" in "clk_foo" is
rather redundant as far as working out if the identifier is a clock
or not.

I suspect DT maintainers would much prefer clock names to have some
meaning back to hardware documentation rather than something randomly
made up.

As clk API maintainer, clk_get() as I designed the API takes the
consumer device and the clock name as defined by the *consumer*. The
clock name is not supposed to be some global identifier. The intention
of the clk API is that the hardware names used by the consumer should
always be used.

Sadly, in the beginning lots of people decided to ignore the "dev"
argument and use global clock names... and then ended up having to
pass clock names through platform data to drivers. That's just dumb
and very short sighted. I think people have generally seen the light
more recently though, especially with DT where the binding defines
the clock names (thus making them device specific) and not some
global clock name.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

