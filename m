Return-Path: <netdev+bounces-40763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DF27C89BA
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DF6282FD0
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AF51CA96;
	Fri, 13 Oct 2023 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lmqzb1Kt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A31DA24
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 16:05:10 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4FD131;
	Fri, 13 Oct 2023 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1uy1ubiiOooNl65dCWB8d4jB7800b7OY5hu8FrKv6yw=; b=lmqzb1KtZuAqcEjljXYctkoYpG
	CTX8xgzWEiariAEajSWsdcoVg8pEp+lGzq6o6K7CRxWASmE62WyXn/c9Z/StUEQqUyIp/+W9/UcQl
	DFl73yQe0S6BFTtAY+ztQgX04Z5+vNA12ZPs2wy5IvSYxfOWxApNX4KevmijRWv33SY0pZkd7AzAg
	jWp1DUyTtUCooQcVsrsP0JeAnAgoyJEvdPS0sTN8/FFGaGThc48s8jgxO2053ZnDpifSP9FYBeD0D
	t/DhM2UjlcfgdZgePfIjlbz/sOucg2YG+Jz7IOWy1ATvXxe0y1MyfcFJ+1+3zQFH6gFNheAlyHx8F
	rUs+hxcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51436)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qrKef-0006Wq-1t;
	Fri, 13 Oct 2023 17:04:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qrKef-0002Uo-8Y; Fri, 13 Oct 2023 17:04:49 +0100
Date: Fri, 13 Oct 2023 17:04:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 3/3] net: phy: micrel: Fix forced link mode
 for KSZ886X switches
Message-ID: <ZSlqoR8PGPQQw/aA@shell.armlinux.org.uk>
References: <20231011123856.1443308-1-o.rempel@pengutronix.de>
 <20231011123856.1443308-3-o.rempel@pengutronix.de>
 <3767760.kQq0lBPeGt@steina-w>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3767760.kQq0lBPeGt@steina-w>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 03:29:49PM +0200, Alexander Stein wrote:
> Hi Oleksij,
> 
> Am Mittwoch, 11. Oktober 2023, 14:38:56 CEST schrieb Oleksij Rempel:
> > +	if (phydev->autoneg != AUTONEG_ENABLE) {
> > +		ret = genphy_setup_forced(phydev);
> > +		if (ret)
> > +			return ret;
> > +
...
> > +		ret = phy_set_bits(phydev, MII_KSZPHY_CTRL,
> > +				   KSZ886X_CTRL_FORCE_LINK);
> > +		if (ret)
> > +			return ret;
> > +	} else {
...
> > +		ret = phy_clear_bits(phydev, MII_KSZPHY_CTRL,
> > +				     KSZ886X_CTRL_FORCE_LINK);
> > +		if (ret)
> > +			return ret;
> 
> Isn't this call to phy_clear_bits() a fix for autonegotiation mode? This 
> should be a separate patch then.

No, I don't think that is the case. Compare the two paths above, noting
that patch 1 introduces the definition for KSZ886X_CTRL_FORCE_LINK.

If autoneg is disabled, then this bit is then set, which forces the
link. Clearly, if autoneg is then re-enabled, this bit has to be
cleared to allow the effects of the autoneg-disabled path to be undone.

So both of these, the phy_set_bits() and the phy_clear_bits() belong in
the same patch. Splitting them up, so we introduce phy_set_bits() first
will create a regression - which we don't want.

These two belong logically together.

What does concern me, however, is that the autoneg-disabled path avoids
calling genphy_setup_master_slave(), and since establishing which end
of the link is part of the fundamentals of a 1000base-T link, I wonder
whether both paths should still call genphy_config_aneg().

Apart from that, I think the patch is otherwise fine.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

