Return-Path: <netdev+bounces-197386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96540AD8708
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB2417E410
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA35291C2E;
	Fri, 13 Jun 2025 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HhFno71t"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E557263C;
	Fri, 13 Jun 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749805542; cv=none; b=eDEGAf7IzzMvswpcdBN+fx2KeilN7eaVA8Z/ElCg9Tx1Gi6PursIJJDPCYFt8ypG+jBoxh6wXCs+cYJ1yR9g2AzVMC7arIOfW9xNfDNEiRYjedrfBe17RnW6ws1tyJtzFV2qnXen/EoYtvIoBJxlhc/IvqnErWjsALwNgdHniNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749805542; c=relaxed/simple;
	bh=8FvV1SciI0lOYrVif+0+YROqsYbPPO/U7ZW0LQOwq4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwGXpzJoXivtDLt8o+C6M2cWOlNKBWl2+CF9a7fpupYQ02NzyRXfuO/me1IQe9qkFJ/P/lHxUAh7YPBeqkagqE0wd/tIkIxfwI4AQ9OWnROya/fK1/+BrNhn1QPjT9+YpFYj2Y2EKC1hfb6PY5MSm0pA16OMqLwhD4/k4G9YBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HhFno71t; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0ft0fSiF67mpk/bqWwyG78k/NSeUXV83RntIl505nZ8=; b=HhFno71tY6laiYHIebx8aooC/C
	k8u9+Ahb6Zsw5wwOMmwYjB7f9u7qxC53lo6igl2YfouCukeiwhieToj1Bn+Abw96R/6IniwPqHqdu
	9RL2BGvbCdtpjMRM5+xGCuBfp3EWJhGH9Lb8mpmxldx8pmnN9k4teTxOkWrJ5vYZIpN55WN7d2W0a
	buLJ7fPlHTenPbf78hLj3tOt5Gdm1d/1gxqjggukmXKotwyoN8FRLo1iDuDGPDMn/WqBt11b0ncFp
	rsr2D+KeJopg2q28biYZ3/Ki1t6LbRea+t12AWthWDDOJgz0AzdsKg8Py8fvW0cjWFmmST232jzAi
	KKV2uyCg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45694)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uQ0Lm-0000av-24;
	Fri, 13 Jun 2025 10:05:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uQ0Lj-0001fm-1F;
	Fri, 13 Jun 2025 10:05:23 +0100
Date: Fri, 13 Jun 2025 10:05:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
Message-ID: <aEvp01pIuK-LUdjR@shell.armlinux.org.uk>
References: <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
 <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>
 <ba7b290d-0cd1-4809-822a-bfe902684d7e@lunn.ch>
 <9ebe16a8d33e00c39c142748a1ea6fff96b9565a.camel@icenowy.me>
 <aElArNHIwm1--GUn@shell.armlinux.org.uk>
 <fc7ad44b922ec931e935adb96dcc33b89e9293b0.camel@icenowy.me>
 <f82a86d3-6e06-4f24-beb5-68231383e635@lunn.ch>
 <40fc8f3fec4da0ed2b59e8d2612345fb42b1fdd3.camel@icenowy.me>
 <aEvi5DTBj-cltE5w@shell.armlinux.org.uk>
 <9922727607de39da7ed75d1edaf1873147e26336.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9922727607de39da7ed75d1edaf1873147e26336.camel@icenowy.me>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 13, 2025 at 04:43:14PM +0800, Icenowy Zheng wrote:
> 在 2025-06-13星期五的 09:35 +0100，Russell King (Oracle)写道：
> > On Fri, Jun 13, 2025 at 04:01:37PM +0800, Icenowy Zheng wrote:
> > > 在 2025-06-11星期三的 17:28 +0200，Andrew Lunn写道：
> > > > > Well in fact I have an additional question: when the MAC has
> > > > > any
> > > > > extra
> > > > > [tr]x-internal-delay-ps property, what's the threshold of MAC
> > > > > triggering patching phy mode? (The property might be only used
> > > > > for
> > > > > a
> > > > > slight a few hundred ps delay for tweak instead of the full 2ns
> > > > > one)
> > > > 
> > > > Maybe you should read the text.
> > > > 
> > > > The text says:
> > > > 
> > > >   In the MAC node, the Device Tree properties 'rx-internal-delay-
> > > > ps'
> > > >   and 'tx-internal-delay-ps' should be used to indicate fine
> > > > tuning
> > > >   performed by the MAC. The values expected here are small. A
> > > > value
> > > > of
> > > >   2000ps, i.e 2ns, and a phy-mode of 'rgmii' will not be accepted
> > > > by
> > > >   Reviewers.
> > > > 
> > > > So a few hundred ps delay is fine. The MAC is not providing the
> > > > 2ns
> > > > delay, the PHY needs to do that, so you don't mask the value.
> > > 
> > > Thus if the MAC delay is set to 1xxx ps (e.g. 1800ps), should the
> > > MAC
> > > do the masking?
> > > 
> > > What should be the threshold? 1ns?
> > 
> > Why should there be a "threshold" ? It's really a case by case issue
> > where the capabilities of the hardware need to be provided and
> > considered before a decision can be made.
> > 
> > In order to first understand this, one needs to understand the
> > requirements of RGMII. RGMII v1.3 states:
> > 
> > Symbol  Parameter               Min     Typ     Max     Units
> > TskewT  Data to Clock output    -500    0       500     ps
> >         skew at clock tx
> > TskewR  Data to Clock input     1               2.6     ns
> >         skew at clock rx
> > 
> > The RGMII specification is written based upon the clock transmitter
> > and receiver having no built-in delays, and the delay is achieved
> > purely by trace routing. So, where delays are provided by the
> > transmitter or receiver (whether that's the MAC or the PHY depends
> > on whether TXC or RXC is being examined) these figures need to be
> > thought about.
> > 
> > However, the range for the delay at the receiver is -1ns to +0.6ns.
> > 
> > In your example, you're talking about needing a 1800ps delay. I
> > would suggest that, *assuming the PCB tracks introduce a 200ps skew
> > between the data and clock*, then using the PHY's built-in 2ns delay
> > is perfectly within the requirements of the RGMII specification.
> > 
> > That bit "assuming" is where the discussion needs to happen, and why
> > it would be case by case. If the skew due to trace routing were
> > 800ps, then enabling the PHY's built-in 2ns delay would take the
> > delay out of spec.
> > 
> > Thrown into this would also be temperature effects, so trying to get
> > to as near as the 2ns delay as possible is probably a good idea.
> > 
> > Lastly, there's the question whether the software engineer even
> > knows what the skew provided by the hardware actually is.
> 
> Sigh, my experience is that the only thing I can get is some magic
> numbers from HW vendor... *facepalm*

I may have missed it if you've given the details, but tell us what
information you have, what the capabilities of the hardware is, and
we should be able to make suggestions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

