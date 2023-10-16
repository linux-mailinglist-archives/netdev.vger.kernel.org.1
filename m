Return-Path: <netdev+bounces-41301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864207CA880
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 14:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1127A281669
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5626E10;
	Mon, 16 Oct 2023 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o5wfr7ss"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1446E208C0
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:50:26 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEACEAD;
	Mon, 16 Oct 2023 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697460625; x=1728996625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QegDkNMZMRhVlJdi4RGF/B2gb0RjIiBMZVBOlKntRnE=;
  b=o5wfr7ss592qcST9IJjcbdSaW/+qLH8/KSws4CwYDvSQKCfRFEKCzXtP
   s5Zmlx4dAnIZNUvGbBZcxq2lUMbnrwt+9J/mU84GITnStK7z4hH4qYCjc
   IEwpgG/ESESdaSsCvTtAogJH9BHnQqUBjHsQI/TR97jCR8xHRfa39EEp8
   RGdOjRhsCFKdHqXxvSs1kYL4fqNVx8eBxbFC8wJZtP1dfLP2333wv/XX7
   eoZcLaUPABNks1yAW13vvYYYoCRzjMMwDdcNFFRQOdeR/gs9cpVT4WYiJ
   bbIU0l8RN55SADj0HnwAzXtesDuJxlCO4f/lbxJcJy1hShLiZriaYLNst
   g==;
X-CSE-ConnectionGUID: ITNzLPtcTWajHI2MYV7Rww==
X-CSE-MsgGUID: +uJSPN5bQBOp65OEvyXvMQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="asc'?scan'208";a="240802253"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2023 05:50:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 16 Oct 2023 05:50:06 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 16 Oct 2023 05:50:02 -0700
Date: Mon, 16 Oct 2023 13:49:41 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Christoph Hellwig <hch@lst.de>
CC: Greg Ungerer <gerg@linux-m68k.org>, <iommu@lists.linux.dev>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley
	<conor@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
	<magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
	<linux-imx@nxp.com>, <linux-m68k@lists.linux-m68k.org>,
	<netdev@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-renesas-soc@vger.kernel.org>, Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH 01/12] riscv: RISCV_NONSTANDARD_CACHE_OPS shouldn't
 depend on RISCV_DMA_NONCOHERENT
Message-ID: <20231016-walmart-egomaniac-dc4c63ea70a6@wendy>
References: <20231016054755.915155-1-hch@lst.de>
 <20231016054755.915155-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H4bRYPb5tXhOAmff"
Content-Disposition: inline
In-Reply-To: <20231016054755.915155-2-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--H4bRYPb5tXhOAmff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Oct 16, 2023 at 07:47:43AM +0200, Christoph Hellwig wrote:
> RISCV_NONSTANDARD_CACHE_OPS is also used for the pmem cache maintenance
> helpers, which are built into the kernel unconditionally.

You surely have better insight than I do here, but is this actually
required?
This patch seems to allow creation of a kernel where the cache
maintenance operations could be used for pmem, but would be otherwise
unavailable, which seems counter intuitive to me.
Why would someone want to provide the pmem helpers with cache
maintenance operations, but not provide them generally?

I also don't really understand what the unconditional nature of the pmem
helpers has to do with anything, as this patch does not unconditionally
provide any cache management operations, only relax the conditions under
which the non-standard cache management operations can be provided.

What am I missing?

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/Kconfig          | 1 -
>  drivers/cache/Kconfig       | 2 +-
>  drivers/soc/renesas/Kconfig | 2 +-
>  3 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d607ab0f7c6daf..0ac0b538379718 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -277,7 +277,6 @@ config RISCV_DMA_NONCOHERENT
> =20
>  config RISCV_NONSTANDARD_CACHE_OPS
>  	bool
> -	depends on RISCV_DMA_NONCOHERENT
>  	help
>  	  This enables function pointer support for non-standard noncoherent
>  	  systems to handle cache management.
> diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
> index a57677f908f3ba..d6e5e3abaad8af 100644
> --- a/drivers/cache/Kconfig
> +++ b/drivers/cache/Kconfig
> @@ -3,7 +3,7 @@ menu "Cache Drivers"
> =20
>  config AX45MP_L2_CACHE
>  	bool "Andes Technology AX45MP L2 Cache controller"
> -	depends on RISCV_DMA_NONCOHERENT
> +	depends on RISCV
>  	select RISCV_NONSTANDARD_CACHE_OPS
>  	help
>  	  Support for the L2 cache controller on Andes Technology AX45MP platfo=
rms.
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index 12040ce116a551..880c544bb2dfda 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -335,7 +335,7 @@ config ARCH_R9A07G043
>  	bool "RISC-V Platform support for RZ/Five"
>  	depends on NONPORTABLE
>  	select ARCH_RZG2L
> -	select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT

FWIW, this one is already gone in linux-next, as part of fixing some
randconfig issues.

Cheers,
Conor.

> +	select AX45MP_L2_CACHE
>  	select DMA_GLOBAL_POOL
>  	select ERRATA_ANDES if RISCV_SBI
>  	select ERRATA_ANDES_CMO if ERRATA_ANDES
> --=20
> 2.39.2
>=20

--H4bRYPb5tXhOAmff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS0xZAAKCRB4tDGHoIJi
0r8WAP0V7KR64e4ZUtsXTDWdQEWkorwWePw0OFIpRuGhinkaEwD/c3YYEZm7U2pY
4IztZY7Ga6qv2gPgi28lN/xhzpKvZgg=
=rZtF
-----END PGP SIGNATURE-----

--H4bRYPb5tXhOAmff--

