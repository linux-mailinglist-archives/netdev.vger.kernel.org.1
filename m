Return-Path: <netdev+bounces-229793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BF6BE0D84
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 23:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28C8A4E1C11
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AC33002BD;
	Wed, 15 Oct 2025 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIHoHGkq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E22D24AC;
	Wed, 15 Oct 2025 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760564528; cv=none; b=BQZZeCjKU+2NNKtvJwrlzIhEyGXqbCxK8L7DobfcfjYMWwB5ewmdDmvb1LxTCEylaJ1p7xLZ/UUtIF3YOLbGRuaJAQbWC4bSIP/Yt33Zm5u3zs3WYPES/pvnOItM9qdnf0Q1DncEkq/H87LLmQfomMh17t8tnSSn1E0N651bQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760564528; c=relaxed/simple;
	bh=qfxkjojbnOlKxoE9ZeK4jTDYrWsSjnjfW0LsKes6m0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvsNT7CMOJ1By9hUtpZ7IZbAspjQnf9dmbBeKrmLYZabJgLs4WHiE4MBfhbtr1fjpKhANh8wJpwk6URLmGSXHMBLHeMiCBUQhvj4s7CC8gtK0m0V/16i2gWTWVvSlWleFP8v1QkCYf6eCsi2x/N78NiZiSoVyG1t/95h74aCtpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIHoHGkq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760564526; x=1792100526;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qfxkjojbnOlKxoE9ZeK4jTDYrWsSjnjfW0LsKes6m0Q=;
  b=fIHoHGkqSfM/ZgiwgyvmhQop0GstHSpMdXOS7q79g+VpkwRE76tUEOgu
   0098BsSozeOvFIAiz77Zg6wvinpJlowWMrG1l2GSChH/xIrJXgxheVtsn
   mRWAnEqU/O02QWgQ6Q2X4iEjOl+P+TF8V/dKwG3qFlMpURjn7IyesqpqR
   0s8GW1bzkj8Otr69cVfanBv7zH/Rq1BIUBtIQU0SpUGEZfLqWYL9ZtZMw
   X6r3qh1eOlBdvOBQvSNLmF983biF8EFGpY5VRkxYhieT8HQ3rruHrP4Et
   yQbQlJIhG//lPIrd4W6GrKRupnUu2CvrmrmLKxCSudxdKZ7hO/Sa19uiV
   Q==;
X-CSE-ConnectionGUID: daR/CbOwSzu8A3p8MV8R9g==
X-CSE-MsgGUID: pXpqIvY/SM+AVyuiudaoZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62680673"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62680673"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 14:42:06 -0700
X-CSE-ConnectionGUID: SoTxdG7CT1OMlEGVBjtzlQ==
X-CSE-MsgGUID: 6v6Ly5oKRwOMTLcFfFauDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="183071417"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.221]) ([10.125.111.221])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 14:42:05 -0700
Message-ID: <aa942655-d740-4052-8ddc-13540b06ef14@intel.com>
Date: Wed, 15 Oct 2025 14:42:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
 <c42081c1-09e6-45be-8f9e-e4eea0eb1296@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <c42081c1-09e6-45be-8f9e-e4eea0eb1296@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/25 1:56 PM, Cheatham, Benjamin wrote:
> On 10/6/2025 5:01 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Support an action by the type2 driver to be linked to the created region
>> for unwinding the resources allocated properly.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
> 
> Fix for this one should be split between 13/22 and this patch, but the majority of it is in this one. The idea is
> if we don't find a free decoder we check for pre-programmed decoders and use that instead. Unfortunately, this
> invalidates some of the assumptions made by __construct_new_region().

Wouldn't you look for a pre-programmed decoder first and construct the auto region before you try to manually create one? Also for a type 2 device, would the driver know what it wants and what the region configuration should look like? Would it be a single region either it's auto or manual, or would there be a configuration of multiple regions possible? To me a type 2 region is more intentional where the driver would know exactly what it needs and thus trying to get that from the cxl core. 

DJ


> 
> __construct_new_region() assumes that 1) the underlying HPA is unallocated and 2) the HDM decoders aren't programmed. Neither
> of those are true for a decoder that's programmed by BIOS. The HPA is allocated as part of endpoint_port_probe()
> (see devm_cxl_enumerate_decoders() in cxl/core/hdm.c specifically) and the HDM decoders are enabled and committed by BIOS before
> we ever see them. So the idea here is to split the second half of __construct_new_region() into the 2 cases: un-programmed decoders
> (__setup_new_region()) and pre-programmed decoders (__setup_new_auto_region()). The main differences between the two is we don't
> allocate the HPA region or commit the HDM decoders and just insert the region resource below the CXL window instead in the auto case.
> 
> I'm not sure if I've done everything correctly, but I don't see any errors and get the following iomem tree:
> 	1050000000-144fffffff : CXL Window 0
>   	  1050000000-144fffffff : region0
>     	    1050000000-144fffffff : Soft Reserved
> 
> ---
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 4af5de5e0a44..a5fa8dd0e63f 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -137,6 +137,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>                         struct cxl_endpoint_dvsec_info *info);
>  int cxl_port_get_possible_dports(struct cxl_port *port);
> 
> +bool is_auto_decoder(struct cxl_endpoint_decoder *cxled);
> +
>  #ifdef CONFIG_CXL_FEATURES
>  struct cxl_feat_entry *
>  cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1f7aa79c1541..8f6236a88c0b 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -712,16 +712,33 @@ static int find_free_decoder(struct device *dev, const void *data)
>         return 1;
>  }
> 
> +bool is_auto_decoder(struct cxl_endpoint_decoder *cxled)
> +{
> +       return cxled->state == CXL_DECODER_STATE_AUTO && cxled->pos < 0 &&
> +              (cxled->cxld.flags & CXL_DECODER_F_ENABLE);
> +}
> +
> +static int find_auto_decoder(struct device *dev, const void *data)
> +{
> +       if (!is_endpoint_decoder(dev))
> +               return 0;
> +
> +       return is_auto_decoder(to_cxl_endpoint_decoder(dev));
> +}
> +
>  static struct cxl_endpoint_decoder *
>  cxl_find_free_decoder(struct cxl_memdev *cxlmd)
>  {
>         struct cxl_port *endpoint = cxlmd->endpoint;
>         struct device *dev;
> 
> -       scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> -               dev = device_find_child(&endpoint->dev, NULL,
> -                                       find_free_decoder);
> -       }
> +       guard(rwsem_read)(&cxl_rwsem.dpa);
> +       dev = device_find_child(&endpoint->dev, NULL,
> +                               find_free_decoder);
> +       if (dev)
> +               return to_cxl_endpoint_decoder(dev);
> +
> +       dev = device_find_child(&endpoint->dev, NULL, find_auto_decoder);
>         if (dev)
>                 return to_cxl_endpoint_decoder(dev);
> 
> @@ -761,6 +778,9 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>         if (!cxled)
>                 return ERR_PTR(-ENODEV);
> 
> +       if (is_auto_decoder(cxled))
> +               return_ptr(cxled);
> +
>         rc = cxl_dpa_set_part(cxled, mode);
>         if (rc)
>                 return ERR_PTR(rc);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2d60131edff3..004e01ad0e5f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3699,48 +3699,74 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>  }
> 
>  static struct cxl_region *
> -__construct_new_region(struct cxl_root_decoder *cxlrd,
> -                      struct cxl_endpoint_decoder **cxled, int ways)
> +__setup_new_auto_region(struct cxl_region *cxlr, struct cxl_root_decoder *cxlrd,
> +                       struct cxl_endpoint_decoder **cxled, int ways)
>  {
> -       struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
> -       struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -       struct cxl_region_params *p;
> +       struct range *hpa = &cxled[0]->cxld.hpa_range;
> +       struct cxl_region_params *p = &cxlr->params;
>         resource_size_t size = 0;
> -       struct cxl_region *cxlr;
> -       int rc, i;
> +       struct resource *res;
> +       int rc = -EINVAL, i = 0;
> 
> -       cxlr = construct_region_begin(cxlrd, cxled[0]);
> -       if (IS_ERR(cxlr))
> -               return cxlr;
> +       scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +       {
> +               for (i = 0; i < ways; i++) {
> +                       if (!cxled[i]->dpa_res)
> +                               goto err;
> 
> -       guard(rwsem_write)(&cxl_rwsem.region);
> +                       if (!is_auto_decoder(cxled[i]))
> +                               goto err;
> 
> -       /*
> -        * Sanity check. This should not happen with an accel driver handling
> -        * the region creation.
> -        */
> -       p = &cxlr->params;
> -       if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -               dev_err(cxlmd->dev.parent,
> -                       "%s:%s: %s  unexpected region state\n",
> -                       dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
> -                       __func__);
> -               rc = -EBUSY;
> -               goto err;
> +                       size += resource_size(cxled[i]->dpa_res);
> +               }
>         }
> 
> -       rc = set_interleave_ways(cxlr, ways);
> -       if (rc)
> +       set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
> +
> +       p->res = kmalloc(sizeof(*res), GFP_KERNEL);
> +       if (!p->res) {
> +               rc = -ENOMEM;
>                 goto err;
> +       }
> 
> -       rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +       *p->res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> +                                      dev_name(&cxlr->dev));
> +
> +       rc = insert_resource(cxlrd->res, p->res);
>         if (rc)
> -               goto err;
> +               dev_warn(&cxlr->dev, "Could not insert resource\n");
> +
> +       p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
> +       scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +       {
> +               for (i = 0; i < ways; i++) {
> +                       rc = cxl_region_attach(cxlr, cxled[i], -1);
> +                       if (rc)
> +                               goto err;
> +               }
> +       }
> +
> +       return cxlr;
> +
> +err:
> +       drop_region(cxlr);
> +       return ERR_PTR(rc);
> +}
> +
> +static struct cxl_region *
> +__setup_new_region(struct cxl_region *cxlr, struct cxl_root_decoder *cxlrd,
> +                  struct cxl_endpoint_decoder **cxled, int ways)
> +{
> +       struct cxl_region_params *p = &cxlr->params;
> +       resource_size_t size = 0;
> +       int rc = -EINVAL, i = 0;
> 
> -       scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +       scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +       {
>                 for (i = 0; i < ways; i++) {
>                         if (!cxled[i]->dpa_res)
>                                 break;
> +
>                         size += resource_size(cxled[i]->dpa_res);
>                 }
>         }
> @@ -3752,7 +3778,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>         if (rc)
>                 goto err;
> 
> -       scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +       scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +       {
>                 for (i = 0; i < ways; i++) {
>                         rc = cxl_region_attach(cxlr, cxled[i], 0);
>                         if (rc)
> @@ -3760,16 +3787,61 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>                 }
>         }
> 
> +       rc = cxl_region_decode_commit(cxlr);
>         if (rc)
>                 goto err;
> 
> -       rc = cxl_region_decode_commit(cxlr);
> +       p->state = CXL_CONFIG_COMMIT;
> +       return cxlr;
> +
> +err:
> +       drop_region(cxlr);
> +       return ERR_PTR(rc);
> +}
> +
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +                      struct cxl_endpoint_decoder **cxled, int ways)
> +{
> +       struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
> +       struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +       struct cxl_region_params *p;
> +       struct cxl_region *cxlr;
> +       int rc;
> +
> +       cxlr = construct_region_begin(cxlrd, cxled[0]);
> +       if (IS_ERR(cxlr))
> +               return cxlr;
> +
> +       guard(rwsem_write)(&cxl_rwsem.region);
> +
> +       /*
> +        * Sanity check. This should not happen with an accel driver handling
> +        * the region creation.
> +        */
> +       p = &cxlr->params;
> +       if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +               dev_err(cxlmd->dev.parent,
> +                       "%s:%s: %s  unexpected region state\n",
> +                       dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
> +                       __func__);
> +               rc = -EBUSY;
> +               goto err;
> +       }
> +
> +       rc = set_interleave_ways(cxlr, ways);
>         if (rc)
>                 goto err;
> 
> -       p->state = CXL_CONFIG_COMMIT;
> +       rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +       if (rc)
> +               goto err;
> +
> +       if (is_auto_decoder(cxled[0]))
> +               return __setup_new_auto_region(cxlr, cxlrd, cxled, ways);
> +       else
> +               return __setup_new_region(cxlr, cxlrd, cxled, ways);
> 
> -       return cxlr;
>  err:
>         drop_region(cxlr);
>         return ERR_PTR(rc);


