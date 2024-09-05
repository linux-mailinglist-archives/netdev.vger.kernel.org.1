Return-Path: <netdev+bounces-125362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3406796CE70
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D331F26D56
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 05:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD6A185941;
	Thu,  5 Sep 2024 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NS8SsDSX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214879F5;
	Thu,  5 Sep 2024 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725514153; cv=none; b=Wtubksavi0xkz+v0l1V1rJNMz4vk/6PLgTPRl0Xnob7qQnIvZp9fajEr/l6yc+p1vvcY/ZSoam8AkYzq7Dd2t+IbCKbbjVEUPxB3k8Jt+MNMjajckete0fih6KustSr8Hd34KZCjABzhfml7i5VnPO1lyCX0bU32EX3+XdTKOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725514153; c=relaxed/simple;
	bh=t4IL1zURGkLHSSkfDGduy22l1pZL0eKjhf0pnmeRqKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p71/Tg6Mko3+DQdwHxDZd3Z6snlyxaGlFMi5oDyAm/mwAeEykA/IrnoG9ApGKwXFAaGufggCDF2hoON9+4Hy6dpfYdc6tnepk8MvkbBVwMwRy+Pye9zweY6KV3AdNWSzmD70v2LlnpQSZIhum1NMdPLJxA898NjDTalNItEXKGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NS8SsDSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDD9C4CEC4;
	Thu,  5 Sep 2024 05:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725514153;
	bh=t4IL1zURGkLHSSkfDGduy22l1pZL0eKjhf0pnmeRqKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NS8SsDSX3TjlfFfgoDpJZnpcGYvFLdOe4npmlaRUKGVunoFYbMJPT3aKi9OsbI7Yd
	 BtwwOT9OQcUpHSq85rqzq2LOYWhe1eqCnFSqKde2TXNKCkcamt6cvnI0q5S6DrOMMu
	 LykCO+LVBrMMfgvgd/uSlpNDHQC6QVW5qAGxe/XQ=
Date: Thu, 5 Sep 2024 07:29:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Timur Tabi <timur@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v4 2/2] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
Message-ID: <2024090521-finch-skinny-69bc@gregkh>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-2-4180e1d5a244@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-const_dfc_prepare-v4-2-4180e1d5a244@quicinc.com>

On Thu, Sep 05, 2024 at 08:36:10AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> To prepare for constifying the following old driver core API:
> 
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> to new:
> struct device *device_find_child(struct device *dev, const void *data,
> 		int (*match)(struct device *dev, const void *data));
> 
> The new API does not allow its match function (*match)() to modify
> caller's match data @*data, but emac_sgmii_acpi_match() as the old
> API's match function indeed modifies relevant match data, so it is not
> suitable for the new API any more, solved by using device_for_each_child()
> to implement relevant finding sgmii_ops function.
> 
> By the way, this commit does not change any existing logic.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
> index e4bc18009d08..29392c63d115 100644
> --- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
> +++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
> @@ -293,6 +293,11 @@ static struct sgmii_ops qdf2400_ops = {
>  };
>  #endif
>  
> +struct emac_match_data {
> +	struct sgmii_ops **sgmii_ops;
> +	struct device *target_device;
> +};
> +
>  static int emac_sgmii_acpi_match(struct device *dev, void *data)
>  {
>  #ifdef CONFIG_ACPI
> @@ -303,7 +308,7 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
>  		{}
>  	};
>  	const struct acpi_device_id *id = acpi_match_device(match_table, dev);
> -	struct sgmii_ops **ops = data;
> +	struct emac_match_data *match_data = data;
>  
>  	if (id) {
>  		acpi_handle handle = ACPI_HANDLE(dev);
> @@ -324,10 +329,12 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
>  
>  		switch (hrv) {
>  		case 1:
> -			*ops = &qdf2432_ops;
> +			*match_data->sgmii_ops = &qdf2432_ops;
> +			match_data->target_device = get_device(dev);
>  			return 1;
>  		case 2:
> -			*ops = &qdf2400_ops;
> +			*match_data->sgmii_ops = &qdf2400_ops;
> +			match_data->target_device = get_device(dev);

Where is put_device() now called?

>  			return 1;
>  		}
>  	}
> @@ -356,10 +363,15 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
>  	int ret;
>  
>  	if (has_acpi_companion(&pdev->dev)) {
> +		struct emac_match_data match_data = {
> +			.sgmii_ops = &phy->sgmii_ops,
> +			.target_device = NULL,
> +		};
>  		struct device *dev;
>  
> -		dev = device_find_child(&pdev->dev, &phy->sgmii_ops,
> -					emac_sgmii_acpi_match);
> +		device_for_each_child(&pdev->dev, &match_data, emac_sgmii_acpi_match);
> +		/* Need to put_device(@dev) after use */
> +		dev = match_data.target_device;


Why this new comment?  That's always required and happens down below in
the function, right?  Otherwise, what changed?

thanks,

greg k-h

