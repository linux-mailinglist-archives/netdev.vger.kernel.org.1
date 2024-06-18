Return-Path: <netdev+bounces-104582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B4590D671
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B412B1F21989
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788B3DDA6;
	Tue, 18 Jun 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OTJlfVTQ"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0123BE;
	Tue, 18 Jun 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722946; cv=none; b=CV64EYoTB+iMZaV+6Iv87C8axMqZ+JoWQ/s2IZ2bIzXU119adiDDYyuzKoKpdBIJvhwuIqLzhMxr1canLIle8cL1xTAZpxH9r98SO2og4h3CMi8pUmyFzChwhQw3IayYX6cPluMlK9/COyi6DkJZvXnl61wack/bobjmfCWGRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722946; c=relaxed/simple;
	bh=4DP/pLvJr5FCTp8Gs8CSgpa+4kUePHLrQ/FzhjNULbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fknrQIa8y0LkvPhysaYPeWXlPRrWnp+wsTAHKlbRU6pIEv/XN/32PVBOKQL8k8yL6B8EIfAtRitS4IMkYij5Z99BeU1DAu2WwXgOHkFEQr+txSx4LeT/7fUXjgcs5wDT+Qzem3x3yEpcmVD1G16CsOuXA49O++G8n3xlf6aZRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OTJlfVTQ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3B4FF882DB;
	Tue, 18 Jun 2024 17:02:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718722942;
	bh=9ns9gHRZfDY4bi8jkbvd27zNfS1kRiPooJSAoQsIPe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OTJlfVTQ1wHzhvj9MakaFaygopHypaAxW2vJgac91reYHZOvBgkNuikuu9kXccGoA
	 CORnroR7Nqk49LZr+ZZEXLX36mkhBJDi/UK1mezXpkSEK9NmPGkMnngg65hpG1Vy1O
	 RuDoP6Hq0Amh1dJT79FSZFwEajTvsmLEVV4JZWHRAFVTipdsO91klqnEMm2t08+BbN
	 Of96jM8m5inuNl+d0ODaFvRr6TTYUXd+abFF4wkdKqRaoKKg8PFmmOVPjCnymrD8y5
	 CuIXdjWOlviEMgUlAZh199oFd2yswT4QNe6uk54QPx8lqlzyIBDxpMJodVkuzhr7g/
	 z10GrvV0817+g==
Date: Tue, 18 Jun 2024 17:02:20 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung.Huh@microchip.com, dan.carpenter@linaro.org, olteanv@gmail.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, o.rempel@pengutronix.de,
 Tristram.Ha@microchip.com, bigeasy@linutronix.de, horms@kernel.org,
 ricardo@marliere.net, casper.casan@gmail.com, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <20240618170220.7c9217bd@wsk>
In-Reply-To: <6a011bd4-8494-4a6f-9ec4-723ab52c4fbf@lunn.ch>
References: <20240618130433.1111485-1-lukma@denx.de>
	<339031f6-e732-43b4-9e83-0e2098df65ef@moroto.mountain>
	<24b69bf0-03c9-414a-ac5d-ef82c2eed8f6@lunn.ch>
	<1e2529b4-41f2-4483-9b17-50c6410d8eab@moroto.mountain>
	<BL0PR11MB291397353642C808454F575CE7CE2@BL0PR11MB2913.namprd11.prod.outlook.com>
	<20240618164545.14817f7e@wsk>
	<6a011bd4-8494-4a6f-9ec4-723ab52c4fbf@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sSiMgKlQi8mtC+G=LfOwu2c";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/sSiMgKlQi8mtC+G=LfOwu2c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > For me the:
> >=20
> > NL_SET_ERR_MSG_MOD(extack, "Cannot offload more than two ports (in
> > use=3D0x%x)", dev->hsr_ports);
> >=20
> > is fine - as it informs that no more HSR offloading is possible (and
> > allows to SW based RedBox/HSR-SAN operation). =20
>=20
> Does user space actually get to see it? I would expect the HSR code
> sees the EOPNOTSUPP, does not consider it an fatal error, and return 0
> to user space.
>=20
> If userspace does see it, maybe we should make it clearer it is not an
> actually error.=20
>=20
> "Cannot offload more than two ports, using software bridging"
>=20
> so something similar.
>=20

Exactly - this is useful information - not error indication.

(The same case is when we do want to set the MAC address already
"taken" by ksz9477 HSR configuration.)

>    Andrew




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/sSiMgKlQi8mtC+G=LfOwu2c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZxoXwACgkQAR8vZIA0
zr2f0Af/YOZs1ZZDgwlYntv1FPHh044NpxAhElR9o6wgCRRTDgQGdRs3KbqXFOvZ
OY+hO4fAPk8Qu4zvisM42a0kyW1wm754WMpSqzUp6PF/oSLAALwTqBqPTyiBxojW
4KUvIj6pv0Aq2iGB88B8QzkNAiPWvVT+kWj2UaJi93w6nnKlVtWw8EBEBIpd4Ts0
JF5NGojlZ4f8B/r7ukdkfmtLaVcT6m+NOetg7g+fCqElu5mxHJI7iQr5oRWZAo7V
QR+SBXhR/nnzUKTYxlJL118jjsbHCwushvKBN90LS4rO9oDvA60CSJFLJCoDG0oV
VTNZaNSbPPZ3RxLWrAvlPlEFDsmvNw==
=kTCU
-----END PGP SIGNATURE-----

--Sig_/sSiMgKlQi8mtC+G=LfOwu2c--

