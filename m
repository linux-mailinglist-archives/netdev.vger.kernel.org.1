Return-Path: <netdev+bounces-47180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 712037E8A16
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 10:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD445B20ABA
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 09:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3B311C9B;
	Sat, 11 Nov 2023 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZZps5wk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9243F1170F
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 09:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45ADC433C8;
	Sat, 11 Nov 2023 09:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699696151;
	bh=HuMp3aDBc6eDQKmMTmycdyRqEdjmcWmMwpTTcBuCirg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZZps5wkj/9aeHWxtZPVUW7UAznDqOf6aiTftPBEQv6Ne/QahFtWnFnFmzx2WgpPk
	 i6Ktk+LpCvy/Xd3kEbFStKlgPJ5RAky3EBH+cmRvYMKLLqLABPmtaaDO8AIYTJ737x
	 km16WMHG3F/wP7rs3hH0MeukU5u/wvQRPK4fLNyVhjpQaxr541IWlobNs0itZv4QU7
	 FVKXEQLKHSqyNOEMY6mQmQrRet1k8A4vTGr0pTDripEmO5LGnb8UoZ1m17onF9KWmU
	 +i8P/vYUM3SB/rapdrb8tlMNM5JL9YtsJUimATth8AR5eijAXXzcZG0n/LseaFT7a3
	 pWUjBRB/CzhoA==
Date: Sat, 11 Nov 2023 10:49:07 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sven Auhagen <sven.auhagen@voleatech.de>
Cc: netdev@vger.kernel.org, thomas.petazzoni@bootlin.com, brouer@redhat.com,
	ilias.apalodimas@linaro.org, mcroce@microsoft.com, leon@kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v5] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <ZU9OEwz7GoHbBE1m@lore-desk>
References: <ydvyjmjgpppf2hd7rzb6iu2hi6aiuxoa7sq5qnorknwk5txuca@7fgznkjwynsf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="coe4qxv7etPQ1vbQ"
Content-Disposition: inline
In-Reply-To: <ydvyjmjgpppf2hd7rzb6iu2hi6aiuxoa7sq5qnorknwk5txuca@7fgznkjwynsf>


--coe4qxv7etPQ1vbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Calling page_pool_get_stats in the mvneta driver without checks
> leads to kernel crashes.
> First the page pool is only available if the bm is not used.
> The page pool is also not allocated when the port is stopped.
> It can also be not allocated in case of errors.
>=20
> The current implementation leads to the following crash calling
> ethstats on a port that is down or when calling it at the wrong moment:
>=20
> ble to handle kernel NULL pointer dereference at virtual address 00000070
> [00000070] *pgd=3D00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Hardware name: Marvell Armada 380/385 (Device Tree)
> PC is at page_pool_get_stats+0x18/0x1cc
> LR is at mvneta_ethtool_get_stats+0xa0/0xe0 [mvneta]
> pc : [<c0b413cc>]    lr : [<bf0a98d8>]    psr: a0000013
> sp : f1439d48  ip : f1439dc0  fp : 0000001d
> r10: 00000100  r9 : c4816b80  r8 : f0d75150
> r7 : bf0b400c  r6 : c238f000  r5 : 00000000  r4 : f1439d68
> r3 : c2091040  r2 : ffffffd8  r1 : f1439d68  r0 : 00000000
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 066b004a  DAC: 00000051
> Register r0 information: NULL pointer
> Register r1 information: 2-page vmalloc region starting at 0xf1438000 all=
ocated at kernel_clone+0x9c/0x390
> Register r2 information: non-paged memory
> Register r3 information: slab kmalloc-2k start c2091000 pointer offset 64=
 size 2048
> Register r4 information: 2-page vmalloc region starting at 0xf1438000 all=
ocated at kernel_clone+0x9c/0x390
> Register r5 information: NULL pointer
> Register r6 information: slab kmalloc-cg-4k start c238f000 pointer offset=
 0 size 4096
> Register r7 information: 15-page vmalloc region starting at 0xbf0a8000 al=
located at load_module+0xa30/0x219c
> Register r8 information: 1-page vmalloc region starting at 0xf0d75000 all=
ocated at ethtool_get_stats+0x138/0x208
> Register r9 information: slab task_struct start c4816b80 pointer offset 0
> Register r10 information: non-paged memory
> Register r11 information: non-paged memory
> Register r12 information: 2-page vmalloc region starting at 0xf1438000 al=
located at kernel_clone+0x9c/0x390
> Process snmpd (pid: 733, stack limit =3D 0x38de3a88)
> Stack: (0xf1439d48 to 0xf143a000)
> 9d40:                   000000c0 00000001 c238f000 bf0b400c f0d75150 c481=
6b80
> 9d60: 00000100 bf0a98d8 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 9d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 9da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 9dc0: 00000dc0 5335509c 00000035 c238f000 bf0b2214 01067f50 f0d75000 c0b9=
b9c8
> 9de0: 0000001d 00000035 c2212094 5335509c c4816b80 c238f000 c5ad6e00 0106=
7f50
> 9e00: c1b0be80 c4816b80 00014813 c0b9d7f0 00000000 00000000 0000001d 0000=
001d
> 9e20: 00000000 00001200 00000000 00000000 c216ed90 c73943b8 00000000 0000=
0000
> 9e40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 9e60: 00000000 c0ad9034 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 9e80: 00000000 00000000 00000000 5335509c c1b0be80 f1439ee4 00008946 c1b0=
be80
> 9ea0: 01067f50 f1439ee3 00000000 00000046 b6d77ae0 c0b383f0 00008946 becc=
83e8
> 9ec0: c1b0be80 00000051 0000000b c68ca480 c7172d00 c0ad8ff0 f1439ee3 cf60=
0e40
> 9ee0: 01600e40 32687465 00000000 00000000 00000000 01067f50 00000000 0000=
0000
> 9f00: 00000000 5335509c 00008946 00008946 00000000 c68ca480 becc83e8 c05e=
2de0
> 9f20: f1439fb0 c03002f0 00000006 5ac3c35a c4816b80 00000006 b6d77ae0 c030=
caf0
> 9f40: c4817350 00000014 f1439e1c 0000000c 00000000 00000051 01000000 0000=
0014
> 9f60: 00003fec f1439edc 00000001 c0372abc b6d77ae0 c0372abc cf600e40 5335=
509c
> 9f80: c21e6800 01015c9c 0000000b 00008946 00000036 c03002f0 c4816b80 0000=
0036
> 9fa0: b6d77ae0 c03000c0 01015c9c 0000000b 0000000b 00008946 becc83e8 0000=
0000
> 9fc0: 01015c9c 0000000b 00008946 00000036 00000035 010678a0 b6d797ec b6d7=
7ae0
> 9fe0: b6dbf738 becc838c b6d186d7 b6baa858 40000030 0000000b 00000000 0000=
0000
>  page_pool_get_stats from mvneta_ethtool_get_stats+0xa0/0xe0 [mvneta]
>  mvneta_ethtool_get_stats [mvneta] from ethtool_get_stats+0x154/0x208
>  ethtool_get_stats from dev_ethtool+0xf48/0x2480
>  dev_ethtool from dev_ioctl+0x538/0x63c
>  dev_ioctl from sock_ioctl+0x49c/0x53c
>  sock_ioctl from sys_ioctl+0x134/0xbd8
>  sys_ioctl from ret_fast_syscall+0x0/0x1c
> Exception stack(0xf1439fa8 to 0xf1439ff0)
> 9fa0:                   01015c9c 0000000b 0000000b 00008946 becc83e8 0000=
0000
> 9fc0: 01015c9c 0000000b 00008946 00000036 00000035 010678a0 b6d797ec b6d7=
7ae0
> 9fe0: b6dbf738 becc838c b6d186d7 b6baa858
> Code: e28dd004 e1a05000 e2514000 0a00006a (e5902070)
>=20
> This commit adds the proper checks before calling page_pool_get_stats.
>=20
> Fixes: b3fc79225f05 ("net: mvneta: add support for page_pool_get_stats")
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> Reported-by: Paulo Da Silva <Paulo.DaSilva@kyberna.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> Change from v4:
> 	* Remove is_stopped check
> 	* Variable ordering
>=20
> Change from v3:
> 	* Move the page pool check back to mvneta
>=20
> Change from v2:
> 	* Fix the fixes tag
>=20
> Change from v1:
> 	* Add cover letter
> 	* Move the page pool check in mvneta to the ethtool stats
> 	  function
>=20
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet=
/marvell/mvneta.c
> index 8b0f12a0e0f2..c498ef831d61 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -4733,14 +4733,17 @@ static void mvneta_ethtool_get_strings(struct net=
_device *netdev, u32 sset,
>  				       u8 *data)
>  {
>  	if (sset =3D=3D ETH_SS_STATS) {
> +		struct mvneta_port *pp =3D netdev_priv(netdev);
>  		int i;
> =20
>  		for (i =3D 0; i < ARRAY_SIZE(mvneta_statistics); i++)
>  			memcpy(data + i * ETH_GSTRING_LEN,
>  			       mvneta_statistics[i].name, ETH_GSTRING_LEN);
> =20
> -		data +=3D ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
> -		page_pool_ethtool_stats_get_strings(data);
> +		if (!pp->bm_priv) {
> +			data +=3D ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
> +			page_pool_ethtool_stats_get_strings(data);
> +		}
>  	}
>  }
> =20
> @@ -4858,8 +4861,10 @@ static void mvneta_ethtool_pp_stats(struct mvneta_=
port *pp, u64 *data)
>  	struct page_pool_stats stats =3D {};
>  	int i;
> =20
> -	for (i =3D 0; i < rxq_number; i++)
> -		page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
> +	for (i =3D 0; i < rxq_number; i++) {
> +		if (pp->rxqs[i].page_pool)
> +			page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
> +	}
> =20
>  	page_pool_ethtool_stats_get(data, &stats);
>  }
> @@ -4875,14 +4880,21 @@ static void mvneta_ethtool_get_stats(struct net_d=
evice *dev,
>  	for (i =3D 0; i < ARRAY_SIZE(mvneta_statistics); i++)
>  		*data++ =3D pp->ethtool_stats[i];
> =20
> -	mvneta_ethtool_pp_stats(pp, data);
> +	if (!pp->bm_priv)
> +		mvneta_ethtool_pp_stats(pp, data);
>  }
> =20
>  static int mvneta_ethtool_get_sset_count(struct net_device *dev, int sse=
t)
>  {
> -	if (sset =3D=3D ETH_SS_STATS)
> -		return ARRAY_SIZE(mvneta_statistics) +
> -		       page_pool_ethtool_stats_get_count();
> +	if (sset =3D=3D ETH_SS_STATS) {
> +		int count =3D ARRAY_SIZE(mvneta_statistics);
> +		struct mvneta_port *pp =3D netdev_priv(dev);
> +
> +		if (!pp->bm_priv)
> +			count +=3D page_pool_ethtool_stats_get_count();
> +
> +		return count;
> +	}
> =20
>  	return -EOPNOTSUPP;
>  }
> --=20
> 2.42.0
>=20

--coe4qxv7etPQ1vbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZU9OEwAKCRA6cBh0uS2t
rN3hAP9NroWJYl+w8i0eGc7r/DR9XBPZNzTHNMuZ5QWeRTAB6wEAuRC55P5spyeH
4TafyKF88ADRSYHBVV93HcDT6vCUTwQ=
=O3E1
-----END PGP SIGNATURE-----

--coe4qxv7etPQ1vbQ--

