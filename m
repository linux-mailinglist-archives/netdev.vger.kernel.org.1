Return-Path: <netdev+bounces-26383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B9F777A82
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6541C215BD
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A867C1FB51;
	Thu, 10 Aug 2023 14:23:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF61E1AC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:23:21 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAFE2D71
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yuAIT0NXdAmLpZhHztgK0xkG5TYP04lC8XEq91dV1fI=; b=jlHiEvHyflIeeNXudqgwNSV0dv
	SpW7z31cWYjowffEg2OxUnhMD4ZfT1DZw1v92tIwCzxCt92LXHE2a5SV6czg76m8RNmATxSsC7wTQ
	TZOO2uG7a/IeD+6mn7ljrmghum9/jbd111Weu1OZJ3QzRJQGnCOOnaEJQv55JoLhMUTA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qU6ZA-003hWk-3u; Thu, 10 Aug 2023 16:23:08 +0200
Date: Thu, 10 Aug 2023 16:23:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Message-ID: <52154174-d3c3-4482-81c7-eadde1fed8af@lunn.ch>
References: <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
 <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
 <18601814-68f6-4597-9d88-a1b4b69ad34f@lunn.ch>
 <36ee0fa9-040a-8f7e-0447-eb3704ab8e11@denx.de>
 <ZNS1kalvEI6Y2Cs9@shell.armlinux.org.uk>
 <ZNS9GpMJEDi1zugk@shell.armlinux.org.uk>
 <20230810125117.GD13300@pengutronix.de>
 <ZNTjQnufpCPMEEwd@shell.armlinux.org.uk>
 <ffc4c902-689a-495a-9b57-e72601547c53@lunn.ch>
 <ZNTsMuuvqaOh6x0Q@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNTsMuuvqaOh6x0Q@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 02:54:58PM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 10, 2023 at 03:49:24PM +0200, Andrew Lunn wrote:
> > > > What will be the best way to solve this issue for DSA switches attached to
> > > > MAC with RGMII RXC requirements?
> > > 
> > > I have no idea - the problem there is the model that has been adopted
> > > in Linux is that there is no direct relationship between the DSA switch
> > > and the MAC like there is with a PHY.
> > 
> > A clock provider/consumer relationship can be expressed in DT. The DSA
> > switch port would provide the clock, rather than the PHY.
> 
> Then we'll be in to people wanting to do it for PHYs as well, and as
> we've recently discussed that isn't something we want because of the
> dependencies it creates between mdio drivers and mac drivers.
> 
> Wouldn't the same dependency issue also apply for a DSA switch on a
> MDIO bus, where the MDIO bus is part of the MAC driver?

We already have some level of circular dependencies with DSA, e.g. the
MAC driver provides the MDIO bus with the switch on it. It registers
the MDIO bus, causing the switch to probe. That probe fails because
the MAC driver has not registered its interface yet, which is the CPU
interface. We end up deferring the switch probe, and by the second
attempt, the MAC is fully registered and the switch probes.

The circular dependency with a clock consumer/provider between the MAC
and switch will be worse. We would need to avoid getting the clock in
the probe function. It would need to happen in during open, by which
time the switch should be present. MAC drivers also typically connect
to their PHY during open, not probe, so i don't see this as being too
big a problem.

As to unbind, my gut feeling is, the general case is too complex. It
is not a simple tree, where you can ensure unbind from the leaves
towards the root. Either we let root take its chance, or we just block
unbind.

	Andrew

