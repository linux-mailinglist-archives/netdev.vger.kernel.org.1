Return-Path: <netdev+bounces-169629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05873A44DDA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7DD164EE2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1C7212FAA;
	Tue, 25 Feb 2025 20:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxU9dIlL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D70D20DD71
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 20:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515810; cv=none; b=JIHCigllsyceipb2Fw4X2LQNR1dCFBBiu5ajufXeOT0LvY5SSVgsYOGsbOzjeq/TpyEGDOgrv+lxvg9vXYvSvOojUoHxHmFOVVkSy1DN04vASU5QGlbAk8ZvXkX5jGsu6+eWk+/A+Hawhi93vSYX59CEuWl4nP3Grr4vwKOqxYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515810; c=relaxed/simple;
	bh=UCjaUYNwA7gkdeo7z/kfqp3ddYxARZ2+9UWe4SoPsMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiLWnzDvZOQmH8W4YMJH5dDuNXlVUPpFE/xU8m9vJxRZ61wteZhrI0l2jZlLJqCe7705anCyMNCsm0rUm9lQLQlsiJFEB0nF0IAq4O90/+RlSBvRzhzN5V4EmM8iZkE4V7MVCLjyY29bRe7Dw44gq7SzuSqNZz5Y91W1shbBMzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxU9dIlL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb999658fbso751363566b.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740515806; x=1741120606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4QFWKkvK1MfnhL/90Bgctff+RTyO4G/8PgMsyHu6Bc=;
        b=TxU9dIlLqf2xVlPemaSZ4KRY0Q3d0ER8NULwWEf3REfAMGZiPXgRdEMex5LWRsxR0b
         vK/0yIdhucLIBV11c7CEHTSjdXH4bcUeoWqMwB25heXaKPoT4W/zosftOnnMcJWe96M1
         6trh7I0MQh+662U8oBRrzq8czrjbpw9xNDjlfhbwLbEoAOgIm5gKSQEbO/NMf/5OrECm
         l1lWuF5Gxyn55yKA3JrZWUQAujyzxYlzqupoMSqa9/HABl75Pp7vyzzBxP9vBQozoohe
         xhx20uUznOksjG9qVO3pj2/IKqwlUTPiP0rh4R7loxR77hhyZB/v87GhOVr7MkT7sAka
         UGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515806; x=1741120606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4QFWKkvK1MfnhL/90Bgctff+RTyO4G/8PgMsyHu6Bc=;
        b=tqW3oMRmSee8Dbz0JgG2tR7WXI0GsL8xuLjbY+rFOCqiuC0GwoAMBcm3EbyHd7j1Zs
         KOurDgRb5Uv4w1tfiz/trKqLmoELuUxWlazKWVuU34rUJUPb/NSYnS4+OQbuSyJ80lu+
         KlHrwZZhQ4Gmnh/0OAxiEQFSiayhpcKnagOUGKB497iNlzhQVDaEND0SI9dPpS+Y6ugs
         phhcrKXlWyFZMPL0nlsOV9LCVklq4Lwu/m8ecbIIec04GyK69buiXnF8OKRFmvZOHcYq
         CtSkfHA4D0Tam08qgA223Oc3dDeoEhOWQzX/tIOYygJQXLLB45XsnC0/JN0ZIGk8qOkn
         EhZg==
X-Forwarded-Encrypted: i=1; AJvYcCWxi2ODznXN/RccfJfO76UQY69gd1gODiBtu2KLEDOSQB6CLpCALHK7NpoDuFMm4s0ip1oPGSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4PjjRoJv+YIz3YZYCmgUcVwYtl2R5/um/OR3HV5Nm5M8XDKB
	tK05aOgucrP3JIWZ8lgAXLLM4p5HqSBDm5kQ81JxV4Sq8exHCi5f
X-Gm-Gg: ASbGncuF/EZkoEOEGV+yYsktSVfY1HWOkFmZZq6p2D7H47zt7kXV/bD66upTikHAEXR
	LH0yAbQk8rmm0ByUnjIN1KxxKkor4jtixjxVr/NRN1tEAMa15MlMbM/gT7qVs0d65TNVE+tjGUE
	y3kZFjlXjXu+yWQdBiSLesYeUHAXGnRowSnX15KB8iZi/M9OM/LbUKjQTm+0LHHpcc7hatILEBt
	GQSv+QacG14lQqVTykAAvaQebpSzE5yAqpho8eKJjMhYkYk+kseXa/uv8I2SkkYwqaJKiWy+gEw
	lBKQngrxzpi7Hua66njOo6IRHJQfl3P7ujJsbus5PFGVYZLbmnyaakQ1TOHT2vLbTRaD9+kiJF5
	vhEWsMEQTSlz1
X-Google-Smtp-Source: AGHT+IFncxJntu78FR7b4qYIZj+yv/K48D2ocZTvPMdxZVQ+iCvW4E3ccfSm9iifNVJPhsHG3qsgrQ==
X-Received: by 2002:a05:6402:3512:b0:5dc:ea7e:8c56 with SMTP id 4fb4d7f45d1cf-5e44a256cc9mr9383487a12.22.1740515806327;
        Tue, 25 Feb 2025 12:36:46 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed205c7efsm199478066b.149.2025.02.25.12.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:36:45 -0800 (PST)
Date: Tue, 25 Feb 2025 21:36:42 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Emil Renner Berthing <kernel@esmil.dk>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
	Inochi Amaoto <inochiama@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jan Petrous <jan.petrous@oss.nxp.com>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org, 
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 4/7] net: stmmac: starfive: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <auqbgnqka3hdrwbxoaa3so6caju6jzzpsbr5yufaqgbqmhjmap@nbawhyq3nz6q>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
 <E1tkLZ0-004RZH-SL@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="npnnru3ejcetrulh"
Content-Disposition: inline
In-Reply-To: <E1tkLZ0-004RZH-SL@rmk-PC.armlinux.org.uk>


--npnnru3ejcetrulh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC net-next 4/7] net: stmmac: starfive: use generic
 stmmac_set_clk_tx_rate()
MIME-Version: 1.0

On Tue, Feb 18, 2025 at 11:14:54AM +0000, Russell King (Oracle) wrote:
> Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
> clock.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 26 +++----------------
>  1 file changed, 4 insertions(+), 22 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--npnnru3ejcetrulh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAme+KdoACgkQ3SOs138+
s6E3eA//VXPPJ389lkM7hL4gCsrCvhxDMVKpYPMFI55f6tZgLN36yUUjjp/67nLz
TWhWj74unoSnThtfJlOzxs/l/n6/XM23PEtj+TVrBk507ao3hEWLWY0KPW7fHU0/
kb7Jfe85CfqmkzrtLINfqpxvbb7bgSxP5yALfculXlykp61GY0aPIHUAXXWWUn2u
SdgqTvYdA3oTDBJ2Cc+unBpVTSuH84RpMvnPLvtLu2+0t0ppjAf4MYJG09t3f/jr
Ku7m1c9zlNWDrv1fSsIJ4kd8YakZsB9aDGxcP4rQhr/73uBetaUFfz92tTvMPAvn
/vTqP75LzOPXu88BGK7ZV6SvdOBstrxxMOTM2/7/DSyCHv2V1Yt3xvplbP5YCble
ORxVJNlzH0JweLWggg9xcvDlwas+jagLOYYp5If3cqsae9CFLxJr7zywxu+UaVT1
DIpGMI0dnVaJcwOc01nlEWCzeOy0oe0lG9UZkUPKWbxoBB9Eit4ZibSmoTCf3l3q
fjPgZBKRJa1hHMBEecD7gQja1zqMg0ZOcdXowP67ZIF9AkfCQHZNorMqQwicvA69
w8x2PvFSXgexu6zDEAZ/5SMc7+iLQQ8gTR1SZHpna+9pl5S2X/CiYK4Ihvzs4EPY
uXWe3lJzBecVr9TdDq5tgbk7cTqduZOS4Yvc1XkGEGgKA/JT4c8=
=slen
-----END PGP SIGNATURE-----

--npnnru3ejcetrulh--

