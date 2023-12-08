Return-Path: <netdev+bounces-55357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A325280A9E6
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4521F2124A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884D537D31;
	Fri,  8 Dec 2023 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV9pLQrd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BFC32C7A;
	Fri,  8 Dec 2023 16:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC84DC433C8;
	Fri,  8 Dec 2023 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702054742;
	bh=h0JkAKzYF1eCC3VCUFet/wUloQePgRqJtpyUOwrwHs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VV9pLQrduCHZxqG1gp2gsdESd89zqUJ8T/ztaw9WJVw7s21G8m8muHVlDot3+Gf40
	 65myTt3MriTs13uBBjQtrCxREZctMcuNBTs7qnGtm24UGeLP0ZZIHk1cDe2BqhGoG5
	 6n9im+9fMvwh7N5TggcZFvP6o6io3PyaZcgCS1iYmLOW+edW4FBFuzCKI3FXRVqssq
	 gBwKneVYebD7Q/ruS5A6bejC3WL/NZroDaT74VKIptNNKVPIXywOlsdC0uq209XkCP
	 And+nEwHTfPBhvawAtMy7NfdJGgiRcPQgMJR+qF0p4bLHgxxd7/yjMuh2w1hz5BSiS
	 rFmD07v7UUqtw==
Date: Fri, 8 Dec 2023 16:58:55 +0000
From: Simon Horman <horms@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/stm: dsi: expose DSI PHY internal clock
Message-ID: <20231208165855.GA8459@kernel.org>
References: <20231204101113.276368-1-raphael.gallais-pou@foss.st.com>
 <20231204101113.276368-4-raphael.gallais-pou@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204101113.276368-4-raphael.gallais-pou@foss.st.com>

On Mon, Dec 04, 2023 at 11:11:12AM +0100, Raphael Gallais-Pou wrote:

...

> @@ -514,18 +675,40 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
>  		dsi->lane_max_kbps *= 2;
>  	}
>  
> -	dw_mipi_dsi_stm_plat_data.base = dsi->base;
> -	dw_mipi_dsi_stm_plat_data.priv_data = dsi;
> +	dsi->pdata = *pdata;
> +	dsi->pdata.base = dsi->base;
> +	dsi->pdata.priv_data = dsi;
> +
> +	dsi->pdata.max_data_lanes = 2;
> +	dsi->pdata.phy_ops = &dw_mipi_dsi_stm_phy_ops;
>  
>  	platform_set_drvdata(pdev, dsi);
>  
> -	dsi->dsi = dw_mipi_dsi_probe(pdev, &dw_mipi_dsi_stm_plat_data);
> +	dsi->dsi = dw_mipi_dsi_probe(pdev, &dsi->pdata);
>  	if (IS_ERR(dsi->dsi)) {
>  		ret = PTR_ERR(dsi->dsi);
>  		dev_err_probe(dev, ret, "Failed to initialize mipi dsi host\n");
>  		goto err_dsi_probe;
>  	}
>  
> +	/*
> +	 * We need to wait for the generic bridge to probe before enabling and
> +	 * register the internal pixel clock.
> +	 */
> +	ret = clk_prepare_enable(dsi->pclk);
> +	if (ret) {
> +		DRM_ERROR("%s: Failed to enable peripheral clk\n", __func__);
> +		goto err_dsi_probe;
> +	}
> +
> +	ret = dw_mipi_dsi_clk_register(dsi, dev);
> +	if (ret) {
> +		DRM_ERROR("Failed to register DSI pixel clock: %d\n", ret);

Hi Raphael,

Does clk_disable_unprepare(dsi->pclk) need to be added to this unwind
chain?

Flagged by Smatch.

> +		goto err_dsi_probe;
> +	}
> +
> +	clk_disable_unprepare(dsi->pclk);
> +
>  	return 0;
>  
>  err_dsi_probe:

...

