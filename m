Return-Path: <netdev+bounces-122811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D06962A45
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA2D1F21EE0
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577CC1684A0;
	Wed, 28 Aug 2024 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RLLj6mIJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD645C1C;
	Wed, 28 Aug 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855519; cv=none; b=IfGfci518blAkDYK/HaJks88gjQ7LVvIXi7o/zxTHgU5JI7xEqvW/qrHUAB5x2Mkb5zVSm+J5T6JG29sn61yYzi18gFrmIhJxG9uNbuAv44diKAgEQyyGJCgpXl+ifCeh1555SuUlYr/4Lv8Ep+U2BNrDNrqIP9hAgKIVLZCm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855519; c=relaxed/simple;
	bh=InPDwIJmiujrgfQpi96LUvkRVAzQqx0fcm7jAgfQpEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQApV5CZAcv2Thh9DHFe0yUJw7BuqwnNSrbnABoA2j2xlerdCQTzUzlwECwissN8PVtddNT1FGMkkYON+IQjcT0fd6qnikl/yubFkOBejBDPsVILnonj/579x2ZcN7K+Xf6D9z3YOnpwqasdYDDUw88ZMWwceneXZ5DYN8yqzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RLLj6mIJ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D26BE40003;
	Wed, 28 Aug 2024 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724855514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBp11t92VbRmerW/yNZLIw8ZxxUVRQYze0GfI/bV7yg=;
	b=RLLj6mIJwOxD4F4Ih3EczWnuu0JhM2qh58gi/MD1Sa3Lta75YgjMDUJ8+uO4MQSDz4FYY6
	m8q3NAJDXBcl6KQ3rey/8CZFJRZkJwZRvIyJXJFN6zOPmzKGitwfvLSAenmXterpgvmyoc
	+WKxz/AXSepM4tFICNISb9sq6b7YdrfNa90wu9NgaXtxY/RAW9ygw77MjHquEFC2q4JoOS
	fXuh1jHZy+dp/9swBngkuOou+yOZDndmZbb494c5+1QUkUYMxcLb+c/DChDr61ycP/sV9L
	VJneaxmD6ees3e5lFbVyaLPED7bcNJ8JPsGdfeeQJWHxgKoc+aJvQrW+LWP5YQ==
Date: Wed, 28 Aug 2024 16:31:51 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 6/6] net: ethernet: fs_enet: phylink conversion
Message-ID: <20240828163151.485b2907@device-28.home>
In-Reply-To: <Zs8sMUxX7mnWZQnA@shell.armlinux.org.uk>
References: <20240828095103.132625-1-maxime.chevallier@bootlin.com>
	<20240828095103.132625-7-maxime.chevallier@bootlin.com>
	<Zs7+J5JWpfvSQ8/T@shell.armlinux.org.uk>
	<20240828134413.3da6f336@device-28.home>
	<Zs8sMUxX7mnWZQnA@shell.armlinux.org.uk>
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

Hello Russell,

On Wed, 28 Aug 2024 14:54:57 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Aug 28, 2024 at 01:44:13PM +0200, Maxime Chevallier wrote:
> > Hi Russell,
> > 
> > On Wed, 28 Aug 2024 11:38:31 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >   
> > > On Wed, Aug 28, 2024 at 11:51:02AM +0200, Maxime Chevallier wrote:  
> > > > +static int fs_eth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> > > > +{
> > > > +	struct fs_enet_private *fep = netdev_priv(dev);
> > > > +
> > > > +	if (!netif_running(dev))
> > > > +		return -EINVAL;    
> > > 
> > > Why do you need this check?
> > >   
> > 
> > I included it as the original ioctl was phy_do_ioctl_running(), which
> > includes that check.
> > 
> > Is this check irrelevant with phylink ? I could only find macb and
> > xilinx_axienet that do the same check in their ioctl.
> > 
> > I can't tell you why that check is there in the first place in that
> > driver, a quick grep search leads back from a major driver rework in
> > 2011, at which point the check was already there...  
> 
> int phylink_mii_ioctl(struct phylink *pl, struct ifreq *ifr, int cmd)
> {
> 	if (pl->phydev) {
> 		... do PHY based access / pass on to phylib ...
> 	} else {
> 		... for reads:
> 		...  return emulated fixed-phy state if in fixed mode
> 		...  return emulated inband state if in inband mode
> 		... for writes:
> 		...  ignore writes in fixed and inband modes
> 		... otherwise return -EOPNOTSUPP
> 	}
> }
> 
> So, if a driver decides to connect the PHY during probe, the PHY will
> always be accessible.
> 
> If a driver decides to connect the PHY during .ndo_open, the PHY will
> only be accessible while the netdev is open, otherwise -EOPNOTSUPP
> will be returned.

That makes sense, so there's no point keeping that check then.

I'll update the patch, thanks for this clarification.

[...]

> At this point... this email has eaten up a substantial amount of time,
> and I can't spend anymore time in front of the screen today so that's
> the end of my contributions for today. Sorry.

I've been in the same rabbit-hole today debating in my head whether or
not to add this check, I'm sorry that I dragged you in there... With
what you stressed-out, I have a good enough justification to drop the
check in the current patch.

As for the current situation with the ioctl return codes, there indeed
room for lots of improvements. For drivers that simply forward the
ioctl to phylib/phylink, I think we could pretty easily add some
consistency on the return code, provided we agree on the proper one to
return.

Thanks for your time,

Maxime 

