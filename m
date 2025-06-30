Return-Path: <netdev+bounces-202678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A349AEE95C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D05171B4B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF18E28A73C;
	Mon, 30 Jun 2025 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEMKA4m7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA721B9F5;
	Mon, 30 Jun 2025 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317718; cv=none; b=hwl6zyIgOWJ3iyy5GO2feg5tOHPzItXlU3orQXosfFfTcqzcNRzzvPVGK8GVDClPcyOFIeIaAjHRiz21/4qHKhQFvdLkte18FkW1jUCO4nwK9v/RYkpnQlOMQzZAWIj/O/o/47RbNVz92PII7sczoh0Gt2fq1YZATNuUL8WEfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317718; c=relaxed/simple;
	bh=OUl/v3cYQErZetR+gHR3HfERW6jdMX2f9V629iiowzk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O/fvJccIuRGbNE4bfetHbK4PgHVFBHTEZn88TYh1d+qetBzgnyYX2EX/O4XZ3yW6wELNq2u/77f/QaqIREwfWkQAG4m08Ze+c0J0Gs5Sn9kxJauzGwIzUFtLZNtKR8w80aF+r8O21Cv3hbbXd7UJjmHMifCMeDGjqGMgOq/5yDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEMKA4m7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso8976191a12.0;
        Mon, 30 Jun 2025 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751317715; x=1751922515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DfEAu4Z4aidz8WUdebCSoWtL+Ka/H89FRK6NQIVtr3U=;
        b=kEMKA4m7RCyUxBxICcvvQl5tjY/AxIXAKqHi5D2qLF+UljUeB8k16nhIkgyXDxvY7W
         kb0XvrRXJTvBiq4zWztgmGyHMZEG3CmC1Jg36+/1Qm9+jl7ZxY8waHvuCIzgZPgF45mF
         nR22QTBmNPdqIo9+WrLj9oH5kepW1Ru5Gnh4nw86LBzdug1z27l19H8GaroYaFTXPQ5G
         swM5wa4THLA6rSJDahupB1RWMGZkrU4E5JSswHUrxct0BxyuwOYNqzW6+2nmJ+SRYO4g
         HHxdntiB4J4aALaNkSyFLEK91kYtojV/7tjblv3fT8vxfK0nDe2r/ZqsbXPnui5akfyh
         L1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751317715; x=1751922515;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfEAu4Z4aidz8WUdebCSoWtL+Ka/H89FRK6NQIVtr3U=;
        b=cD6qAU5sJU1lt6lqkXvaRkzoF46ynyrJZmW7Bjkz/OhnbB8uPKEY3Kk8fQboqIPbgW
         oyXaNBPxg+8z5Lt7qORVY7s4tISxfU0rebCXDAYxaD4ENFa1jKmtQP4SnIpKSAuwoGRY
         C2+2/kVnzWz0MaRH5mXqj90sCiLVWGyKlpIgyBWQvvssAWlpaz8y/aJ4qTZywi/j7N6A
         48wMyZovbsr0VXfIA0os+fhgbHCew79BU0SEGxNqnx+wb8wa89NssbyxD3B+JaDP7psr
         ST2MAIbmwUX1z55dWBXi/tY5ihQldMerIEcQ8WYbrTLEOwoSpluRdloqycpdX5v57OeJ
         nRww==
X-Forwarded-Encrypted: i=1; AJvYcCUJzubGYTzKAkaJRtzMxqY//vqYQQ0yZNgOQ/+Ccgr80ej+QtYBTaTwozxtJlo5Dvhs8DGmihkNRWwC8uZM@vger.kernel.org, AJvYcCVdjqzbVnnNoOndDrCCiSBiA2tS6LH43GRvsfB3QN5Kt6pyrKf7XUQEdzHEutzvnt+fW+lkNXRJlOdd@vger.kernel.org
X-Gm-Message-State: AOJu0YzdIwhoAhWC6nGxEFRTaIE/nSbv18fEVNfvGWrEv07lE7/tIJ0o
	J5zI26B8mEf0s6e86RBXWttMnQJ3rIxonzk1ETljbR/Ovzj2iGk90LWc
X-Gm-Gg: ASbGnctGCFqbA/lfEmb7zde1yBwt73WOLku3Qljvqgasxp+cW58f7NAip3poi70Fp6s
	7UAqaJa6V5H2t7OynSwXipCsZcQRuHYKxhPB0KkfCOo0k6mEvGRyBUzk/F2xv5Bg2pTynp5ZH1a
	i4rDZe2LbWpPcAhePbGPq606MibSe6JQHLLoFv4CTtCk+kHVGAFe680HelDl5hubTph+Wm0D8xV
	9T/TGhJyynZYHh5ySKtdwB7TVtskxxGo9wt0Fh/w8ItWlqOkWwIUJ0orxA9YoqeYx8OocbUDKOw
	IYjh244bMI0lqMnUY3CsI7UrciCRGBCk8Tozls6L5bDGiuXZYTP2KC3k5S57Ad8F8eM61IjgH/m
	uw2/9DQ==
X-Google-Smtp-Source: AGHT+IFiNDi56K5x37KH9GR/A8jMN8Z9TvqTUcjmru8/4qInJ8CfMFwW3ZXy8hbURvxLCUDm+/aZcw==
X-Received: by 2002:a05:6402:3586:b0:608:66a3:fec with SMTP id 4fb4d7f45d1cf-60c88b3453bmr13656712a12.2.1751317714969;
        Mon, 30 Jun 2025 14:08:34 -0700 (PDT)
Received: from giga-mm-8.home ([2a02:1210:8608:9200:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c831ccc90sm6200391a12.56.2025.06.30.14.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:08:34 -0700 (PDT)
Message-ID: <b8e37f3b89209f6674b0419ec28e0302de6b3c4e.camel@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: mdio-mux: Add MDIO mux driver for
 Sophgo CV1800 SoCs
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, 	linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Yixun Lan	 <dlan@gentoo.org>, Longbin Li
 <looong.bin@gmail.com>
Date: Mon, 30 Jun 2025 23:08:37 +0200
In-Reply-To: <20250611080228.1166090-3-inochiama@gmail.com>
References: <20250611080228.1166090-1-inochiama@gmail.com>
	 <20250611080228.1166090-3-inochiama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Inochi!

On Wed, 2025-06-11 at 16:02 +0800, Inochi Amaoto wrote:
> Add device driver for the mux driver for Sophgo CV18XX/SG200X
> series SoCs.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
> =C2=A0drivers/net/mdio/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +++
> =C2=A0drivers/net/mdio/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/net/mdio/mdio-mux-cv1800b.c | 119 +++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 130 insertions(+)
> =C2=A0create mode 100644 drivers/net/mdio/mdio-mux-cv1800b.c
>=20
> diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
> index 7db40aaa079d..fe553016b77d 100644
> --- a/drivers/net/mdio/Kconfig
> +++ b/drivers/net/mdio/Kconfig
> @@ -278,5 +278,15 @@ config MDIO_BUS_MUX_MMIOREG
> =C2=A0
> =C2=A0	=C2=A0 Currently, only 8/16/32 bits registers are supported.
> =C2=A0
> +config MDIO_BUS_MUX_SOPHGO_CV1800B
> +	tristate "Sophgo CV1800 MDIO multiplexer driver"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	depends on OF_MDIO && HAS_IOMEM
> +	select MDIO_BUS_MUX
> +	default m if ARCH_SOPHGO
> +	help
> +	=C2=A0 This module provides a driver for the MDIO multiplexer/glue of
> +	=C2=A0 the Sophgo CV1800 series SoC. The multiplexer connects either
> +	=C2=A0 the external or the internal MDIO bus to the parent bus.
> =C2=A0
> =C2=A0endif
> diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
> index c23778e73890..a67be2abc343 100644
> --- a/drivers/net/mdio/Makefile
> +++ b/drivers/net/mdio/Makefile
> @@ -33,3 +33,4 @@ obj-$(CONFIG_MDIO_BUS_MUX_MESON_G12A)	+=3D mdio-mux-mes=
on-g12a.o
> =C2=A0obj-$(CONFIG_MDIO_BUS_MUX_MESON_GXL)	+=3D mdio-mux-meson-gxl.o
> =C2=A0obj-$(CONFIG_MDIO_BUS_MUX_MMIOREG)=C2=A0	+=3D mdio-mux-mmioreg.o
> =C2=A0obj-$(CONFIG_MDIO_BUS_MUX_MULTIPLEXER)=C2=A0	+=3D mdio-mux-multiple=
xer.o
> +obj-$(CONFIG_MDIO_BUS_MUX_SOPHGO_CV1800B) +=3D mdio-mux-cv1800b.o
> diff --git a/drivers/net/mdio/mdio-mux-cv1800b.c b/drivers/net/mdio/mdio-=
mux-cv1800b.c
> new file mode 100644
> index 000000000000..6c69e83c3dcd
> --- /dev/null
> +++ b/drivers/net/mdio/mdio-mux-cv1800b.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sophgo CV1800 MDIO multiplexer driver
> + *
> + * Copyright (C) 2025 Inochi Amaoto <inochiama@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/mdio-mux.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define EPHY_PAGE_SELECT		0x07c
> +#define EPHY_CTRL			0x800
> +#define EPHY_REG_SELECT			0x804
> +
> +#define EPHY_PAGE_SELECT_SRC		GENMASK(12, 8)
> +
> +#define EPHY_CTRL_ANALOG_SHUTDOWN	BIT(0)
> +#define EPHY_CTRL_USE_EXTPHY		BIT(7)
> +#define EPHY_CTRL_PHYMODE		BIT(8)
> +#define EPHY_CTRL_PHYMODE_SMI_RMII	1
> +#define EPHY_CTRL_EXTPHY_ID		GENMASK(15, 11)
> +
> +#define EPHY_REG_SELECT_MDIO		0
> +#define EPHY_REG_SELECT_APB		1
> +
> +#define CV1800B_MDIO_INTERNAL_ID	1
> +#define CV1800B_MDIO_EXTERNAL_ID	0
> +
> +struct cv1800b_mdio_mux {
> +	void __iomem *regs;
> +	void *mux_handle;
> +};
> +
> +static int cv1800b_enable_mdio(struct cv1800b_mdio_mux *mdmux, bool inte=
rnal_phy)
> +{
> +	u32 val;
> +
> +	val =3D readl(mdmux->regs + EPHY_CTRL);
> +
> +	if (internal_phy)
> +		val &=3D ~EPHY_CTRL_USE_EXTPHY;
> +	else
> +		val |=3D EPHY_CTRL_USE_EXTPHY;
> +
> +	writel(val, mdmux->regs + EPHY_CTRL);
> +
> +	writel(EPHY_REG_SELECT_MDIO, mdmux->regs + EPHY_REG_SELECT);
> +
> +	return 0;
> +}

Seems that it actually doesn't multiplex the buses? As seen on SG2000:

# mdio mdio_mux-0.0
 DEV      PHY-ID  LINK
0x00  0x00435649  up
0x01  0x00435649  up
0x02  0x00000000  down
...
# mdio mdio_mux-0.1
 DEV      PHY-ID  LINK
0x00  0x00435649  up
0x01  0x00435649  up
...

The single internal PHY appears on two addresses (0 and 1) and on both buse=
s.
Maybe it just switches the external MDIO master on/off?
Seems that we need the documentation for this thing ;-)

BTW, above LINK up is unfortunately without any cable attached...

--=20
Alexander Sverdlin.

