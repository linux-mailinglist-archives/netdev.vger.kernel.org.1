Return-Path: <netdev+bounces-207376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20557B06EDA
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F803AAA8E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D7D288C16;
	Wed, 16 Jul 2025 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+zQxyjG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D049E17B50A;
	Wed, 16 Jul 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650477; cv=none; b=ImymOgvxv7KSvTadov3ovtjpcLWlIKUBc/b04K0aAzRZ2nuWMu1/0kErqIthewfZolLCfMKCdgdpL2jvcA1wVvlz32MgCtDvXF6B8a1BRfA7nN0diXsUAE2qfASep++LYy6S127td7+IW5P0azVaWASMF41e7M1/KNL0tA26fBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650477; c=relaxed/simple;
	bh=wbYVLhPOCi1vaoM7sTYVmfW1ciprMAQ8sQlxUBmwWnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU8DXPxm+T7F3fCE4P/aFSof+Uc17HzPWZwz/9EZvVBw5+KBXF85Ry2fZ+2Jygz4k8P2ubjBExpAT/065nTv5SeJh3OtEUE5WzMOAjLGzDQSjdZ5m8nj6QJP2fFZMqdqMuhi0AbMWwIaF2bscnrX3Yl3vfJUgeB1O2JmdK9GRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+zQxyjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073B0C4CEF5;
	Wed, 16 Jul 2025 07:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752650477;
	bh=wbYVLhPOCi1vaoM7sTYVmfW1ciprMAQ8sQlxUBmwWnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+zQxyjGCDYcaP1LOQ4yvAGzfm9/yK0TZ8kv1G2i1KtEbA3F3mai3qoOO7djM14SK
	 Y255zByLUqIafo43lTVWuEhoj1StgVueK8xQacfHVVdQkJhwZugnMbxTMlubf87dgj
	 nJlN7EbS+iA7UMXdgLB/SQNnRdkiMNKo8UjIkGDs1l3T6II8Dx4sUtQ6sm4mivu9uc
	 NFHoSV0aHED5FMkDePsKBa9qA0XnzxYITizl1Ls+sX3dovkAG1eQmHKhgXmizK3RmM
	 PuUyONl+6kLCMsv4eDzWX2JeKaTT3dM2f/WEfIVX/prQZgLtIAa5XqVnaonLFVLn3t
	 AXD6cgqjgZaAA==
Date: Wed, 16 Jul 2025 09:21:14 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: Fix NULL vs IS_ERR()
 bug in mtk_wed_get_memory_region()
Message-ID: <aHdS6o8RNMWplCuT@lore-desk>
References: <87c10dbd-df86-4971-b4f5-40ba02c076fb@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6T5EAh89/vZOaNaz"
Content-Disposition: inline
In-Reply-To: <87c10dbd-df86-4971-b4f5-40ba02c076fb@sabinyo.mountain>


--6T5EAh89/vZOaNaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> We recently changed this from using devm_ioremap() to using
> devm_ioremap_resource() and unfortunately the former returns NULL while
> the latter returns error pointers.  The check for errors needs to be
> updated as well.
>=20
> Fixes: e27dba1951ce ("net: Use of_reserved_mem_region_to_resource{_byname=
}() for "memory-region"")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/et=
hernet/mediatek/mtk_wed_mcu.c
> index 8498b35ec7a6..fa6b21603416 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
> @@ -247,8 +247,10 @@ mtk_wed_get_memory_region(struct mtk_wed_hw *hw, con=
st char *name,
>  	region->phy_addr =3D res.start;
>  	region->size =3D resource_size(&res);
>  	region->addr =3D devm_ioremap_resource(hw->dev, &res);
> +	if (IS_ERR(region->addr))
> +		return PTR_ERR(region->addr);
> =20
> -	return !region->addr ? -EINVAL : 0;
> +	return 0;
>  }
> =20
>  static int
> --=20
> 2.47.2
>=20

--6T5EAh89/vZOaNaz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaHdS6gAKCRA6cBh0uS2t
rJY+AP9l/ZwTg4VNy3YmVDYG7Q6N4lpACY/dpdBptMwTbwVXRQD/VnVlpZVCHfGU
giDlSZY55au/4/6aau9dTKjSxPxYzAE=
=DYVE
-----END PGP SIGNATURE-----

--6T5EAh89/vZOaNaz--

