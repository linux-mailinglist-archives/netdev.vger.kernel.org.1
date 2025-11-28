Return-Path: <netdev+bounces-242532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B4AC91806
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 10:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDFB3AB860
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59882DC793;
	Fri, 28 Nov 2025 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bj3eTU3W"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0AC221FB4
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323183; cv=none; b=lKzEzECZJhSNMQ5k/c+8j4CeJWHqKIDnbk1iKZiCPitNO6ibKke6iOktupG5XT9ADiqveGKqzLd7vr/Q1ir5ynhsK/MfCYnLPzHX1shs1m4YfHAT584ZE1InHT45mDRfuIypOcv+gsf8IU7UTVH99iRMfjhhI7JYMX5zc0r+hJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323183; c=relaxed/simple;
	bh=bTgnthsUmnaNdnUoNw2gIrdUiqBpzi/743flmeyYbDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/STcq1jBx8giT7EKjnKLHQ5axvxvtkDu7Vms2J2jOcaJupPzU1FymDD6s+z73WpBArOXEIuads4vLDJIW4ORl9bXZEMetOeRnAjiwIUvfsODtcSkACv3LZzK547yvnDq5xzgL+Sn/mpkgIlyOo/8Cs1YkxhOImuO3R4eX6n9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bj3eTU3W; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1CE4A1A1DF7;
	Fri, 28 Nov 2025 09:46:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DAE6F60706;
	Fri, 28 Nov 2025 09:46:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8FCDD103C8F6E;
	Fri, 28 Nov 2025 10:46:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764323178; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZNXXDvFrASSfZRcU+EvwOTVHDkvZV9HAk6DNx5QkJao=;
	b=Bj3eTU3Wrw+cMbSjQdmNS2PHt77UEHFuzn5cZuOiVNv/a/czv1nnY1/PqUXlydur0dL0NL
	3TLmjanMFCXG/TfukHUFyl4pDeg3uvBjaVnv5dUk/SrVnFw1yoLA3NHM7SMy+B0sdwDBQ+
	II6ByuCVTEvofwX7Nf5Pfx7R8UDuZYyB69dG9/87rE9mHHaLX2Xc1ulMdP3bI9E8k/5s1S
	KClGTwJ0PLv0sogs8dihwwzJkcGFXboB85TSPBMqFHlnxHMPJDpmUoKWQCQtTSiGaUvMlh
	5aLlccg7cz/GIE+RHgBtk2wxg5vFZwlDU5WK4A58twnPT5uVuVDc8BZ+iIEW0w==
Date: Fri, 28 Nov 2025 10:46:14 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Simon
 Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob
 Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: phy: micrel: add HW timestamp
 configuration reporting
Message-ID: <20251128104614.05fdb7a4@kmaincent-XPS-13-7390>
In-Reply-To: <20251127211245.279737-3-vadim.fedorenko@linux.dev>
References: <20251127211245.279737-1-vadim.fedorenko@linux.dev>
	<20251127211245.279737-3-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 27 Nov 2025 21:12:43 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver stores HW timestamping configuration and can technically
> report it. Add callback to do it.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/phy/micrel.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 2c9a17d4ff18..59fbe0dd38fd 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -3147,6 +3147,18 @@ static void lan8814_flush_fifo(struct phy_device
> *phydev, bool egress) lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
> PTP_TSU_INT_STS); }
> =20
> +static int lan8814_hwtstamp_get(struct mii_timestamper *mii_ts,
> +				struct kernel_hwtstamp_config *config)
> +{
> +	struct kszphy_ptp_priv *ptp_priv =3D
> +			  container_of(mii_ts, struct kszphy_ptp_priv,
> mii_ts); +
> +	config->tx_type =3D ptp_priv->hwts_tx_type;
> +	config->rx_filter =3D ptp_priv->rx_filter;
> +
> +	return 0;
> +}
> +
>  static int lan8814_hwtstamp_set(struct mii_timestamper *mii_ts,
>  				struct kernel_hwtstamp_config *config,
>  				struct netlink_ext_ack *extack)
> @@ -4390,6 +4402,7 @@ static void lan8814_ptp_init(struct phy_device *phy=
dev)
>  	ptp_priv->mii_ts.rxtstamp =3D lan8814_rxtstamp;
>  	ptp_priv->mii_ts.txtstamp =3D lan8814_txtstamp;
>  	ptp_priv->mii_ts.hwtstamp_set =3D lan8814_hwtstamp_set;
> +	ptp_priv->mii_ts.hwtstamp_get =3D lan8814_hwtstamp_get;
>  	ptp_priv->mii_ts.ts_info  =3D lan8814_ts_info;
> =20
>  	phydev->mii_ts =3D &ptp_priv->mii_ts;
> @@ -5042,6 +5055,19 @@ static void lan8841_ptp_enable_processing(struct
> kszphy_ptp_priv *ptp_priv, #define LAN8841_PTP_TX_TIMESTAMP_EN
> 443 #define LAN8841_PTP_TX_MOD			445
> =20
> +static int lan8841_hwtstamp_get(struct mii_timestamper *mii_ts,
> +				struct kernel_hwtstamp_config *config)
> +{
> +	struct kszphy_ptp_priv *ptp_priv;
> +
> +	ptp_priv =3D container_of(mii_ts, struct kszphy_ptp_priv, mii_ts);
> +
> +	config->tx_type =3D ptp_priv->hwts_tx_type;
> +	config->rx_filter =3D ptp_priv->rx_filter;
> +
> +	return 0;
> +}

The two functions are identical, maybe you could use only one instead of
duplicating the code.

Regards,

> +
>  static int lan8841_hwtstamp_set(struct mii_timestamper *mii_ts,
>  				struct kernel_hwtstamp_config *config,
>  				struct netlink_ext_ack *extack)
> @@ -5925,6 +5951,7 @@ static int lan8841_probe(struct phy_device *phydev)
>  	ptp_priv->mii_ts.rxtstamp =3D lan8841_rxtstamp;
>  	ptp_priv->mii_ts.txtstamp =3D lan8814_txtstamp;
>  	ptp_priv->mii_ts.hwtstamp_set =3D lan8841_hwtstamp_set;
> +	ptp_priv->mii_ts.hwtstamp_get =3D lan8841_hwtstamp_get;
>  	ptp_priv->mii_ts.ts_info =3D lan8841_ts_info;
> =20
>  	phydev->mii_ts =3D &ptp_priv->mii_ts;



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

