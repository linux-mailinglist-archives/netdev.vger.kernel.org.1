Return-Path: <netdev+bounces-127607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A7975DCA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 01:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C758E1C21D99
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E93F18735F;
	Wed, 11 Sep 2024 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8r6VrwZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAC186E53;
	Wed, 11 Sep 2024 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726098904; cv=none; b=OkJNoX9A6vmRHboqlGTX6K5kUHjFUtUmeT9aHld1xAcIAAvPzZAMOU6mqiyxnOCueqZE3ywzXlPV0HG9jDBcTjExR8jMts+VLDsIqEzZ3ZwXoNMDVDJYACIjmpmtvQKffKoqZQnh5Ia3eZ5R//yZGUT+6qHzYQ13BgUjkXjisWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726098904; c=relaxed/simple;
	bh=ek8J3fG7+LMM6WtCVa2A7+/+si/gX9ltbqxIerTlvvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPspWQfrY0YM7tQO92jmpGQzKfxM+BBtje0ycvdOgyc2ZHXzGb43vu9bcE/OBdO894cvA/+0uQIXVrFHKPoxDgOJa2CkqmZT470KdQjGLCtBfrVZDgLA7qs+qN8cXwIJ5ytYao/tZf5owGJyomv4GVcpZm8M+t3DhODv+TTZBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8r6VrwZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726098903; x=1757634903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ek8J3fG7+LMM6WtCVa2A7+/+si/gX9ltbqxIerTlvvY=;
  b=R8r6VrwZ7uYaqdyYGpN9sM3FLFOJQBan8ArWoFUIqj5f0yS4rZvmI2RG
   euHDpnChbTlhsqCYmuAnw5BssF6nk3/bMAiEk3nvTqQadWlALx37LoBnH
   JpQhjDG0d/FxpwqaQeBHjSmDbIcy4OuMHzRyt3yE06FH736l497YKkQid
   lwfYBuT8fVAs6uv8r6B7vkGG3TWNOGfw+bJCagyoP+YU7YZVQJSgKhbRw
   lVfZdwsQm0B6JFqcncvj49qmPnTpCH4smbu2gyipW2LkvuFecLnf6Dnmo
   vC8hvw3yu339eWYT0Ch+ktzQOmf6pGiqdZtIXcKrtO2y7digLr6ivLSbI
   g==;
X-CSE-ConnectionGUID: tyAdBCXPSmaHooHmZZrU8Q==
X-CSE-MsgGUID: QIVhu/OGSoSs1jbEzLPW5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28666239"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="28666239"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 16:55:02 -0700
X-CSE-ConnectionGUID: MuWS+NwfRKerCRC7bdP+4A==
X-CSE-MsgGUID: szW6Z3q4Tk+CB2DYSFMZwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="98359031"
Received: from rchernet-mobl4.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 16:55:01 -0700
Message-ID: <56f1a2fb-aab1-4ecc-98b3-bdcf0f37ec3c@intel.com>
Date: Wed, 11 Sep 2024 16:55:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/20] cxl: move pci generic code
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-5-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240907081836.5801-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.
> 
> Move those functions required also for Type2 initialization to
> cxl/core/pci.c with a specific function using that moved code added in
> a following patch.

Please consider rephrasing as:

Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
exported and shared with CXL Type2 device initialization.

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c | 63 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h   |  3 ++
>  drivers/cxl/pci.c      | 60 ----------------------------------------
>  3 files changed, 66 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 57370d9beb32..bf57f081ef8f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1079,6 +1079,69 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
>  
> +/*
> + * Assume that any RCIEP that emits the CXL memory expander class code
> + * is an RCD
> + */
> +bool is_cxl_restricted(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, CXL);
> +
> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  struct cxl_register_map *map)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	resource_size_t component_reg_phys;
> +
> +	*map = (struct cxl_register_map) {
> +		.host = &pdev->dev,
> +		.resource = CXL_RESOURCE_NONE,
> +	};
> +
> +	port = cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return -EPROBE_DEFER;
> +
> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> +
> +	put_device(&port->dev);
> +
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	map->resource = component_reg_phys;
> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
> +	return 0;
> +}
> +
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map,
> +		       u32 *caps)
> +{
> +	int rc;
> +
> +	rc = cxl_find_regblock(pdev, type, map);
> +
> +	/*
> +	 * If the Register Locator DVSEC does not exist, check if it
> +	 * is an RCH and try to extract the Component Registers from
> +	 * an RCRB.
> +	 */
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> +		rc = cxl_rcrb_get_comp_regs(pdev, map);
> +
> +	if (rc)
> +		return rc;
> +
> +	return cxl_setup_regs(map, caps);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
> +
>  bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>  			u32 *current_caps)
>  {
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index eb59019fe5f3..786b811effba 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -113,4 +113,7 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +bool is_cxl_restricted(struct pci_dev *pdev);
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map, u32 *caps);

Does this need to go to a different header like include/cxl/pci.h or something for type2 consumption?

DJ

>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bec660357eec..2b85f87549c2 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -463,66 +463,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  	return 0;
>  }
>  
> -/*
> - * Assume that any RCIEP that emits the CXL memory expander class code
> - * is an RCD
> - */
> -static bool is_cxl_restricted(struct pci_dev *pdev)
> -{
> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> -}
> -
> -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> -				  struct cxl_register_map *map)
> -{
> -	struct cxl_port *port;
> -	struct cxl_dport *dport;
> -	resource_size_t component_reg_phys;
> -
> -	*map = (struct cxl_register_map) {
> -		.host = &pdev->dev,
> -		.resource = CXL_RESOURCE_NONE,
> -	};
> -
> -	port = cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return -EPROBE_DEFER;
> -
> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> -
> -	put_device(&port->dev);
> -
> -	if (component_reg_phys == CXL_RESOURCE_NONE)
> -		return -ENXIO;
> -
> -	map->resource = component_reg_phys;
> -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> -
> -	return 0;
> -}
> -
> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -			      struct cxl_register_map *map, u32 *caps)
> -{
> -	int rc;
> -
> -	rc = cxl_find_regblock(pdev, type, map);
> -
> -	/*
> -	 * If the Register Locator DVSEC does not exist, check if it
> -	 * is an RCH and try to extract the Component Registers from
> -	 * an RCRB.
> -	 */
> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> -		rc = cxl_rcrb_get_comp_regs(pdev, map);
> -
> -	if (rc)
> -		return rc;
> -
> -	return cxl_setup_regs(map, caps);
> -}
> -
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);

