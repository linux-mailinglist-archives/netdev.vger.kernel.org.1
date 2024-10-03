Return-Path: <netdev+bounces-131527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1117D98EC2B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A393EB219D8
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F97145B00;
	Thu,  3 Oct 2024 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UZQpXq74"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5A79CC;
	Thu,  3 Oct 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947198; cv=none; b=VfdToGSWdFxhqTdjVXMLkJud5rbXLW07A9ostxQbH9rmVWwNGcdcEwu8ZtFaNCiZtJFRAlcOlQn2fK8t0/3BFTllQI2mJY00EaZMXd8DPWp4CRc1NXxsESls1/qNbyiIB5Sc5PKonkPE5T77To9Vcv43tDvydSmTLduOwDmCJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947198; c=relaxed/simple;
	bh=t36BZoOl4a7pMSq4Jvqbz0FMUL7mdUU/GR0iV2D3dxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooGT7pzIc108lb1P6jDPRee5DkcJqLQScjQMQiX37kGKSAd/V3X+2iFFVNnISPbsR6ecViwXQDk2dgWrNgbnJ2oiHyLQJo7OQbe1fW5+dxg9UYVI34pS9X1xKtnUD4NhTQjw00w5VyGC4nrHRrUFRcRKRRJlc7aLbaGjZBYquXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UZQpXq74; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MFRkkMNPtECZS6YeBMAiHTWEQNKEFLpXSnm/6ynMfAk=; b=UZQpXq747I+/BZVSrO7byZyMEs
	E9qfSpyX40mwWXaUI3YpA9AZXoPr34+1HY98Y1shDR65lZFxC8pHqD+mW8E2XKBgU+b/P9o6nROxo
	YbRNYT099pZ/nujHxkSNAN/PhFjL52oCqmBx/kZLZU+9RpVeETRONLTU9GJtS9yODNeLJ6ZYMRdWR
	g3F3Prh0uPlue99ZglEpwbXH1sxxQORXdFysZzdCCFfVaEtEq8xaN2npendhxdd3M8+jkXGxKe78T
	oJiDG5B4TCLiUqINogqZW3c0pWjmfAQfciT7a2nE932vclTSGx9nyP6HVX+ylehZKhdWuoe+m8M58
	2IduPASQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56104)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swHzt-0000Gb-22;
	Thu, 03 Oct 2024 10:19:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swHzq-0008QY-2k;
	Thu, 03 Oct 2024 10:19:42 +0100
Date: Thu, 3 Oct 2024 10:19:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Qingtao Cao <qingtao.cao.au@gmail.com>
Cc: Qingtao Cao <qingtao.cao@digi.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/1] net: phy: marvell: avoid bringing down
 fibre link when autoneg is bypassed
Message-ID: <Zv5hrvOspTcYuQYs@shell.armlinux.org.uk>
References: <20241003071050.376502-1-qingtao.cao@digi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003071050.376502-1-qingtao.cao@digi.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 03, 2024 at 05:10:50PM +1000, Qingtao Cao wrote:
> On 88E151x the SGMII autoneg bypass mode defaults to be enabled. When it is
> activated, the device assumes a link-up status with existing configuration
> in BMCR, avoid bringing down the fibre link in this case
> 
> Test case:
> 1. Two 88E151x connected with SFP, both enable autoneg, link is up with
>    speed 1000M
> 2. Disable autoneg on one device and explicitly set its speed to 1000M
> 3. The fibre link can still up with this change, otherwise not.

As you're clearly using fibre, there's this chunk of code in the same
function that is (IMHO) wrong:

                if (phydev->duplex == DUPLEX_FULL) {
                        if (!(lpa & LPA_PAUSE_FIBER)) {
                                phydev->pause = 0;
                                phydev->asym_pause = 0;
                        } else if ((lpa & LPA_PAUSE_ASYM_FIBER)) {
                                phydev->pause = 1;
                                phydev->asym_pause = 1;
                        } else {
                                phydev->pause = 1;
                                phydev->asym_pause = 0;
                        }
                }

as ->pause and ->asym_pause are supposed to be the _resolved_
state, and this is only looking at the link partner's state.

fiber_lpa_mod_linkmode_lpa_t() also uses the baseT linkmodes for
Fibre.

IMHO, this should be:

		mii_lpa_mod_linkmode_x(phydev->lp_advertising, lpa,
				ETHTOOL_LINK_MODE_1000baseX_Full_BIT);
		phy_resolve_aneg_pause(phydev);

Please can you test whether that works correctly in addition to
your other fix? Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

