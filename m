Return-Path: <netdev+bounces-34734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748397A5387
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B51B1C20DB0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5191220B0F;
	Mon, 18 Sep 2023 20:14:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C4BA41
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:14:24 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF998F;
	Mon, 18 Sep 2023 13:14:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50098cc8967so7948649e87.1;
        Mon, 18 Sep 2023 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695068061; x=1695672861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+e7RPlNIEbnCE6SNaWUDYK3xS0AglRAD4OXd3Ulb6s=;
        b=bTh9i89mD05TlvVR6OmjzYHPXUlWHU6M5IYh2Pqrroboh2pGf5+UYoFynx89KSpX1b
         CtUp1ANG6bivxW2EY5rOdKo1VvnNAl8mn8423w0F8aBJIF2ytvMXkOnjZaT1iOR6fLYX
         NioIbTTRhpmWGvEVE4lbfu2aBfQPGI6uoqUjKoyHWFkpEmt/aKBpGs+HpbtRYL/ca/nA
         DfryEtlSEVl8tzVD6FJODusw+aB1OBL8z3nzQXFPMJpdwwMxqun0hIaqX97c7YCCKHop
         pJG5Ay8Dy+ljbWAEymGI08ZZG0hIcYmthLiKXF7yu4NvlEwwb0dD27vLBRijXmxlCUOP
         Tg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695068061; x=1695672861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+e7RPlNIEbnCE6SNaWUDYK3xS0AglRAD4OXd3Ulb6s=;
        b=wVjeAsFmBS5Bd9uenf8vIzLXCKCagZ3OoLoIFCweI1HVBBPquhXoldg7iJObTio4cd
         dHKq3hjP7y+pqRZov3M6PMs6GohmI74Hv1X/8vu/KK1m6XRvVhLtRWKlgkcVk841v+cK
         c1NPcbmyN2i/T3Fdad0AIiLKThphBvWj5UF0Ip4QH0epPsW4PgXOWu23C+dMRbwNL0hl
         CRiuuVYdWclGBG5QAaGwifSwBBa8LVXqXFX8fhTAw1OoTXAt/1qMxMAR3d27C41HsNQr
         4L2tvH1ZijLtarIWXYx9gtsPu1h7itskHrs78AhvxG84ezxOZ/QE+3zJk9MarBhF94lo
         LSeQ==
X-Gm-Message-State: AOJu0Yz8wzy5JvEawwLedtV9i7Br2GlaNOAukXKlWDCAuWnje/+AaFo5
	WZqcZOATJ3ZqsxF/9s+whH8=
X-Google-Smtp-Source: AGHT+IFn+LYvQSp5rZn6lhfAzGXnJK7HIJKtSCz+mspnLIkIgmBXG+lSxqLriZhpKyj97znopumt4A==
X-Received: by 2002:a05:6512:33c8:b0:4fe:d0f:b4f7 with SMTP id d8-20020a05651233c800b004fe0d0fb4f7mr10927733lfg.65.1695068061007;
        Mon, 18 Sep 2023 13:14:21 -0700 (PDT)
Received: from mobilestation ([178.178.81.241])
        by smtp.gmail.com with ESMTPSA id d33-20020a0565123d2100b0050317d2b0f3sm563142lfv.61.2023.09.18.13.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:14:20 -0700 (PDT)
Date: Mon, 18 Sep 2023 23:14:06 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Vladimir Zapolskiy <vz@mleia.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Emil Renner Berthing <kernel@esmil.dk>, 
	Samin Guo <samin.guo@starfivetech.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 00/22] convert to devm_stmmac_probe_config_dt
Message-ID: <nqa7g7x3alrcbnbgkyalg5h26na6rzwid3jxdqviisi2pnkdrn@b4qvgamj4urr>
References: <20230916075829.1560-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916075829.1560-1-jszhang@kernel.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 03:58:06PM +0800, Jisheng Zhang wrote:
> Russell pointed out there's a new devm_stmmac_probe_config_dt()
> helper now when reviewing my starfive gmac error handling patch[1].
> After greping the code, this nice helper was introduced by Bartosz in
> [2], I think it's time to convert all dwmac users to this helper and
> finally complete the TODO in [2] "but once all users of the old
> stmmac_pltfr_remove() are converted to the devres helper, it will be
> renamed back to stmmac_pltfr_remove() and the no_dt function removed."
> 
> Link: https://lore.kernel.org/netdev/ZOtWmedBsa6wQQ6+@shell.armlinux.org.uk/ [1]
> Link: https://lore.kernel.org/all/20230623100417.93592-1-brgl@bgdev.pl/  [2]

I see the series is already merged in. In anyway here is my tag:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thanks for submitting the set.

-Serge(y)

> 
> Since v1:
>  - rebase on new net-next
>  - add make stmmac_{probe|remove}_config_dt static as suggested by Russell.
> 
> Jisheng Zhang (23):
>   net: stmmac: dwmac-anarion: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-dwc-qos-eth: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-generic: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-generic: use devm_stmmac_pltfr_probe()
>   net: stmmac: dwmac-imx: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-ingenic: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-intel-plat: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-ipq806x: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-lpc18xx: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-mediatek: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-meson: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-meson8b: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-rk: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-socfpga: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-starfive: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-sti: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-stm32: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-sun8i: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-sunxi: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-tegra: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-visconti: use devm_stmmac_probe_config_dt()
>   net: stmmac: rename stmmac_pltfr_remove_no_dt to stmmac_pltfr_remove
>   net: stmmac: make stmmac_{probe|remove}_config_dt static
> 
>  .../ethernet/stmicro/stmmac/dwmac-anarion.c   | 10 +--
>  .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 15 +---
>  .../ethernet/stmicro/stmmac/dwmac-generic.c   | 15 +---
>  .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 13 ++--
>  .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 33 +++------
>  .../stmicro/stmmac/dwmac-intel-plat.c         | 25 +++----
>  .../ethernet/stmicro/stmmac/dwmac-ipq806x.c   | 27 +++----
>  .../ethernet/stmicro/stmmac/dwmac-lpc18xx.c   | 19 ++---
>  .../ethernet/stmicro/stmmac/dwmac-mediatek.c  |  6 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-meson.c | 25 ++-----
>  .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 53 +++++---------
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 14 ++--
>  .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 16 ++---
>  .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 10 +--
>  .../net/ethernet/stmicro/stmmac/dwmac-sti.c   | 14 ++--
>  .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 17 ++---
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  6 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 23 +++---
>  .../net/ethernet/stmicro/stmmac/dwmac-tegra.c | 10 ++-
>  .../ethernet/stmicro/stmmac/dwmac-visconti.c  | 18 ++---
>  .../ethernet/stmicro/stmmac/stmmac_platform.c | 70 ++++++-------------
>  .../ethernet/stmicro/stmmac/stmmac_platform.h |  5 --
>  22 files changed, 127 insertions(+), 317 deletions(-)
> 
> -- 
> 2.40.1
> 
> 

