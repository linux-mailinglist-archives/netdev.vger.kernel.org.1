Return-Path: <netdev+bounces-251035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72051D3A349
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EAB230038C3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F46350D78;
	Mon, 19 Jan 2026 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vkfazezO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622B247291
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768815638; cv=none; b=UQXLnzrfc/DmvpuRWE+PgoMfpHgPjcy4m8oPcIKy75hxKDDEohQgjO4HILxdylrlAGY3lqwyMgHMlgf/Hz8s+XnfBpwmuFq/dxqfrbJrNc9pntqDyk9vQx43+oRE+egXE5FRHG16CiIpxM2JUMpKYp3pNo9QrU5zZoTcToDaalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768815638; c=relaxed/simple;
	bh=ZnDvlhRBDUBVsMZvEMZNqDnvf79Xo9/jr2jIUmXIFYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGXPoUu+Kq0qgxSlzsdNgmrOzBtKKo7VWtGR2NY/Pg+VLco9YKISk8/vACbKzmopK9b9ucUeqcwUTlv2Op97in+EScYN69YZEVklxJBtpOjnAmpeGi2AwDkqK8SITjwKeSWK5TNUbQtz3NJpWcCGv0btKVFfyS9kYm/PEhOX9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vkfazezO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47f3b7ef761so21274875e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768815634; x=1769420434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G0tfLHZjioonH3s8pCxwjKiUeh2LK//GGZEDTJFRhKg=;
        b=vkfazezOLxhS1L1OamA0MU+2tws0+863COc6r6loeFzOOwZjdRRVEAqReGbYImwBGu
         1kCIGmFcIK8MxuZdaaM5J8yJddyFqVuOYm0YFKgGyGe5d1N81jst0oLs4Uhj+0C88ztB
         d1nz5uq+T2NCG5MlVgj0vQtANfqTwvIL5P6bj4/HjerUNZbbqmZsuXqw2UyBUCIxghZ2
         qCYYBLsrY83UDwCll3KzdKYD2Mb8GbAvAeW1bVXilraT+rBwrflhSCHmtlMFouCkspmX
         tFzGl0Uin9rXMbLZljMZ4eDRcl/eHM+4KLJfUC+G1ZXJUI0rdHLz6wi20M5Uf8sxzTXb
         FYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768815634; x=1769420434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0tfLHZjioonH3s8pCxwjKiUeh2LK//GGZEDTJFRhKg=;
        b=ZsNz+VhStsdQxgSCV5XPEOm3gVyYqoHR1jI4oebOhYDorqbNRO7+SaCixx72+LVzRf
         KUT7TSn80OdYFAuxDpF7cLyeF6XuhPmujqAyoVcrUgm+ym2+geHaXwWAL7kkMijmA6C7
         caX4QtFeFltFwzINsmkTuDP7rQTjZfdxi6bZdA+7ZBOo/L8Xl6H/ZNJg3b32Jg7dYu0w
         OxdBFG0EKkXU4npdgXdqyW0HA7TSlA297u60MRc4ui9vP9PTE62BtxbBLYrpPwrY8C2h
         afWyVsFTWC3UqpNnAJ8BkciZa5ZLZFIUkPdqOKz6dDzqRms22OI14TYyJK8Z43WbL2Jh
         ERDQ==
X-Gm-Message-State: AOJu0YyA2bDJOAbTcj74B4Q4MD+tKfng4GPWNxf8NO0D48Qk+I5S1XKk
	SotHaeq4TypepliBs6ul64ctjOtALUHubXyb4kaDSjPHckkY50jU0i2n92Gq//U4WGzgsuXRiT0
	2/xUR
X-Gm-Gg: AY/fxX6sYZ0+EuyBRlCtvd90OCiuYQ6MkheYft8woD4YoZo0VMgXEKPwHwKzqkUwkcT
	XA/TCxMCrq8hYQUYIF53y4rOl/LiPpizmV7/7EaoEA/NsswbehlVzdJvWIIMbfxx0kkwTQgGLCo
	vI4fuXHEbQJoeIhXpUlvhzjQ5fY0S/MRh4IL0PnMnx8Wykp6oOw0No26C4A2W3imX088Xa2yaNK
	xCp0tvWyrlRJdi37yyQ/FUvuYLE0iXTAtNafdVlJ/uQdgOokn452Py0X2GMD/LoYdHB15p2LZgA
	PDMukWNaGfcZf9eTregEEVyonxiVe51QevzGWKy7GwzASd7NoSOVcmPmw+2S9J3pIWXpzRkd8pZ
	LCvLZ2jwBLnzomsiqX0VATkpdyNagakEkIpn0k81KtefZMGgrWmciuU5ftLcj2RGqw/hFFDlGp6
	TiZq/JaLft1bnh/MjkdT4ZCj8lEEOxulTNSLWvhj1RY5bSn8k9M5XoYOfo/wrJ4KZIbJBDpMyf
X-Received: by 2002:a05:600c:4e50:b0:47e:e946:3a59 with SMTP id 5b1f17b1804b1-4801e3503fbmr130220275e9.34.1768815633945;
        Mon, 19 Jan 2026 01:40:33 -0800 (PST)
Received: from localhost (p200300f65f20eb040fd825a50706214d.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:fd8:25a5:706:214d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4801e8caceesm182069815e9.13.2026.01.19.01.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:40:33 -0800 (PST)
Date: Mon, 19 Jan 2026 10:40:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, linux@armlinux.org.uk, hkallweit1@gmail.com, pabeni@redhat.com
Subject: Re: [RESEND,net-next] mdio: Make use of bus callbacks
Message-ID: <4ltztdbct4ce6elmnn7wx5fzh4lywlfbjrn75pdju7cdsw4q2j@ubq7qaa4regr>
References: <20260113102636.3822825-2-u.kleine-koenig@baylibre.com>
 <20260117232932.1005051-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jeie2bjeg2jhiq56"
Content-Disposition: inline
In-Reply-To: <20260117232932.1005051-1-kuba@kernel.org>


--jeie2bjeg2jhiq56
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND,net-next] mdio: Make use of bus callbacks
MIME-Version: 1.0

Hello Jakub,

On Sat, Jan 17, 2026 at 03:29:32PM -0800, Jakub Kicinski wrote:
> Does adding these bus-level callbacks break PHY device probing?
>=20
> PHY drivers register via phy_driver_register() which sets:
>=20
>     new_driver->mdiodrv.driver.probe =3D phy_probe;
>     new_driver->mdiodrv.driver.remove =3D phy_remove;
>=20
> The driver core in call_driver_probe() prioritizes bus callbacks over dri=
ver
> callbacks:
>=20
>     if (dev->bus->probe)
>         ret =3D dev->bus->probe(dev);
>     else if (drv->probe)
>         ret =3D drv->probe(dev);
>=20
> With mdio_bus_type.probe now set, phy_probe() will never be called for PHY
> devices. The same applies to phy_remove() being bypassed by mdio_bus_remo=
ve().
>=20
> phy_probe() performs essential initialization including setting phydev->d=
rv,
> reading PHY abilities, configuring EEE, and setting up the state machine.
> Without this, PHY devices would fail to initialize properly.
>=20
> Was there a plan to update phy_driver_register() as part of this change, =
or
> is a separate patch needed to handle PHY drivers?

I think the concern is valid. I'll look into this and send an update
when I convinced myself that I'm not breaking anything.

Best regards
Uwe

--jeie2bjeg2jhiq56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlt/A4ACgkQj4D7WH0S
/k4GiAf/TlIqRlDEomfU50E0GgRFhDP6zMg8GChvMzbHDpW9CiwTYLjzD9BKoTHj
cA+ONmFEyC2cYNrHYjpqcKmlaHsWAHMKtFPKNdQQUDEcy7gfU1B5ps5OD3JQq3ah
fbqkklpmPnLI6DPmc7010aZaaYDzeQit2bTh+3XPqQP7nBpJ+lR5jhSOKzKoKKKq
AgIwhG/Tpp/qjWF6GQ0HuH7uWRcmNekcj0p+YQgqXBDMKedFjCYmO0wh76Htg8vo
slxZWg1wb7Fh6mpgVtD/WAntuhehqiUHAD8KIqDyatOpl0YuIJRGIDEu1l2P9bC6
Q72Y4QrojgOn1qFHGHZasWAiYv3N1g==
=Myok
-----END PGP SIGNATURE-----

--jeie2bjeg2jhiq56--

