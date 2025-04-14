Return-Path: <netdev+bounces-182279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F53A88687
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D411440F4A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D971733997;
	Mon, 14 Apr 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V+xjMWrr"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80A25229A
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642947; cv=none; b=rP+eGwPLQidCoFS9S7AxH9BuVypo15gQ1pvMx7OXWVSKVpGRdLYFGLuxU6lyGop8GaTPLOh8mTRH8KYvxX+8H8+W4JtaWfwdU3tK3jMpxMioBIImHQeghF3TwNpn0CfxnbCYRVouHJR6igidV19TQ37acaxsKcYgM45kKyRHn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642947; c=relaxed/simple;
	bh=5666ktgCYh1TrlmXygnDeCXSRYrhBnrn01gMw7cMnjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHADvxE47wvzsipQ9y9NNKAxcVblRcVOWceeHEwKBzsARBM1gYzpTKqidR+INqxjNiUQ++0F1pNQx9n6M1/jdPKMbOURS7fo2l1i4oOm8lLYvwcGMvqF/PygxysMbpcYQIWmGEk/2y5rasH4Aa6Iq59aiqheq97MCaJ6QCCg9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V+xjMWrr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 610B3439BF;
	Mon, 14 Apr 2025 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744642938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wl9HVA+hKl2CKwKYgpEFXzPGor7X7LW2dsckrfug9iw=;
	b=V+xjMWrrNI0FEPc6pFDQNrv/Ccy3IeuFdim0phjGzOxhDBwL4V4zH5jdGqyhnGm5beZL0B
	0aT6+YF/bMej89P5jQzi1nSspOfnM44DRIR2KaeiDRLOHhXWUU83CFaXpB/CRZAJMJR0iP
	nAq9teUVIcbB4bjInYODvl0jnN33Oxfj9OEgKyHRuVORv0A3Dk3+k2ZhmB0u+ex78oZgEn
	MOyJ+9L1J+outsyZplESfeDKbZg2Fpe2s7k+UGoAcpssRzKw84YxW3RRDXvycPXceJkiyr
	n4KnZNvJapfLZ2BgOFnkHAuwcBj6PVf8m8QY1uVWdggyEOAnZ9S+A49sooArVg==
Date: Mon, 14 Apr 2025 17:02:15 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 1/5] net: mvpp2: add support for hardware
 timestamps
Message-ID: <20250414170215.4b94c934@kmaincent-XPS-13-7390>
In-Reply-To: <Z_0fCjkiry0AKS7j@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
	<E1u3LtP-000COv-Ut@rmk-PC.armlinux.org.uk>
	<20250414145150.63b29770@kmaincent-XPS-13-7390>
	<Z_0fCjkiry0AKS7j@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepu
 ggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtghinhdrshdrfihojhhtrghssehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 14 Apr 2025 15:43:22 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Apr 14, 2025 at 02:51:50PM +0200, Kory Maincent wrote:
> > On Fri, 11 Apr 2025 22:26:31 +0100
> > Russell King <rmk+kernel@armlinux.org.uk> wrote:
> >  =20
> > > Add support for hardware timestamps in (e.g.) the PHY by calling
> > > skb_tx_timestamp() as close as reasonably possible to the point that
> > > the hardware is instructed to send the queued packets.
> > >=20
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk> =20
> >=20
> > Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> >  =20
> > > ---
> > >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c index
> > > 416a926a8281..e3f8aa139d1e 100644 ---
> > > a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c +++
> > > b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c @@ -4439,6 +4439,8 =
@@
> > > static netdev_tx_t mvpp2_tx(struct sk_buff *skb, struct net_device *d=
ev)
> > > txq_pcpu->count +=3D frags; aggr_txq->count +=3D frags;
> > > =20
> > > +		skb_tx_timestamp(skb);
> > > +
> > >  		/* Enable transmit */
> > >  		wmb();
> > >  		mvpp2_aggr_txq_pend_desc_add(port, frags); =20
> >=20
> > Small question for my curiosity here. Shouldn't we move the
> > skb_tx_timestamp() call after the memory barrier for a better precision=
 or
> > is it negligible? =20
>=20
> Depends what the wmb() is there for, which is entirely undocumented.
>=20
> mvpp2_aggr_txq_pend_desc_add() uses writel(), which is itself required
> to ensure that writes to memory before the writel() occurs are visible
> to DMA agents. So, the wmb() there shouldn't be necessary if all
> that's going on here is to ensure that the packet is visible to the
> buffer manager hardware.
>=20
> On arm64, that's __io_wmb(), which becomes __dma_wmb() and ultimately
> "dmb oshst". wmb() on the other hand is a heavier barrier, "dsb st".
> This driver ends up doing both, inexplicably.

Indeed and that is the same case for all the wmb() call in that file.=20
Not sure two consecutive memory barrier are useful here, indeed a bit of doc
would have been great!
Thanks!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

