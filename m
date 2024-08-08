Return-Path: <netdev+bounces-116750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFFF94B96E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F34C280F81
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7534189F31;
	Thu,  8 Aug 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="WVv/plnz"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62DD189BAF
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107741; cv=none; b=KLI3IJdvKFfg7kOGjYvzzlaXvbixscvIYiUrKxfsOgL9rRGhXEgy36XqtjgTasftzJRsvZzcSXPxAtuDFThv9p0JziZWU43TYjQXR7jCFgGSji8ZAiM0ehIJkuk8dchWVMgnaAn2q9JMcA/hIdUs8WvgFlSwEwZbkTVsAcFQLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107741; c=relaxed/simple;
	bh=bnGiOxSOwjh3dJGsVAusbPN8XZQhfG8sws2vVz0sB80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lo+s6Qwgv0BwvdUJ0Jd/IhfVDJJCv00kj3pqMeHd/q6jWZ/l5jSnnk7n+fhg4quJT7bamFJ8aBGVU5TRbcj4V4R2fRTqXl806L9b3VD6FVTPtQ+Ab8Q+25sQ2FGouAEyKlknthszUlyswvhj2FCXzA5IonMQaT0sHwW+xSCZ+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=WVv/plnz; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A1DB5871C7;
	Thu,  8 Aug 2024 11:02:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723107738;
	bh=OwHINITQpXWrLBHbgg1n5P9gtsGurji9agq0l7UT9CA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WVv/plnzP7wAsJL5QJz+AHALjMT93jVsAUj1HyVoid8C5l+4NuBiaUnPDJLa/YrRC
	 2nX6KiG/ykMpVCfLpZ+jLq9tIfMXlYbG1URIbh9orXG9bXH6u30uBKpPlHCRnwLN7K
	 eSSCweDIxvWLQJU7FqlamZHyDhaMjEW6nVr11oAK8lISKcMEDtkSGnYkgid2UQRs4L
	 0T/2Wm5YSaLRQ94+2Tzq3Pp4mcLY7Zy1yuBJpdzPrZ61i9EmzFF1WFTI8yKFvVz8lP
	 kuEX5GaW2uC4a5oPMiqkvCrCimsqk2HXM69p1/mEfwDdL+t1MSDxnaePVMJeQ8k+5d
	 cURocSVH1E0HQ==
Date: Thu, 8 Aug 2024 11:02:16 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Martin Whitaker <foss@martin-whitaker.me.uk>
Cc: netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 Woojung.Huh@microchip.com, o.rempel@pengutronix.de,
 Arun.Ramadoss@microchip.com, kuba@kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: disable EEE for
 KSZ8567/KSZ9567/KSZ9896/KSZ9897.
Message-ID: <20240808110216.20a1787c@wsk>
In-Reply-To: <20240807205209.21464-1-foss@martin-whitaker.me.uk>
References: <20240807205209.21464-1-foss@martin-whitaker.me.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NAgs1bVU6+s.g+bFKien2NI";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/NAgs1bVU6+s.g+bFKien2NI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

> As noted in the device errata [1-8], EEE support is not fully
> operational in the KSZ8567, KSZ9477, KSZ9567, KSZ9896, and KSZ9897
> devices, causing link drops when connected to another device that
> supports EEE. The patch series "net: add EEE support for KSZ9477
> switch family" merged in commit 9b0bf4f77162 caused EEE support to be
> enabled in these devices. A fix for this regression for the KSZ9477
> alone was merged in commit 08c6d8bae48c2. This patch extends this fix
> to the other affected devices.
>=20
> [1]
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDoc=
uments/Errata/KSZ8567R-Errata-DS80000752.pdf
> [2]
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDoc=
uments/Errata/KSZ8567S-Errata-DS80000753.pdf
> [3]
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDoc=
uments/Errata/KSZ9477S-Errata-DS80000754.pdf
> [4]
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDoc=
uments/Errata/KSZ9567R-Errata-DS80000755.pdf
> [5]
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDoc=
uments/Errata/KSZ9567S-Errata-DS80000756.pdf
> [6]
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDoc=
uments/Errata/KSZ9896C-Errata-DS80000757.pdf
> [7]
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDoc=
uments/Errata/KSZ9897R-Errata-DS80000758.pdf
> [8]
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDoc=
uments/Errata/KSZ9897S-Errata-DS80000759.pdf
>=20
> Fixes: 69d3b36ca045 ("net: dsa: microchip: enable EEE support") # for
> KSZ8567/KSZ9567/KSZ9896/KSZ9897 Link:
> https://lore.kernel.org/netdev/137ce1ee-0b68-4c96-a717-c8164b514eec@marti=
n-whitaker.me.uk/
> Signed-off-by: Martin Whitaker <foss@martin-whitaker.me.uk> ---
>  drivers/net/dsa/microchip/ksz_common.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c index
> b074b4bb0629..cebc6eaa932b 100644 ---
> a/drivers/net/dsa/microchip/ksz_common.c +++
> b/drivers/net/dsa/microchip/ksz_common.c @@ -2578,7 +2578,11 @@
> static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port) if
> (!port) return MICREL_KSZ8_P1_ERRATA;
>  		break;
> +	case KSZ8567_CHIP_ID:
>  	case KSZ9477_CHIP_ID:
> +	case KSZ9567_CHIP_ID:
> +	case KSZ9896_CHIP_ID:
> +	case KSZ9897_CHIP_ID:
>  		/* KSZ9477 Errata DS80000754C
>  		 *
>  		 * Module 4: Energy Efficient Ethernet (EEE) feature
> select must @@ -2588,6 +2592,13 @@ static u32
> ksz_get_phy_flags(struct dsa_switch *ds, int port)
>  		 *   controls. If not disabled, the PHY ports can
> auto-negotiate
>  		 *   to enable EEE, and this feature can cause link
> drops when
>  		 *   linked to another device supporting EEE.
> +		 *
> +		 * The same item appears in the errata for the
> KSZ9567, KSZ9896,
> +		 * and KSZ9897.
> +		 *
> +		 * A similar item appears in the errata for the
> KSZ8567, but
> +		 * provides an alternative workaround. For now, use
> the simple
> +		 * workaround of disabling the EEE feature for this
> device too. */
>  		return MICREL_NO_EEE;
>  	}
> --
> 2.41.1

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/NAgs1bVU6+s.g+bFKien2NI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAma0iZgACgkQAR8vZIA0
zr3bMgf/adUqznKzeRcpubvqF1bJKhrfj+8mcdI9q3elr4WR467JkqnLGgIFp0Z0
97NDH7ZzKQDRTSxl8hKOxL6OfOWV8zl+wQhUWDUeEa5qI6Uqc8MYwEGhz9AWQwe9
7R7gMx35nG0lae0L/w6VM1oy3ZhfdcOPLvR3OyX/tFrlOjdGGjbTgF1k+8NYHD5g
31YfWpStzfu/XqS34oGBSU1hCMbiVObHMLabSuMYArCrzD/Sw0V2BgOoq5tA+7mT
uyTTOqO5RAhXTg3LyLn4wwWdGTaopgtzTJiZR9IkbkJRswFneHuUgVUarGfGL7dc
2zC1sODUsbzB5/PpXdSki/N2qN/TxA==
=KZT6
-----END PGP SIGNATURE-----

--Sig_/NAgs1bVU6+s.g+bFKien2NI--

