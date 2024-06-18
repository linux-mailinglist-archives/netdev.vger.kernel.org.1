Return-Path: <netdev+bounces-104552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A723C90D392
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EBB286C28
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0471B1991CB;
	Tue, 18 Jun 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="H5oo0uMz"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCA13A899;
	Tue, 18 Jun 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718576; cv=none; b=j8xKqyQI/JzjNjdVGniY/osxYVJozMil+N7Vqcdl82bAnl9XZLtXwbE+r6kJmp/83oE/1iHQL32u7XemYIaGbF7iZpZ6jQv0ylr3d/sNkPCMLiSd421Es03932FnhCnUsi1lVlsQvqc2R4b2DeGtd8KOsCIaQDJ8qS6XNGpQn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718576; c=relaxed/simple;
	bh=2Gh42P65F4M62z4zrr6A450lagcXTdXdAmZ6brdw7kM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcGjCSkfdYT5UXcwq3rnIfyHvh0ILku25ENZLmOnQmeopbyWpIDKPiKuoaDQgc7TnQKk/pk7Qsf5EYD24S6xLJM+mexkaSzXfISK9xQGLp+Y5UmI9cD8Oynp0DnkZIDzcmuS8UElvfliIXxYKpfSleFtDllz2tiNv+OOCqROnUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=H5oo0uMz; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2E34A8786C;
	Tue, 18 Jun 2024 15:49:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718718571;
	bh=7L0RwYFtaSvc1XTo/PTgwck491NQdc26UYc5Z/uRAPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H5oo0uMzhcdf6MZTiOZZ9245jhl7UKw3n3rOGVHJ24XQmLZtsWDGTzbd7reBPo3bO
	 k7zaVRKp43gI+7ICR2JCyOG8e+2F6PzBP4flv/UzwYCS5m8gENo6Yx6rTmOv55uWm8
	 BoGrd5sUkKZIWAgOXX3Px+8kmJarPesdhu5K2i1a9d1wDx2ErCLuEdO8KHJ2qPJEDe
	 J4g0HLCx98HNpr2e+bTCnkzHmZ1s5TjgN6+E3uTVR4VDkHLJbH7+UbuwBv4KSj69+j
	 unIea25fVI7E9S0RUKhnAHAGT7a0gPrNg7rCVqzUZodOyjT4gygaWDLn81E8b4Tqw5
	 uVQ3Xpc4uxtjA==
Date: Tue, 18 Jun 2024 15:49:28 +0200
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
Message-ID: <20240618154928.29f631e6@wsk>
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
Content-Type: multipart/signed; boundary="Sig_/Xk=wfuMJ3pzqQq/ynaJuO7z";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/Xk=wfuMJ3pzqQq/ynaJuO7z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

> On Tue, Jun 18, 2024 at 03:04:33PM +0200, Lukasz Majewski wrote:
> > The KSZ9477 allows HSR in-HW offloading for any of two selected
> > ports. This patch adds check if one tries to use more than two
> > ports with HSR offloading enabled.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Is this a bug fix?

This seems to be fixing stuff, which was added earlier to next-next.


>  What is the impact for the user?

Impact is that this board with this particular setup can just
malfunction.

>  Fixes tag?

Ok.

>  Add
> this information to the commit message when you resend.

I will wait a few days for input and then send v2.

Thanks for the input.

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

--Sig_/Xk=wfuMJ3pzqQq/ynaJuO7z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZxkGgACgkQAR8vZIA0
zr1YQwf/S+xziRYqZaOOkBrR3AVVSMhUkTpDUf39rSwfVvfe1M2H3R8tmJvaJK96
/dfLP6om6L97IizZPbHOCmGHoeMyby6x25pTo+1PndmzX6++LbaKSjcICv8zDWWk
0XMSx+UYu0rSpN4Ua75bgoTsPTXVn0vbHyXFR6vIs4L4xWrjk8D0PD6lfhhmna65
qqL+qQJu5BkIVCCFFnWgKpEk+oXGh68GCjPZmI05bbP6z/xVUJzQjetAK9RT2gQS
de9mGsDpckXFVQkwyPsTY64IrgJ6X8UcXbScnlksvBEpkAQe4ZZ4d/lQ7TKX3dTX
yW0+4WXPEY2HD8w7s1a1BMLFE53CDQ==
=Nfig
-----END PGP SIGNATURE-----

--Sig_/Xk=wfuMJ3pzqQq/ynaJuO7z--

