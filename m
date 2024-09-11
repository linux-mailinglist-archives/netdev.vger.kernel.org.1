Return-Path: <netdev+bounces-127597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA3975D93
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 01:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC1D2857FC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D46618452A;
	Wed, 11 Sep 2024 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2tcQ9PT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D74F8BB;
	Wed, 11 Sep 2024 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095994; cv=none; b=M9c3YaJVhZms2zdzL+z9Vdt72H4eyRVh4VpC3637THiUUihZXJNjpRdAU4jK3tgFtp5tqG23yF0+4/jpb22/ZzsaRAKFMouXCxMUA4cclrerc9FIi2sLLD92lN+eXMr9TsfC2TF63f3vBD1rVyaKPog+cI/S/t8jihpk2jNwf9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095994; c=relaxed/simple;
	bh=R5Y5jaEDDEi7ivEOvAEu2kB22omNjmLe1sYuwpVdhwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQbe0QTajOH7rQBwn6P5S2mi3ELoYHqHUTbTSFEc5NjKZX0h+RSSvULfvL7EeOBtti7uJmZ171rlc3sSzOSoeFfrYTBstyckLCvoAE8xSay4cHsU7Ruhjn3pzSR8qDNzItYM0PNdjDfEKa3VOjZ4dfxpr2sWBuKNON832iXliJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2tcQ9PT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726095993; x=1757631993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R5Y5jaEDDEi7ivEOvAEu2kB22omNjmLe1sYuwpVdhwc=;
  b=R2tcQ9PTXFOGS/Aa16LTKTYdl9fHOQJnr0tqtuM3zce5+QXtr5BS3CUl
   IqBq9Af58DHjIG5v/xFhCDxD4HyELC8KX0hH+liq4DkYYEqdohxD/zZzR
   isjqFyYEevqmNx5+lyNBKnIGgcHfZFV1Ton6LAQRnWco4V0L03LV5q0BY
   uXQTtxskUxA4EmTiIy6lRTNLAmE/P3JF3yhCCIiCjYkLiqRqHKRHt8QkW
   9c544fLY/pymZQ/kE2ifRkNOlduEufkLdn4HkAsskg6GJ/zPxQ2VNfjvw
   tnIbf+6vvgdYGvqDbJcZlVIIBebOuu+HQhdyMppkX55x8IQOoxbQJLyed
   Q==;
X-CSE-ConnectionGUID: SpilGMlpRR+o4H9nmdXIVA==
X-CSE-MsgGUID: v9i6DBO+SPi+KBhAfIlODw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="25059259"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="25059259"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 16:06:32 -0700
X-CSE-ConnectionGUID: q1fyZxLwSiOnrtqCYoPxpg==
X-CSE-MsgGUID: Xg+2P2KBQ8aP4WUDRWCLtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="72295030"
Received: from rchernet-mobl4.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 16:06:31 -0700
Message-ID: <18ce82cd-e5cc-44c3-ad87-f735f5dc4263@intel.com>
Date: Wed, 11 Sep 2024 16:06:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/20] cxl/pci: add check for validating capabilities
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-4-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240907081836.5801-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> During CXL device initialization supported capabilities by the device
> are discovered. Type3 and Type2 devices have different mandatory
> capabilities and a Type2 expects a specific set including optional
> capabilities.
> 
> Add a function for checking expected capabilities against those found
> during initialization.
> 
> Rely on this function for validating capabilities instead of when CXL
> regs are probed.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c  | 17 +++++++++++++++++
>  drivers/cxl/core/regs.c |  9 ---------
>  drivers/cxl/pci.c       | 12 ++++++++++++
>  include/linux/cxl/cxl.h |  2 ++
>  4 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 3d6564dbda57..57370d9beb32 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/cxl/cxl.h>
>  #include <linux/cxl/pci.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
> @@ -1077,3 +1078,19 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  				     __cxl_endpoint_decoder_reset_detected);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
> +
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
> +			u32 *current_caps)
> +{
> +	if (current_caps)
> +		*current_caps = cxlds->capabilities;
> +
> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08x vs expected caps 0x%08x\n",
> +		cxlds->capabilities, expected_caps);
> +
> +	if ((cxlds->capabilities & expected_caps) != expected_caps)
> +		return false;
> +
> +	return true;


I think you can just do 
return (cxlds->capabilities & expected_caps) == expected_caps;

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 8b8abcadcb93..35f6dc97be6e 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -443,15 +443,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, u32 *caps)
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
>  		cxl_probe_device_regs(host, base, dev_map, caps);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> -		    !dev_map->memdev.valid) {
> -			dev_err(host, "registers not found: %s%s%s\n",
> -				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> -				!dev_map->memdev.valid ? "memdev " : "");
> -			return -ENXIO;
> -		}
> -
>  		dev_dbg(host, "Probing device registers...\n");
>  		break;
>  	default:
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 58f325019886..bec660357eec 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -796,6 +796,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct cxl_register_map map;
>  	struct cxl_memdev *cxlmd;
>  	int i, rc, pmu_count;
> +	u32 expected, found;
>  	bool irq_avail;
>  	u16 dvsec;
>  
> @@ -852,6 +853,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> +	/* These are the mandatory capabilities for a Type3 device */
> +	expected = BIT(CXL_DEV_CAP_HDM) | BIT(CXL_DEV_CAP_DEV_STATUS) |
> +		   BIT(CXL_DEV_CAP_MAILBOX_PRIMARY) | BIT(CXL_DEV_CAP_MEMDEV);

Maybe we can create a static mask for the expected mandatory type3 caps.

I also wonder if cxl_pci_check_caps() can key on pci device type or class type and know which expected mask to use and no need to pass in the expected mask. Or since the driver is being attached to a certain device type, it should know what it is already, maybe we can attach static driver data to it that can be retrieved as the expected_caps:

struct cxl_driver_data {
	u32 expected_caps;
};

static struct cxl_driver_data cxl_driver_data = {
	.expected_caps = BIT(CXL_DEV_CAP_HDM) | BIT(CXL_DEV_CAP_DEV_STATUS) |
			 BIT(CXL_DEV_CAP_MAILBOX_PRIMARY) | BIT(CXL_DEV_CAP_MEMDEV),
};

static const struct pci_device_id cxl_mem_pci_tbl[] = {
/* Maybe need a new PCI_DEVICE_CLASS_DATA() macro */
	{
		.class = (PCI_CLASS_MEMORY_CXL << 8  | CXL_MEMORY_PROGIF),
		.class_mask = ~0,
		.vendor = PCI_ANY_ID,
		.device = PCI_ANY_ID,
		.sub_vendor = PCI_ANY_ID,
		.subdevice = PCI_ANY_ID,
		.driver_data = (kernel_ulong_t)&cxl_driver_data,
	},
	{},
};
MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl); 

static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
{
	struct cxl_driver_data *data = (struct cxl_driver_data *)id->driver_data;

	rc = cxl_pci_check_caps(cxlds, data->expected_caps, &found);
....
}

> +
> +	if (!cxl_pci_check_caps(cxlds, expected, &found)) {
> +		dev_err(&pdev->dev,
> +			"Expected capabilities not matching with found capabilities: (%08x - %08x)\n",
> +			expected, found);
> +		return -ENXIO;
> +	}
> +
>  	rc = cxl_await_media_ready(cxlds);
>  	if (rc == 0)
>  		cxlds->media_ready = true;
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index 930b1b9c1d6a..4a57bf60403d 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -48,4 +48,6 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>  void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>  int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  		     enum cxl_resource);
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
> +			u32 *current_caps);
>  #endif

