Return-Path: <netdev+bounces-133150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E6B9951B3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1B31C25618
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B5D1DFDB7;
	Tue,  8 Oct 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="d5Mfbreg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594CF1DF97C;
	Tue,  8 Oct 2024 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397659; cv=none; b=SK5vuoyg029W3v/03SgRmjxhFUAck2D4Zbi8zVTi8PNNOy8Lh0zXUSI/EaN7IIONfxJy48xJRFfEXx5S2ODiJ16VJd/Y58d1edY9iQee/4krVuLm3DUzrtSeUXU829pkBCTtzzYIWNancpo5GK4FnJmutG5adJgZxEvjE2JLzX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397659; c=relaxed/simple;
	bh=cqF1IIkxJrWVAPrYmX/qgSgwLz6GPiFD607tDN6UK9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsiIG+01OPoiVYu/DusRmzaesB8/1PC1oxIea8IAF+ABBItNEvwsuT4xcpE39cCvzG8erG4rgFQcoL3QqEeGAGzO/MVEPz+lQzdymu0P0pzi+VSpM8zqZBNPZTLFTLJRZGU2sgNZdSYntAoMsz0q6jK8Gb19sHv51sGZsLYM7ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=d5Mfbreg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a+DkmiR6iBjQTpDltHH1Nmd5nsx6wlgZv69FbKbaRbM=; b=d5MfbregxMAtRARB3jZ6BQgusn
	johk4FaL3qHonV14S90IKc0bNPwO40xd0c7mEyOe3oLPuyJZz+EQkI+9cSuHgiva0c5s85T6f6Tnn
	hRPqemOze8k1kwmDgwNTxdQalrff+O4WPXR0ZD1vt20eCm6ld06KeqTvKfS62duZmNwdeKNFbwVZX
	J1zajTQqDPcfKGyRMve5v+/fSzQsj6ChQVgz4wLhnIwmiTD+n0bsL6SzJGCTi1Sb13PgtYO08BCEd
	whNlaB6two9xhcOqj8UojT/38nzjyYVHeAyu40pbzjQYnjy0RtQjp7k6qgYl0U6zY7A/KCQufnfd6
	vQhq1vag==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46250)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syBBO-0007bI-0Z;
	Tue, 08 Oct 2024 15:27:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1syBBK-0005GB-02;
	Tue, 08 Oct 2024 15:27:22 +0100
Date: Tue, 8 Oct 2024 15:27:21 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: check validity of 10GbE
 link-partner advertisement
Message-ID: <ZwVBSaS7UGCwbqDs@shell.armlinux.org.uk>
References: <fb736ae9a0af7616c20c36264aaec8702abc84ae.1728056939.git.daniel@makrotopia.org>
 <8fb5c25d-8ef5-4126-b709-0cfe2d722330@lunn.ch>
 <ZwBmycWDB6ui4Y7j@makrotopia.org>
 <ZwUTDw0oqJ1dvzPq@shell.armlinux.org.uk>
 <ZwUelSBiPSP_JDSy@makrotopia.org>
 <ZwUpT9HRdl33gv_G@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwUpT9HRdl33gv_G@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 08, 2024 at 01:45:03PM +0100, Russell King (Oracle) wrote:
> Let's start checking what we're doing with regards to this register.
> 
> 7.33.11 (Link Partner 10GBASE-T capability) states that this is only
> valid when the Page received bit (7.1.6) has been set. This is the
> BMSR_ANEGCOMPLETE / MDIO_AN_STAT1_COMPLETE bit.
> 
> Looking at rtl822x_read_status, which is called directly as a
> .read_status() method, it reads some register that might be the
> equivalent of MMD 7 Register 33 (if that's what 0xa5d, 0x13 is,
> 0xa5d, 0x12 seems to be MDIO_AN_10GBT_CTRL) whether or not the link
> is up and whether or not AN has completed. It's only conditional on
> Autoneg being enabled.
> 
> However, we don't look at 7.1.6, which is wrong according to 802.3.
> So I think the first thing that's needed here is that needs fixing
> - we should only be reading the LP ability registers when (a) we
> have link, and (b) when the PHY indicates that config pages have
> been received.
> 
> The next thing that needs fixing is to add support for checking
> these LOCOK/REMOK bits - and if these are specific to the result of
> the negotiation (there's some hints in 802.3 that's the case, as
> there are other registers with similar bits in, but I haven't
> looked deeply at it) then, since the resolution is done in core
> PHY code, I think we need another method into drivers to check
> these bits once resolution has occurred.

Okay, I think the problem is down to the order in which Realtek is
doing stuff.

genphy_read_status() calls genphy_update_link(), which updates
phydev->link and phydev->autoneg_complete from the BMSR, and then
goes on to call genphy_read_lpa().

Looking at genphy_read_lpa():

        if (phydev->autoneg == AUTONEG_ENABLE) {
                if (!phydev->autoneg_complete) {
                        mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
                                                        0);
                        mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
                        return 0;
                }

So, if BMSR_ANEGCOMPLETE is not set, then we zero the 1G FD/HD,
Autoneg, Pause, Asym Pause and 100/10M FD/HD fields in the LPA leaving
everything else alone - and then do nothing further. In other words,
we don't read the LPA registers and update these bits.

Looking at genphy_c45_read_lpa():

        if (!(val & MDIO_AN_STAT1_COMPLETE)) {
                linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
                                   phydev->lp_advertising);
                mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
                mii_adv_mod_linkmode_adv_t(phydev->lp_advertising, 0);
                phydev->pause = 0;
                phydev->asym_pause = 0;

                return 0;

So that's basically the same thing - if the MDIO_AN_STAT1_COMPLETE
is clear, then we clear the 10G stuff. I think that
mii_adv_mod_linkmode_adv_t() is wrong here, it should be
mii_lpa_mod_linkmode_lpa_t().

However, the principle here is that if !autoneg_complete, then the
modes that would've been set by the respective function need to be
cleared.

Now, rtl822x_read_status() reads the 10G status, modifying
phydev->lp_advertising before then going on to call
rtlgen_read_status(), which then calls genphy_read_status(), which
in turn will then call genphy_read_lpa().

First, this is the wrong way around. Realtek needs to call
genphy_read_status() so that phydev->link and phydev->autoneg_complete
are both updated to the current status.

Then, it needs to check whether AN is enabled, and whether autoneg
has completed and deal with both situations.

Afterwards, it then *possibly* needs to read its speed register and
decode that to phydev->speed, but I don't see the point of that when
it's (a) not able to also decode the duplex from that register, and
(b) when we've already resolved it ourselves from the link mode.
What I'd be worried about is if the PHY does a down-shift to a
different speed _and_ duplex from what was resolved - and thus
whether we should even be enabling downshift on this PHY. Maybe
there's a bit in 0xa43 0x12 that gives us the duplex as well?

In other words:

static int rtl822x_read_status(struct phy_device *phydev)
{
	int lpadv, ret;

	ret = rtlgen_read_status(phydev);
	if (ret < 0)
		return ret;

	if (phydev->autoneg == AUTONEG_DISABLE)
		return 0;

	if (!phydev->autoneg_complete) {
		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
		return 0;
	}

	lpadv = phy_read_paged(phydev, 0xa5d, 0x13);
	if (lpadv < 0)
		return lpadv;

	mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, lpadv);
	phy_resolve_aneg_linkmode(phydev);

	return 0;
}

That should at least get proper behaviour in the link partner
advertising bitmap rather than the weirdness that Realtek is doing.
(BTW, other drivers should be audited for the same bug!)

Now, if we still have the stale 2500M problem, then I'd suggest:

	if (phydev->speed >= 2500 && !(lpadv & MDIO_AN_10GBT_STAT_LOCOK)) {
		/* Possible stale advertisement causing incorrect
		 * resolution.
		 */
		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
		phy_resolve_aneg_linkmode(phydev);
	}

here.

However, if we keep the rtlgen_decode_speed() stuff, and can fix the
duplex issue, then the phy_resolve_aneg_linkmode() calls should not
be necessary, and it should be moved _after_ this to ensure that
phydev->speed (and phydev->duplex) are correctly set.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

