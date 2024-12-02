Return-Path: <netdev+bounces-148034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C489DFE65
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 11:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C3516386A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9C1FC10C;
	Mon,  2 Dec 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N4Dk1KhB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74031FBEA9;
	Mon,  2 Dec 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134215; cv=none; b=UBtOXMHJoAblcZ+cUVQkp8IDiH3NwdBGcQfTKcj132qJ/rwk2zLTfvDryxlgDowjNkferjBz29AT55jXjV79dRImZP3pSgSpxGxNOZ9nZncx6Wi4b29egH3fpgwD3WQA5ywI+tJl2PIiR3meU2ZsTJlVTihbUrMIHR5nQ0CwwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134215; c=relaxed/simple;
	bh=BekjrHV9A2iBaJ/hnsfWmSp18hPYux6Uud+f58IvV+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLNDB504z5qX8iNJyp3F666xuhgqmHrbC6WIAy5oi5aUAHVTZq7V1Uq78jjVqsdr4uhnhNrRnyW0und2XKKTX+fkKra3U8GVPj+OAbkQv1NEJshDarOz5kxZiHkMwlzqgenDMlCif4UK0oENyaxR+t5ySrsR/3LsX5d5vEYieUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N4Dk1KhB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zciEGacUtXXnqsJZizzkL2r5nPwm0cdJAxVV9XLA9Cs=; b=N4Dk1KhBYWsFhaCe+S0ZNwqG4p
	8nZ3Er+obxRWc4IggBKNGNhzjxTptampgm3rPgKB2rtPEbl/i3D8rFP4HurNoUwUeOTUYbQHh9hr/
	ytCYeMpCKuHCE/WIBeaoftjQzpGCOXsJPTLs9HY0uaJ0TCrSwPT+sySLxqw2J6yypL0+diybzaDvK
	F8/p7mSnYXGBqj4q2PTxvDhG5my5VOYXyOkAS4OjwqaBo4lo2/qph/wv2BBWgWOFKRZqWjLl56zfT
	veXyMWQa3aTQiEGoVLGf5810RtHVTtZwJsd5KjrWXuMxVCVVXcL1MXZj2Bqn5oheDdp4+DinGmZn6
	zdF5L4cw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50824)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tI3NW-00088l-0p;
	Mon, 02 Dec 2024 10:10:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tI3NT-0003UT-30;
	Mon, 02 Dec 2024 10:10:03 +0000
Date: Mon, 2 Dec 2024 10:10:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
Message-ID: <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
 <20241202100334.454599a7@fedora.home>
 <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 02, 2024 at 02:20:17PM +0500, Nikita Yushchenko wrote:
> My hardware is Renesas VC4 board (based on Renesas S4 SoC), network driver
> is rswitch, PHY in question is Marvell 88Q3344 (2.5G Base-T1).
> 
> To get two such PHYs talk to each other, one of the two has to be manually configured as slave.
> (e.g. ethtool -s tsn0 master-slave forced-slave).

I don't see what that has to do with whether AN is enabled or not.
Forcing master/slave mode is normally independent of whether AN is
enabled.

There's four modes for it. MASTER_PREFERRED - this causes the PHY to
generate a seed that gives a higher chance that it will be chosen as
the master. SLAVE_PREFERRED - ditto but biased towards being a slace.
MASTER_FORCE and SLAVE_FORCE does what it says on the tin.

We may not be implementing this for clause 45 PHYs.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

