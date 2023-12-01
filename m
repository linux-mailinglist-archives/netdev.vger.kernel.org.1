Return-Path: <netdev+bounces-53045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A75801281
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCD0B20EEB
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675CF4F204;
	Fri,  1 Dec 2023 18:19:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1EF13E;
	Fri,  1 Dec 2023 10:19:44 -0800 (PST)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1r986k-000740-1c;
	Fri, 01 Dec 2023 18:19:23 +0000
Date: Fri, 1 Dec 2023 18:19:20 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: phylink: set phy_state interface when attaching
 SFP
Message-ID: <ZWojqBKfZvShtjel@makrotopia.org>
References: <8abed37d01d427bf9d27a157860c54375c994ea1.1700887953.git.daniel@makrotopia.org>
 <ZWGwJE0aCC/H3O2A@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWGwJE0aCC/H3O2A@shell.armlinux.org.uk>

On Sat, Nov 25, 2023 at 08:28:20AM +0000, Russell King (Oracle) wrote:
> On Sat, Nov 25, 2023 at 04:56:20AM +0000, Daniel Golle wrote:
> > Assume 'usxgmii' being set as initial interface mode in DTS. Now plug
> > a 2.5GBase-T SFP module with exposed PHY. Currently this results in
> > a rather bizare situation:
> > 
> > RTL8221B-VB-CG 2.5Gbps PHY (C45) i2c:sfp1-wan:11: rtl822x_c45_get_features: supported=00,00000000,00008000,000080ef
> > mtk_soc_eth 15100000.ethernet eth2: requesting link mode phy/2500base-x with support 00,00000000,00008000,0000e0ef
> > mtk_soc_eth 15100000.ethernet eth2: switched to phy/2500base-x link mode   <<< !!!!!!
> > mtk_soc_eth 15100000.ethernet eth2: major config usxgmii    <<< !!!!!!
> > mtk_soc_eth 15100000.ethernet eth2: phylink_mac_config: mode=phy/usxgmii/none adv=00,00000000,00000000,00000000 pause=00
> > mtk_soc_eth 15100000.ethernet eth2: PHY [i2c:sfp1-wan:11] driver [RTL8221B-VB-CG 2.5Gbps PHY (C45)] (irq=POLL)
> > mtk_soc_eth 15100000.ethernet eth2: phy: 2500base-x setting supported 00,00000000,00008000,0000e0ef advertising 00,00000000,00008000,0000e0ef
> > 
> > Then the link seemingly comes up (but is dead) because no subsequent
> > call to phylink_major_config actually configured MAC and PCS for
> > 2500base-x mode.
> > 
> > This is because phylink_mac_initial_config() considers
> > pl->phy_state.interface if in MLO_AN_PHY mode while
> > phylink_sfp_set_config() only sets pl->link_config.interface.
> > 
> > Also set pl->phy_state.interface in phylink_sfp_set_config().
> 
> Does it _actually_ matter?

It does matter, I'm suggesting this change because the SFP module
won't work without it.

> When the PHY's link comes up, doesn't it get sorted out for the real
> mode that will be used?

That does happen once the interface mode *changes* to anything else,
than 2500M/Full and the PHY driver sets state->interface to SGMII.
However, initially it does *not* happen, probably because phylink
ends up believing MAC and PCS are already operating in 2500base-x
mode (but that's not the case).

Previously (eg. with the BananaPi R3) this has not been a problem
because the default interface mode defined in device tree anyway has
also been 2500base-x. Now that I'm testing the same module with the
R4 which uses usxgmii by default the problem surfaced.

