Return-Path: <netdev+bounces-106575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC1D916DDA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2545B1F20F2F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875AF16F913;
	Tue, 25 Jun 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH4ljJVj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956814A0B8;
	Tue, 25 Jun 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332180; cv=none; b=fr1F+mU22GMQDdiiHYYWvhGw/OaygRNHoO/j61ilCA5sJxDdc90DvlnLDottiR71nhVkZdo71rOmlV2hmh+V/8I56f8LeLpUOK56rnad9QbvFCbCPuwvwGPgbYJisSmcfi3L2I5u/JOr1jf3+ExhCGdIsaKgFKNdLeuQ16/Ra4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332180; c=relaxed/simple;
	bh=1WVXoygUO2k28Qdke15vXqnojvrYTkH/M/tMYcvDbZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv4E639V/hR3N+VxmSzy2RIPqWC9STYdttDtYEbuYmQFbzQNJzD8wfhe1C2ORYQO5Qr9EOXX0RlcvIwggG0zRZVFGVQ1RcjHrHWaGX4XyS7bY491TuXju5mbfOrX5hgV5ObdcmbvCaxe/9jAC3I7AzthMV+bek9tremSvcHv+Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH4ljJVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925F2C32781;
	Tue, 25 Jun 2024 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719332179;
	bh=1WVXoygUO2k28Qdke15vXqnojvrYTkH/M/tMYcvDbZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MH4ljJVjO0hDppiYoO3Ajxdamtx2V5hR0j6h9kP7L3ZMFiT1oIAja7uu0eZknV8Xm
	 +nAg0KCl6DYiUKh//lTYuYyWjNGl1FKgtvL5fUlY1ALJ5hubRWHFekGQVwfV6O8zIC
	 MVt9kpIVL158Zf8Y8Q1f9gOYpKd98WSnSZAddFeeEr8byc5xDBzfITEbRO14dmWQOI
	 Gl1g86L4S0bsaMIwi5jrUkQVp4JP+2CLOkBt/yUrh0ne9tfrgzbS0N5ePb4MtO+M+q
	 k4CSz2yrqD0wm8U8h9ibgRHOCiqDitKrLFu3M+A6/f3XAmIXluMXZRcAssybE5bJ7L
	 slsk8fUTAApEA==
Date: Tue, 25 Jun 2024 17:16:13 +0100
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] dt-bindings: net: dsa: mediatek,mt7530: Minor grammar
 fixes
Message-ID: <20240625-surfboard-massive-65f7f1f61f0d@spud>
References: <20240624025812.1729229-1-chris.packham@alliedtelesis.co.nz>
 <704f4b95-2aed-4b76-87cb-83002698471c@arinc9.com>
 <20240624-radiance-untracked-29369921c468@spud>
 <68961d4f-10d8-4769-94d3-92ce709aa00a@arinc9.com>
 <20240624-supernova-obedient-3a2ba2a42188@spud>
 <a17f35ae-5376-458a-b7b5-9dbefd843b40@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eBPkurhNpOKh5uH9"
Content-Disposition: inline
In-Reply-To: <a17f35ae-5376-458a-b7b5-9dbefd843b40@arinc9.com>


--eBPkurhNpOKh5uH9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 08:11:10PM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> On 24/06/2024 20.02, Conor Dooley wrote:
> > On Mon, Jun 24, 2024 at 07:59:48PM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wro=
te:
> > > On 24/06/2024 19.29, Conor Dooley wrote:
> > > > On Mon, Jun 24, 2024 at 10:00:25AM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL=
 wrote:
> > > > > On 24/06/2024 05.58, Chris Packham wrote:
> >=20
> > > > > >       and the switch registers are directly mapped into SoC's m=
emory map rather than
> > > > > >       using MDIO. The DSA driver currently doesn't support MT76=
20 variants.
> > > > > >       There is only the standalone version of MT7531.
> > > > > > -  Port 5 on MT7530 has got various ways of configuration:
> > > > > > +  Port 5 on MT7530 supports various configurations:
> > > > >=20
> > > > > This is a rewrite, not a grammar fix.
> > > >=20
> > > > In both cases "has got" is clumsy wording,
> > >=20
> > > We don't use "have/has" on the other side of the Atlantic often.
> >=20
> > Uh, which side do you think I am from?
>=20
> Who would call it clumsy to use "have" and "got" together for possession.=
=2E.
> Must be an Irishman! :D

Okay, I was just making sure you weren't accusing me of being
American...

--eBPkurhNpOKh5uH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrtTQAKCRB4tDGHoIJi
0ogdAPsGgI16OjIEcRoR3/W3g7mWhBrsC6mYOu/EK0bHwPMgaAEA1ed2WNJBKEvH
EIhgp/sU0bgFgyUSln6h4c1Gh70zUA4=
=xwkj
-----END PGP SIGNATURE-----

--eBPkurhNpOKh5uH9--

