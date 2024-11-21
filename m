Return-Path: <netdev+bounces-146694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509859D50A4
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 17:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C4D281FC0
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93DE70817;
	Thu, 21 Nov 2024 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWGviYrw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FD92309B4;
	Thu, 21 Nov 2024 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206228; cv=none; b=Z0uAFz2F3V1Vvj/dn6sbd4b/IIDou7sPuDj/wvCg4YhH6r4ZSD86f7tZCj+f0rxMcaIxECWVCTozitktTlrYJy8OePkHMvgbktUN6qRxSlxrTrMoHW4loMzqoJQqLCKFm4CpOnuNannIo7Rfn+Qlcb6JPWLF7BgptyPbFgIjHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206228; c=relaxed/simple;
	bh=ccEWUYG9aCTSRzhBVd13XXHUbi+cZB6JA/l9YW2H8hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8RzQECA/2w1HT/qWlV3jv5DP/QeBp7P6j4U44/Fq+XPsmBKIeKYU39OvrruF37BU1n2GNeXE4nci7kVSDLGIYgvhlz/Sh7OvYw3YaYDzrP+5LC+D1bvcM9sBKk5yJlC192vMqXQ+HnAQLzjPZbTGOMeD2nOL8zAP9I8vE7ZZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWGviYrw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732206227; x=1763742227;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ccEWUYG9aCTSRzhBVd13XXHUbi+cZB6JA/l9YW2H8hQ=;
  b=bWGviYrwnnKyxvwfmMoG/wrHgGSFRhvdoYdX6mU7tvTTZXR8YNZHTDnZ
   rp3Us7lWWQ7TR1VsGkG4oMWnBGTWWdpAGP7fDAi50BF4s/j4hpD+aN3ab
   o+U1+d/annkaZx5ryyQJ+U741vaHSmT9OUTwpeC7XnfuJoltnAcHNREUb
   Dds6zyJGFOZcCORAjMQ4ju4VHJBcL2L3knZyXobySf4BDgxLXmBhHJRWW
   AEccI8qx57RM7EJFrY1AQWI16q9G5KRNelsLbfknHli3ONgsw3jUt9bYp
   b5bqBSDRKFsotLF0uoOjY5QZ0KvDNPSJb51OmKQeDw/m7Qx2/cYYFhRET
   w==;
X-CSE-ConnectionGUID: ug7Hw1bmRLmbRjL9nallRA==
X-CSE-MsgGUID: zgBGm3+oRi6+IWuDXxCmGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="54838205"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="54838205"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 08:23:45 -0800
X-CSE-ConnectionGUID: VTtSiqNJSc2mU1lw1k7W0w==
X-CSE-MsgGUID: sS1M8mFOQoKxFGTw+X4Mbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="95098276"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.245]) ([10.125.109.245])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 08:23:44 -0800
Message-ID: <4a54422b-714a-4674-8ca2-4cb76ed22c71@intel.com>
Date: Thu, 21 Nov 2024 09:23:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/27] cxl/region: factor out interleave ways setup
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-21-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241118164434.7551-21-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for kernel driven region creation, factor out a common
> helper from the user-sysfs region setup for interleave ways.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8e2dbd15cfc0..04f82adb763f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -464,22 +464,14 @@ static ssize_t interleave_ways_show(struct device *dev,
>  
>  static const struct attribute_group *get_cxl_region_target_group(void);
>  
> -static ssize_t interleave_ways_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t len)
> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	unsigned int val, save;
> -	int rc;
> +	int save, rc;
>  	u8 iw;
>  
> -	rc = kstrtouint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>  	rc = ways_to_eiw(val, &iw);
>  	if (rc)
>  		return rc;
> @@ -494,20 +486,36 @@ static ssize_t interleave_ways_store(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	rc = down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
>  
>  	save = p->interleave_ways;
>  	p->interleave_ways = val;
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>  	if (rc)
>  		p->interleave_ways = save;
> -out:
> +
> +	return rc;
> +}
> +
> +static ssize_t interleave_ways_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	rc = down_write_killable(&cxl_region_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	rc = set_interleave_ways(cxlr, val);
>  	up_write(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;


