Return-Path: <netdev+bounces-127912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9823D977038
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF362844A7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65849149C50;
	Thu, 12 Sep 2024 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyKORvDQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6713A40F;
	Thu, 12 Sep 2024 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165169; cv=none; b=RnM6vCk+atFmPtKeqLlGQL34lj0UbOD/gr9KsbNEvCf8XLjIjkq59eo7IogPqOF76YQk+J5qq5I2r8ZrLO4zilR+GrlbqLq1ykUZ499MQyVbC8EhzFqW7fmqkYJWOWOaVLHsAly6UYY8XmWywQ0j4SxUvQk7ot9XrDx4ukM35dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165169; c=relaxed/simple;
	bh=HpHolYa6A2/YXxNfS7x9hzMkFm/efMnzar7kgms8g4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiaF1dziCKNoYrwB/NSXRXKzIrZD3QTwKMbTo15RaRnk0En3ZcVexHcbsccppUex/S0t/ZKCIPhVnUeOm8K51UoBcNH4NU5W2A2nxF1nr6mieA4IUj5Bmi3n7e5hxckVo1ewDazG3K0GfJ9XkJyf4/Ib805zm6hvPGvuggFnJBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyKORvDQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726165168; x=1757701168;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HpHolYa6A2/YXxNfS7x9hzMkFm/efMnzar7kgms8g4g=;
  b=OyKORvDQx2bkBZ3QesCzgthFyUo5OHOi5amYrRBSoWfP8RYVxDExNLlq
   zDyZtY+4KXvV/l7+yQHiWaOvcWYdKsiNsYVisZFYv1O4DaEziMuDPwKv2
   hsGb1NzIFpB0bPlXrirHzhTbxUgl0CPVmaerHP/NcgQaHdWNBQIXWG0EI
   /kePykQ+Lw68hHSih4XH6IkLNaAG26ilxIFOvB8w/eemhQ9qufGZKdP4S
   zsoyUeCUsjxrhhR9c0UL1uMeZitoJWwZBRiSR4XjStOq1ofpjMPvxvUMp
   RfyM85iFpxMTp8dog+QDZz/Svyuz4m4vFP0x8NRahJ3gJFznxe9sUUXtM
   Q==;
X-CSE-ConnectionGUID: yF8kvIE3RaewwlrL99OaCQ==
X-CSE-MsgGUID: C2bORb7KT0SqL7RDSZzshA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24913793"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24913793"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:19:28 -0700
X-CSE-ConnectionGUID: swMaWhScQkOriQVe+KE2Yw==
X-CSE-MsgGUID: 8P26sSKFQYuSQc/XvaZ6sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67422250"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO [10.125.108.93]) ([10.125.108.93])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:19:26 -0700
Message-ID: <740c2831-4131-4471-b0ae-23eb816e0600@intel.com>
Date: Thu, 12 Sep 2024 11:19:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/20] cxl: support type2 memdev creation
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-10-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240907081836.5801-10-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add memdev creation from sfc driver.
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
> managed by a specific vendor driver and does not need same sysfs files
> since not userspace intervention is expected. This patch checks for the
> right device type in those functions using cxl_memdev_state.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/cdat.c            |  3 +++
>  drivers/cxl/core/memdev.c          |  9 +++++++++
>  drivers/cxl/mem.c                  | 17 +++++++++++------
>  drivers/net/ethernet/sfc/efx_cxl.c |  7 +++++++
>  include/linux/cxl/cxl.h            |  2 ++
>  5 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index bb83867d9fec..0d4679c137d4 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -558,6 +558,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  	};
>  	struct cxl_dpa_perf *perf;
>  
> +	if (!mds)
> +		return;
> +
>  	switch (cxlr->mode) {
>  	case CXL_DECODER_RAM:
>  		perf = &mds->ram_perf;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 836faf09b328..5f8418620b70 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -468,6 +468,9 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	if (!mds)
> +		return 0;

I think instead of altering the sysfs visible attributes, what you really want is to not register the unwanted group attributes. Or basically only register the cxl_memdev_attribute_group and not the other ones. Otherwise it gets really messy. And whomever adds future attributes need to also remember the special case. I think you can refer to core/port.c and look at the different decoder types as inspiration for creating different memdev types where it has cxl_decoder_base_attribute_group and then tack on specific attribute groups.

DJ 

> +
>  	if (a == &dev_attr_ram_qos_class.attr)
>  		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
>  			return 0;
> @@ -487,6 +490,9 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	if (!mds)
> +		return 0;
> +
>  	if (a == &dev_attr_pmem_qos_class.attr)
>  		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
>  			return 0;
> @@ -507,6 +513,9 @@ static umode_t cxl_memdev_security_visible(struct kobject *kobj,
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	if (!mds)
> +		return 0;
> +
>  	if (a == &dev_attr_security_sanitize.attr &&
>  	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
>  		return 0;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 7de232eaeb17..5c7ad230bccb 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -131,12 +131,14 @@ static int cxl_mem_probe(struct device *dev)
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>  
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
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
> @@ -222,6 +224,9 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	if (!mds)
> +		return 0;
> +
>  	if (a == &dev_attr_trigger_poison_list.attr)
>  		if (!test_bit(CXL_POISON_ENABLED_LIST,
>  			      mds->poison.enabled_cmds))
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 14fab41fe10a..899bc823a212 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -83,6 +83,13 @@ int efx_cxl_init(struct efx_nic *efx)
>  	 */
>  	cxl_set_media_ready(cxl->cxlds);
>  
> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed");
> +		rc = PTR_ERR(cxl->cxlmd);
> +		goto err;
> +	}
> +
>  	return 0;
>  err:
>  	kfree(cxl->cxlds);
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index 08723b2d75bc..fc0859f841dc 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -55,4 +55,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  void cxl_set_media_ready(struct cxl_dev_state *cxlds);
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds);
>  #endif

