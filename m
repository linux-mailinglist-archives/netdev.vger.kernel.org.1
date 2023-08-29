Return-Path: <netdev+bounces-31298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D71278CB69
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8CF1C20978
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FEC18005;
	Tue, 29 Aug 2023 17:38:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D313B17FE6
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 17:38:22 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D8CC9
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:38:20 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qb2fO-0007vm-0O;
	Tue, 29 Aug 2023 17:38:15 +0000
Date: Tue, 29 Aug 2023 18:37:07 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	netdev@vger.kernel.org, simonebortolin@hack-gpon.org,
	nanomad@hack-gpon.org, Federico Cappon <dududede371@gmail.com>,
	lorenzo@kernel.org, ftp21@ftp21.eu, pierto88@hack-gpon.org,
	hitech95@hack-gpon.org, davem@davemloft.net, andrew@lunn.ch,
	edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
	pabeni@redhat.com, nbd@nbd.name
Subject: Re: [RFC] RJ45 to SFP auto-sensing and switching in mux-ed
 single-mac devices (XOR RJ/SFP)
Message-ID: <ZO4sw2gOQjn1GXDg@makrotopia.org>
References: <CAC8rN+AQUKH1pUHe=bZh+bw-Wxznx+Lvom9iTruGQktGb=FFyw@mail.gmail.com>
 <ZO4RAtaoNX6d66mb@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZO4RAtaoNX6d66mb@shell.armlinux.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 04:38:42PM +0100, Russell King (Oracle) wrote:
> On Tue, Aug 29, 2023 at 05:12:48PM +0200, Nicolò Veronese wrote:
> > Hi,
> > 
> > I and some folks in CC are working to properly port all the
> >  functions of a Zyxel ex5601-t0 to OpenWrt.
> > 
> > The manufacturer decided to use a single SerDes connected
> >  to both an SPF cage and an RJ45 phy. A simple GPIO is
> >  used to control a 2 Channel 2:1 MUX to switch the two SGMII pairs
> >  between the RJ45 and the SFP.
> > 
> >   ┌─────┐  ┌──────┐   ┌─────────┐
> >   │     │  │      │   │         │
> >   │     │  │      ├───┤ SFP     │
> >   │     │  │      │   └─────────┘
> >   │     │  │      │
> >   │ MAC ├──┤ MUX  │   ┌─────────┐
> >   │     │  │      │   │         │
> >   │     │  │      │   │ RJ45    │
> >   │     │  │      ├───┤ 2.5G PHY│
> >   │     │  │      │   │         │
> >   └─────┘  └───▲──┘   └─────────┘
> >                │
> >   MUX-GPIO ────┘

Note that most recent MediaTek SoCs have a similar setup built-into the
SoC itself: One MAC can either be internally connected to a built-in
2.5G TP PHY or used with an external PHY or SFP via SerDes ie.
USXGMII/10GBase-R/5GBase-R/2500Base-X/1000Base-X/SGMII **which doesn't
share any pins with the TP PHY**. Hence board manufactorers are likely
to build devices exposing that MAC in both ways, as SFP cage and 2.5G
PHY, because the 2.5G PHY basically comes "for free".

In this case switching the MAC between the two is done using a mux bit
in ETHSYS syscon. However, one should also take care of powering on
and off the 2.5G PHY and maintain the trapdoor in the MDIO bus
allowing the access either built-in PHY or an external PHY at the same
address, so it's a bit more complicated than just a single bit.

> 
> This is do-able in software, but is far from a good idea.
> 
> Yes, it would be possible to "disconnect" the RJ45 PHY from the netdev,
> and switch to the SFP and back again. It would be relatively easy for
> phylink to do that. What phylink would need to do is to keep track of
> the SFP PHY and netdev-native PHY independently, and multiplex between
> the two. It would also have to manage the netdev->phydev pointer.
> Any changes to this must be done under the rtnl lock.
> 
> So technically it's possible. However, there is no notification to
> userspace when such a change may occur. There's also the issue that
> userspace may be in the process of issuing ethtool commands that are
> affecting one of the PHYs. While holding the rtnl lock will block
> those calls, a change between the PHY and e.g. a PHY on the SFP
> would cause the ethtool command to target a different PHY from what
> was the original target.

I can see that the lack of such notification is already an issue even
without the change described above. I've actually struggled with that
just a few days ago:
Some of the SFP+ modules I use for testing expose the built-in
marvell10g PHY via I2C using the RollBall protocol. The protocol
apparently requires a long waiting time between power-on and being
able to access the PHY (something like 25 seconds). So any ethtool
command issued after boot and before the 25 seconds have passed will
have no effect as of today, because the PHY is only being attached
after that. And this is not only a problem when hot-plugging the
module, obviously, but also when having it plugged in already
during boot.

So having userspace notification "some about the PHY has changed"
would already be nice to have, because that'd would an easy way
OpenWrt's netifd could know that it has to re-read supported
capabilities and re-apply ethtool link settings.

> 
> To solve that sanely, every PHY-based ethtool probably needs a way
> to specify which PHY the command is intended for, but then there's
> the question of how userspace users react to that - because it's
> likely more than just modifying the ethtool utility, ethtool
> commands are probably used from many programs.

Maybe just a cookie to make sure "sessions" of ethtool calls are
not broken by a changed from PHY to SFP or vice versa?
Ie. GLINKSETTINGS will should give you a cookie to be used with
SLINKSETTINGS and so one. The cookie may not identify the PHY, but
rather just the previous call to GLINKSETTINGS.

And this could even be optional from perspective of userspace.

> 
> IMHO, it needs a bit of thought beyond "what can we do to support a
> mux".
> 

Another thing which came to my mind is the existing port field in
many ethtool ops which could be either PORT_TP or PORT_FIBRE to
destinguish the TP PHY from the SFP at least for xLINKSETTINGS.

