Return-Path: <netdev+bounces-146325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003B59D2DA4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDEA1F27024
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEA01D14F8;
	Tue, 19 Nov 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVQf7vCg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36EE1CF7B7;
	Tue, 19 Nov 2024 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039946; cv=none; b=H9NNtmadoUTOZHj0V+itBUWqkZmJ3WY4z0aDEEcvSioeNTpqeJZ6kIk/EUrANvMlMs6atgS5gZBrcDMTz66zJHDNiQ2s2nE+xC1Vp4/WGERb+58PvLjovfdv5Nn81rmkYWHe1sALhRWIRWksHP6wuO5IMjqrbQrq4AS8B7NAdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039946; c=relaxed/simple;
	bh=3P17EhN/74Tnlshw0LxHaMTjglShfKoNcLX2V7NLuxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbgpg3TIETikHuUjHe7otNOM5tC2vT1aocU4TMepwyTEHAPI7vKV4pVAvBNymbUteUQpPoscHrNuBRGF4t8GjTzB6U+At7Ug8GkDEF0HUEvCUPwWg+Qsmlz90p/vNEAVlj0yOmHer4F7XJJqDEPHlWJiICIzlPlo0n/Y8+EbUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVQf7vCg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732039945; x=1763575945;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3P17EhN/74Tnlshw0LxHaMTjglShfKoNcLX2V7NLuxk=;
  b=JVQf7vCgcIQOULfORSOYQr+3nmXkkIqdxJJMm5I4E692xuVYGLElYUxH
   bc6nHr4oqn2cc9ToGfb1UiGwoDS6zEUSA+hxMgAGkrBvMEe5xn9IfjPvC
   EtTrDPp+wjS+XdJx+EViLf+2MYNAYD1/J5fSLcrp/YIIOElVOlEIzXZHC
   RJ4W5XpWlw255rYkcEbZZUHrSsscm8r2kXUFOj9u+wGoGAiX7baVJCQsP
   dXBDo/g0fbUAKi8EfvVXLK6LnfO28FRjUS9O06nS8JlKvN5r00IlIWkpQ
   3US0ppI3TnzBlSE94hF/wf7GNX4Q8mBXywcY+x1LZzw/sLM3LxhkkLYrt
   g==;
X-CSE-ConnectionGUID: +GSFtpfPSciFJqo205hRFw==
X-CSE-MsgGUID: 4UZTuykqT6+OVYqBbbG3pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="49598383"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="49598383"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 10:12:24 -0800
X-CSE-ConnectionGUID: q7KaeuIwQF6CSn3x9fXp9A==
X-CSE-MsgGUID: BAF0TYVkRSWC1WZzxMloow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="90031795"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.91]) ([10.125.109.91])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 10:12:24 -0800
Message-ID: <67f92b02-efbe-4e7c-9eb6-fc91f5c582cf@intel.com>
Date: Tue, 19 Nov 2024 11:12:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/27] cxl: add function for setting media ready by a
 driver
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-12-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241118164434.7551-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A Type-2 driver can require to set the memory availability explicitly.
> 
> Add a function to the exported CXL API for accelerator drivers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 6 ++++++
>  include/cxl/cxl.h         | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 7450172c1864..d746c8a1021c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -795,6 +795,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
>  
> +void cxl_set_media_ready(struct cxl_dev_state *cxlds)
> +{
> +	cxlds->media_ready = true;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index e0bafd066b93..6033ce84b3d3 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -56,4 +56,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
> +void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>  #endif


