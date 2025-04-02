Return-Path: <netdev+bounces-178728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CA5A7884D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 08:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E643AABB6
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 06:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF22231CB0;
	Wed,  2 Apr 2025 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QXUCBHUN"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984119049B;
	Wed,  2 Apr 2025 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576447; cv=none; b=NUAXND6KBzuG1MijcHByVdWkkORjn6zCRKKcxpSdMFtEQX2nlqvDZGyF9XVLacQRbrW+dVqRqS0o812Y3Sn4WcBKlWlyM9MNWyrHojtWP8w8E1UXL8HKFbTEELhYpmZ5zlGIuVu20EfqDNhuI8JjdApmdoYxxoZOP+paeJeEEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576447; c=relaxed/simple;
	bh=n2QGawQ++618BOMU9y2B5+lGS8jDmBhY05os0N8/WkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlPX2FlqIGaUQetQsy1wjkcFoJOQU5iHup/2t+9rHrtnGgBONsfM343ooaHwT6bh5LTm/mACp5oFdO1boZrVrt/OzE9pw6tSeIgUAYpwX74aERzdGTbLVXn2RZ9GEz7o+yaPGN2qVJh8f0FZbqtmWDXBLLO/R6L1JuCB6ECvw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QXUCBHUN; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15CDB4432F;
	Wed,  2 Apr 2025 06:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743576442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91QabIyHUeDDbVbgDDW38HeCEEGmj7YCmJ79O7+U7QQ=;
	b=QXUCBHUNUfi1vLcXOftm6Wj0p9c/FfloQ6SezD61YmMYPA3m8FcDc9A7A5C1VBwS1/4VM6
	el1ik/ux7jYuCcCMUNnyQXiJ1dpobRl4Q+mplDZUuUb5l/lFJ35wI3/xc6t13vfxS/XvcL
	gaWvZboR58uI/7CTkylFBvl+TjfefxRTIVXb9/5JPwRkMlyJ6/018NQEPmlC8ejjDqoXJN
	Y7+VOnTBpK6R9nPdbIMiAnMmWbYvpQeCaL87vxT7YXxGpu8MUaQmyEMlDjHPChxdcGyeAt
	vKzDxmEZuGFSYrz4LMt2oOqqLl8wi0juYqNTrCXir501yVdHNqWTB4hlUPrajg==
Date: Wed, 2 Apr 2025 08:47:15 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander H Duyck <alexander.duyck@gmail.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
Message-ID: <20250402084715.3090c6c2@fedora.home>
In-Reply-To: <Z-wQ1Ml_9xNz0XtV@shell.armlinux.org.uk>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
	<20250307173611.129125-10-maxime.chevallier@bootlin.com>
	<8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
	<20250328090621.2d0b3665@fedora-2.home>
	<CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
	<20250331091449.155e14a4@fedora-2.home>
	<3517cb7b3b10c29a6bf407f2e35fdebaf7a271e3.camel@gmail.com>
	<Z-wQ1Ml_9xNz0XtV@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeegleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrlhgvgigrnhguvghrrdguuhihtghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlo
 hhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com


> > Basically we still need the value to be screened by the pl->supported.
> > The one change is that we have to run the extra screening on the
> > intersect instead of skipping the screening, or doing it before we even
> > start providing bits.
> > 
> > With this approach we will even allow people to use non twisted pair
> > setups regardless of speed as long as they don't provide any twisted
> > pair modes in the standard set.
> > 
> > I will try to get this tested today and if it works out I will submit
> > it for net. I just need to test this and an SFP ksettings_set issue I
> > found when we aren't using autoneg.  
> 
> This code used to be so simple... and that makes me wonder whether
> Maxime's work is really the best approach. It seems that the old way
> was better precisely because it was more simple.

Sorry to hear you say that. Fixed-link was the main pain point with
this work, I've stressed it out. I agree that for fixed-link, it
ends-up not looking too good, hopefully the rest of the series
compensate for that.

Maxime

