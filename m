Return-Path: <netdev+bounces-132617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A8799274E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE4F1C22200
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9071218BC1E;
	Mon,  7 Oct 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fed6/b/K"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CEC18BB9F;
	Mon,  7 Oct 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290466; cv=none; b=Fl1Y+AcYgeqa8cBpITWxlZfAZyg8uQ4JAURk/EklMVVD9XRppp3opiV9jflmqHFz3ELODLrpOfXUqxEEKODc2ndXDPIMVTP+IrIZy/YVj6TlikQujBpCAlQNVuXToJRSZfbKzu6xBhtNKzpcwmnkaM5jUjuT+5iklDY8Zd6PSfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290466; c=relaxed/simple;
	bh=rO640+Mrda36Yh11GK+zbotVsVqA477VU0HUG4/w32E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9cOHXbtnr9p/6MQCyPKlQdFl9Bkjlb1dZDMU3Y4V/KV8rgGIxsTE003Cbf1HmewXrpPXUDX7U+/aCtLWeO9lpaNjk4e47565llurqZhjKFQTaDwbRaue57t7N6MNpEqU7IcZlNkmoWQDCpmsC5yUmmlLXCr4fGimUQwsF/8NFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fed6/b/K; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88D366000A;
	Mon,  7 Oct 2024 08:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728290462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjJjYm1U3UwrwhBRK0WKJKYtopNlAlvdyEXIDZdRFuA=;
	b=fed6/b/KZ0zpimBoYUijOJX9VPpnoYkEZ57MkJ/kMDZNwhhVGTZEPANMcaTtOEAhqxZcYz
	8tUdLHAnwFv388rIZPsol5y3n9j+y/IIQhtDS5h/88sNzG8XQAgjIw4IUEJeL3aOxc1ndq
	XF+DNiuSHkF5slxT/PQd85PzpKHbHdHRpENj8hUXA7jySvrUd9dDsmxKfS6mEHdc+egYFm
	v0k3ch38XWLzDwTKJ2jBg+Jiho7jI+0m8xKL7NBoDG/Kjv8iTkDfvdit2imfOAU5vxMWAQ
	ps8aPLWtEplIULhASHEz7DIdam+1ZNHRFI2nlS4oeOsknbB0KexGAmTxXf6fEQ==
Date: Mon, 7 Oct 2024 12:37:51 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 7/9] net: phy: introduce ethtool_phy_ops to
 get and set phy configuration
Message-ID: <20241007123751.3df87430@device-21.home>
In-Reply-To: <ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
	<20241004161601.2932901-8-maxime.chevallier@bootlin.com>
	<4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
	<ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew, Russell,

On Fri, 4 Oct 2024 20:02:05 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

[...]

> > This seems overly simplistic to me. Don't you need to iterate over all
> > the other PHYs attached to this MAC and ensure they are isolated? Only
> > one can be unisolated at once.
> > 
> > It is also not clear to me how this is going to work from a MAC
> > perspective. Does the MAC call phy_connect() multiple times? How does
> > ndev->phydev work? Who is responsible for the initial configuration,
> > such that all but one PHY is isolated?
> > 
> > I assume you have a real board that needs this. So i think we need to
> > see a bit more of the complete solution, including the MAC changes and
> > the device tree for the board, so we can see the big picture.  
> 
> Also what the ethernet driver looks like too!
> 
> One way around the ndev->phydev problem, assuming that we decide that
> isolate is a good idea, would be to isolate the current PHY, disconnect
> it from the net_device, connect the new PHY, and then clear the isolate
> on the new PHY. Essentially, ndev->phydev becomes the currently-active
> PHY.

It seems I am missing details in my cover and the overall work I'm
trying to achieve.

This series focuses on isolating the PHY in the case where only one
PHY is attached to the MAC. I have followup work to support multi-PHY
interfaces. I will do my best to send the RFC this week so that you can
take a look. I'm definitely not saying the current code supports that.

To tell you some details, it indeed works as Russell says, I
detach/re-attach the PHYs, ndev->phydev is the "currently active" PHY.

I'm using a new dedicated "struct phy_mux" for that, which has :

 - Parent ops (that would be filled either by the MAC, or by phylink,
in the same spirit as phylink can be an sfp_upstream), which manages
PHY attach / detach to the netdev, but also the state-machine or the
currently inactive PHY.

 - multiplexer ops, that implement the switching logic, if any (drive a
GPIO, write a register, this is in the case of real multiplexers like
we have on some of the Turris Omnia boards, which the phy_mux framework
would support)

 - child ops, that would be hooks to activate/deactivate a PHY itself
(isoalte/unisolate, power-up/power-down).

I'll send the RFC ASAP, I still have a few rough edges that I will
mention in the cover.

> However, I still want to hear whether multiple PHYs can be on the same
> MII bus from a functional electrical perspective.

Yup, I have that hardware.

Thanks,

Maxime


