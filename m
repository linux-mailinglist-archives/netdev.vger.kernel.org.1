Return-Path: <netdev+bounces-112136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C553937116
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 01:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798C6B21A13
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 23:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EA9146A61;
	Thu, 18 Jul 2024 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXAqyHjV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1FB80C07;
	Thu, 18 Jul 2024 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721345284; cv=none; b=iuF/ufhuWoSVEJcBDrGohz40UWr6noWQNA9C6ZGdSmXkzvNkojLcgGtSBivpkKn6zf1ACJkOKFY4k/roGmqNx+v7VpZRcDuMdiJxk+eD4aRCQgzdF9uTbrztN+5DzOEczu0/uFxzYksH5ycJZev7GBJRTg2Svm1KsFibNao2gyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721345284; c=relaxed/simple;
	bh=QD1QghOQFNrENYCU65uuFoB5yjsiBE3UL5/XQnpp6rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vqp30NdQWDBsR209q0xPzPb6vfwPfZjixOCTVqFcUy/gcL2MNyvon0r4I5i1+SR+tUBIXR+87Fixx0q0vdx2dCK37C6xTENsDr4G1X0UxNy2yicgI28gAPVQ9VHJy0KBBOuiJeSHhbXKYvXvtnTtO01Yipzl8NNPz/EN+N1ahos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXAqyHjV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721345282; x=1752881282;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QD1QghOQFNrENYCU65uuFoB5yjsiBE3UL5/XQnpp6rU=;
  b=aXAqyHjVBUJR1PSwyNbf4XGQgoO79wDIrIYsD+wGEVoJP6eLWnrNmrcu
   ngZrnPXaRiPuMBeF1RYiWEYFbBc8vHPKe+5WZX8G9pq6/PRmRpXziKxnJ
   /kYQuEJjUzomUZv4XLWqcf0o6QKR9pX2wbTZ4/bFq4U+f2/V3RGcjoAJI
   11ClTkZA/hC3uWk+cW5QtyBdzd0x2L1Lh/BBJlaxzwbdw+zAWm2hqQbC7
   GPDA853JsS8ELIaIR7XPaOJoWHbrllAbrwloyEOgwdUscNezPr7OAVpki
   eqem0ePKtegXyeXL/NcjC0Meg9x8FxmAoWKbD+WBQz8GHd483jQrrwQvK
   w==;
X-CSE-ConnectionGUID: GHpCuspEQ0mEk8W/3qGhbA==
X-CSE-MsgGUID: DKmuK59dRJidK7j0KPW5gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="30098696"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="30098696"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 16:28:01 -0700
X-CSE-ConnectionGUID: 2r360qDhToK1XvF2+XOO/Q==
X-CSE-MsgGUID: U1Yp8Jb/RDenoJcqYspsSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="51532661"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.184]) ([10.125.108.184])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 16:28:00 -0700
Message-ID: <33c34f2d-55cb-4b50-888d-1293ea2fa67d@intel.com>
Date: Thu, 18 Jul 2024 16:27:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] cxl: add function for type2 cxl regs setup
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-3-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240715172835.24757-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/24 10:28 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising the opaque
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/pci.c                  | 28 ++++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.c |  3 +++
>  include/linux/cxl_accel_mem.h      |  1 +
>  3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e53646e9f2fb..b34d6259faf4 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -11,6 +11,7 @@
>  #include <linux/pci.h>
>  #include <linux/aer.h>
>  #include <linux/io.h>
> +#include <linux/cxl_accel_mem.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
>  #include "cxl.h"
> @@ -521,6 +522,33 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	return cxl_setup_regs(map);
>  }
>  
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)

Function should go into cxl/core/pci.c

> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxlds->reg_map);
> +	if (rc)
> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> +
> +	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc)
> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");

dev_warn()? also maybe add the errno in the error emissioni. 

> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
> +
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 4554dd7cca76..10c4fb915278 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -47,6 +47,9 @@ void efx_cxl_init(struct efx_nic *efx)
>  
>  	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>  	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
> +
> +	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
> +		pci_info(pci_dev, "CXL accel setup regs failed");

pci_warn()? although seems unnecesary since error emitted in cxl_pci_accel_setup_regs(). 

>  }
>  
>  
> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> index daf46d41f59c..ca7af4a9cefc 100644
> --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -19,4 +19,5 @@ void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
>  void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
>  void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  			    enum accel_resource);
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  #endif

