Return-Path: <netdev+bounces-230822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F715BF01FE
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AE9189ED5B
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371042F531F;
	Mon, 20 Oct 2025 09:16:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911BA29ACC3
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951794; cv=none; b=Puc8hra7V60lVHlCdi14ldY1+Wz3zUO9ZTH721Uq0c48ZPt589RbgBuMZ8Bjlul7Vk8wRrBbiEdx3Ju6OauxhCZr7V+k7peZpHZKMsKToh9A9469otUnX8pfqZHv1sH5zGs/5NXvD1T3tGRa3X/rWv/y9SoV5EDGeSR432K9sTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951794; c=relaxed/simple;
	bh=P5qdqIbQJXlpU2AVWwO5CppXIEQ7tRUuCuhzdjaCMI0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ux4tAz2GEvTQrGV1hGNdwol7alGV1gIUS46x/vcGYOAOSNxW1k1Gf60IjDAknMmyAX8yD7TfEXkZo7XPPtdQtC5pVlETPR0mcoR0kcAWq0WIZoLwdrfltQQsqh7f6N0eHtnOpnGJXLIqk+O9nHqENCyECzAh7n1t2hetWh31xpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vAlzx-0000qK-0b; Mon, 20 Oct 2025 11:16:13 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vAlzv-004WQH-0r;
	Mon, 20 Oct 2025 11:16:11 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vAlzv-0000000059F-0jvO;
	Mon, 20 Oct 2025 11:16:11 +0200
Message-ID: <af5211fbb818c873f22b6622526fa8e0c9eb2fde.camel@pengutronix.de>
Subject: Re: [PATCH net-next v3 4/4] net: mdio: reset PHY before attempting
 to access registers in fwnode_mdiobus_register_phy
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli	 <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 20 Oct 2025 11:16:11 +0200
In-Reply-To: <cb6640fa11e4b148f51d4c8553fe177d5bdb4d37.1760620093.git.buday.csaba@prolan.hu>
References: <cover.1760620093.git.buday.csaba@prolan.hu>
	 <cb6640fa11e4b148f51d4c8553fe177d5bdb4d37.1760620093.git.buday.csaba@prolan.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fr, 2025-10-17 at 18:10 +0200, Buday Csaba wrote:
> Implement support for the `phy-id-read-needs-reset` device tree
> property.
>=20
> When the ID of an ethernet PHY is not provided by the 'compatible'
> string in the device tree, its actual ID is read via the MDIO bus.
> For some PHYs this could be unsafe, since a hard reset may be
> necessary to safely access the MDIO registers.
>=20
> This patch performs the hard-reset before attempting to read the ID,
> when the mentioned device tree property is present.
>=20
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> ---
> V2 -> V3: kernel-doc replaced with a comment (fixed warning)
> V1 -> V2:
>  - renamed DT property `reset-phy-before-probe` to
>   `phy-id-read-needs-reset`

Not completely, see below.

>  - renamed fwnode_reset_phy_before_probe() to
>    fwnode_reset_phy()
>  - added kernel-doc for fwnode_reset_phy()
>  - improved error handling in fwnode_reset_phy()
> ---
>  drivers/net/mdio/fwnode_mdio.c | 35 +++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdi=
o.c
> index ba7091518..8e8f9182a 100644
> --- a/drivers/net/mdio/fwnode_mdio.c
> +++ b/drivers/net/mdio/fwnode_mdio.c
> @@ -114,6 +114,36 @@ int fwnode_mdiobus_phy_device_register(struct mii_bu=
s *mdio,
>  }
>  EXPORT_SYMBOL(fwnode_mdiobus_phy_device_register);
> =20
> +/* Hard-reset a PHY before registration */
> +static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
> +			    struct fwnode_handle *phy_node)
> +{
> +	struct mdio_device *tmpdev;
> +	int err;
> +
> +	tmpdev =3D mdio_device_create(bus, addr);
> +	if (IS_ERR(tmpdev))
> +		return PTR_ERR(tmpdev);
> +
> +	fwnode_handle_get(phy_node);
> +	device_set_node(&tmpdev->dev, phy_node);
> +	err =3D mdio_device_register_reset(tmpdev);
> +	if (err) {
> +		mdio_device_free(tmpdev);
> +		return err;
> +	}
> +
> +	mdio_device_reset(tmpdev, 1);
> +	mdio_device_reset(tmpdev, 0);
> +
> +	mdio_device_unregister_reset(tmpdev);
> +
> +	mdio_device_free(tmpdev);
> +	fwnode_handle_put(phy_node);
> +
> +	return 0;
> +}
> +
>  int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>  				struct fwnode_handle *child, u32 addr)
>  {
> @@ -129,8 +159,11 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>  		return PTR_ERR(mii_ts);
> =20
>  	is_c45 =3D fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c=
45");
> -	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
> +	if (is_c45 || fwnode_get_phy_id(child, &phy_id)) {
> +		if (fwnode_property_present(child, "reset-phy-before-probe"))

Commit message says this should be "phy-id-read-needs-reset" now.

regards
Philipp

