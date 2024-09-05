Return-Path: <netdev+bounces-125363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C02396CE76
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3929B241F9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 05:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F8188A26;
	Thu,  5 Sep 2024 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q8f3q5DW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8985654;
	Thu,  5 Sep 2024 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725514366; cv=none; b=XUlxgSlQF5zwpuvSiQMsccAUQly0OaH+zvy/CdOCbtlaYEmhq8PbWV57z5+Q9YNvmKLwI7xE9A46p9HChkkr9kpNpsb3z19J+hzUr8FhyARL6X2GV/BwFKoFigEDRXB3d25ChHtzXCLNwPASvnKdKoln7B21ovwtN3WFLmxXr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725514366; c=relaxed/simple;
	bh=YzXuS0Wz6pbDi7inJF1uNB7hmxbOrLamUD0i7efbMuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnerYKTLJsDXphrtVMTXloi65e3fU9iVlncNk87yQFYMDDId9jLOYzifdli2Lr6QHN+4BMiLo73hcPqZGu0WvJhUVWnw+h27IcMJJ9+qaKMnRYuwSA4YHyaEvfTfKFcxopA9/KTvI4lOUDjrOemaVJ7s2Rz002N6SGtKKxNA1uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q8f3q5DW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E3BC4CEC4;
	Thu,  5 Sep 2024 05:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725514366;
	bh=YzXuS0Wz6pbDi7inJF1uNB7hmxbOrLamUD0i7efbMuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q8f3q5DWqd/mXGNlgu6mOhiT7g9PT7J+utkKZwIct2yL+T2ohorFmzucNtxq9DCV/
	 PhKFQDX/wdDyCS0UaKIKPr7JaJRyb3bWgpB0o/xnIWKAEmhDru3jlEmunIB5ktbtAx
	 z4sRlRKSJT/cZQXNJvKQvLcL/BCdobT8kB3r8TIo=
Date: Thu, 5 Sep 2024 07:32:43 +0200
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
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
Message-ID: <2024090531-mustang-scheming-3066@gregkh>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>

On Thu, Sep 05, 2024 at 08:36:09AM +0800, Zijun Hu wrote:
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
> caller's match data @*data, but match_free_decoder() as the old API's
> match function indeed modifies relevant match data, so it is not suitable
> for the new API any more, solved by using device_for_each_child() to
> implement relevant finding free cxl decoder function.
> 
> By the way, this commit does not change any existing logic.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..c2068e90bf2f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -794,10 +794,15 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  	return rc;
>  }
>  
> +struct cxld_match_data {
> +	int id;
> +	struct device *target_device;
> +};
> +
>  static int match_free_decoder(struct device *dev, void *data)
>  {
> +	struct cxld_match_data *match_data = data;
>  	struct cxl_decoder *cxld;
> -	int *id = data;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
> @@ -805,17 +810,31 @@ static int match_free_decoder(struct device *dev, void *data)
>  	cxld = to_cxl_decoder(dev);
>  
>  	/* enforce ordered allocation */
> -	if (cxld->id != *id)
> +	if (cxld->id != match_data->id)
>  		return 0;
>  
> -	if (!cxld->region)
> +	if (!cxld->region) {
> +		match_data->target_device = get_device(dev);

Where is put_device() called?

Ah, it's on the drop later on after find_free_decoder(), right?

>  		return 1;
> +	}
>  
> -	(*id)++;
> +	match_data->id++;
>  
>  	return 0;
>  }
>  
> +/* NOTE: need to drop the reference with put_device() after use. */
> +static struct device *find_free_decoder(struct device *parent)
> +{
> +	struct cxld_match_data match_data = {
> +		.id = 0,
> +		.target_device = NULL,
> +	};
> +
> +	device_for_each_child(parent, &match_data, match_free_decoder);
> +	return match_data.target_device;
> +}
> +
>  static int match_auto_decoder(struct device *dev, void *data)
>  {
>  	struct cxl_region_params *p = data;
> @@ -840,7 +859,6 @@ cxl_region_find_decoder(struct cxl_port *port,
>  			struct cxl_region *cxlr)
>  {
>  	struct device *dev;
> -	int id = 0;
>  
>  	if (port == cxled_to_port(cxled))
>  		return &cxled->cxld;
> @@ -849,7 +867,7 @@ cxl_region_find_decoder(struct cxl_port *port,
>  		dev = device_find_child(&port->dev, &cxlr->params,
>  					match_auto_decoder);
>  	else
> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
> +		dev = find_free_decoder(&port->dev);

This still feels more complex that I think it should be.  Why not just
modify the needed device information after the device is found?  What
exactly is being changed in the match_free_decoder that needs to keep
"state"?  This feels odd.

thanks,

greg k-h

