Return-Path: <netdev+bounces-229513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF188BDD551
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2AA1893AFD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970302C030E;
	Wed, 15 Oct 2025 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hjz7huSf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941D1F428F
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516120; cv=none; b=vGV8oJLF6lOKlv9yEqtTSH4hqSsZHUtQZIApfl8uEgKkcjFLsTXuEzkabdUfLrFAojOEMeDp7wsKlEXsC/FroOFJlCyvushtX9mSxkPHI0KAkcaW/eazUptBlyK+p7MkoMD30rSuP6/jh9fnErb4q9KPUOi8t9QfPHMq7yodTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516120; c=relaxed/simple;
	bh=Ccw1kBiyRhQSVrMu4J+f5y24aPSH1p1AMOPs0E4nI3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCc3nu8Z6oghMGrPnWxCNig99/DKA2lqqei/Bi8tfynCcBkTVNcJ0o27OQiou5NE/UiPZFERWEW1FwW9KH3C3hE7UFJlG5fOgzjTym0BJgzwNvwas755zOPUECn2jItE4oZjXYbkwUh9fahkyR274nH6UVbUvUsOWsn83SQt/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hjz7huSf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760516116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZKda9N5dijKxgcEWmfEVaFBabk39V5bB1Cg5EO94mA=;
	b=Hjz7huSfSXmQI5+0RGqZTE7TdiBaF08epeHBkdr2YEKPzm6dseyHBPf9wBIoDytcpYqUAc
	Y7i+WURocb7jqILEWV6UZivFRtQwCpXtYb0fHi+DBV3VXv1DiTiMa4Ueq79k0MSFriEi0v
	WC1SHSaN+zlWejBPGKGGxOzuqetl2TM=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-8fXoWa7DNcCwfRvpPIPZNA-1; Wed, 15 Oct 2025 04:15:15 -0400
X-MC-Unique: 8fXoWa7DNcCwfRvpPIPZNA-1
X-Mimecast-MFC-AGG-ID: 8fXoWa7DNcCwfRvpPIPZNA_1760516114
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6430d5f0099so362312eaf.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 01:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760516114; x=1761120914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZKda9N5dijKxgcEWmfEVaFBabk39V5bB1Cg5EO94mA=;
        b=CHPIzbj72IxDi1WJGDBAEPlc+Iv/CMM84GVKEeQRV09OYYCX26gV8z3JY0v7WKbiIX
         dobOJBUFhJAQ/TxtIPby6HyVqEY0THHht0RUm+6ksgPHWiVQkusVoVVUtj2icFI1Y+wr
         y+QbYbjfX1m1p21pQImQpjhq2bY/8gq6Mfr08HyCi4hrxgA4aC8c8OAr+S2/F5DUDv3+
         eC+mJqN4vB9QhWez6vAlLyHPSKhEBlTq49W++l6M3qJZNTwPxKaAw13QqICPY8+5IfHJ
         FrhXAMk67kfnakHfEvDWwJxGgcblSo0Khh1Srb3I5lfbc00zjf1iaEJTzHDjvtF3OXPO
         2B+A==
X-Forwarded-Encrypted: i=1; AJvYcCVgNBLJxc2yB0CqVWQ6+YmUtLHepfB99N5WjbN4UyKyiFB/VfyXlMtVxi2Vu55sjIonvF3PX3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjcuLgW4MBkJ0KddhIa/2WP0tK0jQ8WezST+1L0fXsZ3bofCfp
	xi2Q+1j7Cl5CXRFh8VBQGRYkX7PnrK+6B6tAvHb0uyxXvsvk4hAjfsXzjJ3GMFQfKvuYMkRaeph
	inJzGF3bikM6LxmFX/ATpUynoOWK1wqaDwfImlLxlmhFLoeeri7CMXBzB8AbWhs65en/ha7iNqx
	ZDDH3Y62yoVyOXbgeCJu3AZLIhEIwTfilV
X-Gm-Gg: ASbGncuGzT9TZBspKWlUT2o5goV3fBWeEjigibgee2iDAbT5CHi2Cj3v0w4U5keM2n1
	RDSvhHWR00nOMXyC+tzcgekXb1Wq4rf2itqPEY9xDOYL6C5KCM8QR3Nm9QI8rFsqduohiJaP+Rq
	iFG2AlDh4ESsz3nnKvcg==
X-Received: by 2002:a4a:a5cb:0:b0:650:11d8:238b with SMTP id 006d021491bc7-65011d82737mr3501926eaf.3.1760516114023;
        Wed, 15 Oct 2025 01:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmaU0mA5ZgI30BHsNRVowCM5aNsY26oF2v2JdjYxUuHKGZZFoMEDYsj2ZYBfGCAjm2CUzHY53+s7Zb3V4S4Qk=
X-Received: by 2002:a4a:a5cb:0:b0:650:11d8:238b with SMTP id
 006d021491bc7-65011d82737mr3501913eaf.3.1760516113614; Wed, 15 Oct 2025
 01:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-nxp-s32g-boards-v1-1-f70a57b8087f@oss.nxp.com>
In-Reply-To: <20251006-nxp-s32g-boards-v1-1-f70a57b8087f@oss.nxp.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Wed, 15 Oct 2025 10:12:55 +0200
X-Gm-Features: AS18NWBquLznSadLgXrWHTjQr4NrQxZIv7gXTzpb0atLEJ2_g3uy-0qxXqM2JHs
Message-ID: <CALE0LRusjwiozUPgncUx=iy8O2jbDkm_ktUNXdA3Ludyp02dEg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: freescale: Add GMAC Ethernet for S32G2 EVB
 and RDB2 and S32G3 RDB3
To: jan.petrous@oss.nxp.com
Cc: Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan

Thank you for your patch.


On Mon, Oct 6, 2025 at 6:32=E2=80=AFPM Jan Petrous via B4 Relay
<devnull+jan.petrous.oss.nxp.com@kernel.org> wrote:
>
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>
> Add support for the Ethernet connection over GMAC controller connected to
> the Micrel KSZ9031 Ethernet RGMII PHY located on the boards.
>
> The mentioned GMAC controller is one of two network controllers
> embedded on the NXP Automotive SoCs S32G2 and S32G3.
>
> The supported boards:
>  * EVB:  S32G-VNP-EVB with S32G2 SoC
>  * RDB2: S32G-VNP-RDB2
>  * RDB3: S32G-VNP-RDB3

I got ethernet detected and working with this patch on S32G-VNP-RDB3

[   43.473918] s32-dwmac 4033c000.ethernet end0: PHY [stmmac-0:01]
driver [Micrel KSZ9031 Gigabit PHY] (irq=3DPOLL)
[   43.477547] s32-dwmac 4033c000.ethernet end0: Enabling Safety Features
[   43.489972] s32-dwmac 4033c000.ethernet end0: Invalid PTP clock rate
[   43.496479] s32-dwmac 4033c000.ethernet end0: PTP init failed
[   43.496491] s32-dwmac 4033c000.ethernet end0: configuring for
phy/rgmii-id link mode
[   46.599752] s32-dwmac 4033c000.ethernet end0: Link is Up -
1Gbps/Full - flow control rx/tx

So,

Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>


>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi        | 50 +++++++++++++++++++=
+++++-
>  arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 21 ++++++++++-
>  arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 19 ++++++++++
>  arch/arm64/boot/dts/freescale/s32g3.dtsi        | 50 +++++++++++++++++++=
+++++-
>  arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts | 21 ++++++++++-
>  5 files changed, 157 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/d=
ts/freescale/s32g2.dtsi
> index d167624d1f0c..d06103e9564e 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -3,7 +3,7 @@
>   * NXP S32G2 SoC family
>   *
>   * Copyright (c) 2021 SUSE LLC
> - * Copyright 2017-2021, 2024 NXP
> + * Copyright 2017-2021, 2024-2025 NXP
>   */
>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -738,5 +738,53 @@ gic: interrupt-controller@50800000 {
>                         interrupt-controller;
>                         #interrupt-cells =3D <3>;
>                 };
> +
> +               gmac0: ethernet@4033c000 {
> +                       compatible =3D "nxp,s32g2-dwmac";
> +                       reg =3D <0x4033c000 0x2000>, /* gmac IP */
> +                             <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> +                       interrupt-parent =3D <&gic>;
> +                       interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names =3D "macirq";
> +                       snps,mtl-rx-config =3D <&mtl_rx_setup>;
> +                       snps,mtl-tx-config =3D <&mtl_tx_setup>;
> +                       status =3D "disabled";
> +
> +                       mtl_rx_setup: rx-queues-config {
> +                               snps,rx-queues-to-use =3D <5>;
> +
> +                               queue0 {
> +                               };
> +                               queue1 {
> +                               };
> +                               queue2 {
> +                               };
> +                               queue3 {
> +                               };
> +                               queue4 {
> +                               };
> +                       };
> +
> +                       mtl_tx_setup: tx-queues-config {
> +                               snps,tx-queues-to-use =3D <5>;
> +
> +                               queue0 {
> +                               };
> +                               queue1 {
> +                               };
> +                               queue2 {
> +                               };
> +                               queue3 {
> +                               };
> +                               queue4 {
> +                               };
> +                       };
> +
> +                       gmac0mdio: mdio {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +                               compatible =3D "snps,dwmac-mdio";
> +                       };
> +               };
>         };
>  };
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/=
boot/dts/freescale/s32g274a-evb.dts
> index c4a195dd67bf..f020da03979a 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (c) 2021 SUSE LLC
> - * Copyright 2019-2021, 2024 NXP
> + * Copyright 2019-2021, 2024-2025 NXP
>   */
>
>  /dts-v1/;
> @@ -15,6 +15,7 @@ / {
>
>         aliases {
>                 serial0 =3D &uart0;
> +               ethernet0 =3D &gmac0;
>         };
>
>         chosen {
> @@ -43,3 +44,21 @@ &usdhc0 {
>         no-1-8-v;
>         status =3D "okay";
>  };
> +
> +&gmac0 {
> +       clocks =3D <&clks 24>, <&clks 19>, <&clks 18>, <&clks 15>;
> +       clock-names =3D "stmmaceth", "tx", "rx", "ptp_ref";
> +       phy-mode =3D "rgmii-id";
> +       phy-handle =3D <&rgmiiaphy4>;
> +       status =3D "okay";
> +};
> +
> +&gmac0mdio {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +
> +       /* KSZ 9031 on RGMII */
> +       rgmiiaphy4: ethernet-phy@4 {
> +               reg =3D <4>;
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64=
/boot/dts/freescale/s32g274a-rdb2.dts
> index 4f58be68c818..b9c2f964b3f7 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> @@ -16,6 +16,7 @@ / {
>         aliases {
>                 serial0 =3D &uart0;
>                 serial1 =3D &uart1;
> +               ethernet0 =3D &gmac0;
>         };
>
>         chosen {
> @@ -77,3 +78,21 @@ &usdhc0 {
>         no-1-8-v;
>         status =3D "okay";
>  };
> +
> +&gmac0 {
> +       clocks =3D <&clks 24>, <&clks 19>, <&clks 18>, <&clks 15>;
> +       clock-names =3D "stmmaceth", "tx", "rx", "ptp_ref";
> +       phy-mode =3D "rgmii-id";
> +       phy-handle =3D <&rgmiiaphy1>;
> +       status =3D "okay";
> +};
> +
> +&gmac0mdio {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +
> +       /* KSZ 9031 on RGMII */
> +       rgmiiaphy1: ethernet-phy@1 {
> +               reg =3D <1>;
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/d=
ts/freescale/s32g3.dtsi
> index be3a582ebc1b..e31184847371 100644
> --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>  /*
> - * Copyright 2021-2024 NXP
> + * Copyright 2021-2025 NXP
>   *
>   * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>   *          Ciprian Costea <ciprianmarian.costea@nxp.com>
> @@ -883,6 +883,54 @@ gic: interrupt-controller@50800000 {
>                               <0x50420000 0x2000>;
>                         interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>                 };
> +
> +               gmac0: ethernet@4033c000 {
> +                       compatible =3D "nxp,s32g2-dwmac";
> +                       reg =3D <0x4033c000 0x2000>, /* gmac IP */
> +                             <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> +                       interrupt-parent =3D <&gic>;
> +                       interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names =3D "macirq";
> +                       snps,mtl-rx-config =3D <&mtl_rx_setup>;
> +                       snps,mtl-tx-config =3D <&mtl_tx_setup>;
> +                       status =3D "disabled";
> +
> +                       mtl_rx_setup: rx-queues-config {
> +                               snps,rx-queues-to-use =3D <5>;
> +
> +                               queue0 {
> +                               };
> +                               queue1 {
> +                               };
> +                               queue2 {
> +                               };
> +                               queue3 {
> +                               };
> +                               queue4 {
> +                               };
> +                       };
> +
> +                       mtl_tx_setup: tx-queues-config {
> +                               snps,tx-queues-to-use =3D <5>;
> +
> +                               queue0 {
> +                               };
> +                               queue1 {
> +                               };
> +                               queue2 {
> +                               };
> +                               queue3 {
> +                               };
> +                               queue4 {
> +                               };
> +                       };
> +
> +                       gmac0mdio: mdio {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +                               compatible =3D "snps,dwmac-mdio";
> +                       };
> +               };
>         };
>
>         timer {
> diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64=
/boot/dts/freescale/s32g399a-rdb3.dts
> index e94f70ad82d9..4a74923789ae 100644
> --- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>  /*
> - * Copyright 2021-2024 NXP
> + * Copyright 2021-2025 NXP
>   *
>   * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)
>   */
> @@ -18,6 +18,7 @@ aliases {
>                 mmc0 =3D &usdhc0;
>                 serial0 =3D &uart0;
>                 serial1 =3D &uart1;
> +               ethernet0 =3D &gmac0;
>         };
>
>         chosen {
> @@ -93,3 +94,21 @@ &usdhc0 {
>         disable-wp;
>         status =3D "okay";
>  };
> +
> +&gmac0 {
> +       clocks =3D <&clks 24>, <&clks 19>, <&clks 18>, <&clks 15>;
> +       clock-names =3D "stmmaceth", "tx", "rx", "ptp_ref";
> +       phy-mode =3D "rgmii-id";
> +       phy-handle =3D <&rgmiiaphy1>;
> +       status =3D "okay";
> +};
> +
> +&gmac0mdio {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +
> +       /* KSZ 9031 on RGMII */
> +       rgmiiaphy1: ethernet-phy@1 {
> +               reg =3D <1>;
> +       };
> +};
>
> ---
> base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
> change-id: 20251006-nxp-s32g-boards-2d156255b592
>
> Best regards,
> --
> Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
>
>
>


