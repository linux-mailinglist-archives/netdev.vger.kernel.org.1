Return-Path: <netdev+bounces-115110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0BE945320
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AACE28386B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 19:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29D11494B3;
	Thu,  1 Aug 2024 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+gXH4/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F813C832;
	Thu,  1 Aug 2024 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539403; cv=none; b=j9UudOakhb6T1jlB0A9WF6eiu0QDb+YFjXlPqZCVU/YZCSLqHH9mWOIzX+cN6Ur5edDA1EuBM8ZqO/C0VHx8gNko/20vlabWPp+FVoN6CUGph3rLlZIuEujfhgCOkG7sHXRwQc+yGdPN/12V1Iz0UDE+dPs68csVS3tG8DpmPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539403; c=relaxed/simple;
	bh=gz2+lTfOSWB7hDYr6gqcTp/Ptge7wjwTerWt2YS43Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctu6GDDjdKbSj1Wiu4CZDXYjY0pJmJj0e8VdeE9YqU9la8C2xYVw8ByxquFAILEGAifgJkE0SThQhAWkKoF9+XnFrgP/beBQIFy9SHqYJvIMzJoUfAUaTgjQwBiyfkDPcO/9R/9G0SmAANGoh1K6n741QaQUJ092xWohY+WoFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+gXH4/Q; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2d7d8854so86383811fa.0;
        Thu, 01 Aug 2024 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722539400; x=1723144200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpZHoO/6hsX+nCMxJXNHxn39l7ARmddReK6PQZfmBS4=;
        b=B+gXH4/Qp+mJDXj/11XsCVxWNi1EOkdgwq7fQ3l2fEXma3X9FfytRBeLqh8iAdBJKP
         /kr2e4Lyr1SyDlHwnr2eYkeex3bpyL7dIb6qTA1YD8Qbhy9c1hoqiCPl/qIbFi1L+2GN
         1Ne6X6Xjulf8zHxKKnirmPI+Tx8q2NAvlqL8oLA4ZklaMtv9yXIoAQe3J3NKLeh4BW5t
         K6tfsh+zpEvJlXrhC7f7B71PZzkwXgULGKufyzTcs1i3MlzrNnzJ8LuSJ8NJQu/Z+7u+
         4fBYYrYxhCC/6fYXlnMnhdUykCxc7q43uPfyc/HPKm7bxqeMHMLv6W1e85H1Edz1VxhA
         C6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722539400; x=1723144200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpZHoO/6hsX+nCMxJXNHxn39l7ARmddReK6PQZfmBS4=;
        b=PL3vRfqEERsjqu3Dz2nGdGm9hj7Ew09FBmdkzSkonnmwY9qMP224GGcavtFnv4cWwz
         impKGVwMzA/+uy560P2xvN+q3AfSFAj2PqWFNyPoT/kE9+oyBNxAjDzWbR9unqp+ayrQ
         paRvE3fyur+SiTjts77ZAk4DBFf9VpJH7uEm5RuY+ChZKiCgVLdYBaSSzMNB93I93u1l
         YsQdbqxaRbz5AuKrwIkNEyW5eQ65cvsZ6vGKAtlCa68mRLnypu03YJXlAiYUos9tFIE+
         b/loH+eRFAeJ6Vnh/CVIX6bWvFd+xx88Xoxol8CB3nNO/RHGIm0lpKup8nCgfsNnQ2N5
         RzOg==
X-Forwarded-Encrypted: i=1; AJvYcCUwb6tNVoXPAtm31S3sE2V4YPLprFoDTqMsL/z5mZzuUq4dr9VX7DyH0O/Ll+mTTbwJvFRzWAWT6QlpSRisY3OnkBiqWKaYmjt4iabPlJe+Ru+F32Nn0IRzosUr5A2YKJsryDTL/nviaSoY8yWRJldA+i5pmLPtUumG4XayrsTgkPMXLyotP22Zr7BZLAoKGTiavmjz6xHMHXOHNh1+q4Ytd0EF
X-Gm-Message-State: AOJu0YwouNEaJCqNdW5D0poFqvILP3pB4CB2QHQqt8o+ZfDN+fe8sBvc
	6oGK5c8X9xx/ubBWJEQg7EaP8qFp4OX0OGNkfFFl8OPQxsVpgKXy
X-Google-Smtp-Source: AGHT+IHz23/0To/xP7PlNyRQ9bo8QpCLAnluXSSXqk43xJIqm7tExXUDfCkMhLZBWEYcH+OqqUb3+w==
X-Received: by 2002:a2e:8096:0:b0:2ef:3250:d0d4 with SMTP id 38308e7fff4ca-2f15ab5c7c8mr7600511fa.48.1722539399214;
        Thu, 01 Aug 2024 12:09:59 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15c1de3easm298551fa.33.2024.08.01.12.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:09:58 -0700 (PDT)
Date: Thu, 1 Aug 2024 22:09:55 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Swathi K S <swathi.ks@samsung.com>, Andrew Lunn <andrew@lunn.ch>
Cc: krzk@kernel.org, robh@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org, 
	richardcochran@gmail.com, mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com, 
	linux-fsd@tesla.com, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, alexandre.torgue@foss.st.com, 
	peppe.cavallaro@st.com, joabreu@synopsys.com, rcsekar@samsung.com, ssiddha@tesla.com, 
	jayati.sahu@samsung.com, pankaj.dubey@samsung.com, ravi.patel@samsung.com, 
	gost.dev@samsung.com
Subject: Re: [PATCH v4 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Message-ID: <yqih2sck5ayuhk5wcvgwahcndc4xb3gxthcjxgt4yqg33zfii5@ub25raxykxdp>
References: <20240730091648.72322-1-swathi.ks@samsung.com>
 <CGME20240730092902epcas5p1520f9cac624dad29f74a92ed4c559b25@epcas5p1.samsung.com>
 <20240730091648.72322-3-swathi.ks@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730091648.72322-3-swathi.ks@samsung.com>

Hi Swathi, Andrew

On Tue, Jul 30, 2024 at 02:46:46PM +0530, Swathi K S wrote:
> The FSD SoC contains two instance of the Synopsys DWC ethernet QOS IP core.
> The binding that it uses is slightly different from existing ones because
> of the integration (clocks, resets).
> 

> For FSD SoC, a mux switch is needed between internal and external clocks.
> By default after reset internal clock is used but for receiving packets
> properly, external clock is needed. Mux switch to external clock happens
> only when the external clock is present.
> 
> Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
> Signed-off-by: Suresh Siddha <ssiddha@tesla.com>
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> ---
>  .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 90 +++++++++++++++++++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 +++++-
>  include/linux/stmmac.h                        |  1 +
>  3 files changed, 117 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> index ec924c6c76c6..bc97b3b573b7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/stmmac.h>
> +#include <linux/regmap.h>
>  
>  #include "stmmac_platform.h"
>  #include "dwmac4.h"
> @@ -37,6 +38,13 @@ struct tegra_eqos {
>  	struct gpio_desc *reset;
>  };
>  
> +struct fsd_eqos_plat_data {
> +	const struct fsd_eqos_variant *fsd_eqos_inst_var;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +	struct device *dev;
> +};
> +
>  static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
>  				   struct plat_stmmacenet_data *plat_dat)
>  {
> @@ -265,6 +273,82 @@ static int tegra_eqos_init(struct platform_device *pdev, void *priv)
>  	return 0;
>  }
>  
> +static int dwc_eqos_rxmux_setup(void *priv, bool external)
> +{
> +	int i = 0;
> +	struct fsd_eqos_plat_data *plat = priv;
> +	struct clk *rx1 = NULL;
> +	struct clk *rx2 = NULL;
> +	struct clk *rx3 = NULL;
> +
> +	for (i = 0; i < plat->num_clks; i++) {
> +		if (strcmp(plat->clks[i].id, "eqos_rxclk_mux") == 0)
> +			rx1 = plat->clks[i].clk;
> +		else if (strcmp(plat->clks[i].id, "eqos_phyrxclk") == 0)
> +			rx2 = plat->clks[i].clk;
> +		else if (strcmp(plat->clks[i].id, "dout_peric_rgmii_clk") == 0)
> +			rx3 = plat->clks[i].clk;
> +	}
> +
> +	/* doesn't support RX clock mux */
> +	if (!rx1)
> +		return 0;
> +
> +	if (external)
> +		return clk_set_parent(rx1, rx2);
> +	else
> +		return clk_set_parent(rx1, rx3);
> +}

Andrew is right asking about this implementation. It does seem
questionable:

1. AFAIR RGMII Rx clock is supposed to be retrieved the PHY. So the
eqos_phyrxclk and dout_peric_rgmii_clk are the PHY clocks. Do you have
a PHY integrated in the SoC? If so you should have defined it as a
separate DT-node and moved the clocks definition in there.

2. Do you really need to perform the "eqos_rxclk_mux" clock
re-parenting on each interface open/close? Based on the commit log you
don't. So the re-parenting can be done in the glue driver or even in
the device tree by means of the "assigned-clock-parents" property.

-Serge(y)

> +
> +static int fsd_clks_endisable(void *priv, bool enabled)
> +{
> +	struct fsd_eqos_plat_data *plat = priv;
> +
> +	if (enabled) {
> +		return clk_bulk_prepare_enable(plat->num_clks, plat->clks);
> +	} else {
> +		clk_bulk_disable_unprepare(plat->num_clks, plat->clks);
> +		return 0;
> +	}
> +}
> +
> +static int fsd_eqos_probe(struct platform_device *pdev,
> +			  struct plat_stmmacenet_data *data,
> +			  struct stmmac_resources *res)
> +{
> +	struct fsd_eqos_plat_data *priv_plat;
> +	int ret = 0;
> +
> +	priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat), GFP_KERNEL);
> +	if (!priv_plat)
> +		return -ENOMEM;
> +
> +	priv_plat->dev = &pdev->dev;
> +
> +	ret = devm_clk_bulk_get_all(&pdev->dev, &priv_plat->clks);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "No clocks available\n");
> +
> +	priv_plat->num_clks = ret;
> +
> +	data->bsp_priv = priv_plat;
> +	data->clks_config = fsd_clks_endisable;
> +	data->rxmux_setup = dwc_eqos_rxmux_setup;
> +
> +	ret = fsd_clks_endisable(priv_plat, true);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Unable to enable fsd clock\n");
> +
> +	return 0;
> +}
> +
> +static void fsd_eqos_remove(struct platform_device *pdev)
> +{
> +	struct fsd_eqos_plat_data *priv_plat = get_stmmac_bsp_priv(&pdev->dev);
> +
> +	fsd_clks_endisable(priv_plat, false);
> +}
> +
>  static int tegra_eqos_probe(struct platform_device *pdev,
>  			    struct plat_stmmacenet_data *data,
>  			    struct stmmac_resources *res)
> @@ -411,6 +495,11 @@ static const struct dwc_eth_dwmac_data tegra_eqos_data = {
>  	.remove = tegra_eqos_remove,
>  };
>  
> +static const struct dwc_eth_dwmac_data fsd_eqos_data = {
> +	.probe = fsd_eqos_probe,
> +	.remove = fsd_eqos_remove,
> +};
> +
>  static int dwc_eth_dwmac_probe(struct platform_device *pdev)
>  {
>  	const struct dwc_eth_dwmac_data *data;
> @@ -473,6 +562,7 @@ static void dwc_eth_dwmac_remove(struct platform_device *pdev)
>  static const struct of_device_id dwc_eth_dwmac_match[] = {
>  	{ .compatible = "snps,dwc-qos-ethernet-4.10", .data = &dwc_qos_data },
>  	{ .compatible = "nvidia,tegra186-eqos", .data = &tegra_eqos_data },
> +	{ .compatible = "tesla,fsd-ethqos", .data = &fsd_eqos_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, dwc_eth_dwmac_match);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 12689774d755..2ef82edec522 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4001,6 +4001,12 @@ static int __stmmac_open(struct net_device *dev,
>  	netif_tx_start_all_queues(priv->dev);
>  	stmmac_enable_all_dma_irq(priv);
>  
> +	if (priv->plat->rxmux_setup) {
> +		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, true);
> +		if (ret)
> +			netdev_err(priv->dev, "Rxmux setup failed\n");
> +	}
> +
>  	return 0;
>  
>  irq_error:
> @@ -4056,7 +4062,13 @@ static void stmmac_fpe_stop_wq(struct stmmac_priv *priv)
>  static int stmmac_release(struct net_device *dev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
> -	u32 chan;
> +	u32 chan, ret;
> +
> +	if (priv->plat->rxmux_setup) {
> +		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, false);
> +		if (ret)
> +			netdev_err(priv->dev, "Rxmux setup failed\n");
> +	}
>  
>  	if (device_may_wakeup(priv->device))
>  		phylink_speed_down(priv->phylink, false);
> @@ -7848,11 +7860,17 @@ int stmmac_suspend(struct device *dev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> -	u32 chan;
> +	u32 chan, ret;
>  
>  	if (!ndev || !netif_running(ndev))
>  		return 0;
>  
> +	if (priv->plat->rxmux_setup) {
> +		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, false);
> +		if (ret)
> +			netdev_err(priv->dev, "Rxmux setup failed\n");
> +	}
> +
>  	mutex_lock(&priv->lock);
>  
>  	netif_device_detach(ndev);
> @@ -8018,6 +8036,12 @@ int stmmac_resume(struct device *dev)
>  	mutex_unlock(&priv->lock);
>  	rtnl_unlock();
>  
> +	if (priv->plat->rxmux_setup) {
> +		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, true);
> +		if (ret)
> +			netdev_err(priv->dev, "Rxmux setup failed\n");
> +	}
> +
>  	netif_device_attach(ndev);
>  
>  	return 0;
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 84e13bd5df28..f017b818d421 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -264,6 +264,7 @@ struct plat_stmmacenet_data {
>  	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
>  	int (*init)(struct platform_device *pdev, void *priv);
>  	void (*exit)(struct platform_device *pdev, void *priv);
> +	int (*rxmux_setup)(void *priv, bool external);
>  	struct mac_device_info *(*setup)(void *priv);
>  	int (*clks_config)(void *priv, bool enabled);
>  	int (*crosststamp)(ktime_t *device, struct system_counterval_t *system,
> -- 
> 2.17.1
> 
> 

