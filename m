Return-Path: <netdev+bounces-138777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548239AED11
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 19:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A99B229CB
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7231F9EA5;
	Thu, 24 Oct 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBaqX6iQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C69C19DF7A;
	Thu, 24 Oct 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789478; cv=none; b=pZDb8QP2b0KlwSJ0FxololysmradOw+JC0o74id/OkqN9JsYlzONeKOjVBiE/T3vcPw8daaibBlrVxuGPW19fwr/tF8Ea0eYA1Izn5/1i/RSS5y0Kb4dCmkoMW+L86Z7mAx1qTvxZYLXz0VbIZg8oRUHobxp8FMuepgMmb0vri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789478; c=relaxed/simple;
	bh=ywLWv1DymM9Q8rNWDVKF/A2+zd9RhYsw+C3ioFEB2fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ST7Uw7LDMd7o5huUKUTvxuu4DnyIVwRCAikx21QdIC83RgoSdQEgJh8028dIF30mVdc6IXCVA9WS81Hb7YUl4xiBxD8Q39yR/hwi+H0Quj9ABovri3eRjZwGDYsH3D4MNVuFDODSBtoPMvgdeYxGc4qoSsTq7Ct6ggCfkW1nDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBaqX6iQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29819C4CEC7;
	Thu, 24 Oct 2024 17:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729789478;
	bh=ywLWv1DymM9Q8rNWDVKF/A2+zd9RhYsw+C3ioFEB2fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dBaqX6iQKVO2I3p6DrGwLpuLJB3LSA0XH7X+UprC50IkkggRW+Y2RLdcIiDwDCh1X
	 k+uJyk8o/qqWWHi++gPxZfzbD15LyxpL7tsAN911NmSofjDWqtsMyWrv9j8+PQ/chd
	 KKLAcTKow+XkNETi9/tPj7EgkZb4/bv4CB27O4p8I8fTzDI6cgXZ9K8Uy1q3PbZJgY
	 NDAPrF/8A+KBJZchG6LgnkuCzfmc7S2vi96lqSFyQsbJKNlo6Orqoj44edCGXhcRbv
	 duePaGbfb7zsTbuX4hn7EHv1IC6gyoJce7RQg5U1tvB2KYrPrVUH2+ag7ZbxPjeP1M
	 FygRhSMkxMAiw==
Date: Thu, 24 Oct 2024 18:04:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: net: Add support for Sophgo SG2044 dwmac
Message-ID: <20241024-wad-dusk-3d49f9ac4dff@spud>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-3-inochiama@gmail.com>
 <20241022-crisply-brute-45f98632ef78@spud>
 <yt2idyivivcxctosec3lwkjbmr4tmctbs4viefxsuqlsvihdeh@alya6g27625l>
 <20241023-paper-crease-befa8239f7f0@spud>
 <5cv7wcdddxa4ruggrk36cwaquo5srcrjqqwefqzcju2s3yhl73@ekpyw6zrpfug>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r+PW8kyxnTDRk3Vc"
Content-Disposition: inline
In-Reply-To: <5cv7wcdddxa4ruggrk36cwaquo5srcrjqqwefqzcju2s3yhl73@ekpyw6zrpfug>


--r+PW8kyxnTDRk3Vc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 06:38:29AM +0800, Inochi Amaoto wrote:
> On Wed, Oct 23, 2024 at 09:49:34PM +0100, Conor Dooley wrote:
> > On Wed, Oct 23, 2024 at 08:31:24AM +0800, Inochi Amaoto wrote:
> > > On Tue, Oct 22, 2024 at 06:28:06PM +0100, Conor Dooley wrote:
> > > > On Mon, Oct 21, 2024 at 06:36:15PM +0800, Inochi Amaoto wrote:
> > > > > The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
> > > > > with some extra clock.
> > > > >=20
> > > > > Add necessary compatible string for this device.
> > > > >=20
> > > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > > ---
> > > > >  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
> > > > >  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 145 ++++++++++++=
++++++
> > > > >  2 files changed, 146 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/net/sophgo,=
sg2044-dwmac.yaml
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yam=
l b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > > index 3c4007cb65f8..69f6bb36970b 100644
> > > > > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > > @@ -99,6 +99,7 @@ properties:
> > > > >          - snps,dwmac-5.30a
> > > > >          - snps,dwxgmac
> > > > >          - snps,dwxgmac-2.10
> > > > > +        - sophgo,sg2044-dwmac
> > > > >          - starfive,jh7100-dwmac
> > > > >          - starfive,jh7110-dwmac
> > > > > =20
> > > > > diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-=
dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..93c41550b0b6
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.y=
aml
> > > > > @@ -0,0 +1,145 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/net/sophgo,sg2044-dwmac.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: StarFive JH7110 DWMAC glue layer
> > > > > +
> > > > > +maintainers:
> > > > > +  - Inochi Amaoto <inochiama@gmail.com>
> > > > > +
> > > > > +select:
> > > > > +  properties:
> > > > > +    compatible:
> > > > > +      contains:
> > > > > +        enum:
> > > > > +          - sophgo,sg2044-dwmac
> > > > > +  required:
> > > > > +    - compatible
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    items:
> > > > > +      - const: sophgo,sg2044-dwmac
> > > > > +      - const: snps,dwmac-5.30a
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  clocks:
> > > > > +    items:
> > > > > +      - description: GMAC main clock
> > > > > +      - description: PTP clock
> > > > > +      - description: TX clock
> > > > > +
> > > > > +  clock-names:
> > > > > +    items:
> > > > > +      - const: stmmaceth
> > > > > +      - const: ptp_ref
> > > > > +      - const: tx
> > > > > +
> > > > > +  sophgo,syscon:
> > > >=20
> > > > How many dwmac instances does the sg2044 have?
> > > >=20
> > >=20
> > > Only one, there is another 100G dwxgmac instance, but it does not
> > > use this syscon.
> >=20
> > That dwxgmac is a different device, with a different compatible etc?
>=20
> Yes, it needs a different compatiable, and maybe a new binding is needed
> since the 100G and 1G IP are different.

In that case, you don't /need/ a syscon property at all, much less one
with offsets. You can just look up the syscon by compatible and hard
code the offset in the driver.

--r+PW8kyxnTDRk3Vc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxp+HgAKCRB4tDGHoIJi
0mRYAQC5zNH78v/p+H9bscKX2XQ4j6+YJ0OaAX6+AvjpwXd/WAEAzV4GkyhyPnWN
1Bs5WxGAGbqBkGnxejt/DzUIguij7wc=
=/5rz
-----END PGP SIGNATURE-----

--r+PW8kyxnTDRk3Vc--

