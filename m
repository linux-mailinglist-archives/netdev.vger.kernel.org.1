Return-Path: <netdev+bounces-235204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D11FCC2D680
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 919D54EB04E
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0EA31A547;
	Mon,  3 Nov 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IKWwfVo0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3B4316196
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190011; cv=none; b=pvFviLLSHTlZR/8vlfrTIN2ORyqQLftDxIeR1SjuWF29iZJ3tqux/9Mbv0RmcvLmk+N5zeVe7+8MbvODZGNNEFfCf4br88W5pBYt3Mq7mg/pxdXmnml7cbT9MUz0Ee8/oUFPMvhf+VHTSTvPo5v69PjHH/ZCW6x829DcVnGrQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190011; c=relaxed/simple;
	bh=fsmHOcmwq3xZNRDzXEyU+IsRTzpCmRB6li48PMVRPjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K97pjDs8Y4HTbIc08a5fHpZ3Nw9aBiuQnClBsnjiGtSaqDB3VxtEFb0ihLTw6YVRMNP86PCYSvdrA+wNxR0OOQ6QAhu0vziHvPrIF+eped8DP2M3cR65gWE2tTy6CQDDxm+DcQ8HhbEus4+CH3TjbLABEajE4gWeHvPCVNfX67E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IKWwfVo0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3g1k5z9QZtVKxfebNO7l/sUZbduhdBqPx9U8LzUB+3E=; b=IKWwfVo0k+dg5F4B80R3fzFVbn
	kpz8WtfyA5VLECRpnJA9r38WQi7lV0806FM+FWzeQ6BGIIcXylwwqOvbqWiuEalI51eWVV/vcVFGX
	itpTGm1hzGt+Io4ZJ9hveg3qGkuLRB6Msq6KvYvG/eIs9RZ0UYcq0xeW84b3V1xl8ZoGS90GkMvYK
	Yb/Pijl9Tbd7MdVuhigsjqYIu7LA5rdWE9Zl6Dsp085dM8oNq20HoKg9BAhV7YL0Yh7YE58lrSCgM
	HhMvzKZkMrCd+/cQacDJWajyNw3D6gOGrCi0umj9ZJ1vKvg3xr/u1UTQorIAm2Uegl9jvLtS6nSSa
	38ciuVRg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43392)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vFy7E-000000001BH-2sTw;
	Mon, 03 Nov 2025 17:13:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vFy7B-000000003xw-1GdJ;
	Mon, 03 Nov 2025 17:13:09 +0000
Date: Mon, 3 Nov 2025 17:13:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aQjipW51FwQyw9rc@shell.armlinux.org.uk>
References: <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
 <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
 <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
 <aQiBjYNtJks2/mrw@oss.qualcomm.com>
 <20251103104820.3fcksk27j34zu6cg@skbuf>
 <aQiP46tKUHGwmiTo@oss.qualcomm.com>
 <aQiVWydDsRaMz8ua@shell.armlinux.org.uk>
 <aQidX6SPDbOQ5WKU@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQidX6SPDbOQ5WKU@oss.qualcomm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 03, 2025 at 05:47:35PM +0530, Mohd Ayaan Anwar wrote:
> On Mon, Nov 03, 2025 at 11:43:23AM +0000, Russell King (Oracle) wrote:
> > On Mon, Nov 03, 2025 at 04:50:03PM +0530, Mohd Ayaan Anwar wrote:
> > > On Mon, Nov 03, 2025 at 12:48:20PM +0200, Vladimir Oltean wrote:
> > > > 
> > > > As Russell partially pointed out, there are several assumptions in the
> > > > Aquantia PHY driver and in phylink, three of them being that:
> > > > - rate matching is only supported for PHY_INTERFACE_MODE_10GBASER and
> > > >   PHY_INTERFACE_MODE_2500BASEX (thus not PHY_INTERFACE_MODE_SGMII)
> > > > - if phy_get_rate_matching() returns RATE_MATCH_NONE for an interface,
> > > >   pl->phy_state.rate_matching will also be RATE_MATCH_NONE when using
> > > >   that interface
> > > > - if rate matching is used, the PHY is configured to use it for all
> > > >   media speeds <= phylink_interface_max_speed(link_state.interface)
> > > > 
> > > > Those assumptions are not validated very well against the ground truth
> > > > from the PHY provisioning, so the next step would be for us to see that
> > > > directly.
> > > > 
> > > > Please turn this print from aqr_gen2_read_global_syscfg() into something
> > > > visible in dmesg, i.e. by replacing phydev_dbg() with phydev_info():
> > > > 
> > > > 		phydev_dbg(phydev,
> > > > 			   "Media speed %d uses host interface %s with %s\n",
> > > > 			   syscfg->speed, phy_modes(syscfg->interface),
> > > > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_NONE ? "no rate adaptation" :
> > > > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_PAUSE ? "rate adaptation through flow control" :
> > > > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_USX ? "rate adaptation through symbol replication" :
> > > > 			   "unrecognized rate adaptation type");
> > > 
> > > Thanks. Looks like rate adaptation is only provisioned for 10M, which
> > > matches my observation where phylink passes the exact speeds for
> > > 100/1000/2500 but 1000 for 10M.
> > 
> > Hmm, I wonder what the PHY is doing for that then. stmmac will be
> > programmed to read the Cisco SGMII in-band control word, and use
> > that to determine whether symbol replication for slower speeds is
> > being used.
> > 
> > If AQR115C is indicating 10M in the in-band control word, but is
> > actually operating the link at 1G speed, things are not going to
> > work, and I would say the PHY is broken to be doing that. The point
> > of the SGMII in-band control word is to tell the MAC about the
> > required symbol replication on the link for transmitting the slower
> > data rates over the link.
> > 
> > stmmac unfortunately doesn't give access to the raw Cisco SGMII
> > in-band control word. However, reading register 0xf8 bits 31:16 for
> > dwmac4, or register 0xd8 bits 15:0 for dwmac1000 will give this
> > information. In that bitfield, bits 2:1 give the speed. 2 = 1G,
> > 1 = 100M, 0 = 10M.
> > 
> 
> This is dwmac4 and I got the following values with devmem at different
> link speeds:
> 1. 10M:		0x00080000  => Bit 2:1 = 0
> 2. 100M:	0x000A0000  => Bit 2:1 = 1
> 3. 1G: 		0x000D0000  => Bit 2:1 = 2

So this suggests it's sending the in-band configuration word, and it
indicates the negotiated speed. If the PHY really is using "rate
adaption" as in "making the packet look like 1G and using pause frames
to pace the transmitter" then that means symbol replication won't be
used by the PHY on the SGMII link. However, stmmac's PCS will be
using symbol replication, because the PHY is telling it to.

This suggests that having rate adaption enabled in the AQR115C PHY
and using SGMII with in-band is broken, and I can't think of any
PCS that would work with such a configuration.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

