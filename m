Return-Path: <netdev+bounces-179893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E063A7ED94
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0349B1885504
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436EC202996;
	Mon,  7 Apr 2025 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FI0v7al1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA515F330
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744054474; cv=none; b=UmQRuyBjeUfW9WF74jmwmWRB4iAmEfuw9oBWqdAZA3XQSUZYQyvwD3wndjzlRXfDSbVVSjMeF8E/u0hKoBXY8xjGQvKPwbqjXt0b9Iq0PCkgkdG22et3bJVIvQZe/cOIS7aa+ynjHygUhrAmwuprzxy6Ky7Vofmf2SiJ/SBY4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744054474; c=relaxed/simple;
	bh=hoSw5gFUEsIo03srdeMczN2dfKNeVVfNmUg0GKIqxrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXBaK0yxGAS8GT31cApf3f5wPfKf+fDpJCGED1QaO3auTRh4DzKvyQ3kslRAqdWmXbrdN8rKXVip/TMz+358G+pzleRU69yClhMsfm8dV4c58N73FV/Ez7JkIX/Iu632+8ipceWYSooLw8y7b4sAkxOWdbUmJ74OxWkiu5ySw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FI0v7al1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ascKgoBjTHY/LUolZzUcoutNuViS5IJzZQ+upUz4wVw=; b=FI0v7al1LRZRic8Xjpj1WG/KnO
	wbk93PfCiZ+2mBxWzremgQXeJYZZ8fgaSJCLv7xnnV7RieR4Q1OIkcNC2AaGk1UiRHhMfsW+ZaWJZ
	oZichNVs69h9yXfqoi/Uqkj6kgmgAQbCVaOM+lAfiejdOawAe+l0jQvXl2m7/Bu83DW4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u1sEj-008IPX-Od; Mon, 07 Apr 2025 21:34:25 +0200
Date: Mon, 7 Apr 2025 21:34:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <b8a7138d-7e7c-49df-b9b5-9e39f02d0aaa@lunn.ch>
References: <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
 <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
 <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8ZFzlAl1zys63e@shell.armlinux.org.uk>
 <8acfd058-5baf-4a34-9868-a698f877ea08@lunn.ch>
 <Z--HZCOqBvyQcmd9@shell.armlinux.org.uk>
 <CAKgT0UeJvSSCybrqUwgfXxva6oBq0n9rxM=-97DQZQR1kbL8SQ@mail.gmail.com>
 <20250407100138.160f5cb7@kernel.org>
 <CAKgT0UdaeXS=7YTnTSdRO4hyNrSbxuM3pDdmE=1JCvkizUYrZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdaeXS=7YTnTSdRO4hyNrSbxuM3pDdmE=1JCvkizUYrZA@mail.gmail.com>

> Arguably understanding this code, both phylink and our own MAC/PCS/PMD
> code, has been a real grind but I think I am getting there. If I am
> not mistaken the argument is that we aren't "fixed-link" as we have
> control over what the PCS/PMA configuration is. We are essentially
> managing things top down, whereas the expectation for "fixed-link" is
> more of a bottom up.

Fixed link is there to emulate something which does not
exist. Typically you have a MAC connected to a PHY, or a MAC connected
to an SFP. The PHY or the SFP tell you how to configure the MAC so the
chain MAC/PHY/Media works.

However, there are use cases where you connect one MAC directly to
another MAC. E.G you connect a NIC MAC to the MAC port of a switch.

Fixed link allows you to emulate the missing PHY, so that the MAC has
no idea the PHY is missing. The end result is that the MAC gets
configured to make the MAC-MAC link work, without the MAC even knowing
it is connected to another MAC.

When talking about top down vs bottom up, i think you mean MAC towards
the media, vs media towards the MAC. Because of Base-T autoneg, etc,
phylink configures stuff upwards from the media. It needs to wait for
the PHY to determine what the media is going to do. The PHY will then
decided what its host side needs, SGMII, 2500BaseX, 10Gbase etc. That
then allows phylink to configure the PCS to output that. And then you
need to configure the MAC to feed the PCSs at the correct speed. I
don't think SFPs are so different. The SFP will probably indicate what
its maximum bandwidth is. You configure that in the PCS and let is
negotiate with the link partner PCS to determine the speed, pause
etc. You can then configure the MAC with the results of that
negotiation.

So fixed-link is not really bottom up, the whole configuration chain
is media towards the MAC, and it makes no difference if the PHY is
being emulated via a fixed-link because it does not exist.

      Andrew

