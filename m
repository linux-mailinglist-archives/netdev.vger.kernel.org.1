Return-Path: <netdev+bounces-146695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833AA9D50A5
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 17:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9511F22BC1
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 16:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2447E15956C;
	Thu, 21 Nov 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4SGRbwM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E03156883;
	Thu, 21 Nov 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206270; cv=none; b=Ch++gKEKCe7k8Ej4f1d5i1Yg8LX1MGmQCwL9U5cTEFji7Pf4PhG5S4E8yNDtJjVOef1n699IV9FmfFWkQEvibNnfimZwPGohqdSiMd8I9vX+gpoJ0fLGRixDwnNTR4PK32n1LHcJGxVLK7QN6m30RLhTWxVYqWAvcRWj9pgvYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206270; c=relaxed/simple;
	bh=kE4RuL/efPiU+nb/p4CSBb19fq3U7L+H/7UaM0ZtbSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHUMU2aUynQWdl+Iu8nJOK3Id2LU2Cp+1WMqMGDVZtAT08G6EthG28H46nRCdEGjsL0L6p+9C3KvdPyK8DIDkViR6NPpv31SnjVXIYmx3N4ppjaKAWp67V0PyDGFOA3+5gMT9SpLH7H46FvUGrU7tuwYZWKwmmUQWn7oQqqbjWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4SGRbwM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732206269; x=1763742269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kE4RuL/efPiU+nb/p4CSBb19fq3U7L+H/7UaM0ZtbSE=;
  b=E4SGRbwMWvCsUOvUPU8jrSHzJcZPugUtQgP4+ISheEVSkLvI9C+2vDbk
   mdFF0dddGDxpfsNEs4h1mOp0ior2Bt7Riil7yKjRw7Nazk10YHltiY8AO
   g4MCP1iU9IhG3n2NYGF/DTD5C5BQ1usgk9+uz8M/tiM05i+EjdAGfAiG0
   s7/XZR9ULnWBTxW/PL0Bbbj/1MCzJsLHrQWYQnDLe7LLrqKF2/u8GL/D+
   fRryKhFKQFVy5LaAPu517rXVcel6m4B4sqT/XsK7Qs22d4NoCMmcvPr2s
   IY0bQAIKkgl5xcvFtASUJvJDTO8AkqHdsFTgNEyMyZj3lnAkLGsbrt4qV
   g==;
X-CSE-ConnectionGUID: FzboST6DRaGwsv6cj37Cww==
X-CSE-MsgGUID: JIXh8CzURbWUiloI/DCoPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="54838462"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="54838462"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 08:24:29 -0800
X-CSE-ConnectionGUID: KgK1oaRjQF2L6EumLuGWog==
X-CSE-MsgGUID: NJtRwu8kSmOJ/2jARe6ggg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="95098528"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.245]) ([10.125.109.245])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 08:24:27 -0800
Message-ID: <96bb4b03-c2ba-429a-88d4-7aaf2e49b7d1@intel.com>
Date: Thu, 21 Nov 2024 09:24:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/27] cxl/region: factor out interleave granularity
 setup
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-22-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241118164434.7551-22-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for kernel driven region creation, factor out a common
> helper from the user-sysfs region setup for interleave granularity.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 04f82adb763f..6652887ea396 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -540,21 +540,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
>  	return rc;
>  }
>  
> -static ssize_t interleave_granularity_store(struct device *dev,
> -					    struct device_attribute *attr,
> -					    const char *buf, size_t len)
> +static int set_interleave_granularity(struct cxl_region *cxlr, int val)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	int rc, val;
> +	int rc;
>  	u16 ig;
>  
> -	rc = kstrtoint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>  	rc = granularity_to_eig(val, &ig);
>  	if (rc)
>  		return rc;
> @@ -570,16 +563,30 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
>  		return -EINVAL;
>  
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
> +
> +	p->interleave_granularity = val;
> +	return 0;
> +}
> +
> +static ssize_t interleave_granularity_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	int rc, val;
> +
> +	rc = kstrtoint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
>  	rc = down_write_killable(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
>  
> -	p->interleave_granularity = val;
> -out:
> +	rc = set_interleave_granularity(cxlr, val);
>  	up_write(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;


