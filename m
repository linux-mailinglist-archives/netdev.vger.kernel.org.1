Return-Path: <netdev+bounces-182151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DEDA8806A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8901773F0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A48C2BE7B8;
	Mon, 14 Apr 2025 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bVlGcrOe"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5EA27C873
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633994; cv=none; b=W/GZBdEHktt2tNs1jdjHvwztg5tftVmH5rWkXrmyQfCAFcCm6Z3089exYwxN+/4Hg5I5nWMvSwTha/ndTkNOBGEP4gE8KgdZz9jfDGh/9aBgnNbJRIYUxYtN64LSsVrLVuEcSTfPLiHPgBU7xdwxWnJ09fnZPf38m9YpADi3/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633994; c=relaxed/simple;
	bh=FZeS/h3jgsSAuNEmPfV0yQnTy2VP8xbcomatU1Yrcpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/VZSzd5IG49+5UoPsu/sVfYjAGJ7PdpKIghIBQpq3nGY2knRiUKLGHEulJKqiauOkZMg5isjF45znSJIpBXtNuOdSiLf8oxBj3P2QQKLQuFcgkG9/ig/zJhfbEM3EMjcNh2dzkgKaMvwkW0L5s+12ejj2RLS5jD90X6+8Ofjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bVlGcrOe; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB8B14398D;
	Mon, 14 Apr 2025 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744633988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9sEAzZyGQFJKmYMn6NJGzhn8gTDkwHmNnaJ6/pHCAo=;
	b=bVlGcrOeOrdvIA0CYNC6D57Fmyq0K3DZpf0yCK43Zf0GhsVdVRA28c5dOQOqVbNJYWTpOs
	Jh0P9zppLJcKdc7bkW8+ci990x6k+9akvCWrzXarZeJfydnFJLofoMb9fz86c7b2hE979q
	kVoMIJCorO4FAOz9ic0/zPqrnxf9b0t6b5AwMn6LfYDED9CpeS0D2gBZaYyfdkwx8oZUsI
	QRnwPMvCwXIXJj+93h/Msx5H2G3LeJayot9YnqK7jziykPbxzGYn1ssi4zOEB/EFkJ83T7
	KGhIdyvkCMzGdEKDLQNapCVsP6rITu2KwxJKzE+y73w+sHLy3MmUsQkL2FF0rw==
Date: Mon, 14 Apr 2025 14:33:06 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next 3/5] net: phy: add Marvell PHY PTP support
Message-ID: <20250414143306.036c1e2e@kmaincent-XPS-13-7390>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprhhmkhdokhgvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtt
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

I wanted to test it, but this patch does not build.

drivers/net/phy/marvell_ptp.c:269:33: error: passing argument 4 of =E2=80=
=98marvell_tai_probe=E2=80=99 from incompatible pointer type [-Werror=3Dinc=
ompatible-pointer-types]
  269 |                                 "Marvell PHY", dev);
      |                                 ^~~~~~~~~~~~~
      |                                 |
      |                                 char *
In file included from drivers/net/phy/marvell_ptp.c:9:
./include/linux/marvell_ptp.h:81:44: note: expected =E2=80=98struct ptp_pin=
_desc *=E2=80=99 but argument is of type =E2=80=98char *=E2=80=99
   81 |                       struct ptp_pin_desc *pin_config, int n_pins,
      |                       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
drivers/net/phy/marvell_ptp.c:269:48: warning: passing argument 5 of =E2=80=
=98marvell_tai_probe=E2=80=99 makes integer from pointer without a cast [-W=
int-conversion]
  269 |                                 "Marvell PHY", dev);
      |                                                ^~~
      |                                                |
      |                                                struct device *
In file included from drivers/net/phy/marvell_ptp.c:9:
./include/linux/marvell_ptp.h:81:60: note: expected =E2=80=98int=E2=80=99 b=
ut argument is of type =E2=80=98struct device *=E2=80=99
   81 |                       struct ptp_pin_desc *pin_config, int n_pins,
      |                                                        ~~~~^~~~~~
drivers/net/phy/marvell_ptp.c:267:15: error: too few arguments to function =
=E2=80=98marvell_tai_probe=E2=80=99
  267 |         err =3D marvell_tai_probe(&tai, &marvell_phy_ptp_ops,
      |               ^~~~~~~~~~~~~~~~~
In file included from drivers/net/phy/marvell_ptp.c:9:
./include/linux/marvell_ptp.h:78:5: note: declared here
   78 | int marvell_tai_probe(struct marvell_tai **taip,
      |     ^~~~~~~~~~~~~~~~~

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

