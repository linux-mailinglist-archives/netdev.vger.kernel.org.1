Return-Path: <netdev+bounces-238546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B227C5AE94
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CF9334BC05
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191DD239E8D;
	Fri, 14 Nov 2025 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z09gLaMZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F027456;
	Fri, 14 Nov 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763083541; cv=none; b=cGmblz9YLFZI+wngC4lC95QQiZTH5n1HzNO+0QhRDQpZql1kPLVpjMRpKLOK3fFoI7tJ3OSo79oae+iHGyi2soVj8PQ7D4flPFHoqQUFFlJPXodh0Ga8SwIa4Pp4FFpWmupUc/ufddyvoII8CSIWWc708pIHqRiiSj6VAm/088A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763083541; c=relaxed/simple;
	bh=jUpqsgzm9mQmlDwIMnmXwws2iJVd0X9NrGflGeH7Iqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHJLqoLtxrWqNMLFBEXrgYwyjNCt3dZnqK6D5ZnVoV6QVYzQ62faAqcqdqNHGmkWr8DvvRLeJxRd3nheM6x/nQ3ZXUi8gbjZbf8kEdHFSbH+6u4CZMGDLrvy6YnkQq5Sq9Si0m5cB9snXJUUhSiw3B/xMwHLIZTjmYhgCpg0aEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z09gLaMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67573C2BCB0;
	Fri, 14 Nov 2025 01:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763083540;
	bh=jUpqsgzm9mQmlDwIMnmXwws2iJVd0X9NrGflGeH7Iqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z09gLaMZlZrJHbraZakAvPZQ2kqgik/E3cfI2zd2AjI6xpvGjYqFZURz2b+UzBcTc
	 8SwRLAul1ddhZmoa7yCwX9IFyPmrEIhWuLBuE4sFEpMh/Xj2ayDrZBOlDWhT8JFLCn
	 K8AAzeBFl1lClijNSqUnLKDYyGpjtc9SHPUCKg3gZQchcPRcFs1kpedjTT0p80gN33
	 nBZ3PHgGXXwZFMdtT0BOjlUvnj/c7xeVt5LlNIMMGA7Rv/7IaPLQFA1I2DV7S1aZEx
	 +YQAP3xbmuM/xOibvOJvy24sED0Q4VX4dZwkiNH1jFlFvXA+HctaCLc3x8eQyQz83/
	 u7OWf0KRaOl4w==
Date: Fri, 14 Nov 2025 01:25:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy
 mode restriction
Message-ID: <20251114-apache-sprung-f1a29b873696@spud>
References: <20251114003805.494387-1-inochiama@gmail.com>
 <20251114003805.494387-2-inochiama@gmail.com>
 <yjl3gnf2gwh327wbbwcbkxwnqy5tyhwutffovlxhcm7b4vr2xu@he4tg6bcrduu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NIRjo9fMfQbx0LeW"
Content-Disposition: inline
In-Reply-To: <yjl3gnf2gwh327wbbwcbkxwnqy5tyhwutffovlxhcm7b4vr2xu@he4tg6bcrduu>


--NIRjo9fMfQbx0LeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 08:44:15AM +0800, Inochi Amaoto wrote:
> On Fri, Nov 14, 2025 at 08:38:03AM +0800, Inochi Amaoto wrote:
> > As the ethernet controller of SG2044 and SG2042 only supports
> > RGMII phy. Add phy-mode property to restrict the value.
> >=20
> > Also, since SG2042 has internal rx delay in its mac, make
> > only "rgmii-txid" and "rgmii-id" valid for phy-mode.
> >=20
> > Fixes: e281c48a7336 ("dt-bindings: net: sophgo,sg2044-dwmac: Add suppor=
t for Sophgo SG2042 dwmac")
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> > ---
> >  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.=
yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > index ce21979a2d9a..e8d3814db0e9 100644
> > --- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > @@ -70,6 +70,25 @@ required:
> > =20
> >  allOf:
> >    - $ref: snps,dwmac.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: sophgo,sg2042-dwmac
> > +    then:
> > +      properties:
> > +        phy-mode:
> > +          enum:
>=20
> > +            - rgmii-rxid
> > +            - rgmii-id
>=20
> Hi, Conor,
>=20
> I have restricted the phy-mode with wrong mode here, it should be
> rgmii-rxid instead of rgmii-txid as the SG2042 always add rx delay
> in their mac. As this is more like a mistake for me when writing
> the binding, I keep you tag with the fix. If you need something
> further, please let me know.

Yeah that's fine chief. In general, if it is some hardware detail
that I couldn't possibly know was correct or incorrect without
reading the device's documentation then I probably don't care about
the binding change required for it when it's so minimal. Probably the
same goes for Rob and Krzysztof.

--NIRjo9fMfQbx0LeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRaFDAAKCRB4tDGHoIJi
0sHeAQCiwuHrj6CHOoRLG+GG2NyvoAYv/ledOLpXXMp9wFne6AD/ac6tU8Z1tAkf
gGLcZaOgphtF9IndUwUcVjxW0F1kDAM=
=Gnn9
-----END PGP SIGNATURE-----

--NIRjo9fMfQbx0LeW--

