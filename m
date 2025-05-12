Return-Path: <netdev+bounces-189685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E7FAB3314
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F0C7AA07D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76E25C80B;
	Mon, 12 May 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1Fbm2J6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE5F25B663;
	Mon, 12 May 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041710; cv=none; b=r4bD+70d809C6us7t8F2kL6azpl7oL+ztaxOI/kkkG5g0e/UtzdRJ+5f5ArtHHJBpl0Uych653fXSGJDR1rkQeBZdqL2wl+qMUXmPzMx3vDThW9/SeL+kgdYlz8fyic3uwjTGY3CUh2X7HZVD5w5qLRPZeitD7cym1la2dCBAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041710; c=relaxed/simple;
	bh=t5o1U0UpFX89qHN3iGYPXHPFCpScbEOGaqvmBNXdX5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goYEOaPTyOseHz/XCXUEY5OzCkFT/Kpb7YwT3IgDkqX/+8WxYsnD1NCuIhPj9/hLnqX1qq66pXb9fnlpiAOkxXiLODH9tpJhcGLnEFUUMvhQ+EYpRqEYvB98N5DQwo9DlDcwRxyA3azDeWQtLD26GPxjBZKFph1TGJ+vBieRoso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1Fbm2J6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1E9C4CEE9;
	Mon, 12 May 2025 09:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747041710;
	bh=t5o1U0UpFX89qHN3iGYPXHPFCpScbEOGaqvmBNXdX5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1Fbm2J6/MflwcGHyfl5LoLLoml/GOsZnj9Fkt4tXuhyGFpAt3Pxkg9CHKpkbfaDv
	 m7iYtIrf3liWT6XMJQZEH/qGWwMOsKtdiYLxgMQ+LdXXIdpHKzvRm433hlwvUvomtH
	 sWh9L3/GJceichgJZntZ5miYv95l7brIE02pc7wqkJak0PNxvfSfzsvjLwBoe0xjp+
	 Ny23KjQG8O84daH5bOYtw5wbxX7WfqzJZoI2uM7nD/MrUdGzi02+MmKqzKLSYe+wxl
	 CWDixsWnWe8tL9dH0175ThoWyknPKdKYIFVzzRW5gPX+4Zxc3MvDv48WR43LhtwUA2
	 uQTmaYWrJGLqQ==
Date: Mon, 12 May 2025 11:21:47 +0200
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
Message-ID: <aCG9q6i7HomgilI6@lore-desk>
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
 <20250511201250.3789083-12-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2yvoztbt3M/n+jtr"
Content-Disposition: inline
In-Reply-To: <20250511201250.3789083-12-ansuelsmth@gmail.com>


--2yvoztbt3M/n+jtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add phylink support for GDM2/3/4 port that require configuration of the
> PCS to make the external PHY or attached SFP cage work.
>=20
> These needs to be defined in the GDM port node using the pcs-handle
> property.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c  | 155 +++++++++++++++++++++-
>  drivers/net/ethernet/airoha/airoha_eth.h  |   3 +
>  drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
>  3 files changed, 169 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 16c7896f931f..3be1ae077a76 100644
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

nit: even if it is not strictly required, in order to align with the rest o=
f the
codebase, can you please stay below 79 columns?

> +		if (err) {
> +			netdev_err(dev, "%s: could not attach PHY: %d\n", __func__,
> +				   err);

same here

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
> @@ -2795,6 +2817,115 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *=
eth,
>  	return false;
>  }
> =20
> +static void airoha_mac_link_up(struct phylink_config *config, struct phy=
_device *phy,
> +			       unsigned int mode, phy_interface_t interface,
> +			       int speed, int duplex, bool tx_pause, bool rx_pause)

ditto.

> +{
> +	struct airoha_gdm_port *port =3D container_of(config, struct airoha_gdm=
_port,
> +						    phylink_config);

ditto.

> +	struct airoha_qdma *qdma =3D port->qdma;
> +	struct airoha_eth *eth =3D qdma->eth;
> +	u32 frag_size_tx, frag_size_rx;
> +
> +	if (port->id !=3D 4)
> +		return;
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
> +	airoha_fe_rmw(eth, REG_GDMA4_TMBI_FRAG,
> +		      GDMA4_SGMII0_TX_FRAG_SIZE_MASK,
> +		      FIELD_PREP(GDMA4_SGMII0_TX_FRAG_SIZE_MASK,
> +				 frag_size_tx));
> +
> +	airoha_fe_rmw(eth, REG_GDMA4_RMBI_FRAG,
> +		      GDMA4_SGMII0_RX_FRAG_SIZE_MASK,
> +		      FIELD_PREP(GDMA4_SGMII0_RX_FRAG_SIZE_MASK,
> +				 frag_size_rx));
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

over 79 columns

> +
> +	err =3D fwnode_phylink_pcs_parse(dev_fwnode(&dev->dev), NULL, &num_pcs);
> +	if (err)
> +		return err;
> +
> +	available_pcs =3D kcalloc(num_pcs, sizeof(*available_pcs), GFP_KERNEL);

I guess you can use devm_kcalloc() and get rid of kfree() here.

> +	if (!available_pcs)
> +		return -ENOMEM;
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
> @@ -2873,7 +3004,23 @@ static int airoha_alloc_gdm_port(struct airoha_eth=
 *eth,
>  	if (err)
>  		return err;
> =20
> -	return register_netdev(dev);
> +	if (airhoa_is_phy_external(port)) {
> +		err =3D airoha_setup_phylink(dev);

This will re-introduce the issue reported here:
https://lore.kernel.org/netdev/5c94b9b3850f7f29ed653e2205325620df28c3ff.174=
6715755.git.christophe.jaillet@wanadoo.fr/

> +		if (err)
> +			return err;
> +	}
> +
> +	err =3D register_netdev(dev);
> +	if (err)
> +		goto free_phylink;
> +
> +	return 0;
> +
> +free_phylink:
> +	if (airhoa_is_phy_external(port))
> +		phylink_destroy(port->phylink);
> +
> +	return err;
>  }
> =20
>  static int airoha_probe(struct platform_device *pdev)
> @@ -2967,6 +3114,9 @@ static int airoha_probe(struct platform_device *pde=
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
> @@ -2994,6 +3144,9 @@ static void airoha_remove(struct platform_device *p=
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
> index d931530fc96f..54f7079b28b0 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -357,6 +357,18 @@
>  #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
>  #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
> =20
> +#define REG_GDMA4_TMBI_FRAG		0x2028
> +#define GDMA4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
> +#define GDMA4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
> +#define GDMA4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
> +#define GDMA4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
> +
> +#define REG_GDMA4_RMBI_FRAG		0x202c
> +#define GDMA4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
> +#define GDMA4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
> +#define GDMA4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
> +#define GDMA4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
> +
>  #define REG_MC_VLAN_EN			0x2100
>  #define MC_VLAN_EN_MASK			BIT(0)
> =20
> --=20
> 2.48.1
>=20

--2yvoztbt3M/n+jtr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaCG9qwAKCRA6cBh0uS2t
rGcGAP0U/LZ3yZ/JFyuZ3S3LnDaKGLcjA+OR9tlWIBeIm4lf1AD/ZSZi/2WmFx3Q
V5z+kAb4yQHd4bFvCmn7z8/Tr4xb+Q0=
=KPwp
-----END PGP SIGNATURE-----

--2yvoztbt3M/n+jtr--

