Return-Path: <netdev+bounces-180649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D97DA8202F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516983AD37F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF0025C706;
	Wed,  9 Apr 2025 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JxOHfEpA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F98F22D4D4;
	Wed,  9 Apr 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187771; cv=none; b=Akkfs69WJHnJONS/AEiFXDvW4lqK1w0IpTcPW8aNhorq6L16EWsRNhlLvL7xeljhYayNiweqUJnDVxMOyGWvjll2CsYbhKQ6IDxXJznpOk6HHEdeDmwpJjZ3cGy/j6si2tm19kvk1Vdodu74mMTU15vPaI/49zomqFDHB0uqVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187771; c=relaxed/simple;
	bh=ndma1L/vxUMfXkDwaQPrl7wCz2eHmQ0e3LdcIJkDHd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9Oq7AIbJ2r027kHSv4GO4YzaTf1iqRr5ijeIfRsIqd61di3FuXoySFe2SwkYgrDTVdi5sWfzMTaH0JOs48F/IbzIXwvyNwQX20jud1tQZNuVljstw2mAi5VMnnCtmWUIXm4d6fDgG9l6r9TB0QQa9Cnin3RZiShMAhHQofURCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JxOHfEpA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q3ecYacwG4Aorvd7wfw9EgBZG2LtEkkY7JvpnDXhS48=; b=JxOHfEpADDwTcatS2ifIslfKRW
	7sPd0FGyUmBnOsdVtrf88xQQYyNdqrJwverEDU/kZrjwttigjkfiWrUqsqoS5Eim3L9KT7L7adelx
	CbLsaCDvLtsUUOzw2Pm0XuUrmtm8MCN/ia2POGL5WFxwkYgh4fLaPS8o5tn7Mnm062w5bA1QUj6x8
	a9yejTFS3Rfk7W+EB55xuo2GzIROnZdn86J18+M7YSb1P3q6RBoWFV0avEkPf8txze37hcOBl/ZER
	8U0xxf6857IFe+FbIjTGwqUYmrMPMw94U6bYSLpeRCkvkv/olb9aOBwOTFdx5dh4IPQDNrPAYie7T
	716a9zzQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47374)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2Quf-0000GO-1d;
	Wed, 09 Apr 2025 09:36:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2Qud-0002Pp-0k;
	Wed, 09 Apr 2025 09:35:59 +0100
Date: Wed, 9 Apr 2025 09:35:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <Z_Yxb6-qclDSWk01@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
 <20250407182028.75531758@kmaincent-XPS-13-7390>
 <Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
 <20250407183914.4ec135c8@kmaincent-XPS-13-7390>
 <Z_WJO9g5Al1Yr_LX@shell.armlinux.org.uk>
 <20250409103130.43ab4179@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409103130.43ab4179@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 09, 2025 at 10:31:30AM +0200, Kory Maincent wrote:
> On Tue, 8 Apr 2025 21:38:19 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Mon, Apr 07, 2025 at 06:39:14PM +0200, Kory Maincent wrote:
> > > On Mon, 7 Apr 2025 17:32:43 +0100
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > > I'm preferring to my emails in connection with:
> > > > 
> > > > https://lore.kernel.org/r/ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk
> > > > 
> > > > when I tested your work last time, it seemed that what was merged hadn't
> > > > even been tested. In the last email, you said you'd look into it, but I
> > > > didn't hear anything further. Have the problems I reported been
> > > > addressed?  
> > > 
> > > It wasn't merged it was 19th version and it worked and was tested, but not
> > > with the best development design. I have replied to you that I will do some
> > > change in v20 to address this.
> > > https://lore.kernel.org/all/20241113171443.697ac278@kmaincent-XPS-13-7390/
> > > 
> > > It gets finally merged in v21.  
> > 
> > Okay, so I'm pleased to report that this now works on the Macchiatobin:
> > 
> > where phc 2 is the mvpp2 clock, and phc 0 is the PHY.
> 
> Great, thank you for the testing!
> 
> > 
> > # ethtool -T eth2
> > Time stamping parameters for eth2:
> > Capabilities:
> >         hardware-transmit
> >         software-transmit
> >         hardware-receive
> >         software-receive
> >         software-system-clock
> >         hardware-raw-clock
> > PTP Hardware Clock: 2
> > Hardware Transmit Timestamp Modes:
> >         off
> >         on
> >         onestep-sync
> >         onestep-p2p
> > Hardware Receive Filter Modes:
> >         none
> >         all
> > 
> > So I guess that means that by default it's using PHC 2, and thus using
> > the MVPP2 PTP implementation - which is good, it means that when we add
> > Marvell PHY support, this won't switch to the PHY implementation.
> 
> Yes.
> 
> > 
> > Now, testing ethtool:
> > 
> > $ ./ethtool --get-hwtimestamp-cfg eth2
> > netlink error: Operation not supported
> > 
> > Using ynl:
> > 
> > # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump
> > tsconfig-get --json '{"header":{"dev-name":"eth2"}}' []
> > 
> > So, It's better, something still isn't correct as there's no
> > configuration. Maybe mvpp2 needs updating first? If that's the case,
> > then we're not yet in a position to merge PHY PTP support.
> 
> Indeed mvpp2 has not been update to support the ndo_hwtstamp_get/set NDOs.
> Vlad had made some work to update all net drivers to these NDOs but he never
> send it mainline:
> https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v9
> 
> I have already try to ping him on this but without success.
> Vlad any idea on when you could send your series upstream?

Right, and that means that the kernel is not yet ready to support
Marvell PHY PTP, because all the pre-requisits to avoid breaking
mvpp2 have not yet been merged.

So that's a NAK on this series from me.

I'd have thought this would be obvious given my well known stance
on why I haven't merged Marvell PHY PTP support before.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

