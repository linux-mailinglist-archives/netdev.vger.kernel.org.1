Return-Path: <netdev+bounces-85572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2576C89B6FC
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 06:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529EDB2105D
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 04:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0996263CB;
	Mon,  8 Apr 2024 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KWjK23+y"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155D3566A;
	Mon,  8 Apr 2024 04:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712551709; cv=none; b=acRV4ezMEyM6+5RBjKA+LsAzijhCH+Pyrgs3rNiyDVQAl64SWTb+UMSX8rbYpzjvbfOXqld3wiBb+PN+fdCwX+Ic5TX2V9Tzcqy0VljBUkYG6NsyRWiITi5HiRSumJr3rQlCtxHt+noB8L9OK90Fhw/5wj04ScyQUXKSWAi8wMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712551709; c=relaxed/simple;
	bh=/D5kjsfsJdiDdaQwGVVFUWrMd2HDh+zg+RwTqv9kdqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NJV9uj7XvXt/RUrlSVxS37mgC8bNJZNWO9WcQ0bXaoajWm16DGR85CuoCgHFUL8p8OpHwRZthIt7Gxe4nr6CBllyaLWhGXtaRjQnktnN/T6nZDy3ak2/lX8y5j7eW4CbUqJ+nJfj/sDWCscug79TL92numDvd0FryuZaLngIsVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=KWjK23+y; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712551705;
	bh=IpU2QpSZg46kAHUBDGrgW+pdugVyxW5ZiVLWGqq1RMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KWjK23+yiyYGRGatLbITytavO0r4Q0wv49xIFeUm+MS8qa0QSsQFOIMq5Swy1LbnY
	 3OLH0f68FILNILH444xqAV4UFrx5k3CpND+p0N9a0+5dwcGPVns41StOJMLUqovw9Q
	 g0kjD18aSWvTO+BOk8ImUHzeri1rIEjmhmwyvhPErOCl3OJ0h8TsHO9MAnSLK/vnK4
	 +XrsXnGCejwS2EUPRgdeKOD1OFQjOLGjbjQ8ZrWddbLQWdasjj3zTRBTmTmS4WdBKn
	 7/fjhfmEb7aUjszUEgKkbEcX/blOz3Sdxp7VmKEhLSzSITaUozgadzGuxeHrt2yt0P
	 OBYUG6c8Osdbg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VCc6b6RhPz4wjF;
	Mon,  8 Apr 2024 14:48:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Greg
 Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Li Yang <leoyang.li@nxp.com>, Zhang Wei
 <zw@zh-kernel.org>, kernel@pengutronix.de, Shawn Guo
 <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 vladimir.oltean@nxp.com
Subject: Re: [PATCH] MAINTAINERS: Drop Li Yang as their email address
 stopped working
In-Reply-To: <20240405072042.697182-2-u.kleine-koenig@pengutronix.de>
References: <20240405072042.697182-2-u.kleine-koenig@pengutronix.de>
Date: Mon, 08 Apr 2024 14:48:23 +1000
Message-ID: <871q7gcve0.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
> When sending a patch to (among others) Li Yang the nxp MTA replied that
> the address doesn't exist and so the mail couldn't be delivered. The
> error code was 550, so at least technically that's not a temporal issue.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> I added the affected maintainers and lists to Cc:, maybe someone there
> knows if this issue is only temporal?

Apparently not. See https://lore.kernel.org/all/20240219153016.ntltc76bphwr=
v6hn@skbuf/

  Leo Li (Li Yang) is no longer with NXP.


cheers

> @Greg: Given that I noticed the non-existing address when sending an usb
> patch, I suggest you care for application of this patch (iff it should
> be applied now). If Li Yang disappeared indeed, I'd prefer to drop the
> contact from MAINTAINERS early to not give wrong expectations to
> contributors.
>
> Best regards
> Uwe
>
>  MAINTAINERS | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c121493f43d..be19aad15045 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2191,7 +2191,6 @@ N:	mxs
>=20=20
>  ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE
>  M:	Shawn Guo <shawnguo@kernel.org>
> -M:	Li Yang <leoyang.li@nxp.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> @@ -8523,7 +8522,6 @@ S:	Maintained
>  F:	drivers/video/fbdev/fsl-diu-fb.*
>=20=20
>  FREESCALE DMA DRIVER
> -M:	Li Yang <leoyang.li@nxp.com>
>  M:	Zhang Wei <zw@zh-kernel.org>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Maintained
> @@ -8688,10 +8686,9 @@ F:	drivers/soc/fsl/qe/tsa.h
>  F:	include/dt-bindings/soc/cpm1-fsl,tsa.h
>=20=20
>  FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
> -M:	Li Yang <leoyang.li@nxp.com>
>  L:	netdev@vger.kernel.org
>  L:	linuxppc-dev@lists.ozlabs.org
> -S:	Maintained
> +S:	Orphan
>  F:	drivers/net/ethernet/freescale/ucc_geth*
>=20=20
>  FREESCALE QUICC ENGINE UCC HDLC DRIVER
> @@ -8708,10 +8705,9 @@ S:	Maintained
>  F:	drivers/tty/serial/ucc_uart.c
>=20=20
>  FREESCALE SOC DRIVERS
> -M:	Li Yang <leoyang.li@nxp.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained
> +S:	Orphan
>  F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
>  F:	Documentation/devicetree/bindings/soc/fsl/
>  F:	drivers/soc/fsl/
> @@ -8745,10 +8741,9 @@ F:	Documentation/devicetree/bindings/sound/fsl,qmc=
-audio.yaml
>  F:	sound/soc/fsl/fsl_qmc_audio.c
>=20=20
>  FREESCALE USB PERIPHERAL DRIVERS
> -M:	Li Yang <leoyang.li@nxp.com>
>  L:	linux-usb@vger.kernel.org
>  L:	linuxppc-dev@lists.ozlabs.org
> -S:	Maintained
> +S:	Orphan
>  F:	drivers/usb/gadget/udc/fsl*
>=20=20
>  FREESCALE USB PHY DRIVER
>
> base-commit: c85af715cac0a951eea97393378e84bb49384734
> --=20
> 2.43.0

