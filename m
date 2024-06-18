Return-Path: <netdev+bounces-104570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D22F390D5C6
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAD61C22F37
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2121149DEE;
	Tue, 18 Jun 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="e/mDUIor"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D113C67A;
	Tue, 18 Jun 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721077; cv=none; b=EP20WjE3T+amCUQYVRzuQ6C8S82x1X0kOTZ49c1+7t4UHQ8f0FLbRjoCd4J0V6z8YZuLrmwGi9XsMBZNPSCrIGbIxH8rfKVFJN6/AQfht+kGPfhv3nSldtWVr8DgA9YIYzxOYQYjHu/Fb5AL8t87JLiNYGIEXC5Uv1I1zWvUReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721077; c=relaxed/simple;
	bh=nMaIiy/xb+SuTAksLDm/qfYl1nveqlT4DhuJSrqfM+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inJ1RWNqz40nSHC1Ksmb7iKsmixEIiGREsXB+Ok5j6G17SgtpAmX6lHh5m+aR9/Oobi3MGftB1FTliwoqELrTZwL1WVMF4+3WPW3CtEpggmuDgBq+ueLXPRKWq5jrH0WPXqEUNDDRBSLXDJwISPy163nsWq2BMT8EGceQY4jfLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=e/mDUIor; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 82DCA8824C;
	Tue, 18 Jun 2024 16:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718721073;
	bh=21yCwQCi8PbQlumOHcSklk+VpfKITEQmeuxP4RiNYR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e/mDUIorrTE2MtZDAJZlkN3mtc8VUbH+/wHYjexR3lNSARpUT+Q7G5LbFr/85YsWY
	 hRmaxnUVGvscqPW2vBllhTpsEvf28RfKoBv4bZTqr7k/ipA9xidgX1eeKAYGltlNy2
	 F8JTqRfTNXLsUFksa0Y1k8X7tdYxGxDiTpiRn3sZRGTYozEFr7xh65NM5sqmdNG6Qb
	 LCiO6HJ0dUcF25iNreNwvmWM53lar8l5EOYMfqDNYnAHbTHtbHzn3BpgHAc1/dQWI1
	 gqWstOioa5SSTCTGZH2qClQ3fGrPgKxOnivNZnYD3C+QJbcedY9tP2hFT8TLz3rRYn
	 1maJpP6UmM5Kg==
Date: Tue, 18 Jun 2024 16:31:11 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Simon Horman <horms@kernel.org>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, Casper Andersson
 <casper.casan@gmail.com>, linux-kernel@vger.kernel.org, Woojung Huh
 <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [PATCH v1 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <20240618163111.5091108a@wsk>
In-Reply-To: <339031f6-e732-43b4-9e83-0e2098df65ef@moroto.mountain>
References: <20240618130433.1111485-1-lukma@denx.de>
	<339031f6-e732-43b4-9e83-0e2098df65ef@moroto.mountain>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aOU1=uJwwmfZyNRHU1mhIyY";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/aOU1=uJwwmfZyNRHU1mhIyY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jun 2024 16:42:51 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Tue, Jun 18, 2024 at 03:04:33PM +0200, Lukasz Majewski wrote:
> > The KSZ9477 allows HSR in-HW offloading for any of two selected
> > ports. This patch adds check if one tries to use more than two
> > ports with HSR offloading enabled.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Is this a bug fix?  What is the impact for the user?  Fixes tag?  Add
> this information to the commit message when you resend.
>=20
> > ---
> >  drivers/net/dsa/microchip/ksz_common.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > b/drivers/net/dsa/microchip/ksz_common.c index
> > 2818e24e2a51..0d68f0a5bf19 100644 ---
> > a/drivers/net/dsa/microchip/ksz_common.c +++
> > b/drivers/net/dsa/microchip/ksz_common.c @@ -3913,6 +3913,9 @@
> > static int ksz_hsr_join(struct dsa_switch *ds, int port, struct
> > net_device *hsr, if (ret) return ret;
> > =20
> > +	if (dev->chip_id =3D=3D KSZ9477_CHIP_ID &&
> > hweight8(dev->hsr_ports) > 1)
> > +		return -EOPNOTSUPP; =20
>=20
> Put this condition before the ksz_switch_macaddr_get().  Otherwise
> we'd need to do a ksz_switch_macaddr_put().
>=20
> If dev->chip_id !=3D KSZ9477_CHIP_ID then we would have already
> returned. Really, that should be the first check in this function.
> The hsr_get_version() should be moved to right before we use the
> version. (But that's a separate issue, not related to this patch so
> ignore it).
>=20
> So do something like this but write a better error message.

Ok.

>=20
> regards,
> dan carpenter
>=20
> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c index
> 2818e24e2a51..181e81af3a78 100644 ---
> a/drivers/net/dsa/microchip/ksz_common.c +++
> b/drivers/net/dsa/microchip/ksz_common.c @@ -3906,6 +3906,11 @@
> static int ksz_hsr_join(struct dsa_switch *ds, int port, struct
> net_device *hsr, return -EOPNOTSUPP; }
> =20
> +	if (hweight8(dev->hsr_ports) > 1) {
> +		NL_SET_ERR_MSG_MOD(extack, "Cannot offload more than
> two ports (in use=3D0x%x)", dev->hsr_ports);
> +		return -EOPNOTSUPP;
> +	}
> +
>  	/* Self MAC address filtering, to avoid frames traversing
>  	 * the HSR ring more than once.
>  	 */
>=20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/aOU1=uJwwmfZyNRHU1mhIyY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZxmi8ACgkQAR8vZIA0
zr2CuAgAsPXhbCA+sQpCDb1kRn8REamh8AxB0i1qkC0oHlWC3/Szjc7Mzga5TL/p
nkVGiJgelsQmdES0cnt4zcornGEnelRpQI9GbgjzMiRG0jsczyizb3/TMq+IKX1F
XhTTedDU3PpRH/jRb8VVWGYZJ+Eyg46wW/gqUKhWm5ycS06nG0zQrqChwrs+ZrDz
t7QO2hEbdwbg6XxDdP3iz2/p0jWoY3hmV7Uzmqqr4PeSKubUfehr96x3RqgaOSPr
tK/dUArkLdxIBfk6QtgtbBcYNMWqZnPymKAG/aJ3JJ/qufZgwE0SSKO9wunqbTZc
fxP4E31+eL6QzU8biswxCBGHMyfWxA==
=NvrA
-----END PGP SIGNATURE-----

--Sig_/aOU1=uJwwmfZyNRHU1mhIyY--

