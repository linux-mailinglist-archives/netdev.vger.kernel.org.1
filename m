Return-Path: <netdev+bounces-70147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE03984DDE2
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A559528D590
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388926BFDD;
	Thu,  8 Feb 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="denpnWJZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB46BB4B
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387158; cv=none; b=DMP1eOV/88UJObv7eVDcbbmKg83u6g5qO+bNA8baoInC2Vzrh5/cTHc4P+Toqhh5jsHGtGdyqx7SVQIiaB1VAHv6lQR9D7jApbx5tlcvRwS7/3hoiw1RbmZL+88lUJ5/Rv4jwnY7xJvkKko0v1jhzLHOCeFaNeCezOWpS50gU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387158; c=relaxed/simple;
	bh=PEWJ09jifRFAAlLjcVc4iKAqSR7wR85dz0SRx0aVLSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KeVLbWcIzNqx0feQpl7FjFekLYFLw7YMZmtmQSQ3p6/q11Xz0pF6O8+pvPY/0IO7DOT8S2l7lbKto1dzSDwLtRAMk2N6spS4QMt/NXABZBUuMRZ39gE2kU4zBX59/TScWVy0l2ZD00PeRes908eSQGYj0tcd+rtoGH9N7UsbOt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=denpnWJZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707387155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2xFFELdl4FuzvLcR7hSHd94J0Sm6euURDyqSxsU4JA4=;
	b=denpnWJZBZ8UZA9b3QVfXJzlFVCZOcoXhZlfXHvhWS3Uaqp4OocxAqau7iqvS3Cr5iGhFG
	HK6xUf7/vMHuI4nzGoF/2WRqjI/jTN2HqRCQNQdEr0j8VCHCIKIZd97kvRcjFBW0clNmim
	H0/9wVe0kHjOfSLfb5wvjZilPn2SBuI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-AWhUyQnjM-al177VmVkunA-1; Thu, 08 Feb 2024 05:12:33 -0500
X-MC-Unique: AWhUyQnjM-al177VmVkunA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40efaee41dbso1015765e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 02:12:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707387150; x=1707991950;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xFFELdl4FuzvLcR7hSHd94J0Sm6euURDyqSxsU4JA4=;
        b=b6qIGBWQYf6oNzp8OZwuG2oyGRlkvHMh4Q0+0XO8jX4olre8B5gIbpPchstILu7Utl
         L4SoKuCCmx8vHpXkjhYBjPP/O6JDnB7uFiHHtFZsdpL2+/2TVwU0BxsL5VOUXN5PmtV9
         OYfGGPyJaAt2U6ERreihJGX42ul8tu8bBKgFpnBRd/fAJhGb1LGnuM0zzwLa7cUY5HkW
         4Srd1h8FxyRjPQtFbDLPN4NJohwn0YnXw0Y/VzFWvZlKUtX47Vk2XF4JQ+zCPaeaVxOr
         /M1WO3T7VisPXzBqrVyQmu35ktGcMpsgzO18tWh5UqxjKzi6xiiohS7bjRZwHqyI+2wq
         /utA==
X-Gm-Message-State: AOJu0YyyUGudlUMSfQvnThR6e4pbyFKoMImD91KIfoj3q0uz2Rf54hqp
	/T4vgBI0q7lzG+bvoo+Ou204sBcCRvaaY7/yntsMNWes0FRa5U8r1PBDQeNkDuNEAhaSZkVplM7
	5T3DxG+cGXiP8d0LFejohm+ro4Pbd6MPp1nILiuS0S1oi+lEqswGAOg==
X-Received: by 2002:a05:600c:1d07:b0:40f:c996:307f with SMTP id l7-20020a05600c1d0700b0040fc996307fmr6728391wms.3.1707387150294;
        Thu, 08 Feb 2024 02:12:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH78/GRltwIxEgIU+8Y7+NU4Q4kqElIeGIOwpokqq1fSu2KdOgrVrhKBlh9KprEw1Zrt0zakA==
X-Received: by 2002:a05:600c:1d07:b0:40f:c996:307f with SMTP id l7-20020a05600c1d0700b0040fc996307fmr6728375wms.3.1707387149932;
        Thu, 08 Feb 2024 02:12:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnsIxnq53mDLozbjJ3fZAb8+suXi7BF8TSIURB8mIK8DOG9FXPIZfU3FXRaSoS8XmbleXl0vluyFQEmyQhvG5V9yejM7Ii8Z9CPrIsiW2dPuWnNFixWc8KrgrkIEuHcy9dSTGcxJKth2bGEXzsJd/2A4MHwDQAVwyNpdp81G/Tj/vOaTCXgtDltgPrUeNt8p5cmEE3cePb6c+Tf3EXc8KmrW4WKq5G8BfjS1ZFLpk/5iAIvedV/Z8/ocL6gahj10uapy+c9Xg/Rqv0RxX1UyDyxDBISQtJ
Received: from gerbillo.redhat.com (146-241-238-112.dyn.eolo.it. [146.241.238.112])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c138c00b004100c0882fdsm1170260wmf.31.2024.02.08.02.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:12:29 -0800 (PST)
Message-ID: <63d59bff272f572c94f97000475c4ac3e157c013.camel@redhat.com>
Subject: Re: [PATCH v2] net: phy: dp83822: Fix RGMII TX delay configuration
From: Paolo Abeni <pabeni@redhat.com>
To: Tim Pambor <tp@osasysteme.de>, Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Dan Murphy
 <dmurphy@ti.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2024 11:12:28 +0100
In-Reply-To: <20240204101128.49336-1-tp@osasysteme.de>
References: <20240204101128.49336-1-tp@osasysteme.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-04 at 11:11 +0100, Tim Pambor wrote:
> The logic for enabling the TX clock shift is inverse of enabling the RX
> clock shift. The TX clock shift is disabled when DP83822_TX_CLK_SHIFT is
> set. Correct the current behavior and always write the delay configuratio=
n
> to ensure consistent delay settings regardless of bootloader configuratio=
n.
>=20
> Reference: https://www.ti.com/lit/ds/symlink/dp83822i.pdf p. 69
>=20
> Fixes: 8095295292b5 ("net: phy: DP83822: Add setting the fixed internal d=
elay")
> Signed-off-by: Tim Pambor <tp@osasysteme.de>
> ---
> Changes in v2:
>   - Further cleanup of RGMII configuration

This overall makes the change more invasive, I'm unsure is in the
direction pointed by Russell

>   - Check for errors setting DP83822_RGMII_MODE_EN
> ---
>  drivers/net/phy/dp83822.c | 41 +++++++++++++--------------------------
>  1 file changed, 14 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> index b7cb71817780..1b2c34a97396 100644
> --- a/drivers/net/phy/dp83822.c
> +++ b/drivers/net/phy/dp83822.c
> @@ -380,42 +380,29 @@ static int dp83822_config_init(struct phy_device *p=
hydev)
>  {
>  	struct dp83822_private *dp83822 =3D phydev->priv;
>  	struct device *dev =3D &phydev->mdio.dev;
> -	int rgmii_delay;
> -	s32 rx_int_delay;
> -	s32 tx_int_delay;
> +	int rcsr_mask =3D DP83822_RGMII_MODE_EN;
> +	int rcsr =3D 0;
>  	int err =3D 0;
>  	int bmcr;
> =20
>  	if (phy_interface_is_rgmii(phydev)) {
> -		rx_int_delay =3D phy_get_internal_delay(phydev, dev, NULL, 0,
> -						      true);
> +		rcsr |=3D DP83822_RGMII_MODE_EN;
> =20
> -		if (rx_int_delay <=3D 0)
> -			rgmii_delay =3D 0;
> -		else
> -			rgmii_delay =3D DP83822_RX_CLK_SHIFT;
> +		/* Set DP83822_RX_CLK_SHIFT to enable rx clk internal delay */
> +		if (phy_get_internal_delay(phydev, dev, NULL, 0, true) > 0)
> +			rcsr |=3D DP83822_RX_CLK_SHIFT;
> =20
> -		tx_int_delay =3D phy_get_internal_delay(phydev, dev, NULL, 0,
> -						      false);
> -		if (tx_int_delay <=3D 0)
> -			rgmii_delay &=3D ~DP83822_TX_CLK_SHIFT;
> -		else
> -			rgmii_delay |=3D DP83822_TX_CLK_SHIFT;
> +		/* Set DP83822_TX_CLK_SHIFT to disable tx clk internal delay */
> +		if (phy_get_internal_delay(phydev, dev, NULL, 0, false) <=3D 0)
> +			rcsr |=3D DP83822_TX_CLK_SHIFT;
> =20
> -		if (rgmii_delay) {
> -			err =3D phy_set_bits_mmd(phydev, DP83822_DEVADDR,
> -					       MII_DP83822_RCSR, rgmii_delay);
> -			if (err)
> -				return err;
> -		}
> -
> -		phy_set_bits_mmd(phydev, DP83822_DEVADDR,
> -					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
> -	} else {
> -		phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
> -					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
> +		rcsr_mask |=3D DP83822_RX_CLK_SHIFT | DP83822_TX_CLK_SHIFT;

It looks like there is a change of behavior here. The current code
clear the DP83822_RGMII_MODE_EN, while this patch will clear
DP83822_RX_CLK_SHIFT | DP83822_TX_CLK_SHIFT, leaving
DP83822_RGMII_MODE_EN unmodified.

It does not look correct to me.

Cheers,

Paolo


