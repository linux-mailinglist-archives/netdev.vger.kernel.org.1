Return-Path: <netdev+bounces-161760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43EA23B8D
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 10:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0DC7A2C8C
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E28187554;
	Fri, 31 Jan 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T9qqmdYm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5828EC;
	Fri, 31 Jan 2025 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738316608; cv=none; b=IUUyI9PiKVLR7gIxf1ONveyAp3/ir0nn6NcTNWdiCjKeqtyevYegRaB6EN5wBpdqyM4eDD8BoUlDjIhnlTo1VMaoFyJNimldsXwIXS1zZDDJ/pYeHLqctp07DqDaZPVpg/Yc1+Dqp/n9qZNzR8ABdSSVvgv/miqHUL2wJvEaqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738316608; c=relaxed/simple;
	bh=9sSfE4Da7iTgPTe+GemO1QZpxkhlfruvpvY4WqD1gls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUfuWyhSU4s9XfhhfS+PchaXPqgTuDWrvnDzMDgU55mciAWySks78maOxzrdXZVvLxiXJrE7uYRggkkePzojSMjagx3ZGCed42FyaNF+QfjMw6z2mg2GVgQUzs0udByHDTQdK3ETb58wbFvFLNAxu9ck2Eg88wudZP/SyicAXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=T9qqmdYm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=damiScJwwAAqpStEXMs7R9lz10u6wGnSYVG7PJwwDIU=; b=T9qqmdYm1tXaK12u1V4YwuiApo
	E5KinTANgFGGBR+VswILFeZqRNiNhKnK7C/a24CsmVGuta/wbhP1SxSlq0MxX3ZQNQZxzE5te38AR
	o8mUFrT8fM+z6c3x6lqclRjERFOEijpWsCQ/pW0vaKx4Tze4npnAAe2hZahIt+hU1RTOCfXCq40xI
	8+4VPrOXdsn7TnXzsLmfXQAbHR6FE7tzPM6WZQdxK4J2O6hgAnI4I7w+PlmgmqSD6NHrjwNlu7u0K
	3nsTE9l9hTA1D0325FcEjHHpOdnVgAAWHqf4/QbVESJT/764g98RsnQEiMWydkHEXmGV9ajKTvyD6
	vzn0xGgA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49490)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tdnYI-0006dd-0F;
	Fri, 31 Jan 2025 09:43:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tdnYE-0005hG-0t;
	Fri, 31 Jan 2025 09:43:02 +0000
Date: Fri, 31 Jan 2025 09:43:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: olteanv@gmail.com, Woojung.Huh@microchip.com, andrew@lunn.ch,
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <Z5ybJtpOWNyWuF5h@shell.armlinux.org.uk>
References: <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <DM3PR11MB87365B3AD3C360B0EF0432F3ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
 <Z5tNcNINk1CMDBeo@shell.armlinux.org.uk>
 <DM3PR11MB8736B524E983153188A531ADECE82@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB8736B524E983153188A531ADECE82@DM3PR11MB8736.namprd11.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 31, 2025 at 02:24:23AM +0000, Tristram.Ha@microchip.com wrote:
> > So the value of 0x2200 for DIG_CTRL1 means that bits 13 and 9 are both
> > set, which are the EN_VSMMD1 and MAC_AUTO_SW bits. So, are you saying
> > that MAC_AUTO_SW can't be cleared in KSZ9477? This is key information
> > that we need.
> > 
> > PHY_MODE_CTRL only has an effect when:
> >         DW_VR_MII_PCS_MODE_C37_SGMII
> >         DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII
> > are both set.
> > 
> > are set, and it determines the source for the bits in the configuration
> > word to be sent to the _MAC_ (since XPCS is acting as a PHY with both
> > these bits set.)
> 
> Sorry, my mistake.  The default value is 0x2400.  XPCS driver tries to
> write 0x2600 and the value stays at 0x2400.

Okay, we can use that if necessary to probe the hardware to see whether
it supports the MAC_AUTO_SW feature, and if it doesn't, it gives us a
clue that it is older IP.

> > If you have a SFP plugged in, then setting PHY-side on the XPCS is
> > wrong. TX_CONFIG_MAC_SIDE_SGMII should be used, and thus PHY_MODE_CTRL
> > is irrelevant as we are not generating a PHY-side Cisco SGMII config
> > word (as I detailed when I described the Cisco SGMII config words which
> > are asymmetric in nature.)

(relevant to the final part of my reply, so leaving this quoted here)

> > That's because if the XPCS acts as a PHY and is talking to another PHY,
> > the only then that the remote PHY (in the SFP module) is looking for is
> > an acknowledgement (bit 14 set.) It's possible that XPCS does this
> > despite operating as a PHY. However, there is another (remote)
> > possibility.

(relevant to the final part of my reply, so leaving this quoted here)

> > ... because the XPCS is operating in the wrong mode, and when operating
> > as a PHY does not expect the other end "the MAC" to be signalling link
> > status to it. One end of a Cisco SGMII link must operate as a PHY and
> > the other end must operate as a MAC to be correct. Other configurations
> > may sort-of work but are incorrect to the Cisco SGMII documentation.

(relevant to the final part of my reply, so leaving this quoted here)

> > Sigh. So you are referring to struct phylink_pcs's boolean neg_mode
> > member here, and fiddling with that is _wrong_. This flag is a
> > property of the driver code. It's "this driver code wants to see the
> > PHYLINK_PCS_NEG_* constants passed into its functions" when set,
> > as opposed to the MLO_AN_* constants that legacy drivers had. This
> > flag _must_ match the driver. It is _not_ to be fiddled with depending
> > on IP versions or other crap like that. It's purely about the code in
> > the driver. Do not touch this boolean. Do not change it in the XPCS
> > driver. It is correct. Setting it to false is incorrect. Am I clear?
> 
> I noticed when neg_mode == NEG_INBAND_ENABLED then auto-negotiation is
> not enabled.  And in the link_up function the code is skipped when this
> is the case.  I wanted to manipulate neg_mode so that it does not equal
> to NEG_INBAND_ENABLED and found it can be done by setting pcs->neg_mode
> to false.  I know the phylink code changes neg_mode to different values
> when pcs->neg_mode is true.  So if pcs->neg_mode is always set to true
> then is there a situation when neg_node is not equal to
> NEG_INBAND_ENABLED?

Yes, several.

- If you're using a fibre SFP and use ethtool to disable autoneg.
- If "inband" mode is not being used (rare with SFPs)
- If the PHY doesn't support inband.

> After executing this code it was the first time I realized that
> 1000BASEX mode works with auto-negotiation disabled.

... which probably happens because the PHY enters "bypass" mode
having given up waiting for the XPCS to send the config word.

> > Right, and its as documented in the KSZ9477 documentation. 1000base-X
> > mode requires TX_CONFIG_PHY_SIDE_SGMII and SGMII_LINK_STS. Likely
> > because of the older IP version.
> > 
> > Let me get back to what I said in my previous email - but word it
> > differently:
> > 
> >    Can we think that setting both TX_CONFIG_PHY_SIDE_SGMII and
> >    SGMII_LINK_STS unconditionally in the 1000base-X path with will
> >    not have any deterimental effects on newer IP versions?
> 
> Using this SGMII_LINK_STS | TX_CONFIG_PHY_SIDE_SGMII combination does not
> have any side effect on the new IP even though it is no longer required
> for 1000BASEX mode.

Let's hope that is the case.



> Note SGMII_LINK_STS | TX_CONFIG_PHY_SIDE_SGMII | C37_SGMII setting even
> works for SGMII mode.  It seems this combination SGMII_LINK_STS |
> TX_CONFIG_PHY_SIDE_SGMII reverts the effect of setting
> TX_CONFIG_PHY_SIDE_SGMII so the SGMII module still acts as a MAC.

No it won't. I've described what happens when you operate both sides
in PHY mode. I've given you the bit layout of the configuration words
that are sent in both directions. I've described how XPCS uses
SGMII_LINK_STS to populate the configuration word it sends in PHY
mode.

Not only will setting PHY mode change the configuration word that is
transmitted, it will change the interpretation of the received
configuration word.

It's broken to configure both ends of the Cisco SGMII link to be
acting as "master" or "PHY" mode. Don't do it.

I've already covered this in my previous reply (see the bits above
that I quoted and stated that they were relevant to this part of the
reply).

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

