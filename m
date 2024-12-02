Return-Path: <netdev+bounces-148050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF39E042F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E54DB3CB7B
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D20F1FECB8;
	Mon,  2 Dec 2024 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KKcWoxi2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775E41FF7DA;
	Mon,  2 Dec 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142621; cv=none; b=SahPonBdUXKDX8you3yWEAhdBSq+0vOL2+dD/8TuPyLS6FgECtSpmMtQIIIgp2ICNL0t0ROaOKhbH1VfbInBIZHfUKPMq1c+qXIvMzKsuh3sKp8QXpgcpIb8mvwNVnc4fygPMw2mFIqndcmWT9qCi78UOWVuq9VqspFDFSgPXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142621; c=relaxed/simple;
	bh=5Xyo5nOCg2fTOq8pqNwjMvooTE/vU0oUcIk6nzyVG9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeFM9Xm6G3kfduETqz5ceVp47Xhq8+/JBWAHn5L3qCt+GBzN5rRjORPDKLKnp443XkE2cbOX54bneMtVtdOryUxPSYaPFB6ref1tSvfKQQGvBNhNBitYu4DRBEh3EIVJN4KzsfUmpgr4mHS6w5Ap4XKnvR/5jgBNMx3RDEXWq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KKcWoxi2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dTC+gMCuGXrpbpNTlTZ4pflG6PEuf6LHsnKKAyen5K8=; b=KKcWoxi2AbRVpK8zPFzXiq8QCV
	z1sRNU8u450aRzrUmVvBM10qTHQAmc8K3xSQNlfeftHuaqOTEnkupBOX3W/6xIKVYD4v+iOZoB6XH
	uzZsyYlLPTaOUGIC+dPnDUHpnfhCIiH2VyT1BDoTkJ6jA96h+fWrAgUBmM/3qbpWlpnu5ITi9RaCX
	4HDh4PigH5+uX7XhcJkZ96Cfvw3BG/+1W1gk7htuy2hVQEX2XeDyNY+3Td3xY9LpWXVzNslvu0sQy
	H6swbRB+pKISoq015I0DeToC1AyLyWFnkLSbKtd6akeoto2YhfA3mjIM/7+46ueFVVqOkwxELXUx5
	po+DpBxg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36580)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tI5Z2-0008O9-39;
	Mon, 02 Dec 2024 12:30:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tI5Yy-0003ZG-1n;
	Mon, 02 Dec 2024 12:30:04 +0000
Date: Mon, 2 Dec 2024 12:30:04 +0000
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
Message-ID: <Z02oTJgl1Ldw8J6X@shell.armlinux.org.uk>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
 <20241202100334.454599a7@fedora.home>
 <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
 <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
 <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
 <Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
 <c1296735-81be-4f7d-a601-bc1a3718a6a2@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1296735-81be-4f7d-a601-bc1a3718a6a2@cogentembedded.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 02, 2024 at 04:09:43PM +0500, Nikita Yushchenko wrote:
> > > Right now, 'ethtool -s tsn0 master-slave forced-slave' causes a call to
> > > driver's ethtool set_link_ksettings method. Which does error out for me
> > > because at the call time, speed field is 2500.
> > 
> > Are you saying that the PHY starts in fixed-speed 2.5G mode?
> > 
> > What does ethtool tsn0 say after boot and the link has come up but
> > before any ethtool settings are changed?
> 
> On a freshly booted board, with /etc/systemd/network temporary moved away.
> 
> (there are two identical boards, connected to each other)
> 
> root@vc4-033:~# ip l show dev tsn0
> 19: tsn0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 3a:e3:5c:56:ba:bd brd ff:ff:ff:ff:ff:ff
> 
> root@vc4-033:~# ethtool tsn0
> Settings for tsn0:
>         Supported ports: [ MII ]
>         Supported link modes:   2500baseT/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: No

Okay, the PHY can apparently only operate in fixed mode, although I
would suggest checking that is actually the case. I suspect that may
be a driver bug, especially as...

>         Supported FEC modes: Not reported
>         Advertised link modes:  2500baseT/Full
>         Advertised pause frame use: No
>         Advertised auto-negotiation: No
>         Advertised FEC modes: Not reported
>         Speed: 2500Mb/s
>         Duplex: Unknown! (255)

... after link up:

>         Speed: 2500Mb/s
>         Duplex: Full

it changes phydev->duplex, which is _not_ supposed to happen if
negotiation has been disabled.

When negitation is disabled, phydev->speed and phydev->duplex are
supposed to set the link parameters, and the PHY driver is not
supposed to alter them from what was set, possibly by the user.

So there is something weird going on in the driver, and without
seeing it, I'm not sure whether (a) it's just a badly coded driver
that the PHY does support AN but the driver has decided to tell the
kernel it doesn't, (b) whether it truly is not using AN.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

