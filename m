Return-Path: <netdev+bounces-179755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BCEA7E721
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66743AA25C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAFB20E00F;
	Mon,  7 Apr 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PwAsRLai"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566B20DD5E;
	Mon,  7 Apr 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043961; cv=none; b=tYk5vXjpziVXpZm+f0OvefcGWBYduFPDJ0Y5JUQrbbUrdKoCphxdSyvbcUM2ZUlTd+xZEQP88M5+KKUEEGqkVljgX/kBN8ei/dBFNOb0vnR17D4g2/TYQ5F3Kf78ZWPCaHo/Ju4XYpYVqyJOlE2/p/9HBK8clpZVbuHh7MenttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043961; c=relaxed/simple;
	bh=Dg8o6C0AsxnelO6Xo6Qfc2MXFDv91eVFRd7+6eolJJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQoUCvuNyzT+2wQIIvhuGnZzAPcbneJjnK3oi0YCJxgdv8V90lx0mhZqnPN9oVKiaGxiV9AshHGl1EE+azo1f+uh5t/oCd/9hB8p/kELGRMWUXtG88/p/5sZEQTvUe0PxTGPTNKWWvNTw5YnBuVmS+7LnQMepQ8DODfEKvgH/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PwAsRLai; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B8B620485;
	Mon,  7 Apr 2025 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744043956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CH/qp3/AaCHFl3eKPvG4jbQaXjD1BP8zO8PK+bAjXs=;
	b=PwAsRLaiVpkvg02qQVZERhFznJv4C1gCboEdp20ke9sUHRUBwPvUQReKEvazvJDzSXAzD0
	6MVzAsi8Iw6gj2UOKrWjE7AWTdWlDFj6aAgt+JEIrdlP0gndWnjzH94ExZDXWbd84L1KZS
	ETsLaJ9rJhS0tloXjf8jlmEVdGMKsLfuLRCNuifRFdS/YNKH641do5dq6ANpTvO5K/5tdf
	quZLAn9dkp9DKxgofEDrDbIpo3oEPM5SR3pYezHS37JMSJBqmVzHF54fEQgKmawwZgnRWL
	Gans8LUwPGjFlhMiBE9nWFljGaSLJF3GJbN/D4LIMHCjVgwIEFE0mQiJLtvG4A==
Date: Mon, 7 Apr 2025 18:39:14 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <20250407183914.4ec135c8@kmaincent-XPS-13-7390>
In-Reply-To: <Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
	<20250407182028.75531758@kmaincent-XPS-13-7390>
	<Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfduveekuedtvdeiffduleetvdegteetveetvdelteehhfeuhfegvdeuuedtleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvt
 hdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhgrsggvlheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 7 Apr 2025 17:32:43 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Apr 07, 2025 at 06:20:28PM +0200, Kory Maincent wrote:
> > On Mon, 7 Apr 2025 17:02:28 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >  =20
> > > On Mon, Apr 07, 2025 at 04:02:59PM +0200, Kory Maincent wrote: =20
>  [...] =20
> > >=20
> > > Is the PTP selection stuff actually sorted now? Last time I tested it
> > > after it having been merged into the kernel for a while, it didn't wo=
rk,
> > > and I reported that fact. You haven't told me that you now expect it =
to
> > > work. =20
> >=20
> > The last part of the series, the PTP selection support wasn't merged wh=
en
> > you tested it, although the default PTP choice that causes your regress=
ion
> > was merged.
> > Now it is fully merged, even the ethtool support.
> > https://lore.kernel.org/netdev/mjn6eeo6lestvo6z3utb7aemufmfhn5alecyoaz4=
6dt4pwjn6v@4aaaz6qpqd4b/
> >=20
> > The only issue is the rtln warning from the phy_detach function. About =
it, I
> > have already sent you the work I have done throwing ASSERT_RTNL in
> > phy_detach. Maybe I should resend it as RFC.
> >  =20
> > > I don't want this merged until such time that we can be sure that MVP=
P2
> > > platforms can continue using the MVPP2 PTP support, which to me means
> > > that the PTP selection between a MAC and PHY needs to work. =20
> >=20
> > It should works, the default PTP will be the MAC PTP and you will be ab=
le to
> > select the current PTP between MAC and PHY with the following command:
> > # ethtool --set-hwtimestamp-cfg eth0 index 0 qualifier precise
> > Time stamping configuration for eth0:
> > Hardware timestamp provider index: 0
> > Hardware timestamp provider qualifier: Precise (IEEE 1588 quality)
> > Hardware Transmit Timestamp Mode:
> > 	off
> > Hardware Receive Filter Mode:
> > 	none
> > Hardware Flags: none
> > # ethtool --set-hwtimestamp-cfg eth0 index 1 qualifier precise
> > Time stamping configuration for eth0:
> > Hardware timestamp provider index: 1
> > Hardware timestamp provider qualifier: Precise (IEEE 1588 quality)
> > Hardware Transmit Timestamp Mode:
> > 	off
> > Hardware Receive Filter Mode:
> > 	none
> > Hardware Flags: none
> >=20
> > You can list the PTPs with the dump command:
> > # ethtool --show-time-stamping "*"
> >=20
> > You will need to stop phc2sys and ptp4l during these change as linuxptp=
 may
> > face some issues during the PTP change. =20
>=20
> I'm preferring to my emails in connection with:
>=20
> https://lore.kernel.org/r/ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk
>=20
> when I tested your work last time, it seemed that what was merged hadn't
> even been tested. In the last email, you said you'd look into it, but I
> didn't hear anything further. Have the problems I reported been
> addressed?

It wasn't merged it was 19th version and it worked and was tested, but not
with the best development design. I have replied to you that I will do some
change in v20 to address this.
https://lore.kernel.org/all/20241113171443.697ac278@kmaincent-XPS-13-7390/

It gets finally merged in v21.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

