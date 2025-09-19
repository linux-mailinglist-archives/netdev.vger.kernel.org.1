Return-Path: <netdev+bounces-224794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0470B8A799
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE6318992BC
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169EB31FEE8;
	Fri, 19 Sep 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdCkQEyF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE831E10B;
	Fri, 19 Sep 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297593; cv=none; b=bXYjiLze4ybwbkKS7z8kLNgP8Tqo8nbpRGb/NTU6smimBZpvK4TuooYPC9+vvuAu4S4lhddwgtcY9dGwum/cqT4xUJkrA0pR6HqgRB63IUkNKZVVrP8hJq7M+ArOaycvBQNNoBlS5GaK8Tv83pTY3iJJZVYrFm9gm062XHZ9O0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297593; c=relaxed/simple;
	bh=h8n9/HVSSgsWUsIjT5pxH9zRPTaAUBl7AAj0DbeFqp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHYTJwqxhgSlUDKDdsD9OrKU3bomwCr0Hj/pbkAo8TNnoYBFdwBaRx3I7esutCYoburt5QATvdbDTi5+/qPAzCdNX1jnugm4vvi/IYPSIlGLbTeeu7+R1R0y6bSYCNAO4O3vMWQFYMXMaW2UGSZ22HnuCkmXrIPwt7ipdIyvWNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdCkQEyF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758297592; x=1789833592;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h8n9/HVSSgsWUsIjT5pxH9zRPTaAUBl7AAj0DbeFqp4=;
  b=MdCkQEyF/gB6my/cQE/lZomse2tOpCLHTFfFRTPspDOAZktOMy8mnzxP
   8kHWRTCmM049iQwKDIVEuzqO2MV7HgrNhTGroxJmZkBJwgJ9wjQq8SyKp
   RMfesWYa5ds42MQ60CQNfxyFTvZjvhb2X50ilqszWBxwFN2nEZttdtftz
   DCntsqRYTImsW0ooEmUS7t2zC16PYInzZWq/cfNteUeKlQVtryev3hdj2
   OSFsC3xMxbysdIePKQh6/GFxI6N0VX2XmKaauTCu/NEip7O//bawedBO1
   5mQni9kRION2rUIBLQFLNOuD3P2lYAjbM7/NTz0PhGasnNtjCpGQnSyFS
   w==;
X-CSE-ConnectionGUID: STh8zqJ1QUaqkHzD5cpn9w==
X-CSE-MsgGUID: 4eHlsTZtSqCjVAHXPsn/hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="78088805"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="78088805"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 08:59:51 -0700
X-CSE-ConnectionGUID: LNeOun0HQsmhEhM/+nAt4Q==
X-CSE-MsgGUID: rmxgIehFTQOFyJ8TDXcrrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176688761"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.58]) ([10.125.108.58])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 08:59:49 -0700
Message-ID: <58917e54-5631-4e68-8e0e-bcff94c41516@intel.com>
Date: Fri, 19 Sep 2025 08:59:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 07/20] sfc: create type2 cxl memdev
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Martin Habets <habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-8-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250918091746.2034285-8-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl API for creating a cxl memory device using the type2
> cxl_dev_state struct.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

with a nit below.

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 651d26aa68dc..177c60b269d6 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -82,6 +82,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return dev_err_probe(&pci_dev->dev, -ENODEV,
>  				     "dpa capacity setup failed\n");
>  
> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds, NULL);
> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed");

As Jonathan mentioned. Maybe dev_err() to keep it consistent.

> +		return PTR_ERR(cxl->cxlmd);
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;


