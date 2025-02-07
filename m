Return-Path: <netdev+bounces-164091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E41FA2C918
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E758F165258
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CF218DB01;
	Fri,  7 Feb 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuTqCW8G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249923C8DE;
	Fri,  7 Feb 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738946538; cv=none; b=KRXBZ+8izq2IlZSb/pou/jMEbKDYaqQdMVNu6u96izsSaxA7zCoCz3KWU4Xmamv668uRJJsayu9N9eZV2kPzFeV/JGvmlgjnnpL7KD5/l3KE8+ihB9quaXjnJnWpTenf9p7FDgVJH9iMcc6v+J90stKa4eBQoqtbaAa1ecSGPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738946538; c=relaxed/simple;
	bh=xahoYTgr2JXlBEBiH4Eh9CeXWNus+8o8NYBdfY24J1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRECTWWDo0VZ7+9tqwREAyuiu81RGZPtBqdCenV0hmLUE5x1VLzrVo0moxSFy82uBNaR+AQCUhdSm3oObOgY1P+cl4LVp1oGrJrBqhyKOSG2bqyiSmp8ZNVzrXRnMFAC7n6cTUGXPGpNcmmi5uCwLCLoKt+FXdmtC6OCdpQiq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuTqCW8G; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436341f575fso27832015e9.1;
        Fri, 07 Feb 2025 08:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738946535; x=1739551335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FiPV/oHe7RmZIp/M852C28biSFhSs4bIOllT1QoCRG4=;
        b=QuTqCW8GlqBrQsgS1iMUPOTh5xsw8n14Ap4L4KDg0LuMS4ApXp+89jAfMIxcT//1IW
         aBBvlgDMfuiEVnVFe5lO4Lxt/1iVMlbFSi+2Ul7s8ClZkKp76pHPsBOfGjt2OoA+5p2k
         h3XG+87bTI1S0KvKge1INoR+KcMR/ObnEEtZEuC/arI30vOA/gm1M9vfVA6P8wrhvMTB
         Qn2xJA1DWbhcDsZB+w3HJ24YcIIRctySrwDBTAUr1+8qKp0l0NoFda3a6Ah6szMRv6ul
         LMtiETMuF3dxa46QOYa+CQW0c9KJM99lGgH9/Aq8/6imj/Uv3EJxdGQ8H1oL+aWEPy4G
         JPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738946535; x=1739551335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiPV/oHe7RmZIp/M852C28biSFhSs4bIOllT1QoCRG4=;
        b=bUdHwKym8HnPP4PbbQhk5fComzgTcG43uFteEhW5vUL869PfrKiIi2mvNlDlrJMNK7
         CpOGS+bxWNbyt4nyczMyl9bKYDEAnw9Sgsi3qAFe6Z2Z23KK2QT2UpxVQQuI0XEqHhJv
         QCQiCbRKRIwiYqH/EZuTUgm0FTR2w0lC0eUHQvvdpzCpfi/CA6z/Zm+PE8XkSON+tR47
         Y1DlBOYKLnxukFIxF0i69VlI4Pls+yzgqL/gQ7jHo0J0izmD/dnvS8uia1GDj3X38nUR
         S1N/r6Sfoj7semkbooTad1Y6qpad6tP6AKNmz9wRe1YBlMl9qvW/TaY+4dBKMNbQUrt6
         8uuA==
X-Forwarded-Encrypted: i=1; AJvYcCUVTJdL7FkgEdoLn8azsbeS8gIOdPZKAyZdYEEw6Vfwg4G+XBEpdC/QdX6SKt25yU2F0y9ZcDnu@vger.kernel.org, AJvYcCXpZqNzLN3MCGr42y40JZnTnTJG5PEKMGdq79lCYIqk8a6eWiPHb0x4geA+AkTzgPSCabQOP0D/F2tqnkk=@vger.kernel.org, AJvYcCXstpVvzl/77KyuSsPZve4cNTm9jQCM16K+pNb6DMHh+esCJMlOJ1PiK+OAvUaf4nE0asoHKEPu/Uhlkbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfYH7r4BU2cda2vJDZ2HZalFuO+Fdlsw49veIo8l18ly1l62Z1
	CmzseHghEBQ8SKvlwIkmdwrUfTi/xju+vpTu+iUVYikCli1OyTXz7U9tAQ==
X-Gm-Gg: ASbGncuTtH1f2FTGQcsCnFWHMzymLB/38KkuFMy69A8wkMnnOE4xnG8d1BFiwemT3ho
	3n5SkX7patgI5+v+n0rmd8KJNMYFPDoN9W1LOYpF0UPgBJZurJ5G13P2O5euxJSS5eHD/z8Br/2
	opcfTClltwIL1tikK4YLHF0gOVQ5Gis/3L6t8ALKxJrH9YTdf8b9GdCmHTliSBn/+ZQMWZ6COoJ
	g++Al3OEkP2rjz/pAmS3Nk9Hzf7RSrrOlC/WQIYY0GWH2m+TlcwKELyYVxh0k7mK7EKA/5ewB8t
	On18qgBMIYncJFgv0tzBZYJZ/AutOAjy9b67cknq2102YmdLEncPdmn+Emp833M7H94fkbm+Z8H
	nVQ==
X-Google-Smtp-Source: AGHT+IF7y5ag5xXtJbBXF9RYFf/lu5m+MBmyeyrGK4CKk4esPPFHu01PFcCg+qkitoVRNQ1xblHDPw==
X-Received: by 2002:a05:6000:1863:b0:38d:d0e7:7d5c with SMTP id ffacd0b85a97d-38dd0e77fc3mr943984f8f.23.1738946534954;
        Fri, 07 Feb 2025 08:42:14 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390db11264sm94032655e9.35.2025.02.07.08.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 08:42:13 -0800 (PST)
Date: Fri, 7 Feb 2025 17:42:11 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, xfr@outlook.com, 
	Brad Griffis <bgriffis@nvidia.com>, Ido Schimmel <idosch@idosch.org>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net v1] net: stmmac: Apply new page pool parameters when
 SPH is enabled
Message-ID: <heg3exbrmo4zt64cdeolououo25lj2idusepuyuu7iggxgn5fe@6bky6h5pe3tu>
References: <20250207085639.13580-1-0x1207@gmail.com>
 <8fc7c79d-ace8-4e05-acef-1699ee6c4158@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fkugobpneo3jjh3p"
Content-Disposition: inline
In-Reply-To: <8fc7c79d-ace8-4e05-acef-1699ee6c4158@nvidia.com>


--fkugobpneo3jjh3p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v1] net: stmmac: Apply new page pool parameters when
 SPH is enabled
MIME-Version: 1.0

On Fri, Feb 07, 2025 at 01:41:49PM +0000, Jon Hunter wrote:
> Hi Furong,
>=20
> On 07/02/2025 08:56, Furong Xu wrote:
> > Commit df542f669307 ("net: stmmac: Switch to zero-copy in
> > non-XDP RX path") makes DMA write received frame into buffer at offset
> > of NET_SKB_PAD and sets page pool parameters to sync from offset of
> > NET_SKB_PAD. But when Header Payload Split is enabled, the header is
> > written at offset of NET_SKB_PAD, while the payload is written at
> > offset of zero. Uncorrect offset parameter for the payload breaks dma
> > coherence [1] since both CPU and DMA touch the page buffer from offset
> > of zero which is not handled by the page pool sync parameter.
> >=20
> > And in case the DMA cannot split the received frame, for example,
> > a large L2 frame, pp_params.max_len should grow to match the tail
> > of entire frame.
> >=20
> > [1] https://lore.kernel.org/netdev/d465f277-bac7-439f-be1d-9a47dfe2d951=
@nvidia.com/
> >=20
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Reported-by: Brad Griffis <bgriffis@nvidia.com>
> > Suggested-by: Ido Schimmel <idosch@idosch.org>
> > Fixes: df542f669307 ("net: stmmac: Switch to zero-copy in non-XDP RX pa=
th")
> > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index b34ebb916b89..c0ae7db96f46 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -2094,6 +2094,11 @@ static int __alloc_dma_rx_desc_resources(struct =
stmmac_priv *priv,
> >   	pp_params.offset =3D stmmac_rx_offset(priv);
> >   	pp_params.max_len =3D dma_conf->dma_buf_sz;
> > +	if (priv->sph) {
> > +		pp_params.offset =3D 0;
> > +		pp_params.max_len +=3D stmmac_rx_offset(priv);
> > +	}
> > +
> >   	rx_q->page_pool =3D page_pool_create(&pp_params);
> >   	if (IS_ERR(rx_q->page_pool)) {
> >   		ret =3D PTR_ERR(rx_q->page_pool);
>=20
>=20
> Thanks for sending this. I can confirm that it fixes the issue we are see=
ing
> and so ...
>=20
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Yes, I can confirm as well. I've tested based on the discussion in the
earlier thread and had the equivalent of this patch (modulo the ->sph
check, but that's always true on this system), so:

Tested-by: Thierry Reding <treding@nvidia.com>

--fkugobpneo3jjh3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmemN+MACgkQ3SOs138+
s6Fq3A//eleSd2dC6AIYwZSlmN2xxQXFAVjTTNU/LQhRI2PSENWvFHSXJDcGTG+U
OTEIid1JgSaw+/xwshMu0F6lR1OmIeBCMudKmla/AxFUEOYF2JWkYPQgCfGalJxe
Ig9uZMsXmaxIeunEhaRQhYiBU0F9l7+IKe5yr8sFnUNrI1UJUQ23aJqAnCxJmtW7
3w/KbNMMii2TygqUrDaVHaDqOe4azGVzAGNYSd1g1iNpVYiORO8t6VHpiUBtJfme
k3ryZ+ptRKVTJX6pdiUYtjfTlSOW9ncvlgwyD8OGGaLG1RsoOWBiVTdGm13XDbm2
tDEY4ggUyPYUmphjKNsCjivZ9vqeMWoQ35MDCR3/pI6j/RVDkNSQmEH55qLyW4WD
67s3SF4eoDiAQAzzZ1C9vp96I2bm10J/NX2flJ036cw+2SXAl2rprzDrARhTupC9
uKTCXlV7vep2zRRDIljBxZDE90WTUL4fj/u9cKDXjRkkYrf5inVJuMM9zTO56HGn
hyYqmUhDklG4jLYmEp/g2H9pberttT7RCVo6UeI/P+Ms9B5Xszf+tiIzGti/SrDv
pCTV4/2D/wucb7zdNeX+a2j6D1rr6CgITO5sWT7i2w/o/UcHoXQV4E/gY39V4s9O
g1NrNtk9aOd2qalUqpS56aboQSaz04QWnYNubjlbxDgT9R+f46E=
=AlgO
-----END PGP SIGNATURE-----

--fkugobpneo3jjh3p--

