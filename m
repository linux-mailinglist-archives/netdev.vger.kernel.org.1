Return-Path: <netdev+bounces-188614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4A7AADF5E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B354E36C7
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC5F28003E;
	Wed,  7 May 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UxEUkuIl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FAB280028;
	Wed,  7 May 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621463; cv=none; b=VaTjPQ8NTh032EXRDhvxee26Cccbcu0YdyjyqZtHnWLTQp3JQsIJFbhHB/URm2oue4MdufFqCr+k06Li58ktjHnkPc3XI9iIeXJl92xcMJSDoa7An6YXiOQBrxLdwbJj7HH2LwjnwJSmXhoFkUUL570qOn7kfLLp2W5SjoKjARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621463; c=relaxed/simple;
	bh=xCGmUPVZuDdzuUKuQNbIIVf2waBPmWTdSstOrPdd0oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGwqGd1MJWHR8glUNiNayBnfonzclZDr55WZIvgadXZrMzGJnTK8ZzdGNUCXO42PcHG9OghhfkZ2DzmQeACdJ0cb1e7RFGP6T3dh7unC31SfPZEw5TUYfvUZJKA9Bb7powLQtT6L+G5DwUHnC6hr50CeqBkMCCyAuD7HHOdc4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UxEUkuIl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5sPVrzUiQ+hehg1asUBhs/XYvzKveDurKf1FDpj71eU=; b=UxEUkuIlcl7krxdT+42I9uKAVB
	YsgHWsOYxgVRqKwf7S8mlsuYxgynUv7Q9dX/JaEovXdfoebGLpb08RSV3kTRj4omig7NyEb6+V/rw
	UceXPNJzvFZKjLe9487sxOqbkwnHbCPN4zSyyKGVVC3kyRHngUxW7FK4rGWfa2nyHZr4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uCe1T-00BsZW-F1; Wed, 07 May 2025 14:37:15 +0200
Date: Wed, 7 May 2025 14:37:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 0/4] riscv: sophgo: Add ethernet support for
 SG2042
Message-ID: <b4ce3e35-9255-4fc7-9c8d-4078b24ac3fa@lunn.ch>
References: <20250506093256.1107770-1-inochiama@gmail.com>
 <c7a8185e-07b7-4a62-b39b-7d1e6eec64d6@lunn.ch>
 <fgao5qnim6o3gvixzl7lnftgsish6uajlia5okylxskn3nrexe@gyvgrp72jvj6>
 <ffa044e2-ee9e-4a34-af6a-2e45294144f7@lunn.ch>
 <2tu2mvwsnqdezjei5h43ko24vfave4c3ek2fjoatwsg72p6lpz@3vbtpmm7l73z>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2tu2mvwsnqdezjei5h43ko24vfave4c3ek2fjoatwsg72p6lpz@3vbtpmm7l73z>

On Wed, May 07, 2025 at 08:01:29PM +0800, Inochi Amaoto wrote:
> On Wed, May 07, 2025 at 02:10:48AM +0200, Andrew Lunn wrote:
> > On Wed, May 07, 2025 at 06:24:29AM +0800, Inochi Amaoto wrote:
> > > On Tue, May 06, 2025 at 02:03:18PM +0200, Andrew Lunn wrote:
> > > > On Tue, May 06, 2025 at 05:32:50PM +0800, Inochi Amaoto wrote:
> > > > > The ethernet controller of SG2042 is Synopsys DesignWare IP with
> > > > > tx clock. Add device id for it.
> > > > > 
> > > > > This patch can only be tested on a SG2042 x4 evb board, as pioneer
> > > > > does not expose this device.
> > > > 
> > > > Do you have a patch for this EVB board? Ideally there should be a user
> > > > added at the same time as support for a device.
> > > > 
> > > > 	Andrew
> > > 
> > > Yes, I have one for this device. And Han Gao told me that he will send
> > > the board patch for the evb board. So I only send the driver.
> > > And the fragment for the evb board is likes below, I think it is kind
> > > of trivial:
> > > 
> > > &gmac0 {
> > > 	phy-handle = <&phy0>;
> > > 	phy-mode = "rgmii-txid";
> > 
> > And this is why i ask, because this is broken. For more information,
> > please see:
> > 
> > https://patchwork.kernel.org/project/netdevbpf/patch/20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch/
> > 
> > 	Andrew
> 
> You are right, the right phy-mode is "rgmii-id", the delay is not
> added by the PCB. It seems to be better to ask for the vendor about
> the hardware design before copying params for vendor dts. Anyway,
> thanks for reviewing this.

Please do figure this out. Since you are adding a new compatible, you
have a bit more flexibility. If the MAC driver is doing something
wrong, you can change its behaviour based on this new compatible
without breaking other users of the driver using other compatibles.

	Andrew

