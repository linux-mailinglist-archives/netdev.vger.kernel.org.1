Return-Path: <netdev+bounces-34691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE327A52C5
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2832B281CD5
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EB2266D7;
	Mon, 18 Sep 2023 19:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFE2376F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:12:24 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91510D;
	Mon, 18 Sep 2023 12:12:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9338e4695so77945711fa.2;
        Mon, 18 Sep 2023 12:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695064341; x=1695669141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymg444KdzoYqbAJJDaXLrEYL/H+uXP42VM/AMIopDrc=;
        b=Yx8Ufs3vzVJTed3Y87G+yI/k1G9v3oHfv7TRHXJTQZoVAt+Hqy/GeXHRP1M2YvSuie
         842ZkigvRbnT3Vohk9tmDFV4hxCaXZtmT+yQAWtSp05HxwwjfEkfJtc4f7zNp/apEEYJ
         CPRQdNywnDE/lfjf+zOHGoiiQuPPnwyfJs7VdQMT8xWiCWD2tLhy86uPHRCrQyvr/rI6
         EjW3KRydcHDh14Mvl/LEs15roQmP7VA4wBkPaTB0cwXYdWPPpEHgt3Zh1TeolmSY7GN5
         Sf8NNKCJ2g7ksrALD0j6nvKgVCHaFGBb/2K14kldg+dI+i+iUBaRHNNj/C2Nto9rz2Mt
         PLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695064341; x=1695669141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ymg444KdzoYqbAJJDaXLrEYL/H+uXP42VM/AMIopDrc=;
        b=LRMnuQgGbf71L8WK/acy9ZSkBoiQ++ZQBmlAoYn+dYaLIbTLafpb+OD+P2dIkjstc6
         nch6GvpwHKpBurzbnFT55WhsibUXbe8oAY7hUXCKssFmUOXrPMj2f7ueDWZMe5KhEmmi
         /2y/+fcQZDkx2mn38nSDv7OBC+gYWE5oWcqgR3me0n5d0Rakqdgn1FGtO8qnwVDfpQkZ
         2TDJtIvQaxta2TG3sainQfNCfWCLou9Qbr4kNtp114Uu4kreCA0Kaxlwsb4+VswhnaE3
         DytcQD88KdkdcFr0glEiANq1945wsOulGLpc0NJp38Zn82s7FOl2INpt/SN5T9tqLUD+
         /u8Q==
X-Gm-Message-State: AOJu0Yzk7DcoiH9sLAZ1N4r17k0w0pPL3lTrXNShzghY5xdJbHlFzLNc
	iAcW4odgHH1Gr6aD+28gZDb/Cg1sm4lwlg==
X-Google-Smtp-Source: AGHT+IFjg/ob0U+8PEhUDzZxfqbyJQBZc1GsvUR1GE+uNr8GDm+7qXSDDyadXaGQKQJr0ryj693ksg==
X-Received: by 2002:a2e:700d:0:b0:2bf:6852:9339 with SMTP id l13-20020a2e700d000000b002bf68529339mr8798200ljc.3.1695064340742;
        Mon, 18 Sep 2023 12:12:20 -0700 (PDT)
Received: from mobilestation ([85.140.3.118])
        by smtp.gmail.com with ESMTPSA id y15-20020a2e978f000000b002bce38190a3sm2221659lji.34.2023.09.18.12.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:12:20 -0700 (PDT)
Date: Mon, 18 Sep 2023 22:11:26 +0300
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
Subject: Re: [PATCH net-next v2 02/23] net: stmmac: dwmac-dwc-qos-eth: use
 devm_stmmac_probe_config_dt()
Message-ID: <d3vpg5jcgfoe5qpreh2hnworsa2ly3ufrgqi4mcxx2yzfs7eoy@w2hgimsg64hp>
References: <20230916075829.1560-1-jszhang@kernel.org>
 <20230916075829.1560-3-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916075829.1560-3-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jisheng

On Sat, Sep 16, 2023 at 03:58:08PM +0800, Jisheng Zhang wrote:
> Simplify the driver's probe() function by using the devres
> variant of stmmac_probe_config_dt().
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c   | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> index 61ebf36da13d..ec924c6c76c6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> @@ -435,15 +435,14 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
>  	if (IS_ERR(stmmac_res.addr))
>  		return PTR_ERR(stmmac_res.addr);
>  
> -	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
>  	if (IS_ERR(plat_dat))
>  		return PTR_ERR(plat_dat);
>  
>  	ret = data->probe(pdev, plat_dat, &stmmac_res);
>  	if (ret < 0) {

>  		dev_err_probe(&pdev->dev, ret, "failed to probe subdriver\n");
> -
> -		goto remove_config;
> +		return ret;

just "return dev_err_probe()".

-Serge(y)

>  	}
>  
>  	ret = dwc_eth_dwmac_config_dt(pdev, plat_dat);
> @@ -458,25 +457,17 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
>  
>  remove:
>  	data->remove(pdev);
> -remove_config:
> -	stmmac_remove_config_dt(pdev, plat_dat);
>  
>  	return ret;
>  }
>  
>  static void dwc_eth_dwmac_remove(struct platform_device *pdev)
>  {
> -	struct net_device *ndev = platform_get_drvdata(pdev);
> -	struct stmmac_priv *priv = netdev_priv(ndev);
> -	const struct dwc_eth_dwmac_data *data;
> -
> -	data = device_get_match_data(&pdev->dev);
> +	const struct dwc_eth_dwmac_data *data = device_get_match_data(&pdev->dev);
>  
>  	stmmac_dvr_remove(&pdev->dev);
>  
>  	data->remove(pdev);
> -
> -	stmmac_remove_config_dt(pdev, priv->plat);
>  }
>  
>  static const struct of_device_id dwc_eth_dwmac_match[] = {
> -- 
> 2.40.1
> 
> 

