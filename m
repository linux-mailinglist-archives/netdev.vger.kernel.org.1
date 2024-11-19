Return-Path: <netdev+bounces-146321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D654B9D2E0F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65173B3219D
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306901D0BAE;
	Tue, 19 Nov 2024 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Og3vZPlm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA61D173F;
	Tue, 19 Nov 2024 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039207; cv=none; b=ckRIe6shkQ/+dpM5yYRFzdnRpYw6inRL6yA4t7MkIb87nx6bROGvHbevqvPsJl8sQ5hMWUJGvvonm6h2YvhdBGALJHmFo/y6bW0bbd7vuEllP01CUCffoPgcTebrYkRq/KG8bpCfoiECgYelRhAw33PNl+7Pkzfq+hmuqaq8zc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039207; c=relaxed/simple;
	bh=D4d7AQwNFQp9VL6XjyVRYxJRnt21oXhp0Iy7mu4P2k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rk+s5SLL9MHQ9Ph56l19Jt/nxbdfOIGgsPEdrBMYaaC5X2NiUzxPdL53VO/oVXIb6xTjOW36T/JTLTfGawU6y1Uc0xqfNBqcVarj5K8rc4e/8qcdIe/iOkWrhjL8tyrlG1v/9kwmU1x0fEdkXi6MWqewRAG494aAEPyvBVBcBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Og3vZPlm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732039205; x=1763575205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D4d7AQwNFQp9VL6XjyVRYxJRnt21oXhp0Iy7mu4P2k8=;
  b=Og3vZPlmMiPYKB3nm2Sbz0Ger+evRZeCg0WmRm46OAoSYRGUk/eBB825
   l6xdykspF1zqT039zfRM9UzgmaeFQ6PlhSWcmLY/IQdVLQnPNVv+rs5oO
   flao7zItrPYcxekV+VhYWuqtqVfLDwQGSODbP8oxqodbQ5gJIP05DJjri
   8iEEo5NOG+4/cxVYgHgCnJNxizKB37Er5+dVfKU7tLhxwvfpxMP8Zpd+a
   2tVT8aQtQf280jlXw51mJ41Tktbg5bronAk4b4BqFOGfu9JtL6Mqfb7qf
   oE+yGMwegOQyX3M4EVvCFxDfQ0BtXipgJc9t5/BwozSyrxT17gE8/LyMR
   Q==;
X-CSE-ConnectionGUID: NynF2pBKToCL9lH2kZ/lGA==
X-CSE-MsgGUID: RShv3j21R7itH3PKymmQGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="49596414"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="49596414"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 10:00:04 -0800
X-CSE-ConnectionGUID: hbN+6rQmTfSYb9Sh5U60Vg==
X-CSE-MsgGUID: hnzgSaVtRvK4r4bu7x+wJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="90029785"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.91]) ([10.125.109.91])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 10:00:03 -0800
Message-ID: <bc2a587b-5f24-4834-a38c-8bfcb930bcda@intel.com>
Date: Tue, 19 Nov 2024 11:00:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/27] cxl: harden resource_contains checks to handle
 zero size resources
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-11-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241118164434.7551-11-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> For a resource defined with size zero, resource_contains returns
> always true.
> 
> Add resource size check before using it.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Should this be broken out and send ahead of the type2 series?

nit below

> ---
>  drivers/cxl/core/hdm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 223c273c0cd1..c58d6b8f9b58 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	cxled->dpa_res = res;
>  	cxled->skip = skipped;
>  
> -	if (resource_contains(&cxlds->pmem_res, res))
> +	if (resource_size(&cxlds->pmem_res) &&
> +	    resource_contains(&cxlds->pmem_res, res)) {
>  		cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(&cxlds->ram_res, res))
> +	} else if (resource_size(&cxlds->ram_res) &&
> +		   resource_contains(&cxlds->ram_res, res)) {
>  		cxled->mode = CXL_DECODER_RAM;
> +	}
>  	else {

} else {
>  		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
>  			 port->id, cxled->cxld.id, cxled->dpa_res);


