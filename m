Return-Path: <netdev+bounces-168933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2CA41944
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F5E7A2226
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA3B189912;
	Mon, 24 Feb 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NMEWlje+"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951F078F2E;
	Mon, 24 Feb 2025 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389738; cv=none; b=H+D31FrldFAyAb4PtEbEXc8mDZIOfhHhijFNPtdoQGwTwga8oVwmZk+jYzwUDTnYvzdLFNU4XZtgKNzemQW/ILXPt3axcDUvRyh+jgpoqAdi4fwCxF5PMjXOwzj+td16/N/gueWPKuytMM0rZDGKx11zYD9BTRAoOKp7nGTbJB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389738; c=relaxed/simple;
	bh=Lfq2WCwQwVV2cU+ktpJpJCAIJ0AqM3fPlCTamF5mHIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYeKdBKC6+W+TJBVr39y26vaqod5HYrRFwcWDUPhMb83u84Q/1XPHDIObR9Zkop2E7ou9yRgET4XhFqQCken5ixp7CpdIvkK/CxA6POa6I9b6p/IR17c4AwhSqC9JxLZO89ZHa7zGUSpYjSXVLu5VpqDlMCY9qwXWkN4LlU6MiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NMEWlje+; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1DD843209;
	Mon, 24 Feb 2025 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740389728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGa772eSKIEFLSlSRxRncn+1VapD5h+fpWIguQax5B0=;
	b=NMEWlje+MruUWah4Nc7CnSF6Nt3IE69a3glvct/Gr3o32wxgxXI+VHY6zGpICn7Q09iV+w
	JGZl9w3wWpUkEu8f4anxjpuS6sYs3MIVwc1iHXLDGZvMKENDNfXFyRwgFjbgk/zCeU6i/f
	rIzFOFIRFw0t4CpmzjoKniE5iEesvBT0NYVJVCLDjEf8eJn05t4mAcwlA/c/wGoUngY17P
	nEMFVvBUqKQheisDp2x7+uLDBiHtUvJI+XWXw//b4d1cZOWFB/WIRk7trq0bH3+5ZSJ0RC
	gd8jzMi99EYisT/Qz8SFsPs3MFTgA7qtzfSdygcOGRkC4pHXl0jBWXMYrmEYAA==
Date: Mon, 24 Feb 2025 10:35:26 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, Andrew Lunn <andrew@lunn.ch>,
 davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Florian
 Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>, Romain
 Gantois <romain.gantois@bootlin.com>, Antoine Tenart <atenart@kernel.org>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <20250224103526.5164e637@fedora>
In-Reply-To: <Z7wyFolx3q6ACUHO@shell.armlinux.org.uk>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
	<87r03otsmm.fsf@miraculix.mork.no>
	<Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>
	<3c6b7b3f-04a2-48ce-b3a9-2ea71041c6d2@lunn.ch>
	<87ikozu86l.fsf@miraculix.mork.no>
	<Z7wyFolx3q6ACUHO@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhfefgffgtdfhgffhvdfhhffhteeutdektefghfetveehheejjefgudeiudehudenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsjhhorhhnsehmohhrkhdrnhhopdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgo
 hhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 24 Feb 2025 08:47:18 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Feb 24, 2025 at 08:13:22AM +0100, Bj=C3=B8rn Mork wrote:
> > Andrew Lunn <andrew@lunn.ch> writes:
> >  =20
> > >> So, not only do I think that hwmon should be disabled if using SMBus,
> > >> but I also think that the kernel should print a warning that SMBus is
> > >> being used and therefore e.g. copper modules will be unreliable. We
> > >> don't know how the various firmwares in various microprocessors that
> > >> convert I2C to MDIO will behave when faced with SMBus transfers. =20
> > >
> > > I agree, hwmon should be disabled, and that the kernel should printing
> > > a warning that the hardware is broken and that networking is not
> > > guaranteed to be reliable. =20
> >=20
> > What do you think will be the effect of such a warning?  Who is the
> > target audience?
> >=20
> > You can obviously add it, and I don't really care.  But I believe the
> > result will be an endless stream of end users worrying about this scary
> > warning and wanting to know what they can do about it.  What will be
> > your answer? =20
>=20
> ... which is good, because it raises the visibility of crap hardware
> and will make people think twice about whether to purchase it, thus
> penalising (a little) the sales of badly designed hardware.

It's also going to allow users to understand a bit more why all
features aren't available. Plugging modules in a true i2c connected
cage will report all the features, while plugging on an smbus cage will
cause the use of a degraded mode. Not only for hwmon, but as Russell
specifies, I doubt all SFP PHY will behave exactly the same...

I'll respin without hwmon and with the warning then.

Maxime

