Return-Path: <netdev+bounces-169569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E2CA44A2C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E682216764A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0759119E98D;
	Tue, 25 Feb 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CVqql2uZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8F19DF4F;
	Tue, 25 Feb 2025 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507667; cv=none; b=uHnbVGh6RMr9EbPZdtHVGn0/PMLIdD2zL/cUthuAnF6Sj67/Ja6bNZA6vVThGguRz9sIATeuBBno8QAdk18x669L5xLuhHx+xn2yuMbVVMpe2o6LwtNQyKhvVra+KzL2G6vfIM5sPeWxRuyM945sfb8+/soXLzecyJ/GfUr+IDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507667; c=relaxed/simple;
	bh=Cn/mewwWYXy4+YNwH4XczW57RlDnZqheZRJagcYXGkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9lF6UExRDmAQSg4qyh3Qb9Oy0gTVASigbzcegYcT5BOanlBE7VKCRFDMRd3ouD7bDB8FWYb+4LGhoR8CUyZolm8LT+JlO1ee2f/1yz2P0Tr82JyY3BT4/VdAdA17qgALu80beNkKTFYkNND1FVIPaZaTECWrnBkudGvBAVnvZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CVqql2uZ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B44B44469;
	Tue, 25 Feb 2025 18:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740507658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLHCu1SzDUA81bfOLrX40HQiaQBQLCEnAu274pcYQI8=;
	b=CVqql2uZnn25u38xUpnKUfNUVQhNWeQZuyo6ovNiU1q2OF6rFT5LluPVTdNoaKf2ZsujlG
	VOb37t+gS+AzpzdUlsffmNG0uh1OsUZY2+1GWauWuS4Vi3PaY4WYelX/aJwiaQTd7AtJWe
	ewCKVjysXsjeSm5CUlMTgoNu6NGL72OEbEzqM6loCbrDNz8ndhEaW8E0MGwsggFhS+3C2S
	CGRs0VMzSfV6FYN8LfaxQYM87mxjDMwaTCFKj0msLbuErOhH5NcH/jVbf6Bf5ZIG5o96Lj
	gk8qeb2ljL2AndLEM4VHkx2J2jixaTIqZuC0oUPtajmQSEAKS9zVRdOi0eeJww==
Date: Tue, 25 Feb 2025 19:20:55 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Simon Horman
 <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>, Antoine
 Tenart <atenart@kernel.org>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, =?UTF-8?B?QmrDuHJu?= Mork
 <bjorn@mork.no>
Subject: Re: [PATCH net-next v2 1/2] net: phy: sfp: Add support for SMBus
 module access
Message-ID: <20250225192055.32168b48@fedora.home>
In-Reply-To: <Z74GLblGUPhHID8a@shell.armlinux.org.uk>
References: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
	<20250225112043.419189-2-maxime.chevallier@bootlin.com>
	<Z74GLblGUPhHID8a@shell.armlinux.org.uk>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdegudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtt
 hhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue, 25 Feb 2025 18:04:29 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Feb 25, 2025 at 12:20:39PM +0100, Maxime Chevallier wrote:
> > The SFP module's eeprom and internals are accessible through an i2c bus.
> > However, all the i2c transfers that are performed are SMBus-style
> > transfers for read and write operations.  
> 
> Note that there are SFPs that fail if you access them by byte - the
> 3FE46541AA locks the bus if you byte access the emulated EEPROM at
> 0x50, address 0x51. This is documented in sfp_sm_mod_probe().
> 
> So there's a very real reason for adding the warning - this module
> will not work!

That's indeed pretty serious and since we can't even read the
eeprom, there's not even a chance to have, say, a list of modules that
will break with 1-byte io. So indeed the warning is needed...

Thanks

Maxime

