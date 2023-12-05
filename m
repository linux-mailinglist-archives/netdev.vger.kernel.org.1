Return-Path: <netdev+bounces-53849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ABA804DF0
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE981F2133C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C2A3FB01;
	Tue,  5 Dec 2023 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0Aa4r5a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E0C9A
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 01:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701768780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmV5PIM8N+YASBRCp2k/i8/vJmd/O3Z/jDrIpMhsQ7o=;
	b=L0Aa4r5adRyLgL0crAikRJiUBccJAHkaKqCqdb2RZUUqPQlWxwA2qDWMwgOlbdtZVok3Lf
	vUE/W7iLCJTDsSudXbzn0XjpO48wevoJVjeJZLVAvs1Q+nYpEadazQ0+69eTueVqZOuh56
	3v3RC3ixYa0xUbLe4SnIUL8x59VgjEo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-XZNGdDv8PmyLVcmkoCQNJw-1; Tue, 05 Dec 2023 04:32:58 -0500
X-MC-Unique: XZNGdDv8PmyLVcmkoCQNJw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54c8febd0b0so234976a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 01:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768777; x=1702373577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KmV5PIM8N+YASBRCp2k/i8/vJmd/O3Z/jDrIpMhsQ7o=;
        b=DpkU+U0/E0CyMDtvvUl8p/pr5GL8L3M81KTvD30cfZoWdflW9KVxER6GAJtTiO381e
         7VXZPMohnZBG9e9Kb00Nzb8+08NoBoUcoQHe5tCtROT9qA8m1JmucPmDCQHo8u3h7B3J
         UWJoNHggC9DFE5+d0bCfHMhBH7BcdLq7tVpWd+i14OXcD11vQ6hShGaXv3FwnXZCI8cL
         cOr5MPZtnVPffnFTGG6egloEhUnn4NftSOVDgqDSO3Kwv86rrRervnISzUjhdGRKOwiG
         ZdounWNSP6lsBpq5jxeMgERhK14RVmj3vKEqm7bofBpe4iCf3kV2wIvfoHrdoAeAH+1t
         4Kzg==
X-Gm-Message-State: AOJu0YzfmU1bbeKUMVlnj5cG37s8YPHQPpwbfrOe1+ELSLHUyBv39LLP
	HDW57itSVA8DgMD1qF+m/D6Ai5tnLJf1c24xO6NzhGIbytMtk7wWdBCZZUKdLmhjO+LdMkIYkB7
	wNmVF6sIXcFYrVRnb
X-Received: by 2002:a05:6402:11cd:b0:54c:6fc0:483a with SMTP id j13-20020a05640211cd00b0054c6fc0483amr7715361edw.2.1701768777010;
        Tue, 05 Dec 2023 01:32:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrOiNCUmKVi/iGgzgG60YpzCBmx46bRetO9rs0qZVvKYqL4pzT2RAwtddwNEmm+Bl9ygdisQ==
X-Received: by 2002:a05:6402:11cd:b0:54c:6fc0:483a with SMTP id j13-20020a05640211cd00b0054c6fc0483amr7715346edw.2.1701768776687;
        Tue, 05 Dec 2023 01:32:56 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id z20-20020aa7d414000000b0054c49f1f207sm822636edq.39.2023.12.05.01.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:32:56 -0800 (PST)
Message-ID: <bdbe618d4fd38469e4e139ce4ebd161766f2e4d5.camel@redhat.com>
Subject: Re: [net-next PATCH v2 08/12] net: phy: at803x: move specific
 at8031 WOL bits to dedicated function
From: Paolo Abeni <pabeni@redhat.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 05 Dec 2023 10:32:55 +0100
In-Reply-To: <20231201001423.20989-9-ansuelsmth@gmail.com>
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
	 <20231201001423.20989-9-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-01 at 01:14 +0100, Christian Marangi wrote:
> Move specific at8031 WOL enable/disable to dedicated function to make
> at803x_set_wol more generic.
>=20
> This is needed in preparation for PHY driver split as qca8081 share the
> same function to toggle WOL settings.
>=20
> In this new implementation WOL module in at8031 is enabled after the
> generic interrupt is setup. This should not cause any problem as the
> WOL_INT has a separate implementation and only relay on MAC bits.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/at803x.c | 42 ++++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index 02ac71f98466..2de7a59c0faa 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -466,27 +466,11 @@ static int at803x_set_wol(struct phy_device *phydev=
,
>  			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
>  				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
> =20
> -		/* Enable WOL function for 1588 */
> -		if (phydev->drv->phy_id =3D=3D ATH8031_PHY_ID) {
> -			ret =3D phy_modify_mmd(phydev, MDIO_MMD_PCS,
> -					     AT803X_PHY_MMD3_WOL_CTRL,
> -					     0, AT803X_WOL_EN);
> -			if (ret)
> -				return ret;
> -		}
>  		/* Enable WOL interrupt */
>  		ret =3D phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_W=
OL);
>  		if (ret)
>  			return ret;
>  	} else {
> -		/* Disable WoL function for 1588 */
> -		if (phydev->drv->phy_id =3D=3D ATH8031_PHY_ID) {
> -			ret =3D phy_modify_mmd(phydev, MDIO_MMD_PCS,
> -					     AT803X_PHY_MMD3_WOL_CTRL,
> -					     AT803X_WOL_EN, 0);
> -			if (ret)
> -				return ret;
> -		}
>  		/* Disable WOL interrupt */
>  		ret =3D phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL,=
 0);
>  		if (ret)
> @@ -1611,6 +1595,30 @@ static int at8031_config_init(struct phy_device *p=
hydev)
>  	return at803x_config_init(phydev);
>  }
> =20
> +static int at8031_set_wol(struct phy_device *phydev,
> +			  struct ethtool_wolinfo *wol)
> +{
> +	int ret;
> +
> +	/* First setup MAC address and enable WOL interrupt */
> +	ret =3D at803x_set_wol(phydev, wol);
> +	if (ret)
> +		return ret;
> +
> +	if (wol->wolopts & WAKE_MAGIC)
> +		/* Enable WOL function for 1588 */
> +		ret =3D phy_modify_mmd(phydev, MDIO_MMD_PCS,
> +				     AT803X_PHY_MMD3_WOL_CTRL,
> +				     0, AT803X_WOL_EN);
> +	else
> +		/* Disable WoL function for 1588 */
> +		ret =3D phy_modify_mmd(phydev, MDIO_MMD_PCS,
> +				     AT803X_PHY_MMD3_WOL_CTRL,
> +				     AT803X_WOL_EN, 0);
> +
> +	return ret;

If I read correctly, the above changes the order of some WoL
initialization steps: now WOL_CTRL is touched after
AT803X_INTR_ENABLE_WOL. Is that correct?

Thanks,

Paolo


