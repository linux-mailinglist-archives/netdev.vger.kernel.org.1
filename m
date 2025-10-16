Return-Path: <netdev+bounces-229932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FADBBE22CE
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31DA487DE2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF41B305057;
	Thu, 16 Oct 2025 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSxiCumn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429E145348;
	Thu, 16 Oct 2025 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603812; cv=none; b=Qn96gISutGEBIUs2ixPJxP0RTlKyuDcUIQFCJc4jmgHiQOEXNAQu3VdLOt6j8hLPw1uwRxlzpU0l5F7TpXQH0U3zNrfXVtyhJ0gPNtlOv/uejRoYa2pFIRjTZpJf3vmZhO/haJdlC/Rn/BaUD3bR5ihRQGMlTMUgZn3IIc162/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603812; c=relaxed/simple;
	bh=MuVT8F29Xlc5XO/utltXz470EZDUUeT2p+kzo7sBpCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+YiFuNCUWrgV+p4Te3WsFV8zAbbgCdam3TcspEf0baSCSffWRxl2x6g9DpJ0wrTRq3dek/rur5bKQYymdIrbw0lTVo5N5PwEA3iirOAgnAUGXI64CLzZiluG9retjE418VF4hdPn1OabP7qJ09QojyOhVtdVtGBBBeLhIKpeJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSxiCumn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CC6C4CEF1;
	Thu, 16 Oct 2025 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760603812;
	bh=MuVT8F29Xlc5XO/utltXz470EZDUUeT2p+kzo7sBpCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSxiCumns7EpzNLOIgT/81hEQX9eA2qS1y/SDwq4SEuMAG5jL16PWcY1aeG8GdOH+
	 QcclVkiqrcTwaToa4hGCK0J7pXlx1HsGlbj5wBXQLlQ3Ab/o4pTbThi9acFoCR/eLo
	 65WmTLCEw20m71CvOHv/ZoA19nC1E7uORPjfXxifwEFKC0SVlCgfAVjl3ZuQNkjdc9
	 m5gILegWqx67jDRS1rqorVr1lthwCEn9rHUNhS4KdtrXH2DojZ+YT+BCTGwFBrYSLR
	 TD70OsqTNs0/v9YvrtLSrwrmpLX6/tnnXmj8+J22+D3sWTU+KKzkaJkRW8Vdg70GYH
	 e7htLXVq29SVw==
Date: Thu, 16 Oct 2025 10:36:49 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] net: airoha: Refactor src port
 configuration in airhoha_set_gdm2_loopback
Message-ID: <aPCuoR8ukM23d71i@lore-desk>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-11-064855f05923@kernel.org>
 <aO_GOE0jPMlcP-VR@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="njSAvnTeCku01lzf"
Content-Disposition: inline
In-Reply-To: <aO_GOE0jPMlcP-VR@horms.kernel.org>


--njSAvnTeCku01lzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Oct 15, 2025 at 09:15:11AM +0200, Lorenzo Bianconi wrote:
> > AN7583 chipset relies on different definitions for source-port
> > identifier used for hw offloading. In order to support hw offloading
> > in AN7583 controller, refactor src port configuration in
> > airhoha_set_gdm2_loopback routine and introduce get_src_port_id
> > callback.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c  | 75 +++++++++++++++++++++--=
--------
> >  drivers/net/ethernet/airoha/airoha_eth.h  | 11 +++--
> >  drivers/net/ethernet/airoha/airoha_regs.h |  5 +--
> >  3 files changed, 60 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 5f6b5ab52e0265f7bb56b008ca653d64e04ff2d2..76c82750b3ae89a9fa81c64=
d3b7c3578b369480c 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1682,11 +1682,14 @@ static int airoha_dev_set_macaddr(struct net_de=
vice *dev, void *p)
> >  	return 0;
> >  }
> > =20
> > -static void airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
> > +static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
> >  {
> >  	u32 pse_port =3D port->id =3D=3D 3 ? FE_PSE_PORT_GDM3 : FE_PSE_PORT_G=
DM4;
> >  	struct airoha_eth *eth =3D port->qdma->eth;
> >  	u32 chan =3D port->id =3D=3D 3 ? 4 : 0;
> > +	/* XXX: handle XSI_USB_PORT and XSI_PCE1_PORT */
> > +	u32 nbq =3D port->id =3D=3D 3 ? 4 : 0;
> > +	int src_port;
>=20
> I think this code could benefit for names (defines) for port ids.
> It's a bit clearer in airoha_en7581_get_src_port_id(). But the
> numbers seem kind of magic in this function.

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> > =20
> >  	/* Forward the traffic to the proper GDM port */
> >  	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(2), pse_port);
> > @@ -1709,29 +1712,23 @@ static void airhoha_set_gdm2_loopback(struct ai=
roha_gdm_port *port)
> >  	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(2));
> >  	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(2));
> > =20
> > -	if (port->id =3D=3D 3) {
> > -		/* FIXME: handle XSI_PCE1_PORT */
> > -		airoha_fe_rmw(eth, REG_FE_WAN_PORT,
> > -			      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
> > -			      FIELD_PREP(WAN0_MASK, HSGMII_LAN_PCIE0_SRCPORT));
> > -		airoha_fe_rmw(eth,
> > -			      REG_SP_DFT_CPORT(HSGMII_LAN_PCIE0_SRCPORT >> 3),
> > -			      SP_CPORT_PCIE0_MASK,
> > -			      FIELD_PREP(SP_CPORT_PCIE0_MASK,
> > -					 FE_PSE_PORT_CDM2));
> > -	} else {
> > -		/* FIXME: handle XSI_USB_PORT */
> > +	src_port =3D eth->soc->ops.get_src_port_id(port, nbq);
> > +	if (src_port < 0)
> > +		return src_port;
> > +
> > +	airoha_fe_rmw(eth, REG_FE_WAN_PORT,
> > +		      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
> > +		      FIELD_PREP(WAN0_MASK, src_port));
> > +	airoha_fe_rmw(eth, REG_SP_DFT_CPORT(src_port >> 3),
> > +		      SP_CPORT_MASK(src_port & 0x7),
> > +		      FE_PSE_PORT_CDM2 << __ffs(SP_CPORT_MASK(src_port & 0x7)));
>=20
> Likewise, 3 and 0x7 a bit magical here.
>=20
> > +
> > +	if (port->id !=3D 3)
> >  		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6,
> >  			      FC_ID_OF_SRC_PORT24_MASK,
> >  			      FIELD_PREP(FC_ID_OF_SRC_PORT24_MASK, 2));
>=20
> ... and 2 here.
>=20
> > -		airoha_fe_rmw(eth, REG_FE_WAN_PORT,
> > -			      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
> > -			      FIELD_PREP(WAN0_MASK, HSGMII_LAN_ETH_SRCPORT));
> > -		airoha_fe_rmw(eth,
> > -			      REG_SP_DFT_CPORT(HSGMII_LAN_ETH_SRCPORT >> 3),
> > -			      SP_CPORT_ETH_MASK,
> > -			      FIELD_PREP(SP_CPORT_ETH_MASK, FE_PSE_PORT_CDM2));
> > -	}
> > +
> > +	return 0;
> >  }
>=20
> ...
>=20
> > @@ -3055,11 +3057,38 @@ static const char * const en7581_xsi_rsts_names=
[] =3D {
> >  	"xfp-mac",
> >  };
> > =20
> > +static int airoha_en7581_get_src_port_id(struct airoha_gdm_port *port,=
 int nbq)
> > +{
> > +	switch (port->id) {
> > +	case 3:
> > +		/* 7581 SoC supports PCIe serdes on GDM3 port */
> > +		if (nbq =3D=3D 4)
> > +			return HSGMII_LAN_7581_PCIE0_SRCPORT;
> > +		if (nbq =3D=3D 5)
> > +			return HSGMII_LAN_7581_PCIE1_SRCPORT;
> > +		break;
> > +	case 4:
> > +		/* 7581 SoC supports eth and usb serdes on GDM4 port */
> > +		if (!nbq)
> > +			return HSGMII_LAN_7581_ETH_SRCPORT;
> > +		if (nbq =3D=3D 1)
> > +			return HSGMII_LAN_7581_USB_SRCPORT;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
>=20
> ...

--njSAvnTeCku01lzf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPCuoQAKCRA6cBh0uS2t
rCOOAQDMDIpF364/MbSzib3j8d9uEzbbNEXLxP3luCc3gqQiqwEA742hYnGMwq6H
kCa9nehAixoGaVR15kULJyL3ZZAxHgc=
=NNc+
-----END PGP SIGNATURE-----

--njSAvnTeCku01lzf--

