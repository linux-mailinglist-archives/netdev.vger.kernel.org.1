Return-Path: <netdev+bounces-148091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872039E0580
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE6D16B875
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA5B20FABD;
	Mon,  2 Dec 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rzjSVrTq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF420FAA4;
	Mon,  2 Dec 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149963; cv=none; b=PiGF3Rpo/ZThUtaPWdkwI5TWwX+zdbCX6sz6W+dYgdXtVogxAI948/KFKRI5tcoLi3E6U3dX7KRWpQiypm2ZSeqmZMn6i9YAwIxmYiKbxMO+Xg7Gbtdb8M+z5bqHl41pxnuLqFUMO1SYWDCnPxE66Bc2qCnFjAAMcg09PrVQhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149963; c=relaxed/simple;
	bh=IJ1Rrc7KpT8C107R71TYZs9A0BxxfhfJImHlo+06Fxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQoLlbmIZYz9Dj1DeWqWq55+2Umax8YT68T5HSatNc0JpZT3RgCnr3Wi/c2LEese3apP+GHvCZhp9GDAdqjLgsaIAdxUE2Z8wBCoTX1rVGAG/GOGzRD2/za96olldAGTn/F+OcZ1KkOUTU9OQB/tF4Umm6a1XMj1AIVpti/Wea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rzjSVrTq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QywnUlO+90s8saZdPpnrP4d9TT5pCFNVTXS7DZDgsoU=; b=rzjSVrTqpXXd2IrWGOplMAgOgI
	UMaFfeD1n5bCrmJ4CxYG7RRwAQ9BUjKNNP35naVgqIVwIsPGOszt7AASAxlEuTSRotK6PYSf+cA9C
	to4xkuSiUr751CRr5txHzafN/rW2ey4isMsZvjixo4Q039JXDCv8PVLsYwAOn5ZmDJ/g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tI7TH-00Exjr-G3; Mon, 02 Dec 2024 15:32:19 +0100
Date: Mon, 2 Dec 2024 15:32:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
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
Message-ID: <3b98a7c5-b8bf-4e96-b969-da1800813251@lunn.ch>
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

If it is a T1 PHY, we want it reporting 25000BaseT1/Full here.  Having
T1 then probably allows us to unlock forced master/slave without
autoneg, and setting speeds above 1G without autoneg.

Given this is an out of tree driver, i can understand why it does not,
it means patching a number of in tree files.

https://www.marvell.com/products/automotive/88q4364.html

says it can actually do 2.5G/5G/10GBASE-T1 as defined by the IEEE
802.3ch standard.

I would be reluctant to make changes to phylib without a kernel
quality PHY driver queued for merging. So you might want to spend some
time cleaning up the code. FYI: I've not looked at 802.3ch, but if
that defines registers, i would expect the driver patches to actually
be split into helpers for standard defined registers any 3ch driver
can use, and a PHY driver gluing those together and accessing marvell
specific registers.

	 Andrew

