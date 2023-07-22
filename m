Return-Path: <netdev+bounces-20135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2333375DCAA
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 14:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DF22822C7
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698E11D2F8;
	Sat, 22 Jul 2023 12:43:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC0F4431
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 12:43:51 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6176110FD
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 05:43:48 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qNBx5-0007uX-3D;
	Sat, 22 Jul 2023 12:43:16 +0000
Date: Sat, 22 Jul 2023 13:43:07 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>,
	Jakub Kicinski <kuba@kernel.org>, John Crispin <john@phrozen.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>
Subject: Re: Aw: Re: [PATCH net-next 0/4] Remove legacy phylink behaviour
Message-ID: <ZLvO2_OCBO53oS5c@makrotopia.org>
References: <ZLptIKEb7qLY5LmS@shell.armlinux.org.uk>
 <ZLsJWXyFJ0oKLkEq@makrotopia.org>
 <trinity-d3292c8a-89e4-4d5e-838f-cdf1f65ff58b-1690029105348@3c-app-gmx-bs12>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-d3292c8a-89e4-4d5e-838f-cdf1f65ff58b-1690029105348@3c-app-gmx-bs12>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 22, 2023 at 02:31:45PM +0200, Frank Wunderlich wrote:
> Hi
> 
> > Gesendet: Samstag, 22. Juli 2023 um 00:40 Uhr
> > Von: "Daniel Golle" <daniel@makrotopia.org>
> >
> > Hi Russell,
> >
> > On Fri, Jul 21, 2023 at 12:33:52PM +0100, Russell King (Oracle) wrote:
> > > Hi,
> > >
> > > This series removes the - as far as I can tell - unreachable code in
> > > mtk_eth_soc that relies upon legacy phylink behaviour, and then removes
> > > the support in phylink for this legacy behaviour.
> > >
> > > Patch 1 removes the clocking configuration from mtk_eth_soc for non-
> > > TRGMII, non-serdes based interface modes, and disables those interface
> > > modes prior to phylink configuration.
> > >
> > > Patch 2 removes the mac_pcs_get_state() method from mtk_eth_soc which
> > > I believe is also not used - mtk_eth_soc appears not to be used with
> > > SFPs (which would use a kind of in-band mode) nor does any DT appear
> > > to specify in-band mode for any non-serdes based interface mode.
> > >
> > > With both of those dealt with, the kernel is now free of any driver
> > > relying on the phylink legacy mode. Therefore, patch 3 removes support
> > > for this.
> > >
> > > Finally, with the advent of a new driver being submitted today that
> > > makes use of state->speed in the mac_config() path, patch 4 ensures that
> > > any phylink_link_state member that should not be used in mac_config is
> > > either cleared or set to an invalid value.
> >
> > Thank you for taking care of this!
> 
> > For the whole series:
> >
> > Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> > Tested-by: Daniel Golle <daniel@makrotopia.org>
> >
> > Tested on BPi-R2 (MT7623N), BPi-R3 (MT7986A) and BPi-R64 (MT7622A).
> > All works fine as expected.
> 
> have you changed anything?
> 
> in my test with bpi-r2 i see boot hangs after link-up on my wan-port (still trgmii-mode configured), no access to userspace.
> 
> [   10.881844] mtk_soc_eth 1b100000.ethernet eth0: configuring for fixed/trgmii link mode
> [   10.891611] mtk_soc_eth 1b100000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> [   11.005814] mt7530-mdio mdio-bus:1f wan: configuring for phy/gmii link mode
> [   11.016654] mt7530-mdio mdio-bus:1f lan3: configuring for phy/gmii link mode
> [   11.025685] mt7530-mdio mdio-bus:1f lan2: configuring for phy/gmii link mode
> [   11.035122] mt7530-mdio mdio-bus:1f lan1: configuring for phy/gmii link mode
> [   11.045370] mt7530-mdio mdio-bus:1f lan0: configuring for phy/gmii link mode
> 
> [   15.144255] mt7530-mdio mdio-bus:1f wan: Link is Up - 1Gbps/Full - flow control rx/tx
> 
> removing the cable does not show link down so it looks like completely stalled...but also no panic/crash or similar.
> When booting without cable it hangs too (without the up-message of course).
> 
> > To apply the series I needed to resolve a minor conflict due to
> > net: ethernet: mtk_ppe: add MTK_FOE_ENTRY_V{1,2}_SIZE macros
> > being applied in the meantime.
> 
> i used yesterdays net-next (6.5-rc2) and put series on top (also needed to do one hunk of first patch manually) and
> then my defconfig,buildscript etc. maybe i miss anything?

I tested in a fairly similar way.

> 
> afair trgmii is basicly rgmii only with higher clock-setting...and if this is dropped from mac-driver but switch is still using it it cannot work, but i'm sure you know this ;)

For TRGMII mode mtk_gmac0_rgmii_adjust behavior should not have changed,
only speed-dependent adjustments for RGMII have been dropped.
I also didn't not see such a problem when I was testing.

However, I guess in my case the MAC interface mode has already been
setup in hardware because I booted the board via TFTP, hence U-Boot
already took care of initializing everything, so that can also be
a reason why it worked fine for me.

