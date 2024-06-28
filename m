Return-Path: <netdev+bounces-107763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FEE91C3F4
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014791F2140D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1223E1C9ED9;
	Fri, 28 Jun 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTdsSCmp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2B51BE87E;
	Fri, 28 Jun 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592987; cv=none; b=lY5g++lUCW5HWTp05jnm+IzmSiXdJMsQ3k+blKhcKDdfW1W78sYjqKdvg5Gw33P8WSpUepCwNyCL7eAS+ea7TB78S83wPUJWSUmnXs2cRXV/husNpSntlBaw1HgAurCmieRJ3Ux4u7GZDZM+yIwPCW7FUL7EvIoblk/mC+UUi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592987; c=relaxed/simple;
	bh=/k1CPyU+XO2vXsbEnUV0QGlSHspgxIC0z5i/wwJgdsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DisBPNiDHq9Evkuwk86+TxbWR5Rqrf3TteycVbxrhF+wOOkPBieWf8Ve3JDfAZ4i+CoP0aeZ3WHA3jsWt9ZMn2In1N5Qv0HFjKDrXuKjDReurLHRebadYBAyF5VQmCcM9vrJeACPgauD2XsDiBEeB/AoDaQtH6ak4Pmpv49K4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTdsSCmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC1FC116B1;
	Fri, 28 Jun 2024 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719592986;
	bh=/k1CPyU+XO2vXsbEnUV0QGlSHspgxIC0z5i/wwJgdsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTdsSCmp/RV3A0DWzYJo5AY5jA6vTjzSmfYAvRAmsjcejNx+rZ5x209iqIc4/hpSo
	 j3QbrCS5MLZ2CsJIVid/k4a6xgeb6lqe04SheFd78mUZ8MU31dj6oOUbCQP3lm/vTH
	 yviwXfPLD4odoqzN9OUcNaxPvQklUukKh7r3jKDd1Dxnf1Utl8c09LnN4+gUzndEmv
	 XfayDPc4WE7vMMIkY3Ea5q4/IqxQhne4bOKB/HtMAaXbJsZR4nFcWosgsTprm8pqAJ
	 hqJwVXZCIxEE+UtLXksaioXvIBQi7pVOnIARt5FNSX6xpydywhJKpB1hhskB0Cw0/X
	 mJjfAh/GBjgYQ==
Date: Fri, 28 Jun 2024 17:42:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/10] dt-bindings: net: Add Synopsys DW xPCS
 bindings
Message-ID: <20240628-ovary-bucket-3d23c67c82ed@spud>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
 <20240627004142.8106-7-fancer.lancer@gmail.com>
 <20240627-hurry-gills-19a2496797f3@spud>
 <e5mqaztxz62b7jktr47mojjrz7ht5m4ou4mqsxtozpp3xba7e4@uh7v5zn2pbn2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BMxyj/+lWel1Q7do"
Content-Disposition: inline
In-Reply-To: <e5mqaztxz62b7jktr47mojjrz7ht5m4ou4mqsxtozpp3xba7e4@uh7v5zn2pbn2>


--BMxyj/+lWel1Q7do
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 08:10:48PM +0300, Serge Semin wrote:
> On Thu, Jun 27, 2024 at 04:51:22PM +0100, Conor Dooley wrote:
> > On Thu, Jun 27, 2024 at 03:41:26AM +0300, Serge Semin wrote:
> > > +  clocks:
> > > +    description:
> > > +      Both MCI and APB3 interfaces are supposed to be equipped with =
a clock
> > > +      source connected via the clk_csr_i line.
> > > +
> > > +      PCS/PMA layer can be clocked by an internal reference clock so=
urce
> > > +      (phyN_core_refclk) or by an externally connected (phyN_pad_ref=
clk) clock
> > > +      generator. Both clocks can be supplied at a time.
> > > +    minItems: 1
> > > +    maxItems: 3
> > > +
> > > +  clock-names:
> > > +    oneOf:
> > > +      - minItems: 1
> > > +        items:
> > > +          - enum: [core, pad]
> > > +          - const: pad
> > > +      - minItems: 1
> > > +        items:
> > > +          - const: pclk
> > > +          - enum: [core, pad]
> > > +          - const: pad
> >=20
>=20
> > While reading this, I'm kinda struggling to map "clk_csr_i" to a clock
> > name. Is that pclk? And why pclk if it is connected to "clk_csr_i"?
>=20
> Right. It's "pclk". The reason of using the "pclk" name is that it has
> turned to be a de-facto standard name in the DT-bindings for the
> peripheral bus clock sources utilized for the CSR-space IO buses.
> Moreover the STMMAC driver responsible for the parental DW *MAC
> devices handling also has the "pclk" name utilized for the clk_csr_i
> signal. So using the "pclk" name in the tightly coupled devices (MAC
> and PCS) for the same signal seemed a good idea.
>=20
> > If two interfaces are meant to be "equipped" with that clock, how come
> > it is optional? I'm probably missing something...
>=20
> MCI and APB3 interfaces are basically the same from the bindings
> pointer of view. Both of them can be utilized for the DW XPCS
> installed on the SoC system bus, so the device could be accessed using
> the simple MMIO ops.
>=20
> The first "clock-names" schema is meant to be applied on the DW XPCS
> accessible over an _MDIO_ bus, which obviously doesn't have any
> special CSR IO bus. In that case the DW XPCS device is supposed to be
> defined as a subnode of the MDIO-bus DT-node.
>=20
> The second "clock-names" constraint is supposed to be applied to the
> DW XPCS synthesized with the MCI/APB3 CSRs IO interface. The device in
> that case should be defined in the DT source file as a normal memory
> mapped device.
>=20
> >=20
> > Otherwise this binding looks fine to me.
>=20
> Shall I add a note to the clock description that the "clk_csr_i"
> signal is named as "pclk"? I'll need to resubmit the series anyway.

Better yet, could you mention MDIO? It wasn't clear to me (but I'm just
reviewing bindings not a dwmac-ist) that MCI and APB3 were only two of
the options and that the first clock-names was for MDIO. Maybe something
like:

  clock-names:
    oneOf:
      - minItems: 1
        items: # MDIO
          - enum: [core, pad]
          - const: pad
      - minItems: 1
        items: # MCI or APB
          - const: pclk
          - enum: [core, pad]
          - const: pad

--BMxyj/+lWel1Q7do
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn7oEgAKCRB4tDGHoIJi
0vUkAP91mL5HozxNT6oDCThjtd+7mltthe8Q+r0IJLYFCEMEEgEAma2+j1iod5gj
qAd6c89tOFymOHfSWvAKjyGEyH9YZwE=
=8AMU
-----END PGP SIGNATURE-----

--BMxyj/+lWel1Q7do--

