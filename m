Return-Path: <netdev+bounces-161314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24AEA20AA9
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E85E16244A
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D757B1A0712;
	Tue, 28 Jan 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="R3btnQBE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5832F29;
	Tue, 28 Jan 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068054; cv=none; b=Gq5/LjIuuO17TTo3UZ1EwAskC+M14PS4GTeyWPUnu9mkgg5tO0BpJbKke6DeGzSpAU3YRlvQZpjoTuvYfTNlGWHh6BtnPDQ8RTZBvgwBT7Er00daly+PH7yWkIBEYiDP5eBg5k7gHQE0UzbewlSbe3dOnD4JICV7r3Zd3rV4gTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068054; c=relaxed/simple;
	bh=hXsF08SOAke4/SpKv0NFawp63NNokuaM7e4d5J7uwrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqTO4JRQqCpPqgy6ItkSTd+GjPUjfh/GLmVvSR+2xll1XQrFaeM+VYIZ5wVtseKJ5lKjfwJCCAyqb2ohtjYjoYbGRRTaEg/4abA3vkM2pVoWzBlf3lPAs/e6i58xwJgDQZulqC8GqkmktYgMx/4DrBkl17pyTw5lm680fwQhY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=R3btnQBE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kSP7vG6EMUCVzvP8h7o4x5YphzxGUgC67JnqHWivrOc=; b=R3btnQBE1usH8bzHGZcmrRG99y
	JM9NtwY/ABE6u+9L87uf/cwUlUlljxV+NGXdN9Agwp0b/H5kpCS0ASgSt/nfPYNRSkrzwlsuGtbMC
	OSRfRHB4O0hRVi/Ltsxuro3hsrhDI+q/WYy2aiNTtjqzlc1I77SaGROT3n6Fhe+MNr5c6VvgBzgFa
	XS1UiH/EMmiUY648gVyEfbRJ4xiGLdkeZT5uo0Gu4yhUg/z7pALjGpCNmq0zE8XeOd15Z0WpUF/uB
	0T7ChSdnPsa/MKelXcaOLMpBGy93d7ZqbAQjXMp2m8HU91EiyBA2XM4YzGyOk/AUO8aqge+qFf8LB
	Otbr08EQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50586)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tcktY-00078g-2v;
	Tue, 28 Jan 2025 12:40:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tcktX-0002eP-1F;
	Tue, 28 Jan 2025 12:40:43 +0000
Date: Tue, 28 Jan 2025 12:40:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <Z5jQS-atzbR1O-9q@shell.armlinux.org.uk>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128102128.z3pwym6kdgz4yjw4@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 28, 2025 at 12:21:28PM +0200, Vladimir Oltean wrote:
> On Tue, Jan 28, 2025 at 09:24:45AM +0000, Russell King (Oracle) wrote:
> > On Mon, Jan 27, 2025 at 07:32:25PM -0800, Tristram.Ha@microchip.com wrote:
> > > For 1000BaseX mode setting neg_mode to false works, but that does not
> > > work for SGMII mode.  Setting 0x18 value in register 0x1f8001 allows
> > > 1000BaseX mode to work with auto-negotiation enabled.
> > 
> > I'm not sure (a) exactly what the above paragraph is trying to tell me,
> > and (b) why setting the AN control register to 0x18, which should only
> > affect SGMII, has an effect on 1000BASE-X.
> > 
> > Note that a config word formatted for SGMII can result in a link with
> > 1000BASE-X to come up, but it is not correct. So, I highly recommend you
> > check the config word sent by the XPCS to the other end of the link.
> > Bit 0 of that will tell you whether it is SGMII-formatted or 802.3z
> > formatted.
> 
> I, too, am concerned about the sentence "setting neg_mode to false works".
> If this is talking about the only neg_mode field that is a boolean, aka
> struct phylink_pcs :: neg_mode, then setting it to false is not
> something driver customizable, it should be true for API compliance,
> and all that remains false in current kernel trees will eventually get
> converted to true, AFAIU. If 1000BaseX works by setting xpcs->pcs.neg_mode
> to false and not modifying anything else, it should be purely a
> coincidence that it "works", since that makes the driver comparisons
> with PHYLINK_PCS_NEG_* constants meaningless.

Another related issue that concerns me is:

         * Note: Since it is MAC side SGMII, there is no need to set
         *       SR_MII_AN_ADV. MAC side SGMII receives AN Tx Config from
         *       PHY about the link state change after C28 AN is completed
         *       between PHY and Link Partner. There is also no need to
         *       trigger AN restart for MAC-side SGMII.

However, 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII
mode") added support for switching this to PHY-side SGMII, so this
comment is no longer true.

Again, I still wonder whether PHY-side is some kind of hack despite
my queries during the review of that change. Sadly, I didn't catch
that comment (and until recently, I didn't have any documentation
on these registers. I now have the KS9477 and SJA1105 manuals that
document some of the register set.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

