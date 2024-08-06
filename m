Return-Path: <netdev+bounces-116017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC60948CB0
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D8E28501D
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2511BDA86;
	Tue,  6 Aug 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCehmxG5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E5EADC;
	Tue,  6 Aug 2024 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722939479; cv=none; b=McaP/K4bmisQICIM4hbyH4qYp6ArZZwdBlf5wsetmBjOXPCfUnGjuBZWfKurnpiEkXKr4NumqM3vl7Vu5wReyWZ2S75xKyB06X7vd++I2KbYr9UQ+4wrEOQXX7BZvy2RyIwbJ8fK/+9o9NC32G2jrFrGkWfu0g0RHq5Ta2sl4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722939479; c=relaxed/simple;
	bh=cDS0bvDeWHq+/jB+Y3bTQlTMD3033YsDpQQp+IMKXPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMxvoPi9JlHPMz2F1Q50SW4pEfnRWS9IkyYgK4sHEZi3GqIGtCzW22tOH7e8JT9OMuJ1NgHTI52mhRyIrtN6XjZd3C9mMICKOPQxJCsalgwX/4CQWXgMdCPfq2yGayHe1XEti059L7YX/qxUQb6SNuNH5Amv3OPLHBk5+nZLRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCehmxG5; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f00ad303aso863433e87.2;
        Tue, 06 Aug 2024 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722939476; x=1723544276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWXCoJ7rYq4RnfaGfXCHjKin4v2Wy0/q7H4yQqP9Ac4=;
        b=mCehmxG5iW6Ql/P1X4t/02oalM9rqc9hPKKl199aTjd+f2nvL17JmKLVkExcY13V4n
         TGsf0f08iMfBkAYJkYGhfeBriPdWut307vDo1BXkCaxWiTHaUT83z84KkOg1AUQu9ViJ
         xKitqanNZC9Mh+N6o4VnyP4F3kiPqAgtxGAvSFG6Dh9eKc576jJxtZ+mmTWu+9SFEwBj
         mfdAg3YUyJ5+loSlQ5ZUPphXchrIFzUhHPU42q3Tenmw8uQewD3iQy9zbngjJiO8FQ7m
         QUbICmX4Ae2gEaCgaJaEZsb+3jMzbcaoUAqckSwfuXdVe4E40r+dDvJSD53TaUh4m+CJ
         d0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722939476; x=1723544276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWXCoJ7rYq4RnfaGfXCHjKin4v2Wy0/q7H4yQqP9Ac4=;
        b=n8QiRsXQNjudjP14XoKP4MGwF7EaXrfeW3CgZg1ljWfd4efXtJMQxS7Rld7nMCn1+2
         72ydy7l2n/jJyCYY8os3z2c75w8Qrbz9UvKddasrFveTLz7I1hQURK8AZzXCkPgxnYdk
         xXVd1iX1wKLOlXcfC7hDbADQsYmZtKVUxeeRjcw3dKfwp/aBHOZaGDvnDIJFO9o+Bhn4
         TM43a6LlrwOymauPjV71L1wIYrskfp0GvLb0zBTuTd+WdWtjyQnO4IrKvnrZInDprN/y
         s7cSBooHunw3I4o5PPFe7YzsxtK3BM8baa+Z2/6k6eB0d+vsFwbDXrYHsIva2tVE2d25
         qdPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOVR9n62LNp5QejNiAYwlLAx8F4y5FUlzIbnqGVz7WKf3OWG7zr4X+yTsBKYs6ZG5KIQ7SoMsrbMNRVKMelxARoi7728VOuEQeP1PuSbES6B3wfMxrKStlUXGxuquKvYAF0WxY
X-Gm-Message-State: AOJu0YwZ9eQjnTUMfpRkw6IKEP88rLmIA9TqOgEgp7mvwE2tADLkYivE
	ix0UPXUBuWyt3xqwjThwqNtCcFQMX/kXFAxELE+juiDZ8IFRkwDg
X-Google-Smtp-Source: AGHT+IHzsWMpgZJ3RQ+PF9fvZCYjeTmSj6mhWqMiOTlM0IENo7LW4n77skqeBowAwJ40wPFgndSJ+g==
X-Received: by 2002:a05:6512:b08:b0:52e:9694:3f98 with SMTP id 2adb3069b0e04-530bb3a05c4mr9527838e87.27.1722939475747;
        Tue, 06 Aug 2024 03:17:55 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba0fee7sm1421223e87.66.2024.08.06.03.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 03:17:55 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:17:52 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, dl-S32 <S32@nxp.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 2/6] net: stmmac: Expand clock rate variables
Message-ID: <ciueb72cjvfkmo3snnb5zcrfqtbum5x54kgurkkouwe6zrdrjj@vi54y7cczow3>
References: <AM9PR04MB85062693F5ACB16F411FD0CFE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB85062693F5ACB16F411FD0CFE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>

On Sun, Aug 04, 2024 at 08:49:49PM +0000, Jan Petrous (OSS) wrote:
> The clock API clk_get_rate() returns unsigned long value.
> Expand affected members of stmmac platform data.
> 
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Since you are fixing this anyway, please convert the
stmmac_clk_csr_set() and dwmac4_core_init() methods to defining the
unsigned long clk_rate local variables.

After taking the above into account feel free to add:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c   | 2 +-
>  include/linux/stmmac.h                                  | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 901a3c1959fa..2a5b38723635 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -777,7 +777,7 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
>  		netdev_err(priv->dev, "Failed to max out clk_ptp_ref: %d\n", err);
>  	plat_dat->clk_ptp_rate = clk_get_rate(plat_dat->clk_ptp_ref);
>  
> -	netdev_dbg(priv->dev, "PTP rate %d\n", plat_dat->clk_ptp_rate);
> +	netdev_dbg(priv->dev, "PTP rate %lu\n", plat_dat->clk_ptp_rate);
>  }
>  
>  static int qcom_ethqos_probe(struct platform_device *pdev)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index ad868e8d195d..b1e4df1a86a0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -639,7 +639,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  		dev_info(&pdev->dev, "PTP uses main clock\n");
>  	} else {
>  		plat->clk_ptp_rate = clk_get_rate(plat->clk_ptp_ref);
> -		dev_dbg(&pdev->dev, "PTP rate %d\n", plat->clk_ptp_rate);
> +		dev_dbg(&pdev->dev, "PTP rate %lu\n", plat->clk_ptp_rate);
>  	}
>  
>  	plat->stmmac_rst = devm_reset_control_get_optional(&pdev->dev,
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 7caaa5ae6674..47a763699916 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -279,8 +279,8 @@ struct plat_stmmacenet_data {
>  	struct clk *stmmac_clk;
>  	struct clk *pclk;
>  	struct clk *clk_ptp_ref;
> -	unsigned int clk_ptp_rate;
> -	unsigned int clk_ref_rate;
> +	unsigned long clk_ptp_rate;
> +	unsigned long clk_ref_rate;
>  	unsigned int mult_fact_100ns;
>  	s32 ptp_max_adj;
>  	u32 cdc_error_adj;
> @@ -292,7 +292,7 @@ struct plat_stmmacenet_data {
>  	int mac_port_sel_speed;
>  	int has_xgmac;
>  	u8 vlan_fail_q;

> -	unsigned int eee_usecs_rate;
> +	unsigned long eee_usecs_rate;

Sigh... One another Intel clumsy stuff: this field is initialized by
the Intel glue-drivers and utilized in there only. Why on earth has it
been added to the generic plat_stmmacenet_data structure?.. The
only explanation is that the Intel developers were lazy to refactor
the glue-driver a bit so the to be able to reach the platform data at
the respective context.

-Serge(y)

>  	struct pci_dev *pdev;
>  	int int_snapshot_num;
>  	int msi_mac_vec;
> -- 
> 2.45.2
> 
> 

