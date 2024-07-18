Return-Path: <netdev+bounces-112137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A95D937120
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 01:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8402E1C20C82
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 23:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6773F1DA3D;
	Thu, 18 Jul 2024 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3azep9B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB362AF18;
	Thu, 18 Jul 2024 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721345764; cv=none; b=kwXMJbG2WXlgE+Nka3lHu5uIxUMjwftdSLCXFkHRJoAtwyhJwNCakiIIb9IsjNLZNLxUZeUwrAc+TBMTmCmaP94LoHzKMEPTaoh8p5FnpraEU8p8CoEAUl359Wce5HZIbHHbc8GXOoB+NjzJAVIeXpIUC1zfE9IgawuowUwRcxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721345764; c=relaxed/simple;
	bh=ep5eWrhAXKMT3a1EI4DLi3Mu5MhwEqP3OAgzzQUi5xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDn1TeEURlJZn3Ce9+IhzJoO/9M0XlRKaZJR0urmObEhn7aJizGFyWjCy5dUOOErdg0ikBSqLFwXWyh5fOmyJf43lwvglvpaJzjz1eOp05zlauPJ2o1FsW0HN2Xdg7CcR0eoAfDMSzgKRlvn3fEwhkCXbM2k6MwAHS9HKljRiZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3azep9B; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721345762; x=1752881762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ep5eWrhAXKMT3a1EI4DLi3Mu5MhwEqP3OAgzzQUi5xo=;
  b=a3azep9BRUj2UMLjvO/9JwBqtl+s/QaHK45i1wQEFceLUfztPQAypG6X
   G3aH7mffTPwaQr5KP9dSfuuxguTzIoLNG9/tSEwv09wpB7Z6Y8hj0LCMB
   0yXCXDTMyKtrTFALgFAuiUla6/jTaTwDbuBjMnVcn1ZUagiEsJyPmeswt
   symHVH4UUl8XlXshBgr1ljf0AYsh8rle6Jnyv5Gfpn05pzCwW9Nqe6RF0
   x3CWeoGiX3BFSmzEK5nT2aNiHxxAhHSE/+6B9xmdG/ylVThhnusmifbno
   wmGOYSDyac4YdY80OLPGJwFFVpriSW0YBqfUuwYUItV+mErxEDQ/KvUmv
   g==;
X-CSE-ConnectionGUID: 1oSghVNnR8aLdFwz8ZOXQw==
X-CSE-MsgGUID: DtWISr8sQoe7H4JNnamjog==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="36380985"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="36380985"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 16:36:01 -0700
X-CSE-ConnectionGUID: 9QbGHwy+Q/GOIGQqvzaYcw==
X-CSE-MsgGUID: rIBhblh5QxWij0HjDc9PXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="55786036"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.184]) ([10.125.108.184])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 16:36:00 -0700
Message-ID: <abff9def-a878-47e9-b9c8-27cf3c008c29@intel.com>
Date: Thu, 18 Jul 2024 16:36:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] cxl: add function for type2 resource request
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-4-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240715172835.24757-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/24 10:28 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device requesting a resource
> passing the opaque struct to work with.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/memdev.c          | 13 +++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++-
>  include/linux/cxl_accel_mem.h      |  1 +
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 61b5d35b49e7..04c3a0f8bc2e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -744,6 +744,19 @@ void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
>  
> +int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram)
Maybe declare a common enum like cxl_resource_type instead of 'enum accel_resource' and use here instead of bool?

> +{
> +	int rc;
> +
> +	if (is_ram)
> +		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
> +	else
> +		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_request_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 10c4fb915278..9cefcaf3caca 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -48,8 +48,13 @@ void efx_cxl_init(struct efx_nic *efx)
>  	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>  	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
>  
> -	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
> +	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds)) {
>  		pci_info(pci_dev, "CXL accel setup regs failed");
> +		return;
> +	}
> +
> +	if (cxl_accel_request_resource(cxl->cxlds, true))
> +		pci_info(pci_dev, "CXL accel resource request failed");

pci_warn()? also emitting the errno would be nice. 

>  }
>  
>  
> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> index ca7af4a9cefc..c7b254edc096 100644
> --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -20,4 +20,5 @@ void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
>  void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  			    enum accel_resource);
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
> +int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram);
>  #endif

