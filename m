Return-Path: <netdev+bounces-189752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D32DAB37D7
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC021665C6
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83438293725;
	Mon, 12 May 2025 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3fRCOyL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF8255F3E;
	Mon, 12 May 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054401; cv=none; b=BXtQC+d7elY8fsmxTjLfM7GLfpkZO+cvnDRkNnAgtSd1IPyXarcIDMRU6HR67QuJDcfIeI52ugZERiKFKraEofRrjCT/uf8D6HNIk3X5KMjFqDVVK4NKxIlcuiH45Z+tTrzyqTzsDJjBy1zfc7DFBDaEvWGoj0y33CEtxvX6zDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054401; c=relaxed/simple;
	bh=bGEl/N/Mj0l0P5OgWd/MVZto+HVhtJO0kIfC1NcF2TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHaSkrQ9GZqBtx53qHRBReQ1odMkaFjc5LyCOEj4L1gRlN0flxvxfK8Neb2hbJ1/CTIjiteKNvV0lpvTCzg51dtpa+YOkSPNoxNN56upVgRdK+uiK/li2GYZZ47eQ6GpdV7Nj0ms151XVjSb8xKe+M9FIY1Ph4SmisEvv8/2FIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3fRCOyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F74CC4CEE7;
	Mon, 12 May 2025 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747054400;
	bh=bGEl/N/Mj0l0P5OgWd/MVZto+HVhtJO0kIfC1NcF2TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3fRCOyLPT0vjKRO5zR3VuRX900CG3fKPgscz7YdQspH2GDbSo3AYbupGLL8zQFqL
	 3m+b7CxaUycY5DapAxsIgnmn/UwywUPYkN4qYNQWFmnFXgT3KEoDZYD9iCdmh26/Ms
	 PPxj4I3EYeoSxnCv1zD61T/Aik0T0c5cPb5xi8WRqPoePZZ/Z+DFRGT/ud0ZDrbY5l
	 S0rMfC04JTcp4qh+aYv5n+AkIUe5fIWoNfmR4LFuvgP5h2ce6pLDyU+ySdOvEb5eJk
	 mRBmHURhaRMZ7sZK6efFPXOjND4wZxNOpmvkjD9z2XP4Z4uV8wcheCQoVRQshxozuU
	 dUyajsHSr/8kA==
Date: Mon, 12 May 2025 14:53:18 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [net-next PATCH v4 11/11] net: airoha: add phylink support for
 GDM2/3/4
Message-ID: <aCHvPoZDGUrCVif1@lore-desk>
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
 <20250511201250.3789083-12-ansuelsmth@gmail.com>
 <aCG9q6i7HomgilI6@lore-desk>
 <6821bef5.5d0a0220.319347.d533@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qLFnU5peW7PO9M+h"
Content-Disposition: inline
In-Reply-To: <6821bef5.5d0a0220.319347.d533@mx.google.com>


--qLFnU5peW7PO9M+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> >=20
> > I guess you can use devm_kcalloc() and get rid of kfree() here.
> >
>=20
> I forgot to answer to this in the previous revision. No devm can't be
> used there available_pcs is just an array allocated for phylink_config.
>=20
> Phylink then copy the data in it and doesn't use it anymore hence it
> just needs to be allocated here and doesn't need to stay till the driver
> gets removed.

I guess this is exactly the point. Since available_pcs is used just here and
this is not a hot-path, I think the code would be simpler, but I do not have
a strong opinion about it.

>=20
> > > +	if (!available_pcs)
> > > +		return -ENOMEM;
> > > +
> > > +	err =3D fwnode_phylink_pcs_parse(dev_fwnode(&dev->dev), available_p=
cs,
> > > +				       &num_pcs);
> > > +	if (err)
> > > +		goto out;
> > > +
> > > +	port->phylink_config.available_pcs =3D available_pcs;
> > > +	port->phylink_config.num_available_pcs =3D num_pcs;
> > > +
> > > +	__set_bit(PHY_INTERFACE_MODE_SGMII,
> > > +		  port->phylink_config.supported_interfaces);
> > > +	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> > > +		  port->phylink_config.supported_interfaces);
> > > +	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > > +		  port->phylink_config.supported_interfaces);
> > > +	__set_bit(PHY_INTERFACE_MODE_USXGMII,
> > > +		  port->phylink_config.supported_interfaces);
> > > +
> > > +	phy_interface_copy(port->phylink_config.pcs_interfaces,
> > > +			   port->phylink_config.supported_interfaces);
> > > +
> > > +	phylink =3D phylink_create(&port->phylink_config,
> > > +				 of_fwnode_handle(np),
> > > +				 phy_mode, &airoha_phylink_ops);
> > > +	if (IS_ERR(phylink)) {
> > > +		err =3D PTR_ERR(phylink);
> > > +		goto out;
> > > +	}
> > > +
> > > +	port->phylink =3D phylink;
> > > +out:
> > > +	kfree(available_pcs);
> > > +
> > > +	return err;
> > > +}
> > > +
> > >  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> > >  				 struct device_node *np, int index)
> > >  {
> > > @@ -2873,7 +3004,23 @@ static int airoha_alloc_gdm_port(struct airoha=
_eth *eth,
> > >  	if (err)
> > >  		return err;
> > > =20
> > > -	return register_netdev(dev);
> > > +	if (airhoa_is_phy_external(port)) {
> > > +		err =3D airoha_setup_phylink(dev);
> >=20
> > This will re-introduce the issue reported here:
> > https://lore.kernel.org/netdev/5c94b9b3850f7f29ed653e2205325620df28c3ff=
=2E1746715755.git.christophe.jaillet@wanadoo.fr/
> >=20
>=20
> I'm confused about this. The suggestion wasn't that register_netdev
> might fail and I need to destroy phylink? Or the linked patch was merged
> and I need to rebase on top of net-next?

what I mean here is if register_netdev() or airoha_setup_phylink() fails, we
should free metadata_dst running airoha_metadata_dst_free() as pointed out =
by
Christophe. I think this path depends on Christophe's one.

Regards,
Lorenzo

>=20
> I didn't include that change to not cause conflicts but once it's merged
> I will rebase and include that fix.
>=20
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > +
> > > +	err =3D register_netdev(dev);
> > > +	if (err)
> > > +		goto free_phylink;
> > > +
> > > +	return 0;
> > > +
> > > +free_phylink:
> > > +	if (airhoa_is_phy_external(port))
> > > +		phylink_destroy(port->phylink);
> > > +
> > > +	return err;
> > >  }
> > > =20
> > >  static int airoha_probe(struct platform_device *pdev)
> > > @@ -2967,6 +3114,9 @@ static int airoha_probe(struct platform_device =
*pdev)
> > >  		struct airoha_gdm_port *port =3D eth->ports[i];
> > > =20
> > >  		if (port && port->dev->reg_state =3D=3D NETREG_REGISTERED) {
> > > +			if (airhoa_is_phy_external(port))
> > > +				phylink_destroy(port->phylink);
> > > +
> > >  			unregister_netdev(port->dev);
> > >  			airoha_metadata_dst_free(port);
> > >  		}
> > > @@ -2994,6 +3144,9 @@ static void airoha_remove(struct platform_devic=
e *pdev)
> > >  			continue;
> > > =20
> > >  		airoha_dev_stop(port->dev);
> > > +		if (airhoa_is_phy_external(port))
> > > +			phylink_destroy(port->phylink);
> > > +
> > >  		unregister_netdev(port->dev);
> > >  		airoha_metadata_dst_free(port);
> > >  	}
> > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/e=
thernet/airoha/airoha_eth.h
> > > index 53f39083a8b0..73a500474076 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > > @@ -498,6 +498,9 @@ struct airoha_gdm_port {
> > >  	struct net_device *dev;
> > >  	int id;
> > > =20
> > > +	struct phylink *phylink;
> > > +	struct phylink_config phylink_config;
> > > +
> > >  	struct airoha_hw_stats stats;
> > > =20
> > >  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> > > diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/=
ethernet/airoha/airoha_regs.h
> > > index d931530fc96f..54f7079b28b0 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_regs.h
> > > +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> > > @@ -357,6 +357,18 @@
> > >  #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
> > >  #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
> > > =20
> > > +#define REG_GDMA4_TMBI_FRAG		0x2028
> > > +#define GDMA4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
> > > +#define GDMA4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
> > > +#define GDMA4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
> > > +#define GDMA4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
> > > +
> > > +#define REG_GDMA4_RMBI_FRAG		0x202c
> > > +#define GDMA4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
> > > +#define GDMA4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
> > > +#define GDMA4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
> > > +#define GDMA4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
> > > +
> > >  #define REG_MC_VLAN_EN			0x2100
> > >  #define MC_VLAN_EN_MASK			BIT(0)
> > > =20
> > > --=20
> > > 2.48.1
> > >=20
>=20
>=20
>=20
> --=20
> 	Ansuel

--qLFnU5peW7PO9M+h
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaCHvPQAKCRA6cBh0uS2t
rCKKAQDoo1Ic7QM4rc/5oU7UWhtoTcWdR7rS8tHWdV+0UgkdMgEA3gSouVvqUpuL
PLyVAXcTL1u29P6WuHKZvkQmExHFyAU=
=1tGU
-----END PGP SIGNATURE-----

--qLFnU5peW7PO9M+h--

