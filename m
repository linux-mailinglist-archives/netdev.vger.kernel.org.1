Return-Path: <netdev+bounces-182266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D6FA88621
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65021904886
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C04253932;
	Mon, 14 Apr 2025 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c7SfZNtM"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879F274FF7
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641801; cv=none; b=mV9NEZTOBLYT3duZReltKmXxV9Z1Rf0XI1K5Y5AIByjpnCDvyoIz5q8AeqYDG8we90XW4UdYyoq010Y9tjKaykyo5RrYsytLjKW4wHAb9rOvj6xUYHZhw1I3HeB2/KZXjF48nz8gEbPObm2sES4MZ9pNHDgkBTd9dKv6MZM+h6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641801; c=relaxed/simple;
	bh=LN30hcm+N4XrhXGh3JvkAudvQ4owbFUGDF0VU2Eipro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqCin/zko6T8O5R8V29ZBMZhlEPyrDL0sAz1iFDUdou+y8raINMxwzag5VP9lIioHwbZfiwpQSQpRwB1rCs6UFsAu7ss9zcDQE66YR3ivu0biIbR6kBi9AvRuR8v4+e6HJa9Ipx5g1pIZ4K8dCGQjBWHd3gsTsUgxnjpcYRgjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c7SfZNtM; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C60B41FCE6;
	Mon, 14 Apr 2025 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744641796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5o38Y9e7Dfh+umbjH5JNjMMTlJ+9zJZPKhUxMqcsK8=;
	b=c7SfZNtMIchI44s0wBuBh8lsTT2nemY2tPm8/lf9jePpum7l6ThUZzimQwGm6bei5MaRDg
	sUzXLZyirdDpC0Gdewn5GE+1N4LEAW39JYeNTAVoq27026S3avNWbZ4XoqhApvT8LtyhoP
	jZoNQis5KxoXdsvQOyFrE2ndqoK+6SZ45SDdYeAa5yVENiBFVqFB2mQmRo1Qkri0ARqGIb
	KIaBoRUSyBoW17boW7Tgmsm7hDZl2psD98zbUKFS6OzUQ1acI2Th52EG1fxIOP0SXOc+JM
	vj4a0oDgSM4m+bV1vGFHiiKZVgXUot8o2m3pkOJDcIfAVpYeBXRbIbEoySYMjg==
Date: Mon, 14 Apr 2025 16:43:14 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next 3/5] net: phy: add Marvell PHY PTP support
Message-ID: <20250414164314.033a74d2@kmaincent-XPS-13-7390>
In-Reply-To: <E1u3Lta-000CP7-7r@rmk-PC.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
	<E1u3Lta-000CP7-7r@rmk-PC.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprhhmkhdokhgvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtt
 hhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 11 Apr 2025 22:26:42 +0100
Russell King <rmk+kernel@armlinux.org.uk> wrote:

> Add PTP basic support for Marvell 88E151x single port PHYs.  These
> PHYs support timestamping the egress and ingress of packets, but does
> not support any packet modification, nor do we support any filtering
> beyond selecting packets that the hardware recognises as PTP/802.1AS.
>=20
> The PHYs support hardware pins for providing an external clock for the
> TAI counter, and a separate pin that can be used for event capture or
> generation of a trigger (either a pulse or periodic). Only event
> capture is supported.
>=20
> We currently use a delayed work to poll for the timestamps which is
> far from ideal, but we also provide a function that can be called from
> an interrupt handler - which would be good to tie into the main Marvell
> PHY driver.
>=20
> The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> drivers. The hardware is very similar to the implementation found in
> the 88E6xxx DSA driver, but the access methods are very different,
> although it may be possible to create a library that both can use
> along with accessor functions.

It seems a lot less stable than the first version of the driver.

Lots of overrun:
ptp4l[949.894]: port 1 (eth0): assuming the grand master role
[  954.899275] Marvell 88E1510 ff0d0000.ethernet-ffffffff:01: tx timestamp =
overrun (stat=3D0x5 seq=3D0)
[  954.908670] Marvell 88E1510 ff0d0000.ethernet-ffffffff:01: rx timestamp =
overrun (q=3D1 stat=3D0x5 seq=3D0)

PTP L2 in master mode is not working at all maybe because there is no
configuration of PTP global config 1 register.

Faced also a case where it has really high offsets and I need to reboot the
board to see precise synchronization again:
ptp4l[4649.618]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
ptp4l[4652.519]: master offset 7650600217 s0 freq +32767998 path delay -339=
23681843
ptp4l[4653.487]: master offset 7617827584 s1 freq      +6 path delay -33923=
681843
ptp4l[4654.454]: master offset     -27201 s2 freq  -27195 path delay -33923=
681843
ptp4l[4654.454]: port 1: UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
ptp4l[4655.422]: master offset 33926879673 s2 freq +32767999 path delay -67=
850561538
ptp4l[4656.389]: master offset 33649307442 s2 freq +32767999 path delay -67=
605734496
ptp4l[4657.356]: master offset 33454635535 s2 freq +32767999 path delay -67=
443834753

The PTP set as master mode seems really buggy.

I will try to debug this!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

