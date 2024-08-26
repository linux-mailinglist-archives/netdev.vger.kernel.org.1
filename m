Return-Path: <netdev+bounces-122043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222095FA84
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB002834FC
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2125F19AD73;
	Mon, 26 Aug 2024 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zp0jeE0o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156819AA5F
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703508; cv=none; b=eWm5ErV9AKQ+bcqqYqa9rDJWtk9w/hXujS2HeN8WfFS871UrmstfL0eBA10TlSO2xSpZr5ow7t+fZHnz3SLdc6YT4Z6qRLVi89+6bBr8uBc5aAn4dTq4szPnHazHdqGUb9vRqyS1QLi+eU8lZqxxRwIkkC+8HlOzjoDD8PfZ8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703508; c=relaxed/simple;
	bh=x1koh82jZtl5PCTVnwGWjnH7a1/xTcElJvB0lCAu//I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujG6SuuhhBdtkYhYaWrMHj6Wb4X6jOknmKv3Rqnxir3zM4cxU8nbSHkBZ17vo6l2mHAbViVjH20DbdPZ46ZYbC+dMp5KWm/ZofiXzY9hLYVcLPvNaCLZ2rIQQS/Ch7lrjKJ7xpXcybaH5R/ckbBQ1apUnRmKYSMx+fDnf11EFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zp0jeE0o; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a866d3ae692so273081266b.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724703503; x=1725308303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQcMPtKwW2Ur+/ekeJHQBfttffMZ3TRumocDv4AvDhE=;
        b=Zp0jeE0oF/j8fU2kLqs40sNtdop8ZQZdgPIxd5yILz7t5nz/nqzeGgDHeAhu6gamWw
         T22oZADtHvcJNNm718zniI6jonxYUHR8IeGIb6plg479Ri4PlGS4yaDZ+xViwtjYRlru
         KRjFeC1Hp3Ifg+FXt5WLpVY63Mu7IN8QMDnbwZH7Ze/UyLNTMSpWNzAbcHJhed1bqrnh
         /dxRiyaM3kUnLkkExvJfokrcchEsYW2k7wZoibIFzDmYt970knIZXQzzxrLx663jYHU0
         5IAaixaQatSfzMvCuFTXrIlMWl87jrGEdyPr3cJt3Yyz7s0RgzZDDbfY627IWt9Owco/
         34yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724703503; x=1725308303;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQcMPtKwW2Ur+/ekeJHQBfttffMZ3TRumocDv4AvDhE=;
        b=YQntRFOAfB8hCH/3jnxoLey66AhI2nJXFnr06wAD33azUp/GCDjBv26C0QZ7rEgS2L
         L0WIP3Kq1bR6baw/2aAVYIikwCUzBYz+bKcMNZa5U2+LF4Z6FSQpN9J82WlNu1AD8UVH
         Vf8+RXUduZqGYG+eIINyBK+N2eTMlL1dJ1T2VyhhZnFgKXVUXbAocQZqTu03AOs1SqBJ
         ujdzXpFg+9wsD87X96EbyniPuNShsbkOq1tI+uhA8C1GcaxW6MEjPj8oamTZxhlpQN8m
         hMu3X+6jDXcJeyveOe8fmmsh5k6VgFehb1aKUxBYEBhd7uYAcIffGcWH3PJNaZ/iUwyG
         N0MA==
X-Forwarded-Encrypted: i=1; AJvYcCXO2PbwfURYD5gXIDrQkEkFs+oF/T1dssJ9p1TNie1xgnwz9kOcf6yOKCuRWnnubzXsvLXafUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMbex7e7NXOxzjj6JSIyzgSO3+zFBVR+v6xINAMy8bt/03HYPK
	TCCk08nacXCGz1vKGFm+lN/IY4GICAkP01xUzSGhF5bhDYdAKsVu02XB1PBq1Pk=
X-Google-Smtp-Source: AGHT+IGg3wF8BNSAEwrMaM1mnP282cCzSjHmPqhfR3e+bo7xqlwNcVANiEFofVeUFy+v47Ksb4HTjw==
X-Received: by 2002:a05:6402:26d3:b0:5a1:2ce9:f416 with SMTP id 4fb4d7f45d1cf-5c0891b4825mr9974880a12.37.1724703502649;
        Mon, 26 Aug 2024 13:18:22 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5485003sm16833066b.13.2024.08.26.13.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:18:22 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 26 Aug 2024 22:18:29 +0200
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 11/11] arm64: dts: rp1: Add support for MACB contained in
 RP1
Message-ID: <ZszjFYkoSCfwxUOk@apocalypse>
Mail-Followup-To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <a3fde99c2e522ef1fbf4e4bb125bc1d97a715eaf.1724159867.git.andrea.porta@suse.com>
 <e442c254-6bd1-4724-83f7-e3690d756ac4@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e442c254-6bd1-4724-83f7-e3690d756ac4@broadcom.com>

Hi Florian,

On 10:02 Wed 21 Aug     , Florian Fainelli wrote:
> On 8/20/24 07:36, Andrea della Porta wrote:
> > RaspberryPi RP1 is multi function PCI endpoint device that
> > exposes several subperipherals via PCI BAR.
> > Add an ethernet node for Cadence MACB to the RP1 dtso
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >   arch/arm64/boot/dts/broadcom/rp1.dtso | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
> > index d80178a278ee..b40e203c28d5 100644
> > --- a/arch/arm64/boot/dts/broadcom/rp1.dtso
> > +++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
> > @@ -78,6 +78,29 @@ rp1_clocks: clocks@c040018000 {
> >   							       <50000000>;   // RP1_CLK_ETH_TSU
> >   				};
> > +				rp1_eth: ethernet@c040100000 {
> > +					reg = <0xc0 0x40100000  0x0 0x4000>;
> > +					compatible = "cdns,macb";
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +					interrupts = <RP1_INT_ETH IRQ_TYPE_LEVEL_HIGH>;
> > +					clocks = <&macb_pclk &macb_hclk &rp1_clocks RP1_CLK_ETH_TSU>;
> > +					clock-names = "pclk", "hclk", "tsu_clk";
> > +					phy-mode = "rgmii-id";
> > +					cdns,aw2w-max-pipe = /bits/ 8 <8>;
> > +					cdns,ar2r-max-pipe = /bits/ 8 <8>;
> > +					cdns,use-aw2b-fill;
> > +					local-mac-address = [00 00 00 00 00 00];
> > +					phy-handle = <&phy1>;
> > +					phy-reset-gpios = <&rp1_gpio 32 GPIO_ACTIVE_LOW>;
> > +					phy-reset-duration = <5>;
> > +
> > +					phy1: ethernet-phy@1 {
> > +						reg = <0x1>;
> > +						brcm,powerdown-enable;
> 
> Undocumented property, and I would like to understand why this needs to be
> specified in the Device Tree? What model of Broadcom Ethernet PHY is being
> used here?

It's a Broadcom BCM5421 transceiver, and that property is intended to support
the optional link-down powersave from DT. It will require slight changes in
drivers/net/phy/broadcom.c too and is not really necessary for minimal support,
so I will drop it in the next iteration.

Many thanks,
Andrea

> -- 
> Florian
> 

