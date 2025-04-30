Return-Path: <netdev+bounces-186920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43A2AA3FE7
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 02:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38979174C11
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D605C96;
	Wed, 30 Apr 2025 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnqKyQw+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626C1854;
	Wed, 30 Apr 2025 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974701; cv=none; b=sfBMcBM6wPNM6pVr+uzhfm/rOEonXq6wtTg80Fpvdb7xkQczOHEXGqiUOjpjswoD+XsHz76D1CLheDrRIgwcmHEe2/SJNpditoW+268fq0z6pX/Gf472U0Zwcm2z+voLLPQogJ+cZbRSW/sett6N98EhleRXGEgdvtgI4nQ6hxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974701; c=relaxed/simple;
	bh=VTjDPaYh+u5lYUk6QTs7Ped8pYONP5kyLuqft4sGjrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrvAMdW75d53XLR4QDVEmRtbR5ekIqAjGvd/rmY/mGLBmCiWZbDbzglGFl8djOMvGQuMYxvFmaH6iG8E4y0UHjeDEct2QJdMiizNO9D9bsQ1+s2/cF9LUeU7E7OGwBirCNdevthxM4kM/UDMZ0jcAmZgOjaSAnCcRCB9mLdPAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnqKyQw+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c55500cf80so611462485a.1;
        Tue, 29 Apr 2025 17:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745974699; x=1746579499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94XR8HfIvZVA47q76MDPh+836wqzBgIA3jvEFvXfxEI=;
        b=QnqKyQw+1cxeEq/ej/3P5XLVL38fH1tqVdgDLpk9H8v1RdkxvCdqnRR1HQtQ4CJf2o
         RHLCR0v6YKn1IvyEcO5lbo6jq+i/K6d1HcFcu8I5gCuWOkMDkhhUoqglNjSxUD3spoNj
         Nzc8bxXf5clIBFIEu18XbBMO9fdjJS4qNyqmRck45lV6aQE3By9hZAI7Y90m2fSEE+uZ
         SIgWjMbqMiufuow4Iu3ZNnBMUAxjAfPn5GtViK2x8/kb8C8Z4+DSQSeo6GpOmkQAJQYD
         1/8tkwzr1LjoKCWeeaGJhR971lc6uX4KoLMV79m3bEXjKUq3ztegfxkSluXsVIP+Kh4D
         oFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745974699; x=1746579499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94XR8HfIvZVA47q76MDPh+836wqzBgIA3jvEFvXfxEI=;
        b=VKmP7EJ9MI4O/uESrULc1GVnPdC1/4J/XpTGqrLJDPT2UdIEcKGlJcjslHBd2RjVLs
         DGcMOj2seBTdr2KTVMgJ+anMJAv/r6Fo9dVYDpZtipijzokwpBK6bj0K0ZuPbIkel1ff
         XcHAGbqy0ahkxuP0RH7O6tw8190AGHbL8QWOR6raUpcx5mT9sCU0h4kA5WJrCky+dhV2
         RzFhoR7Tj3m2rpwDQbpAdAbY9NtSuXyiYazORWrPL6qo0Q6DWkDI4ml3LGJAf2UOVEGA
         OKv/GgSBCmHWyXWErSgVCpb9OnK3XbZHGLhrKol0pEtSVcu2QaKbmMMBcbEZgnmTKXfT
         MHQA==
X-Forwarded-Encrypted: i=1; AJvYcCUDcA/a19lT9LnQGT2mkLspavnwGP+CAthJWFLdIbvxvzwn97bsi2oNvOg8VUa65uNpvq4AoP7m2L7++u0e@vger.kernel.org, AJvYcCUioryjcOpVKwfDtH9J+GxeEA8RX/Jo2RryuFe2NX5Z5IrcmjL8+/74Q1NdFYWsA8icuyLzUm8g@vger.kernel.org, AJvYcCWc3K8ccLnzfrtGw+UTrS0pE7DeBGhBV7XXcsOk1sVUqhdwFsll7FaBecpnLRl33PqNVnjd2Avx/Ztj@vger.kernel.org, AJvYcCXWiTvCZWcm8w6FTxvQWH8hcUszvGAxSCYz9maC7Lcnt7CgMYhw+WT9Fdjq8IMaPWhxFb8LU9Fsc+Wc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PIH2X0TS5J8WQyhgOQd2mQz3CCQmjzeC0iZfG+4mMcAifgVG
	A5dPkc+LDGFlKyI+HkNbhMtK6i0Y/6hriQuWHas/1ypFAocAsh0z
X-Gm-Gg: ASbGncvIzxS/RsGycWKB0pfTA1SSXK3v6M4J8N3DDNcFvwUDSkmk5geLcsKeZIiVRIU
	IobftrmkHFh7vr12KwRDk82viMO52jM+x2kRyiM7txt3sXjTPn9nXFIDlT/gS6qoulg1izINzWX
	8EOI9R/I9HTIsWg9uRRavp8MgB8nhDIRBSL8O1N28A/UwSGy0MhvzJ0nPSPmkMFaS1wPvOLKy12
	cqN+cWlEVXNQr3AGbVZqcwt3T4papd+v7NOgLPpyUok5pZf5XH3C+RCL1g5io9/NmM3r8c7M26F
	XGX7KQgFi/WBOtSc
X-Google-Smtp-Source: AGHT+IEoxuSWeOuphj55vm/B2QbnSvTd1DarRfQwHsT+LizREZWeT0py38cxrg7yErDGpEqmoj4ZIw==
X-Received: by 2002:a05:620a:448b:b0:7c5:50ab:de02 with SMTP id af79cd13be357-7cac767c95fmr205020885a.41.1745974698627;
        Tue, 29 Apr 2025 17:58:18 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958c9204asm804297885a.5.2025.04.29.17.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:58:18 -0700 (PDT)
Date: Wed, 30 Apr 2025 08:58:02 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Vinod Koul <vkoul@kernel.org>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Nikita Shubin <nikita.shubin@maquefel.me>, Linus Walleij <linus.walleij@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 0/5] clk: sophgo: add SG2044 clock controller support
Message-ID: <f6bg3cwrujyhbrcpww3ezsqew4raelctk76qwl633f3sbkbasa@g7fuf4taklby>
References: <20250418020325.421257-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418020325.421257-1-inochiama@gmail.com>

On Fri, Apr 18, 2025 at 10:03:19AM +0800, Inochi Amaoto wrote:
> The clock controller of SG2044 provides multiple clocks for various
> IPs on the SoC, including PLL, mux, div and gates. As the PLL and
> div have obvious changed and do not fit the framework of SG2042,
> a new implement is provided to handle these.
> 
> Changed from v4:
> 1. patch 1,3: Applied Krzysztof's tag.
> 2. patch 1: fix header path in description.
> 3. patch 4: drop duplicated module alias.
> 4. patch 5: make sg2044_clk_desc_data const.
> 
> Changed from v3:
> - https://lore.kernel.org/all/20250226232320.93791-1-inochiama@gmail.com
> 1. patch 1,2: Add top syscon binding and aux driver.
> 2. patch 4: Separate the syscon pll driver to a standalone one.
> 3. patch 4: use abs_diff to compare pll clock.
> 4. patch 4: remove unnecessary else.
> 5. patch 5: use clk_hw for parent clocks if possible.
> 6. patch 5: inline the header which is necessary.
> 7. patch 5: make common array as const.
> 
> Changed from v2:
> - https://lore.kernel.org/all/20250204084439.1602440-1-inochiama@gmail.com/
> 1. Applied Chen Wang's tag.
> 2. patch 2: fix author mail infomation.
> 
> Changed from v1:
> - https://lore.kernel.org/all/20241209082132.752775-1-inochiama@gmail.com/
> 1. patch 1: Applied Krzysztof's tag.
> 2. patch 2: Fix the build warning from bot.
> 
> Inochi Amaoto (5):
>   dt-bindings: soc: sophgo: Add SG2044 top syscon device
>   soc: sophgo: sg2044: Add support for SG2044 TOP syscon device
>   dt-bindings: clock: sophgo: add clock controller for SG2044
>   clk: sophgo: Add PLL clock controller support for SG2044 SoC
>   clk: sophgo: Add clock controller support for SG2044 SoC
> 
>  .../bindings/clock/sophgo,sg2044-clk.yaml     |   99 +
>  .../soc/sophgo/sophgo,sg2044-top-syscon.yaml  |   49 +
>  drivers/clk/sophgo/Kconfig                    |   19 +
>  drivers/clk/sophgo/Makefile                   |    2 +
>  drivers/clk/sophgo/clk-sg2044-pll.c           |  628 ++++++
>  drivers/clk/sophgo/clk-sg2044.c               | 1812 +++++++++++++++++
>  drivers/soc/Kconfig                           |    1 +
>  drivers/soc/Makefile                          |    1 +
>  drivers/soc/sophgo/Kconfig                    |   21 +
>  drivers/soc/sophgo/Makefile                   |    3 +
>  drivers/soc/sophgo/sg2044-topsys.c            |   45 +
>  include/dt-bindings/clock/sophgo,sg2044-clk.h |  153 ++
>  include/dt-bindings/clock/sophgo,sg2044-pll.h |   27 +
>  13 files changed, 2860 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2044-top-syscon.yaml
>  create mode 100644 drivers/clk/sophgo/clk-sg2044-pll.c
>  create mode 100644 drivers/clk/sophgo/clk-sg2044.c
>  create mode 100644 drivers/soc/sophgo/Kconfig
>  create mode 100644 drivers/soc/sophgo/Makefile
>  create mode 100644 drivers/soc/sophgo/sg2044-topsys.c
>  create mode 100644 include/dt-bindings/clock/sophgo,sg2044-clk.h
>  create mode 100644 include/dt-bindings/clock/sophgo,sg2044-pll.h
> 
> --
> 2.49.0
> 

Hi, Stephen,

Would you like to share some comments on this series? I think this
driver now it is ready to go.

Regards,
Inochi

