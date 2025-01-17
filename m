Return-Path: <netdev+bounces-159378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC2AA15537
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0C6161958
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792A419E979;
	Fri, 17 Jan 2025 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJJbfjFa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36F19CCEC;
	Fri, 17 Jan 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133412; cv=none; b=RXvqdTBH6Wkf8tH3Fsf9DYHxoqpxgCvOY84CyFE/Sk7exURUIOVw/FGoMJEQhNyli/HvUqoYLl/ZE8oEy4y7D4Er7ovLeyiLmBxWms8jQnkhjG+gVUNVarfbRBnnX85nI+Kj6oYj2V9JK/Rd2yeSm8+xhf6TMJoCsWo+8C8LzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133412; c=relaxed/simple;
	bh=7+7jqSST9DXKAARHg+D99JW6DXAhw6kqu5zZwJaCdA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecjf6CzFiJKg8Nkd6Yf6Sdx+5gQ+iYDOsZDaiALeamL465Wme9NcS5reYWt9r1i8YfsccrjgPTdtq2EN7juzqzbUWL/yqUKwqqjQkNpCNqPbiAcvw6irGILyFflhr4NlAG0ak7PzusGO/82b4AdpxBsnBc7Anoo5uAsKGiIZ88M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJJbfjFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAE4C4CEDD;
	Fri, 17 Jan 2025 17:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737133411;
	bh=7+7jqSST9DXKAARHg+D99JW6DXAhw6kqu5zZwJaCdA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJJbfjFa60XiZ4VAGecLla1hbgUb65SMy6TIOGVyF5tJSyQeauVWNKrNjy/T7bYyy
	 K1T0nkgFCn2ErUYFkyx3JrEa4tdOCLmK13CZa/I0/PXk1J+CyYAur6WoFHk0UTYt/f
	 1U0V+ZHS7IGMxcJ4gihPHVLalHEfcFxXgXQhkusdT8PDouxUODx6ZLt//DFWtalmBw
	 Uw+eMw1BtR8ARe8h+qKukUYKcT5E1vKa1NtRn2sVlcOJphox5oqcDiZ8mdirLpvt5p
	 wfjJ9u6gztvti5Q4ZiMqw9/BszLDYvBlDA7flt4qmqsXBbzhZkixdu1REnmtGqniPE
	 9mgu4A/E2zLxg==
Date: Fri, 17 Jan 2025 18:03:28 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, upstream@airoha.com
Subject: Re: [net PATCH] net: airoha: Fix wrong GDM4 register definition
Message-ID: <Z4qNYBWBFn-Adbli@lore-desk>
References: <20250117155257.19263-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dDHGaHO6hPydbGRy"
Content-Disposition: inline
In-Reply-To: <20250117155257.19263-1-ansuelsmth@gmail.com>


--dDHGaHO6hPydbGRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 17, Christian Marangi wrote:
> Fix wrong GDM4 register definition, in Airoha SDK GDM4 is defined at
> offset 0x2400 but this doesn't make sense as it does conflict with the
> CDM4 that is in the same location.
>=20
> Following the pattern where each GDM base is at the FWD_CFG, currently
> GDM4 base offset is set to 0x2500. This is correct but REG_GDM4_FWD_CFG
> and REG_GDM4_SRC_PORT_SET are still using the SDK reference with the
> 0x2400 offset. Fix these 2 define by subtracting 0x100 to each register
> to reflect the real address location.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/ethernet/mediatek/airoha_regs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/airoha_regs.h b/drivers/net/et=
hernet/mediatek/airoha_regs.h
> index e448b66b5334..30c96f679735 100644
> --- a/drivers/net/ethernet/mediatek/airoha_regs.h
> +++ b/drivers/net/ethernet/mediatek/airoha_regs.h
> @@ -249,11 +249,11 @@
>  #define REG_GDM3_FWD_CFG		GDM3_BASE
>  #define GDM3_PAD_EN_MASK		BIT(28)
> =20
> -#define REG_GDM4_FWD_CFG		(GDM4_BASE + 0x100)
> +#define REG_GDM4_FWD_CFG		GDM4_BASE
>  #define GDM4_PAD_EN_MASK		BIT(28)
>  #define GDM4_SPORT_OFFSET0_MASK		GENMASK(11, 8)
> =20
> -#define REG_GDM4_SRC_PORT_SET		(GDM4_BASE + 0x33c)
> +#define REG_GDM4_SRC_PORT_SET		(GDM4_BASE + 0x23c)
>  #define GDM4_SPORT_OFF2_MASK		GENMASK(19, 16)
>  #define GDM4_SPORT_OFF1_MASK		GENMASK(15, 12)
>  #define GDM4_SPORT_OFF0_MASK		GENMASK(11, 8)
> --=20
> 2.47.1
>=20

--dDHGaHO6hPydbGRy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ4qNYAAKCRA6cBh0uS2t
rKM9AP9qxIC+KDo4D2c6L+3TtapTrfantCgjpRZKdGBE3AW47QEAxqhGFldb4QF/
WgB/p4rDxSN9ukHVhmmzMDKo0ICFTAY=
=QQSQ
-----END PGP SIGNATURE-----

--dDHGaHO6hPydbGRy--

