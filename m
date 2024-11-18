Return-Path: <netdev+bounces-146020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6649D1B57
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 23:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2596281B03
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E021E882A;
	Mon, 18 Nov 2024 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNm577zh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6C1E7647;
	Mon, 18 Nov 2024 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970683; cv=none; b=QJoCk8anSPPPDuLqsETNGRyaqud+iG2csA1X/6R2uOQn92KGEuDiw0ghNu9yg3tT6hspVbTIaOOlKDES7wPTh1y7fL/5f6LaX7yUGhKNM9rRV1j8NLw4U4z0gfQu2FT/PnnzwXF4Y43TxLRcQ6nwM1GXMy4QG7kZmxpO5S9aWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970683; c=relaxed/simple;
	bh=yxa74zr5ad8zRl1Oz282PX29c7NfuH9wfVE3+PhnN2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9ceXEu3Qy+3cEhpAn5MqzfByozwvhIYUW7aEsJKF0b/vEmGQYtDvJ++WxcCS36aJ+sDdEw/2Eo4ylLMiC46j+V2EbQeyUSHsijG7P1Eo3wuJtXnh6JvJSg1qhIxboVLVqkOnZ1lLgCo73PV5ZdV0uF5AyMo05L1PTwcvLCxMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNm577zh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731970681; x=1763506681;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yxa74zr5ad8zRl1Oz282PX29c7NfuH9wfVE3+PhnN2s=;
  b=bNm577zhxXf62GDOBmF1Y6lTyK+FZiE0RRZobvZpn6uoRZ5bYyFt8lI9
   WSx2M/1e02tcXNABAGFvStNIrjH2qaU8iwQDujJT/02DxFTfHKJo6sdqL
   dqBjR5KFSV5aDdmTc90PmWeU0OK7WP9QsQaCn46/wrz23QaeVQodZwzS0
   NPLBj10jt9yrkr3guhlgD/6HVOGPUdpQCVyTn5ZWr/eoml5Hj28hbVXkL
   hofDg1wxFEm9dpoTlmaOScZBWIO8CBzEV8KFyRj8pODTSIeJElzj0oh4S
   tuVL3MH5YW1jOwoj8wRvrUO1K+be2zRw44MG1dHG8kedhb/gNWaS7XuVz
   A==;
X-CSE-ConnectionGUID: fxrBIsUWTGGtwmu88MuoWw==
X-CSE-MsgGUID: dheU9fGqRqWej2eyCaV6lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="57359973"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="57359973"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 14:58:01 -0800
X-CSE-ConnectionGUID: gz62ZcmbRPC7c6rbZibi2g==
X-CSE-MsgGUID: aDWvHNLYSbqiC0cnlCoHlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="88927528"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.108.254]) ([10.125.108.254])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 14:57:59 -0800
Message-ID: <7ff99dbf-d7ad-4af7-97fa-c10b579eb92f@intel.com>
Date: Mon, 18 Nov 2024 15:57:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/27] cxl: move pci generic code
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-6-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241118164434.7551-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.
> 
> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> exported and shared with CXL Type2 device initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h   |  3 ++
>  drivers/cxl/pci.c      | 58 ---------------------------------------
>  3 files changed, 65 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a1942b7be0bc..bfc5e96e3cb9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1034,6 +1034,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
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
> +		       struct cxl_register_map *map, unsigned long *caps)
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
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  {
>  	int speed, bw;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index eb59019fe5f3..985cca3c3350 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -113,4 +113,7 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +bool is_cxl_restricted(struct pci_dev *pdev);
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map, unsigned long *caps);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5de1473a79da..caa7e101e063 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -467,64 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
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
> -	struct cxl_dport *dport;
> -	resource_size_t component_reg_phys;
> -
> -	*map = (struct cxl_register_map) {
> -		.host = &pdev->dev,
> -		.resource = CXL_RESOURCE_NONE,
> -	};
> -
> -	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return -EPROBE_DEFER;
> -
> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
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
> -			      struct cxl_register_map *map,
> -			      unsigned long *caps)
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


