Return-Path: <netdev+bounces-240031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D07DC6F819
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC2873C1CD8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0834230BE9;
	Wed, 19 Nov 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0rlftSN7"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D7D32FA3A
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563741; cv=none; b=JkZMb4uMJRrEpwVwqjf0AS+qGwNVNkdXXxNu/zWNFPQlU5Ab8wuDYcPev4CxLgmJO0Flg5n6eIUCIgQYxtPriTfOdX2t67HwGTCX8eZTuP3G9qIjz3BzIfqoGSAooTHvOtzf+KdG0i6q9W8lQRnH7X5n8i8WoifEDpa1zT+Xl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563741; c=relaxed/simple;
	bh=4doQAZ3M6jgNMwmbVqioze/lt7kV28IHt2RBrCvbT1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohTVSb1fD70MjPJYHudRV74tdnspg3f+zVE905kARqRo44XgDc7aP3gD/8UwVYqXPCJi4tEVY//hA37sP656JbVpifzqUJHgwgsCTp4ZU1ABEA06mWgUUI2mAkxJpbZiRDwwISQg9Kq4qmoBa8mxsZD4zXz0Q441iH7muH1pKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0rlftSN7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A29691A1BE0;
	Wed, 19 Nov 2025 14:48:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7841B60699;
	Wed, 19 Nov 2025 14:48:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 680D210371A76;
	Wed, 19 Nov 2025 15:48:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763563736; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jA8L2HvZw9grqfqPEky3uIhcmboT88C0Yg/E0L+M6uM=;
	b=0rlftSN7bG6qGW92GTgcw1GY8ImUkRx+HiCBF2GrensuuL4gCAwd2Ue5PdRsSZNNOSvXtM
	13fr9gSFrSEeZ3UU8nVGLHn9p0MJbizkl59nD33OAbGXbcE+6RBSKcA4PUyE+xXwEIzA+H
	pl0ahun64ACbMM5tXSQSJ4yu/1aB4PBNrTiVhJZ/lsHSPFYw27uQlrn1EAks2Uqzv+H208
	ldy8SjP0XZtHATC9jP0pHXQeg13J8VZ7MpdzUOVGWm1UIUHGO0vBz8h15t6DSQREilcFK0
	79muOfY8zCZr2x8WAT6YDpalNlJKfJsgF7+e1mfUzQxL+gR3O6Zbqnc8qMipmA==
Date: Wed, 19 Nov 2025 15:48:52 +0100
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
Subject: Re: [PATCH net-next v3 7/9] phy: mscc: add HW timestamp
 configuration reporting
Message-ID: <20251119154852.16e3a2f4@kmaincent-XPS-13-7390>
In-Reply-To: <20251119124725.3935509-8-vadim.fedorenko@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
	<20251119124725.3935509-8-vadim.fedorenko@linux.dev>
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

On Wed, 19 Nov 2025 12:47:23 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver stores HW configuration and can technically report it.
> Add callback to do it.

The hwtstamp_set ops of this driver is well written!
Setting vsc8531->ptp->tx_type and vsc8531->ptp->rx_filter after the switch
condition.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/phy/mscc/mscc_ptp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_=
ptp.c
> index dc06614222f6..4865eac74b0e 100644
> --- a/drivers/net/phy/mscc/mscc_ptp.c
> +++ b/drivers/net/phy/mscc/mscc_ptp.c
> @@ -1051,6 +1051,18 @@ static void vsc85xx_ts_reset_fifo(struct phy_device
> *phydev) val);
>  }
> =20
> +static int vsc85xx_hwtstamp_get(struct mii_timestamper *mii_ts,
> +				struct kernel_hwtstamp_config *cfg)
> +{
> +	struct vsc8531_private *vsc8531 =3D
> +		container_of(mii_ts, struct vsc8531_private, mii_ts);
> +
> +	cfg->tx_type =3D vsc8531->ptp->tx_type;
> +	cfg->rx_filter =3D vsc8531->ptp->rx_filter;
> +
> +	return 0;
> +}
> +
>  static int vsc85xx_hwtstamp_set(struct mii_timestamper *mii_ts,
>  				struct kernel_hwtstamp_config *cfg,
>  				struct netlink_ext_ack *extack)
> @@ -1612,6 +1624,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
>  	vsc8531->mii_ts.rxtstamp =3D vsc85xx_rxtstamp;
>  	vsc8531->mii_ts.txtstamp =3D vsc85xx_txtstamp;
>  	vsc8531->mii_ts.hwtstamp_set =3D vsc85xx_hwtstamp_set;
> +	vsc8531->mii_ts.hwtstamp_get =3D vsc85xx_hwtstamp_get;
>  	vsc8531->mii_ts.ts_info  =3D vsc85xx_ts_info;
>  	phydev->mii_ts =3D &vsc8531->mii_ts;
> =20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

