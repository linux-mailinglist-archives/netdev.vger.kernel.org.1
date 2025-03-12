Return-Path: <netdev+bounces-174059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE0CA5D3CB
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 02:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC2E3B7C8F
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 01:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9780034;
	Wed, 12 Mar 2025 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgJfRlpb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ABE8489;
	Wed, 12 Mar 2025 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741741326; cv=none; b=H6vCNnd9MUMs509NUvwLRDf4+sPaxQgVSFor94zi9SwMlZN/esRyoHSbeTR3PWNhyoWIdmeJryFUx6HMi94yjmJhEAgbzWbtOwpeRG1iXmSDkM6myEFCdf/ArslBZe/eGvcdpSZ8p8B9HCra4OUzJXpz361+rgYvNF4m1AVo9LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741741326; c=relaxed/simple;
	bh=eb++Q5Jt+b0eT0gGz4oPDiZgy4tcJOes/kQeNeoV1Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfuOSPMdiBLOFi4C7VcsfDB9VVCFVURSLl35TiBuGX8M9o7bLJfMXRcQwdHJ3c9Da1wRaU/+Gk7E+O7JklHj3Xd16ugFEsfcFpmSGsiyhGcdCtFSyRg+JaRTmN/QTvqraj0stwu9tKTwt6qSnKUgca1BU5Pl0WayEHHeUMwPz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgJfRlpb; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476805acddaso31266871cf.1;
        Tue, 11 Mar 2025 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741741323; x=1742346123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFfHYKK4frHiUF1ZzwqraamwfZW4LWO3zsXjdACXB+s=;
        b=RgJfRlpbx+m65bAcal+5MgahMLCyHvUxbMu6dFp+XS5/j6DONv7d8EcH/P6c9oMmOJ
         qb4lKsonsZpxRr2WfJK2oFk3io6npaSbKFL4kbWKGa4Q91wUlENRuATNUx2wQ6Acm8EC
         PoPd1y+5OAHhFmI7e1crJJ+eHfTFxMX98dvvgdiTYQIg4EpPqrDzrbvvR0A78e0YNVND
         ptJwOu0RA5I66xnXHI1fd4QyVubGo1RHjyH+UqeA7T2sbTvtDR3ei9Nqf0TRAOzlI1pC
         TFWU1VsdDCyZAczZKiVTgOx/EKl8IfVoP+E+sWnhTXF6ID5sCeHFMb5zEL03Q5FHnYSq
         uqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741741323; x=1742346123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFfHYKK4frHiUF1ZzwqraamwfZW4LWO3zsXjdACXB+s=;
        b=I8TKH/F2OxmrcGjBlm5KvOxzEsCSfiHQLSuHe41yik9osdNcQIU2tlq/ayF/k3o9F4
         0W96dvCTWOv2LDhLatPKtsQ0UMG1olmN46E30OZpzF6cZbY4w6jxUzrAUS2+40ngDwTu
         H5GnWU8Yb90v0M/wN7enUmpBLOADlnekbt145QLZliEiGCVEeAPlCVpXR9NNB2nm6dJD
         tSh55VE1Hilc3uudAy8Oucg68HBI90E7uqVSemL2M+vUE73jSnVbBJsOttaF6j1xGI8a
         vPMs4HI+fYUCiFqO+A1nVEiewQZA8aZN0KFvm/93Z2XPQ+CsxM5Z8GCn1QvECalpILEH
         C8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUB9W44tQS0r5eXUtOBeFPa8zt0EdCsKV3ITE8QkOzRvRft7i+81R3LIxL8DCS+q8P356fLbW+/qCr1BgEH@vger.kernel.org, AJvYcCUcdjxYXlge/P+nWr1geB/loARDP7C4rZex4VXu5baXewdFkMgChab928Nvpg5nrC6AEaf0OamA@vger.kernel.org, AJvYcCWaL/P1MQr6Hrduu9Dh28yRedPeWZ0PTMZpacu5bdzSF+XnEU4sdjUjl22uxESgPqL30ttk1MFkkqhJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzjXOVc2qXOzO4EJxOKtYz0rmBhgkuAFL4sHdRwQXndRptmDAvs
	/3s3pcmnWoMhby/b+Y3KQhYbx1sCkjL3VT8kPuI5PcnXPrmF19Hx
X-Gm-Gg: ASbGncsZwB/ovaXnnM08FfARBvIBJJYRpUv9s8/Uu7tMEfBqxCL+aIFMifc4KtFuS+Q
	lwMheoAQg5b3UhN5c/9KfI9K+9RJdKhOxO8o9AEV/odq7lGm6A1eRZKtdsV4yQAFQTkcIvawQGR
	iovnzgv1Po8vnn3vne3B7GRyLTw9IDAseieUj/JiIlP/DCF8G5X3oHomhsQu+lfRGK4xl81tuhv
	bWv0tbALQlnxL/GViKoEX/pNOvt2NX7CHWmo03Ko6ZVD7c7BOVQ+lM7sEAMTmw52LvMcUKoQq/X
	gyxU4PIqoVZJshXuVgYH
X-Google-Smtp-Source: AGHT+IHlCUmVJJVqYKAw7Z0b7HklLTnuNSheRG/jnY/Tt83KaOqWVDYITSq5PUFIPY8i76+P4jskSQ==
X-Received: by 2002:a05:622a:438b:b0:476:afd2:5b5d with SMTP id d75a77b69052e-476afd2993bmr3009071cf.4.1741741322959;
        Tue, 11 Mar 2025 18:02:02 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47685e04db5sm37613271cf.64.2025.03.11.18.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 18:02:02 -0700 (PDT)
Date: Wed, 12 Mar 2025 09:01:54 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 2/2] clk: sophgo: Add clock controller support for
 SG2044 SoC
Message-ID: <ih7hu6nyn3n4bntwljzo4suby5klxxj4vs76e57qmw65vujctw@khgo3qbgllio>
References: <20250226232320.93791-1-inochiama@gmail.com>
 <20250226232320.93791-3-inochiama@gmail.com>
 <aab786e8c168a6cb22886e28c5805e7d.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab786e8c168a6cb22886e28c5805e7d.sboyd@kernel.org>

On Tue, Mar 11, 2025 at 12:23:35PM -0700, Stephen Boyd wrote:
> Quoting Inochi Amaoto (2025-02-26 15:23:19)
> > diff --git a/drivers/clk/sophgo/clk-sg2044.c b/drivers/clk/sophgo/clk-sg2044.c
> > new file mode 100644
> > index 000000000000..b4c15746de77
> > --- /dev/null
> > +++ b/drivers/clk/sophgo/clk-sg2044.c
> 
> Thanks for sticking with it. Some minor nits below but otherwise this
> looks good to go.
> 
> > @@ -0,0 +1,2271 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Sophgo SG2042 clock controller Driver
> > + *
> > + * Copyright (C) 2025 Inochi Amaoto <inochiama@gmail.com>
> > + */
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/math64.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "clk-sg2044.h"
> > +
> > +#include <dt-bindings/clock/sophgo,sg2044-clk.h>
> > +
> [...]
> > +
> > +static unsigned long sg2044_pll_recalc_rate(struct clk_hw *hw,
> > +                                           unsigned long parent_rate)
> > +{
> > +       struct sg2044_pll *pll = hw_to_sg2044_pll(hw);
> > +       u32 value;
> > +       int ret;
> > +
> > +       ret = regmap_read(pll->top_syscon,
> > +                         pll->syscon_offset + pll->pll.ctrl_offset + PLL_HIGH_CTRL_OFFSET,
> > +                         &value);
> > +       if (ret < 0)
> > +               return 0;
> > +
> > +       return sg2044_pll_calc_rate(parent_rate,
> > +                                   FIELD_GET(PLL_REFDIV_MASK, value),
> > +                                   FIELD_GET(PLL_FBDIV_MASK, value),
> > +                                   FIELD_GET(PLL_POSTDIV1_MASK, value),
> > +                                   FIELD_GET(PLL_POSTDIV2_MASK, value));
> > +}
> > +
> > +static bool pll_is_better_rate(unsigned long target, unsigned long now,
> > +                              unsigned long best)
> > +{
> > +       return (target - now) < (target - best);
> 
> Is this more like abs_diff(target, now) < abs_diff(target, best)?
> 

Yeah, using abs is more better.

> > +}
> > +
> > +
> > +static int sg2044_pll_enable(struct sg2044_pll *pll, bool en)
> > +{
> > +       if (en) {
> > +               if (sg2044_pll_poll_update(pll) < 0)
> > +                       pr_warn("%s: fail to lock pll\n", clk_hw_get_name(&pll->common.hw));
> > +
> > +               return regmap_set_bits(pll->top_syscon,
> > +                                      pll->syscon_offset + pll->pll.enable_offset,
> > +                                      BIT(pll->pll.enable_bit));
> > +       } else {
> 
> Drop the else please.
> 
> > +               return regmap_clear_bits(pll->top_syscon,
> > +                                        pll->syscon_offset + pll->pll.enable_offset,
> > +                                        BIT(pll->pll.enable_bit));
> > +       }
> > +}
> > +
> [...]
> > +
> > +static u32 sg2044_div_get_reg_div(u32 reg, struct sg2044_div_internal *div)
> > +{
> > +       if ((reg & DIV_FACTOR_REG_SOURCE))
> > +               return (reg >> div->shift) & clk_div_mask(div->width);
> > +       else
> 
> Drop the else please.
> 
> > +               return div->initval == 0 ? 1 : div->initval;
> > +}
> > +
> > +
> > +
> [...]
> > +
> > +static const struct clk_parent_data clk_fpll0_parent[] = {
> > +       { .hw = &clk_fpll0.common.hw },
> > +};
> 
> If the only parent is a clk_hw pointer it's preferred to use struct
> clk_init_data::parent_hws directly instead of clk_parent_data.
> 

This is OK for me, I will change all to parent_hws.

> > +
> > +static const struct clk_parent_data clk_fpll1_parent[] = {
> > +       { .hw = &clk_fpll1.common.hw },
> > +};
> > +
> [...]
> > +                        CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
> > +                        80);
> > +
> > +static DEFINE_SG2044_DIV(CLK_DIV_PKA, clk_div_pka,
> > +                        clk_fpll0_parent, 0,
> > +                        0x0f0, 16, 8,
> > +                        CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
> > +                        2);
> > +
> > +static const struct clk_parent_data clk_mux_ddr0_parents[] = {
> > +       { .hw = &clk_div_ddr0_fixed.common.hw },
> > +       { .hw = &clk_div_ddr0_main.common.hw },
> 
> Similarly, if the only parents are clk_hw pointers we should be using
> struct clk_init_data::parent_hws.
> 
> > +};
> > +
> > +static DEFINE_SG2044_MUX(CLK_MUX_DDR0, clk_mux_ddr0,
> > +
> > +static struct sg2044_clk_common *sg2044_pll_commons[] = {
> > +       &clk_fpll0.common,
> [...]
> > +       &clk_mpll5.common,
> > +};
> > +
> > +static struct sg2044_clk_common *sg2044_div_commons[] = {
> > +       &clk_div_ap_sys_fixed.common,
> > +       &clk_div_ap_sys_main.common,
> [...]
> > +       &clk_div_pka.common,
> > +};
> > +
> > +static struct sg2044_clk_common *sg2044_mux_commons[] = {
> > +       &clk_mux_ddr0.common,
> [..]
> > +};
> > +
> > +static struct sg2044_clk_common *sg2044_gate_commons[] = {
> 
> Can these arrays be const?
> 

It can not be, we need a non const clk_hw to register. It is 
defined in this structure. Although these array can be set as
"struct sg2044_clk_common * const", but I think this is kind
of meaningless.

> > +       &clk_gate_ap_sys.common,
> > diff --git a/drivers/clk/sophgo/clk-sg2044.h b/drivers/clk/sophgo/clk-sg2044.h
> > new file mode 100644
> > index 000000000000..bb69532fdf4f
> > --- /dev/null
> > +++ b/drivers/clk/sophgo/clk-sg2044.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2024 Inochi Amaoto <inochiama@outlook.com>
> > + */
> > +
> > +#ifndef _CLK_SOPHGO_SG2044_H_
> > +#define _CLK_SOPHGO_SG2044_H_
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/io.h>
> > +#include <linux/spinlock.h>
> > +
> 
> Please inline the contents of this file in the one C file that uses the
> header.
> 

OK, I will take it.

> > +#define PLL_LIMIT_FOUTVCO      0
> > +#define PLL_LIMIT_FOUT         1
> > +#define PLL_LIMIT_REFDIV       2
> > +#define PLL_LIMIT_FBDIV                3
> > +#define PLL_LIMIT_POSTDIV1     4
> > +#define PLL_LIMIT_POSTDIV2     5
> > +
> > +#define for_each_pll_limit_range(_var, _limit) \
> > +       for (_var = (_limit)->min; _var <= (_limit)->max; _var++)
> > +
> > +struct sg2044_clk_limit {
> > +       u64 min;
> > +       u64 max;
> > +};
> > +

