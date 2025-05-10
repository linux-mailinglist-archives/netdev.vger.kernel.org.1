Return-Path: <netdev+bounces-189467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AFEAB23C0
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 14:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53844A4908
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4312550BF;
	Sat, 10 May 2025 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES8QMARx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8685F1F2C58;
	Sat, 10 May 2025 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746879803; cv=none; b=eKWPSs7aFWtorRhnZracumLtBfVuq/h0qXkAS8jcPHXwPnTKuJRHvm28VZERjgHWQYNsinK6X53T7bgZpmrJYA3VkDKaYMy6fNuaNv9ACo0KV3JgUeQQ1VKJ+JBQuMEuy2jNr74DqA2kAlRfmOEWOcHWYGponONjhKUoseTfjWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746879803; c=relaxed/simple;
	bh=fJ09idw0k6VOwugZFuVgtxsdsW4+oSLBmul/hcAb+VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVvGsz+Rw17le49AmlPUm9t7SKQxtEa7ifxE2lqkmUZjz+wrse2r/mLmtYDDrqS7W/RXkWkc99OHD/ajhk+iJNeAHXcs+koDkMfAPRNntG7NU5Hc4ySC0g7ZIo9ufrR8bj4h/uo58Td2wula34ThGkxn4VP5h3hkUHy/g4elNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES8QMARx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB11C4CEE2;
	Sat, 10 May 2025 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746879802;
	bh=fJ09idw0k6VOwugZFuVgtxsdsW4+oSLBmul/hcAb+VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ES8QMARxdqfQqUFG1Mq9ItRQEi+VSzHDUVAxDsxw/4OTQw9uYBQiJ37h80h1LIypw
	 HeB64+zAOYYPEG7WkET0205NvJwmbw7yJT0QW3mDXGVbdhOj5fqoy2aPOxxGz3w4Zy
	 OCaTFg3Z+OFAKiGZ/GeHwTEHyM7JgMZGzi4yEM9UkwIYD7Rdesbx1+eFH0ey4FwxtK
	 M3jCFy5Yng895eVwpum2ep7sfdXvALcyKXo88Fd8mS5Q9IC7L/K5g/rIlXDeVAgFSJ
	 XGhrXNQAYxRcJGxq4a/Wo4oOO0OdDsyiO/rqYuFu2ddQZSWZzHNBNb5avMljwnE+nC
	 5mpLkBF6SkUdQ==
Date: Sat, 10 May 2025 14:23:20 +0200
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
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH v3 11/11] net: airoha: add phylink support for
 GDM2/3/4
Message-ID: <aB9FOFYEHueMe5L3@lore-desk>
References: <20250510102348.14134-1-ansuelsmth@gmail.com>
 <20250510102348.14134-12-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8oAR6Szfu4s7qgD3"
Content-Disposition: inline
In-Reply-To: <20250510102348.14134-12-ansuelsmth@gmail.com>


--8oAR6Szfu4s7qgD3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add phylink support for GDM2/3/4 port that require configuration of the
> PCS to make the external PHY or attached SFP cage work.
>=20
> These needs to be defined in the GDM port node using the pcs-handle
> property.

Hi Christian,

thx for the patch. Some comments inline.

Regards,
Lorenzo

>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c  | 138 ++++++++++++++++++++++
>  drivers/net/ethernet/airoha/airoha_eth.h  |   3 +
>  drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
>  3 files changed, 153 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 16c7896f931f..17521be820b5 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -7,6 +7,7 @@
>  #include <linux/of_net.h>
>  #include <linux/platform_device.h>
>  #include <linux/tcp.h>
> +#include <linux/pcs/pcs.h>
>  #include <linux/u64_stats_sync.h>
>  #include <net/dst_metadata.h>
>  #include <net/page_pool/helpers.h>
> @@ -79,6 +80,11 @@ static bool airhoa_is_lan_gdm_port(struct airoha_gdm_p=
ort *port)
>  	return port->id =3D=3D 1;
>  }
> =20
> +static bool airhoa_is_phy_external(struct airoha_gdm_port *port)
> +{
> +	return port->id !=3D 1;
> +}
> +
>  static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *a=
ddr)
>  {
>  	struct airoha_eth *eth =3D port->qdma->eth;
> @@ -1613,6 +1619,17 @@ static int airoha_dev_open(struct net_device *dev)
>  	struct airoha_gdm_port *port =3D netdev_priv(dev);
>  	struct airoha_qdma *qdma =3D port->qdma;
> =20
> +	if (airhoa_is_phy_external(port)) {
> +		err =3D phylink_of_phy_connect(port->phylink, dev->dev.of_node, 0);
> +		if (err) {
> +			netdev_err(dev, "%s: could not attach PHY: %d\n", __func__,
> +				   err);
> +			return err;
> +		}
> +
> +		phylink_start(port->phylink);
> +	}
> +
>  	netif_tx_start_all_queues(dev);
>  	err =3D airoha_set_vip_for_gdm_port(port, true);
>  	if (err)
> @@ -1665,6 +1682,11 @@ static int airoha_dev_stop(struct net_device *dev)
>  		}
>  	}
> =20
> +	if (airhoa_is_phy_external(port)) {
> +		phylink_stop(port->phylink);
> +		phylink_disconnect_phy(port->phylink);
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -2795,6 +2817,110 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *=
eth,
>  	return false;
>  }
> =20
> +static void airoha_mac_link_up(struct phylink_config *config, struct phy=
_device *phy,
> +			       unsigned int mode, phy_interface_t interface,
> +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct airoha_gdm_port *port =3D container_of(config, struct airoha_gdm=
_port,
> +						    phylink_config);
> +	struct airoha_qdma *qdma =3D port->qdma;
> +	struct airoha_eth *eth =3D qdma->eth;
> +	u32 frag_size_tx, frag_size_rx;

I guess we can just return here if port->id !=3D 4 and avoid setting
frag_size_tx/frag_size_rx

> +
> +	switch (speed) {
> +	case SPEED_10000:
> +	case SPEED_5000:
> +		frag_size_tx =3D 8;
> +		frag_size_rx =3D 8;
> +		break;
> +	case SPEED_2500:
> +		frag_size_tx =3D 2;
> +		frag_size_rx =3D 1;
> +		break;
> +	default:
> +		frag_size_tx =3D 1;
> +		frag_size_rx =3D 0;
> +	}
> +
> +	/* Configure TX/RX frag based on speed */
> +	if (port->id =3D=3D 4) {
> +		airoha_fe_rmw(eth, REG_GDMA4_TMBI_FRAG, GDMA4_SGMII0_TX_FRAG_SIZE,
> +			      FIELD_PREP(GDMA4_SGMII0_TX_FRAG_SIZE, frag_size_tx));
> +
> +		airoha_fe_rmw(eth, REG_GDMA4_RMBI_FRAG, GDMA4_SGMII0_RX_FRAG_SIZE,
> +			      FIELD_PREP(GDMA4_SGMII0_RX_FRAG_SIZE, frag_size_rx));
> +	}
> +}
> +
> +static const struct phylink_mac_ops airoha_phylink_ops =3D {
> +	.mac_link_up =3D airoha_mac_link_up,
> +};
> +
> +static int airoha_setup_phylink(struct net_device *dev)
> +{
> +	struct airoha_gdm_port *port =3D netdev_priv(dev);
> +	struct device_node *np =3D dev->dev.of_node;
> +	struct phylink_pcs **available_pcs;
> +	phy_interface_t phy_mode;
> +	struct phylink *phylink;
> +	unsigned int num_pcs;
> +	int err;
> +
> +	err =3D of_get_phy_mode(np, &phy_mode);
> +	if (err) {
> +		dev_err(&dev->dev, "incorrect phy-mode\n");
> +		return err;
> +	}
> +
> +	port->phylink_config.dev =3D &dev->dev;
> +	port->phylink_config.type =3D PHYLINK_NETDEV;
> +	port->phylink_config.mac_capabilities =3D MAC_ASYM_PAUSE | MAC_SYM_PAUS=
E |
> +						MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD |
> +						MAC_5000FD | MAC_10000FD;
> +
> +	err =3D fwnode_phylink_pcs_parse(dev_fwnode(&dev->dev), NULL, &num_pcs);
> +	if (err)
> +		return err;
> +
> +	available_pcs =3D kcalloc(num_pcs, sizeof(*available_pcs), GFP_KERNEL);
> +	if (!available_pcs)
> +		return -ENOMEM;

since airoha_setup_phylink() is just run in the following path:

airoha_probe() -> airoha_alloc_gdm_port()

we can use devm_kcalloc() and get rid of the kfree and the end of the routi=
ne.

> +
> +	err =3D fwnode_phylink_pcs_parse(dev_fwnode(&dev->dev), available_pcs,
> +				       &num_pcs);
> +	if (err)
> +		goto out;
> +
> +	port->phylink_config.available_pcs =3D available_pcs;
> +	port->phylink_config.num_available_pcs =3D num_pcs;
> +
> +	__set_bit(PHY_INTERFACE_MODE_SGMII,
> +		  port->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +		  port->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +		  port->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_USXGMII,
> +		  port->phylink_config.supported_interfaces);
> +
> +	phy_interface_copy(port->phylink_config.pcs_interfaces,
> +			   port->phylink_config.supported_interfaces);
> +
> +	phylink =3D phylink_create(&port->phylink_config,
> +				 of_fwnode_handle(np),
> +				 phy_mode, &airoha_phylink_ops);
> +	if (IS_ERR(phylink)) {
> +		err =3D PTR_ERR(phylink);
> +		goto out;
> +	}
> +
> +	port->phylink =3D phylink;
> +out:
> +	kfree(available_pcs);
> +
> +	return err;
> +}
> +
>  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>  				 struct device_node *np, int index)
>  {
> @@ -2873,6 +2999,12 @@ static int airoha_alloc_gdm_port(struct airoha_eth=
 *eth,
>  	if (err)
>  		return err;
> =20
> +	if (airhoa_is_phy_external(port)) {
> +		err =3D airoha_setup_phylink(dev);
> +		if (err)
> +			return err;
> +	}
> +
>  	return register_netdev(dev);

we should run phylink_destroy() if register_netdev() fails. Please take a
look to:

https://lore.kernel.org/netdev/aB8MPkMYXWvoaA03@lore-desk/T/#m0a036b0759384=
a38d2518025db46306858b5707b

>  }
> =20
> @@ -2967,6 +3099,9 @@ static int airoha_probe(struct platform_device *pde=
v)
>  		struct airoha_gdm_port *port =3D eth->ports[i];
> =20
>  		if (port && port->dev->reg_state =3D=3D NETREG_REGISTERED) {
> +			if (airhoa_is_phy_external(port))
> +				phylink_destroy(port->phylink);
> +
>  			unregister_netdev(port->dev);
>  			airoha_metadata_dst_free(port);
>  		}
> @@ -2994,6 +3129,9 @@ static void airoha_remove(struct platform_device *p=
dev)
>  			continue;
> =20
>  		airoha_dev_stop(port->dev);
> +		if (airhoa_is_phy_external(port))
> +			phylink_destroy(port->phylink);
> +
>  		unregister_netdev(port->dev);
>  		airoha_metadata_dst_free(port);
>  	}
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 53f39083a8b0..73a500474076 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -498,6 +498,9 @@ struct airoha_gdm_port {
>  	struct net_device *dev;
>  	int id;
> =20
> +	struct phylink *phylink;
> +	struct phylink_config phylink_config;
> +
>  	struct airoha_hw_stats stats;
> =20
>  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethe=
rnet/airoha/airoha_regs.h
> index d931530fc96f..71c63108f0a8 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -357,6 +357,18 @@
>  #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
>  #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
> =20
> +#define REG_GDMA4_TMBI_FRAG		0x2028
> +#define GDMA4_SGMII1_TX_WEIGHT		GENMASK(31, 26)
> +#define GDMA4_SGMII1_TX_FRAG_SIZE	GENMASK(25, 16)
> +#define GDMA4_SGMII0_TX_WEIGHT		GENMASK(15, 10)
> +#define GDMA4_SGMII0_TX_FRAG_SIZE	GENMASK(9, 0)

in order to be consistent with the codebase, can you please add _MASK suffix
here?

> +
> +#define REG_GDMA4_RMBI_FRAG		0x202c
> +#define GDMA4_SGMII1_RX_WEIGHT		GENMASK(31, 26)
> +#define GDMA4_SGMII1_RX_FRAG_SIZE	GENMASK(25, 16)
> +#define GDMA4_SGMII0_RX_WEIGHT		GENMASK(15, 10)
> +#define GDMA4_SGMII0_RX_FRAG_SIZE	GENMASK(9, 0)
> +
>  #define REG_MC_VLAN_EN			0x2100
>  #define MC_VLAN_EN_MASK			BIT(0)
> =20
> --=20
> 2.48.1
>=20

--8oAR6Szfu4s7qgD3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaB9FOAAKCRA6cBh0uS2t
rKPIAPwMEFXVq68i8yQsuu9IvUlxGoQG+53nB09xyQ9gjCAcrAD/R4CUglVPB8nT
85veqNrpKWaemKxHYCZcXiFXq5lPbws=
=fSdo
-----END PGP SIGNATURE-----

--8oAR6Szfu4s7qgD3--

