Return-Path: <netdev+bounces-159371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF322A1542C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361573A2626
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A7F19D080;
	Fri, 17 Jan 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rOdCqqzE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5F166F29;
	Fri, 17 Jan 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131054; cv=none; b=ZFH1LKZR4gj+2YJVl99orkC7LbToiUizBmeILix2XGWmPQb/0oYu0G99tIgDbonQUGoYq+cC/supBflxenS4RpzwT4UARX2GwEpJ0SfIMLD/pCq4qX963e0i2+c4ZtBe3oMTGnZg4MEnDD86ytimFOPobbruFPo8mZIJc1FQmz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131054; c=relaxed/simple;
	bh=h9YsWAZk9qLOvZwPyCAqcJpmPWQBzv+eiudGczHYG9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIMXPlcPLYsnaGJVEIsgIiOAeEaZGtObrWjkt3+Z4cv1wdPNW1FQghaDEyQLUTt93Nc6E1XWttKa+rXufxBuSM07DnHxHyiFogXBjycqNm/Gknn5McVTGJgP9xvD17oiPtUIuAP40c2pQGoL9GAuP0uUnvuvQU7oYAUCMfNc3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rOdCqqzE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xicYrBaQw1cJ0ijyVJuoq5ECOHSUWcpDmtquBWpKU0g=; b=rOdCqqzEyg04Rz4lXrp/liRC/G
	l0Gmv328xHTfBvVLo7WVlGldMUQ3wIzCpAsP0Z7YAo7kOTW/XnyoUcbs0PFyhkxs+qTNjXLqJalQN
	Pa2pU7jGGuJBTLUmd4gp4T0P1kxzjbBJXt5NaFrdw3VLx7jkRFY9f7s0sd3FSy59d+3K8Vn144ulY
	3zfhQwCy3cTmLsRRyyQJZXnwcNrRXJA6UDBJMNN/LwozXkvcupLPAtfw5so8EFWerIB01WAG0UUlI
	8Z4kcgoSr0xbwyrXEecn+8z33I6w3tnLzWKLMHTeqLoYT48rB/thqDnZwprsSHLML2kr2I30czP29
	09iqVrXw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58606)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tYp8V-0003qt-2J;
	Fri, 17 Jan 2025 16:23:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tYp8S-0008P8-29;
	Fri, 17 Jan 2025 16:23:52 +0000
Date: Fri, 17 Jan 2025 16:23:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z4qEGIRYvSuVR9AK@shell.armlinux.org.uk>
References: <Z36KacKBd2WaOxfW@pengutronix.de>
 <Z36WqNGpWWkHTjUE@shell.armlinux.org.uk>
 <Z4ADpj0DlqBRUEK-@pengutronix.de>
 <Z4AG7zvIvQDv3GTn@shell.armlinux.org.uk>
 <Z4AJ4bxLePBbbR2u@pengutronix.de>
 <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
 <80925b27-5302-4253-ad6d-221ba8bf45f4@lunn.ch>
 <Z4UKHp0RopBT5gpI@pengutronix.de>
 <Z4UVQRHqk8ND984c@shell.armlinux.org.uk>
 <38ad9a25-a5b9-48ab-b92d-4c9d9f4c7d62@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38ad9a25-a5b9-48ab-b92d-4c9d9f4c7d62@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 13, 2025 at 02:45:14PM +0100, Andrew Lunn wrote:
> On Mon, Jan 13, 2025 at 01:29:37PM +0000, Russell King (Oracle) wrote:
> > On Mon, Jan 13, 2025 at 01:42:06PM +0100, Oleksij Rempel wrote:
> > > On Thu, Jan 09, 2025 at 08:33:07PM +0100, Andrew Lunn wrote:
> > > > > Andrew had a large patch set, which added the phylib core code, and
> > > > > fixed up many drivers. This was taken by someone else, and only
> > > > > Andrew's core phylib code was merged along with the code for their
> > > > > driver, thus breaking a heck of a lot of other drivers.
> > > > 
> > > > As Russell says, i did convert all existing drivers over the new
> > > > internal API, and removed some ugly parts of the old EEE core code.
> > > > I'm not too happy we only got part way with my patches. Having this in
> > > > between state makes the internal APIs much harder to deal with, and as
> > > > Russell says, we broke a few MAC drivers because the rest did not get
> > > > merged.
> > > > 
> > > > Before we think about extensions to the kAPI, we first need to finish
> > > > the refactor. Get all MAC drivers over to the newer internal API and
> > > > remove phy_init_eee() which really does need to die. My patches have
> > > > probably bit rotted a bit, but i doubt they are unusable. So i would
> > > > like to see them merged. I would however leave phylink drivers to
> > > > Russell. He went a slight different way than i did, and he should get
> > > > to decide how phylink should support this.
> > > 
> > > Hi Andrew,
> > > 
> > > Ok. If I see it correctly, all patches from the
> > > v6.4-rc6-net-next-ethtool-eee-v7 branch, which I was working on, have been
> > > merged by now. The missing parts are patches from the
> > > v6.3-rc3-net-next-ethtool-eee-v5 branch.
> > > 
> > > More precisely, the following non-phylink drivers still need to be addressed:
> > > drivers/net/ethernet/broadcom/asp2
> > > drivers/net/ethernet/broadcom/genet
> > > drivers/net/ethernet/samsung/sxgbe
> > > drivers/net/usb/lan78xx - this one is in progress
> > > 
> > > Unfortunately, I won’t be able to accomplish this before the merge window, as I
> > > am currently on sick leave. However, I promise to take care of it as soon as
> > > possible.
> > 
> > Does any of this include mvneta?
> 
> Hi Russell 
> 
> I asked Oleksij to skip MAC drivers using phylink. I'm not sure it
> makes sense to merge my phylink changes for EEE and then replace them
> with your EEE implementation.

Doing an audit on today's net-next after I've fixed up another driver
for the phylib-eee fallout, we have two obvious breakages remaining
in drivers that directly use phylib:

drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c:

        edata->tx_lpi_timer = priv->tx_lpi_timer;

        return phy_ethtool_get_eee(dev->phydev, edata);

drivers/net/ethernet/broadcom/genet/bcmgenet.c:

        e->tx_lpi_enabled = p->tx_lpi_enabled;
        e->tx_lpi_timer = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);

        return phy_ethtool_get_eee(dev->phydev, e);

Two others change ->tx_lpi_timer after calling phy_ethtool_get_eee()
and thus are unaffected:

drivers/net/ethernet/realtek/r8169_main.c:
drivers/net/usb/lan78xx.c

Howeve,r I wonder whether lan78xx_set_eee() is racy:

        ret = phy_ethtool_set_eee(net->phydev, edata);
        if (ret < 0)
                goto out;

        buf = (u32)edata->tx_lpi_timer;
        ret = lan78xx_write_reg(dev, EEE_TX_LPI_REQ_DLY, buf);

since phy_ethtool_set_eee() will have bounced the link if the timer
was changed.

I'm also wondering whether r8169 programs its LPI timer correctly.

I think all phylink using drivers network are now no longer affected.

I'm unsure about many DSA drivers. mt753x:

        u32 set, mask = LPI_THRESH_MASK | LPI_MODE_EN;

        if (e->tx_lpi_timer > 0xFFF)
                return -EINVAL;

        set = LPI_THRESH_SET(e->tx_lpi_timer);
        if (!e->tx_lpi_enabled)
                /* Force LPI Mode without a delay */
                set |= LPI_MODE_EN;
        mt7530_rmw(priv, MT753X_PMEEECR_P(port), mask, set);

Why force LPI *without* a delay if tx_lpi_enabled is false? This
seems to go against the documented API:

 * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
 *      that eee was negotiated.

qca8k_set_mac_eee() sets the LPI enabled based off eee->eee_enabled.
It doesn't seem to change the register on link up/down, so I wonder
how the autoneg resolution is handled. Maybe it isn't, so maybe it's
buggy.

b53_set_mac_eee() looks similar to qca8k_set_mac_eee().

So there's still work to be done.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

