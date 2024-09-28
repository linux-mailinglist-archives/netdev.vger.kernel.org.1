Return-Path: <netdev+bounces-130183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63478988EDB
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 11:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55392823BD
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B7F19DF8D;
	Sat, 28 Sep 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ci5fCWpE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAADE14F119;
	Sat, 28 Sep 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727516895; cv=none; b=iXWmCUinDVY3x0n7JjKvNedAl/IW4UBbvZdsirx3/trzTgJNXDClvpd9G/SaLpjFYpujpwQJ99Rh6lgVW6F7CBBAerhKG8ekcB/CpdD8aOSqcrs9vPyxIigZWn+1kysnPvG+x+sgJ7YVudVk2lMRG9MMnhyULZfGvTWeuKXmHUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727516895; c=relaxed/simple;
	bh=DF+fwg6bdVvkftDxUYL3VWZd1OSxAyFKBk0jUIfYBxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoWNMgZlRZ8inZtSRugDDTphOSItCmTgcsnxVxyOrQ+VEYiTptDreIcCZsrhLrcPu+Cm09Bg8z3080Xda131NM9OLRjIkd9ls+p0znb78svRQliBKrcTOcNbVPn9wtIKIgrG3qu4t3VdFIDz7+Q8oKx9DDGkLg9L26u7RSCkSHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ci5fCWpE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=izBdRtlBZqbINlKG+ox2SV5wtLyK5BMZ/5jXPwblvR0=; b=ci5fCWpEyqbmae51/CaR+EwVF9
	dScY5Onuh6wFBzYyuUtughRzOiUI4DLtxY3Avs5WrgHxdE0n4bqRc5bMskhZNdBmhRpqCOgujij5c
	2hIAGnsoGWwiwql14uQSDsxw18s1Ku3FkoDtTrj1ytrCNtjQsetVQsudxlTmdHzOrpBqQK+X+jydV
	sNbUow+WS3ZZLpZpZooMDhuUFORzQylj9uy4T2zm36ZPGZcrdpd9079ln1FGoQH5qkZoXQNel6+B4
	mXFkzV00rrs22msO4XHw2I8GUUgLzHP4WfNBVNuWUjr11ahJ/lCcsvOo/qca7MmNYjkYmcn8yL5Fy
	VPMls42A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49856)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1suU3O-000217-0P;
	Sat, 28 Sep 2024 10:47:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1suU3H-0001jp-25;
	Sat, 28 Sep 2024 10:47:47 +0100
Date: Sat, 28 Sep 2024 10:47:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Halaney <ahalaney@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, kernel@quicinc.com
Subject: Re: [PATCH net v4 2/2] net: phy: aquantia: remove usage of
 phy_set_max_speed
Message-ID: <ZvfQw0adwC/Ldngk@shell.armlinux.org.uk>
References: <20240927010553.3557571-1-quic_abchauha@quicinc.com>
 <20240927010553.3557571-3-quic_abchauha@quicinc.com>
 <20240927183756.16d3c6a3@fedora.home>
 <048bbc09-b7e1-4f49-8eff-a2c6cec28d05@quicinc.com>
 <20240928105242.5fe7f0e1@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928105242.5fe7f0e1@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Sep 28, 2024 at 10:52:42AM +0200, Maxime Chevallier wrote:
> On Fri, 27 Sep 2024 12:42:36 -0700
> "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com> wrote:
> 
> > On 9/27/2024 9:37 AM, Maxime Chevallier wrote:
> > > Hi,
> > > 
> > > On Thu, 26 Sep 2024 18:05:53 -0700
> > > Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:
> > >   
> > >> Remove the use of phy_set_max_speed in phy driver as the
> > >> function is mainly used in MAC driver to set the max
> > >> speed.
> > >>
> > >> Instead use get_features to fix up Phy PMA capabilities for
> > >> AQR111, AQR111B0, AQR114C and AQCS109
> > >>
> > >> Fixes: 038ba1dc4e54 ("net: phy: aquantia: add AQR111 and AQR111B0 PHY ID")
> > >> Fixes: 0974f1f03b07 ("net: phy: aquantia: remove false 5G and 10G speed ability for AQCS109")
> > >> Fixes: c278ec644377 ("net: phy: aquantia: add support for AQR114C PHY ID")
> > >> Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
> > >> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>  
> > > 
> > > [...]
> > >   
> > >> +static int aqr111_get_features(struct phy_device *phydev)
> > >> +{
> > >> +	unsigned long *supported = phydev->supported;
> > >> +	int ret;
> > >> +
> > >> +	/* Normal feature discovery */
> > >> +	ret = genphy_c45_pma_read_abilities(phydev);
> > >> +	if (ret)
> > >> +		return ret;
> > >> +
> > >> +	/* PHY FIXUP */
> > >> +	/* Although the PHY sets bit 12.18.19, it does not support 10G modes */
> > >> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported);
> > >> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, supported);
> > >> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, supported);
> > >> +
> > >> +	/* Phy supports Speeds up to 5G with Autoneg though the phy PMA says otherwise */
> > >> +	linkmode_or(supported, supported, phy_gbit_features);
> > >> +	/* Set the 5G speed if it wasn't set as part of the PMA feature discovery */
> > >> +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
> > >> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);  
> > > 
> > > As you are moving away from phy_set_max_speed(phydev, 5000), it should mean
> > > that what used to be in the supported bits already contained the
> > > 5GBaseT bit, as phy_set_max_speed simply clears the highest speeds.
> > > 
> > > In such case, calling the newly introduced function from
> > > patch 1 should be enough ?
> > >   
> > 
> > Well i am not sure about how other phy(AQR111, AQR111B0, AQR114C and AQCS109) behaved, 
> > but based on my testing and observation with AQR115c, it was pretty clear that 
> > the phy did not advertise Autoneg capabilities, did not set lower speed such as 10M/100M/1000BaseT
> > ,it did set capabilities beyond what is recommended in the data book.
> > 
> > So the below mentioned phys such as 
> > 
> > AQR111, AQR111B0, AQR114C = supports speed up to 5Gbps which means i cannot use the function
> > defined in the previous patch as that sets speeds up to 2.5Gbps and all lower speeds. 
> > 
> > AQCS109 = supports speed up to 2.5Gbps and hence i have reused the same function aqr115c_get_features
> > as part of this patch.
> 
> I understand your point, and it's hard indeed to be sure that no
> regression was introduced. It does feel like you're reading the PHY
> features, then reconstructing them almost from scratch again, but given
> that the PMA report looks totally incorrect, there not much choice
> indeed. So that's fine for me then.

I think this is getting overly complex, so let's rewind a bit.

I believe Abhishek mentioned in a previous review what the differences
are between what the PHY reports when read, and what it actually
supports, and the result was that there was not a single bit in the
supported mask that was correct. I was hopeful that maybe Andrew would
respond to that, but seems not to, so I'm putting this statement here.
More on this below.

Therefore, I believe that using genphy_c45_pma_read_abilities() here
is a mistake.

Now, looking at these two patches, patch 1 clears:
	ETHTOOL_LINK_MODE_10000baseT_Full_BIT
	ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT
	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT
	ETHTOOL_LINK_MODE_5000baseT_Full_BIT

and sets:
	phy_gbit_features
	ETHTOOL_LINK_MODE_2500baseT_Full_BIT

Patch 2 clears:
	ETHTOOL_LINK_MODE_10000baseT_Full_BIT
	ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT
	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT

and sets:
	phy_gbit_features
	ETHTOOL_LINK_MODE_5000baseT_Full_BIT
	ETHTOOL_LINK_MODE_2500baseT_Full_BIT

So, the only difference between the code in patch 1 and patch 2 is
whether ETHTOOL_LINK_MODE_5000baseT_Full_BIT is set. Everything else
is the same.

So, the function in patch 2 can call the function in patch 1, and then
do:

	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
			 phydev->supported);

However, I go back to my original point. Is it worth all this
complexity clearing and setting these bits, when what is read from
the PHY is so wrong? This is what was said in previous emails:

| //Print added by me in the AQR driver
| [    5.583440]  AQR supported mask=00,00000000,00018000,000e102c
| 
| key points :-
| 
| AQR115c supports 10Mbps(F/H) but feature discovery says no
| AQR115C supports 1Gbps(F/H) but feature discovery says no
| AQR115C supports 2500BaseX but feature discovery says no
| AQR115C supports Autoneg but feature discovery says Hell no!
| AQR115C does not support 10GBaseT/KX4/KR but feature discovery says yes
| AQR115c does not support 5GbaseT but feature discovery says yes

Providing a fuller picture:
- bit 0,1 not set (10baseT_{Half,Full}) - but should be set.
- bit 2,3 are set (100baseT_{Half,Full}) - correct!
- bit 4 not set (1000baseT_Half) - but should be set.
- bit 5 is set (1000baseT_Full) - correct!
- bit 6 not set (Autoneg) - but should be set.
- bit 12 is set (10000baseT_Full) - no idea!
- bits 17-19 set (1000baseKX_Full, 10000baseKX4_Full, 10000baseKR_Full) -
     but should be clear.
- bit 47 is set (2500baseT_Full) - correct!
- bit 48 is set (5000baseT_Full) - but should be clear.

Sorting this by status (correct, should be clear, should be set):

Should be clear:
- bits 17-19 set (1000baseKX_Full, 10000baseKX4_Full, 10000baseKR_Full)
- bit 48 is set (5000baseT_Full)

Should be set:
- bit 0,1 not set (10baseT_{Half,Full})
- bit 4 not set (1000baseT_Half)
- bit 6 not set (Autoneg)

Correct:
- bit 2,3 are set (100baseT_{Half,Full})
- bit 5 is set (1000baseT_Full)
- bit 47 is set (2500baseT_Full)

Unknown:
- bit 12 is set (10000baseT_Full)

So that's four bits to be cleared, four bits to be set, four bits are
correct, and one we don't know. Is it really worth reading the PHY
abilities, or would just having a list of the ethtool link modes that
the PHY actually supports be a saner, more maintainable solution as
originally proposed?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

