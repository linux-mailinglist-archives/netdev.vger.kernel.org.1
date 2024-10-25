Return-Path: <netdev+bounces-139253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42DF9B132C
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 01:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699B428367C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 23:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20EC21312B;
	Fri, 25 Oct 2024 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGkxptTR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEC217F5A;
	Fri, 25 Oct 2024 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729898898; cv=none; b=rIzCRAiCyyAYik4GnZiaCOKKv/3Pk5E+idbgS8/WjcqCG7pFhDEVoGPLkv+lbxKlF4Bdh054bwjs9dVNhOLzEHy32YoSGCXxjSqfacxzzwLkKKf5nDH/AIHvXI6O/5DwofmYc2+80IwaKdWmEVgDP1K+hbi0myVCZI/CkwwkjPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729898898; c=relaxed/simple;
	bh=jQ4mjlOg4DeTsZFdz74RrRfb3zbdpYLDxB741vOeOig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn47ddUJv5XroLU69paCbtAkuQPkMF+x61LdLciSbGyZ1H8/ix0pHVoOspmfhM2m8WkyXsazuyFqm/IRUoL4fzhUK3+7BUE1RdhPF5+PoGRe2NBp8fjUTGe/geaSnB4ZiWsrbIWtIeq4CaR/p573Xyp9Ad2+9HtXsG7kxqXP9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGkxptTR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20caea61132so20051625ad.2;
        Fri, 25 Oct 2024 16:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729898896; x=1730503696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+LonYrIZEHor693r4mdE7TdXh7oFFBiZD+b7YxVtbo=;
        b=ZGkxptTRJbPeh1TQxxRpHscY3LaW+op4p7MRB6wE4oT5TJzcMG4PMXV28SPxWnzXRT
         nOi2oYuY7EzgcBmuh64bjFOAZ/j+ljVzFGt3EWCFXyiGitNulrHrNAEDS0yZrz4IFW19
         mFzqghAK5airxRgmOqlJOuVojKPZJF0GGUtKy7DFt3nZZgtwqGnoUYcVroMHRx+vQuZ8
         Yrp/QqOpjAPhz490YnkkT5PvmEemKlvSs/bnf04R3CABslj164KJrnas/G3/LHNNbFyW
         vImvdmDvRo1hJSLQ+YFF9Vq98ZNNrZYdkr8yJU+2XAm891fABDJOTpIjf2zUeF2n6wWz
         1SyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729898896; x=1730503696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+LonYrIZEHor693r4mdE7TdXh7oFFBiZD+b7YxVtbo=;
        b=d9QMoNZVD7EHoVGfSfeLPczz+xKhufiGxS5S8gIpsRWuRlVIE2ZqQr7aSkEzO27YoA
         WBcn2ECkaMFYBEfrYJgwnZMZQtOosKvSisqqG46SY9LeXGewV3o6ZLWJapqTF/d7iyR0
         bDs/0VsCPVjW48/t2eGR6pI4EHitdGHwj3Mh+itm6qW7zrYytvnQmL/4viIJmB1TmOR/
         xzJPoawioID+Ddaj5Tqp/4u1v50Is0mKESwMrkFWluK2J4GeONH1V96cVi9JT62kbBEk
         bg8LunGDMPirCL1F6tHMSsG/ApSwokONtjLVyutlQizd5/7ym9jobuNcFsNSRnOEe0Ja
         6rBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEpGLSgjcRWLUkdqJePaAcJ4JS8AmFYY1+d8tE8qE7cGRUFQmNAl2u8bZFbhrjs3nJp82BNnPp@vger.kernel.org, AJvYcCWUBRAKXFDoZLR7CEaMYOoLNvBcbRVknWVBumrWRx6TmgVjyh15YGfcqAtytOzbxVZpIx9ZYPHJkt8g@vger.kernel.org, AJvYcCWf0auEH5YDmYKvNfr/7eLPytKVTTjtZJ0hEAdrDcUNHK2okrtRsz1KdysvXx5c8Sn3zm/xES+vxkoWpYuH@vger.kernel.org
X-Gm-Message-State: AOJu0YxY7+G4QEbsKp6924kFrqVt6h2K0A4AjWb3Vl2XypjQtFOP9Nsw
	AqC3WVPzitIEKlTXMxtj8x8G/4lfFEbvu6H54fYC/Z7rVBwTnXyl
X-Google-Smtp-Source: AGHT+IHamz0WczDVCsPc6CPqKdEhjI+8PIhVIRTWBbvo/nv2cWi0cJElpgaxLC3cRQCvUjNkV4uDYQ==
X-Received: by 2002:a17:903:2450:b0:20c:a692:cf1e with SMTP id d9443c01a7336-210c6c6ce1bmr13188725ad.43.1729898895779;
        Fri, 25 Oct 2024 16:28:15 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d6e7sm14383325ad.71.2024.10.25.16.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 16:28:15 -0700 (PDT)
Date: Sat, 26 Oct 2024 07:27:54 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Message-ID: <22g3v2h52xjhhwxdgnte6mhhadjfds2vlxlwz7b7t2fa7jlty2@lwyumoromg3c>
References: <20241025011000.244350-1-inochiama@gmail.com>
 <20241025011000.244350-5-inochiama@gmail.com>
 <e00a0277-c298-47ba-9fdd-8f740f7490cc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e00a0277-c298-47ba-9fdd-8f740f7490cc@intel.com>

On Fri, Oct 25, 2024 at 04:53:07PM +0200, Alexander Lobakin wrote:
> From: Inochi Amaoto <inochiama@gmail.com>
> Date: Fri, 25 Oct 2024 09:10:00 +0800
> 
> > Adds Sophgo dwmac driver support on the Sophgo SG2044 SoC.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
> >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> >  .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 109 ++++++++++++++++++
> >  3 files changed, 121 insertions(+)
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> 
> [...]
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> > new file mode 100644
> > index 000000000000..8f37bcf86a73
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> > @@ -0,0 +1,109 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Sophgo DWMAC platform driver
> > + *
> > + * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
> > + *
> 
> This empty line is redundant I guess?
> 
> > + */
> > +
> > +#include <linux/bits.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/phy.h>
> > +#include <linux/regmap.h>
> 
> Here should be alphabetical order.
> 

Thanks, I forgot to reorder it when adding new include.

> > +
> > +#include "stmmac_platform.h"
> > +
> > +struct sophgo_dwmac {
> > +	struct device *dev;
> > +	struct clk *clk_tx;
> > +};
> > +
> > +static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
> > +{
> > +	struct sophgo_dwmac *dwmac = priv;
> > +	long rate;
> > +	int ret;
> > +
> > +	rate = rgmii_clock(speed);
> > +	if (ret < 0) {
> 
> Did you mean `if (rate < 0)`?
> 

Yeah, it seems I forgot to modify it.

> > +		dev_err(dwmac->dev, "invalid speed %u\n", speed);
> > +		return;
> > +	}
> > +
> > +	ret = clk_set_rate(dwmac->clk_tx, rate);
> > +	if (ret)
> > +		dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
> 
> Don't you want to print the error code here?
> 
> 		"failed to set tx rate %lu: %pe\n", rate, ERR_PTR(ret));
> 

Thanks, it is more clear now.

> > +}
> > +
> > +static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
> > +				    struct plat_stmmacenet_data *plat_dat,
> > +				    struct stmmac_resources *stmmac_res)
> > +{
> > +	struct sophgo_dwmac *dwmac;
> > +	int ret;
> 
> Unused var.
> 
> > +
> > +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> > +	if (!dwmac)
> > +		return -ENOMEM;
> > +
> > +	dwmac->clk_tx = devm_clk_get_enabled(&pdev->dev, "tx");
> > +	if (IS_ERR(dwmac->clk_tx))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->clk_tx),
> > +				     "failed to get tx clock\n");
> > +
> > +	dwmac->dev = &pdev->dev;
> > +	plat_dat->bsp_priv = dwmac;
> > +	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE;
> > +	plat_dat->fix_mac_speed = sophgo_dwmac_fix_mac_speed;
> > +	plat_dat->multicast_filter_bins = 0;
> > +	plat_dat->unicast_filter_entries = 1;
> > +
> > +	return 0;
> > +}
> 
> [...]
> 
> + see the build bot report.
> 
> Thanks,
> Olek


Thanks, I will fix it.

Regards,
Inochi

