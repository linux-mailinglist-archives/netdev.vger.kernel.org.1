Return-Path: <netdev+bounces-121110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AC295BB7F
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763C1286ECE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247431CCEDD;
	Thu, 22 Aug 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkvMUXwx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D21CCEC2;
	Thu, 22 Aug 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343252; cv=none; b=u/MS2qJ1u6HbcLG1zGnOvnXDdBRzAnoUYTD3gy1dfn9zC09TBlIqeU8gG4uOMHmjpVlxTtSloy/hNxlCoklOd7FCSJwWU5Qif9U+3WE3hkFEiIobL8HvW8Y+b47cE1nPOBSOhsY0O7aTpyRH2ql8XREI449Fb0/V2G4jPhHsuhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343252; c=relaxed/simple;
	bh=vJBuL2L7n5w/avABxl53Lo0I7jmSTtK6MiCSsu4B+m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDxksFgQGNJn3qY/VduxyR6AkSqlYvBde4u0jQPa+fhDmGgQXelMyN9NSZKmKB8/jswyoCwKYqvGmMjvVD1ZNZdJrBum76APaNKCMq4uewZXGiDTXd0koYsAJP7S7IUYcwQV28fkWvrapSEuPTE6+CjUF71StbTL6jT9GDZ+R54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkvMUXwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FB6C32782;
	Thu, 22 Aug 2024 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724343251;
	bh=vJBuL2L7n5w/avABxl53Lo0I7jmSTtK6MiCSsu4B+m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZkvMUXwxEQA91o7CEOpB5EOZL3pdspEjmL+OjzFSAOkWgB+7ZvB3AZiAYf5/rEuoP
	 6BXeg0FiDixhm+UyZ2+XZDWHhDCPkJdYS0OTjazTR3ULBnYLz0LcU6GHoXhxX0/0bj
	 ORonL+TpBzy5qrMuKRJBweo6t59gRsW7/nL0X8mxsKkfWunnY1hMeNqilSTE2ftKkr
	 n4+hUkE+zPkQUsqqVZ4YBpZkjUbYXOgd4RNhmTp+eL30fubz49FvZdmb6z8GY/aSoo
	 KChGm/rwEg1SnJirBn97BmkNnktVF3t0VFxGM61uL7MUq9G1mwUpHjpzuzmEkmJdrc
	 ocZheuTc+JwNQ==
Date: Thu, 22 Aug 2024 17:14:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 2/3] net: phy: tja11xx: replace
 "nxp,rmii-refclk-in" with "nxp,phy-output-refclk"
Message-ID: <20240822-passerby-cupcake-a8d43f391820@spud>
References: <20240822013721.203161-1-wei.fang@nxp.com>
 <20240822013721.203161-3-wei.fang@nxp.com>
 <20240822-headed-sworn-877211c3931f@spud>
 <PAXPR04MB85107F19C846ABDB74849086888F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XXhCYX8L+V1oR2ZQ"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85107F19C846ABDB74849086888F2@PAXPR04MB8510.eurprd04.prod.outlook.com>


--XXhCYX8L+V1oR2ZQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 09:37:11AM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: 2024=E5=B9=B48=E6=9C=8822=E6=97=A5 16:47
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; andrew@lunn.ch; f.fainelli@gmail.com;
> > hkallweit1@gmail.com; linux@armlinux.org.uk; Andrei Botila (OSS)
> > <andrei.botila@oss.nxp.com>; netdev@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 net-next 2/3] net: phy: tja11xx: replace
> > "nxp,rmii-refclk-in" with "nxp,phy-output-refclk"
> >=20
> > On Thu, Aug 22, 2024 at 09:37:20AM +0800, Wei Fang wrote:
> > > As the new property "nxp,phy-output-refclk" is added to instead of the
> > > "nxp,rmii-refclk-in" property, so replace the "nxp,rmii-refclk-in"
> > > property used in the driver with the "nxp,reverse-mode" property and
> > > make slight modifications.
> >=20
> > Can you explain what makes this backwards compatible please?
> >=20
> It does not backward compatible, the related PHY nodes in DTS also
> need to be updated. I have not seen "nxp,rmii-refclk-in" used in the
> upstream.

Since you have switched the polarity, devicestrees that contain
"nxp,rmii-refclk-in" would actually not need an update to preserve
functionality. However...

> For nodes that do not use " nxp,rmii-refclk-in", they need
> to be updated, but unfortunately I cannot confirm which DTS use
> TJA11XX PHY, and there may be no relevant nodes in upstream DTS.

=2E..as you say here, all tja11xx phy nodes that do not have the property
would need to be updated to retain functionality. Given you can't even
determine which devicetrees would need to be updated, I'm going to have
to NAK this change as an unnecessary ABI break.

Thanks,
Conor.

>=20
> > >
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > ---
> > > V2 changes:
> > > 1. Changed the property name.
> > > ---
> > >  drivers/net/phy/nxp-tja11xx.c | 13 ++++++-------
> > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/phy/nxp-tja11xx.c
> > > b/drivers/net/phy/nxp-tja11xx.c index 2c263ae44b4f..7aa0599c38c3
> > > 100644
> > > --- a/drivers/net/phy/nxp-tja11xx.c
> > > +++ b/drivers/net/phy/nxp-tja11xx.c
> > > @@ -78,8 +78,7 @@
> > >  #define MII_COMMCFG			27
> > >  #define MII_COMMCFG_AUTO_OP		BIT(15)
> > >
> > > -/* Configure REF_CLK as input in RMII mode */
> > > -#define TJA110X_RMII_MODE_REFCLK_IN       BIT(0)
> > > +#define TJA11XX_REVERSE_MODE		BIT(0)
> > >
> > >  struct tja11xx_priv {
> > >  	char		*hwmon_name;
> > > @@ -274,10 +273,10 @@ static int tja11xx_get_interface_mode(struct
> > phy_device *phydev)
> > >  		mii_mode =3D MII_CFG1_REVMII_MODE;
> > >  		break;
> > >  	case PHY_INTERFACE_MODE_RMII:
> > > -		if (priv->flags & TJA110X_RMII_MODE_REFCLK_IN)
> > > -			mii_mode =3D MII_CFG1_RMII_MODE_REFCLK_IN;
> > > -		else
> > > +		if (priv->flags & TJA11XX_REVERSE_MODE)
> > >  			mii_mode =3D MII_CFG1_RMII_MODE_REFCLK_OUT;
> > > +		else
> > > +			mii_mode =3D MII_CFG1_RMII_MODE_REFCLK_IN;
> > >  		break;
> > >  	default:
> > >  		return -EINVAL;
> > > @@ -517,8 +516,8 @@ static int tja11xx_parse_dt(struct phy_device
> > *phydev)
> > >  	if (!IS_ENABLED(CONFIG_OF_MDIO))
> > >  		return 0;
> > >
> > > -	if (of_property_read_bool(node, "nxp,rmii-refclk-in"))
> > > -		priv->flags |=3D TJA110X_RMII_MODE_REFCLK_IN;
> > > +	if (of_property_read_bool(node, "nxp,phy-output-refclk"))
> > > +		priv->flags |=3D TJA11XX_REVERSE_MODE;
> > >
> > >  	return 0;
> > >  }
> > > --
> > > 2.34.1
> > >

--XXhCYX8L+V1oR2ZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsdjzgAKCRB4tDGHoIJi
0tuuAPsFBFv/feOfZpvEiCFO0QwcR+wcGtRCxFYB+5Rlo9Bh0wEA6RKSo6nTh+Zg
Ph2MWQK6BPCaE6PnC35trZ2VnYS97Q0=
=Ze8R
-----END PGP SIGNATURE-----

--XXhCYX8L+V1oR2ZQ--

