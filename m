Return-Path: <netdev+bounces-187618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C7EAA81C5
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 19:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB605A474E
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B542798E3;
	Sat,  3 May 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVNRyeU/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEF5130E58;
	Sat,  3 May 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746292478; cv=none; b=ixGeLoZrh6HeS2bDzMdFN07euG1iaRBIOrZ3TW3dBNh0PDTS6VSXOTdGAegYP9FNEakaVPRpmDGbwG8OpRF6hTvd3b8EFyW5yI7v4yKjNYy9qzC20hObE6yuLjM06qDhg5Tk36ODepF9LK0PLbdj/fqwub1r1A7E87gTmsIxWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746292478; c=relaxed/simple;
	bh=TO0GFJ0GhL304hsOhpjSdH3o1D4SYQYquYsY9RZQ6fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldR33cae+92MYwpVZTaEkSMmS4lCo0rgpu9gxM6CTy+Mi0NCcGzB3Xo3BMz6kWXc56UfQII8kdgUeBflu0rlirwlYV/tLv7kYZNoGOIxLBSmULdWVVtOC4B8LXxp9bciut9AZhU1J700Imnn7Zgueco5FcUA3HmVfWticwj/x00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVNRyeU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DAEC4CEE3;
	Sat,  3 May 2025 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746292477;
	bh=TO0GFJ0GhL304hsOhpjSdH3o1D4SYQYquYsY9RZQ6fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVNRyeU/8qZCUHMRmqHsxd5g3wj3Um9s0fPqjmF5GJy0xnk6UdVnLE3sQFHlaeyhH
	 zLZ2LMG7iSw1jV21YXZZIntyIOzxPIVxMPUBSeP6M4B3rWXGiRp2/RzgsSZ6GalLQ7
	 Fy2CysyqQe2BR4bVNvFHxoL5QdtV9qWiXhaX8xaBdAI9IQDCffFWTb2HqsGh2ifmSN
	 YG9NdFDUC93Y3SiJs32tmhMhEF826K6+hsMzufCcNKwJCfnPIUeSQFi22IGCQ90we1
	 /jNiPrzHvFDLIANuISVIYQpEolSAIm3ZIV2cQ6pJDa0Wf06n1YYmOEUlgrK9Qg9E8A
	 4jEBTpDVdslKA==
Date: Sat, 3 May 2025 19:14:34 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Elad Yifee <eladwf@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 1/2] net: ethernet: mtk_eth_soc: reset all TX queues
 on DMA free
Message-ID: <aBZO-nmFoKLx5E5w@lore-desk>
References: <27713d0004ead6e57d070f9e19c0d13709ba2512.1746285649.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rv+qQaaENS0fon55"
Content-Disposition: inline
In-Reply-To: <27713d0004ead6e57d070f9e19c0d13709ba2512.1746285649.git.daniel@makrotopia.org>


--Rv+qQaaENS0fon55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The purpose of resetting the TX queue is to reset the
> byte and packet count as well as to clear the software
> flow control XOFF bit.
>=20
> MediaTek developers pointed out that netdev_reset_queue would only
> resets queue 0 of the network device.
>=20
> Queues that are not reset may cause unexpected issues.
>=20
> Packets may stop being sent after reset and "transmit timeout" log may
> be displayed.
>=20
> Import fix from MediaTek's SDK to resolve this issue.
>=20
> Link: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwr=
t-feeds/+/319c0d9905579a46dc448579f892f364f1f84818
> Fixes: f63959c7eec31 ("net: ethernet: mtk_eth_soc: implement multi-queue =
support for per-port queues")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/et=
hernet/mediatek/mtk_eth_soc.c
> index 217355d79bbb7..d6d4c2daebab0 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -3274,11 +3274,19 @@ static int mtk_dma_init(struct mtk_eth *eth)
>  static void mtk_dma_free(struct mtk_eth *eth)
>  {
>  	const struct mtk_soc_data *soc =3D eth->soc;
> -	int i;
> +	int i, j, txqs =3D 1;
> +
> +	if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA))
> +		txqs =3D MTK_QDMA_NUM_QUEUES;
> +
> +	for (i =3D 0; i < MTK_MAX_DEVS; i++) {
> +		if (!eth->netdev[i])
> +			continue;
> +
> +		for (j =3D 0; j < txqs; j++)
> +			netdev_tx_reset_queue(netdev_get_tx_queue(eth->netdev[i], j));

nit: you can use netdev_tx_reset_subqueue() here.

Regards,
Lorenzo

> +	}
> =20
> -	for (i =3D 0; i < MTK_MAX_DEVS; i++)
> -		if (eth->netdev[i])
> -			netdev_reset_queue(eth->netdev[i]);
>  	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && eth->scratch_ring) {
>  		dma_free_coherent(eth->dma_dev,
>  				  MTK_QDMA_RING_SIZE * soc->tx.desc_size,
> --=20
> 2.49.0

--Rv+qQaaENS0fon55
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaBZO+gAKCRA6cBh0uS2t
rE0aAQDxoKadhJgML6RMtuWFIuS6nXVqip1kMkzOx8SOecG8mAEAu48++YTfL3y+
spXzcEGZDYYHs2oCuQXYweAp4NW2YAI=
=Q4YT
-----END PGP SIGNATURE-----

--Rv+qQaaENS0fon55--

