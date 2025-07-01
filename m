Return-Path: <netdev+bounces-202702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9AFAEEB47
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 02:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D503A1BC20A7
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 00:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB59136352;
	Tue,  1 Jul 2025 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5K51t3K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2C25760;
	Tue,  1 Jul 2025 00:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751330194; cv=none; b=Vu2GGAxV6wr9t6GosF8EhZlKMMxRs6bYjdYcABKwrLq+hN/f+JcMjfP5x1WubxeggAR0BKu8k2Kb+mD1Nr1sMouFASLkWUabkhO/9xbW60H75gsTdvKGZCk5SXfZuncBOaIW26MkgJIsZPM6q7KLh1aUN8vud55FWMhuY7JfCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751330194; c=relaxed/simple;
	bh=U29TfWta/+jEYM0KLBYGjTQGmU2hqhx1SBmhAIlL0Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEqP8uWs6hYcWY97l1zfssgE8mZP6ROt3cXfMjwsgpHGy+iCrJcUhb1Tb/EAclLXkXyY37UhhNafdmbhJBXqalX234xqsR5rX4iEC5ydvw9JAYETFm2dk+QIJbpj8uLyw45cqKJEBQSnI6g9WaZdrFCvpjAgfO2l4+1iMMU5S1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5K51t3K; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3305853b3a.2;
        Mon, 30 Jun 2025 17:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751330190; x=1751934990; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fYK0EMxlksXo/Dbg3CdSxsVmRLSPWk16y3vUzHbd8ns=;
        b=Q5K51t3KUHDBiMS2cC5tnAy7cPxxzVN7lOMiqS1T1JAjIKFrUNpVyz9VSR1UcUq9ss
         6/ecEtPJZKW6XMzsWoR2fej39BNTF9xR5Q5ipCRJT1XC9rkyrOqLGs2+ikH0QPnV/nm2
         K5QsT8glw6ninzCisyaXVwOPxQ5c9ui1UpRzVbtDtx9xdRmLMdVljGjm2TjDup8Y0mnI
         8QizOgv8IhZg/AqYA3z/usJJHynCL2cukFcOuFTz1POGQB2vsFTMrTjfBV4q0vsHthb0
         tZoeh735NLd+K0vhfpX/y/R9lmn+TQVlwZqlxNUsPvPAwGYpzgose5zZACM7a6qEXxT0
         XdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751330190; x=1751934990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYK0EMxlksXo/Dbg3CdSxsVmRLSPWk16y3vUzHbd8ns=;
        b=Hy/Y5zR4mM/1az3q1/VliKBTqLqsehc6KwdNbemmLDPJJldLcJjcKffzXgfXgGuFGw
         WKvLDo15ZpdfPVLI5pO4dkRDEBhmUJI7AZaXFXbPD7WZ7GiWLoulqx+3sE1qdeT78oJw
         70x2v4jUCyEJWSITtFK8KcPP5qhRyloEr8bhxC9f9V93ef/aWnqO97GFDhFaEZ6Hk64R
         2XKiMAqkFKGBmQuE84ScxIcxn8v48jKszPRPC34pSFGes6Ik7Tn+lNibC8sy48bmENhD
         CM2XWwtS8uOkTVKq/Dw8BjlPhCkmAYM02e1/h8MYn6TPm2jyMuO7EgZcPYq0iLRDQvlP
         oWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuvB/ynGVNu4CyxH35LS/pfu3RYaRzyiIotD5BdtTSPUfEJZvlFoidLSnBs05BTHyV7I9Y4qyjPo9O@vger.kernel.org, AJvYcCXlFHIH49+UwSGoHC9ySTciH7Js3ic0XRLpIBYE8qOz6Jix1ycCCWmwMko8dujnnvR8lvrIouZo3a3TKyh5@vger.kernel.org
X-Gm-Message-State: AOJu0YzaMlpXLU4CxpwqPtOYGzr7PDjHi4AI9UASfjHXqwYjbgpcYnzq
	AzCDybz6WdR0vgjGr5s1JkcI4/zb3M9CSD4Wbp9n5P1YDaA9aVuNdqqO
X-Gm-Gg: ASbGncsvMxMXvlezq1kHGzn680v3ALsElm8Vn3kBAvzOr6Scx9EaA7KQ/KmKp+ISlzG
	xkdbj5wLyHyIXpGL4uqXHwQONyNo20+MD9bHr0ozFHNAl2fhT7+TWTLcmJpGWPX0iOOBRVwqTB0
	K3tBPqN8aRatebS71bPXZ7v1A4t+Noj0r51v3AawYF5hYHdnjxsRNEkBRmLUrqQu6n4+xqdHBIN
	NAXpL6AJBXXJAGB0P/l9KbiyIyxk3l1GsWWyDg8pVO5/qpMk7VDdUp1SO2Y0Ndch6w6DbB0Gmj4
	cDTld8RE26KBG7/cJy/3wxl1hTY0D5zbu4c4aCva32+8Ve/yasbYU6CE2Jcf5kA0+7hL25TB
X-Google-Smtp-Source: AGHT+IGKImkUMqI2z1gYD78QbviBmg1fxYvY1gFIlaFkYpHjQXCCeDUr0So2MH05sHoga4eLCxoPHg==
X-Received: by 2002:a05:6a00:b42:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-74af70291e3mr20221152b3a.16.1751330190407;
        Mon, 30 Jun 2025 17:36:30 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af541b6e5sm9662133b3a.43.2025.06.30.17.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 17:36:29 -0700 (PDT)
Date: Tue, 1 Jul 2025 08:36:12 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: mdio-mux: Add MDIO mux driver for
 Sophgo CV1800 SoCs
Message-ID: <255j5pbi3pty5n3dmcalq4uhsoj37rsq5263fijn76o3vrkbs5@cctlwa5567om>
References: <20250611080228.1166090-1-inochiama@gmail.com>
 <20250611080228.1166090-3-inochiama@gmail.com>
 <b8e37f3b89209f6674b0419ec28e0302de6b3c4e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8e37f3b89209f6674b0419ec28e0302de6b3c4e.camel@gmail.com>

On Mon, Jun 30, 2025 at 11:08:37PM +0200, Alexander Sverdlin wrote:
> Hi Inochi!
> 
> On Wed, 2025-06-11 at 16:02 +0800, Inochi Amaoto wrote:
> > Add device driver for the mux driver for Sophgo CV18XX/SG200X
> > series SoCs.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/net/mdio/Kconfig            |  10 +++
> >  drivers/net/mdio/Makefile           |   1 +
> >  drivers/net/mdio/mdio-mux-cv1800b.c | 119 ++++++++++++++++++++++++++++
> >  3 files changed, 130 insertions(+)
> >  create mode 100644 drivers/net/mdio/mdio-mux-cv1800b.c
> > 
> > diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
> > index 7db40aaa079d..fe553016b77d 100644
> > --- a/drivers/net/mdio/Kconfig
> > +++ b/drivers/net/mdio/Kconfig
> > @@ -278,5 +278,15 @@ config MDIO_BUS_MUX_MMIOREG
> >  
> >  	  Currently, only 8/16/32 bits registers are supported.
> >  
> > +config MDIO_BUS_MUX_SOPHGO_CV1800B
> > +	tristate "Sophgo CV1800 MDIO multiplexer driver"
> > +	depends on ARCH_SOPHGO || COMPILE_TEST
> > +	depends on OF_MDIO && HAS_IOMEM
> > +	select MDIO_BUS_MUX
> > +	default m if ARCH_SOPHGO
> > +	help
> > +	  This module provides a driver for the MDIO multiplexer/glue of
> > +	  the Sophgo CV1800 series SoC. The multiplexer connects either
> > +	  the external or the internal MDIO bus to the parent bus.
> >  
> >  endif
> > diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
> > index c23778e73890..a67be2abc343 100644
> > --- a/drivers/net/mdio/Makefile
> > +++ b/drivers/net/mdio/Makefile
> > @@ -33,3 +33,4 @@ obj-$(CONFIG_MDIO_BUS_MUX_MESON_G12A)	+= mdio-mux-meson-g12a.o
> >  obj-$(CONFIG_MDIO_BUS_MUX_MESON_GXL)	+= mdio-mux-meson-gxl.o
> >  obj-$(CONFIG_MDIO_BUS_MUX_MMIOREG) 	+= mdio-mux-mmioreg.o
> >  obj-$(CONFIG_MDIO_BUS_MUX_MULTIPLEXER) 	+= mdio-mux-multiplexer.o
> > +obj-$(CONFIG_MDIO_BUS_MUX_SOPHGO_CV1800B) += mdio-mux-cv1800b.o
> > diff --git a/drivers/net/mdio/mdio-mux-cv1800b.c b/drivers/net/mdio/mdio-mux-cv1800b.c
> > new file mode 100644
> > index 000000000000..6c69e83c3dcd
> > --- /dev/null
> > +++ b/drivers/net/mdio/mdio-mux-cv1800b.c
> > @@ -0,0 +1,119 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Sophgo CV1800 MDIO multiplexer driver
> > + *
> > + * Copyright (C) 2025 Inochi Amaoto <inochiama@gmail.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/delay.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/mdio-mux.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define EPHY_PAGE_SELECT		0x07c
> > +#define EPHY_CTRL			0x800
> > +#define EPHY_REG_SELECT			0x804
> > +
> > +#define EPHY_PAGE_SELECT_SRC		GENMASK(12, 8)
> > +
> > +#define EPHY_CTRL_ANALOG_SHUTDOWN	BIT(0)
> > +#define EPHY_CTRL_USE_EXTPHY		BIT(7)
> > +#define EPHY_CTRL_PHYMODE		BIT(8)
> > +#define EPHY_CTRL_PHYMODE_SMI_RMII	1
> > +#define EPHY_CTRL_EXTPHY_ID		GENMASK(15, 11)
> > +
> > +#define EPHY_REG_SELECT_MDIO		0
> > +#define EPHY_REG_SELECT_APB		1
> > +
> > +#define CV1800B_MDIO_INTERNAL_ID	1
> > +#define CV1800B_MDIO_EXTERNAL_ID	0
> > +
> > +struct cv1800b_mdio_mux {
> > +	void __iomem *regs;
> > +	void *mux_handle;
> > +};
> > +
> > +static int cv1800b_enable_mdio(struct cv1800b_mdio_mux *mdmux, bool internal_phy)
> > +{
> > +	u32 val;
> > +
> > +	val = readl(mdmux->regs + EPHY_CTRL);
> > +
> > +	if (internal_phy)
> > +		val &= ~EPHY_CTRL_USE_EXTPHY;
> > +	else
> > +		val |= EPHY_CTRL_USE_EXTPHY;
> > +
> > +	writel(val, mdmux->regs + EPHY_CTRL);
> > +
> > +	writel(EPHY_REG_SELECT_MDIO, mdmux->regs + EPHY_REG_SELECT);
> > +
> > +	return 0;
> > +}
> 
> Seems that it actually doesn't multiplex the buses? As seen on SG2000:
> 

A switch is also a multiplexer.

> # mdio mdio_mux-0.0
>  DEV      PHY-ID  LINK
> 0x00  0x00435649  up
> 0x01  0x00435649  up
> 0x02  0x00000000  down
> ...
> # mdio mdio_mux-0.1
>  DEV      PHY-ID  LINK
> 0x00  0x00435649  up
> 0x01  0x00435649  up
> ...
> 
> The single internal PHY appears on two addresses (0 and 1) and on both buses.

Only address 1 is right, all phy will respond address 0.
And you should not probe bus 1 when using internal bus,
it is not existed.

> Maybe it just switches the external MDIO master on/off?

Yes

> Seems that we need the documentation for this thing ;-)
> 

Please ask for the vendor.

> BTW, above LINK up is unfortunately without any cable attached...

I have repeat the led problem. After setting the right pinctrl,
It is always light and not blink. I guess there may be a internal
bug for it. I will ignore this problem as it is not the driver
issue.

Regards,
Inochi

