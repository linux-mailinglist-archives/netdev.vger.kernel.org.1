Return-Path: <netdev+bounces-128044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E7A9779C1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A881C21F72
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 07:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3601B9B33;
	Fri, 13 Sep 2024 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ihMVstQ5"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2C15575F;
	Fri, 13 Sep 2024 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212902; cv=none; b=Yhb1wzz1hNnNXhSGwumKp2c1fPvHH+QkuwFeO7YM3gcrodfNkQ8UsOl7hrmcBae29X94sEpTY1ADgmYM+b9mrTjLgdtYySzSywyp00oDh/wmOG4hDFA83qXrTHMaJ6xKk+TskuA56JjcWL3a0QVC0x1qUYxi3caQiQnlTfH4Q+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212902; c=relaxed/simple;
	bh=mX/jGZffk5gk33fJhoW3d3jfLDUh95XDVff2tB8gaOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+a/ys/8vyrIcq4PcAUvWFddt2ztJT/0NlwJWAfDscZMWYFKH24TxKhWWiUM3jlq384USSxjYOxXUfJFa8Ats42PfAiu/Y1IRPmzmxyc4FPV9GdIsJrCAzham2kzUlN8iThcw83yYvkmOEiM15aT7XgQS9MzMCBNpsoa+GdWeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ihMVstQ5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A2AE20005;
	Fri, 13 Sep 2024 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726212897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vDMD1mz7qag9tEUPclLr5THupOcTv6X+Brs4WZuFfQ=;
	b=ihMVstQ5VzodMRLaKFCwMp5j8g2iNPC21AvpGx5mswUpXCxHYSscXU5Mkz2A0GDX/DocYP
	p91hNIGOeDE5y+3zaAxn+9T4eDMF2tpnGJvqu8xxPHUnkXh98/OtCn70moyqsSqroxtWK0
	xMLmC/HoIlrXeXIMkN4nasF3ZQllDuB51UQk+xRV130nf6j1ZgqQjAOV5C3XfOlDMajAFd
	yEXT/q4CcoLNOnNT+BbXGBV5NxMuMDKu6wWVcDwEFy/xpWKbjmY842IsDkuHD8RiFJ+8v8
	c1MOTUW8+UxrDUxp+HQeODL4ujGpod8mMAxDrGeLYOcoJE10whV293T8+fZIyA==
Date: Fri, 13 Sep 2024 09:34:53 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 0/7] Allow controlling PHY loopback and isolate
 modes
Message-ID: <20240913093453.30811cb3@fedora.home>
In-Reply-To: <8372fe02-110a-4fca-839a-a4fa6a2dea74@gmail.com>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
	<aae18d69-fc00-47f2-85d8-2a45d738261b@lunn.ch>
	<8372fe02-110a-4fca-839a-a4fa6a2dea74@gmail.com>
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

Hello Andrew, Florian,

On Thu, 12 Sep 2024 11:26:41 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 9/12/24 11:21, Andrew Lunn wrote:
> >> The loopback control from that API is added as it fits the API
> >> well, and having the ability to easily set the PHY in MII-loopback
> >> mode is a helpful tool to have when bringing-up a new device and
> >> troubleshooting the link setup.  
> > 
> > We might want to take a step back and think about loopback some more.
> > 
> > Loopback can be done at a number of points in the device(s). Some
> > Marvell PHYs can do loopback in the PHY PCS layer. Some devices also
> > support loopback in the PHY SERDES layer. I've not seen it for Marvell
> > devices, but maybe some PHYs allow loopback much closer to the line?
> > And i expect some MAC PCS allow loopback.
> > 
> > So when talking about loopback, we might also want to include the
> > concept of where the loopback occurs, and maybe it needs to be a NIC
> > wide concept, not a PHY concept?  
> 
> Agreed, you can loop pretty much anywhere in the data path, assuming the 
> hardware allows it. For the hardware I maintain, we can loop back within 
> the MAC as close as possible from the interface to DRAM, or as "far" as 
> possible, within the MII signals, but without actually involving the PHY.
> 
> Similarly, the PHY can loop as close as possible from the electrical 
> data lines, or as far as possible by looping the *MII pins, before 
> hitting the MAC.
> 
> So if nothing else, we have at least 4 kinds of loopbacks that could be 
> supported, it is not clear whether we want to define all of those as 
> standardized "modes" within Linux, and let drivers implement the ones 
> they can, or if we just let drivers implement the mode they have, and 
> advertise those. Meaning your user experience could vary.

Oleksji identified some loopback modes in TI PHYs, the PHYs have access
to have even different sets of loopback modes / locations as well, to me
it's hard to come-up with a list of all the possible loopback locations
indeed.

However, I don't think it's inconceivable to come-up with a list - that
can be extented - of possible loopback spots.

Making the loopback a NIC concept would indeed make sense here, where we
would aggregate all possible loopback points within the NIC and PHY(s)
combined, and having ways for MAC/PHYS to enumerate their loopback
modes through a set of ethtoop ops.

With that being said, is it OK if I split the loopback part out of that
series ? From the comments, it looks like a complex-enough topic to be
covered on its own, and if we consider the loopback as a NIC feature,
then it doesn't really fit into the current work anymore.

I am however happy to continue discussing that topic. Using loopback
has proven to be most helpful several times for me when bringing-up
devices.

Thanks,

Maxime

