Return-Path: <netdev+bounces-52293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BFD7FE288
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 23:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7231C20A65
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E154CB43;
	Wed, 29 Nov 2023 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xwl0hT+Z"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419C7C1;
	Wed, 29 Nov 2023 14:00:40 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F05AFFF809;
	Wed, 29 Nov 2023 22:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701295239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNjLQPYU0Y0cmtZZUI0sl+DvPdmEpXuqt+dY1EeZ7k8=;
	b=Xwl0hT+Zp0aePF+NZGO+bwf3NrCp914pDUFQyo3fz5tB50UMSRBPWfkQ6HFrwMgDBeYFPk
	e3mveqQNL9444KwCqPPTLxlxuzxWDl0x2CJXBSRNe6A44Fa9x+vZRcPDJOtC2JakC4pgeS
	NCl+Wr7jp8Lyy4Lb7nLcOKzrRws9+CTcbKEjREYwfgkEFIF/JwavN+zYCjTRNgKnxUjn3+
	cPMfz8JhuQX9uDbARsc3OzsIsZ1ux04Z4xfgaTPClHYUAXhT1Tvh8QIRxeHbbuaC78iph8
	vl9urFj+N/wWOtmp2wcuJuvmDdp4arPKsPlGvIfrgFxm8IZwkYGjBKh1s7jT/g==
Date: Wed, 29 Nov 2023 23:00:34 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231129230034.7301d8b2@kmaincent-XPS-13-7390>
In-Reply-To: <20231129203700.ckpkc4r5bwwudwpf@skbuf>
References: <20231120121440.3274d44c@kmaincent-XPS-13-7390>
	<20231120120601.ondrhbkqpnaozl2q@skbuf>
	<20231120144929.3375317e@kmaincent-XPS-13-7390>
	<20231120142316.d2emoaqeej2pg4s3@skbuf>
	<20231120093723.4d88fb2a@kernel.org>
	<157c68b0-687e-4333-9d59-fad3f5032345@lunn.ch>
	<20231120105148.064dc4bd@kernel.org>
	<20231120195858.wpaymolv6ws4hntp@skbuf>
	<20231120134551.30d0306c@kernel.org>
	<20231129210959.19e1e2b7@kmaincent-XPS-13-7390>
	<20231129203700.ckpkc4r5bwwudwpf@skbuf>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 29 Nov 2023 22:37:00 +0200
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On Wed, Nov 29, 2023 at 09:09:59PM +0100, K=C3=B6ry Maincent wrote:
> > On Mon, 20 Nov 2023 13:45:51 -0800
> > Jakub Kicinski <kuba@kernel.org> wrote:

> > > Sounds reasonable. Having more attributes than just PHC index works.
> > > Given the lack of distinction between MAC and PHY for integrated NICs
> > > I'd lean towards ditching the "layers" completely and exposing=20
> > > an "approximate" vs "precise" boolean. Approximate being the DMA point
> > > for NICs, but more generically a point that is separated from the wire
> > > by buffering or other variable length delay. Precise =3D=3D IEEE 1588
> > > quality. =20
> >=20
> > Hello Jakub, just wondering.
> > I can add this hwtstamp provider qualifier in the next series version b=
ut it
> > won't be used as it is set and used at the driver level and no driver is
> > using it for now. It would not be accepted if I use something that is n=
ot
> > used, right? Do you still think I should add this in v8? =20
>=20
> Not sure why you say "not used", though. Are you not planning to expose
> the qualifier as an attribute to the listing of hwtstamp providers
> offered to user space by ETHTOOL_MSG_TSINFO_GET?

Yes I will, I was just saying that all the PHC would be set as precise for =
now.
Approximate timestamp quality won't be used because IIUC there are no NIC d=
river
supporting it yet.

> Personally, I worry that if the qualifier gets added later (not now) to
> the UAPI, we will end up having user space software (written now) that
> iterates through the provider listing thinking that there may only ever
> be one provider offered by one PHC, and will stop at the first such
> provider found, whichever that may be.
>=20
> With the added qualifier, there's a higher chance that user space
> searches will be for a {phc, qualifier} pair (even if there will only be
> 1 possible qualifier type), and the future addition of a new hwtstamp
> provider will keep existing software working in the same way as before,
> i.e. user space won't select the DMA provider by mistake, by ignoring
> the qualifier attribute altogether.
>=20
> Generally I'm against adding things upfront that can only be in a certain
> way, but in this case I believe that it is necessary in order for the
> future extensions that were discussed to be possible. The qualifier is
> part of the user space search key and thus pretty important.
>=20
> My 2 cents, Jakub can absolutely disagree.

Alright, this seems relevant.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

