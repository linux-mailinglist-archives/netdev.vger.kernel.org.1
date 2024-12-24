Return-Path: <netdev+bounces-154211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2549FC119
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE57165B50
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF00A212B1A;
	Tue, 24 Dec 2024 17:54:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816901BC9FF;
	Tue, 24 Dec 2024 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735062881; cv=none; b=GXQHoS1jOYjLY9SFuUpXUaV/pqQYrhVwVY1gUBaZlSUnI3cn3G0pkx8iivZB+ihw9TPn01KrtNYmZdx7xOBhADVFEtl+TPuOLFda9Z29Olb+SDW/LCdy0bi/E3k003Tho1lLiGPQAIJR8OFOT5vGUIzX+ApB+R7PPBt8oEd3iTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735062881; c=relaxed/simple;
	bh=D/KhizhTQBGkjewvpq0aVPdUbV59Qbk0HMgX3hfLL/Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKbAe9x9j+oujz7TNbrr5bpmZCcilxkTIVN7AhaXHGKoMSBYQsVr2IFYv/TbtObtZvHw6KmCBBDeHQJOX4Fj2Og4R5jUY+XF9F2aHT14rZByevfCReFFRF9VbI2JbTTs7j9MyMvo4MPCEwNW6Ad0cUZfJxypkxjB4L5vLYlb7CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHjFP1kBxz6K6TY;
	Wed, 25 Dec 2024 01:54:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E7C6140391;
	Wed, 25 Dec 2024 01:54:37 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 18:54:36 +0100
Date: Tue, 24 Dec 2024 17:54:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 19/27] cxl: make region type based on endpoint type
Message-ID: <20241224175435.00007e36@huawei.com>
In-Reply-To: <20241216161042.42108-20-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-20-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:34 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
> Support for Type2 implies region type needs to be based on the endpoint
> type instead.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Makes sense.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index eb2ae276b01a..583727df1666 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2667,7 +2667,8 @@ static ssize_t create_ram_region_show(struct device *dev,
>  }
>  
>  static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> -					  enum cxl_decoder_mode mode, int id)
> +					  enum cxl_decoder_mode mode, int id,
> +					  enum cxl_decoder_type target_type)
>  {
>  	int rc;
>  
> @@ -2689,7 +2690,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(-EBUSY);
>  	}
>  
> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
> +	return devm_cxl_add_region(cxlrd, id, mode, target_type);
>  }
>  
>  static ssize_t create_region_store(struct device *dev, const char *buf,
> @@ -2703,7 +2704,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, mode, id);
> +	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> @@ -3379,7 +3380,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	do {
>  		cxlr = __create_region(cxlrd, cxled->mode,
> -				       atomic_read(&cxlrd->region_id));
> +				       atomic_read(&cxlrd->region_id),
> +				       cxled->cxld.target_type);
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
>  	if (IS_ERR(cxlr)) {


