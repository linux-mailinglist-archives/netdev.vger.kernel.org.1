Return-Path: <netdev+bounces-202053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA771AEC1CE
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0861B1880328
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785225DCF6;
	Fri, 27 Jun 2025 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jjNjMmoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D303F25CC57
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751059132; cv=none; b=ZL4Xk9DB4fTqGwWZIm9qxwhubIcL7tH/dE6TJeyTmsMFfmp/UA6GPN6Mh06tM4Rvjb8C/NZj99kr2mS3Q+yJ0M+LNaEERs4r7T1cs0Lpe5DYVwDb82u5mbKwF0nY/BTIhdGHREvklJx0HBS8feN3OEEiVuOwJEr5n0UiJoRv/5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751059132; c=relaxed/simple;
	bh=kbgeC+OhJBkEXFY0Fif5Ujsa1r2Mn8ORx0MKUa5g2uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jyh0DYWZKPhZfc/ovJmOhPWB/nDfOXRS6KH1phBBHHd3T6Bwk0w0FBmm+EdXyfZDEoQF7uwMcAr/XTrk/YM0d6mYXBVopXH/uI1/N0x2TUKJpxROAcDICF3l3Z4CPxNlovL1d9OJ12uET+Q/MLXAZFtvHdFdm3/fMvs/g9sc0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jjNjMmoY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad883afdf0cso501287466b.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751059128; x=1751663928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbgeC+OhJBkEXFY0Fif5Ujsa1r2Mn8ORx0MKUa5g2uU=;
        b=jjNjMmoYYPxT39/5Wxdfdg1uW/9Zt6fUurnMujK/kLzdBrddqvnHvNTCClQT+REiSw
         xYH3UWPuLvYfshklVQGK6Fw+2tY205UIPzjboMozIFeadPLpD2QvrRMTn2ANznEv3Rk1
         xC7PVnSwPJWiVPOzWqVwDoZobGBlN1cfHo53ovtybRxhwjDkKha7we0FY1Z85wyUq9ny
         +iIa4xdOK5U+RFJ4MToZB6uT/RAvp0X/jGt7Lw/26PeCzKmnHdnulxz8mq0AiqSTVYSE
         eeEHmXuwMLABr+7N4LWkbUz/UYgouBJjRkY5CKe89Z+j1GDhqz5TwlnXsX1sZU7cXQcq
         rnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751059128; x=1751663928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbgeC+OhJBkEXFY0Fif5Ujsa1r2Mn8ORx0MKUa5g2uU=;
        b=IxhpKDLaTc9zAWGp1dIcL0B9QqDoGDFceZerpwp3C3v01ZNOV412K3qLpLc6r5LeTD
         QZMqjz1OwREGX8iraywmKXDl9FrNb7f2WKufMGvpyLk30mkqDJwMOibRQfeh5CE/BJVi
         nhegy6UrulYpz94qz/axQe+BAypW7G/TPw5D2HlaCGU+p9sl8nTIncEbRVTARJMsTv8Z
         n//9jOSt2aWJ5lx3l9E5GB/hqfzbLI+tCSM8D9OTnu7JUQHUwIHfUCgOVE0AAfwNUdW8
         U1klD20Vgaeuu0A2slrnOSxocVFDtzg1kQoxHov+0JI1kH5yZndXanRJzBryJ+xCa8r0
         ZiAw==
X-Forwarded-Encrypted: i=1; AJvYcCU5LVGsD9W62g4gInOxuFRNiD6Hs+NQc/KUD2LblLvWgnyE/JH/SvC0T+hWdli1w7OhizxAJCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIm+OyGdj7pIusl3HOzhA9ocwqTA6IWaBFICjWdATdo0OvqZ6s
	KFgCPauRFME2dA8aQRN3l5ZMVnMFBAHKIphYLXPCCC8IJS5wIRDmy4pSCWpXPp/CiDA=
X-Gm-Gg: ASbGncvaMQoh7bMBvs2ATW1vzkj34FF8LNRMi0WHQ4DilwlflP/ORgL3LTPJTg61auJ
	Nv/TQdmkUxKWHC5Y5BC3u205vV7PRvgynrgGDfNvFaUxnhK1H96+kRZWqre3hscYg0Q6oBVWRcm
	pNCdee2RLVrzPIxsVy9r0AvpdJjKbMnHhc/PmEvH4qXrT3rlqu8roUp7DHXbyfnYp/cTvTQQF6I
	UxYj8fsXfJBkLFvGvBfXfNPTMZsdXEvAztJZyqN0yWHzKLrrOOXN2Jchnozwh6YELPf7ha4Olm7
	k5UGr1EoYG9nS3SVTswhUopzhWwZa58ZRiVca11J4JMcq/VF3nmu2r0qhwbbUY5CQyA=
X-Google-Smtp-Source: AGHT+IG2SuiQBSGi4kBhNiZtqFlAquVrP23pVOrEebjVUR5m+81V7111Mpin7QJJ/rvtW7uva6BgHQ==
X-Received: by 2002:a17:907:7f8e:b0:ae3:6bb4:2741 with SMTP id a640c23a62f3a-ae36bb57a86mr63322966b.38.1751059127949;
        Fri, 27 Jun 2025 14:18:47 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae353d99612sm189196966b.182.2025.06.27.14.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 14:18:47 -0700 (PDT)
Date: Fri, 27 Jun 2025 23:18:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Simon Horman <horms@kernel.org>
Cc: Igor Russkikh <irusskikh@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexander Loktionov <Alexander.Loktionov@aquantia.com>, 
	David VomLehn <vomlehn@texas.net>, Dmitry Bezrukov <Dmitry.Bezrukov@aquantia.com>, 
	Pavel Belous <Pavel.Belous@aquantia.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: Rename PCI driver struct to end in _driver
Message-ID: <kkqutqwaydubjuypkxsa52ynljn5av3zkrgn7tix3fleql7mbk@ltk4dqtbaltt>
References: <20250627094642.1923993-2-u.kleine-koenig@baylibre.com>
 <20250627194752.GE1776@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fbljtups23ebsv4o"
Content-Disposition: inline
In-Reply-To: <20250627194752.GE1776@horms.kernel.org>


--fbljtups23ebsv4o
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net: atlantic: Rename PCI driver struct to end in _driver
MIME-Version: 1.0

Hello Simon,

On Fri, Jun 27, 2025 at 08:47:52PM +0100, Simon Horman wrote:
> On Fri, Jun 27, 2025 at 11:46:41AM +0200, Uwe Kleine-K=F6nig wrote:
> > This is not only a cosmetic change because the section mismatch checks
> > also depend on the name and for drivers the checks are stricter than for
> > ops.
> >=20
> > However aq_pci_driver also passes the stricter checks just fine, so no
> > further changes needed.
> >=20
> > Fixes: 97bde5c4f909 ("net: ethernet: aquantia: Support for NIC-specific=
 code")
>=20
> From a Networking subsystem point of view
> this feels more like an enhancement than a bug fix.
> Can we drop the Fixes tag?

I think it's right to include it, but I won't argue if you apply the
patch without it.

Best regards
Uwe

--fbljtups23ebsv4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhfCrIACgkQj4D7WH0S
/k4ABAgAp9WxwO3UAvCx4a+4Z2LR5+kV7R4qLKpI9CzQ2EdHdHUSIydls9sOESfD
tYOV96yckbKV2r5wL1hfq/xDGMuxPnw7Fp1NGa1j9EKrEbCCJJeXv0qVmiBd1pVU
vPzbj7UO08/fZ6FmNS171mPwt6w4WQ/TyWfHOy1UAi8+ebqtTb5FgnQHgzO4nPbA
7fOIblfZ9fU8hPKfW51pWB27+UGNlO889d7gg3SvgQPHX2bj19PglinReaUEC2Ih
1XssEqz/nGbSjkm2zBRBODIpIZRfO9pEP4i+dWheaQArD3U1AVCoyLE+VR85UJPu
40hqYZwqIFLIsES+AOGxuOTmyAyKXQ==
=pF+H
-----END PGP SIGNATURE-----

--fbljtups23ebsv4o--

