Return-Path: <netdev+bounces-182345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8419A88858
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FA2162F4C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D92267395;
	Mon, 14 Apr 2025 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lgPaZwzr"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4D42581
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647409; cv=none; b=VkwDOLEs4QIjRZD6Ok0w412y6bYr3ob3ULap2y0boRI7P1JcuHILAHZDjUI4Jswb44jFfFbGXCAWDuBM/P5bdY7rogxQK7upywI6puJ+7R4NtVcBVY+zgx5Z18Zq9+vxGpBO68HwRZ+fGR5HBOHUuVobc7VKHQhz1ybK+lCDT40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647409; c=relaxed/simple;
	bh=FcWqqM7Hu8kFvxsSsdpPS1AYE/+nQNBgeuGVkDYCMc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nvjui+vE83jGylKPX1PsFqaWu/mFfSFP2rzcvU9J0SJ+FLZjW+OMCWbbMly59tDf/ULzLAzLeTclygxpWmYDXseEDn+kQ9lasWo7MUzbAqTjX8psHKxzRDR4jtygdajiOOKjB42n44trqG/5XUxrL9JeAAJ74QbobEgvNmDrD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lgPaZwzr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8462D4384E;
	Mon, 14 Apr 2025 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744647405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMO4NDkskBv2rK2IcoJSv2ck3O6X7RPBqbbgLTi5vCo=;
	b=lgPaZwzr1kYTUxUWBb7L5FPER1iOzhrp9zGjVnWaFI7GOMgZY72W6gfs1pgGUNNSfX53kW
	mr/MpMvjtoNvJrcoMzgec+7EYmGQv/s9jeSeriBy73Jf5VNP5v4ojum5D+5NRQQh+WyN6k
	rbAWGROuOG4ZJskKjf9rA4EAuu/EH6f+J2Ew6sXMMMp5mu47JgEydHP73DqwhxTd5MK2/8
	ArzjRHSRPJDiUQafSI+z4tSxg3C3SpzqoHDD7woLvbv1MdNwn2xHhTGDxD7kQKUR9mEHHk
	H5VQggYo1sz6xzuc9jCUPXmT8gIV5OrP9FQSZcw6FDlf1uiNC3kzE8fC339iNA==
Date: Mon, 14 Apr 2025 18:16:43 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next 3/5] net: phy: add Marvell PHY PTP support
Message-ID: <20250414181643.7eca2d2c@kmaincent-XPS-13-7390>
In-Reply-To: <20250414172137.42e98e29@kmaincent-XPS-13-7390>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
	<E1u3Lta-000CP7-7r@rmk-PC.armlinux.org.uk>
	<20250414164314.033a74d2@kmaincent-XPS-13-7390>
	<Z_0hzd7Bl6ECzyBB@shell.armlinux.org.uk>
	<20250414172137.42e98e29@kmaincent-XPS-13-7390>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddutdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 14 Apr 2025 17:21:37 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Mon, 14 Apr 2025 15:55:09 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>=20
> > On Mon, Apr 14, 2025 at 04:43:14PM +0200, Kory Maincent wrote: =20
> > > On Fri, 11 Apr 2025 22:26:42 +0100
> > > Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > >    =20
>  [...] =20
> > >=20
> > > It seems a lot less stable than the first version of the driver.

FYI there is also an invalid wait context error:
[   65.041285] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   65.045286] [ BUG: Invalid wait context ]
[   65.049289] 6.14.0-13314-g04846c13cbec-dirty #91 Not tainted
[   65.054938] -----------------------------
[   65.058939] swapper/0/0 is trying to lock:
[   65.063028] ffff000805b0c110 (&rxq->rx_mutex){....}-{4:4}, at:
marvell_ptp_rxtstamp+0xf0/0x228=20
[   65.071665] other info that might help us debug this:=20
[   65.076707] context-{3:3}
[   65.079320] no locks held by swapper/0/0.
[   65.083321] stack backtrace:
[   65.086198] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
6.14.0-13314-g04846c13cbec-dirty #91 PREEMPT(voluntary)
[   65.086207] Hardware name: Fluyt Prototype 1 Carrier Board ZU9 mpsoc  (D=
T)
[   65.086211] Call trace:=20
[   65.086214]  show_stack+0x18/0x24 (C)
[   65.086224]  dump_stack_lvl+0xa4/0xf4
[   65.086233]  dump_stack+0x18/0x24
[   65.086240]  __lock_acquire+0xa14/0x2000
[   65.086250]  lock_acquire+0x1c4/0x360
[   65.086259]  __mutex_lock+0xa0/0x52c
[   65.086266]  mutex_lock_nested+0x24/0x30
[   65.086273]  marvell_ptp_rxtstamp+0xf0/0x228
[   65.086282]  marvell_phy_ptp_rxtstamp+0x18/0x24
[   65.086290]  skb_defer_rx_timestamp+0x104/0x31c

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

