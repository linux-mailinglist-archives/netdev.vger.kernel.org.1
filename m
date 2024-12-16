Return-Path: <netdev+bounces-152120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8989F2C5A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F981658AE
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44B11FFC6D;
	Mon, 16 Dec 2024 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeSLAR0Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082D1FF7B0
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339297; cv=none; b=VAreIZ5+TFJPdacPWaB22ZZO01sWWIJMWKtj6xpeRThUH+WtP0BncEuacfiWuCSGFIqnuTKj09T5YEJg23jHMcHdRczO+LaOW/JMwzUfvVwPocOPG3HIg+UGN3NDI/9V7oj8RajdpAg0fDcCwDt3ezPIUJQRfFY2JRYAc6kZVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339297; c=relaxed/simple;
	bh=ueAx4MDUx4QGJFCZ9Ssjl5PSZd44B1p3Fmtj8vR19uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r56qzF7fn9/6iTPX+imuKAJi6MAd4P+cOZp540gcBBHOLxdk3jR+TtV6qWOxleT3I4Zp+38ixjfzCxRkvyN/kFIoih9cE2Om8Q97k5ti7P6Q2/cqizyopZ+JCpVNq86eMDqpYWGW+UEWY5Bn/IYTKfJjMGIaHawWwUBkGMYl7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeSLAR0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3697C4CEDD;
	Mon, 16 Dec 2024 08:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734339297;
	bh=ueAx4MDUx4QGJFCZ9Ssjl5PSZd44B1p3Fmtj8vR19uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeSLAR0ZbC9ioITrynkKXWeHpqr79aMbctHhZepc4Km9fVPn/4SkbLGMWlLZKlEak
	 VMcDIE8819AUbBVa8Jqv+3TqTkJkQmIiTWf4Vqat3PH8ogenT0z7HY68LiyOuAU0sk
	 EB+GwYHqRT2sCAIIMFnXLa4rANRXaptNIim9QC+XkjG3AHpcxz63umOIIyRxoSBnFJ
	 Ez3nu6sYvNBRcpqUmo5StAHuj+4rmDQ5STHfQYl2DoaNPkPeTFlp8dibmTIMceBSXA
	 xc5KRI4lzRUeA0R3G93hd32npBREHmRV7QW5gPgOY4LVu4YksrMFe83KpZF1OEbIHI
	 QDT4/askROUAA==
Date: Mon, 16 Dec 2024 09:54:54 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix error patch in airoha_probe()
Message-ID: <Z1_q3tnwtRBq-fQE@lore-desk>
References: <20241215-airoha_probe-error-path-fix-v1-1-dd299122d343@kernel.org>
 <Z1/Tng80hii4dBQU@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k9cFlZGy+0zOzppE"
Content-Disposition: inline
In-Reply-To: <Z1/Tng80hii4dBQU@mev-dev.igk.intel.com>


--k9cFlZGy+0zOzppE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Dec 15, 2024 at 06:36:35PM +0100, Lorenzo Bianconi wrote:
> > Do not run napi_disable if airoha_hw_init() fails since Tx/Rx napi
> > has not been started yet. In order to fix the issue, introduce
> > airoha_qdma_disable_napi routine and remove napi_disable in
> > airoha_hw_cleanup().
> >=20
> > Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN758=
1 SoC")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/mediatek/airoha_eth.c | 33 ++++++++++++++++++++++=
--------
> >  1 file changed, 25 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/e=
thernet/mediatek/airoha_eth.c
> > index 6c683a12d5aa52dd9d966df123509075a989c0b3..5bbf5fee2802135ff608323=
3d0bda78f2ba5606a 100644
> > --- a/drivers/net/ethernet/mediatek/airoha_eth.c
> > +++ b/drivers/net/ethernet/mediatek/airoha_eth.c
> > @@ -2138,17 +2138,14 @@ static void airoha_hw_cleanup(struct airoha_qdm=
a *qdma)
> >  		if (!qdma->q_rx[i].ndesc)
> >  			continue;
> > =20
> > -		napi_disable(&qdma->q_rx[i].napi);
> >  		netif_napi_del(&qdma->q_rx[i].napi);
> >  		airoha_qdma_cleanup_rx_queue(&qdma->q_rx[i]);
> >  		if (qdma->q_rx[i].page_pool)
> >  			page_pool_destroy(qdma->q_rx[i].page_pool);
> >  	}
> > =20
> > -	for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
> > -		napi_disable(&qdma->q_tx_irq[i].napi);
> > +	for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
> >  		netif_napi_del(&qdma->q_tx_irq[i].napi);
> > -	}
> > =20
> >  	for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
> >  		if (!qdma->q_tx[i].ndesc)
> > @@ -2173,6 +2170,21 @@ static void airoha_qdma_start_napi(struct airoha=
_qdma *qdma)
> >  	}
> >  }
> > =20
> > +static void airoha_qdma_disable_napi(struct airoha_qdma *qdma)
> Nit: similar function for enabling napi is named airoha_qdma_start_napi()
> maybe stop here or enable there to be consistent.
>=20
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>=20
> Thanks

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
> > +		napi_disable(&qdma->q_tx_irq[i].napi);
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
> > +		if (!qdma->q_rx[i].ndesc)
> > +			continue;
> > +
> > +		napi_disable(&qdma->q_rx[i].napi);
> > +	}
> > +}
> > +
>=20
> [...]

--k9cFlZGy+0zOzppE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ1/q3gAKCRA6cBh0uS2t
rHdwAQDkwNoKHlLv4DFuRV0cVVaUQgmWSouorR++rrQv8srd6gD9HvF8JFxX6Vh9
SWqgKwUuQpaP0ZYYs5VsyOYuzgVTPgw=
=tfqU
-----END PGP SIGNATURE-----

--k9cFlZGy+0zOzppE--

