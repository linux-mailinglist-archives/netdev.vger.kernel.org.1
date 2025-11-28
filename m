Return-Path: <netdev+bounces-242531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F94C917CA
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 10:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A70AE4E2D99
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B923330507E;
	Fri, 28 Nov 2025 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hRJ/n4WJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DC617736
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322934; cv=none; b=GEFi7Azb4ksZ7sigw5tvU5Ev85/kji1lJ8U6z/6owK5rxMe9zVUjL2CjA/wGUooVUXgMPCDKBwiGd0I+ie4702RHYfd4o0YlrRgFkYbKvjjxGfuibcNOuN+SZygTPVMhuOIPIGtp16g9NWGrQbt4T2zj/uKwnmWylm9b7mdRIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322934; c=relaxed/simple;
	bh=eguvVuFTb5erkQcXUlXAuM+wpFWHAT4U/nzSD7V9iGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhsEcJ4hooSlbu2yCWjlztFyn2OkNnBq7eBahER+dJou0bCuQgVCgqJCkNNH5n/RB1Kht9OkVfZcmkCyoobU1d7Yxif6wagyCf9OiBtXKKJOsbwBD6HhamNRXWG6QnVVUxirKz2yQfI8dl55ZvKjsepOTkGMfiVP6bLvXLuTW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hRJ/n4WJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4142C1A1DFB;
	Fri, 28 Nov 2025 09:42:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 141B660706;
	Fri, 28 Nov 2025 09:42:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6448103C8F63;
	Fri, 28 Nov 2025 10:42:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764322929; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Oyy5lXXtjli4NPNnXaTo7F8VObMfhMfoIMl2ZuA0ezo=;
	b=hRJ/n4WJH47TkI6k6507FmjwC328r6bNs7ssGFPIKXizvELFCEj4cdvMeFoy3xuqG8CrjW
	1Iu2IxCgUla+UYXERcBRpHkwaTxGowrMw09AkmgIu65Eo2LqudMtmGQP6xemV6TqBo7PRH
	yja7Bzhi8AfSNZqn4Gk/ElkMfodgMC1NOtOZKw9/YOWuR9tucHK1fu+mK3pvHe6WpbdvsM
	s3lHVlo/DTDYjpXDJGW3E36Tms6idYfTQdPdtMv8k94emFYfE6ymD/RwbyD3gliorH6Jc+
	jEHs7vguGOCC7MKzTtDVr6GhndwZCNJ3BBaIKj4XaFLbj06Xl7paYJgnXnrkMA==
Date: Fri, 28 Nov 2025 10:41:59 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Simon
 Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob
 Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: micrel: improve HW timestamping
 config logic
Message-ID: <20251128104159.0756d624@kmaincent-XPS-13-7390>
In-Reply-To: <20251127211245.279737-2-vadim.fedorenko@linux.dev>
References: <20251127211245.279737-1-vadim.fedorenko@linux.dev>
	<20251127211245.279737-2-vadim.fedorenko@linux.dev>
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

On Thu, 27 Nov 2025 21:12:42 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver was adjusting stored values independently of what was
> actually supported and configured. Improve logic to store values
> once all checks are passing
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/phy/micrel.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 05de68b9f719..2c9a17d4ff18 100644
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
> @@ -3187,6 +3184,9 @@ static int lan8814_hwtstamp_set(struct mii_timestam=
per
> *mii_ts, return -ERANGE;
>  	}
> =20
> +	ptp_priv->hwts_tx_type =3D config->tx_type;
> +	ptp_priv->rx_filter =3D config->rx_filter;
> +
>  	if (ptp_priv->layer & PTP_CLASS_L2) {
>  		rxcfg =3D PTP_RX_PARSE_CONFIG_LAYER2_EN_;
>  		txcfg =3D PTP_TX_PARSE_CONFIG_LAYER2_EN_;

There is still an issue with tx_type.
HWTSTAMP_TX_ONESTEP_P2P is not supported but the driver does not return -ER=
ANGE
if we try to set it. Could you add also this check?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

