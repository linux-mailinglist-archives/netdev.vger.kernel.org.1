Return-Path: <netdev+bounces-183299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3A3A9043D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098AA1906E9F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989E1189B91;
	Wed, 16 Apr 2025 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zfx15pH3"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5517A304
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809596; cv=none; b=n078lbeRS5s7CesuWAKs3NxcYSa8QaEnAoLRhWfSt268GHV5qID/JLkOaEP6vJ+VPDTsTIFbWLhO3Hk/GQ+So/oWoP/2Dr+84OfkMAFpDkEG8M88QCvT+39sNkX/0PodSp2toFaQNlmu50/GPdRI6yQLH3MBZp1qnlv5Gh5v5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809596; c=relaxed/simple;
	bh=7Jv4eMqp33u8FvIsIhegCrHiuE/9+7fGsj8gbaBg3N4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkM49C8d87xsVPFs1wTlQYChMgiGDDKDXyzVRHzTmy/o3HOYPFixX5JtyaLMSn17SQ2pUsZwsQ6BrsnU654Dj7urOp3CN3KRrSIGxgiWBMm4nsA+rJ0vJDGNdsS07w5+gG0qjKne0RyPj9KIzNXdyA3R3wjrLsjc1Nm6yWR6VTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zfx15pH3; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CDB843858;
	Wed, 16 Apr 2025 13:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744809592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Jv4eMqp33u8FvIsIhegCrHiuE/9+7fGsj8gbaBg3N4=;
	b=Zfx15pH33jUU9EQVxOSLQ2OGhbq5O1M4LY8Cg1Ddw2RypSPvS8nZPHlVNnDhgGcAliIVkE
	sccN8ysQjpyllr95UqwUW3HxEQrokQRCIEouzRW01Uwqcg8OHdDzJF3jtSpKOEtG2rxaqs
	U0k2/+amo4VzzZDaPa0stcNZ/Aso/gYzEk1ccPvI5j6dFgnAWCsnAzRXSDScK7At0vAfsw
	9MgT0dIqPoFyCam6wfRjrw/dfJQnBeU8wZjBAZcg8tvMBuMyX7LG7+3OBVMftSXcRMMo6i
	jmXiNiKbW3tM/hWlvYGkyvaoMvJkkd9N70QQDtg3kUjbjt86TALvzBBzLuqKng==
Date: Wed, 16 Apr 2025 15:19:49 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 0/5] Marvell PTP support
Message-ID: <20250416151949.6bddde35@kmaincent-XPS-13-7390>
In-Reply-To: <Z_-Lr-w95sX4fLIF@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
	<Z_-Lr-w95sX4fLIF@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeigeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkeefvdejheekhfeiieeuhfdugfelveekueekteffteejfeevteelhefhtdfhuefgnecuffhomhgrihhnpegthhhrohhnohhsrdhukhdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnr
 dgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhgtihhnrdhsrdifohhjthgrshesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 16 Apr 2025 11:51:27 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Fri, Apr 11, 2025 at 10:26:15PM +0100, Russell King (Oracle) wrote:
> > Hi,
> >=20
> > This series is a work in progress, and represents the current state of
> > things, superseding Kory's patches which were based in a very old
> > version of my patches - and my patches were subsequently refactored
> > and further developed about five years ago. Due to them breaking
> > mvpp2 if merged, there was no point in posting them until such time
> > that the underlying issues with PTP were resolved - and they now have
> > been.
> >=20
> > Marvell re-uses their PTP IP in several of their products - PHYs,
> > switches and even some ethernet MACs contain the same IP. It really
> > doesn't make sense to duplicate the code in each of these use cases.
> >=20
> > Therefore, this series introduces a Marvell PTP core that can be
> > re-used - a TAI module, which handles the global parts of the PTP
> > core, and the TS module, which handles the per-port timestamping.
> >=20
> > I will note at this point that although the Armada 388 TRM states that
> > NETA contains the same IP, attempts to access the registers returns
> > zero, and it is not known if that is due to the board missing something
> > or whether it isn't actually implemented. I do have some early work
> > re-using this, but when I discovered that the TAI registers read as
> > zero and wouldn't accept writes, I haven't progressed that.
> >=20
> > Today, I have converted the mv88e6xxx DSA code to use the Marvell TAI
> > module from patch 1, and for the sake of getting the code out there,
> > I have included the "hacky" patches in this series - with the issues
> > with DSA VLANs that I reported this evening and subsequently
> > investigated, I've not had any spare time to properly prepare that
> > part of this series. (Being usurped from phylink by stmmac - for which
> > I have a big stack of patches that I can't get out because of being
> > usurped, and then again by Marvell PTP, and then again by DSA VLAN
> > stuff... yea, I'm feeling like I have zero time to do anything right
> > now.) The mv88e6xxx DSA code still needs to be converted to use the
> > Marvell TS part of patch 1, but I won't be able to test that after
> > Sunday, and I'm certainly not working on this over this weekend.
> >=20
> > Anyway, this is what it is - and this is likely the state of it for
> > a while yet, because I won't be able to sensibly access the hardware
> > for testing for an undefined period of time.
> >=20
> > The PHY parts seem to work, although not 100% reliably, with the
> > occasional overrun, particularly on the receive side. I'm not sure
> > whether this is down to a hardware bug or not, or MDIO driver bug,
> > because we certainly aren't missing timestamping a SKB. This has been
> > tested at L2 and L4.
> >=20
> > I'm not sure which packets we should be timestamping (remembering
> > that this is global config across all ports.)
> > https://chronos.uk/wordpress/wp-content/uploads/TechnicalBrief-IEEE1588=
v2PTP.pdf
> > suggests Sync, Delay_req and Delay_resp need to be timestamped,
> > possibly PDelay_req and PDelay_resp as well, but I haven't seen
> > those produced by PTPDv2 nor ptp4l.
> >=20
> > There's probably other stuff I should mention, but as I've been at
> > this into the evening for almost every day this week, I'm mentally
> > exhausted.
> >=20
> > Sorry also if this isn't coherent. =20
>=20
> I've just updated this series for the supported pins flags that was
> merged into net-next last night.
>=20
> Kory, if you have any changes you want me to review before sending
> out the updates, please send soon. Thanks.

Maybe using kdoc in marvell_ts.c. You can copy paste the ones I wrote on th=
e v2
of your driver I posted.

Also don't forget to run checkpatch, patchwork reported errors on your seri=
es.
It was not an issue as it was a RFC but it will if you remove it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

