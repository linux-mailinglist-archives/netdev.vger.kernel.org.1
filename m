Return-Path: <netdev+bounces-242533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA806C9184E
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 10:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9593A755C
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C0D30595B;
	Fri, 28 Nov 2025 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GeflDWx2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573922D3A86
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323457; cv=none; b=GXqkFNMEoJVnE/RIM+Xp1IjtnYFH9AgSF+65FSYF5w2JK5v1zT3/0oLcc2KBnVvt8g0SGwMQ5OBZp+rfgxAjz7pw0nxi2+ujSp7giseut7ZBYIg81wH/pkJYjMJ/SzVaCyqcTabzMIuyey4c1RvT7csBUweVFCWspUAGoALZFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323457; c=relaxed/simple;
	bh=MxRQMC/csO26wXumR4P5HS75oQrKW0J/vFcosq9jcTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpC72CZB/22oZjVUVEgDuVCW0N1mcRPUVqbXMjtwkwOF2qvtFHCcwbN5/ypIjLukcgDODRGBbbypiNBxVC43194QEtKkwJ+YxyNJVCc31syScOteWmYfd2hW6TaWl73jk+bN6mqt0LBIORVrbGzTGisFtLpomZ5PFrca9R7I21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GeflDWx2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E89FB4E41942;
	Fri, 28 Nov 2025 09:50:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BD9C660706;
	Fri, 28 Nov 2025 09:50:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88B9D103C8F28;
	Fri, 28 Nov 2025 10:50:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764323452; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RauHCwsO7DcER+doO2d2KM9ZqaEGyUuni4ugyGwsje8=;
	b=GeflDWx2Gj9iUyjyvXh58zA3IdUdVQTrDEHQ0i+ztiY8QTG1x7qdR7sz4dz6OW2xCEPcA+
	+X+hDa5EEmpHxc7M6MBALUbkQ/QpWpQRWxvGdbhThz0Qwp5unRtS9EXavWKbXrPiLDgknM
	JL5GLTJfpQbZ2QSu7GapYuZ+E9/ofCHoubojz00Cadf9ED/Zd39rZ3J+lZii8M16I19n1v
	Kq3SMxufR6JZTdqy1Zs8/i/fAslI4lWYlQwxPcxuWfL7kEbraDclk5qQTBwf3mImYtMOjJ
	l4NjQEdONT2XEg4GoCQHJjllvK44C7qJoK7XqG3L9ESctN12InJZEtJuCOB9iQ==
Date: Fri, 28 Nov 2025 10:50:47 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Simon
 Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob
 Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: phy: microchip_rds_ptp: improve HW ts
 config logic
Message-ID: <20251128105047.5e54f463@kmaincent-XPS-13-7390>
In-Reply-To: <20251127211245.279737-4-vadim.fedorenko@linux.dev>
References: <20251127211245.279737-1-vadim.fedorenko@linux.dev>
	<20251127211245.279737-4-vadim.fedorenko@linux.dev>
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

On Thu, 27 Nov 2025 21:12:44 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver stores new HW timestamping configuration values
> unconditionally and may create inconsistency with what is actually
> configured in case of error. Improve the logic to store new values only
> once everything is configured.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/phy/microchip_rds_ptp.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/phy/microchip_rds_ptp.c
> b/drivers/net/phy/microchip_rds_ptp.c index 4c6326b0ceaf..6b0933ef9142 10=
0644
> --- a/drivers/net/phy/microchip_rds_ptp.c
> +++ b/drivers/net/phy/microchip_rds_ptp.c
> @@ -488,9 +488,6 @@ static int mchp_rds_ptp_hwtstamp_set(struct
> mii_timestamper *mii_ts, unsigned long flags;
>  	int rc;
> =20
> -	clock->hwts_tx_type =3D config->tx_type;
> -	clock->rx_filter =3D config->rx_filter;
> -
>  	switch (config->rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		clock->layer =3D 0;
> @@ -553,7 +550,7 @@ static int mchp_rds_ptp_hwtstamp_set(struct
> mii_timestamper *mii_ts, if (rc < 0)
>  		return rc;
> =20
> -	if (clock->hwts_tx_type =3D=3D HWTSTAMP_TX_ONESTEP_SYNC)
> +	if (config->tx_type =3D=3D HWTSTAMP_TX_ONESTEP_SYNC)
>  		/* Enable / disable of the TX timestamp in the SYNC frames */
>  		rc =3D mchp_rds_phy_modify_mmd(clock, MCHP_RDS_PTP_TX_MOD,
>  					     MCHP_RDS_PTP_PORT,
> @@ -587,8 +584,13 @@ static int mchp_rds_ptp_hwtstamp_set(struct
> mii_timestamper *mii_ts, /* Now enable the timestamping interrupts */
>  	rc =3D mchp_rds_ptp_config_intr(clock,
>  				      config->rx_filter !=3D
> HWTSTAMP_FILTER_NONE);
> +	if (rc < 0)
> +		return rc;
> =20
> -	return rc < 0 ? rc : 0;
> +	clock->hwts_tx_type =3D config->tx_type;
> +	clock->rx_filter =3D config->rx_filter;

Same here, there is no check over HWTSTAMP_TX_ONESTEP_P2P. You should add
capabilities check.

Regards,

> +	return 0;
>  }
> =20
>  static int mchp_rds_ptp_ts_info(struct mii_timestamper *mii_ts,



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

