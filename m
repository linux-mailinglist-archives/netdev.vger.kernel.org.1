Return-Path: <netdev+bounces-224979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC7B8C69F
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 13:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5909562CF1
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 11:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9F2D640A;
	Sat, 20 Sep 2025 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1Y81j9AE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2829BDB3
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758367116; cv=none; b=TE0FYfNFBBo1L3K/lLyNltTTWC70FaG65MYx9x4oYALCNSnLD8Bj6TZEk9pYzl0/mfF6pG3zOCWS7SXrc/frsbEZ0dhHubKVGFQhPlEHxbHhd+6V3mRuRj1501C58JtEIh8F+R4M/50kTxJC7bb/Pgp3fK8KyYUqb09GRFikwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758367116; c=relaxed/simple;
	bh=aigZPeNf3sifh493XXNkxFvOYEKd0OBOWnVZiKKjV/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAJkPkKK6WL8pQQw5Bk1uBO261iZwoWiJcQC6WHBPre/X5Ogwvt+rldm8u9d+XngsDWy6ZVqUc+jBt/gc8Z2f8knosJ3Hz6Owgm6lmkxvLY8KoV9Lhb5m+TW0JeqEJereTzSjmmRYYNlCrYOPwRTrqA6pJjLvB+EkYWrl9kDrKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1Y81j9AE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tCEeW85kaGzH1qr1kRp+zRPUSwpshCIjL2JqDbKueGk=; b=1Y81j9AE7BnfPyMs/l4w70hhVP
	VqEwHJuIocAzeJVsZPeSPzVaXM5PQG63W5Ypd9Z83dYbXkRblh7FByaBTxg/3a/tW5rvV6rBST93U
	SIPj31F60bpqyY9KJHz4LhDod51itglKFlc9U04gMbsZ8XOEcwJ3JgZNSdq0JCAA4o5/0hD9ngXKw
	3Cd4SX/1zEUb8AhZw/DbIwtzjGUN5jSb4u73hKY5ahJ8ZGkvTdP58loM6YZeCqIHStykdykTHCg6J
	NSC5sAp1ZpubbwckEGyceMyXZq2kGx1d/FlUbBlTzvVB4ygA6ajnuq/heyeqW+/8ij1TfI5migq0K
	6dVVdUpw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60442)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uzvbq-0000000007I-14pz;
	Sat, 20 Sep 2025 12:18:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uzvbn-0000000034s-1zH5;
	Sat, 20 Sep 2025 12:18:27 +0100
Date: Sat, 20 Sep 2025 12:18:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
Message-ID: <aM6Ng7tnEYdWmI1F@shell.armlinux.org.uk>
References: <971aaa4c-ee1d-4ca1-ba38-d65db776d869@kabelmail.de>
 <cbc4a620-36d3-409b-a248-a2b4add0016a@lunn.ch>
 <f86737b0-a0fe-49a6-aeca-9e51fbdf0f0d@kabelmail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f86737b0-a0fe-49a6-aeca-9e51fbdf0f0d@kabelmail.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Sep 20, 2025 at 12:00:50PM +0200, Janpieter Sollie wrote:
> Op 19/09/2025 om 19:04 schreef Andrew Lunn:
> > On Fri, Sep 19, 2025 at 03:52:55PM +0200, Janpieter Sollie wrote:
> > > Hello everyone,
> > Please ensure you Cc: the correct Maintainers.
> > 
> > ./scripts/get_maintainer.pl drivers/net/phy/sfp.c
> > Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT)
> > Andrew Lunn <andrew@lunn.ch> (maintainer:ETHERNET PHY LIBRARY)
> > Heiner Kallweit <hkallweit1@gmail.com> (maintainer:ETHERNET PHY LIBRARY)
> > "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
> > Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
> > Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
> > Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
> > netdev@vger.kernel.org (open list:SFF/SFP/SFP+ MODULE SUPPORT)
> > linux-kernel@vger.kernel.org (open list)
> Done, sorry, this is my first post here
> > 
> > > I tested a SFP module where the i2c bus is "unstable" at best.
> > Please tell us more about the hardware.
> > 
> > Also, what speed do you have the I2C bus running at? Have you tried
> > different clock-frequency values to slow down the I2C bus? Have you
> > checked the pull-up resistors? I2C problems are sometimes due to too
> > strong pull-ups.
> The hardware is a bananapi R4 2xSFP using a MT7988a SoC.
> The SFP+ module is a RJ45 rollball module using a AQR113C phy, but needs a
> quirk in sfp.c (added below)
> I'm not a i2c expert at all,
> but about the i2c bus speed, the SFP cage seems to be behind a muxer, not a i2c root.
> I could not find anything about i2c bus speed in /proc or /sys, maybe it's impossible to tell?
> 
> The dtsi or dtso files do not mention anything about bus speeds, so I honestly do not know.

As you have not include the author of the SFP support (me) in your
initial email, and have not provided a repeat of the description,
I'm afraid I have no idea what the issue is that you're encountering.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

