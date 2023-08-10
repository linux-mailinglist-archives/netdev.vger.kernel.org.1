Return-Path: <netdev+bounces-26371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0207779EE
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FAF1C215D0
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6F71EA6E;
	Thu, 10 Aug 2023 13:55:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A871E1B2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:55:06 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB3E212B
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OjeQjNMSaDjDI7/OWYt+S4+MnrkuOiq8uerulA3j8ds=; b=uM/es20/F9aDZDhLwct1IxdJvx
	3g67BtBA8hZM19SPG20uc6JXIPXr59ErwliRhulgo7WS/8Yg7NwChufHiyYCdNQcCKlBlM81ZUJPV
	UxXHG8P6j6CP3DQ0Wn5l2cQTDgntq65zBRErYmZp/1Tx7QcyY6pdY4QJAmZ2nOIQmsuMD55VUENFH
	MvpgFiN5LwyxM6z98XHNBOu7Q1J1jCBzOdh8/Ay/hO1pGZAS5uEgqdnfn37C5IN8dS1kduQverphv
	RgxSL8ByzNkj6SrblYYccu3AiO+gqCLzvQtfbDsfrf2ZEqNBBWS766uqhY8iBWbDYzuHLaqlK8pqc
	A7fusHEA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38070)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qU67w-00043h-0K;
	Thu, 10 Aug 2023 14:55:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qU67u-0001qp-Ur; Thu, 10 Aug 2023 14:54:58 +0100
Date: Thu, 10 Aug 2023 14:54:58 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Marek Vasut <marex@denx.de>,
	Wei Fang <wei.fang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <ZNTsMuuvqaOh6x0Q@shell.armlinux.org.uk>
References: <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
 <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
 <18601814-68f6-4597-9d88-a1b4b69ad34f@lunn.ch>
 <36ee0fa9-040a-8f7e-0447-eb3704ab8e11@denx.de>
 <ZNS1kalvEI6Y2Cs9@shell.armlinux.org.uk>
 <ZNS9GpMJEDi1zugk@shell.armlinux.org.uk>
 <20230810125117.GD13300@pengutronix.de>
 <ZNTjQnufpCPMEEwd@shell.armlinux.org.uk>
 <ffc4c902-689a-495a-9b57-e72601547c53@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffc4c902-689a-495a-9b57-e72601547c53@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 03:49:24PM +0200, Andrew Lunn wrote:
> > > What will be the best way to solve this issue for DSA switches attached to
> > > MAC with RGMII RXC requirements?
> > 
> > I have no idea - the problem there is the model that has been adopted
> > in Linux is that there is no direct relationship between the DSA switch
> > and the MAC like there is with a PHY.
> 
> A clock provider/consumer relationship can be expressed in DT. The DSA
> switch port would provide the clock, rather than the PHY.

Then we'll be in to people wanting to do it for PHYs as well, and as
we've recently discussed that isn't something we want because of the
dependencies it creates between mdio drivers and mac drivers.

Wouldn't the same dependency issue also apply for a DSA switch on a
MDIO bus, where the MDIO bus is part of the MAC driver?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

