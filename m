Return-Path: <netdev+bounces-240028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBADC6F75E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8E25F303CE
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B79366DDC;
	Wed, 19 Nov 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dvgZ6xwO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B893283FC9
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563573; cv=none; b=qoyCM9zs7vCu885e+ak6MKUN102tre5N4CLiKEOfEurJU/7+JQRUVPb2wTXdK2UyH+aXC04+2guLU/PhL2daNKNEYpkpE2nVTPfwkKiFVbFUVi0A+hgWGo/Mi8jCOSebMrGYKTQ0EqDKz6or4mwZoMZL5D0fq16Fa5Bk1rjZBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563573; c=relaxed/simple;
	bh=36NwsHghWkuAuwcythUBqzBZMfnNkNcH2jtU86TLEpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKcpuL/gLBpQRE1AZvLU6aCzpEvKSLc5LNjghBnqeOZfM2L84NneIi70baUaELTyi9qiGhDrpQtjBRZSFSCaxXSQLJEUZ4Q8Mpn34wuSDlUImztLF0HdLcYnigjDJm7kJ7aT8IVboEPz3MoDUcgXXjv2lnQaoukY0SDVpIqauTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dvgZ6xwO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CC1414E417A5;
	Wed, 19 Nov 2025 14:46:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A161C60699;
	Wed, 19 Nov 2025 14:46:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BB0110371A6A;
	Wed, 19 Nov 2025 15:46:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763563568; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wqK434lY254Z2JI7UE1pQ2daMFPpjCixqjp1to8GALA=;
	b=dvgZ6xwOZgE6bg3MeGM3HCKI1c3ffuPZnhqbwPoprB8BkVNvcATvWrYGZIWNWWC4TF0bLV
	QTa8C+lD3way/Mesc6X4mfLBfauGLA3/NyOeHOLXDN+ptHjDtt2tv9NlBG0JbTstPOn35V
	dh/6ZBa25wR/S27QPsUQtzZDEgs9t8YGHR7igHG2st6St02sTJmKePKdZHwDn2AjGmd1YH
	iKA9a3Ncgs1TWDzjJU08OlqSoNbEDJX69yGu3l8Q4WY/VX3EixDf71dcH4v1SBvdkiYt12
	goDi3ilyTvcWMq0IBOaiRzM49DO0ZRXsH95rahRtSzMshRnr7aCPUsV9nly37Q==
Date: Wed, 19 Nov 2025 15:46:04 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrei Botila
 <andrei.botila@oss.nxp.com>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/9] net: phy: microchip_rds_ptp: add HW
 timestamp configuration reporting
Message-ID: <20251119154604.564ae00d@kmaincent-XPS-13-7390>
In-Reply-To: <20251119124725.3935509-7-vadim.fedorenko@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
	<20251119124725.3935509-7-vadim.fedorenko@linux.dev>
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

On Wed, 19 Nov 2025 12:47:22 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver stores HW timestamping configuration and can technically
> report it. Add callback to do it.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/phy/microchip_rds_ptp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/net/phy/microchip_rds_ptp.c
> b/drivers/net/phy/microchip_rds_ptp.c index 4c6326b0ceaf..d2beb3a2e6c3 10=
0644
> --- a/drivers/net/phy/microchip_rds_ptp.c
> +++ b/drivers/net/phy/microchip_rds_ptp.c
> @@ -476,6 +476,18 @@ static bool mchp_rds_ptp_rxtstamp(struct mii_timesta=
mper
> *mii_ts, return true;
>  }
> =20
> +static int mchp_rds_ptp_hwtstamp_get(struct mii_timestamper *mii_ts,
> +				     struct kernel_hwtstamp_config *config)
> +{
> +	struct mchp_rds_ptp_clock *clock =3D
> +				container_of(mii_ts, struct
> mchp_rds_ptp_clock,
> +					     mii_ts);
> +	config->tx_type =3D clock->hwts_tx_type;
> +	config->rx_filter =3D clock->rx_filter;

Same issue as patch 5.

> +
> +	return 0;
> +}
> +
>  static int mchp_rds_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
>  				     struct kernel_hwtstamp_config *config,
>  				     struct netlink_ext_ack *extack)
> @@ -1282,6 +1294,7 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct
> phy_device *phydev, u8 mmd, clock->mii_ts.rxtstamp =3D mchp_rds_ptp_rxtst=
amp;
>  	clock->mii_ts.txtstamp =3D mchp_rds_ptp_txtstamp;
>  	clock->mii_ts.hwtstamp_set =3D mchp_rds_ptp_hwtstamp_set;
> +	clock->mii_ts.hwtstamp_get =3D mchp_rds_ptp_hwtstamp_get;
>  	clock->mii_ts.ts_info =3D mchp_rds_ptp_ts_info;
> =20
>  	phydev->mii_ts =3D &clock->mii_ts;



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

