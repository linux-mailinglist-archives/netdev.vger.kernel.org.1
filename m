Return-Path: <netdev+bounces-146331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC939D2E68
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E51EB37E17
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D5A1D1F73;
	Tue, 19 Nov 2024 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlL9yv8V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508A1D3195;
	Tue, 19 Nov 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040688; cv=none; b=ctUh1c/ZW1RKopBBqSYDdkaxVpIH5IenS/ixMdq6pPl05hRzOiA7zdbRHZqXtN5XHipDXZqfsk5MZ2nBqxap6tnTLPMvyNICF33rexPBMhvRBHz457lA0PUoM0X5+TQhFcCSFxYyc+n3T5LmGI/I9PM7bBa26yCfj4/19hkjHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040688; c=relaxed/simple;
	bh=4wU3fPyGfq6oK3/tU8QEiILOw7mZnTD6hNSiJ50ffE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K15zf4oj0Qd1XsAtjWdxKckuIStg3/LX64Mt90SZc4/2I/ufIUXXPh1CBBjmS0zdcGIavvRxr1XHZuSmPOccOTyRIgU+13NFmeFicvQw1P/vCoorHqhFiRRra+3Nd2fdpvd2cHPA4cmM6zUXInUeoXZqMVNtIzaabeTwvlVG8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlL9yv8V; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732040687; x=1763576687;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4wU3fPyGfq6oK3/tU8QEiILOw7mZnTD6hNSiJ50ffE4=;
  b=jlL9yv8Vg2qiQTmlsFRHM56r2xdiyuJp6TtCvJXhgK2NRMurNYtcVVae
   pOccbRGDbt0YC3HrLWWoWlqgcZz8Ow+K7fFIoGIFHaiCka1DpybzpCNlV
   CoMs1mBxc0UArkUqvZbYdUA2oXBgPVrOB1hzmZtoDeRnN5en+wYkt6Lop
   nb8ryTnho7kmqn27sNZ6eUmXU9b40k7jtI1COcT88J8Shk89WgfB+wFdW
   UQxcux0sXWv5SPvlwZiD0u9ZNIfdO+WtWk564oHM8spyc7FtHHeL5vTnd
   kZY5HN5O9WfvRpkXYTzJnNONIZNYU23mVv/YVUhvm4XTFdrRBRsS4qjrG
   A==;
X-CSE-ConnectionGUID: z0KOrCadReyC5Rz3Oz+6pg==
X-CSE-MsgGUID: AA5IAw0kRMeKgIwhjXn+3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="31471519"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="31471519"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 10:24:46 -0800
X-CSE-ConnectionGUID: fMbPyOy6SDad189fK8GVPg==
X-CSE-MsgGUID: N8zWcVvtQEuIzg7lHm3gJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89767694"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.91]) ([10.125.109.91])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 10:24:45 -0800
Message-ID: <75e8c64e-5d0c-4ebf-843e-e5e4dd0aa5ec@intel.com>
Date: Tue, 19 Nov 2024 11:24:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/27] cxl: prepare memdev creation for type2
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-14-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241118164434.7551-14-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
> managed by a specific vendor driver and does not need same sysfs files
> since not userspace intervention is expected.
> 
> Create a new cxl_mem device type with no attributes for Type2.
> 
> Avoid debugfs files relying on existence of clx_memdev_state.
> 
> Make devm_cxl_add_memdev accesible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/cdat.c   |  3 +++
>  drivers/cxl/core/memdev.c | 15 +++++++++++++--
>  drivers/cxl/core/region.c |  3 ++-
>  drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>  include/cxl/cxl.h         |  2 ++
>  5 files changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index e9cd7939c407..192cff18ea25 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -577,6 +577,9 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	struct cxl_dpa_perf *perf;
>  
> +	if (!mds)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  		perf = &mds->ram_perf;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index d746c8a1021c..df31eea0c06b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -547,9 +547,17 @@ static const struct device_type cxl_memdev_type = {
>  	.groups = cxl_memdev_attribute_groups,
>  };
>  
> +static const struct device_type cxl_accel_memdev_type = {
> +	.name = "cxl_memdev",
> +	.release = cxl_memdev_release,
> +	.devnode = cxl_memdev_devnode,
> +};
> +
>  bool is_cxl_memdev(const struct device *dev)
>  {
> -	return dev->type == &cxl_memdev_type;
> +	return (dev->type == &cxl_memdev_type ||
> +		dev->type == &cxl_accel_memdev_type);
> +
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);

Does type2 device also exports a CDAT?

I'm also wondering if we should have distinctive helpers:
is_cxl_type3_memdev()
is_cxl_type2_memdev()

and is_cxl_memdev() is just calling those two helpers above. 

And if no CDAT is exported, we should change the is_cxl_memdev() to is_cxl_type3_memdev() in read_cdat_data(). 

DJ

>  
> @@ -660,7 +668,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev->parent = cxlds->dev;
>  	dev->bus = &cxl_bus_type;
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
> +		dev->type = &cxl_accel_memdev_type;
> +	else
> +		dev->type = &cxl_memdev_type;
>  	device_set_pm_not_required(dev);
>  	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index dff618c708dc..622e3bb2e04b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> -	cxl_region_perf_data_calculate(cxlr, cxled);
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
> +		cxl_region_perf_data_calculate(cxlr, cxled);
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		int i;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index a9fd5cd5a0d2..cb771bf196cd 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>  
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
> +	/*
> +	 * Avoid poison debugfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (mds) {
> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_inject_fops);
> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_clear_fops);
> +	}
>  
>  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>  	if (rc)
> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	/*
> +	 * Avoid poison sysfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (!mds)
> +		return 0;
> +
>  	if (a == &dev_attr_trigger_poison_list.attr)
>  		if (!test_bit(CXL_POISON_ENABLED_LIST,
>  			      mds->poison.enabled_cmds))
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 6033ce84b3d3..5608ed0f5f15 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -57,4 +57,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  void cxl_set_media_ready(struct cxl_dev_state *cxlds);
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds);
>  #endif


