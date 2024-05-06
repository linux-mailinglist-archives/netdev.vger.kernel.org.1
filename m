Return-Path: <netdev+bounces-93707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE2B8BCDF4
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CA91C2383F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D857014431F;
	Mon,  6 May 2024 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY61CW2c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE9143C50;
	Mon,  6 May 2024 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998554; cv=none; b=MlPJY+3s3O37k12W8vk6lrtUe7LvDb7pMLAhjNK8e1xaOHl7R0AQeWDUUYp1trlEIyjRbulU1Yfv4fmtiSpNZHNdyCvn3teikCVEvOS/gRkeNC4F1Y6IEgp0l5rzFvdQenMf7H4i0Szn7SgPfdtMdLcDalknJXy4LYLc0Idh8Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998554; c=relaxed/simple;
	bh=sajSVbpQQVWfzjIjb2J4Yq7NAW+S1ejV3grweJRqLLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT/QsxJmDYztN3eNxwaQt5mHqQJSWsrFtDCIx2toDq9ufRu4+0H7B+ECjWxpfIIuf0IIAswOTZ0WQO2NSh+eKvbzf3ChNS5ckfH/zamsKzBEPbBGDJmt4cQOo6RvA4NMjNylduq4p67et4hwVtv2UFu9ruyMwzTL0lf/AXRnZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY61CW2c; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34da35cd01cso1747485f8f.2;
        Mon, 06 May 2024 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714998551; x=1715603351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DBfsNC19rPNR16qUNGOxKom5OYtxMKfBBimwIPACZsU=;
        b=mY61CW2cKbJ4cNAl7w1xWGVCwo7iHOnEUshytSRE7AnLRhsEYXJZ+avSfxOPz088Y3
         qARnuX1MmYdQAcmy5J++tT/G6dvLsdCHSuV56pz6Q0FuWaXolRSGKEZ4cqLaw6mDe8vC
         x36aOBk5r74hsjwq63gNknPaglnInbyJjh4TMpPBCEJKX5R5gm0MF8wxRHX0ep7w0Wjn
         AZZCoLGSQRCXYOwxz912TcxnPNMosSjX3JrgJ8RJtyqxTrtdaTV5nSThnvm6akFUagwe
         zoP9bJlWjHa2RkFkraW+xUAHiXYhS35G3UNe4b2TDjYxCLV0ubT6l6q0tk9QshjYzC09
         gINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714998551; x=1715603351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBfsNC19rPNR16qUNGOxKom5OYtxMKfBBimwIPACZsU=;
        b=GpHvT4zGPYoEzefzykIGl+qrJinGzjkU9nmWYBWXdOzpUar6uNtiMGpxlr8YGiHosR
         Wz/COjUTlZI1mFpYVPhELzinxLCpwZkXxU9ORvJEQpij7zSMxqrXwyQpNviaY19BTDJW
         087xqQE4dys2jZW1WPT3DybY4dRL/ZdWtdpiaT3TSZCE4ckPiY+ZsEvBUxunbt/E5Mca
         caC5gv7xFTFByuhk1MrVFsMdoL/PqUWzVYMdXwSmhgMIC6KDp0zRfuziJRf39TdwcXRR
         8a5tfO7dXD2t1AZs6MJvjHnEBxj0E5R6jvyC0J6dOQS5O9BgjK+mmFhO9gfkHAHBj1ZX
         Mm5A==
X-Forwarded-Encrypted: i=1; AJvYcCUxcZINJyilXzngy2KUwKVODu+B7kr5YEG/CLA3woc57SsFm89pDx6TVsV9P+Z0BDzAs99n/6v0gxnhKw/T0kCujUbDe1w3hWo8sNP40P2QExIOVFAAuieKmQc3pAmwCKdbtEhK2QcCa//tLidQokzmSzV1RzZwFEj8tuqNx/XYRQ==
X-Gm-Message-State: AOJu0YyPWD396oY5Tf8XcwtBZDDPer1jKtE0A1Ykvy0qvMJ24DGQkbcG
	swJpVR2P0ucYpKnGtTMDZw6vNOcqqF68ELy/pAq12HyLnZHE+ewV
X-Google-Smtp-Source: AGHT+IH4vs2suWLEPsQrwp4kV7M90dNck7PxfG+1yQ451/pvKhK19o0/XcgDeD+Xz05jC5FqD8M+1w==
X-Received: by 2002:adf:f7ce:0:b0:34c:def3:2f82 with SMTP id a14-20020adff7ce000000b0034cdef32f82mr8284909wrq.27.1714998550675;
        Mon, 06 May 2024 05:29:10 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:f8e4:2dcd:2c07:4d8e])
        by smtp.gmail.com with ESMTPSA id i3-20020a5d6303000000b00347eb354b30sm10539322wru.84.2024.05.06.05.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 05:29:09 -0700 (PDT)
Date: Mon, 6 May 2024 14:29:08 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, michael@walle.cc,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <ZjjNFAB7cyXajH8a@eichest-laptop>
References: <Zio9g9+wsFX39Vkx@eichest-laptop>
 <ZippHJrnvzXsTiK4@shell.armlinux.org.uk>
 <Zip8Hd/ozP3R8ASS@eichest-laptop>
 <ZiqFOko7zFjfTdz4@shell.armlinux.org.uk>
 <ZiqUB0lwgw7vIozG@eichest-laptop>
 <Ziq5+gRXGmqt9bXM@shell.armlinux.org.uk>
 <ZjOYuP5ypnH8GJWd@eichest-laptop>
 <ZjOftdnoToSSsVJ1@shell.armlinux.org.uk>
 <ZjUSaVqkmt7+ihTA@eichest-laptop>
 <ZjVn/5KD72zKEcnK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjVn/5KD72zKEcnK@shell.armlinux.org.uk>

On Fri, May 03, 2024 at 11:41:03PM +0100, Russell King (Oracle) wrote:
> On Fri, May 03, 2024 at 06:35:53PM +0200, Stefan Eichenberger wrote:
> > On Thu, May 02, 2024 at 03:14:13PM +0100, Russell King (Oracle) wrote:
> > > On Thu, May 02, 2024 at 03:44:24PM +0200, Stefan Eichenberger wrote:
> > > > Hi Russell,
> > > > 
> > > > Sorry for the late reply but I wanted to give you some update after
> > > > testing with the latest version of your patches on net-queue.
> > > 
> > > I've also been randomly distracted, and I've been meaning to ping you
> > > to test some of the updates.
> > > 
> > > http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue
> > > 
> > > The current set begins with:
> > > 
> > > "net: sfp-bus: constify link_modes to sfp_select_interface()" which is
> > > now in net-next, then the patches between and including:
> > > 
> > > "net: phylink: validate sfp_select_interface() returned interface" to
> > > "net: phylink: clean up phylink_resolve()"
> > > 
> > > That should get enough together for the PCS "neg" mode to be consistent
> > > with what the MAC driver sees.
> > > 
> > > The remaining bits that I still need to sort out is the contents of
> > > phylink_pcs_neg_mode() for the 802.3z mode with PHY, and also working
> > > out some way of handling the SGMII case where the PHY and PCS disagree
> > > (one only supporting inband the other not supporting inband.)
> > > 
> > > I'm not sure when I'll be able to get to that - things are getting
> > > fairly chaotic again, meaning I have again less time to spend on
> > > mainline... and I'd like to take some vacation time very soon (I really
> > > need some time off!)
> > 
> > No problem, I'm also quite busy at the moment and I have the workaround
> > to test the hardware, so it is nothing urgent for me.
> > 
> > > > I think I see the problem you are describing.
> > > > 
> > > > When the driver starts it will negotiate MLO_AN_PHY based on the
> > > > capabilities of the PHY and of the PCS. However when I switch to 1GBit/s
> > > > it should switch to MLO_AN_INBAND but this does not work. Here the
> > > > output of phylink:
> > > 
> > > I'm designing this to work the other way - inband being able to fall
> > > back to PHY (out of band) mode rather than PHY mode being able to fall
> > > forwards to inband mode.
> > 
> > I tested again with 89e0a87ef79db9f3ce879e9d977429ba89ca8229 and I think
> > in my setup the problem is that it doesn't fall back to PHY mode but
> > takes it as default mode. Here what happens when I have the mxl-gpy PHY
> > connected to a 1000 GBit/s port:
> > [    9.331179] mvpp2 f2000000.ethernet eth1: Using firmware node mac address 00:51:82:11:22:02
> > [   14.674836] mvpp2 f2000000.ethernet eth1: PHY f212a600.mdio-mii:11 doesn't supply possible interfaces
> > [   14.674853] mvpp2 f2000000.ethernet eth1:  interface 2 (mii) rate match none supports 0-3,6,13-14
> > [   14.674864] mvpp2 f2000000.ethernet eth1:  interface 4 (sgmii) rate match none supports 0-3,5-6,13-14
> > [   14.674871] mvpp2 f2000000.ethernet eth1:  interface 9 (rgmii) rate match none supports 0-3,5-6,13-14
> > [   14.674877] mvpp2 f2000000.ethernet eth1:  interface 10 (rgmii-id) rate match none supports 0-3,5-6,13-14
> > [   14.674883] mvpp2 f2000000.ethernet eth1:  interface 11 (rgmii-rxid) rate match none supports 0-3,5-6,13-14
> > [   14.674889] mvpp2 f2000000.ethernet eth1:  interface 12 (rgmii-txid) rate match none supports 0-3,5-6,13-14
> > [   14.674895] mvpp2 f2000000.ethernet eth1:  interface 22 (1000base-x) rate match none supports 5-6,13-14
> > [   14.674900] mvpp2 f2000000.ethernet eth1:  interface 23 (2500base-x) rate match none supports 6,13-14,47
> > [   14.674907] mvpp2 f2000000.ethernet eth1: PHY [f212a600.mdio-mii:11] driver [Maxlinear Ethernet GPY215C] (irq=POLL)
> > [   14.685444] mvpp2 f2000000.ethernet eth1: phy: 2500base-x setting supported 00,00000000,00008000,0000606f advertising 00,00000000,00008000,0000606f
> > [   14.686635] mvpp2 f2000000.ethernet eth1: configuring for phy/2500base-x link mode
> > [   14.694263] mvpp2 f2000000.ethernet eth1: major config, requested phy/2500base-x
> 
>                                                                        ^^^
> 
> You're still requesting (from firmware) for PHY mode, and phylink will
> _always_ use out-of-band if firmware requests that.
> 
> > [   14.700402] mvpp2 f2000000.ethernet eth1: major config, active phy/outband/2500base-x
> 
> So it uses PHY mode for 2500base-X, which is correct.
> 
> > [   17.768370] mvpp2 f2000000.ethernet eth1: major config, requested phy/sgmii
> 
> Still requesting PHY mode with SGMII, which historically we've always
> used out-of-band mode for, so we preserve that behaviour.
> 
> > [   17.774602] mvpp2 f2000000.ethernet eth1: firmware wants phy mode, but PHY requires inband
> 
> So we complain about it with an error, because it is wrong...
> 
> > [   17.782976] mvpp2 f2000000.ethernet eth1: major config, active phy/outband/sgmii
> 
> and we still try to use it (correctly, because that's what phylink
> has always done in this case.)
> 
> As I tried to explain, there is fall-back from MLO_AN_INBAND to
> MLO_AN_PHY, but there won't be fall-forward from MLO_AN_PHY to
> MLO_AN_INBAND.

I still don't get it, sorry. So the mxl-gpy driver currently has two
modes:
2500 MBit/s -> PHY_INTERFACE_MODE_2500BASEX -> (0 no inband)
1000 MBit/s -> PHY_INTERFACE_MODE_SGMII -> LINK_INBAND_ENABLE
If I use this configureation it will not work because there is no
fallback from MLO_AN_PHY to MLO_AN_INBAND.

Now if I understand everyting correctly, this happens for 1000 MBit/s
and SGMII because the firmware decides to use PHY mode. I modified
the PHY driver to use 1000BASEX instead:
2500 MBit/s -> PHY_INTERFACE_MODE_2500BASEX -> (0 no inband)
1000 MBit/s -> PHY_INTERFACE_MODE_1000BASEX -> LINK_INBAND_ENABLE
However, the same thing happens:
[   14.635831] mvpp2 f2000000.ethernet eth1: PHY [f212a600.mdio-mii:11] driver [Maxlinear Ethernet GPY215C] (irq=POLL)
[   14.646742] mvpp2 f2000000.ethernet eth1: phy: 2500base-x setting supported 00,00000000,00008000,0000606f advertising 00,00000000,00008000,0000606f
[   14.647986] mvpp2 f2000000.ethernet eth1: configuring for phy/2500base-x link mode
[   14.655784] mvpp2 f2000000.ethernet eth1: major config, requested phy/2500base-x
[   14.663313] mvpp2 f2000000.ethernet eth1: major config, active phy/outband/2500base-x
[   14.663323] mvpp2 f2000000.ethernet eth1: phylink_mac_config: mode=phy/2500base-x/none adv=00,00000000,00000000,00000000 pause=00
[   14.666098] mvpp2 f2000000.ethernet eth1: phy link down 2500base-x/2.5Gbps/Full/none/rx/tx
[   18.760959] mvpp2 f2000000.ethernet eth1: phy link up 2500base-x/2.5Gbps/Full/none/rx/tx
[   18.760977] mvpp2 f2000000.ethernet eth1: pcs link up
[   18.761211] mvpp2 f2000000.ethernet eth1: can LPI, EEE enabled, inactive
[   18.761231] mvpp2 f2000000.ethernet eth1: Link is Up - 2.5Gbps/Full - flow control rx/tx
[   70.983936] mvpp2 f2000000.ethernet eth1: phy link down 2500base-x/Unknown/Full/none/rx/tx
[   70.983965] mvpp2 f2000000.ethernet eth1: deactivating EEE, was inactive
[   70.984017] mvpp2 f2000000.ethernet eth1: pcs link down
[   70.985000] mvpp2 f2000000.ethernet eth1: Link is Down
[   74.057088] mvpp2 f2000000.ethernet eth1: phy link up 1000base-x/1Gbps/Full/none/rx/tx
[   74.057109] mvpp2 f2000000.ethernet eth1: major config, requested phy/1000base-x
[   74.063342] mvpp2 f2000000.ethernet eth1: firmware wants phy mode, but PHY requires inband
[   74.071706] mvpp2 f2000000.ethernet eth1: major config, active phy/outband/1000base-x
[   74.072902] mvpp2 f2000000.ethernet eth1: phylink_mac_config: mode=phy/1000base-x/none adv=00,00000000,00000000,00000000 pause=03
[   74.072976] mvpp2 f2000000.ethernet eth1: pcs link up
[   74.073225] mvpp2 f2000000.ethernet eth1: can LPI, EEE enabled, active
[   74.073245] mvpp2 f2000000.ethernet eth1: enabling tx_lpi, timer 250us
[   74.073279] mvpp2 f2000000.ethernet eth1: Link is Up - 1Gbps/Full - flow control rx/tx

If I then request inband by setting managed = "in-band-status" in the
device tree the logic will fail because there is not phydev and
therefore the link will never be configured for phy mode (it falls back
to "Legacy, so determine inband depending on the advertising bit"):
[    9.299037] mvpp2 f2000000.ethernet eth1: Using firmware node mac address 00:51:82:11:22:02
[   14.586343] mvpp2 f2000000.ethernet eth1: configuring for inband/2500base-x link mode
[   14.595669] mvpp2 f2000000.ethernet eth1: major config, requested inband/2500base-x
[   14.631876] mvpp2 f2000000.ethernet eth1: major config, active inband/inband/an-enabled/2500base-x
[   14.631887] mvpp2 f2000000.ethernet eth1: phylink_mac_config: mode=inband/2500base-x/none adv=00,00000000,00008000,0000e240 pause=04
[   14.633208] mvpp2 f2000000.ethernet eth1: pcs link up
[   14.633241] mvpp2 f2000000.ethernet eth1: can LPI, EEE enabled, inactive
[   14.633262] mvpp2 f2000000.ethernet eth1: Link is Up - 2.5Gbps/Full - flow control off
[   60.713862] mvpp2 f2000000.ethernet eth1: pcs link down
[   60.713947] mvpp2 f2000000.ethernet eth1: deactivating EEE, was inactive
[   60.714978] mvpp2 f2000000.ethernet eth1: Link is Down
[   60.720200] mvpp2 f2000000.ethernet eth1: pcs link up
[   60.720586] mvpp2 f2000000.ethernet eth1: can LPI, EEE enabled, inactive
[   60.720619] mvpp2 f2000000.ethernet eth1: Link is Up - 2.5Gbps/Full - flow control off
[   63.012413] mvpp2 f2000000.ethernet eth1: pcs link down
[   63.012444] mvpp2 f2000000.ethernet eth1: deactivating EEE, was inactive
[   63.013480] mvpp2 f2000000.ethernet eth1: Link is Down

Or is there a way to configure the firmware to use inband by default but
sill having a phydev device? 

For me it is not entirely clear which scenario should work for the
mxl-gpy in the end?

Scenario A:
2500 MBit/s -> PHY_INTERFACE_MODE_2500BASEX -> (0 no inband)
1000 MBit/s -> PHY_INTERFACE_MODE_SGMII -> LINK_INBAND_ENABLE
Then I would need a way to tell that the default mode is inband but that
there is still a phydev device available. Maybe this is possible and I
simply don't know how to do it?

Scenario B:
2500 MBit/s -> PHY_INTERFACE_MODE_2500BASEX -> LINK_INBAND_DISABLE
1000 MBit/s -> PHY_INTERFACE_MODE_1000BASEX -> LINK_INBAND_ENABLE
Then the phylink logic should change the firmwares mode depending on the
speed. Would this also work with 100MBit/s and 10MBit/s?

Scenario C (which I understand is not wanted):
2500 MBit/s -> PHY_INTERFACE_MODE_2500BASEX -> (0 no inband)
1000 MBit/s -> PHY_INTERFACE_MODE_SGMII -> (0 no inband)
This would already work but would require me to change the phy driver
and is not the desired behaviour anyways.

Sorry for my confusion, regards,
Stefan


