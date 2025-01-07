Return-Path: <netdev+bounces-155777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC87CA03B8C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33F87A1F81
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 09:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43BB1E3771;
	Tue,  7 Jan 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z8ufki5z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93E1E0B96
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736243614; cv=none; b=Tl5iUnNlwPyiutfiAYJRVUy/VBG4KobesJe04zHYUFiEuIwLqog+R/Olkp5w7xqTBgDxC4o3G+F4vlzXzotrB9haUpHlmr3YqJcfsAzT/6IjKe2Z+ibUpo+T2HrX+JpLVsTdJsrzb5v0g6qBpQNmXlsqkBfXBZgvyQqe4p1RrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736243614; c=relaxed/simple;
	bh=PuYCglGBGBf8/cSXmff9wfrp6dccIU1+L5fPfpHdlc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9cBqbNpbOGR9E3Y4YD7SLyQMSCmIjivQkUX4x7lqWxp7ROLY0qJ0/UrrytbxsiDnnjbeS4o8L2jHKQ3VUD5m2LDYvy7z3sOwpyBPCoOibwRZSzq1g0wSb97MWihrqN2hcz7mmmJT6LALn+0x/Ggm+2LDaNcJtgijciZGMOYVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z8ufki5z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso109457105e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 01:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736243609; x=1736848409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HfOXeXixgxr/lDKJT/RAbwwwphKuJpVBpnVCZ3E+HkQ=;
        b=z8ufki5zg4heJdRgOI49PfUAHd6nrIPyEN56C+iRSQshX/HDiDslneZZoCY1/9Y7c3
         +nzftIGHpnbCxFtiCPJFXaWopgBXNVfoy7yyQMXURPs1yqkYj2ypBQMqrsIvmV9dB6rU
         u1hBmmg/cy+KoycSc73wpPGgcchgy88GHjsBDVbBAbD6YLKlXtRGqg5qdN+ILeIifvxf
         RVUUEjCf6av/4feVsdzx/OMenhxLXpIpezLxtAJD9YqEfm50aWdnDu3ns14iN5/zCRFo
         YzbpfEU0c/EbYib+yAPDgSPpWwRnwxVXcZngEkpCvqa9VuPknf8NxtkF50lnMXrBq+6y
         68CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736243609; x=1736848409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfOXeXixgxr/lDKJT/RAbwwwphKuJpVBpnVCZ3E+HkQ=;
        b=kp23hs0o0/I8guvg6mHy1jy7OfnnGpx+t7CzQi7ZjWKzMepxy2pqY+2wVWKIKdEDnz
         ugHAmGDSh/FZn9JewNu6LActRf1XOKLk/E2Y4OO46vcYJxYWE5xbZdVeCwc4Sm/+IDRI
         fIYizAfQ5yMmDvZIX679fMmuNqqlv50qV8dAqxTgZoRt+PDI4DjyZuk86v0jp+c15Vwg
         mSO2Cg1rzX1qFfaMjUHdudXLDnehOFHaG3Oq1tP3eUc8flKbBgTjlHSK1nMLqFMrsVRl
         XeVU+F2TLbslvflOSZxJPT15886aHM5KvrHftKxBIOufDT0bxmyelxGoakdaj7Tk/Vnw
         G+yg==
X-Forwarded-Encrypted: i=1; AJvYcCWlqJw5VAtgMQnZAqjuE56rsoxm4NH7dog3zruYgCw5d1OAm/yX7DnmGaWw0yOuIVMUiqTeJbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywb4NgsW9j+v0sv5eqpG/k8r4GrADUQxTUJbp2RSG6PdyZDG0c
	/gFwIV/uyeQ27aUwHxTImWgsrT15NVDsLzsWgK90p0YryFfQ9+humAM3Grqesxs=
X-Gm-Gg: ASbGncsvrc6lK/7C8wi5fdAv1AoT8hxpIVbRLJQ7G3TU0MSxiJVtY94hPT1Q1JIbujj
	FOyreuVsfiqgRsezlbZVj6ki/6f7uFf1IIAfHvCqrWfGLfaiUD7rnz1EO2n5M5q7jQxQQkvqSy9
	1qdb9cSYH4/deJ7e9UGDoXfYtCm/AsD7zC+jvDXepb1knqoJZ7fwJr/Ir2JduUcV1A0AQPJY+9g
	hxFq2YxYRckx3t6aTXawvMMBDWyghJh0xSbcPYm9Cwm8S0BKDhA
X-Google-Smtp-Source: AGHT+IHvX1OshrfmD6p1l0+Jh61zeJh68TXBs8zHN9+1raYn02+x8hZ0AZB5VEOINJMVZA2d+QJVZQ==
X-Received: by 2002:a05:6000:188d:b0:385:f7d2:7e9b with SMTP id ffacd0b85a97d-38a221f3785mr48240940f8f.30.1736243608128;
        Tue, 07 Jan 2025 01:53:28 -0800 (PST)
Received: from localhost ([2001:4090:a245:80cb:3b5a:db2d:b2b7:c8b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a6abesm49944076f8f.90.2025.01.07.01.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:53:27 -0800 (PST)
Date: Tue, 7 Jan 2025 10:53:26 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v6 1/7] dt-bindings: can: m_can: Add wakeup properties
Message-ID: <d6hukfwjqgtwqjgvo65icmpzbm32ob6n7ehrzlywwomjbdn5lg@2wm53244pszz>
References: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
 <20241219-topic-mcan-wakeup-source-v6-12-v6-1-1356c7f7cfda@baylibre.com>
 <20241225-singing-passionate-antelope-88e154-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pwtr634u7r3uhzqt"
Content-Disposition: inline
In-Reply-To: <20241225-singing-passionate-antelope-88e154-mkl@pengutronix.de>


--pwtr634u7r3uhzqt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/7] dt-bindings: can: m_can: Add wakeup properties
MIME-Version: 1.0

On Wed, Dec 25, 2024 at 08:50:17PM +0100, Marc Kleine-Budde wrote:
> On 19.12.2024 20:57:52, Markus Schneider-Pargmann wrote:
> > m_can can be a wakeup source on some devices. Especially on some of the
> > am62* SoCs pins, connected to m_can in the mcu, can be used to wakeup
> > the SoC.
> >=20
> > The wakeup-source property defines on which devices m_can can be used
> > for wakeup and in which power states.
> >=20
> > The pins associated with m_can have to have a special configuration to
> > be able to wakeup the SoC. This configuration is described in the wakeup
> > pinctrl state while the default state describes the default
> > configuration.
> >=20
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>=20
> The DTBS check fails:
>=20
> | $ make CHECK_DTBS=3Dy ti/k3-am625-beagleplay.dtb
> |   DTC [C] arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb
> | arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: can@4e08000: wakeup-sou=
rce: 'oneOf' conditional failed, one must be fixed:
> |         ['suspend', 'poweroff'] is not of type 'boolean'
> |         ['suspend', 'poweroff'] is too long
> |         from schema $id: http://devicetree.org/schemas/net/can/bosch,m_=
can.yaml#
> | arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: can@4e08000: wakeup-sou=
rce: ['suspend', 'poweroff'] is not of type 'boolean'
> |         from schema $id: http://devicetree.org/schemas/wakeup-source.ya=
ml#
> | arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: can@4e18000: wakeup-sou=
rce: 'oneOf' conditional failed, one must be fixed:
> |         ['suspend', 'poweroff'] is not of type 'boolean'
> |         ['suspend', 'poweroff'] is too long
> |         from schema $id: http://devicetree.org/schemas/net/can/bosch,m_=
can.yaml#
> | arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: can@4e18000: wakeup-sou=
rce: ['suspend', 'poweroff'] is not of type 'boolean'
> |         from schema $id: http://devicetree.org/schemas/wakeup-source.ya=
ml#

Thanks, the bot also notified me about this issue. I wasn't able to
solve it without updating the dt-schema, so I submitted a pull request
there:

https://github.com/devicetree-org/dt-schema/pull/150

Best
Markus

--pwtr634u7r3uhzqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZ3z5kgAKCRAkjLTi1BWu
P1hgAP4voovKy4zR8WCkwL+8S3ZCowjZyknLvSjGcbXBU0z0owD/aFzfe3ymIfCD
zi6dOgCGDyI9zo5QxMWmEvkbRaXn1ww=
=uv0O
-----END PGP SIGNATURE-----

--pwtr634u7r3uhzqt--

