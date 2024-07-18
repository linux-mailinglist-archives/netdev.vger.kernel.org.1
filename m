Return-Path: <netdev+bounces-112126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC3B935238
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 21:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C21282F49
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 19:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2319145B13;
	Thu, 18 Jul 2024 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb0t5blW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928513AA26;
	Thu, 18 Jul 2024 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331556; cv=none; b=BZrrjG8bOQ8xAgYkG/da82IN+O11f9qjsCygI5Vod7CS6SwzNDCPuPfF/g5HfJ/ipmFMR+yA45b/KD7HCtkNYueKZp6rOPdjRV38/UDOh+TgsZ14cXTPOxaR1QwlG38RsEq6UgoN6QHYUR12QeGwIh9V+gSyp0ArjfxqY6K7N+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331556; c=relaxed/simple;
	bh=3Oxn/O8Cot8sA3M6dSYeBY2dym38XFOUgiLPyiITpck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMEWn1dyaU56krkytQthMumyJmqyM/5fR2f0CwtFHPET/lTFvEzSgcsgoDMnw8rn4q33RxvZMTboqv7QwaTiScGQXMUbVXXDi2fQNWG9TW8X0IFprQ1wWTPYzKF94x4ldPoYZ1KxsC9eSRzUty3ClNMmsX30QSUeOVrg/Oz9K8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb0t5blW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F869C116B1;
	Thu, 18 Jul 2024 19:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721331556;
	bh=3Oxn/O8Cot8sA3M6dSYeBY2dym38XFOUgiLPyiITpck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lb0t5blWEsVxQMAAIsEkdkQ6FAA2H6U29yLkMKgjr09eRWHLM24YySj5Bx3vCEJs+
	 eXOdL6XI//huQ6VT+Zwuj1+oRJTzcuVRO+fivhhU3lQ4iXCU7KQYo6ZEE1B/hmiLCH
	 eE8+7vX8xtA6wxxCIWofG84Tzmwh4rdbjdqSly8dNDyGK38QB/pr/aLCFYUzNWjWDr
	 o9P6C2oUUcdxGFNI+AHWe++viIwEYhunvjegAbRzVg9tzwc6pVbS1GikxphiqUrr1V
	 AKXON1KB1sCUWx9scLQIV9J97zpmRgIwqBXmwCMpPFzQQZ9T+Jc1WIYZUd8mEYP36z
	 RiZqdP4BKvULg==
Date: Thu, 18 Jul 2024 21:39:12 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix forever loops in error handling
Message-ID: <ZplvYE1YDEUBTR4Q@lore-desk>
References: <693c433a-cf72-4938-a1aa-58af2ff89479@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k9Epfoq46wrPNTrg"
Content-Disposition: inline
In-Reply-To: <693c433a-cf72-4938-a1aa-58af2ff89479@stanley.mountain>


--k9Epfoq46wrPNTrg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> These loops have ++ where -- was intended.  It would end up looping until
> the system died.

Hi Dan,

I have already posted a fix for it:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D1f038d5897fe6b439039fc28420842abcc0d126b

Regards,
Lorenzo

>=20
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/mediatek/airoha_eth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/eth=
ernet/mediatek/airoha_eth.c
> index 7967a92803c2..698835dc6da0 100644
> --- a/drivers/net/ethernet/mediatek/airoha_eth.c
> +++ b/drivers/net/ethernet/mediatek/airoha_eth.c
> @@ -977,7 +977,7 @@ static int airoha_set_gdm_ports(struct airoha_eth *et=
h, bool enable)
>  	return 0;
> =20
>  error:
> -	for (i--; i >=3D 0; i++)
> +	while (--i >=3D 0)
>  		airoha_set_gdm_port(eth, port_list[i], false);
> =20
>  	return err;
> @@ -2431,7 +2431,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  	return NETDEV_TX_OK;
> =20
>  error_unmap:
> -	for (i--; i >=3D 0; i++)
> +	while (--i >=3D 0)
>  		dma_unmap_single(dev->dev.parent, q->entry[i].dma_addr,
>  				 q->entry[i].dma_len, DMA_TO_DEVICE);
> =20
> --=20
> 2.43.0
>=20

--k9Epfoq46wrPNTrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZplvYAAKCRA6cBh0uS2t
rNC8AP9GO+whLkH0wsxQawNmzPqkNemW01FJwDdnGMfvvu+DYAD+Pt57+Q7JdTKW
FfkVr1yCsZG5iaad7AAyQvlXrb7NmAw=
=RvDK
-----END PGP SIGNATURE-----

--k9Epfoq46wrPNTrg--

