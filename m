Return-Path: <netdev+bounces-106114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B87A2914DFF
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6676C1F231FD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815FB13D531;
	Mon, 24 Jun 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3LtX1a+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA91311A1;
	Mon, 24 Jun 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234606; cv=none; b=I7kiP2iHw76piVWFVgVr1bcfbk1Dp2T7RCaex+BL8rAUTJdbGqEnOIrLIyoe6YSGy+/2L1WifIhWFKsxoLIhEhSsfAES3+Z2CcwEov62Tdf2/0L4vH10hGwCCi6fL9aihSnGTFCtb9TcjZRDs+eVyhpdIyAorJXnZFfaXtOCcDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234606; c=relaxed/simple;
	bh=ZNOSYfBHU/JMuVbC+tYd2ovrK1RAxjtVc4gjOkw6ABg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA4XLWTcgIw5YcpcP9BzPdDeW6XsMEdAwIw9Vd8AszXsJ/Iiz9qZ75NGp3hRmaiuaUJ2Khs/hwkVjYsvGtyn4Nv2JX3OoiLsE8j9pd9J6CQc66PwxVM16IqHFDWI+cayyCfUL2xa97uzCHuJQHipeXIz1afASvZbRwMN1vgZFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3LtX1a+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513EBC2BBFC;
	Mon, 24 Jun 2024 13:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719234605;
	bh=ZNOSYfBHU/JMuVbC+tYd2ovrK1RAxjtVc4gjOkw6ABg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3LtX1a+ym/XRSuXi3JcEcN6ZrO5QaXBt04cprYKbO9DHL/ZReeLpP7kIX6MhiBW9
	 0eCWDYXHvLq8A6cFoBHfAYTtHEIhFOyf+tA8TEjgGZNm842OBMFzarBrmwz3oMAW5a
	 GIj3jr3uRY752pwNNBvyg7mtxKmHjya1hWK3VWf1SB2bm8GsmPIokcOtDAZpS3E/77
	 2LptiL8ws/Q4L+TVctY5N1u1GhuSeTqi84WkUBMxbW+bMCDIZ0xH8zpbWmX0Ohs5vD
	 GHV+izLD5RukacXXTN28RniOyyRraa1Kb0XDlwdL0IH1ZEJx57iQy8hCWeTdNHMmhz
	 lm/ylSdbxj1XQ==
Date: Mon, 24 Jun 2024 15:10:02 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"nbd@nbd.name" <nbd@nbd.name>,
	"lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"conor@kernel.org" <conor@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"upstream@airoha.com" <upstream@airoha.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"benjamin.larsson@genexis.eu" <benjamin.larsson@genexis.eu>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <ZnlwKo1tKR-wI07p@lore-desk>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
 <BY3PR18MB4737D3B6C1CA79E3FFDCCDEBC6D42@BY3PR18MB4737.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NNCf/2QvrUCQb5Bk"
Content-Disposition: inline
In-Reply-To: <BY3PR18MB4737D3B6C1CA79E3FFDCCDEBC6D42@BY3PR18MB4737.namprd18.prod.outlook.com>


--NNCf/2QvrUCQb5Bk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 24, Sunil Kovvuri Goutham wrote:
> >Add airoha_eth driver in order to introduce ethernet support for
> >Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> >en7581-evb networking architecture is composed by airoha_eth as mac
> >controller (cpu port) and a mt7530 dsa based switch.
> >EN7581 mac controller is mainly composed by Frame Engine (FE) and
> >QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> >functionalities are supported now) while QDMA is used for DMA operation
> >and QOS functionalities between mac layer and the dsa switch (hw QoS is
> >not available yet and it will be added in the future).
> >Currently only hw lan features are available, hw wan will be added with
> >subsequent patches.
> >
> >Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> >Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >---
> >
> >+
> >+static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
> >+{
> ......................
> >+		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>=20
> Unconditionally setting UNNECESSARY for all pkts.
> Does HW reports csum errors ?

We enabled packet drop if TCP/UDP or IPv4 checksum is failed in
REG_GDM1_FWD_CFG register in airoha_fe_maccr_init(). In other words, if the=
 nic
forwards the packet to the cpu, the checksum is correct.

Regards,
Lorenzo

>=20
> Thanks,
> Sunil.
>=20

--NNCf/2QvrUCQb5Bk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZnlwKgAKCRA6cBh0uS2t
rCeUAQDKuiP8GcpikHBr84SEuvT2ObofyIaTjhI/xxlz0rkpFAD/Q6Wzz+Tg2yEk
jIjJqWEzCeodNO22dp30ELA/3VjhzA4=
=jhix
-----END PGP SIGNATURE-----

--NNCf/2QvrUCQb5Bk--

