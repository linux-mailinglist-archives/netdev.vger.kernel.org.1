Return-Path: <netdev+bounces-135434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578FB99DE6E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC8282B49
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 06:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88B189F43;
	Tue, 15 Oct 2024 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PL6Bi1BB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83F17335E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973942; cv=none; b=P8j1nLhMXNeSul4/OkiFCt/0jpekjaN0/W4Q+pJBveHYN4x4DkToZS/CeaYP4cMGZ9mXaL0EuuvPrphE4sWDk8KVoigRVwZwE9Z3Wbqo+ZY9CDuqGUg97nf61MnGUHD5RJJmjYrgx5OCvQSnyewNJsEFbmwtemfp1TW+w09MPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973942; c=relaxed/simple;
	bh=1q4Y/mLkXbRsgsUsBr1rXVG3WA30GAlbK74JzmOqeeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNg/wBbLP5XmGrTuXC6M+VMfvSoNUN0u8tbHoHWgRkCcQR0/S5NF+gyV+UrNPuR+/Zmrm38kLHG10Rcs8wF4gaeP/qo9cJjJN0fjEJdhxMFbh4YeUqZe6b4wexlYWjPtI7pg6sSEYm4gVCklWoGjtSYxiR8tzJkCsnLnsnlTKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PL6Bi1BB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso171935166b.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 23:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728973937; x=1729578737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7op+5UqCxwoHXxBuDQd+qJjZ+3UWGpylDlz/kTqb0xg=;
        b=PL6Bi1BBWUhrw++H6juzfxzC3YlEUviBtwOm6kT1GykiAzWchkJ9G4AfMib3717w21
         HnF47beitC2XSanFc3m6unEAuRZr9gr1JZOH/pv7ApTpP+Vy+UazxPoGx/G1oqvOGRME
         KmTc9KP72e3PkgJThMh0EdNsiRg6sLHBnxNCmzmtXNHfQiMOeVvZj4M/utxcXP5hYFWd
         r/GFhpml3/WbjxpZwNvwIHNdRNkXX1BNQxet3bjGzGYlDsgGCd9jCBGrAOT99Eo2c5y6
         7zEzFw5wQFfvpmlWeU9TPUDcIrMdgpcMK2dN++avlBmxr0QC4do1Usim/S4cUc7jwr6W
         1nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728973937; x=1729578737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7op+5UqCxwoHXxBuDQd+qJjZ+3UWGpylDlz/kTqb0xg=;
        b=Xrq2LdyD/pQKH3R8PR5ea3YLO3Hnutfm+WD3k9jB2vtAd/dhz0giKzUQRmiTdIOjAf
         Thpap21r+fuG3dN5n+ARIYR3Osesc8J/TY382cfaDx68+MtPoT5HndK6iq+rTPalHkM3
         y/DAHceEPqMku3XF6oxJ72WGYUWZtnoK3STRFBKMiBgN+F4VRcrTKnPEi4bxOoY60QCt
         84JYX2Ln4+0noB2cDLXPHQhH3RfWt2lKxZVpjZ2OM65vc6G7mhvazW8oEfxMC3oTXTZz
         l/1urJZm8AlB5jylSC7DOmmys1fVNiuF4eiS8qsOvqyvxRcLLB0ARkR9VqqF/L4kGYp3
         ldwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRgQp3FH5bXDgOVfBOwj3TrKamP+COKmRGIbNZ8IG77aDMDgZ0VSqDc1/UWphERRP2rtbPV1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVAaoF+J4MdDYOC7qcLeRwudWZwU7W4uyWWJ30sw3WjTDAqyjD
	BDBOJs+oRi3ccPy7K+v3uCfuWwwOKHI8f1NDM0zwIs9OC+4bRpfFwguKduq04n8=
X-Google-Smtp-Source: AGHT+IGO9kn6nJ4TYuBfxJXBP1NHraNDZPSzUfn+T9RlBAD6g56KlbxRj/4ac95OylIrX3b4RE5stA==
X-Received: by 2002:a17:906:7312:b0:a9a:139:5ef3 with SMTP id a640c23a62f3a-a9a01396165mr745726666b.55.1728973936618;
        Mon, 14 Oct 2024 23:32:16 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:c75a:6d73:cead:b69a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2984396esm30947666b.164.2024.10.14.23.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 23:32:15 -0700 (PDT)
Date: Tue, 15 Oct 2024 08:32:14 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Simon Horman <horms@kernel.org>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 3/9] can: m_can: Map WoL to device_set_wakeup_enable
Message-ID: <cxembrzcref2shryu3sisexjuf7jwn7ieknuw2eyzd5lpb7atq@ivtpvhrwww5q>
References: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
 <20241011-topic-mcan-wakeup-source-v6-12-v3-3-9752c714ad12@baylibre.com>
 <20241011185929.GA53629@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="23bg3cpe6mlws6xq"
Content-Disposition: inline
In-Reply-To: <20241011185929.GA53629@kernel.org>


--23bg3cpe6mlws6xq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 07:59:29PM GMT, Simon Horman wrote:
> On Fri, Oct 11, 2024 at 03:16:40PM +0200, Markus Schneider-Pargmann wrote:
> > In some devices the pins of the m_can module can act as a wakeup source.
> > This patch helps do that by connecting the PHY_WAKE WoL option to
> > device_set_wakeup_enable. By marking this device as being wakeup
> > enabled, this setting can be used by platform code to decide which
> > sleep or poweroff mode to use.
> >=20
> > Also this prepares the driver for the next patch in which the pinctrl
> > settings are changed depending on the desired wakeup source.
> >=20
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++=
++
> >  1 file changed, 37 insertions(+)
> >=20
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index a978b960f1f1e1e8273216ff330ab789d0fd6d51..29accadc20de7e9efa509f1=
4209cc62e599f03bb 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -2185,6 +2185,36 @@ static int m_can_set_coalesce(struct net_device =
*dev,
> >  	return 0;
> >  }
> > =20
> > +static void m_can_get_wol(struct net_device *dev, struct ethtool_wolin=
fo *wol)
> > +{
> > +	struct m_can_classdev *cdev =3D netdev_priv(dev);
> > +
> > +	wol->supported =3D device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
> > +	wol->wolopts =3D device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
> > +}
> > +
> > +static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinf=
o *wol)
> > +{
> > +	struct m_can_classdev *cdev =3D netdev_priv(dev);
> > +	bool wol_enable =3D !!wol->wolopts & WAKE_PHY;
>=20
> Hi Markus,
>=20
> I suspect there is an order of operations issue here.
> Should the line above be like this?
>=20
> 	bool wol_enable =3D !!(wol->wolopts & WAKE_PHY);

Yes, you are absolutely right, thanks for spotting this.

Best
Markus

>=20
> > +	int ret;
> > +
> > +	if ((wol->wolopts & WAKE_PHY) !=3D wol->wolopts)
> > +		return -EINVAL;
> > +
> > +	if (wol_enable =3D=3D device_may_wakeup(cdev->dev))
> > +		return 0;
> > +
> > +	ret =3D device_set_wakeup_enable(cdev->dev, wol_enable);
> > +	if (ret) {
> > +		netdev_err(cdev->net, "Failed to set wakeup enable %pE\n",
> > +			   ERR_PTR(ret));
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
>=20
> ...

--23bg3cpe6mlws6xq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZw4MZgAKCRAkjLTi1BWu
P53TAQCj7dklp8iNY9/7+mXl3KO4/Qhx6MY4breTVV2LuvTk4QD/fCiMaCYLJQXv
5aeaj3cc9UUeFKO61bSzmqzV92dHeQU=
=Kr5x
-----END PGP SIGNATURE-----

--23bg3cpe6mlws6xq--

