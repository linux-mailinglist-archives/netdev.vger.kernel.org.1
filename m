Return-Path: <netdev+bounces-179741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E04A7E684
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB5F166BB2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051B620C00F;
	Mon,  7 Apr 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k8iDYmWf"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D081EF364;
	Mon,  7 Apr 2025 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042835; cv=none; b=FQy7lVLY/jZKJeDvn3/2eOzHPB/3tHcYSzFy10pS5YXAxHywsU5YPpONnRgj4y6wT5XKGxoAmALPucrEjJ7slOwTy06e76yxOIJ/hhEBBaCo65qt8AouGBr/UGhdnzyG5MSArdVbJrYr4tDNrMMacRvAITNgsUIudSwjFtLOBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042835; c=relaxed/simple;
	bh=TXxyR3B4GcjqANR48pncgbPmMsr2xRFhP8dU3iyGi6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZ6YOH4O4jJhrT1FCFnhczdP31cqFX4f1/SbSNBEcQizKeErDmUg+qRBAwzgkmT2QJu2ptxs06FjqGo2LFRaLDS/jYJDrRgNk1OVzqFclujqr3MBgeu0swBbq7wpFacGQ7MUB+Msp6ZtH8pWS+TxjgK/oJTasHEVUL9nsu7u/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k8iDYmWf; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CB7D43310;
	Mon,  7 Apr 2025 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744042831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3exJDntRzfa6VQ7cc8gO8rKZAJz7OniloKYEXg1rsLY=;
	b=k8iDYmWfALvmeIFNnOnbPCcJfs9l/2YY0lIaUu6qjkMCKX0So7vt2l6mBm4mdxAv5vMXow
	mIuGa6Xmd7bei+k748YcovLM6oHAEWNsR6FlBSyRJRTAvqeLTOjJlYo50jM2XwWa9dpksV
	o9KfjKKCAsmiyJW9G2pHFmD594e9zvE3kdSssFc6VzySII7Z8HrpwpBE1GSRZIopdTMMzd
	Wcabe30KAQjaI9DjV7sUXX6T3BnJIgGFE8NZzPkrcjb58ZbRKMJtrPQ+bCLkW6cG02VrYG
	PrIl1BgIVxJSac9yNKjzsBxpTQB9pm2Rtzd7eqxk0+9u996mMd4Uj0ah1Kv7Ng==
Date: Mon, 7 Apr 2025 18:20:28 +0200
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
Message-ID: <20250407182028.75531758@kmaincent-XPS-13-7390>
In-Reply-To: <Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtieehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqheftdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjedvtdevledtjedvkeetheekleefgfefvdetkeduteejheehiefhvdekvdelhfeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvt
 hdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhgrsggvlheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 7 Apr 2025 17:02:28 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Apr 07, 2025 at 04:02:59PM +0200, Kory Maincent wrote:
> > Add PTP basic support for Marvell 88E151x PHYs.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Is the PTP selection stuff actually sorted now? Last time I tested it
> after it having been merged into the kernel for a while, it didn't work,
> and I reported that fact. You haven't told me that you now expect it to
> work.

The last part of the series, the PTP selection support wasn't merged when y=
ou
tested it, although the default PTP choice that causes your regression was
merged.
Now it is fully merged, even the ethtool support.
https://lore.kernel.org/netdev/mjn6eeo6lestvo6z3utb7aemufmfhn5alecyoaz46dt4=
pwjn6v@4aaaz6qpqd4b/

The only issue is the rtln warning from the phy_detach function. About it, I
have already sent you the work I have done throwing ASSERT_RTNL in phy_deta=
ch.
Maybe I should resend it as RFC.

> I don't want this merged until such time that we can be sure that MVPP2
> platforms can continue using the MVPP2 PTP support, which to me means
> that the PTP selection between a MAC and PHY needs to work.

It should works, the default PTP will be the MAC PTP and you will be able to
select the current PTP between MAC and PHY with the following command:
# ethtool --set-hwtimestamp-cfg eth0 index 0 qualifier precise
Time stamping configuration for eth0:
Hardware timestamp provider index: 0
Hardware timestamp provider qualifier: Precise (IEEE 1588 quality)
Hardware Transmit Timestamp Mode:
	off
Hardware Receive Filter Mode:
	none
Hardware Flags: none
# ethtool --set-hwtimestamp-cfg eth0 index 1 qualifier precise
Time stamping configuration for eth0:
Hardware timestamp provider index: 1
Hardware timestamp provider qualifier: Precise (IEEE 1588 quality)
Hardware Transmit Timestamp Mode:
	off
Hardware Receive Filter Mode:
	none
Hardware Flags: none

You can list the PTPs with the dump command:
# ethtool --show-time-stamping "*"

You will need to stop phc2sys and ptp4l during these change as linuxptp may
face some issues during the PTP change.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

