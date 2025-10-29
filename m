Return-Path: <netdev+bounces-234114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA70DC1CA15
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCECF4E1148
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7E83491F4;
	Wed, 29 Oct 2025 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2tj5JN3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB51DF271;
	Wed, 29 Oct 2025 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760497; cv=none; b=KERDGwmHBcExE++Uw+H/OtHQPDk3EzMrypDuVjOO7TNBQkliIZfS8b8IUYBXK03QxeRe4xmqfek3e9ur0CHRLNNANAn7a/PCGr3nUXZgtqO9pnsU8m3270L6PbQLXs8DUmgIER2Gys4UOVI7eIbwBAfxd2YnNn+5EkJBb6GUoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760497; c=relaxed/simple;
	bh=bCXLipd8jw4UWfF/s5HKsZqILEHRwryjypVy7tkLUjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE8hhSF6VjXj3UE8gGu0sTtWBR3mQErjtPDknQEHe0uyy/a1yF8OrTv6POX16q2y+TKBwdWV2BdOI0vuYl2Z9JyNk/1oHf7a1024ACHc7HABI9luhkbIdKa0UiqxlK2jMwA0Kpsnb2rQNT2aigIgSmveEik/dorqlAFnD1gm+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2tj5JN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99C8C4CEF7;
	Wed, 29 Oct 2025 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761760496;
	bh=bCXLipd8jw4UWfF/s5HKsZqILEHRwryjypVy7tkLUjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e2tj5JN387EOqfUzqfbcncN6EFYT4OwAISQxnGTNRwt+7QYfTddUa14wSsM/M0eA/
	 lY+4h6ETkKg7o3jpW85ZU0y2lae7avMVcvFP7v/SEFsbARyqbD0oNiAiLvpe1CYzaT
	 IuuzqvjzurbH11uNGwmCPkUZ546lWRVfgAUGPFrvFYOTckwvUFggfO++KsGCS+GWm1
	 /xbtIUCkwcQ31tp67OcF3lTVc55SJPPSso6hov6boz113Vahc+Jifr4Q5NNedVELLK
	 jLA5Jby4dX9uSizqMTZpb9knFrinWRP79P6aK0nswAcv++PSsewUjwlZK90MSo9Nlt
	 NG/j0vZNGZQHQ==
Date: Wed, 29 Oct 2025 17:54:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy
 mode restriction
Message-ID: <20251029-fading-expulsion-f0911c28d23d@spud>
References: <20251028003858.267040-1-inochiama@gmail.com>
 <20251028003858.267040-2-inochiama@gmail.com>
 <20251028-parka-proud-265e5b342b8e@spud>
 <rclupbdjyk67fee2lgf74k6tkf7mnjcxzwcjvyk2bohgpetqt5@toxvy3m5orm2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xiR9j6m1veV/qNYv"
Content-Disposition: inline
In-Reply-To: <rclupbdjyk67fee2lgf74k6tkf7mnjcxzwcjvyk2bohgpetqt5@toxvy3m5orm2>


--xiR9j6m1veV/qNYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 08:56:09AM +0800, Inochi Amaoto wrote:
> On Tue, Oct 28, 2025 at 07:22:37PM +0000, Conor Dooley wrote:
> > On Tue, Oct 28, 2025 at 08:38:56AM +0800, Inochi Amaoto wrote:
> > > As the ethernet controller of SG2044 and SG2042 only supports
> > > RGMII phy. Add phy-mode property to restrict the value.
> > >=20
> > > Also, since SG2042 has internal rx delay in its mac, make
> > > only "rgmii-txid" and "rgmii-id" valid for phy-mode.
> >=20
> > Should this have a fixes tag?
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
>=20
> Although I add a fixes tag to the driver, I am not sure whether the
> binding requires it. But if it is required, I think it should be

Kinda depends for bindings, amending a binding for completeness probably
doesn't need one but amending it to actually permit a functional
configuration does. This is somewhere in-between I suppose. If a driver
change is coming along with it which is likely to be backported, that'd
be a vote in favour of a fixes tag here too, so that the binding and
driver match in stable.

>=20
> Fixes: e281c48a7336 ("dt-bindings: net: sophgo,sg2044-dwmac: Add support =
for Sophgo SG2042 dwmac")
>=20
> > >=20
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > ---
> > >  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 20 +++++++++++++++++=
++
> > >  1 file changed, 20 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwma=
c.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > > index ce21979a2d9a..916ef8f4838a 100644
> > > --- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > > +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > > @@ -70,6 +70,26 @@ required:
> > > =20
> > >  allOf:
> > >    - $ref: snps,dwmac.yaml#
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: sophgo,sg2042-dwmac
> > > +    then:
> > > +      properties:
> > > +        phy-mode:
> > > +          enum:
> > > +            - rgmii-txid
> > > +            - rgmii-id
> > > +    else:
> > > +      properties:
> > > +        phy-mode:
> > > +          enum:
> > > +            - rgmii
> > > +            - rgmii-rxid
> > > +            - rgmii-txid
> > > +            - rgmii-id
> > > +
> > > =20
> > >  unevaluatedProperties: false
> > > =20
> > > --=20
> > > 2.51.1
> > >=20
>=20
>=20

--xiR9j6m1veV/qNYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJU6QAKCRB4tDGHoIJi
0r18AP9YHrFoYXPV2dEPqru+c49A0QRQ0TNcKAkMQ1H/ppaEYgD9FQ3HpD0h2vUk
e+BRSTPq5uaZbxl+044FWdyYYKRVCQE=
=moFb
-----END PGP SIGNATURE-----

--xiR9j6m1veV/qNYv--

