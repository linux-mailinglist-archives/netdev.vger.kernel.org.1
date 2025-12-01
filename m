Return-Path: <netdev+bounces-242920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B91A7C96621
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 10:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D3A24E0582
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C42FDC23;
	Mon,  1 Dec 2025 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1WFrs/aK"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2F21420B
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581611; cv=none; b=X9EcmmKMabbuL0JJLo4+SYjVOMVAoh63iP9oXjPIrDrApXS3B/wExP57Pbn+28PRyA6YfTWDWu5Bk1twMkUvREQ3M76sJ/eEiIPIZyds2atag9moWZ7NtoynykKCqQWGBrl3k/EpmB6cuHLpzuQh1Hh5JuT65Nq76iFkr/T6vMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581611; c=relaxed/simple;
	bh=fx9P8wuCcN8SmBCrze3qDsSOYpo0BMetky+HDL4ewZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3IQO/PvC2uhjeXjY3fqkxOyWOPV6UtzCZo5RuZc05puRR/rkHfjctr5sORc+ma5+wbfVe+8UIW5NfkN0OYiZjxSFRkjg7JuyV6yxDftIkh757/Kxo6tXRVFBnoj79PUriORk2+1pL+mGTzvQVdLDZ4XUANRiWQhS9JKT+s7ikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1WFrs/aK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D99681A1E7E;
	Mon,  1 Dec 2025 09:33:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE573606BB;
	Mon,  1 Dec 2025 09:33:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F31EF11912400;
	Mon,  1 Dec 2025 10:33:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764581606; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dK/RYzvBc4277Jzcb9K/KT/ziQZZW74uGFbwvi9l2h4=;
	b=1WFrs/aKy42phRaolDxSdqQd8YMfQsXzHhltGTAvrdTZ23OJxcd/gvUC2ideBn1yUMWX/K
	8eWpUvTKK+ZDisg5GOX+5xyvKZF32EcQFBiN8lmCykamOLdq7BFZ/k5dSmeCx8rym7kGhd
	jczgLwkyGT4+ZlXHFy66I5y78JMOcZa3WrKcTjRhzDt5LOxHfWeqsM0wi4xjht+85JF/Ec
	nFbsTrR6f2V0Z+Gnl0GisTs7j38iHP0OBLNLPgnvFFJ3VOBbd51PM1Od8rZwa6XrwSQW10
	WwO8W0rSMWpKItObzOOmPkQ86D295tvbjRr64Entc/5jMVv7fj8OkULHA6LlXw==
Date: Mon, 1 Dec 2025 10:33:21 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Simon
 Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob
 Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: phy: micrel: improve HW
 timestamping config logic
Message-ID: <20251201103321.47cb4ceb@kmaincent-XPS-13-7390>
In-Reply-To: <20251129195334.985464-2-vadim.fedorenko@linux.dev>
References: <20251129195334.985464-1-vadim.fedorenko@linux.dev>
	<20251129195334.985464-2-vadim.fedorenko@linux.dev>
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

On Sat, 29 Nov 2025 19:53:31 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver was adjusting stored values independently of what was
> actually supported and configured. Improve logic to store values
> once all checks are passing
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/phy/micrel.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 05de68b9f719..1ada05dd305c 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -3157,9 +3157,6 @@ static int lan8814_hwtstamp_set(struct mii_timestam=
per
> *mii_ts, int txcfg =3D 0, rxcfg =3D 0;
>  	int pkt_ts_enable;
> =20
> -	ptp_priv->hwts_tx_type =3D config->tx_type;
> -	ptp_priv->rx_filter =3D config->rx_filter;
> -
>  	switch (config->rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		ptp_priv->layer =3D 0;
> @@ -3187,6 +3184,18 @@ static int lan8814_hwtstamp_set(struct mii_timesta=
mper
> *mii_ts, return -ERANGE;
>  	}
> =20
> +	switch (config->rx_filter) {

You want to check tx_type here, not rx_filter.

> +	case HWTSTAMP_TX_OFF:
> +	case HWTSTAMP_TX_ON:
> +	case HWTSTAMP_TX_ONESTEP_SYNC:
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	ptp_priv->hwts_tx_type =3D config->tx_type;
> +	ptp_priv->rx_filter =3D config->rx_filter;
> +
>  	if (ptp_priv->layer & PTP_CLASS_L2) {
>  		rxcfg =3D PTP_RX_PARSE_CONFIG_LAYER2_EN_;
>  		txcfg =3D PTP_TX_PARSE_CONFIG_LAYER2_EN_;
> @@ -5051,9 +5060,6 @@ static int lan8841_hwtstamp_set(struct mii_timestam=
per
> *mii_ts, int txcfg =3D 0, rxcfg =3D 0;
>  	int pkt_ts_enable;
> =20
> -	ptp_priv->hwts_tx_type =3D config->tx_type;
> -	ptp_priv->rx_filter =3D config->rx_filter;
> -
>  	switch (config->rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		ptp_priv->layer =3D 0;
> @@ -5081,6 +5087,9 @@ static int lan8841_hwtstamp_set(struct mii_timestam=
per
> *mii_ts, return -ERANGE;
>  	}
> =20
> +	ptp_priv->hwts_tx_type =3D config->tx_type;
> +	ptp_priv->rx_filter =3D config->rx_filter;

I there a reason to not add the check in the hwtstamp ops for lan8841 as we=
ll?
because the issue is also present.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

