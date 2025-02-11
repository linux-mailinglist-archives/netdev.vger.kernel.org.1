Return-Path: <netdev+bounces-165002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AF6A2FFAD
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2E416946E
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7471CAA6E;
	Tue, 11 Feb 2025 00:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGzt43q+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44041C7F;
	Tue, 11 Feb 2025 00:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234833; cv=none; b=dfLvzGZHafDnZzeAjuIF+zYUi9t1dg+mAFqqLrls9sN34XxeDhFk0ghZmxG6V1RLbJayY1zlC8b4EeLuz6JjbMrp+wZZuwKhabKxxJc2egbDnqnerHHwXTt4eHB1sfO0LbwfWR2GjDc4Ql4KcmRTaNWm9MoQsY2cv3HtFjDTU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234833; c=relaxed/simple;
	bh=9VES0IWV7eXdCEVwV5017MoNTx0dvRf0I+xHBK0PfeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOG99UqRFR+7lOcLyO5IU9EbHyrWbWjrStrsAjH70npj4XjUctPxZOUN9sACj45nWJdV1IRSKdJ3R1PNEapurX10BpAnSKBd0B+3/iNDwiWmQ3yTW19kgT4vE5NZW/m/1Vs7f+ySfaP+dj3zJsjX3y+qZdAddyTc6d2oJfECmMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGzt43q+; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471899f228cso16488741cf.3;
        Mon, 10 Feb 2025 16:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739234829; x=1739839629; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jTIEVTb8WG6g/xYwFCZRA14WxKqhOtoX7+ICXbI2OMk=;
        b=kGzt43q+om5i3lEdi/lF4fEnFyF9FgZSb4V7Uh+1VfgLM8xKaf9bUSQwiRPbeE/j68
         UL4LbE2zAur0oeWl0Oipuf4MPJQtH7DBO9B5/XMqmCrTD4T2/eeNTfBvQ2rOQC1JBGIm
         0sdqO8NUJ8vX3zeWZ9FKh27i6dBzijckuSB9d2v3erYhAfP9U+3KYv/ytjTIzmjR3Ny0
         vHQ79JTjCAjJELejFK/JZ6MsvoOGN3i79jNVJU8K2Dx9+IY4gIjMsBbZeg7g70uqKgkL
         iSKAD5g1k6IvBzD0ZVssBd61WonhJKe8E1rHRA6TG5i+Uepr4HlQEvxw2DX17dLl+3hD
         VXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234829; x=1739839629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTIEVTb8WG6g/xYwFCZRA14WxKqhOtoX7+ICXbI2OMk=;
        b=OjJi71MPa5nT1/Xrv2hABQgMQfYqfmyHvKzs7F0zZOaJNwr72B9g6qhfkBGIq39c3/
         9enzNkp4uhh6oLqkMwi2gIfp5NmQIOAezdNi1lT8S2d0N07W+quysKQDslT4+2ORD/vW
         H12v/To3WP4jlmTg4gyPQxih+1uY8+ac+vaIudXW8Uhr7RMmOZrcJ5ltz4nQqM9bOiwk
         G7mq3QH7x7bCeppS+Ui8NnSjm8fYm2NGCpF8lpz0jYxpvv/CzgznKFMtV4WnR13q8qeZ
         2CN8U/xtk4YB+fWj6zbP7CiGn1YPWHblKrcn4lt7xe+8Q0fNXKzpvdSYvlH+xR6udlSl
         L4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCURftNWhgu86FMF20TaRy0JUhdFyzYzLOFIwZ8qyZk01xMhYFLvewu2EsFYZ4hVv6u941mXHXcSpBXd@vger.kernel.org, AJvYcCXR2oKGGyiBfjgMjEEWr6A/9PB1aRtCbkdUW69yGiOixJshUKUIYxoOWrMZgoqLdv0tjHrtcLLpqD1l9K7L@vger.kernel.org
X-Gm-Message-State: AOJu0YynqrVuZ5I9tfX4GfGu5GMRTc16sH32VROABD9zEGw4FRc8Gglt
	dWxL9BLkundLbKR+EkMCkFzml4zwMhKCCFGEBNa5Bofc7v6VtsNh
X-Gm-Gg: ASbGncsutU+Xr9gcJuvyiItSVbavSTaNjkbUkb6ieUsLbN7UShmoJpAoBDKn/CChhQA
	oMXtlxtafXbJKZDbdyy9p4ms9Ku4xZk2ucgoto1VbogKl2gEBcHLvANF8/aKbVA79+bu55SWGnz
	/4SVA7uC5eSSkPSzVM7jiywWkFSYVYAs65R/Tkoj1LWJpp2EGSwHeX39L0St80ONGSb0i4lzZzl
	dupKKRQa4rgihD7v3Y2QbiwqoOVP1tR9rB2LmEVl3A03nc15vXGO7uOwfAnd89MANo=
X-Google-Smtp-Source: AGHT+IHdTWiwpRzbdPuvlFEYzABE9ESxasKSuFHVRX5pGBvoEIPULEvUws7kobHnz0ZNoja0v14wbA==
X-Received: by 2002:a05:6214:dc7:b0:6d4:1e43:f3a5 with SMTP id 6a1803df08f44-6e4455f4e38mr268033066d6.13.1739234829280;
        Mon, 10 Feb 2025 16:47:09 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e459711533sm26289906d6.18.2025.02.10.16.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:47:08 -0800 (PST)
Date: Tue, 11 Feb 2025 08:47:02 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Jisheng Zhang <jszhang@kernel.org>, 
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Simon Horman <horms@kernel.org>, Furong Xu <0x1207@gmail.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Lothar Rubusch <l.rubusch@gmail.com>, 
	Suraj Jaiswal <quic_jsuraj@quicinc.com>, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v4 3/3] net: stmmac: Add glue layer for Sophgo
 SG2044 SoC
Message-ID: <uhup3bm6ez6kg7efvimy6rcthmqfcdkg2vmcwafqz33vouplfl@i25wn6q6c4h6>
References: <20250209013054.816580-1-inochiama@gmail.com>
 <20250209013054.816580-4-inochiama@gmail.com>
 <2379380.ElGaqSPkdT@fw-rgant>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2379380.ElGaqSPkdT@fw-rgant>

On Mon, Feb 10, 2025 at 12:01:56PM +0100, Romain Gantois wrote:
> Hello Inochi,
> 
> On dimanche 9 février 2025 02:30:52 heure normale d’Europe centrale Inochi 
> Amaoto wrote:
> > Adds Sophgo dwmac driver support on the Sophgo SG2044 SoC.
> ...
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> > @@ -0,0 +1,105 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Sophgo DWMAC platform driver
> > + *
> > + * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
> > + */
> > +
> > +#include <linux/bits.h>
> 
> It doesn't look like this include is used, could you please remove it?
> 

Thanks, I will. And I will add the miss header 
linux/clk.h and linux/module.h.

> > +#include <linux/mod_devicetable.h>
> > +#include <linux/phy.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "stmmac_platform.h"
> > +
> > +struct sophgo_dwmac {
> > +	struct device *dev;
> > +	struct clk *clk_tx;
> > +};
> > +
> > +static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed,
> > unsigned int mode) +{
> > +	struct sophgo_dwmac *dwmac = priv;
> > +	long rate;
> > +	int ret;
> > +
> > +	rate = rgmii_clock(speed);
> > +	if (rate < 0) {
> > +		dev_err(dwmac->dev, "invalid speed %u\n", speed);
> > +		return;
> > +	}
> > +
> > +	ret = clk_set_rate(dwmac->clk_tx, rate);
> > +	if (ret)
> > +		dev_err(dwmac->dev, "failed to set tx rate %lu: %pe\n",
> 
> nit: shouldn't this be "%ld"?
> 

Yeah, it is my mistake, I will fix it.

> > +			rate, ERR_PTR(ret));
> > +}
> > +
> > +static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
> > +				    struct plat_stmmacenet_data *plat_dat,
> > +				    struct stmmac_resources *stmmac_res)
> > +{
> > +	struct sophgo_dwmac *dwmac;
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
> > +
> > +static int sophgo_dwmac_probe(struct platform_device *pdev)
> > +{
> > +	struct plat_stmmacenet_data *plat_dat;
> > +	struct stmmac_resources stmmac_res;
> 
> nit: I think adding "struct device *dev = &pdev->dev;" here would
> be better than repeating "&pdev->dev" later on.
> 

Thanks, I will change that.

> > +	int ret;
> > +
> > +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed to get resources\n");
> 
> This error message is a bit too vague, maybe replace it with "failed to get 
> platform resources"?
> 

OK.

> > +
> > +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> > +	if (IS_ERR(plat_dat))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
> > +				     "dt configuration failed\n");
> 
> This error message is a bit misleading IMO, I would replace it with
> something like "failed to parse device-tree parameters".
> 

OK.

> > +
> > +	ret = sophgo_sg2044_dwmac_init(pdev, plat_dat, &stmmac_res);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> > +}
> > +
> > +static const struct of_device_id sophgo_dwmac_match[] = {
> > +	{ .compatible = "sophgo,sg2044-dwmac" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, sophgo_dwmac_match);
> > +
> > +static struct platform_driver sophgo_dwmac_driver = {
> > +	.probe  = sophgo_dwmac_probe,
> > +	.remove = stmmac_pltfr_remove,
> > +	.driver = {
> > +		.name = "sophgo-dwmac",
> > +		.pm = &stmmac_pltfr_pm_ops,
> > +		.of_match_table = sophgo_dwmac_match,
> > +	},
> > +};
> > +module_platform_driver(sophgo_dwmac_driver);
> > +
> > +MODULE_AUTHOR("Inochi Amaoto <inochiama@gmail.com>");
> > +MODULE_DESCRIPTION("Sophgo DWMAC platform driver");
> > +MODULE_LICENSE("GPL");
> 
> Thanks,
> 
> -- 
> Romain Gantois, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



