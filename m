Return-Path: <netdev+bounces-197871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8EFADA185
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 12:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BBE3B1490
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 10:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AECF1FCFEE;
	Sun, 15 Jun 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSZsaBJH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC845C0B;
	Sun, 15 Jun 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749982411; cv=none; b=L5pbvOKF1THempCKEdjApkksLl/7zwhkCoCEK7iG+4QzeVtW4EB43QHI3moLiPlkwPEJHgTHqXBNDQohWB7BHuz6HXwD45qfHfHjQKH6AEUhQNj9oRHi3eGR+Xm+P6RIjCnu7ZyISc6QVK4SnP0o7koYh9mZMW4pCZERsytx9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749982411; c=relaxed/simple;
	bh=zKQku6o0q3P5txBFLBWiKo5vZY670ZgyClTPpDf7UPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRFyfsBE/VMgSH0esFY2HD8CDrrQw/oh+dpIILtxQYK7Wetzw8BWaXjBnwr8kVIKpTy3td6z+jgTs99TQtEAAAPMJqIsEHksuTigyoBatnok8p+LgI+lfyWB5cvP0evEghD12T7878uXFg18aLf8kQzl1fZ5/ajSNxD9XjUp0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSZsaBJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38415C4CEE3;
	Sun, 15 Jun 2025 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749982410;
	bh=zKQku6o0q3P5txBFLBWiKo5vZY670ZgyClTPpDf7UPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oSZsaBJH/SwcdVwN5JSUFt/uwKkNCS6OeUhMpChIg+g/2XonSDPRvp+sY/E9AQGdH
	 LPiPK4AyqVOLC802DHBeORVSqX75WeYJLhOPeiU8SpYpYlavEo9s+UMDgimcODNWdh
	 QycYFNr17FOIT8ruJ5EEBreENjAA/otDqruFOWJY1L+QTQUXUayU1pby9L7vxHqhaX
	 9XbZdzibohYDYRnaTPNCPJBb8MgF4wANCakWqZCFrvl+l4fdeP6InV/TLz1K4r5PBU
	 0XrOE94MrDy/+Mb3tnNcRgGpaiGlzarOl+7YBxZv/oMX8sTFuHH+1SdcxyEuZfd9g0
	 FdpnXndUwsuLg==
Date: Sun, 15 Jun 2025 12:13:28 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Frank Wunderlich (linux)" <linux@fw-web.de>
Cc: Daniel Golle <daniel@makrotopia.org>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2] net: ethernet: mtk_eth_soc: support named IRQs
Message-ID: <aE6cyHC39IV27PcF@lore-desk>
References: <20250615084521.32329-1-linux@fw-web.de>
 <aE6K-d0ttAnBzcNg@lore-desk>
 <d4781d559e3f72b0bcde88e6b04ed8e5@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oVrPlAnEQ6cDmmnL"
Content-Disposition: inline
In-Reply-To: <d4781d559e3f72b0bcde88e6b04ed8e5@fw-web.de>


--oVrPlAnEQ6cDmmnL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Am 2025-06-15 10:57, schrieb Lorenzo Bianconi:
> > > From: Frank Wunderlich <frank-w@public-files.de>
> > >=20
> > > Add named interrupts and keep index based fallback for exiting
> > > devicetrees.
> > >=20
> > > Currently only rx and tx IRQs are defined to be used with mt7988, but
> > > later extended with RSS/LRO support.
> > >=20
> > > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> >=20
> > Hi Frank,
> >=20
> > I guess my comments on v1 apply even in v2. Can you please take a look?

sure

>=20
> adding your comments (and mine as context) from v1 here:
>=20
> Am 2025-06-15 10:57, schrieb Lorenzo Bianconi:
> > > From: Frank Wunderlich <frank-w@public-files.de>
>=20
> > > I had to leave flow compatible with this:
> > >=20
> > > <https://github.com/frank-w/BPI-Router-Linux/blob/bd7e1983b9f0a69cf47=
cc9b9631138910d6c1d72/drivers/net/ethernet/mediatek/mtk_eth_soc.c#L5176>
> >=20
> > I guess the best would be to start from 0 even here (and wherever it is
> > necessary) and avoid reading current irq[0] since it is not actually
> > used for
> > !shared_int devices (e.g. MT7988).  Agree?
> >=20
> > >=20
> > > Here the irqs are taken from index 1 and 2 for
> > >  registration (!shared_int else only 0). So i avoided changing the
> > >  index,but yes index 0 is unset at this time.
> > >=20
> > > I guess the irq0 is not really used here...
> > > I tested the code on bpi-r4 and have traffic
> > >  rx+tx and no crash.
> > >  imho this field is not used on !shared_int
> > >  because other irq-handlers are used and
> > >  assigned in position above.
> >=20
> > agree. I have not reviewed the code in detail, but this is why
> > I think we can avoid reading it.
>=20
> i areee, but imho it should be a separate patch because these are 2
> different changes

I am fine to have it in a separate patch but I would prefer to have this pa=
tch
in the same series, I think it is more clear.

>=20
> > > It looks like the irq[0] is read before...there is a
> > >  message printed for mediatek frame engine
> > >  which uses index 0 and shows an irq 102 on
> > >  index way and 0 on named version...but the
> > >  102 in index way is not visible in /proc/interrupts.
> > > So imho this message is misleading.
> > >=20
> > > Intention for this patch is that irq 0 and 3 on
> > >  mt7988 (sdk) are reserved (0 is skipped on
> > > !shared_int and 3 never read) and should imho
> > >  not listed in devicetree. For further cleaner
> > >  devicetrees (with only needed irqs) and to
> > >  extend additional irqs for rss/lro imho irq
> > >  names make it better readable.
> >=20
> > Same here, if you are not listing them in the device tree, you can
> > remove them
> > in the driver too (and adjust the code to keep the backward
> > compatibility).
>=20
> afaik i have no SHARED_INT board (only mt7621, mt7628) so changing the
> index-logic will require testing on such boards too.

I think the change will not heavily impact SHARED_INT devices.

Regards,
Lorenzo

>=20
> i looked a bit into it and see mt7623 and mt7622 have 3 IRQs defined
> (!SHARED_INT) and i'm not 100% sure if the first is also skipped (as far =
as
> i understood code it should always be skipped).
>=20
> In the end i would change the irq-index part in separate patch once this =
is
> accepted to have clean changes and not mixing index with names (at least =
to
> allow a revert of second in case of regression).
>=20
> Am 2025-06-15 11:26, schrieb Daniel Golle:
> > In addition to Lorenzo's comment to reduce the array to the actually
> > used
> > IRQs, I think it would be nice to introduce precompiler macros for the
> > irq
> > array index, ie. once the array is reduce to size 2 it could be
> > something
> > like
> >=20
> > #define MTK_ETH_IRQ_SHARED 0
> > #define MTK_ETH_IRQ_TX 0
> > #define MTK_ETH_IRQ_RX 1
> > #define __MTK_ETH_IRQ_MAX MTK_ETH_IRQ_RX
> >=20
> > That would make all the IRQ code more readable than having to deal with
> > numerical values.
>=20
> makes sense, i will take this into the second patch.
>=20
> I hope you can agree my thoughts about not mixing these 2 parts :)
>=20
> regards Frank

--oVrPlAnEQ6cDmmnL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaE6cxwAKCRA6cBh0uS2t
rJJ0AQCF7N7EGGGmdCWiswfJnsbpS1FE5H/ZMgT6lUi1gJ/XqAD/YbauPgAy5ONu
BTFp/8Gr6q73o9av+Tuz8j8d7KQ6Mg4=
=tSdA
-----END PGP SIGNATURE-----

--oVrPlAnEQ6cDmmnL--

