Return-Path: <netdev+bounces-169592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC66A44AA7
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790E517FA58
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762819F42C;
	Tue, 25 Feb 2025 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9BXYcqX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759FA18C903
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508672; cv=none; b=tZuRMBnF3F+20Re3li45kqh/Gs09Xu24Y0ikQZOd/Eu6qRkyNb5VnVKG1fAe9zHG7D0gR1frKuWTfqq2+EZ/iZcsWZxyvMa6hGdm1sJx1BWFfL5rh+/2QaByb/15CGlfQu5lvC9amt3UTGPf4h/1veTLkiFUamLQGrFlGUAka8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508672; c=relaxed/simple;
	bh=mtc5kHV4yfcg8CvyLXlfl9YFsPEAtSKI4leOBz+u5+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HddaZ3JJTZCnI+oURUpzbwCKEm82rwZW9qm9DuN4it1Xxqjd0uyo/Mt8zC40Si3TRYAkBvneLdNLWyH7TxERztFu65jN8lCxnt0yosMhSyzNmHbmoTaUWIFI2DbUJG3oIltetlxaoby3WnTASjo9J/143nMMHF8ezzJYrWkuv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9BXYcqX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4398738217aso52181675e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740508669; x=1741113469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3iaVHc4/XfXA2DF9jl+povuubBeCM8bFfr3Gc9B5VcM=;
        b=H9BXYcqXQ7E++rZhRJiuDcUzKyE2g4XZyAToIdHlMt/lkZlhTYgIL5Wfqp5boPA7E/
         pE8YlKFcd0xdMnDxGNKW8rJq6gtF04PgS/3l2S7yXbDbhW3ZmMjZiRBEBX7dij3ZqJo/
         0YA2Sx9q3afM44clKvtUN9EFLcXy2zeKF+ii5Oikvlkz1i/bk+Y1hBDxUkp3iJu2QPHt
         mzS5cej0gyiHsxPeXuER4CbMIn6JwHgFrU4FBroTD8wNkpnJWeKWfS2CKoeswCvtpA6I
         aBS/2apF9K1FHD7hYKTnz4bs1Aje9Cu04JLeqv24JERPrMS15c2a2vOaJGjpTZ6cGkh1
         figA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740508669; x=1741113469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iaVHc4/XfXA2DF9jl+povuubBeCM8bFfr3Gc9B5VcM=;
        b=HVkr7Pk2Zz5ljy4b4R3x3YjOXW0cR/v8bZXUblSSh4fWN8HtR+/prR+M1qmdMzOBiK
         tA/sIRTMYTLtn/+VbTitvx76zEUj01MplBvJsLG0VJTGaKJaTd2WIz2gpkfRBUlmOCEw
         DJDwe/21MpJzv7aRdHPcymc8GxHiH0HaoG5gaPgShJJIkj3Jnk9YxOp4txSR4PLB3FD8
         fmeLK0bnY/eUvepkCscxOrVntxjb79kX1yT7mQRDMR2h1BP1+jlxMJ65Hi6v0BJBFlxa
         9ywi/zWfDaaHDq8xNFlB3Pf6GAdpB//Dec1TX4l8S+pGi+4kasg4q/YvPIR4bluqKQda
         W5BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWFqLH8qOx4JqnstBzWWvEksdZwJb8JoNycAjD8YeVLhR64ESCVPXS0mPR8PgQGoGO+fh/baI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFTbmvrwgeRbLnwN2TSvYkp9mfK/Wlx4ers02RMwxGGdWuf521
	BxXLQEC3jD4nAK02QFLXrIT3Xg5Jxhe5Atab6pgvSl8cT4mQ37rt
X-Gm-Gg: ASbGnctEkNXztQDpPsBcnh0fiP1oI+s+G1+BUxCrWdkJbxFAJYF7t3547N52fWz+oEj
	v5UjJqnN+OYIupTWy2TNI6XtGKVAidcjdGC20bqxLD6qBotjt4MUE58B1n1DctEU44wombp470q
	LwUr1GCHgcxThtJttnpK+EWLK4K6lv+5pn2zJosWV/51cNqS+GcsTNUth3UgSukrIZQAdoPvw4Z
	6Meel6UpSWW8lSJwDOf+u9bmjL0gDrlwtfwPI7KaF3uqEkMCfCkfT5Zj7fW3i1WafgckXT7RbSq
	fLDFn8qIiO3gFGjm7bIrnbr5rAAn3Nj8aHHK7h1xF1I1ugnZQfP7ipkb6MPSGTkiovGYa8WZp3G
	vg0PegGpTRgWE
X-Google-Smtp-Source: AGHT+IH5jV0WLJwr4meYw5t5geNhiZJeRS99N5uTizzJ/xzS+uRzG3Le5O1v29l/A3y6EY3d135kgQ==
X-Received: by 2002:a05:600c:1d0e:b0:439:6712:643d with SMTP id 5b1f17b1804b1-43ab8fd8620mr5118395e9.9.1740508668374;
        Tue, 25 Feb 2025 10:37:48 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce735sm149842745e9.3.2025.02.25.10.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:37:46 -0800 (PST)
Date: Tue, 25 Feb 2025 19:37:44 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: dwc-qos: clean up clock
 initialisation
Message-ID: <5qx6hg33brb2zjjqzk3cr7dt56m5jxcwzioejtw5woweemskg5@suu43pp3nsg4>
References: <Z7yj_BZa6yG02KcI@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f3i4x2skmc3z4dxx"
Content-Disposition: inline
In-Reply-To: <Z7yj_BZa6yG02KcI@shell.armlinux.org.uk>


--f3i4x2skmc3z4dxx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: dwc-qos: clean up clock
 initialisation
MIME-Version: 1.0

On Mon, Feb 24, 2025 at 04:53:16PM +0000, Russell King (Oracle) wrote:
> Hi,
>=20
> My single v1 patch has become two patches as a result of the build
> error, as it appears this code uses "data" differently from others.
> v2 still produced build warnings despite local builds being clean,
> so v3 addresses those.
>=20
> The first patch brings some consistency with other drivers, naming
> local variables that refer to struct plat_stmmacenet_data as
> "plat_dat", as is used elsewhere in this driver.
>=20
>  .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 53 ++++++++++++----=
------
>  1 file changed, 29 insertions(+), 24 deletions(-)

Tested and works fine on Jetson TX2:

Tested-by: Thierry Reding <treding@nvidia.com>

--f3i4x2skmc3z4dxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAme+DfgACgkQ3SOs138+
s6Hc5xAAns6YS5EqizTjVtcybrFLTInegeZ0X+D5ciydxOvm9iHAwZY2/4ywuY9e
gq6UePIgB51vAzfDfxy5R5X4GvK5+922IL841tyDAJejg54ylBHTFiDoWJVNXUll
QJbbhM+dL0vRRaxTqPzJfJzkIO7ZyU0BylQwr3GYka21DUkYK4J/LnTleP1b3LMu
1W0QlEMWq5DznlUJuQ8C9Tn1C4Pr4+ZRmDjSPF7t8coFAP5XNs9Db5KK0DWkTWto
P0HugDfCHPdDHodfPFzHnT9QxCESDiIHjX4P+PTcR9w4eqg+gjMkiXq1EDpTYu/O
ph05+xPdywaHeGftW0K2RAf3ZdSRep1YWI90autg4U/g0JTq/P9fCyOwR8p3WEen
AtGz3MvZmcGbe6FGY7ZjnY/tVKAwPVP07DVSJcD1DzTe+YusCryfWRUTIHfpe69L
Ric7GRdggYEOZL88Y/bpybtv6kb3baNOpUDwKHj8xDn72FA8coa6Xl8KYDhZvzQe
4jxMzrghudcWAQ8XKxgxB2q+lZ7B+ZFRt1xU6jc7x+KdMsAGI8XHXc1Y0LiiJMfs
xNyl8+5hHbissm7ie2JbC/UyuXB4pCtB51+qfRJrzdZs+DTHXbyZZT5TtUWbtHpB
AzcgVhxrv05jSv7AzsbQiFjNoCC9WZvdMfzZg3Ja2bAh62bFw+o=
=BS53
-----END PGP SIGNATURE-----

--f3i4x2skmc3z4dxx--

