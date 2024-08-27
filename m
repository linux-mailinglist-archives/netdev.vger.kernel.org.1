Return-Path: <netdev+bounces-122264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAEE9608B6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91B828246F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848DD19EEB4;
	Tue, 27 Aug 2024 11:30:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF619EED6;
	Tue, 27 Aug 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758213; cv=none; b=Fx7WERJnKi5Fn9Mir27SSusXpy4rmy4azGiS0/NvsLNCXjlNykqtrJj2wHppM0VmK9ypOmZdbZvHUeNeDuU/4JP/T/5/tvqy4rwXtO9+YvCxKkQmWGxOqOogiTEcpETZToQSebSGfqKHL1QS74SyS2PcwIH/XNO+VDfCzwWfS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758213; c=relaxed/simple;
	bh=ZIK4DVQeG/hFWSg8QSiKss4AKOZ86lowHe9qs91icjc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esP580EslrSAjrkWNe4vPppcyxc7OUvDmwv++SZOdeyN5dOznrH3Zf+TOLeWKdV+e1dlA1PftdRkcqT3L9fnTtNt7vzc5ssByv5yXpunPL7wx2RKHxKIe4V6RkNQ5QDcAGx7oXYoPRQFzEXRUz3YXfOibAi3Hdi6omhA0lGqHhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtQHK0YBPz6K98L;
	Tue, 27 Aug 2024 19:26:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BF0D140257;
	Tue, 27 Aug 2024 19:30:08 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 12:30:07 +0100
Date: Tue, 27 Aug 2024 12:30:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Zijun Hu <zijun_hu@icloud.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Takashi Sakamoto
	<o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v3 2/3] cxl/region: Find free cxl decoder by
 device_for_each_child()
Message-ID: <20240827123006.00004527@Huawei.com>
In-Reply-To: <20240824-const_dfc_prepare-v3-2-32127ea32bba@quicinc.com>
References: <20240824-const_dfc_prepare-v3-0-32127ea32bba@quicinc.com>
	<20240824-const_dfc_prepare-v3-2-32127ea32bba@quicinc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 24 Aug 2024 17:07:44 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

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
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
This seems to functionally do the same as before.

I'm not sure I like the original code though so a comment inline.

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

Why do we carry on in this case?
Conditions are:
1. Start match_data->id == 0
2. First pass cxld->id == 0 (all good) or
   cxld->id == 1 say (and we skip until we match
   on cxld->id == 0 (perhaps on the second child if they are
   ordered (1, 0, 2) etc. 

If we skipped and then matched on second child but it was
already in use (so region set), we will increment match_data->id to 1
but never find that as it was the one we skipped.

So this can only work if the children are ordered.
So if that's the case and the line above is just a sanity check
on that, it should be noisier (so an error print) and might
as well fail as if it doesn't match all bets are off.

Jonathan
 
>  		return 0;
>  
> -	if (!cxld->region)
> +	if (!cxld->region) {
> +		match_data->target_device = get_device(dev);
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
>  	if (!dev)
>  		return NULL;
>  	/*
> 


