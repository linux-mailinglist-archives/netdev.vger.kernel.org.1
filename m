Return-Path: <netdev+bounces-56780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53855810D2D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097CC1F210A0
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026B1EB58;
	Wed, 13 Dec 2023 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WABEb+4G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9134BB7
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 01:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=S9gv7pPUxkoLt0tyAxCpE1lP8Dqrry7GadZ99nPae2g=; b=WA
	BEb+4G/tY+F1W/Cz4edYln9g7ZO+D6LsO88Di9RYGs4TJAk0378+0D5EkCd5Q8h1sb7ZxqrxE24WO
	XXd+3qHZ5qqaDGB7G0LCp8fIM5uHm8t3exsQCY7Ru5rvZ5p3HMAoaWDNS1ZLuSW1VUmQr1ffmyfkI
	rQ0s609CzyaAVQY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDLMV-002nhD-Gs; Wed, 13 Dec 2023 10:17:03 +0100
Date: Wed, 13 Dec 2023 10:17:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Richard Tresidder <rtresidd@electromag.com.au>
Cc: Jakub Kicinski <kuba@kernel.org>, vinschen@redhat.com,
	netdev@vger.kernel.org
Subject: Re: STMMAC Ethernet Driver support
Message-ID: <d0b7cc4b-2322-469b-b588-00c69e3afa46@lunn.ch>
References: <e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au>
 <20231208101216.3fca85b1@kernel.org>
 <8a0850d8-a2e4-4eb0-81e1-d067f18c2263@electromag.com.au>
 <41903b8b-d145-4fdf-a942-79d7f88f9068@electromag.com.au>
 <f47b0230-1513-4a81-9d78-3f092b979c48@electromag.com.au>
 <2139624b-e098-457a-bda4-0387d576b53a@lunn.ch>
 <8ba4d31f-9436-43ad-afd7-997a4d3a4bf2@electromag.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ba4d31f-9436-43ad-afd7-997a4d3a4bf2@electromag.com.au>

On Tue, Dec 12, 2023 at 11:57:22AM +0800, Richard Tresidder wrote:
> 
> <font face="monospace">Richard Tresidder</font>
> 
> 
> On 12/12/2023 12:16 am, Andrew Lunn wrote:
> > > We use the SOC's internal  STMMAC interface to connect to a Marvel switch IC
> > > and expose each port individually using vlan, I'd forgot that part.
> > > It's an  88E6352-xx-TFJ2I000  device utilising the 'marvell,mv88e6085'
> > > compatible driver  in drivers\net\dsa\mv88e6xxx
> > Its odd you need VLANs. Each port should already be exposed to the
> > host as netdev interfaces. That is what DSA does.
> > 
> >       Andrew
> Hi Andrew
>    I'll read further on that one as this is the first time I've had to dig
> into this side of the system.
> It had always "just worked".
> The ports show up in an 'ip l' list in the same style as a vlan with an @
> symbol, naming isn't quite vlan style though.
> That in concert with the fact this 'vlan_feature' line broke things has
> possibly distorted my view of how they're propagated.
> It's a rather trimmed down busybox image, so I'm missing some tools I'd
> usually use to examine stuff.
> 
> This is the config in the dts
> **************************************
> //------------------------------------------------------------------------------
> // connected to dsa network switch
> &gmac1 {
>   clock-names = "stmmaceth", "clk_ptp_ref";
>   clocks = <&emac1_clk &hps_eosc1>;
>   f2h_ptp_ref_clk;
>   fixed-link {
>     speed = <1000>;
>     full-duplex;
>   };
> };
> 
> //------------------------------------------------------------------------------
> &mdio1 {
>   #address-cells = <1>;
>   #size-cells = <0>;
> 
>   switch0: switch0@0 {
>     compatible = "marvell,mv88e6085";
>     #address-cells = <1>;
>     reg = <0>;
>     //reset-gpios = <&pio_a0 2 GPIO_ACTIVE_LOW>;
> 
>     dsa,member = <0 0>;
> 
>     ports {
>       #address-cells = <1>;
>       #size-cells = <0>;
> 
>       port@2 {
>         reg = <2>;
>         label = "lan1";
>         phy-handle = <&switch1phy2>;
>       };
> 
>       port@3 {
>         reg = <3>;
>         label = "lan2";
>         phy-handle = <&switch1phy3>;
>       };
> 
>       port@4 {
>         reg = <4>;
>         label = "lan3";
>         phy-handle = <&switch1phy4>;
>       };
> 
>       port@5 {
>         reg = <5>;
>         label = "wifi";
>         fixed-link {
>           speed = <100>;
>           full-duplex;
>         };
>       };
> 
>       port@6 {
>         reg = <6>;
>         label = "cpu";
>         ethernet = <&gmac1>;
>         fixed-link {
>           speed = <1000>;
>           full-duplex;
>         };
>       };
> 
>     };
> 
>     mdio {
>       #address-cells = <1>;
>       #size-cells = <0>;
>       switch1phy2: switch1phy2@2 {
>         reg = <2>;
>         marvell,reg-init = <0 0x10 0 0x0200>; // Sense only on Rx Energy
> Detect, no FLPs sents
>       };
>       switch1phy3: switch1phy3@3 {
>         reg = <3>;
>         marvell,reg-init = <0 0x10 0 0x0200>; // Sense only on Rx Energy
> Detect, no FLPs sents
>       };
>       switch1phy4: switch1phy4@4 {
>         reg = <4>;
>         marvell,reg-init = <0 0x10 0 0x0200>; // Sense only on Rx Energy
> Detect, no FLPs sents
>       };
>     };
> 
>     };
> };

That all looks normal, expect the marvell,reg-init. That is a pretty
ugly hack, from years and years ago, which should not be used any
more. It would be better to add a DT property for what you want, or a
PHY tunable.


> This is how they appear using 'ip l'
> The @ symbol got me as I've usually associated this with vlan's in my day to
> day networking.

The @ is just trying to show there is a relationship between to
interfaces. Its a VLAN on top of a base interface, or its a DSA user
port on top of a conduit interface.

So there is nothing odd at all here. What i have seen is user space
hacks to run Marvell SDK to program the switch to map a VLAN to a
port. There is no point doing that when you have a perfectly good
kernel driver.

     Andrew

